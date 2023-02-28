Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FE16A63B0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjB1XLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjB1XL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:11:29 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0023D12064
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 15:11:27 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id o6so17402367vsq.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 15:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wd8Jz8eN+KAQgwsdPXLtOcLkWzE6Ah0rN7veq16jhGM=;
        b=dD8SaWmoQQMzPnPhMxY9SABSN2hC5eRXd5is8yUOmQgL+NjZhUsdu739U2MJZwyKU+
         EqdZSRk41AbK3lWvHyoK8aRPVRPdgbodCsZJCjEjq8kGOmPKhpGOpmsHzqbCwRshKVC3
         uQgaZJdxgUVsEctrrjXO6p58bJ6A04UqgmzOGdK8mkomAEJW+iV/zKzFCKOCDiK8o+NI
         LRpJ/UkZvgYbhYnp8wU7Kwez5U5lBpIniSM8q1Sk+5xiGwnoA+c4PSBinbVWfQSFyDRv
         IkGL5Fw5hdjYofzVG+K9KSUqHMkp66NorFZoFiGGDx6DVm3DB7k8nQHJ0aiEBhpcd5on
         /BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wd8Jz8eN+KAQgwsdPXLtOcLkWzE6Ah0rN7veq16jhGM=;
        b=S6krZUuH8hpsf0+guOZ+UqrWMyB1MRyXEgbaRkopyUv/7oYU8s588Fpbr6NEDc9d2m
         YxUX2U6iXLFQzSyOHU/YK98kyaQMoiNHxD22QhHHVizvu5FWpFGA3Gcsb79ytrYFFrXT
         Kq43Y0mHBK874l7CcGHXSRhKAS8btW2iqgcHw6rKPmp2DPy0HGdi4/z2hyFZCUOU3cm4
         RCFnMhzNdP9XOtCThgmUVtVmFlOvskPZdTAoNZRnI0ChK7nRHU96AAEDg+HWdD3Qeito
         YI+tqQ8NX6iepfJ53X0g352cz6gSnPIO4nJ//1HPcQsrdII+PH2nYOhGcDNj5mkIjzxZ
         ZfCQ==
X-Gm-Message-State: AO0yUKXJ5fXKvIySe7cBb/VU7VeaNOlhhKnek1XEKa9Ez081RrPHA6fH
        ewWqoGRSQrOQ5A4OF8p6e8wYEgQaIlEbiwCRBlzWPQ==
X-Google-Smtp-Source: AK7set/BLOkqMVb9X8lI7qO8tvchw3DlISzdv8JjH9K3QEa1p/x6AruKolyPIBBwl94ih85169BytSuicZ31U7AVdm4=
X-Received: by 2002:a67:d886:0:b0:421:7f84:f3d9 with SMTP id
 f6-20020a67d886000000b004217f84f3d9mr2377859vsj.3.1677625886981; Tue, 28 Feb
 2023 15:11:26 -0800 (PST)
