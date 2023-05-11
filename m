Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB36FFA1E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbjEKTZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbjEKTZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:25:54 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51086A76;
        Thu, 11 May 2023 12:25:49 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4896E8617A;
        Thu, 11 May 2023 21:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683833147;
        bh=rHgsU9iR5Pjtdw37Mctvncab17xEMiFi6e0Q5zJkhRg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hHb17e/gL1rekh+QZtswChKgA9OlDsWRDuyHH41Tv1VOmaI2TX9BxIyMzGO+XN72m
         9oN6FKHFIC0oJ3EOkGXZ0mxP3/iIZd4DSTx/I1ZKB9hydc89jYCN/ejSN9R3CF1eBR
         yywRLFACaZkk9uMtwMd8p1CKQa0NA0B0Q5p1zPJyu2gxRDEh9vriFKLRb9vo7/ZS9r
         DNxETqBgRikMpMj7tsJ2JSY7E1WW6iqxJx5Ppk07+8GAv0cOLZxtarAxNj/JCu7An1
         McTTnSvmEEE5VwgrS025pdtEFRvCCxOwrHTXxn4wCUIS6fFm8GONUqpISdYSf05kLW
         oTT3ThQqKBetA==
Message-ID: <898fe00e-43f4-a8aa-b2b4-5b293fc77640@denx.de>
Date:   Thu, 11 May 2023 21:25:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] cpufreq: imx6q: Disable only available frequencies
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230511092334.3017-1-cniedermaier@dh-electronics.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230511092334.3017-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 11:23, Christoph Niedermaier wrote:
> In the example in Documentation/power/opp.rst, an availability check
> is present before disabling a specific frequency. If a frequency isn't
> available, the warning of a failed disabling of a non-existent
> frequency is misleading. Therefore, check the availability of the
> frequency in a separate inline function before disabling it.

[...]

> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 48e1772e98fd..4e2d2bc47aba 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -209,6 +209,21 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
>   	.suspend = cpufreq_generic_suspend,
>   };
>   
> +static inline int disable_freq_if_available(struct device *dev,

The inline isn't needed, esp. on static function, let the compiler 
figure it out.

Also, "disable if available" should rather be "disable if unavailable" I 
think ?

> +					    unsigned long freq)
> +{
> +	struct dev_pm_opp *opp;
> +	int ret = 0;
> +
> +	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
> +	if (!IS_ERR(opp)) {
> +		dev_pm_opp_put(opp);
> +		ret = dev_pm_opp_disable(dev, freq);
> +	}
> +
> +	return ret;
> +}
> +
>   #define OCOTP_CFG3			0x440
>   #define OCOTP_CFG3_SPEED_SHIFT		16
>   #define OCOTP_CFG3_SPEED_1P2GHZ		0x3
> @@ -254,16 +269,16 @@ static int imx6q_opp_check_speed_grading(struct device *dev)
>   	val &= 0x3;
>   
>   	if (val < OCOTP_CFG3_SPEED_996MHZ)
> -		if (dev_pm_opp_disable(dev, 996000000))
> +		if (disable_freq_if_available(dev, 996000000))
>   			dev_warn(dev, "failed to disable 996MHz OPP\n");
>   
>   	if (of_machine_is_compatible("fsl,imx6q") ||
>   	    of_machine_is_compatible("fsl,imx6qp")) {

Can we introduce a function like:

void imx_disable_freq_if_unavailable(struct device *dev, u32 freq_mhz, 
u32 val, u32 mask)
{
    if (val == mask)
      return;
    if (!disable_freq_if_available(dev, freq_mhz * 1000000))
      return;
    dev_warn(dev, "failed to disable %dMHz OPP\n", mhz);
}

And then just call it multiple times in here, to reduce duplication ?

>   		if (val != OCOTP_CFG3_SPEED_852MHZ)
> -			if (dev_pm_opp_disable(dev, 852000000))
> +			if (disable_freq_if_available(dev, 852000000))
>   				dev_warn(dev, "failed to disable 852MHz OPP\n");

[...]
