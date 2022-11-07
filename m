Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7873461F139
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiKGKzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiKGKzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:55:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70EC7F9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:55:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5789C1FB;
        Mon,  7 Nov 2022 02:55:17 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 728B33F73D;
        Mon,  7 Nov 2022 02:55:09 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:55:06 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] firmware/psci: Switch to the sys-off handler API
Message-ID: <20221107105506.pfoxmngp7shhci3p@bogus>
References: <20221105214841.7828-1-samuel@sholland.org>
 <20221105214841.7828-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105214841.7828-3-samuel@sholland.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 04:48:40PM -0500, Samuel Holland wrote:
> Any other poweroff handlers registered at the default priority will
> run before the legacy pm_power_off() function. Register the PSCI
> poweroff handler with the correct priority to ensure it runs first.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  drivers/firmware/psci/psci.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index e7bcfca4159f..6d528021925d 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -13,7 +13,6 @@
>  #include <linux/errno.h>
>  #include <linux/linkage.h>
>  #include <linux/of.h>
> -#include <linux/pm.h>
>  #include <linux/printk.h>
>  #include <linux/psci.h>
>  #include <linux/reboot.h>
> @@ -322,9 +321,11 @@ static struct notifier_block psci_sys_reset_nb = {
>  	.priority = 129,
>  };
>  
> -static void psci_sys_poweroff(void)
> +static int psci_sys_poweroff(struct sys_off_data *data)
>  {
>  	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
> +
> +	return NOTIFY_DONE;

Just note that PSCI SYSTEM_OFF doesn't return and hence the above return
is useless. I understand the generic idea here and should be fine, just
thought of pointing that the firmware won't return from the call.

-- 
Regards,
Sudeep
