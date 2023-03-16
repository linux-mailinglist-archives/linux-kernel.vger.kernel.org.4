Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4F16BC643
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCPGqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCPGqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:46:09 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A5C59F3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:46:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso599427pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678949166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pKRA4Nz16THcP4sOVr9xZNPpLk0Z9Kp3Pw1+X+MGR3Q=;
        b=ZuSVXVXdO4U3ZAXsrC2uqDYK06EKuhK1k12cghZZQ/MaOZDaKD4Vqj6rbqoYW/yeCZ
         tgBYihRPS4EFXMaF/xWNc4v7DzAgrWYVpANQvL0viIykfXraVcUNR2kCCaEKkMhgrW3C
         2T6aHn9Er3ecYLX6xmjGQRPuuEUqDAjgvAWMenjB6sxP+O7B3Cyaq4gE/JS2NJYHBoGV
         1i0Gz5GTAP27sIGBV3I0lK8vt9eQjyYePIQHp9eJLTKN3wQ9pdJsBKcNMI5DeDSnjICf
         ijupi8SPC2FtWhstb2glgbTTl/ee/kbTSMJxWFmiXj6MuuSIncoWhyIH4WxCtMbtKTAC
         lCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678949166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKRA4Nz16THcP4sOVr9xZNPpLk0Z9Kp3Pw1+X+MGR3Q=;
        b=bib7P0SFLkHdS3eQ5tv3jzJGRWF0QwcUxsHP/jWohNsFcaUU0Z0JPR7q74QZk63uQS
         9Jj08oxeoxCvzmNdkDYQ2/12Ctlm4xxK3wHdNbWXvZPRSeiSuAclKYUER1+GMvw245i2
         E3kaimFG4fbTyPbIjp/uARqKtmsMYGEYj7Zrkkf4CBGBUMwRnWLG6W637kahWEmHiRfm
         sMYAZKHYCUgNFdMcagI1f6lbg2yjVc/aN5Y9187tqPGdshLdDaQeqDMHWvTddNPEW3jD
         Wrvm/ld0MEEy3rueSXwuIGhoMSA4BGu4ROLKA+sYkEbQFgEz9J/jQ+AhaL4Ungu0fi69
         XPHg==
X-Gm-Message-State: AO0yUKUu5Ndg81GRzJb1eyMRs0O7lwhz3yhm+a6gzlZ+f1fukE85N/sC
        8dojLS3R9GDVP+2keGkbtq3z
X-Google-Smtp-Source: AK7set8MD9xflVVWo3JfFq3UaAA07K7hytq4ujFV5zacXikVZC/lVO5VJ4TXzZ2jrcMPCq6KgVkd+g==
X-Received: by 2002:a17:902:ceca:b0:1a1:86c9:e30b with SMTP id d10-20020a170902ceca00b001a186c9e30bmr2455933plg.53.1678949165967;
        Wed, 15 Mar 2023 23:46:05 -0700 (PDT)
