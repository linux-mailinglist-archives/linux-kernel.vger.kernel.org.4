Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB987727892
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjFHHTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbjFHHT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:19:28 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2102.outbound.protection.outlook.com [40.107.113.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49C21B9;
        Thu,  8 Jun 2023 00:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDzF7l+GISiHAUK5YB8AkfY3pHTY6UpuxMELeR8Aau6aKv0L78N9r5pGPm+EXq1M4kbw52mNJS29TMRTrQlV1PIwGNlR1NZ4UT+46FVvNujMgDJQFpLiXlM7VOw1IEJxswN+f2tu391u5pOopbkICgsj/Ga3NzsmI9lbb8/AQv0YH5abkS0INLvisUveDUZWRDJW8GyDDmC0F6T5EdTOz8PD+pj9iOR++r6tZ7ApFcLwNdYiT9GF1cwCX5IV3KyxMEQdAUgHJW7K8FbzYuxrWKlPk2mCnmSzm2l26Ciuyo54QCx8He3o3mC/ITOTVJwRpQylOrXcWO+QNsE8+Vzaug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBO1L88aW4ExIhxd4z+GvLwUulYHSAZG9GdZ2atc70w=;
 b=ZfR1RIaI5sQrb0JJN2hiHuZSIGz6/aYEeCn0bGVMtWgqfx/paxa1fQoUkD8Ew28228dJ7veLe0yhltrGsKyQPnRI6GAkUp++/l/FBtOJf910TKR6h8g1AS1O664jJPYKaXe6LJZS5p6a3yrN+J833kGM3MGlIdkImtnbo+CZXhAUzvykonzNySUtTtNXplWDRGZOYGfoPqf0eRHPZ/9M9xh4Ekl2LdGAHQVcgu3enqTrlydQ368V9AY6cT7WA3bpTldMDBB9XBO0uMkw320/9mx6DSk3Gpvan5hNYTMwwDuHZ4wHey1xfCheTYFeqvCwqiZjrjVVV5W2QGf17ecxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBO1L88aW4ExIhxd4z+GvLwUulYHSAZG9GdZ2atc70w=;
 b=M2v5NBW5INECd5Y9tVMUds546mDeE3sCmuxGQSVBosbToxArcXxFbA7GzFMZfzNGN2yCnS1dKYMTzCFbMo5IcCLZqz9lOANJfL0FvxMiHWqBGu+Lh4QK6Q1wLBUv9DxaMsYjOHM3pigizLo2WIDC6p1dEVEot7vjk+IJrBXYyA4=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB9662.jpnprd01.prod.outlook.com (2603:1096:400:230::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 07:19:21 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 07:19:21 +0000
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
Subject: RE: [PATCH 4.14 00/61] 4.14.317-rc1 review
Thread-Topic: [PATCH 4.14 00/61] 4.14.317-rc1 review
Thread-Index: AQHZmX2AYvXDNJXCtU+tSH9sBvJHgq+AaUKg
Date:   Thu, 8 Jun 2023 07:19:21 +0000
Message-ID: <TY2PR01MB3788E02C8370F96EF9312CABB750A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230607200835.310274198@linuxfoundation.org>
In-Reply-To: <20230607200835.310274198@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB9662:EE_
x-ms-office365-filtering-correlation-id: 543a8c8c-855e-42c5-dd4f-08db67f0ae1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ym5baFMcajPENJZRwIHLtHfzcu7SZBuxDC/r9FLF4xu1oWVwIhKrakdWj5C5K/COJYIpQSGTjNYUJhy9HRpp9FUNzIdWDyIprJo+3zidDeUGBTpbO6EcdVUCtDJPbCj3dJYTpQ8FA9vd5ACywCcQWX4gZdrObgAjv9CSOPcnNVrrqkL+c29EqjBQ7L+I+UtJHFs+EL5LkvvOz5C5OK+NV1g2wRdEuCrcZ8VbbQQldcB8BRL7u1hgAI8evbtPv4i5d4ArmvUhUsJKtc0JErEKwD0vcotfirP0xSBxsb7cqdKNg0i3+8nFH968yQRDUQbGzlg8lxzd1jNQJYcsm147Prz7MvA45GgxC8UgdW/Z8nHqe+KeFMlJ8szjPWmPND6u72Zsaqfj8hq2I1bjYDWrpzbyjCMMTvsmxyRBZfAGkJbqgU6IYZ3p6+TahjvXqUvsblnyYa1kIkRjAuVkMln28d30WYXJ3Qw+IGNxTNd56KLaQ7RQcLSqRflFWY6jRJyKGYvbUAkstbUfjiaIqoXRa8pphic/UIo1dSsSHETZVYu/B5c9e1tJZpo1lccpxvOhq4vU20V6JhmBxZi6i0kvsmXOvdRaWAtMfRbDi3r0O9tggOiVjD3NElL2TsPm7RavyN2rD57r4VewhqFP8GIBCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(186003)(478600001)(6506007)(26005)(316002)(966005)(9686003)(52536014)(7696005)(55016003)(8676002)(38070700005)(86362001)(41300700001)(38100700002)(71200400001)(8936002)(64756008)(66556008)(66946007)(66476007)(122000001)(76116006)(33656002)(54906003)(4744005)(4326008)(5660300002)(7416002)(2906002)(110136005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?dVC7zV4VcjxeKBrTTsUTVTiZ65+YfE3pdwGpJO3adUcR6RFMQacop7nnV9?=
 =?iso-8859-2?Q?E4ECZXrvXoBk6iq9EKj7BqDJGw/SFk9y84GQcuTdW5NN+MK+ZFXooemjyj?=
 =?iso-8859-2?Q?U3GgPsogJdNDdPgMN0FeXZ/MFELu9KSx0LaS0LtIEpfhs/7ZOixvxOJfCO?=
 =?iso-8859-2?Q?QBmNUffJPq9X4OGi2YE1fm6Y4CxwaOzYXyFEYRlbNgWxiWsHWagS7ZHRcJ?=
 =?iso-8859-2?Q?VLbGy8e6SDGYmlgkxyLDA2sazM7IaW8sl6GtQc0/ylr8jBpBI1+4Wea1KB?=
 =?iso-8859-2?Q?OVVDTS5Vwf2ZmsMu/Ge+NVyyBcQ9r4vwzvOuYbi3zGLTh0QWBAYNqbmDct?=
 =?iso-8859-2?Q?aBimsxPLW/HsIytKYvdWOoc5fsH3JQjIabtfI7oKcpKTYo4OMdQRuomcqj?=
 =?iso-8859-2?Q?Pya8FChzP8tLi47SNnxe91vmLUpibSV/7oHymOjeH9leKMQIa71p0MvgDK?=
 =?iso-8859-2?Q?c4THN5DNWwZeH6id0752b+ZTiRfCSRg0ugRua5cY6saHcPNmrN1ISRPGj5?=
 =?iso-8859-2?Q?0OWX5LEDTj7oBJXDV3oSjDTyK7PbnVHU5laNtnWv4IsSNyWHBd9WQ2r/d4?=
 =?iso-8859-2?Q?g8tW6N31v9htIN0CANEuME+KkTx+Vv9cIq7Z4xdXq+2+ojym1Oznh+ZU5a?=
 =?iso-8859-2?Q?biflc7q7GY23u6KgmdkK0JpciOM3Sn7g2WW+boGj//MWM+CgbuXMBhPYDo?=
 =?iso-8859-2?Q?wkfaJKnBI4xsYRjmT7C6JCb5y3dNgzaXdYRjCe69NtiwbyGNYvK7kQL9sC?=
 =?iso-8859-2?Q?DCHnZhGgZRnJeqzOrDTnCdJXp7pCXttOHIAfBiNgwBAYAiM8Y0CRN/NReF?=
 =?iso-8859-2?Q?CfwOev545I3d6lDpxthC6rL50vhgiweaOlR9bl5gKxz826VlvshZym7O4d?=
 =?iso-8859-2?Q?x9FGunJm6vSRxGUdSyg/6ePD7RGF4PZ6MCe70uXZ5G1m0duY9opw/S2FMc?=
 =?iso-8859-2?Q?b41yo6JTH0sVstdrOkJpbpv5uRvwq8JazX4bOFnCMNaL1scYBCRo8vf8E4?=
 =?iso-8859-2?Q?W0uwfje21w9tT4W/ASF7Xynv1EFfeUerOk0LF5+d/DDXMw6/onfwHLWCNI?=
 =?iso-8859-2?Q?nLUGUwZsGaV905h3sLj+5MxymxdYx4lF3HtVpwFjYg7aQz9/nfrMpWGZ7w?=
 =?iso-8859-2?Q?MNo7Iz6U3gnFU3kLvzePqHtuDM6roIw04gNRfv64kCxieEjn+NyXFwZynz?=
 =?iso-8859-2?Q?e1MhyK4fmNnLu8vwGli2X/UINL1rjdcJQyxyl+vVJqjKgdD8MzgXdEr2q9?=
 =?iso-8859-2?Q?I3x+8fWk6OZlTienJ9tzu/ROl0Cf/jc9wuecZ41syse1VzMzA+NRATGBMW?=
 =?iso-8859-2?Q?zL/WVkr+9VDOXcmK5RKj8Isp0HWeuX7AQ0txYeHkSDj3uCHClu0qtXo7Mu?=
 =?iso-8859-2?Q?HP9J6v0HZnGME8oVjbk/YBRI1ocKSXvCmU/t0U2zJEGFF+pISCZIi4sqdR?=
 =?iso-8859-2?Q?oJlw+SANU+YEStRoF7IgBrxYqiL0ohXg6R6CbH6ld5NA6pFXCygY/INI02?=
 =?iso-8859-2?Q?Bhu2VbnSXmzHnIyOoUernC6TSwMApj1NLM6JPgd4N1R7MKRPWNDfzp6W9g?=
 =?iso-8859-2?Q?T3mZIJ0Jtf4j6VVCenca8iXr36s28nMZqg66kLx3tBwWLVUg6bP+kcQ0A0?=
 =?iso-8859-2?Q?0ei+LExWjdJtm7vCFdTEUqRu582VeJdBwg97X2Lojzb8v6XKhxH7/IMg?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543a8c8c-855e-42c5-dd4f-08db67f0ae1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 07:19:21.3611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +wSKr+zcAJhCouJeUVuG+9XH8AWhW8/7RF82OjZlcUCgEm48AeEHFmwwKt3gTz2G4wMnG97j7jzeaCx3NzyyUjVopkyCNezfRSjQv/L3ABM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9662
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
> Sent: Wednesday, June 7, 2023 9:15 PM
>=20
> This is the start of the stable review cycle for the 4.14.317 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted okay with Linux 4.14.317-rc1 (c6b4cc5cb=
549):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
93073846
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-4.14.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
