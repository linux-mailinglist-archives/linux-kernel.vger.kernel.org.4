Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973D76719B0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjARKxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjARKvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:51:00 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F289A45F40;
        Wed, 18 Jan 2023 02:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674036041; x=1705572041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2kzgrBUfMBAY/+H5vDRwbImFOagJJve1sIaVm+YscYE=;
  b=UefuBp1NLFFuMnkqf4VPFFpP4d3UJcidkltE1mvqxinv8jl4A6c8nClB
   T/QhABpFTbDLwlDGaQZ2X5X1D0Q0PkSWhbybz5Hcq93bDo4sJBSBRTId0
   ESZnsivQgU+vo0zyuHyNQJEkzWSuR9qgH7STZv8Gxc6LYcihYzMApuNFO
   RvTVcQy0+ZZ/PZ/VWZHr0zcy4V46jEMi1RVcxJbre1vMOeImwM66cgvnH
   8Yv9RwUNjAuBaZ4v3KYlUAYkvN0DYVi/BPOKRo042Vcw0qPeORPIm7VbV
   0ksrLCqEU9J1gSgCGiHeTnmV2jzH29Pb93HoTI+pwYsKO2lrlQgBiC3+Q
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="308508848"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="308508848"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 02:00:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="783612749"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="783612749"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2023 02:00:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pI5FF-00B6yP-0G;
        Wed, 18 Jan 2023 12:00:37 +0200
Date:   Wed, 18 Jan 2023 12:00:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] HID: i2c-hid: acpi: Drop unneded NULL check of
 adev
Message-ID: <Y8fDRJ9tL8BzUKJD@smile.fi.intel.com>
References: <20230116154621.16135-1-andriy.shevchenko@linux.intel.com>
 <nycvar.YFH.7.76.2301181006170.1734@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.YFH.7.76.2301181006170.1734@cbobk.fhfr.pm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:06:32AM +0100, Jiri Kosina wrote:
> On Mon, 16 Jan 2023, Andy Shevchenko wrote:
> 
> > The driver is enumerated on ACPI platforms, so adev is valid.
> > Since there is no valid I²C ID table provided, there is no
> > possibility to bind a device to this driver via user space.
> > Hence, drop unneeded NULL check of adev.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Applied both to hid.git#for-6.3/i2c-hid. Thanks,

Thank you and HNY!

-- 
With Best Regards,
Andy Shevchenko


