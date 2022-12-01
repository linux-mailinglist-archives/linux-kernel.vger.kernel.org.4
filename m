Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03A163F45A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiLAPmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiLAPlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:41:50 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C3BBBBC0;
        Thu,  1 Dec 2022 07:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669909250; x=1701445250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0GOY+1e8ccz1SadE0JDTGj0SX1z4eRNxvGHkNwFzbpw=;
  b=lpsQhAfTkNvR0aHLjFlE9/ypFFQ+WAXkpsb7PUHiocKiMd++lgnDDYoK
   ha3xnGoED3dgAmWpN8UEPVWyYUdzsmtYv5JsuklAbE8Tbdm4J/Vv7J5TS
   g78QZaVh35zAZ0zk9odHzcp21Q53Yc3P0Y929VnrpJSJclZ/zda4j0Hdd
   akGi6kKPcLHTlwx4af2Jt3gh0/0vxszNEzbdYyybmToRnIVJwGKYnnEFR
   3iX15xw83dcnfzlIV0uuqMQV581QrU+LXWbWsGHG1yxElkpwac/6CMkZx
   ve6Dmsp7j5diHai4+CwlcU0BqGQruWRLPjV17/E81Du8PMQmEIOD5u8aa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="377876353"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="377876353"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 07:40:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="819081782"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="819081782"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 01 Dec 2022 07:40:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0lg5-002s5z-2L;
        Thu, 01 Dec 2022 17:40:45 +0200
Date:   Thu, 1 Dec 2022 17:40:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 0/2] gpiolib: don't allow user-space to crash the
 kernel with hot-unplugs
Message-ID: <Y4jK/RPDsyf/wcqM@smile.fi.intel.com>
References: <20221201125928.3031325-1-brgl@bgdev.pl>
 <CAMRc=MfGi52s+LcTrBnBPDV91SbC4vf1prrLUpzQ_KZQQZGBuQ@mail.gmail.com>
 <Y4izMVZBhXGj1jbj@smile.fi.intel.com>
 <CAMRc=MedXBgh+JnTL0qUOrhKJ+w0vcVZTk-k2TKJzdbk_TNtVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MedXBgh+JnTL0qUOrhKJ+w0vcVZTk-k2TKJzdbk_TNtVQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 03:13:55PM +0100, Bartosz Golaszewski wrote:
> On Thu, Dec 1, 2022 at 2:59 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Dec 01, 2022 at 02:00:06PM +0100, Bartosz Golaszewski wrote:
> > > On Thu, Dec 1, 2022 at 1:59 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > ...
> >
> > > I know Kent and Linus left their review tags already, I will add them
> > > when applying.
> >
> > I guess it's good enough, go ahead with it.
> 
> Can you leave your Reviewed-by here too?

Hmm... Your both patches already have it.

-- 
With Best Regards,
Andy Shevchenko


