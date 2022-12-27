Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EBF657009
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiL0Vhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiL0Vhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:37:47 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944B6E44;
        Tue, 27 Dec 2022 13:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672177066; x=1703713066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7aRB3Na6+UMGKeVFbVMFj8VMFlINfqaup6ApmodHJro=;
  b=lKByGZZwoqPILHHiF13X4AtdtlE/7uEZJ3SJvwhKDnvK4RGjbeMCutbk
   X9AGs4wWe8EMcoknu/0hLiGi3Wax1ujJNeRsPObpdB0+l72EjA3tIYjBT
   bwEWpswR3t3UENDAvapJFlUdgYFoLYu5wHsxVL/Eq7v0DbseNXHKhgxvy
   TRkUT84q+OvXMb1Dk6HSyliO8jlFJ7+hPhHpI6QSp47B4Lt/+wKO2WTfw
   B4Uj2X4YbYRRBe/pNepGYrq3MDvkI6HLq4awOwFu/FYG/Bu/ig9W9e1hn
   1wshKHdRJkJDWKlbo7hsgsjb6/XkA4c1zaNylHVCvRt88axiRZqZL58YO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="383063320"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="383063320"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 13:37:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="795454719"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="795454719"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 27 Dec 2022 13:37:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pAHdk-000GfT-1C;
        Tue, 27 Dec 2022 23:37:40 +0200
Date:   Tue, 27 Dec 2022 23:37:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iio: pressure: bmp280: Add enumeration to handle
 chip variants
Message-ID: <Y6tlpP2SgsgoVBrK@smile.fi.intel.com>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
 <f0368a3f460707417110dffdb0166824da20af15.1672062380.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0368a3f460707417110dffdb0166824da20af15.1672062380.git.ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 03:29:20PM +0100, Angel Iglesias wrote:
> Adds enumeration to improve handling the different supported sensors
> on driver initialization. This avoid collisions if different variants
> share the same device idetifier on ID register.

As per v1, use pointers in the ID tables.

-- 
With Best Regards,
Andy Shevchenko


