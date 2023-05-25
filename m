Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C317105BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 08:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjEYGmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 02:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEYGmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 02:42:43 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A4F191
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 23:42:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2553663f71eso797570a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 23:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1684996961; x=1687588961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RP9FD88UkFVMHShTHtEKtDxspdlacPg7hzEI1lBXYXo=;
        b=nQdCvaRkzM5brXcqkmj6ypJiRH+basjuBsdIDbCieXituJUqGg5FUZkiWLrIFzvM/o
         tFviHg1iUeNP2uvcifiTQpfIo6ThxT+ioYeffvB8hMIZENMU0UATb251h6hRGcc+PUTG
         OioJy2b7P70c95NTnou2A1Bvxldioovu610bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684996961; x=1687588961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RP9FD88UkFVMHShTHtEKtDxspdlacPg7hzEI1lBXYXo=;
        b=MTi2dYq6G+0Zhf1hxMjQ6OIa5cwT5gyKsuElOxvjDcUDykknR2g8l6uQNdr8FQn8O0
         dh41+uN/iV+JlZeWoOqU3BwWkMtfRnRX5u9a4aFgss618h2diGjyGczR5j0ua6qoM0iF
         /uDuZnlw0I6UDKGvuCL4+ImZax37aAvgnRwSDLlzGHkzwCzv4Mmrkw7U8zBHEyDJ3xO0
         fugqcCdRpp97FOvgGMzxVOf+GWm+GHeEfdPG+aGuk6g0sb1aVNcN+My99FX1PZWDYSQf
         RMZ3JZCIYxcNeKw2Me6MkmUw2Bxi8L5zjHPtZf5qhzPNcA2Q1YB9LQ20JiE5dD3n4r39
         8U5A==
X-Gm-Message-State: AC+VfDz6pUtOlZfOFg8iK5faIPHRUBob6wELJEipm201XsMMewu2JMc0
        cZBh9GwbQEwYDhUKSqpwnIlZuFCNhl7t9MikekMQYQ==
X-Google-Smtp-Source: ACHHUZ4Fhrsl0+4imuJWNgdZFCCVBsdlgplnfxSwnr/0TiSEycnFHQqFp3Ctt0QArNetg8P4LM6f7gBY5sX69753HJ8=
X-Received: by 2002:a17:90a:f2ce:b0:24d:ee34:57b6 with SMTP id
 gt14-20020a17090af2ce00b0024dee3457b6mr582694pjb.41.1684996961014; Wed, 24
 May 2023 23:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230523075857.76520-1-duoming@zju.edu.cn> <ZGz9k3jnVqiO20a2@redhat.com>
 <89fc5b.4de4d.18850c1b97f.Coremail.duoming@zju.edu.cn>
In-Reply-To: <89fc5b.4de4d.18850c1b97f.Coremail.duoming@zju.edu.cn>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Thu, 25 May 2023 07:42:29 +0100
Message-ID: <CALrw=nGt6c824fYnArXDbxmOux=61vJR=s6S5ZU2rZY=NhzRbw@mail.gmail.com>
Subject: Re: dm crypt: fix sleep-in-atomic-context bug in kcryptd_crypt_tasklet
To:     duoming@zju.edu.cn
Cc:     Mike Snitzer <snitzer@kernel.org>, linux-kernel@vger.kernel.org,
        agk@redhat.com, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On Thu, May 25, 2023 at 3:34=E2=80=AFAM <duoming@zju.edu.cn> wrote:
