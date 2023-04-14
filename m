Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082296E1F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjDNJkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDNJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:40:38 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A67721BD0;
        Fri, 14 Apr 2023 02:40:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8D20980A6;
        Fri, 14 Apr 2023 09:40:36 +0000 (UTC)
Date:   Fri, 14 Apr 2023 12:40:35 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Clear port->pm on port specific driver
 unbind
Message-ID: <20230414094035.GF36234@atomide.com>
References: <20230413070342.36155-1-tony@atomide.com>
 <ZDgoi2mFYYqswAhu@smile.fi.intel.com>
 <20230414054726.GE36234@atomide.com>
 <63b333cb-13c7-db58-9cf-697aa1c4c48a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63b333cb-13c7-db58-9cf-697aa1c4c48a@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [230414 07:36]:
> On Fri, 14 Apr 2023, Tony Lindgren wrote:
> 
> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [230413 16:06]:
> > > On Thu, Apr 13, 2023 at 10:03:41AM +0300, Tony Lindgren wrote:
> > > > Let's fix the issue by clearing port->pm in serial8250_unregister_port().
> > > 
> > > Sounds to me like a fix that needs a Fixes tag.
> > 
> > Maybe commit c161afe9759d ("8250: allow platforms to override PM hook.").
> > 
> > That's a bit unclear though as the hardware specific functions were
> > available at that point as they were passed in platform data. This can
> > be seen with git blame c161afe9759d drivers/serial/8250.c. To me it seems
> > the port->pm became potentially invalid if a serial port device driver
> > started implementing PM runtime?
> > 
> > Maybe just tagging it with Cc: stable is better if no obvious Fixes tag
> > can be figured out.
> 
> I'd just put that c161afe9759d there. It seems quite harmless even if it 
> would be unnecessary before some driver commit which is much harder to 
> pinpoint (and it would likely turn out old enough to not matter anyway 
> for the kernels stable cares about).

OK works for me.

I'm now wondering still if we should clear all the conditional hardware
specific functions too in addition to port->pm that get set in
serial8250_register_8250_port(). Maybe best done in a separate patch
as needed.. Any suggestions?

> I forgot to give this earlier:
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks,

Tony
