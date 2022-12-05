Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A70F642818
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiLEMIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiLEMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:08:39 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD70C19022;
        Mon,  5 Dec 2022 04:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670242117; x=1701778117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uJDU9m043EcXQE54s0k8c5YvgSAGF8dwhqSdHctP7KA=;
  b=nXk61bxbevVx+SIggjzDRSfk6Sqi5i1e7XgdXGOj+Wr6kd6IcZOLBG8C
   sHUifjlpgZmAdV9p3DAozL1JAiUDIcnJHJC0TenusQpgH6J0eyx7tQVw7
   XCXrPDHhy6AUQ3W3v/vRgQvE6wHAVD7Dh/amh1YUbX6Anq/DNARl3IJur
   LnzGC4KqGPPFCRhMvInd7SRC5rAK+Ql6zL0YKgSPJ1cuZc5afkjuV7wiH
   z/TdjhEjxcq3cuiw6+qZWjQD543HTNG2f629EmPqG2SwerdWdNkgnHzXm
   vAjSPI/8gAzX1VpDv0BaDwR2uVv9UYDeW3kH7FfjJhO0ixCpxRKqc+53T
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="296028414"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="296028414"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 04:08:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="645796618"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="645796618"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 05 Dec 2022 04:08:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p2AGv-004rL6-04;
        Mon, 05 Dec 2022 14:08:33 +0200
Date:   Mon, 5 Dec 2022 14:08:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 2/3] Documentation: gpio: Add a section on what to
 return in ->get() callback
Message-ID: <Y43fQFBcPgKtuKRZ@smile.fi.intel.com>
References: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
 <20221130155519.20362-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdaQWZE6=BNEh5hSH9=jBK=TcLoD1uUb=JyNYmHFvaSAfg@mail.gmail.com>
 <Y41MxPthLjitvzEl@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y41MxPthLjitvzEl@sol>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 09:43:32AM +0800, Kent Gibson wrote:
> On Sat, Dec 03, 2022 at 10:38:45AM +0100, Linus Walleij wrote:
> > On Wed, Nov 30, 2022 at 4:55 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > +The below table gathered the most used cases.
> > > +
> > > +==========  ==========  ===============  =======================
> > > +  Input       Output         State        What value to return?
> > > +==========  ==========  ===============  =======================
> > > + Disabled    Disabled    Hi-Z             input buffer
> > > + Disabled    OS/OD/etc   Single ended     [cached] output buffer
> > > +    x        Push-Pull   Out              [cached] output buffer
> > > + Enabled     Disabled    In               input buffer
> > > + Enabled     OS/OD/etc   Bidirectional    input buffer
> > > +==========  ==========  ===============  =======================
> > 
> > This looks about right to me, but we need more input, Kent?
> > 
> 
> Firstly, I'm all for tightening up the driver contract, and hope that
> whatever is decided will also be updated in driver.h itself.
> 
> I can also understand Andy wanting to add support for Bidirectional
> using the existing API.
> 
> But, and please correct me if I'm wrong, the user has no control over
> whether an open drain output is single ended or bidirectional, and
> no visibility as to which the driver supports or chooses.
> So the contract is still vague.
> 
> My preference would be for the driver API to be extended with a new
> callback for the output buffer, say get_output(), and have the existing
> get() always return the input buffer.  Both would return an error if the
> buffer is unavailable or disconnected, e.g. in the Hi-Z case.
> As per Hans' suggestions, this would keep the drivers simple.

That's not about keeping driver simple, it's about how from hardware
(electrical) point of view we should recognize the GPIO signal value.
And I disagree on the input buffer to be always involved (in particular,
not all hardware may support that anyway). That said, I will send an answer
to all you guys, but just to make sure that we are on the different pages
here I state yet another time that this is not about solely software p.o.v.
And yes, there is no simple answer to the question.

> Then cdev could determine the approriate buffer to return, depending
> on the mode.  Or, better yet, we extend that through the uAPI and
> handball that decision to the user.

TL;DR: I don't like this idea.

-- 
With Best Regards,
Andy Shevchenko


