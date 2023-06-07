Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB0D7262B0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjFGOWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240634AbjFGOWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:22:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8040C1BFE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB4CB63F38
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 14:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD41EC433EF;
        Wed,  7 Jun 2023 14:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686147721;
        bh=PWyDPpucE3UwcC14P8MHk7X2eKHdVp0MmHoFYCJy4qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rSGIo2wqQgc1/y1rp138JEiKgpzLFwl2+PF4HMRDblbeb9FQc+AVj5dQj8Zwgt5V/
         AkxUR3cAds3TTQT4sjR/GPBht6ndNOAJqwY21hkqbckTO367GuXnTYNLekPFitosoe
         vzni+2Q9BZtX4AFKa4kgl6Od0BJZKuBZUJ9wie3LSrVPzp32N82YJFvwIpitEL5DmG
         t4KyDCtW6m4qA5NdFIZ3NTdCIYYqtxEbSe67CZ4buibN2pg6scPmlEChII+p6urVj4
         vLT0D+XQ5tQQQS/Q2oAOqnoXuUO+fhPJkX4fKH9Mc2Idv/dCt0lRRiXwjTuvm++vvj
         i8Cr4jMHsZsog==
Date:   Wed, 7 Jun 2023 16:21:55 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        bwicaksono@nvidia.com, ilkka@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v2 2/4] ACPI/APMT: Don't register invalid resource
Message-ID: <ZICSg1voX4yKfU+m@lpieralisi>
References: <cover.1685983270.git.robin.murphy@arm.com>
 <63b34656e1f7b41bcb458fb6d7496e04db757e0d.1685983270.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63b34656e1f7b41bcb458fb6d7496e04db757e0d.1685983270.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 06:01:32PM +0100, Robin Murphy wrote:
> Don't register a resource for the second page unless the dual-page
> extension flag is actually present to say it's valid.
> 
> CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
> CC: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/acpi/arm64/apmt.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

As you mentioned in v1 I don't think we need to backport this
since the kernel is working around it (in code you are cleaning
up) even though that would not hurt.

Lorenzo

> diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
> index 8cab69fa5d59..aa7d5c3c0dd8 100644
> --- a/drivers/acpi/arm64/apmt.c
> +++ b/drivers/acpi/arm64/apmt.c
> @@ -35,11 +35,13 @@ static int __init apmt_init_resources(struct resource *res,
>  
>  	num_res++;
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
>  	if (node->ovflw_irq != 0) {
>  		trigger = (node->ovflw_irq_flags & ACPI_APMT_OVFLW_IRQ_FLAGS_MODE);
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 
