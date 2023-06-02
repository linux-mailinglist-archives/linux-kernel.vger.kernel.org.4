Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A2171FF59
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbjFBKbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbjFBKaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:30:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6756A1FF0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:28:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27AE412FC;
        Fri,  2 Jun 2023 03:27:54 -0700 (PDT)
Received: from [10.57.22.125] (unknown [10.57.22.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5924C3F7BD;
        Fri,  2 Jun 2023 03:27:07 -0700 (PDT)
Message-ID: <fa49e5fc-7856-5698-d555-c4277a05478b@arm.com>
Date:   Fri, 2 Jun 2023 11:27:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH 2/4] ACPI/APMT: Don't register invalid resource
To:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org
Cc:     mark.rutland@arm.com, bwicaksono@nvidia.com,
        ilkka@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <cover.1685619571.git.robin.murphy@arm.com>
 <91c8787f1e84d79e110a057615c838f6ac244669.1685619571.git.robin.murphy@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <91c8787f1e84d79e110a057615c838f6ac244669.1685619571.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 12:59, Robin Murphy wrote:
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

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
