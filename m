Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B476E405E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjDQHIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjDQHHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:07:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAE92D4D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:07:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s6-20020a17090a698600b00247a7794e78so736663pjj.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681715273; x=1684307273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU1Eelp74KzEr0sUsJWlhFF4mGcWamWpqWGCcEgLmck=;
        b=OMA9QK5JYfRz/6uRPusmZgaFyuzZt5tirWMC8362U7sSTgVunjwkfUw6WoxPQLFd4I
         fOaavt/27rhek78Lsx6Kh6C8r2GOBvJD5WY24nGd0ilJGcHI/svaw7C1Z4F+TfSKSQvu
         2jHbGBBvEdabMc5HkUiXU1O5mvMxg4Y6rkGDTv/lVGTNxG7GlVqAdXKXNSDMNItkBhkj
         PApZWgg8Ibaw+VYALquT8T/Q3P59PbPTyLQ6Y8mTNN4gCAKogMajuCcESqNH3moie2vi
         SfWU3qLXZgrc88BGOWx6qguUJC4o+FpWf3Y63GgHsts1FepuP+sEsW2RReROgLZmAvj1
         jW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681715273; x=1684307273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WU1Eelp74KzEr0sUsJWlhFF4mGcWamWpqWGCcEgLmck=;
        b=E9/y3O16O71fQBt1AKCltNcjmwSVsm0mLXJNw5fNUbEFs0GYbMNxyt06Yl/2WCTztP
         VzYkMoTxVj+WhR9YGM1DJlEA8BvnfnkYF5/ya2KcoFpwqhTiUuL1ymYhDUH28KQ6Ex+9
         or3bEXnmGJdFePKCm3iv6xiiufjdvfK4hQmAvCGZ0kwW84jR3kgpXP9adHak9wzKLFnU
         tbVW5Ly79awWJAdA7nasPcYstPhQAeez7pB6oPWt/efrHV8I+hY93xE1msCBepAqX2yl
         wzji64h50YtKnxRSQrqRk1G3u9QwEktbfjzvY9P1SpEH85ILHVFPhL/I083z2+jw4+Mw
         kxqg==
X-Gm-Message-State: AAQBX9ea/pZ6HoqEchAzSc3gQ5GSrd0E+PeuAUlqdNqjVYSEscZtygaa
        DEguH/nCa7ToSKv4YL/5RGk=
X-Google-Smtp-Source: AKy350a37xcV+yNa6vzHd2woK8VS5vGyFiU38w+9/N+bTeoFqC7Fx6g6Ob0pSKox9YhfeAxxxoX/Vg==
X-Received: by 2002:a17:902:ce8e:b0:1a6:b55c:8a7c with SMTP id f14-20020a170902ce8e00b001a6b55c8a7cmr9089032plg.57.1681715272965;
        Mon, 17 Apr 2023 00:07:52 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902b58600b001a19bde435fsm6945340pls.65.2023.04.17.00.07.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Apr 2023 00:07:52 -0700 (PDT)
Date:   Mon, 17 Apr 2023 15:15:06 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        jefflexu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        huyue2@coolpad.com, zhangwen@coolpad.com
Subject: Re: [PATCH] erofs: remove unneeded icur field from struct
 z_erofs_decompress_frontend
Message-ID: <20230417151506.00006565.zbestahu@gmail.com>
In-Reply-To: <dd1d75a6-38c3-771c-c1ed-2f5dca523c03@linux.alibaba.com>
References: <20230417064136.5890-1-zbestahu@gmail.com>
        <26cdf7b0-5d7d-68ba-da76-1ad800708946@linux.alibaba.com>
        <dd1d75a6-38c3-771c-c1ed-2f5dca523c03@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 15:00:25 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/4/17 14:52, Gao Xiang wrote:
> > 
> > 
> > On 2023/4/17 14:41, Yue Hu wrote:  
> >> From: Yue Hu <huyue2@coolpad.com>
> >>
> >> The icur field is only used in z_erofs_try_inplace_io(). Let's just use
> >> a local variable instead. And no need to check if the pcluster is inline
> >> when setting icur since inline page cannot be used for inplace I/O.  
> 
> Where do we check if the pcluster is inline?

       /* since file-backed online pages are traversed in reverse order */
       fe->icur = z_erofs_pclusterpages(fe->pcl);


static inline unsigned int z_erofs_pclusterpages(struct z_erofs_pcluster *pcl)
{
        if (z_erofs_is_inline_pcluster(pcl))
                return 1;
	[...]

> 
> >>
> >> Signed-off-by: Yue Hu <huyue2@coolpad.com>  
> > 
> > Nope, it's a behavior change.
> > Other users could feed more inplace I/O pages before I/O submission
> > to reduce memory consumption, it's common when applying stress model
> > in low memory scenarios.  
> 
> Oh, I misread it.  I think it can be done in this way although
> each following users will now rescan the whole array all the time.
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> > 
> > Thanks,
> > Gao Xiang
> >   
> >> ---
> >>   fs/erofs/zdata.c | 13 +++++--------
> >>   1 file changed, 5 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> >> index f759152feffa..f8bf2b227942 100644
> >> --- a/fs/erofs/zdata.c
> >> +++ b/fs/erofs/zdata.c
> >> @@ -554,9 +554,6 @@ struct z_erofs_decompress_frontend {
> >>       /* used for applying cache strategy on the fly */
> >>       bool backmost;
> >>       erofs_off_t headoffset;
> >> -
> >> -    /* a pointer used to pick up inplace I/O pages */
> >> -    unsigned int icur;
> >>   };
> >>   #define DECOMPRESS_FRONTEND_INIT(__i) { \
> >> @@ -707,11 +704,13 @@ static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
> >>                      struct z_erofs_bvec *bvec)
> >>   {
> >>       struct z_erofs_pcluster *const pcl = fe->pcl;
> >> +    /* file-backed online pages are traversed in reverse order */  
> 
> Although please help refine the comment below:
> 
> 	/* scan & fill inplace I/O pages in the reverse order */

Ok, will refine it in v2.

> 
> Thanks,
> Gao Xiang
> 
> >> +    unsigned int icur = pcl->pclusterpages;
> >> -    while (fe->icur > 0) {
> >> -        if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
> >> +    while (icur > 0) {
> >> +        if (!cmpxchg(&pcl->compressed_bvecs[--icur].page,
> >>                    NULL, bvec->page)) {
> >> -            pcl->compressed_bvecs[fe->icur] = *bvec;
> >> +            pcl->compressed_bvecs[icur] = *bvec;
> >>               return true;
> >>           }
> >>       }
> >> @@ -877,8 +876,6 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
> >>       }
> >>       z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
> >>                   Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
> >> -    /* since file-backed online pages are traversed in reverse order */
> >> -    fe->icur = z_erofs_pclusterpages(fe->pcl);
> >>       return 0;
> >>   }  

