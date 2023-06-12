Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EE172D384
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237708AbjFLVvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbjFLVvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:51:07 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2097.outbound.protection.outlook.com [40.107.114.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469D0192;
        Mon, 12 Jun 2023 14:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNKQ9fi02MYsLHgW1BSLgtrPoyc1z3W1RDQXLMt2HpkhlC0rxztBjFudydy5jwiWTAvE36lzRI8P8zfwmgrnOa3PB4UZkPp932zwmTfG8B94LLMoR+G3Im6iHnBFtDnklmH/8dn1NBRE+rZodOIRLFJwik7TH4uuKqIeMS2OgRl2YmpGbydo/DOGHwFoaGZfGyJCgeBhAsTNMENBcnUjaR/C5VWL5sPZcktz9OuZ7wScx++qe1J38jtwxAGfa8En9T7lZf1vj2gB5QYZKONkBr6aS0VIoeXnnyI1lOZt+iNNhUmi4rMxppP9nIwA4GD0T0IhNcooAPhnZ4X2s11S6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RPWpcuIsZS/E2IGBdOQEl7drglShW4/MN/SDyzeqPU=;
 b=QoFZ1bG0SDkochXnIIoFdnqJra3T2z9s0CgQCgnOBjJPsKoR2aWFM8SbS0FhuNmhcsvuGgstq6KvhDWAGr2/CKRaHEhv1I21upxlpxi19KtFmE/MIdw7yhCZga7uXW4eKP5KyCDcvbJcSCeg0FlNTwq4mN/avvttqw8Hut3XoHFrWvX2tbM+oO3ZnGCX+2jn4Ex8/C56Fqv7Z9QPqWUcSfWEB1pUJ9/UWsmbVd5hmvK8rRH94qpiv34O1o1ycuqiANznZ+7J9fO0R5IX1Ptdli+7ViSLbFGWsSejiYM50mRAjar9hg7dEK/1YxNglxoWAQU3dgw94leWrCCgi9sDkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RPWpcuIsZS/E2IGBdOQEl7drglShW4/MN/SDyzeqPU=;
 b=KY1rndD2w+a8Qg+OfMdRbc9NZ/3FCu22BH3R9Bj78084vAN2ZdJ1eJBY5+l+xAWFO1pbAPqPflRaWFm2aoxQ5puzIDymJ/slEdjb4c57FY3VL6Qy1mfITJ0DlCmxErNEhHxXQXV8h2YLR8yYb5GrN9pMjXvU3Nav47D/kH3oFBA=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYCPR01MB8680.jpnprd01.prod.outlook.com (2603:1096:400:157::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 21:51:03 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:51:03 +0000
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
Subject: RE: [PATCH 4.19 00/23] 4.19.286-rc1 review
Thread-Topic: [PATCH 4.19 00/23] 4.19.286-rc1 review
Thread-Index: AQHZnRsk1U+knwcS/Uq1AkElAM/Ynq+HtCnQ
Date:   Mon, 12 Jun 2023 21:51:03 +0000
Message-ID: <TY2PR01MB37880F650933C6635287471FB754A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230612101651.138592130@linuxfoundation.org>
In-Reply-To: <20230612101651.138592130@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYCPR01MB8680:EE_
x-ms-office365-filtering-correlation-id: 243709d0-4fb3-4fc3-d0b2-08db6b8f1e2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xqX167ZPyWjCAv7d4tJkeb3uur1OhEWNwJJg0rWx2t4wYbaCa0coJD5PNXvrtrUWjqlMogCr9CDlA9eLgtUdjRq4efyTu9v/3Ctw3JMafpaQpm9NcnA2raBHAgmNCcJCIcdINTj4eWoemSH5Lc60B5GViv2FtmQZjmjblWVa6jJeFlby+JgMy0wVPmw7pVHlb8taSdauafYgrNBk4TK+QITW/wGzI4ms7PiSkXa64Uk5yWGiNwUGOB4ZyW4SKmL2DarolCyBPl8zPUZCFJswbOaToRVbHYx8mPtk+/qQRq2iFbJQtJkoqbd4Iim0x+Z8HS9a9NMkhm6J71gGWmvUApIj4Cbiag7Jyu+tS2mVc+Jy4vq+dN7R3zt2mR6YK9apYEz2SDvbwyphywKEfhU/H3A/PpNNcPwmrfC5nGkKqaCeZw1+eEU86sU+a0nLgXL40yH0hMAuzGIUDYjdOFo2iQo5Lj9FKiMmzlFgGGgmOyCJECwHL50XEaagXrU3OKmUp5GxBb9tKlk5ZPClOZ33mekN6d9akWZy6i/UpV0RH7GYIIbDytEIzGD2nCcGUHpr0gP6lxM+Bb25RM2Nny5rnCdYw05Zewq0QS6P/QIHIaMyGfJ86aaK3wMaBwF9EAu108YMYpv21bsFGRrSqNyR1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(64756008)(66476007)(66556008)(66946007)(316002)(7416002)(4326008)(66446008)(41300700001)(76116006)(186003)(4744005)(2906002)(110136005)(54906003)(478600001)(8676002)(8936002)(5660300002)(52536014)(71200400001)(966005)(7696005)(6506007)(33656002)(122000001)(26005)(55016003)(9686003)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?EQluLKuR0AqdEYwjBSWJYG04OgnAeACj+BBbu2UktEDVWFfRcBW6NPf0?=
 =?Windows-1252?Q?0CuBCpwQX2qzV+m7cIEQ+7ziPYgYzch5b+WLgZDqx3fzso43hHGu9eyw?=
 =?Windows-1252?Q?LKi2BeBYTY6E8oWj/kwtikeSlD5Mt7IhvIMP+cMPTObyZ1tNqeG3Rah2?=
 =?Windows-1252?Q?kQlOG0hFjZ02Op3tJCZqV0AwjH48GotPNkzUSe4MmSMCdCdDwB9J+bba?=
 =?Windows-1252?Q?okKkanRmuNje7Iymkk21lYttCiZ7gkhS0jU+qUazGNWB/xdxbVM9VoA9?=
 =?Windows-1252?Q?Qgnq79aNzHCnw//F08mLG3yyXgBp4Y1eJycni9ZmfzQPTIJrzovC5SZz?=
 =?Windows-1252?Q?6PTu/B+8JEDWuhHEvANlZdyhDWW0yW77kSdBQ/gm9Qc3y/ggWzydcIr0?=
 =?Windows-1252?Q?AjSQCppLpxlMeEPOa/lriq1ne0ayNy/QaEVPiJeGnokwlLEIas1gMmJz?=
 =?Windows-1252?Q?qzRscexdX2kPNHhilFBpfobFrQtIf9TR7M5ycnx8yDk7TFaNaDl/Mtzx?=
 =?Windows-1252?Q?/IHMYydYxO3uWk13dbP4oiiZ8xioM5HA2hzeirIPXvf3efohZY3iuUUW?=
 =?Windows-1252?Q?d7YCsw75VitlBMagkml7zjsmCqzbq7oIU8+oP9eb68/+8UOlVchiWNjV?=
 =?Windows-1252?Q?Xj14zcvsvLPX91wrO4iQdnoGgAWyvfsAxACH+UavwztSa7R5etZiocPM?=
 =?Windows-1252?Q?xuY7EVdO+ygOcQWNNjAHpi9ovoIEP9quC9eVvQ5qAZ4JbhNyi2rneb4D?=
 =?Windows-1252?Q?2IKgKyFdQzVd26LkFQ6jjHe8nhFgkqwWUWYrxG0rSqxZuRCiRBysFTWF?=
 =?Windows-1252?Q?tojMD/SYV985Wlk9yoAGGRw6lVmGJdtDEzuyNCpYnp5EuSKqcNxkuU8S?=
 =?Windows-1252?Q?9laTZ4joBlkHanpSPu071xw8HGdKgTVDHEzoMvKmnbcT46zXTuokXCS7?=
 =?Windows-1252?Q?nDcen1f5bejSyTAFF54i2r9Hw1O70tYjxty//koddhFof09vSBFwOmdw?=
 =?Windows-1252?Q?bPcTJP0LivTsxdLcFRk8Ofir39C0U26P23QBgRBdrPHbD1Q4tmptFW/N?=
 =?Windows-1252?Q?+UTwIrWGTcAYXJsTE5n+5a8GgVRTqw8On6C5NxPDqYjOgUORSU5+ld8n?=
 =?Windows-1252?Q?nz+gLLnbFif0pI7Ne497nxamDPYK/Sy+6G5M1drxfzhIPq/08RSd5zHL?=
 =?Windows-1252?Q?sYF8iiX3BwUSP/3evAmJVsmT+IuqqP8E08UTYIqrbuZfcdP+BNhR3yXP?=
 =?Windows-1252?Q?0StWlp8pI7W74ylxuTJVJjnQaftSunG2ntGtCeBBr4ri82COelzEZTbl?=
 =?Windows-1252?Q?Ri60vPd8C33thlSKiHp+dThEdhZzfBb/1QKER7C3hjsVur5uVL/jPYmc?=
 =?Windows-1252?Q?Mi5lZFozpWap3TF6zIHAVhNAxwy2E9SjdJ+XVULfsrYiMHWEHoOQk90G?=
 =?Windows-1252?Q?2VM6uyoZzPm5FjBqQ32m6JFPp5UgwNKybJ7BoUCZIAU/pxhWzNzGoQg+?=
 =?Windows-1252?Q?jFWtXCQCUohOc9cZVwCM+P6q4qHBbLHL+pitqkzgPwlGX+wEOZRMktQ2?=
 =?Windows-1252?Q?LPXeNEmxmQ9rme1loepuUY20DCIeWKes/eNHz8laFM9J30UslYPD8RWK?=
 =?Windows-1252?Q?7eg/StjR16STn+TY1nnjGV/VCxeCQOKofRRdfUP0NWqPa3tIf4FJPerx?=
 =?Windows-1252?Q?jkRmn0oXfwXIE0huACLHbU/9VRR3gcZvn/yJnOnUEuosXbNuA2WN7A?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243709d0-4fb3-4fc3-d0b2-08db6b8f1e2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 21:51:03.3577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LW56fEPSxTpv6EWi+MJkOu8itTJuAsfZ4+XhLI67E94l92I6B2LPWP8XaoCdppkOOFwp2m0oayLQgk6cTThovv+3gKccYfm4HMiw2RlL1K8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8680
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
> Sent: Monday, June 12, 2023 11:26 AM
>=20
> This is the start of the stable review cycle for the 4.19.286 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 4.19.286-rc1 (0312c44fe=
575):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
97025898
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-4.19.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
