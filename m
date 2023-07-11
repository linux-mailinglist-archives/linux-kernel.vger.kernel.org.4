Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B756574F7FA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjGKS0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGKSZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:25:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3478A7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:25:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3141c3a7547so6237231f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689099957; x=1691691957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcA9zAZcv8H6F59O2yL/w1UsRzgAVue6pYP3PRyEN9Q=;
        b=bg7auqVXWeD/637tUroyB0q8jyytfqMQ02OIG990Kv8DY8eYOAMmSmJ9D6y4X4zOxY
         OE8Yr1SxH+CYjv4PafmryaU9ziO+P6fh700g025fnN+RLwjBz8D1nL4c7o2zRly3ici4
         mCNk8WYYnP3MJVOrAuuDYWWZ2VlYR2pzPzSzScnVSq43s0OoybytqwnQCnRD2Fdp4TIi
         Hu8qkGOJiqenfyN9yprrTf9IStWGG7opj5+trPJItJ61AkEf0rV96XwKfJqJZNUtGtlo
         f/+ebbcMZmdsvWNxzJWtyCpwH0sbPM5E3gKaoXvI1DPuw1mGHtFeGdvdz6XzdDUyz+Hh
         qNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689099957; x=1691691957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcA9zAZcv8H6F59O2yL/w1UsRzgAVue6pYP3PRyEN9Q=;
        b=BLBL0rS6MWfNxgP3BAEzwOKq6JoVe2KpYWTfDE2jHjV6HqxDFqgIFfKtThkkc+3InD
         +/d3oR7MC3d548Cfn3N6ioarijcKjjID5CoShG8dm1lIrS1/QCRosQ5mZ3dKjhCBSYC8
         yu28KtzssevFaGLrw+HHgqedHGEctkTfnuGnx09NYXX8mhvJyGO5DHokBfaM0QIs6CrL
         xVC2oSx2GAl014jRjeY1DQL9Qut00usPoJA5ivc+BxdPin9epr1a6hL+lFfw71Vp625x
         +McequerI5b8HUlDEmutKeybDMuKVX3dHFqdugC1Tkd/VpyMQhYf74eFqb75QDzZNv3t
         Y6Og==
X-Gm-Message-State: ABy/qLYt57Ayr2Lwkm4tcwac/NE5EuxX+NI/cHLb3Xsd3cfxLV0Lib/u
        63AWppXb7aKyuhj500VEIBg=
X-Google-Smtp-Source: APBJJlFVSzM/6yF41kx+JCmUQnPCxQ1HuMA/ja/T8CsCKHgbXdd4Sga+3LTsDZ649EZut433azkWJw==
X-Received: by 2002:a5d:568f:0:b0:314:5376:f0d6 with SMTP id f15-20020a5d568f000000b003145376f0d6mr14001158wrv.52.1689099957068;
        Tue, 11 Jul 2023 11:25:57 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d66c3000000b00314398e4dd4sm2888343wrw.54.2023.07.11.11.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 11:25:56 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] bus: sunxi-rsb: Convert to devm_platform_ioremap_resource()
Date:   Tue, 11 Jul 2023 20:25:55 +0200
Message-ID: <21938707.EfDdHjke4D@jernej-laptop>
In-Reply-To: <20230706072042.31296-1-frank.li@vivo.com>
References: <20230706072042.31296-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 06. julij 2023 ob 09:20:36 CEST je Yangtao Li napisal(a):
> Use devm_platform_ioremap_resource() to simplify code.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/bus/sunxi-rsb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> index 696c0aefb0ca..2aefd5dde3c9 100644
> --- a/drivers/bus/sunxi-rsb.c
> +++ b/drivers/bus/sunxi-rsb.c
> @@ -746,7 +746,6 @@ static int sunxi_rsb_probe(struct platform_device *pd=
ev)
> {
>  	struct device *dev =3D &pdev->dev;
>  	struct device_node *np =3D dev->of_node;
> -	struct resource *r;
>  	struct sunxi_rsb *rsb;
>  	u32 clk_freq =3D 3000000;
>  	int irq, ret;
> @@ -766,8 +765,7 @@ static int sunxi_rsb_probe(struct platform_device *pd=
ev)
> rsb->dev =3D dev;
>  	rsb->clk_freq =3D clk_freq;
>  	platform_set_drvdata(pdev, rsb);
> -	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	rsb->regs =3D devm_ioremap_resource(dev, r);
> +	rsb->regs =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(rsb->regs))
>  		return PTR_ERR(rsb->regs);




