Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6055874044B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjF0UIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0UIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:08:36 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2100.outbound.protection.outlook.com [40.107.114.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC111B2;
        Tue, 27 Jun 2023 13:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tu+9/0qLI4Kgb0mWO7n8swrW3+OaDdK4ZcMX04ENvLL3grlz4U9o3NqncYRohK+Q3jH+2XpPySF5kB1Jm5rCtU8AOieXzYP03JC4r7rnVYh31TMRRTUyJ7SS5JCOkBzgsfCaeMODc2RYWOUwhx6lZPdFxlGOYgpOq9ZtHRdiQWYfIZr1KO2NKEDBqLUzkhjDlGQjkKQFnlVk0YG5O5wTONTWk03Pzb10JtSm0NcsgBkk+OjTUZwYnRGpny7sHGlCR9JyZY+VWUseA4HJMVLoZPKHRovPXZ03vKm2TPgXmGcNMaoVeBEfVWRfoTDUyLepYyjs1xZlCJhNLCK2gmZAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxFWPRTijubTzx/TdaVDdFWw5DI3+/YG3ASoiqZrDyc=;
 b=l6k6F8IIfreIQqRStG6NeQsSbkN1vaRikNex2xwUHmkfvbfhtWprT+SxBo1ac775JJNdchxE9FCLQwGJHrP8y2L9DgFDYnLVaG7cvDslql9QlKK7p9oQoqt4zfC4SlKVo76Hn7zePUEMfuFeQw/KS4flTsRLX7SIVOuTjLmTdVt8fWCZJNbMP4au8ha+tMXIwlqyQloQssZ7QPey1ilsFiCQIN2/DTzmIQzcgdyqJ4mh5CCmF+CSjUbo5yIsgTXsMZwjIphJUrkTwhmneGrc8yEseV9pBxQrE0DNMsPCH9lORKxFvfe5Fga3ORSU+MX6+j0doe9syCkjUBRM1Zkh3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxFWPRTijubTzx/TdaVDdFWw5DI3+/YG3ASoiqZrDyc=;
 b=bgiAt3mrClQKlvV83detHDH86k/GpmLOmlqsLoiBH/gSQRKrogK12XheGXk/zsmGAOg2DdPxtxThfyTTk5IrikGBCzRnE009E/d0gEq0PJCbI3sKP2yzEvRWo/ihAgzzf5T1wiG7I4VKL25VP3WJIDQEfTEch4uIZkHBAre0Qjo=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYVPR01MB10876.jpnprd01.prod.outlook.com (2603:1096:400:2aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 20:08:32 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 20:08:32 +0000
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
Subject: RE: [PATCH 4.19 00/41] 4.19.288-rc1 review
Thread-Topic: [PATCH 4.19 00/41] 4.19.288-rc1 review
Thread-Index: AQHZqFvV+tJ15wfxR06TmYw2mMG53K+fD5kQ
Date:   Tue, 27 Jun 2023 20:08:32 +0000
Message-ID: <TY2PR01MB3788AD47A67CD150CC8648C9B727A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230626180736.243379844@linuxfoundation.org>
In-Reply-To: <20230626180736.243379844@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYVPR01MB10876:EE_
x-ms-office365-filtering-correlation-id: 5aaa1607-69a7-4cef-31e4-08db774a483c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zU2JnVXen4mvfrA+wF5uAqCKN0iKyDU96wTkjiRvgVWUzOirZvDh7JnN0xreQytZuDrohe5iols1050PWm0OK3+0hyPslzvwHDiCqx0t4G0AtWw4dzBHAAifsauRnXtakiD68WvJsHny4BWO4dlz9TBK5yaPv1CklbbaiBfdgVjTFrQf/A1FPn8z6q1wibKfVs58ElxkFeS9wZpPWj/ux1/wd15gG7HtosfCVXfW350F9idCdUEeZrFh0xnNlKlUig23FvMcW8uYGypJXckzWNxysCpx8Y6sqbccXcJZGmy323aHICylOuH/K78abTRvzSB3niW195iLWU/4fGA8dlvk47HFEYOXI77zim3Jr5Cp8wGbvIT7jjob5/P6r7hpWyDA+cvmHtBu5/0I/1edeKoWavqeSTFpgor6DSOemaZ8rRcs3hHnF41/Gm4sJbGBiDAJm3jFWj+4Fv7vjZmvwU5m8uCEB3sdS/rNfLR896eq2JMoaxyP34Q7IuTtcS8CTEvNIT6aQVtP3eRyaEixzdxIMdkfGSIOLmhoYI3A3fLsKR5m6ZzSMsWD+B7XxAF1+F4rgvMsAsP9Jl7LdtJOUsVOpvvifQYRkB07xFgtm0/km2sbQU6jpxiMGNZA/HEfWQwwL25/E5AJJdVF0n3yHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(8676002)(66946007)(66446008)(64756008)(4326008)(55016003)(66476007)(66556008)(41300700001)(8936002)(316002)(76116006)(6506007)(186003)(26005)(4744005)(966005)(9686003)(110136005)(478600001)(54906003)(71200400001)(7696005)(5660300002)(2906002)(7416002)(52536014)(38070700005)(122000001)(38100700002)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?vdt2uW+C1mI/DQU0NFYIm1AV7HzL6ciWKB1kqpEN1F5zjyuoVqtgOPyC?=
 =?Windows-1252?Q?0vXUA16zLBgIKVUh7J94gCXcyoF3OciBuMxSOmGV+CfQDXh3NWWZItor?=
 =?Windows-1252?Q?L1EtY+WYCA5Q1TaSWQPFwub0iPyYwqFL8LngeB63+iDsa1Pyu64pzaKt?=
 =?Windows-1252?Q?paInY4jVVPZjSaVv3zblH+VQR22jVa6l+3MWyLejPbvBD26QR1c2xzAx?=
 =?Windows-1252?Q?920O014qO270KODggkKUsGieM5lFIo3RWisMCJq4E9ie23FmrjxuKZrN?=
 =?Windows-1252?Q?L/tVSfzniEUSpDxb9yuyWbNOmz4hi9oBVwPWMbXQtk902B2RtdWvhOLa?=
 =?Windows-1252?Q?3i6+Pf5+xsGc0xuPMUdVfTdODggZ//GjSCVP8GZFsuSA3lucOm8q9E5b?=
 =?Windows-1252?Q?6kJSOCUbeUA56ZU7fA2a2kvgEwf8Z1zZQs4fNbIB6U6T4kMBTpvIaGEN?=
 =?Windows-1252?Q?StVxJo4MNUA0MfycGz78arSy0ww4QZtarUUBgTru7xTU5clFdCMth54L?=
 =?Windows-1252?Q?5UVDN7Wcd1KoLNuCO9rfMpIYpAw5p9/7WSfKx25j2vH/kGhmJ94d92ET?=
 =?Windows-1252?Q?cycHFk3spRwykDJTS1ML+Qt4UbB9SfZQnjal8ZC8qCy9TWfjyBZ2HTcq?=
 =?Windows-1252?Q?HO5s1ho6HMmAtAb6OCJdqBA3+z3mRtwW5CmCP6ygpZkZvDOwvuYKvM3+?=
 =?Windows-1252?Q?CpeE+DSoLE5uRU9vhw6Z8kLI2nGs0fGt2kxot0i9n1HQ+54NrY5P+jyB?=
 =?Windows-1252?Q?sLxw+GViN0d1vF2adX9HCak4pKcebbrYIIZWXrCJcuHp6EkQtnwrLzvh?=
 =?Windows-1252?Q?UvT29nW2vnrRted2M5NyCwTqexgDDcooYeT7h9Zz4B5qAeapJoCcR+l2?=
 =?Windows-1252?Q?7j14Sm67dQ8NxHhj1IIprmsUu0WIPiqRw+y1aB3wx0yTwZ3p04h3A/Pb?=
 =?Windows-1252?Q?6QhnmUxtDdNfra8bB+cxK0Xot6EryTU6mVVcl5rQaKeXBL4z1UTfWV/T?=
 =?Windows-1252?Q?SMWkj0O29gWD5Eu09oD23vGUVadMEBpRyfiNWOniENiL4yNLiaIaexnI?=
 =?Windows-1252?Q?rKbQbjaMtjGAi/slJBgbxjAPvStxIZm5TGDfLBltVK/hovylJWhBI0A6?=
 =?Windows-1252?Q?SmZbjZQTyqLk/pHfiI17uNQNs3dAoqPcPhyR98owMhDbaAISloTG4MIg?=
 =?Windows-1252?Q?ZWzLSFkvHXMcl6kyMRJvz6WQke9QoaAu9iqNEi6AC5AeS/uHZGO4YHqQ?=
 =?Windows-1252?Q?au2ewe+xRfkZtMgFznFlk1EzHyPlcaXv72WeyMdRFXE3Cb5cf4L1Ufty?=
 =?Windows-1252?Q?CZomqYk1DdEppKGXqnwFRwkkybaVNAGeYltdeDUbl2nN+7N5zFXun1G0?=
 =?Windows-1252?Q?jaVlV3tGVV+FWHbpmE+2Cv+ERmbUVf5D3Y8bE/lqzBJp002i3+5CHMb7?=
 =?Windows-1252?Q?6TX7IX9UpfZnUDR3g9jn9WiNodOyv9LEit/G9FPjuRaNx/59zOqHD8Y5?=
 =?Windows-1252?Q?PjPEVLWI58F6maPD2jDo6ly0m78BwE+Oo3FdxrrWZE21NalnPaa/q+n/?=
 =?Windows-1252?Q?1AfvDQWKlicXd5fOvZ92YwZzaixVZnP4SEq+U1HDMw0CPoTffBeaFelI?=
 =?Windows-1252?Q?AaLUMMLxSQoITI8Kkj3h5L6Z3ItCBY2kuUzCN+LZ4IaJy2YdnFauK2b0?=
 =?Windows-1252?Q?dlMXhlHczrWaCHGv8LbZ0Yhn0J2936UO?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aaa1607-69a7-4cef-31e4-08db774a483c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 20:08:32.5622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lznm5Z5kASSlgqRwdKC4R11A+/j2i/CIs5SgO1agjOKxFFTz6g5BmpShUDPw5iV4llm3QmW5okGdIdkm2bUw82iMawID0n1dJGmZq5fuoxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10876
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
> Sent: Monday, June 26, 2023 7:11 PM
>=20
> This is the start of the stable review cycle for the 4.19.288 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 4.19.288-rc1 (d46c55c4b=
242):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
12373201/
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-4.19.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
