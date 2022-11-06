Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7F61E650
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 22:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiKFVKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 16:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiKFVKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:10:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73D611C02
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 13:10:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A26D5B80D11
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 21:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DF5C43143;
        Sun,  6 Nov 2022 21:09:58 +0000 (UTC)
Date:   Sun, 6 Nov 2022 16:09:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v5a 5/5] treewide: Convert del_timer*() to
 timer_shutdown*()
Message-ID: <20221106160956.2414d73f@rorschach.local.home>
In-Reply-To: <CAHk-=wiD3VWYqgO7JLqRCJvYHiO5RicGAERH1dWQ2pDqnXDy6g@mail.gmail.com>
References: <20221106054535.709068702@goodmis.org>
        <20221106054649.099333291@goodmis.org>
        <CAHk-=wiD3VWYqgO7JLqRCJvYHiO5RicGAERH1dWQ2pDqnXDy6g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Nov 2022 12:51:46 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Thanks, this looks reasonable.
> 
> On Sat, Nov 5, 2022 at 10:46 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > The coccinelle script:
> >
> > @@
> > expression E;
> > identifier ptr, timer, rfield, slab;  
> 
> I think Julia suggested making 'ptr' be an expression too, and I think

And I forgot to add Julia to the Cc :-/

> she's right. Probably 'slab' should be too - there's no reason to
> limit it to just one identifier.
> 
> >   ... when strict
> >       when != ptr->timer.function = E;  
> 
> I suspect any "ptr->timer" access anywhere between the
> del_timer_sync() and the freeing should disable things.
> 
> Although hopefully there aren't any other odd cases than that one
> "clear timer function by hand" one.

OK, I did the following with this new script:

$ cat timer.cocci
@@
expression E,ptr,slab;
identifier timer, rfield;
@@
(
-       del_timer(&ptr->timer);
+       timer_shutdown(&ptr->timer);
|
-       del_timer_sync(&ptr->timer);
+       timer_shutdown_sync(&ptr->timer);
)
  ... when strict
      when != ptr->timer.function = E;
(
        kfree_rcu(ptr, rfield);
|
        kmem_cache_free(slab, ptr);
|
        kfree(ptr);
)


$ git show | patch -p1 -R
$ spatch --dir timer.cocci . > /tmp/t.patch
$ patch -p1 < /tmp/t.patch

And it caught some more:

$ git diff
diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index 99cae174d558..eec0cc2144e0 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -2530,7 +2530,7 @@ idt77252_close(struct atm_vcc *vcc)
                vc->tx_vcc = NULL;
 
                if (vc->estimator) {
-                       del_timer(&vc->estimator->timer);
+                       timer_shutdown(&vc->estimator->timer);
                        kfree(vc->estimator);
                        vc->estimator = NULL;
                }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
index f9f18ff451ea..7ea2631b8069 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
@@ -394,7 +394,7 @@ void brcmf_btcoex_detach(struct brcmf_cfg80211_info *cfg)
 
        if (cfg->btcoex->timer_on) {
                cfg->btcoex->timer_on = false;
-               del_timer_sync(&cfg->btcoex->timer);
+               timer_shutdown_sync(&cfg->btcoex->timer);
        }
 
        cancel_work_sync(&cfg->btcoex->work);
diff --git a/net/netfilter/xt_IDLETIMER.c b/net/netfilter/xt_IDLETIMER.c
index 0f8bb0bf558f..8d36303f3935 100644
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -413,7 +413,7 @@ static void idletimer_tg_destroy(const struct xt_tgdtor_param *par)
                pr_debug("deleting timer %s\n", info->label);
 
                list_del(&info->timer->entry);
-               del_timer_sync(&info->timer->timer);
+               timer_shutdown_sync(&info->timer->timer);
                cancel_work_sync(&info->timer->work);
                sysfs_remove_file(idletimer_tg_kobj, &info->timer->attr.attr);
                kfree(info->timer->attr.attr.name);
@@ -441,7 +441,7 @@ static void idletimer_tg_destroy_v1(const struct xt_tgdtor_param *par)
                if (info->timer->timer_type & XT_IDLETIMER_ALARM) {
                        alarm_cancel(&info->timer->alarm);
                } else {
-                       del_timer_sync(&info->timer->timer);
+                       timer_shutdown_sync(&info->timer->timer);
                }
                cancel_work_sync(&info->timer->work);
                sysfs_remove_file(idletimer_tg_kobj, &info->timer->attr.attr);


Which all look legit.

I'll post a v6a using the new script.

-- Steve

