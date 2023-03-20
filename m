Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B6E6C1167
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCTMDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCTMDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:03:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18982BB8C;
        Mon, 20 Mar 2023 05:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679313780; x=1710849780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P79vOyG/7Azm51QlnjSuUs5bhuG7/kywUyNBoV2/iC8=;
  b=arxJdqZP2dPo/2hQpZSVSQyuHsXUf6aqQ/WzO6El/DivsAvFfbDSBVTI
   xHXMmzOTv43vMRXyzfQbDEtounAjcLElL3T9fTzcpTieX8U6c6UTwRyYk
   yHEgPGH1d+gzGSsnxAzn0jGjyvToDh+pFZ56ufuEK682nx7CCPYDxNn4H
   h5dxnzqjFqQLaLyKtYMgzxNs3qppQ4OUzfeiu+f+m5P7sp+xM5ok/671g
   kbNqJOVaaaqjKkMzMoJv3CUAXxiJAUn/gHZ+LDTyHkHZ0YqnzxczbLhc+
   fmKQkcJsvUYAzpUG98Vb4CLOE3q9/g8JrB5kxHDBFHAWUBf9Ma/ehDRBk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="403512839"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="403512839"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 05:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="681051468"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="681051468"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 20 Mar 2023 05:02:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1peEDq-006FyI-29;
        Mon, 20 Mar 2023 14:02:42 +0200
Date:   Mon, 20 Mar 2023 14:02:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
Message-ID: <ZBhLYvp9JdX3FGhI@smile.fi.intel.com>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
 <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
 <4c28925d-c07c-61b7-8863-9c00e6846687@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c28925d-c07c-61b7-8863-9c00e6846687@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:35:06AM +0200, Matti Vaittinen wrote:
> On 3/17/23 01:48, Mehdi Djait wrote:
> > Refactor the kx022a driver implementation to make it more
> > generic and extensible.
> > Add the chip_info structure will to the driver's private
> > data to hold all the device specific infos.
> > Move the enum, struct and constants definitions to the header
> > file.

...

> Something like:
> 
> enum {
> 	KIONIX_IC_KX022A,
> 	KIONIX_IC_KX132_xxx, /* xxx denotes accurate model suffix */
> };
> 	
> static const struct of_device_id kx022a_of_match[] = {
> 	{ .compatible = "kionix,kx022a", .data = KIONIX_IC_KX022A },
> 	...
> 
> chip_id = device_get_match_data(&i2c->dev);

No, please avoid putting plain integers as pointers of driver_data.

The problem you introduced with your suggestion is impossibility
to distinguish 0 and NULL, beyond other not good things (like missing
castings which are ugly).

-- 
With Best Regards,
Andy Shevchenko


