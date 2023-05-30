Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE7715E32
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjE3L55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjE3L5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:57:54 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2133.outbound.protection.outlook.com [40.107.114.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C28C185;
        Tue, 30 May 2023 04:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMjHoiACXDc32l5arxWUT+66KGuuwFeJd0QLPlwZ3XUW3o3ZU4S4HzK/i3FrxdJPFafSAxwrlXb8dW0k4WWG4AmBYlehqEewRssEV/nsBVXfPBmhZeY5gWNXaik9ETeuvxFV5D/ixNZxyGezdmOPhrtyrRSXsJuvSfNrpHHJt/vkvGy2O4qVJFHQ7mmbyhdFUVbOPkczzExdCno10Tby7LYp1wW6w0zYaMhfCAeKxK0wrdr5mpiTivkJor65ksUm31xOreA9aLZeiRSWAhMKexCe1ZsnMenbEcaXly5TONzODsvHXcQCv4ABLYi2Qr074euHaxqTXcZZnKKF4Gmugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMSPkHhUu3TentykL1BblH2g3dsj/bJ7OvrFXuZwT98=;
 b=GcZs3WZSQMfL/ueGdQXr2htY+3LPg1jmL1LOFeUgHzSHu6beHgk3+MWWmoXF4yLuV/5IVnwSfXuSOFL77OMazGnD4ejL/OHGF20pSCmrmYfdsg8Ok/88msI03mCqg1leKGduMPaJkyDJ53lzSURj61nHptLaGv4LegjSufvGUEFIhthVfi30BWv3TTiFW7v0fi1S9c9GeXlpbuA01WjmGVvnbPqKausc2fv1aTLd7sV4XWn6565KaZa/qDS8u3ZuxKGy9syzbGisg1BcwAM15jweWo4agON8w5yAWtuzPo5fJ2JQbsHIHZid+pzUQhK9VhwufzSpiM6/yY0YJpeHiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMSPkHhUu3TentykL1BblH2g3dsj/bJ7OvrFXuZwT98=;
 b=SywvfuA++SiLEq6EPjqpx4x+yuj3K8X+UWPUAfIgDqLDCuSu8gpYAvGwJCeBibETdr0eAeyDSG0mnG0dI+PS9KIiFIpF/mFltSETr9nkwypIwOVjnSRDTojGW1tYcSCjgBss/zWIh38PJ8OpVPSShUXWwUPzDOzdxDO19SpBWwE=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYBPR01MB5390.jpnprd01.prod.outlook.com (2603:1096:404:801c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 11:56:02 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 11:56:02 +0000
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
Subject: RE: [PATCH 5.10 000/211] 5.10.181-rc1 review
Thread-Topic: [PATCH 5.10 000/211] 5.10.181-rc1 review
Thread-Index: AQHZkZw15cJ5EGK2ikmdZmqMXyPC+a9ytREg
Date:   Tue, 30 May 2023 11:56:02 +0000
Message-ID: <TY2PR01MB3788AF39415D7FDD6EAE5FFBB74B9@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230528190843.514829708@linuxfoundation.org>
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYBPR01MB5390:EE_
x-ms-office365-filtering-correlation-id: fde007ac-6713-4660-55e1-08db6104d750
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HIMjyVeKYpZb7Riy70sqr+ItmQ+BL3Ib+SVfNV7hglMpRkA2GZTW4nFDXITqPKHwJ1pzS6RHczv5HGC10qK/dDareEkkdlyztB3H4047HamrQWau52GSXUqJ2HdtGxLQ34GiTwcJGtHs13L29/tIkgmYSBEwlqFad0EDmCe3+srx/II+1wKIi6J37D/2n+8ZORgqjoXN0EeJBuIqjcd45AqtQY5uty2JdqbHWdf4hZTuMLTksC6KybjMeGe8va4G7BUIpMHsNVWVqwLcY+4Ec+LHLFlC2IXft2M15681TK/+CELMPNIwx51RAAff4vMhpVEAa1sfR/QidAOgJHJ22z8mib1dpKGoo1beAFFkpxZnW8KmLSubDiVpuEhQpymz+KPX1ZgogE/Kz9Q9Kt1tlaO4ifJpCV83EfIWAT++afVEKD63rl4d8BZ3hcPAJ1J4f6zH9yHBeCT30IWncQBnjpFYKrIonarcHIBUy1wNlm9SnwmGZczDKs9e9Sxz6RVxAVo+NRadNqvbEGsDyW9yAaz3PDW4GPrCCNaTR07ZA55/4WzjCp3AhUxi6PhvEdhsziHu6Gzfi4SNm/ZpFYaB4P2tIQpU0xuhuyFX8cVEPScSKRjuS5cOy6OIYn+DrlO2QVG41WHpSyPgpWIMHWQF6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199021)(71200400001)(478600001)(54906003)(110136005)(8936002)(52536014)(8676002)(7416002)(5660300002)(33656002)(38070700005)(4744005)(86362001)(2906002)(66556008)(66946007)(4326008)(64756008)(122000001)(76116006)(66446008)(66476007)(316002)(55016003)(38100700002)(41300700001)(26005)(9686003)(6506007)(186003)(966005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?B0+9fx77AnJV05d+sul084ESUusxtBExuEbrJKkskhj4h2UAMP9hw415?=
 =?Windows-1252?Q?Wi2Td6b9W4wnUo/+89zetEJ9cOxEEmWVyK9XlI2I/paFfokHORy4u6Iu?=
 =?Windows-1252?Q?f3WTn1bRbd42lKjdl89HSjUnMxfVeDU3M/AYqXG7jUrjyg11RX9EEBWz?=
 =?Windows-1252?Q?z30LmSvc3HMw58su9EiL0XJVxwWiUIJNwNXT0gbpwd3fzUmnDCu06arz?=
 =?Windows-1252?Q?Y5wPg4+IBE4Ry+i1DdoOpT9NMo+O6RyEsP1c9cISUW97bv/gxdhEiHK5?=
 =?Windows-1252?Q?XmrWCTCRupWyqHr+s2WWfL1aWOlgs0Ie8srsu0RYAFlpgXP3zqCr6qLD?=
 =?Windows-1252?Q?PwB2d6FY6AhTf2DmFrrpGKthGmJU+OUuHUZdziPQfwJdfNA9YwbMgWpa?=
 =?Windows-1252?Q?RYOBXQozDWX8ch2XKYJkhEQvxfLut3b0Fu8qM3ndUaOKtV3MMlYbhwf3?=
 =?Windows-1252?Q?YJYl6oj4ba9B1KGA9woY0sbrbihlZMLoguUHDlLAGrCA7TsPLkfPMpuF?=
 =?Windows-1252?Q?zs8PskRYLzHnocg2+tb7DAmRvirTE6U9h63vXUxzWwwh0J4/y4did+tf?=
 =?Windows-1252?Q?l6T0tvap35PAgbBVxqhn+5ifC3syAWQYeG1IJzU8FfctOnKA8N40q548?=
 =?Windows-1252?Q?Oom2mkTM8g4NuZUBAbG9AvXY/D5qKs8QBZk4ufysNN/PxBYLH39gFG1k?=
 =?Windows-1252?Q?eaUqLVtJZpgj/VqI9+hE8il9J/V3xdCIyDN/CWbZXiupPXEuAvhotAhH?=
 =?Windows-1252?Q?CVDxn1U0OfSfIKHZ61jTKc2z9byOksN3kqt3IidM7lM1sDBOxPWfVzL7?=
 =?Windows-1252?Q?RlXEMg7gU6MmygnCFY2Xz9zyD0JAx4EHiJBy2F+Vt38gUtdmvoTdIbKP?=
 =?Windows-1252?Q?WRCIHOhlUZLcQLwmkGaIPyIk0sCZTQqvRSq02vlWyL1BrTaai0FAYoRv?=
 =?Windows-1252?Q?RkwkpuCGCTkQvzoWxJ+XivTni06FGliJc5o1ZvRm8f5zEO5nBxt8CjqS?=
 =?Windows-1252?Q?yU9NUEF3/ajG+GPDB/n+PEQBLrIRCyJhQGnGsCmdfuNPScKzsRMg/mWb?=
 =?Windows-1252?Q?9Ia/HmzENeYZ+XYRkUdsfOKpHItSPA0zSbPcXB2usEE/bBu0ACoek70M?=
 =?Windows-1252?Q?TuxU6hDYsL+aNgoV9PGKPE3Qp8eLWfpOGv/6k0z505NWVaLEXYId1aw6?=
 =?Windows-1252?Q?6QbLJPByIzAvW3s1xQg0cu2v2FupecoMPY8Bje37vP5v42zbg3DR/cpj?=
 =?Windows-1252?Q?n0YYNV63Pgr8UUaEQSyMgFPZnWkDj3pqi+GGMYy4UGWOs49mAew/bLix?=
 =?Windows-1252?Q?YzAoNIYBypnxqqI97hdVzPAhFOhAeDX1g95iNDxrJAr9dgGLPSytGhvU?=
 =?Windows-1252?Q?rLg2CjRe+3i/EYXwRRFnPJrI84kpvDsoUuF6uYuIZR3JcjhQlp/buG1F?=
 =?Windows-1252?Q?zef2/24A3aA1mMi/PooWS958tBI0Z5TZ+pxa6vVT+fj/0vHH2i82pHJq?=
 =?Windows-1252?Q?UdvwSYqnvE87zK+6U0wEqyQAIGmKYNqKZ7b1Jic1w58qK6NJa84EyKjN?=
 =?Windows-1252?Q?F00IfnUn1D77dxyLhR+G4XvCdXPIP1lr9oT5IAbgJJEQcIYS3SVc5kbV?=
 =?Windows-1252?Q?mwtFOYff4foI2021hX1v2YCS5oNd9u3vz/qffUa/KBO1yj8sdfkugkHd?=
 =?Windows-1252?Q?yXs/+ssVFqeXr0HafLfalXDT9weOX1JTHX8T8xTjCuy0u2FEqvziJw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde007ac-6713-4660-55e1-08db6104d750
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 11:56:02.2879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VT2DSli3WKtDRUFYYUPka5/Y1GZikb8EUur+zmNCBxhtAHxhz3fvaz3yakySioKwCRAsD1Uqdc+QyXTscLbyVGaSLHrnfNIyFenIzkObZOk=
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
> Sent: Sunday, May 28, 2023 8:09 PM
>=20
> This is the start of the stable review cycle for the 5.10.181 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 5.10.181-rc1 (80ae453d08c1):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
81425018
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.10.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
