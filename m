Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0390E731DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjFOQcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjFOQcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:32:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B5912E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686846724; x=1718382724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XhSm0Ah8n5TfTVfCC5FzcpXI4AyB4pPPo3UttJyIm5c=;
  b=KI/5B/4rNucmzmfzXCPH47jLsuByaM4iXhqBbsna/gbtXw0awmXSQKzM
   XTLhH5kEpLM4l+p5SV0ba+2DOYPHvS7vZoy9fBTaRg4ZzRnF+AYFQyguV
   SV/4B9P5J6dWtwYNKgdXJYbi/Vr4UviWGLGuTb0i71fQB/1qYpURiVFzD
   BRfvjQRrn/6ixTK2t6fCgYXNfVTA7ac+0+Ik+FX8oFWKhW1RTtPWs9GzY
   za/jdirCmWu+nepYR+dPAGmbyzoWSl+VG/6CdOsT6DWxRQoytAe4Ur9Dm
   liB+pWO1ZyuaOzRJYgRt4RmFLGUd8WdM5CLQ8UIQstoMvu/YVXxecQTan
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="445338205"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="445338205"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 09:31:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="886747196"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="886747196"
Received: from ckale-mobl1.amr.corp.intel.com (HELO desk) ([10.212.176.170])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 09:31:35 -0700
Date:   Thu, 15 Jun 2023 09:31:25 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Jordy Zomer <jordyzomer@google.com>
Cc:     linux-kernel@vger.kernel.org, phil@philpotter.co.uk
Subject: Re: [PATCH v2 1/1] cdrom: Fix spectre-v1 gadget
Message-ID: <20230615163125.td3aodpfwth5n4mc@desk>
References: <20230612110040.849318-1-jordyzomer@google.com>
 <20230612110040.849318-2-jordyzomer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612110040.849318-2-jordyzomer@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:00:40AM +0000, Jordy Zomer wrote:
> This patch fixes a spectre-v1 gadget in cdrom.
> The gadget could be triggered by,
>  speculatviely bypassing the cdi->capacity check.
> 
> Signed-off-by: Jordy Zomer <jordyzomer@google.com>
> ---
>  drivers/cdrom/cdrom.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 416f723a2dbb..ecf2b458c108 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -264,6 +264,7 @@
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> +#include <linux/nospec.h>
>  #include <linux/slab.h> 
>  #include <linux/cdrom.h>
>  #include <linux/sysctl.h>
> @@ -2329,6 +2330,9 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
>  	if (arg >= cdi->capacity)
>  		return -EINVAL;
>  
> +	/* Prevent arg from speculatively bypassing the length check */
> +	barrier_nospec();

On a quick look it at the call chain ...

sr_block_ioctl(..., arg)
  cdrom_ioctl(..., arg)
    cdrom_ioctl_media_changed(..., arg)

.... it appears maximum value cdi->capacity can be only 1:

sr_probe()
{
...
	cd->cdi.capacity = 1;

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/sr.c?h=v6.4-rc6#n665

If we know that max possible value than, instead of big hammer
barrier_nospec(), its possible to use lightweight array_index_nospec()
as below:

---
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 416f723a2dbb..e1c4f969ffda 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -264,6 +264,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/nospec.h>
 #include <linux/slab.h> 
 #include <linux/cdrom.h>
 #include <linux/sysctl.h>
@@ -2329,6 +2330,9 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
 	if (arg >= cdi->capacity)
 		return -EINVAL;
 
+	/* Prevent arg from speculatively bypassing the length check */
+	arg = array_index_nospec(arg, CDI_MAX_CAPACITY);
+
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 12869e6d4ebd..62e163dc29cc 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -662,7 +662,7 @@ static int sr_probe(struct device *dev)
 	cd->cdi.ops = &sr_dops;
 	cd->cdi.handle = cd;
 	cd->cdi.mask = 0;
-	cd->cdi.capacity = 1;
+	cd->cdi.capacity = CDI_MAX_CAPACITY;
 	sprintf(cd->cdi.name, "sr%d", minor);
 
 	sdev->sector_size = 2048;	/* A guess, just in case */
@@ -882,7 +882,7 @@ static int get_capabilities(struct scsi_cd *cd)
 	    (buffer[n + 6] >> 5) == mechtype_cartridge_changer)
 		cd->cdi.capacity =
 		    cdrom_number_of_slots(&cd->cdi);
-	if (cd->cdi.capacity <= 1)
+	if (cd->cdi.capacity <= CDI_MAX_CAPACITY)
 		/* not a changer */
 		cd->cdi.mask |= CDC_SELECT_DISC;
 	/*else    I don't think it can close its tray
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 67caa909e3e6..51c046354275 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -29,6 +29,8 @@ struct packet_command
 	void			*reserved[1];
 };
 
+#define CDI_MAX_CAPACITY	1
+
 /*
  * _OLD will use PIO transfer on atapi devices, _BPC_* will use DMA
  */
