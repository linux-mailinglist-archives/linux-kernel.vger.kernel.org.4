Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E21961E775
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 00:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiKFXIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 18:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiKFXIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 18:08:39 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2690A2605
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 15:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zzS08RiZF1Z2uI4dAaatGojb+Gx3qLBB9eWAehoQ11w=;
  b=XRU4jXssVxHsQFesRVrwWQJRuhXJ+YiF2L0KcizR/t2gdch8wh1WLrTu
   gMkK4s5dCFxvlbZgPBbzPBh6++XOhHmCEKGVhHE1LuxaizGcYI+ScxuxY
   /1Bu1a+m1xlPHqhCLlI0tvpp+CjInI2UNl1DBO5uZWes6xdhGyRGUj5vT
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.96,143,1665439200"; 
   d="scan'208";a="39031933"
Received: from unknown (HELO hadrien) ([129.126.215.52])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 00:08:30 +0100
Date:   Mon, 7 Nov 2022 07:08:27 +0800 (+08)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v5a 5/5] treewide: Convert del_timer*() to
 timer_shutdown*()
In-Reply-To: <20221106160956.2414d73f@rorschach.local.home>
Message-ID: <4e62b9f4-911-b412-d66-3192cb36af2f@inria.fr>
References: <20221106054535.709068702@goodmis.org> <20221106054649.099333291@goodmis.org> <CAHk-=wiD3VWYqgO7JLqRCJvYHiO5RicGAERH1dWQ2pDqnXDy6g@mail.gmail.com> <20221106160956.2414d73f@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Nov 2022, Steven Rostedt wrote:

> On Sun, 6 Nov 2022 12:51:46 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > Thanks, this looks reasonable.
> >
> > On Sat, Nov 5, 2022 at 10:46 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > The coccinelle script:
> > >
> > > @@
> > > expression E;
> > > identifier ptr, timer, rfield, slab;
> >
> > I think Julia suggested making 'ptr' be an expression too, and I think
>
> And I forgot to add Julia to the Cc :-/
>
> > she's right. Probably 'slab' should be too - there's no reason to
> > limit it to just one identifier.
> >
> > >   ... when strict
> > >       when != ptr->timer.function = E;
> >
> > I suspect any "ptr->timer" access anywhere between the
> > del_timer_sync() and the freeing should disable things.
> >
> > Although hopefully there aren't any other odd cases than that one
> > "clear timer function by hand" one.
>
> OK, I did the following with this new script:
>
> $ cat timer.cocci
> @@
> expression E,ptr,slab;
> identifier timer, rfield;
> @@
> (
> -       del_timer(&ptr->timer);
> +       timer_shutdown(&ptr->timer);
> |
> -       del_timer_sync(&ptr->timer);
> +       timer_shutdown_sync(&ptr->timer);
> )
>   ... when strict
>       when != ptr->timer.function = E;

Maybe change the second when line to when != ptr->timer to see what are
the differences in the results?  That could show if there is anything
important that has not been taken into account.

julia

> (
>         kfree_rcu(ptr, rfield);
> |
>         kmem_cache_free(slab, ptr);
> |
>         kfree(ptr);
> )
>
>
> $ git show | patch -p1 -R
> $ spatch --dir timer.cocci . > /tmp/t.patch
> $ patch -p1 < /tmp/t.patch
>
> And it caught some more:
>
> $ git diff
> diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
> index 99cae174d558..eec0cc2144e0 100644
> --- a/drivers/atm/idt77252.c
> +++ b/drivers/atm/idt77252.c
> @@ -2530,7 +2530,7 @@ idt77252_close(struct atm_vcc *vcc)
>                 vc->tx_vcc = NULL;
>
>                 if (vc->estimator) {
> -                       del_timer(&vc->estimator->timer);
> +                       timer_shutdown(&vc->estimator->timer);
>                         kfree(vc->estimator);
>                         vc->estimator = NULL;
>                 }
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
> index f9f18ff451ea..7ea2631b8069 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
> @@ -394,7 +394,7 @@ void brcmf_btcoex_detach(struct brcmf_cfg80211_info *cfg)
>
>         if (cfg->btcoex->timer_on) {
>                 cfg->btcoex->timer_on = false;
> -               del_timer_sync(&cfg->btcoex->timer);
> +               timer_shutdown_sync(&cfg->btcoex->timer);
>         }
>
>         cancel_work_sync(&cfg->btcoex->work);
> diff --git a/net/netfilter/xt_IDLETIMER.c b/net/netfilter/xt_IDLETIMER.c
> index 0f8bb0bf558f..8d36303f3935 100644
> --- a/net/netfilter/xt_IDLETIMER.c
> +++ b/net/netfilter/xt_IDLETIMER.c
> @@ -413,7 +413,7 @@ static void idletimer_tg_destroy(const struct xt_tgdtor_param *par)
>                 pr_debug("deleting timer %s\n", info->label);
>
>                 list_del(&info->timer->entry);
> -               del_timer_sync(&info->timer->timer);
> +               timer_shutdown_sync(&info->timer->timer);
>                 cancel_work_sync(&info->timer->work);
>                 sysfs_remove_file(idletimer_tg_kobj, &info->timer->attr.attr);
>                 kfree(info->timer->attr.attr.name);
> @@ -441,7 +441,7 @@ static void idletimer_tg_destroy_v1(const struct xt_tgdtor_param *par)
>                 if (info->timer->timer_type & XT_IDLETIMER_ALARM) {
>                         alarm_cancel(&info->timer->alarm);
>                 } else {
> -                       del_timer_sync(&info->timer->timer);
> +                       timer_shutdown_sync(&info->timer->timer);
>                 }
>                 cancel_work_sync(&info->timer->work);
>                 sysfs_remove_file(idletimer_tg_kobj, &info->timer->attr.attr);
>
>
> Which all look legit.
>
> I'll post a v6a using the new script.
>
> -- Steve
>
>
