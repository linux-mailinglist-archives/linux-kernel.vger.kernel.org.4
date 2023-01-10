Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF8A663CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbjAJJXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237813AbjAJJWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:22:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AF2CEB
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:22:48 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E34A56602D72;
        Tue, 10 Jan 2023 09:22:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673342567;
        bh=I2gJPlcF+jyW1J551Fuqu3z1Wg3HeLzZXwOmprSzWkg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Srm7lmvX2lAUDnh8Y6LXq9YXq72EXOwU5zwlPc90QrJuH51Pko1MOj2SWwvFd/wwJ
         KPygbI+Pu4+s27nftvJetY7YDydh8fmzzizysqDvnB9TFEtOSJn0zOMclRbaTB9sfV
         d5Q4/YdrOr1JWMY+ZQhbdIJGCc4RRiqahOGeMTCxelyYPAZB1skcJoE9CdhBCbJ6Vl
         11MeGdnX4vD48PVqs3mbZxE658TP5exOrYFVajotf9tfLX7zdT/SaBuRQR+tpjjDvg
         jB0jXC+O8s9UtnsrqVs635Sam1mlO1W0Vyf4csB/23bQVClPkSp6JgR+pa1LlInjXF
         sJWTIh0RRVh0A==
Message-ID: <21efdb3e-3c4d-0bc9-bbde-34ec3e04bfad@collabora.com>
Date:   Tue, 10 Jan 2023 10:22:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 3/3] drm/panel: boe-tv101wum-nl6: Fine tune the panel
 power sequence
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, jitao.shi@mediatek.com,
        thierry.reding@gmail.com, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1673330093-6771-1-git-send-email-xinlei.lee@mediatek.com>
 <1673330093-6771-4-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1673330093-6771-4-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/23 06:54, xinlei.lee@mediatek.com ha scritto:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> For "boe,tv105wum-nw0" this special panel, it is stipulated in the
> panel spec that MIPI needs to keep the LP11 state before the
> lcm_reset pin is pulled high.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>   drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index f0093035f1ff..67df61de64ae 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -36,6 +36,7 @@ struct panel_desc {
>   	const struct panel_init_cmd *init_cmds;
>   	unsigned int lanes;
>   	bool discharge_on_disable;
> +	bool lp11_before_reset;
>   };
>   
>   struct boe_panel {
> @@ -1261,6 +1262,10 @@ static int boe_panel_prepare(struct drm_panel *panel)
>   
>   	usleep_range(10000, 11000);
>   
> +	if (boe->desc->lp11_before_reset) {
> +		mipi_dsi_dcs_nop(boe->dsi);

NOP will never reach the driveric if it is in reset, which should apparently be
the state of it at that point in code.

I guess that you wanted to do that after LCM reset and before sending init cmds.

Regards,
Angelo

