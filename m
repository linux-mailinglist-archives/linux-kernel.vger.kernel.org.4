Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6116977AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjBOHzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjBOHze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:55:34 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DE629E18;
        Tue, 14 Feb 2023 23:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676447732; x=1707983732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WflJ5FrfNUOX+nPHvzKmR7kLVTUVtVMrv41kl6P0qxU=;
  b=W+GaYUT6QKU7cs1KmpJ/pzbP5giG9m/qguwL9P9t6GCBoK62SQuAKReh
   SH1M0MPWtvj6Y2SQew5WvfLGaGDiY0c1zTIQZoKDMBqxNBzL+BUzpm4E8
   z4M5HMbPB3FPzs4flJZ/6aLLrSLonLT44H4vjyZwi2K47H4/caPy5zbjb
   agZnJ/6PZdoxx0vwBk8cWsLiAtX5scoZ13smdCT7SvOWAwN+QEUJXeHot
   JBiy9XrV9MGYCKg8OlXEU5VugCsDa2mCbcP/gr0SWN7QGcosOkLTBRx20
   VzYhzz2fcQN+qXVXA/yh+SuzoPWd5aii8i1fW0FobVpb0vjZL9WZ++S2E
   g==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669071600"; 
   d="scan'208";a="29090210"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 15 Feb 2023 08:55:30 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 15 Feb 2023 08:55:30 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 15 Feb 2023 08:55:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676447730; x=1707983730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WflJ5FrfNUOX+nPHvzKmR7kLVTUVtVMrv41kl6P0qxU=;
  b=Md17VaT0uRLL47mX9Cc00x2sTgqY2xxRMnQ/TDGd1j29ZmMjAJeOXqeS
   5VBly5sRCCcCtwLb9kmxDAtZJdfaeA9PwB/53Z9cfGvsbsk9NwzogzZeX
   hpH564XxPMLDiTOw4NhaScJdrhXvDPt2G+iWWbRwEppHHYcOFJ6XyLt5V
   5AsOrcLB2vgZkIR4Zd3w113UEYBbCwylaK3F4sV6FdeW49GgcLCn7BGqR
   NKEtOf6NmPWUMXRsPunPIHdVgxL8ohboVIe/OpKrNSNgbs1+deghsvtYg
   n1xjUeGP2WbYwj6toYsfHxW2QjSV9qnCKk8vwYBoRlGSoPtR03Cir9gMw
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669071600"; 
   d="scan'208";a="29090209"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Feb 2023 08:55:30 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 79EAD280056;
        Wed, 15 Feb 2023 08:55:30 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Liu Ying <victor.liu@nxp.com>
Cc:     marex@denx.de, stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        krzysztof.kozlowski@linaro.org, LW@karo-electronics.de
Subject: Re: [PATCH v3 6/6] drm: lcdif: Add i.MX93 LCDIF compatible string
Date:   Wed, 15 Feb 2023 08:55:28 +0100
Message-ID: <45316988.fMDQidcC6G@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230213085612.1026538-7-victor.liu@nxp.com>
References: <20230213085612.1026538-1-victor.liu@nxp.com> <20230213085612.1026538-7-victor.liu@nxp.com>
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

Am Montag, 13. Februar 2023, 09:56:12 CET schrieb Liu Ying:
> With all previous preparations done to make it possible for the
> single LCDIF embedded in i.MX93 SoC to drive multiple displays
> simultaneously, add i.MX93 LCDIF compatible string as the last
> step of adding i.MX93 LCDIF support.
>=20
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v2->v3:
> * Fix a trivial typo in commit message.
>=20
> v1->v2:
> * Split from patch 2/2 in v1. (Marek, Alexander)
>=20
>  drivers/gpu/drm/mxsfb/lcdif_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> b/drivers/gpu/drm/mxsfb/lcdif_drv.c index eb6c265fa2fe..48c43b273a4a 1006=
44
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> @@ -249,6 +249,7 @@ static const struct drm_driver lcdif_driver =3D {
>=20
>  static const struct of_device_id lcdif_dt_ids[] =3D {
>  	{ .compatible =3D "fsl,imx8mp-lcdif" },
> +	{ .compatible =3D "fsl,imx93-lcdif" },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, lcdif_dt_ids);

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


