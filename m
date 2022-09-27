Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0FD5EB9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiI0Fpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiI0Fpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:45:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA838E449;
        Mon, 26 Sep 2022 22:45:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y136so8762918pfb.3;
        Mon, 26 Sep 2022 22:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wtwWABB0BpI6/a65gQtEabnzhcZ4S5n275z4YEq9z6Y=;
        b=lGnUS5bSHuqMWffgy1HOdM5vnxI0w1kBHZxMNpyQB9WPt4nM4GNHAlGyc4jqIIZYDR
         1yOq+LuIumhCoSowKrJrYzAt+nHuUeAQfPQDrVKZekA9T4sRieeruZ67jYwr99QxQqx4
         IPxuA8SvbkgpJVzTkSlBhNxVBWBpyBaT1JKP0nDvvHaPD4NXw9bKKPE47adb0gb/jeQA
         v+1I3V347ib5jZkZ3dNPPn1zmvE3owzKjgZC/VPth1bTewkt/yVcz7J47UHy0+mwG061
         +ZBmPdlfgu/T+ueA/IGJ5UkD92JsO6QI+GiVSk78iu10bQeDUcArlui9vFglN4vDwB8M
         v87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wtwWABB0BpI6/a65gQtEabnzhcZ4S5n275z4YEq9z6Y=;
        b=rd+/lTlyOrqQbL54E2fTEIFgvDx4tQpiPHGip7ASg45MQXro8NC+/PX6CW5eKwKshJ
         CnaPbnknXjtxwzqEhGuS6AaIObxoVdfu33aXRoUeDzdANds8iy2Dg+zckYDyNLm6baVo
         HKqm22DNSRy2SiTbdQjSNwWR6ksWABcZxomM+mPzOQQdIYHNps2rTcWDn5jkh37Rhaxd
         TO8Xg4fRJNyZQhxHivZd3FpR2s5xYzDmnbKVO31/DpCeUesKnOH//X4Jdm/7gcKm3ki/
         iObEYzArW6kg8yLxUrrz0Uq700PL194DOmR86FU9rSJKz9l68XZ7fuULH0+IGUj6UBvI
         tqzQ==
X-Gm-Message-State: ACrzQf2OkB5pn1gBA6Uck4Ekz3bo3bo+O5NMPWNiXLNq5OhbpDCXW6Uc
        wAqO59KgUXw/ET4Ry7PUv0BORT2Q75eU1w9vi/E=
X-Google-Smtp-Source: AMsMyM5j4uZ5IMP3R87CCe0z5LSitKwCdY4KhaoLIW/mCPI3pAJIIkZh/YOSqz3qMtFdH2SfQKJDFKjjd6UZd2/bcME=
X-Received: by 2002:a63:4d5b:0:b0:42c:299e:eecc with SMTP id
 n27-20020a634d5b000000b0042c299eeeccmr22736136pgl.41.1664257535701; Mon, 26
 Sep 2022 22:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220916090506.10662-1-wenchao.chen666@gmail.com>
 <CAPDyKFqNJzwizZduMj_ig=aEXAgssQM8AzbYxa_T9XEqNXeWPw@mail.gmail.com> <25977700-7ab7-9a3b-5c67-c6c5fe35a13a@intel.com>
In-Reply-To: <25977700-7ab7-9a3b-5c67-c6c5fe35a13a@intel.com>
From:   =?UTF-8?B?6ZmI5paH6LaF?= <wenchao.chen666@gmail.com>
Date:   Tue, 27 Sep 2022 13:45:21 +0800
Message-ID: <CA+Da2qxNU9cuYLm3-RcTeqpSszeCtHw4bzQ2xe_=76mwaKiKSQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: Fix data stomping during mmc recovery
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 6:19 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 20/09/22 12:32, Ulf Hansson wrote:
> > + Adrian
> >
> > On Fri, 16 Sept 2022 at 11:05, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
> >>
> >> From: Wenchao Chen <wenchao.chen@unisoc.com>
> >>
> >> The block device uses multiple queues to access emmc. There will be up to 3
> >> requests in the hsq of the host. The current code will check whether there
> >> is a request doing recovery before entering the queue, but it will not check
> >> whether there is a request when the lock is issued. The request is in recovery
> >> mode. If there is a request in recovery, then a read and write request is
> >> initiated at this time, and the conflict between the request and the recovery
> >> request will cause the data to be trampled.
> >>
> >> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> >
> > Looks like we should consider tagging this for stable kernels too, right?
Yes,

Kernel crash log:
[  242.987575] process reclaim queue work at vmpressure 79
[  243.041611] CPU: 0 PID: 5 Comm: kworker/0:0 Tainted: G        WC O
    5.4.147-ab07227 #1
[  243.041615] Hardware name: Generic DT based system
[  243.041628] Workqueue: events mmc_mq_recovery_handler
[  243.041638] PC is at mmc_blk_mq_recovery+0x2c/0x120
[  243.041643] LR is at mmc_mq_recovery_handler+0x54/0xb8
[  243.041648] pc : [<c0b9511c>]    lr : [<c06e331c>]    psr: 20030013
[  243.041651] sp : ee941f00  ip : eed191a0  fp : ee941f08
[  243.041655] r10: 00000000  r9 : e00aca0c  r8 : e0243fc0
[  243.041659] r7 : e0096000  r6 : eed1b280  r5 : 00000000  r4 : e00aca08
[  243.041667] r3 : c0cb7fd0  r2 : 00000000  r1 : a68e26a3  r0 : e0096000
[  243.059012] process reclaim queue work at vmpressure 72

