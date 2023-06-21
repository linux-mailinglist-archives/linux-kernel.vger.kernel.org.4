Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B996738C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjFUQw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFUQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:52:55 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF22E9;
        Wed, 21 Jun 2023 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=6WA3GXEESmxypvEyfFrL5uv4yC5/yc2PeWiHyP0/kFg=; b=jAR7VSWfsOiZvPQRWvfZ2NZjiN
        u8ceeRk9ZsuwLMn8AlYC16evp29iYpzUudOF2rR7oo3CoOh8zWOqvZG3DjtQNIYhFAW1zHzuRA64i
        gX6Kh0SKw1KNU3J/dr5DyzRnlVR4WWysO8U1/IS/P5ISI66I9bNN7tjCYnXCBsRK926o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qC148-00HAOG-F0; Wed, 21 Jun 2023 18:52:20 +0200
Date:   Wed, 21 Jun 2023 18:52:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Evan Quan <evan.quan@amd.com>, rafael@kernel.org,
        lenb@kernel.org, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mdaenzer@redhat.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        hdegoede@redhat.com, jingyuwang_vip@163.com, lijo.lazar@amd.com,
        jim.cromie@gmail.com, bellosilicio@gmail.com,
        andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH V4 1/8] drivers/acpi: Add support for Wifi band RF
 mitigations
Message-ID: <36902dda-9e51-41b3-b5fc-c641edf6f1fb@lunn.ch>
References: <20230621054603.1262299-1-evan.quan@amd.com>
 <20230621054603.1262299-2-evan.quan@amd.com>
 <3a7c8ffa-de43-4795-ae76-5cd9b00c52b5@lunn.ch>
 <216f3c5aa1299100a0009ddf4e95b019855a32be.camel@sipsolutions.net>
 <b1abec47-04df-4481-d680-43c5ff3cbb48@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1abec47-04df-4481-d680-43c5ff3cbb48@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:15:00AM -0500, Limonciello, Mario wrote:
> 
> On 6/21/2023 10:39 AM, Johannes Berg wrote:
> > On Wed, 2023-06-21 at 17:36 +0200, Andrew Lunn wrote:
> > > On Wed, Jun 21, 2023 at 01:45:56PM +0800, Evan Quan wrote:
> > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > 
> > > > Due to electrical and mechanical constraints in certain platform designs
> > > > there may be likely interference of relatively high-powered harmonics of
> > > > the (G-)DDR memory clocks with local radio module frequency bands used
> > > > by Wifi 6/6e/7.
> > > > 
> > > > To mitigate this, AMD has introduced an ACPI based mechanism that
> > > > devices can use to notify active use of particular frequencies so
> > > > that devices can make relative internal adjustments as necessary
> > > > to avoid this resonance.
> > > Do only ACPI based systems have:
> > > 
> > >     interference of relatively high-powered harmonics of the (G-)DDR
> > >     memory clocks with local radio module frequency bands used by
> > >     Wifi 6/6e/7."
> > > 
> > > Could Device Tree based systems not experience this problem?
> > They could, of course, but they'd need some other driver to change
> > _something_ in the system? I don't even know what this is doing
> > precisely under the hood in the ACPI BIOS, perhaps it adjusts the DDR
> > memory clock frequency in response to WiFi using a frequency that will
> > cause interference with harmonics.
> 
> The way that WBRF has been architected, it's intended to be able
> to scale to any type of device pair that has harmonic issues.

So you set out to make something generic...

> In the first use (Wifi 6e + specific AMD dGPUs) that matches this
> series BIOS has the following purposes:
> 
> 1) The existence of _DSM indicates that the system may not have
> adequate shielding and should be using these mitigations.
> 
> 2) Notification mechanism of frequency use.
> 
> For the first problematic devices we *could* have done notifications
> entirely in native Linux kernel code with notifier chains.
> However that still means you need a hint from the platform that the
> functionality is needed like a _DSD bit.
> 
> It's also done this way so that AML could do some of the notifications
> directly to applicable devices in the future without needing "consumer"
> driver participation.

And then tie is very closely to ACPI.

Now, you are AMD, i get that ACPI is what you have. But i think as
kernel Maintainers, we need to consider that ACPI is not the only
thing used. Do we want the APIs to be agnostic? I think APIs used by
drivers should be agnostic.

      Andrew
