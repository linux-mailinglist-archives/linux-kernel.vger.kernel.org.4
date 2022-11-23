Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBE8636056
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbiKWNsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbiKWNrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:47:25 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D6327167
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669210610; x=1700746610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s3wmITUCruWfxk9mEyAdcJfC9b76R+0p3TGKuqcT4kQ=;
  b=QxcujeydPCwV14b1FZwzZiBY66ZTX0MQ5eZ2N3jQ68EztsnZUGz/eqER
   Dci4N6ZLM8UbtfGyawG/zzeknkXBE0Gvzo87jCa1p+zgODgk8z26BbaHn
   X0OvZi68FGTWqOKf8YsFqV+M0WMVO8Qj/2nD47CJSiy0LLfcaqJqzsup1
   t3nMfuH/GDnNgr3Cilm+IHC88qHYg8l6Tyq/48HghHrjt+hZbqN0n1Y1y
   r7kFcVHBOo/oh+xA3qEVy1xLba7TgGle0Wi/a1WokXYazpnaRCF7aEopY
   C5y628glUdWoIRIqTWmCmWdDXs1BLQTz+gZth1BlRsuBoP2gVhmqxF6zH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="378323997"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="378323997"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 05:36:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="672878807"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="672878807"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2022 05:36:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxpva-00GIoe-02;
        Wed, 23 Nov 2022 15:36:38 +0200
Date:   Wed, 23 Nov 2022 15:36:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Won Chung <wonchung@google.com>
Subject: Re: [PATCH 5/5] driver core: device_get_devnode() should take a
 const *
Message-ID: <Y34h5QBMTxEn/lzC@smile.fi.intel.com>
References: <20221123122523.1332370-1-gregkh@linuxfoundation.org>
 <20221123122523.1332370-5-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123122523.1332370-5-gregkh@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 01:25:23PM +0100, Greg Kroah-Hartman wrote:
> device_get_devnode() should take a constant * to struct device as it
> does not modify it in any way, so modify the function definition to do
> this and move it out of device.h as it does not need to be exposed to
> the whole kernel tree.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(see one nit-pick below)

> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Won Chung <wonchung@google.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/base.h    | 2 ++
>  drivers/base/core.c    | 2 +-
>  include/linux/device.h | 2 --
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 7d4803c03d3e..a8a119c36bdc 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -158,6 +158,8 @@ extern void device_block_probing(void);
>  extern void device_unblock_probing(void);
>  extern void deferred_probe_extend_timeout(void);
>  extern void driver_deferred_probe_trigger(void);

I would put a blank line here if the below doesn't belong to the deferral probe
routines.

> +const char *device_get_devnode(const struct device *dev, umode_t *mode,
> +			       kuid_t *uid, kgid_t *gid, const char **tmp);
>  
>  /* /sys/devices directory */
>  extern struct kset *devices_kset;
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index a3e14143ec0c..72ec54a8a4e1 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3739,7 +3739,7 @@ static struct device *next_device(struct klist_iter *i)
>   * a name. This memory is returned in tmp and needs to be
>   * freed by the caller.
>   */
> -const char *device_get_devnode(struct device *dev,
> +const char *device_get_devnode(const struct device *dev,
>  			       umode_t *mode, kuid_t *uid, kgid_t *gid,
>  			       const char **tmp)
>  {
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 4ad1280713e6..e4498389e866 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -927,8 +927,6 @@ int device_rename(struct device *dev, const char *new_name);
>  int device_move(struct device *dev, struct device *new_parent,
>  		enum dpm_order dpm_order);
>  int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid);
> -const char *device_get_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
> -			       kgid_t *gid, const char **tmp);
>  int device_is_dependent(struct device *dev, void *target);
>  
>  static inline bool device_supports_offline(struct device *dev)
> -- 
> 2.38.1
> 

-- 
With Best Regards,
Andy Shevchenko


