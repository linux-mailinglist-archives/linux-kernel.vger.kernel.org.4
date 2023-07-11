Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5695A74F803
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjGKS2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjGKS1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:27:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0E1170F;
        Tue, 11 Jul 2023 11:27:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so6606989f8f.1;
        Tue, 11 Jul 2023 11:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689100034; x=1691692034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKWUjHYl3foUxpIk1+qyClaunh32Kc8gPI+5NOFPgGs=;
        b=M+q2D1BlRVUEVYbiFkbHFOCQCg6FTNIZE8+pqseAtFSK5xy/HDIa9hNaBOsJZqL3Xm
         F0Vhyn84rlKzLWKnT4xmWUyQsKu+gCzI5kMMwAQQnFFuOjifHHaf+F9yijlfC51TuKoF
         9NAWm+Ezb4kfKouVrILRTHJZXAHiX9xuwISzC4kTZvFnhx+in+uDJagzgw+PrnUDEL9p
         cnV0VB40ArsUij1d0eVkemA6fTav9rw4om0lSiMvoU0SSkvCtv/IGnYKcfjixH1S+eTB
         480EtI1dy/c2gSHKK50JHMyLmVtj75q2DxgaN3MjKwKiWr+XunGZmeft21hHExY2NSYs
         FKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689100034; x=1691692034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKWUjHYl3foUxpIk1+qyClaunh32Kc8gPI+5NOFPgGs=;
        b=dQGM5AOiDyQVZoyZ6Nr0tZ2Ye0AAYAUWB6mqxtatIYYxVWu9t3fDoh6bJnx6g5z4Ih
         tOXGSJIGH8KpzH9wPZdtiFHr6IqU/QM9ydkVRJvw0oYY91lhcErvzGFHAq9RyIF1Tn+V
         yJOUJmy/hlfBfavWo7qjOoCWgMM5EoORwOARiSjo8l3keqJ7qRTGgWMzvvBPCPPB0pub
         Slx2CEKnlE68sFqIN6j//i20I2wuG30fx1UaK2za/soZPwgqXcAiswbLr18jJZhhcJVW
         uPOSnBU+pfi5Wuz6p4d9nf4n54OS4afYDjLkAIvg80tSyQCi1bUXEQdOYUjTnJ+y9NZK
         oLLQ==
X-Gm-Message-State: ABy/qLZw/R4gXZpzoR0Lg8gYiRNw7sJgdmg+0LFcOhc8HPA3dtf5aLr6
        HjhO3g1h/l+HfDd/9fgEQlk=
X-Google-Smtp-Source: APBJJlFqEqFYCh6MT3tFL7RHAl/UWYoVkTrcP/XYR3mXD+4NTRd8J+1DC16+7HEtxpG2Uu2/QL3Oew==
X-Received: by 2002:adf:fcca:0:b0:315:9de4:92f0 with SMTP id f10-20020adffcca000000b003159de492f0mr5931362wrs.5.1689100034540;
        Tue, 11 Jul 2023 11:27:14 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d5182000000b003143aa0ca8asm2929620wrv.13.2023.07.11.11.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 11:27:14 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] clk: sunxi: sun9i-mmc: Use
 devm_platform_get_and_ioremap_resource()
Date:   Tue, 11 Jul 2023 20:27:13 +0200
Message-ID: <9132614.CDJkKcVGEf@jernej-laptop>
In-Reply-To: <20230705065313.67043-1-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 05. julij 2023 ob 08:53:01 CEST je Yangtao Li napisal(a):
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clk/sunxi/clk-sun9i-mmc.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/sunxi/clk-sun9i-mmc.c
> b/drivers/clk/sunxi/clk-sun9i-mmc.c index 636bcf2439ef..0862b02b1ed4 100644
> --- a/drivers/clk/sunxi/clk-sun9i-mmc.c
> +++ b/drivers/clk/sunxi/clk-sun9i-mmc.c
> @@ -108,15 +108,13 @@ static int sun9i_a80_mmc_config_clk_probe(struct
> platform_device *pdev)
> 
>  	spin_lock_init(&data->lock);
> 
> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!r)
> -		return -EINVAL;
> -	/* one clock/reset pair per word */
> -	count = DIV_ROUND_UP((resource_size(r)), SUN9I_MMC_WIDTH);
> -	data->membase = devm_ioremap_resource(&pdev->dev, r);
> +	data->membase = devm_platform_get_and_ioremap_resource(pdev, 0, 
&r);
>  	if (IS_ERR(data->membase))
>  		return PTR_ERR(data->membase);
> 
> +	/* one clock/reset pair per word */
> +	count = DIV_ROUND_UP((resource_size(r)), SUN9I_MMC_WIDTH);
> +
>  	clk_data = &data->clk_data;
>  	clk_data->clk_num = count;
>  	clk_data->clks = devm_kcalloc(&pdev->dev, count, sizeof(struct clk 
*),




