Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF979680DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbjA3Ma0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjA3MaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:30:24 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B616D36089;
        Mon, 30 Jan 2023 04:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675081822; x=1706617822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HmEHm/9gJR3pZ+9imdlTbasj5qnwePyJ2tav5AQCevc=;
  b=Qxwsl5GeDEGYb6xWcZm81PtnUWF9aWjLVW0hrMXBTj8/qfckGur1fKWk
   mLun99DnFAYvSk9mqq8niVsQQ88y/raMTH6j+msKkBqQVL+Z5/dilNGxc
   5Pu+NIuGpSogUwI56gT0t0S7GtJnHbaQrwThgUfYmQuyVMahboYikykhT
   LlSbsWEg1R3Q8UMVZzjsNL4KZ8S7vXj3RaPwTNoO5nYgX/55ignvaAi7I
   n+HID9J9URyOjhLxvWrvXy3OcgfWdl5Lmn2tDWGN1u13aEKucI6XluwWq
   i8HccGt/n6DXYgitRxS5dxaLlCqtSAw9+zXNmZH02CCtLG97qbR+oH0Mp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="307889126"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="307889126"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 04:30:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="806658086"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="806658086"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2023 04:30:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMTIg-00HLU8-1c;
        Mon, 30 Jan 2023 14:30:18 +0200
Date:   Mon, 30 Jan 2023 14:30:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Add support for pressure sensor Bosch BMP580
Message-ID: <Y9e4WviD+Lmiin9T@smile.fi.intel.com>
References: <cover.1674954271.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674954271.git.ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 02:33:02AM +0100, Angel Iglesias wrote:
> This patchset adds support for the new pressure sensors BMP580 extending
> the bmp280 driver.
> 
> Patch 1 introduces a minor refactor of the driver structure to change how
> the device matching and driver initialization is performed. In place of
> the chips ids, the driver_data now contains a pointer to its chip_info.
> To perform this change, a series of declarations previously on the core
> file were migrated to the shared header file, to allow access to specific
> fields on the chip_info on the I2C and SPI drivers. This change is
> required because BMP380 and BMP580 have the same chip_id and values would
> collide using the chip_id as the driver_data value.
> Patch 2 introduces new preinit callback and unifies init logic across all
> supported variants.
> Patch 3 made calibration callback function optional.
> Patch 4 deletes misleading i2c reference on bmp280 Kconfig entry.
> Patch 5 extends the bmp280 driver with the new logic to read measurements
> and configure the operation parameters for the BMP580 sensors.
> Patch 6 updates the devicetree binding docs with the new sensor id.
> Patch 7 adds the NVMEM operations to read and program the NVM user range
> contained in the non-volatile memory of the BMP580 sensors.

Patches 1-5 are good enough for me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

If anything, we can fix in the followups.

-- 
With Best Regards,
Andy Shevchenko


