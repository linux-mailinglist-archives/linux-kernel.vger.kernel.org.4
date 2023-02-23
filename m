Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28AC6A0262
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 06:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjBWFcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 00:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBWFc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 00:32:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26165BB99;
        Wed, 22 Feb 2023 21:32:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0423F615E6;
        Thu, 23 Feb 2023 05:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155EEC4339B;
        Thu, 23 Feb 2023 05:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677130347;
        bh=tZWvuFXOQ4HwnaliWoOMC+207at9HmW9RXIymVau3A4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E0dB585LAZLCX8ruBHtIf+NtLVABjw/UDMACwB8krHa2waxmtdBimKuK7FU1c9vOs
         zhKmbQTZw+6MSsxeqBYk/xN66IXjPnFnlF503tLXDFrwlkdwFvvnC9UYZ5f+vJ8SNK
         5Z4jrS5lVWzWNTDpTLioIck6EKsY/s8fSt0wNDenL0siGW2Bxw/lYwkwsegBt8eMeu
         gF0tshBVpBXMUcqUE59bLjQE6LxZSp41mSVmklHaJZHEBwdUnEQJljwGj0zKfcXB4/
         Kual9bWMqtlEVvWqY6etRfc4lcPRpQgvpRvmqupiUmAz4D+4qi2DOv1bfBxV+QEM84
         4ivZeTDkCqZAw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-172094e10e3so13299533fac.10;
        Wed, 22 Feb 2023 21:32:27 -0800 (PST)
X-Gm-Message-State: AO0yUKWtCVgD6OvTcKWFryVMmkLFENG32Y2GV+8vJQDLA3z6n7qxZSg8
        dtqwaFXLcqe1Lq+zlD+MWAtZ78yBJf7qoPYqF1M=
X-Google-Smtp-Source: AK7set+JB77wQ5G/FBB0pH45ZewGFfkSLhtrofRqARHBfcEbCECO742zGSvt2l5pqjgTieH+tNqylMJOGX5Vo6DqUjY=
X-Received: by 2002:a05:6870:65a4:b0:163:a45a:9e41 with SMTP id
 fp36-20020a05687065a400b00163a45a9e41mr1075917oab.194.1677130346275; Wed, 22
 Feb 2023 21:32:26 -0800 (PST)
MIME-Version: 1.0
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net> <63c2936e-6bc7-67e3-eaf3-0123333381f8@landley.net>
In-Reply-To: <63c2936e-6bc7-67e3-eaf3-0123333381f8@landley.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 23 Feb 2023 14:31:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNASA+Dpe9nv4afnueFeRj4BZDUccOFGJRPr7_rZQ7ZZKaA@mail.gmail.com>
Message-ID: <CAK7LNASA+Dpe9nv4afnueFeRj4BZDUccOFGJRPr7_rZQ7ZZKaA@mail.gmail.com>
Subject: Re: [PATCH 1/5] try generic compiler name "cc" before falling back to "gcc".
To:     Rob Landley <rob@landley.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 5:41 AM Rob Landley <rob@landley.net> wrote:
>
> Distros like debian install the generic "cc" name for both gcc and clang,
> and the plumbing already does CC_VERSION_TEXT to include Makefile.clang.
>
> Previously: https://lkml.iu.edu/hypermail/linux/kernel/2202.0/01505.html
> Signed-off-by: Rob Landley <rob@landley.net>
> ---
>  Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 3f6628780eb2..0ac57ae3b45f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -456,7 +456,7 @@ endif
>  HOSTCC = $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
>  HOSTCXX        = $(LLVM_PREFIX)clang++$(LLVM_SUFFIX)
>  else
> -HOSTCC = gcc
> +HOSTCC := $(shell cc --version >/dev/null 2>&1 && echo cc || echo gcc)



'cc' only makes sense for the host compiler,
which is configured by 'update-alternative'.

I tried it before, but LLVM folks preferred
using $(LLVM) to choose clang/gcc.






>  HOSTCXX        = g++
>  endif
>  HOSTRUSTC = rustc
> @@ -503,7 +503,8 @@ OBJDUMP             = $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
>  READELF                = $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
>  STRIP          = $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
>  else
> -CC             = $(CROSS_COMPILE)gcc
> +CC             := $(CROSS_COMPILE)$(shell $(CROSS_COMPILE)cc --version \
> +                       >/dev/null 2>&1 && echo cc || echo gcc)

This hunk sets up GCC/binutils.
So, cc does not make sense.  NACK.






>  LD             = $(CROSS_COMPILE)ld
>  AR             = $(CROSS_COMPILE)ar
>  NM             = $(CROSS_COMPILE)nm



-- 
Best Regards
Masahiro Yamada
