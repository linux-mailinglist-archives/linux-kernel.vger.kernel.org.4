Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8689720E87
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 09:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjFCHmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 03:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFCHmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 03:42:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7175D1A6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 00:42:33 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QYBY82q45z18KHx;
        Sat,  3 Jun 2023 15:37:48 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 3 Jun 2023 15:42:30 +0800
Subject: Re: [PATCH 2/4] ACPI/APMT: Don't register invalid resource
To:     Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>
CC:     <mark.rutland@arm.com>, <suzuki.poulose@arm.com>,
        <bwicaksono@nvidia.com>, <ilkka@os.amperecomputing.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <cover.1685619571.git.robin.murphy@arm.com>
 <91c8787f1e84d79e110a057615c838f6ac244669.1685619571.git.robin.murphy@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <fff39213-5824-4bd6-f0cd-699358eb5361@huawei.com>
Date:   Sat, 3 Jun 2023 15:42:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <91c8787f1e84d79e110a057615c838f6ac244669.1685619571.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/1 19:59, Robin Murphy wrote:
> Don't register a resource for the second page unless the dual-page
> extension flag is actually present to say it's valid.
> 
> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
> CC: Hanjun Guo <guohanjun@huawei.com>
> CC: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Not a critical fix, since the driver currently works around this itself,
> but patch #4 would like to clean that up.
> 
>   drivers/acpi/arm64/apmt.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
> index 8cab69fa5d59..aa7d5c3c0dd8 100644
> --- a/drivers/acpi/arm64/apmt.c
> +++ b/drivers/acpi/arm64/apmt.c
> @@ -35,11 +35,13 @@ static int __init apmt_init_resources(struct resource *res,
>   
>   	num_res++;
>   
> -	res[num_res].start = node->base_address1;
> -	res[num_res].end = node->base_address1 + SZ_4K - 1;
> -	res[num_res].flags = IORESOURCE_MEM;
> +	if (node->flags & ACPI_APMT_FLAGS_DUAL_PAGE) {
> +		res[num_res].start = node->base_address1;
> +		res[num_res].end = node->base_address1 + SZ_4K - 1;
> +		res[num_res].flags = IORESOURCE_MEM;
>   
> -	num_res++;
> +		num_res++;
> +	}
>   
>   	if (node->ovflw_irq != 0) {
>   		trigger = (node->ovflw_irq_flags & ACPI_APMT_OVFLW_IRQ_FLAGS_MODE);

Good catch,

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
