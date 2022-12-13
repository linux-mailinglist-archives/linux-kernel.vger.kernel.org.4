Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D9464B240
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbiLMJWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiLMJVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:21:40 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2C423C;
        Tue, 13 Dec 2022 01:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670923299; x=1702459299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lFIERIufb6+u1QPc+oZnH/HkpfTZ0dBxzw8JMYgcWzI=;
  b=U32we2owV2BFXDxE7+Mo1AZDS4rDx3Cq+2DEzHJ4NG0AxjR1X2ZESNxW
   YFSJX5CATdir1DJWgjdMliOtU2RLzMLxD7R8FrHNDyrH2L/TaTHLVPtH2
   ExOOG3tSef3glmL9M+BWEPR0DpwVP+KHroFjPxfc/U9VPzuvdJajx+d65
   jN5ncAFNrt6N5sbvo/9GPpnfDg5mVmnsXMO6oX6NO2Syc++vwbcXTS8LR
   QDow8jDZCUq9cqCKIJBeV9AiCn1OUemEiDJI3jKhq3zMvKcToLr7JbIEe
   8ClR2fK39cnG14AOpMylRl7TRZ3i26DqxBcVb7K4KTYI4HZfT4VwEQmsI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="297766663"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="297766663"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 01:21:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="790833550"
X-IronPort-AV: E=Sophos;i="5.96,240,1665471600"; 
   d="scan'208";a="790833550"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 13 Dec 2022 01:21:31 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 13 Dec 2022 11:21:30 +0200
Date:   Tue, 13 Dec 2022 11:21:30 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        RD Babiera <rdbabiera@google.com>
Subject: Re: [PATCH v1] usb: typec: altmodes/displayport: Add hpd sysfs
 attribute
Message-ID: <Y5hEGqbIF9rLg8AG@kuha.fi.intel.com>
References: <20221211193755.1392128-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221211193755.1392128-1-badhri@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 11:37:55AM -0800, Badhri Jagan Sridharan wrote:
> Exporsing HotPlugDetect(HPD) helps userspace to infer HPD
> state as defined by VESA DisplayPort Alt Mode on USB Type-C Standard.
> This allows userspace to notify users for self help, for instance,
> to hint user that the display port cable is probably detached (or)
> the display port sink (viz., monitors ect.,) is un-powered.
> Also helps to debug issues reported from field.
> 
> This change adds an additional attribute "hpd" to the existing
> "displayport" attributes.
> 
> VESA DisplayPort Alt Mode on USB Type-C Standard defines how
> HotPlugDetect(HPD) shall be supported on the USB-C connector
> when operating in DisplayPort Alt Mode. This is a read only
> node which reflects the current state of HPD.
> 
> Valid values:
>  - 1 when HPD’s logical state is high (HPD_High)
>  - 0 when HPD’s logical state is low (HPD_Low)
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  .../ABI/testing/sysfs-driver-typec-displayport    | 15 +++++++++++++++
>  drivers/usb/typec/altmodes/displayport.c          | 10 ++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-typec-displayport b/Documentation/ABI/testing/sysfs-driver-typec-displayport
> index 231471ad0d4b..256c87c5219a 100644
> --- a/Documentation/ABI/testing/sysfs-driver-typec-displayport
> +++ b/Documentation/ABI/testing/sysfs-driver-typec-displayport
> @@ -47,3 +47,18 @@ Description:
>  		USB SuperSpeed protocol. From user perspective pin assignments C
>  		and E are equal, where all channels on the connector are used
>  		for carrying DisplayPort protocol (allowing higher resolutions).
> +
> +What:		/sys/bus/typec/devices/.../displayport/hpd
> +Date:		Dec 2022
> +Contact:	Badhri Jagan Sridharan <badhri@google.com>
> +Description:
> +		VESA DisplayPort Alt Mode on USB Type-C Standard defines how
> +		HotPlugDetect(HPD) shall be supported on the USB-C connector when
> +		operating in DisplayPort Alt Mode. This is a read only node which
> +		reflects the current state of HPD.
> +
> +		Valid values:
> +			- 1: when HPD’s logical state is high (HPD_High) as defined
> +			     by VESA DisplayPort Alt Mode on USB Type-C Standard.
> +			- 0 when HPD’s logical state is low (HPD_Low) as defined by
> +			     VESA DisplayPort Alt Mode on USB Type-C Standard.
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index de66a2949e33..06fb4732f8cd 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -146,6 +146,7 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
>  		if (dp->hpd != hpd) {
>  			drm_connector_oob_hotplug_event(dp->connector_fwnode);
>  			dp->hpd = hpd;
> +			sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
>  		}
>  	}
>  
> @@ -508,9 +509,18 @@ static ssize_t pin_assignment_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(pin_assignment);
>  
> +static ssize_t hpd_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct dp_altmode *dp = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", dp->hpd);
> +}
> +static DEVICE_ATTR_RO(hpd);
> +
>  static struct attribute *dp_altmode_attrs[] = {
>  	&dev_attr_configuration.attr,
>  	&dev_attr_pin_assignment.attr,
> +	&dev_attr_hpd.attr,
>  	NULL
>  };
>  
> 
> base-commit: 81c25247a2a03a0f97e4805d7aff7541ccff6baa
> -- 
> 2.39.0.rc1.256.g54fd8350bd-goog

thanks,

-- 
heikki
