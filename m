Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEB762A429
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbiKOVak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238641AbiKOVab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:30:31 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6A1C0C;
        Tue, 15 Nov 2022 13:30:30 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id k2so39433497ejr.2;
        Tue, 15 Nov 2022 13:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YMB5wqa41Qx7Nhpc1b1K/YGC00PDJRyqPvnVv8h9bw=;
        b=H94SosSAInfkcwKBQIK27bslSv2Xdm3jxgjp2d0WXHIgaKTzQ9TBMGGEa7GtKyCQ2l
         DGVvIvHWBlOMW6FH0t/HLwSfByqktPEwJqsL3IWDUyYKdj5fGOEOWwVtBF7jK9aPrijX
         dB3RtYXmZzjxTkp/qw09Se8fHdUGBVsBLKyb63g5nBBn985rwqs9UqKOc0XZePKm21JZ
         yW2kFLoD5UuixPn8zx1i4wkxkOnkHqkzl7OJtkMYImQWsIGNBUwRX3mg7Qcz6crVQ3wQ
         WHNas3JTSMVD0bYDCEOpHwDtwkGfwe2hsNXlJWAD6i/i/NjD8DSxwR1+Pb6NRDfAOXPg
         vlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YMB5wqa41Qx7Nhpc1b1K/YGC00PDJRyqPvnVv8h9bw=;
        b=tPZ0R7kGzGUKnDcQ5xNJA4iJL7QXl1lHurQsBzoVmoqk/x3PKoLgbhKvqc5qr1duGu
         wt0+sBdgZ7nv1c0djGFM0vtmXtICx2vQcWc2amf21wBX8GyXh1QjC5rpb/0ODuCC4OXB
         9RYRc0gEjHXRNg/DXdc9lHDdNolg3Xe2fqDPvsl+sGdQkxbnHDWLg21xaGWiwrN36ae4
         BiYWEjfcHBhHCilpN2RTQDjac/67o95HgmZIqjSNRr33XT/zO5asCPZqb7NPFjVIRG2+
         ku3AppQPMhwvH/goL54KiG8uDkyU4iiuZgM40+rjDMI2HDAxwnPqkyFW3PIdZfqEUAoI
         VoUQ==
X-Gm-Message-State: ANoB5pkgeo7Y9O+2oCfo/z7BW3QxM6zch1baQjrFKqOJxVBC5haU6SAr
        bh0YIBWyCao+RhllTGkB1Dc=
X-Google-Smtp-Source: AA0mqf5NuFVrNYRrXLO9HcnMljXOMrLrHDjFWROyEYkpFGTdhpCcqTY3MCd3RNI/6kfbaaZPOzEplQ==
X-Received: by 2002:a17:906:3a55:b0:78d:f2d8:4623 with SMTP id a21-20020a1709063a5500b0078df2d84623mr15863994ejf.274.1668547828479;
        Tue, 15 Nov 2022 13:30:28 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id a2-20020aa7d742000000b004623028c594sm6639814eds.49.2022.11.15.13.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 13:30:27 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: dt-bindings: allwinner: h6-vpu-g2: Add IOMMU reference property
Date:   Tue, 15 Nov 2022 22:30:26 +0100
Message-ID: <2121144.irdbgypaU6@jernej-laptop>
In-Reply-To: <20221115090644.3602573-2-wenst@chromium.org>
References: <20221115090644.3602573-1-wenst@chromium.org> <20221115090644.3602573-2-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 15. november 2022 ob 10:06:43 CET je Chen-Yu Tsai napisal(a):
> The Hantro G2 video decoder block sits behind an IOMMU. The device tree
> binding needs a property to reference it. Without a reference for the
> implementation to properly configure the IOMMU, it will fault and cause
> the video decoder to fail.

Note, Hantro G2 can happily work without IOMMU, if it is disabled for whole 
system, like disabling driver in kernel config. In such cases, it uses CMA.

Anyway, it's true that there should be proper reference in DT and bindings, 
so:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> 
> Add an "iommus" property for referring to the IOMMU port. The master ID
> in the example is taken from the IOMMU fault error message on Linux,
> and the number seems to match the order in the user manual's IOMMU
> diagram.
> 
> Fixes: fd6be12716c4 ("media: dt-bindings: allwinner: document H6 Hantro G2
> binding") Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  .../bindings/media/allwinner,sun50i-h6-vpu-g2.yaml           | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml
> b/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml
> index 24d7bf21499e..9d44236f2deb 100644
> ---
> a/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml
> +++
> b/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml
> @@ -36,6 +36,9 @@ properties:
>    resets:
>      maxItems: 1
> 
> +  iommus:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -43,6 +46,7 @@ required:
>    - clocks
>    - clock-names
>    - resets
> +  - iommus
> 
>  additionalProperties: false
> 
> @@ -59,6 +63,7 @@ examples:
>          clocks = <&ccu CLK_BUS_VP9>, <&ccu CLK_VP9>;
>          clock-names = "bus", "mod";
>          resets = <&ccu RST_BUS_VP9>;
> +        iommus = <&iommu 5>;
>      };
> 
>  ...




