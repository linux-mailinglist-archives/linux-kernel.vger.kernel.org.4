Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C18612A59
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 12:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJ3LeT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 30 Oct 2022 07:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3LeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 07:34:17 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A752EC;
        Sun, 30 Oct 2022 04:34:13 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 554FCE0005;
        Sun, 30 Oct 2022 11:34:10 +0000 (UTC)
Message-ID: <c6ec738617a839a692bc3eb1317c1eb9cae29fe0.camel@hadess.net>
Subject: Re: [PATCH v2] HID: uclogic: Add support for XP-PEN Deco LW
From:   Bastien Nocera <hadess@hadess.net>
To:     =?ISO-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        Mia Kanashi <chad@redpilled.dev>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        pobrn@protonmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Grosse <andig.mail@t-online.de>
Date:   Sun, 30 Oct 2022 12:34:09 +0100
In-Reply-To: <20221029145511.GA7941@elementary>
References: <20221028082348.22386-1-jose.exposito89@gmail.com>
         <ED1CBF63-A70C-44FF-9F0B-80090EB347EA@redpilled.dev>
         <20221029075832.GA8790@elementary>
         <21CA0A00-1B9F-4E97-B942-A3B7CAA2B52E@redpilled.dev>
         <C7FD0EC0-899A-4D29-8363-D2FAD8E89BBD@redpilled.dev>
         <20221029145511.GA7941@elementary>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.0 (3.46.0-2.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-10-29 at 16:55 +0200, José Expósito wrote:
> Hi!
> 
> On Sat, Oct 29, 2022 at 04:55:21PM +0300, Mia Kanashi wrote:
> > > > [1] Actually it should be set to discharging until this gets
> > > > merged:
> > > >   
> > > > https://lore.kernel.org/linux-input/20221028181849.23157-1-jose.exposito89@gmail.com/T/
> > > 
> > > But i also currently applied this ^ patch, i will try testing
> > > without it and then report.
> > 
> > Tested without it, same issue.
> > So yeah it seems that hid-input driver can set supply status to
> > discharging before setting a battery capacity? 
> 
> Very good catch. I managed to reproduce it using the USB dongle. I
> didn't notice it before because I was running upower after connecting
> the device, which isn't fast enough. However, using watch as you
> suggested makes the issue pretty noticeable.
> 
> The problem is that the battery is fetched when the USB dongle is
> connected. However, the tablet might not be paired at that point.
> 
> To explain it with the actual code:
> 
> 
>   if (dev->battery_status != HID_BATTERY_REPORTED &&
>       !dev->battery_avoid_query) {
>         value = hidinput_query_battery_capacity(dev);
>                 ^ Here the battery is fetched, but because the tabled
>                   is not paired and this function returns garbage
>         if (value < 0)
>                 return value;
> 
>         dev->battery_capacity = value;
>         dev->battery_status = HID_BATTERY_QUERIED;
>                             ^ Now the battery is set as queried
>   }
> 
>   if (dev->battery_status == HID_BATTERY_UNKNOWN)
>         val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
>   else
>         val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>                     ^ And therefore the battery is reported
> 
> 
> Thankfully, there is already a flag (battery_avoid_query) used to
> solve
> the same issue on stylus. The battery percentage is unknown until the
> stylus is in proximity.
> 
> So I guess I could use the same flag to avoid this problem.
> 
> I'll add a fix in a second revision of this patch.

UPower will also respect the POWER_SUPPLY_PROP_PRESENT property, if
that's useful.
