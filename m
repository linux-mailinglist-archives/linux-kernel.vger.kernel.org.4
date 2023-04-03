Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523F26D3C04
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 05:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjDCDHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 23:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCDHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 23:07:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB1C65A9
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 20:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680491250; x=1712027250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GcmrPwQweEDsU0TZJLAO5H0U9qjIpMTqPTXgYTBWRRs=;
  b=c5b65u6b/Vnd0WzclWStUas/ZZC79q639p4Q8uKXCVBe/fYDYtCeBKsm
   upBKxcLRSJ8dMkZHjbiBDAQDW9690tRgNYDzIzjlCfd1jOSfllsBz5T74
   opNlstFXcp558lkdpl+5Xg41QpSoipj6XMu2WXDA7S5hBJ3ZqDG2iHW08
   nvvin+2ubfwVgUZT3WUFw165rnyA6kEwjyjVCLSXYg4LORy/hmSxszjgt
   pahcech2BAMnAQ6hq0RHl4yziP/TF4Yl+MW85rL5lrNrNEGZ1Cy9lcALs
   TppoJZ5yTgEXPuEOnJTIPQOGO9V89GOmtQxTaV/tT9LdKAjXJFI9krZHr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="428084309"
X-IronPort-AV: E=Sophos;i="5.98,313,1673942400"; 
   d="scan'208";a="428084309"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 20:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="663048941"
X-IronPort-AV: E=Sophos;i="5.98,313,1673942400"; 
   d="scan'208";a="663048941"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.19.220])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 20:07:29 -0700
Date:   Sun, 2 Apr 2023 20:07:27 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, outreachy@lists.linux.dev,
        hvaibhav.linux@gmail.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: greybus: add a single exit path to
 arche_platform_wd_irq()
Message-ID: <ZCpC7wpDsUFZVWkQ@aschofie-mobl2>
References: <cover.1680185025.git.kamrankhadijadj@gmail.com>
 <e670baa9bde47a3bdb02e59ec37a438a62c52dd1.1680185025.git.kamrankhadijadj@gmail.com>
 <642a1fdcb2648_394c3829469@iweiny-mobl.notmuch>
 <ZCoqMSy1Ary0sAp9@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCoqMSy1Ary0sAp9@khadija-virtual-machine>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 06:21:53AM +0500, Khadija Kamran wrote:
> On Sun, Apr 02, 2023 at 05:37:48PM -0700, Ira Weiny wrote:
> > Khadija Kamran wrote:
> > > arche_platform_wd_irq() function has two exit paths. To make the code
> > > more readable, use only one exit path.
> > > 
> > > Suggested-by: Alison Schofield <alison.schofield@intel.com>
> > 
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> >
> 
> Okay, noted.
> 
> Also, would it be okay to send a patch revision with the changes or
> should I wait for the feedback on Dan's comment. Here is a link to it:
> https://lore.kernel.org/outreachy/6ce8aa34-e600-4d6a-adad-ead8255342e5@kili.mountain/

Khadija,

It's customary to wait for folks to respond to your follow ups, and
address  all the current feedback before sending out a new revision.

Ira asked a question about using positive instead of negative logic.
I probably steered you down the negative logic path, perhaps it can
be flipped to a more preferable positive logic. 

Alison



> 
> Thank you!
> Regards,
> Khadija 
> 
> > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > ---
> > >  drivers/staging/greybus/arche-platform.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> > > index fcbd5f71eff2..a64c1af091b0 100644
> > > --- a/drivers/staging/greybus/arche-platform.c
> > > +++ b/drivers/staging/greybus/arche-platform.c
> > > @@ -153,6 +153,7 @@ static irqreturn_t arche_platform_wd_irq_thread(int irq, void *devid)
> > >  static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> > >  {
> > >  	struct arche_platform_drvdata *arche_pdata = devid;
> > > +	irqreturn_t rc = IRQ_HANDLED;
> > >  	unsigned long flags;
> > >  
> > >  	spin_lock_irqsave(&arche_pdata->wake_lock, flags);
> > > @@ -180,9 +181,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> > >  						WD_STATE_COLDBOOT_START) {
> > >  					arche_platform_set_wake_detect_state(arche_pdata,
> > >  									     WD_STATE_COLDBOOT_TRIG);
> > > -					spin_unlock_irqrestore(&arche_pdata->wake_lock,
> > > -							       flags);
> > > -					return IRQ_WAKE_THREAD;
> > > +					rc = IRQ_WAKE_THREAD;
> > >  				}
> > >  			}
> > >  		}
> > > @@ -204,7 +203,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> > >  
> > >  	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
> > >  
> > > -	return IRQ_HANDLED;
> > > +	return rc;
> > >  }
> > >  
> > >  /*
> > > -- 
> > > 2.34.1
> > > 
> > > 
> > 
> > 
