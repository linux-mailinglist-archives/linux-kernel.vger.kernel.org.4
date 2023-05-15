Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7978D703E53
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjEOUOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244176AbjEOUOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:14:44 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2113.outbound.protection.outlook.com [40.107.114.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DFA83;
        Mon, 15 May 2023 13:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3IEMmY8Gffr0267Lx59SIDgLRlSbbsuar2MOWGVPpC34gV5aflcz5sgRcVi6vFXfOoyEBQ8z3qKu3AoQyt9uNbY+uCXkQ6OJcjPxSbQ6GU1Jx9s6nMRWQ5nooGwjEuVCLpFRKjjU3wK+7haYonokmJ7DQLOcdCKm/FjLOVoFmRy5fHzQ1Pi2WmXquyY1WwQ/V1a1Yvpc7vgWC5sjQXvHmV9wivufrueFOqC8G2q0sIw9NWsoZutt+eJMqJ2vUwUGeAJjAj3XIMWcpEWt/f3qGkk65NRRu+tGSCDGzezjsR4zCx/xW0DDrlSh4X+ZXpAvIAp7ILUGvEASmLGlXwPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Whglp1tGnAEEz+8X7R6Q8/KdxSKce02N5RC+ZDHCTSg=;
 b=mia4AE7mRZZb3g1HPJn2id3iSvK4m9Wa+ixb7p8Zcf4TG+Oga84IfP3apPhKw65utWy9Tn7q9htCrjQJG6mDYzR1DZrNB2f7T9RZ5ggeN13B6jEyBm7Tw2lhtKvBmtlW//E02vBd7lNVgcsto40UVeWF27YRNzKFUu/a6BOfastiv8tPVendyEJdLaO2tlWSfJNUfnfKk9skkaKUNpkSXCMQR75JBS16tB3k2s/01HJt+112niDHuMeZmkWDGZuYakG7AGZyHGxiHkHL9jkDvtKBA6UKwpWl6odN94gIbCYzC/bgw5zMT8ZZGHg+MSXoxivp3tSNwxtBNlETnuNbGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Whglp1tGnAEEz+8X7R6Q8/KdxSKce02N5RC+ZDHCTSg=;
 b=Wk8Z4dg4JznSWiUJgxMipKxxKcr6JVrUhJQs1KxsEodXVzRgFfbTD07PotRw6ktA7HWOxFPghb1aXUzcn/GX1/4xj8fSj+gX+wdGS2I3++GB+AokGiyGEk3hHYElQz8qFhsKAAladik8XPKHbjZTuhQirpJjRrBoDpld2M0y/M4=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS0PR01MB5459.jpnprd01.prod.outlook.com (2603:1096:604:af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.31; Mon, 15 May
 2023 20:14:21 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:14:21 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>
Subject: RE: [PATCH 6.3 000/246] 6.3.3-rc1 review
Thread-Topic: [PATCH 6.3 000/246] 6.3.3-rc1 review
Thread-Index: AQHZh00193qFVSadW0+FBixlm4mJ4q9bweLg
Date:   Mon, 15 May 2023 20:14:21 +0000
Message-ID: <TY2PR01MB3788CDE68B5CD0B8B1FA99D0B7789@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230515161722.610123835@linuxfoundation.org>
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS0PR01MB5459:EE_
x-ms-office365-filtering-correlation-id: a001cdb7-b552-4887-4816-08db5580f886
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0T1Ue5MRsuIWI6wyUovR+Iv9JX35MbK9sCprLClBTCAYRlPsK0QN10260VKQzNgUkAzfBXBN4yWErGKEjN0CQ48NltaErTzPSTH4/yQmnXhwVEPxlXyT4yRZDvzmcxLyrEjnAOBdD4KaXO6wvtl356XN4IRQ9bV+PPAseku5dhKUdqVXhDFShIP9f2G8ZhvFrGy2Su0OTYUQwe22+CEoPQO6w9t8pCBGWvfrzm+Gdg+M4yarGbIaiyVRO7Xe6E/I6c1cnwimaX+BvNQrG3C7f6ghUwZjHHTDkjGe7rpeDF252rDnb2JLhE8U/n0uwwarL18y5pZ3+GAAEiiEYHJmglvrg2SgoRmX4lcFmai3rpGOPH3HICpd/Gs0MnItY/YpEi5Ux1XSsun4gt2tZZyPeb1/f3T5FoIOCkLjQbYfgCMNR2fMTftEyy6IPYPrbgy384noBFXaruIDvFbp4uAWqBgcQMsA7Qqs8I6jwmi+Wa41GFBnPk7AA2T9tcf50LnmZbOTrZ+UYKw1izM5XFAmDh3tAuGWBFm0owtD2gCXu/uLP9JjtMn+923M02vCfsP8EH27pk5MnFezg6owuykJ4yOjSai/BEPldCC54FgYuqg3NO+9lWBJjTMayEqFiauFe4uYkayyno17xfFybsD9EA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(52536014)(8676002)(8936002)(5660300002)(7416002)(4744005)(4326008)(316002)(41300700001)(2906002)(478600001)(66946007)(66556008)(66446008)(64756008)(66476007)(76116006)(55016003)(54906003)(33656002)(110136005)(7696005)(966005)(26005)(186003)(9686003)(6506007)(38100700002)(38070700005)(71200400001)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-3?Q?rW/VB6ByyDETk/dTLqhdhL+gMvsvWa6xiSIy2jD0tXo+aXp+lq7N/FC16p?=
 =?iso-8859-3?Q?YwB/5a0346lYzOiNdqU1Q+/w22GqbaxlW3MNaReQSH8ny4dTj4OZ063Prk?=
 =?iso-8859-3?Q?2kizqG2sPzIIf3iOdnjZu/h+wUQ6+NAzBj+csaJ8cuNqXVhPu7/AgVsM/8?=
 =?iso-8859-3?Q?NXBpMqCQZR15dyMt0GvOyxmLrnuokfQLRZU1EnqzQGsB7utcwR702HRpOb?=
 =?iso-8859-3?Q?pjCSB5XMVcC9mUr3o/mBqsR8dabsPFSQHvpCzmed/ZWEiI53AQfHxrv/ix?=
 =?iso-8859-3?Q?l2j8EOwYVeqWInzhGYgJi16bE6s3BJc+kJw5/Ob7tWUliXHXfvspi7btyH?=
 =?iso-8859-3?Q?XKscPIlG84j+NYrsqfERyJ3XQ7QSBONHu62nU+/SBRrz06y6eleSj9RnKk?=
 =?iso-8859-3?Q?c6QFT3VBKu14C2ZJptY8tjOHrEWX54Z5qMnEqta3NwnKIJ/wofnbssFpQK?=
 =?iso-8859-3?Q?lghHyeRLyBf2yesJdhlhxSlKfAi7yHCyUvj6ZTU/abxsGs95+YyydK8ls8?=
 =?iso-8859-3?Q?sVVrG9hwYBUohcTTQdglZyP2a9bmLk1PwJi4O7+cJ6WzeZVKWkbZP24Vdg?=
 =?iso-8859-3?Q?ukTH2nsP9KQT5wyI3PkAhb5S36odVCngy3lPJkwFNqxRA795jBoKto7y66?=
 =?iso-8859-3?Q?bNcX+g/xOvuWPHRGPacy4etjgVYRtIf19Ra+Wvxk5nyk6YhyOz34Vby+dv?=
 =?iso-8859-3?Q?CaWNbEiCbanI9eWnP2QwHfYiuoQjnraW280okQgxw8pLcNOAF9kJp7aHoH?=
 =?iso-8859-3?Q?6Og5H1Df9VQ4OdSLzCxmA2KZ8iOcLBRhEBqZ6C2MFONEPnT9WoK6gzuw7m?=
 =?iso-8859-3?Q?TldrzXZTsyB3WyQrSBJniPDHSWFBAL0Zrpa9PYg+2H2qlVmzDbjZ8+G1gX?=
 =?iso-8859-3?Q?b9AYWWwC8qLkBs2dgxFPDrHCD8s+cCProkOvuas7lkJe8xJ9nXif/Cuouw?=
 =?iso-8859-3?Q?K6OKzJW11/CIrjc3bsjEcBvr0LNL40os57uFD2nOMkeLbAW8vkDPEvHjdG?=
 =?iso-8859-3?Q?SHnVTYk4vRfDKL06str+wZVuvZts/Z5HiFdiDTFRlOKOODAii5ihhELK42?=
 =?iso-8859-3?Q?KQ3JWncMhiOvN9giWnen8Ecn5MhR4W8tP6xi0lSFWat7PxK6Rx+whCrTkP?=
 =?iso-8859-3?Q?SD7lgbq58OhKmlXWKgB0v3kfQVQ3Urg2f59n9ISoxlzq3EiJVZXZb1OIdD?=
 =?iso-8859-3?Q?evBYUAGssk51z2xoKLfudAIudiywJWbJmEJyRl0H5SOWeYC6Zzmchr657U?=
 =?iso-8859-3?Q?jLOffaiZmWB+YOA7BgbW66a+W+8Yp4BQZpvC86XanQAnxDIYtRiHAxID5m?=
 =?iso-8859-3?Q?qxcQhZDdl7/fDpE2N5UX8W2Hxa2bHCv1SIM05C1Hh5dX7zqJbh4jDk8pfN?=
 =?iso-8859-3?Q?CIo5m5giV/qOAiJ/iUm6zhUb2SsTE1tIzDzlJcxR/TAD+dR3pIlx48rmSL?=
 =?iso-8859-3?Q?Zm6kgz4QFTBHyZTznmr4Ofdw/zGSdvQbUuAbOyMOnSuVm7RHb/MCk2PdDQ?=
 =?iso-8859-3?Q?2NZ4JDKKvAh7KFw4KO0ekpD7VidxHI7iaNncMd89KDcpVDUJb2tPjU4BFo?=
 =?iso-8859-3?Q?hcL4Mn+aj0ec6Lxoa+5bs3v4VNW75aF/gPOowhrtQgpx1dVIellWqxXLTG?=
 =?iso-8859-3?Q?RQTs7+wNZdbYleFMiuq6Qj744tEzgmOPCNCa9IaJjuzQvUtI1rkwXcOQ?=
 =?iso-8859-3?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a001cdb7-b552-4887-4816-08db5580f886
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 20:14:21.6402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgSLIQwb58bOv/9XGUkmggFhx2UCIky/y0Si5LBsBzZwhe6FJ09gIut8OnjPnjMHhbOOZMdRqKNZOiQWEFBKuZ5QGVy+ROOLWEEk+Y3zstA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5459
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Monday, May 15, 2023 5:24 PM
>=20
> This is the start of the stable review cycle for the 6.3.3 release.
> There are 246 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 6.3.3-rc1 (5a952cfef67c):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
67957411
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.3.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
