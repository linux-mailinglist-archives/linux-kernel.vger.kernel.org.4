Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479EB686081
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjBAHWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjBAHWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:22:03 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3426D47EE3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:22:01 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso1100321pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5amrPi0ca5+SKsqiXkMIYJy52ckgRLFOkHmllRTMEz4=;
        b=Q0SV3vi0yfdWEVsqnN0zDmQo0EqKcPcbjpnwBu7G8rkbhnKeB5L8Zy0a4qTYl+jy54
         1YlMEDXgguElT4cm4nASqmJlJmkDLqu1Eu1mL0EMn3j1eTIGqQ04FjTkQoBo3HxnqktG
         61qm5u2YR/8UeFNj9D3m79aBcQ68mYiaNLy+ICfKsa2L7n+Ow7shCvvwV7wtp+wPZq5d
         ueg9x3D441DtzleYbD+vdjdcTT17Mto5dnGWyTYmNCf+qzje5HLkTx3M3j5pwZohfroK
         Iu77QFDfAHshw3fH9nH9Uwtqbh8oZpwAuAMqg4PnOcReP7Vhr7P14WU9xZnWVKJuAF+m
         XFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:date:message-id
         :subject:references:in-reply-to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5amrPi0ca5+SKsqiXkMIYJy52ckgRLFOkHmllRTMEz4=;
        b=kmb3ABPbakwok1IdUuEwMCmtLowUGQjHZvGGK84VZX/EXvTB/pLiezyTDS8aADdWH2
         QeMRzOJE57LcQ2TaqRPcNsgtftN1he77kCe/7/0SwFSr6lCjmNIG9/p6ilSAvfHtNYiQ
         XhQkjHb330YYQRyUfCSZXpzNZEI5NFYhIBSyt8Fsz3pBk6Dx9x5xmO9SfxASyYZjwVeE
         CKFCg9nfg5FMOBV2ORpI0TRuYxSpW1ix5YBVPJfnk1AjHep9iYKjx2HuvtKXtA4WEdgG
         lbxG+DxFp3AxikONfxQuy9EahdQBnC7s9O3R7xMl8/3RNNR4ZHOinpgxwg491cLMRBBw
         JPBg==
X-Gm-Message-State: AO0yUKULvTclZ+tlCwDlAPEWTJNPWDFrG82EWyAunlEKHqxQ8/NQVuxt
        fCuIRNFTUqkmf3DV9U15M8D68iUZIt0o6lVD
X-Google-Smtp-Source: AK7set+D19QyrJ75BJrk8CMPqFyIqHg9JpGbBw3I2Vn2h8oPRlQqxPpLGNaXfJvt5COJS+yO2SuHBw==
X-Received: by 2002:a05:6a20:840c:b0:bc:7371:e3d1 with SMTP id c12-20020a056a20840c00b000bc7371e3d1mr1804825pzd.45.1675236120262;
        Tue, 31 Jan 2023 23:22:00 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id p4-20020aa78604000000b00592de256f2csm9370789pfn.145.2023.01.31.23.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 23:21:59 -0800 (PST)
In-Reply-To: <20220922060958.44203-1-samuel@sholland.org>
References: <20220922060958.44203-1-samuel@sholland.org>
Subject: Re: [PATCH] riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y
Message-Id: <167523607081.29266.3967297527966644183.b4-ty@rivosinc.com>
Date:   Tue, 31 Jan 2023 23:21:10 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-e660e
Cc:     linux-kernel@vger.kernel.org, Dao Lu <daolu@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>, Guo Ren <guoren@kernel.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 01:09:58 -0500, Samuel Holland wrote:
> commit 8eb060e10185 ("arch/riscv: add Zihintpause support") broke
> building with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled (gcc 11.1.0):
> 
>   CC      arch/riscv/kernel/vdso/vgettimeofday.o
> In file included from <command-line>:
> ./arch/riscv/include/asm/jump_label.h: In function 'cpu_relax':
> ././include/linux/compiler_types.h:285:33: warning: 'asm' operand 0 probably does not match constraints
>   285 | #define asm_volatile_goto(x...) asm goto(x)
>       |                                 ^~~
> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro 'asm_volatile_goto'
>    41 |         asm_volatile_goto(
>       |         ^~~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:285:33: error: impossible constraint in 'asm'
>   285 | #define asm_volatile_goto(x...) asm goto(x)
>       |                                 ^~~
> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro 'asm_volatile_goto'
>    41 |         asm_volatile_goto(
>       |         ^~~~~~~~~~~~~~~~~
> make[1]: *** [scripts/Makefile.build:249: arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
> make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
> 
> [...]

Applied, thanks!

[1/1] riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y
      https://git.kernel.org/palmer/c/3c349eacc559

Best regards,
-- 
Palmer Dabbelt <palmer@rivosinc.com>
