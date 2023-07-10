Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF59F74D38D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjGJKcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGJKcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:32:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F03B8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688985129; x=1720521129;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=tz2zZQ8f/yg7gZP7NI81aF7OXMQPyUOJOe7LMRyGsrg=;
  b=hTEB5lfkiX7nq1GG2J5NIzcwCh6dAIZik24Snz74FYooKgd/kyUWoTlG
   q8fpYbh+3CxuEL/ydfAQUW5odLjSbRNLI6jJzchEc9OGyBUrhqwklQimM
   DjmHwhNLGN8RP+gnL9WXntjCXCnyzZZXRgfBh9Vr6BKXS9oUFcR2As8Iq
   D9NzHTiGC2dseUqI+74Mu8gTh88J9z12IKEA9D00CmVHTRr9Kjc02jKZp
   IjW/8reBPUMzkan/0rcqC1WJ8OwkXzOdgWEJEYmNJXHyOKcjjqmj085E2
   cb3GtpRbQWOJ76RGl4ADzky5WkpZripf0q+wUzMIcHy3lmvQm9j66fFex
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="349110577"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="349110577"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 03:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="723960814"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="723960814"
Received: from stoicaan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.52.170])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 03:32:05 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH RESEND] drm/bridge: anx7625: Use common macros for DP
 power sequencing commands
In-Reply-To: <20230710090929.1873646-1-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230710090929.1873646-1-wenst@chromium.org>
Date:   Mon, 10 Jul 2023 13:32:03 +0300
Message-ID: <87edlgjbvg.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023, Chen-Yu Tsai <wenst@chromium.org> wrote:
> The DRM DP code has macros for the DP power sequencing commands. Use
> them in the anx7625 driver instead of raw numbers.
>
> Fixes: 548b512e144f ("drm/bridge: anx7625: send DPCD command to downstrea=
m")
> Fixes: 27f26359de9b ("drm/bridge: anx7625: Set downstream sink into norma=
l status")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Collected tags and rebased on v6.5-rc1.
>
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/=
bridge/analogix/anx7625.c
> index 8b985efdc086..9db3784cb554 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -931,8 +931,8 @@ static void anx7625_dp_start(struct anx7625_data *ctx)
>=20=20
>  	dev_dbg(dev, "set downstream sink into normal\n");
>  	/* Downstream sink enter into normal mode */
> -	data =3D 1;
> -	ret =3D anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, 0x000600, 1, &data);
> +	data =3D DP_SET_POWER_D0;
> +	ret =3D anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, DP_SET_POWER, 1, &d=
ata);

So you have code to implement the drm dp aux abstractions, why aren't
you using drm_dp_dpcd_writeb() and friends here?

BR,
Jani.


>  	if (ret < 0)
>  		dev_err(dev, "IO error : set sink into normal mode fail\n");
>=20=20
> @@ -971,8 +971,8 @@ static void anx7625_dp_stop(struct anx7625_data *ctx)
>=20=20
>  	dev_dbg(dev, "notify downstream enter into standby\n");
>  	/* Downstream monitor enter into standby mode */
> -	data =3D 2;
> -	ret |=3D anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, 0x000600, 1, &data=
);
> +	data =3D DP_SET_POWER_D3;
> +	ret |=3D anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, DP_SET_POWER, 1, &=
data);
>  	if (ret < 0)
>  		DRM_DEV_ERROR(dev, "IO error : mute video fail\n");

--=20
Jani Nikula, Intel Open Source Graphics Center
