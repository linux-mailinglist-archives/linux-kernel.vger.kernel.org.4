Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FDA7258CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbjFGIzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbjFGIyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:54:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47091BC8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:53:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD53663C81
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8CAC4339B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686127938;
        bh=y+Vn9zbMc2hWJvwt6pYFCnKNfmsXKCru69Eowq/2vyg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SH9hTd6Mbau3Gm7dVYVLFLwMQiv/GoLE0ZAvKr9Q/TvDt6zQC8nbigfjSenZSQFXX
         pWT0daQA/KSxbK7p0Nq8AtbI+VQYDferv3PVPniF+FnD+W0x9oWis4SgJ2R/M6e8SP
         nMk/DpWZBhi75Fbn0kFMXKa9rsfc2camhx33ENqKIv8Pv7iTNLlmONR88jS0Er6qAY
         SKL8cgln01o+B3TeT/xIzVkD23FyAadQd4Kl8lHR6N2ssynhHnFxEIyibjWaenT9cL
         KtA4/zNLsHjbpVAT2CbhD3dcH+4TB79FvRAljxpbVdAUhz/IC7GXokg+Bd0yCLCrW2
         pL7M9ejtSl2pA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9786c67ec32so295015666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:52:18 -0700 (PDT)
X-Gm-Message-State: AC+VfDzNpUTs3DUa6lUvJApf/7bKdh4+yCdvv+9jY9rFpzSymZuunvgY
        XoEH5QscoMIO8Z7WIwc56B8UgDzBdGefRk/gL6g=
X-Google-Smtp-Source: ACHHUZ5rVX7nMf4mLB7xA+YwfztnsjhwjZ0qYq90zgPX5Rh3+cSvm4YXtdA/T/LZHsWx0XT0KdHMco0LugTGHjSSeFw=
X-Received: by 2002:a17:907:6e22:b0:953:37eb:7727 with SMTP id
 sd34-20020a1709076e2200b0095337eb7727mr5584515ejc.43.1686127936329; Wed, 07
 Jun 2023 01:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <1685947150-4949-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1685947150-4949-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 7 Jun 2023 16:52:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5CXX+tVdXj8jpYjeprwFihDJw6O6K5t6dRZPH8bWZ94A@mail.gmail.com>
Message-ID: <CAAhV-H5CXX+tVdXj8jpYjeprwFihDJw6O6K5t6dRZPH8bWZ94A@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add uprobes support for LoongArch
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jeff Xie <xiehuan09@gmail.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jeff,

I queued this series at
https://github.com/chenhuacai/linux/commits/loongarch-next, could you
please test it when you have time? Thanks.

Huacai

On Mon, Jun 5, 2023 at 2:39=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
>
> v5:
>   -- Rebased on 6.4rc5
>   -- Like arm64, add user_enable_single_step() in arch_uprobe_pre_xol(),
>      add user_disable_single_step() in arch_uprobe_{post,abort}_xol(),
>      suggested by Jeff and Huacai offline
>
> v4:
>   -- Rebased on 6.4rc1
>   -- Fix problem about "perf probe -x /lib64/libc.so.6 malloc"
>
> v3:
>   -- Check atomic instructions in insns_not_supported()
>   -- Remove five DIE_* definitions in kdebug.h
>
> v2:
>   -- Move the functions to inst.c in patch #1
>   -- Pass around union for insns_not_supported(),
>      insns_need_simulation() and arch_simulate_insn()
>
> v1:
>   -- Split the RFC patch #2 into two patches
>   -- Use larch_insn_gen_break() to generate break insns
>      for kprobes and uprobes
>   -- Pass around instruction word instead of union for
>      insns_not_supported(), insns_need_simulation() and
>      arch_simulate_insn() to avoid type conversion for callers
>   -- Add a simple test case for uprobes in the commit message
>
> Tiezhu Yang (6):
>   LoongArch: Move three functions from kprobes.c to inst.c
>   LoongArch: Add larch_insn_gen_break() to generate break insns
>   LoongArch: Use larch_insn_gen_break() for kprobes
>   LoongArch: Add uprobes support
>   LoongArch: Check atomic instructions in insns_not_supported()
>   LoongArch: Remove five DIE_* definitions in kdebug.h
>
>  arch/loongarch/Kconfig               |   3 +
>  arch/loongarch/include/asm/inst.h    |  42 ++++++++++
>  arch/loongarch/include/asm/kdebug.h  |   5 --
>  arch/loongarch/include/asm/kprobes.h |   2 +-
>  arch/loongarch/include/asm/uprobes.h |  35 ++++++++
>  arch/loongarch/kernel/Makefile       |   1 +
>  arch/loongarch/kernel/inst.c         |  54 +++++++++++++
>  arch/loongarch/kernel/kprobes.c      |  75 ++++-------------
>  arch/loongarch/kernel/traps.c        |   9 +--
>  arch/loongarch/kernel/uprobes.c      | 152 +++++++++++++++++++++++++++++=
++++++
>  10 files changed, 306 insertions(+), 72 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/uprobes.h
>  create mode 100644 arch/loongarch/kernel/uprobes.c
>
> --
> 2.1.0
>
