Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFFC715DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjE3Lxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjE3Lx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:53:26 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2113.outbound.protection.outlook.com [40.107.114.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D097FE61;
        Tue, 30 May 2023 04:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBmyxtkMTtvNkY8u4f1CtiUdO/KRMD6Cl2v1dux6gGNKXW3bLPu1mMmNT+eXKcL7oyu9oDrrjdZ6Rx2Qw7aRcS+tPoJ6RSJim14vfwkgQ9AfGvwwSOGEgDsLKpz0qjsK7XzYDrHrVvMNx23RSI0KUwy+YypB3eulvNyOl7AQBP/gZoCzHFgnSlH+w0Uy7vLBPXIugnp00HRFm+QODxQ9yuFQw5f1uUtSei1q7732b09fmuLMaQQYPFey8Yuf4cF9KuHArVf7sb48GuQj7fxj1S4tGDFUTpaTc/AAiW7f2OFnogUxI7+gZgU7MTDn3e3Mwwspex1h0dg2hw9USIWcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwvm/4I21J6vl/I0dBjGRzEbuMHBF38tkbc3NxuZep0=;
 b=Kb85azX9P1VPovSF1mW52BgBZ7TSw4s1ZfyvSn2QF2bDpvGkQjC876s4s1oEKubH+A/yo+9QaKsq75JjOEogWLAS4IHnnfuOVl50l5SwhtPzwBW2eZeH5cXi6Y1NZH9KArNVzoPqJ5N7Lo99CcJwlqBgiBNcEFOsZucNeINnbXZ4cg1RlBvCPoKeXPkm0kLEge7wIMZtxDlkNT64+u7wkt3XMzb1Vx2OM/o5hUVBsgBJfcXg8JLhzoz3hSfgQv+zRq/t/s1OPzQkp/7mbYUaHQwJI+jsL8fBrx7uI857t/FkGV5sC6X5QTvFxPPuQMcM4Mbgs126CHk4/TS3zPDwPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwvm/4I21J6vl/I0dBjGRzEbuMHBF38tkbc3NxuZep0=;
 b=iWDH5HV3Ws44Co9f4SN0/jp76OHstA22ANDrHz33BDGg65B4ZrQDAw4UnRNoMuu7QFBnUFKaESWSZYrpTVuHqUqRGdVawYUZ+tTfuduOgB8wJcWwSa0bg6B18jUDl6LMcXfJqK1llOnvVaLBUvePOUQ1KuffNswVf7Vy4flDQ20=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYBPR01MB5390.jpnprd01.prod.outlook.com (2603:1096:404:801c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 11:52:40 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 11:52:40 +0000
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
Subject: RE: [PATCH 6.1 000/119] 6.1.31-rc1 review
Thread-Topic: [PATCH 6.1 000/119] 6.1.31-rc1 review
Thread-Index: AQHZkZtwA2w5rxMPMU+T9qznSJyjmq9ytbMA
Date:   Tue, 30 May 2023 11:52:40 +0000
Message-ID: <TY2PR01MB3788EEDEB7BD85863DAFFA2EB74B9@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230528190835.386670951@linuxfoundation.org>
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYBPR01MB5390:EE_
x-ms-office365-filtering-correlation-id: c2381918-5646-46f7-2959-08db61045f0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dSkxCg+Ly9R3efz3OHv3ZYsP1U/E2iyvPfzkY06H52vVDCkV+m4IjXB4HagbdsyZI0dWu6yQaAIuDGDG8jBPEjyX7SPVb/9BdkJqxB6ZZOFdIJCdSyucWzvmsOJnW0t3HwvDO6SzQZF0NJS5WW7bKl86Q+ob8ZWiAK3JlUJNgd0SizByvMNVnLEcSUOMqmcSQv3IdYYJEot5MoO7ly2dOZUj7VQ/sDlX3yykXZvkNBlPrIglg/9cJs603ff0fQJX7a34IWZ2SGqGDtBqmY/Z0o4o9CsmTSuqjr0J7BMK1i6cJR56WhZL6TuJ4opiRH+qhEHYa/HEJbqP79gBpqu+QoZeXyKYRXP2+UjnkMKBtMKH3TT8cmpVDSK3hzG4Clt2aRyOo01dIwdn7ifHFXE/tbylwe0tl5yLYbDphzrhNizzLHXD/WgP1RrSL+JWe+xwcYrLk6UjXU5TygJ4hhIW44BXkP7l1mPnn3H6XwBESebIOQjWAYt2WpE0ddZDj1aaYh9aqhoRARTO974emoSBpyK1jANuE2fzjqwFicPdOUp9ScptsXPPpFNZEo2NkGjYC/QMj96EspGFn74oSDA8/s4sqJ9FNleI5ETmCwEpORFm+fBQ+DcCU0+hRe+emj1mkR6bRmK6x9sYeYwHs1mWWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199021)(71200400001)(478600001)(54906003)(110136005)(8936002)(52536014)(8676002)(7416002)(5660300002)(33656002)(38070700005)(4744005)(86362001)(2906002)(66556008)(66946007)(4326008)(64756008)(122000001)(76116006)(66446008)(66476007)(316002)(55016003)(38100700002)(41300700001)(26005)(9686003)(6506007)(186003)(966005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?G0pAfzGa7Uf1WPydQJq2oAuRpptmP4KCrSFCeWjk2vX8krHUkxgjyAXTzZ?=
 =?iso-8859-2?Q?t9GQO5U184OYa1J0CpZcmtFS0WUnOcyOFhAd1l6Vh4Z8YJZCcBdA3sVm1U?=
 =?iso-8859-2?Q?t0eNj5TBQ3aVTfUHc1/vG3z3+Zw6JzUWegk/Fah/A2aBNMMrA0rcFuWRGM?=
 =?iso-8859-2?Q?d5RpWo6p4zid3x1cC55BoL9GlT5MfsD7KH57TLTCLNFmdjYGZPUsJ3sGzS?=
 =?iso-8859-2?Q?9S+fpArPFODNPl6TBpSt2nDFQdR3/yeoam/0wVs6eSE/q1jYrkLUqxtTkv?=
 =?iso-8859-2?Q?IxlPVibyrpJq5788/uMcwDWZAxYvPHAF5Ki706TZ0Fa4nXL0x1kl63Bhxt?=
 =?iso-8859-2?Q?8IpBgnGlMqU76NZT+F4kL9wjgOZLOBbH9XDcr4bxFyCZKlo/KkQJLWbVmy?=
 =?iso-8859-2?Q?ukrRpg8KAMeNYQmcmAbxAM8VsEwcXtYEvYyZSkqrdhbfARdxxw9YN1vKOg?=
 =?iso-8859-2?Q?jiANGgrPp7/hzPOjDyWKCL/5O3H4W5rDGAwhY/svG6yKZmIGR3N/7E96f4?=
 =?iso-8859-2?Q?LdyFU4jamwa7iKim+4uxsvFceiAW9ZTycTqpXUW551Akdbi0Mm++tpIHwl?=
 =?iso-8859-2?Q?ALE7OaGOI7RXipD+bO4gAdc94T4bzz1BGcxH91e331CeUv6JWulWQkWsgl?=
 =?iso-8859-2?Q?RW6qtJjmMnM2Z7kXjvrb4AuJv31//Yyy4GPwg1XRK/cAJjDJGMiO69zD+1?=
 =?iso-8859-2?Q?zBNYOMwQDauN5pg1YweexNHucoWeAUHXpuebkXiopNsjzRP0KRROY/KOqZ?=
 =?iso-8859-2?Q?RhSu4qC+dIV70i0r5ZPsqYWV3pgAAszR558YmENabfDr7bWgefitW+y3np?=
 =?iso-8859-2?Q?89BRFZDSkkY3p9vTWMwKEKcJ6+MF6nKRhZ9DKCzkSg1R+aaWafCXaNttA3?=
 =?iso-8859-2?Q?AnIlOusKWfRPGs7m2gcEOi664HNcSY8WrzXLbtikxyD54hxuvzbGLySTjQ?=
 =?iso-8859-2?Q?H1kjgFWxE3SNEgfxrtZwGIJntZDFa6klUIsQKrEbPcOt0pHJri+8xq1GhZ?=
 =?iso-8859-2?Q?eJLXsShF46zl46wgrUdm5TKlQuqhz16Z+VUemOtAa/J6T+SzC/GUNEQ7wF?=
 =?iso-8859-2?Q?h3nwPPzbXYdXLZTkO2BajbalWgSqeuUOgtYG+Xu9aeRYY2ffmvXw+FbCut?=
 =?iso-8859-2?Q?4XkTVhBINQ/Zk0UFoNyov2A/DvWFZkl/MTEQGcovyhYeVaIRpbnckvb3vw?=
 =?iso-8859-2?Q?IRYYllYhkeh1ArT4EFjO04GREtMT4sl2BBTL+/hejr/l3nsKYdr0h4UtYB?=
 =?iso-8859-2?Q?oEnF6IAgl9ro/La0s2H/D6gMfZ5lfq7O9AeYyvM96vg5ajj1mh6ognl7PG?=
 =?iso-8859-2?Q?7P98SMf3N2adCHNP00TJh/sPTEa/lEx3HvIJBEyTG/NVxUwIkCLPSa20AS?=
 =?iso-8859-2?Q?nPegD65vEl2q7uImHAwMYWPL/Utn1YJNV/8wV0fJ+QSaOasPzogWgadykk?=
 =?iso-8859-2?Q?EmWmCh86K9W2DzvCPPOvIt081+ORXTNwpY97LedYq71AXRceLYS4Y5ue5J?=
 =?iso-8859-2?Q?SwXod5plCpOHqPweMy4fKtpa3tkz7oEQe2WFZAsU2hIrMtEwaQzD9zrpip?=
 =?iso-8859-2?Q?nTeFvEes3Dq/vZa5+fCEBKd67ge2wChvjsUoJD1Yz82l9LBCAFaTpBYtV1?=
 =?iso-8859-2?Q?OisfS1Fho3x/b+Sp670p4IKimCwlD4TurFZFEn2XXlVUwA8bxf7VTogQ?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2381918-5646-46f7-2959-08db61045f0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 11:52:40.5157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBp/cjENMwL5S6cGcQAu5yieSxBFmBb2mkPRFl+EBNhQ9QZ2UFsUeiozvijWrytmFDSLmFKJvTfeGNu0MSx1gsuu0IQTZ3K/yJMjsKaDiuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5390
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Sunday, May 28, 2023 8:10 PM
>=20
> This is the start of the stable review cycle for the 6.1.31 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 6.1.31-rc1 (8482df0ff7e7):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
81425030
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.1.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
