Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96AD5E8231
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiIWSzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiIWSyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:54:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76D63719E;
        Fri, 23 Sep 2022 11:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663959282; x=1695495282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QjtqkxggCYEVL0YB/9OZMsexSYgKKgFGvQCG9MprRME=;
  b=Gq1Dzlsxj1rS549hjlx6ziDfbiHIzfmeFz1PbWna8jakXno5UXwA4sd5
   klahS0R4paDTGN3avs7ckvc1rSi83oaH0j8aR44g8l3LLtD6ZFQK1LqKh
   neZZHE2i45bvHiQ2PO1OjFUyEZtj7iOrcHZd1w//9ynEhTJCN6Qfu6tE7
   JBOK9+mZEf1nqP+GKTrV1apPwchdSiNFlWFRSKgaUPCltITbdIoIVEq2c
   PQbGtWkJZWCNBAw9jE7xKGj73enNzIP7gdstPEze8avhR1r7u6Ai+AgoW
   s6iukrg5kttZLsnvDjMv1dlJcPakW96FjLgTqnI55rdpSJvBg+xxySfNh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="300650059"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="300650059"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 11:54:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="795609695"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 23 Sep 2022 11:54:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1obnor-006cZQ-32;
        Fri, 23 Sep 2022 21:54:37 +0300
Date:   Fri, 23 Sep 2022 21:54:37 +0300
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
Message-ID: <Yy4A7W9y4eeHOvco@smile.fi.intel.com>
References: <20220403164907.662860-1-andrew.smirnov@gmail.com>
 <Yyw0K/hcTZ02UP+A@smile.fi.intel.com>
 <691c3073-5105-9a2b-e6f2-ea0a4b8aaea8@gmail.com>
 <CAHQ1cqGFFJ0gRbdN+DH0iJhcKc=eee8uNoDyfHEy00-CMgstiw@mail.gmail.com>
 <Yy3iAHLlS2emAmWn@smile.fi.intel.com>
 <CAHQ1cqHWZeVHp6QmsDw5bjVq=nknRVG5iETB0n4fMMLWginbLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqHWZeVHp6QmsDw5bjVq=nknRVG5iETB0n4fMMLWginbLg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 11:23:23AM -0700, Andrey Smirnov wrote:
> On Fri, Sep 23, 2022 at 9:42 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Thu, Sep 22, 2022 at 04:32:55PM -0700, Andrey Smirnov wrote:
> > > On Thu, Sep 22, 2022 at 3:23 AM Ferry Toth <fntoth@gmail.com> wrote:
> > > > On 22-09-2022 12:08, Andy Shevchenko wrote:
> > > > On Sun, Apr 03, 2022 at 09:49:07AM -0700, Andrey Smirnov wrote:
> >
> > FYI: For now I sent a revert, but if we got a solution quicker we always
> > can choose the course of actions.
> 
> I think we have another problem. This patch happened in parallel to mine
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc6&id=ab7aa2866d295438dc60522f85c5421c6b4f1507
> 
> so my changes didn't have that fix in mind and I think your revert
> will not preserve that fix. Can you update your revert to take care of
> that too, please?
> 
> I'm really confused how the above commit could be followed up by:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/dwc3/drd.c?h=v6.0-rc6&id=0f01017191384e3962fa31520a9fd9846c3d352f
> 
> the diffs in dwc3_drd_init seem contradictory

I'm not sure I follow. Your patch has been merged and after that some kind of
merge conflict was resolved by an additional change. To revert your stuff
cleanly we need to revert the merge update patch first. That's why revert is a
series of patches and not a single one. I have no idea how above mentioned
commit at all related to all this.

Can you elaborate more, please?

