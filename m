Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1E0673008
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjASEKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjASDs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:48:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05256CCC9;
        Wed, 18 Jan 2023 19:45:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E7BECCE1FC5;
        Thu, 19 Jan 2023 03:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB38C433EF;
        Thu, 19 Jan 2023 03:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674099836;
        bh=DtX/m8VS/oitQXmE/jhFHYHwqO3UAviNdSUK7AOwdZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gUHWG12ePwVF6r6UDyC3DWhmGA0CJo/JYRqzdIj5boHTf+f5tdPwBf3xk/7Q6ixPP
         hbK902v3f4hpK2iY4sLUObEyyFEbLJVvdt9DBRqhZUVk521Efd7suSs8gDEynSB0jp
         eHF5xvONJntaH0JcRDxsqk/4F18DbUH+PTGoLsjG2UjylrWoyqAqWkdseNsg3GzWTE
         Yh0J/UKKVHPwuoFjJXorq+HRMGmZIVH4MrG5QjtgSrxEVeEvoNvBaqhhfHruWX8eEI
         Y9gMI225k6CCN6XrKInKYGiHhMVJuoc6sTZG5HUdUdduew/DOw6Hvoe2DTps0oK97+
         xnn5+IszJalKQ==
Date:   Wed, 18 Jan 2023 21:43:52 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com
Subject: Re: [RFC v4 0/5] Add multiport support for DWC3 controllers
Message-ID: <20230119034352.stbhutga5ounihj7@builder.lan>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230115114146.12628-1-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 05:11:41PM +0530, Krishna Kurapati wrote:
> Currently the DWC3 driver supports only single port controller which
> requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
> DWC3 controller with multiple ports that can operate in host mode.
> Some of the port supports both SS+HS and other port supports only HS
> mode.
> 
> This change primarily refactors the Phy logic in core driver to allow
> multiport support with Generic Phy's.
> 
> Chananges have been tested on  QCOM SoC SA8295P which has 4 ports (2
> are HS+SS capable and 2 are HS only capable).
> 

I can confirm that applying this series allow me to use all 6 USB ports
on the ADP. Looking forward to v5.

Thanks,
Bjorn

> Changes in v4:
> Added DT support for SA8295p.
> 
> Changes in v3:
> Incase any PHY init fails, then clear/exit the PHYs that
> are already initialized.
> 
> Changes in v2:
> Changed dwc3_count_phys to return the number of PHY Phandles in the node.
> This will be used now in dwc3_extract_num_phys to increment num_usb2_phy 
> and num_usb3_phy.
> 
> Added new parameter "ss_idx" in dwc3_core_get_phy_ny_node and changed its
> structure such that the first half is for HS-PHY and second half is for
> SS-PHY.
> 
> In dwc3_core_get_phy, for multiport controller, only if SS-PHY phandle is
> present, pass proper SS_IDX else pass -1.
> 
> Link to v3: https://lore.kernel.org/all/1654709787-23686-1-git-send-email-quic_harshq@quicinc.com/#r
> Link to v2: https://lore.kernel.org/all/1653560029-6937-1-git-send-email-quic_harshq@quicinc.com/#r
> 
> Krishna Kurapati (5):
>   dt-bindings: usb: Add bindings to support multiport properties
>   usb: dwc3: core: Refactor PHY logic to support Multiport Controller
>   usb: dwc3: core: Do not setup event buffers for host only controllers
>   usb: dwc3: qcom: Add multiport controller support for qcom wrapper
>   arm: dts: msm: Add multiport controller node for usb
> 
>  .../devicetree/bindings/usb/snps,dwc3.yaml    |  42 ++-
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts      |  49 +++
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  60 ++++
>  drivers/usb/dwc3/core.c                       | 325 +++++++++++++-----
>  drivers/usb/dwc3/core.h                       |  15 +-
>  drivers/usb/dwc3/drd.c                        |  14 +-
>  drivers/usb/dwc3/dwc3-qcom.c                  |  28 +-
>  7 files changed, 429 insertions(+), 104 deletions(-)
> 
> -- 
> 2.39.0
> 
