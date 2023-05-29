Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324F1714823
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjE2Kna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjE2Kn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:43:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D20C2;
        Mon, 29 May 2023 03:43:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6e1393f13so20458705e9.0;
        Mon, 29 May 2023 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685357006; x=1687949006;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlXsffIo/L+kqdH7G4cgKFcqeg5Ddsyfs99NjT62XR0=;
        b=EnvTo00wkAKLMtoqFGLvi4W/YB7706/2c8SCT0SwMNQ3+pkfme8KI4yEiYWFlVqCAq
         d945IbI9mN7zA8SlLc/zgkBmLP5haKZIgMBg82pOiGMzYcOw099B1l3X8v7APSYbaeDo
         31foG6mi/PrfAShYbpKynBiEIdG3vjBrLtjskeW7619fwiOIBJSbpgFrGp2PzFFh8lF7
         hhS+r7Q3GOUARarEoG71NOf9mFEHZ0tqBl5yEEPFBhpl3lM174god86ZZz4JgxvRgFLY
         0sav5dPH69qTaUyDsS9uOCY4XvjIezh1mmql9jHAUlIdq8jvOolQqahEgdQqKK6VGsds
         TIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685357006; x=1687949006;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlXsffIo/L+kqdH7G4cgKFcqeg5Ddsyfs99NjT62XR0=;
        b=TzEUstQpSSpHWN+SMTkE++iWB+elAxaU7p5oPto94B0Ye9uRjs+B5LhgSONZPqssow
         KsT8hxZ2JoOaS8/y2ZpC0okb9ifuDllhLJRhERbrJliqFOyzeMOKCkQ17ah3J+gWglHA
         22OVt++MDr/mPhtm1FYS30NhXtTNrasqSx7VSKwyNoE2ZfTXNyHdexU6HV1YkR2ozesZ
         tBEi94eWIsWauwswt76+F2r62LPi/CeQ9yj1+IhrJxzcJl10l1iV/QGPeovqFgynbZK2
         NmyU772vzZBiHIByZKkuaEND86r3a+UmtGEzFRwH+nfoeA70A1mx57IAVn1n0xFfMQSM
         D7hA==
X-Gm-Message-State: AC+VfDz/gjVDGE3p0TT6zUR+xKSfTmhClU9VSgTai9dmyM3PFC0It402
        4QvqM75nLCuGcEWeszZAaqQ=
X-Google-Smtp-Source: ACHHUZ7CjLIg3UX/43lAqvLYo2kYHppv7AAeFOm98QxZc1G1aJsABrKHd8VUKghu08PFLHVkTkjQfw==
X-Received: by 2002:a5d:5086:0:b0:309:1532:8287 with SMTP id a6-20020a5d5086000000b0030915328287mr8940723wrt.19.1685357005863;
        Mon, 29 May 2023 03:43:25 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r6-20020adff706000000b0030903371ef9sm13399824wrp.22.2023.05.29.03.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 03:43:24 -0700 (PDT)
Message-ID: <0ff74fff-9e48-e2a6-617c-13d4cfc2e157@gmail.com>
Date:   Mon, 29 May 2023 12:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] pwm: mtk_disp: Fix the disable flow of disp_pwm
Content-Language: en-US, ca-ES, es-ES
To:     Shuijing Li <shuijing.li@mediatek.com>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de,
        angelogioacchino.delregno@collabora.com
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com
References: <20230518115258.14320-1-shuijing.li@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230518115258.14320-1-shuijing.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/05/2023 13:52, Shuijing Li wrote:
> There is a flow error in the original mtk_disp_pwm_apply() function.
> If this function is called when the clock is disabled, there will be a
> chance to operate the disp_pwm register, resulting in disp_pwm exception.
> Fix this accordingly.
> 
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>

We are missing a fixes tag here.
Fixes: 888a623db5d0 ("pwm: mtk-disp: Implement atomic API .apply()")


with that:
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> Changes in v2:
> Use
> if (A && B) {
> 	something();
> }
> instead of
> if (A) {
> 	if (B) {
> 		something();
> 	}
> }
> per suggestion from the previous thread:
> https://lore.kernel.org/lkml/20230515140346.bxeu6xewi6a446nd@pengutronix.de/
> ---
>   drivers/pwm/pwm-mtk-disp.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index 79e321e96f56..2401b6733241 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -79,14 +79,11 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   	if (state->polarity != PWM_POLARITY_NORMAL)
>   		return -EINVAL;
>   
> -	if (!state->enabled) {
> -		mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
> -					 0x0);
> -
> -		if (mdp->enabled) {
> -			clk_disable_unprepare(mdp->clk_mm);
> -			clk_disable_unprepare(mdp->clk_main);
> -		}
> +	if (!state->enabled && mdp->enabled) {
> +		mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN,
> +					 mdp->data->enable_mask, 0x0);
> +		clk_disable_unprepare(mdp->clk_mm);
> +		clk_disable_unprepare(mdp->clk_main);
>   
>   		mdp->enabled = false;
>   		return 0;
