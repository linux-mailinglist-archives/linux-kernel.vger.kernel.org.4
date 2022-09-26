Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AA45EA5BC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbiIZMPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbiIZMOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:14:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBEB86703;
        Mon, 26 Sep 2022 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664189958; x=1695725958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u7owsbshEAO1iKwIIF0asyEoQmpmhQVZYEfFvSbbgvA=;
  b=IhcW78cgPnLXMiuAxpE7Ml2lMOENZuyY/aJv9xE2sKU1ACGFUkhfWTxt
   22fbYe0MjmGhuv6SpTYVWN9peZufurmcTtJplKGJoQoV67/poJQXwEPmA
   RojGJDF/tx9M7srWodqxamdf1N7lLNPVJKOFzmOF7wTRIYCinOYt6je/V
   60cDJpUtOTueCc+B328gdvm+37vX8ElzpACX4zT6uQAwLUCr0JVsHfQzh
   6kP6E6buYTC0vPsXZtkJvTHytBkQjKbG4fLrQqQW8uQ8HVyDgW25lMXAH
   BOCTXcIl5gtG6HR26c5xxVCobiXOhh2BOdPw5TnuOV7nzpYsVD1Ci3fXP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="299719957"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="299719957"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 03:57:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="623290877"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="623290877"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 26 Sep 2022 03:57:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oclnH-007lcz-0H;
        Mon, 26 Sep 2022 13:56:59 +0300
Date:   Mon, 26 Sep 2022 13:56:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] Input: matrix_keypad - replace header inclusions
 by forward declarations
Message-ID: <YzGFevZg149db377@smile.fi.intel.com>
References: <20220923184632.2157-1-andriy.shevchenko@linux.intel.com>
 <20220923184632.2157-2-andriy.shevchenko@linux.intel.com>
 <Yy4C5HH3yxssLMPh@google.com>
 <YzGFWt40IhkASq4j@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzGFWt40IhkASq4j@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 01:56:27PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 23, 2022 at 12:03:00PM -0700, Dmitry Torokhov wrote:
> > On Fri, Sep 23, 2022 at 09:46:32PM +0300, Andy Shevchenko wrote:
> > > When the data structure is only referred by pointer, compiler may not need
> > > to see the contents of the data type. Thus, we may replace header inclusions
> > > by respective forward declarations.

...

> > > +struct device;
> > > +struct input_dev;
> > 
> > This results in a ton of compile errors. While I believe this change is
> > a good one, we need to fix users of this include first.
> 
> Indeed, sorry for breaking things (I compile-tested with limited drivers
> enabled). I will look into LKP reports and will fix the users.

Ah, thanks, I see your series for that!

-- 
With Best Regards,
Andy Shevchenko


