Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2078960F6F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiJ0MQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiJ0MQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:16:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAB92DCE92
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:16:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B80D023A;
        Thu, 27 Oct 2022 05:16:09 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.1.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07EE03F7B4;
        Thu, 27 Oct 2022 05:16:01 -0700 (PDT)
Date:   Thu, 27 Oct 2022 13:15:59 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Johan Hovold <johan+linaro@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firmware/psci: demote suspend-mode warning to info
 level
Message-ID: <Y1p2f6OnN2wjCuop@FVFF77S0Q05N>
References: <20221026135445.8004-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026135445.8004-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 03:54:45PM +0200, Johan Hovold wrote:
> On some Qualcomm platforms, like SC8280XP, the attempt to set PC mode
> during boot fails with PSCI_RET_DENIED and since commit 998fcd001feb
> ("firmware/psci: Print a warning if PSCI doesn't accept PC mode") this
> is now logged at warning level:
> 
> 	psci: failed to set PC mode: -3
> 
> As there is nothing users can do about the firmware behaving this way,
> demote the warning to info level and clearly mark it as a firmware bug:
> 
> 	psci: [Firmware Bug]: failed to set PC mode: -3
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

On the assumption that we don't have any latent issues in this case, this looks
ok to me, so:

  Acked-by: Mark Rutland <mark.rutland@arm.com>

Sudeep, does this reasonable to you?

Are there any latent issues that mean we should keep this as a pr_warn()? 

Thanks,
Mark.

> ---
>  drivers/firmware/psci/psci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index e7bcfca4159f..f8fa32f0a130 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -165,7 +165,8 @@ int psci_set_osi_mode(bool enable)
>  
>  	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
>  	if (err < 0)
> -		pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
> +		pr_info(FW_BUG "failed to set %s mode: %d\n",
> +				enable ? "OSI" : "PC", err);
>  	return psci_to_linux_errno(err);
>  }
>  
> -- 
> 2.37.3
> 
