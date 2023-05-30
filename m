Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47013715883
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjE3I31 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 May 2023 04:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjE3I3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:29:24 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971DCCD;
        Tue, 30 May 2023 01:29:19 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-565a77af71fso34482767b3.2;
        Tue, 30 May 2023 01:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685435358; x=1688027358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9QLzEEeHcOqfv4kFNr/Qspw8g1QoGyjW4Pr7IpYvTM=;
        b=HmLBLykRk2RZbJ1VM2RLnDXjnTjK1HKxNv+80cWg83/tBpfa9QZRPV0o+smfdtN7h4
         xi8aaHiDI5SMjGxAigtqDqJqML48r8FnP9CQK+RuqBJ4t1gw4ZDKJeWODMMVt7XUt/vl
         VY3AwALLCtQ1yWc6Rme1qOUBPPakoNC0IVYSogRU9hrZU19yp1p3T37PUy8Rf+OHIA2M
         54N101BRto7RZUgSDD4bPvNcK4TINbYw+sJSpv0vbiO6Nwg8GHElSu4N1Hq/eNdBCfgs
         YPO9dBA2oEZTzaRVh4zn0Pw00Y4mqiWplZk5N5OXCFyAuYN7rbVJ1qExi6iudI4bBlHK
         0hLA==
X-Gm-Message-State: AC+VfDx03wnICdhmLcsE83IedloyGHe0aZevM9TKJdB9WYFXfldpWNsQ
        LbbNyULHIdnawUCVmqAc1UVp9qnwh4kx/g==
X-Google-Smtp-Source: ACHHUZ64vHPCsX0YBghfFYc9KuFKOi4BGAb4a8K44e5vuZKAWkciK3Mvk10XmYwAvjcMCXdk4Orszw==
X-Received: by 2002:a0d:eb92:0:b0:565:de9d:be6b with SMTP id u140-20020a0deb92000000b00565de9dbe6bmr1658761ywe.21.1685435358348;
        Tue, 30 May 2023 01:29:18 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id d17-20020a0ddb11000000b00565ef2c105asm2137823ywe.118.2023.05.30.01.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 01:29:16 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-568af2f6454so9997287b3.1;
        Tue, 30 May 2023 01:29:16 -0700 (PDT)
X-Received: by 2002:a0d:ca83:0:b0:556:ea38:eb07 with SMTP id
 m125-20020a0dca83000000b00556ea38eb07mr1308427ywd.50.1685435356175; Tue, 30
 May 2023 01:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230515131353.v2.cover@dianders> <20230515131353.v2.2.I88dc0a0eb1d9d537de61604cd8994ecc55c0cac1@changeid>
In-Reply-To: <20230515131353.v2.2.I88dc0a0eb1d9d537de61604cd8994ecc55c0cac1@changeid>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 May 2023 10:29:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWM_t7uQqkesM3fnSK7THrmLszA7U54==A0-98xPH90Bw@mail.gmail.com>
Message-ID: <CAMuHMdWM_t7uQqkesM3fnSK7THrmLszA7U54==A0-98xPH90Bw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] irqchip/gic-v3: Disable pseudo NMIs on Mediatek
 devices w/ firmware issues
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, wenst@chromium.org,
        yidilin@chromium.org, Tinghan Shen <tinghan.shen@mediatek.com>,
        jwerner@chromium.org, Weiyi Lu <weiyi.lu@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

On Mon, May 15, 2023 at 10:16 PM Douglas Anderson <dianders@chromium.org> wrote:
> Some Chromebooks with Mediatek SoCs have a problem where the firmware
> doesn't properly save/restore certain GICR registers. Newer
> Chromebooks should fix this issue and we may be able to do firmware
> updates for old Chromebooks. At the moment, the only known issue with
> these Chromebooks is that we can't enable "pseudo NMIs" since the
> priority register can be lost. Enabling "pseudo NMIs" on Chromebooks
> with the problematic firmware causes crashes and freezes.
>
> Let's detect devices with this problem and then disable "pseudo NMIs"
> on them. We'll detect the problem by looking for the presence of the
> "mediatek,broken-save-restore-fw" property in the GIC device tree
> node. Any devices with fixed firmware will not have this property.
>
> Our detection plan works because we never bake a Chromebook's device
> tree into firmware. Instead, device trees are always bundled with the
> kernel. We'll update the device trees of all affected Chromebooks and
> then we'll never enable "pseudo NMI" on a kernel that is bundled with
> old device trees. When a firmware update is shipped that fixes this
> issue it will know to patch the device tree to remove the property.
>
> In order to make this work, the quick detection mechanism of the GICv3
> code is extended to be able to look for properties in addition to
> looking at "compatible".
>
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - mediatek,gicr-save-quirk => mediatek,broken-save-restore-fw

