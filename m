Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4090B6CCDD7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjC1XEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC1XEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:04:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20988268A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 16:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680044676; x=1711580676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pezn8xNxurkZBFxsQdb+ZWL+d/jfpSEsRx1iVibRi7M=;
  b=SeIpoXZ8GGzXPCbXXXDsGTU8sFlFFhqAILgQMyQmmoM/k1FT2QlCwB72
   DCT/v/sIIuVnloaQaipqoeQ8iqgj3aCbrXnPPoyohtV3jqOOLc0miqvA1
   lxk6pKEuUpZI3W5a7W3QhLRXLSXEvy1wjhVeuUf4u5Swv+co3Cec2Ck4d
   4let9r/UKl3qCjilZIzWCVyjoyt0OvKOyuJZJUG+t4Qcbs3Hvtxcfs68o
   Js1d8bj/8EkQvajyVKHZvfDsCYTG6nRyTngiiPuRvlzJDPXXTzgbbRWZ1
   5Uuh19p/XjASSAeRSM4ZelblVop7527RHmfE7A8VSP5x00gh2K6wSuLxM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="368486620"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="368486620"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 16:04:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="686603765"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="686603765"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.62.61])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 16:04:34 -0700
Date:   Tue, 28 Mar 2023 16:04:33 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        Dan Carpenter <error27@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: refactor arche_platform_wd_irq()
 function
Message-ID: <ZCNygZ8aPsElfTK6@aschofie-mobl2>
References: <ZCH6LV5XU0FBlW7Y@khadija-virtual-machine>
 <a64ad550-9991-4f54-8e09-735133422291@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a64ad550-9991-4f54-8e09-735133422291@kili.mountain>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:33:23AM +0300, Dan Carpenter wrote:
> On Tue, Mar 28, 2023 at 01:18:53AM +0500, Khadija Kamran wrote:
> > Refactor function by adding goto statement. This reduces the
> > indentation and fixes the issue reported by checkpatch.pl script.
> > 
> > "CHECK: line length of 101 exceeds 100 columns"
> > 
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> >  drivers/staging/greybus/arche-platform.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> > index fcbd5f71eff2..c7d3b6f7368f 100644
> > --- a/drivers/staging/greybus/arche-platform.c
> > +++ b/drivers/staging/greybus/arche-platform.c
> > @@ -178,11 +178,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> >  				 */
> >  				if (arche_pdata->wake_detect_state !=
> >  						WD_STATE_COLDBOOT_START) {
> > -					arche_platform_set_wake_detect_state(arche_pdata,
> > -									     WD_STATE_COLDBOOT_TRIG);
> > -					spin_unlock_irqrestore(&arche_pdata->wake_lock,
> > -							       flags);
> > -					return IRQ_WAKE_THREAD;
> > +					goto out;
> 
> I don't like this goto.
> 
> It suggests that calling arche_platform_set_wake_detect_state(arche_pdata, WD_STATE_COLDBOOT_TRIG);
> is a part of a shared exit path when that is not true so it is sort of
> lying to the reader and making things harder to understand.
> 
> Unlocking is shared.  goto unlock is fine.  But that doesn't help with
> the very long lines.  (I am not saying that goto unlock is a worthwhile
> patch to send but I would definitely have found it tolerable).
> 
> regards,
> dan carpenter


Khadija,
While you are reworking this, just wanted to note that, once 'out:'
becomes the single exit path for the function, it won't be a lie
any more. So you will have addressed Dan's concern.
Alison


> 
> >  				}
> >  			}
> >  		}
> > @@ -205,6 +201,11 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> >  	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
> >  
> >  	return IRQ_HANDLED;
> > +
> > +out:
> > +	arche_platform_set_wake_detect_state(arche_pdata, WD_STATE_COLDBOOT_TRIG);
> > +	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
> > +	return IRQ_WAKE_THREAD;
> >  }
> >  
> >  /*
> > -- 
> > 2.34.1
> > 
> 