MIME-Version: 1.0
References: <c534c2a458a3bf94ccdae8abc6edc3d45a689c30.1649777295.git.robin.murphy@arm.com>
In-Reply-To: <c534c2a458a3bf94ccdae8abc6edc3d45a689c30.1649777295.git.robin.murphy@arm.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 28 Feb 2023 15:11:15 -0800
Message-ID: <CAJ+vNU3+rz50MRQQsz39Jfbspy2ig9tqzb_yg1RFooxGutCM+g@mail.gmail.com>
Subject: Re: [RFC PATCH] irqchip/gic-v3: Claim iomem resources
To:     Robin Murphy <robin.murphy@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     maz@kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 8:29=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> As a simple quality-of-life tweak, claim our MMIO regions when mapping
> them, such that the GIC shows up in /proc/iomem. No effort is spent on
> trying to release them, since frankly if the GIC fails to probe then
> it's never getting a second try anyway.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>
> ---
>
> I briefly looked at doing the same for GICv2, but quickly decided that
> GICv2 isn't interesting enough to be worth the (greater) bother...
>
> Lightly tested with ACPI.
> ---
>  drivers/irqchip/irq-gic-v3.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index b252d5534547..9815b692a47a 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1980,10 +1980,10 @@ static int __init gic_of_init(struct device_node =
*node, struct device_node *pare
>         u32 nr_redist_regions;
>         int err, i;
>
> -       dist_base =3D of_iomap(node, 0);
> -       if (!dist_base) {
> +       dist_base =3D of_io_request_and_map(node, 0, "GICD");
> +       if (IS_ERR(dist_base)) {
>                 pr_err("%pOF: unable to map gic dist registers\n", node);
> -               return -ENXIO;
> +               return PTR_ERR(dist_base);
>         }
>
>         err =3D gic_validate_dist_version(dist_base);
> @@ -2007,8 +2007,8 @@ static int __init gic_of_init(struct device_node *n=
ode, struct device_node *pare
>                 int ret;
>
>                 ret =3D of_address_to_resource(node, 1 + i, &res);
> -               rdist_regs[i].redist_base =3D of_iomap(node, 1 + i);
> -               if (ret || !rdist_regs[i].redist_base) {
> +               rdist_regs[i].redist_base =3D of_io_request_and_map(node,=
 1 + i, "GICR");
> +               if (ret || IS_ERR(rdist_regs[i].redist_base)) {
>                         pr_err("%pOF: couldn't map region %d\n", node, i)=
;
>                         err =3D -ENODEV;
>                         goto out_unmap_rdist;
> @@ -2034,7 +2034,7 @@ static int __init gic_of_init(struct device_node *n=
ode, struct device_node *pare
>
>  out_unmap_rdist:
>         for (i =3D 0; i < nr_redist_regions; i++)
> -               if (rdist_regs[i].redist_base)
> +               if (rdist_regs[i].redist_base && !IS_ERR(rdist_regs[i].re=
dist_base))
>                         iounmap(rdist_regs[i].redist_base);
>         kfree(rdist_regs);
>  out_unmap_dist:
> @@ -2081,6 +2081,7 @@ gic_acpi_parse_madt_redist(union acpi_subtable_head=
ers *header,
>                 pr_err("Couldn't map GICR region @%llx\n", redist->base_a=
ddress);
>                 return -ENOMEM;
>         }
> +       request_mem_region(redist->base_address, redist->length, "GICR");
>
>         gic_acpi_register_redist(redist->base_address, redist_base);
>         return 0;
> @@ -2103,6 +2104,7 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_header=
s *header,
>         redist_base =3D ioremap(gicc->gicr_base_address, size);
>         if (!redist_base)
>                 return -ENOMEM;
> +       request_mem_region(gicc->gicr_base_address, size, "GICR");
>
>         gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
>         return 0;
> @@ -2304,6 +2306,7 @@ gic_acpi_init(union acpi_subtable_headers *header, =
const unsigned long end)
>                 pr_err("Unable to map GICD registers\n");
>                 return -ENOMEM;
>         }
> +       request_mem_region(dist->base_address, ACPI_GICV3_DIST_MEM_SIZE, =
"GICD");
>
>         err =3D gic_validate_dist_version(acpi_data.dist_base);
>         if (err) {
> --
> 2.28.0.dirty
>

Greetings,

I have bisected a kernel issue where octeontx (CN803x) will hang on
reboot caused by commit c0db06fd0993 ("mmc: core: Disable card detect
during shutdown"). This commit made it into 5.16 and stable kernels.
I've found that the patch here which is commit 2b2cd74a06c3 resolves
this hang but I'm not entirely clear why.

Does anyone have a good explanation of why the hang occurs in the
first place and why this resolves it? I would like to get the proper
fix into the affected stable branches.

Best Regards,

Tim
