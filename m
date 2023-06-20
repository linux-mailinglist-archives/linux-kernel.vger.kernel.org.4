Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B05A736785
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjFTJS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjFTJSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:18:18 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2133.outbound.protection.outlook.com [40.107.114.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48752C2;
        Tue, 20 Jun 2023 02:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRjtMMW8nthwHJwjpdN8WZB6SbuRP5FfAw70mcVVazeYoQdmkaYa6Zs/YqA094fMOMlFBeWmyEtCM5fMlfNiWeJwcCqKymuqe/t/1BHuTqTBnic8GTph2oXORbIS7NhBlvmT+6w+D7JNAgw2+jkeFYLei3zSj4D5nYMoroTXqjiM3gkQ5qq+dfIUpYfToirnWwc4+YlsHG0uWjYp8yeG7gqqwg6+Wg5N+Gv0nuKpU3L31lHJKRvzksZnd3VBXzeJ8bV2j30b3kqDmNwnToEovlZJ0gQD+rf+hO9lAMQIFZaMH7A6+VvvGZI5dYvG8eC6qq9ad+lVrvmCnBYz8K5AJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ut4QGT2RnQfRqvlj5OR+mPYJFfdif0jQSm6uVPeeoV4=;
 b=db6vaQhNeyZyJg6aWEEYsN+6q2LxiwZdzWuC9GP8RSSMRXUHoSlRrpPGYSxCgc0vvB8BIg4/+9vnvK+P2A9nQQs2gun3a2Nj32RbtHR5GBU9vbzwAu1c8OBfTIuDCsRPby4EMY8TYwSqFbTFns30Libw0+3EcjpUioyffmabqLfW/gP+r0P2/ByAt+RuwUecitqUAZ0uxAZ7FiZtrwChKRsAOrVFli3sfBAPuSds1W5cGDUhkQ8ZermqraFZOilg74zoS7J66cwyPYIxWfnUWbadi4bGtgy9iNr7+J3aOqmnQpp2ZzlacCtUfWvcWrM2uouRIr8K8P9+9a5eMWcWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut4QGT2RnQfRqvlj5OR+mPYJFfdif0jQSm6uVPeeoV4=;
 b=i3KsB0P5PYB7QdXN8lmKUPbHhuPH0CMQDilhlzJI3XPntu4KcjT7Y0qXpcoTGRTW+rLI2lgSY3qa+fcoeEYZ9w7YOotsxhXqBPHSq1vX5Xjr6MblI6vbiFjnWz8rAdVmBS8++yBaY0iX1J4sEfl1lJ3Ha52ZYOCBfI4O9+l1RcY=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS3PR01MB9414.jpnprd01.prod.outlook.com (2603:1096:604:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:18:02 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:18:02 +0000
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
Subject: RE: [PATCH 5.10 00/89] 5.10.185-rc1 review
Thread-Topic: [PATCH 5.10 00/89] 5.10.185-rc1 review
Thread-Index: AQHZopyk3x5hNuthj0SFzlVnv05lma+TaWjA
Date:   Tue, 20 Jun 2023 09:18:02 +0000
Message-ID: <TY2PR01MB37887F3C5960D2609CC9EFDCB75CA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230619102138.279161276@linuxfoundation.org>
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS3PR01MB9414:EE_
x-ms-office365-filtering-correlation-id: 4e5754be-3e11-4b81-cb23-08db716f3fad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lfjPsJ6TpcaCJs/B3rqATsCiJeHO968F2GA81UraQQrOmVr8P0A9+5xsd/EoYDEF65/ylwS33y8K163jseYbclseJIcQP5ISlselBe2xa7vGiDCZHqZRywlgqQMEisp3zaOg7FiHEmFYZDubgZzF7Pd0BTRsXgU4bfrJ2jJtg+Wgkg1x8KOSc0bGf25IXONQ3naHo0E1vjJpOtGdhbWXmltjELnZ9sNlgODz1hu5Ph2UMSO/BkrD9Uw/v7Lhqz3lkufZ+RzhCvxOUQyEalVXfp99OuRNJ3O4QWeMnpMwGDhvlFgt8rc+oQWNEU3XNfoDiwV4YJY9JaIac5kTNw4Eqa3zgC2dmWCh9wkQqt3pSB/5jjgFzfK7jsooXmBzXhMM9quUQYSuzdf11WswDITVgs6MuCgOb6QCxVdBVNwa5IAKzxCRi96dioTrIWuAWl4+7/dMux9VkWx/JA4IbNHb/quiltjqzK6eqQR8DkzHIm7otfHUOTHfq30ZNir22Fa0YE9Gp559bHIXUiYHZLgbdsyGAVHEuzA8ABigrbYvy3A9bVyliiKxkSCdT/Isj6jx8XURywAgfrSInkOkhQBydmNRMR0Cm8kIRoZH8MVyJwtuZ1TPSBAWdJHgg0qtTl4mv9HneqerZ9QSqxjP0RXaaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(7416002)(52536014)(122000001)(86362001)(38070700005)(2906002)(4744005)(5660300002)(110136005)(76116006)(54906003)(64756008)(8676002)(66446008)(4326008)(8936002)(186003)(66946007)(66556008)(66476007)(26005)(966005)(41300700001)(38100700002)(478600001)(9686003)(55016003)(6506007)(7696005)(71200400001)(316002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?osYBBmGVoGqPxwZSr5ifYXUYAoLQ7cRxLHWM8qTvkMwySEKPoIPFS1JD?=
 =?Windows-1252?Q?IE2HhuiwMqVkcCvUJQx2+IwKnXntgKA69HJObfnJolv2xZrVtscH/btl?=
 =?Windows-1252?Q?XEnZBc9TWucoKxRW6XXPq8C0EY/UujMmf+gDXLT+3kAT1+E8q1euV62X?=
 =?Windows-1252?Q?N6itEWcp+Id0SganakP+97G/6OHPWrimbRiLkjyl0xrU4uU6CPJuWlu8?=
 =?Windows-1252?Q?agwbx0aokiZAu7A5V5I9Qt37+jPrcyBU33qyWv1fvy7OETpIBk6a4xO7?=
 =?Windows-1252?Q?E/4It1hLagEsWwYQ6g6o8EogIi6erkEJC7A2yXuBXbHqfcx3b7EZs+YV?=
 =?Windows-1252?Q?Y/7CtFg5LEEcCCFkkPKVOOLKW12qmxokWVGCbdvvJ6VY22RKjkzZ+Jaw?=
 =?Windows-1252?Q?eo/sNtFlsDH17lTaXK/XkydfSgtYN6WQMGUPqcXkyjeYZEO9lgitjftS?=
 =?Windows-1252?Q?t9w5CwWDrZTvxRPOVsMxV4gttOr3bgvHN5tqzOCwja9i8xiY7C4F89G3?=
 =?Windows-1252?Q?I8s3TlAdSQ+V8SO6cawGvamdHwPm03/VyRNboqp6q324QQkhugXt6i0r?=
 =?Windows-1252?Q?BxFk0v8jNcyEl5/68m/AdYzTRr/7i8QEbJsfw5z8AJmMhcUf8ezUo2xW?=
 =?Windows-1252?Q?P1IAXri/Bs2lR3/G3y5qhT1wtrrcUYs05i6TzJdi9bR1WDYMko3qALcn?=
 =?Windows-1252?Q?7coqAAHRtjxjwmwTfWivcMjerRfl4ipw9Q072ndOKRhq5pOO6zixl+hu?=
 =?Windows-1252?Q?+YuTtngE5KbvX+dWwavmjzQre1XyoZN6Xi88gJL7MUcvb6sy8UdqdjhX?=
 =?Windows-1252?Q?cNMghF2Wxr7uQ3UyHUsnft7nQEysKSySVAcrEy2DlDipc1L16XcSCDVT?=
 =?Windows-1252?Q?DKAWP4yaT5LGrGOSb554xBWccF+Ugy3pwvxzR1ntMpiAHkQ1e9XwhQpu?=
 =?Windows-1252?Q?sXY3IId9uRITFQL3dkkvdv3RLaIlOBiTVBRF67Lmrsv4tmtuSLFNb/tu?=
 =?Windows-1252?Q?lKpe/Lfcebe4V/EI3aabSlLs04xMBu+CTFbrLyuQmJR4rFt0HjYqrkLy?=
 =?Windows-1252?Q?3nH2BqYWeSboo7qf85tiiupMr3wdwcIacDwVtXcZq2mlLu6LhhsOSBNp?=
 =?Windows-1252?Q?Phsm1/6fjbvHtg+lufZNVHrwoLG5b+5qmUbhwBBgIGgRJs8EbJ0z0ZoX?=
 =?Windows-1252?Q?jz69h+FJqIQsFtCVlmAFWeIenoZKfiobUmgHDVHXnK7aXwrG8GLUSMeU?=
 =?Windows-1252?Q?KOtekBfxvKxlHwbGCiA5yiFibzLlCmpRmhskuymte5I+UU6vMzLqNS7U?=
 =?Windows-1252?Q?RNGTLjp5Z69UyhKI06XF1RgNXzl9yAWAdH5/a2XRr+bqECJjPVPB5w0Y?=
 =?Windows-1252?Q?i0K3QYUazHJlYVMOTvdhvkae7R11CE9dvgIjnMJfJXYyW9hMx6coIzwe?=
 =?Windows-1252?Q?GA33aiklaYlCOyG8YmxXtiCVJ5XEXpA3JAwbit7rjvaFkrfnSOaJgNJ2?=
 =?Windows-1252?Q?8HJmP53AD8KR0hkwNmDRAlMzuxAuKNKrZO2qtoAeXZ93LtFcEsXoMrPo?=
 =?Windows-1252?Q?1RRSil9+5rxYfxOO8zWyCjBar+rND3CU5+MNtffZpxeBiN58B+S/GxJg?=
 =?Windows-1252?Q?J0gbo9xCfUcJBdqCioQsBdzoqjkR95c4uWUWzetYYxxZ6VHHG21wD3vU?=
 =?Windows-1252?Q?R6TR1bzxkBmNItvQButIbFsAKgFRlb/nBiSH/H10JX70ATEkwMxGFQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5754be-3e11-4b81-cb23-08db716f3fad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 09:18:02.6267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKVPbzZ1DxbDQjv9G/5j7u+HeY8NgPeN5RmmHgQh5XDvKr6Pj5R1BNL5bSolVMty00XOS4q+yJGUj1Me/aHBdt8FBzCkidy78G6OihT4FME=
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
> This is the start of the stable review cycle for the 5.10.185 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 5.10.185-rc1 (8ce687c6d=
277):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
04359430
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.10.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
