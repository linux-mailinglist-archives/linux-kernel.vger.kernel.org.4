Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976E6637714
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiKXLDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiKXLD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:03:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F43F61BBB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:03:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7FB823A;
        Thu, 24 Nov 2022 03:03:32 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.5.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2877B3F587;
        Thu, 24 Nov 2022 03:03:25 -0800 (PST)
Date:   Thu, 24 Nov 2022 11:03:22 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Wang Honghui <honghui.wang@ucas.com.cn>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Maruss <cristian.marussi@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm_scpi: modify to support acpi
Message-ID: <Y39PetDhm9fpycwo@FVFF77S0Q05N>
References: <F813BC8072CDDB25+Y38Yq2QKFefSupZV@TP-P15V.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F813BC8072CDDB25+Y38Yq2QKFefSupZV@TP-P15V.lan>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 03:09:31PM +0800, Wang Honghui wrote:
> arm_scpi: modify to support acpi
> 
> Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>

> @@ -937,55 +952,116 @@ static int scpi_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	for (; scpi_drvinfo->num_chans < count; scpi_drvinfo->num_chans++) {
> -		resource_size_t size;
> -		int idx = scpi_drvinfo->num_chans;
> -		struct scpi_chan *pchan = scpi_drvinfo->channels + idx;
> -		struct mbox_client *cl = &pchan->cl;
> -		struct device_node *shmem = of_parse_phandle(np, "shmem", idx);
> -
> -		if (!of_match_node(shmem_of_match, shmem))
> -			return -ENXIO;
> +	/* Wang Honghui modified to support acpi */
> +	if (dev->of_node) {

[...]

> +	} else {
> +		for (; scpi_info->num_chans < count; scpi_info->num_chans++) {
> +                        u32 size;
> +                        u32 addr;
> +                        int idx = scpi_info->num_chans;
> +                        struct scpi_chan *pchan = scpi_info->channels + idx;
> +                        struct mbox_client *cl = &pchan->cl;
> +                        struct fwnode_handle *fn;
> +
> +                        fn = dev_fwnode(&(pdev->dev));
> +                        ret = fwnode_property_read_u32(fn, "shmem_start",  &addr);
> +                        if (ret < 0) {
> +                                dev_err(dev, "failed to get SCPI payload mem resource\n");
> +                                return ret;
> +                        }
> +
> +                        ret = fwnode_property_read_u32(fn, "shmem_size",  &size);
> +                        if (ret < 0) {
> +                                dev_err(dev, "failed to ioremap SCPI payload\n");
> +                                return -EADDRNOTAVAIL;
> +                        }

ACPI has native mechanisms to describe IO resources, so this doesn't look right at all.

Does ARM have ACPI bindings for SCPI? I don't think we should be inventing
vendor-specific bindings for this....

> +                        if (!ret) {
> +                                pchan->chan = phytium_mbox_request_channel(cl);

... so this looks very wrong.

Thanks,
Mark.
