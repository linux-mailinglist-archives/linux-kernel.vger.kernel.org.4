Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E155642374
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiLEHMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiLEHMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:12:13 -0500
Received: from out30-8.freemail.mail.aliyun.com (out30-8.freemail.mail.aliyun.com [115.124.30.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73205BF5E;
        Sun,  4 Dec 2022 23:12:12 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=0;PH=DS;RN=5;SR=0;TI=SMTPD_---0VWOYkxM_1670224329;
Received: from 30.97.48.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VWOYkxM_1670224329)
          by smtp.aliyun-inc.com;
          Mon, 05 Dec 2022 15:12:09 +0800
Message-ID: <2b6381f9-dc23-05c9-0d24-3c86ccd264bc@linux.alibaba.com>
Date:   Mon, 5 Dec 2022 15:12:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] power: supply: fix null pointer dereferencing in
 power_supply_get_battery_info
To:     ruanjinjie <ruanjinjie@huawei.com>, sre@kernel.org,
        linus.walleij@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221204023857.1621757-1-ruanjinjie@huawei.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20221204023857.1621757-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/4/2022 10:38 AM, ruanjinjie wrote:
> when kmalloc() fail to allocate memory in kasprintf(), propname
> will be NULL, strcmp() called by of_get_property() will cause
> null pointer dereference.
> 
> So directly return ENOMEM, if kasprintf() return NULL pointer.
> 
> Fixes: 3afb50d7125b ("power: supply: core: Add some helpers to use the battery OCV capacity table")
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
>   drivers/power/supply/power_supply_core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 4b5fb172fa99..2fd6ab7a4471 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -750,6 +750,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
>   		int i, tab_len, size;
>   
>   		propname = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d", index);
> +		if (!propname)
> +			return -ENOMEM;

Please read the code carefully, you can not just return error number 
without releasing resource.

>   		list = of_get_property(battery_np, propname, &size);
>   		if (!list || !size) {
>   			dev_err(&psy->dev, "failed to get %s\n", propname);
