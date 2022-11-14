Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A021628AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbiKNVCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237268AbiKNVCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:02:17 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17E8B4A7;
        Mon, 14 Nov 2022 13:02:15 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id n20so10788456ejh.0;
        Mon, 14 Nov 2022 13:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TzzsYr3QBaUTVu5kumkFsbRVJbtcn69A/lItbi1zU98=;
        b=bojHQRtx6KhmuPEwvS6vokOwrOP4UUSsInITgCjLbtci2sWccS1NQ3IBggtobrbZan
         a/DE0f7eJ6SrCJmepFpJfRyZZAbhpYX9/hC7gaa39gPY78WqWta518lYjhXbVzG1i9Vq
         xyrz920zssclK67meKsPP4rTz+a0mTOT19jBOsWogfCaw0BnG9xfsRBVswbODWVdQ7PN
         qzT0AsUgSgEcw/PbJ8DeaeYtwoOIxAFBKo5HFM1hxPQ4qHppx3v2jlzl/jdyoEE3uzX2
         JdbSkmxETArx0MEIfJ0ApbMwn84Q3VsxW6qNXf45s1NXFIjqt5/TfAmDbnsqiaU3PXv5
         RUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzzsYr3QBaUTVu5kumkFsbRVJbtcn69A/lItbi1zU98=;
        b=saFI7LGX+1PX8zSQvt0LWBlmx2CdfvA7nOt1tiIRTySjCeuUmpnmsVYZgYgXLq+VzD
         cL9iuvvaZ64O5R9wfDn+VJZjlhD2XoZ6B5DXYsxBqBpCbg9I1pAwLpBjM9Bn7PfedjqN
         7nj/b3rKBU9uWDiqdbFAdAoPWyUxNNlJ+Q8XF6tT806q9gfSko9T1cxl9LMqJjjopYvb
         voQpyRrdct3EOQI5oWbg5ZPMRsioRxu/wstPx5UZZS0rzF93fjp80waj1Rnn8ddxWaqT
         xSHQyALZFn5VX9uooDzjexCg8TGECPlLmOlUhRRG6qAwZtY0puSjfGvboIDlPozMZYTP
         pYCA==
X-Gm-Message-State: ANoB5pkOGC5ih6SzaAGEeRMia/VaIGHmmTlFW4WLa4q5gNiagxHn/i7H
        cXwhfSUHeKylDiF3EMnwCdQ=
X-Google-Smtp-Source: AA0mqf4romJpJ696KN+fPZmMnIrPunyW+McWEUlAOPIcwTtZicCYdIFczAT2Nw/U1Ct4Zm/p43lNmg==
X-Received: by 2002:a17:906:c185:b0:7ad:84d1:5b56 with SMTP id g5-20020a170906c18500b007ad84d15b56mr12214793ejz.205.1668459734207;
        Mon, 14 Nov 2022 13:02:14 -0800 (PST)
Received: from [192.168.3.32] (dh207-97-48.xnet.hr. [88.207.97.48])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906135000b0073d84a321c8sm4587847ejb.166.2022.11.14.13.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 13:02:13 -0800 (PST)
Message-ID: <b3860cbd-0967-0b8d-3d67-f2a09f1e0042@gmail.com>
Date:   Mon, 14 Nov 2022 22:02:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH RFC] gpiolib: ensure that fwnode is properly set
To:     Brian Masney <bmasney@redhat.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, psodagud@quicinc.com,
        quic_shazhuss@quicinc.com, quic_ppareek@quicinc.com,
        ahalaney@redhat.com, echanude@redhat.com,
        nicolas.dechesne@linaro.org
References: <20221114202943.2389489-1-bmasney@redhat.com>
Content-Language: en-US
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <20221114202943.2389489-1-bmasney@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14. 11. 2022. 21:29, Brian Masney wrote:
> Note that this is a RFC patch and not meant to be merged. I looked into
> a problem with linux-next-20221110 on the Qualcomm SA8540P automotive
> board (sc8280xp) where the UFS host controller would fail to probe due
> to repeated probe deferrals when trying to get reset-gpios via
> devm_gpiod_get_optional().
>
> of_get_named_gpiod_flags() returns -EPROBE_DEFER, which is caused by
> of_gpiochip_match_node_and_xlate() returning 0 since the of_xlate function
> pointer is not set for the qcom,sc8280xp-tlmm pinctrl driver. The
> pinctrl driver doesn't define one, so of_gpiochip_add() should
> automatically setup of_gpio_simple_xlate() on it's behalf. This doesn't
> happen since the fwnode member on the struct gpiochip is set to null
> when of_gpiochip_add() is called. Let's work around this by ensuring
> that it's set if available.
>
> Note that this broke sometime within the last few weeks within
> linux-next and I haven't bisected this. I'm posting this in the hopes
> that someone may know offhand which patch(es) may have broken this.

Hi, the following patch should fix it for you, I have hit the same issue on
IPQ8074.

https://patchwork.ozlabs.org/project/linux-gpio/patch/20221111113732.461881-1-thierry.reding@gmail.com/

Regards,
Robert

>
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>   drivers/gpio/gpiolib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 11fb7ec883e9..8bec66008869 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -678,7 +678,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>   	 * Assign fwnode depending on the result of the previous calls,
>   	 * if none of them succeed, assign it to the parent's one.
>   	 */
> -	gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
> +	gc->fwnode = gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
>   
>   	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
>   	if (gdev->id < 0) {
