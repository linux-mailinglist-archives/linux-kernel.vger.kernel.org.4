Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6B96C7084
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjCWSt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjCWStT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:49:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE13E26873;
        Thu, 23 Mar 2023 11:49:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u1so1829268wmn.5;
        Thu, 23 Mar 2023 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679597348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaAtIRtOu++U0RXXy05q7KocYfCm4/E/CZEqe2Ect2k=;
        b=h2ivD7hcvtWe9brHOPv+jqBpm0raSc80vwDnXEhu5IdMrXiSPdjv0esN1GT7ewwyYG
         H2y8Eqn4Mo60ywPRXJTn8XgB+fMxZVA7Ct7E9JHORCpJmeCIzHvdrGjUdnE+vxLGYPiz
         VllmEBVE8pnA4884rTJfjjv+EJ0V+uVKTLuKCdadwNglfs7N/eccLAUNRpSrEf1I0/Hg
         dxzYcGpTFKNcuWyNeoJKlNn2EdqUnIIf8IbDhN28vDqEqCqgpCdS+JbajSk8ldfUqupS
         L6eoIE7x1bDdqffvBZdtYyGHZKEJjlBUFneI5JFhM147Bl5C24i2CFWn5q43MEwWX9Re
         KG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679597348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaAtIRtOu++U0RXXy05q7KocYfCm4/E/CZEqe2Ect2k=;
        b=lYO507gBCrKiXYE7hViKI05OAhhZUKLYfyGbWSR+BsW28DUHiFr8/BBlbS+wdBi9uj
         aRrmzfTFM/+0h3SAuTLoHNOBPgxmlIGTQ/3xzycDCuCIc80GqAXEoB69aux+HqvLWM20
         pidk3Cum0ElSSETq0eIJvGZyfwkjRiTdLYp5p2urQM5tTamSMRCR8zeBt/uVuQHPqi8w
         nP8as2Bc2MMxHxNEYAVWSARebzT0ZcjsLj3+FgE3EEdJmJNt/i/V5sQGJplW80H2vuxH
         20XXhxsEW38TXvF6lOHR6th19IpYSiB9oRRTZWBGiIaSwSTkYP6M6e7Z1wSJR9l9kN/N
         g01w==
X-Gm-Message-State: AO0yUKU8Lm3zHIrVsRhigBVLgZg2FY54JKn60RRC39/1VevFtPYtOmd7
        /nQGMyuxXv49MUnTJXi9Mi0=
X-Google-Smtp-Source: AK7set8iPShWRfidqt9I4Gp4+eMynjPzq6WpxgPllmii/Bx8E6MpO7U6wLeZYbAleSLfDLFNMZa2Gg==
X-Received: by 2002:a7b:cd88:0:b0:3ee:7061:1bdd with SMTP id y8-20020a7bcd88000000b003ee70611bddmr481614wmj.4.1679597348358;
        Thu, 23 Mar 2023 11:49:08 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id n17-20020a1c7211000000b003edf2dc7ca3sm2621024wmc.34.2023.03.23.11.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 11:49:07 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Joe Tessler <jrt@google.com>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Benoit Parrot <bparrot@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] media: dt-bindings: Drop unneeded quotes
Date:   Thu, 23 Mar 2023 19:49:05 +0100
Message-ID: <5657054.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20230320233944.2920964-1-robh@kernel.org>
References: <20230320233944.2920964-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 21. marec 2023 ob 00:39:42 CET je Rob Herring napisal(a):
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/media/allwinner,sun4i-a10-ir.yaml | 2 +-
>  .../bindings/media/allwinner,sun50i-h6-vpu-g2.yaml        | 4 ++--

For Allwinner:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  .../devicetree/bindings/media/amlogic,axg-ge2d.yaml       | 4 ++--
>  .../devicetree/bindings/media/amlogic,gx-vdec.yaml        | 4 ++--
>  .../devicetree/bindings/media/amlogic,meson-ir-tx.yaml    | 4 ++--
>  .../devicetree/bindings/media/i2c/chrontel,ch7322.yaml    | 4 ++--
>  .../devicetree/bindings/media/i2c/dongwoon,dw9768.yaml    | 6 +++---
>  .../devicetree/bindings/media/i2c/maxim,max9286.yaml      | 2 +-
>  .../devicetree/bindings/media/i2c/ovti,ov02a10.yaml       | 2 +-
>  .../devicetree/bindings/media/mediatek,mdp3-rdma.yaml     | 2 +-
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml    | 4 ++--
>  .../devicetree/bindings/media/microchip,sama5d4-vdec.yaml | 4 ++--
>  .../devicetree/bindings/media/nxp,imx8mq-vpu.yaml         | 4 ++--
>  .../devicetree/bindings/media/qcom,msm8916-camss.yaml     | 4 ++--
>  .../devicetree/bindings/media/qcom,msm8916-venus.yaml     | 8 ++++----
>  .../devicetree/bindings/media/qcom,msm8996-camss.yaml     | 4 ++--
>  .../devicetree/bindings/media/qcom,msm8996-venus.yaml     | 4 ++--
>  .../devicetree/bindings/media/qcom,sc7180-venus.yaml      | 4 ++--
>  .../devicetree/bindings/media/qcom,sc7280-venus.yaml      | 4 ++--
>  .../devicetree/bindings/media/qcom,sdm660-camss.yaml      | 4 ++--
>  .../devicetree/bindings/media/qcom,sdm660-venus.yaml      | 4 ++--
>  .../devicetree/bindings/media/qcom,sdm845-camss.yaml      | 4 ++--
>  .../devicetree/bindings/media/qcom,sdm845-venus-v2.yaml   | 4 ++--
>  .../devicetree/bindings/media/qcom,sdm845-venus.yaml      | 4 ++--
>  .../devicetree/bindings/media/qcom,sm8250-camss.yaml      | 4 ++--
>  .../devicetree/bindings/media/qcom,sm8250-venus.yaml      | 4 ++--
>  Documentation/devicetree/bindings/media/rc.yaml           | 2 +-
>  .../devicetree/bindings/media/rockchip,rk3568-vepu.yaml   | 4 ++--
>  Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 4 ++--
>  Documentation/devicetree/bindings/media/ti,cal.yaml       | 2 +-
>  30 files changed, 57 insertions(+), 57 deletions(-)



