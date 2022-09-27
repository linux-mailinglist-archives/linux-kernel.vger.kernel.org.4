Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D58C5EB969
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiI0FDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiI0FDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:03:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06298A4B36
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 22:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84D2BB8160E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B9AC433C1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664254994;
        bh=Jt1l+ur8owCZNiwKZzkzl+bfr1wPLucqAu5BcgfoKHg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VqooohJpWsmp9T0yAMgRfKNhQgNMildZLFNzSZBMp8sEoU/+P10eS8Z+WYpwOG6Xu
         lAYOt3ftHPLlTN1aF8Ja/ZBf5GXjnX9dV0JhA/RalpeoiFItESPgb13sbnvo0467C1
         Mhnkv7d+u8EOsTMIeg2bYRax0Qb5l3RXUHhzw044GxTomY8rGqvq7Z/seOEiaKDMN+
         5Vi5KN/8MuAxqWU0zRct+I2Ocyrq8r1KwBwGr4HKU0y9r4IPIgZvaafSaHDtpUbElu
         N8xSaXRtZyHe6/n+GTLaEe/NuN8/dlRVw+hrXSNeikoL/YTYa7/k4zkmw6FOol++R7
         KrDV0LggSs1kw==
Received: by mail-vs1-f41.google.com with SMTP id k2so8596515vsk.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 22:03:14 -0700 (PDT)
X-Gm-Message-State: ACrzQf2NcbHRIAwRPs9NBBXHmY9795MLxESMiKdTF4o3kXrvsHBCL3WJ
        vGJOMFDOY2NM4HPEg/kUTXxrCQXnLkdwz7hwuYU=
X-Google-Smtp-Source: AMsMyM5z4O33bMpiughscS5oPJRSCkVN84Wq4J5UOo9i92KMKuSDDYODXKgEp4DQ3Y5fibeF3nGDbQ+54+F/JRh8t7I=
X-Received: by 2002:a05:6102:1481:b0:39a:67f5:3096 with SMTP id
 d1-20020a056102148100b0039a67f53096mr9795505vsv.70.1664254993281; Mon, 26 Sep
 2022 22:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220926122727.2310118-1-yijun@loongson.cn> <CAJF2gTQR804AwU0up2-FyTciQZJY2M9xQ7JbiqjwMbkD=aLhCQ@mail.gmail.com>
 <5bf565a4-5bc4-42f8-59c0-8b908a9c2ab6@loongson.cn>
In-Reply-To: <5bf565a4-5bc4-42f8-59c0-8b908a9c2ab6@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 27 Sep 2022 13:03:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5oVTpGiW6T8dMSiGVe8KtAtUt2Q2sb5nEwc9PUJyqUnw@mail.gmail.com>
Message-ID: <CAAhV-H5oVTpGiW6T8dMSiGVe8KtAtUt2Q2sb5nEwc9PUJyqUnw@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch: Fixup do_ri csr_era
To:     Jun Yi <yijun@loongson.cn>
Cc:     Guo Ren <guoren@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Qing Zhang <zhangqing@loongson.cn>,
        Mao Bibo <maobibo@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

I clean up do_ri() further based on this patch [1], thanks.

[1] https://lore.kernel.org/loongarch/20220927045820.2770062-1-chenhuacai@loongson.cn/T/#u


On Tue, Sep 27, 2022 at 11:10 AM Jun Yi <yijun@loongson.cn> wrote:
>
> do_ri is porting from mips, mipsr6 use do_ri to emulate some fp
> instructions, but Loongarch do not need to emulate these instructions.
>
> And the regs->csr_era be always recovered to ths old_era =
> regs->csr_era, so the compute_return_era is useless.
>
> On 9/27/22 07:41, Guo Ren wrote:
> > On Mon, Sep 26, 2022 at 8:27 PM Jun Yi <yijun@loongson.cn> wrote:
> >>
> >> csr_era of pt_regs in do_ri should not add 4 to point to the
> >> next instruction.
> > The comment does not make sense. I think it wants to skip some
> > instructions, but your patch broke that.
> >
> >>
> >> Signed-off-by: Jun Yi <yijun@loongson.cn>
> >> ---
> >>   arch/loongarch/kernel/traps.c | 2 --
> >>   1 file changed, 2 deletions(-)
> >>
> >> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> >> index aa1c95aaf595..ec888eda3d45 100644
> >> --- a/arch/loongarch/kernel/traps.c
> >> +++ b/arch/loongarch/kernel/traps.c
> >> @@ -477,8 +477,6 @@ asmlinkage void noinstr do_ri(struct pt_regs *regs)
> >>
> >>          die_if_kernel("Reserved instruction in kernel code", regs);
> >>
> >> -       compute_return_era(regs);
> >> -
> >>          if (unlikely(get_user(opcode, era) < 0)) {
> >>                  status = SIGSEGV;
> >>                  current->thread.error_code = 1;
> >> --
> >> 2.31.1
> >>
> >
> >
>
