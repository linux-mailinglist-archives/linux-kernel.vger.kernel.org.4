Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8AF72E14D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbjFMLVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240177AbjFMLKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:10:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BAA10E2;
        Tue, 13 Jun 2023 04:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686654622; x=1718190622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A8Y9jhYwbl6fSD8erJqnV9yCcJCHoGiVNR/9ZIZ0qI0=;
  b=QgGFfTqWgDoMf2BxROkQGcfeOWaR3mY3CnTsL/cnoldq56JOkjIVMsZ1
   vn8akfInAsbVaHSRkXjm1wGVZSVw2fePgvMvK6t95G7mjdiCmg4CLkf1m
   fGZzZ1uoQPDu3Ch0NVHsH4h582yf2i1Yp3xPNltGvLUjSUhfv3Ah29RnU
   +Ur1diqRFfYKNlXI1tG0pHJ134f7ft1R68IaSqXHEWvKl7cvt6U05DbiG
   R0rHeoOOI+Gv6tTKH1kBYcD0hlJBqGnox3/n9vD1PbTzEMqtMJ1RsDjTv
   VqNacsTvUDPvfupX00fGpmhXARyyGGmskSMWK50RpW+vw1K0AnEmlIZyW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="338660377"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="338660377"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 04:10:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="856045971"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="856045971"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 13 Jun 2023 04:10:19 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 13 Jun 2023 14:10:19 +0300
Date:   Tue, 13 Jun 2023 14:10:19 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Message-ID: <ZIhOm5LKwn+YVGzT@kuha.fi.intel.com>
References: <1685544074-17337-1-git-send-email-quic_prashk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685544074-17337-1-git-send-email-quic_prashk@quicinc.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 31, 2023 at 08:11:14PM +0530, Prashanth K wrote:
> Currently if we bootup a device without cable connected, then
> usb-conn-gpio won't call set_role() since last_role is same as
> current role. This happens because during probe last_role gets
> initialised to zero.
> 
> To avoid this, added a new constant in enum usb_role, last_role
> is set to USB_ROLE_UNKNOWN before performing initial detection.

So why can't you fix this by just always setting the role
unconditionally to USB_ROLE_NONE in your probe function before the
initial detection?

> While at it, also handle default case for the usb_role switch
> in cdns3, intel-xhci-usb-role-switch & musb/jz4740 to avoid
> build warnings.
> 
> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> v7: Added default case in musb/jz4740.c & intel-xhci-usb-role-switch.c to
>     avoid build warnings.
> v6: Moved USB_ROLE_UNKNOWN towards the end of enum usb_role.
> v5: Update commit text to mention the changes made in cdns3 driver.
> v4: Added Reviewed-by tag.
> v3: Added a default case in drivers/usb/cdns3/core.c as pointed out by
>     the test robot.
> v2: Added USB_ROLE_UNKNWON to enum usb_role.
> 
>  drivers/usb/cdns3/core.c                       | 2 ++
>  drivers/usb/common/usb-conn-gpio.c             | 3 +++
>  drivers/usb/musb/jz4740.c                      | 2 ++
>  drivers/usb/roles/intel-xhci-usb-role-switch.c | 2 ++
>  include/linux/usb/role.h                       | 1 +
>  5 files changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index dbcdf3b..69d2921 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -252,6 +252,8 @@ static enum usb_role cdns_hw_role_state_machine(struct cdns *cdns)
>  		if (!vbus)
>  			role = USB_ROLE_NONE;
>  		break;
> +	default:
> +		break;
>  	}
>  
>  	dev_dbg(cdns->dev, "role %d -> %d\n", cdns->role, role);
> diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
> index e20874c..30bdb81 100644
> --- a/drivers/usb/common/usb-conn-gpio.c
> +++ b/drivers/usb/common/usb-conn-gpio.c
> @@ -257,6 +257,9 @@ static int usb_conn_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, info);
>  	device_set_wakeup_capable(&pdev->dev, true);
>  
> +	/* Set last role to unknown before performing the initial detection */
> +	info->last_role = USB_ROLE_UNKNOWN;
> +
>  	/* Perform initial detection */
>  	usb_conn_queue_dwork(info, 0);
>  
> diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
> index 5aabdd7..6d880c4 100644
> --- a/drivers/usb/musb/jz4740.c
> +++ b/drivers/usb/musb/jz4740.c
> @@ -95,6 +95,8 @@ static int jz4740_musb_role_switch_set(struct usb_role_switch *sw,
>  	case USB_ROLE_HOST:
>  		atomic_notifier_call_chain(&phy->notifier, USB_EVENT_ID, phy);
>  		break;
> +	default:
> +		break;
>  	}
>  
>  	return 0;
> diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> index 5c96e92..4d6a3dd 100644
> --- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
> +++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
> @@ -97,6 +97,8 @@ static int intel_xhci_usb_set_role(struct usb_role_switch *sw,
>  		val |= SW_VBUS_VALID;
>  		drd_config = DRD_CONFIG_STATIC_DEVICE;
>  		break;
> +	default:
> +		break;
>  	}
>  	val |= SW_IDPIN_EN;
>  	if (data->enable_sw_switch) {
> diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
> index b5deafd..65e790a 100644
> --- a/include/linux/usb/role.h
> +++ b/include/linux/usb/role.h
> @@ -11,6 +11,7 @@ enum usb_role {
>  	USB_ROLE_NONE,
>  	USB_ROLE_HOST,
>  	USB_ROLE_DEVICE,
> +	USB_ROLE_UNKNOWN,
>  };
>  
>  typedef int (*usb_role_switch_set_t)(struct usb_role_switch *sw,
> -- 
> 2.7.4

-- 
heikki
