Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F2D6BA013
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCNTxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjCNTwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:52:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C419A36680;
        Tue, 14 Mar 2023 12:52:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eg48so7486919edb.13;
        Tue, 14 Mar 2023 12:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678823542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMc2AnlV82kWeOQMw4Z57Uy8gyinuEGs+efX/3BzdrM=;
        b=GaBPzv3wgeHg5mdOzdiwOVazLXCDhdCOrdePbsgJDi21f+1qnJM6ELcpmu7tU1rMST
         cjE8SlnKUyVc4FxAIbKf3kico9yQhyCmf0umFoCZlG8v7KZ0XkFh8PPO3cbZAyTm2nCH
         N/kIfjmK/Egjl5SbHw3k/SOTTT6+sIiCwY0kZpqrJ8gMnQq/7AIDTMp8yEnpdz4rfQuf
         D54Rs5kZCp++koUnziuR0GUPgtpl8GPiw5dywdDwOYVUCaLameqj32/emey+m+Tq2FGK
         OIou9a5lMr8BdC8svsyN5SZf9s8l5a3EQLYTP6FU0J3IWkhor6AUTxk78E26aUy22uE6
         zKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678823542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMc2AnlV82kWeOQMw4Z57Uy8gyinuEGs+efX/3BzdrM=;
        b=6Zx73aAWWC1qc8CYnH+VfhSFv48jPvFrK5duC5GQNqCVH6Jmc1T2rlYzsmuYj498Jo
         7BFhvJnwBHKRcrRkaOLuYxzq7KRsNcbPUYXu1lG9XTYIwLr/YT/iVMWJ/DtcAij5NTb9
         ud+uaNVPgyvfOBPbmFjSqYTvopS5ERFBfCyfVb+pd+INmzgpvXUwJXGEYL9TmxYE2YQh
         riH9wnLxlK4DwOpgFT5JvKCBXSsiyYzuwNzV6XPWpgZJ/TtQah8ragvIHGh2BGssuOGw
         1qQTRWtLL+zjiDjl/VBNinkAQLcZtXp0XFOicLu15WSvGltAEqbJWIrT3SPhKOrqORXW
         5tNQ==
X-Gm-Message-State: AO0yUKXErxInI0Gom1zoGn2/w265s7F4iVdZ+vbyFumC2UkCEuv3U95t
        qTfonVe12TMZ7rFDPPVchjo=
X-Google-Smtp-Source: AK7set9lGQSvj/0qLoxjjRbWIJWyy4clOJmKgKtnIzH8T77Xxvcq28Mg1JfG2Pp6mT42x0CH2tiMRw==
X-Received: by 2002:a50:fe92:0:b0:4af:62af:460a with SMTP id d18-20020a50fe92000000b004af62af460amr322583edt.8.1678823542126;
        Tue, 14 Mar 2023 12:52:22 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id v10-20020a50a44a000000b004fd204d180dsm1484455edb.64.2023.03.14.12.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 12:52:21 -0700 (PDT)
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
Subject: Re: [PATCH 17/28] media: platform: sun6i-mipi-csi2: drop of_match_ptr for ID
 table
Date:   Tue, 14 Mar 2023 20:52:19 +0100
Message-ID: <5654872.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20230312131318.351173-17-krzysztof.kozlowski@linaro.org>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
 <20230312131318.351173-17-krzysztof.kozlowski@linaro.org>
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

Dne nedelja, 12. marec 2023 ob 14:13:07 CET je Krzysztof Kozlowski napisal(=
a):
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).  This
> also fixes !CONFIG_OF error:
>=20
>   drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c:751:34:
> error: =E2=80=98sun6i_mipi_csi2_of_match=E2=80=99 defined but not used
> [-Werror=3Dunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>=20
> diff --git a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2=
=2Ec
> b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c index
> a220ce849b41..0851b6b4e1ff 100644
> --- a/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
> +++ b/drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
> @@ -759,7 +759,7 @@ static struct platform_driver
> sun6i_mipi_csi2_platform_driver =3D { .remove	=3D sun6i_mipi_csi2_remove,
>  	.driver	=3D {
>  		.name		=3D SUN6I_MIPI_CSI2_NAME,
> -		.of_match_table	=3D=20
of_match_ptr(sun6i_mipi_csi2_of_match),
> +		.of_match_table	=3D sun6i_mipi_csi2_of_match,
>  		.pm		=3D &sun6i_mipi_csi2_pm_ops,
>  	},
>  };




