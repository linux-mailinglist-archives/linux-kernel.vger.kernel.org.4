Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4342649BED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiLLKTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiLLKTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:19:04 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258AA6540
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:19:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id s8so17734486lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LJWd6AQztEmSWT/U5Xb23y3w/Zwmz1JFHRldH5LnDP0=;
        b=zwvGvG8xi+vxQNRzfLMBIZHsUNUMx7b+j3H3D+U6IkMjn0SP4C2qkEyZ9te6dt4HHA
         sCdAgV8NBSYmGRHJzSZh6pLofhXhWm0EYJJuxiFg02afRnnV/U94Lc+yBZR4e4j3KJIj
         dZG9fOYQOW3OrF2fBEDOik9/WHYWLG3Pt15b9+vcWuPeQQnB+g34y7f6nGmK5it+O+CF
         Fe58l7mnXL9kGamdInKND9W2A0ARpfWq1QZyr7+zCsll5NJQ7Fllqiy+occ6pqrKEUOj
         9e6xR9rYWGxRv5cFlD/2c9ASF1UHaPuq6mbJziG/+dmvknEW1pbF+QCoyJzR56o/BAvC
         28fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LJWd6AQztEmSWT/U5Xb23y3w/Zwmz1JFHRldH5LnDP0=;
        b=vPl99NuJfID8mHIX90NejlY9UbZ/Ssa6lyP7TZK3ijpciiTlW9nyEy31cxdR0jpFGc
         A5ITVL6xMmAEVbaS+g9bB7DZqzqaQub/LuC1A4vUpOKJo5+F/Zf8co49oJQka7L7dfDV
         rSanc1qOsFyYdxdoTtcITsjzc+K4C4W+NAj3r2eOjm/tgOhVuZ5IpvGO3GIyrlNCKsvr
         86vddGF9BH0tI7sKSZSmFM4c//uMShhh/Sxy6eXIjV111u+0sC51gsnoFv6BiL9ycgO0
         sBad9x6wMK9uw5ijfn9kLuq3e/Tbmj4nol1iJ4JqZ2f+8/UyckCOB/CRY/pMTnBe3f7N
         JpYA==
X-Gm-Message-State: ANoB5pnBS+UTgpOCdttd/0RAns3ysmAb29OUYl6TiL0mCzcnfWLcK/tC
        oBFM3G/QPnwZEE82kYiRtUsYEg==
X-Google-Smtp-Source: AA0mqf6YBUpss09uzAVY1l7XE3IX3EtN6+7g2xVY9ikGcR4jNDTXTGvpknnrJD5vQVuagvsPiHjvTg==
X-Received: by 2002:a05:6512:329c:b0:4b1:2447:697f with SMTP id p28-20020a056512329c00b004b12447697fmr4067081lfe.24.1670840341542;
        Mon, 12 Dec 2022 02:19:01 -0800 (PST)
Received: from [127.0.0.1] ([94.25.228.118])
        by smtp.gmail.com with ESMTPSA id y17-20020a056512045100b004b52aed44besm1592841lfk.25.2022.12.12.02.19.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 02:19:01 -0800 (PST)
Date:   Mon, 12 Dec 2022 13:18:53 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
CC:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8150: Add DISPCC node
User-Agent: K-9 Mail for Android
In-Reply-To: <20221212093315.11390-2-konrad.dybcio@linaro.org>
References: <20221212093315.11390-1-konrad.dybcio@linaro.org> <20221212093315.11390-2-konrad.dybcio@linaro.org>
Message-ID: <FF242AC6-01EC-4C8E-BE49-BB54FC9D2FEE@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12 December 2022 12:33:13 GMT+03:00, Konrad Dybcio <konrad=2Edybcio@lin=
aro=2Eorg> wrote:
>Years after the SoC support has been added, it's high time for it to
>get dispcc going=2E Add the node to ensure that=2E
>
>Signed-off-by: Konrad Dybcio <konrad=2Edybcio@linaro=2Eorg>
>---
> arch/arm64/boot/dts/qcom/sm8150=2Edtsi | 26 ++++++++++++++++++++++++++
> 1 file changed, 26 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/qcom/sm8150=2Edtsi b/arch/arm64/boot/dts=
/qcom/sm8150=2Edtsi
>index a0c57fb798d3=2E=2Eff04397777f4 100644
>--- a/arch/arm64/boot/dts/qcom/sm8150=2Edtsi
>+++ b/arch/arm64/boot/dts/qcom/sm8150=2Edtsi
>@@ -3579,6 +3579,32 @@ camnoc_virt: interconnect@ac00000 {
> 			qcom,bcm-voters =3D <&apps_bcm_voter>;
> 		};
>=20
>+		dispcc: clock-controller@af00000 {
>+			compatible =3D "qcom,sm8150-dispcc";
>+			reg =3D <0 0x0af00000 0 0x10000>;
>+			clocks =3D <&rpmhcc RPMH_CXO_CLK>,
>+				 <0>,
>+				 <0>,
>+				 <0>,
>+				 <0>,
>+				 <0>,
>+				 <0>;
>+			clock-names =3D "bi_tcxo",
>+				      "dsi0_phy_pll_out_byteclk",
>+				      "dsi0_phy_pll_out_dsiclk",
>+				      "dsi1_phy_pll_out_byteclk",
>+				      "dsi1_phy_pll_out_dsiclk",
>+				      "dp_phy_pll_link_clk",
>+				      "dp_phy_pll_vco_div_clk";
>+			#clock-cells =3D <1>;
>+			#reset-cells =3D <1>;
>+			#power-domain-cells =3D <1>;
>+
>+			power-domains =3D <&rpmhpd SM8150_MMCX>;
>+			/* TODO: Maybe rpmhpd_opp_min_svs could work as well? */
>+			required-opps =3D <&rpmhpd_opp_low_svs>;

Is it required for the dispcc, for the DSI or for the dpu? We have stumble=
d upon the similar issue when working on the 8350, see the latest Robert's =
patchset=2E


>+		};
>+
> 		pdc: interrupt-controller@b220000 {
> 			compatible =3D "qcom,sm8150-pdc", "qcom,pdc";
> 			reg =3D <0 0x0b220000 0 0x400>;

--=20
With best wishes
Dmitry
