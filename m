Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7082E714A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjE2NU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjE2NUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:20:23 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2090.outbound.protection.outlook.com [40.107.113.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424FE91;
        Mon, 29 May 2023 06:20:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzLqV+iKVedAC39Uenx0GtdztQrUFbpe+eGMp7r+munsY88UzFX7TzJkUHE7Vz7bzh5Bb+FkhSTqPLbhN/rFtvJ3uWPjCfeQ2fSqJ1fg94ef3z7DcLLKNlBQMBYRxHv/jmXJOergQgzolbHdjSmKXPNldfbGRVP3ZtH14dFyfT8hLQM/ixmyIoBMSFd3UaAp8Y2bFylwyO7gBVJ6fmuMPXg9RG6ExqyIlvDNCYrlkyKXL7hWgxjQMP11gcjoHRMqOxmnTg28CqAhwcdVQhI+EVQxCGgTbY5cDQQGOztMsubuiQDcid3HNb6+i9h9nL8mHcO3wvYcdDQcKJWY+tgtvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HLDgnVMAa2veByrcpjrg8efs9G1nCaB6jn39HaQ13o=;
 b=AWWmla9dtiZtqn8aftWuuSRWsNqtvSzQ/MT+XMONfjI8/5DhNSxdDZ04/PZvIrgzyZHGCHcGhXTwu5JsV2v981xblGqUWM3LhEkQodpWuztDtZdBWjqf2CNt+6NUYI6G3obpOKxCxyQNqO13aH9eK9VWAl3+UA4BDqQdUa04qwKzbR21N8fYOFlLH0rIe0xreywNMNVLuYP9Qzvh4A1c47egyYkjvXLIWG5Wfoy1Mf8S0LcGrPNNirBZIrFHAkGfg6hUybKrjatpjSaiGIklkUjW1pyNXGdI2Utm+4He9UJHbmDzuKEaW8ig2vGZX4RGZmhqSiO8oZ9Sa0pH3Rb2dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HLDgnVMAa2veByrcpjrg8efs9G1nCaB6jn39HaQ13o=;
 b=h34cjedJjCqRhwllOpNWyNPrePDT9SDBuSYZp798UbN1cubukWEuLw+s4OlPR+S042yVRxAKDvwrd3Z8LUE8RH+JgVNF+FNsYLapnbARZcslSV39QgLHuE+6q18EUhMasjWXK1L+av1fznZxUb6JUdRctFzXIFarRklMga3c/Sc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB9953.jpnprd01.prod.outlook.com (2603:1096:400:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 13:20:17 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6433.020; Mon, 29 May 2023
 13:20:17 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zheng Wang <zyytlz.wz@163.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Thread-Topic: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Thread-Index: AQHZj99wvrGBFYOn5Ea9mIuOTwGccK9wyqwAgAAi9sCAAA05gIAAAIqAgAAMaQCAAAEC8IAAFTIAgAAgWiA=
Date:   Mon, 29 May 2023 13:20:17 +0000
Message-ID: <OS0PR01MB5922CCF2F3DD6763EAF1F2E3864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230526143615.372338-1-biju.das.jz@bp.renesas.com>
        <20230529061714.GA25984@pendragon.ideasonboard.com>
        <OS0PR01MB592296756992262EC6D382D0864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
        <86bki3cxm2.wl-maz@kernel.org>
        <OS0PR01MB59227E69FF1DE67327BDEF77864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
        <87353flavh.wl-maz@kernel.org>
        <OS0PR01MB59227D8298776A092F024F2A864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <871qizl771.wl-maz@kernel.org>
In-Reply-To: <871qizl771.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB9953:EE_
x-ms-office365-filtering-correlation-id: dcf57535-c741-497c-8d2c-08db604771f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Le+uqaItw190eiUcaY/+2HISq5n95iMw3CNtzfWe8t7SRai8g900slsL6rI4z+Xyx82YTXSecHg41SYGL8pTwQzm4NekNIsJsOg2mm8w6Iacs81kM6I+vYcjMfZsmfCTp04z6ujHNPAWhjMUJH4xZAtY0Owq75yHu/Cy6Oy6ueM0TtjQgRrH7wPRksSmcY3YqySHkqhOmWBgpFeCYaqE8vJmpPoEUe5vZw4DnfLdkUrBvOGKD3zqH0yY5nHIExnst2rTdyy1/TdMeWN262+sPe6Ah7dC56xSwFTJnP7YXWJqC1gBbgTEVGLHAwiSpDiQpb/5DtIlLWGQVjoy1YMJOqqaU8Bnm/GDDU9E0ZSw1WL46yRuKLGHjaycMEVuNR2utsDcR9bQKmmwyH6T3FjRMOKx+r9B2C/uriMXUDVp6688tghTBZv8fqKNd0YaOMsS53xpVC8PI9mY5pStFV4Po2FjqpG/g0rkOQMdM+fjKcRyUq4baThFH2oMb/JvSDPQQZupg8q9Et4EeO+filwJ/wYqLEalOvKPl8aP9c2CKe4O0O2nwkeu+LBDqgGfgr4918cIE7OD/AajWxj8W0wNH4ZsYOxDRS3Dp5jkI4xBs0xdh7zeMxKzE+Q6tdi1MwFU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(83380400001)(33656002)(71200400001)(5660300002)(316002)(76116006)(64756008)(66946007)(66446008)(66476007)(66556008)(7416002)(52536014)(6916009)(4326008)(122000001)(8676002)(8936002)(41300700001)(38100700002)(86362001)(7696005)(55016003)(54906003)(2906002)(6506007)(38070700005)(9686003)(186003)(478600001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gQSk8TdxRQIatbJ0MK3a8udYmeaTPGAMbSAI1GzYwi2nCCdwRL79xJ3c0Cjv?=
 =?us-ascii?Q?Lzqxt/3Kr4T1xn8SvWuYoA/uvjqKjOoOhOIN+FrxJ5ex5CRVhUDpxf6bIhaA?=
 =?us-ascii?Q?tOF6Q696caeDAy16xSL8ilyHql/LUozr5gfJcv14navPvTVcwVivd2BWyxJW?=
 =?us-ascii?Q?QK5NHWF0Yr16YQvGGzF3QvQIlKxQ2nCKFepsBnWIncMYoH+WASTJrceH2073?=
 =?us-ascii?Q?0ndA19r4nm/U1zI3fRwoMo5VdUQF4OpHk2OzEI3CuI2iVC41TsemfbQ2ofl+?=
 =?us-ascii?Q?+iRO7iAhiyduKrvyAR64WLnJfgUv+x36Ue7/yQYPaNq8eMwiznn4nM5PuxW+?=
 =?us-ascii?Q?p1I5rMPf4lti53AgN4qDCdxVjq0R2aS30dLR0saMexmP/c76TqzLuCP8kqIs?=
 =?us-ascii?Q?5PWjd79DfgQ6NoJY0VDzcolreMdcLmYNlndARvSgCl8qofmhEzSy+/ww503u?=
 =?us-ascii?Q?WyWNVjAn5LDvyQVFb0Ps8gnd73kuS1xq5hG5pgnsS97CMwjUJJMWNBDIy07N?=
 =?us-ascii?Q?uH4bSeKDSsEtwImnUT8VIa5xKIHuvZz3gF5GgKliA3q0Y/NmftoVAsWoaR8N?=
 =?us-ascii?Q?ZY3IeNRjCwS6bMa7ntVQUd/JPq6Z8Arm9VhOtvd58H2MAIM02Qu2h2Op8pdz?=
 =?us-ascii?Q?lb1oj7XWJuGXIhiTUG+d3GgVKsB87gSKpQxDCcA22GvJqbdOxTYlli2/Q9zS?=
 =?us-ascii?Q?7yZYSzSrOhOvtVvm17l39tyqvhM9Jt3JUcoAsFPFqldJs0vTuM7nDFetCeYb?=
 =?us-ascii?Q?GfQe7aRZSB60+wykU+FC1fCX84UhIrCobgqaMm3kLhv3HAU+h+tWRACswbak?=
 =?us-ascii?Q?IzDf0gQETzVsSMXNNSWICxK3ZtTuNOSuHwk2VSwmIw3SmMTuf4+6aY6+IUQp?=
 =?us-ascii?Q?M69PbOKzsraNNa5IorHyABRXVfFSWsecww1MTFMOQ9vbDGtmLyX3b111e1u1?=
 =?us-ascii?Q?EH4+rQpxLL/EGw3t7mgS3Ilblq1iNrbKEGl5mkkiP/8QS26wcH3TKQI3ecjM?=
 =?us-ascii?Q?Bht8p2zrPpIB7Vz4PzfVSwtNb7biUrK0TNx/OfIlu7YghpIs5Ty0PGOHrLoI?=
 =?us-ascii?Q?MsztOye8XUDzhTn8WHdbMPSldfHT/U4SmOvMmxBC0JD9utmQGjTFWSWcAXml?=
 =?us-ascii?Q?5dyrV69Xs/+FruYfiBw5Zn/ysJBnLYwsM0hXs/qYMDN+uExyWp2BYDYkaawP?=
 =?us-ascii?Q?Dcj9+HAB/zvpEJPGLGetuSsOqEmyrpk+TpbvBhU5lXrj68KjSjQZlIp+WJqV?=
 =?us-ascii?Q?vUl4XwhxvKEKXGU/VS1RoT6lgs0IB4LjOXlUA+qjguCuMtsdwuTBczvkcOu6?=
 =?us-ascii?Q?zH7WrkvhL3I3EtS6SENbBFzSt2ku0rzMgMKWax3Lqd08eoPrQ6www1K3uGwN?=
 =?us-ascii?Q?AgYUHuOwmuq/CoIpGGt1xQGcSBjmh3XeUlh6lHHv3Uvl0l8VH15U3hq4mJVQ?=
 =?us-ascii?Q?e+3QUJsynTlRARfRTRMiLFg9SB+WnX5zF6jAlkPvRLPNEzjDpn7S2dxDNnXF?=
 =?us-ascii?Q?rdH6ybFXE220EnMLkq2BQiunquq+77tQMOpV20lgG5fwYlNf0iUjxdK9ExXH?=
 =?us-ascii?Q?64hkpoMpdeD8eXo272+JYJbb2GnCSKbhCLyugy0N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf57535-c741-497c-8d2c-08db604771f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 13:20:17.3262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GUGCtBmKU36IvOJOt9M7iQ2CYJDhQH99SXTVju2TD5dsnUZRpuXLA0GRKStbyy1oYDQ2SeaqrhMm7WUIDfq+FbcMcmPdHVGvzC4MNyOag8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9953
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
> {modprobe,bind} error
>=20
> On Mon, 29 May 2023 11:03:27 +0100,
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> >
> > > Do you understand the meaning of the "dev" parameter you pass to
> > > devm_request_irq()?
> >
> > Yes, the resource is managed with particular device.
>=20
> So what does it tell you about the life cycle of the interrupt you
> request with the *wrong* device?

It is not *wrong* device, it just parent device, which is telling
its child to manage it.

I agree, using parent device is wrong here.

>=20
> > I should not use devm_request_irq here. rather should use request_irq
> > and free_irq during unload with parent device handle.
>=20
> No, that's just papering over the real issue. You should just get the
> driver that handles the interrupt to request it. Anything else is a
> design bug.

Got it, but I guess, by using devm_request_irq() with child device is not a=
 design bug

In a real life situation, for eg: A parent owns a property,=20

Parent is thinking it is efficient to handle the property by its child
rather than him. So it can tell its child to manage the property.=20
The parent share the property details and child manages it efficiently.

Cheers,
Biju
