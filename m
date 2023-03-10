Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AAA6B36DE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 07:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCJGwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 01:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjCJGwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 01:52:04 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 858E9F34D6;
        Thu,  9 Mar 2023 22:51:42 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A623780F5;
        Fri, 10 Mar 2023 06:51:41 +0000 (UTC)
Date:   Fri, 10 Mar 2023 08:51:40 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230310065140.GI7501@atomide.com>
References: <20230309085713.57700-1-tony@atomide.com>
 <ZAnPrwLUA/1Bsq26@smile.fi.intel.com>
 <20230309130700.GH7501@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309130700.GH7501@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [230309 13:07]:
> * Andy Shevchenko <andriy.shevchenko@intel.com> [230309 12:23]:
> > On Thu, Mar 09, 2023 at 10:57:08AM +0200, Tony Lindgren wrote:
> > > +	err = pm_runtime_get(port_dev);
> > 
> > Is not sync API a deliberate choice? Do we need to comment on why is so?
> 
> I don't think it can be sync version.. See where all __uart_start() may
> get called from. The pm_runtime_get() here is needed so the check for
> pm_runtime_active() won't be racy. Maybe we can now leave out the
> "start TX anyways" part though.

To clarify, the reason we no longer need the check for "start TX anyways"
is we now do pm_runtime_get() on the new port_dev. Earlier we tried to do
it on the physical serial port driver dev where runtime PM possibly was
not enabled.

Regards,

Tony
