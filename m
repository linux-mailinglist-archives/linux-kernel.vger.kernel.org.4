Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5A06A32C5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBZQW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjBZQW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:22:26 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8658318A9E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 08:22:24 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4PPpn81DrXz9sS9;
        Sun, 26 Feb 2023 17:22:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1677428540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GeYK5BT9h66VwNjG4DOXCbRc5mY33nHGF0n866cCNfk=;
        b=O7ocRnSVeb6PxmMCGvOOycFANQN23dOLnwv2BXMB1H6qnoezhqCs9cL6w/msTsU7Blu6Ib
        ck5+p87gt9GWAHOjwtWqOQJHBkL1GV99vKz6bKJPYM97+j/F4DcMuczU7LG7fHixgaFT3d
        3H2Mb2KjylU7WWfv506WRuBZJLZVNJJ+1HNnh4ad5JpoHcKYMTVVuix3tMOyTh03ED3qPN
        jxCaEZSnuTubIY0J9UTqwl0zYUGGQ6ESTuViK3VS8HHq8gQ8snsqPzlt/NMrADOoGoUztF
        Tpvghm5mWjTtCp/Dt1L7bNuTtHQEQowgVCu7XNnMcnMM6MoQDxTCDUKsQS8hWw==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        =?utf-8?Q?Ond=C5=99e?= =?utf-8?Q?j?= Jirman <megous@megous.com>
Cc:     Purism Kernel Team <kernel@puri.sm>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] drm/panel: st7703: Fix vertical refresh rate of XBD599
Date:   Sun, 26 Feb 2023 16:17:32 +0100
References: <20230219114553.288057-1-frank@oltmanns.dev>
 <20230219114553.288057-2-frank@oltmanns.dev>
 <20230219123542.yxb5ixe424ig6ofv@core>
In-reply-to: <20230219123542.yxb5ixe424ig6ofv@core>
Message-ID: <87zg90e6s5.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ond=C5=99ej,
hi Guido,

On 2023-02-19 at 13:35:42 +0100, Ond=C5=99ej Jirman <megous@megous.com> wro=
te:

> On Sun, Feb 19, 2023 at 12:45:53PM +0100, Frank Oltmanns wrote:
>> Fix the XBD599 panel=E2=80=99s slight visual stutter by correcting the p=
ixel
>> clock speed so that the panel=E2=80=99s 60Hz vertical refresh rate is me=
t.
>>
>> Set the clock speed using the underlying formula instead of a magic
>> number. To have a consistent procedure for both panels, set the JH057N
>> panel=E2=80=99s clock also as a formula.
>>
>> =E2=80=94
>>  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 4 ++=E2=80=93
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff =E2=80=93git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/driv=
ers/gpu/drm/panel/panel-sitronix-st7703.c
>> index 6747ca237ced..cd7d631f7573 100644
>> =E2=80=94 a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
>> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
>> @@ -139,7 +139,7 @@ static const struct drm_display_mode jh057n00900_mod=
e =3D {
>>  	.vsync_start =3D 1440 + 20,
>>  	.vsync_end   =3D 1440 + 20 + 4,
>>  	.vtotal	     =3D 1440 + 20 + 4 + 12,
>> -	.clock	     =3D 75276,
>> +	.clock	     =3D (720 + 90 + 20 + 20) * (1440 + 20 + 4 + 12) * 60 / 100=
0,
>>  	.flags	     =3D DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>>  	.width_mm    =3D 65,
>>  	.height_mm   =3D 130,
>> @@ -324,7 +324,7 @@ static const struct drm_display_mode xbd599_mode =3D=
 {
>>  	.vsync_start =3D 1440 + 18,
>>  	.vsync_end   =3D 1440 + 18 + 10,
>>  	.vtotal	     =3D 1440 + 18 + 10 + 17,
>> -	.clock	     =3D 69000,
>> +	.clock	     =3D (720 + 40 + 40 + 40) * (1440 + 18 + 10 + 17) * 60 / 10=
00,
>
> As for pinephone, A64 can=E2=80=99t produce 74.844 MHz precisely, so this=
 will not work.
>
> Better fix is to alter the mode so that clock can be something the only S=
oC this
> panel is used with can actually produce.
>
> See eg. <https://github.com/megous/linux/commit/dd070679d717e7f34af755856=
3698240a43981a6>
> which is tested to actually produce 60Hz by measuring the vsync events ag=
ainst
> the CPU timer.

I did some testing using a 60fps video I produced using the following comma=
nd:
    ffmpeg -f lavfi -i testsrc=3Dduration=3D10:size=3D80x50:rate=3D60 -vf =
=E2=80=9Cdrawtext=3Dtext=3D%{n}:fontsize=3D36:r=3D60:x=3D(w-tw)/2: y=3Dh-(1=
*lh):fontcolor=3Dwhite:box=3D1:boxcolor=3D0x00000099=E2=80=9D test_80x50.mp4

This 10-second video shows an increasing number on every frame, which makes=
 it easy to spot dropped frames by recording the playback with a camera tha=
t can record more than 60fps (I used a 240fps camera).

When playing back that video with your current drm-6.2 branch I get a stead=
y 60fps. But applying either your or my patch to mainline, only helps very =
little. Frames are being skipped more often than not in both cases.

Therefore, I need to investigate more and retract the patch for now.

The other two patches I sent earlier, however, are far more important for m=
aking the pinephone usable on mainline.

Best regards,
  Frank

>
> Your patch will not produce the intended effect.
>
> kind regards,
> 	o.
>
>>  	.flags	     =3D DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>>  	.width_mm    =3D 68,
>>  	.height_mm   =3D 136,
>> =E2=80=93
>> 2.39.1
>>

--=-=-=--
