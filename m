Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB35A74F2F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjGKPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGKPGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:06:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A7A10D2;
        Tue, 11 Jul 2023 08:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37E3461529;
        Tue, 11 Jul 2023 15:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9569DC433C7;
        Tue, 11 Jul 2023 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689088009;
        bh=kZIeBvNcC0nOtzMWF800gLz1bn5znzCQrdohaF8tsvc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LrF6V7Vvgxw9nV4mmthPSEIQirtGB3yxNKRuQ0aEGrIB69Reaj8zk77jgJ6cYZ7ta
         gc8qwDFYulhYV7Woi5zGl8ecXZGmtHOtY6cyvnwhhQw9gZA2Wzol4XnAVkE//IykgS
         EOud/K9zjpNkyljQvll0KmseIx32s2VNHrTa7x6f7cZCwCln4ZnntcK/UNuejkFt8+
         GmPEtkDQey2BcKM0y5yIgzomKtDUQhQC/VGn8nzyt8Q4dZCrsKcARbslbLaH90rxZv
         qP4zAZOtCy1wWjfVFHLqXnJKbbdwuoKDi034fNBrtQylQyD4e31MAApLXPihDfS8h7
         clSs1BYbKOC/g==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so9398715e87.3;
        Tue, 11 Jul 2023 08:06:49 -0700 (PDT)
X-Gm-Message-State: ABy/qLZJc1aWy2XnucMjwFbF//fv1AJmCl4aI8DS/w5EXknK5GydqPll
        iXzyUkoSH3xT+0TtSN4Zy7NIEqB78UR5zj3oPu8=
X-Google-Smtp-Source: APBJJlGrLT89LzutG3S3N9QOzesfJED07ndmWdSZdToL3jggMkVPoM7Sq9DyqiEv1VteQSrNQMJLa07qvnGiWqJRW0k=
X-Received: by 2002:ac2:58cf:0:b0:4f7:69b9:fa07 with SMTP id
 u15-20020ac258cf000000b004f769b9fa07mr12515921lfo.45.1689088007614; Tue, 11
 Jul 2023 08:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230711120807.1805186-1-maobibo@loongson.cn> <20230711120807.1805186-2-maobibo@loongson.cn>
In-Reply-To: <20230711120807.1805186-2-maobibo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 11 Jul 2023 23:06:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5k-FVhrRAQj58dckQAGPT9PNp2ghCCfHOMtsr3gf-wRw@mail.gmail.com>
Message-ID: <CAAhV-H5k-FVhrRAQj58dckQAGPT9PNp2ghCCfHOMtsr3gf-wRw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] irqchip/loongson-eiointc: Fix return value
 checking of eiointc_index
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
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

On Tue, Jul 11, 2023 at 8:08=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> Return value of function eiointc_index is int, however it is converted
> into uint32_t and then compared smaller than zero. This causes logic
> problem. There is eioint initialization problem on qemu virt-machine
> where there is only one eioint node and more than 4 vcpus. Nodemap of
> eioint is 1, and external device intr can only be routed to vcpu 0-3, the
> other vcpus can not response any external device interrupts and only loca=
l
> processor interrupts like ipi/timer can work.
I'm sorry but there are still spelling problems...
"eio", "eio intc", "eioint" should all be "eiointc".

Huacai

>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  drivers/irqchip/irq-loongson-eiointc.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq=
-loongson-eiointc.c
> index 92d8aa28bdf5..1c5a5b59f199 100644
> --- a/drivers/irqchip/irq-loongson-eiointc.c
> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> @@ -144,12 +144,14 @@ static int eiointc_router_init(unsigned int cpu)
>         int i, bit;
>         uint32_t data;
>         uint32_t node =3D cpu_to_eio_node(cpu);
> -       uint32_t index =3D eiointc_index(node);
> +       int index =3D eiointc_index(node);
>
> -       if (index < 0) {
> -               pr_err("Error: invalid nodemap!\n");
> -               return -1;
> -       }
> +       /*
> +        * qemu virt-machine has only one eio intc and more than four cpu=
s
> +        * irq from eio can only be routed to cpu 0-3 on virt machine
> +        */
> +       if (index < 0)
> +               return 0;
>
>         if ((cpu_logical_map(cpu) % CORES_PER_EIO_NODE) =3D=3D 0) {
>                 eiointc_enable();
> --
> 2.27.0
>
