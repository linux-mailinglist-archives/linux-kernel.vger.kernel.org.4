Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B85673D16
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjASPHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjASPHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:07:17 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E85283C3;
        Thu, 19 Jan 2023 07:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674140836; x=1705676836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=woLpKP+4ChVEfynHbF9D8nFvbiL39hwbIGHk3XoR4Gw=;
  b=P3XB6ijeBykCSvn+da2M8r5Xp3hkFg7vGPBURpK6l/LkMQwMgx9JZfal
   Gmthfjh66/HrXTEvZUhaWzQmSwFosLj7KYWwUWqEmh7lLMVSdEysCAhcp
   4sA3UzeGnH2bG5b2Own50M2SCf6F8fvzSPFYEAPbBL8tOrIzGdG4u9mpT
   2HiIqe3Mnt/3DjD6MSbHFu+ab3UiADDCEYmxCzybFlizRaMIv4XR0FCMc
   tkq8+htKft2HrAX0T7pLSQUlCR3XaMl5Zz45UtTyUzMotntaKMa5ikBtt
   Op24KrbXvoJ0Tme7i8HV2OnfYVOMwzqRJHbMxOD9Q79l1SaVbn/ATjspl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="325349196"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="325349196"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 07:06:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="610090966"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="610090966"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 19 Jan 2023 07:06:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIWUa-00Bil1-1G;
        Thu, 19 Jan 2023 17:06:16 +0200
Date:   Thu, 19 Jan 2023 17:06:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Okan Sahin <okan.sahin@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/5] drivers: mfd: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <Y8lcaAFMaUaMTE2m@smile.fi.intel.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-2-okan.sahin@analog.com>
 <Y8eq0GtVZfVdNKYn@smile.fi.intel.com>
 <Y8lTUegNjFZrXh1o@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lTUegNjFZrXh1o@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:27:29PM +0000, Lee Jones wrote:
> On Wed, 18 Jan 2023, Andy Shevchenko wrote:
> > On Wed, Jan 18, 2023 at 09:38:08AM +0300, Okan Sahin wrote:

...

> > > +/*
> > > + * Copyright (c) 2022 Analog Devices, Inc.
> > 
> > Happy New Year!
> 
> If the code hasn't changed greatly since the Copyright, there is no
> requirement to update the date.

It would have made sense if we have/had seen that code in the past.
And since it's a v3 I think this is the case.

-- 
With Best Regards,
Andy Shevchenko


