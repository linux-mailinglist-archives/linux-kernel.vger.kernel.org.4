Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FFC5E9E59
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiIZJvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiIZJvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:51:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C544E31DC2;
        Mon, 26 Sep 2022 02:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664185889; x=1695721889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Vv4T7R4h9e9Wl2n3SmIRXDL5lb25nAct3ThLSkM40ug=;
  b=YZu2ugZeh2L39xui7eclk6UnQWL6zxn/m9C2m9UtDw0QTJryW3qsLIr/
   zuORYnd87ZxxM67279RLgff0QfD0+wv7z9I1t+cfdF7OHll/0Cdv5IJLa
   5Kv8bwaEUWIQqWAh8ZoOQlaJH8o0FxIonXaj0VTey5j1S8BraRGcMuknK
   KtUHPc+gC81zMEUDorQlvF0+u4+PZ32X2XYvNqB7dT8IrvRDo9xgQ8MrF
   waGIEmvc0HV4spPx9X/ZRBdcqCrV1IhgAtaev4Tb3eqMT3sZ/IiQPEfeQ
   sL4BN4d39TVOJhCfSlpO2nj7w/6nsDOSC4DWK/feEI9EK5FhyjHcP4d0D
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="387278268"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="387278268"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 02:51:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="710062423"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="710062423"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2022 02:51:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ocklq-007jdW-1P;
        Mon, 26 Sep 2022 12:51:26 +0300
Date:   Mon, 26 Sep 2022 12:51:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 6/9] pwm: lpss: Use DEFINE_RUNTIME_DEV_PM_OPS() and
 pm_ptr() macros
Message-ID: <YzF2HmvDcOF8zBXk@smile.fi.intel.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
 <20220908135658.64463-7-andriy.shevchenko@linux.intel.com>
 <20220924100714.mn6o5iggv5dtucyd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220924100714.mn6o5iggv5dtucyd@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 12:07:14PM +0200, Uwe Kleine-König wrote:
> On Thu, Sep 08, 2022 at 04:56:55PM +0300, Andy Shevchenko wrote:
> > Using these new macros allows the compiler to remove the unused dev_pm_ops
> > structure and related functions if !CONFIG_PM without the need to mark
> > the functions __maybe_unused.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> that was one of the patches I thought I already acked. I didn't check if
> I'm confused or if you missed to add my Ack.

If so, sorry, and I think it might be because of wrong branch I took or misuse
of `git filter-branch --msg-filter`... But looking into [1] I do not see your
replies.

[1]: https://lore.kernel.org/linux-pwm/20220906195735.87361-1-andriy.shevchenko@linux.intel.com/

> Doesn't really matter to
> me. So:
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


