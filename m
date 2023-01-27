Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B02267E119
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjA0KKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjA0KKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:10:44 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC4B4B89E;
        Fri, 27 Jan 2023 02:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674814242; x=1706350242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qg/3JDFsC2nzbd86XepCeae+28Y0mZGY4eLCR4gfcsI=;
  b=EHmNzsNUXbZ20M83kZzhtWO/+kfcv+EgSdi4z+c/kHxxMUs3Py+XQZv9
   tU+nXiYTmyuo85p4su8bKJqJkhJyfZAgtnZU0S5vhflXJ9baT8RMjJo7/
   hD2ERE+pYOskdxLmbODtQxp/HKtNs6yIgQrmcDX8YzVCXNqLDRM1noyFy
   wpZw3sbZI6VMeIt+Q2wiR5eiaJ4hteXdCT23Ok7IlwTyvr+Qtdr/jLU6O
   16yZ6aZaRDYiWOokh2S0Qr2tORZDD3bv3cRVYNJzFqtkJS45KFIwqGZs4
   YNGNlnT5BFvkPsQt7Ap4p81G4mVw6KAeNkP5jgejseCfGfDlY4+Fcp8gJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="307403875"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="307403875"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 02:10:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="695462376"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="695462376"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2023 02:10:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLLgh-00FuQp-2J;
        Fri, 27 Jan 2023 12:10:27 +0200
Date:   Fri, 27 Jan 2023 12:10:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 08/11] driver core: fw_devlink: Make cycle detection
 more robust
Message-ID: <Y9OjE+bJquDcCpJ8@smile.fi.intel.com>
References: <20230127001141.407071-1-saravanak@google.com>
 <20230127001141.407071-9-saravanak@google.com>
 <Y9OcqGTocu8ZlFqy@smile.fi.intel.com>
 <CAMuHMdXRbiNW9nd_N_=+OTo-uCmy2ePfOmREEHcqLyEn1H=Rhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXRbiNW9nd_N_=+OTo-uCmy2ePfOmREEHcqLyEn1H=Rhg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 10:52:02AM +0100, Geert Uytterhoeven wrote:
> On Fri, Jan 27, 2023 at 10:43 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Jan 26, 2023 at 04:11:35PM -0800, Saravana Kannan wrote:
> > > + * Check if @sup_handle or any of its ancestors or suppliers direct/indirectly
> > > + * depend on @con.  This function can detect multiple cyles between @sup_handle
> >
> > A single space is enough.
> 
> It's very common to write two spaces after a full stop.
> When joining two sentences on separate lines in vim using SHIFT-J,
> vim will make sure there are two spaces.

But is this consistent with all kernel doc comments in the core.c?

I'm fine with either as long as it's consistent.

-- 
With Best Regards,
Andy Shevchenko


