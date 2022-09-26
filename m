Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9E95EB5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIZXlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiIZXlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:41:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6E93AB30
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:41:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A13A6B816E9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 23:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47498C433D7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 23:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664235689;
        bh=6wNqUX/iaj9uUsoDs1oH5DIKGHbHydMuzqQ6tFjrpzo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VRN5faFCTQRla4ho117TzoULktAE1emcXRD3+rTh9X8wHEA8ao+FkmkGcdhybEjab
         o5KJoO4BaUKaWZE3QN9YH7rIG1ZTOz8pUonYvn7fCvB/EYcs2WEGJfb3eYJ3KedoY3
         xdOJSFOnwCFz+dWbPrL/oFfm5e+mMU5DWRURd+48blW5hgG21mtRbRQIRAQ5/g2xWD
         YQIgpOCKBQXVXKPeMDRUxTtSUBOPpFRjW3D33Ak+GVYnArCmXDrinUxitD664wMSNO
         PBd0RdccXzbl1n9b1Ig05Tk2bklG5xdKEUOxh50q+MPG8+t0K/HQTsoDPpyWIiHhj2
         74x6rOaUom2jw==
Received: by mail-ot1-f42.google.com with SMTP id e24-20020a05683013d800b0065be336b8feso5436751otq.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:41:29 -0700 (PDT)
X-Gm-Message-State: ACrzQf1SBvY3KBqeY9+F9VXEDJmfhIXaj9+QWC77o+vTsJqZWtW4HXir
        zqhGRErC5+1OL/rz0fStzo7W3k+IiWmoaZXUxdc=
X-Google-Smtp-Source: AMsMyM6zFzxM3eN6t+1iO53bYPjOeh6NQ+Kjjm6uWtTDyY/6Beq6d0f5Vr/fEwB0lAQL9VRbhWTpDdJZfmUed7ItXL8=
X-Received: by 2002:a05:6830:34a4:b0:65a:b03:54cc with SMTP id
 c36-20020a05683034a400b0065a0b0354ccmr10832187otu.140.1664235688429; Mon, 26
 Sep 2022 16:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220926122727.2310118-1-yijun@loongson.cn>
In-Reply-To: <20220926122727.2310118-1-yijun@loongson.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 27 Sep 2022 07:41:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQR804AwU0up2-FyTciQZJY2M9xQ7JbiqjwMbkD=aLhCQ@mail.gmail.com>
Message-ID: <CAJF2gTQR804AwU0up2-FyTciQZJY2M9xQ7JbiqjwMbkD=aLhCQ@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch: Fixup do_ri csr_era
To:     Jun Yi <yijun@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
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

On Mon, Sep 26, 2022 at 8:27 PM Jun Yi <yijun@loongson.cn> wrote:
>
> csr_era of pt_regs in do_ri should not add 4 to point to the
> next instruction.
The comment does not make sense. I think it wants to skip some
instructions, but your patch broke that.

>
> Signed-off-by: Jun Yi <yijun@loongson.cn>
> ---
>  arch/loongarch/kernel/traps.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> index aa1c95aaf595..ec888eda3d45 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -477,8 +477,6 @@ asmlinkage void noinstr do_ri(struct pt_regs *regs)
>
>         die_if_kernel("Reserved instruction in kernel code", regs);
>
> -       compute_return_era(regs);
> -
>         if (unlikely(get_user(opcode, era) < 0)) {
>                 status = SIGSEGV;
>                 current->thread.error_code = 1;
> --
> 2.31.1
>


-- 
Best Regards
 Guo Ren
