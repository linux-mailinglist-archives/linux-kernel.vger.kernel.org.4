Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB2B6C304E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjCULYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjCULYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:24:05 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B47399E8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:23:52 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e11so6475507lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679397829;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER78GHh5meRUHq/j4G9iD3cSNrSOw2jr5A6Yqe49ido=;
        b=j0c1dNmNOiKvzn+MKcBDmz8oC7QduFqCJEGBELhkG3uwT8+MZWZT17Y9FN4BILwBIH
         e63eHVnmnphbJ1I38xl0RJW9U0SVjXbOR5Cp4j+6pb5z6yNSoG6in6y9QR15u28P0W36
         sSLFa0oSyUvfO3IFgYsqh0W8gjiXNKux4ozqYNhawqWTGKuPzplzosd3+vKTRqt418tc
         wrlliFQ6fErIuyAGgeVid3AEQwDpH6nE0xTc3OiaxPs2wXzHK11mj/dHk4NRef5BBjZV
         Cxcz8TsPP8HWRszymXdecLPajgRwLdVvFRU99tE4/VSCHiOR5tk9TE/1ciWHoTc1Pp4r
         7zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679397829;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ER78GHh5meRUHq/j4G9iD3cSNrSOw2jr5A6Yqe49ido=;
        b=ZsZKVogQGs8zkakFjQ1JOs/k84kbcNg1XAgS9g/KXk2mE1R/wXlB6jFbCSMmEK/hAD
         773jwvCav+8D3W2BZdPu4D0+Se+L7E9j9FxE1PjDcGJBTka9VrcejO307nHB44dWNywz
         ldi3CDJ7kBTcXTejxZwKYCPa6my9m5PgrDz6v+lyZTYoMr4g7jTRz0TjOSRM6EmT1oAt
         60941NDmme3uXr39Lqzd7PTou2eDIqwCeMSrVLVHb3MrrrIClggQVDBvqh8pWcWAtA0Y
         ifEhHjaEmHjxpeO3fv7O5cCG0pGme3V6+Yruryi8GWWBtGLgOVS0C8LAL6DGdXVYu5OX
         3pug==
X-Gm-Message-State: AO0yUKWab5XZofxvW3g56tx8sYVQDrWtDPjAyVEGxEp0COaf6BPaoChl
        nHgFVGpz0oxyqkwrL9uzqX7K0w==
X-Google-Smtp-Source: AK7set/mVbvLGeipIKw4ztCPoVgboNoFh6FukbmES88Qkm4XRAa6hcn/LLLdwYaDQ78cYiiZzuI9LA==
X-Received: by 2002:a2e:7c10:0:b0:298:592e:113a with SMTP id x16-20020a2e7c10000000b00298592e113amr768230ljc.6.1679397829545;
        Tue, 21 Mar 2023 04:23:49 -0700 (PDT)
Received: from [127.0.0.1] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m10-20020ac2428a000000b004b6f00832cesm2113222lfh.166.2023.03.21.04.23.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Mar 2023 04:23:49 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:23:26 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
User-Agent: K-9 Mail for Android
In-Reply-To: <644b4b0f17f72e109445a7b31f3e0d2e75dcc361.1679388632.git.quic_varada@quicinc.com>
References: <cover.1677749625.git.quic_varada@quicinc.com> <cover.1679388632.git.quic_varada@quicinc.com> <644b4b0f17f72e109445a7b31f3e0d2e75dcc361.1679388632.git.quic_varada@quicinc.com>
Message-ID: <122A5E4F-2794-43AE-8DAC-CC2D51279AC6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21 March 2023 11:54:25 GMT+03:00, Varadarajan Narayanan <quic_varada@qu=
icinc=2Ecom> wrote:
>Add USB phy and controller related nodes
>
>Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc=2Ecom>
>
>---
> Changes in v2:
>	- Fixed issues flagged by Krzysztof
>	- Fix issues reported by make dtbs_check
>	- Remove NOC related clocks (to be added with proper
>	  interconnect support)
>---
> arch/arm64/boot/dts/qcom/ipq9574=2Edtsi | 86 +++++++++++++++++++++++++++=
++++++++
> 1 file changed, 86 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/qcom/ipq9574=2Edtsi b/arch/arm64/boot/dt=
s/qcom/ipq9574=2Edtsi
>index 2bb4053=2E=2E513da74 100644
>--- a/arch/arm64/boot/dts/qcom/ipq9574=2Edtsi
>+++ b/arch/arm64/boot/dts/qcom/ipq9574=2Edtsi
>@@ -829,6 +829,92 @@
> 			msi-parent =3D <&v2m0>;
> 			status =3D "disabled";
> 		};

