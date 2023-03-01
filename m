Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A20D6A7084
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjCAQGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAQGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:06:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A7A3B3E3;
        Wed,  1 Mar 2023 08:06:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEF93613CA;
        Wed,  1 Mar 2023 16:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E0AC433D2;
        Wed,  1 Mar 2023 16:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677686774;
        bh=VdvYhAdKqjudnNo3k4LLMHDxSQaTIboINwfNTYdczfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFD6ZOs/O2Om7uKjYI/N8I4MtDDeajQQnIaYWE/ctLqX5tQbz+SmuJVInP2qEYlu8
         0GJYYE5uKJjULV2P9m9AD3zJzMsjSIN8uqEATx/s6+efSB7RkXXxP5xPyegh1Mc43j
         AZcE0+wx5hKZ5JJRW9EOOQda3phVks22ULFPim8qednJrS819ys8yPTG4NwTw/roc6
         oJ01iL+oxefCYm7c4MC8U99jAUkAN+9mSq6wOfLxBrkjJTuQmUO3+sB8Wdw0x8AR8F
         tAQZXLFZ0tRV19m7oO4Mz02y5MoAptNLwo5EGqUrCAu9ZjrDFsWUB36SSvbzz3mERw
         zxZv2veB4oSbQ==
Date:   Wed, 1 Mar 2023 16:06:09 +0000
From:   Lee Jones <lee@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Henning Schild <henning.schild@siemens.com>,
        Pavel Machek <pavel@ucw.cz>, Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/3] leds: simatic-ipc-leds-gpio: split up into multiple
 drivers
Message-ID: <Y/938WpvjQ3HEOwD@google.com>
References: <20230221122414.24874-1-henning.schild@siemens.com>
 <20230221122414.24874-3-henning.schild@siemens.com>
 <Y/TMR0GBUr69KiQ5@smile.fi.intel.com>
 <20230221154354.290ae938@md1za8fc.ad001.siemens.net>
 <Y/TaftuNMABevCWV@smile.fi.intel.com>
 <bf678bc5-9615-31a3-3039-5d013f9c9f25@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf678bc5-9615-31a3-3039-5d013f9c9f25@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2023, Hans de Goede wrote:

> Hi,
> 
> On 2/21/23 15:51, Andy Shevchenko wrote:
> > On Tue, Feb 21, 2023 at 03:43:54PM +0100, Henning Schild wrote:
> >> Am Tue, 21 Feb 2023 15:51:03 +0200
> >> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> >>> On Tue, Feb 21, 2023 at 01:24:13PM +0100, Henning Schild wrote:
> >>>> In order to clearly describe the dependencies between the gpio  
> > 
> > ...
> > 
> >>>> +#ifndef __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO
> >>>> +#define __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO  
> >>>
> >>>> +#endif /* __DRIVERS_LEDS_SIMPLE_SIMATIC_IPC_LEDS_GPIO */  
> >>>
> >>> This header doesn't look right.
> >>>
> >>> Have you run `make W=1 ...` against your patches?
> >>
> >> No reports.
> >>
> >>> Even if it doesn't show defined but unused errors
> >>> the idea is that this should be a C-file, called,
> >>> let's say, ...-core.c.
> >>
> >> When i started i kind of had a -common.c in mind as well. But then the
> >> header idea came and i gave it a try, expecting questions in the review.
> >>
> >> It might be a bit unconventional but it seems to do the trick pretty
> >> well. Do you see a concrete problem or a violation of a rule?
> > 
> > Exactly as described above. The header approach means that *all* static
> > definitions must be used by each user of that file. Otherwise you will
> > get "defined but not used" compiler warning.
> > 
> > And approach itself is considered (at least by me) as a hackish way to
> > achieve what usually should be done via C-file.
> > 
> > So, if maintainers are okay, I wouldn't have objections, but again
> > I do not think it's a correct approach.
> 
> I agree with Andy here, please add a -common.o file with a shared
> probe() helper which gets the 2 different gpiod_lookup_table-s
> as parameter and then put the actual probe() function calling
> the helper inside the 2 different .c files.

Thanks for your reviews guys, I really appreciate the help.

-- 
Lee Jones [李琼斯]
