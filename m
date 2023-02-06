Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B1468B394
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBFBFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFBFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:05:21 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2130.outbound.protection.outlook.com [40.107.215.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB6B15549
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 17:05:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2LZCaZiznfQ7VBFWebthdCknnqLNmJ6rQBNLmP8PrTFShZ0VFVX4N2X6uK6YFnTpE6e6Sw49GJN3nk6zwdaskl42s47bSE81E0KrZYHWd5X7XdpkLtU05dtlyXg1ad2on0a1c2T/tYQyl11AGprRHMH+bBhh45LBKNLpa9YQEZaHwGjaw4IAu8NAdZlmOxm/nVUfCcDjPbRAuEvv4tgXCNq/GI88eRScWvoYjzcAk59nB4903olq58v0KwB/n3bcrfvycfjJ/6vaYSpvNobdHYD2sRHMoFDyuOjtfORZkp7Werb/kWuYnn2Uw6IdQpreqomgl74d6aj3eac0Q9cTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBl08KEPDMHPDWgVPLEpP8RBx+zX9fnZtQHDItAt/5Q=;
 b=jc7JMsArbyXXQfWFIq9fMiyP76kojLN38k1sKv0mPRkOOJ8cLVXbFBmqegeqL7f5eE/cV5oOj9Ehob8hMw7h9jbsxbGPBcEXxo/nfxIwq3RLbKmjr2GeEvS25YwjI0BtW03tHGky24/JMbc+RNw1mC/WZ50J3lb3OWCYalRZcXuAGfx6pMaVennGDYTGBNpWk7hZFdYxYjBUqtYOu2lYKE3H7dThfmoK2nwNbT+FIb4TuYrHL2xO3UpoKgV6sDOoErRZ6JNELqkuLLl+r/Ypvd0DDP35sUoJPSvauOHUieOAranWliDWDYAqD9rFxS3XWUmakT79HQH0O1efDRZbeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBl08KEPDMHPDWgVPLEpP8RBx+zX9fnZtQHDItAt/5Q=;
 b=C09TRbIAyhMlKP7KucwnlSHiOgLMruT+Z1aquF2IanV4O0qU6VEFQRwha9ohAmjyg3SEZ+jxUHkXsO6UUUv1xZI4nA16bhDKY7GRGtUCbwTMwW/jhvNYRnosOm+nnyRwHjBq3gyh+Ytl4L+t5voajoN5rQN23r3p0NGnN3TmAog=
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by TYWPR01MB11908.jpnprd01.prod.outlook.com (2603:1096:400:3fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 01:05:14 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::9438:5139:7952:d8b0]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::9438:5139:7952:d8b0%7]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 01:05:13 +0000
From:   David Rau <david.rau.zg@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>
CC:     "perex@perex.cz" <perex@perex.cz>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Thread-Topic: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Thread-Index: AQHY/Wc8EHyTvYawJkGeL+1XJ6BDpa6jYNiAgAIOc/CAANeEgIASDP8AgAAoZACAAGKRgIADYrqAgAAUigCAABqigIAAD+IAgACSkbA=
Date:   Mon, 6 Feb 2023 01:05:13 +0000
Message-ID: <OS3PR01MB66412D895E26CC3327A186A3CDDA9@OS3PR01MB6641.jpnprd01.prod.outlook.com>
References: <20221121050744.2278-1-david.rau.zg@renesas.com>
 <20230117195645.GA83401@roeck-us.net>
 <OS3PR01MB66416CEF9F6E5AE62D194BACCDC49@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <20230119161221.GA981953@roeck-us.net>
 <OS3PR01MB66416C10BF8E6400C84DAD02CDD09@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <38f09c4d-70d1-f65f-6e9b-4ad84eda4059@roeck-us.net>
 <Y9kE1cSUg2CQM5vq@sirena.org.uk> <20230202155101.GB1373010@roeck-us.net>
 <Y9vtIISfmpICi+9u@sirena.org.uk>
 <8f89eeac-b3ef-4137-80df-6cf044873b05@roeck-us.net>
 <Y9wQygzbFyOWl54r@sirena.org.uk>
