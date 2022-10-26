Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8F360E291
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbiJZNt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiJZNtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:49:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B3B105CCA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:48:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso3731616pjn.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKFRv0zM9kMluPQ3+hHI7EIzkLtxGEc8lwOlSBqM7+8=;
        b=RPvo9GZ9F6TwIw7A0fjA6QSO9W3jcPv50/4lWroYKxeuCqonf/4q/oMdH6lzyQjbkR
         lcnpvxPLCNsCxJgGc34bD7+VVsaPhHFSMd26Go+hj1TtvQFd4s6yxPzn0BK8PUGFAFVj
         rrDI/HWdcXi90GzguqjpqrQsWonoNZR4iLg0m0IypxjIPcoRig5a2Sb1XFSBxMZ5EaW8
         KqIajKKdXwH8UhjdkhHpocjl8bOAMvozKyOozJ3U0Ux8rh8BlK5WRraxays1gWVtFnCt
         GvkCrX2lsF+ctvRabev0+wy3UJlze/MesBoJ2zpUb03SVjHKFRruOD3qHhLA1Ej/L+Rv
         NzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKFRv0zM9kMluPQ3+hHI7EIzkLtxGEc8lwOlSBqM7+8=;
        b=7LJVF87rHSmqT51oApw08Tlh6yir7MJvFCpAahzz1VHupSSCk/zbco2SWqA7xxAdLW
         CbD4LYL8y5LT4/v5OruAq9WLqaIcc12c+V2KXFXP/fxSKMb+AkNbb2RM7DeORLp1k3Qf
         5SkgmwSrDu34m4C+asoRkSK/HZcKZ01QOL5+QH+O87xgSb2fbMA3U0BE9RogR0hon5/R
         k4xKWIuljTO67vybhmAppdZC7v+05ItU+ixU6vZxBtaFYFjJTcYz87NydMB93U2npofH
         /ue4PB6PKPclVCjlu3xyi5wCVNUtK83lc7WiYELpRg+PvJsn9RJBF8t8KYWKMYOo1U3p
         1k7Q==
X-Gm-Message-State: ACrzQf3cmwo/LIQULTLn9zyswKGGekRfgFU4QCRypaEKKXaS1XSjufKl
        UBnubQB1wc5uiLdpSL3kD8cVwidboZRGMw==
X-Google-Smtp-Source: AMsMyM4Iwzkt6Srcrk4gx6gtg+JjdQxqOxgx2b6dNxZl9uzmX1WjFH0HKC1etqmNAoTPp+5pkSjkug==
X-Received: by 2002:a17:903:1207:b0:185:4042:23d2 with SMTP id l7-20020a170903120700b00185404223d2mr43403332plh.143.1666792127247;
        Wed, 26 Oct 2022 06:48:47 -0700 (PDT)
Received: from localhost ([135.180.227.132])
        by smtp.gmail.com with ESMTPSA id i129-20020a639d87000000b0046ae5cfc3d5sm2790473pgd.61.2022.10.26.06.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:48:46 -0700 (PDT)
In-Reply-To: <20221008145437.491-1-jszhang@kernel.org>
References: <20221008145437.491-1-jszhang@kernel.org>
Subject: Re: [PATCH v2] riscv: jump_label: mark arguments as const to satisfy asm constraints
Message-Id: <166679181922.18979.10448305327462266940.b4-ty@rivosinc.com>
Date:   Wed, 26 Oct 2022 06:43:39 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-36ce3
Cc:     linux-riscv@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>, llvm@lists.linux.dev,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Tom Rix <trix@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Oct 2022 22:54:37 +0800, Jisheng Zhang wrote:
> Samuel reported that the static branch usage in cpu_relax() breaks
> building with CONFIG_CC_OPTIMIZE_FOR_SIZE:
> 
> In file included from <command-line>:
> ./arch/riscv/include/asm/jump_label.h: In function 'cpu_relax':
> ././include/linux/compiler_types.h:285:33: warning: 'asm' operand 0
> probably does not match constraints
>   285 | #define asm_volatile_goto(x...) asm goto(x)
>       |                                 ^~~
> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro
> 'asm_volatile_goto'
>    41 |         asm_volatile_goto(
>       |         ^~~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:285:33: error: impossible constraint
> in 'asm'
>   285 | #define asm_volatile_goto(x...) asm goto(x)
>       |                                 ^~~
> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro
> 'asm_volatile_goto'
>    41 |         asm_volatile_goto(
>       |         ^~~~~~~~~~~~~~~~~
> make[1]: *** [scripts/Makefile.build:249:
> arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
> make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
> 
> [...]

Applied, thanks!

[1/1] riscv: jump_label: mark arguments as const to satisfy asm constraints
      commit: 89fd4a1df829187d4d35f6a520cc531de622e6f0

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
