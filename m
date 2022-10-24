Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3631B609F67
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJXKzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJXKyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:54:40 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB40CE0E;
        Mon, 24 Oct 2022 03:54:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F0CAF61D7A;
        Mon, 24 Oct 2022 12:44:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1666608272; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=s6+zpCqS6FPxz8ZLKaj1J443b3jYNWuEs6pNuizXfBs=;
        b=cLi1hzzFHj8dNkBW0yrnn+LRsRdGoWuCmaLSI+VBf2/mX7lC78Gmie4gPpJH1URSSet0TW
        Un8fW2WYnNd2MfYt8nPZwl56cNZSBWJfaXaIXLC0dsHQaXefyftS5cTmUf+95gdot1Et6p
        4u1TipPziBcE6dw4QlQ2YPSekpcidzfFDtNF2n7ggsPHF7gpgZjvBq/wlRpvdFaY9DfrUw
        gVW37QGelHsXHePuKfGb6OIEq/pWRP4XJ3WeMBcUO7IyFblXtW4fCNSZdWxupzVduwLZpu
        E3P3Md1gbUfo+moCh7DDDnaxhZUQllbRiRZ3BL2WWzS0g78pE5ScnNROjc0uAg==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 4/9] Revert "workqueue: Use local irq lock instead of irq disable regions"
Date:   Mon, 24 Oct 2022 12:44:20 +0200
Message-Id: <20221024104425.16423-5-wagi@monom.org>
In-Reply-To: <20221024104425.16423-1-wagi@monom.org>
References: <20221024104425.16423-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.19.255-rt114-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


This reverts the PREEMPT_RT related changes to workqueue. It reverts the
usage of local_locks() and cpu_chill().

This is a preparation to pull in the PREEMPT_RT related changes which
were merged upstream.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[wagi: 827b6f6962da ("workqueue: rework") already reverted
       most of the changes, except the missing update in
       put_pwq_unlocked.]
Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 kernel/workqueue.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4ed22776b2ee..d97c2ad8dc08 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1496,11 +1496,9 @@ EXPORT_SYMBOL(queue_work_on);
 void delayed_work_timer_fn(struct timer_list *t)
 {
 	struct delayed_work *dwork = from_timer(dwork, t, timer);
-	unsigned long flags;
 
-	local_irq_save(flags);
+	/* should have been called from irqsafe timer with irq already off */
 	__queue_work(dwork->cpu, dwork->wq, &dwork->work);
-	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(delayed_work_timer_fn);
 
-- 
2.38.0

