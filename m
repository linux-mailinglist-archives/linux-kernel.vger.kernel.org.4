Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABB76BA00C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCNTwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjCNTvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:51:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81727233E0;
        Tue, 14 Mar 2023 12:51:51 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o12so66704036edb.9;
        Tue, 14 Mar 2023 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678823510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AT8USwG5WyHMLzA6/8T0IUfb3m04Mgmj2Z9mkS5Q9k=;
        b=VQ1Bxxrd0PI+Y36KGSR9tvLfCRNckswniNWELVaaPvUCxWivB6ajZpVwNfQPWx/bxk
         wlyb+IDMNnHUcblddMhuEzgUKSHLuI4IYjI16P82uxBFfu+92mr4ylyALdg2BFJvB0AO
         onmyGCP+1rgPgi7D6BPokZjuqWgag+074+OsP3gh5V8/s6Ajcuo0Ix20CPS0vWa6y38n
         CxUj1yc60ELISGN+7y9S+Iv2DRIOmu8bGsTq9Aeo9AEahw49g7yGwjhT0f4XFogDgefs
         /N/wuVy/EJ9AiQTL6+rT/SW6ZaLlic2kpZM0aIBubfPL2LM3uwH4k5DAmUCIPj+m+x3r
         sfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678823510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AT8USwG5WyHMLzA6/8T0IUfb3m04Mgmj2Z9mkS5Q9k=;
        b=oJNQBJDzWpTzt/Xz5j60S+1tcI4xKoBLJiFBvILS6BOSi2T9Lp9j+L43LTGBJuPOlx
         d0ieBRKW3FRVhraVnz7AQlzvTyz0Xh1gl5O0eOROtoFP2kyAvm4H+gXdnVD7NXykIjgW
         ac/jX+7kpQzKyV22ALUAuYAdIQjfxxjxh+rkLj3O7hx3Pb+rrDjeUzrYCPKQDc44oTS5
         zU5ZgO5UFw7hOFMt3vRnNebushmblQj1spP6X/f4/6UyXiRIhFOCxajjerUkLprQD4+a
         lO1TJu2gbucSvbt9adFvVS1LHE1zbzPWBzZqxrvrKeCxoeANw0mfnXJTIcEgXRnoaoCJ
         Rs9Q==
X-Gm-Message-State: AO0yUKV4AVbHo1QFWf5wTIUAdq0VeDaxTD1mC+X9kjGHQvqUaFxVfPp6
        s8cgHKlQ3PnNosVZXscH2kM=
X-Google-Smtp-Source: AK7set/tzuvE7xTzdstMMoDin2Jn1A93J29XnBrFLWGatjpCIuLb3twRybszlAVT52/X8b7+AM6KfA==
X-Received: by 2002:a17:906:a249:b0:92b:b4d9:3f07 with SMTP id bi9-20020a170906a24900b0092bb4d93f07mr3722129ejb.14.1678823509909;
        Tue, 14 Mar 2023 12:51:49 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id z4-20020a170906714400b008e53874f8d8sm1509261ejj.180.2023.03.14.12.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 12:51:49 -0700 (PDT)
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
Subject: Re: [PATCH 16/28] media: platform: sun6i-csi: drop of_match_ptr for ID table
Date:   Tue, 14 Mar 2023 20:51:46 +0100
Message-ID: <2671303.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230312131318.351173-16-krzysztof.kozlowski@linaro.org>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
 <20230312131318.351173-16-krzysztof.kozlowski@linaro.org>
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

Dne nedelja, 12. marec 2023 ob 14:13:06 CET je Krzysztof Kozlowski napisal(=
a):
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).  This
> also fixes !CONFIG_OF error:
>=20
>   drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c:401:34: error:
> =E2=80=98sun6i_csi_of_match=E2=80=99 defined but not used [-Werror=3Dunus=
ed-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> e3e6650181c8..187a2419da96 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -429,7 +429,7 @@ static struct platform_driver sun6i_csi_platform_driv=
er
> =3D { .remove	=3D sun6i_csi_remove,
>  	.driver	=3D {
>  		.name		=3D SUN6I_CSI_NAME,
> -		.of_match_table	=3D=20
of_match_ptr(sun6i_csi_of_match),
> +		.of_match_table	=3D sun6i_csi_of_match,
>  		.pm		=3D &sun6i_csi_pm_ops,
>  	},
>  };




