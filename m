Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24616635371
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiKWIzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbiKWIym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:54:42 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF492748FE;
        Wed, 23 Nov 2022 00:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669193681; x=1700729681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VZbmJPZfndM+pgDfB8pn/QDgWDK1DpcXGRSBx6vCr6Q=;
  b=YTXEX0gGuJhzf2zJ91kCh6AJjVMNaqAcFDat+JwdNAgcZqICbm47CqnF
   Bt06dva4MacwRb23vGzJtDplOKVG5Au9A2yi7TSQWk/48K6xuNgF6SuF1
   e/4XHQmh//C8MYiqlPt44dWsiEAoKQuT8dualGeupjIdgMsTQq8vbzPj0
   KyhjypFbEeYW0+KFBAIYPZD4iUqg9SC8ngxD9yBiGDUw62u364QqbkyqR
   JzFKZrNycWu/r33uC1tRD14aAOlYxNwnzHYTk1GwtE4smO/d0HjeljR61
   4c+LcrjT79Nun8aAI0MwAjaYGApgXUHJEVu3Y/uOWo41JkOIL6ttcowKW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="293725710"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="293725710"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 00:54:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="784161624"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="784161624"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 23 Nov 2022 00:54:23 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 23 Nov 2022 10:54:23 +0200
Date:   Wed, 23 Nov 2022 10:54:23 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Set parent of
 partner PD object
Message-ID: <Y33fv3YXz8YNKqv8@kuha.fi.intel.com>
References: <20221122220538.2991775-1-pmalani@chromium.org>
 <20221122220538.2991775-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122220538.2991775-3-pmalani@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:05:37PM +0000, Prashant Malani wrote:
> In order to tell what Type-C device a PD object belongs to, its parent
> needs to be set. Use the Type-C partner USB PD registration wrapper
> to set the parent appropriately for PD objects which are created for
> connected Type-C partners.
> 
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes since v1:
> - Use wrapper function introduced in Patch1 (v2).
> - Update commit message to reflect that we are using the wrapper.
> 
>  drivers/platform/chrome/cros_ec_typec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 2a7ff14dc37e..d5bc4021aca2 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -968,7 +968,7 @@ static void cros_typec_register_partner_pdos(struct cros_typec_data *typec,
>  	if (!resp->source_cap_count && !resp->sink_cap_count)
>  		return;
>  
> -	port->partner_pd = usb_power_delivery_register(NULL, &desc);
> +	port->partner_pd = typec_partner_usb_power_delivery_register(port->partner, &desc);
>  	if (IS_ERR(port->partner_pd)) {
>  		dev_warn(typec->dev, "Failed to register partner PD device, port: %d\n", port_num);
>  		return;

thanks,

-- 
heikki
