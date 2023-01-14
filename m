Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBB066A8E1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 04:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjANDPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 22:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjANDPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 22:15:15 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7254E892DC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 19:15:14 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c26so13042822pfp.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 19:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ip/pS4hOwEDNTZTnRliPkXIQuo63sSsYiUxW40edaTA=;
        b=nOe+DyEBVoMASlZf8kH2SaLRZneqHW0TxwZoctB9Pd1wjO9ILxXYcwNyXwgHG6BcqM
         FJyc5ybiUaxetb9fZNDYHxo31GQQFmH2fhAKWbNofU4hImgatXSd8wrqyo9inOG8Z9eP
         VqP/DNkBc4CxL3bE5qtVv1FTG+rFnzXoSCezg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip/pS4hOwEDNTZTnRliPkXIQuo63sSsYiUxW40edaTA=;
        b=m9DQ5a6WpXJPhGzB2SqfNw4qnRP2c7HkHtDBFOvMiZBIQjYsgH8OtetiQSRcx2Dlqv
         AoABQ7usO3ECeZctkv5dNUc/gr1QQXj0Ubc09CVUCGFVjIYvV7rWtrlP0agRTkyVnVVK
         JuqfWFUMVvg9YUjFSrFF0S8xePJO1zIKdCAL76HPh7T1xhIIILdSVVWG9rR9wLWo6cMg
         EUrPf8G8ik2uPBpN1ECUxDJBvWGO0Zio2q+amPW8BYSThVhX/mFfPDm1BzrsMzl3AGHC
         7yzKENaaA6cSscMVZ78vwFnb2yYWnD2SkLL7F9o1XUIr/BhJ8mWrIwx1bqTXBb8E3Hzg
         57iA==
X-Gm-Message-State: AFqh2kohQ9vO2ibMeGx2pRQE7Fu+PMBdL26FU/YWzBk7AZSHyI+XyAL8
        5TdFTXE63zjzRpLRQKfPoPXW3mCR9geRTU3H
X-Google-Smtp-Source: AMrXdXtdqRyfD4/WRdTAd6aI/nEcBBLmsKStZRep6cBm0c/tqlvTgkC9X73jW9+wMzXfPtBCrAuLJQ==
X-Received: by 2002:a62:506:0:b0:56c:7216:fbc6 with SMTP id 6-20020a620506000000b0056c7216fbc6mr81187195pff.30.1673666113826;
        Fri, 13 Jan 2023 19:15:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 128-20020a620586000000b0058b9dc62071sm4301178pff.6.2023.01.13.19.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 19:15:13 -0800 (PST)
Date:   Fri, 13 Jan 2023 19:15:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Terrell <terrelln@meta.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2] lib: zstd: Fix -Wstringop-overflow warning
Message-ID: <202301131911.B3C664392@keescook>
References: <20230104212048.gonna.331-kees@kernel.org>
 <93130521-AF03-4941-8FF1-C97C76027A02@fb.com>
 <202301131643.6D23A4AEA1@keescook>
 <C3D7D026-AA51-45E3-B871-74D411D3F275@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C3D7D026-AA51-45E3-B871-74D411D3F275@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 01:06:07AM +0000, Nick Terrell wrote:
