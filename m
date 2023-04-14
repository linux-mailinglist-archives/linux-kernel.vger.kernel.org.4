Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EADF6E273A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjDNPqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjDNPqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:46:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F013E3A9C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681487133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ntFhRK7YK6RZBFuf1XKMu9P/ROVc9nlQCbHsKHmy5Eo=;
        b=FvVgt89Fr1Z0JnMQzJgwEjc7T0XGwTiQWJENDd8nTTPYHqynn2e71JVVsyInTCip+JLS/L
        cTvfedaWR7F1NpNff+Flg9w327aT9IXi1BicjmxYneQY5iIjUz5jB8j7Yp000MXU9v1Snj
        sK37BQwj2HnhrKb7a3iwGiP1cOQyAS4=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-LXhKXqNZN1OAMiyGdcuIVw-1; Fri, 14 Apr 2023 11:45:32 -0400
X-MC-Unique: LXhKXqNZN1OAMiyGdcuIVw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1842f32da75so9801961fac.23
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681487131; x=1684079131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntFhRK7YK6RZBFuf1XKMu9P/ROVc9nlQCbHsKHmy5Eo=;
        b=PQ00hcUEHAo8tuGSQFycthU/BG8H3HjP/lHtpP8KXdVawrTvMeoLgE+P1rZXhirSU8
         0GQ1pXC5upUWIjII1DGLn0hij6p2X8eMYUpt0NxherWEgoNXXYjM9ixiaAKc7n/G2Kl3
         tulTVlzaFZXATaS7UjKuPU6GrpbCFAxriJSvTxI4VqJpufcAt/VI5+cxrlvAbrtkjyWa
         +xyC75QNJeEmcA8+OS3y/hi0iUmAwhR8AgnnsxGfSasIeazXaTQkapZ43Y3CjA2x4Dik
         746mTKMxZW+i0pTOmWuVVHmfSNQmZd896qyxANP+0wrAgHCk35PsYAK9nDOLXyW1FcrJ
         H9xw==
X-Gm-Message-State: AAQBX9dLBdtDDZ5i7pkgJnpETfZyI4q1ip31eLYnymYMNGuNOxcZi8+Z
        MRAU/mCPYnzFo8IlIXgJsOsdj6agTaCRurTCD/6R3rxOltmYigNS7D3m8c0mpY7JvnkMB3fF9VY
        ECkN9bRp4PMo7rSL26PAkkJg+
X-Received: by 2002:a05:6808:1416:b0:38c:4f8b:9b53 with SMTP id w22-20020a056808141600b0038c4f8b9b53mr723663oiv.44.1681487131323;
        Fri, 14 Apr 2023 08:45:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350aM1E0hQumIIqX/xpL8i7+Bxzwh+LCf5RpzG+zNMOHmuiyqHTvwGGH6vqXTSIWdmY4/KiCQLA==
X-Received: by 2002:a05:6808:1416:b0:38c:4f8b:9b53 with SMTP id w22-20020a056808141600b0038c4f8b9b53mr723627oiv.44.1681487130936;
        Fri, 14 Apr 2023 08:45:30 -0700 (PDT)
Received: from halaney-x13s (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id c15-20020a544e8f000000b0038bf8c6151fsm1796337oiy.6.2023.04.14.08.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 08:45:30 -0700 (PDT)
Date:   Fri, 14 Apr 2023 10:45:27 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        quic_harshq@quicinc.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v6 6/8] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Message-ID: <20230414154527.vsjtgtfsd5kc7vww@halaney-x13s>
References: <20230405125759.4201-1-quic_kriskura@quicinc.com>
 <20230405125759.4201-7-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405125759.4201-7-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 06:27:57PM +0530, Krishna Kurapati wrote:
> Add USB and DWC3 node for tertiary port of SC8280 along with multiport
> IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
> platforms.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
> Link to v5: https://lore.kernel.org/all/20230310163420.7582-7-quic_kriskura@quicinc.com/
> 
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 58 ++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 42bfa9fa5b96..7b81f2b0449d 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -3108,6 +3108,64 @@ usb_1_role_switch: endpoint {
>  			};
>  		};
>  
> +		usb_2: usb@a4f8800 {
> +			compatible = "qcom,sc8280xp-dwc3", "qcom,dwc3";
> +			reg = <0 0x0a4f8800 0 0x400>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_CFG_NOC_USB3_MP_AXI_CLK>,
> +				 <&gcc GCC_USB30_MP_MASTER_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_MP_AXI_CLK>,
> +				 <&gcc GCC_USB30_MP_SLEEP_CLK>,
> +				 <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
> +				 <&gcc GCC_AGGRE_USB_NOC_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_USB_NOC_NORTH_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_USB_NOC_SOUTH_AXI_CLK>,
> +				 <&gcc GCC_SYS_NOC_USB_AXI_CLK>;
> +			clock-names = "cfg_noc", "core", "iface", "sleep", "mock_utmi",
> +				      "noc_aggr", "noc_aggr_north", "noc_aggr_south", "noc_sys";
> +
> +			assigned-clocks = <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_MP_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <200000000>;
> +
> +			interrupts-extended = <&pdc 127 IRQ_TYPE_EDGE_RISING>,
> +						<&pdc 126 IRQ_TYPE_EDGE_RISING>,
> +						<&pdc 16 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-names = "dp_hs_phy_irq", "dm_hs_phy_irq",
> +						"ss_phy_irq";
> +

This is breaking the current schema (with the full series applied),
I am not sure if a pwr_event IRQ exists or but it maybe necessary to
modify qcom,dwc3.yaml in order to explain hardware if it doesn't exist:

(dtschema) ahalaney@halaney-x13s ~/git/linux-next (git)-[718f2024524f] % make CHECK_DTBS=y DT_SCHEMA_FILES=/usb/qcom,dwc3.yaml qcom/sa8540p-ride.dtb                                                                                   :(
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK arch/arm64/boot/dts/qcom/sa8540p-ride.dtb
/home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8540p-ride.dtb: usb@a4f8800: interrupt-names:0: 'pwr_event' was expected
	From schema: /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
/home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8540p-ride.dtb: usb@a4f8800: interrupt-names:1: 'dp_hs_phy_irq' was expected
	From schema: /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
/home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8540p-ride.dtb: usb@a4f8800: interrupt-names:2: 'dm_hs_phy_irq' was expected
	From schema: /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
/home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8540p-ride.dtb: usb@a4f8800: interrupt-names: ['dp_hs_phy_irq', 'dm_hs_phy_irq', 'ss_phy_irq'] is too short
	From schema: /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
/home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8540p-ride.dtb: usb@a4f8800: interrupts-extended: [[99, 127, 1], [99, 126, 1], [99, 16, 4]] is too short
	From schema: /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
make CHECK_DTBS=y DT_SCHEMA_FILES=/usb/qcom,dwc3.yaml qcom/sa8540p-ride.dtb  22.61s user 0.54s system 99% cpu 23.172 total
(dtschema) ahalaney@halaney-x13s ~/git/linux-next (git)-[718f2024524f] %

Thanks,
Andrew

