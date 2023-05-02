Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4696F43D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjEBM0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjEBM02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:26:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B3EE6A;
        Tue,  2 May 2023 05:26:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13B98623D1;
        Tue,  2 May 2023 12:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B614C433EF;
        Tue,  2 May 2023 12:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683030386;
        bh=+tUawv5EiBg4sqiRbzAHZDe9om3TRYdvWox2tHvlSzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGHceCY6xP7mDbZltsp5coAmNywdFwO3NYphny/G+DLVhtX3SpVVcIBBvo9MIfDSO
         Tre5lOjjXPdwLrYugKH+/Ay6m4KlEJXKFPuLrFbVPkHzYAwTQnyja7/bwSqMSqDyTr
         J+U1GK9IekqBukX1SDRrZy996kb8DOFc6Cxa9nhWHXWxZWUBLUUX02Pb1I3bwU/lOe
         pXK00VzQJK4mA4IE/TAHIhVnWc4PwKoYWUj8/Azhzae1tldMT9FI8h+VFOY890iGFo
         plUE8p6r2qoP82JsYPRcfHPoz4mGC3Jz95/P4WxUySlPJrZzkFYVF7SVL2u4kmVeyc
         hCceoQgLWTjmw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ptp5R-0003n8-Gn; Tue, 02 May 2023 14:26:29 +0200
Date:   Tue, 2 May 2023 14:26:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] phy: qcom-qmp-combo: Support orientation switching
Message-ID: <ZFEBdT4Yh4fBItHk@hovoldconsulting.com>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 08:40:03PM -0700, Bjorn Andersson wrote:
> This adds support for USB and DisplayPort orientation switching to the
> QMP combo PHY, as well as updating the sc8280xp devices to include the
> QMP in the SuperSpeed graph.

Nice and clean series!

I've tested it a bit on the X13s and verified that DP works on both
ports and in both orientations. Coldplug also appears to work reliably.

Tested-by: Johan Hovold <johan+linaro@kernel.org>	# X13s

> Bjorn Andersson (7):
>   dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add ports and
>     orientation-switch
>   phy: qcom-qmp-combo: Move phy_mutex out of com_init/exit
>   phy: qcom-qmp-combo: Introduce orientation variable
>   phy: qcom-qmp-combo: Introduce orientation switching
>   phy: qcom-qmp-combo: Introduce drm_bridge
>   arm64: dts: qcom: sc8280xp-crd: Add QMP to SuperSpeed graph
>   arm64: dts: qcom: sc8280xp-x13s: Add QMP to SuperSpeed graph
> 
>  .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    |  51 ++++
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  28 ++-
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  28 ++-
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  34 +++
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 227 ++++++++++++++----
>  5 files changed, 309 insertions(+), 59 deletions(-)

Johan
