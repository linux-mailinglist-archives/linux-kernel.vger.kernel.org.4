Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C963D652C38
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 06:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLUFBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 00:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLUFB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 00:01:29 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962FA1CB1A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:01:28 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so1001523pjr.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9uDeIpR3gZlQEuN6OZGowsBPkz2+a3TKumaK+E7tV7M=;
        b=SsaaBuO7tn3RAhdIkQeSVAHRMaPr9U3H2EyE9I8Rm4FTXFxB17JUFK2dq/IEM8WTOT
         fLzO2iTdrQlpwSeeeABdgkfgpBM0YeQ09TP20po29jbzYIc37v1+4X4BQOo9yfzwA3Ia
         tkXeov9L85T2o/dDHUmK2bCHPfETevmFLvBIHujttqWV7zD3vtc88nZA1DeiEGt5xSbB
         N5W7alf081O26lalJshSupqtLACVSops8UtxQuLhKGLDnL82P1UgN1Vvpd5PquPf8HGY
         U94N46N+vuUgBLEPFw1/gt8zUkbhGNtCf9nV7gxxAMzkwM6QOzGabFi4Vmlzaym5b9pS
         KaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uDeIpR3gZlQEuN6OZGowsBPkz2+a3TKumaK+E7tV7M=;
        b=es4VhQFVRcwInA8fW2cXmT3Y9rKF24lC10CUZi+gN7A4LxYXNfwZNaP6o2P6Ukr57G
         RzBxNErRhA/cpo9UEtNmGanOLXOntj8QCZU9e564AD1+UeuqjWriUorW7k7mEPN0A2GE
         UOeRj3GtlICkS5FKWIpWRr211JoHFS4rYymmbhyymms02CGA4FN67/VMjXHssTpxSuHI
         H6avsUWuh9T56ZHFXbN74YyEhz78p+SaJVqdUv9hGYhlRRY4lSXwgTOv0Ki33caNjfjy
         Tnyq1otTrVUH8CoNZXhPaVUqcLWbafcSKkUPASQLeYQ0HGf0vH47rZOKMfxfO2TlnFsc
         Wj5g==
X-Gm-Message-State: AFqh2kojoeseycfEunABeD4xzvZCHVkwP+ausg2AxKJ9+1DmTQtAIz43
        6HNAadJ5PX3VwM1EqVBgZ4DWlA==
X-Google-Smtp-Source: AMrXdXsAXXw8HbLxnwnKo/sDyx1mzhJbIJ9xlHX7fXi7HmSiLp/ONLWoanQN7QCsvyqJFciiunVQ/A==
X-Received: by 2002:a05:6300:8181:b0:a5:6ed:669f with SMTP id bt1-20020a056300818100b000a506ed669fmr17419316pzc.2.1671598888114;
        Tue, 20 Dec 2022 21:01:28 -0800 (PST)
Received: from localhost ([122.172.82.107])
        by smtp.gmail.com with ESMTPSA id u62-20020a637941000000b004790eb3fee1sm8923780pgc.90.2022.12.20.21.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 21:01:27 -0800 (PST)
Date:   Wed, 21 Dec 2022 10:31:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     treding@nvidia.com, krzysztof.kozlowski@linaro.org,
        dmitry.osipenko@collabora.com, rafael@kernel.org,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sanjayc@nvidia.com, ksitaraman@nvidia.com, ishah@nvidia.com,
        bbasu@nvidia.com
Subject: Re: [Patch v1 07/10] cpufreq: Add Tegra234 to cpufreq-dt-platdev
 blocklist
Message-ID: <20221221050125.6gndqorox5ez2gkb@vireshk-i7>
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-8-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220160240.27494-8-sumitg@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-22, 21:32, Sumit Gupta wrote:
> Tegra234 platform uses the tegra194-cpufreq driver, so add it
> to the blocklist in cpufreq-dt-platdev driver to avoid the cpufreq
> driver registration from there.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 8ab672883043..e329d29d1f9d 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -137,6 +137,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "nvidia,tegra30", },
>  	{ .compatible = "nvidia,tegra124", },
>  	{ .compatible = "nvidia,tegra210", },
> +	{ .compatible = "nvidia,tegra234", },
>  
>  	{ .compatible = "qcom,apq8096", },
>  	{ .compatible = "qcom,msm8996", },

Applied. Thanks.

-- 
viresh
