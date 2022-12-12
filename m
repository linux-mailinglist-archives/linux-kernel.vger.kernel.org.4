Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5607649D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiLLLHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiLLLG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:06:57 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D812311812
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:54:06 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p8so17846842lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jN9sEBY3LAhBIsC2SKGFeUTMmLXmYwsXUk6CCQcXwxI=;
        b=OPkAol+cxiEfwUWOLToSowmwiWak4vBJdX05KL5JTgLv8JWbaYjlXWQUg5ptE8F2GL
         1AFXhyXnq/XU9mQ9eU9alzRptl4z0b0r8KvdRa9Ar6xhV4SMrAwyg73t6r/V/YVw3ozC
         1W5UNNcY3YorB1N5bXyYyPtwfn971LYYhdAUqAQ+LX8U10BJPF5zOQ442H7HU5WVlyAa
         qR8Lw0aX8qRO7LXYfgV54PN+44wrSV1KgNhhDHvSIu9f/tQXKktrR+X0cFf7FjN8ysrS
         cxVxpB2iJ1v7rwHUJqs+ErxxVx+FcNn+L4SiQfiZv+8B0y70qmVAZ2F/BxuGWocOkwtb
         5llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jN9sEBY3LAhBIsC2SKGFeUTMmLXmYwsXUk6CCQcXwxI=;
        b=083kJlzEiSX/mQkMLkmTOMZ3oKeVqreLamts1AWzzWSECHNL7HOSFd8oitZBEsie+b
         gM79yO0CfNIYjt7aWzzFMbJBR1R64Gs5Q+OwXwttyxG/Uk85N4jGTcWKPrXgtSc8Na8z
         Iv1YHHPRlnEFudaLwDt9M6VgChcDPw4jfzuydPWNqMt6UWFKKEiB5tOho0mGgPSYpwlO
         /zqI14Uih918acGCfJONaK64mb8CDkgCqxafIQFROlov/0GS17OInz79WQGXDB7aG6dR
         sd/iuowMf5TRx4edzFkhiTeC6Tjohgf+OtbQGnLBAZ3P4F3+BTr82BarpViEKufMtl5i
         tBDw==
X-Gm-Message-State: ANoB5plqPZ3q9/C+9tgR519ZxZnW/ejXhzpJblz8bVSHzsEmaO7nI1c9
        x+6iXY6wKXaemSHZmw/Fod/sWg==
X-Google-Smtp-Source: AA0mqf5FK4Y1X52q+deu6rdGbCIJ2U5TFCkzrIkKv3HQ4S4H1QrelaJC+P8CW+wTRYBgXdgV0LCdFA==
X-Received: by 2002:a19:5f5a:0:b0:4b5:9b5b:ae92 with SMTP id a26-20020a195f5a000000b004b59b5bae92mr3978862lfj.10.1670842445212;
        Mon, 12 Dec 2022 02:54:05 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.102])
        by smtp.gmail.com with ESMTPSA id h28-20020a056512055c00b00494942bec60sm1588845lfl.17.2022.12.12.02.54.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 02:54:04 -0800 (PST)
Date:   Mon, 12 Dec 2022 13:53:59 +0300
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
In-Reply-To: <80168963-0e17-e8aa-6d99-a1c53f63c934@linaro.org>
References: <20221212093315.11390-1-konrad.dybcio@linaro.org> <20221212093315.11390-2-konrad.dybcio@linaro.org> <FF242AC6-01EC-4C8E-BE49-BB54FC9D2FEE@linaro.org> <80168963-0e17-e8aa-6d99-a1c53f63c934@linaro.org>
Message-ID: <16CE34C3-ADAE-47EC-AAFB-4436C4D8C842@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12 December 2022 13:23:50 GMT+03:00, Konrad Dybcio <konrad=2Edybcio@lin=
aro=2Eorg> wrote:
>
>
>On 12=2E12=2E2022 11:18, Dmitry Baryshkov wrote:
>>=20
>>=20
>> On 12 December 2022 12:33:13 GMT+03:00, Konrad Dybcio <konrad=2Edybcio@=
linaro=2Eorg> wrote:
>>> Years after the SoC support has been added, it's high time for it to
>>> get dispcc going=2E Add the node to ensure that=2E
>>>
>>> Signed-off-by: Konrad Dybcio <konrad=2Edybcio@linaro=2Eorg>
>>> ---
>>> arch/arm64/boot/dts/qcom/sm8150=2Edtsi | 26 ++++++++++++++++++++++++++
>>> 1 file changed, 26 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8150=2Edtsi b/arch/arm64/boot/=
dts/qcom/sm8150=2Edtsi
>>> index a0c57fb798d3=2E=2Eff04397777f4 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8150=2Edtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8150=2Edtsi
>>> @@ -3579,6 +3579,32 @@ camnoc_virt: interconnect@ac00000 {
>>> 			qcom,bcm-voters =3D <&apps_bcm_voter>;
>>> 		};
>>>
>>> +		dispcc: clock-controller@af00000 {
>>> +			compatible =3D "qcom,sm8150-dispcc";
>>> +			reg =3D <0 0x0af00000 0 0x10000>;
>>> +			clocks =3D <&rpmhcc RPMH_CXO_CLK>,
>>> +				 <0>,
>>> +				 <0>,
>>> +				 <0>,
>>> +				 <0>,
>>> +				 <0>,
>>> +				 <0>;
>>> +			clock-names =3D "bi_tcxo",
>>> +				      "dsi0_phy_pll_out_byteclk",
>>> +				      "dsi0_phy_pll_out_dsiclk",
>>> +				      "dsi1_phy_pll_out_byteclk",
>>> +				      "dsi1_phy_pll_out_dsiclk",
>>> +				      "dp_phy_pll_link_clk",
>>> +				      "dp_phy_pll_vco_div_clk";
>>> +			#clock-cells =3D <1>;
>>> +			#reset-cells =3D <1>;
>>> +			#power-domain-cells =3D <1>;
>>> +
>>> +			power-domains =3D <&rpmhpd SM8150_MMCX>;
>>> +			/* TODO: Maybe rpmhpd_opp_min_svs could work as well? */
>>> +			required-opps =3D <&rpmhpd_opp_low_svs>;
>>=20
>> Is it required for the dispcc, for the DSI or for the dpu? We have stum=
bled upon the similar issue when working on the 8350, see the latest Robert=
's patchset=2E
>While I don't have any hard evidence, it seems like it is required for
>any "interesting" multimedia components, AFAIU even including video and
>camera clocks=2E=2E
>
>Seems like it's a deep down dependency for a lot of things on this
>particular SoC (and likely also on newer ones, remember the initial
>mess with 8250 mmcx?)

Yes=2E I was questioning the opp level rather than the domain itself=2E Us=
ually the least possible mmcx level is enough to get dispcc going=2E Then t=
he consumers (via the PLLs) bump this requirement=2E=20

In this particular case the vendor dtsi (sm8150-regulator=2Edtsi) declares=
 that the minimum level for mmcx is low_svs=2E So, I think, you can drop th=
e todo completely=2E


>
>Konrad
>>=20
>>=20
>>> +		};
>>> +
>>> 		pdc: interrupt-controller@b220000 {
>>> 			compatible =3D "qcom,sm8150-pdc", "qcom,pdc";
>>> 			reg =3D <0 0x0b220000 0 0x400>;
>>=20

--=20
With best wishes
Dmitry
