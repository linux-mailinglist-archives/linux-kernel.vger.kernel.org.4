Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32FF646DA4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiLHKzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiLHKzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:55:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25FF83244;
        Thu,  8 Dec 2022 02:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670496537; x=1702032537;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6Lc8UH5jmbeum+UYKXkdmWfy6L1eJ0Ew3kz09+x4P4g=;
  b=EYcs0ciPdPhqzkpi4nKMwDJKMZqLyekX+LLYLJZgA/+LyKK4UEp/LQku
   9/k8fH/+uOjNduF+X0NJ1FsfKUXEOmruVUe7ejBXSta00omPXBHFM62gS
   jeZ1DhS0KFFvy1DjEdyFTQLHCwsoPjK8ISRuPdVJX+O27SVJqa3CYOrIY
   hqaCnlq8QUQ65j3BMqBuGcuaSH18+McKdo6kvuEvfVZcvgW1cRIvQdMzt
   m4YIngQQD3uUz672gt6X3f5rRG6AvRl8amI5Z+TDefI58M3nXR0I7R26r
   fBfsB1UTz14ke2pImObUpgVCWAt+82zEux44VP/5r/msseOZ0tPnrXB/d
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="315856841"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="315856841"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 02:48:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="640584949"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="640584949"
Received: from pors-mobl3.ger.corp.intel.com ([10.252.39.224])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 02:48:53 -0800
Date:   Thu, 8 Dec 2022 12:48:47 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
In-Reply-To: <Y5G5Udw6FAEFdAYi@atomide.com>
Message-ID: <3c87186b-336f-6884-a2c-6ee3c9d70@linux.intel.com>
References: <20221207124305.49943-1-tony@atomide.com> <7f105ff9-cdc3-f98e-2557-812361faa94@linux.intel.com> <Y5G5Udw6FAEFdAYi@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1480847773-1670496537=:1682"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1480847773-1670496537=:1682
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 8 Dec 2022, Tony Lindgren wrote:

> * Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [221208 09:12]:
> > On Wed, 7 Dec 2022, Tony Lindgren wrote:
> > > +	ret = serial_core_add_one_port(drv, port);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	mutex_lock(&port_mutex);
> > > +
> > > +	/* Inititalize a serial core controller device if needed */
> > > +	ctrl_dev = serial_core_ctrl_find(drv, port->dev, port->ctrl_id);
> > > +	if (!ctrl_dev) {
> > > +		ctrl_dev = serial_core_ctrl_device_add(port);
> > > +		if (!ctrl_dev)
> > > +			goto err_remove_port;
> > > +		allocated = true;
> > > +	}
> > > +
> > > +	/* Initialize a serial core port device */
> > > +	ret = serial_core_port_device_add(ctrl_dev, port);
> > 
> > How is ->port_dev supposed to work here?
> > 
> > ->port_dev is not set until in serial_core_port_device_add() but you made
> > serial_core_add_one_port() call before that.
> 
> Hmm do you mean you want to call serial_core_add_one_port() later after
> serial_core_port_device_add()?
> 
> Or are you seeing some uninitialized use of port->port_dev (and not
> port->dev)?

With the other patch on top of this, yes, I did see uninitialized 
port->port_dev already in serial_core_add_one_port()->uart_configure_port().
While that could be solved by removing the pm_runtime_*() calls from 
there, I think it's a generic problem because after 
serial_core_add_one_port() the port can have anything happening on it, no?


-- 
 i.

--8323329-1480847773-1670496537=:1682--
