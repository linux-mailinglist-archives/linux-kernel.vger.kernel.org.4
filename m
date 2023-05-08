Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985956FA02B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjEHGws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjEHGwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:52:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572DD11628;
        Sun,  7 May 2023 23:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9EEB61F3A;
        Mon,  8 May 2023 06:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B12C433A1;
        Mon,  8 May 2023 06:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683528763;
        bh=ZE6Vr9Yajp3snKfRb/T4DJi7T/W3uvjeYiZ1cxbbIQ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hs/uQexpO/8RkhQ8GVASe16K5oogngtqWb4hWHGsYN+phIhOYKsxuEyHuOVWH8dqq
         s/ycLF9sGenZ526Kv7dFj2xUkEvU1/sAoaThocwUfx64gipZijsklWVrgLo72kfKBQ
         h5V551044EuiZ2nA1xveZU1dtjwIBRiseKdLIOdeY04gb1ZkMcflkaTqCfU75TIQh6
         jD3DqwZv4Zgg/tZssm8y7r8QYvu6pDhZEmy8lGmDpaSwZrN3X7/1DipxA004TyGs2C
         VpH4n3+VYflmI7qStjblaHRawAOhN+lZ4EtvO14IDz7r+O5seIIGF3Bea1ze+HmySL
         HfszT9KBNABBA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-965ac4dd11bso833864566b.2;
        Sun, 07 May 2023 23:52:43 -0700 (PDT)
X-Gm-Message-State: AC+VfDwqaXAaU9vghMopTBYMdIpQMQhNSqmH89QoyRyD/G+5q//kgcrO
        HuILqeExyYl/7KfZdMsADcaRT/i9fiTb+61KQTU=
X-Google-Smtp-Source: ACHHUZ6Y6grqgRLTUhlimPBKynh9DnHZoR/6MpPmj9ylOios2EVUGTDYz+S0kva/uFN5mGCt7yUrdJztk28ZabD8yiM=
X-Received: by 2002:a17:907:5c6:b0:94e:e293:cf34 with SMTP id
 wg6-20020a17090705c600b0094ee293cf34mr8100801ejb.6.1683528761470; Sun, 07 May
 2023 23:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230507182304.2934-1-jszhang@kernel.org> <20230507182304.2934-2-jszhang@kernel.org>
In-Reply-To: <20230507182304.2934-2-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 8 May 2023 14:52:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTni=G5FP80rSArErXGWQatR1P8rCy9nNOggeA4vtXftQ@mail.gmail.com>
Message-ID: <CAJF2gTTni=G5FP80rSArErXGWQatR1P8rCy9nNOggeA4vtXftQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] irqchip/sifive-plic: Support T-HEAD's C910 PLIC
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
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

On Mon, May 8, 2023 at 2:34=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> w=
rote:
>
> The T-HEAD's C910 PLIC still needs the delegation bit settingto allow
> access from S-mode, but it doesn't need the edge quirk.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 4 ++++
>  drivers/irqchip/irq-sifive-plic.c                             | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifiv=
e,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> index f75736a061af..64b43a3c3748 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> @@ -62,6 +62,10 @@ properties:
>                - starfive,jh7110-plic
>                - canaan,k210-plic
>            - const: sifive,plic-1.0.0
> +      - items:
> +          - enum:
> +              - thead,light-plic
> +          - const: thead,c910-plic
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-plic
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifi=
ve-plic.c
> index e1484905b7bd..71afa2a584d9 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -569,6 +569,7 @@ static int __init plic_init(struct device_node *node,
>  }
>
>  IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
> +IRQCHIP_DECLARE(thead_c910_plic, "thead,c910-plic", plic_init);
>  IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy sy=
stems */
>
>  static int __init plic_edge_init(struct device_node *node,
> --
> 2.40.0
>
opensbi needs thead,c900-plic, and we could put multi compatible name
in the dts. So, it's no need here.

Another question, Could we change the name of Sifive to RISC-V when
"cat /proc/interrupts" ?

diff --git a/drivers/irqchip/irq-sifive-plic.c
b/drivers/irqchip/irq-sifive-plic.c
index ff47bd0dec45..b5844d784bfa 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -177,7 +177,7 @@ static int plic_set_affinity(struct irq_data *d,
 #endif

 static struct irq_chip plic_edge_chip =3D {
-       .name           =3D "SiFive PLIC",
+       .name           =3D "RISC-V PLIC",
        .irq_enable     =3D plic_irq_enable,
        .irq_disable    =3D plic_irq_disable,
        .irq_ack        =3D plic_irq_eoi,
@@ -192,7 +192,7 @@ static struct irq_chip plic_edge_chip =3D {
 };

 static struct irq_chip plic_chip =3D {
-       .name           =3D "SiFive PLIC",
+       .name           =3D "RISC-V PLIC",
        .irq_enable     =3D plic_irq_enable,
        .irq_disable    =3D plic_irq_disable,
        .irq_mask       =3D plic_irq_mask,

--=20
Best Regards
 Guo Ren
