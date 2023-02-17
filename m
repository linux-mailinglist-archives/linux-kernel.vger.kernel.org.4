Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD2169B2D9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjBQTHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBQTHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:07:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2262429;
        Fri, 17 Feb 2023 11:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676660842; x=1708196842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GUE3tAE4Et6+TGfEegC3D71rexRa7L+1eXg/T+Edzz0=;
  b=DdUA3c3UhMZaO9jV+6CcISfS05nxYPTBK3Q4MyU6TAdG4MDgXTPIx4BU
   fQWUNVbMjExT1pDxS5BS2r86237Qty0n3Sv6w69DqQ8xwrApBBhPnm6W5
   ZoM4kvEobIIIbnpjzyuDs/QyD/nQuSQbCSZepvl7M80QWUJp7ljXhnWHU
   z6MrTfBsc2yy52wGCrxmg26vXnRD8lTIqkPooLhaBMxpWCrdfAlAPaHZF
   ucBABQBdGuUSqjFxIefavb64SaR7ryZNIs/1v8Tv37ZT8XT5hxiSg6C/e
   7yHF444s4IyUDfrtCVaWApPQk3fk3JkMBb6xjYFelBgpG1hvcuqK1X5oE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="359516979"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="359516979"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 11:07:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="739353039"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="739353039"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 17 Feb 2023 11:07:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pT64l-008KaN-2A;
        Fri, 17 Feb 2023 21:07:19 +0200
Date:   Fri, 17 Feb 2023 21:07:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, broonie@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] gpio: pci-idio-16: Migrate to the regmap API
Message-ID: <Y+/QZ7VX2EAxweIt@smile.fi.intel.com>
References: <cover.1675876659.git.william.gray@linaro.org>
 <1bac3155e366fc7da7dbb48f54ab96d4a9649e57.1675876659.git.william.gray@linaro.org>
 <Y+/PwYe3pvtausbe@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+/PwYe3pvtausbe@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 09:04:33PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 08, 2023 at 12:18:20PM -0500, William Breathitt Gray wrote:
> > The regmap API supports MMIO accessors so we can take advantage of
> > regmap abstractions rather than handling access to the device registers
> > directly in the driver. Migrate the pci-idio-16 module to the new
> > idio-16 library interface leveraging the gpio-regmap API.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Don't you need to allow PIO accessors in the regmap configuration?

If not, update a commit message accordingly.

-- 
With Best Regards,
Andy Shevchenko


