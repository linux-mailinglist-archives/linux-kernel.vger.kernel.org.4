Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D85A6E217D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjDNLBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjDNLBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:01:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B00E49FF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:01:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8DA82F4;
        Fri, 14 Apr 2023 04:01:56 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD91B3F587;
        Fri, 14 Apr 2023 04:01:10 -0700 (PDT)
Date:   Fri, 14 Apr 2023 12:01:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Johan Hovold <johan+linaro@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] firmware/psci: demote suspend-mode warning to
 info level
Message-ID: <ZDkyc0cVcgmbnrDt@FVFF77S0Q05N>
References: <20230414084619.31524-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414084619.31524-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 10:46:19AM +0200, Johan Hovold wrote:
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
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> This one fell between the cracks so resending with tags added.
> 
> Mark or Lorenzo, is this something you can pick up?
> 
> Johan

Sorry about this.

I don't think we have anything else in this area, so Arnd, are you happy to
pick this via the soc tree?

Thanks,
Mark.

> 
> 
>  drivers/firmware/psci/psci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 29619f49873a..d9629ff87861 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -167,7 +167,8 @@ int psci_set_osi_mode(bool enable)
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
> 2.39.2
> 
