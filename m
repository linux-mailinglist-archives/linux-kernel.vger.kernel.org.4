Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D657E70A676
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 10:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjETIn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 04:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjETIny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 04:43:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36E4AB
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 01:43:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43A3A610D5
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 08:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31B9C4339C
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 08:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684572232;
        bh=q8wzoly7YJd3wL9q5vpF3c1DGI0d06QhOhge2JVJV5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ijwwa9nw0pjTSuZ7q/bshHkMKD5QlO5fINK6ccVvDAjoWCNALzzCD/XYxT8NR/f/l
         D52pipde/es6WfhZqeA3/i0U6WK94+1Fzqdi+Jo1QQBxSnMW6oMqmc89g6UU9XQWE3
         LRwf1zqujrnLyu9o+ni1TBNhclvAtyU/B4DBs9xrdhjYA7zx2xfu36We+a+chVKzGT
         piWQoAmEM8RqOavzbz3GclquTdAU7fvI7BZ/jNUH5XgtJ5keJnv/A2Gxt+sHkJyjza
         fqrknfT+Cmr4euWcx60uVv1Vjv0tPrUMFISo5ZmuefW/I2lrOhKWgm/qU9ZPqb9jkC
         sSgZ4LkR79hfw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-510d8b0169fso5489206a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 01:43:52 -0700 (PDT)
X-Gm-Message-State: AC+VfDyBNi2rm6cQEsEeYEkxnBnvEqxqcBwDU9q8tkuKLEdrZ1CtD+YM
        m0kttXlUslaAOEpZfAs5dFoYmra0X3qbTKz6vCQ=
X-Google-Smtp-Source: ACHHUZ7TLDwGUzb3p7e39xGVbwmazSAUUSI8aJJ1deVvVbH905mq/y8n8yEbYhWccb49zSY4Cd0hDP2vFe1tWYsTO2Q=
X-Received: by 2002:a17:907:94ca:b0:94a:44ef:853d with SMTP id
 dn10-20020a17090794ca00b0094a44ef853dmr4504939ejc.68.1684572230928; Sat, 20
 May 2023 01:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230520063818.27208-1-lvjianmin@loongson.cn> <20230520063818.27208-5-lvjianmin@loongson.cn>
In-Reply-To: <20230520063818.27208-5-lvjianmin@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 20 May 2023 16:43:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6BBCXpF2uOehwz1gsMdb6vcjHsCYsp+soL+Tzy-bfxQg@mail.gmail.com>
Message-ID: <CAAhV-H6BBCXpF2uOehwz1gsMdb6vcjHsCYsp+soL+Tzy-bfxQg@mail.gmail.com>
Subject: Re: [PATCH V1 4/4] irqchip/loongson-liointc: Add IRQCHIP_SKIP_SET_WAKE
 flag
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
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

Hi, Jianmin,

On Sat, May 20, 2023 at 2:38=E2=80=AFPM Jianmin Lv <lvjianmin@loongson.cn> =
wrote:
>
> From: Yinbo Zhu <zhuyinbo@loongson.cn>
>
> Liointc doesn't require specific logic to work with wakeup IRQs,
> and no irq_set_wake callback is needed. To allow registered IRQs
> from liointc to be used as a wakeup-source, and ensure irq_set_irq_wake()
> works well, the flag IRQCHIP_SKIP_SET_WAKE should be added.
Maybe using LIOINTC instead of Liointc/liointc is better in commit
message. Except this small issue, for the whole series,
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> ---
>  drivers/irqchip/irq-loongson-liointc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq=
-loongson-liointc.c
> index 9a9c2bf048a3..dbd1ccce0fb2 100644
> --- a/drivers/irqchip/irq-loongson-liointc.c
> +++ b/drivers/irqchip/irq-loongson-liointc.c
> @@ -291,6 +291,7 @@ static int liointc_init(phys_addr_t addr, unsigned lo=
ng size, int revision,
>         ct->chip.irq_mask =3D irq_gc_mask_disable_reg;
>         ct->chip.irq_mask_ack =3D irq_gc_mask_disable_reg;
>         ct->chip.irq_set_type =3D liointc_set_type;
> +       ct->chip.flags =3D IRQCHIP_SKIP_SET_WAKE;
>
>         gc->mask_cache =3D 0;
>         priv->gc =3D gc;
> --
> 2.31.1
>
>