In-Reply-To: <Y9wQygzbFyOWl54r@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6641:EE_|TYWPR01MB11908:EE_
x-ms-office365-filtering-correlation-id: 4ef47dd5-3df5-4c69-87b0-08db07de33d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iezF0Pisd2k9O4xELv1M0hHqUS59y4F+IjTUjNWn2kCzuP44/vf851qN5v5xalsS+yVhnWO/qswfnl8l9ce21993Iwav8gi4RHAepiG7MQpnkZQHkHMBjf7uuHqrUDgcDWSOfWCS5ocQpIwmloTSbL6rRybMDEdzj1ed1IYDFgHA/1W7kwQjLg7OK6FPr/PIttmqc+5iF+uIr1OUB2DuJrClnAZJOcOZWUIx4r7Rn+oPL/mpFoeFRDIYe2Desv03c3L4szoeBOjHB8hj5voiaYgyG9defzULKKzqNhI1GmnWoNo7IjC0rFXLIrfDB7+ZPFZzLvyVdPfOaKiyHKVwF4TIXscT+alWYlkC3IvuPhJ4nfGATIQFLehzY0mnNlokXpy5xBAUrDyF52bmVmmUch/4RD3YaRySZZflfBqfNq7Fs4I7SKrzXn7i4Eot8O5848qNYkuzecN52rNIONmpTkaj+3zFSvccOSGX9JuhqlN7QNB8tx8d9kSe4Whe91OJYchcZn8d+O3BMVZHl+jFBVMprZcqEbLVskXNsWQTJIrFJR6he4jQP+ebOtpc3UOjyyqyO+w0Wlg+bBGr2drIPXgRMgwDy8fq+gO8vFLypWMP34IlPRpLcFAiMXW3lAkiV/74OhfX7V2LonK5Biv4xQbU2sSVWA0A2FaqW1ubM9dekdzosWPSdleDD8hZ7xptZ2FksA0NFYsspdWxmAvY4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199018)(316002)(110136005)(54906003)(66556008)(2906002)(122000001)(86362001)(38070700005)(5660300002)(33656002)(8676002)(4326008)(76116006)(66476007)(38100700002)(66946007)(64756008)(66446008)(83380400001)(41300700001)(8936002)(55016003)(52536014)(9686003)(478600001)(7696005)(71200400001)(66899018)(26005)(186003)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uPGR+Pf2cVvyKnjJxKJ84Np5198iiS3/IUHjUpnAYEl3pjcExfF+ju8ATZ0f?=
 =?us-ascii?Q?UtxnmZiQDjre+4C85YBVlMw2DQn1iU2xeMKo8vFD47k04myvaKje/RMCwoJN?=
 =?us-ascii?Q?zvbSMhuyblL8Ugz/CdogdExOt23iyv5tGyBDC0FfNVq8nDlO2hvZrlodmIFF?=
 =?us-ascii?Q?YGeCebYsjGubbbNvSas5BDBZrQ0alX8scU5VXwMrLR/+n+/rvJ/LPcu/rbee?=
 =?us-ascii?Q?Ys8G/PjwuXngffLX+ALb4zroVP4NshrJPMk1xidpZmU1l1RCrrvXJL+jGdCu?=
 =?us-ascii?Q?R4md0ZoqW2y0+NfzSD90OpqM8y6veKImgIEvA869yspaZjRk9o0bAQlhm28r?=
 =?us-ascii?Q?8QVY91ekYdtvqaWV2GqNIfCwJXH1AIXOas6SCgXTZuuGB3iPuHg8WEMhW69C?=
 =?us-ascii?Q?X9Mcch9CmkUqgo1yjTZyFDKuVDsBD8JXmawb4hxpoOcYqhQGciyrJG1p6zjs?=
 =?us-ascii?Q?E/0W0v5sD5q5L11TwvrZvWSapci5VjkXz5bq9jVIfzvDOJFCuG3tjKFs+KMc?=
 =?us-ascii?Q?dGpD8I1i7p1h59ereepGfhaVCbqxmb77bwqUC6vct0Arcdal+bq49QX2xcVx?=
 =?us-ascii?Q?Mi6yZVtx7DXS2flVbTrpEwmr2pIFpmHEtMcrOsW3iIIBG/zhJLnQ/LpjsvCq?=
 =?us-ascii?Q?FlettP2uO9vKAkS0suSlB4Ybbzps8ODX6YMGqD8qg2lm9b0TNg1BQKT9BjEo?=
 =?us-ascii?Q?vjIg3pxH7WaKGeAChSCq5iqxXRC1vQniwMblVNx9H3aNiHH7mnkVPYpZg/L8?=
 =?us-ascii?Q?dUltRikKue0MX2HoYbWvL5XCmoS/a4aO56oJRCDTWM5EOO/IgwubIgDIITr0?=
 =?us-ascii?Q?jrw18coSVYx+Uudl3cokZ/Bhl3W8Sh/qc0LcFY6aBI+m/aSeKQ3rNRCfWeg5?=
 =?us-ascii?Q?WwfumsVdfE7x9c6vm+Cqln3kuvcRYqh0S5fjqj3FvP/dIvH1rhb6nEf/m3KT?=
 =?us-ascii?Q?itztqkji1kXDA9+K1IoZbTP3RcLP83T3GrMNMdRVhhwIXPaHVz9TEyW46wq6?=
 =?us-ascii?Q?vzsxbjYburwXtnesoLhUYzS7VHcdmxqCuWizD2c5Jq+2ctbUEEAx8B2OA3Wj?=
 =?us-ascii?Q?mDGyoCW/bM0ev2arlQn4b6xtvIZUw34EPhKP6uCLyXZ0zkEw7yekyVyEJFwJ?=
 =?us-ascii?Q?3YCqf4a+KC+c2qiEmViI2cBWnDbwNeAZaWxfAGodz/EEXdFYkAdkZhkQtTGO?=
 =?us-ascii?Q?Osa/R68rAtNSUg1SAMhqFae24xyDEAJQjFN/YuJbpXCLDC+j0uF0ZDSjHv6e?=
 =?us-ascii?Q?nIufR/UBhqdMWLWc1ZdgKPLy2Z0WUC+q8T8OAs36AczW9a5eKXmqTmiMo/Qd?=
 =?us-ascii?Q?9Ta5KJSgLWG3TL8skV688uvLSddbe6Q0YgqoMLTDAzQCVnqxjBLMu+ako12j?=
 =?us-ascii?Q?vknhleVKl8gmkvNxl6/9YBM1pdofMC5uJuz88GIbFgPqmwZ0UONj8odPvTaU?=
 =?us-ascii?Q?T1yBe/T9gGKdYmGlyIlGQ06VesRyjK375SrYy/HME+bx/5B4PvlGczefJgMn?=
 =?us-ascii?Q?0slTJobZe2aBTrU7VHMUJ30cKa4FSgWQ8CjMMl014G43o8xG6RH0d0Kugib3?=
 =?us-ascii?Q?02+T+6tbwkQgn0rgyttwVsJucz33vzWvtrCZ9KdT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef47dd5-3df5-4c69-87b0-08db07de33d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 01:05:13.6289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QmwESmAyJpVrHzqNow2gplwllAAopWQwix4Me/iOu4s/ntE84+I4tzoPDeBznP0xVjRUzBhKIrau8w+WKfkDtJvVaST/7iANn2K++7HVo1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11908
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Mark Brown <broonie@kernel.org>=20
Sent: Friday, February 3, 2023 03:37
To: Guenter Roeck <linux@roeck-us.net>
Cc: David Rau <david.rau.zg@renesas.com>; perex@perex.cz; lgirdwood@gmail.c=
om; tiwai@suse.com; support.opensource@diasemi.com; alsa-devel@alsa-project=
.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP h=
eadsets when playing music

