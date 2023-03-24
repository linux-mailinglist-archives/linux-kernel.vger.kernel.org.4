Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630B96C7D77
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjCXLs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCXLss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:48:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A800272D;
        Fri, 24 Mar 2023 04:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679658527; x=1711194527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Agnq49hm9Z5LVKQlvI7cyxmsUfGXQDYTkHF95rmm7IM=;
  b=JZK3T1sKvALC1YRoxEz4qHWky/81ET0/VfG5x3QmPafbLfNw1Zu5/2vG
   TJe37ODdjOfapjQ3NiMb78NpvyHaaittCr/Wz47j/4oyoVHCRq7CIVOuv
   F1EvyZGq2YYpqi8TA7mYM99+iKhL4Vho3CP+1RxWogl+g9QVJ1DIPJKpx
   u8lslCtsDxlUkAIAMPM5GIxxa8ARdqzjBASinmZQo5p3f2OZX9EtYOdIP
   +eAD/vuEpa/j/d6AySyoRn5p/e5bVsPl4I9AQcYGC0pvMdzYc8oLlp2am
   5pq64gdUSVWp4KsIIJJTUMSTMsF1end2vB9NgQKHy5nx9a/TyyLCoxSTz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="320152546"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="320152546"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 04:48:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="793411392"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="793411392"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 24 Mar 2023 04:48:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pffuV-007t0P-2b;
        Fri, 24 Mar 2023 13:48:43 +0200
Date:   Fri, 24 Mar 2023 13:48:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] counter: 104-quad-8: Refactor to buffer states
 for CMR, IOR, and IDR
Message-ID: <ZB2OG4zZXsqqyN8v@smile.fi.intel.com>
References: <cover.1679605919.git.william.gray@linaro.org>
 <c5adb13b4b0887beb1df40b34d2ef03d63a2860d.1679605919.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5adb13b4b0887beb1df40b34d2ef03d63a2860d.1679605919.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:25:28PM -0400, William Breathitt Gray wrote:
> The 104-quad-8 driver buffers the device configuration states
> separately, however each device has only three control registers: CMR,
> IOR, and IDR. Refactoring to buffer the states of these control
> registers rather than each configuration separately results in succinct
> code that more closely matches what is happening on the device.

...

> +static void quad8_control_register_update(struct quad8 *const priv, u8 *const buf,
> +					  const size_t channel, const u8 val, const u8 field)
> +{
> +	u8p_replace_bits(&buf[channel], val, field);
> +	iowrite8(buf[channel], &priv->reg->channel[channel].control);
> +}

How did you compile this?
Due to nature of *_replace_bits() this may only be a macro.

That's what LKP is telling about I think.


-- 
With Best Regards,
Andy Shevchenko


