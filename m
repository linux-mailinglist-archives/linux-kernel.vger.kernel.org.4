Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E278A60082A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJQHzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJQHzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:55:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286964C60A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665993308; x=1697529308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vtjlkeu8sKMQz9IdE+hQRGUqr0x2eN33wJszlyvmDS0=;
  b=OcdPqTYI+19qwK339mulO754HL+XHjgHRhHuke8hp8QPCO/QP1lStK/Z
   bahfjBXvGZUIW1kJOnzH/8wsf1uynmWPrwJzqnnsUgHR9JDxYjfmGmMHC
   KBNZv9pnzX5qGi2hHOFyJvhOLKuQtbPXKuSrPofFrQxUOGWcytlP7Hc+g
   /+QNYUYIYpvZ/eknkOtXc91MWWZ5eaMrZG/ejEz0jmmtVMqNAvZwc03SW
   lF8Q/DpbVwk7XEIYeTDSO3Ryi3PQSYKWiapjuj62Fnik+nGtVqeqkGfJZ
   RPK5+nnjBIxD3HewgKuZMNcahwXlyPa9wmIsTS+PdUqUgoaL5Lo4UITe/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="367757284"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="367757284"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 00:54:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="770676008"
X-IronPort-AV: E=Sophos;i="5.95,190,1661842800"; 
   d="scan'208";a="770676008"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 00:54:55 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id EA6B920310;
        Mon, 17 Oct 2022 10:54:52 +0300 (EEST)
Date:   Mon, 17 Oct 2022 07:54:52 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] driver core: allow kobj_to_dev() to take a const
 pointer
Message-ID: <Y00KTAobXJ0/Jgv3@paasikivi.fi.intel.com>
References: <20221016104126.1259809-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221016104126.1259809-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sun, Oct 16, 2022 at 12:41:26PM +0200, Greg Kroah-Hartman wrote:
> If a const * to a kobject is passed to kobj_to_dev(), we want to return
> back a const * to a device as the driver core shouldn't be modifying a
> constant structure.  But when dealing with container_of() the pointer
> const attribute is cast away, so we need to manually handle this by
> determining the type of the pointer passed in to know the type of the
> pointer to pass out.

Alternatively container_of() could be fixed, but that will likely produce
lots of warnings currently.

> 
> Luckily _Generic can do this type of magic, and as the kernel now
> supports C11 it is availble to us to handle this type of build-time type
> detection.
> 
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2 - use _Generic() to make this type safe as pointed out by Sakari
> 
>  include/linux/device.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 424b55df0272..023ea50b1916 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -680,11 +680,27 @@ struct device_link {
>  	bool supplier_preactivated; /* Owned by consumer probe. */
>  };
>  
> -static inline struct device *kobj_to_dev(struct kobject *kobj)
> +static inline struct device *__kobj_to_dev(struct kobject *kobj)
>  {
>  	return container_of(kobj, struct device, kobj);
>  }
>  
> +static inline const struct device *__kobj_to_dev_const(const struct kobject *kobj)
> +{
> +	return container_of(kobj, const struct device, kobj);
> +}
> +
> +/*
> + * container_of() will happily take a const * and spit back a non-const * as it
> + * is just doing pointer math.  But we want to be a bit more careful in the
> + * driver code, so manually force any const * of a kobject to also be a const *
> + * to a device.
> + */

container_of() documentation has (probably?) never warned about this.

Wouldn't such a comment be more appropriate there? Albeit it wouldn't be
needed if container_of() were fixed.

> +#define kobj_to_dev(kobj)					\
> +	_Generic((kobj),					\
> +		 const struct kobject *: __kobj_to_dev_const,	\
> +		 struct kobject *: __kobj_to_dev)(kobj)
> +
>  /**
>   * device_iommu_mapped - Returns true when the device DMA is translated
>   *			 by an IOMMU

-- 
Kind regards,

Sakari Ailus
