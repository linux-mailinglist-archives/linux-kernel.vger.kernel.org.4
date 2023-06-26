Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A5173E50F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjFZQaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjFZQ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:29:27 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE96330D8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:28:26 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so21850241fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20221208.gappssmtp.com; s=20221208; t=1687796905; x=1690388905;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uFfAVdAi8YUvaWjVDsPOzE14XMF9lW4DI0A7m7Li71U=;
        b=qJFo348MOOuwRVRBMkS6+ho84DgjprvcxeE03KnuT9zi80DPVw9EKLotDWxhslfUPi
         xZVqD2ezObm6o5LxVEX0s5thCYHY+qv949Dp/+harlda2/0hZq2McuAbYgzAuHNRtybj
         WszWCq7HWZ5Yezf0YHDjDnjonm78VN/TKITaYWZCKNKqUJGkrgbRrWxHRRaWGhlty97K
         WtdxfhKp7y9HExCHpKUi+O67beJGD6kyBi3rY1otef1kXRjxHOTEcaoYM7UrbRzuq7ak
         R+NdluDkJU0qKVzMdyWo720cvZtjaU5dBZMWDClSjuXtJ7DmjwGNieEV76ClKxPrRsEl
         39jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796905; x=1690388905;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFfAVdAi8YUvaWjVDsPOzE14XMF9lW4DI0A7m7Li71U=;
        b=e9sE2GMO7z48gjzzjWpSs97kcLsNyvYiopRgZP+mzrXOHhIPjoWLd2q7K9wTNcD0tS
         LDRqwn2+U81Q+shV49DoJF8CYQU5S7HejSqGXIXHvnXRr/UzT/vsGbGb7QK0xaX64EqR
         kpWX1YvLhmaMmG54BRna5dK2qAiHUZhlAoR6NctDyQuw2eG4MN2lbF720qT8tnpsPREH
         jv6gT0cZyjTw9DjJ5NbH1hREJSgziSuIy7V/CB4Vv6goNIP841irJwBknRahdZOcDBdB
         8ems7/Pb0LF/voydOtGNmtr2mu4Ce7Lm9yU6zMGNXStEfu5rS5ClvIPZ6cdFhJs/rjHD
         5xDg==
X-Gm-Message-State: AC+VfDy8DAU5zeDgw2+VEm1hAfZtdDOas/nwNPHQ/QlvldPdOiX7OEJi
        2yCygNFkmrFQqNTfAbcW5tA83Q==
X-Google-Smtp-Source: ACHHUZ5b+6SI5MIEkxDpWK1UintWB/QDRSb9Rm3ZlCSJducoy8VE8KrXaywdbDE1qdwvBcWvzYv+iA==
X-Received: by 2002:a2e:9943:0:b0:2b6:9909:79bd with SMTP id r3-20020a2e9943000000b002b6990979bdmr2892280ljj.24.1687796904825;
        Mon, 26 Jun 2023 09:28:24 -0700 (PDT)
Received: from localhost (h-46-59-89-207.A463.priv.bahnhof.se. [46.59.89.207])
        by smtp.gmail.com with ESMTPSA id r1-20020a2eb601000000b002b1bf326a88sm1299955ljn.127.2023.06.26.09.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:28:23 -0700 (PDT)
Date:   Mon, 26 Jun 2023 18:28:23 +0200
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] drivers/thermal/rcar_gen3_thermal: Convert to
 devm_platform_ioremap_resource()
Message-ID: <ZJm8p4GnTG-vtb0Q@oden.dyn.berto.se>
References: <20230626124334.15100-1-frank.li@vivo.com>
 <20230626124334.15100-4-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230626124334.15100-4-frank.li@vivo.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

Thanks for your work.

On 2023-06-26 20:43:31 +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

This do indeed simplify the code, but it also breaks the driver :-)

Before the change, failing to find a resource at position "i", breaks 
the probe loop, and probing continues and the number of resource 
described are the number of TSC find are used.

After the change failing to find all possible TCS will fail the whole 
probe process, even if some TCS where described. And not describing max 
number of TCS on each system is perfectly fine.

Nacked-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>

> ---
>  drivers/thermal/rcar_gen3_thermal.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 9029d01e029b..5c623f13d9ec 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -481,7 +481,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  {
>  	struct rcar_gen3_thermal_priv *priv;
>  	struct device *dev = &pdev->dev;
> -	struct resource *res;
>  	struct thermal_zone_device *zone;
>  	unsigned int i;
>  	int ret;
> @@ -504,17 +503,13 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  	for (i = 0; i < TSC_MAX_NUM; i++) {
>  		struct rcar_gen3_thermal_tsc *tsc;
>  
> -		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> -		if (!res)
> -			break;
> -
>  		tsc = devm_kzalloc(dev, sizeof(*tsc), GFP_KERNEL);
>  		if (!tsc) {
>  			ret = -ENOMEM;
>  			goto error_unregister;
>  		}
>  
> -		tsc->base = devm_ioremap_resource(dev, res);
> +		tsc->base = devm_platform_ioremap_resource(pdev, i);
>  		if (IS_ERR(tsc->base)) {
>  			ret = PTR_ERR(tsc->base);
>  			goto error_unregister;
> -- 
> 2.39.0
> 

-- 
Kind Regards,
Niklas Söderlund
