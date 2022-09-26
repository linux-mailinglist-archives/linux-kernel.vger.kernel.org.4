Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465425E9FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiIZKb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbiIZK3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:29:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AE54E86A;
        Mon, 26 Sep 2022 03:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664187558; x=1695723558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yic0GwGpixPkuYrr1AQ7VR1nKuBMpremGARqqE5/85A=;
  b=XU9yTuy7gqms4TQfoqNBXrkehFyXfi5nnUdoqY8K0au6cEyoe3WWLCCQ
   pfhkE6NyahzWJlBEtGTxn1MrQji2wv0CDB9uhGd4j6BLJ61yatZd4Sa5a
   IeEl5cwwWNPP6L5KiGXC1JVdOuPUH74Y0OG1gAUdMJJ2oFd/54dSR/hjg
   tTzo2mbB+Miws+zsrBMXmEiPM6nMzQCzJrW5Pmjv+dF6fai+rMeVErNS1
   Z93HsB+3P71+zN3A2EPI4XtiZn6Lntyz8W0RTJmfTo3gkD0lWI1kkSdqW
   OuiuQOmu+CdzA6kSU7ynon8ishHQ4riM0AClIdcjHfkKHv8alwlOBdXM7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="302459750"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="302459750"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 03:19:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="651773562"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="651773562"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 26 Sep 2022 03:19:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oclCZ-007kP2-2R;
        Mon, 26 Sep 2022 13:19:03 +0300
Date:   Mon, 26 Sep 2022 13:19:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Ferry Toth <fntoth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon
 is present
Message-ID: <YzF8l7kiS7m496YE@smile.fi.intel.com>
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com>
 <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
 <Yy3iAHLlS2emAmWn@smile.fi.intel.com>
 <CAHQ1cqHWZeVHp6QmsDw5bjVq=nknRVG5iETB0n4fMMLWginbLg@mail.gmail.com>
 <966ef528-455c-5180-fc63-ea77cb933af1@gmail.com>
 <331b5644-e204-8915-cd08-bd4fabbfcb49@gmail.com>
 <CAHQ1cqGrfTO9JLgD-k0Akg7+hXNT+WevfjH_YpsVi8wQt6_iBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqGrfTO9JLgD-k0Akg7+hXNT+WevfjH_YpsVi8wQt6_iBw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 10:43:07PM -0700, Andrey Smirnov wrote:
> On Sun, Sep 25, 2022 at 12:21 PM Ferry Toth <fntoth@gmail.com> wrote:

...

> I think we'd want to figure out why the ordering is important if we
> want to justify the above fix.

At least we all on the same page (I hope) on justification for reverts.

...

> IMHO instead of trying to rush something in it be prudent to revert my
> patch _and_ address the fact that above patch was lost during the
> merge (Andy's revert needs to be updated)

I'm not an expert in your fixes for DWC3, so please come up with
the solution sooner than later, otherwise I will try to get my
reverts into the final release, because they obviously fix the
regression.

-- 
With Best Regards,
Andy Shevchenko


