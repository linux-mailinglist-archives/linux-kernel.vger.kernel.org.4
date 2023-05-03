Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF786F611C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjECWQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjECWQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:16:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5072283DD
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 15:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683152183; x=1714688183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U2RkwWDWwvP3/HeZFRjgqWJRs2v9sGGHsRUT5S3DVmk=;
  b=Ov6ZSEopuNsrijxYm6m5ZV7+ov/68u6GyZ1SrASrQtKgj0qHst9yx3jt
   ddy5MTscZFYihre6T+KBdPBfE4v82sFoIsz6bt6hyF6ngvNID+dRi8WTb
   /RZ4JT0e+K8vuP5FdXFy0dYN01gfPHJkeqKX0WJLtzmMr3RbyOhMZSa0e
   KAbfQ+Uh5UUDP1k9Yh18CJlpm6U/YxNiHBfZ7a+FYMzqrAlTHT1PCb6EQ
   VvwnoQim57h6RYZjUkxW/w/nCRHlstpW51LVd5feFwBXHES52dQAXudru
   qF30pK9MUx769kHN85b8artJzdfEUa4NiSbNtVCMv37UjuHa4l1eZuurW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="376844634"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="376844634"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 15:16:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="786266224"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="786266224"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.181.38])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 15:16:22 -0700
Date:   Wed, 3 May 2023 15:16:20 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Dan Carpenter <error27@gmail.com>, outreachy@lists.linux.dev,
        hvaibhav.linux@gmail.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: greybus: refactor arche_platform_wd_irq()
Message-ID: <ZFLdNKJUo3RMbwiU@aschofie-mobl2>
References: <cover.1680185025.git.kamrankhadijadj@gmail.com>
 <96d04a4ff3d4a46293355f5afae3a8ece65f2c5b.1680185025.git.kamrankhadijadj@gmail.com>
 <6ce8aa34-e600-4d6a-adad-ead8255342e5@kili.mountain>
 <ZChs5jB7DMCUnVzr@khadija-virtual-machine>
 <9688d93f-5ece-4799-898d-98515a98f9be@kili.mountain>
 <ZEoV5/S3owfPVil7@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEoV5/S3owfPVil7@khadija-virtual-machine>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 11:27:51AM +0500, Khadija Kamran wrote:
