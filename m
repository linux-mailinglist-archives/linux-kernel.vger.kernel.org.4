Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DF2723F45
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjFFKWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbjFFKWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:22:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79650E9;
        Tue,  6 Jun 2023 03:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686046922; x=1717582922;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=K73CgqDhV6+wYuuwO+L54HYNSyp1lD7d/wmA1mlNlZM=;
  b=OnEb6L/7k96T3eWZfQg51SJaEo6YPRYrJ9OlrDE+DAfyiXkGADvz216I
   AYdqIxqCSlnrnDglQbJqa4lKVL1UiN9jMWqMEiN90lmFW1ggsUYr28n/F
   wRADbusJBYKGDaQgTZRQ+DQgrLs8gNPUhLWKuXr7KqtO65N8TGqMqkvhM
   X9Pr2wZGdVfyilwzjesMpDDaEnN/gJyeZ358dryiHqhVIdxAfCTqFfi1u
   gDI/aRz0gJFyG6LZ7d0a4rekn1wwpH0RF0DY3dIsr6C1lPYAsgcmPG8rU
   qnbpB/squapkY1qz3wUbazzZW8xYZxKouzbUCy+oOCjm8kEGpN6ecxCfV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="443004663"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="443004663"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 03:22:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="709033551"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="709033551"
Received: from vkkalava-mobl1.amr.corp.intel.com ([10.249.42.194])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 03:21:58 -0700
Date:   Tue, 6 Jun 2023 13:21:55 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
In-Reply-To: <CAGXv+5GRBOWFMw+BmkSpczHcm_R6=mvL2GSKnWWyhpng1xw21w@mail.gmail.com>
Message-ID: <61ec34d0-6cc2-951e-c990-fdfd57381d7@linux.intel.com>
References: <20230606091747.2031168-1-wenst@chromium.org> <58949bbd-1506-90a0-7154-e6e57d8ddf70@collabora.com> <CAGXv+5GRBOWFMw+BmkSpczHcm_R6=mvL2GSKnWWyhpng1xw21w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1339228617-1686046822=:2339"
Content-ID: <2c863382-e720-b6b7-8c78-4cab41dcba20@linux.intel.com>
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

--8323329-1339228617-1686046822=:2339
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <b22da189-5993-cbb5-5c44-4a56a22022cf@linux.intel.com>

On Tue, 6 Jun 2023, Chen-Yu Tsai wrote:

> On Tue, Jun 6, 2023 at 5:36 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Il 06/06/23 11:17, Chen-Yu Tsai ha scritto:
> > > The 8250_mtk driver's runtime PM support has some issues:
> > >
> > > - The bus clock is enabled (through runtime PM callback) later than a
> > >    register write
> > > - runtime PM resume callback directly called in probe, but no
> > >    pm_runtime_set_active() call is present
> > > - UART PM function calls the callbacks directly, _and_ calls runtime
> > >    PM API
> > > - runtime PM callbacks try to do reference counting, adding yet another
> > >    count between runtime PM and clocks
> > >
> > > This fragile setup worked in a way, but broke recently with runtime PM
> > > support added to the serial core. The system would hang when the UART
> > > console was probed and brought up.
> > >
> > > Tony provided some potential fixes [1][2], though they were still a bit
> > > complicated. The 8250_dw driver, which the 8250_mtk driver might have
> > > been based on, has a similar structure but simpler runtime PM usage.
> > >
> > > Simplify clock sequencing and runtime PM support in the 8250_mtk driver.
> > > Specifically, the clock is acquired enabled and assumed to be active,
> > > unless toggled through runtime PM suspend/resume. Reference counting is
> > > removed and left to the runtime PM core. The serial pm function now
> > > only calls the runtime PM API.
> > >
> > > [1] https://lore.kernel.org/linux-serial/20230602092701.GP14287@atomide.com/
> > > [2] https://lore.kernel.org/linux-serial/20230605061511.GW14287@atomide.com/
> > >
> > > Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> > > Suggested-by: Tony Lindgren <tony@atomide.com>
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >
> > You're both cleaning this up and solving a critical issue and I 
> > completely agree about doing that.
> >
> > I can imagine what actually fixes the driver, but still, is it 
> > possible to split this commit in two?
> > One that solves the issue, one that performs the much needed cleanups.
> >
> > If it's not possible, then we can leave this commit as it is... and if the problem
> > about splitting is the Fixes tag... well, we don't forcefully need it: after all,
> > issues started arising after runtime PM support for 8250 landed and before that the
> > driver technically worked, even though it was fragile.
> 
> The pure fix would look like what Tony posted [1]. However it would add stuff
> that isn't strictly needed after the cleanup. Doing it in one patch results
> in less churn. Think of it another way: it's a nice cleanup that just so
> happens to fix a regression.
> 
> As for the fixes tag, it's there so other people potentially doing backports
> of the 8250 runtime PM work can spot this followup fix.

Tony's patch is recent enough to not have progressed beyond tty-next so 
fixing it shouldn't really require paying that much attention to stable 
rules wrt. Fixes tag and minimality.

As the target currently is tty-next, a cleanup which also happens to fix 
the issue seems perfectly fine.


-- 
 i.
--8323329-1339228617-1686046822=:2339--