On Thu, Feb 02, 2023 at 10:39:51AM -0800, Guenter Roeck wrote:
> On 2/2/23 09:04, Mark Brown wrote:

> > > It's definitely unclear, there's a datasheet at [1] which does=20
> > > appear to explicitly call for a 512ms delay though (see figure 20 on=
=20
> > > page 50).  It does look like it should only be applied in the case=20
> > > where an inserted jack is detected (ie, when identifying an=20
> > > accessory or button press) and not when removal is detected though.

> > The datasheet doesn't really suggest that a delay shall be applied=20
> > using msleep (ie in the code). The chip presumably debounces=20
> > internally (see

> Obviously it doesn't call for an explicit implementation in the host.

> > jackdet_debounce and jackdet_rem_deb), and there is also=20
> > jack_detect_rate to configure the detection rate. The table seems to=20
> > suggest (to me) that there is an e_jack_insertion event, which would=20
> > then be followed 64-512 ms later with an e_jack_detect_complete event.

> Right, I think what I was looking at was that in combination of the fact =
that there's a *much* longer window before the host clears the interrupt sh=
own on the first JACK_IN. =20
> It could be spurious and possibly just due to the host type check thing i=
n the diagram but it smells real bad, like the hardware state machine has r=
obustness issues or something. =20
> The diagram currently doesn't quite correspond to the code since we have =
the delay applied unconditionally, and there's that undocumented register f=
or the ground switch being managed.

> > Whatever is done in software is on top of that, or at least that is my=
=20
> > understanding, and not explained by anything in the datasheet.

> > Given that the chip itself supports debouncing internally, it is not=20
> > clear to me what the delay is actually supposed to accomplish. Soft=20
> > debounce on top of chip debounce ? I don't see that explained=20
> > anywhere, though of course I might be missing it.

> That's what it looks like it's trying to accomplish but as you say it's n=
ot exactly explicit.  I *suspect* it's trying to debounce in more cases tha=
n is needed.

