Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1001B73867A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjFUONa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjFUONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:13:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652021BF1;
        Wed, 21 Jun 2023 07:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687356739; x=1718892739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LjdGendaOChspmczDqlVv2lUaqfNdB1QDN1y/lEkBQs=;
  b=iEbElGjTL0LVqGHdhJO9fYLkHEiiCeOYtF/KIv/r/zal2wd1rEwoNWJW
   sAG9W9jnqO487hLdP6G/o8Umh9POmIbvPWsNwj8ntXuS/e2Sn1ZrtncKP
   pGOe/ssJL59ffKxGbWzcggISmxEOV96juVjsmZHG/AMvkazVxUYEM21hx
   00lgmQlm1CHEh2PkYNxZk1ZZfX8RTlF7K/rCDSZGG9ejSdRjGcEMsge8X
   6+9TbWh446dup3B2hiehKrK4tJnnQdcBqUk+s/LacdIIVpN/ZEu2JFngW
   5A4k+riB75hI4qHsJ3sx+0VwFz867mb7Gbe4x7Kmt1xWxR1dX2FHRxfef
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="344917978"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="344917978"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="858984265"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="858984265"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jun 2023 07:10:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qByX6-005VxA-2j;
        Wed, 21 Jun 2023 17:10:04 +0300
Date:   Wed, 21 Jun 2023 17:10:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v1 3/3] meson saradc: support reading from channel7 mux
 inputs
Message-ID: <ZJMEvDeSRaUOInc9@smile.fi.intel.com>
References: <20230621062715.455652-1-gnstark@sberdevices.ru>
 <20230621062715.455652-4-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621062715.455652-4-gnstark@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 09:26:10AM +0300, George Stark wrote:
> meson saradc channel 7 is connected to muxer that can switch channel
> input to well-known sources like Vdd, GND and several Vdd dividers.
> This patch adds iio channel for every mux input.

Same comments as per patch 2.

...

> +static const char * const chan7_mux_names[] = {
> +	"gnd",
> +	"0.25vdd",
> +	"0.5vdd",
> +	"0.75vdd",
> +	"vdd",
>  };

Looks good to me now, thank you for fixing this.


-- 
With Best Regards,
Andy Shevchenko


