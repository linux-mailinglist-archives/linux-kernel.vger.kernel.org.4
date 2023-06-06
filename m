Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F094724018
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjFFKuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFFKuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:50:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5F11995;
        Tue,  6 Jun 2023 03:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686048517; x=1717584517;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=XyN+KIiSuE6e1s6MFnXdI244hBkU0NrA3+Zkh0IR9wY=;
  b=iJIhFD1pvaw8x/oEjwE/Kwk9T+a9fG1gvwtDO3a9mrcJixm/zSl1eJQ9
   VrR0QKabk4SW4ujVhwOGAA2Hi3jefX8mf97GlWBe87UfgzZ+X+2WkquHH
   OkX6FWxPidErhKr+VI+u8CLfH8MrOtM/NJg9umYmuvHm+COKYh0FEmzU6
   DkvJTC6pZsVbAyhidz7YOC7gbD5FVH1xD+Ll+klolltqo7Rna4mIogUQ3
   KcYDL3o7e9x4NHKtnGWKXB0LWXWouUFU43AoScIXVf+UWFXioRFq8Mq/t
   egdOi77wGpmx2zXfKDYknJVEP9/kwrGnPKgtKLPcIvZLhvHxIBHEtTIC5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="356642053"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="356642053"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 03:48:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="712164833"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="712164833"
Received: from vkkalava-mobl1.amr.corp.intel.com ([10.249.42.194])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 03:48:22 -0700
Date:   Tue, 6 Jun 2023 13:48:19 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: 8250_mtk: Simplify clock sequencing and runtime
 PM
In-Reply-To: <2023060608-bucket-footsore-9e43@gregkh>
Message-ID: <b831965-c588-cca7-a861-2a525041c8f3@linux.intel.com>
References: <20230606091747.2031168-1-wenst@chromium.org> <58949bbd-1506-90a0-7154-e6e57d8ddf70@collabora.com> <CAGXv+5GRBOWFMw+BmkSpczHcm_R6=mvL2GSKnWWyhpng1xw21w@mail.gmail.com> <61ec34d0-6cc2-951e-c990-fdfd57381d7@linux.intel.com>
 <2023060608-bucket-footsore-9e43@gregkh>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1863769213-1686048085=:2339"
Content-ID: <7bd0d48-77b6-a9a2-8f9-e3d0ed9752ce@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1863769213-1686048085=:2339
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <142fbc7c-385f-24bc-4383-c4af99d03515@linux.intel.com>

On Tue, 6 Jun 2023, Greg Kroah-Hartman wrote:

> On Tue, Jun 06, 2023 at 01:21:55PM +0300, Ilpo Järvinen wrote:
> > On Tue, 6 Jun 2023, Chen-Yu Tsai wrote:
> > 
> > > On Tue, Jun 6, 2023 at 5:36 PM AngeloGioacchino Del Regno
> > > <angelogioacchino.delregno@collabora.com> wrote:
> > > >
> > > > Il 06/06/23 11:17, Chen-Yu Tsai ha scritto:
> > > > > The 8250_mtk driver's runtime PM support has some issues:
> > > > >
> > > > > - The bus clock is enabled (through runtime PM callback) later than a
> > > > >    register write
> > > > > - runtime PM resume callback directly called in probe, but no
> > > > >    pm_runtime_set_active() call is present
> > > > > - UART PM function calls the callbacks directly, _and_ calls runtime
> > > > >    PM API
> > > > > - runtime PM callbacks try to do reference counting, adding yet another
> > > > >    count between runtime PM and clocks
> > > > >
> > > > > This fragile setup worked in a way, but broke recently with runtime PM
> > > > > support added to the serial core. The system would hang when the UART
> > > > > console was probed and brought up.
> > > > >
> > > > > Tony provided some potential fixes [1][2], though they were still a bit
> > > > > complicated. The 8250_dw driver, which the 8250_mtk driver might have
> > > > > been based on, has a similar structure but simpler runtime PM usage.
> > > > >
> > > > > Simplify clock sequencing and runtime PM support in the 8250_mtk driver.
> > > > > Specifically, the clock is acquired enabled and assumed to be active,
> > > > > unless toggled through runtime PM suspend/resume. Reference counting is
> > > > > removed and left to the runtime PM core. The serial pm function now
> > > > > only calls the runtime PM API.
> > > > >
> > > > > [1] https://lore.kernel.org/linux-serial/20230602092701.GP14287@atomide.com/
> > > > > [2] https://lore.kernel.org/linux-serial/20230605061511.GW14287@atomide.com/
> > > > >
> > > > > Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> > > > > Suggested-by: Tony Lindgren <tony@atomide.com>
> > > > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > >
> > > > You're both cleaning this up and solving a critical issue and I 
> > > > completely agree about doing that.
> > > >
> > > > I can imagine what actually fixes the driver, but still, is it 
> > > > possible to split this commit in two?
> > > > One that solves the issue, one that performs the much needed cleanups.
> > > >
> > > > If it's not possible, then we can leave this commit as it is... and if the problem
> > > > about splitting is the Fixes tag... well, we don't forcefully need it: after all,
> > > > issues started arising after runtime PM support for 8250 landed and before that the
> > > > driver technically worked, even though it was fragile.
> > > 
> > > The pure fix would look like what Tony posted [1]. However it would add stuff
> > > that isn't strictly needed after the cleanup. Doing it in one patch results
> > > in less churn. Think of it another way: it's a nice cleanup that just so
> > > happens to fix a regression.
> > > 
> > > As for the fixes tag, it's there so other people potentially doing backports
> > > of the 8250 runtime PM work can spot this followup fix.
> > 
> > Tony's patch is recent enough to not have progressed beyond tty-next so 
> > fixing it shouldn't really require paying that much attention to stable 
> > rules wrt. Fixes tag and minimality.
> > 
> > As the target currently is tty-next, a cleanup which also happens to fix 
> > the issue seems perfectly fine.
> 
> The Fixes: tag is relevant here, please don't dissuade people from using
> them.

Not including Fixes tag was definitely among the things I tried to 
say.

What I meant was that this patch, given the current time frame, 
likely gets included within the same "next cycle". So it fixes the issue 
even before the commit it fixes ends up into any rc not to speak of 
stables. As such, stable kernel rules don't seem relevant.

So creating a "fix patch" with extra stuff just for the sake of it and 
then removing the extra stuff away in the cleanup change seems unnecessary 
to me as the cleanup itself would fix the same issue. I'm not even sure if 
it's proper to call this change a cleanup, it just takes a different 
avenue to fix the problem by removing some complexity from old.

-- 
 i.
--8323329-1863769213-1686048085=:2339--
