Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BB0685F3D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjBAFtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjBAFtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:49:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB192199C3;
        Tue, 31 Jan 2023 21:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675230555; x=1706766555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4nBs6trcLWpDBx7VDaJDKRwln2U7CiR7zHSHXqX9zrI=;
  b=k/xyYEq6hnnW2oXsI0MgVXSHP0aw8CdHY6Z+DRZ33dbhhJaaJR42XKIp
   N7kYGED91/K250FFtY1xz8z3WUh3ZB09Ztt7EaKHV1F/5RLCKe/7xJW5e
   uyx50Pt7RtZf6ndY9DF642gKPaNBoeWwEE/nuWtml5hzXu1GwKENewoCV
   rdeEPYGlhdgh61QDX/GxSbgTNvoS8/Kpg2zXZKpsK4ZWYydI68USpKZsa
   XXg8JWD5BKXVE3vxfyCMmd/4Lw8SBGRbtdOF95PXNIUiJx8YaeAEQMmx4
   7KB7TLEOLB+7vhMi3mM4sJWeH5+IQlb2i/ZMODe3+Wsxl2/GXMlmuXTRx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="325754646"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="325754646"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 21:49:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="614736581"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="614736581"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 31 Jan 2023 21:49:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 80818E1; Wed,  1 Feb 2023 07:49:50 +0200 (EET)
Date:   Wed, 1 Feb 2023 07:49:50 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mauro Lima <mauro.lima@eclypsium.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: intel: Add support for controllers
Message-ID: <Y9n9fhc6YbdPe08f@black.fi.intel.com>
References: <20230201050455.505135-1-mauro.lima@eclypsium.com>
 <20230201050455.505135-3-mauro.lima@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230201050455.505135-3-mauro.lima@eclypsium.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 02:04:55AM -0300, Mauro Lima wrote:
> Add Device IDs to the module table for the following controllers:
> 	- 9da4  Cannon Lake 300 Series On-Package
> 	- a2a4  200 Series/Z370 Chipset Family SPI Controller
> 	- 9d24  Intel® 200 Series Chipset Family (Including Intel® X299),
> 		Intel® Z370 Intel® H310C,B365,
> 		also Intel® B460 and H410 Chipset Platform Controller Hub
> 
> Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>
> ---
>  drivers/spi/spi-intel-pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
> index 10fa3a7fa4f5..ba08f64e56eb 100644
> --- a/drivers/spi/spi-intel-pci.c
> +++ b/drivers/spi/spi-intel-pci.c
> @@ -80,6 +80,9 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
>  	{ PCI_VDEVICE(INTEL, 0xa224), (unsigned long)&bxt_info },
>  	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
>  	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
> +	{ PCI_VDEVICE(INTEL, 0x9da4), (unsigned long)&cnl_info },
> +	{ PCI_VDEVICE(INTEL, 0xa2a4), (unsigned long)&cnl_info },
> +	{ PCI_VDEVICE(INTEL, 0x9d24), (unsigned long)&cnl_info },

Make sure these are sorted numerically.

Otherwise looks good, thanks for doing this!

