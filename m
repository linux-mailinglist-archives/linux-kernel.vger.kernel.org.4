Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580296B99FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjCNPlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjCNPkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:40:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13D8B0497;
        Tue, 14 Mar 2023 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678808411; x=1710344411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UzlMpAtk/JrMVON44CzIZ5oumEcd7fiM8bADp/UkciU=;
  b=G7htEcSkcf0up18llbo+yt7WnKc3pJAsiWoJourZz2JhjYYoFBwjpCuR
   vM0N6q0iwHTufL1/fkqC6YY+JzAvEe1csWo9qSmzA3QQli6g6Z1WELaH5
   wvnNEfgCBH9vRVzoZXZWOeVMvBfqToPj/gTtb1weqc4NULTXFXat12HjT
   Nrad7c0wOXZi0el4YhNcYQ2twI/oTAEokDS0MqbM8uPrN49kVOZR57exo
   jMDVzHRIeYLMdvoSrL46Rp+KN/rZFxvHR/cqznCk6mEy/CAljdPsnuNnv
   INwwSauLmFqavz4OexSe9ZYb2qWGPO9e6smsgWaOFW76SfWrL/wGKI1h/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="423735657"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="423735657"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 08:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="679151163"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="679151163"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 14 Mar 2023 08:38:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pc6jT-003IHX-1s;
        Tue, 14 Mar 2023 17:38:35 +0200
Date:   Tue, 14 Mar 2023 17:38:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v7 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <ZBCU+8MpTCWAfJLG@smile.fi.intel.com>
References: <20230314073603.42279-1-tony@atomide.com>
 <ZBB1h12WHIGo4NX8@smile.fi.intel.com>
 <20230314133810.GM7501@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314133810.GM7501@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 03:38:10PM +0200, Tony Lindgren wrote:
> * Andy Shevchenko <andriy.shevchenko@intel.com> [230314 13:25]:
> > On Tue, Mar 14, 2023 at 09:35:59AM +0200, Tony Lindgren wrote:

...

> > > +	/* Increment the runtime PM usage count for the active check below */
> > > +	err = pm_runtime_get(port_dev);
> > 
> > The question here is why don't we need to actually turn on the device immediately
> > (sync) if it's not already powered?

> Doing it would require the use of pm_runtime_irq_safe() at least currently.

> > > +	if (err < 0) {
> > > +		pm_runtime_put_noidle(port_dev);
> > > +		return;
> > > +	}
> > 
> > > +	/*
> > > +	 * Start TX if enabled, and kick runtime PM. Otherwise we must
> > > +	 * wait for a retry. See also serial_port.c for runtime PM
> > > +	 * autosuspend timeout.
> > > +	 */
> > 
> > I.o.w. does the start_tx() require device to be powered on at this point?
> 
> Yes. And if the device is not enabled, serial_port.c runtime_resume()
> calls this function again after the hardware is enabled.

Ah, that makes sense.

> > > +	if (pm_runtime_active(port_dev))
> > >  		port->ops->start_tx(port);
> > > +	pm_runtime_mark_last_busy(port_dev);
> > > +	pm_runtime_put_autosuspend(port_dev);
> 
> For your other comments, I'll take a look thanks.

-- 
With Best Regards,
Andy Shevchenko