> > > > is not conceivable (or explained) why the ground switch is enabled=
=20
> > > > only to be disabled immediately afterwards if a jack was removed.

> > > It smells like there's a power benefit to leaving it disabled when=20
> > > unplugged (which seems plausible), and possibly like the detection=20
> > > is more stable with the ground switch enabled.  The ground switch is=
=20
> > > not documented AFAICT (it's in register 0xfb which isn't named and=20
> > > doesn't appear to appear in the datsheet from a quick search).  The=20
> > > code is leaving the switch enabled so long as an accessory is plugged=
.

> > I understand. What I don't understand is that it is always enabled in=20
> > the interrupt handler, no matter if a jack was inserted or not, only=20
> > to be disabled immediately if the jack was disabled or after insertion=
=20
> > detection work is complete.

> My guess was that it was making the detection more stable, it's surprisin=
g that it'd help with simple presence detection though.
I added this software debouncing to make DA7219 more stable to do Jack dete=
ction.

> > > Are you saying this is actually crashing, or just that you're=20
> > > getting warnings about threads being blocked for too long (that was=20
> > > what was posted earlier in the thread)?  The only things I can see=20
> > > that look like

> > ChromeOS is configured to crash after stalled threads are detected (ie=
=20
> > after 120 seconds), so this is actually causing crashes.

> Ah, that's much more serious than I'd understood from the log you posted.
Sorry to hear about that.
Now I am refactoring the mechanism that remove the pervious delay in IRQ th=
read to avoid such race condition problem.


> > > they have the potential to actually lock up are the=20
> > > cancel_work_sync() calls but they were unchanged and the backtrace=20
> > > you showed was showing the thread in the msleep().  My guess would=20
> > > be that you've got systems where there are very frequent jack=20
> > > detection events (potentiallly with broken accessories, or possibly=20
> > > due to the ground switch putting things into the wrong priority) and=
=20
> > > that the interrupt is firing again as soon as the thread unmasks the=
=20
> > > primary interrupt which means it never actually stops running.

> > That is what I strongly suspect is happening. I don't know why exactly=
=20
> > the interrupt is firing continuously, but the hang is always in msleep(=
).
> > One possibility might be that the event is actually a disconnect=20
> > event, and that enabling and immediately disabling the ground switch=20
> > causes another interrupt, which is then handled immediately, causing th=
e hang.

> Could be.  I'd be willing to guess that it's not just one event but rathe=
r a stream of events of some kind. =20
> Possibly if it's due to the ground switch it's spuriously detecting a con=
stant stream of button presses for the affected systems,=20
> which don't produce any UI visible result which would cause users to pull=
 the accessory for whatever reason?  Whatever's going on I bet it's broken =
accessories triggering it.

> > > My other guess would be that moving the delay that's been added to a=
=20
> > > delayed work would avoid the warnings, though you might want to=20
> > > manually keep the physical interrupt disabled while that's running wh=
ich is fun.

> > I am not sure if that would fix anything. The current code sleeps,=20
> > then enables the ground switch and does the rest of the detection. I'd=
=20
> > somewhat understand the code if it would enable the ground switch=20
> > after an "insertion detected" interrupt, then wait for some amount of=20
> > time and handle the rest of the detection after waiting (even though=20
> > that should really be handled by the "detection complete" interrupt). B=
ut that isn't what it does.
> > If we were to implement the above, I suspect the result would be that=20
> > the interrupt still happens all the time, and the only difference=20
> > would be that it would be "silenced" while the delayed work is waiting =
to be scheduled.
> > That doesn't really fix the problem, it only works around it. But,=20
> > sure, it would be much better than the current situation.

> Yes, exactly - I was just looking at a refactoring in the code which woul=
d mitigate the immediate problem while keeping the current partially docume=
nted algorithm in place.

> > My "wild shot" fix would be to enable the ground switch after an=20
> > insertion event and to drop the software sleep entirely.

> That's entirely plausible to me, either together or possibly just one of =
those is actually needed.  Do you want to send a patch?
I will send a patch after the complete verification and waveform measuremen=
t.

> > However, it is really impossible to know what the delay is for in the=20
> > first place. Looking into the code further, the sleep time actually=20
> > matches the configured jack detection rate. I have no idea why it=20
> > would make sense to wait for a detection cycle after an event, then=20
> > enable the ground switch and actually handle the event (which by then=20
> > probably reports that jack detection is complete after an insertion).=20
> > I really don't understand the logic behind that.

> This all smells like there's either a race condition in a state machine s=
omewhere or the button detection needs a bit of help (though if it's the la=
tter then it'd be conditional on a microphone having been detected).

> Hopefully David will get back to us with some explanation and ideally fix=
.
