Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231CD6F4346
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjEBMFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjEBMFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:05:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01865BA5;
        Tue,  2 May 2023 05:05:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 455196238C;
        Tue,  2 May 2023 12:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93155C4339B;
        Tue,  2 May 2023 12:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683029150;
        bh=pjosqgAvcJiDE8ocsFRuyjcgaSS47imfs2wX0R23ors=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgrMCZV3PZlTUxJtlLltDnGq8PpAFqsf3Cpf9J8cImNxENWE13YAYt/fm9H/81QgF
         u88v1rhOs2FgynKvqrkMA0JTGOq1ew7Ss4oLmiMy/ZOPctHcROxvgHgFMPogyAk+0g
         XX/vZPZX9knrHjscuxBRy3Haov7Ie7VvT63/puN6exZ7bQ1ErQQyLxwL1BfZp7Jj5c
         g5DjbazrYult8Hs3qRBcFFA3js3LEm8CnUj8xfrIB567Ti3whxP5gPqaOCZmHcEIrR
         Dgc0iaEWGC+GI0KWCIFEWhe1ukMl+RaSO37msxENCVvU1a+SOpL7QDWYME6ijziRv4
         qUscBxiY1BjWg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ptolV-0003eH-Di; Tue, 02 May 2023 14:05:53 +0200
Date:   Tue, 2 May 2023 14:05:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] phy: qcom-qmp-combo: Introduce drm_bridge
Message-ID: <ZFD8oQETtLuDH2Xg@hovoldconsulting.com>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-6-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425034010.3789376-6-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 08:40:08PM -0700, Bjorn Andersson wrote:
> The QMP combo PHY sits in an of_graph connected between the DisplayPort
> controller and a USB Type-C connector (or possibly a redriver).
> 
> The TCPM needs to be able to convey the HPD signal to the DisplayPort
> controller, but no directly link is provided by DeviceTree so the signal
> needs to "pass through" the QMP combo phy.
> 
> Handle this by introducing a drm_bridge which upon initialization finds
> the next bridge (i.e. the usb-c-connector) and chain this together. This
> way HPD changes in the connector will propagate to the DisplayPort
> driver.
> 
> The connector bridge is resolved lazily, as the TCPM is expected to be
> able to resolve the typec mux and switch at probe time, so the QMP combo
> phy will probe before the TCPM.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 36 +++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 5d6d6ef3944b..84bc08002537 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -22,6 +22,8 @@
>  #include <linux/usb/typec.h>
>  #include <linux/usb/typec_mux.h>
>  
> +#include <drm/drm_bridge.h>
> +
>  #include <dt-bindings/phy/phy-qcom-qmp.h>
>  
>  #include "phy-qcom-qmp.h"
> @@ -1332,6 +1334,8 @@ struct qmp_combo {
>  	struct clk_hw dp_link_hw;
>  	struct clk_hw dp_pixel_hw;
>  
> +	struct drm_bridge bridge;
> +
>  	struct typec_switch_dev *sw;
>  	enum typec_orientation orientation;
>  };
> @@ -3196,6 +3200,34 @@ static int qmp_combo_register_clocks(struct qmp_combo *qmp, struct device_node *
>  	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, dp_np);
>  }
>  
> +static int qmp_combo_bridge_attach(struct drm_bridge *bridge,
> +				   enum drm_bridge_attach_flags flags)
> +{
> +	struct qmp_combo *qmp = container_of(bridge, struct qmp_combo, bridge);
> +	struct drm_bridge *next_bridge;
> +
> +	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> +		return -EINVAL;
> +
> +	next_bridge = devm_drm_of_get_bridge(qmp->dev, qmp->dev->of_node, 0, 0);
> +	if (IS_ERR(next_bridge))
> +		return dev_err_probe(qmp->dev, PTR_ERR(next_bridge), "failed to acquire drm_bridge\n");

Using dev_err_probe() in an attach callback looks wrong as these
functions should not be returning -EPROBE_DEFER (and this is not a probe
function).

> +
> +	return drm_bridge_attach(bridge->encoder, next_bridge, bridge, DRM_BRIDGE_ATTACH_NO_CONNECTOR);

This line is over 100 chars, but there should be no reason not to break
it before 80 here.

> +}
> +
> +static const struct drm_bridge_funcs qmp_combo_bridge_funcs = {
> +	.attach	= qmp_combo_bridge_attach,
> +};
> +
> +static int qmp_combo_dp_register_bridge(struct qmp_combo *qmp)
> +{
> +	qmp->bridge.funcs = &qmp_combo_bridge_funcs;
> +	qmp->bridge.of_node = qmp->dev->of_node;
> +
> +	return devm_drm_bridge_add(qmp->dev, &qmp->bridge);
> +}

Guess you need a dummy function also for qmp_combo_dp_register_bridge()
in case of !CONFIG_DRM.

> +
>  static int qmp_combo_parse_dt_lecacy_dp(struct qmp_combo *qmp, struct device_node *np)
>  {
>  	struct device *dev = qmp->dev;
> @@ -3459,6 +3491,10 @@ static int qmp_combo_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = qmp_combo_dp_register_bridge(qmp);
> +	if (ret)
> +		return ret;
> +
>  	/* Check for legacy binding with child nodes. */
>  	usb_np = of_get_child_by_name(dev->of_node, "usb3-phy");
>  	if (usb_np) {

Johan
