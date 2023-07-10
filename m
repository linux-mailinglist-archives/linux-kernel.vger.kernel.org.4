Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE9574D177
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjGJJ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjGJJ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:28:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04719B;
        Mon, 10 Jul 2023 02:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688981305; x=1720517305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VhTJq09wWAcaEWErmqx7lEChTys+wW+JV/HO+/NxcT0=;
  b=KHRkBQOsZSy2NGn/ZZjAZ+LSu3M6HbQRoHOtWxhrcQrlGoouohd773I0
   1qui35665J2OY7OmKRkPXLqbXuscg+bhPM/x0T5EWmb6cpNRDW5aZ38i5
   /HPaAbeI7NE05fF+TW0cZSyClQmatjWoORjN8HEwgfWB1AQ2FcxBYrMXN
   9iVCgJDnykWWZ9E6IcY1hPyvAocefI2nlDFzwi0tHBjE2J64wJVbUnH9p
   Ul1/wGPfNmKfUy8sjqfkdb4lO9lUp9vgZAKkV4tzfzbqz6wNt5H9odyNv
   PYf1FAa2WRIwmhNWUt7a7gp5YnqFSLxc5LlxbYbyyqNQandkh2VkfOF3j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="395078931"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="395078931"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 02:28:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="755936091"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="755936091"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 10 Jul 2023 02:28:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qInBp-001Vto-2Z;
        Mon, 10 Jul 2023 12:28:17 +0300
Date:   Mon, 10 Jul 2023 12:28:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v4 3/6] iio: adc: meson: move meson_sar_adc_set_chan7_mux
 routine upper
Message-ID: <ZKvPMXu3Q8U18FG8@smile.fi.intel.com>
References: <20230707153322.114302-1-gnstark@sberdevices.ru>
 <20230707153322.114302-4-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707153322.114302-4-gnstark@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 06:27:40PM +0300, George Stark wrote:
> meson_sar_adc_set_chan7_mux is a basic routine writing single register,

We refer to the functions as func().
Mind the parentheses.

"for writing a"

> and defined as static. It moved up so it could be used in more places.

"Move it up, so"

-- 
With Best Regards,
Andy Shevchenko


