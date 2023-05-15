Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBEB703E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245008AbjEOUNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjEOUNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:13:38 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2093.outbound.protection.outlook.com [40.107.114.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC16711D84;
        Mon, 15 May 2023 13:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYCR+dGVIEe7EGn5nzG0KwqV9P0rs/22tm/0R262ubPKTR4/zS9bAyycMbWnUuPcG9Nk2LY47WlUK3bHs7Q21g+ls2FEKYTrVHi5KE7XstRRaDaHj4BhFgy2cMz2g+QtAdM+VMMNWC5c+Qm66mb9fukO/ZR2x4j6yWDG9BWyKGwEAboqnAzWi5X9g8GGOSiS2pjS4xmOYSASCZyGOhliqSF7TrLwfL7+QKaNqBjo+67bD/3aLuer7rFLMkc9wnhNeZD0rV1D5Gp8ggYv+4CWq5SRMWHejU7GR55QF/6CNN08PrHjFGb8s5oIEIfYembhjnqCW4jMf5NGyZv715TPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKmjEDesNbfJinSwcHfmKrNSHcoskSpNQs7SiDTL810=;
 b=CESppEqGNuJXB5J/N78Rn5qRkaE10jelE+j9LRpa3ZyYNfC+9nj5fozxUfEq7IqqliTuaY7X5XEkGgRkz2lTCahCzAcL3SS7zLdkTR+B9bSHjZXr2AkuF2XtVraLhfZAz7dpFciyRhwLaanI1MKoM0lizHDkKGe3Zg3u0WxiOAGPgV6ywLK6ev0m5KWE5/y5kxuWVinHFutX6pnvARFgYUiAtcpr55gObznqhvqMeQ5OaS5zbDvE3Av0R+IdWFKxpBHRn9a10bAQ5tyM6wvmlT749Eug072cJ15UA/bS0Ih14CJXEO0+xGaJaf0OgaJbIFSa7AgDWq0b8GJsSS7C+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKmjEDesNbfJinSwcHfmKrNSHcoskSpNQs7SiDTL810=;
 b=Jj0PHCRENUOXo5k1YVI0ngCugVtxlx/KY2OpnK9fbKN6F3RJzpT5WWLu/bwmpi8vwoyWmZfxCNuy9xW9ehJseH2gOU6bIJK8fbI2oOyMINcNDLl41RCucSp2fH6ZOixtJVzbalGVW6IRB88Gn77wIjUk8XQLtZn1Xc5KoRLgY2g=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS0PR01MB5459.jpnprd01.prod.outlook.com (2603:1096:604:af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.31; Mon, 15 May
 2023 20:12:52 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:12:52 +0000
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
Subject: RE: [PATCH 6.1 000/239] 6.1.29-rc1 review
Thread-Topic: [PATCH 6.1 000/239] 6.1.29-rc1 review
Thread-Index: AQHZh094U0Wi/P0fn0emGuQAFg9Bwq9bwfsg
Date:   Mon, 15 May 2023 20:12:52 +0000
Message-ID: <TY2PR01MB378884235495138229616EA0B7789@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230515161721.545370111@linuxfoundation.org>
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS0PR01MB5459:EE_
x-ms-office365-filtering-correlation-id: ff74bf1c-910a-4792-4ee3-08db5580c346
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ELyHE2meR1B+MUhsxK5DXGFN73Jk+C8CVKCn1p9T9/o8YQ4ZNmP6v2+r3hq/KrB4Zp7NyvuhRvzbKOcXltARS7I/H4ik0KsA8aEerNUMVARJhRkWbtTnuJr1Il84/WzKK6ZQJr4HjhuUQtpYcXMhVSE3+J6R5x2xJOkEboAF9AuTDhjHvHZww28LaA8Fxq0lRxClK8G2Ar9LwTge2qTJI7WHraJQQpqdW325VCExkmZ9w7v+5rc89bAZoGErO3EbDVQZ3xhwB+TQc3Xoa8qLLWePAZNz1DDUAiSJsR9gAgeKTRL49W9HgSF40fWEwigoz8Hdwg/c0pFWjwlu/o7rDMKWql/xa0OuriUr51FqrFZrJBUJ+Xf6MFAIe/J5H7lhFsb6m3SZnHR0zL/If31W3n2VYbKgLrwWJk+YyvsxnvATTf0bTit9GxvQBraENS5iLE6QeBnFpdiSbX1HeaWEWwMSu6mYAxSnRq/4quMk695tFci6AHvkzjIm2EXCyBWV1i1CHUuh1/CyG16VrxQiIwrfA7iH0WGAQCukYtIjpeYaYylGXNTNdY6FoNds5awRLq8tdZgjvEIV6oYU4+xKCf2C4Zw5U6mD8yDJb5ldzxqjATg7zWxOesdGFWge9sWAP9awIpeTxXTXJ4IHAahcZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(52536014)(8676002)(8936002)(5660300002)(7416002)(4744005)(4326008)(316002)(41300700001)(2906002)(478600001)(66946007)(66556008)(66446008)(64756008)(66476007)(76116006)(55016003)(54906003)(33656002)(110136005)(7696005)(966005)(26005)(186003)(9686003)(6506007)(38100700002)(38070700005)(71200400001)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-3?Q?OfBdfscXPLI6L6ZWZWJRLFFZVNoWRWTdDEZxtuf2T44n4LrLGFoOyV3TcP?=
 =?iso-8859-3?Q?zNhswbUnF7tkunTy9sl9Q6pL2QS8sT37DipQJWhiv0yVyRDAeoBckAAu7U?=
 =?iso-8859-3?Q?GWnUuvHwZAO2RFOJ48X+mFc0Okt2KQAZI3Q8mBOWxFC/UCBeJzk0/FOU72?=
 =?iso-8859-3?Q?D0ZZU8AuttYNGRuM+N+y9jNTq4BrBaabqGUoETLhz4HGGiev9PN/lA+Oh4?=
 =?iso-8859-3?Q?zYITgHT2EuMgQ/5+PcFOF1hYaRMPSGHXGwcCAY9na+4+pUvePz9EO4Tgj3?=
 =?iso-8859-3?Q?WL+eursmxU/IqxufzuBGKTaG//rm3EfEg8Rb+cEerekZfVO1DCXk+FbLhR?=
 =?iso-8859-3?Q?h7szeBvLgPGmAQ8BBCV05NKBXNBCByeNbnbnQVnRpGjNv2xYhOsNCOzIOU?=
 =?iso-8859-3?Q?Db0WD6tPEZRd6kl+0VG83MGUnrStyRYvOZXQFwa7ouEQDLV/3b6fWkd3DH?=
 =?iso-8859-3?Q?J+HT5xqiHoqXdD/5BXMilbxtGNkJHqx2PS7uqodduyxeEkE8FaNF1mm+m8?=
 =?iso-8859-3?Q?L4CrKOb7qjupu4GMbZr9fs5blwTc31xBBe5rV5gqvwIK+5l26H4lthxAwD?=
 =?iso-8859-3?Q?W0r4ggqLbhJXBj+v9HaRRIvFv/13tD1p4KfczBICiZ1cc+B0dvnet608Sy?=
 =?iso-8859-3?Q?z4iRM3WmU+/fYruEr4QJHD63K8mG8TP+OrelkI2rpSFnPstGRzWUQmP7E1?=
 =?iso-8859-3?Q?3iq6Vdn3ibhEzKm9u9V0U+lnaIwhGicnVmHp95yQPwQK2XzOXFgtFo2puk?=
 =?iso-8859-3?Q?ebwtmC2l2mZ9digM6q+ej+Phl/w/LykABZyhBAemTOKaiSOOfgRN/dpHHt?=
 =?iso-8859-3?Q?3eUA2Gy2Nuc9tzK3eLF7bOWj4eDdvNzFr/ctRwefPQRpSURvMBY99Xu43v?=
 =?iso-8859-3?Q?7AW8efNJWSq8vBJVgkeUYHREOBTvCKqSSqHFK2CrsA+uLtsDWYtJPT8Dqe?=
 =?iso-8859-3?Q?j/rlqhh2L1z2RYT6AkD0xhLajHzj7LXpxRsKgBXYEo1Dz6eiBkMxyvrun0?=
 =?iso-8859-3?Q?lNvF/GBKqVQB7SAa2stSL/N/qpcq1k8L/nIByCJAq7pA4fTxGXAja8s41+?=
 =?iso-8859-3?Q?I2aXm2pmcAxuG9y/fxFWb+44G5TkRe7tps8kv/X/pcTltfxwQya1eBzGim?=
 =?iso-8859-3?Q?zvSBCsARx6BKJLVUezSlJ1vqT7ZWereTqGay5FIptvXiMMfeltSKCw+kqy?=
 =?iso-8859-3?Q?DT9zIZ4DXEA4wn7cHnmhfenabG9FA3XIxRS+wckUXDA9AWGk3hbzTuvFk9?=
 =?iso-8859-3?Q?tlKQzJp8sm/Z/fXJIJ80/6GJQUeiKsdfZMtXHkeg1FA5bUmU7hQffrCzsq?=
 =?iso-8859-3?Q?e7FKuF5luweY2ue2vQrvzlkHYzuJkL7DOKNPYXOAwXG8sjmrZ4gf5/9V1+?=
 =?iso-8859-3?Q?jQCviLE8eaGRlKbnNneJ3rgNrd+SzifRjTucuW6ko6NCrXeLp3HpUL2s6G?=
 =?iso-8859-3?Q?4X/20Pb6ObBMA/CBxtoftfTUMp6pvoghPH/NA0ymDIIMne1rBP+tUUIS/y?=
 =?iso-8859-3?Q?avUG+SUKF8v1LFlbHL4vm2JPbQFqcnsuljyYpEdyunTFFt3pZn4o92F3yy?=
 =?iso-8859-3?Q?NiPtl2FE0PEPnpw2mWtsmwZH6NVS3nGL+buiPU99uPYMlge3V2S0lMU2My?=
 =?iso-8859-3?Q?mLAARjzM8Sz7u6WcBtfwnAIu6KnVn2CgooTOERtBbRmnh2mNYLtsa2/w?=
 =?iso-8859-3?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff74bf1c-910a-4792-4ee3-08db5580c346
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 20:12:52.3032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sloPZiAP+ifUW8T8t7aN9MxTksLUf20mF2McxE7YgXQW57Y1FtpGLqb4wA3gO9wLkMVJmdZmS25uJ05y+9KoUW0MgNtBMLNCMSOKCGIKB7U=
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
> This is the start of the stable review cycle for the 6.1.29 release.
> There are 239 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 6.1.29-rc1 (b82733c0ff99):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
67957755
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.1.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
