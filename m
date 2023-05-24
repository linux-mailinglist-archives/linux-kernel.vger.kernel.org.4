Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3055C70F4D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbjEXLH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjEXLHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:07:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F1E12F
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:07:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-25394160fd3so73265a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684926471; x=1687518471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kwUoFw1i63AKV85YeOpM79iAnzRIac8pe/CUur9ToI=;
        b=rJZD6KdGxtxMGfMZ65tuF/XHKRwmqFYXEdAU9SzIfkvD4hvAR7Eq/aezT5WYq1LQKd
         0GmAU+PxpEssPxphag5NHcsUvbLpqvVpHgI9qoNlgQNefbTFHuTIlEy7d414wxGhb3KL
         dTTU2TBiTjhjRLmzgDUuWJ9YFP+YaseUAe9f8fNKlOC2v9AhuDtjDO1ggB7CDvwWiK7i
         94dWLSt7rRxbL24rzkad0oWpL3vbr9wfnU+7obqX39AvNVeMWh7ZG4+63os7zkmMES/D
         7BdLblh8y9WgbUn+XWvrvx5vAtrZrTjDVa7MsZz7yzW1KYGRGWHNFSGVaIQ3Uw6mGPLC
         TlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684926471; x=1687518471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kwUoFw1i63AKV85YeOpM79iAnzRIac8pe/CUur9ToI=;
        b=IdPXeF5oKUBK+0aSxkMGbdNBTThWXDk5Jj3C5pJHfFFOJrtsglMPkUEuTStNL5m7Ya
         kkxyUtB9O7ACV4y7FacAEhoZxnB5iHjQobCLESS3jfz6Rr3L8iG7zQc7iVy0aGXDLB1B
         Au0lKMLvUQdtK2WCYOT82DWPASA2rJMYA9N15VLcxleAzwcRDt3bnikbB0RraISdHtYk
         NAUTQInCMm3ruZTnSOJPutjJX+m6ye0A1qResWMd9QsmxPxhKJlgm/iIGRTwbmP3ljzT
         Lg8uxE7Cnvzk4KoSsqNeywu1zQZaRtJhmOnIW8qScR5IACUDK2pwdy3hmAoJfUgT7dgM
         7p4g==
X-Gm-Message-State: AC+VfDwT0nLj/62chzjbpXgiLMVIaiwV/jSkWZwR6sCkd/4OnO1Khkoe
        3peom2cRVPaj3I34yo6YQhI4gcnXaNg=
X-Google-Smtp-Source: ACHHUZ5b8yTYf2SfFtwVp6myUaHhmww9y384rCnWI3pX3y4OW8Ohd+vPCKGtSHjAdu2MMDLr9Lg6vw==
X-Received: by 2002:a17:90b:4d91:b0:255:7d50:c1aa with SMTP id oj17-20020a17090b4d9100b002557d50c1aamr8356264pjb.44.1684926470481;
        Wed, 24 May 2023 04:07:50 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id q89-20020a17090a756200b002508f0ac3edsm1163040pjk.53.2023.05.24.04.07.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 May 2023 04:07:50 -0700 (PDT)
Date:   Wed, 24 May 2023 19:15:49 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        huyue2@coolpad.com, zhangwen@coolpad.com
Subject: Re: [PATCH] erofs: remove end parameter from
 z_erofs_pcluster_readmore()
Message-ID: <20230524191549.000037d6.zbestahu@gmail.com>
In-Reply-To: <4056d17c-6cdf-0248-b36f-1fbb7a3685e8@linux.alibaba.com>
References: <20230524101305.22105-1-zbestahu@gmail.com>
        <4056d17c-6cdf-0248-b36f-1fbb7a3685e8@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 18:45:48 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/5/24 03:13, Yue Hu wrote:
> > From: Yue Hu <huyue2@coolpad.com>
> > 
> > The `end` argument is pointless if it's not backmost.  And we already
> > have `headoffset` in struct `*f`, so let's use this offset to get the
> > `end` for backmost only instead in this function.
> > 
> > Also, remove linux/prefetch.h since it's not used anymore after commit
> > 386292919c25 ("erofs: introduce readmore decompression strategy").
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>  
> > --->   fs/erofs/zdata.c | 19 ++++++++-----------  
> >   1 file changed, 8 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index 5cd971bcf95e..b7ebdc8f2135 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -5,7 +5,6 @@
> >    * Copyright (C) 2022 Alibaba Cloud
> >    */
> >   #include "compress.h"
> > -#include <linux/prefetch.h>
> >   #include <linux/psi.h>
> >   #include <linux/cpuhotplug.h>
> >   #include <trace/events/erofs.h>
> > @@ -1825,16 +1824,16 @@ static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
> >    */
> >   static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
> >   				      struct readahead_control *rac,
> > -				      erofs_off_t end,
> > -				      struct page **pagepool,
> > -				      bool backmost)
> > +				      struct page **pagepool, bool backmost)
> >   {
> >   	struct inode *inode = f->inode;
> >   	struct erofs_map_blocks *map = &f->map;
> > -	erofs_off_t cur;
> > +	erofs_off_t cur, end;
> >   	int err;
> >   
> >   	if (backmost) {
> > +		end = f->headoffset +
> > +		      rac ? readahead_length(rac) : PAGE_SIZE - 1;  
> 
> 		could we avoid "?:" here for readability?

Ok, let me change to use if-else branch.
And seems 'newstart' should be just `f->headoffset`.
I will send v2 later.

> 
> Thanks,
> Gao Xiang