> > > > If the extcon device exists, get the mode from the extcon device. If
> > > > the controller is DRD and the driver is unable to determine the mode,
> > > > only then default the dr_mode to USB_DR_MODE_PERIPHERAL.
> > > >
> > > > According to Ferry (Cc'ed) this broke Intel Merrifield platform. Ferry, can you
> > > > share bisect log?
> > > >
> > > > I can but not right now. But what I did was bisect between 5.18.0 (good) and 5.19.0 (bad) then when I got near the culprit (~20 remaining) based on the commit message I tried 0f01017191384e3962fa31520a9fd9846c3d352f "usb: dwc3: Don't switch OTG -> peripheral if extcon is present" (bad) and commit before that (good).
> > > >
> > > > The effect of the patch is that on Merrifield (I tested with Intel Edison Arduino board which has a HW switch to select between host and device mode) device mode works but in host mode USB is completely not working.
> > > >
> > > > Currently on host mode - when working - superfluous error messages from tusb1210 appear. When host mode is not working there are no tusb1210 messages in the logs / on the console at all. Seemingly tusb1210 is not probed, which points in the direction of a relation to extcon.
> > > >
> > > > Taking into account the late cycle, I would like to revert the change. And
> > > > Ferry and I would help to test any other (non-regressive) approach).
> > > >
> > > > I have not yet tested if a simple revert fixes the problem but will tonight.
> > > >
> > > > I would be happy to test other approaches too.
> > >
> > > It's a bit hard for me to suggest an alternative approach without
> > > knowing how things are breaking in this case. I'd love to order one of
> > > those boards to repro and fix this on my end, but it looks like this
> > > HW is EOLed and out of stock in most places. If you guys know how to
> > > get my hands on those boards I'm all ears.
> >
> > There are still some second hand Intel Edison boards flying around
> > (but maybe cost a bit more than expected) and there are also
> > Dell Venue 7 3740 tablets based on the same platform/SoC. The latter
> > option though requires more actions in order something to be boot
> > there.
> 
> OK, I'll check e-bay just in case.
> 
> > In any case, it's probably quicker to ask Ferry or me for testing.
> > (Although currently I have no access to the board to test OTG, it's
> >  remote device which I can only power on and off and it has always
> >  be in host mode.)
> >
> > > Barring that, Ferry can you dig more into this failure? E.g. is it this hunk
> > >
> > > @@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
> > >                  * mode. If the controller supports DRD but the dr_mode is not
> > >                  * specified or set to OTG, then set the mode to peripheral.
> > >                  */
> > > -               if (mode == USB_DR_MODE_OTG &&
> > > +               if (mode == USB_DR_MODE_OTG && !dwc->edev &&
> > >                     (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
> > >                      !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
> > >                     !DWC3_VER_IS_PRIOR(DWC3, 330A))
> > > @@ -1632,6 +1633,51 @@ static void dwc3_check_params(struct dwc3 *dwc)
> > >         }
> > >  }
> > >
> > > that's problematic or moving
> >
> > I think you wanted to revert only this line and test?
> 
> Yes.

Ferry, can you try that (but I believe it won't help anyway, because I don't
see how we handle deferred probe).

> > >  static int dwc3_probe(struct platform_device *pdev)
> > >  {
> > >         struct device           *dev = &pdev->dev;
> > > @@ -1744,6 +1790,13 @@ static int dwc3_probe(struct platform_device *pdev)
> > >                 goto err2;
> > >         }
> > >
> > > +       dwc->edev = dwc3_get_extcon(dwc);
> > > +       if (IS_ERR(dwc->edev)) {
> > > +               ret = PTR_ERR(dwc->edev);
> > > +               dev_err_probe(dwc->dev, ret, "failed to get extcon\n");
> > > +               goto err3;
> > > +       }
> > > +
> > >         ret = dwc3_get_dr_mode(dwc);
> > >         if (ret)
> > >                 goto err3;
> > >
> > > to happen earlier?
> >
> > It is not always possible to have an extcon driver available, that's why in
> > some cases the probe of it defers. I dunno how your patch supposed to work
> > in that case.
> 
> I'm not sure I understand what you mean. AFAIU the logic is that if
> the platform specifies the presence of extcon either via DT or, like
> Merrifield, via and explicit "linux,extcon-name" device property in
> the code then extcon is a mandatory component of the DRD stack and the
> driver is expected to be present for the whole thing to work.

> I don't
> think I really changed that logic with my patch, even after the revert
> dwc3_get_extcon() will be called as a part of a probing codepath,

But it's not true as proved by the experiment. So with your patch it doesn't
work anymore, so the logic _is_ changed.

>	so
> if the a missing driver is causing a probe deferral it should still be
> happening, unless I missed something.

The merge fix removes deferred probe by some reason.

> > > Does tracing the "mrfld_bcove_pwrsrc" driver (the
> > > excton provider in this case AFIACT) show anything interesting?
> >
> > I believe there is nothing interesting.

-- 
With Best Regards,
Andy Shevchenko


