Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAE16F1508
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345762AbjD1KKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345665AbjD1KKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:10:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63B855B1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:10:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f18dacd392so60535495e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682676636; x=1685268636;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TnjMQg8kpOI/tLXCV+U2uVaZATuk63w/0SRizrpFRbA=;
        b=dOlbcx8UlFUbKUELvsZTdvOh393HzzYFNakWn0JA+EV9vBVHqtbFl4/eXgLQSnIfL4
         3lGJycpz9q8Wdeic/18I4HIklja19U4ivWahULRzgyHML/OV6ss4G8zNhwJfZkjErJUe
         cdWo24YS+Scf0ThIjkrhVCuvd13l8643sLv7PW/rqZDYKC0mt10Mns1JHc1FAKMyOtRd
         IwpenhAzrjNuc/QFLI32e0RJvJArBw9oMlNsz5zqD29wF5o8KxDSIuXuL8U4u6E4kWFC
         8VNqnTWv4ISN+ex0+sW2ZjADctDtYQgVgIlL/cegGJVNthHCdaqhMuHIz5TiYbKXOuuB
         5Xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682676636; x=1685268636;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TnjMQg8kpOI/tLXCV+U2uVaZATuk63w/0SRizrpFRbA=;
        b=RcvUvRwv9Ysy1Cd3qr9xQ6ebRi5Ej2uK+gRE6IgxUBRqEMoQUgcg3niyifWtu2tn5i
         SPSAS0JbG4oGrli4AzM6Ws6p+rVvNIVu9IVR67amBCge5Fa26zExTWnwyVX4RR6HLkzm
         aDZi6AeUKiVb5fVQxYPtbBEc0YzbiQRUO5TBuX2F1w9SBGlOyDkkfN+YyXvBYb6TeIgn
         kwHbFR8pDrhN/a5t77anoiBauAGaPtPh2kozKRGFFpa4SKUgnsXipWm9AAnCw//X17zk
         eyNE+mTZGmjmP1Kt27+gR9UbP4l+xb5trRVxzBFS1fsOGYqkR83hElRB6gjRXeS0hR1T
         nI8w==
X-Gm-Message-State: AC+VfDxlytRxOrd0nNUl0hR2KZhXxfblCJ6spRJyDfJMCPO/EAJdtlSn
        9RfQivmFfFbRWup8lDE1bQfFmQ==
X-Google-Smtp-Source: ACHHUZ7wN8sd9iprabidS2L7DNwbiYTkTDWfA2PyggQESoC1B3R5+aUhLvpYexBB8DPH2MDxdefT3A==
X-Received: by 2002:a7b:c5c6:0:b0:3f1:9acf:8682 with SMTP id n6-20020a7bc5c6000000b003f19acf8682mr3241158wmk.17.1682676635935;
        Fri, 28 Apr 2023 03:10:35 -0700 (PDT)
Received: from [172.23.3.169] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c358e00b003f188f608b9sm24689357wmq.8.2023.04.28.03.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 03:10:35 -0700 (PDT)
Message-ID: <90081c40-1740-d812-ac5f-0186eb255ee8@linaro.org>
Date:   Fri, 28 Apr 2023 11:10:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/4] Input: pwm-vibra - add newline to dev_err prints
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
 <20230427-hammerhead-vibra-v1-2-e87eeb94da51@z3ntu.xyz>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20230427-hammerhead-vibra-v1-2-e87eeb94da51@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/04/2023 21:34, Luca Weiss wrote:
> Make sure all printed messages end with a newline.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/input/misc/pwm-vibra.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
> index d0e58a7cdfa3..c08971c97ad6 100644
> --- a/drivers/input/misc/pwm-vibra.c
> +++ b/drivers/input/misc/pwm-vibra.c
> @@ -42,7 +42,7 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
>   	if (!vibrator->vcc_on) {
>   		err = regulator_enable(vibrator->vcc);
>   		if (err) {
> -			dev_err(pdev, "failed to enable regulator: %d", err);
> +			dev_err(pdev, "failed to enable regulator: %d\n", err);
>   			return err;
>   		}
>   		vibrator->vcc_on = true;
> @@ -54,7 +54,7 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
>   
>   	err = pwm_apply_state(vibrator->pwm, &state);
>   	if (err) {
> -		dev_err(pdev, "failed to apply pwm state: %d", err);
> +		dev_err(pdev, "failed to apply pwm state: %d\n", err);
>   		return err;
>   	}
>   
> @@ -65,7 +65,7 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
>   
>   		err = pwm_apply_state(vibrator->pwm_dir, &state);
>   		if (err) {
> -			dev_err(pdev, "failed to apply dir-pwm state: %d", err);
> +			dev_err(pdev, "failed to apply dir-pwm state: %d\n", err);
>   			pwm_disable(vibrator->pwm);
>   			return err;
>   		}
> @@ -137,7 +137,7 @@ static int pwm_vibrator_probe(struct platform_device *pdev)
>   	err = PTR_ERR_OR_ZERO(vibrator->vcc);
>   	if (err) {
>   		if (err != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Failed to request regulator: %d",
> +			dev_err(&pdev->dev, "Failed to request regulator: %d\n",
>   				err);
>   		return err;
>   	}
> @@ -146,7 +146,7 @@ static int pwm_vibrator_probe(struct platform_device *pdev)
>   	err = PTR_ERR_OR_ZERO(vibrator->pwm);
>   	if (err) {
>   		if (err != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Failed to request main pwm: %d",
> +			dev_err(&pdev->dev, "Failed to request main pwm: %d\n",
>   				err);
>   		return err;
>   	}
> @@ -158,7 +158,7 @@ static int pwm_vibrator_probe(struct platform_device *pdev)
>   	state.enabled = false;
>   	err = pwm_apply_state(vibrator->pwm, &state);
>   	if (err) {
> -		dev_err(&pdev->dev, "failed to apply initial PWM state: %d",
> +		dev_err(&pdev->dev, "failed to apply initial PWM state: %d\n",
>   			err);
>   		return err;
>   	}
> @@ -172,7 +172,7 @@ static int pwm_vibrator_probe(struct platform_device *pdev)
>   		state.enabled = false;
>   		err = pwm_apply_state(vibrator->pwm_dir, &state);
>   		if (err) {
> -			dev_err(&pdev->dev, "failed to apply initial PWM state: %d",
> +			dev_err(&pdev->dev, "failed to apply initial PWM state: %d\n",
>   				err);
>   			return err;
>   		}
> @@ -189,7 +189,7 @@ static int pwm_vibrator_probe(struct platform_device *pdev)
>   		break;
>   
>   	default:
> -		dev_err(&pdev->dev, "Failed to request direction pwm: %d", err);
> +		dev_err(&pdev->dev, "Failed to request direction pwm: %d\n", err);
>   		fallthrough;
>   
>   	case -EPROBE_DEFER:
> @@ -207,13 +207,13 @@ static int pwm_vibrator_probe(struct platform_device *pdev)
>   	err = input_ff_create_memless(vibrator->input, NULL,
>   				      pwm_vibrator_play_effect);
>   	if (err) {
> -		dev_err(&pdev->dev, "Couldn't create FF dev: %d", err);
> +		dev_err(&pdev->dev, "Couldn't create FF dev: %d\n", err);
>   		return err;
>   	}
>   
>   	err = input_register_device(vibrator->input);
>   	if (err) {
> -		dev_err(&pdev->dev, "Couldn't register input dev: %d", err);
> +		dev_err(&pdev->dev, "Couldn't register input dev: %d\n", err);
>   		return err;
>   	}
>   
> 
