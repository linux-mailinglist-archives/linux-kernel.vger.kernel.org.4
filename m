Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE56969B9DB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 12:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBRLs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 06:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRLs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 06:48:27 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D03A166DC;
        Sat, 18 Feb 2023 03:48:26 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0157F1C0DFD; Sat, 18 Feb 2023 12:48:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1676720904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YHZsK3arv/1aj12I3FHMYRgbyAEsDvuM63EKtoCmH34=;
        b=JMxu16V3xqCXCqfOzG5r0s9Db595ho7q7LQue9sF2PWxtHqWZpKdbessRANaUG1B0v3Ytw
        wd9GaWTcRJ5nGzkrqleDyk3NSjutmtF5L/tgANCScUYgXg028J7MGaBGT1S/+ru0bZryDG
        39r1Cet83pkhINqV+rHN7d8SssOUziY=
Date:   Sat, 18 Feb 2023 12:48:19 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Rishit Bansal <rishitbansal0@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: API for setting colors of RGB backlit keyboard zones (was [PATCH
 V3] platform/x86: hp-wmi: Support omen backlight control wmi-acpi methods)
Message-ID: <Y/C7A9eCjpdbzYbz@duo.ucw.cz>
References: <20230131235027.36304-1-rishitbansal0@gmail.com>
 <9b761996-d522-b0f8-6472-10e40e09e036@redhat.com>
 <65a11a89-e780-6d60-a40e-cd3245780762@gmail.com>
 <b83ad6ba-7d55-f309-5d7b-4a5ff77ff5a3@redhat.com>
 <02c96cfe-ab10-513f-fc36-f474dd227656@gmail.com>
 <544484b9-c0ac-2fd0-1f41-8fa94cb94d4b@redhat.com>
 <Y+I7xNqkq/X6Lag+@duo.ucw.cz>
 <3c48e204-780c-f78c-8219-267e297dc1e3@gmail.com>
 <ec5bc4a6-dc9f-90dd-0cf6-5fab47bb5fa6@redhat.com>
 <b11185d3-fbf3-a461-39bc-67bee4739e40@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qAV0Wrzlh/6x7U/V"
Content-Disposition: inline
In-Reply-To: <b11185d3-fbf3-a461-39bc-67bee4739e40@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qAV0Wrzlh/6x7U/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> > I do agree with you that we need to avoid kbd_backlight in the name to =
avoid causing existing upower code to have weird interactions with this (it=
 supports / assumes there is only 1 kbd_backlight LED class device).
> >=20
> > So lets go with just these 4:
> >=20
> > /sys/class/leds/hp_omen::kbd_zoned_backlight-1/
> > /sys/class/leds/hp_omen::kbd_zoned_backlight-2/
> > /sys/class/leds/hp_omen::kbd_zoned_backlight-3/
> > /sys/class/leds/hp_omen::kbd_zoned_backlight-4/
> >=20
> > Using the _zoned_ between kbd and baclight to avoid confusing the exist=
ing upower code. Then once this has landed we can look into extending upowe=
r support for this.
> >=20
> > Note the requested documentation patch should probably also explain tha=
t the _zoned_ was done deliberately to make current upower code ignore the =
devices.
> >

>=20
> This makes sense, I agree that the global LED file will cause more confus=
ion
> and hacks in the code. I'll start working on the  _zoned_ naming scheme w=
ith
> 4 files + documentation changes and make a patch for this soon!
>

/sys/class/leds/:rgb:kbd_zoned_backlight-4/ is better than what was
suggested above. But we already use _1 suffix to deduplicate the, so
I'm not sure this is best naming.

There are keyboards with per-key backlight. How do you suggest to
solve those?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--qAV0Wrzlh/6x7U/V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY/C7AwAKCRAw5/Bqldv6
8pXMAKCIdI8KbS5mAISKNMRztO7602shGACbBpeBHzXsXIPq1r6rMBoYzfUSFwk=
=G7yz
-----END PGP SIGNATURE-----

--qAV0Wrzlh/6x7U/V--
