Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731B960157C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiJQRex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJQRer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:34:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA6111176;
        Mon, 17 Oct 2022 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666028073; x=1697564073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eAb8YxBfSFdDfJx0JCc9f+Nak1n7XNSg7jL/KIJ9xxY=;
  b=DA/X24CZc8ZhrWvWYawqEqVDL+sCrniAct5NlGjXjzSoby9gpX0+Vhhh
   Yc6VFK+ZerST25HlfbtAeORyTPwaWqPHCz6O9Jsw7SIa67zU1HGjKN9EK
   kbrb/xP8Ti+UPTeSGNp2BwUwB+p+EpvvW2B6b/1W6ubWO9zJr+yVnwU9J
   /KHttr9CrB06voaigERrqQPC9CWiGY+YPwz/lwHi9pDN9UdnmMH2m7i1m
   Dpx+iqNmNxBfWq9AFaGxWWCacxvx47gET1rDlxPgTwrlqC/8I376KgNbN
   GE6oLRTDpM2DRmZl3QkP1sb4+cthO8i5VvvnqHQ0+FWXs31WrM0JKOBay
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="370064270"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="370064270"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 10:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="753713646"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="753713646"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 17 Oct 2022 10:34:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1okU0S-008wZJ-1V;
        Mon, 17 Oct 2022 20:34:28 +0300
Date:   Mon, 17 Oct 2022 20:34:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 2/6] spi: pxa2xx: Respect Intel SSP type given by a
 property
Message-ID: <Y02SJNTxrLMjpZfG@smile.fi.intel.com>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
 <20221017171243.57078-2-andriy.shevchenko@linux.intel.com>
 <Y02OMNAFrKLWUtiO@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y02OMNAFrKLWUtiO@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 06:17:36PM +0100, Mark Brown wrote:
> On Mon, Oct 17, 2022 at 08:12:39PM +0300, Andy Shevchenko wrote:
> 
> > Allow to set the Intel SSP type by reading the property.
> 
> > +	/* Always try to read property */
> > +	device_property_read_u32(&pdev->dev, "intel,spi-pxa2xx-type", &value);
> 
> What is the advantage of pushing this into firmware?

To distinguish better what the controller generation is there.

-- 
With Best Regards,
Andy Shevchenko


