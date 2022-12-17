Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDF764F6F3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 03:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiLQCJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 21:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLQCJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 21:09:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF3627CE7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 18:09:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3199EB81E78
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 02:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8ADC433F0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 02:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671242946;
        bh=2c/K1FLzSlsGs90CqSv0s2cU3Pb0DF8Hg/Ru7aZ4sws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a2pVefvnYxx0QNpWstRNpARXRHN6NMoz6pP5QSaqjTxijI5eFakPGLWTPrTtga0qg
         04e2MCbO7mE85N/NOiZbmTwrS9jXI+VehwJ6236EzMf5PbTBhBZsOI4AXAAfRY1UUZ
         44X3I2PPvbWhIjE4rv4lcTutNLCiU/KGHf3EvjWkS9zL7UGjYFoTfbGxrTHTL19Rbm
         9K6xxn33Pnx8YoX8GOjd5bGQ8+mu7Qsn3I5yLoxEjdwBNZXYYMv69e+zmLJgReDj9C
         Nax4HPIfO8skdMihZ1xz2NLCkpJPwbOjgrk/3QAljv/w130WQ1PgReuL8XYCAvIWnv
         eStkkzwztimLg==
Received: by mail-ej1-f50.google.com with SMTP id t17so10174884eju.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 18:09:06 -0800 (PST)
X-Gm-Message-State: ANoB5pm5GiuelcrweCMRxfniPVuqq2L415eNi9zk6ddqp75NSymVRKG1
        HjpsBabbzeqTNjQ6U4l29utVkx3ycJWGWIZ6gUI=
X-Google-Smtp-Source: AA0mqf4OfUQSE65JBf8FffwSX+G3LU2TbpfljIUaWnEIHAZ5lG1kU+oGREB/az6hVjvhiB65DZBgf80eGJzKxtZ7Qmw=
X-Received: by 2002:a17:907:37a:b0:7c0:e4b6:132e with SMTP id
 rs26-20020a170907037a00b007c0e4b6132emr19078943ejb.224.1671242945036; Fri, 16
 Dec 2022 18:09:05 -0800 (PST)
MIME-Version: 1.0
References: <1670575981-14389-1-git-send-email-yangtiezhu@loongson.cn>
 <1670575981-14389-3-git-send-email-yangtiezhu@loongson.cn>
 <20221214162847.1f9481fd2cf5212657a0fd58@kernel.org> <0a135b50-ca96-8ee1-6f33-29efcdb256ed@loongson.cn>
In-Reply-To: <0a135b50-ca96-8ee1-6f33-29efcdb256ed@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 17 Dec 2022 10:08:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6LrhiYPtjeiTOp6fT4pdo8j-KvtRXjvSjeGtsbF4FY=A@mail.gmail.com>
Message-ID: <CAAhV-H6LrhiYPtjeiTOp6fT4pdo8j-KvtRXjvSjeGtsbF4FY=A@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] LoongArch: Add kprobe support
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
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

Hi, all,

This series seems have too many problems, so I will drop it. So Tiezhu
please export the latest patches from
https://github.com/loongson/linux/commits/loongarch-next, and do
modifications on top of them.

Huacai

On Fri, Dec 16, 2022 at 5:33 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>
>
> On 12/14/2022 03:28 PM, Masami Hiramatsu (Google) wrote:
> > Hi,
> >
> > On Fri,  9 Dec 2022 16:52:59 +0800
> > Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >
> >> Kprobes allows you to trap at almost any kernel address and
> >> execute a callback function, this commit adds kprobe support
> >> for LoongArch.
>
> ...
>
> >> +    case KPROBE_HIT_ACTIVE:
> >> +    case KPROBE_HIT_SSDONE:
> >
> > Recently, I removed these cases because this page fault will be finally
> > handled by the generic pagefault handler.
> >
>
> Hi Masami,
>
> I have addressed all your comments on my local machine, the code logic
> looks much more clear now, thank you very much.
>
> When I test kprobe_example.ko with a C function like "kernel_clone",
> it works well, but the kernel hangs [1] when test with an assembler
> function like "__memset_fast" [2].
>
> Just did some quick research and it seems the bug is related with
> kallsyms_lookup_name(), I'm looking for a solution.
>
> [1]
> https://lore.kernel.org/loongarch/CAEr6+EC2wPAtK8zb3=e1mUiya3gv0UhqF9J_ySYx9p_96pB+tg@mail.gmail.com/
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/tree/arch/loongarch/lib/memset.S?h=loongarch-next#n56
>
> Thanks,
> Tiezhu
>
>