>
> Hello,
>
> On Tue, 23 May 2023 13:53:23 -0400 Mike Snitzer wrote:
>
> > > In order to improve the IO performance of the dm-crypt
> > > implementation, the commit 39d42fa96ba1 ("dm crypt:
> > > add flags to optionally bypass kcryptd workqueues")
> > > adds tasklet to do the crypto operations.
> > >
> > > The tasklet callback function kcryptd_crypt_tasklet()
> > > calls kcryptd_crypt() which is an original workqueue
> > > callback function that may sleep. As a result, the
> > > sleep-in-atomic-context bug may happen. The process
> > > is shown below.
> > >
> > >    (atomic context)

Did you actually encounter this in practice? I know it is possible
from the dm-crypt code perspective, but during my initial testing I
could never trigger a setup when the write path was happening in
atomic context

> > > kcryptd_crypt_tasklet()
> > >   kcryptd_crypt()
> > >     kcryptd_crypt_write_convert()
> > >       wait_for_completion() //may sleep
> > >
> > > The wait_for_completion() is a function that may sleep.
> > > In order to mitigate the bug, this patch changes
> > > wait_for_completion() to try_wait_for_completion().
> > >
> > > Fixes: 39d42fa96ba1 ("dm crypt: add flags to optionally bypass kcrypt=
d workqueues")
> > > Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> > > ---
> > >  drivers/md/dm-crypt.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> > > index 8b47b913ee8..5e2b2463d87 100644
> > > --- a/drivers/md/dm-crypt.c
> > > +++ b/drivers/md/dm-crypt.c
> > > @@ -2085,7 +2085,8 @@ static void kcryptd_crypt_write_convert(struct =
dm_crypt_io *io)
> > >     crypt_finished =3D atomic_dec_and_test(&ctx->cc_pending);
> > >     if (!crypt_finished && kcryptd_crypt_write_inline(cc, ctx)) {
> > >             /* Wait for completion signaled by kcryptd_async_done() *=
/
> > > -           wait_for_completion(&ctx->restart);
> > > +           while (!try_wait_for_completion(&ctx->restart))
> > > +                   ;

We can't just busy-loop here. This effectively creates a spin-lock.
And probably on a single CPU system it would hang everything, because
the code would be stuck here and would never give the chance to other
code to signal completion. You might need to do something similar to
how crypt_convert handles this for "EBUSY" case.

> > >             crypt_finished =3D 1;
> > >     }
> > >
> > > --
> > > 2.17.1
> > >
> >
> > Cc'ing Ignat for closer review.
> >
> > But wasn't this already addressed with this commit?:
> > 8abec36d1274 dm crypt: do not wait for backlogged crypto request comple=
tion in softirq
> >
> > Mike
>
> Thank you for your review, I think the commit 8abec36d1274 ("dm crypt:
> do not wait for backlogged crypto request completion in softirq") could
> not solve this problem.
>
> When crypt_convert() returns BLK_STS_PROTECTION or BLK_STS_IOERR, meanwhi=
le,
> there is request that is queued and wait kcryptd_async_done() to process.
> The workqueue callback function kcryptd_crypt_read_continue() will not be=
 called.
> The variable crypt_finished equals to zero, it will call wait_for_complet=
ion()
> that may sleep. The relevant codes are shown below:
>
> static blk_status_t crypt_convert(...)
> {
> ...
>                 /*
>                  * The request is queued and processed asynchronously,
>                  * completion function kcryptd_async_done() will be calle=
d.
>                  */
>                 case -EINPROGRESS:
>                         ctx->r.req =3D NULL;
>                         ctx->cc_sector +=3D sector_step;
>                         tag_offset++;
>                         continue;
> ...
>                 /*
>                  * There was a data integrity error.
>                  */
>                 case -EBADMSG:
>                         atomic_dec(&ctx->cc_pending);
>                         return BLK_STS_PROTECTION;
>                 /*
>                  * There was an error while processing the request.
>                  */
>                 default:
>                         atomic_dec(&ctx->cc_pending);
>                         return BLK_STS_IOERR;
>                 }
> ...
> }
>
> static void kcryptd_crypt_write_convert(...)
> {
> ...
>         r =3D crypt_convert(); //return BLK_STS_PROTECTION or BLK_STS_IOE=
RR
> ...
>         if (r =3D=3D BLK_STS_DEV_RESOURCE) { //this condition is not sati=
sfied, the workqueue will not be called.

Should we just handle BLK_STS_PROTECTION and BLK_STS_IOERR similarly
to BLK_STS_DEV_RESOURCE?

>                 INIT_WORK(&io->work, kcryptd_crypt_write_continue);
>                 queue_work(cc->crypt_queue, &io->work);
>                 return;
>         }
> ...
>         // crypt_finished is zero, because there is request that is queue=
d and wait kcryptd_async_done() to process.
>         crypt_finished =3D atomic_dec_and_test(&ctx->cc_pending);
>         if (!crypt_finished && kcryptd_crypt_write_inline(cc, ctx)) {
>                 /* Wait for completion signaled by kcryptd_async_done() *=
/
>                 wait_for_completion(&ctx->restart);  //may sleep!
>                 ...
>         }
> ...
> }
>
> Best regards,
> Duoming Zhou
>
>
>
>

Ignat
