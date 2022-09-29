Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40395EF0D9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbiI2IuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI2IuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:50:04 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E7257569;
        Thu, 29 Sep 2022 01:50:01 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28T3rrg9004118;
        Thu, 29 Sep 2022 10:49:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Wiofu9rgpuc65f8rPaqHRSUum4t8vxulsqM/fN8xAIQ=;
 b=g234rio/WSMJtn7ImOlYWED7msuragbYqoRTN/yYULxEHMeqp6jile9k1UgKq075AZko
 keL7sIRshNQc/dPDPMsGBuog3J4z4qljDQpqf3wu6n1LbZt5gcAG85icT5ZG07pngC83
 ii95L6LJa3xQDPcewAKkJVvzqxeKi1QjEyyxDkHIFENih375+BH+Al9+yAU0SmtozOB7
 VBz5ruwcXM+7gfe6k6/1Gt5QfxHEYQN25bQR+6A/onR4RypEMAeFC7CwOdNU/rRSbA1N
 qBgj8KQBJpm7JKBNlduw1Yujj4UXhuSMUIlkbi3crbb+NKg9fLUhN19k7C9RwMxKxMrM vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jss82p4r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 10:49:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2301B10002A;
        Thu, 29 Sep 2022 10:49:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1AA1021A217;
        Thu, 29 Sep 2022 10:49:30 +0200 (CEST)
Received: from [10.201.21.72] (10.75.127.45) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Thu, 29 Sep
 2022 10:49:29 +0200
Message-ID: <88c9109d-2c97-ac21-91dc-4025dd27b552@foss.st.com>
Date:   Thu, 29 Sep 2022 10:49:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] pinctrl: st: stop abusing of_get_named_gpio()
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <YzSsgoVoJn4+mSpv@google.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <YzSsgoVoJn4+mSpv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_04,2022-09-29_02,2022-06-22_01
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry

On 9/28/22 22:20, Dmitry Torokhov wrote:
> Pin descriptions for this chip only look like standard GPIO device tree
> descriptions, while in fact they contain additional data (in excess of
> number of cells specified in description of gpio controllers). They also
> refer to only pins/gpios belonging to the driver and not to arbitrary
> gpio in the system.
> 
> Because we want to stop exporting OF-specific handlers from gpiolib-of,
> let's parse the pin reference ourself instead of trying to call
> of_get_named_gpio().
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> Just compiled, not tested on real hardware.
> 
>  drivers/pinctrl/pinctrl-st.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
> index 0fea71fd9a00..cf7f9cbe6044 100644
> --- a/drivers/pinctrl/pinctrl-st.c
> +++ b/drivers/pinctrl/pinctrl-st.c
> @@ -12,7 +12,6 @@
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
> -#include <linux/of_gpio.h> /* of_get_named_gpio() */
>  #include <linux/of_address.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/regmap.h>
> @@ -1162,6 +1161,31 @@ static void st_parse_syscfgs(struct st_pinctrl *info, int bank,
>  	return;
>  }
>  
> +static int st_pctl_dt_calculate_pin(struct st_pinctrl *info,
> +				    phandle bank, unsigned int offset)
> +{
> +	struct device_node *np;
> +	struct gpio_chip *chip;
> +	int retval = -EINVAL;
> +	int i;
> +
> +	np = of_find_node_by_phandle(bank);
> +	if (!np)
> +		return -EINVAL;
> +
> +	for (i = 0; i < info->nbanks; i++) {
> +		chip = &info->banks[i].gpio_chip;
> +		if (chip->of_node == np) {
> +			if (offset < chip->ngpio)
> +				retval = chip->base + offset;
> +			break;
> +		}
> +	}
> +
> +	of_node_put(np);
> +	return retval;
> +}
> +
>  /*
>   * Each pin is represented in of the below forms.
>   * <bank offset mux direction rt_type rt_delay rt_clk>
> @@ -1175,6 +1199,8 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
>  	struct device *dev = info->dev;
>  	struct st_pinconf *conf;
>  	struct device_node *pins;
> +	phandle bank;
> +	unsigned int offset;
>  	int i = 0, npins = 0, nr_props, ret = 0;
>  
>  	pins = of_get_child_by_name(np, "st,pins");
> @@ -1214,9 +1240,9 @@ static int st_pctl_dt_parse_groups(struct device_node *np,
>  		conf = &grp->pin_conf[i];
>  
>  		/* bank & offset */
> -		be32_to_cpup(list++);
> -		be32_to_cpup(list++);
> -		conf->pin = of_get_named_gpio(pins, pp->name, 0);
> +		bank = be32_to_cpup(list++);
> +		offset = be32_to_cpup(list++);
> +		conf->pin = st_pctl_dt_calculate_pin(info, bank, offset);
>  		conf->name = pp->name;
>  		grp->pins[i] = conf->pin;
>  		/* mux */

I tested it on stih410-b2260 board

Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
