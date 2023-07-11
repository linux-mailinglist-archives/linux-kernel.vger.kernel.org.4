Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AAF74E3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjGKB7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGKB7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:59:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF95C94;
        Mon, 10 Jul 2023 18:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42327612C3;
        Tue, 11 Jul 2023 01:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5624C433C9;
        Tue, 11 Jul 2023 01:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689040775;
        bh=5u/NSKIV2nolz0tg2ru2sg4cYcJQKRcGmlJyJGL5omY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kXT/suzvoAQQkKN7xJlF34bmtKt7iWA6wBE17wFwUYm2Gzt8xaOvKrZb00qASTJCo
         SYzgMH3r52Nv03hB4+2bUz2itZP9G/wyrkCKXaTvPz2EZgQhnrdaG1hFFfcoQ5Ycv8
         UCag6ddLjGtut9vcchGSbSocE75t6Qe4AF9T6L4Y+TjcsYvx2sat88MTJO8+58AkaK
         gGK/r5BdAuDOD2tIRhQYtQyAeY6Ff8T5ghexzCrl3Ya3HsAtGikBVtyB1NcDi/Uadn
         dUe91v6m3X+cB8CmaCkJHlol7ghKpPS/ZjXWkyI/ATM55UM80w1yEc2bpWizmJVYaj
         pVRowCBCOIwaA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so11698672a12.1;
        Mon, 10 Jul 2023 18:59:35 -0700 (PDT)
X-Gm-Message-State: ABy/qLb0r3c9R0smT+4C5NHon+fTEE4EBZMQo7OtwY7Cx9PYcn1eavv3
        6OhdLtLr3E7W11S7dJ4BtGGHc8kIyIGzasNrIXE=
X-Google-Smtp-Source: APBJJlFEzMJmBjlLLkJbSvKKv9tRt6H7oqzSwe2lZuADQ+ClJrVB5X98H5QL4GXGDjGR+KTpzaO49hNpz58R7eMCGb0=
X-Received: by 2002:aa7:d7d0:0:b0:51e:65b:bc3b with SMTP id
 e16-20020aa7d7d0000000b0051e065bbc3bmr18581910eds.15.1689040773849; Mon, 10
 Jul 2023 18:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230706022849.1272591-1-maobibo@loongson.cn> <20230706022849.1272591-2-maobibo@loongson.cn>
In-Reply-To: <20230706022849.1272591-2-maobibo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 11 Jul 2023 09:59:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4uQEDPRb0Kj8aqth9U7-7fa50Cj8=Off4+wk+CFhM1HQ@mail.gmail.com>
Message-ID: <CAAhV-H4uQEDPRb0Kj8aqth9U7-7fa50Cj8=Off4+wk+CFhM1HQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] irqchip/loongson-eiointc: Fix return value
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

On Thu, Jul 6, 2023 at 10:28=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> return value of function eiointc_index is int, however it is
'return' -> 'Return'.

> converted uint32_t when used. This causes logic problem when
> checking return value. There is eioi initial problem on qemu
'eioi' -> 'eiointc'.

Huacai

> virt-machine where there is only one eioi node and more than 4
> vcpus, external device intr can only be routed to vcpu 0-3.

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
