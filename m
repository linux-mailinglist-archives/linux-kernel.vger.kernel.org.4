Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBF563D985
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiK3Pe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiK3PeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:34:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E3C1CFE3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:34:21 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id t1so13460092wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s9l5W+++EB6NlTNQ2XeW/aJwLvMG4kwDS8FzLeXyfuw=;
        b=OODKmXJ6crJMlLhh/+vdhA3F4o5MwqA9QOCEg8PrNXZTQAd6n0YodJdRLPkktAA/LR
         IkRXQjOlFg2XlI/qqufD6xExRdXNDx5cX8Vz/eStqmwfx7wQSbStkDbFNPinHyFpO7fg
         sD16RdndosM4pWCCIcK3mU7LpNx6CemfLSGP//QW+7MndIjsaqXJm6mg844kP0UQMyGA
         BxLF+rFPs+K02ivqGesCLhUBmXJRgHQZYNYxtoPSFGsjASuT9ajNQfT3ytLeWxsHWsal
         ZK7j7jlqB1OlNq/YRMzC11GBtZWlmVg2V+K9+3AGsmzjLj2fZgWT14iNT8byeiqZjYB3
         ry2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9l5W+++EB6NlTNQ2XeW/aJwLvMG4kwDS8FzLeXyfuw=;
        b=bBFxY9abv6Ab8ummGh9FZy0Qe7k8PQ2E2pPel4zeB3udWTj3z5UusN+CXqI80wgVzK
         jb/Chy3fN0XTCCTbLbZ8Eij0XjIm7mQI0B1zjqJfhi6IyD0ShZY3NRpK9h6kUGQeXlxI
         XpGWdC2z4jrMCoQcrFghBtxvQNH+Tkyc+XhoI70IH4QUSHi2X00oEbvEKqCBq9Y1V4q7
         fzSIvcR0ZaOuDdOrYw/r2vSdD9mXMbAmuDHSl1KNvjPsKNdSOLPm+G3O5y4u3mL7QRSo
         +KoKQxkjLehWPHm6yzXPHOed5V9jtdGw2VbWZmY0t637YKLzvNoAKgSb7bJfMWbz7J5o
         Stxw==
X-Gm-Message-State: ANoB5plWfGXxmTj0s/E1qpcCkdCiP1RDGbyz1l/4IN8UsC5jFG1Zh7AE
        Zx0EpaohOYeGkgDAAuCHeXfub1b+qd80rCDh
X-Google-Smtp-Source: AA0mqf5De6caILdEu8rZPYKkWFUtjt/TYmdGaIIF1tA4kqQIvg9paWBjvYYs6P5O6HNMXBV4NN3wkQ==
X-Received: by 2002:a05:600c:1d9c:b0:3c6:e369:e856 with SMTP id p28-20020a05600c1d9c00b003c6e369e856mr45158316wms.35.1669822459732;
        Wed, 30 Nov 2022 07:34:19 -0800 (PST)
Received: from localhost ([2a01:cb19:85e6:1900:2bf7:7388:731d:c4e1])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c2cc900b003cf9bf5208esm5138684wmc.19.2022.11.30.07.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 07:34:19 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/3] input/touchscreen: imagis: Correct the maximum
 touch area value
In-Reply-To: <20221118182103.3405-3-linmengbo0689@protonmail.com>
References: <20221118182103.3405-1-linmengbo0689@protonmail.com>
 <20221118182103.3405-3-linmengbo0689@protonmail.com>
Date:   Wed, 30 Nov 2022 16:34:18 +0100
Message-ID: <87lenssbgl.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 18:21, "Lin, Meng-Bo" <linmengbo0689@protonmail.com> wrote:

> From: Markuss Broks <markuss.broks@gmail.com>
>
> As specified in downstream IST3038 driver and proved by testing,
> the correct maximum reported value of touch area is 16.
>
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> [Change from IST3038B to IST3038]
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/touchscreen/imagis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
> index e2697e6c6d2a..b667914a44f1 100644
> --- a/drivers/input/touchscreen/imagis.c
> +++ b/drivers/input/touchscreen/imagis.c
> @@ -210,7 +210,7 @@ static int imagis_init_input_dev(struct imagis_ts *ts)
>  
>  	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
>  	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
> -	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 16, 0, 0);
>  
>  	touchscreen_parse_properties(input_dev, true, &ts->prop);
>  	if (!ts->prop.max_x || !ts->prop.max_y) {
> -- 
> 2.30.2