dis -lx mmc_blk_mq_recovery
0xc0b950f0 <mmc_blk_mq_recovery>:       push    {r4, r5, r11, lr}
0xc0b950f4 <mmc_blk_mq_recovery+0x4>:   add     r11, sp, #8
0xc0b950f8 <mmc_blk_mq_recovery+0x8>:   mov     r4, r0
0xc0b950fc <mmc_blk_mq_recovery+0xc>:   stmfd   sp!, {lr}
0xc0b95100 <mmc_blk_mq_recovery+0x10>:  ldmfd   sp!, {lr}
0xc0b95104 <mmc_blk_mq_recovery+0x14>:  ldr     r0, [r4]
0xc0b95108 <mmc_blk_mq_recovery+0x18>:  mov     r2, #0
0xc0b9510c <mmc_blk_mq_recovery+0x1c>:  ldr     r5, [r4, #196]  ; 0xc4
0xc0b95110 <mmc_blk_mq_recovery+0x20>:  ldr     r0, [r0]
0xc0b95114 <mmc_blk_mq_recovery+0x24>:  str     r2, [r4, #196]  ; 0xc4
0xc0b95118 <mmc_blk_mq_recovery+0x28>:  strb    r2, [r4, #148]  ; 0x94
0xc0b9511c <mmc_blk_mq_recovery+0x2c>:  ldr     r1, [r5, #404]  ; 0x194

Analyze:
0xc0b9510c <mmc_blk_mq_recovery+0x1c>:  ldr     r5, [r4, #196]  ; 0xc4
r4 = e00aca08
r4 + 0xc4 = E00ACACC
crash_arm> rd E00ACACC
e00acacc:  ec00cc00
But r5 is 0, the correct value should be ec00cc00

Code:
void mmc_blk_mq_recovery(struct mmc_queue *mq)
{
struct request *req = mq->recovery_req;
struct mmc_host *host = mq->card->host;
struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);

mq->recovery_req = NULL;//<2>
mq->rw_wait = false;

if (mmc_blk_rq_error(&mqrq->brq)) {
mmc_retune_hold_now(host);
mmc_blk_mq_rw_recovery(mq, req);
}

mmc_blk_urgent_bkops(mq, mqrq);

mmc_blk_mq_post_req(mq, req, true);
}

static void mmc_blk_hsq_req_done(struct mmc_request *mrq)
{
struct mmc_queue_req *mqrq =
container_of(mrq, struct mmc_queue_req, brq.mrq);
struct request *req = mmc_queue_req_to_req(mqrq);
struct request_queue *q = req->q;
struct mmc_queue *mq = q->queuedata;
struct mmc_host *host = mq->card->host;
unsigned long flags;

if (mmc_blk_rq_error(&mqrq->brq) ||
    mmc_blk_urgent_bkops_needed(mq, mqrq)) {
spin_lock_irqsave(&mq->lock, flags);
mq->recovery_needed = true;
mq->recovery_req = req; //<1>
spin_unlock_irqrestore(&mq->lock, flags);

host->cqe_ops->cqe_recovery_start(host);

schedule_work(&mq->recovery_work);
return;
}

mmc_blk_rw_reset_success(mq, req);

/*
* Block layer timeouts race with completions which means the normal
* completion path cannot be used during recovery.
*/
if (mq->in_recovery)
mmc_blk_cqe_complete_rq(mq, req);
else if (likely(!blk_should_fake_timeout(req->q)))
blk_mq_complete_request(req);
}

When <1> is executed, just after the previous work is executed <2>, at
this time, mq->recovery_req will be reassigned to NULL, causing the
kernel to crash.
So we need to wait for the recovery to complete before continuing to issue req.

> >
> >> ---
> >>  drivers/mmc/host/mmc_hsq.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> >> index a5e05ed0fda3..9d35453e7371 100644
> >> --- a/drivers/mmc/host/mmc_hsq.c
> >> +++ b/drivers/mmc/host/mmc_hsq.c
> >> @@ -34,7 +34,7 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
> >>         spin_lock_irqsave(&hsq->lock, flags);
> >>
> >>         /* Make sure we are not already running a request now */
> >> -       if (hsq->mrq) {
> >> +       if (hsq->mrq || hsq->recovery_halt) {
> >
> > This still looks a bit odd to me, but I may not fully understand the
> > code, as it's been a while since I looked at this.
> >
> > In particular, I wonder why the callers of mmc_hsq_pump_requests()
> > need to release the spin_lock before they call
> > mmc_hsq_pump_requests()? Is it because we want to allow some other
> > code that may be waiting for the spin_lock to be released, to run too?
>
> FWIW, I am not aware of any reason.
>
> >
> > If that isn't the case, it seems better to let the callers of
> > mmc_hsq_pump_requests() to keep holding the lock - and thus we can
> > avoid the additional check(s). In that case, it means the
> > "recovery_halt" flag has already been checked, for example.
> >
> >>                 spin_unlock_irqrestore(&hsq->lock, flags);
> >>                 return;
> >>         }
> >> --
> >> 2.17.1
> >>
> >
> > Kind regards
> > Uffe
>
