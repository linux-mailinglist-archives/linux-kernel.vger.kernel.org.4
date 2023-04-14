Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B968B6E2911
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjDNRPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjDNRPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:15:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DA526BB;
        Fri, 14 Apr 2023 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681492545; x=1713028545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tg77TiFtWEw2ZRP1m55Sp0S/s2dVvmdXA4yXjOSsMVo=;
  b=lJS2Yjdl3UeD/Gpr20J+saPK612crkeXhJ9yIUUs0EqrGqdTidh/dYJi
   KfR5PBw/YmHVYD9jlGCKsdL3MxsWHxrr4Fx3/y/v24Lt5MT+MVOI8FaSU
   X5wYxPeW+rkvd8An67MA9rYOsZSS/d/SQyI5ORR1s8TA9n5UIbajnDnEy
   Jsp/jRPryqLlTSCil0xO8A68A7ir8khQ//P79DqIRgLrVnET/AFrwIP0f
   GcheoSP4tREUVHrT7kbhD2qp9kb0CisTarUPR3MUUtn9xeIVbHBLVfbMw
   w3UGeaAWnU1YNCbX0znmI7A6rqxFR9BrNleYp7Mh3p8M2ETdvgUKRpL00
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="407397611"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="407397611"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 10:15:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="813960433"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="813960433"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 14 Apr 2023 10:15:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pnN18-00HDWx-0J;
        Fri, 14 Apr 2023 20:15:22 +0300
Date:   Fri, 14 Apr 2023 20:15:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, nvdimm@lists.linux.dev,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvdimm: Replace the usage of a variable by a direct
 function call in nd_pfn_validate()
Message-ID: <ZDmKKadGjEwKMCcY@smile.fi.intel.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <d2403b7a-c6cd-4ee9-2a35-86ea57554eec@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2403b7a-c6cd-4ee9-2a35-86ea57554eec@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 12:12:37PM +0200, Markus Elfring wrote:
> Date: Fri, 14 Apr 2023 12:01:15 +0200
> 
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function “nd_pfn_validate”.
> 
> Thus avoid the risk for undefined behaviour by replacing the usage of
> the local variable “parent_uuid” by a direct function call within
> a later condition check.

> This issue was detected by using the Coccinelle software.
> 
> Fixes: d1c6e08e7503649e4a4f3f9e700e2c05300b6379 ("libnvdimm/labels: Add uuid helpers")

Same issues as per patch 1.

...

> -	if (memcmp(pfn_sb->parent_uuid, parent_uuid, 16) != 0)
> +	if (memcmp(pfn_sb->parent_uuid, nd_dev_to_uuid(&ndns->dev), 16) != 0)

If parent_uuid is of uuid_t type, you better to replace memcmp() with
uuid_equal().

>  		return -ENODEV;

-- 
With Best Regards,
Andy Shevchenko


