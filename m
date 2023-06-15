Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955C4731DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjFOQdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjFOQdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:33:15 -0400
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242E7211D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=kRWfxKU6iLOyQwwGx2ME57rRsTmS+Y/mv8gYh4DhOyg=;
        b=okJlCJ3JHQ3+H0XLiMBf0glJchvuuMsEcUCgzmvJnyKMoDMx5KHnSTtuAyw0+6C02Fj+PIczYsQAb
         1sJXFppRbmiGQviCKIb6gD9tGzLEdywy9YByMgoeRCa84fyqZkmGszeCCOuLk+544Y+QNzLZKDM87E
         R+MDZJ4STSxW54XyqvVk2jeDkTM+7hDVzHkzZIH7HZecVf7PLr7GF7PWoIRiAkQPtxs1vJ7iZjPeUI
         8aMMfkVKa1VnG0CWOwYTNA76VeemsnDscjlKWyMSZ0Wyx32wByG6pAy08mMt1KyZN9XMciIJhmstwO
         20X+A/bkr4Y7SdFgKgk+vxuxgnP+UnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=kRWfxKU6iLOyQwwGx2ME57rRsTmS+Y/mv8gYh4DhOyg=;
        b=XINu3AbpGKXRusYWTJ6IxnhI3JYWGjV1+42EsWbHmdUP4+C57+XyPjz9QZOcgglPnTa8mYWRY3EwX
         WRTXCTvAw==
X-HalOne-ID: 4f77e8bb-0b9a-11ee-8d88-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id 4f77e8bb-0b9a-11ee-8d88-b90637070a9d;
        Thu, 15 Jun 2023 16:33:10 +0000 (UTC)
Date:   Thu, 15 Jun 2023 18:33:08 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Sandor Yu <Sandor.yu@nxp.com>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, vkoul@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, oliver.brown@nxp.com,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: Re: [PATCH v6 3/8] drm: bridge: Cadence: Add MHDP8501 DP driver
Message-ID: <20230615163308.GA1588386@ravnborg.org>
References: <cover.1686729444.git.Sandor.yu@nxp.com>
 <67f54be91e91f6291c4ad3f5155598d699b8bc09.1686729444.git.Sandor.yu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f54be91e91f6291c4ad3f5155598d699b8bc09.1686729444.git.Sandor.yu@nxp.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandor,

On Thu, Jun 15, 2023 at 09:38:13AM +0800, Sandor Yu wrote:
> Add a new DRM DisplayPort bridge driver for Candence MHDP8501
> used in i.MX8MQ SOC. MHDP8501 could support HDMI or DisplayPort
> standards according embedded Firmware running in the uCPU.
> 
> For iMX8MQ SOC, the DisplayPort FW was loaded and activated by SOC
> ROM code. Bootload binary included HDMI FW was required for the driver.

The bridge driver supports creating a connector, but is this really
necessary?

This part:
> +static const struct drm_connector_funcs cdns_dp_connector_funcs = {
> +	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.destroy = drm_connector_cleanup,
> +	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static const struct drm_connector_helper_funcs cdns_dp_connector_helper_funcs = {
> +	.get_modes = cdns_dp_connector_get_modes,
> +};
> +
> +static int cdns_dp_bridge_attach(struct drm_bridge *bridge,
> +				 enum drm_bridge_attach_flags flags)
> +{
> +	struct cdns_mhdp_device *mhdp = bridge->driver_private;
> +	struct drm_encoder *encoder = bridge->encoder;
> +	struct drm_connector *connector = &mhdp->connector;
> +	int ret;
> +
> +	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
> +		connector->interlace_allowed = 0;
> +
> +		connector->polled = DRM_CONNECTOR_POLL_HPD;
> +
> +		drm_connector_helper_add(connector, &cdns_dp_connector_helper_funcs);
> +
> +		drm_connector_init(bridge->dev, connector, &cdns_dp_connector_funcs,
> +				   DRM_MODE_CONNECTOR_DisplayPort);
> +
> +		drm_connector_attach_encoder(connector, encoder);
> +	}

Unless you have a display driver that do not create their own connector
then drop the above and error out if DRM_BRIDGE_ATTACH_NO_CONNECTOR is
not set.
It is encouraged that display drivers create their own connector.

This was the only detail I looked for in the driver, I hope some else
volunteer to review it.

	Sam
