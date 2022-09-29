Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E57F5EFB16
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbiI2QkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiI2QkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2269237D1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664469603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L6vXI1WS0UxzQeZpA4OgRrRLeEgBfGYudqcjKdjRj7M=;
        b=TJu5WBQlN7rYlZSGpbBnpQwfU39CO66Qg3tONs0XE8Wtmq8G7Om3OCmm8oblHwIeOaPhgo
        ZT/6jLk9UNq0HkFV/sv6Ik8575MCR/sIKy69ftC1Q5ujGuUGEDpATRQk7IpEs8Q8AyMk0q
        GJ0uqUbkfWPBAU93VXOELHaT3DfVfhg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-6I3q8TJ0Pm2bKTmHsCLDzQ-1; Thu, 29 Sep 2022 12:40:00 -0400
X-MC-Unique: 6I3q8TJ0Pm2bKTmHsCLDzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C5FB85A5B6;
        Thu, 29 Sep 2022 16:39:59 +0000 (UTC)
Received: from localhost (unknown [10.22.11.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F310F1731B;
        Thu, 29 Sep 2022 16:39:58 +0000 (UTC)
Date:   Thu, 29 Sep 2022 13:39:57 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "dinggao.pan" <dinggao.pan@horizon.ai>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ming.yu" <ming.yu@horizon.ai>,
        "yunqian.wang" <yunqian.wang@horizon.ai>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH RFC stable 4.14 1/1] mmc: core: fix hung task caused by
 race condition on context_info
Message-ID: <YzXKXQOw5FtNmy/J@uudg.org>
References: <21f604139a9a4675b9ed49292839dcfb@horizon.ai>
 <dd8d212c48944cb4ba3b58af2efe3723@horizon.ai>
 <CAPDyKFo_izPD7z-GmSEZ_8H_AX+KiVuLqN7JcD2Kdjjuukk-7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFo_izPD7z-GmSEZ_8H_AX+KiVuLqN7JcD2Kdjjuukk-7g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 02:41:26PM +0200, Ulf Hansson wrote:
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

And the new code has the queue operations protected by a spinlock
(queue_lock), which I believe is necessary to fix the issue reported
here.

Luis
 
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
> 
---end quoted text---

