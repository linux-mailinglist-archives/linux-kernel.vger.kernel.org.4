Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150D969F8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjBVQOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjBVQOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:14:21 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB8F1B4;
        Wed, 22 Feb 2023 08:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677082458; x=1708618458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I6ENmotH9WhjFHgBXjptrRdYaJ2iUL3qQRBQvBjFmRs=;
  b=Gh+J3KqcePTmU+MTBFFmgNYAUXfo0N6Sb/sXtUZKy1WsmtZbNgPuPQAx
   2pUE1AjqzIrfG7dCvEnXQ8weqQPmqYhUon2NCGAmaX+uYxaDVAf6Vu/Kt
   E4ubxPRrIg+0+cpSC6mZ9+xKD3dBYx24/2PD1aHdNF9N0u2lokgvmvpqK
   hQ0RjCY8vxKYOfED3coJ8blW+0mxl6a8cQsCytU1iXHu/flEmQAOoY/A8
   OM2S+rLfIsrAbkT6BBRrfykq9GYDbjUT/uXZSt9Y8NmxQ05z51ZH+bKDf
   H0J2xgCG6J8TijDHA0Jj4FWKWPxeGourpBJG4L1K/bcJ40zAbR2JxY3IS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="321104022"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="321104022"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 08:14:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="621959481"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="621959481"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 22 Feb 2023 08:14:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pUrks-00AVJl-1y;
        Wed, 22 Feb 2023 18:14:06 +0200
Date:   Wed, 22 Feb 2023 18:14:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Okan Sahin <okan.sahin@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <Y/Y/Tv9CxgRkNESv@smile.fi.intel.com>
References: <20230221103926.49597-1-okan.sahin@analog.com>
 <20230221103926.49597-6-okan.sahin@analog.com>
 <Y/S1ftKmV92TL8VO@smile.fi.intel.com>
 <Y/Y1p/4Mc1Oy4dWl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/Y1p/4Mc1Oy4dWl@google.com>
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

On Wed, Feb 22, 2023 at 03:32:55PM +0000, Lee Jones wrote:
> On Tue, 21 Feb 2023, Andy Shevchenko wrote:
> > On Tue, Feb 21, 2023 at 01:39:13PM +0300, Okan Sahin wrote:

...

> > > +#ifndef __MAX77541_MFD_H__
> > > +#define __MAX77541_MFD_H__
> > 
> > Can we go towards consistency in this?
> > Seems to me the most used patter so far is
> > 
> > #ifndef __LINUX_MFD_MAX77541_H
> 
> Drop the LINUX_ part please.

Wouldn't be better to get rid of its usage at once?
Perhaps after v6.3-rc1 is out.

-- 
With Best Regards,
Andy Shevchenko


