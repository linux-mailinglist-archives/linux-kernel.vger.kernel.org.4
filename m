Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D2160E28F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiJZNtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbiJZNsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:48:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2EA9638A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:48:34 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso2527987pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj0TM5bO6CiXLXopRt7KzsGmWpYwV3SAG3uAWIAdKIc=;
        b=dEBWnydZB2sT2o4/CNd3AiCHQ6mNtjfUnxKUBT1v8gi915eWHCK4I81u51BH1455ei
         gaScWVm9I5F09VFuiQXdiaM940JpxXIKNrzST5eolWuK4RPmIWSzsQdMAR0ic+3Wohln
         9B0iDTimJV6LFwnANCXHhmoq10odAvZBvvOTaG+n3Jm/1lSnit96Y1UWxEPiYvL44zb9
         0SOT1icgGL3TSVwBZbK+8+NQdWk77UeFqXrtYnUTcw1JkxJzqssHPPFcHq2oHxwIG0ey
         ibFXRADG3hIWxSifwMHPrkcxFPp5Vr1CoFBQVLaAWea+9fbP+SyqLiJ/J436uUcxtXgG
         HWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nj0TM5bO6CiXLXopRt7KzsGmWpYwV3SAG3uAWIAdKIc=;
        b=Qpr4lkgNqtQtr44ymTPYSB3xkTRJe/cGvfbyXSCVMdnhw3rcn1rhfxcuzved4jSE5O
         0IJwfrzI2h7v4onpxP37IAyZp3holGWv7WbyLeGKCwYvMYD1Mq/uzi3i0I2S1LUJUiqv
         YJf4ntge8qIaVHzAzFOoteiJsHFxADFM/1+te6mKKI0d/1lKzCfodhgKyphZmVhbrlzE
         sZkqQkkRoqTghMN0SHn+A2AONEE/z9lCwSJozcF2NcRSgxTPFxogaUzgStlh1MrAvY2R
         mtvZde8D8NJzZCd5rFgGd4TiAiZmB+TiHbqtanbfrLE+liHMZmJNOKvU24AxBzu4/ULB
         vAPg==
X-Gm-Message-State: ACrzQf36A1S7Bm+//b7qTpW88mVbgIDZecFMftVID6oBjY41bHB/VYpb
        yFk+CTP/2sGcxG0eWl98eA1iyA==
X-Google-Smtp-Source: AMsMyM6KCvcn+mv8QO+c1gSYr3stSYSsi3urpCrKbYoOp9HE9VUWT2Q/k4hrndAulZM/iqYiSab0Kg==
X-Received: by 2002:a17:902:b90b:b0:186:8a4d:d4b7 with SMTP id bf11-20020a170902b90b00b001868a4dd4b7mr22604604plb.129.1666792113800;
        Wed, 26 Oct 2022 06:48:33 -0700 (PDT)
Received: from localhost ([135.180.227.132])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902710300b00186c37270f6sm2659038pll.24.2022.10.26.06.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:48:32 -0700 (PDT)
Date:   Wed, 26 Oct 2022 06:48:32 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Oct 2022 23:50:10 PDT (-0700)
Subject:     Re: [PATCH 0/2] (attempt to) Fix RISC-V toolchain extension support detection
In-Reply-To: <20221006173520.1785507-1-conor@kernel.org>
CC:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        conor.dooley@microchip.com, daolu@rivosinc.com, heiko@sntech.de,
        guoren@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-eb49b867-c5d3-45f9-904c-1726b1ce6158@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 10:35:19 PDT (-0700), Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Hey,
> This came up due to a report from Kevin @ kernel-ci, who had been
> running a mixed configuration of GNU binutils and clang. Their compiler
> was relatively recent & supports Zicbom but binutils @ 2.35.2 did not.
>
> Our current checks for extension support only cover the compiler, but it
> appears to me that we need to check both the compiler & linker support
> in case of "pot-luck" configurations that mix different versions of
> LD,AS,CC etc.
>
> Linker support does not seem possible to actually check, since the ISA
> string is emitted into the object files - so I put in version checks for
> that. The checks have gotten a bit ugly since 32 & 64 bit support need
> to be checked independently but ahh well.
>
> As I was going, I fell into the trap of there being duplicated checks
> for CC support in both the Makefile and Kconfig, so as part of renaming
> the Kconfig symbol to TOOLCHAIN_HAS_FOO, I dropped the extra checks in
> the Makefile. This has the added advantage of the TOOLCHAIN_HAS_FOO
> symbol for Zihintpause appearing in .config.
>
> I pushed out a version of this that specificly checked for assember
> support for LKP to test & it looked /okay/ - but I did some more testing
> today and realised that this is redudant & have since dropped the as
> check.
>
> I tested locally with a fair few different combinations, to try and
> cover each of AS, LD, CC missing support for the extension.
>
> The one that I am left wondering about is Zicsr/Zifencei. Our Makefile
> has:
>
>> # Newer binutils versions default to ISA spec version 20191213 which moves some
>> # instructions from the I extension to the Zicsr and Zifencei extensions.
>> toolchain-need-zicsr-zifencei := $(call cc-option-yn, -march=$(riscv-march-y)_zicsr_zifencei)
>> riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
>
> I'd like to also move that one to Kconfig rather than the Makefile so
> that, again, it shows up in .config etc. But as Zicsr/Zifencei do not
> appear to be emitted into the object files it's not a fix and can be a
> follow-on patch if my approach here is not entirely off-the-wall.

This is actually a different case: for Zicbom and Zihintpause the 
instructions were added to the toolchain at the same time the extensions 
were, for Zifencei and Zicsr the toolchain had the instructions before 
the extension was defined (as they were in previous base ISAs).  So the 
assembler always supports "fence.i", it's just a question of whether it 
also needs another extension in march.

I'm not opposed to adding a Kconfig for it, but it's a slightly 
different thing and I'm not sure the Kconfig really helps any because 
none of the kernel sources need to understand the "the assembler doesn't 
support the 'fence.i' instruction" case.

> I am not 100% on the LD/LLD versions that I picked, I went off of a
> `git branch -a --contains` of the first commits I found that with
> mention of the extension. Please scream if I got it wrong, I'm not
> overly familar with where to find this sort of info for the toolchains.

This LD version check is for the ISA string mismatches between objects?  
IIRC we stopped failing on those in 2.38, from that point on we just 
guess at a mix and allow linking anyway (largely because of that fence.i 
stuff).

>
> Thanks,
> Conor.
>
> Conor Dooley (2):
>   riscv: fix detection of toolchain Zicbom support
>   riscv: fix detection of toolchain Zihintpause support
>
>  arch/riscv/Kconfig                      | 17 +++++++++++++----
>  arch/riscv/Makefile                     |  6 ++----
>  arch/riscv/include/asm/vdso/processor.h |  2 +-
>  3 files changed, 16 insertions(+), 9 deletions(-)
