Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173797108D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbjEYJ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjEYJ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:26:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D32191
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:26:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30957dd7640so1263493f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685006787; x=1687598787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kMj+2el2dGt8TUSmh5ASzD6FTnfF+Hm05Jh6eBFAFVk=;
        b=jD4bd+X6wPf0itZXjBaBUXqrNWlPmA5IGDgRSWr9gVGoDBuDpXqzM2g2zWeDLdMgNM
         Orr+KEyx5G6+4v57T6bJ4JkRKasJaWasnC2twLB/OX1S/BbjMizEB1jIOnNYgEJns0bY
         bh5x723WTSWiFh0NJkHGehWzwlpD9jenNHYBVoFu4toNKu7YmJXBkc7fEs6KuGVgeKxn
         4XAQl7iY8+IGA14WXRjceoo1FyLlAu4FMq4UKvSB0tKuQA7wvvdekAByBMN+ij/lrul+
         980NzmNJBWo+s8K46WPQZnHNbQpmHJ/jBGThygE6GcrCgXEo5Po0LEMEVCJWiqRB9mmB
         Sqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685006787; x=1687598787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMj+2el2dGt8TUSmh5ASzD6FTnfF+Hm05Jh6eBFAFVk=;
        b=Xs048vzF1yTomQCN6Bl0SU+n/BB8cXcfkwV4hvuaHgN2iSAGuP7beXLC3/sq19zYYb
         x3P0n1A1xVev8HEv1Qnah7kgvTz1kLnVWJZBIJ4gzy4vaqPTfgCN8c8Ufza/BY+udRl8
         vN+YEzj37mjv1MTO43YCOlx5CxARNHYiA19ytnPGT2XzfZpQiQOTZ3w8eQtAgRFVN9zV
         Dgexh5Vqyi+qczPAI+Bt9QREhJLlPwZs5cqao33AJE8M9qXHs7Q/C4xRuolPp3kd4eo+
         lqxaf0hMrt2M3XnsiHkrmibyaSY3HPVZ9eqBo0yLrVW8VsUKdcbvTF4dwpkn5ye5nGIK
         0+5A==
X-Gm-Message-State: AC+VfDys7J99hw4bGfkV7ogrNah/JCJJ+PXArywwuXMugaN41M7zUY1B
        XbLAYqeqpEXilVd4+eG/WH/HUA==
X-Google-Smtp-Source: ACHHUZ5qOQzMzKP23aMzXP/Wr1FlN0hHstqfQ3C3qtCXY/8nx7ND7StpKqs9XQVDFk7g+CKhz4F8Xg==
X-Received: by 2002:a5d:4c8b:0:b0:306:37bf:ca5a with SMTP id z11-20020a5d4c8b000000b0030637bfca5amr1847639wrs.47.1685006787584;
        Thu, 25 May 2023 02:26:27 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q5-20020a5d61c5000000b0030789698eebsm1106119wrv.89.2023.05.25.02.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 02:26:26 -0700 (PDT)
Date:   Thu, 25 May 2023 08:02:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Wang Zhang <silver_code@hust.edu.cn>
Cc:     Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>,
        hust-os-kernel-patches@googlegroups.com, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] i2c: ocores: use devm_ managed clks
Message-ID: <2ca66dae-8424-4382-a0ed-ff742921c495@kili.mountain>
References: <5572a733.abc0.18846f13b0b.Coremail.m202171703@hust.edu.cn>
 <20230524154318.2259-1-silver_code@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524154318.2259-1-silver_code@hust.edu.cn>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 11:43:18PM +0800, Wang Zhang wrote:
> @@ -780,19 +768,18 @@ static int ocores_i2c_resume(struct device *dev)
>  {
>  	struct ocores_i2c *i2c = dev_get_drvdata(dev);
>  
> -	if (!IS_ERR(i2c->clk)) {
> -		unsigned long rate;
> -		int ret = clk_prepare_enable(i2c->clk);
> +	unsigned long rate;
> +	int ret = clk_prepare_enable(i2c->clk);

Don't put functions which can fail in the declaration block.  Generally
the declaration block is for preliminary stuff, and the important
actions should be in the code block.  There should not be a blank line
before the function call and the error checking.

>  
> -		if (ret) {
> -			dev_err(dev,
> -				"clk_prepare_enable failed: %d\n", ret);
> -			return ret;
> -		}
> -		rate = clk_get_rate(i2c->clk) / 1000;
> -		if (rate)
> -			i2c->ip_clock_khz = rate;
> +	if (ret) {
> +		dev_err(dev,
> +			"clk_prepare_enable failed: %d\n", ret);

This can fit on one line now.

	int ret;

	ret = clk_prepare_enable(i2c->clk);
	if (ret) {
		dev_err(dev, "clk_prepare_enable failed: %d\n", ret);
		return ret;
	}

regards,
dan carpenter

> +		return ret;
>  	}
> +	rate = clk_get_rate(i2c->clk) / 1000;
> +	if (rate)
> +		i2c->ip_clock_khz = rate;
> +
>  	return ocores_init(dev, i2c);

