Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A964162DFED
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiKQPeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiKQPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:34:03 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CA815FF4;
        Thu, 17 Nov 2022 07:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668699242; x=1700235242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fkCAycRFwGIy50cHuUdedfLvL366rnmiKrb/go8o+Dc=;
  b=PCFnigxqvqaYm6cLXUvcrSJDIb+tFKciZvoGE5mjA6HeIKXDlaoDolhy
   atOwVswOig1bO3VRHVoIUE3QiKNstNv/iYptysesH5rA0Y1C+mWIfLGKf
   xrIru7BrEhZStmVqPcfN+Gy+9o1WOEfSYc58s9bxcuOmm470W4SdxH1R2
   uxdahsI20ji0MwLFiWLl9lIW8eqqeyHhLq9tdKTVrBIQ0Abic7Umz4FFQ
   +Q9na0Trcvln08zbTHUJwj3wiw9/XX1PaJWlEMoRIS6Dwhat6Pc1FyQew
   AnNRJw5gH37xOLrQtbdzi/o2MZHbepmtzhl0blMCyhgqcPZyhOsql5ycZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="377146610"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="377146610"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 07:33:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="814551644"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="814551644"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2022 07:33:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovgtT-00DcyZ-0v;
        Thu, 17 Nov 2022 17:33:35 +0200
Date:   Thu, 17 Nov 2022 17:33:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/4] pwm: Reduce time the pwm_lock mutex is held in
 pwmchip_add()
Message-ID: <Y3ZUT3SNmfInzEv9@smile.fi.intel.com>
References: <20221115211515.3750209-1-u.kleine-koenig@pengutronix.de>
 <20221115211515.3750209-3-u.kleine-koenig@pengutronix.de>
 <Y3SbNM8H3QxY0XF2@smile.fi.intel.com>
 <20221117140024.o77f5prewt5clgyh@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117140024.o77f5prewt5clgyh@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 03:00:24PM +0100, Uwe Kleine-König wrote:
> On Wed, Nov 16, 2022 at 10:11:32AM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 15, 2022 at 10:15:13PM +0100, Uwe Kleine-König wrote:
> > > This simplifies error handling as the need for goto error handling goes
> > > away and at the end of the function the code can be simplified as this
> > > code isn't used in the error case any more.

...

> > > +	mutex_unlock(&pwm_lock);
> > >  
> > >  	if (IS_ENABLED(CONFIG_OF))
> > >  		of_pwmchip_add(chip);
> > 
> > Why calling this without a lock is not a problem? Commit message doesn't share
> > a bit about this change.
> 
> Maybe add another paragraph at the end reading:
> 
> Now memory allocation and the call to of_pwmchip_add() are done without
> holding the lock. Both don't access the data structures protected by
> &pwm_lock.

Good to me, with that added
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


