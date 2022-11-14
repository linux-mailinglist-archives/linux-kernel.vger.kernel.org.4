Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD91627550
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 05:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiKNEcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 23:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbiKNEcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 23:32:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2694364C0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:32:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A56460E0B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BE5C433D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668400325;
        bh=EbegW7e7iQHObSeYBPdv3EstAC7CXPC2Nu8Y64xLSrs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bQ+kvjq7Lbc2Xr2dbJykl+/kSOp4/sxQd8iiCcBfA4XVOf3NIvyO2dNvVYB+/AsZk
         RcpM1vluQAMcbsrGRo0+ARRvDhKqZ9IXMEvYCkODixkCsYoXDq6qtP5dpG8HPLCSqo
         xoaQ+GG2/q9SnAR0ILC+VN+8kqOpCeRF2wKH9pXd248dxxke564W7a5BkE/Ohqn8rz
         6rovxzZYX6lt3SMOiIlWjAYrUZCUz7xSYijY+q1nX6C8VgQBDJHcJ0MZYu73YxiMv2
         t3C0XXnZbhS6mslGjKcN3LmKEUMN3Q9j0h16ap9qBLY/7Qg/2EiEwyjaPeZdKDcgoT
         B79uLgR3916cA==
Received: by mail-ej1-f42.google.com with SMTP id f27so25564176eje.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:32:05 -0800 (PST)
X-Gm-Message-State: ANoB5plLZOHvMFk236qDUJ4VCs72w7WVTV73Dwskouqb/ag9yUWyMloW
        SvvIgQ1jqLJiiWWn8NmNWrAYuo3BUawfA/UkOO8=
X-Google-Smtp-Source: AA0mqf5mcW5etmwY+P5oEpsUpHexU3+Y/WyhcfZzap1uWYoO5Y2h2or0GzoGKIGMQkpZGfFAQvRmEZJcP9DKyF5x+CE=
X-Received: by 2002:a17:906:a20c:b0:7ae:27a7:2a66 with SMTP id
 r12-20020a170906a20c00b007ae27a72a66mr9181411ejy.72.1668400323862; Sun, 13
 Nov 2022 20:32:03 -0800 (PST)
MIME-Version: 1.0
References: <1664326209-13995-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1664326209-13995-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 14 Nov 2022 12:31:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H47oPC6mYkeDh7NfmvL2jAHO32ugM-PK2mmFY6XdqF8_Q@mail.gmail.com>
Message-ID: <CAAhV-H47oPC6mYkeDh7NfmvL2jAHO32ugM-PK2mmFY6XdqF8_Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add kprobe and kretprobe support for LoongArch
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu,

Thanks for your patches, however,
1, You should rebase your code, since some functions such as
is_pc_insn is provided in the github's loongarch-next branch;
2, Your code may have some problems about preemption, you can do
something like this commit [1];
3, I don't think Kprobe should be enabled by default, distribution
configs can enable it if needed.

[1] https://github.com/loongson/linux/commit/023d5412ab5c154b87d57d70d465a4243df53717

Huacai

On Wed, Sep 28, 2022 at 8:50 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> v2:
>   -- Split simu_branch() and simu_pc() into a single patch
>   -- Call kprobe_page_fault() in do_page_fault()
>   -- Add kprobes_trampoline.S for kretprobe
>
> Tiezhu Yang (5):
>   LoongArch: Simulate branch and PC instructions
>   LoongArch: Add kprobe support
>   LoongArch: Add kretprobe support
>   samples/kprobes: Add LoongArch support
>   LoongArch: Enable KPROBES in default config
>
>  arch/loongarch/Kconfig                     |   2 +
>  arch/loongarch/configs/loongson3_defconfig |   1 +
>  arch/loongarch/include/asm/inst.h          |  31 +++
>  arch/loongarch/include/asm/kprobes.h       |  44 ++++
>  arch/loongarch/include/asm/ptrace.h        |   1 +
>  arch/loongarch/kernel/Makefile             |   2 +
>  arch/loongarch/kernel/inst.c               | 113 ++++++++++
>  arch/loongarch/kernel/kprobes.c            | 336 +++++++++++++++++++++++++++++
>  arch/loongarch/kernel/kprobes_trampoline.S |  97 +++++++++
>  arch/loongarch/mm/fault.c                  |   3 +
>  samples/kprobes/kprobe_example.c           |   8 +
>  11 files changed, 638 insertions(+)
>  create mode 100644 arch/loongarch/include/asm/kprobes.h
>  create mode 100644 arch/loongarch/kernel/kprobes.c
>  create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S
>
> --
> 2.1.0
>