Received: from thinkpad ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id kp8-20020a170903280800b0019ee042602bsm4748980plb.92.2023.03.15.23.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 23:46:05 -0700 (PDT)
Date:   Thu, 16 Mar 2023 12:15:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Georgi Djakov <djakov@kernel.org>
Subject: Re: [PATCH 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Message-ID: <20230316064557.GB4386@thinkpad>
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <6b8d17006d8ee9a1b0c4df803c1cc7caf53ea3ef.1677749625.git.quic_varada@quicinc.com>
 <CAA8EJprbMybV0o1-436yLhVnnEX6qywrj=JmWDCL5usaH0DXiQ@mail.gmail.com>
 <61e8c730-e46d-728d-d770-f1ead4405d12@quicinc.com>
 <83184da4-b183-3271-983f-3a1a62fb9f1a@linaro.org>
 <365f2609-d3b4-df23-5b6e-7a190815a640@quicinc.com>
 <47b591c0-2f68-429d-6d1b-fa8b701785ac@linaro.org>
 <20230316063009.GA29961@varda-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230316063009.GA29961@varda-linux.qualcomm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 12:00:09PM +0530, Varadarajan Narayanan wrote:
> Dmitry,
> 
> On Tue, Mar 07, 2023 at 01:49:40PM +0200, Dmitry Baryshkov wrote:
> > On 07/03/2023 08:36, Varadarajan Narayanan wrote:
> > >
> > >On 3/6/2023 5:21 PM, Dmitry Baryshkov wrote:
> > >>On 06/03/2023 13:26, Varadarajan Narayanan wrote:
> > >>>Dmitry,
> > >>>
> > >>>On 3/2/2023 9:52 PM, Dmitry Baryshkov wrote:
> > >>>>On Thu, 2 Mar 2023 at 11:57, Varadarajan Narayanan
> > >>>><quic_varada@quicinc.com> wrote:
> > >>>>>Add USB phy and controller related nodes
> > >>>>>
> > >>>>>Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > >>>>>---
> > >>>>>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 92
> > >>>>>+++++++++++++++++++++++++++++++++++
> > >>>>>  1 file changed, 92 insertions(+)
> > >>>>>
> > >>>>>diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > >>>>>b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > >>>>>index 2bb4053..319b5bd 100644
> > >>>>>--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > >>>>>+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > >>
> > >>[skipped]
> > >>
> > >>
> > >>>>>+               usb3: usb3@8A00000 {
> > >>>>You know the drill. This node is in the wrong place.
> > >>>>
> > >>>>>+                       compatible = "qcom,dwc3";
> > >>>>>+                       reg = <0x8AF8800 0x400>;
> > >>>>>+                       #address-cells = <1>;
> > >>>>>+                       #size-cells = <1>;
> > >>>>>+                       ranges;
> > >>>>>+
> > >>>>>+                       clocks = <&gcc GCC_SNOC_USB_CLK>,
> > >>>>>+                               <&gcc GCC_ANOC_USB_AXI_CLK>,
> > >>>>>+                               <&gcc GCC_USB0_MASTER_CLK>,
> > >>>>>+                               <&gcc GCC_USB0_SLEEP_CLK>,
> > >>>>>+                               <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> > >>>>>+
> > >>>>>+                       clock-names = "sys_noc_axi",
> > >>>>>+                               "anoc_axi",
> > >>>>>+                               "master",
> > >>>>>+                               "sleep",
> > >>>>>+                               "mock_utmi";
> > >>>>Please fix the indentation of the lists.
> > >>>>
> > >>>>>+
> > >>>>>+                       assigned-clocks = <&gcc GCC_SNOC_USB_CLK>,
> > >>>>>+                                         <&gcc GCC_ANOC_USB_AXI_CLK>,
> > >>>>Why do you assign clock rates to the NOC clocks? Should they be set
> > >>>>using the interconnect instead?
> > >>>
> > >>>The SNOC and ANOC run at a fixed speed of 350MHz and 342MHz
> > >>>respectively and are not scaled. These clocks are for the interface
> > >>>between the USB block and the SNOC/ANOC. Do we still need to use
> > >>>interconnect?
> > >>
> > >>Maybe I misunderstand something here. If the snoc and anoc speeds are at
> > >>350 MHz and 342 MHz, why do you assign clock-rates of 200 MHz?
> > >>
> > >>Is it enough to call clk_prepare_enable() for these clocks or the rate
> > >>really needs to be set?
> > >
> > >The rate of 200MHz is not being set for the SNOC/ANOC. It is for the
> > >NIU that connects the USB and SNOC/ANOC. The reason for setting the
> > >rate to 200MHz is to configure the RCG parent for these interface
> > >clocks. That said can we configure this RCG standalone in the driver
> > >and enable these clocks?
> >
> > We discussed this separately with Georgi Djakov. Let me quote his IRC
> > message: "it sounds like this is for USB port that connects to the NOC. if
> > bandwidth scaling is not needed (or other interconnect configuration), then
> > maybe this can go without interconnect provider driver."
> >
> > However as we discover more and more about this platform (e.g. PCIe using
> > the aggre_noc region to setup some magic registers, see [1]), I'm more and
> > more biased towards suggesting implementing the interconnect driver to setup
> > all these tiny little things. With the DT tree being an ABI, it is much
> > preferable to overestimate the needs rather than underestimating them (and
> > having to cope with the backwards compatibility issues).
> >
> > Generally I think that PCIe/USB/whatever should not poke into NoC registers
> > or NoC/NIU clocks directly (because this is a very platform-specific item).
> > Rather than that it should tell the icc/opp/whatever subsystem, "please
> > configure the SoC for me to work".
> >
> > [1] https://lore.kernel.org/linux-arm-msm/30cf9717-dcca-e984-c506-c71b7f8e32cd@quicinc.com/
> 
> Dmitry,
> Can we remove the interconnect clocks in the next patch
> version (and assume that the boot loader configures them)?
> 
> And add these clocks once the interconnect support is available.
> 

Yes, that should work. If you do not care about interconnect scaling, then let
the bootloader set whatever fixed bandwidth is required for the peripherals.

Thinking from the usecase perspective of these router chipsets, you won't need
interconnect provider driver as of now.

Thanks,
Mani

> Thanks
> Varada
> 
> >
> > >
> > >Thanks
> > >Varada
> > >
> > >
> > >>
> > >>
> > >>>
> > >>>>>+ <&gcc GCC_USB0_MASTER_CLK>,
> > >>>>>+                                         <&gcc
> > >>>>>GCC_USB0_MOCK_UTMI_CLK>;
> > >>>>>+                       assigned-clock-rates = <200000000>,
> > >>>>>+ <200000000>,
> > >>>>>+ <200000000>,
> > >>>>>+ <24000000>;
> > >>>>>+
> > >>>>>+                       resets = <&gcc GCC_USB_BCR>;
> > >>>>>+                       status = "disabled";
> > >>>>>+
> > >>>>>+                       dwc_0: dwc3@8A00000 {
> > >>>>>+                               compatible = "snps,dwc3";
> > >>>>>+                               reg = <0x8A00000 0xcd00>;
> > >>>>>+                               clock-names = "ref";
> > >>>>>+                               clocks = <&gcc
> > >>>>>GCC_USB0_MOCK_UTMI_CLK>;
> > >>>>clocks before clock-names
> > >>>>
> > >>>>>+ interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> > >>>>>+                               phys = <&qusb_phy_0>, <&usb0_ssphy>;
> > >>>>>+                               phy-names = "usb2-phy", "usb3-phy";
> > >>>>>+                               tx-fifo-resize;
> > >>>>>+                               snps,dis_ep_cache_eviction;
> > >>>>>+                               snps,is-utmi-l1-suspend;
> > >>>>>+                               snps,hird-threshold = /bits/ 8 <0x0>;
> > >>>>>+                               snps,dis_u2_susphy_quirk;
> > >>>>>+                               snps,dis_u3_susphy_quirk;
> > >>>>>+ snps,quirk-frame-length-adjustment = <0x0A87F0A0>;
> > >>>>>+                               dr_mode = "host";
> > >>>>>+                       };
> > >>>>>+               };
> > >>>>>+
> > >>>>>                 pcie0_phy: phy@84000 {
> > >>>>>                         compatible =
> > >>>>>"qcom,ipq9574-qmp-gen3x1-pcie-phy";
> > >>>>>                         reg = <0x00084000 0x1bc>; /* Serdes PLL */
> > >>>>>--
> > >>>>>2.7.4
> > >>>
> > >>>Will address these and post a new revision.
> > >>>
> > >>>Thanks
> > >>>
> > >>>Varada
> > >>>
> > >>
> >
> > --
> > With best wishes
> > Dmitry
> >

-- 
மணிவண்ணன் சதாசிவம்
