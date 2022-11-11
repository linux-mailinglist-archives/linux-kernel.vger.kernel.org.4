Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C1E625F33
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiKKQNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiKKQNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:13:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 935BA6594
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:13:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C5A71FB;
        Fri, 11 Nov 2022 08:13:46 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43D9B3F73D;
        Fri, 11 Nov 2022 08:13:39 -0800 (PST)
Date:   Fri, 11 Nov 2022 16:13:36 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ludvig =?utf-8?Q?P=C3=A4rsson?= <ludvig.parsson@axis.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>, kernel@axis.com,
        Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tee: optee: Populate child nodes in probe function
Message-ID: <20221111161336.msozo7l632jvbwcn@bogus>
References: <20221109160708.507481-1-ludvig.parsson@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221109160708.507481-1-ludvig.parsson@axis.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 05:07:08PM +0100, Ludvig Pärsson wrote:
> Currently there is no dependency between the "linaro,scmi-optee" driver
> and the tee_core. If the scmi-optee driver gets probed before the
> tee_bus_type is initialized, then we will get an unwanted error print.
> 
> This patch enables putting scmi-optee nodes as children to the optee
> node in devicetree, which indirectly creates the missing dependency.
> 
> Signed-off-by: Ludvig Pärsson <ludvig.parsson@axis.com>
> ---
>  drivers/tee/optee/smc_abi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index a1c1fa1a9c28..be6f02fd5a7f 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1533,6 +1533,11 @@ static int optee_probe(struct platform_device *pdev)
>  	if (rc)
>  		goto err_disable_shm_cache;
>  
> +	/* Populate any dependent child node (if any) */
> +	rc = devm_of_platform_populate(&pdev->dev);
> +	if (rc)
> +		goto err_disable_shm_cache;
> +

While I agree with idea of populating dependent child nodes from here,
I am not sure if it is OK to give error if that fails or to just continue
as there may be other users(like the user-space) for the OPTEE in general.

-- 
Regards,
Sudeep
