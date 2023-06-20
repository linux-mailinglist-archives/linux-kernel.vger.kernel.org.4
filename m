Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D9B73678A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjFTJTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjFTJTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:19:20 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2129.outbound.protection.outlook.com [40.107.114.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFC7185;
        Tue, 20 Jun 2023 02:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfNevbv+Po6sgWrMqnVWbahl9NZpIuFGY+29aZdYWSgMtiipppbALtcADnPBiXAj8TzPLCd5tBfiTTNYNGNX6AiokrQEXt97oYogmDrW0bfYJfoNdtBO41haPWJOyMRJUmkSxwgW/E5XkG6D4JVGOKCXDH6an/oh1vvhoObCzc/ipeN93a2DmSSYoWborXcFPmwfF8HvX8SNAoXPa36A7VuqpVPaQ5/a56IUENN68rP7ZwpWF/J073UI9CERWVR3PKwvT3GmsG7PtBuTxOn2O3NHJOLvku9pq9ng416vVv7RXMpJ7kE/KhPz17HsR+SA1rjSNfmfE8n188zeJXyCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxCMKavtox/87WhJDfD52AE0AdX9nJw+pw1MD6aL3XQ=;
 b=ddsr8q7Qfhr+ElxGkCQo0Phk6day8IevBLFQQLogpLbGiemJEMUEWbWI/mQKcjBrMXbgyXqrtMpwjquY+Yuhyzn0qDJ2yI8pgPVlDtrKmfVE99SvfGUIJ2V4POlcWvf8QhMWH2RpROUW4dTjEOELdzQZCBtCa50lIybqmn7Hat8mtE0iEeTwc5IgFHEVn590kindfuQa+eYxs7cGI4efBfqpgQnglDxfjLqD2fw1yZierQPr6k3fAbjZ+lWDNLj+SB/rJMcbPO9lN8FYPkT2keYGs3G3ZnpbHvjg7F9r5PQXxNIpNX+stAYHMH31v4bcnjzZZafHXDU4F9gZEq6UIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxCMKavtox/87WhJDfD52AE0AdX9nJw+pw1MD6aL3XQ=;
 b=pDe9Hd+4PPXY4TCX7fDSxMBL6ULJ6htDwJZSBQYYmIXMNaH2j49bqgGfHIjiN85+YBRw0wgiohMcTV52HbabKzxQ4TLWdSxHrBtA2aiG9jEkSNUdkGpgPo8VZVTv0xFkb9iD2f/UY21nBTS1JuzARnFtmYAcr6d/c+sgMSclBF8=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS3PR01MB9414.jpnprd01.prod.outlook.com (2603:1096:604:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:19:07 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:19:06 +0000
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
Subject: RE: [PATCH 4.19 00/49] 4.19.287-rc1 review
Thread-Topic: [PATCH 4.19 00/49] 4.19.287-rc1 review
Thread-Index: AQHZopqxsH2plOgFwkOCOrWJONQYoq+TaSFQ
Date:   Tue, 20 Jun 2023 09:19:06 +0000
Message-ID: <TY2PR01MB378872FD225467E0E5D508FEB75CA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230619102129.856988902@linuxfoundation.org>
In-Reply-To: <20230619102129.856988902@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS3PR01MB9414:EE_
x-ms-office365-filtering-correlation-id: 7cab699b-9ac6-4795-865e-08db716f6602
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pKH+fMjImpUILc2yQ3YPxhy73FNz+KYjrS2MQsRghYeZbcePFHMw//ceCz2sIwA9JXnOXYHLwBtKv7nEVY7UL343FBJPEG04H2iEEhSgOeWIn1ZuT/Q0Z65n8IPy07zTrT7/aB6Z6KlskIEdGjHa0GaE8H6N7J7upLs/yxspx6UcMCA77Ns4hrtLMb17DxrRfnfr1M0ccrLLgw32UtzWql+aqvJOqBKyvMvtsx6G72+2upT5X8mRyE/r2wNbp+L8aHZvzIIWZkeTsjNS+ctypBeKpUYO08e3E3iEElVDSSswvcmmoCt0znszZDkNpJmqzjelcGF2fR3s/qdKxJjUshXGcZc8jhayaB2MmvjfA1ZftrQLILKQ0jdnsR70XgALwIx3fhJ7BV/sxfJB10BUaYbDDcti29Y1aIoh+5cfczINht9XiGmHfUCSMKK/3eg5t+pd16jiIHAsMHgA8ZI5Z9OjkGDSTUpc1ua20xgcXi+apm+CKpbEIXUj4nRNfk3/ohQyGncW61xGt75EJ6sKWvs7nSPtZPCNi1Z0KfI5cN8YwyrXNclVxVhr5QtEXdPHPBMBKnR22vCXXMCKH/u4IvZLkA5+7hvTv10OwsweE8RDoMI/1XR3Q/ghkS/0g5dF8m0878lZPHlk3uzSaqU/IQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(7416002)(52536014)(122000001)(86362001)(38070700005)(2906002)(4744005)(5660300002)(110136005)(76116006)(54906003)(64756008)(8676002)(66446008)(4326008)(8936002)(186003)(66946007)(66556008)(66476007)(26005)(966005)(41300700001)(38100700002)(478600001)(9686003)(55016003)(6506007)(7696005)(71200400001)(316002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?Abz9VxCsR38j6B5fF4mXPLFnGo62TiXl9HV3IrGtESGL1TLOfha4wcL0?=
 =?Windows-1252?Q?gi0reWD33pZIzoQKgoN/3d/xi5Ez8Fca0OXciTprnHUwP8UbBSTeT9Gp?=
 =?Windows-1252?Q?5KOTDZ+Z3Jnr+vCo3mjrnUwqoBeeqk++lMiMMVHTuKT2JoHDlqEs8P6u?=
 =?Windows-1252?Q?4NO8EPWm51PzzORZhp10e1O8fVueO4UJ2BJT4IOKpu4S4vqZDBIEJzuV?=
 =?Windows-1252?Q?5kWwUMxjByHYDwR8NTxhczWtDFwMr3fIUkwPAzYUV9DfY8cPaPPusqk2?=
 =?Windows-1252?Q?uTvzwMqIR5Wn2cW9C8x4z3xVdJAS39yTEpE+Mbpi4oC8xv+JLzXM20dH?=
 =?Windows-1252?Q?Mp4UMwlxD+KsYj+X2MVvITJiD+e9BsJvbuzytJxwa5JrGnZv8BpErlaC?=
 =?Windows-1252?Q?ZhgTv0xalMOBTG0XyWc/y7VjiOaXPAZXLtji1ClVNG0MqXn57xKxFd94?=
 =?Windows-1252?Q?QgyvO217hi8KPzPGGeeToKh7JJJViCt17ogD3FjeyRVX9awnJ+OZxCbt?=
 =?Windows-1252?Q?DwwDxdhkecZHdLF61rAtIiezIr/Bv78latRb10bhUuLkf7jYKWeY4hIK?=
 =?Windows-1252?Q?8F4qyP5HiwUDeS1FDyghCKorvyvyztMPYYOiYYsOdwvOjD8ZyPadaR6z?=
 =?Windows-1252?Q?OGzSgG1/CuPT61glKp0xqKqZmPr6tE8/IA957jcXGtHHWyq5jJBEQh+1?=
 =?Windows-1252?Q?KK1Xsh4u0+6WhbJ11uNyOBmXPUVQFsM4tkxVvbdKm5g7b10KXYt4OzDV?=
 =?Windows-1252?Q?aMKCCckIQhT+cLO6adDB5iCyABS3QEHnILlv7xwSrWHSHsRfZSctjzZn?=
 =?Windows-1252?Q?q9FLToYgou6oFhEykz8Czx7fPuEMlYtJENvSQaU9ipg+yzwTjYjSVbqK?=
 =?Windows-1252?Q?QYp2zhIBAA9wI4eecNApO+7p2Dh/oNjqlNkMXyMszNszuvkbaUPvLF6p?=
 =?Windows-1252?Q?sBPkFOcPtKuSqA2QJTVDSItNB2FRvqpPWOAcsiNDIK3zUpcz1e45xO+7?=
 =?Windows-1252?Q?jIrCmKEAiNxiUa6PEMI89h5Uk/NTglSb6wchlJup/z41vZXDYFSBtutg?=
 =?Windows-1252?Q?2/z8bB6HoojMU9+iRJ/VHtArFuLjhtXGvK7zgZp6GGGMrVpYMQS2YTr/?=
 =?Windows-1252?Q?brJaWYYMzw1DSZHUYDFoIBQokHr+nx6KSCDR3N4h9GD9K0oWMgjkJTK9?=
 =?Windows-1252?Q?ZuFPA2gkGWCjanczYhQwkDZkbeAllOIkogsXsit2xptRRIdS9BloAP17?=
 =?Windows-1252?Q?IU6L99qA+YKZ1KKslHMG6qHklEGeAN9rQOnWwlhxVBX6kh6DIUbbjM/j?=
 =?Windows-1252?Q?/r1+xxd5BVwSv5FhhZOiY3LMbJYZgLyFnSd7037LXfHRAxxGVe0saa6j?=
 =?Windows-1252?Q?NsFF+0HI2yxOQlrZgtunhdWrSLe8ENX81ryMHvu3dP9Ma89EptlceVXv?=
 =?Windows-1252?Q?jOI3EKEgc68/RXmMJN9cuxrT648qhKdOY7kh9W00+8XAEiyw1UToB0qp?=
 =?Windows-1252?Q?tTxZFrfitNmZk90vO8AezM4Y9Xigm4AJ1kPdztoUfNznQMLBhi4WpewV?=
 =?Windows-1252?Q?GOqYGdrY+tqLgBjQHM6r5OsSW3yozJxCMtdd64tZyZlgCWmTJdQX8xmU?=
 =?Windows-1252?Q?5BIYDeHsJNeJmNgBBnf1aqzYkPwFgkYPTNdL9B4VSPRvHsn+izCIQTmH?=
 =?Windows-1252?Q?Qn8AtgzJywz43od66UxSR4BvaxNH9lzUQ+guNafA+qQZcT2v2pd11w?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cab699b-9ac6-4795-865e-08db716f6602
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 09:19:06.9390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yyK+iZrW2XetdXl2O5l31AN7hUOTyDU88d4lnTf36/S6TXJb+y2TxkkEpPopTrOuSvDF/UMs2hnkRO0tPNI3GQnXALgMwHVN57jfeSvLz/0=
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
> This is the start of the stable review cycle for the 4.19.287 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 4.19.287-rc1 (3e62ea320=
ab2):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
04359056
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-4.19.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
