Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F0774994E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjGFKVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGFKVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:21:04 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on20707.outbound.protection.outlook.com [IPv6:2a01:111:f403:700c::707])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D209410B;
        Thu,  6 Jul 2023 03:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWuRpTzFota7mzB2MtP3nrScqLewfGwAD2aUUidhp++VKF5GJe7R9rE4dPjSSsXNLVQ79VkPTl6PtpLegda5tj2w3VTu8xZ5e5f5Z/sSqOoEFBdFJJwZqOXd/YFsB8ozSLpHY4Fj4qUhjZ7luX6irGwpQAYRq65juZ9Ea/U7ZH4S3hICmNk4XS1qeU13yrwTVFpBlF15wBCDU1v4fBxalLr8RlwJ79UEfiKd6+X4hSyfZqdIa6bd/2XOH7ohQlDu0RUOIRWvgs/1SBMaC+DICRGn78uRuugIJIuMJkuFvKtDy1iLNa/BlgpJWTdKNsqi/vICrz9jfNDi5I9cQMuC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xfj/tPh8ifwO+foo+46Fts0kLcej8KU9+mcryhXoe0w=;
 b=la1zGlMq246ZQrH0kJ5St4/SFNl2IBbDRzHcsIlQlR66KGi2ygfWezk5fgUsnzXeAOuJOC0Bi6lRbEB3FRKkT2+Hz7orJDN4VeQtQsHCGrUJNYVDuBgPaEYMvzh/uZJV5w8WpMw5O7m3kzl/39ebZLN1B12iHimMMGvyVakJ4V8lg8qKuHojqposD2fGix4Npav69a0gRxZz4xoIHIrK6jfFcNRzjT7uA0CL2v9VCwMjCPI3l1K3Bs89ewlrWCGCoH4eNlhD69oGiwoLz7CIrhtVJDpW9TTHvSwfcL7zISH1U2maCtHdrADtyYSj1PQvecV+d5ENkFopX7J0BEMYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfj/tPh8ifwO+foo+46Fts0kLcej8KU9+mcryhXoe0w=;
 b=BTnCMEQFfV1c/4dfRu65a4VyB9KgoMfSM/POA4e8VgOiNqIcEqEEtFFiSkZ+YuV7tmuy3b8ESJNmT8/+7ExQXDkxjKFKc+YB+vkT1+dcJsff0SxKbI1hbgTR7HULtNSDUPsLVET37d56P3V15yEQ/CRw6U3wdz3yi8ILIz7+mz8=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS0PR01MB5747.jpnprd01.prod.outlook.com (2603:1096:604:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 10:20:57 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:20:57 +0000
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
Subject: RE: [PATCH 6.3 00/14] 6.3.12-rc2 review
Thread-Topic: [PATCH 6.3 00/14] 6.3.12-rc2 review
Thread-Index: AQHZrlSQHrZUS0BVqUq9PCHrr65k16+sihwA
Date:   Thu, 6 Jul 2023 10:20:57 +0000
Message-ID: <TY2PR01MB378829FD870D146DC2DD1E63B72CA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230704084611.028211988@linuxfoundation.org>
In-Reply-To: <20230704084611.028211988@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS0PR01MB5747:EE_
x-ms-office365-filtering-correlation-id: 391e7923-2938-4369-29ba-08db7e0ab064
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RDs+KOOn6rd7h6EguXsvVGqpLdKxqqHiSxG7pEWag4Yz1vSuSwIG/3YX31Ft6PXXkItU2ck//WDIdrbkSJ7OPnYFMmaVxEa3HOexq/5vifP1sJA4Iog26ZfOepDc8rnC3vaH392dROaE/DGrKAjDhILl9kkPxXtXeCaWawACNVTM107AqEmVugDKD7fFf9LkGITsxPYZL2HE/m0nIakK96EOgbTorN2VSrNdNxCjiTIWl9C7Z0wu93II9o1o51vvIub4efD9ULh52E7PgbSdRQQW7pkSslusfGKpwCwGhNeTpIqYxcpXaNx1J03kij7qz3IHj/MlESwy6dLvLllQ0XTa8/+vdxtnVGK3h3DevGcNXzSJ+OdjWbTJe8gBD07h55TMvb8Ea0+6EKTWB/JWRZJWG6XJGsFNXRFhBdEIzx+ElBw56IJVgpZ73v9sF4ZNnpCSaLSJBcuS1QYhi6hIsOboDYro9E2jcNH+YSMWdNTgQvH7+5XCPL0IRL/CBEXgTWcCerIPVy2GunWp7fILx8zNHYrU+Z4y0TYbYoas8tbBZ8f+28KWhYYr/KvNcQFtAvzGxAaspn6F9xhwo/PDGw1nWYAobRJQKpSV+OcswFGJ6/gx2zIvZk0Uss/5RvzUdOIGR1u5nJPrkU2FZlrFdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199021)(38100700002)(122000001)(33656002)(55016003)(86362001)(38070700005)(71200400001)(966005)(9686003)(7696005)(6506007)(186003)(26005)(5660300002)(52536014)(41300700001)(8676002)(7416002)(8936002)(2906002)(4744005)(54906003)(478600001)(110136005)(66556008)(66476007)(66446008)(64756008)(4326008)(316002)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?KFmYQDhZMT38nPYkhrmkEbhSOAN1REPFkxUaR2T8/V3iOe9vLZDQsCZ9?=
 =?Windows-1252?Q?RtLGOGtCtHbsw0ntSQqGi8ysMB4QbuDBzmoLqh6oVVe1zflPxqboXYLx?=
 =?Windows-1252?Q?w1gtKnbEWZ411PxrXxb0/EX7yF1AYTa6bloldxgsY0d8EWnKF5r5Rs8A?=
 =?Windows-1252?Q?zZ3od/6OKxCELSUTtM7JfLU5ifLUfHT0KjSl94iynj6fxibAe6dS6CKu?=
 =?Windows-1252?Q?jR1Zd/yCPY/DdO3b6bJjy3ZzoIT3t87mzfU8LTTI2kNAn2uRF5+2eAyV?=
 =?Windows-1252?Q?doriqsvsInm5rm9kJVsk6xYIJu7QTy0BTzSSpBGSwgVkJGClEC6zJBiI?=
 =?Windows-1252?Q?yuVS1iGFSrMj3IiZ8FipaoSpf0H6eU2eDwir29vnHd/cqxwbBauTRh+U?=
 =?Windows-1252?Q?Rs1cuD95tvndfKv/IK4l8G6utyHFXUVTUtpbyqB/aoJgr7fau/tKPqk1?=
 =?Windows-1252?Q?U2ritzqiDTC5FUHXYOUgXCZkv8dhT5IYqn2+F/8vLLIHmfiUOIgkSUrQ?=
 =?Windows-1252?Q?vcfOq/eIUrPJpqhY5iBQKEL55n84SL1mhOMV+4KwjW3bUfIEEJlkLQh9?=
 =?Windows-1252?Q?mhAhGhD//l6EH6cXgJjlpFlSmz4zBs19ZwksfffGrTTtrBM+uTnQw6cE?=
 =?Windows-1252?Q?VlmCZ3qPTEkQ8OmMykNU7CX8HhKzipSlYVegjsaJCOTe9FVDdNB12Ahh?=
 =?Windows-1252?Q?UevOuMsiyQAL+gxRnLsIAUptOn7qGfb0w2Ruh9huWUzHEz3L0fug9nZt?=
 =?Windows-1252?Q?CDcQogzNIfKHUvhtyUQy6QfYBK8OBVkcBX0sSb5TCEPTlxUnt9w+dMzP?=
 =?Windows-1252?Q?dK/7XyWAbuBP7hRTz0ZVxsfmUK40yx8lFoJGZ9wXL8QhpbaUpEscYSBc?=
 =?Windows-1252?Q?Q5LaDPbfLya9KzBUG8Zdqbnj1vkp2qcWBRynD+Kd6dKxL73LXAN5/3B1?=
 =?Windows-1252?Q?uN0ew3Ml0v4Y8eKkbLROmQ8Rq56bkeJL80igQVDYQpWgbjFH0r6XlACI?=
 =?Windows-1252?Q?YEfwnL1y2sVz8tcdIjBnq9M1bzQHvMGzHqhKByRnAGOJE27K2KyGwFyw?=
 =?Windows-1252?Q?XFmB6z43mLxC8j5OwPFVNJ4UfQXDUuKk8rkLCkLXGPD50dQkgx21Pkzg?=
 =?Windows-1252?Q?c6pUtuLSnF+TRBQoc+ozYYiIbXkLVt8wg4GAlVopabaDv/h6A1piX/qm?=
 =?Windows-1252?Q?tk2fTend6vPgwI0YJjhPSsZXHKnyU5tUmXaXxUhRpMiQ8XIpOY5dsi76?=
 =?Windows-1252?Q?ZYoVU09AirIM2Vufzcs6xSdIxqu7jLUiSidazS/Lv8EHAX2N92P1Z24I?=
 =?Windows-1252?Q?+JyGOVcICPhsPaxuPSzIgOOtm0DquTq2Qa/LqiZ1px6phM+bnO40djFS?=
 =?Windows-1252?Q?uITFRgm89z3W6WDKkozjAvoN7KjnjOWR4CyGaPT+QlobhNhk4N1XeHUS?=
 =?Windows-1252?Q?v1mLWkkS/ajfkCgF10qoI7Y3//B0+AIeAQDWOE/YOj/rekayzuzFqhTk?=
 =?Windows-1252?Q?vDQaAHujIfvZ+tcGxrb+9uKljZ/S0pvQvx8n1U4yn4jLxIesZE+LlaUs?=
 =?Windows-1252?Q?RTQFmh8lMCM6EIqFPpdS11T7XvkI9dCBZmxTeR6qmiFT6mBcwAvGV7Yn?=
 =?Windows-1252?Q?fBkkjuCBK/oe4rDFiEKVCLjU4HpZ8Ysy0mEQ9Twkw1FlcO3o2vGV+m9/?=
 =?Windows-1252?Q?q/329dQEGX7sFmPEMCxk8nzYFFAN8iFwkmHMH2Jbq5uTEGoQNbt2Wg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391e7923-2938-4369-29ba-08db7e0ab064
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 10:20:57.7151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VgXW/au4hur8zuo7fao4EuNZL/rcHvQrC26n72LrdBcCTTTsDU+S56KiLjPHilD0c+wvmavrx2l4EzgmZOf9i+UB1ksve2XNFn9NHjeyWTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5747
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
> Sent: Tuesday, July 4, 2023 9:49 AM
>=20
> This is the start of the stable review cycle for the 6.3.12 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 6.3.12-rc2 (c5daff36a0c=
e):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
20271055
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.3.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
