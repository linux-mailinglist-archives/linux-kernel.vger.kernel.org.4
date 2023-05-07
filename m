Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7646F9948
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjEGPXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjEGPXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:23:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400D35FF2;
        Sun,  7 May 2023 08:23:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F0DC60C7B;
        Sun,  7 May 2023 15:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF266C433D2;
        Sun,  7 May 2023 15:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683472981;
        bh=GwggOkw376MwKe9ADd4xSds5t1UcPk1BpfCQL0KqQg4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H1RZKvkY2mCBZJWqmqJu0Tem22yS/bzxke82206/cbXqSisorUgQcV4aLmdvtaa0j
         hnVWeYwWkUCJteOr7UKP2w7hEs6dPBQqql17LGVYnQXeSXo5cRJ+NFOlYa7WUpQcZu
         Q7ilImTmiBV68XCsEdoncrhNTuwCnoJe7Og1pPC9AoaZ2qoSkGtGLo7VE+Ik/sR8qP
         KHvPYVeJHE0B2e/lBTxI1RjIpfgKMqdirJV0U7rTvbs5w+eIbN+nzSq/YWk/h1SAWC
         Zb1dKMKO3CFTU4G32BHy7mYAcfrveVKWtQhatNj1IEkXFyfcjP5PQ91HjFojnE1x3S
         Un6m0CKIAsEww==
Message-ID: <8eea2352-1d4f-aa3a-7c86-9306adb0aaae@kernel.org>
Date:   Mon, 8 May 2023 00:22:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/2] ata: libata: Defer rescan on suspended device
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     bblock@linux.ibm.com, acelan.kao@canonical.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230502150435.423770-1-kai.heng.feng@canonical.com>
 <20230502150435.423770-2-kai.heng.feng@canonical.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230502150435.423770-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/05/03 0:04, Kai-Heng Feng wrote:
> During system resume, if an EH is schduled after ATA host is resumed
> (i.e. ATA_PFLAG_PM_PENDING cleared), but before the disk device is
> fully resumed, the device_lock hold by scsi_rescan_device() is never
> released so the dpm_resume() of the disk is blocked forerver.
> 
> That's because scsi_attach_vpd() is expecting the disk device is in
> operational state, as it doesn't work on suspended device.
> 
> To avoid such deadlock, defer rescan if the disk is still suspended so
> the resume process of the disk device can proceed. At the end of the
> resume process, use the complete() callback to schedule the rescan task.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v4: 
>  - No change.
> 
> v3:
>  - New patch to resolve undefined pm_suspend_target_state.
> 
> v2:
>  - Schedule rescan task at the end of system resume phase.
>  - Wording.
> 
>  drivers/ata/libata-core.c | 11 +++++++++++
>  drivers/ata/libata-eh.c   | 11 +++++++++--
>  include/linux/libata.h    |  1 +
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 8bf612bdd61a..bdd244bdb8a2 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5093,6 +5093,16 @@ static int ata_port_pm_poweroff(struct device *dev)
>  	return 0;
>  }
>  
> +static void ata_port_pm_complete(struct device *dev)
> +{
> +	struct ata_port *ap = to_ata_port(dev);
> +
> +	if (ap->pflags & ATA_PFLAG_DEFER_RESCAN)
> +		schedule_work(&(ap->scsi_rescan_task));
> +
> +	ap->pflags &= ~ATA_PFLAG_DEFER_RESCAN;

Is this called with the port lock held ? Otherwise, there is a race with
ata_eh_revalidate_and_attach() and we may end up never actually revalidating the
drive. At the very least, I think that ATA_PFLAG_DEFER_RESCAN needs to be
cleared before calling schedule_work().

> +}
> +
>  static const unsigned int ata_port_resume_ehi = ATA_EHI_NO_AUTOPSY
>  						| ATA_EHI_QUIET;
>  
> @@ -5158,6 +5168,7 @@ static const struct dev_pm_ops ata_port_pm_ops = {
>  	.thaw = ata_port_pm_resume,
>  	.poweroff = ata_port_pm_poweroff,
>  	.restore = ata_port_pm_resume,
> +	.complete = ata_port_pm_complete,
>  
>  	.runtime_suspend = ata_port_runtime_suspend,
>  	.runtime_resume = ata_port_runtime_resume,
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index a6c901811802..0881b590fb7e 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -15,6 +15,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/export.h>
>  #include <linux/pci.h>
> +#include <linux/suspend.h>
>  #include <scsi/scsi.h>
>  #include <scsi/scsi_host.h>
>  #include <scsi/scsi_eh.h>
> @@ -2983,8 +2984,14 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
>  			 */
>  			ehc->i.flags |= ATA_EHI_SETMODE;
>  
> -			/* schedule the scsi_rescan_device() here */
> -			schedule_work(&(ap->scsi_rescan_task));
> +			/* Schedule the scsi_rescan_device() here.

Code style: please start multi-line comment with a line starting with "/*"
without text after it.

> +			 * Defer the rescan if it's in process of
> +			 * suspending or resuming.
> +			 */
> +			if (pm_suspend_target_state != PM_SUSPEND_ON)

Why ? Shouldn't this be "pm_suspend_target_state == PM_SUSPEND_ON" ? Because if
the device is already resumed, why would we need to defer the rescan ?

> +				ap->pflags |= ATA_PFLAG_DEFER_RESCAN;
> +			else
> +				schedule_work(&(ap->scsi_rescan_task));
>  		} else if (dev->class == ATA_DEV_UNKNOWN &&
>  			   ehc->tries[dev->devno] &&
>  			   ata_class_enabled(ehc->classes[dev->devno])) {
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 311cd93377c7..1696c9ebd168 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -189,6 +189,7 @@ enum {
>  	ATA_PFLAG_UNLOADING	= (1 << 9), /* driver is being unloaded */
>  	ATA_PFLAG_UNLOADED	= (1 << 10), /* driver is unloaded */
>  
> +	ATA_PFLAG_DEFER_RESCAN	= (1 << 16), /* peform deferred rescan on system resume */

Do we really need a new flag ? Can't we use ATA_PFLAG_PM_PENDING correctly ?
From the rather sparse commit message description, it sounds like this flag is
being cleared too early. Not sure though. Need to dig further into this.

>  	ATA_PFLAG_SUSPENDED	= (1 << 17), /* port is suspended (power) */
>  	ATA_PFLAG_PM_PENDING	= (1 << 18), /* PM operation pending */
>  	ATA_PFLAG_INIT_GTM_VALID = (1 << 19), /* initial gtm data valid */

-- 
Damien Le Moal
Western Digital Research

