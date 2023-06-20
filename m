Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0869373677E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjFTJRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjFTJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:17:47 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2096.outbound.protection.outlook.com [40.107.114.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3173B1711;
        Tue, 20 Jun 2023 02:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9F6iteAgGzVJvcxYPQd1ZCRXHtx0yTLbIPsEXk86ZZVdXJ/yHuezk+mP3s0QKuJ+M3ABslqY4TsecOmiTz0IUpxCkJ4Hv2qOmdCJ3qejNR2rvjQvSXD7Cd+FSZT9YLgtA98+9O7yUu+a75ubEQL91+6P2WG7YFKWL+3pF8UMG/tgx/AmUuJuT/OeQXazO3W1ydfK5CzNy7atnpRpdIYAolTJlpY4k0Z46hTr/14Z5wbGMY/aviBiiqQdDW5ZwCIjc4hjGQ5n5HfbJasoC0ERFjKmU6ZYyGhOSDtuJoJv9GeBhunxgapkYTF6q83C0jvUoYnvLymXnJ6+dGkorSD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15QfsOVikge3Uw+M/B0TlZ3xPyrgJvqeT/48KGhRPms=;
 b=EQRinZWV8Gjjc9lhppc1FLNOILJRDWnBLnCYtEspjU9TCNhLyfNYrjvDs30ynWeOgdUuY1L9Swd6el+4yOqlMTC++ppS30Szun6AGQ1cvzCz2yibMRhu5gXgV+0SSdJiEyF8pa9rRceAoe0pgJGGEEYE5vshAfBw/rZ68vPQle0Euk44E4HDEOcX/dwcxcwQBECLutxyz/p1uNxT0Vm45kKyaGoF4CXP4QPC2yEbGi2lfyQsB3ktJYbzqPpxZIw45R1G51f4zvWq3WW76t/X9qRuJOFmUb87gldZz4OcPGZvLslth1Hhb//HCxt4SlfUio1wNv159CAEANzzG9Wh9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15QfsOVikge3Uw+M/B0TlZ3xPyrgJvqeT/48KGhRPms=;
 b=KVEcAQqa0TjQNUZ8jqzKMQNXwaFQHnk+0SBQqniVMKr5Tm616m7Va4v3koIAlhmZNtoAWxaGWDa6pyhHZjaa/HBglGSActuMFEXEqoovvxuB8jPQEhbvR2QsH6ekGMy91IEIu/fhvfQOK/mR3bT9L2nqBdEVKk7rkLIrtUrhzM8=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS3PR01MB9414.jpnprd01.prod.outlook.com (2603:1096:604:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:17:16 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:17:16 +0000
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
Subject: RE: [PATCH 5.15 000/107] 5.15.118-rc1 review
Thread-Topic: [PATCH 5.15 000/107] 5.15.118-rc1 review
Thread-Index: AQHZop1FecpDdLD27Eq/2YGCKWWzHK+TaYJg
Date:   Tue, 20 Jun 2023 09:17:16 +0000
Message-ID: <TY2PR01MB378890C9A62E61EEA4B749CAB75CA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230619102141.541044823@linuxfoundation.org>
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS3PR01MB9414:EE_
x-ms-office365-filtering-correlation-id: f56fa09a-6597-4bf7-8c26-08db716f2445
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: adfzghc8JlOP+9Kc4DPeWs9lcfRP/TaYqrey1ep3ZA3nmIGiUrlHi38ccdDgqCIjjicJ2QAijnwnTOpruerQ4JCpivFuVXzGC6yR3+bZn7GRDmoT+0OeCLlWJRvnNa9aoVUpasjxNjghoFXYnRxJkhX/QMa47l5jnUDvT+YGzQLTJqkKE4p5AxrjMtkN/bzSK5YYdFIAL1HXj9//mQ3lSw+91YN82rGgpnQ+O/4qpYiS8Htik9szN+8I7rHsGtxVEeFGfz92xADpin6Epmfmk1e6cY4A7BOHu8AXRvN/+STUhbMBpUjXJ2eMU+sI64nRt7Xka7K+wJTnMT4avHJgTqY7+KiGGqQF068ey4kCg8SWJDVJL3R/egFpfEagRiFkF790ycGm0WLZePeVMiDfcSqsuKdUvnfP2/dQFP13g5VyrrtEn12loZQpH5SAAfoRF2z+SHwxQ5bkDWPpUcMuLZL1HvhXE+H5ZEQ2+tLP2nxIkqwM50tnpLA7/mlSNwzxW5SRRNI2BCLE6M6ftM+Jn7KBX9Mcg4p49oNrIZJUEY4UUGtas0pVqQPIABFMJDVvayv3z1nfsQo7dPpKDAQyJkH/SKANPBJFo0tj2dqXMSbt0v/Zt3bUQuDr9WOSX23VGIfNypl9TDirXuB48pv1Cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(7416002)(52536014)(122000001)(86362001)(38070700005)(2906002)(4744005)(5660300002)(110136005)(76116006)(54906003)(64756008)(8676002)(66446008)(4326008)(8936002)(186003)(66946007)(66556008)(66476007)(26005)(966005)(41300700001)(38100700002)(478600001)(9686003)(55016003)(6506007)(7696005)(71200400001)(316002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?Y6niv4lV48LlFw/hEgQXnj+IwWq3cKkh3JchpVuweyUzDCHjgTjWGrK5?=
 =?Windows-1252?Q?5qcxaFA0Hc+Kyz5P69x12b7N3QA1E3PWK/a7Oqihcawi217sBqXAv/0Y?=
 =?Windows-1252?Q?98Nxfhfs2/ckIwliCMHW3ABAnBIpidRbhGA093IDOztBSu4vYGNFt3LP?=
 =?Windows-1252?Q?vCwFpGE37oRY/dho/P2PfeYTwQTR0MKzH/rsHCi+icyVoXW0aHs8eI56?=
 =?Windows-1252?Q?A0Ht2EZWTb8G2zpZBkjx1oT0BerhdaNLsUpvMczwqHrAoWUcHkFLkFqh?=
 =?Windows-1252?Q?BU/SidTY1strB8Ykx5eve783GFvH6HotzTjUTuYNGhWnDbCu5HUxCKpR?=
 =?Windows-1252?Q?zlV46wgSVAVZUwd4pVBwPAxv6Vct0swHPLmGfl8o6Mv4QGeJNOTUYCuu?=
 =?Windows-1252?Q?mGC5GzuwhL4ZqdnFfCdaEYiWiEX+MmkC7P7GEBMDau5JpWLu7DYSXBhm?=
 =?Windows-1252?Q?NQsAvPCLSdG14YK6vGRHpDPW4qxQ0GODbUiUtwZWmXmWZHW4RpxWNlU2?=
 =?Windows-1252?Q?+fjDhVXacb874cMy7QCSVp/9EFrCRDtH8qfyd8Xtg+lHBQECFK32joGr?=
 =?Windows-1252?Q?BnI5jYYvxwPx2riREXm86wisMJfTRQ39EVKxcKy7z/v+oiEPvcO184RG?=
 =?Windows-1252?Q?cu1iyiqDh5x08pJbV/IH2ga3YYt8ndqdxgsjhOdpnSNhp7gC89F+n/xL?=
 =?Windows-1252?Q?y/IirP9KV5T3CWeaVOcluVUS7GjIl/biIvygfQkWCfgZwOK3hRqMEKJY?=
 =?Windows-1252?Q?agB5KjZl2QvCbUw0NN9FIHQTSzj4FQ99/qsr50G8WyDGfNq5l2kqd9yV?=
 =?Windows-1252?Q?brgJlcUU7d/AfbPYAfp3WAY3cQuSaxZQrRUiZwzzaE7uiiC/qSFMW8YE?=
 =?Windows-1252?Q?rHjOG38wNvo8owqhdJDwtmMVDinHzbSRmwGn9t9FxCpDi8n+Qt3hZmEm?=
 =?Windows-1252?Q?bWMP6FQ9tcXmBLaDvzhvbHwGDZafdOIBQE3so9p0Vqic4JiDsV5PRQ6o?=
 =?Windows-1252?Q?MGRha5HOEGsYOGpuK1A+QHlvazTCICeEknf1cztfRxkuO5uLRLPaiVm6?=
 =?Windows-1252?Q?KRDQz9Ip3rdK5o6gZd9p+drAduADkvvWbe94binFI/xcxbXhf6WozbAY?=
 =?Windows-1252?Q?e50YrR3f+eV1yghB+Fp1CkfwwXkQVG8CLdKrkuG/qzpJv2ch6GDd5Pi4?=
 =?Windows-1252?Q?h4rO7c3bEXVXmlbKVJZSl+03aAWFnEERwhoO9NoK1WFU3+0PrtnOg1dv?=
 =?Windows-1252?Q?ghyvF0gQ1gyqfD5AjOtWEZIfepyonqj6ucuoA91RG1aAx8tkispTzjRA?=
 =?Windows-1252?Q?GlkUWq6r2e09qN+0EflRHwimVgsFDCz/y6g/kleUKaW9A9NsLDFmtbrI?=
 =?Windows-1252?Q?/jtfxx80DrN+DkAQ27FpIVlcDyu9+hyd5ESh2nl4qY0yGutklbd+HkgO?=
 =?Windows-1252?Q?+TpnGUso1YqzTKqtth2xPtCaLqS/COwerScQf28IDXSD3RF+q4HyyGUl?=
 =?Windows-1252?Q?Akor8h65KBSbkMR+BF25UbHmK8D0XtXORslsntOonC9AUepOHBvIHzRw?=
 =?Windows-1252?Q?rXrVmfaOQUxaAagfY+dDqLPysIlRb4oCgxNbbCCTzogFGdnenxndAZQD?=
 =?Windows-1252?Q?GRoEJmumgUk/7s7T4nLAFY0pf5NkwqgDVT8EWITNMnlmsWCYqJoNvc6T?=
 =?Windows-1252?Q?7VGd9QXc1h+lnczGhLITVOtOvlv6Xirt5It8GQgDVhELF7W+bcMc3g?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56fa09a-6597-4bf7-8c26-08db716f2445
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 09:17:16.6308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6QfpAZTvNrRhfwss5GSTJ6yc7dWot/myRQrn4KAkfSpAFwTgmosWP+1B0bjhoXLoH2PdqPpJ5WECzWqu5BYMqzyiZB6d0kSsABxHR1eBz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9414
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
> Sent: Monday, June 19, 2023 11:30 AM
>=20
> This is the start of the stable review cycle for the 5.15.118 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 5.15.118-rc1 (71c980089=
d73):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
04359527
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.15.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
