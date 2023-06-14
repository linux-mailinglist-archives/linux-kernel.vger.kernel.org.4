Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315F072FE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjFNMO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244007AbjFNMOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:14:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C461BF3;
        Wed, 14 Jun 2023 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686744847; x=1718280847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zu0EJm0A4E/r52S2oZKehz3Y6IyIfevP7ODvoSpOeSk=;
  b=Dy0o6HyOj4oDV/wm/y24qF3NwowzdcRkGJcAdY5/MYSzXz3Wp0/GdQqh
   yrvLwKcsCp8rr1V2f3m0jfLGZPNwEWdKDUEW4R4OyAmOwIClJhu1ZkqG9
   KlfCUxQrRBjkKmXCV7DwW/adGowWALe3IrKTCFePkr4htAFwwI3P+PgdR
   Xfo2yEJu0aM+XvrE9W2DuNV2VhXLhlM1P4/0XQ7Nn+WZzEQYQISqJ8Mpv
   7T4SQ5N8M9+Z2Q1fiEwf3nnMk6YriidNm88CzhP+1kDCxVXAe0qirvzUK
   bOt3iDR3nHsgTzz4E87dkx1gIwpxT2iwqTXIKwHRsjJp062A5UsFbZLLI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="361967482"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361967482"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 05:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="782064205"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="782064205"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2023 05:13:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9PNV-003hCK-0K;
        Wed, 14 Jun 2023 15:13:33 +0300
Date:   Wed, 14 Jun 2023 15:13:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] rtc: isl12022: implement support for the
 #clock-cells DT property
Message-ID: <ZImu7BlD2XrvFqsl@smile.fi.intel.com>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-9-linux@rasmusvillemoes.dk>
 <ZIiKTXmrxBHw+gkG@smile.fi.intel.com>
 <c826b8a9-ed12-a6cc-d089-47adbc200f37@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c826b8a9-ed12-a6cc-d089-47adbc200f37@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 12:51:47PM +0200, Rasmus Villemoes wrote:
> On 13/06/2023 17.25, Andy Shevchenko wrote:
> > On Tue, Jun 13, 2023 at 03:00:10PM +0200, Rasmus Villemoes wrote:

...

> >> +#define ISL12022_INT_FO_MASK	GENMASK(3, 0)
> >> +#define ISL12022_INT_FO_OFF	0x0
> >> +#define ISL12022_INT_FO_32K	0x1
> > 
> > A nit-pick. Are they decimal or bit fields? 
> 
> -ENOPARSE. A number is a number. Its representation in C code may be
> decimal or hexadecimal (or...). And sure, 0 and 0x0 are different
> spellings of the same thing. The data sheet lists the possible values in
> terms of individual bits, so I suppose I could even do 0b0000 and
> 0b0001, but that's too unusual (even if perfectly acceptable by gcc).

What does datasheet define? bits or the value in a 4-bit field?
If bits, why don't you put it that way

#define ISL12022_INT_FO_OFF	0
#define ISL12022_INT_FO_32K	BIT(0)

?

It's a nit-pick, of course, but the nuance is that proposed form might give a
hint to the reader, current -- not.

> > To me seems like the 0x can be dropped.
> 
> Can, but won't, a single hex digit is more natural way to represent a
> four-bit field.

-- 
With Best Regards,
Andy Shevchenko