> 
> 
> > On Jan 13, 2023, at 4:48 PM, Kees Cook <keescook@chromium.org> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  This Message Is From an External Sender
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Tue, Jan 10, 2023 at 11:10:08PM +0000, Nick Terrell wrote:
> >> 
> >> 
> >>> On Jan 4, 2023, at 1:20 PM, Kees Cook <keescook@chromium.org> wrote:
> >>> 
> >>> !-------------------------------------------------------------------|
> >>> This Message Is From an External Sender
> >>> 
> >>> |-------------------------------------------------------------------!
> >>> 
> >>> Fix the following -Wstringop-overflow warning when building with GCC 11+:
> >>> 
> >>> lib/zstd/decompress/huf_decompress.c: In function ‘HUF_readDTableX2_wksp’:
> >>> lib/zstd/decompress/huf_decompress.c:700:5: warning: ‘HUF_fillDTableX2.constprop’ accessing 624 bytes in a region of size 52 [-Wstringop-overflow=]
> >>> 700 |     HUF_fillDTableX2(dt, maxTableLog,
> >>>     |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>> 701 |                    wksp->sortedSymbol, sizeOfSort,
> >>>     |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>> 702 |                    wksp->rankStart0, wksp->rankVal, maxW,
> >>>     |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>> 703 |                    tableLog+1,
> >>>     |                    ~~~~~~~~~~~
> >>> 704 |                    wksp->calleeWksp, sizeof(wksp->calleeWksp) / sizeof(U32));
> >>>     |
> >>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>> lib/zstd/decompress/huf_decompress.c:700:5: note: referencing argument 6 of type ‘U32 (*)[13]’ {aka ‘unsigned int (*)[13]’}
> >>> lib/zstd/decompress/huf_decompress.c:571:13: note: in a call to function ‘HUF_fillDTableX2.constprop’
> >>> 571 | static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
> >>>     |             ^~~~~~~~~~~~~~~~
> >>> 
> >>> by using pointer notation instead of array notation.
> >>> 
> >>> This is one of the last remaining warnings to be fixed before globally
> >>> enabling -Wstringop-overflow.
> >> 
> >> The patch looks correct to me, thanks for reviving it. But, I was attempting to reproduce the issue,
> >> so I could better understand what's going on, and I wasn't able to reproduce it myself.
> >> 
> >> To attempt to reproduce, I applied this patch
> >> 
> >> ---
> >> diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
> >> index 20f08c644b71..190d3d5ab4be 100644
> >> --- a/lib/zstd/Makefile
> >> +++ b/lib/zstd/Makefile
> >> @@ -12,6 +12,8 @@ obj-$(CONFIG_ZSTD_COMPRESS) += zstd_compress.o
> >> obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
> >> obj-$(CONFIG_ZSTD_COMMON) += zstd_common.o
> >> 
> >> +ccflags-y := -Wstringop-overflow=4 -Werror
> >> +
> >> zstd_compress-y := \
> >>                zstd_compress_module.o \
> >>                compress/fse_compress.o \
> >> ---
> >> 
> >> Then compiled on x86-64 with gcc 12.2.0 on tag v6.2-rc3. I saw no errors.
> >> I also tried with just `-Wstringop-overflow`, and on upstream zstd. I tried to
> >> make a minimal reproducer on godbolt, so I could see if it was the gcc version,
> >> but wasn't able to make it fail with any of them https://gcc.godbolt.org/z/Exzq9arMr .
> >> 
> >> Could you please tell me how to reproduce this warning?
> > 
> > I saw it like so with next-20230113 on x86_64:
> > 
> > $ gcc --version
> > gcc (Ubuntu 12.2.0-3ubuntu1) 12.2.0
> > ...
> > $ make KCFLAGS=-Wstringop-overflow allmodconfig lib/zstd/decompress/huf_decompress.o
> 
> Thanks, I was able to repro it! I will merge this patch into my tree.

Thanks!

> If you would like to submit the same patch upstream yourself, I will accept the PR, otherwise I can submit an upstream PR.

I don't know the process there, so if you could do it, I'd appreciate
it.

> Just to be certain, this patch is to work around a shortcoming in
> -Wstringop-overflow, but the code was otherwise correct?

It's the same result for the binary output. The types indicated in the
function prototype meant there was cross-struct-member overflow (i.e.
writing to the second array dimension when only 1 was specified), but
the way to clear up intention isn't as clean here, so I'd kind of say
half a code correctness issue, and half a work-around. *makes wavey
hands gesture*

-Kees

-- 
Kees Cook
