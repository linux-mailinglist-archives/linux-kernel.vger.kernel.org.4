Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFED631C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiKUJC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiKUJCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:02:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA4F317D2;
        Mon, 21 Nov 2022 01:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669021341; x=1700557341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M+rRHtdKg5QyHpNqpD1T8O6Ma2WXA8citsXe5pnDnJA=;
  b=X8ZDYy/VFZq00SzmO3WyOIWglT2sBRgXAoXIsbpw3b7d0984/ZI4FjAi
   qDm3dAWgDHzdDacdj/t30W54c9ga1+25PzNtuMKxFjkN5zD1xhJYqgCSn
   YsRFa+siSqbFEOtnxWy0JEbVnSyLwa7h5XAyiCF4fi7EIVUjIi7OP01TD
   4LHzAbSgloCDWmCEZGg0XV6YokJy1AUawNFYBF+wTZgk3yJrZlnfFmyyL
   Pu7n6OBcpYvCGd2igB718ZJFgJKz35TMR4lX5JDOxi+RWflrYzWwMAgrl
   sX6V/LpHn9vcepzihDheJyJpJjbyS3guWbCsYSN/5XImt9C2a7o3LT3Jq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="311140789"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="311140789"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 01:02:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="783374619"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="783374619"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 21 Nov 2022 01:02:16 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 21 Nov 2022 11:02:15 +0200
Date:   Mon, 21 Nov 2022 11:02:15 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>
Subject: Re: [PATCH v1 1/4] media: ipu3-cio2: Don't dereference fwnode handle
Message-ID: <Y3s+l54MbAv+svzI@kuha.fi.intel.com>
References: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 08:56:14PM +0200, Andy Shevchenko wrote:
> Use acpi_fwnode_handle() instead of dereferencing an fwnode handle directly,
> which is a better coding practice.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/pci/intel/ipu3/cio2-bridge.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
> index df6c94da2f6a..18974a72e94a 100644
> --- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
> +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
> @@ -263,7 +263,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
>  				      struct cio2_bridge *bridge,
>  				      struct pci_dev *cio2)
>  {
> -	struct fwnode_handle *fwnode;
> +	struct fwnode_handle *fwnode, *primary;
>  	struct cio2_sensor *sensor;
>  	struct acpi_device *adev;
>  	acpi_status status;
> @@ -322,7 +322,9 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
>  		}
>  
>  		sensor->adev = acpi_dev_get(adev);
> -		adev->fwnode.secondary = fwnode;
> +
> +		primary = acpi_fwnode_handle(adev);
> +		primary->secondary = fwnode;
>  
>  		cio2_bridge_instantiate_vcm_i2c_client(sensor);
>  

This and also the others look good to me. FWIW, for the series:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

thanks,

-- 
heikki
