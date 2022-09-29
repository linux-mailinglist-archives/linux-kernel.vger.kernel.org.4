Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE055EF72E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbiI2OGv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Sep 2022 10:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbiI2OGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:06:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C7513A95E;
        Thu, 29 Sep 2022 07:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D8A9B824A8;
        Thu, 29 Sep 2022 14:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387F7C433D7;
        Thu, 29 Sep 2022 14:06:38 +0000 (UTC)
Date:   Thu, 29 Sep 2022 10:07:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "dinggao.pan" <dinggao.pan@horizon.ai>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ming.yu" <ming.yu@horizon.ai>,
        "yunqian.wang" <yunqian.wang@horizon.ai>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [PATCH RFC stable 4.14 1/1] mmc: core: fix hung task caused by
 race condition on context_info
Message-ID: <20220929100750.172e53d4@gandalf.local.home>
In-Reply-To: <CAPDyKFo_izPD7z-GmSEZ_8H_AX+KiVuLqN7JcD2Kdjjuukk-7g@mail.gmail.com>
References: <21f604139a9a4675b9ed49292839dcfb@horizon.ai>
        <dd8d212c48944cb4ba3b58af2efe3723@horizon.ai>
        <CAPDyKFo_izPD7z-GmSEZ_8H_AX+KiVuLqN7JcD2Kdjjuukk-7g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 14:41:26 +0200
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On Mon, 5 Sept 2022 at 08:22, dinggao.pan <dinggao.pan@horizon.ai> wrote:
> >
> > Hi,
> > After applying rt patches to our 4.14 kernel and enabling preempt-rt, we met a hung task during boot caused by race condition on context_info stored in struct mmc_host.
> > From our investigation, context_info should not be changed by threads that have not claimed the host, hence the following fix.
> >
> > Any comments are much appreciated.
> > Dinggao Pan  
> 
> Hi Dinggao,
> 
> Apologize for the delay.
> 
> The 4.14 kernel is too old for me to be able to comment. In
> particular, the mmc block layer moved to blk-mq in v4.16, which means
> the path you are investigating doesn't exist any more, sorry.

Luis (Cc'd) is still supporting the 4.14-rt kernel.

-- Steve

> 
> Kind regards
> Uffe
> 
> >
> > From: "Dinggao Pan" <mailto:dinggao.pan@horizon.ai>
> >
> > 　　A race condition happens under following circumstances:
> >     (mmc_thread1)               |              (mmc_thread2)
> >     mmc_issue_rq(req1)          |  
> >       > qcnt++ for req1         |  
> >         host handling req1      |
> >     mmc_queue_thread(req=null)  |  
> >       > enter queue thread      |  
> >         again, fetches blk req  |
> >         (return null), sets     |
> >         is_waiting_last_req 1   |  mmc_request_fn(req1) -> set is_new_req 1
> >                                 |                   and wake_up wait_queue
> >     mmc_issue_rq(req2)          |   > mmc_thread2 tries to claim host  
> >       > **qcnt++ for req2**     |  
> >       mmc_finalize_req(req2)    |  
> >         > should wait for req1  |  
> >           done but req2 return  |
> >           MMC_BLK_NEW_REQ       |
> >           due to is_new_req     |
> >           already set to 1      |
> >                                 |
> >                                 |
> >     req1 done                   |  
> >       > qcnt-- for req1         |  
> >     mmc_issue_rq(req3)          |  
> >       > qcnt++ for req3         |  
> > req2 is not handled but qcnt is already added(noted by **),
> > thus mmc_thread1 will never release host, causing mmc_threads
> > except thread1 to hung. Fix race by moving wake_up to the front of
> > context_info update.
> >
> > Reviewed By: Yunqian Wang <mailto:yunqian.wang@horizon.ai>
> > Signed-off-by: Dinggao Pan <mailto:dinggao.pan@horizon.ai>
> > Signed-off-by: Ming Yu <mailto:ming.yu@horizon.ai>
> > ---
> > drivers/mmc/core/queue.c | 7 +++++--
> > 1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> > index 0a4e77a5b..58318c102 100644
> > --- a/drivers/mmc/core/queue.c
> > +++ b/drivers/mmc/core/queue.c
> > @@ -107,6 +107,11 @@ static void mmc_request_fn(struct request_queue *q)
> >                return;
> >       }
> >
> > +      if (mq->asleep) {
> > +               wake_up_process(mq->thread);
> > +               return;
> > +      }
> > +
> >       cntx = &mq->card->host->context_info;
> >
> >       if (cntx->is_waiting_last_req) {
> > @@ -114,8 +119,6 @@ static void mmc_request_fn(struct request_queue *q)
> >                wake_up_interruptible(&cntx->wait);
> >       }
> >
> > -       if (mq->asleep)
> > -                wake_up_process(mq->thread);
> > }
> >
> > static struct scatterlist *mmc_alloc_sg(int sg_len, gfp_t gfp)
> > --
> > 2.36.1  

