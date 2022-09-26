Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C8B5E9D17
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiIZJOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiIZJN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:13:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E49402C0;
        Mon, 26 Sep 2022 02:13:55 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F06A6600367;
        Mon, 26 Sep 2022 10:13:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664183633;
        bh=ReHLoFF8/G1tqeZPxdH2KQHhFx0wlNUICsMaObAVG10=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i51YL3oZDsVzxfn5GXIpo6P8FnOnQlvRaMLm9LHjnsPU98LUA/nxcs59ZM9K6CxMo
         LX/lomOcw5Z4QD40UyQoc8FBfpL9TjXDHA90Hm6tIXg61/EIZVIIlj/L53xwJYLzLJ
         RNDmwyy7gHMndsDyxIrKGCS8BTQspsNcKBgmlDAj3t4ozkwzDKRx8MXxaDeSOUnwmF
         CoGzrgwXaCT/v8ePzTnNsn2UsO15WLQczAm3C9ffI0ETBkGdFZ3A2Ml9ocz5yw8hVf
         6UOQZ7FPU6Er6QX5tQEMrAXKSGecHXMmN6vr5SPiQH4qnm2LeYj2duWZNOqp9qy8Hb
         iRjezBAjENi3g==
Message-ID: <b594626f-5c73-2a4c-6286-81f9df26832e@collabora.com>
Date:   Mon, 26 Sep 2022 11:13:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH,v2] pwm: mtk-disp: Fix the parameters calculated by the
 enabled flag of disp_pwm
Content-Language: en-US
To:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, matthias.bgg@gmail.com
Cc:     linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com
References: <1663934771-15152-1-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1663934771-15152-1-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/22 14:06, xinlei.lee@mediatek.com ha scritto:
> From: xinlei lee <xinlei.lee@mediatek.com>
> 
> In the original mtk_disp_pwm_get_state() function, the result of reading
> con0 & BIT(0) is enabled as disp_pwm.
> In order to conform to the register table, we should use the disp_pwm
> base address as the enabled judgment.
> 
> Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")
> 
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
> ---
> Base on the branch of Linux-next/master.
> 
> change since v1:
> 1. Modify the way to set disp_pwm enbale.
> ---
> ---
>   drivers/pwm/pwm-mtk-disp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index c605013..1a9880d 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -197,7 +197,7 @@ static void mtk_disp_pwm_get_state(struct pwm_chip *chip,
>   	rate = clk_get_rate(mdp->clk_main);
>   	con0 = readl(mdp->base + mdp->data->con0);
>   	con1 = readl(mdp->base + mdp->data->con1);
> -	state->enabled = !!(con0 & BIT(0));
> +	state->enabled = !!(readl(mdp->base + DISP_PWM_EN) & BIT(0));

I think you mean mdp->data->enable_mask here.

Anyway, for the sake of human readability....

u32 clk_div, pwm_en, con0, con1;

pwm_en = readl(mdp->base + DISP_PWM_EN);

state->enabled = !!(pwm_en & mdp->data->enable_mask);

Regards,
Angelo

>   	clk_div = FIELD_GET(PWM_CLKDIV_MASK, con0);
>   	period = FIELD_GET(PWM_PERIOD_MASK, con1);
>   	/*
> 

