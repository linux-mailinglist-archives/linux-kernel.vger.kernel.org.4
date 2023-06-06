Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAB5724716
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbjFFO6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238555AbjFFO5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:57:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517AA1711;
        Tue,  6 Jun 2023 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686063428; x=1717599428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MQEsBJHaYbXDRD+nEVDnWSxOpbHnEjtxUPCk18s4my8=;
  b=mhRx996Y0dMsCdHI79p6fnvbYPMGyGdrtjarOQHsLMbyJlg2048kBsPA
   RUPa7gqnVwNFKARBK0f9ir7yJs6VWouciReqhrJXe9gHnkM4YbhSykCsc
   7lBp7epFodQWNjuuXjtj7NSicyOxJVqp1cqt2aLCW9uHEioeUcM7/RxjY
   xDfmdTt9HQLFfOm1bQNWtROPWSwo8UXzOrQPl5dQt/vvUj07bkef8Fcmt
   VScuRLBfuzP6TWNpfxMTPZwjgNw2YKcUVBvT00h0/YnAQLwhPrQTNyYqT
   o6o3zktaerPLxpMxCPX6o7dDQBRKq8RxChCLmRIv946hoNWqxIE68YzW2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="336323090"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="336323090"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="774156290"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="774156290"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2023 07:56:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q6Y74-001gNE-2K;
        Tue, 06 Jun 2023 17:56:46 +0300
Date:   Tue, 6 Jun 2023 17:56:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v2] meson saradc: fix clock divider mask length
Message-ID: <ZH9JLtnlvEbgh+wD@smile.fi.intel.com>
References: <20230606135017.4141617-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606135017.4141617-1-gnstark@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:50:17PM +0300, George Stark wrote:
> According to datasheets of supported meson SOCs
> length of ADC_CLK_DIV field is 6 bits long.
> Although all supported SOCs have the register with the
> field ADC_CLK_DIV documented later SOCs use external clock
> rather than ADC internal clock so
> this patch affects only meson8 family (S8* SOCs)

The longest line above has 60 characters, isn't it too wasteful?
Can you make it ~72?

Code wise looks good to me.

-- 
With Best Regards,
Andy Shevchenko


