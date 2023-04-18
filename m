Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D376B6E5AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjDRHpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjDRHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:45:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043CE44A5;
        Tue, 18 Apr 2023 00:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681803903; x=1713339903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2GkX+7Y2EPR5wAFJuF3tLDRqsCCn3i3+/rD88hSVrus=;
  b=lLfN0vtEGf2TZgYUIqg4nPxwO08SJB4LcHDqs9svlgMkwd4YmPpziXld
   oZXYF3QdGv4Fcru0dkQ5BC0YAQRfP8jT8TtX/z6vYJo5Ka608ByOEBSaY
   H7Gy6L76NkcPXeR+3sIs1i5hEYiRSLOn2157QARRrzK+ELVV+dPf3EG8O
   A9Gx3asZVcWGYcyFpE70BIt5mKQXygG3i0XPUwUk9DRJJo87F1Ydo5S9i
   6DZ0zjbM6t1m+zJjmB4w8/i4iW2Vhm4v8yUEK6v2XZkRQ0p0Z6sZMNXqW
   FQdyQPaRiw9H5QR232We/f3uTgkWPunj9VUjdSU4/cBbsby882lJ32G0j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="342595346"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="342595346"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 00:45:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684477294"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="684477294"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 18 Apr 2023 00:44:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pog1J-001VmC-36;
        Tue, 18 Apr 2023 10:44:57 +0300
Date:   Tue, 18 Apr 2023 10:44:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v4 4/4] counter: 104-quad-8: Migrate to the regmap API
Message-ID: <ZD5KeYJoIZ1PFKud@smile.fi.intel.com>
References: <cover.1681753140.git.william.gray@linaro.org>
 <1f1f7920d2be94aedb6fdf49f429fe6137c8cb24.1681753140.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f1f7920d2be94aedb6fdf49f429fe6137c8cb24.1681753140.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 03:50:50PM -0400, William Breathitt Gray wrote:
> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver. With regmap we get boundary checks, read-write
> permissions, operation synchronization locks, and more for free. Most
> important of all, rather than rolling our own we utilize implementations
> that are known to work and gain from any future improvements and fixes
> that come.

...

>  - Use "int ret" for regmap_* return values throughout for consistency

Looking into it I would think it might be better to have a precursor patch.
But it's up to you. It looks good now.

-- 
With Best Regards,
Andy Shevchenko


