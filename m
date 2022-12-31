Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013D265A2E6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 07:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbiLaGIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 01:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiLaGIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 01:08:41 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FD7178A5;
        Fri, 30 Dec 2022 22:08:41 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id y18-20020a0568301d9200b0067082cd4679so14230951oti.4;
        Fri, 30 Dec 2022 22:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PB6nkYHwbeEU6BoPVup3kf2+k4tTb4RworfRekHpADE=;
        b=kc6hmVULeBL/e4hBDUH8LlEO9h96/31TrQkGWpCU+BfBNu5COmTRSYoIiD5+XqrMSQ
         6DhITkG8rzvzqPUja2u7q6gGtde27nXAqdZtOSa43QeWBsdnGAc5UQTsAlENzWeRpwgF
         77gXfop2J4KwekCDszlMxreXl07Po8PHbEwLM1uXFQudtbTWdy6PpPkCTMajXkJjTuVp
         hXRK8NOZ7Sx5eBlvfEstLgQ5O4NjkMCvzPStsjIlUgWLSso5ZcR5sHE+/8EO+M6S5vMP
         Yxlqsm1Z7hm9WU8AvNhnybPfFoOsUUoC/du52jiT3EbvqCO+fI9wJtgszqcFQ0LDA4lL
         eOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PB6nkYHwbeEU6BoPVup3kf2+k4tTb4RworfRekHpADE=;
        b=Qj/8b7v5lCeZAv82nZLwQy+keP7Ft6s5XwB+SdPw4MO2xRtpHNI5dY2HYMT0VdOMk1
         QLyTBsbSiN90ctc2lZkt7mKbtx9c0OVOlCMJm8dWCa9rEot+c6SD0Iva8xQVHPuelq3B
         xIE/YG9LvtQg+xX5weoP3Gp5I0Zx2wUd6C1OlYxrETQlK8CJ6xfplF8TTow+AZIcNIE/
         RqjUoOZzSaM+ozUP6EKPeJnMxT/ZV/ESG1tFa5jFLL8/vhNSCOi/D+tY8EHtLkEGOSQd
         +kLhsDbplFOCEHvemgRzxj8YvPDgdEm4YAtOwjtEOhJtxsvQXbGubsQ85C0EXKm46rXS
         F/TA==
X-Gm-Message-State: AFqh2koDVR+Npo4DH5Fp/aKRMsQ7aXx9sCxMW81j5/fO5VQUGJLkUVGs
        +Yo4S2BBnLqYlw8ANwKU81QRjdzfWX8=
X-Google-Smtp-Source: AMrXdXsc/45o+KW09Y2iUOhPUGyGhuiWnuGz2IAoXrcdgIlgurZ4WbOG4MbtpI7kwS75UX8RS5GAGA==
X-Received: by 2002:a05:6830:1459:b0:66e:7442:7d2c with SMTP id w25-20020a056830145900b0066e74427d2cmr25376611otp.30.1672466920541;
        Fri, 30 Dec 2022 22:08:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k25-20020a056830151900b0066e873e4c2csm11401715otp.45.2022.12.30.22.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 22:08:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Dec 2022 22:08:38 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: qcom: Use devm_clk_get_enabled() helper
Message-ID: <20221231060838.GD2927444@roeck-us.net>
References: <7c2d5f3815949faf6d3a0237a7b5f272f00a7ae9.1672418969.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c2d5f3815949faf6d3a0237a7b5f272f00a7ae9.1672418969.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 05:49:47PM +0100, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/qcom-wdt.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 0d2209c5eaca..d776474dcdf3 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -175,11 +175,6 @@ static const struct watchdog_info qcom_wdt_pt_info = {
>  	.identity	= KBUILD_MODNAME,
>  };
>  
> -static void qcom_clk_disable_unprepare(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static const struct qcom_wdt_match_data match_data_apcs_tmr = {
>  	.offset = reg_offset_data_apcs_tmr,
>  	.pretimeout = false,
> @@ -226,21 +221,12 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(wdt->base))
>  		return PTR_ERR(wdt->base);
>  
> -	clk = devm_clk_get(dev, NULL);
> +	clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(clk)) {
>  		dev_err(dev, "failed to get input clock\n");
>  		return PTR_ERR(clk);
>  	}
>  
> -	ret = clk_prepare_enable(clk);
> -	if (ret) {
> -		dev_err(dev, "failed to setup clock\n");
> -		return ret;
> -	}
> -	ret = devm_add_action_or_reset(dev, qcom_clk_disable_unprepare, clk);
> -	if (ret)
> -		return ret;
> -
>  	/*
>  	 * We use the clock rate to calculate the max timeout, so ensure it's
>  	 * not zero to avoid a divide-by-zero exception.
> -- 
> 2.34.1
> 
