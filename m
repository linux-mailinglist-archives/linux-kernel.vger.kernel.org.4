Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D727632734
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiKUPBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiKUPBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:01:01 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6573D39E8;
        Mon, 21 Nov 2022 06:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669042204; x=1700578204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1h87WbLq+PbLt7QpiRo9I8PSCUlCMW2H/19r0KnYV+U=;
  b=Ls5ywVVbRJP2U2JTHOrA162xJET615/8mGwZTVB9EUFBCNT40jm79LJA
   nqZMASb3koCkp9DPQZK33JU0OddtPMd2SkDqeGnjXBQ5vKHktiq6q0IHD
   6zuMfuLU4bfXZeHO3gGmjVQhLnvkcpy7AxGgjgkx/ZdVShsHOhkGA0nhs
   rqxTHO6ibKV7nQOu75zN7sAEekR/m9psNl/XgUJoS3/yA1kutGr7Ot8h8
   aN6i7xRfckfQuDlBFRHV/jh/fCHujSQCWF9/Wgb1h4P0TMrkkHi90rJPv
   mBs1svezPLypw+aac3bSEZ9phwTj/MYv1dPV9WL7PmBNxoyh44FUzLCEL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="377831734"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="377831734"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 06:49:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="673996172"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="673996172"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 21 Nov 2022 06:49:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ox86y-00FJuh-1C;
        Mon, 21 Nov 2022 16:49:28 +0200
Date:   Mon, 21 Nov 2022 16:49:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, hdegoede@redhat.com, rafael@kernel.org,
        mika.westerberg@linux.intel.com, mario.limonciello@amd.com,
        timvp@google.com, linus.walleij@linaro.org, jingle.wu@emc.com.tw,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Alistair Francis <alistair@alistair23.me>,
        Jiri Kosina <jikos@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/13] HID: i2c-hid: acpi: Stop setting wakeup_capable
Message-ID: <Y3uP+Kx1xLWRVUAX@smile.fi.intel.com>
References: <20220929161917.2348231-1-rrangel@chromium.org>
 <20220929093200.v6.9.I2efb7f551e0aa2dc4c53b5fd5bbea91a1cdd9b32@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929093200.v6.9.I2efb7f551e0aa2dc4c53b5fd5bbea91a1cdd9b32@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 10:19:13AM -0600, Raul E Rangel wrote:
> This is now handled by the i2c-core driver.

What happened to this patch? I don't see it in the Linux Next...

-- 
With Best Regards,
Andy Shevchenko


