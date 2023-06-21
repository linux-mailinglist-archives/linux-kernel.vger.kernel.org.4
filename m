Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDE1738BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjFUQmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjFUQmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:42:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9481FFC;
        Wed, 21 Jun 2023 09:42:04 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b50d7b4aaaso27704785ad.3;
        Wed, 21 Jun 2023 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687365724; x=1689957724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZeysVMxLr4V+mtdvRA0frrYDzh/8CDiDj5/Ledzf8A=;
        b=bQJ6bOWQGKdsl9spwn87pEoV4njOCTfT+23Efi4pw7BInh8dGPzR+q2+IY0HwHp4oz
         sdB65Ay702xN0sDc7ieTiRZ16ZJNsqnX6h5TCbFM0/IOL7ncNWDFfyqAFONlcNUunt4i
         PVoqr1Vy0/m3mH1FHzxaymLGgUdVBOfq43ZwKRMzj69HwWZTtwFbguFuEMzZRDOPBoiU
         T6jsJ7rg7fPs/FoAUDu+8La+j20luJ6TpClQLudLgZFR774UjJf4L3Fg5RwXvQgtIRFT
         1/nPRA80kf6KO21z7oCj/P7V77dwqcB6u8ATGvesiWPG//mFKSleIPdVeKMRr8D9sLwv
         47cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687365724; x=1689957724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZeysVMxLr4V+mtdvRA0frrYDzh/8CDiDj5/Ledzf8A=;
        b=QnLcJM3hXwq21BHcRSaGVrWKxTxAJF1eVMTdhUHgs/E9yKBDiWi79+UGkz6n9jnNjT
         7iF1ZjubL6Zaq79MzZ3V8qRbQiNz4JwtPYSaANG3FJEwYoJy/s8JsPdWG+miWRx1NvCS
         4vlmO1a9LRtRRAuqJ7KOsdxQi9ao5Hgouh6rlPheQCpzXgcNqmuxKfuZoI8pRmXtSp4n
         ri6H7+jonf5ocO7bbUntF86RSblWuOhsXz0zzImnY3TDLcUZaHEgz4mz+WspmaJoWVwU
         Mg6xZf1bw9zUAvV1W2dr+0pcHXllz6VWO3LzMVEK0AYfDaFcQSzX+I02PYhkwAOid6x0
         a/pQ==
X-Gm-Message-State: AC+VfDyqthIW6NIc93PCYFjoTJMTxNTDAJqgqakAIMBmgQJKzrxh2/H1
        Tiqfx/MXD9c1yJzBZejKLhI=
X-Google-Smtp-Source: ACHHUZ6wjy33jCOordhGlER/jnFO55zfxhPkZeTwr+8ezi8uYHYbzmDJrgs5j9sgURuC5Hbp7PYOlA==
X-Received: by 2002:a17:902:fa8d:b0:1b0:7739:657a with SMTP id lc13-20020a170902fa8d00b001b07739657amr8509709plb.50.1687365723865;
        Wed, 21 Jun 2023 09:42:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b001ae365072ccsm3755503plh.122.2023.06.21.09.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 09:42:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Jun 2023 09:42:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Marco Elver <elver@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ubsan: Tighten UBSAN_BOUNDS on GCC
Message-ID: <07dea91f-9b93-4227-9fec-728a9e7a0d55@roeck-us.net>
References: <20230405022356.gonna.338-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405022356.gonna.338-kees@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 04, 2023 at 07:23:59PM -0700, Kees Cook wrote:
> The use of -fsanitize=bounds on GCC will ignore some trailing arrays,
> leaving a gap in coverage. Switch to using -fsanitize=bounds-strict to
> match Clang's stricter behavior.
> 
> Cc: Marco Elver <elver@google.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Miroslav Benes <mbenes@suse.cz>
> Cc: linux-kbuild@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

This patch, presumably as side effect, enables CONFIG_ARCH_STM32
for arm64:allmodconfig. As consequence, CONFIG_STM32_RPROC is enabled
as well. This in turn results in the following build error.

