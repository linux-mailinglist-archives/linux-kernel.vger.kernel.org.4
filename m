Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A4D642724
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiLELFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiLELFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:05:01 -0500
Received: from out30-6.freemail.mail.aliyun.com (out30-6.freemail.mail.aliyun.com [115.124.30.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD4A15FEF;
        Mon,  5 Dec 2022 03:04:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=0;PH=DS;RN=5;SR=0;TI=SMTPD_---0VWSuwMa_1670238296;
Received: from 30.97.48.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VWSuwMa_1670238296)
          by smtp.aliyun-inc.com;
          Mon, 05 Dec 2022 19:04:56 +0800
Message-ID: <ea327ec7-e9f3-b589-43f5-70b5f1a0025a@linux.alibaba.com>
Date:   Mon, 5 Dec 2022 19:05:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] power: supply: fix null pointer dereferencing in
 power_supply_get_battery_info
To:     ruanjinjie <ruanjinjie@huawei.com>, sre@kernel.org,
        linus.walleij@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221205075153.2830393-1-ruanjinjie@huawei.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20221205075153.2830393-1-ruanjinjie@huawei.com>
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



On 12/5/2022 3:51 PM, ruanjinjie wrote:
> when kmalloc() fail to allocate memory in kasprintf(), propname
> will be NULL, strcmp() called by of_get_property() will cause
> null pointer dereference.
> 
> So return ENOMEM if kasprintf() return NULL pointer.
> 
> Fixes: 3afb50d7125b ("power: supply: core: Add some helpers to use the battery OCV capacity table")
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> v2:
> - release resource instead of just returning error number
> ---
>   drivers/power/supply/power_supply_core.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 4b5fb172fa99..afbe9eecfc30 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -750,6 +750,11 @@ int power_supply_get_battery_info(struct power_supply *psy,
>   		int i, tab_len, size;
>   
>   		propname = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d", index);
> +		if (!propname) {
> +			power_supply_put_battery_info(psy, info);
> +			err = -ENOMEM;
> +			goto out_put_node;
> +		}
>   		list = of_get_property(battery_np, propname, &size);
>   		if (!list || !size) {
>   			dev_err(&psy->dev, "failed to get %s\n", propname);
