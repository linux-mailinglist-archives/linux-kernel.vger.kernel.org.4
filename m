Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0995D6727BB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjARTC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjARTCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:02:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6695CFD8;
        Wed, 18 Jan 2023 11:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674068468; x=1705604468;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=csT4HksI9oM/ml2mHEbILNsUNQxDWjDr4rLyUkDIzRE=;
  b=G20Cf0W0gUunSk7mfjpp2Egv3xYMh1WZvhVbv2utcvUPDG9tG983x4Ok
   HN89imn4SHVfZqKyz6kLZgol49zR32e+S181pzlZ2SOULuYew6t9aZpFy
   G3fOHFpMlQ7bnez+9wWq5kAZPqYxyEsUgbeiYq34uuHd0X+1wy/Mzbo7I
   twkTbwx5//xwSN/C+ZnBAuXbOjewQKk33Frz7s+9YDKfBF6wMhY8si5CZ
   t3NnQ4SGyjmFIQUL5wSlThAS44MBgC6JFZ9jxMpW5pdfOng+KsjCMTmQc
   V4Q5QqWkFt6xFm8+4Z4/cf088kG/+2mYUpZcLZKu2VWJsf9SeLPujER4X
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="323756339"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="323756339"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 11:01:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="659907410"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="659907410"
Received: from yzeleke-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.16.158])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 11:01:01 -0800
Message-ID: <5aabdd3010a02e361fbbe01f4af0e30d11f0ae6b.camel@linux.intel.com>
Subject: Re: [PATCH v5 0/3] Thermal ACPI APIs for generic trip points
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Date:   Wed, 18 Jan 2023 11:01:01 -0800
In-Reply-To: <2627c37e07dce6b125d3fea3bf38a5f2407ad6a1.camel@intel.com>
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
         <f76c13de-d250-ebc0-d234-ccb3a9ce3c28@linaro.org>
         <2627c37e07dce6b125d3fea3bf38a5f2407ad6a1.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-01-18 at 13:48 +0000, Zhang, Rui wrote:
> On Wed, 2023-01-18 at 10:53 +0100, Daniel Lezcano wrote:
> > Hi,
> > 
> > On 13/01/2023 19:02, Daniel Lezcano wrote:
> > > Recently sent as a RFC, the thermal ACPI for generic trip points
> > > is
> > > a set of
> > > functions to fill the generic trip points structure which will
> > > become the
> > > standard structure for the thermal framework and its users.
> > > 
> > > Different Intel drivers and the ACPI thermal driver are using the
> > > ACPI tables to
> > > get the thermal zone information. As those are getting the same
> > > information,
> > > providing this set of ACPI function with the generic trip points
> > > will
> > > consolidate the code.
> > > 
> > > Also, the Intel PCH and the Intel 34xx drivers are converted to
> > > use
> > > the generic
> > > trip points relying on the ACPI generic trip point parsing
> > > functions.
> > > 
> > > These changes have been tested on a Thinkpad Lenovo x280 with the
> > > PCH and
> > > INT34xx drivers. No regression have been observed, the trip
> > > points
> > > remain the
> > > same for what is described on this system.
> > 
> > Are we ok with this series ?
> > 
> > Sorry for insisting but I would like to go forward with the generic
> > thermal trip work. There are more patches pending depending on this
> > series.
> 
> The whole series looks good to me.
> 
> Reviwed-by: Zhang Rui <rui.zhang@intel.com>
> 
> But we'd better wait for the thermald test result from Srinvias.

A quick test show that things still work with thermald and these
changes.

Thanks,
Srinivas

> 
> thanks,
> rui
> > 
> > Thanks
> >    -- Daniel
> > 
> > > Changelog:
> > >   - V5:
> > >     - Fixed GTSH unit conversion, deciK -> milli C
> > > 
> > >   - V4:
> > >     - Fixed Kconfig option dependency, select THERMAL_ACPI if
> > > ACPI
> > > is set
> > >       only for the PCH driver
> > > 
> > >   - V3:
> > >     - Took into account Rafael's comments
> > >     - Used a silence option THERMAL_ACPI in order to stay
> > > consistent
> > >       with THERMAL_OF. It is up to the API user to select the
> > > option.
> > > 
> > >   - V2:
> > >     - Fix the thermal ACPI patch where the thermal_acpi.c was not
> > > included in
> > >       the series
> > >     - Provide a couple of users of this API which could have been
> > > tested on a
> > >       real system
> > > 
> > > Daniel Lezcano (3):
> > >    thermal/acpi: Add ACPI trip point routines
> > >    thermal/drivers/intel: Use generic trip points for intel_pch
> > >    thermal/drivers/intel: Use generic trip points int340x
> > > 
> > >   drivers/thermal/Kconfig                       |   4 +
> > >   drivers/thermal/Makefile                      |   1 +
> > >   drivers/thermal/intel/Kconfig                 |   1 +
> > >   drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
> > >   .../int340x_thermal/int340x_thermal_zone.c    | 177 ++++-------
> > > --
> > > --
> > >   .../int340x_thermal/int340x_thermal_zone.h    |  10 +-
> > >   drivers/thermal/intel/intel_pch_thermal.c     |  88 ++------
> > >   drivers/thermal/thermal_acpi.c                | 210
> > > ++++++++++++++++++
> > >   include/linux/thermal.h                       |   8 +
> > >   9 files changed, 286 insertions(+), 214 deletions(-)
> > >   create mode 100644 drivers/thermal/thermal_acpi.c
> > > 

