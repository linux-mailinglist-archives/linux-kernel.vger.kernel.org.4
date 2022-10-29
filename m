Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F146122CE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJ2MN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2MN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:13:26 -0400
X-Greylist: delayed 41851 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 29 Oct 2022 05:13:25 PDT
Received: from redpilled.dev (redpilled.dev [IPv6:2a01:4f8:1c1c:f8e2::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FFE77E8C;
        Sat, 29 Oct 2022 05:13:24 -0700 (PDT)
Date:   Sat, 29 Oct 2022 15:13:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redpilled.dev;
        s=mail; t=1667045602;
        bh=iecAOUrXA5SLA/RHjbWjdCfOOsBiEh01Dkv1Qck30Ok=;
        h=Date:From:To:CC:Subject:In-Reply-To:References;
        b=j1yJl6a8D9c78OedEOwHsOMCZh/wKr9iKbPSaT8CZ2JV+PcX4Es6yKKdbjpIVJSx2
         yHPDbAwmrUqNEbYskcfB0uEp0q/pqRsF9Ql3N0xe8jvoSYft2V+mTQNGYO+iui4naQ
         bdaO4Ya81DnRU1xZhezMOuMXVp2UatRzq6SBsYJ4=
From:   Mia Kanashi <chad@redpilled.dev>
To:     =?ISO-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
CC:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        pobrn@protonmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Grosse <andig.mail@t-online.de>
Subject: Re: [PATCH v2] HID: uclogic: Add support for XP-PEN Deco LW
In-Reply-To: <20221029075832.GA8790@elementary>
References: <20221028082348.22386-1-jose.exposito89@gmail.com> <ED1CBF63-A70C-44FF-9F0B-80090EB347EA@redpilled.dev> <20221029075832.GA8790@elementary>
Message-ID: <21CA0A00-1B9F-4E97-B942-A3B7CAA2B52E@redpilled.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 October 2022 10:58:32 EEST, "Jos=C3=A9 Exp=C3=B3sito" <jose=2Eexposit=
o89@gmail=2Ecom> wrote:
>Hi Mia,
>
>Thanks for testing :D
>
>On Sat, Oct 29, 2022 at 03:28:10AM +0300, Mia Kanashi wrote:
>> Hello!
>>=20
>> Before device sends a battery report, you can notice garbage values in =
a power supply capacity=2E
>>=20
>> You can see this by running
>> `watch -n0=2E1 cat /sys/class/power_supply/hid-28bd-935-battery/uevent`
>> and then connecting the tablet=2E
>>=20
>> You can set it to a value here, but i think this is a problem in the gl=
obal hid driver?
>
>That shouldn't be problematic, because the charging status should be
>initially set to unknown and change to charging/discharging [1] once
>the device sends the first report=2E
>
>Your desktop environment shouldn't display the battery percentage
>while the status is unknown, so the initial values are ignored=2E
>
>Here is my output of my XP-Pen Deco SW before receiving the battery
>percentage:
>
> POWER_SUPPLY_NAME=3Dhid-28bd-933-battery
> POWER_SUPPLY_TYPE=3DBattery
> POWER_SUPPLY_PRESENT=3D1
> POWER_SUPPLY_ONLINE=3D1
> POWER_SUPPLY_MODEL_NAME=3DUGTABLET Deco Pro SW
> POWER_SUPPLY_SCOPE=3DDevice
>
>And after:
>
> POWER_SUPPLY_NAME=3Dhid-28bd-933-battery
> POWER_SUPPLY_TYPE=3DBattery
> POWER_SUPPLY_PRESENT=3D1
> POWER_SUPPLY_ONLINE=3D1
> POWER_SUPPLY_CAPACITY=3D99
> POWER_SUPPLY_MODEL_NAME=3DUGTABLET Deco Pro SW
> POWER_SUPPLY_STATUS=3DDischarging
> POWER_SUPPLY_SCOPE=3DDevice
>
>Jose
>
>[1] Actually it should be set to discharging until this gets merged:
>    https://lore=2Ekernel=2Eorg/linux-input/20221028181849=2E23157-1-jose=
=2Eexposito89@gmail=2Ecom/T/

Hello, for me it first looks like this:

 POWER_SUPPLY_NAME=3Dhid-28bd-935-battery
 POWER_SUPPLY_TYPE=3DBattery
 POWER_SUPPLY_PRESENT=3D1
 POWER_SUPPLY_ONLINE=3D1
 POWER_SUPPLY_MODEL_NAME=3DHanvon Ugee Deco LW
 POWER_SUPPLY_SCOPE=3DDevice

Then it looks like this for a very brief (or not so brief) period of time,=
 it also isn't always there, i suggest trying plugging it in multiple times=
:

 POWER_SUPPLY_NAME=3Dhid-28bd-935-battery
 POWER_SUPPLY_TYPE=3DBattery
 POWER_SUPPLY_PRESENT=3D1
 POWER_SUPPLY_ONLINE=3D1
 POWER_SUPPLY_CAPACITY=3D160
 POWER_SUPPLY_MODEL_NAME=3DHanvon Ugee Deco LW
 POWER_SUPPLY_STATUS=3DDischarging
 POWER_SUPPLY_SCOPE=3DDevice

Here value is 160, obvious garbage, it can have any other value depending =
on your luck=2E

And then after that it looks like this:

 POWER_SUPPLY_NAME=3Dhid-28bd-935-battery
 POWER_SUPPLY_TYPE=3DBattery
 POWER_SUPPLY_PRESENT=3D1
 POWER_SUPPLY_ONLINE=3D1
 POWER_SUPPLY_CAPACITY=3D40
 POWER_SUPPLY_MODEL_NAME=3DHanvon Ugee Deco LW
 POWER_SUPPLY_STATUS=3DDischarging
 POWER_SUPPLY_SCOPE=3DDevice


>[1] Actually it should be set to discharging until this gets merged:
>    https://lore=2Ekernel=2Eorg/linux-input/20221028181849=2E23157-1-jose=
=2Eexposito89@gmail=2Ecom/T/

But i also currently applied this ^ patch, i will try testing without it a=
nd then report=2E
