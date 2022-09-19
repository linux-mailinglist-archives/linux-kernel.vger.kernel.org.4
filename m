Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848975BD400
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiISRmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiISRm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:42:29 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E04422CB;
        Mon, 19 Sep 2022 10:42:27 -0700 (PDT)
Date:   Mon, 19 Sep 2022 17:42:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1663609345; x=1663868545;
        bh=H1kQb3nW7uX+EQ7dI51yCfmSThnS5rQTaBAtat/cQa0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=EvtG51QQFuE6OuwoSuVwn8/0/t1ldc8h2OExykjwbo7OVd9HzecrXmBPrg5JFbkvY
         3G4N9woPZFDewBJML/LjtDNVO7dgRlwU5T6onepzkf1BsYt0yUDAhY/mLe5dRNMGTA
         gQkr0XjzXwyOk/3iyJ+MuKdJWBZEMWiy1pJpvUQrrbhngoFRws9AAj1FB5W0AYObcM
         GEzA71ZIYLFj1+/pgDXQlqfPvvKk+NaxNpcPcUZQ9Z7huyhYyBPBUfs0O51LWvt9PW
         D93ByrKn2YAwaAzicNkB56AA4bJHSUaZlhaCa1OXJezs1lmjsFCZmmxSEFLcWG67Ef
         Q59bf+PfHTkJw==
To:     Armin Wolf <W_Armin@gmx.de>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, rafael@kernel.org,
        lenb@kernel.org, hmh@hmh.eng.br, matan@svgalib.org,
        corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ACPI: battery: Allow battery hooks to be registered multiple times.
Message-ID: <NPN9qozoyFasUKS8WoJ8ZBuQcrF0-7SfN4Kky2xzCEvKpanHWJIPvNLBEMbGRIDV8gwyjh4xjQgucgItcCpqz4VwaawwjAFhjwOQE_6Tggs=@protonmail.com>
In-Reply-To: <155062a9-8d1a-e771-1bee-35580b1b2b73@gmx.de>
References: <20220912125342.7395-1-W_Armin@gmx.de> <20220912125342.7395-4-W_Armin@gmx.de> <wY3UHtenNt5tmQSMtoDLmzNxvJ7B56SLwlhguYfg6rqC71dDDCYypvSqvS0SUhRJwsel8wBEy3yeS8rDlJCOii24Llo0XKU34IcSn5WNwg8=@protonmail.com> <155062a9-8d1a-e771-1bee-35580b1b2b73@gmx.de>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

2022. szeptember 12., h=C3=A9tf=C5=91 19:29 keltez=C3=A9ssel, Armin Wolf <W=
_Armin@gmx.de> =C3=ADrta:

> Am 12.09.22 um 18:42 schrieb Barnab=C3=A1s P=C5=91cze:
>=20
> > Hi
> >=20
> > 2022. szeptember 12., h=C3=A9tf=C5=91 14:53 keltez=C3=A9ssel, Armin Wol=
f =C3=ADrta:
> >=20
> > > Registering multiple instances of a battery hook is beneficial
> > > for drivers which can be instantiated multiple times. Until now,
> > > this would mean that such a driver would have to implement some
> > > logic to manage battery hooks.
> > >=20
> > > Extend the battery hook handling instead.
> > > I think this is already possible by embedding the acpi_battery_hook
> > > object inside the driver's device specific data object, no?
> >=20
> > Regards,
> > Barnab=C3=A1s P=C5=91cze
>=20
> Yes, it indeed is. However afaik it is not possible to pass instance-spec=
ific
> data to such an embedded battery hook. It could be possible by passing th=
e
> battery hook as an argument to add_battery()/remove_battery() and using c=
ontainer_of(),
> but in my opinion this would be too much of a quick hack.

Good point about the instance-specific data. However, regarding the second =
point,
I am with Hans. I do not really think it is that big of a hack. It is inher=
itance.


Regards,
Barnab=C3=A1s P=C5=91cze
