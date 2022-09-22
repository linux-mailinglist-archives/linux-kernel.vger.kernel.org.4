Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FACE5E5F74
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiIVKJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiIVKJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:09:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5505DD74D6;
        Thu, 22 Sep 2022 03:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663841337; x=1695377337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BlcPVId1GxxIp58W8m/1nLh/pQWXUcpPVn9W23hAIq4=;
  b=OduOko6xaUmoOiqTX9qrOLgCrXqqx4FxikNAB1iip5V1QsIWu/9y0prC
   4Uh0iOMRXSs8D2WL4VKwlGIVCQcMEyVNJcPF2b8622yzHfXdeTQfd96ky
   skK2l+pbL1hHT/cmWNE24rJdiNHalCgXzV5HnrBfEVWuCQQPi8RdIg10v
   ip6hDti8KWzC4Fd4Wh3lesqEz9S111HW6HC29vUOCcvXH5NR45SX25kC/
   beFC391+Jlf7HOvGDsZjDqHHhjLfRqhusmiI1Pq3Oza/nX9SnrzMAjwCb
   Kr1LXja1JfR1O8nD33s+Cx+93rm4P/TwVgC1FOMb6ibQBhheiTTH/9Q3M
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="287336912"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="287336912"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 03:08:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="762127202"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2022 03:08:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1obJ8O-005xJF-0Z;
        Thu, 22 Sep 2022 13:08:44 +0300
Date:   Thu, 22 Sep 2022 13:08:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Ferry Toth <fntoth@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon
 is present
Message-ID: <Yyw0K/hcTZ02UP+A@smile.fi.intel.com>
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403164907.662860-1-andrew.smirnov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
> If the extcon device exists, get the mode from the extcon device. If
> the controller is DRD and the driver is unable to determine the mode,
> only then default the dr_mode to USB_DR_MODE_PERIPHERAL.

According to Ferry (Cc'ed) this broke Intel Merrifield platform. Ferry, can you
share bisect log?

Taking into account the late cycle, I would like to revert the change. And
Ferry and I would help to test any other (non-regressive) approach).

-- 
With Best Regards,
Andy Shevchenko


