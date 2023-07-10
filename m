Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88DB74D1B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjGJJfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjGJJem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:34:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394761FF9;
        Mon, 10 Jul 2023 02:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688981617; x=1720517617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GW+b4HfFoMEuN/QF1SrX4sd509xB7kt59hdOjhlP1FA=;
  b=cKSCVWAyK3vTrYZQOBA/wGlKtpjKO5Z8u89r5z5yfvhI0Et9tPKxzTrb
   Z+NiMHPy6UK/ajfHQp1XF9GI55c6dtjwLblKF/JfUxw29p+VSM08GODyz
   cXkVLM4ll8jCAqVLxe/0WeXi/9SnpZyHUeY0k/3Fxk9JsJ6IDL/9ad/qO
   srJm+JtftS80S/hBMe7uQR5w2BP7kpkfEVQM9tc2+DJk8YUgt9KdtZMCk
   mSbrnD2qJ2lkbruKbO3+lwS9KkZKJLBMbJpXaM5KGo1VMT/N7rrNYXkXG
   Bc1w5RdddXRvNJ2uWe4qu3NkP5RBUQpmmkNaA1DN/UxCBwF7VFdk8YE50
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="427991705"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="427991705"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 02:33:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="810753577"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="810753577"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2023 02:33:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qInGt-001Vxx-0L;
        Mon, 10 Jul 2023 12:33:31 +0300
Date:   Mon, 10 Jul 2023 12:33:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     George Stark <gnstark@sberdevices.ru>, lars@metafoo.de,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, kernel@sberdevices.ru
Subject: Re: [PATCH v4 0/6] iio: adc: meson: add iio channels to read channel
 7 mux inputs
Message-ID: <ZKvQaoFxO5gpAFdM@smile.fi.intel.com>
References: <20230707153322.114302-1-gnstark@sberdevices.ru>
 <20230708170410.0885b8e4@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708170410.0885b8e4@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 05:04:10PM +0100, Jonathan Cameron wrote:
> On Fri, 7 Jul 2023 18:27:37 +0300
> George Stark <gnstark@sberdevices.ru> wrote:
> 
> > From: George Stark <GNStark@sberdevices.ru>
> 
> 
> All looks fine to me.  However, given earlier versions had various other reviewers
> I'd like to leave it on list a little longer.

Code wise
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The commit messages have to be improved, but hey, I'm not a native speaker, so
I assume that Jonathan can help me with that and correct me if required :-)

-- 
With Best Regards,
Andy Shevchenko


