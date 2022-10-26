Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7D560E1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiJZNNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiJZNNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:13:42 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A795CFBCD8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=hVlTEDNXqc/fdmdheJRXcBghemReuWQuEg72Ug1yjCQ=; b=w3hIo
        exZgL3mE1EU8J0QZCFZNzGgmAd71kq7c212s3cOAdKD8+tZiGPsFE6mss3OeQR5/Uskrv1benxejF
        pBbY4CleScuxjuKMp53MaE8jpI4TNnwx0xbL0q0mFS+mLpqbTVBLfkR61L5NRVCubvbp1hZ+JDsb4
        W8DypmVA8cWH+TKpr+g5cs0t79owvqcvK0+ly12gX2X8ZZfBvt5YrUe+J8TJN/60VY1r6N+vcwUh/
        ljCbL/Ks4N+TH8g/yWDp3ZlVtnlgQZLpYK7eP6WK76ijUlRW6M5PmzmI4UZ3icuQ8KSJhQkRTSbZS
        +fBzphM6n/OH5uZhpqNty1IjV2CtQ==;
Received: from dougal.metanate.com ([192.168.88.1] helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1ongDr-0007Dc-Mv;
        Wed, 26 Oct 2022 14:13:33 +0100
Date:   Wed, 26 Oct 2022 14:13:32 +0100
From:   John Keeping <john@metanate.com>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        "open list:DRM DRIVERS FOR ROCKCHIP" 
        <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm/rockchip: dw_hdmi: filter regulator -EPROBE_DEFER
 error messages
Message-ID: <Y1kyfAMbt6yFFlJ6@donbot>
References: <20220926203752.5430-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926203752.5430-1-aurelien@aurel32.net>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 10:37:52PM +0200, Aurelien Jarno wrote:
> When the avdd-0v9 or avdd-1v8 supply are not yet available, EPROBE_DEFER
> is returned by rockchip_hdmi_parse_dt(). This causes the following error
> message to be printed multiple times:
> 
>     dwhdmi-rockchip fe0a0000.hdmi: [drm:dw_hdmi_rockchip_bind [rockchipdrm]] *ERROR* Unable to parse OF data
> 
> Fix that by not printing the message when rockchip_hdmi_parse_dt()
> returns -EPROBE_DEFER.
> 
> Fixes: ca80c4eb4b01 ("drm/rockchip: dw_hdmi: add regulator support")
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index c14f88893868..2f4b8f64cbad 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -565,7 +565,8 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
>  
>  	ret = rockchip_hdmi_parse_dt(hdmi);
>  	if (ret) {
> -		DRM_DEV_ERROR(hdmi->dev, "Unable to parse OF data\n");
> +		if (ret != -EPROBE_DEFER)
> +			DRM_DEV_ERROR(hdmi->dev, "Unable to parse OF data\n");

Can we use dev_err_probe() here?

There's no DRM-specific variant, but that is already widely used across
the DRM subsystem.
