Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9505ED62B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiI1HeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiI1HeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:34:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E145AEB138;
        Wed, 28 Sep 2022 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664350441; x=1695886441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CemS3SbJ4Y7mcmGZ3q6D0TMYCXLcTmaPwaze2uSljn4=;
  b=Kc7SASIzDOvs+DCYvC71UXqAy5ChjeuXMUSQPIAUDMkfI44XxfJ9+3De
   R7cJ1SkXlbAr7aK5usleh5B1h3bqmNa61SL4qapZb5meE23tobKd0CYag
   XuE+1v2njnudaytYQ5CV6+llWcpiN2Mrf2k4wA4rsRtGRFbCoYtPc/WJl
   RdmOszbCVQI7K5q12slnWG8N7XMI7uQCRdrwKAMuceOnwfs9fNDP5Gr1R
   Wf1g38PcTJ4wPQV2O3BeE4eGEq/I4anvgUcsHCnm6kuTDHxLnfchirEXv
   gVVHDL4xUOkcEyFtRwDsPRmU/vA/+ukLj7u5dFVVlURjNTCblErTaoU7v
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="299130774"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="299130774"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 00:33:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="764185921"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="764185921"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 28 Sep 2022 00:33:34 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 28 Sep 2022 10:33:34 +0300
Date:   Wed, 28 Sep 2022 10:33:34 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] usb: typec: Replace custom implementation of
 device_match_fwnode()
Message-ID: <YzP4znoUSFTbSp55@kuha.fi.intel.com>
References: <20220927171924.61908-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927171924.61908-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 08:19:24PM +0300, Andy Shevchenko wrote:
> Replace custom implementation of the device_match_fwnode().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux.c     | 4 ++--
>  drivers/usb/typec/retimer.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index f81ea26ab389..c7177ddd4f12 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -29,7 +29,7 @@ static int switch_fwnode_match(struct device *dev, const void *fwnode)
>  	if (!is_typec_switch_dev(dev))
>  		return 0;
>  
> -	return dev_fwnode(dev) == fwnode;
> +	return device_match_fwnode(dev, fwnode);
>  }
>  
>  static void *typec_switch_match(const struct fwnode_handle *fwnode,
> @@ -259,7 +259,7 @@ static int mux_fwnode_match(struct device *dev, const void *fwnode)
>  	if (!is_typec_mux_dev(dev))
>  		return 0;
>  
> -	return dev_fwnode(dev) == fwnode;
> +	return device_match_fwnode(dev, fwnode);
>  }
>  
>  static void *typec_mux_match(const struct fwnode_handle *fwnode,
> diff --git a/drivers/usb/typec/retimer.c b/drivers/usb/typec/retimer.c
> index 8edfdc709a28..8e1055783fe2 100644
> --- a/drivers/usb/typec/retimer.c
> +++ b/drivers/usb/typec/retimer.c
> @@ -31,7 +31,7 @@ static bool dev_name_ends_with(struct device *dev, const char *suffix)
>  
>  static int retimer_fwnode_match(struct device *dev, const void *fwnode)
>  {
> -	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-retimer");
> +	return device_match_fwnode(dev, fwnode) && dev_name_ends_with(dev, "-retimer");
>  }
>  
>  static void *typec_retimer_match(const struct fwnode_handle *fwnode, const char *id, void *data)

thanks,

-- 
heikki
