Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2646F6834
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjEDJVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjEDJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:21:37 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72835449E
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1683192095; x=1714728095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g6RxfrONaXC7pnFp2IZrwZPN67O1XvovTarMdoUT4JQ=;
  b=V9NZdudre4zEDAA/JSwYX0hwGKfnsZ2iGu0ht0oAXiGnZJ5iGBAxOggs
   o713QweGP2N+r6i0t09QxClVA5Wjdo9wbJAQOumOJ9bIo07n1CT2altq8
   SgrCh9CC62cavBBnnwvAnPGrDdcW8fjKgZt3XiIA9YiEiIHU1hSRGVEHh
   uR++8xIGKyali8vhFesIf0I/zyi5jhFPPM27v9PtrbhpylgUJRe/Iehi9
   YBgCTUE5XiJpGdFvYr+NWT8Drd3Z98b0pWOXwkj4eUF/9pILwKa2N9dyX
   gGNsvgIzRfCP/+HTRSBBB6z434NexwIsIMcLrQLiTJqb/uhb14AYjrH7W
   A==;
X-IronPort-AV: E=Sophos;i="5.99,249,1677538800"; 
   d="scan'208";a="30715302"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 May 2023 11:21:32 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 04 May 2023 11:21:32 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 04 May 2023 11:21:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1683192092; x=1714728092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g6RxfrONaXC7pnFp2IZrwZPN67O1XvovTarMdoUT4JQ=;
  b=CIG+oU/lzn/GuEWp+s8219DvxNlK2Q6Ahxvdp//nqqH5usZBDpeUYljH
   Ip4pSpcBwdVjiNEYF1PRTAlyf96TRW1U/EUcJyjhX+hdNauAmiOZyKkFP
   Qb7O2kbVlrF+/pAA2Om32dMexrUYqZAhN/alOdw/7ctiAWB7aEjAD/fEv
   OYyQJrfrVUG7rKMslEjEp9d97LZjY6cfwfzjWpwcn+QCNuCI6in89yyJw
   xXMfNYKKQrm8KMc5pvG3H8CLFqDQD7c7nlQMfvfWMaZuys1pBeE4Xxsm9
   qNmZrGkm8pdQOhPQ3np2VeuhMhpUrQKVX+1seDGt0gLb5/m06dbMgRngZ
   w==;
X-IronPort-AV: E=Sophos;i="5.99,249,1677538800"; 
   d="scan'208";a="30715301"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 May 2023 11:21:32 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id E0557280056;
        Thu,  4 May 2023 11:21:31 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     dri-devel@lists.freedesktop.org
Cc:     marex@denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Adam Ford <aford173@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH V3 3/7] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
Date:   Thu, 04 May 2023 11:21:30 +0200
Message-ID: <7519081.EvYhyI6sBW@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230502010759.17282-4-aford173@gmail.com>
References: <20230502010759.17282-1-aford173@gmail.com> <20230502010759.17282-4-aford173@gmail.com>
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

Am Dienstag, 2. Mai 2023, 03:07:55 CEST schrieb Adam Ford:
> Make the pll-clock-frequency optional.  If it's present, use it
> to maintain backwards compatibility with existing hardware.  If it
> is absent, read clock rate of "sclk_mipi" to determine the rate.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c
> b/drivers/gpu/drm/bridge/samsung-dsim.c index bf4b33d2de76..2dc02a9e37c0
> 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1726,12 +1726,20 @@ static int samsung_dsim_parse_dt(struct samsung_d=
sim
> *dsi) {
>  	struct device *dev =3D dsi->dev;
>  	struct device_node *node =3D dev->of_node;
> +	struct clk *pll_clk;
>  	int ret;
>=20
>  	ret =3D samsung_dsim_of_read_u32(node, "samsung,pll-clock-frequency",
>  				       &dsi->pll_clk_rate);
> -	if (ret < 0)
> -		return ret;
> +
> +	/* If it doesn't exist, read it from the clock instead of failing */
> +	if (ret < 0) {
> +		pll_clk =3D devm_clk_get(dev, "sclk_mipi");
> +		if (!IS_ERR(pll_clk))
> +			dsi->pll_clk_rate =3D clk_get_rate(pll_clk);
> +		else
> +			return PTR_ERR(pll_clk);
> +	}
>=20

Now that 'samsung,pll-clock-frequency' is optional the error in=20
samsung_dsim_of_read_u32() should be changed. Otherwise you will get
> /soc@0/bus@32c00000/dsi@32e10000: failed to get 'samsung,pll-clock-
frequency' property

Best regards,
Alexander

>  	ret =3D samsung_dsim_of_read_u32(node, "samsung,burst-clock-
frequency",
>  				       &dsi->burst_clk_rate);


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


