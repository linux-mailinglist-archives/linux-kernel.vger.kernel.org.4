Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DBF637700
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiKXLA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiKXLAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:00:54 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B085297348
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1669287652; x=1700823652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TKsmYGKYqQviZJozhSmWaRTpNKVgkOaOV5+wyTY4lf4=;
  b=PqzuJuSBcZIeTxi3+dO14op7fSnmnaavS12lXXa2m1UOsQAFqTzPm3Cd
   y17/ixXnHJvHjnawq0OdRl1geIN1sQlzqEoueb0Qj3ddJs2rKTyciUZCR
   +64nEtMPtV724gWTRZD4mtTOo4Uim0J6Mvutujop8SynHbj4h2JqFO8mz
   qI5viDoJeKnYKIYg6lPiz/hDGQZbUK86oBz0WU7Ermzbv/nj4NVq/D1Xi
   0/GR39aaCi4LmVJoBbwUAORFcxX49QNtoYbhkdLoXhmrAWf6urXdbU7sw
   UXUvBDkJA0oStbpnkBvj0R1vvcZoz2+Q5Xd5XwSkZ85WCTmT/neiC9vZ3
   w==;
X-IronPort-AV: E=Sophos;i="5.96,190,1665439200"; 
   d="scan'208";a="27559212"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 24 Nov 2022 12:00:50 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 24 Nov 2022 12:00:50 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 24 Nov 2022 12:00:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1669287650; x=1700823650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TKsmYGKYqQviZJozhSmWaRTpNKVgkOaOV5+wyTY4lf4=;
  b=lAvHyzOo6Pjn32Y9f9SKk7orxpl0h4UIhBVAXqEoUtTJixflj802qCxj
   51wxjUkLMoNdTsxouXcPmaNOy1RU3gumpOD0W2lR+9En+kOKMRs8aSY0F
   u8rAaz8FUpKZMB/eZaeFeVGy3mrr77ldOrSkM5HLg07eHMFph5ke1cCsh
   2TyedO30gaNur/3ECF5LwvvgKyWJFkdh6Q/Vaa1oWyZv6x4Xdx1YMRbtG
   tSOcqxA9BRGEwTSh7BBPnA8uk+fomj6s3EAaeC0sN8iCvosSuclsg8M9o
   mNPJZi6PBm8d11SKOOHzwwf32jvT1qwPCP9G5sJFfcJh6+m9DVVpn6IwU
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,190,1665439200"; 
   d="scan'208";a="27559210"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Nov 2022 12:00:50 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 0B7B7280056;
        Thu, 24 Nov 2022 12:00:50 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Frieder Schrempf <frieder@fris.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?ISO-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi83: Fix delay after reset deassert to match spec
Date:   Thu, 24 Nov 2022 12:00:48 +0100
Message-ID: <9079928.rMLUfLXkoz@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20221122081219.20143-1-frieder@fris.de>
References: <20221122081219.20143-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 22. November 2022, 09:12:18 CET schrieb Frieder Schrempf:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The datasheet specifies a delay of 10 milliseconds, but the current
> driver only waits for 1 ms. Fix this to make sure the initialization
> sequence meets the spec.
> 
> Fixes: ceb515ba29ba ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and
> SN65DSI84 driver") Signed-off-by: Frieder Schrempf
> <frieder.schrempf@kontron.de>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> b/drivers/gpu/drm/bridge/ti-sn65dsi83.c index 7ba9467fff12..047c14ddbbf1
> 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -346,7 +346,7 @@ static void sn65dsi83_atomic_enable(struct drm_bridge
> *bridge,
> 
>  	/* Deassert reset */
>  	gpiod_set_value_cansleep(ctx->enable_gpio, 1);
> -	usleep_range(1000, 1100);
> +	usleep_range(10000, 11000);
> 
>  	/* Get the LVDS format from the bridge state. */
>  	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);

How about using fsleep?

Either way:
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>


