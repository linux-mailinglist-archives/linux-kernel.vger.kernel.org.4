Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221BE5FACB6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJKGYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJKGXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:23:49 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AEB876B5;
        Mon, 10 Oct 2022 23:23:20 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B2qCck029031;
        Tue, 11 Oct 2022 08:23:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=6v4jn48G55j1zHu6u3iSPwnoOxrHr4uzOjtBt2iTrI4=;
 b=0uMnwiZ0mVoxSnnBVOwzYz8letyhQMeeqW6dWi8TT3vuX1k8Te3pTkTdkBLKm/8AexaR
 HiaiWTPqryv96rnes/yZjbSF0YLVNop9ldmw7ytb1xQy5gJ5kGYVMAryfqTyC+a7dRId
 qKCOahY7evDN1XileHvKFPO5F7YjZ7Ce/Bkm03879nuP+kGds589O8hD5T8ctjk/SHvh
 hkSVOl731ITPL8gfTupstixVwYP3fnOuse7eY25aJaSLdNuXb2g/pPOEjEZdozf6b74e
 RAGnbbzpaWF1mtrF6O5f8fZyMC/sPJ+H9fd2bxD2LCeRNHU9sC6/+d+ct8HnwYLh5Sy4 Rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k31gprnwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 08:23:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F3A9510002A;
        Tue, 11 Oct 2022 08:23:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EF5712128D0;
        Tue, 11 Oct 2022 08:23:01 +0200 (CEST)
Received: from [10.201.21.72] (10.75.127.119) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Tue, 11 Oct
 2022 08:23:01 +0200
Message-ID: <26cd3948-b86d-82c1-4b11-c28e8b8482b6@foss.st.com>
Date:   Tue, 11 Oct 2022 08:23:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1 1/1] pinctrl: st: Switch to use fwnode instead of
 of_node
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20221010075615.43244-1-andriy.shevchenko@linux.intel.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20221010075615.43244-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-11_03,2022-10-10_02,2022-06-22_01
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/22 09:56, Andy Shevchenko wrote:
> The OF node in the GPIO library is deprecated and soon
> will be removed.
> 
> GPIO library now accepts fwnode as a firmware node, so
> switch the driver to use it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/pinctrl-st.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
> index cf7f9cbe6044..987878c83349 100644
> --- a/drivers/pinctrl/pinctrl-st.c
> +++ b/drivers/pinctrl/pinctrl-st.c
> @@ -1175,7 +1175,7 @@ static int st_pctl_dt_calculate_pin(struct st_pinctrl *info,
>  
>  	for (i = 0; i < info->nbanks; i++) {
>  		chip = &info->banks[i].gpio_chip;
> -		if (chip->of_node == np) {
> +		if (chip->fwnode == of_fwnode_handle(np)) {
>  			if (offset < chip->ngpio)
>  				retval = chip->base + offset;
>  			break;
> @@ -1518,7 +1518,7 @@ static int st_gpiolib_register_bank(struct st_pinctrl *info,
>  	bank->gpio_chip = st_gpio_template;
>  	bank->gpio_chip.base = bank_num * ST_GPIO_PINS_PER_BANK;
>  	bank->gpio_chip.ngpio = ST_GPIO_PINS_PER_BANK;
> -	bank->gpio_chip.of_node = np;
> +	bank->gpio_chip.fwnode = of_fwnode_handle(np);
>  	bank->gpio_chip.parent = dev;
>  	spin_lock_init(&bank->lock);
>  
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