Building arm64:allmodconfig ... failed
--------------
Error log:
In file included from include/linux/printk.h:564,
                 from include/asm-generic/bug.h:22,
                 from arch/arm64/include/asm/bug.h:26,
                 from include/linux/bug.h:5,
                 from include/linux/fortify-string.h:5,
                 from include/linux/string.h:254,
                 from include/linux/dma-mapping.h:7,
                 from drivers/remoteproc/stm32_rproc.c:9:
drivers/remoteproc/stm32_rproc.c: In function 'stm32_rproc_mem_alloc':
drivers/remoteproc/stm32_rproc.c:122:22: error: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'size_t'

I did not try to understand what is going on, but reverting this
patch fixes the problem.

---
bisect script:

rm .config
make-arm64 mrproper
make-arm64 -j allmodconfig
if ! grep -q CONFIG_ARCH_STM32 .config; then
    exit 1
fi
exit 0

---
bisect log:
# bad: [15e71592dbae49a674429c618a10401d7f992ac3] Add linux-next specific files for 20230621
# good: [45a3e24f65e90a047bef86f927ebdc4c710edaa1] Linux 6.4-rc7
git bisect start 'HEAD' 'v6.4-rc7'
# good: [e867e67cd55ae460c860ffd896c7fc96add2821c] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good e867e67cd55ae460c860ffd896c7fc96add2821c
# good: [0ab4015a11182e2a19c3dd52db85418f370cef39] Merge branch 'for-next' of git://git.kernel.dk/linux-block.git
git bisect good 0ab4015a11182e2a19c3dd52db85418f370cef39
# good: [50b29407850776d7c61461f883e5896dcea596a4] Merge branch 'driver-core-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
git bisect good 50b29407850776d7c61461f883e5896dcea596a4
# good: [04d46f23e86112fc9d6469fc0155ce19faabc181] Merge branch 'staging-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
git bisect good 04d46f23e86112fc9d6469fc0155ce19faabc181
# good: [bdd44289ba061dab3863ff80a5999d4c6160b93d] Merge branch 'gpio/for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
git bisect good bdd44289ba061dab3863ff80a5999d4c6160b93d
# good: [c7d13e64a19b0bbed1a6eb18e9b4fd55f7530e5d] Merge branch 'at24/for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
git bisect good c7d13e64a19b0bbed1a6eb18e9b4fd55f7530e5d
# good: [6477d1cebd3339658f8421e05380576ed535677c] Merge branch 'rust-next' of https://github.com/Rust-for-Linux/linux.git
git bisect good 6477d1cebd3339658f8421e05380576ed535677c
# bad: [d01a77afd6bef1b3a2ed15e8ca6887ca7da0cddc] lib/string_helpers: Change returned value of the strreplace()
git bisect bad d01a77afd6bef1b3a2ed15e8ca6887ca7da0cddc
# bad: [d67790ddf0219aa0ad3e13b53ae0a7619b3425a2] overflow: Add struct_size_t() helper
git bisect bad d67790ddf0219aa0ad3e13b53ae0a7619b3425a2
# bad: [30ad0627f169f56180e668e7223eaa43aa190a75] dlm: Replace all non-returning strlcpy with strscpy
git bisect bad 30ad0627f169f56180e668e7223eaa43aa190a75
# bad: [3bf301e1ab85e18ed0e337ce124dc71d6d7b5fd7] string: Add Kunit tests for strcat() family
git bisect bad 3bf301e1ab85e18ed0e337ce124dc71d6d7b5fd7
# bad: [ead62aa370a81c4fb42a44c4edeafe13e0a3a703] fortify: strscpy: Fix flipped q and p docstring typo
git bisect bad ead62aa370a81c4fb42a44c4edeafe13e0a3a703
# bad: [2d47c6956ab3c8b580a59d7704aab3e2a4882b6c] ubsan: Tighten UBSAN_BOUNDS on GCC
git bisect bad 2d47c6956ab3c8b580a59d7704aab3e2a4882b6c
# first bad commit: [2d47c6956ab3c8b580a59d7704aab3e2a4882b6c] ubsan: Tighten UBSAN_BOUNDS on GCC
