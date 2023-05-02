Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887726F3D1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 07:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjEBFkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 01:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjEBFkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 01:40:31 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2072f.outbound.protection.outlook.com [IPv6:2a01:111:f403:7010::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ED5A7;
        Mon,  1 May 2023 22:40:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZXkaCEGstXWWmklDOc7ca3S1lgNWO7S6tVkT/XA+uk4c2v7CLp33F/TlXve/FA5Rptue7ptn+ghSm1B9bLtP6xYHCv3wXa1C4ZlN711jkHF9CiDvjcn+3rvhXLbNHoHOffNrgNyd/G6sNhvKRHomefcfmqyxF3y+ZgYEDppQGx1+ByqR8gw/VJUU7unnDC9cLKKR1ZApugTEfl6yU2/oGwEKjs4eoSaLGoSLss1Cxeq4qhalejlCQX2iA/ph1SuZxOqj6NVGRy93Gvb/kbcMmH8Bg8S163Q4l8OUoN/ybWrkrYNQY4wCxrFD68B6YYj+xu2/iuxi0wfUpXLWprEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8yezqFDQXoLady1Ry5YNEE36rO6/U+w7U/UQ6oLoVg=;
 b=SAfVhWDmR1l3XrqKRSszp6s+HSlY1nz8TePP4Yj/hySP4ktiihUrED2M4YrVOw40WEfEmd/pp/qdlbbLdZoLPs9MymnytrrlyCVEl5isQ+XA770CNvxa46Rz7omXaVrTxubOMsovkkX5FZqNTD5FiZNUfs02Jpt+wvvYMaoqZ8PRty86FcKDmP8O3qZ6AGpZby02UgQwBvMGiMGFbSPBvGfo8uwd+DdfLqSp0YmUDpstu5ZYGu6nRyec5K/MGzBE2fCRTF+AxrO83g0lGOoOgy/XnawilY8ty4nA8v64Y3qi4NBNVKyWPLFYuHgmqo+5SiGcN2aLK83RJyxAAFeFCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8yezqFDQXoLady1Ry5YNEE36rO6/U+w7U/UQ6oLoVg=;
 b=eT0tkMIru8m4bV1NRoHVWwsl86oEoHTOABX+Rn17zLEc+xO3ltHGFo69KX4sHjR0yiB0jg7Hbs5/Rk8Vxu3SfK4NZXMBuZtqF1+f0xvqb7+Cqn9A1JwBsszzvkqPaTFfrXSDhCL7F7yURHne+KqgVm84MTny7ZKSFh8t3VcF0Qg=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB9389.jpnprd01.prod.outlook.com (2603:1096:400:1a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 05:40:26 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8b5:5f09:5a0f:370]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8b5:5f09:5a0f:370%7]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 05:40:26 +0000
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
Subject: RE: [PATCH 5.15 00/13] 5.15.110-rc1 review
Thread-Topic: [PATCH 5.15 00/13] 5.15.110-rc1 review
Thread-Index: AQHZecTLlpQjpkJR7UyaFQK04NE1tK9GfBKg
Date:   Tue, 2 May 2023 05:40:26 +0000
Message-ID: <TY2PR01MB378828BB6C03B65637A277E9B76F9@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230428112039.133978540@linuxfoundation.org>
In-Reply-To: <20230428112039.133978540@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB9389:EE_
x-ms-office365-filtering-correlation-id: 107abaab-ceb0-4f85-8d9c-08db4acfbb54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iKuTLwnP37kehJhdDxI6QWWYHfpkx2l4H03W+AdIiq5qg81B07wcZdtN3rcLdnnWsE+aAQ9sbZyHqWWVLPNlf13y7Ki40kMUk+0l0Go9w+2I5+PqtdpNdeP2bGjsBhEJ3KevItUOXEppxn22RoxixydGd/nu8xw2LVD1roLnyEGZjyiFGzWUM5hn4t0OMb4s8pjaYUEpPoRXvfp2wQ/vSPkQT7h6tD+NtO0uRNjJwsE2lCVC8dkgpKAUMPFRvg6GwWeRoi883S4vQV3dUOiVDzI59IGZ+j+V3IvCdsM2nmc/VBIezxSGWYCEMXMIA3UUAh+X/miP5eIiHiV22ATkYZ5CrhTtd3+rerxpcUTCDiU9Ic3tMUWYEg5Z6C5BhS9SrnylGXiJ8BASfATg/FILFq773bWxlsx0dtSXelSsrx9EpUrwpmk/W5lTQZAo1KEH6SXDXftXvu+nLk1cYukBXW80+FTnRM1mYJUqXXeJb2J3rZ0ioaUvXKtQKLpmmGyaIjr/v3Fso8rcTOY/mgx/6DnThj7xyAoJz46+B5oPWFPDCqWb2HslDCjnT7kzvptPJeQIxYBrRc7JO08wsJ32tov8Md3+Z3tl7pL2DfvJiwh/5YomC94W5m2zZreI2T7+sm36daUIt++g5QrcdL5o8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199021)(7696005)(316002)(66946007)(66476007)(66556008)(66446008)(64756008)(71200400001)(38070700005)(54906003)(4326008)(41300700001)(110136005)(76116006)(86362001)(33656002)(966005)(26005)(6506007)(8936002)(5660300002)(52536014)(7416002)(2906002)(8676002)(478600001)(55016003)(4744005)(122000001)(186003)(9686003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-3?Q?9LNE3AsptFTaCoSvdHzaq4FP6/Ebissolar6VN7AMHU9ZSUyGKhl5F5FeZ?=
 =?iso-8859-3?Q?oPzyBgHRZvpbsqOVmbDwE7TeVm4dosnp4BZXMI4SVCMr9jkmhT9BSejqSO?=
 =?iso-8859-3?Q?nX6BS4yPml+xGMwVsJZPzZSr2mmM3Awov/d6wLQJh2IVHfGUUSFCeNDt9A?=
 =?iso-8859-3?Q?3FAD2Fnq9vI/vbRAKVQHVOlxI7/g6KPvMxjsZ4aPMqeUrsVtkxNTZY0iEd?=
 =?iso-8859-3?Q?DtHw/IbQ5r8WfeAy30/FrCGIvodeb30j4Id/F02Y3XAkAuIrxUn1OHWZST?=
 =?iso-8859-3?Q?6i4ybmka9Z9Y2+bBQX3dWmCPUiSiQpgVQAwjoA2u5dNRSZ9YMsiTjeZsK0?=
 =?iso-8859-3?Q?pFslATjc//+82UATmzaV9NAE0ZlaXeStT6UIYAD/zu25ysPlIfGtTZQwzq?=
 =?iso-8859-3?Q?qM0BTHVMrya4Rq+1uwz/a8rpQaqcxDl7f0kUmzA5lxHSFwAHJd5IIfShwI?=
 =?iso-8859-3?Q?5BRXnNGsdsgt/Btl1BmR8QI1iCmG3KrwnsxQhSPg9JJ2ggVgYYuj7RvVIk?=
 =?iso-8859-3?Q?pL+sGNkeIMgdeUmfX44IePticPrkzuZCNH4IRIJ9PInK9/iiOfSBa9LRUY?=
 =?iso-8859-3?Q?cz/+sbl6ViUQXSNDextrY8uGVkQfawz0RhqiZgt4oRIH0Ih8jTd6/XEfRP?=
 =?iso-8859-3?Q?IqvXAx14m7paa6jZjXWMbr3JykdZjzUGKFm9qrmCNY2w4CE020T4kbMMm4?=
 =?iso-8859-3?Q?Uq0RFi4sxoghAcXTHNKoR8gIp9M+ckCcfHRxlGIqRXqXTpOwJuGF6opbOz?=
 =?iso-8859-3?Q?8J/F8nFyvm2/94SZ4G9ZLFh4Q5LPXX9L5INqti8n9y9KWDrShj4six1CUG?=
 =?iso-8859-3?Q?uySrwBMoudCCJjgGXJmL0H8N1geL1m8rr4xtEFVWWwAlhCz7DcoSo14DvI?=
 =?iso-8859-3?Q?Tu07N1xyEOqVQiSslmgtDRKqb5EEGj9BpBwxmqB5aXwBlkkHCkBQfRBKcQ?=
 =?iso-8859-3?Q?FVatEuD9rQey2LwfK7u/A7Cadp0kBHRoD9ORpc5+SAHe4Aq6xUPTmfRjt4?=
 =?iso-8859-3?Q?rOIr2t7oDn72469hQ0xV3fTlUSxOymdE4CTAIeayaHsIezD2SqaQjjxtpU?=
 =?iso-8859-3?Q?0P9MCM5pSf5aU4RadnZDWnVxTgkXXSllaVG1Qband7KZNFXww6s+ZTz7lK?=
 =?iso-8859-3?Q?DUwusnfYGyi1Gts0M34k7fi4Fs+nqATj4J8ZTzBr7X8Br4ud9eTwWABoNJ?=
 =?iso-8859-3?Q?XCm6KDXCSl9joZWgUqHh6uhZnZk3P7EoBmIekcfcSX9L5PqHiDhLQzpY8y?=
 =?iso-8859-3?Q?/aRq9wWSqXof7xS3og0vNgYnTOoHcCHBCp9UgtEAxjfxxQg7Rl0ju4VEE1?=
 =?iso-8859-3?Q?Q6SW3Qys/csFcU9nz4bAxncdTrfJoFTdxKJ+txQjmhD4IJYbV8s8fP1w6i?=
 =?iso-8859-3?Q?ZGH0h8Vd40TGqRrV/GFXTuupe9eFXxdGPphGnyYcZmmyN00/3zSoA+m1Zd?=
 =?iso-8859-3?Q?ustpXgn5xGUT4TEWYo9BhGoyfpmfPyPVKIvjSEqEfTqj+mKXliIUdIQO2S?=
 =?iso-8859-3?Q?RjRfAr2WQ3mvpcTkaVKmAJYcRmx5TZVPdGJBFf1mQEtGlS3fMnarAM5/va?=
 =?iso-8859-3?Q?aGHMPtwlWRD0Pl7mjx1IjHwZfxX3Ju3CeHD/LA/wfcviKsFe7jP305o80x?=
 =?iso-8859-3?Q?TywZSeUAglY8+vWnqkrJRQIi3aOpRQThfZW0mYRvUGV6KXd/Dc6SX5lw?=
 =?iso-8859-3?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107abaab-ceb0-4f85-8d9c-08db4acfbb54
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 05:40:26.4544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GfPyN1H9QoQMcJ4aHpiidpYEHqJMBiF4cYQwaG3sw+E1fZsATqU0MnvpQdcUaebspLwLnu5osayzurkFph5emANIkiHAPdu14DtG3X1FTr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9389
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Friday, April 28, 2023 12:28 PM
>=20
> This is the start of the stable review cycle for the 5.15.110 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.

Sorry it's late. Weekend & national holidays in the UK etc...

CIP configurations built and booted with Linux 5.15.110-rc1 (64fb7ad7e758):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
52034473/
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.15.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris

