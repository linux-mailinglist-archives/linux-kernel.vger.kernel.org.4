Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC97697757
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjBOH0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjBOH0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:26:22 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4731728222;
        Tue, 14 Feb 2023 23:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676445980; x=1707981980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1+BNIE0i1dEK/uDSABMSpkeF8y7fSo07sIK227mq4hc=;
  b=CYa1U0p9SLoNcwMr+38HqBfG00JAPWFpMhHHgUZwfb7ed5fpHylZmkIa
   aA6UDix2IGtQzgC4f0MVFcwyVzoxblgBztPY0GDTCXDr5aOW04gHrFgjT
   Ld9PzoSsH45u2lj6c0reVB6rHu19wNuao6cPALIrCsAHKSVDNEvlSxE4m
   EGpegAK3nKgLCUCc5nUyN3Tx0RvjwluCiCg2JpGCyRyE3FfdOWynXyXez
   Sllke0Egqvg046sZRZLvdOVg0Ka1uzjpwRHWdIUTN08vTjP6cY5v7Zi0w
   Yv+YdcpO/0eL4Puur05U4AREXkUAn6LvxH08exOlLBc/KbOMEGtt+IoBF
   w==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669071600"; 
   d="scan'208";a="29089230"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 15 Feb 2023 08:26:18 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 15 Feb 2023 08:26:18 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 15 Feb 2023 08:26:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676445978; x=1707981978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1+BNIE0i1dEK/uDSABMSpkeF8y7fSo07sIK227mq4hc=;
  b=cu0/bptZbw+Dv5TBOS0mrdI/r3GN9WeAcchDDl2pW08SCGO48jKn/rdE
   /gLQIMTYroCrc8l00eBOb6i0VtPVDKZQzGh/2xmEpGu+cBVdll8oRzI5U
   1kiM66FtD+jZU4WFMdTnNq1LacG6qtpwgWtjgi6ZMC+MopCXnlZwev72V
   rVXBhGQsRIbiOK+bs2rhfjIL2Q5OHqbZyLSR2Y713lkElQQZN4ahAqxas
   f7hbdj8WTcU7fFJlLS6zvKIm+oZJdJJ7/N8helyh+puNuASA5zINCJUEs
   Nt517mSCc0hyx/QiCa4U8SicshxrWC/N9qJme+7TQEHhIMzdj0Gfu8LF4
   g==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669071600"; 
   d="scan'208";a="29089229"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Feb 2023 08:26:18 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 21827280056;
        Wed, 15 Feb 2023 08:26:18 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Liu Ying <victor.liu@nxp.com>
Cc:     marex@denx.de, stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        krzysztof.kozlowski@linaro.org, LW@karo-electronics.de
Subject: Re: [PATCH v3 1/6] dt-bindings: lcdif: Add i.MX93 LCDIF support
Date:   Wed, 15 Feb 2023 08:26:16 +0100
Message-ID: <2551514.Lt9SDvczpP@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230213085612.1026538-2-victor.liu@nxp.com>
References: <20230213085612.1026538-1-victor.liu@nxp.com> <20230213085612.1026538-2-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

thanks for the update.

Am Montag, 13. Februar 2023, 09:56:07 CET schrieb Liu Ying:
> There is one LCDIF embedded in i.MX93 SoC to connect with
> MIPI DSI controller through LCDIF cross line pattern(controlled
> by mediamix blk-ctrl) or connect with LVDS display bridge(LDB)
> directly or connect with a parallel display through parallel
> display format(also controlled by mediamix blk-ctrl).  i.MX93
> LCDIF IP is essentially the same to i.MX8MP LCDIF IP.  Add device
> tree binding for i.MX93 LCDIF.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v2->v3:
> * No change.
>=20
> v1->v2:
> * Add Krzysztof's A-b and Marek's R-b tags on patch 1/6.
>=20
>  Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml index
> 75b4efd70ba8..fc11ab5fc465 100644
> --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> @@ -21,6 +21,7 @@ properties:
>            - fsl,imx28-lcdif
>            - fsl,imx6sx-lcdif
>            - fsl,imx8mp-lcdif
> +          - fsl,imx93-lcdif
>        - items:
>            - enum:
>                - fsl,imx6sl-lcdif
> @@ -88,7 +89,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: fsl,imx8mp-lcdif
> +            enum:
> +              - fsl,imx8mp-lcdif
> +              - fsl,imx93-lcdif
>      then:
>        properties:
>          clocks:
> @@ -107,6 +110,7 @@ allOf:
>                enum:
>                  - fsl,imx6sx-lcdif
>                  - fsl,imx8mp-lcdif
> +                - fsl,imx93-lcdif
>      then:
>        properties:
>          clocks:
> @@ -123,6 +127,7 @@ allOf:
>                - fsl,imx8mm-lcdif
>                - fsl,imx8mn-lcdif
>                - fsl,imx8mp-lcdif
> +              - fsl,imx93-lcdif
>      then:
>        required:
>          - power-domains

I would have expected that fsl,imx93-lcdif supports up to 3 endpoints (MIPI=
=20
DSI, LVDS, and parallel) in a 'ports' subnode. But this binding only suppor=
ts=20
a single 'port' sub-node. Also an example for this case might be very helpf=
ul.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


