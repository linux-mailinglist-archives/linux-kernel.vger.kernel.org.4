Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA1E6B789E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjCMNOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCMNOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:14:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACE5C67D;
        Mon, 13 Mar 2023 06:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678713256; x=1710249256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cVeWGOx69qW/3lWynjvHLBQvhaQb/2+on+nkdo8szzY=;
  b=Z8kVzco/sbqODLxGdjXxrCp/Erm2/ff+3NKp5kBq0ar/pM+ZQlYfuUjf
   zgMOgYN7Emis/zku+nWWcemPWQCgi68buMMHBzisKcC3YKHF11ylq3+BF
   0nWRptEBIvpUvSrnGllUvczzjQ3iqGghDyYlu8JugERQhjuQUnZbuUpcC
   KPeq3bAhwD8D1D7CKElLG2aiZDJFlnv3BEvE4zf41GFjJMn8PPqM8WHFy
   Vq20sVLnYDXY+L5sUgw2VGVU4XuPaqHVk00yO0RbHIdvki9Kk/T1kFOgT
   ++zgcQUAy5dMq9QiwxzC8h/tw4ivlXeIEqc25ovUGO2HH6NFPyK1r6QfY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="402011568"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="402011568"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 06:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="1007981075"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="1007981075"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2023 06:14:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pbi0B-002dl8-1l;
        Mon, 13 Mar 2023 15:14:11 +0200
Date:   Mon, 13 Mar 2023 15:14:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <ZA8ho4YfhBkSMFxS@smile.fi.intel.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <ZAXiKfRbsXpHhwAJ@smile.fi.intel.com>
 <20230312165100.45de0c9b@jic23-huawei>
 <bad05e06-3b37-b435-bfac-962aef36cc97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad05e06-3b37-b435-bfac-962aef36cc97@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 02:56:59PM +0200, Matti Vaittinen wrote:
> On 3/12/23 18:51, Jonathan Cameron wrote:
> > On Mon, 6 Mar 2023 14:52:57 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Mar 06, 2023 at 11:17:15AM +0200, Matti Vaittinen wrote:

...

> > > > +EXPORT_SYMBOL_NS_GPL(iio_gts_total_gain_to_scale, IIO_GTS_HELPER);
> > > 
> > > I would say _HELPER part is too much, but fine with me.
> > 
> > Hmm. I think I like the HELPER bit as separates it from being a driver.
> > Of course I might change my mind after a few sleeps.
> 
> Ever considered a career as a politician? ;) (No offense intended - and feel
> free to change your mind on this. I don't expect this to be done tomorrow)

It will be a one liner in the provider if you use DEFAULT_SYMBOL_NAMESPACE
definition.

-- 
With Best Regards,
Andy Shevchenko


