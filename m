Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47D87021C1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 04:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbjEOCgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 22:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbjEOCgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 22:36:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFB110F3;
        Sun, 14 May 2023 19:36:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48A6460F57;
        Mon, 15 May 2023 02:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513FEC433EF;
        Mon, 15 May 2023 02:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684118197;
        bh=/3QYM4VEPV59xXf0yiNFF12gZIjhplj+fBoVniSTVlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBbOMyIVfhwdlx2H4ZEXI5ZammVxYzyeWCXo9vJHdL44ZwgYRMuXEO2zvmLIOBpke
         8sVvOHWKNTMWNTpC4Ei5FB4iJXMgfGV+N6llX85Lka3t5OEyftSz2ZaBZbMbynW8ey
         7HG2GOl/WbgS8B22kf8aAf/uq5jpZ3jWpyOU67qU0lLFpd2lb9SBA5Abpwsyy9eCzB
         TlQ/fFsMzLrQqWaR1dASY4mlYLreITVuUj/0PIdKLApDurV8r1OxKmAxbULqgD07P3
         Y5i01Lbn5u/y3UkwZuK9iwLVbloFI9PaLrupQTbgzcRwL/1LGXgiVco0XByqbszlN7
         yErzO/6OabAPA==
Date:   Sun, 14 May 2023 19:40:29 -0700
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
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v8 0/9] Add multiport support for DWC3 controllers
Message-ID: <20230515024029.3s7bm5iiktzcfzy2@ripper>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514054917.21318-1-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 11:19:08AM +0530, Krishna Kurapati wrote:
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

I'm able to detect my USB stick on all 4 ports on the sa8295p adp.

Tested-by: Bjorn Andersson <andersson@kernel.org>

Thanks,
Bjorn

> Changes in v8:
> Reorganised code in patch-5
> Fixed nitpicks in code according to comments received on v7
> Fixed indentation in DT patches
> Added drive strength for pinctrl nodes in SA8295 DT
> 
> Changes in v7:
> Added power event irq's for Multiport controller.
> Udpated commit text for patch-9 (adding DT changes for enabling first
> port of multiport controller on sa8540-ride).
> Fixed check-patch warnings for driver code.
> Fixed DT binding errors for changes in snps,dwc3.yaml
> Reabsed code on top of usb-next
> 
> Changes in v6:
> Updated comments in code after.
> Updated variables names appropriately as per review comments.
> Updated commit text in patch-2 and added additional info as per review
> comments.
> The patch header in v5 doesn't have "PATHCH v5" notation present. Corrected
> it in this version.
> 
> Changes in v5:
> Added DT support for first port of Teritiary USB controller on SA8540-Ride
> Added support for reading port info from XHCI Extended Params registers.
> 
> Changes in RFC v4:
> Added DT support for SA8295p.
> 
> Changes in RFC v3:
> Incase any PHY init fails, then clear/exit the PHYs that
> are already initialized.
> 
> Changes in RFC v2:
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
> Link to v7: https://lore.kernel.org/all/20230501143445.3851-1-quic_kriskura@quicinc.com/
> Link to v6: https://lore.kernel.org/all/20230405125759.4201-1-quic_kriskura@quicinc.com/
> Link to v5: https://lore.kernel.org/all/20230310163420.7582-1-quic_kriskura@quicinc.com/
> Link to RFC v4: https://lore.kernel.org/all/20230115114146.12628-1-quic_kriskura@quicinc.com/
> Link to RFC v3: https://lore.kernel.org/all/1654709787-23686-1-git-send-email-quic_harshq@quicinc.com/#r
> Link to RFC v2: https://lore.kernel.org/all/1653560029-6937-1-git-send-email-quic_harshq@quicinc.com/#r
> 
> Test results:
> 
> Bus 3/4 represent multiport controller having 4 HS ports and 2 SS ports.
> 
> / # dmesg |grep hub
> [    0.029029] usbcore: registered new interface driver hub
> [    1.372812] hub 1-0:1.0: USB hub found
> [    1.389142] hub 1-0:1.0: 1 port detected
> [    1.414721] hub 2-0:1.0: USB hub found
> [    1.427669] hub 2-0:1.0: 1 port detected
> [    2.931465] hub 3-0:1.0: USB hub found
> [    2.935340] hub 3-0:1.0: 4 ports detected
> [    2.948721] hub 4-0:1.0: USB hub found
> [    2.952604] hub 4-0:1.0: 2 ports detected
> / #
> / # lsusb
> Bus 003 Device 001: ID 1d6b:0002
> Bus 001 Device 001: ID 1d6b:0002
> Bus 003 Device 005: ID 0b0e:0300
> Bus 003 Device 002: ID 046d:c077
> Bus 004 Device 001: ID 1d6b:0003
> Bus 002 Device 001: ID 1d6b:0003
> Bus 003 Device 004: ID 03f0:0024
> Bus 003 Device 003: ID 046d:c016
> 
> Krishna Kurapati (9):
>   dt-bindings: usb: qcom,dwc3: Add bindings for SC8280 Multiport
>   dt-bindings: usb: Add bindings for multiport properties on DWC3
>     controller
>   usb: dwc3: core: Access XHCI address space temporarily to read port
>     info
>   usb: dwc3: core: Skip setting event buffers for host only controllers
>   usb: dwc3: core: Refactor PHY logic to support Multiport Controller
>   usb: dwc3: qcom: Add multiport controller support for qcom wrapper
>   arm64: dts: qcom: sc8280xp: Add multiport controller node for SC8280
>   arm64: dts: qcom: sa8295p: Enable tertiary controller and its 4 USB
>     ports
>   arm64: dts: qcom: sa8540-ride: Enable first port of tertiary usb
>     controller
> 
>  .../devicetree/bindings/usb/qcom,dwc3.yaml    |  22 +
>  .../devicetree/bindings/usb/snps,dwc3.yaml    |  13 +-
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts      |  52 +++
>  arch/arm64/boot/dts/qcom/sa8540p-ride.dts     |  22 +
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  66 +++
>  drivers/usb/dwc3/core.c                       | 389 +++++++++++++++---
>  drivers/usb/dwc3/core.h                       |  28 +-
>  drivers/usb/dwc3/drd.c                        |  13 +-
>  drivers/usb/dwc3/dwc3-qcom.c                  |  28 +-
>  9 files changed, 543 insertions(+), 90 deletions(-)
> 
> -- 
> 2.40.0
> 
