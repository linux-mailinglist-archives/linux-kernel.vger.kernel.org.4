Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA39635353
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbiKWIyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiKWIyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:54:03 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F89F418A;
        Wed, 23 Nov 2022 00:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669193642; x=1700729642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4BV3r9SxAr4VNWpyNtV7GXCDpxpEV3V9ULZRmjgFZwA=;
  b=f9zNUzmBrfWDK5RBkIYBycTk2YpzqI8S12BSYgM4yKe5pS25JOvds5M1
   uX3XGg3wQC6Xqc+H+bcQNGUbyJ2yVk8alljCBrVbWVoiXc4HObc1pAt87
   P7M2er+kWyENt3qd+rgDRBbsT+RP4qNA75rIJIRZ3oV2H+hNeEAy83s/M
   4JzWeD5YibHh+ohZOdswc9BMLtgCZU7LGKZqAUWLqz69wg6TRXIjQoUji
   OMRKDmwcDFN+gro13pSMIT9FEUyPlZepqRg1sqlRVJUPLaVe6RszGBB2J
   zIIpGc+FzbJa9wibitGH+8mR+l5YEhONVpxrC7duw9atNUNAmLhP6ki7I
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="340895476"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="340895476"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 00:54:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="784161497"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="784161497"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 23 Nov 2022 00:53:45 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 23 Nov 2022 10:53:44 +0200
Date:   Wed, 23 Nov 2022 10:53:44 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 1/2] usb: typec: Add partner PD object wrapper
Message-ID: <Y33fmFzu8j5pdJb3@kuha.fi.intel.com>
References: <20221122220538.2991775-1-pmalani@chromium.org>
 <20221122220538.2991775-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122220538.2991775-2-pmalani@chromium.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:05:36PM +0000, Prashant Malani wrote:
> Some port drivers may want to set a Type-C partner as a parent for a
> USB Power Delivery object, but the Type-C partner struct isn't exposed
> outside of the Type-C class driver. Add a wrapper to
> usb_power_delivery_register() which sets the provided Type-C partner
> as a parent to the USB PD object. This helps to avoid exposing the
> Type-C partner's device struct unnecessarily.
> 
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Benson Leung <bleung@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes since v1:
> - Patch first introduced in v2.
> 
>  drivers/usb/typec/class.c | 19 +++++++++++++++++++
>  include/linux/usb/typec.h |  4 ++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index bd5e5dd70431..5897905cb4f0 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -821,6 +821,25 @@ void typec_partner_set_svdm_version(struct typec_partner *partner,
>  }
>  EXPORT_SYMBOL_GPL(typec_partner_set_svdm_version);
>  
> +/**
> + * typec_partner_usb_power_delivery_register - Register Type-C partner USB Power Delivery Support
> + * @partner: Type-C partner device.
> + * @desc: Description of the USB PD contract.
> + *
> + * This routine is a wrapper around usb_power_delivery_register(). It registers
> + * USB Power Delivery Capabilities for a Type-C partner device. Specifically,
> + * it sets the Type-C partner device as a parent for the resulting USB Power Delivery object.
> + *
> + * Returns handle to struct usb_power_delivery or ERR_PTR.
> + */
> +struct usb_power_delivery *
> +typec_partner_usb_power_delivery_register(struct typec_partner *partner,
> +					  struct usb_power_delivery_desc *desc)
> +{
> +	return usb_power_delivery_register(&partner->dev, desc);
> +}
> +EXPORT_SYMBOL_GPL(typec_partner_usb_power_delivery_register);
> +
>  /**
>   * typec_register_partner - Register a USB Type-C Partner
>   * @port: The USB Type-C Port the partner is connected to
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 7751bedcae5d..8fa781207970 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -23,6 +23,7 @@ struct fwnode_handle;
>  struct device;
>  
>  struct usb_power_delivery;
> +struct usb_power_delivery_desc;
>  
>  enum typec_port_type {
>  	TYPEC_PORT_SRC,
> @@ -327,6 +328,9 @@ void typec_partner_set_svdm_version(struct typec_partner *partner,
>  				    enum usb_pd_svdm_ver svdm_version);
>  int typec_get_negotiated_svdm_version(struct typec_port *port);
>  
> +struct usb_power_delivery *typec_partner_usb_power_delivery_register(struct typec_partner *partner,
> +							struct usb_power_delivery_desc *desc);
> +
>  int typec_port_set_usb_power_delivery(struct typec_port *port, struct usb_power_delivery *pd);
>  int typec_partner_set_usb_power_delivery(struct typec_partner *partner,
>  					 struct usb_power_delivery *pd);

thanks,

-- 
heikki
