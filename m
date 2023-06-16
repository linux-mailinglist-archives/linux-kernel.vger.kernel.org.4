Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93E9732B95
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbjFPJag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344706AbjFPJaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:30:09 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3182733;
        Fri, 16 Jun 2023 02:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686907797; x=1718443797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=32N1yGo7ctZs2eC7CuXCSbbaVed5l58bkGfloxPTIp4=;
  b=eCEN/Cg3pJShxTMm742vfMXOycmBsyMQiHrfwmUzSS870hmQbUqGkP3M
   nK+rCcu1DE2ttGfRB1Gas8jOaON2RYFAKEv2y/ySC358bUDAl/hsHe4yg
   xm2kVfcGf5u2f4XonFO5Y53+vqQehyeEB+KTgvnhVn27R6RQO7H/JEQQ2
   octK4umYTTuJnLtV5TkKaVhsi6539zu0UDpFtJFcd8g/yWoFGWP2MZsED
   5otrVsm8/ZDK/EjSAWo3La+FEKjahr99mhzcUNhdI5b8PWvu/a0t5uB29
   ibi3EphdKbIzKWWfCP9QTpgwApuqWokmhHHAKqeeUjkFZ/o6Ybl2nIU2s
   g==;
X-IronPort-AV: E=Sophos;i="6.00,247,1681164000"; 
   d="scan'208";a="31462582"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Jun 2023 11:29:55 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 63301280082;
        Fri, 16 Jun 2023 11:29:55 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, vkoul@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     oliver.brown@nxp.com, Sandor.yu@nxp.com, linux-imx@nxp.com,
        kernel@pengutronix.de, Sandor Yu <Sandor.yu@nxp.com>
Subject: Re: [PATCH v6 5/8] drm: bridge: Cadence: Add MHDP8501 HDMI driver
Date:   Fri, 16 Jun 2023 11:29:57 +0200
Message-ID: <11795277.nUPlyArG6x@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <ee0982418cc2e996b1f7889375b1a5138fb38a11.1686729444.git.Sandor.yu@nxp.com>
References: <cover.1686729444.git.Sandor.yu@nxp.com> <ee0982418cc2e996b1f7889375b1a5138fb38a11.1686729444.git.Sandor.yu@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandor,

thanks for sending a new version.

Am Donnerstag, 15. Juni 2023, 03:38:15 CEST schrieb Sandor Yu:
> Add a new DRM HDMI bridge driver for Cadence MHDP8501
> that used in Freescale i.MX8MQ SoC.
> MHDP8501 could support HDMI or DisplayPort standards according
> embedded Firmware running in the uCPU.
>=20
> For iMX8MQ SoC, the HDMI FW was loaded and activated by SOC ROM code.
> Bootload binary included HDMI FW was required for the driver.
>=20
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>  drivers/gpu/drm/bridge/cadence/Kconfig        |   12 +
>  drivers/gpu/drm/bridge/cadence/Makefile       |    1 +
>  .../drm/bridge/cadence/cdns-mhdp8501-hdmi.c   | 1024 +++++++++++++++++
>  3 files changed, 1037 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-hdmi.c
>=20
> diff --git a/drivers/gpu/drm/bridge/cadence/Kconfig
> b/drivers/gpu/drm/bridge/cadence/Kconfig index 5b7ec4e49aa1..bee05e834055
> 100644
> --- a/drivers/gpu/drm/bridge/cadence/Kconfig
> +++ b/drivers/gpu/drm/bridge/cadence/Kconfig
> @@ -59,3 +59,15 @@ config DRM_CDNS_MHDP8501_DP
>  	  Support Cadence MHDP8501 DisplayPort driver.
>  	  Cadence MHDP8501 Controller support one or more protocols,
>  	  DisplayPort firmware is required for this driver.
> +
> +config DRM_CDNS_MHDP8501_HDMI
> +	tristate "Cadence MHDP8501 HDMI DRM driver"
> +	select DRM_KMS_HELPER
> +	select DRM_PANEL_BRIDGE
> +	select DRM_DISPLAY_HELPER
> +	select DRM_CDNS_AUDIO
> +	depends on OF
> +	help
> +	  Support Cadence MHDP8501 HDMI driver.
> +	  Cadence MHDP8501 Controller support one or more protocols,
> +	  HDMI firmware is required for this driver.
> diff --git a/drivers/gpu/drm/bridge/cadence/Makefile
> b/drivers/gpu/drm/bridge/cadence/Makefile index 5842e4540c62..8a129c14ac14
> 100644
> --- a/drivers/gpu/drm/bridge/cadence/Makefile
> +++ b/drivers/gpu/drm/bridge/cadence/Makefile
> @@ -7,3 +7,4 @@ cdns-mhdp8546-y :=3D cdns-mhdp8546-core.o cdns-mhdp8546-h=
dcp.o
> cdns-mhdp8546-$(CONFIG_DRM_CDNS_MHDP8546_J721E) +=3D cdns-mhdp8546-j721e.o
>=20
>  obj-$(CONFIG_DRM_CDNS_MHDP8501_DP) +=3D cdns-mhdp8501-dp.o
> +obj-$(CONFIG_DRM_CDNS_MHDP8501_HDMI) +=3D cdns-mhdp8501-hdmi.o
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-hdmi.c
> b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-hdmi.c new file mode 100644
> index 000000000000..43673f1b50f6
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-hdmi.c
[...]
> +static int cdns_hdmi_bridge_attach(struct drm_bridge *bridge,
> +				 enum drm_bridge_attach_flags flags)
> +{
> +	struct cdns_mhdp_device *mhdp =3D bridge->driver_private;
> +	struct drm_mode_config *config =3D &bridge->dev->mode_config;
> +	struct drm_encoder *encoder =3D bridge->encoder;
> +	struct drm_connector *connector =3D &mhdp->connector;
> +
> +	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
> +		connector->interlace_allowed =3D 0;
> +		connector->polled =3D DRM_CONNECTOR_POLL_HPD;
> +
> +		drm_connector_helper_add(connector,=20
&cdns_hdmi_connector_helper_funcs);
> +
> +		drm_connector_init(bridge->dev, connector,=20
&cdns_hdmi_connector_funcs,
> +				   DRM_MODE_CONNECTOR_HDMIA);
> +
> +		drm_object_attach_property(&connector->base,
> +					   config-
>hdr_output_metadata_property, 0);
> +
> +		if (!drm_mode_create_hdmi_colorspace_property(connector))

This is missing a 2nd parameter.

> +			drm_object_attach_property(&connector->base,
> +						connector-
>colorspace_property, 0);
> +
> +		drm_connector_attach_encoder(connector, encoder);
> +	}
> +
> +	return 0;
> +}
[...]

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


