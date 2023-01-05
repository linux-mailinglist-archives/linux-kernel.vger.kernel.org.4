Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D9D65EC68
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjAENJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjAENIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:08:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F35325BA04
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:08:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 821ED15BF;
        Thu,  5 Jan 2023 05:09:17 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.45.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47CAB3F663;
        Thu,  5 Jan 2023 05:08:34 -0800 (PST)
Date:   Thu, 5 Jan 2023 13:08:31 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH] firmware/psci: Don't register with debugfs if PSCI isn't
 available
Message-ID: <Y7bLz/1ISoKdNoLW@FVFF77S0Q05N>
References: <20230105090834.630238-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105090834.630238-1-maz@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 09:08:34AM +0000, Marc Zyngier wrote:
> Contrary to popular belief, PSCI is not a universal property of an
> ARM/arm64 system. There is a garden variety of systems out there
> that don't (or even cannot) implement it.
> 
> I'm the first one deplore such a situation, but hey...
> 
> On such systems, a "cat /sys/kernel/debug/psci" results in
> fireworks, as no invocation callback is registered.
> 
> Check for the invoke_psci_fn and psci_ops.get_version pointers
> before registering with the debugfs subsystem, avoiding the
> issue altogether.
> 
> Fixes: 3137f2e60098 ("firmware/psci: Add debugfs support to ease debugging")
> Reported-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/firmware/psci/psci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index e7bcfca4159f..447ee4ea5c90 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -440,6 +440,9 @@ static const struct file_operations psci_debugfs_ops = {
>  
>  static int __init psci_debugfs_init(void)
>  {
> +	if (!invoke_psci_fn || !psci_ops.get_version)
> +		return 0;
> +
>  	return PTR_ERR_OR_ZERO(debugfs_create_file("psci", 0444, NULL, NULL,
>  						   &psci_debugfs_ops));
>  }
> -- 
> 2.34.1
> 
