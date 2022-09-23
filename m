Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793D55E8234
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiIWS6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIWS6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:58:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF19122A5C;
        Fri, 23 Sep 2022 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663959496; x=1695495496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bLhdRM6jcdMlWBQ+zRFY/u6ww5on8N54bdu+PLsPS4I=;
  b=HHbiYgQOiTA6QSjQ8P1JS+MbD7BgnNnYb3jLMB4IEonHDvo6vNzECSTX
   t0lhSk876mMqP8v66WJ7HtTHUEYXJXOSlnJ+13Jt9TY0RTfBjVzsqh9Gc
   zYspUySzmXvC0dPzF+lgaF6+KKriqMpyEd3YnNReDvUvdxlRytpWe/FJp
   MQIWy8Q4N1VZRYz6GM1LmEB2PGPAjkFj4MkGG3gKBHUp+YZSoeMymXbaG
   4lqRmjsb8kuNvZGlnE1NBhIKg+QhIEj3cSTxKumiE4dAKgLGjJKlJdCAH
   fNSnX4dIkpta2Jtvyhqmq4/ozewyfmutRJjuC4eo2CIJL8xXasjTaPz9K
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="362484146"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="362484146"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 11:58:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="615716976"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 23 Sep 2022 11:58:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1obnsJ-006ch1-2h;
        Fri, 23 Sep 2022 21:58:11 +0300
Date:   Fri, 23 Sep 2022 21:58:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Sven Peter <sven@svenpeter.dev>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Ferry Toth <fntoth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v4] usb: dwc3: Don't switch OTG -> peripheral if extcon
 is present
Message-ID: <Yy4Bw+jqDxshX4Dg@smile.fi.intel.com>
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com>
 <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
 <Yy3iAHLlS2emAmWn@smile.fi.intel.com>
 <CAHQ1cqHWZeVHp6QmsDw5bjVq=nknRVG5iETB0n4fMMLWginbLg@mail.gmail.com>
 <ec9cc2c9-733c-4e72-b61f-d2ab3bf7a99b@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec9cc2c9-733c-4e72-b61f-d2ab3bf7a99b@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Stephen to help to realize what the mess we have now...

On Fri, Sep 23, 2022 at 08:35:13PM +0200, Sven Peter wrote:
> On Fri, Sep 23, 2022, at 20:23, Andrey Smirnov wrote:
> > On Fri, Sep 23, 2022 at 9:42 AM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> >>
> >> On Thu, Sep 22, 2022 at 04:32:55PM -0700, Andrey Smirnov wrote:
> >> > On Thu, Sep 22, 2022 at 3:23 AM Ferry Toth <fntoth@gmail.com> wrote:
> >> > > On 22-09-2022 12:08, Andy Shevchenko wrote:
> >> > > On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
> >>
> >> FYI: For now I sent a revert, but if we got a solution quicker we always
> >> can choose the course of actions.
> >>
> >
> > I think we have another problem. This patch happened in parallel to mine
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc6&id=ab7aa2866d295438dc60522f85c5421c6b4f1507
> >
> > so my changes didn't have that fix in mind and I think your revert
> > will not preserve that fix. Can you update your revert to take care of
> > that too, please?
> >
> > I'm really confused how the above commit could be followed up by:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/dwc3/drd.c?h=v6.0-rc6&id=0f01017191384e3962fa31520a9fd9846c3d352f
> >
> > the diffs in dwc3_drd_init seem contradictory
> 
> I noticed this a while ago when I finally rebased the M1 USB3 PHY WIP branch
> and have been meaning to send a fix. Then life unfortunately got in the way and
> I completely forgot about it again.
> 
> Both patches were sent at approximately the same time and I think got merged into
> two separate branches. The conflict resolution [1] then went bad but I didn't notice
> until weeks later :(

Folks, I have no idea what you are talking about. Can you check that revert
series [2] gets your change still in? Because I have no clue how it's involved at
all into discussion.

> [1] https://lore.kernel.org/lkml/20220426150842.473be40e@canb.auug.org.au/

[2]: https://lore.kernel.org/linux-usb/20220923163051.36288-1-andriy.shevchenko@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko


