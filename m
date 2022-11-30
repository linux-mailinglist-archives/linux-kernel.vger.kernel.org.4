Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D0263D740
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 14:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiK3Nxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 08:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiK3Nxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:53:35 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E124B765;
        Wed, 30 Nov 2022 05:53:33 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NMgdH6ssrz15N2n;
        Wed, 30 Nov 2022 21:52:51 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 21:53:32 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 21:53:31 +0800
Subject: Re: [PATCH v2] mmc: core: Normalize the error handling branch in
 sd_read_ext_regs()
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221130134920.2109-1-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a111e3ab-c5ef-4cfb-5fae-99619c0840d9@huawei.com>
Date:   Wed, 30 Nov 2022 21:53:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221130134920.2109-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/30 21:49, Zhen Lei wrote:
> 1. Use pr_err() to output the error message.
> 2. Add the description of why success 0 is returned in case
>    "non-supported SD ext reg layout".
> 
> Fixes: c784f92769ae ("mmc: core: Read the SD function extension registers for power management")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/mmc/core/sd.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Sorry, I forgot to add the version difference description.

v1 --> v2:
Add a description instead of returning an error code.

v1:
https://lkml.org/lkml/2022/11/30/240

> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 3662bf5320ce56d..93ee53f74427c38 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1259,7 +1259,7 @@ static int sd_read_ext_regs(struct mmc_card *card)
>  	 */
>  	err = sd_read_ext_reg(card, 0, 0, 0, 512, gen_info_buf);
>  	if (err) {
> -		pr_warn("%s: error %d reading general info of SD ext reg\n",
> +		pr_err("%s: error %d reading general info of SD ext reg\n",
>  			mmc_hostname(card->host), err);
>  		goto out;
>  	}
> @@ -1273,7 +1273,12 @@ static int sd_read_ext_regs(struct mmc_card *card)
>  	/* Number of extensions to be find. */
>  	num_ext = gen_info_buf[4];
>  
> -	/* We support revision 0, but limit it to 512 bytes for simplicity. */
> +	/*
> +	 * We only support revision 0, and limit it to 512 bytes for simplicity.
> +	 * In other cases, success 0 is returned, because the card remains
> +	 * functional and all but the new features from the SD function
> +	 * extensions registers can still be used.
> +	 */
>  	if (rev != 0 || len > 512) {
>  		pr_warn("%s: non-supported SD ext reg layout\n",
>  			mmc_hostname(card->host));
> @@ -1288,7 +1293,7 @@ static int sd_read_ext_regs(struct mmc_card *card)
>  	for (i = 0; i < num_ext; i++) {
>  		err = sd_parse_ext_reg(card, gen_info_buf, &next_ext_addr);
>  		if (err) {
> -			pr_warn("%s: error %d parsing SD ext reg\n",
> +			pr_err("%s: error %d parsing SD ext reg\n",
>  				mmc_hostname(card->host), err);
>  			goto out;
>  		}
> 

-- 
Regards,
  Zhen Lei
