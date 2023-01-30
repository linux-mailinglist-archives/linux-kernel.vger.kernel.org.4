Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB871681E03
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjA3W0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3W0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:26:31 -0500
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E791125B8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:26:28 -0800 (PST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id C981511DA;
        Mon, 30 Jan 2023 23:26:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz C981511DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1675117585; bh=M4Gc6X96kuFeaN6aP2ubqI+ZhC4pG+m2LQpyGmQp4Uw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L/K1K0E/eziEKfW0/IosOyrHlbL86sGfNH8av5e79xqbURoYGPhE1Z04XIQXuUGuY
         QFPCBeBoutLiZUxMZjAHBFv51VrG8t1sw+ACSu5iHm5+EeZkdyeNN6HSrQhlA59KJL
         3w5xn+Z6j/7rwhRXNP/y9jxZW/iFOJFkxxrBlwuw=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Mon, 30 Jan 2023 23:26:14 +0100 (CET)
Message-ID: <0670df68-ccc0-6806-cc78-15187481b973@perex.cz>
Date:   Mon, 30 Jan 2023 23:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/6] ASoC: amd: yc: Add a module parameter to influence
 pdm_gain
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mukunda Vijendar <Vijendar.Mukunda@amd.com>,
        Saba Kareem Syed <Syed.SabaKareem@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
References: <20230130220754.8379-1-mario.limonciello@amd.com>
 <20230130220754.8379-3-mario.limonciello@amd.com>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230130220754.8379-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 01. 23 23:07, Mario Limonciello wrote:
> In case of regressions for any users that the new pdm_gain value is
> too high and for additional debugging, introduce a module parameter
> that would let them configure it.
> 
> This parameter should be removed in the future:
>   * If it's determined that the parameter is not needed, just hardcode
>     the correct value as before
>   * If users do end up using it to debug and report different values
>     we should introduce a config knob that can have policy set by ucm.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>   * Add a guard for values > 3 to overflow the FIELD_PREP
>   * Clear ACP_WOV_GAIN_CONTROL before setting it
> ---
>   sound/soc/amd/yc/acp6x-pdm-dma.c | 10 +++++++++-
>   sound/soc/amd/yc/acp6x.h         |  2 +-
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/amd/yc/acp6x-pdm-dma.c b/sound/soc/amd/yc/acp6x-pdm-dma.c
> index acecd6a4ec4b1..2bb3ea14bae9c 100644
> --- a/sound/soc/amd/yc/acp6x-pdm-dma.c
> +++ b/sound/soc/amd/yc/acp6x-pdm-dma.c
> @@ -7,6 +7,7 @@
>   
>   #include <linux/platform_device.h>
>   #include <linux/module.h>
> +#include <linux/bitfield.h>
>   #include <linux/err.h>
>   #include <linux/io.h>
>   #include <sound/pcm_params.h>
> @@ -18,6 +19,10 @@
>   
>   #define DRV_NAME "acp_yc_pdm_dma"
>   
> +static int pdm_gain = 3;
> +module_param(pdm_gain, int, 0644);
> +MODULE_PARM_DESC(pdm_gain, "Gain control (0-3)");
> +
>   static const struct snd_pcm_hardware acp6x_pdm_hardware_capture = {
>   	.info = SNDRV_PCM_INFO_INTERLEAVED |
>   		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> @@ -55,7 +60,10 @@ static void acp6x_enable_pdm_clock(void __iomem *acp_base)
>   
>   	acp6x_writel(pdm_clk_enable, acp_base + ACP_WOV_CLK_CTRL);
>   	pdm_ctrl = acp6x_readl(acp_base + ACP_WOV_MISC_CTRL);
> -	pdm_ctrl |= ACP_WOV_MISC_CTRL_MASK;
> +	pdm_ctrl &= FIELD_PREP(ACP_WOV_GAIN_CONTROL, 0);

It should be 'pdm_ctrl &= ~ACP_WOV_GAIN_CONTROL' see include/linux/bitfield.h 
(Modify: comment).

> +	if (pdm_gain > 3)
> +		pdm_gain = 3;

Negative values are not handled. Use clamp(pdm_gain, 0, 3) - see 
include/linux/minmax.h.

> +	pdm_ctrl |= FIELD_PREP(ACP_WOV_GAIN_CONTROL, pdm_gain);
>   	acp6x_writel(pdm_ctrl, acp_base + ACP_WOV_MISC_CTRL);

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

