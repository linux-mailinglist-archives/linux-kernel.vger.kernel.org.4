Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754997226F1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjFENJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjFENJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:09:23 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2094.outbound.protection.outlook.com [40.107.114.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D80F4;
        Mon,  5 Jun 2023 06:09:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AN8PT3sWLbrxtTEhzzXcCLqq7YbQQuSZAXSHGmzGS6DjS5O8r1VXKViJr1U2vjYy9hsf2jpm8hArjMwjQfuuvBFCThZS5sl4uTPhO85g+MtVPY5nN2gDVAFSB2hHYkRxEiEC2diGdIEbIjhVwPedvFOeVsxBiJJGMQa6jN7sSwm5H022gEbxmwEUsuT4hWiN6bHm/N4Z7yQaQby1SDV8UYxYeWz27aInbWizIn4rpHJu5796xf+nIHjzkg+YUpBZCKrza/KkN2tCK3fXApx9EqMWHPj92dH8JT3njnLo4EGIX3a/EKPq/ftDt7YRU6Pf/yPR+C0TX2bquUiSSnWopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Cpva4+qf/X6Hojzmawi8bcSwIf7qAkKH2cp0lFrW3s=;
 b=RPj0A6Kt4Cg/C+X0LwWdPOCoeuCkAU03ba+Np71myYXxkvkXdwU1ELbuVa7cwZ5ynnENTxYD/YbkKQqXKt3Ka/tr6ODKdtVnAr+T11Bqep/vLfI3E3xRzqOh7DkEtgOfATNuK6VEB3Pq3hRfh0grb+H5JtwAkkJvtbBQf1NKOuUxreSF7AkXsCtSpWzl2Ur/vJHz1cdHQhkxtS1ebGsu8KWtXqIuW1xLOPM8KfJvSFuCoQS8xzC3dDVInSPIw4LHlCz4ZM6qTbhcN0jQrD0z7uUcdT4qzmx8dnfA9jecqK2XMifwTPgsyoZPJCBHF4pSRQ+3KnIeQEDIeczDnCq99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Cpva4+qf/X6Hojzmawi8bcSwIf7qAkKH2cp0lFrW3s=;
 b=s77MOACiq/mAVYGPn2dvh/3mZD3EEQFUEGQidpHKpMHrCLq2gW6A5KPRIA6lQ14aXEBUMmWpPge67nWhHfzrM2tD/Jec9TFuBa9o5ZUQjRHg1kGC4NYQgp0tXHdvJ53XhlI7q4E3XN6X2mcba5cLmb6pZEvffo5pwSBBzJVK/74=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8088.jpnprd01.prod.outlook.com (2603:1096:400:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 13:09:16 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 13:09:16 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Wolfram Sang <wsa@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH v6 00/11] Add Renesas PMIC RAA215300 and built-in RTC
 support
Thread-Topic: [PATCH v6 00/11] Add Renesas PMIC RAA215300 and built-in RTC
 support
Thread-Index: AQHZlV30mPNpl/zsHU6y3jXrqwORkq98MdGAgAAAbTA=
Date:   Mon, 5 Jun 2023 13:09:16 +0000
Message-ID: <OS0PR01MB5922A2DA5C66F0F8702012C8864DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230602142426.438375-1-biju.das.jz@bp.renesas.com>
 <202306051304351d588a1a@mail.local>
In-Reply-To: <202306051304351d588a1a@mail.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8088:EE_
x-ms-office365-filtering-correlation-id: 7839b091-9476-4d7d-efad-08db65c61100
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S4/VankqecGxY6FBSxiiZyEIdL6Ep6Y6VqUH5idKSHje4/i9svVKoSxATwkaX0AS1/PyCcDWK2nEzgWnobXKh9DB9rJQSprva/js2qq+UrtVNfO+gBEzn40Ddet0y4iSY0cxmmcQQcU+otj1cfjkoSyEvlonpDdX2cU33bkO2pc9CmIn5+AOI6rZbvicziHNUwJM4A/mcLGLAsGJCxVk++xBlywj6t8dfzgoeVV+aUxmZ7MylBSfNmOc2SzdJlx8J7Kc5oxta1BOFWBl5kG4HOrZaKXB8Dd/jzlVnzN9/BRpUIUqPySwyo4OLIVkHXZOpMXdiB6y5IjB7Eav/+tEAYPtI7Fbxo6PjuTnFhooWmpCAHRdYCz9S9mS/L/Mh3fLup7I2WsL6morjIE8wD4voe2d2Zt9fjk9p2EYK7AQNUZ+KOcC+IYRy6jXFNQ1+pgeD8Y6PHOG/EN+niY0tWxWeHMFwzriybdlBLEz30RGmNQ2kBPVy9VlaDbuUYPvi/15+zEMrTY9m4sPTsuPJ79Nz2MUzOJ8Q8lqgzDxJHyUPSvjZmbTeMJ9ZBTA4nx23N2xYdoORaDHEpiQOxlaPRAxQq8ggGAE7uYvxXQagN5NNeQNfnX1z8z+vuY73N0GE4CR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199021)(8676002)(7416002)(4326008)(76116006)(6916009)(66556008)(66476007)(66446008)(64756008)(8936002)(66946007)(5660300002)(316002)(55016003)(41300700001)(52536014)(54906003)(186003)(45080400002)(2906002)(478600001)(122000001)(38100700002)(9686003)(6506007)(26005)(86362001)(107886003)(33656002)(71200400001)(7696005)(966005)(38070700005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S8pmeMPDdvP2u2F/d6UHjwj+1jWOZlc/o+I9OGyB625jMj7g8A3sP6wHl2xh?=
 =?us-ascii?Q?jtH7MlwZoG4CsKZ2U+hq04hdAUuebVgOJzF/tbYNH+fodVArwOdG6Ac/6cFe?=
 =?us-ascii?Q?ofoVXnEeGBP75no51M98O6r/Ukdzjp7mvcz3uQt1yo/jzgyLQCM1A6DjZ8/B?=
 =?us-ascii?Q?nIGNK8N9sJkcPry6t7i7/EOajf9AdheVJ4bKj5lIWSPwx8jmbPQcBEVaP3Gq?=
 =?us-ascii?Q?9UKWsEHor9Uv5Ba4jRvVX3U1BmpI1/gAtXKVKaTZBx6TOb4DAMj8JAwWO2Yx?=
 =?us-ascii?Q?YKfU/soZYMptNV17ZVhXi27cp3LJSaXNq0qWE76OPUS7IdDBVa8nbHD4VIk7?=
 =?us-ascii?Q?TFQeEStp8x/Q7e1wgouvfjqEXF0lW6juuax0ec3RQQOXR1L9QnGF2xJ0gPNU?=
 =?us-ascii?Q?eJjMZFsbjcvzwBEc3bVvbpUjvWlC/r0C0K5SCUGorR4G6K3m8e0w3k8RmQoR?=
 =?us-ascii?Q?SuAxoi2Ck0RtjVgfG1+nqMbHFj5Gf9aEfNjAZrytlgS7H7a6mO4sl1D1NiOR?=
 =?us-ascii?Q?lT4mP2EwFekGjzrUxv67UaJ+S4BQYxmZbfqEaKy2BEaL4+5S4ujXkFJLPj84?=
 =?us-ascii?Q?TGIyGwy+6FC3U4BW+TRjhT8KEnL5E0/WCHaylVhboLkfTjEUvVs4WM9+o3Ro?=
 =?us-ascii?Q?VrvzF4YgWDHQc0+wDz+pIGRBHXPXONdHCcJCRvGIUe/2n3aMv9+za9PJ+g0i?=
 =?us-ascii?Q?XBfQWb72euRWpBy5GKEBu+Vll6KsiqBqKPdP4CWPH1MTTJL2j3CbXN1qU4Wq?=
 =?us-ascii?Q?OBKHywb/xej/S0f4TADvuSfye7mFDlKqG01lXgoeunXuME524d64Ln4sMaYO?=
 =?us-ascii?Q?DcY8J/Mmk/cGdv2mRaE6qeVLp5UFcYWRyZOBLU5BvIUpOCBm3LlTLS+/dmVc?=
 =?us-ascii?Q?pgzqkZN1qureN1LKzDTmPLgaZ59jc7yjSOIHPECTSp4lguNzrV92OFHNB7xu?=
 =?us-ascii?Q?Nj+eNsn22MeGyFZtbbJzEHZ7D5A+scLVB9XMvjkUrS2i+AfAb9tRyVchUVs5?=
 =?us-ascii?Q?AAnaX1xTELeXC9zQGtO5kuswwxw0o1/aUiia1Bx/6Wb6TJbxTZIUGABLzz+m?=
 =?us-ascii?Q?dKkYaTtlHvu122ZKmD6NsAwfF4hPxHHZXAtMDFo5ff79ZRsTLqkYpvX67qAm?=
 =?us-ascii?Q?XqV8FEzQTe03yMcypi8VrMBkegDdCN3teBk4JlYhPlcMAPrPYCa8xaVHei5J?=
 =?us-ascii?Q?2oHxox4LjJKz10FfWcfaVCxytW7mbyF4nJyMIYjinX8MgADZYzQo9G1C/fjl?=
 =?us-ascii?Q?AcigqxxEub03RhLfA3Ho9Y2hS9R5c9FW+Rb2G9ZhQe3zYlaSPFUE6Cds6l4J?=
 =?us-ascii?Q?utpwGZd89WTv9wV4JQnnU5o47wr98KxwIqAk2YlExNkVHFqKAj12bGDU7VrY?=
 =?us-ascii?Q?XMB9vWLkLVP7/6+usyz+uw3oyoKJXOV2JSxwHgltRB4WQR/3Kj8M2UReeVja?=
 =?us-ascii?Q?KdcvwAwxxVJcRGpgJ98FRFUqCeHCAKvc8eNJR5mgFkM0cGymNMuTHpK6Bdv2?=
 =?us-ascii?Q?ExQtv2rXAEHm/qWytTr6nq+Ur7Qy84ffAfzTpSdnBRfNiC8yMZyyfCWMz1eh?=
 =?us-ascii?Q?N3nw8PV4W7gnF3kyb7Nfpd9KMVv88nGSuHIebAXA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7839b091-9476-4d7d-efad-08db65c61100
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 13:09:16.6244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuWtIqo4rgxeaum/tsUvt3nX8biqmNfYd1Y1PBhLcSyaVHpCqgCW5ULxdemyg0YWHluxEQBt69VbTbZCMsHJTQCiGjDVzazxccxvEnj30gE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre Belloni,

Thanks for the feedback.

> Subject: Re: [PATCH v6 00/11] Add Renesas PMIC RAA215300 and built-in
> RTC support
>=20
> Hello,
>=20
> On 02/06/2023 15:24:15+0100, Biju Das wrote:
> > Logs:
> > [   15.447305] rtc-isl1208 3-006f: registered as rtc0
> > [   15.479493] rtc-isl1208 3-006f: setting system clock to 2023-04-
> 27T19:31:02 UTC (1682623862)
> >
> > root@smarc-rzv2l:~# hwclock -r
> > 2023-04-27 19:33:05.499001+00:00
> > root@smarc-rzv2l:~# hwclock -r
> > 2023-04-27 19:33:06.936688+00:00
> > root@smarc-rzv2l:~#
>=20
> You should probably run rtc-test if you want to ensure it is working
> properly.

OK.
>=20
> What is the expectation, can I apply the rtc patches once they are ready
> or are there dependencies?

Yes please once it is ready, as there is no build dependencies.

Cheers,
Biju

>=20
> >
> > Biju Das (11):
> >   i2c: Enhance i2c_new_ancillary_device API
> >   regulator: dt-bindings: Add Renesas RAA215300 PMIC bindings
> >   regulator: Add Renesas PMIC RAA215300 driver
> >   arm64: dts: renesas: rzg2l-smarc-som: Enable PMIC and built-in RTC
> >   dt-bindings: rtc: isl1208: Convert to json-schema
> >   dt-bindings: rtc: isil,isl1208: Document clock and clock-names
> >     properties
> >   rtc: isl1208: Drop name variable
> >   rtc: isl1208: Make similar I2C and DT-based matching table
> >   rtc: isl1208: Drop enum isl1208_id and split isl1208_configs[]
> >   rtc: isl1208: Add isl1208_set_xtoscb()
> >   rtc: isl1208: Add support for the built-in RTC on the PMIC RAA215300
> >
> >  .../bindings/regulator/renesas,raa215300.yaml |  85 ++++++++++
> > .../devicetree/bindings/rtc/isil,isl1208.txt  |  38 -----
> > .../devicetree/bindings/rtc/isil,isl1208.yaml | 100 ++++++++++++
> >  .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |  18 +++
> >  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c  |   6 +-
> >  drivers/i2c/i2c-core-base.c                   |  91 +++++++----
> >  drivers/media/i2c/adv748x/adv748x-core.c      |   2 +-
> >  drivers/media/i2c/adv7604.c                   |   3 +-
> >  drivers/regulator/Kconfig                     |   7 +
> >  drivers/regulator/Makefile                    |   1 +
> >  drivers/regulator/raa215300.c                 |  92 +++++++++++
> >  drivers/rtc/rtc-isl1208.c                     | 150 ++++++++++++++---
> -
> >  include/linux/i2c.h                           |   3 +-
> >  13 files changed, 490 insertions(+), 106 deletions(-)  create mode
> > 100644
> > Documentation/devicetree/bindings/regulator/renesas,raa215300.yaml
> >  delete mode 100644
> > Documentation/devicetree/bindings/rtc/isil,isl1208.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/rtc/isil,isl1208.yaml
> >  create mode 100644 drivers/regulator/raa215300.c
> >
> > --
> > 2.25.1
> >
>=20
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbootl=
i
> n.com%2F&data=3D05%7C01%7Cbiju.das.jz%40bp.renesas.com%7C9d246dbc501d49a6=
c
> 47608db65c56c20%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63821567083
> 2856847%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DhBni%2BGZSj221vD45CuME=
d
> oxS3MDoA%2FfB1ERpMlFbYuE%3D&reserved=3D0
