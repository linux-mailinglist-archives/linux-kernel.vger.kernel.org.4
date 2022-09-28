Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5092B5EDA5E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiI1Ksg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiI1Ksa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:48:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106E2AD980;
        Wed, 28 Sep 2022 03:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664362110; x=1695898110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fgqWgYLtqyh89ejbiHJg9arOWq6A+nLd10+6Mxvv6dE=;
  b=UN09qkwjdYPfVaNcS4vi/97FEXNLOV+FZZuZzTJrArOy6aGaXy06RjjJ
   bITVkpTn578r3EvwwjPBAjH7yR/tTRYdWwwfWTSxcp5bc5LY8HrJ6xBy7
   eS30cj2DQ+ajr9HnRS917KN5CNgoDO9C1lf9MUZorGmcOTDlQKqvHE5cf
   RZsRhJSBxOn68Zc0wdAn4U8oxBS67zvISNFTYSI2YOncjCR/XpXtQTtdZ
   5JSbtRlhoEweEZ3ngKabQVtbSDUBk7hF2g2DgbHNTTtodLRjYyRyBkfXJ
   BpjLc7ofxWUQJSEXP2ZAUBEEUW2wQW3Xb9z96vZV0wD4ieNs0M1mjep/X
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="303052262"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="303052262"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 03:48:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="950657958"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="950657958"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 28 Sep 2022 03:48:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1odUc3-008u8P-23;
        Wed, 28 Sep 2022 13:48:23 +0300
Date:   Wed, 28 Sep 2022 13:48:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org,
        rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, mario.limonciello@amd.com,
        pobrn@protonmail.com, coproscefalo@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] platform/x86: dell: Add new dell-wmi-ddv driver
Message-ID: <YzQmdwTE2XcratWr@smile.fi.intel.com>
References: <20220927204521.601887-1-W_Armin@gmx.de>
 <8d976e9c-8fea-8a67-1331-7993705c60d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d976e9c-8fea-8a67-1331-7993705c60d9@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 11:52:51AM +0200, Hans de Goede wrote:
> On 9/27/22 22:45, Armin Wolf wrote:
> > This patch series adds a new driver for a WMI interface found in
> > many newer Dell machines. This interface allows to read battery
> > properties like temperature and the ePPID (Dell-specific), while
> > also providing fan and thermal sensor information.
> > 
> > The interface does support multiple batteries which are indentified
> > by an "index", which appears to be the battery ACPI UID. Since
> > the interface also appears to omit any bounts checking of the
> > index, the ACPI battery hook mechanism is used to discover batteries.
> > 
> > Since the information returned when querying fan/thermal sensor
> > information is currently unknown, a debugfs entry is created to
> > allow for easier reverse engineering. The interface is likely
> > to be replaced by a proper hwmon interface in the future.
> > 
> > Since the driver can potentially be instantiated multiple times,
> > the ACPI battery hook mechanism had to be extended.
> > 
> > The first patch passes a pointer to the battery hook to the
> > hook callbacks, so that they can access instance-specific data
> > with container_of().
> > 
> > The second patch finally adds the new driver. It was called
> > dell-wmi-ddv since the interface is called "DDV" by Dell software,
> > likely meaning "Dell Data Vault".
> > 
> > The driver was tested, together with the changes made to the
> > ACPI battery driver, on a Dell Inspiron 3505. Other drivers
> > already using the battery hook mechanism where changed as well,
> > but could only be compile-tested due to missing hardware.
> > 
> > ---
> > Changes in v2:
> > - Significantly lower the amount of changes being made to the
> > acpi battery driver
> > - drop unnecessary ABI description of the temp attribute
> > - return 0 when a unsupported battery is found to avoid being
> > unloaded
> > 
> > Armin Wolf (2):
> >   ACPI: battery: Pass battery hook pointer to hook callbacks
> >   platform/x86: dell: Add new dell-wmi-ddv driver
> 
> Thanks.
> 
> The new version looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> for the series.
> 
> Rafael, from my POV this can be merged through either your
> tree or mine. Feel free to merge this through your tree,
> or please give your Ack for merging through mine
> (assuming you are ok with the changes of course).

I gave some comments, but it's up to you if they have to be addressed now or as
a follow up.

-- 
With Best Regards,
Andy Shevchenko