Thanks for your patch, which is now commit 44bd78dd2b8897f5
("irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/
firmware issues") in v6.4-rc4.

This causes enabling an unrelated workaround on R-Car V4H:

    GIC: enabling workaround for GICv3: Cavium erratum 38539

> --- a/drivers/irqchip/irq-gic-common.c
> +++ b/drivers/irqchip/irq-gic-common.c
> @@ -16,7 +16,11 @@ void gic_enable_of_quirks(const struct device_node *np,
>                           const struct gic_quirk *quirks, void *data)
>  {
>         for (; quirks->desc; quirks++) {
> -               if (!of_device_is_compatible(np, quirks->compatible))
> +               if (quirks->compatible &&
> +                   !of_device_is_compatible(np, quirks->compatible))
> +                       continue;
> +               if (quirks->property &&
> +                   !of_property_read_bool(np, quirks->property))
>                         continue;

Presumably the loop should continue if none of quirks-compatible
or quirks->property is set?

>                 if (quirks->init(data))
>                         pr_info("GIC: enabling workaround for %s\n",
> @@ -28,7 +32,7 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
>                 void *data)
>  {
>         for (; quirks->desc; quirks++) {
> -               if (quirks->compatible)
> +               if (quirks->compatible || quirks->property)
>                         continue;
>                 if (quirks->iidr != (quirks->mask & iidr))
>                         continue;
> diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
> index 27e3d4ed4f32..3db4592cda1c 100644
> --- a/drivers/irqchip/irq-gic-common.h
> +++ b/drivers/irqchip/irq-gic-common.h
> @@ -13,6 +13,7 @@
>  struct gic_quirk {
>         const char *desc;
>         const char *compatible;
> +       const char *property;
>         bool (*init)(void *data);
>         u32 iidr;
>         u32 mask;
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 6fcee221f201..a605aa79435a 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -39,6 +39,7 @@
>
>  #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996    (1ULL << 0)
>  #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539  (1ULL << 1)
> +#define FLAGS_WORKAROUND_MTK_GICR_SAVE         (1ULL << 2)
>
>  #define GIC_IRQ_TYPE_PARTITION (GIC_IRQ_TYPE_LPI + 1)
>
> @@ -1720,6 +1721,15 @@ static bool gic_enable_quirk_msm8996(void *data)
>         return true;
>  }
>
> +static bool gic_enable_quirk_mtk_gicr(void *data)
> +{
> +       struct gic_chip_data *d = data;
> +
> +       d->flags |= FLAGS_WORKAROUND_MTK_GICR_SAVE;
> +
> +       return true;
> +}
> +
>  static bool gic_enable_quirk_cavium_38539(void *data)
>  {
>         struct gic_chip_data *d = data;
> @@ -1792,6 +1802,11 @@ static const struct gic_quirk gic_quirks[] = {
>                 .compatible = "qcom,msm8996-gic-v3",
>                 .init   = gic_enable_quirk_msm8996,
>         },
> +       {
> +               .desc   = "GICv3: Mediatek Chromebook GICR save problem",
> +               .property = "mediatek,broken-save-restore-fw",
> +               .init   = gic_enable_quirk_mtk_gicr,
> +       },
>         {
>                 .desc   = "GICv3: HIP06 erratum 161010803",
>                 .iidr   = 0x0204043b,
> @@ -1834,6 +1849,11 @@ static void gic_enable_nmi_support(void)
>         if (!gic_prio_masking_enabled())
>                 return;
>
> +       if (gic_data.flags & FLAGS_WORKAROUND_MTK_GICR_SAVE) {
> +               pr_warn("Skipping NMI enable due to firmware issues\n");
> +               return;
> +       }
> +
>         ppi_nmi_refs = kcalloc(gic_data.ppi_nr, sizeof(*ppi_nmi_refs), GFP_KERNEL);
>         if (!ppi_nmi_refs)
>                 return;
> --
> 2.40.1.606.ga4b1b128d6-goog

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
