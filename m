Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F3A6DDF29
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjDKPM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjDKPMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:12:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516D65FD8;
        Tue, 11 Apr 2023 08:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681225906; x=1712761906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iLQiotX10XelskjYsdgJSl4FyQWqiFPC4B2wnpojFn0=;
  b=OVXdj5YY64fo8+io4EG3mDSaCIZOhVAMTSS3okkZ86oCJZ+JrqBub2vn
   JtT2w/y19J98lkM5RtpYP8nsQU7T8sj74btCR+c53Pi3dyhI1a7EhhCUD
   58ALx5hfMRYTNA7gWZ6tvSefU5dSRcqBp2eGCdkXDJbMjIvTmA0rmznZ4
   k2HfTEhW5qqqSRdUYs61f14JnM/9AJ+ENRAT+b4mdI+o+JTOYnPyZKoiV
   JN/J8/gtLY/tJhQu52o2ZhGP+DN+EztO1WXyb+62eUDGpC7plQtGtCUvV
   JCfh3W/hL07o+tpvKxDet4t33dXgU1wf+Sw6wF978ykkYvVKZ9A65upBT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="429934029"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="429934029"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 08:11:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="688617403"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="688617403"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 11 Apr 2023 08:11:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pmFem-00FLXe-0B;
        Tue, 11 Apr 2023 18:11:40 +0300
Date:   Tue, 11 Apr 2023 18:11:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v5 2/2] spi: dw: Add dma controller capability checks
Message-ID: <ZDV4q79uHy5aGdT1@smile.fi.intel.com>
References: <20230330063450.2289058-1-joychakr@google.com>
 <20230330063450.2289058-3-joychakr@google.com>
 <ZDVQGu/gBPTNbQPU@smile.fi.intel.com>
 <CAOSNQF0R7p7kW04w0nKF2egv1+8NrMhSXpggunYhjQnA+v-qMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOSNQF0R7p7kW04w0nKF2egv1+8NrMhSXpggunYhjQnA+v-qMQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 08:30:41PM +0530, Joy Chakraborty wrote:
> On Tue, Apr 11, 2023 at 5:48 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Thu, Mar 30, 2023 at 06:34:50AM +0000, Joy Chakraborty wrote:

...

> > > +static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes);
> >
> > Can we avoid forward declarations please?
> 
> We can, but for that I would have to move this api somewhere else in
> the file is that acceptable?

Yes, but make it in a separate change as a preparation for this one.

-- 
With Best Regards,
Andy Shevchenko