The last device node is pci@28000000=2E Thus you are trying to add all usb=
 nodes at the wrong place=2E Please move them so that all nodes are still s=
orted by the address part=2E


>+
>+		qusb_phy_0: phy@7b000 {
>+			compatible =3D "qcom,ipq9574-qusb2-phy";
>+			reg =3D <0x07b000 0x180>;
>+			#phy-cells =3D <0>;
>+
>+			clocks =3D <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
>+				<&xo_board_clk>;
>+			clock-names =3D "cfg_ahb", "ref";
>+
>+			resets =3D <&gcc GCC_QUSB2_0_PHY_BCR>;
>+			status =3D "disabled";
>+		};
>+
>+		ssphy_0: phy@7d000 {
>+			compatible =3D "qcom,ipq9574-qmp-usb3-phy";
>+			reg =3D <0x7d000 0x1c4>;
>+			#clock-cells =3D <1>;
>+			#address-cells =3D <1>;
>+			#size-cells =3D <1>;
>+			ranges;
>+
>+			clocks =3D <&gcc GCC_USB0_AUX_CLK>,
>+				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
>+			clock-names =3D "aux", "cfg_ahb";
>+
>+			resets =3D  <&gcc GCC_USB0_PHY_BCR>,
>+				 <&gcc GCC_USB3PHY_0_PHY_BCR>;
>+			reset-names =3D "phy","common";
>+			status =3D "disabled";
>+
>+			usb0_ssphy: phy@7d200 {
>+				reg =3D <0x0007d200 0x130>,	/* tx */
>+				      <0x0007d400 0x200>,	/* rx */
>+				      <0x0007d800 0x1f8>,	/* pcs  */
>+				      <0x0007d600 0x044>;	/* pcs misc */
>+				#phy-cells =3D <0>;
>+				clocks =3D <&gcc GCC_USB0_PIPE_CLK>;
>+				clock-names =3D "pipe0";
>+				clock-output-names =3D "usb0_pipe_clk";
>+			};
>+		};
>+
>+		usb3: usb3@8a00000 {
>+			compatible =3D "qcom,ipq9574-dwc3", "qcom,dwc3";
>+			reg =3D <0x8af8800 0x400>;
>+			#address-cells =3D <1>;
>+			#size-cells =3D <1>;
>+			ranges;
>+
>+			clocks =3D <&gcc GCC_SNOC_USB_CLK>,
>+				 <&gcc GCC_ANOC_USB_AXI_CLK>,
>+				 <&gcc GCC_USB0_MASTER_CLK>,
>+				 <&gcc GCC_USB0_SLEEP_CLK>,
>+				 <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>+
>+			clock-names =3D "sys_noc_axi",
>+				      "anoc_axi",
>+				      "master",
>+				      "sleep",
>+				      "mock_utmi";
>+
>+			assigned-clocks =3D <&gcc GCC_USB0_MASTER_CLK>,
>+					  <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>+			assigned-clock-rates =3D <200000000>,
>+					       <24000000>;
>+
>+			resets =3D <&gcc GCC_USB_BCR>;
>+			status =3D "disabled";
>+
>+			dwc_0: usb@8a00000 {
>+				compatible =3D "snps,dwc3";
>+				reg =3D <0x8a00000 0xcd00>;
>+				clocks =3D <&gcc GCC_USB0_MOCK_UTMI_CLK>;
>+				clock-names =3D "ref";
>+				interrupts =3D <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
>+				phys =3D <&qusb_phy_0>, <&usb0_ssphy>;
>+				phy-names =3D "usb2-phy", "usb3-phy";
>+				tx-fifo-resize;
>+				snps,is-utmi-l1-suspend;
>+				snps,hird-threshold =3D /bits/ 8 <0x0>;
>+				snps,dis_u2_susphy_quirk;
>+				snps,dis_u3_susphy_quirk;
>+				dr_mode =3D "host";
>+			};
>+		};
> 	};
>=20
> 	rpm-glink {

--=20
With best wishes
Dmitry
