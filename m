Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0F46FC82A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbjEINnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjEINm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:42:57 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2107.outbound.protection.outlook.com [40.107.114.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5B0AF;
        Tue,  9 May 2023 06:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz8hqX1u29EkArC/HQE5YZ2mqfHCZQ1hh4nssVqjLBkrfg5WTlpbmE0lW3HWnU4BS7PJ0qPrH8im6O7xh+SWSuPSjbQl2CGyPgkZ3OMjeIb7xB2n7b2DNTV8ZjtkSSPdzv0u5UilYdxl5uXRuZ+jPdABOPUhq9MCdrFS21Ml1rNH68/F/ZvL/3Hn3lFhIrRT2axTwBNJqBnKiBz/2oJe5SerWjTuIZrG2u336pbt7XvHSc0mSdUNWNB48yMxGUzBXSKqRYP4lwIR3unTT7GmPtqldwIH+iLPlZpccRzUgS4ZfNuC+bE0uFBhyyAal4sUPub1ymOXHFpNDdOQuZBPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rG5jhwqpaYuR+XTF5xbzF2649glEvvWwhmHKClrNA/0=;
 b=LZiSesSpxy+V/5NM+iRcZYmbMHn0hPLX2chupEL0wmSNs2ObJ7OS4UTs+NHwFRHulXxztU9BgjS4Vka/RxeCw55e8CapIB7DtQ45VVHRpmnO/coP8jlol1EMizUuTUAKei2q7aoNz1anTAKOgjfAHXFguyvf6jp3FAdfI3g13Arf2ZKou43M16I7RYR3EA5BCNQZKJFpR2jGNZMBJFgObo7civST8xp7RHKOmwcytnorlOkX5S1RgpuWJWFgVmX8kBzCuh+LMOMXKNf40cJ4rThhKmSK1Ca8JOqRAjGjzuxL3PjsBO4aa1l5d4Q5H1hN8TkM+iRlBI9N55+Gp0rQ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rG5jhwqpaYuR+XTF5xbzF2649glEvvWwhmHKClrNA/0=;
 b=pAx61kUTFaG33gTAqnT8aGz2fzqUFpU+gkuq/aBcSS3kn5auDkBr5+W3g1mSqdebQV8QgRXniq4eOy5tqLO7XSp27YnXAM6SghwS518IbgehT6mD55UGbQpXpj1NDPkyqcWWkLXyw57QeySGJtuGbkMr4FmFAIrKBIbt5vbHZE0=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYAPR01MB5850.jpnprd01.prod.outlook.com (2603:1096:404:8056::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 13:42:53 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8c55:9dbb:2418:df89]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8c55:9dbb:2418:df89%4]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 13:42:53 +0000
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
Subject: RE: [PATCH 6.3 000/694] 6.3.2-rc2 review
Thread-Topic: [PATCH 6.3 000/694] 6.3.2-rc2 review
Thread-Index: AQHZgiZnFxYNB4czcU2cxIRQrYhiEK9R1L6g
Date:   Tue, 9 May 2023 13:42:53 +0000
Message-ID: <TY2PR01MB3788BE388EFD912CF7B8D5E5B7769@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230509030705.399628514@linuxfoundation.org>
In-Reply-To: <20230509030705.399628514@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYAPR01MB5850:EE_
x-ms-office365-filtering-correlation-id: 73ad281c-35db-41be-2859-08db509349c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 61DZ4t5PkXE/gn0IyA2mEYxSZ3p1luGpPWeq9eyWKOtmD8hm+6mdTtOk1bW/KlkiWHTHpa0jS1byBQnfHJmEIvpORVlJ/7plp46GDu/FWyo8Zt/vtlKvI/cgoRfX0uPCft8pP+z8MZa8DAgV8jPev4eHhcKZh5a9tQBnzbgp2iXUPXnvl0BOIonp3CSUhrbJs7j0FTkCRR1ttSjTzx3sFhA3oU4YT66pZophnQFbtn2r6gvsQ5pJNBRPYRkvrapUZV0haxJDgZX0lBvJY1WUaDHmbRMFFXHPeTJYbmup4iDKzAAmn3eBzjJ8ndilti2H2WvzSR9QDZ+PhVtkXjWlpC7aX6T5ypNOTqoYiJ8/Jim5NdDyAvNTv3+TPY9u5VSC/wPim9Z6k0q3Zdg34f3kdrocptlQoCK0vjj0nhThfLSrEhA3K87D4+w7MJdFbmAYVxc++XCRo2ZTf1bDVn+VwzO+Adi4tQonx26XUjyyINDFOQ46+4PlXa3opWsqOvpGXFfCcPWuffEaF5zCb1K4ENuPMPJLSNRTVuiBAjAQQcztNDGW0BIwfF7x3Ah7ApZt7Zy8Ni0EnXEKZ1SvVLmaP2qltBluDzMSmarz9F/+N+pPjLjJZOHtIx2O7iK7KnZa4kWDBdvoIzN3y5OvHz1s0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199021)(86362001)(33656002)(966005)(110136005)(54906003)(316002)(478600001)(76116006)(66476007)(66556008)(4326008)(64756008)(66946007)(7696005)(66446008)(55016003)(4744005)(52536014)(8936002)(5660300002)(8676002)(2906002)(7416002)(41300700001)(38100700002)(38070700005)(122000001)(186003)(26005)(9686003)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-3?Q?d4qQEy+E252gjmWxl0Kilqd0oV53adWLbK3Soj6yYyDjTUfKNXWcwX2e78?=
 =?iso-8859-3?Q?JfU2ki7a1sbUW3UFN945ZNQwqimB5b+3zLJZfd33P0LzdfwJ4yGGOiXx3/?=
 =?iso-8859-3?Q?UAlIOAubNiB3Qi0PzMOIT/m9HLgTV6r55IwRtRoxAIgwS0oVeNTa4wGKHZ?=
 =?iso-8859-3?Q?A4JMEhcnkoHI+gpf4ukmaaIRxZAxa6Ssb5IO71O8VCEKH/Nb9q6n8Y+74e?=
 =?iso-8859-3?Q?wny/Q+wDsiNmJ2pBVwwnshoY1EDr5jYSQJXl8sqx5vLgkJtvfP0rEn+qpV?=
 =?iso-8859-3?Q?Ebv3Zrt+yjRd6QMSRL6Ig1zU+dEKy1xqfkVBN26QLSTz8b1PDSdy2/oh/L?=
 =?iso-8859-3?Q?mlKP/n2lgfPdaiVow6y6pKwdHuBZYWd058h6ujIGC/Z5jPZo39QSRknVPg?=
 =?iso-8859-3?Q?gNQSeZ8RWPDQHInYX0oZgMhmdYEcJOhIvC2D+Z8wL69C6CUGUfrWGvx7gb?=
 =?iso-8859-3?Q?oMd6i3xHT8wJDj3Pm2aHrYR8IVYUNIbPn5GziqfIRZRhsw1jSrqZuWq69r?=
 =?iso-8859-3?Q?+Z0ylpFcnkTcpfL6YRPd9gRibZzTE0eWlAvA6/WGPtV4j1Bh4i7kOjDt5b?=
 =?iso-8859-3?Q?Vh85KifumjA9ANekW6CxNisAwwCDEud3kmNEoQzVtomIo7PxI70kHjfi3D?=
 =?iso-8859-3?Q?9UqwbfKi5voEWktEL/NL4FfYb/e6djTbBbtZCVJ87eqQ4sO4YAg0nPn9lM?=
 =?iso-8859-3?Q?cUp6RHN/pN/fv/6qrFF59MTTNYEUXFHuPwAA/jgEuRqG5muLcjG4QU9ZMh?=
 =?iso-8859-3?Q?KOoYNNq+6xfAk18Y78lCrFoJJWh8tg8XWY32OEVHBVB7yvSrVMx7z3ZHeG?=
 =?iso-8859-3?Q?qUu908IkV1FxKytTySunL8epy9R4BLKltUoRDFc5V/gRVkw2WSe6A8oSJY?=
 =?iso-8859-3?Q?R6s1JbdGFIAE4Ybua0eJUFXQ5m+i313wk5E2hfmfGQN9im1AK7whUDSPOr?=
 =?iso-8859-3?Q?Ppq9+hwwQ4Z2iNKyeWiROtdNOb+qaRDp1PA0740z0rIt38NdQz2+QUg0S4?=
 =?iso-8859-3?Q?YS2XmOQs5QqL1/legKXL3lZ3SYiZIhYj9Sfp1gPOLxWGDP5unpH8djVs4d?=
 =?iso-8859-3?Q?YgJrXdkgbsKYqYhn7DOMQ873p6HQvchRvT2i5E5M8DHQag/hHyz/N1tMl7?=
 =?iso-8859-3?Q?yDJ/dOKBDDoomDDG6n8kXnsonNu6uBkLYmQQ47P25VC3ee6iQRSBECIFuw?=
 =?iso-8859-3?Q?F7ekmREPHJeZ82QfKgi8YMadn8jYwZhngRUe2LXSXAh1dfr6jZlGem94gz?=
 =?iso-8859-3?Q?kgL+pZ5ocbWnkUk+p8yU810TA06/DPY1qJnBQwnc/c/z0kub4Z4Cy7vE8v?=
 =?iso-8859-3?Q?I9PSB8cDUy0+MDCiXpo+tNyFwvGCUq7Vn1gHzMoTrSLnM5Gqu7efshCQEM?=
 =?iso-8859-3?Q?lvYj99OcMOWZ4V9ZFOGyusHWCUp3n2RoYBXAM6wOxUii2nRG4pTglzDkLh?=
 =?iso-8859-3?Q?leWH7LYq1zMLp0PcUmJlYcfMBMiBDCYX0NJpYnLvXXvALorO07LRZjEuc+?=
 =?iso-8859-3?Q?NPapFBJpBJDuez2c5cxBesoSJc/dt8liKe/9+XyHUfGTBDluRtJqAdnIvf?=
 =?iso-8859-3?Q?eylS0+v2jwjWY5z3j9d7UKkq6LEtDbReOGWkOO1gsFs1M9oK90MdHoRk/0?=
 =?iso-8859-3?Q?prQ7ob+jirAa8DauXUipOoH8q39h4HqZLfPetS/QuxDNtKjHYLURgfvw?=
 =?iso-8859-3?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ad281c-35db-41be-2859-08db509349c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 13:42:53.0929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8OGhs5gFDjcV56fbfOVCAqFjgXyoFkljCzExEWxTxkp2E7f1LhPXgkJAEa4EOCgy7JCOTJnuh4EqTuHD/PvHa9gIdy2KdB6vvNpBrvq7xuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5850
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
> Sent: Tuesday, May 9, 2023 4:27 AM
>=20
> This is the start of the stable review cycle for the 6.3.2 release.
> There are 694 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 6.3.2-rc2 (f1bb4e945e52):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
61545073
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.3.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
