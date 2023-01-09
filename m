Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B78662428
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbjAILZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbjAILZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:25:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0028DEBC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:25:51 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 75EE86602D06;
        Mon,  9 Jan 2023 11:25:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673263549;
        bh=AB2/l46Up7/+QV6Mp4GjW9e9vUcC9MMu+4KrzEQ5hvc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X2N7MMeXAIaiDJfLbW7ZS07CKJKqGLJgRcvEP1SSAhXdmJMejOBphb4aLMRv5EvHE
         4MfRZ8Ud07gBDIBb3GTgTndnNaV66lrJTsGlgl/zjCdhZE42CVe+IQIgdnHFwp0oGs
         nZpo9AuXyUwZexUyvyGSCFLFnsWxFBvKwHsvj0fVmRrWHAQiC699pIpBvjKMvluep8
         1KW2j5fncfXIAUKk/4UtFnwbzEKsf5li3IdRzxfzYtsCMPruVs+EU1dg5TV6hf7Ec5
         O0EqINTC1FsJe93O0GB/htqGqissi8GFqVwxYC/Bm6WUwqv3BDmD0axoG4cLm0R2KV
         PMdtzUno7wQqw==
Message-ID: <778af306-ae24-4c49-5e93-7810fad7f8bb@collabora.com>
Date:   Mon, 9 Jan 2023 12:25:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] drm/panel: boe-tv101wum-nl6: Reduce lcm_reset to send
 initial code time
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, jitao.shi@mediatek.com,
        thierry.reding@gmail.com, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1672974321-18947-1-git-send-email-xinlei.lee@mediatek.com>
 <1672974321-18947-3-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1672974321-18947-3-git-send-email-xinlei.lee@mediatek.com>
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

Il 06/01/23 04:05, xinlei.lee@mediatek.com ha scritto:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Since the panel spec stipulates that the time from lcm_reset to DSI to
> send the initial code should be greater than 6ms and less than 40ms,
> so reduce the delay before sending the initial code and avoid panel
> exceptions.
> 
> Fixes: a869b9db7adf ("drm/panel: support for boe tv101wum-nl6 wuxga dsi video mode panel")
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>   drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index 857a2f0420d7..f0093035f1ff 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -780,7 +780,6 @@ static const struct panel_init_cmd inx_hj110iz_init_cmd[] = {
>   };
>   
>   static const struct panel_init_cmd boe_init_cmd[] = {
> -	_INIT_DELAY_CMD(24),

You said that should be greater than 6 and less than 40: perhaps on MediaTek
platforms removing this delay is fine but we don't know about others - and this
driver is for all platforms.

To stay on the safe side you should, at this point, replace this delay with

	_INIT_DELAY_CMD(7);

Regards,
Angelo

