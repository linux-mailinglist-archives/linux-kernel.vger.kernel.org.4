Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA0749BDA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjGFMdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjGFMdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:33:43 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2108.outbound.protection.outlook.com [40.107.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA2A1FC3;
        Thu,  6 Jul 2023 05:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrcMC56TIc7mYXzsnv5LIh2NqmBXiJ/jfJEHSpEPqUNvHZbC7FFNTg1YofS3KaREVIRpmlRHIY5IzkCjH6NZ+4vgPdBsJJbDYKfhEWFRZmG+fZwgZWvo+TIsPOWkvAaZxO2+OElqewK06Qf8O6rs5XZ/0KXC3S+U2j/cAEAtscKWW1efr+7nh+tOIpGeiyjgKYwSZhAAZmFkmRASchR+FP07pMA+gSEzTS/hpL5mr4kboq5Y6evzH3lgFrOlaE1xqLCzyIumg1Fcq6BjgtvMeoxVeUE8U5rnEUgfuQW1QYVeuvRag8/HARPPHysPRvo03ROcMCG1oFIk2koj0/JLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woAIix99L3mAIOrctDG35LjcJ3/SblHitII4EALaeYk=;
 b=RZTta/+FbON8y4Ujc8oQBqj/4ibNgq2EuJC5Gyvrw7wzJeRDGuNz7xRtpjXVq9rX50wlGOJyLwSvLRPDrUR/Jr2wlOJ8muGJXITEQqZqPiHiNUJ5GEXVml45at6k+UQQ3scuzQMsRT+Eh08Erk0p4FfemlKlKZtMOJKJWxcKHkWB+5ZyDW4BlYrKWoNAv65UhWu6Vhnf9EFG8sN9B8enY0tyBeIF/WnuWEMkOumPC9V0Zx7DKsvA5YJW+DzLsYN5wNX0a3Q1a6EOxEQb4uLredtBI1p0301TT4+0F1Y8WN3Z+pYqhCNj8u94ThSUyV5L0NVYQXDqXBwp8J/Y410ZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woAIix99L3mAIOrctDG35LjcJ3/SblHitII4EALaeYk=;
 b=JWvqZya7J30bVVjH/GwkKYFkvfc50ZRKRSEykn+0MiNo7FFLfr6uLx4O+/HQeZOkIZl7C5i75LgExZuu+UdH7dTI4eSB7Hd63wo9sHnJ79DCfMnjcPW/upEb/foKDKslU2+iDO5OqRJPkivW8QgeEnGyXw9BvQ5i1DA0cTRQUK4=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS3PR01MB5941.jpnprd01.prod.outlook.com (2603:1096:604:b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:33:27 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:33:27 +0000
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
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        "conor@kernel.org" <conor@kernel.org>
Subject: RE: [PATCH 6.4 00/15] 6.4.2-rc2 review
Thread-Topic: [PATCH 6.4 00/15] 6.4.2-rc2 review
Thread-Index: AQHZrlRxZNzzrhL0WEeAE8WNpJMogq+sizfg
Date:   Thu, 6 Jul 2023 12:33:27 +0000
Message-ID: <TY2PR01MB3788D087FDA8695A369E561AB72CA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230704084611.900603362@linuxfoundation.org>
In-Reply-To: <20230704084611.900603362@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS3PR01MB5941:EE_
x-ms-office365-filtering-correlation-id: 8ebec6a6-d34a-4fc2-2a28-08db7e1d32bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nRoAm1huqNwwQesJ8e3S/rOzkbY7snh9DDUcNhMEwR9rcL4s5t9cmQj6n8rCCdvKflT5iigFTYi+rXhHas2lSb73/OO/ecACrAo0H/Mj6Dqx6lhyURvePjv7xkkaHK5JcIhWtBHvkDzaHUJEpkdiONlAxdQsEpayexHj1+fDFpVgoLQn/AawSDEfDas9d4OpjviPfg3nnVlN+5drZSRYeZT3Dug/VsouZwtSstASKrKCwJ3czKsqWmXDNefbLFvC+bGnwzas2QeY1EYGdJ+/Opp3KxZTF+VLSBurAzDi7HYDuUng65zps3OVu7ZfIdeqljDBlJmATPdF475TJf8hiiXnzoQaxLLHKGVb0VOCUcfBmh61HThllTKhz+e8QqgkqbS53Teo1v+sohNi0o6xHLKbL2+S66M8i5a+iDV3e6i4yi+qgEG+V27Fvw4PXoCmz1W9HvTCyaJsvsj7diPP/1NioCwnCSGSDgQMYBNxSDtNnIQRohKXiBsAoDovIEMo9u3Pfp+qMDfrXuduJYY9t4TiAyZ8es2AwuMVY/MJo5kOSz323ZwaeikfGIOPfysAyqfiXA1UjbrDMl9WiZdtJ6KVgcDAE1mWezAC18n7B/7THb/9aNx1PhTiN8raE1wKZT11tTYj7fWdNcOUonMIcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(4744005)(5660300002)(8936002)(8676002)(41300700001)(316002)(2906002)(7416002)(52536014)(55016003)(122000001)(66476007)(38100700002)(66446008)(66556008)(64756008)(66946007)(4326008)(76116006)(478600001)(86362001)(54906003)(6506007)(26005)(110136005)(9686003)(186003)(33656002)(71200400001)(38070700005)(7696005)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?8nqMlUOFpM2+UAzlJqh64N8Wr+kBbmZHUecaGOQzKCbae2uJq3cXL54A?=
 =?Windows-1252?Q?C5aib+OalY7Kyld7g2pvnSP2jHHy/v/8OPSvYSLKap9ljWsbTQZefzIO?=
 =?Windows-1252?Q?z93Rkbxgw2tNo0pAPz25xks09hfdo9BJNFRC2oV5N8hvbXsA9Q17IIOy?=
 =?Windows-1252?Q?11yqiWQVHQRmRlkzLs9+2SQGbOHm3yCRHq3+y2qthgEFQzm+c5mSKVuL?=
 =?Windows-1252?Q?DP800of3ZI/dsAs802KrpSF26ge5R6fmiDHpb/AUIlsFFm7RU8q+TDhz?=
 =?Windows-1252?Q?Ibp1q9weCXcWUhnkuSp5OT4qoj7J+/bfnhavtDC8EDGUwiAswVXiKXWY?=
 =?Windows-1252?Q?i5MYkiT6qSDDqjvTvLZMuyz8IRZOjyG7e5a+lQRgCXERP0G6YMPBMpdz?=
 =?Windows-1252?Q?BX1Dv4iBU2Kg2Gg8JdI7p9NB+8owbQ/8ivYSEF90fPn7ED9c6c7OpTOP?=
 =?Windows-1252?Q?NF9l8tyhjClLCbVtP+cJQi16FOd+oJ/TzifiNzJ/Fp5gBjOrw1pKI2C8?=
 =?Windows-1252?Q?k3Nkl/imA6ItW1wCmfO60D4RARHNuI6s7Nc/+hsZ07VseoFEGww9aTa4?=
 =?Windows-1252?Q?SoPeel47dO3xKpPZkZ+7L0JdMFxFrv2MJB70cGgAjiE9Uf10fzqwmcaY?=
 =?Windows-1252?Q?8Zs8AinRfGVEtOvNAevwUtFWrAQ7ZT6et6haDb8De/pQuYhlLR7kNSkB?=
 =?Windows-1252?Q?ySX4KpJh+WCXMA7+UWqlEomeKKgvVpgjDmQnwM8mt82eLctuy1MWIU/W?=
 =?Windows-1252?Q?VQ+N1slOdK+1b2fY0VrI3tXHvPg0ySm855ICtWhVvwRwhEITay3VShaV?=
 =?Windows-1252?Q?wdf3UrWuWoTpZXsvR4oPqIcl95pH+ztUnq+okzkMdgxCWRZ/qldj/AzA?=
 =?Windows-1252?Q?c53/8NMRtl8gwfH55OP4Ay+pcv2h8k3Ti3DyoQFbhpTTYkrLA0qTRedj?=
 =?Windows-1252?Q?qDCk8fT3snxZ1XjmYmGoDY+OjU3Tco4/rkV6558SXUv3uq4qeBElakMP?=
 =?Windows-1252?Q?xXrnmUsO5dtrMsAMjGecQ+/nzT73A3I2XKIcwGUIM9d2i7tSnnPOourf?=
 =?Windows-1252?Q?+uNF2mhSGVoA0onPIz7/EUcOyFKaX2cxpfhswRZsA8+9IE+L3SLTK21w?=
 =?Windows-1252?Q?QbrsYVA7ciQK7wPsuIE7TRt8BVgTCRg7eIoscasFnwJD59mLIAVpYzwg?=
 =?Windows-1252?Q?rNB9+1dshvH4uvHLp3Clwxk4DLzo4FS60cMixa4wemW/GQlnS7qHwAEr?=
 =?Windows-1252?Q?k7IA3kI7EW/6OolmiYMBYDZBII+nvsnPitpQhgcD9FzVY5lVi3XMXoIw?=
 =?Windows-1252?Q?JNm2Y4xN5Wx2+LoqESPruI9vptiGRDckcI+w2X2jgkpUT42W/Ok4Hsg6?=
 =?Windows-1252?Q?+Ci5fBFXbqkKGcDzbW5mihhbIkFyBv2+42IIfgw1q+myn3hTcJVpFO4C?=
 =?Windows-1252?Q?//YB8JmPyVo2uOyOlloafHbeJVkZh97vQeFJMUNPoi8AbSfyO0mWcONc?=
 =?Windows-1252?Q?HBk6WWkTgz3Ny+Sq7r5OAYXn7C2qneP+yZCoi7htzOoMKs/v8Rixvv9j?=
 =?Windows-1252?Q?RM4YPI4I2sqUu8y/XD12pYcSL0L9PBbkcSbc6JtQAuhPJla82KqwWZ7i?=
 =?Windows-1252?Q?4U4b119i3kHbh5xCPoRD8KlMjAreR9l43Uas12thznEmCGv+6aeMSpAH?=
 =?Windows-1252?Q?FmpgDiKwMu9sJNGF0unB/+GFYn+nGrTgOh+IhKDQLmvOJPeOrBgvuw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebec6a6-d34a-4fc2-2a28-08db7e1d32bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 12:33:27.3251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +sLM0IRcLE9AaeuvEpD5SahgEjtbmOb3Wd121L5DjxJIYKPXxIUbxbRE35jGnFxMeR+4BWRchOXf4qPx8MwZvHW9B1mNpkXH23xF5b8T76A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5941
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
> Sent: Tuesday, July 4, 2023 9:48 AM
>=20
> This is the start of the stable review cycle for the 6.4.2 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 6.4.2-rc2 (289036004f4b=
):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
23134632
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.4.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
