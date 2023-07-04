Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB9B74763A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGDQOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGDQOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:14:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B917DA;
        Tue,  4 Jul 2023 09:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 932996129E;
        Tue,  4 Jul 2023 16:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E6FC433C7;
        Tue,  4 Jul 2023 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688487281;
        bh=WaqoCbbAiAIa8lE0EoMoQvZ3t15hwghN4poN3anXYpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pevey5kYhx8mtiMCHZsX1JthVxYJ4L1EziGcd2lkqPcNrbj662Hh4R5D8IrR+6LP9
         e2qL1aGZUjA0KEWzYARLVPpds+SiGRTJVL8z7Tb5KTpNqsfFGx2B1MSvwheoV9NbRy
         PllaxXVOQYatcZobwOsNBpDJo3NXIRsbMNja4y6A=
Date:   Tue, 4 Jul 2023 17:14:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, samsagax@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (oxp-sensors): remove static board variable
Message-ID: <2023070425-jujitsu-ladder-195e@gregkh>
References: <20230704131715.44454-5-gregkh@linuxfoundation.org>
 <20230704131715.44454-6-gregkh@linuxfoundation.org>
 <a9c6c44c-21fb-9d42-9a6d-6685e110015d@roeck-us.net>
 <2023070402-festive-rind-9274@gregkh>
 <cb71b00e-0225-ea24-b30e-4d615af026f0@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb71b00e-0225-ea24-b30e-4d615af026f0@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 07:14:54AM -0700, Guenter Roeck wrote:
> On 7/4/23 06:44, Greg Kroah-Hartman wrote:
> > On Tue, Jul 04, 2023 at 06:39:07AM -0700, Guenter Roeck wrote:
> > > On 7/4/23 06:17, Greg Kroah-Hartman wrote:
> > > > Drivers should not have a single static variable for the type of device
> > > > they are bound to.  While this driver is really going to only have one
> > > > device at a time in the system, remove the static variable and instead,
> > > > look up the device type when needed.
> > > > 
> > > 
> > > This is expensive. I think it would be much better to just move
> > > the board type detection into the init code and not instantiate
> > > the driver in the fist place if the board type is unknown.
> > 
> > The board type detection is all over the place in the driver, it's not
> > just for "unknown" types, so how about just saving the board type at
> > probe time and using it then for all other places?
> > 
> 
> I must be missing something. The current code detects the board type
> only once, in the probe function. Otherwise the static variable is used.
> You are replacing it with repeated calls to get_board_type().
> The whole point of the static variable is to avoid the cost of repeated
> calls to dmi_first_match().

Ah, ok, yes, I was refering to the fact that the driver relies on the
detection of the device type in lots of different places (and doesn't
ever error out from the detection call.)

> > > We can handle the static variable separately if it really bothers
> > > you that much.
> > 
> > I did this change to make patch 2/3 more "obvious" what is happening
> > when the in_visible() callback happens, so that you don't have to worry
> > about the saved value or not.  But this whole patch isn't really needed
> > if you don't mind the lookup just happening in the in_visible() callback
> > for the first time.
> > 
> 
> That would at least be a minimal change, and just add one extra lookup
> which is only called once (or zero, if it is used to save the board type).

Ok, I'll switch it up, but really, it's just a simple table lookup loop,
and none of the detection calls are on a "hot path" that I can
determine.  Or am I missing something?

> As I said, my solution would be to move the board type detection
> into the init function and not instantiate the driver in the first
> place if the probe function would bail out anyway.

That's not the case today, the only way the probe function would fail
today is if the registering of the sysfs files fail.  It does not matter
if the board detection call passes or not.

> Personally I'd keep
> the static variable for simplicity, but if you really dislike it
> that much, we could pass it around in platform and later driver data.
> But it seems to me that this could (and should) be a separate patch
> that doesn't have to be hurried in.

Fair enough, let me rework this and resend a v2 series when I get a
chance soon.

thanks for the review.

greg k-h
