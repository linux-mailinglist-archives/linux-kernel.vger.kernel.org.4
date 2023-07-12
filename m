Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A74D74FC7F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGLBHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGLBHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:07:43 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C20310CF;
        Tue, 11 Jul 2023 18:07:40 -0700 (PDT)
Date:   Wed, 12 Jul 2023 01:07:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1689124055; x=1689383255;
        bh=g7kGVsClTy/iWJCP+6nLX2Ne55mJ+O961CXlN41wCfg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=CXf/Esvi4EHk+HW3QA+Oq7ej2JiKOHNGVGZN4u0m1OyQmtRQ/1qlzVLLtxEg3FBWF
         4Q/PLIKx2jdYpI5Jx6iyjL0QSfJOvTsf39Al0hy7vyueqLgIh0dEiZwqEzH6CNj60f
         AlIGv0oHz3J0eaoNO90vyr5sSCN8GxdJp2Wjk8CNgMCxiN+EsIZUpXXH0VTy1rOBAF
         bWRAZtWTrhvtEP/Ux5pR4usdqASLGb0i96C/IlJAXIl3Hp53lFJBXtnX/Zwowub1sv
         h93zkkFAOUvtdOiNknRLQTXxr2EMiRMRJ/RgLuD8t6Lwa4fMmo2ZVGkkLlefJX1qUZ
         T8quqEd47S5dQ==
To:     Hans de Goede <hdegoede@redhat.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4 1/1] platform/x86: asus-wmi: add support for ASUS screenpad
Message-ID: <MFcnkX194DPlx9DJUNWx43ia7ew825I6K1k8hOoUYImBv390MzOdWngMLTzr5g4iv_9o9x8qE2FqoVcKUcN6s6lHdbIzfj3eDXQLgtU3w9o=@protonmail.com>
In-Reply-To: <350cfb54-f435-4482-5a40-18d4358bf747@redhat.com>
References: <20230630041743.911303-1-luke@ljones.dev> <20230630041743.911303-2-luke@ljones.dev> <974093b4-5dac-dc29-8f86-304eb5c6c19b@redhat.com> <39e6044b960c1099ecc34d76f78aad12496b23e2.camel@ljones.dev> <350cfb54-f435-4482-5a40-18d4358bf747@redhat.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2023. j=C3=BAlius 11., kedd 11:42 keltez=C3=A9ssel, Hans de Goede <hdegoede=
@redhat.com> =C3=ADrta:

> [...]
> >>
> >> If settings below 60 are no good, then the correct way to handle
> >> this is to limit the range to 0 - (255-60) and add / substract
> >> 60 when setting / getting the brightness.
> >>
> >> E.g. do something like this:
> >>
> >> #define SCREENPAD_MIN_BRIGHTNESS        60
> >> #define SCREENPAD_MAX_BRIGHTNESS        255
> >>
> >>         props.max_brightness =3D SCREENPAD_MAX_BRIGHTNESS -
> >> SCREENPAD_MIN_BRIGHTNESS;
> >>
> >> And in update_screenpad_bl_status() do:
> >>
> >>         ctrl_param =3D bd->props.brightness + SCREENPAD_MIN_BRIGHTNESS=
;
> >>
> >> And when reading the brightness substract SCREENPAD_MIN_BRIGHTNESS,
> >> clamping to a minimum value of 0.
> >>
> >> This avoids a dead-zone in the brightness range between 0-60 .
> >
> > Hi Hans, I think this is the wrong thing to do.
> >
> > The initial point of that first `brightness =3D 60;` is only to set it =
to
> > an acceptable brightness on boot. We don't want to prevent the user
> > from going below that brightness at all - this is just to ensure the
> > screen is visible on boot if the brightness was under that value, and
> > it is usually only under that value if it was set to off before
> > shutdown/reboot.
> >
> > It's not to try and put the range between 60-255, it's just to make the
> > screen visible on boot if it was off previously. The folks who have
> > tested this have found that this is the desired behaviour they expect.
>=20
> I see.
>=20
> So if I understand things correctly then 60 is a good default,
> but the screen can go darker and still be usable.
>=20
> But 1 leads to an unusable screen, so we still need
> a SCREENPAD_MIN_BRIGHTNESS to avoid the screen being able
> to go so dark that it is no longer usable and then still
> move the range a bit, but just not by 60, but by some
> other number (something in the 10-30 range I guess?)
>=20
> Combined with adding a:
>=20
> #define SCREENPAD_DEFAULT_BRIGHTNESS        60
>=20
> And at boot when the read back brightness <
> SCREENPAD_MIN_BRIGHTNESS set it to SCREENPAD_DEFAULT_BRIGHTNESS.
>=20
> We really want to avoid users to be able to set an unusable
> low brightness level. As mentioned in the new panel brightness
> API proposal:
>=20
> https://lore.kernel.org/dri-devel/b61d3eeb-6213-afac-2e70-7b9791c86d2e@re=
dhat.com/
>=20
> "3. The meaning of 0 is not clearly defined, it can be either off,
>    or minimum brightness at which the display is still readable
>   (in a low light environment)"
>=20
> and the plan going forward is to:
>=20
> "Unlike the /sys/class/backlight/foo/brightness this brightness property
> has a clear definition for the value 0. The kernel must ensure that 0
> means minimum brightness (so 0 should _never_ turn the backlight off).
> If necessary the kernel must enforce a minimum value by adding
> an offset to the value seen in the property to ensure this behavior."
>=20
> So I really want to see this new backlight driver implement the
> new planned behavior for 0 from the start, with 0 meaning minimum
> *usable* brightness.
>=20
> Regards,
>=20
> Hans


Sorry for hijacking this thread, but then how can I turn backlight off?
I quite liked how I was able to turn my laptop display (almost) completely =
off
with the brightness hotkeys / brightness slider in gnome-shell, and I was q=
uite
annoyed when this was changed in gnome-settings-daemon and forced the minim=
um
brightness to be 1% of max_brightness.

(https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/merge_requests/17)

Also, "minimum brightness at which the display is still readable" is not re=
ally
well-defined, so it can (will) happen that the minimum brightness values do=
n't match,
so it is theoretically possible that I cannot set both my laptop panel and =
external
monitor to the same desired brightness level. Or am I missing something?


Regards,
Barnab=C3=A1s P=C5=91cze
