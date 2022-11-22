Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B31E6341BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbiKVQnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiKVQnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:43:21 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E753B627EC;
        Tue, 22 Nov 2022 08:43:12 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMEcLLU023395;
        Tue, 22 Nov 2022 17:42:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=HK/hUX/1Uxhh9PLD29GekR3TIoW6hLHvQUyNtMEWAy8=;
 b=M0hetnGNa5Rj3RRaEgFQGBhBigSHcxkNZAPbcPSw6ehY7v0zsY4erHyLf3C2G757K4mb
 6atdDXjrjI1JEUZdJ4gTigfujQjY+nJCOxNLDNkUppSF4qfSaYM8VlFoEZ6vK+RFPc+F
 xXly1LtE4crDD9JchcdwjrUzXxxi9/Z53jZrLvcpi7rObBPSdDhjVz5BFU79i+tceWZl
 gg857lUqvhRgYG9inHQB6IBvqrslXeCE8Vs2tcd8Qzhr1KAsSIU+h0gqk1BFpvKZNe4T
 rPO5/iv68GLfIDABWofV+C4EpcNKLem0S2b6Mse8P9HJdIUoFHRjklrrAvMfAr1IWCxS sg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3m10c48rcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 17:42:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BBAE6100038;
        Tue, 22 Nov 2022 17:42:41 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7ACA3236953;
        Tue, 22 Nov 2022 17:42:41 +0100 (CET)
Received: from [10.201.20.130] (10.201.20.130) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Tue, 22 Nov
 2022 17:42:40 +0100
Message-ID: <e83b6f9a-9144-130e-aebb-17529d3d4d64@foss.st.com>
Date:   Tue, 22 Nov 2022 17:42:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] clk: st: Fix memory leak in st_of_quadfs_setup()
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <windhl@126.com>, <avolmat@me.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221122133614.184910-1-xiujianfeng@huawei.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20221122133614.184910-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.130]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_11,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiu

On 11/22/22 14:36, Xiu Jianfeng wrote:
> If st_clk_register_quadfs_pll() fails, @lock should be freed before goto
> @err_exit, otherwise will cause meory leak issue, fix it.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  drivers/clk/st/clkgen-fsyn.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
> index d820292a381d..40df1db102a7 100644
> --- a/drivers/clk/st/clkgen-fsyn.c
> +++ b/drivers/clk/st/clkgen-fsyn.c
> @@ -1020,9 +1020,10 @@ static void __init st_of_quadfs_setup(struct device_node *np,
>  
>  	clk = st_clk_register_quadfs_pll(pll_name, clk_parent_name, datac->data,
>  			reg, lock);
> -	if (IS_ERR(clk))
> +	if (IS_ERR(clk)) {
> +		kfree(lock);
>  		goto err_exit;
> -	else
> +	} else
>  		pr_debug("%s: parent %s rate %u\n",
>  			__clk_get_name(clk),
>  			__clk_get_name(clk_get_parent(clk)),

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
