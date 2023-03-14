Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005AC6BA014
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCNTxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCNTwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:52:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DD32A6F9;
        Tue, 14 Mar 2023 12:52:43 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id eh3so10826482edb.11;
        Tue, 14 Mar 2023 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678823561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84n+oQ302Lrrw4Xj5iionDKBc2AXr3E7Vl/qNdfFHag=;
        b=jtMqk3VJbrkKpAHPz/4m10k3iyx5QewNEjy33UoSDCoiTp8RD6GFTQmtaqMT8czpXw
         +Uk+DEy81/sRL+3LcFriMiCaGN+2szqqX4YISqDiRotNme1tvGk59RHvoSOnTXZ41+H4
         2fXlBn+jPV377GGy9kXTImtKGbB3Q9yjIbbmPTWqafGJvuomVcnaxDMFP4Kn1LwZ9/Qh
         6tnk8G5PpSbXhsYwd0NwrROnOAQ3aDVqRWTfN9O+J/cafAD/5ixh9w63wF1MEzxsGni6
         Q3WwEbB1tZrj6RlW+hV5MrOK4tSO9IEydQF34bmg1ZSZQZNeRAl2iM9Tz9aIGfGnJlAv
         hIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678823561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84n+oQ302Lrrw4Xj5iionDKBc2AXr3E7Vl/qNdfFHag=;
        b=tE1ec+WyBiPT1a4bC37GoR8VlV4PjZTtVKeJ2sg6KfXrcwbgWNpT9FXJvE5zar9mr/
         S9WI9N9lji4sfwEShwNDGjXHIzaTWY8zv//u3IedrqsdNFRNr327rhKMwn1aIDptRZmO
         pn482jGT6NkVMhIdPE4YXZ6QTpXACvTOYkW+fanMFFoiIKtsX/8hgqwFbtznSXfaZPkl
         oMy6jkGydKo1o+jzHY1w8JMeq0ypc04Tn+TvdiZ9pYNf2IbN+mEjxPpRyUoKGTcNd8UC
         4S4+I/TRdpcSIE8y5UmCF7jpggamocd0vxerMXjxPdDCrMfl9Pca6oddbM46TY864ATr
         bgUQ==
X-Gm-Message-State: AO0yUKUWmXjm8bN+2oVynPjPsKu1D4iZsmvo++a4rL6a0dljVelFiyA5
        kZCYw7ssO4xJpUApx9Rw1Hg=
X-Google-Smtp-Source: AK7set9vnDgs0zNzFk64fSk03ZwJbehhJo01RTpV7gmR2nsQclFdjqoiygwh42ihvzlFoYsvReQjWA==
X-Received: by 2002:a17:907:20f1:b0:924:943d:7181 with SMTP id rh17-20020a17090720f100b00924943d7181mr3347932ejb.51.1678823561589;
        Tue, 14 Mar 2023 12:52:41 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id ot10-20020a170906ccca00b008e51a1fd7bfsm1538555ejb.172.2023.03.14.12.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 12:52:41 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Joe Tessler <jrt@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 18/28] media: platform: sun8i-a83t-mipi-csi2: drop of_match_ptr
 for ID table
Date:   Tue, 14 Mar 2023 20:52:38 +0100
Message-ID: <4812650.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20230312131318.351173-18-krzysztof.kozlowski@linaro.org>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
 <20230312131318.351173-18-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 12. marec 2023 ob 14:13:08 CET je Krzysztof Kozlowski napisal(=
a):
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).  This
> also fixes !CONFIG_OF error:
>=20
> =20
> drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c:=
81
> 8:34: error: =E2=80=98sun8i_a83t_mipi_csi2_of_match=E2=80=99 defined but =
not used
> [-Werror=3Dunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> diff --git
> a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
> b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
> index cd2e92ae2293..1f0cc7b1ba47 100644
> ---
> a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
> +++
> b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
> @@ -826,7 +826,7 @@ static struct platform_driver
> sun8i_a83t_mipi_csi2_platform_driver =3D { .remove	=3D
> sun8i_a83t_mipi_csi2_remove,
>  	.driver	=3D {
>  		.name		=3D SUN8I_A83T_MIPI_CSI2_NAME,
> -		.of_match_table	=3D=20
of_match_ptr(sun8i_a83t_mipi_csi2_of_match),
> +		.of_match_table	=3D sun8i_a83t_mipi_csi2_of_match,
>  		.pm		=3D &sun8i_a83t_mipi_csi2_pm_ops,
>  	},
>  };




