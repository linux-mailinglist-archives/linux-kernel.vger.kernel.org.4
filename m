Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5A2604F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiJSSQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiJSSQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:16:38 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CE91799BB;
        Wed, 19 Oct 2022 11:16:35 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5F88020005;
        Wed, 19 Oct 2022 18:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666203394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9SDWbLBkb/h2sQPqeuUH/CeGmpjRZuE4XaooJvwlTqQ=;
        b=mSJAK7UgQ6gh0kM2LZK4QHHLJntPqC61BSWtE6HmBI8bHOZYTTnOkrAKOzkBG6d8G67CNB
        oTTOYFtfD993Edlybr9g/1Rwv09h4M3nwigG0Tk/8E6kwlxxp1hbPAyBh8Y9pTpwNycaCH
        rO1ROfohQ52fQLm7rCo71VfIIZrzpDBfZZKbYXe/YA0j9+EoHOW+AwzhFhkoF2oxpLBlPk
        uQH4xQvV+mBJdpzh/PVYFseOE21x2RJngkkSlwi5Gv36IsV5YBuEV2Z3eBFBwYUFBBivSS
        iEt0StNpXgZ69YfchI2L7aV4fOYT9NU7GL+YcRjRFBIwuCv17v8VCejfpoJnsQ==
Date:   Wed, 19 Oct 2022 20:16:33 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: rtc-cmos: Fix wake alarm breakage
Message-ID: <Y1A/AZmfTI6hr3RZ@mail.local>
References: <5887691.lOV4Wx5bFT@kreacher>
 <166611112152.2353171.9661532286339710942.b4-ty@bootlin.com>
 <CAJZ5v0jh9g8fKAoymwv1UeUqtX7EcU3JkgMHsQWZSHngyQUFQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jh9g8fKAoymwv1UeUqtX7EcU3JkgMHsQWZSHngyQUFQg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 18:13:43+0200, Rafael J. Wysocki wrote:
> On Tue, Oct 18, 2022 at 6:39 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > On Tue, 18 Oct 2022 18:09:31 +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Commit 4919d3eb2ec0 ("rtc: cmos: Fix event handler registration
> > > ordering issue") overlooked the fact that cmos_do_probe() depended
> > > on the preparations carried out by cmos_wake_setup() and the wake
> > > alarm stopped working after the ordering of them had been changed.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/1] rtc: rtc-cmos: Fix wake alarm breakage
> >       commit: 0782b66ed2fbb035dda76111df0954515e417b24
> 
> Thank you!
> 
> However, there is a build fix on top of this which has just been posted:
> 
> https://lore.kernel.org/linux-acpi/2677035.mvXUDI8C0e@kreacher/
> 
> Sorry about breaking it again.

I had that in rtc-fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?h=rtc-fixes


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
