Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B887C6FF33E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbjEKNmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238166AbjEKNm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:42:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52AC106C4
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:42:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683812531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iCwX8gHyc3b+mBTSawk7jvVq4HsHK8LP72wiJ/1PsQw=;
        b=fXlTxNIgHL75VxOsJEKll1WWilsJNeHpptTpPm1JDmAa5Q6MnxsT09wv2el/6zu4p0SevS
        RjeG+lb0o1JKqXg3ovlZ/N9SerZBO6TdewLXbYyVA03LnAsOJMeJn3j5XC9gabG3T8FJZ2
        PonkFjRUUwnWFyJELe9eJNNC5oFRAZsVqcBy/lCryvqJD+r9D+x1bl2kWGZy6j2Qss1qQQ
        T0i4RIt4g89tvLCwLrX9S/1TPYApr7MB2tlPPLpGQJ1umnkoDuo+i3r4zSB1H1f5ypeEKM
        evKiVSWbAOAOLbQMN31ED/VcUak9Rn1txa8BkeIRK+isfhy4id8lTkXrWN0Ltw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683812531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iCwX8gHyc3b+mBTSawk7jvVq4HsHK8LP72wiJ/1PsQw=;
        b=d9j/MDo1mtTovVltFiI5zG8LDyf0ar7JcOqj4Y1gAI8sMOnWIFM+RegaOROgMRrv0u0lOG
        b5uORHX/7MsR7ZCQ==
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Andrey Vagin <avagin@openvz.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Emelyanov <xemul@openvz.org>
Subject: Re: [RFD] posix-timers: CRIU woes
In-Reply-To: <c25b958d-f843-41d1-7b68-5d069f5c5121@virtuozzo.com>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx> <878rdy32ri.ffs@tglx>
 <87v8h126p2.ffs@tglx> <875y911xeg.ffs@tglx> <87ednpyyeo.ffs@tglx>
 <CANaxB-wV9iUT6=Y9nZCWbJhiscMrnAQh4fUXs7Tb8pr=-HwSYQ@mail.gmail.com>
 <cc8aa6a4-a187-f3ad-fec9-05f037a3886d@virtuozzo.com> <87r0rnciqo.ffs@tglx>
 <c25b958d-f843-41d1-7b68-5d069f5c5121@virtuozzo.com>
Date:   Thu, 11 May 2023 15:42:10 +0200
Message-ID: <87ilczc7d9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11 2023 at 17:52, Pavel Tikhomirov wrote:
> On 11.05.2023 17:36, Thomas Gleixner wrote:
>> On Thu, May 11 2023 at 11:17, Pavel Tikhomirov wrote:
>>> On 10.05.2023 16:16, Andrey Vagin wrote:
>>>>>
>>>>> So because of that half thought out user space ABI we are now up the
>>>>> regression creek without a paddle, unless CRIU can accomodate to a
>>>>> different restore mechanism to lift this restriction from the kernel.
>>>>>
>>>> If you give us a new API to create timers with specified id-s, we will
>>>> figure out how to live with it. It isn't good to ask users to update
>>>> CRIU to work on new kernels, but here are reasons and event improvements
>>>> for CRIU, so I think it's worth it.
>>>
>>> I agree, any API to create timers with specified id-s would work for new
>>> CRIU versions.
>> 
>> The real question is whether this will cause any upheaval when a new
>> kernel meets a non-updated CRIU stack.
>
> Creation of posix timer would hang forever in this loop 
> https://github.com/checkpoint-restore/criu/blob/33dd66c6fc93c47213aaa0447a94d97ba1fa56ba/criu/pie/restorer.c#L1185 
> if old criu is run on new kernel (without consecutive id allocation) AFAICS.

Yes, because that "sanity" check

     if ((long)next_id > args->posix_timers[i].spt.it_id)

which tries to establish whether the kernel provides timer IDs in strict
increasing order does not work for that case.

It "works" to detect the IDR case on older kernels by chance, but not
under all circumstances. Assume the following case:

      Global IDR has a free slot at index 1

      Restore tries to create a timer for index 2

That will also loop forever, unless some other process creates a timer
and occupies the free slot at index 1, right?

So this needs a fix anyway, which should be done so that the new kernel
case is at least properly detected.

But even then there is still the problem of "it worked before I upgraded
the kernel".

IOW, we are still up a creek without a paddle, unless you would be
willing to utilize the existing CRIU bug to distribute the 'deal with
new kernel' mechanics as a bug bounty :)

Fix for the loop termination below.

Thanks,

        tglx
---
 criu/pie/restorer.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

--- a/criu/pie/restorer.c
+++ b/criu/pie/restorer.c
@@ -1169,10 +1169,10 @@ static int timerfd_arm(struct task_resto
 static int create_posix_timers(struct task_restore_args *args)
 {
 	int ret, i;
-	kernel_timer_t next_id;
+	kernel_timer_t next_id, timer_id;
 	struct sigevent sev;
 
-	for (i = 0; i < args->posix_timers_n; i++) {
+	for (i = 0, next_id = 0; i < args->posix_timers_n; i++) {
 		sev.sigev_notify = args->posix_timers[i].spt.it_sigev_notify;
 		sev.sigev_signo = args->posix_timers[i].spt.si_signo;
 #ifdef __GLIBC__
@@ -1183,25 +1183,27 @@ static int create_posix_timers(struct ta
 		sev.sigev_value.sival_ptr = args->posix_timers[i].spt.sival_ptr;
 
 		while (1) {
-			ret = sys_timer_create(args->posix_timers[i].spt.clock_id, &sev, &next_id);
+			ret = sys_timer_create(args->posix_timers[i].spt.clock_id, &sev, &timer_id);
 			if (ret < 0) {
 				pr_err("Can't create posix timer - %d\n", i);
 				return ret;
 			}
 
-			if (next_id == args->posix_timers[i].spt.it_id)
+			if (timer_id != next_id) {
+				pr_err("Can't create timers, kernel don't give them consequently\n");
+				return -1;
+			}
+
+			next_id++;
+
+			if (timer_id == args->posix_timers[i].spt.it_id)
 				break;
 
-			ret = sys_timer_delete(next_id);
+			ret = sys_timer_delete(timer_id);
 			if (ret < 0) {
-				pr_err("Can't remove temporaty posix timer 0x%x\n", next_id);
+				pr_err("Can't remove temporaty posix timer 0x%x\n", timer_id);
 				return ret;
 			}
-
-			if ((long)next_id > args->posix_timers[i].spt.it_id) {
-				pr_err("Can't create timers, kernel don't give them consequently\n");
-				return -1;
-			}
 		}
 	}
 


