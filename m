Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA99573678E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjFTJUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjFTJTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:19:39 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2115.outbound.protection.outlook.com [40.107.114.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98AA10FE;
        Tue, 20 Jun 2023 02:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jy+PkaNpT0NPExBNg9MbrbYh+8ND4y86LOOHl7hovsEpUBwDaGjsItmYMH5DHCi0ww5RvIDuwKPEYqJE2L+n/0OHRjhs1+chJQcYvgWsqM6JaJqbybdZElrkUhb3xFP84jaAVcJKSlyA3tmUSZ2FCQj77bp1C4GFc6EYWZLBhQcndGSuUDGWAX6xoR0uVMrSvGul4b2fx4kSEDonMObZacb4MeGViQp3mV5Du+YT7PNKh5h9KrdCosltAkTwwAQJVI+K8R1Jnh7N8cgmZA9nzywx5Q1WxaKQwAhz4xtOalprp2BvSXd2k7LukDcWsT8BFGecID/H1dkINTUvf0cedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMhm1mJjqz/VgwhZ/1b3gaZI1QHheWXgLIlckoDooto=;
 b=h/2hGldfTcfWwICIZqNyvGNgOOAUi4pM9eqddRnEq1kIJj6RSKGSran2qGUpqUYQlFnxtiHChN8rGbXDvHBZGD4KtN05Fgqq0mdf6EHBuNj23Dy/uLyjXuoFWbQhH/LsaZh4/1kIxgJjw94tLtP2xc8kdRQcsVjg8SZcpyNBA1yLEaBgVRqAi+O0kA8CJFUJSzhx53iuRdfiw+lfbygli4LoRP/sEWENg7uwsx/cclaMJXhP9sVEByjs1BNSF/LFTjy5Lfvix9xETAE2EcsaB0uJgnbOOGh8AirDnSNDScHp0F6iRqlm7WqKaUKBknsTG4/q5jzOt5+cuIK2XxQkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMhm1mJjqz/VgwhZ/1b3gaZI1QHheWXgLIlckoDooto=;
 b=dF+2lN/MRvMiv8bdDZvw9KQMlkZx30C3ASQ6s6fVLtndqKT70+hKg7r63+Mk6lacub0wB0HjflBHcR+kaE0kO0pRLZyxOJrtljRSHFRFc2oUBAdDWGF4v/NM10hXzEhkhm3gVRLpyaj6Znnli2uHilIcN/nn+v7GFJjvDINvd4c=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS3PR01MB9414.jpnprd01.prod.outlook.com (2603:1096:604:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:19:35 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:19:35 +0000
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
Subject: RE: [PATCH 4.14 00/32] 4.14.319-rc1 review
Thread-Topic: [PATCH 4.14 00/32] 4.14.319-rc1 review
Thread-Index: AQHZopkN553XPHtI8UqOB8Ga6IN0O6+TaO5Q
Date:   Tue, 20 Jun 2023 09:19:34 +0000
Message-ID: <TY2PR01MB378866F6D11A492ED8A8560EB75CA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230619102127.461443957@linuxfoundation.org>
In-Reply-To: <20230619102127.461443957@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS3PR01MB9414:EE_
x-ms-office365-filtering-correlation-id: 1c17d068-c6ef-4314-4543-08db716f76bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ybbO9QMzLMh3MzrYP5dG0B/klMZgxrO9P/5SHc6W9DArY+O3PbBNWY5FRfLELHRq3jZZT4hqAUuEjEEjltGFvkrp5h0CbgBcEda1u3j+BRF4EXQmTABX9O6xOo6VaZPnjDpYHNlDPBvr806EuNoYLmFmhz59dJKaP+AM/7GlG1hZDGZnQM2qiSSbfvWgUt4NCZkeJl6UkbAxHh3j1DH82/wWjV4z4mev67HLX84qcfwTopNmciS9aLGETcNqRZljtkXjwm/XGEdh7uIyyWl41dQQLRCsGDC2/PBp3pnlrbIoInekjfjyul/vueIYqOv1C6486Cs8sbanwfLydlhSvc8Lou70Tmvo/LmErShPkWRWv3l3N4tDqz48/Tk6DGAvCEVtcKfT9HMabt+LmF2jwK74cFUoWapcZTDls9/AITSK7bAefvJZy7MTXze/YHyjd3meyFJScVE/AWi8jBXXTJVvj8mRkWQUh7BNWT7Bby1+6hM2tgjhZzVOMxoA9bwjrVyJFuL8q5OK7MRghdA4N021Hdd3prhVUuWYNeyO6+5JKBmBObSohH2ZEtOPWsgHsl4z70Qvm4+oKpVIJLniL1LMnELBTszJYMnVlD1gXMyq0in5fmfEnNBFTvaKjitmO4jRLkeGwmwOG4GoE5eZGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(7416002)(52536014)(122000001)(86362001)(38070700005)(2906002)(4744005)(5660300002)(110136005)(76116006)(54906003)(64756008)(8676002)(66446008)(4326008)(8936002)(186003)(66946007)(66556008)(66476007)(26005)(966005)(41300700001)(38100700002)(478600001)(9686003)(55016003)(6506007)(7696005)(71200400001)(316002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?WQczSIZMboXe1dqp5/p0Gfsh8JX6Xj4DmNuLGlIk65jhlnvyptgYgPuh?=
 =?Windows-1252?Q?3nHjDAJKpUSKWkIwZfVUY3KYMj8+spaL+pJezshhM3UyV3WVUOT4oYv8?=
 =?Windows-1252?Q?vJX+Zcw72uJUZXL4J4HOW0cXl/JSQpCc95Q3qXDvIttC7XT4l7DNNENI?=
 =?Windows-1252?Q?bNEK2SXT5mWdm9q1fLNbRIKUeWEQs9SAkmkfTg5LEUi4y/xIl1vMBhi8?=
 =?Windows-1252?Q?KBSRk0q3iJe1paykmxQO48+iFQkDLkZpAXi84Te8GEbuz//Yu9HOb/qK?=
 =?Windows-1252?Q?Y3f9u0PSXpjK0Ebhn17h6McIU6JmGrG6Pf/b+Ak4FYy4E0hCDrURgmDX?=
 =?Windows-1252?Q?udLJ8jqBOEieJcZg8K+VT1tUmSkbIV74K7rBVvjZHSPw44tvEaIcWgkP?=
 =?Windows-1252?Q?6NLrD+qxtO8QM/J4XIRKIfLxKZwAb+/zwIiM1Z21IBAYQqjPI82xx47S?=
 =?Windows-1252?Q?kwnFx+840Xd2aQWoqbR5HNxuwuGq1LV4J/jEkxA6GFbCbYsG1J7q8VyQ?=
 =?Windows-1252?Q?I8LaZ3QasNmOxTHNvHRU4x1vj/O6BIq3RkDOLQVT/T2rIUOyeX7ILYtl?=
 =?Windows-1252?Q?DHXcTrBJCppW2PXWemD99Nxs+WXW6oweSyHBoES9omIFmeNzsspPZh6y?=
 =?Windows-1252?Q?3u0NZ/567pyWBsctsuzrXOKviT4V64IYNK+BgOQ97IgYR9P08hd782+p?=
 =?Windows-1252?Q?lbvPIKD+oiOYZFrvRPSPwg7Q35NJ9LXjsawqFzxNJSEErxadNxiMYOVA?=
 =?Windows-1252?Q?5+lv8SjEGPx7AW5xHRHvC9nIhQPu/N3ISVfFKRPBU60idwLTJU6NYBrt?=
 =?Windows-1252?Q?CIIUD+O0YogW1bn4s+ecWBywuF2ux72R8CFUyijiW4JMK5X8EPCz4ThT?=
 =?Windows-1252?Q?g621/+TVT/rGr6CoIGkHP/spnjRzbDp7zGMF6i0UdrMxPBu/qxP0u04T?=
 =?Windows-1252?Q?npk6AsAF/5o05/6OIA+h4gU52FAaEKtMIpUyBBIsyASEt4iNdbVy2CQc?=
 =?Windows-1252?Q?SxK88bBJwg7JNmnlF+PkwbqIY96ZCySRL8yNH6nq907Lm8S4WNf45nqO?=
 =?Windows-1252?Q?woJz8OW3YtpmZNHTyid4OF6A5h/5GgN2n6NxixoLo1t+5vbgIiFMGwxn?=
 =?Windows-1252?Q?+Zqkti8mfrS7vogbDbpFSRDlxV/GQHmvdS00foXO1AlPedAOzm4njM5t?=
 =?Windows-1252?Q?MUXUL36whh3OmZKJ8G/qNLy80Hea6h5NGlrSKHGWYLxdQBEbnqhe0zfS?=
 =?Windows-1252?Q?WinpMDH8V5lYIlD3XucjU8hA2y54ReAgWDgMx4D2h+NSX8fQIdfsqkmw?=
 =?Windows-1252?Q?cUIlZQw1poi/LLJYtj1jKi9QaigDPW/M8VWseV0LAiHqn1WHd+rHJife?=
 =?Windows-1252?Q?DWe9a9irOkcYt4ucQJt48XKr9mc6yT7lXtXrwtRp1M33VfcYBtwfbYZH?=
 =?Windows-1252?Q?J7OGIZZBaksl6OMPa1y/ppy0y1SdUs/elNF1HpKiE34OuGSkzEJ1aRBj?=
 =?Windows-1252?Q?WT7uzQZ9rtcNEoCV/NedItGWwr2WvZWwZONU4qPLkw/SQtY+Tot+uWqK?=
 =?Windows-1252?Q?sHhPidHPBAtVjfk6R+oRiZ6dHxQyQAraVzvrP+a197oZA/xRru/hWc+5?=
 =?Windows-1252?Q?qQL9TLZ1ZY6hFB4iV7rD23fkG1KzKulzO1/r8YQ9A754GMAJs+2G2VhJ?=
 =?Windows-1252?Q?JA1De77C5ZCFDwQqkG2odTELMQ70IjwO5c3OCEpM7/OP7vBJTPiBug?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c17d068-c6ef-4314-4543-08db716f76bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 09:19:34.9878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Gr6YOVUl7eRMaoVE4LRfYTLFtCJawcszbTTArZC3urKfHW3zhg31/Issq5kFbUqAH2Wz+HRrJpSRE+c9+isIca52hZRd2wrSXc3oMbTOtU=
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
> Sent: Monday, June 19, 2023 11:29 AM
>=20
> This is the start of the stable review cycle for the 4.14.319 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 4.14.319-rc1 (30c57b30b=
667):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
04359282/
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-4.14.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