> On Mon, Apr 03, 2023 at 07:29:36AM +0300, Dan Carpenter wrote:
> > On Sat, Apr 01, 2023 at 10:41:58PM +0500, Khadija Kamran wrote:
> > > On Thu, Mar 30, 2023 at 06:23:19PM +0300, Dan Carpenter wrote:
> > > > On Thu, Mar 30, 2023 at 07:11:25PM +0500, Khadija Kamran wrote:
> > > > > Linux kernel coding-style suggests to fix your program if it needs more
> > > > > than 3 levels of indentation. Due to indentation, line length also
> > > > > exceeds 100 columns, resulting in issues reported by checkpatch.
> > > > > 
> > > > > Refactor the arche_platform_wd_irq() function and reduce the indentation
> > > > > with the help of goto statement.
> > > > > 
> > > > > Suggested-by: Alison Schofield <alison.schofield@intel.com>
> > > > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > > > ---
> > > > >  drivers/staging/greybus/arche-platform.c | 79 ++++++++++++------------
> > > > >  1 file changed, 41 insertions(+), 38 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> > > > > index a64c1af091b0..dde30c8da1a1 100644
> > > > > --- a/drivers/staging/greybus/arche-platform.c
> > > > > +++ b/drivers/staging/greybus/arche-platform.c
> > > > > @@ -158,49 +158,52 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> > > > >  
> > > > >  	spin_lock_irqsave(&arche_pdata->wake_lock, flags);
> > > > >  
> > > > > -	if (gpiod_get_value(arche_pdata->wake_detect)) {
> > > > > -		/* wake/detect rising */
> > > > > +	if (!gpiod_get_value(arche_pdata->wake_detect))
> > > > > +		goto falling;
> > > > >  
> > > > > +	/* wake/detect rising */
> > > > > +
> > > > > +	/*
> > > > > +	 * If wake/detect line goes high after low, within less than
> > > > > +	 * 30msec, then standby boot sequence is initiated, which is not
> > > > > +	 * supported/implemented as of now. So ignore it.
> > > > > +	 */
> > > > > +	if (arche_pdata->wake_detect_state != WD_STATE_BOOT_INIT)
> > > > > +		goto out;
> > > > 
> > > > This checks that we are in WD_STATE_BOOT_INIT state.
> > > > 
> > > > > +
> > > > > +	if (time_before(jiffies,
> > > > > +			arche_pdata->wake_detect_start +
> > > > > +			msecs_to_jiffies(WD_COLDBOOT_PULSE_WIDTH_MS))) {
> > > > > +		arche_platform_set_wake_detect_state(arche_pdata,
> > > > > +						     WD_STATE_IDLE);
> > > > > +		got out;
> > > > > +	}
> > > > > +
> > > > > +	/* Check we are not in middle of irq thread already */
> > > > > +	if (arche_pdata->wake_detect_state !=
> > > > > +			WD_STATE_COLDBOOT_START) {
> > > > 
> > > > This checks that we are not in WD_STATE_COLDBOOT_START state.  How are
> > > > we going to be in COLDBOOT if we are in INIT?  Is this changing in the
> > > > background?  Can this check be removed?  This might be took tricky to
> > > > answer but it's important that we understand this before we continue.
> > > > 
> > > > 
> > > > > +		arche_platform_set_wake_detect_state(arche_pdata,
> > > > > +						     WD_STATE_COLDBOOT_TRIG);
> > > > > +		rc = IRQ_WAKE_THREAD;
> > > > > +		goto out;
> > > > > +	}
> > > > 
> > > > Let's assume the above check cannot be removed.
> > > > 
> > > > In the original code if gpiod_get_value(arche_pdata->wake_detect)
> > > > returned true and arche_pdata->wake_detect_state == WD_STATE_IDLE then
> > > > it just returned without doing anything, but now we fall through to the
> > > > falling: label below.
> > 
> > Let me show you in the original code:
> > 
> > STEP 1:	if (gpiod_get_value(arche_pdata->wake_detect)) {
> > 
> > Assume this condition is true.
> > 
> > STEP 2:		if (arche_pdata->wake_detect_state == WD_STATE_BOOT_INIT) {
> > 
> > Assume this condition is true.
> > 
> > STEP 3:		if (time_before(jiffies, ...)
> > 
> > Assume that time is up.
> > 
> > STEP 4:			if (arche_pdata->wake_detect_state !=
> > 					WD_STATE_COLDBOOT_START) {
> > 
> > Assume that it is equal.  We are done.  return IRQ_HANDLED;
> > 
> > Now in the new code:
> > 
> > STEP 1:	if (!gpiod_get_value(arche_pdata->wake_detect))
> > 		goto falling;
> > 
> > Assume we don't goto falling.
> > 
> > STEP 2:	if (arche_pdata->wake_detect_state != WD_STATE_BOOT_INIT)
> > 
> > Assume that it == WD_STATE_BOOT_INIT.
> > 
> > STEP 3:	if (time_before(jiffies, ...)
> > 
> > Assume that time is up.
> > 
> > STEP 4:	if (arche_pdata->wake_detect_state != WD_STATE_COLDBOOT_START) {
> > 
> > Assume that it is equal.  Before, in the old code it would return
> > return IRQ_HANDLED; at this point.  But now it does:
> > 
> > STEP 5:	if (arche_pdata->wake_detect_state == WD_STATE_IDLE) {
> > 
> > Which seems like it's a contradictory condition with STEP 4 so it's
> > probably impossible.  But on the other hand, we have already checked
> > contradictory conditions between STEP 2 and STEP 4 so who knows what's
> > going on?
> 
> 
> Hey Dan!
> 
> Sorry about the delay in the reply. I want to continue working on the
> completion of this thread. 
> 
> Thank you for the above steps, they clearly explain the problem you
> addressed in the new code. Can't this problem be resolved by "goto out;"
> right above the 'falling:' label?
> 
> I'm copy pasting your mail here,
> 
> On Mon, Apr 03, 2023 at 07:29:36AM +0300, Dan Carpenter wrote:
> > > > This checks that we are not in WD_STATE_COLDBOOT_START state.  How are
> > > > we going to be in COLDBOOT if we are in INIT?  Is this changing in the
> > > > background?  Can this check be removed?
> 
> > It turned out the answer was yes, it can be removed.
> 
> > > Also if stuff is changing in the background and there is no way the
> > > locking is correct.
> 
> > The locking is correct.  Take a look at it.
> 
> > We are holding the &arche_pdata->wake_lock in arche_platform_wd_irq()
> > and every place that calls arche_platform_set_wake_detect_state() takes
> > that lock first.  So it can't change in the background.
> 
> > Delete the check like so.
> 
> If we delete the check then the indentation problem would be
> automatically addressed. Also, there would be a single exit path to the
> function. Should I send a patch or is there anything else that should be
> addressed. 

Hi Khadija,

Thanks for picking this up again. I suggest posting an updated version
and let folks take a look at it again. It's a bit stale in my mind now,
but I'm happy to iterate on it with you further.

Thanks,
Alison

> 
> Thank you!
> 
> Regards,
> Khadija
> 
> > 
> > This function is very hard to understand.
> > 
> > Also if stuff is changing in the background and there is no way the
> > locking is correct.
> > 
> > regards,
> > dan carpenter
> 
