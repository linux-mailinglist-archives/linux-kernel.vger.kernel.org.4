Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BDB736787
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjFTJTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjFTJTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:19:03 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2130.outbound.protection.outlook.com [40.107.114.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0AD19A1;
        Tue, 20 Jun 2023 02:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLx+EnyoTEFnFza0RLNcEpSUgFK81gwY/ZvUYZgOUEswrATAx32PKusIny2OjXLLya+33Kt9DymHSDKT12L2+2UiYh+F39hQ7P6IGk1m58ZjA7dMrkFs3fCvw0WxA0ypv1cdfQHx00DPad51tBFQVFCWJtyTI6k6GYLdu3DPYXpJ8onpfQuQ22IzQDQZCf8Q10fqAPCxFbaNRhD4VtfPbSFQWmE8VajszRrNwb6VN4RWTKCpykkxl/eu9pMcohAMiiqoE45Qn54b1tJdLh8c9QYwnW1J13AwxneuVe+GgL1MQ4PJkETP1UqacBTqkFphwVqQcCNzS3kHKcaC+ore8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63UpFJu/FgAx4qMhIpWgQETwYWcl6+ZCDHWDFY9fneI=;
 b=h2uemAuXO+HPMp9Z6cu6k18gJRgobq+EWaXvSTvBZNtQ2ErSFCb8TmOvp7D8M9++qSj++pvTjBmD8aEyFUg0WRckfCW3EHD2ht0gqHkwG82SX58bW1EE8j7PPIrL66bmb9JPJ0weBlz2nlIljNRkoNCGN2GB7UTadQTTs/45jQ3D8qPY6v3KIxtu0Wm2DwFBKi500/E9QrySdOsgsxaQEeB81b//jv5blkb/8yLKvoWCTgbllfSL+UPpoGtfPIZieLjt4MZyu1uYwXiMUd8KCWf/IbKuNbYoW5OxXOvfbeYamrqBxcJ7CDzpTcJpGpUC6KQFXdYgomXmbxfUnCT1tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63UpFJu/FgAx4qMhIpWgQETwYWcl6+ZCDHWDFY9fneI=;
 b=PrhatHOEhF2ZdD3masyGNqllxqF1yT2WwR99sWQ+3zzD+RKdBas9ZLj2SI61FF3r5ygUYqtz+noR/q5eZhsKxl0BPrATJyj5YUa1p57n/zLmIgdxWIMcEXM9Cw0bffiuBJw2+YMOkNAh9tP9eoomZ5bN1wLSNcMOGAbWGxeXh6Y=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS3PR01MB9414.jpnprd01.prod.outlook.com (2603:1096:604:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:18:33 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:18:33 +0000
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
Subject: RE: [PATCH 5.4 00/64] 5.4.248-rc1 review
Thread-Topic: [PATCH 5.4 00/64] 5.4.248-rc1 review
Thread-Index: AQHZopxE5sj9E7ao4E6d86mo7mImEq+TaTdg
Date:   Tue, 20 Jun 2023 09:18:33 +0000
Message-ID: <TY2PR01MB378854E8406DF3BD5E6F9BEDB75CA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230619102132.808972458@linuxfoundation.org>
In-Reply-To: <20230619102132.808972458@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS3PR01MB9414:EE_
x-ms-office365-filtering-correlation-id: 83577d2e-0d0d-456a-0b44-08db716f5236
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LpmXo7o9v+TIJRK7Iz+0WYA2IVUzMeR5iZ+mM8fx7VkEX9FviSD3hyCuiWpqHMHuolpRw9AAwnkLTdERCvXOxdDBGD2bA/eWHM8bkWVjEwPZdS34eLojR/KZtpv8wqEP2049SZJZVKlx+4F60HtfOEUn1QYa4toKyemJ1ogHcwLN2GVZjCZkqFL3vpAcfECFTQGLBjNLVWkaKM1E5sG6hmoY9infIWUgeE7FYKmYgxAyAcjXULBnnfETYSGgAMcd5tTYcCWeCVn2pIHvG/1n5Z/LTWOEDpBs1k6yeTA64qI6vdG4aXA8qPCeVoyfnuKi1s+2+bgecYDGGKsPsIM112lWI1wsCQc8pabEwrMZ5cb6X6/gwtWvL1rQ0eX2lB4UzbRDts7hk01Vrc2xcbvVmLDT/L/X90b2Mq5DWgS7dWWQmx+iFMRir2NjLER1v8Bu9InkIAblXcMGfYvjLyODVI97bCMbGRrN+5lyBFrzR4DcaA8JXFTYhak5g1WE7d7W9WUnIEGgJyCxwtsL3fyns94rUoQ3AkltPv/aKwas0GU07I6Gnmn5bBwaizt9VHFLpf0ahOR9fUdU/Fu2aIKTcxkxUfbMwl30GmGribWgMxEUfOZGqBQXITF6ppnphGtv/oeq11w6NpgcxeyCSPucog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(7416002)(52536014)(122000001)(86362001)(38070700005)(2906002)(4744005)(5660300002)(110136005)(76116006)(54906003)(64756008)(8676002)(66446008)(4326008)(8936002)(186003)(66946007)(66556008)(66476007)(26005)(966005)(41300700001)(38100700002)(478600001)(9686003)(55016003)(6506007)(7696005)(71200400001)(316002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?0VSg7cKwb9D3/0g6VFW5N2CsgJdphtpc8BbN64hHE19Et0sqgyNUkb4z?=
 =?Windows-1252?Q?990tSsliQ1won1NQuPqEjetdiXi7w3ttXSSIMnDJ8ewguxi2fT/AuHHQ?=
 =?Windows-1252?Q?ZcKUlpPF8dbkgW5TYW+joqUKBiCE6TqAfpE3lJ+b1bu08f8bQxJJglYj?=
 =?Windows-1252?Q?rUm0Fu6lY87nif0CtMBqBHOqA9Qw7ciT1JkDaT9MI+AKXKyVNyvFCFji?=
 =?Windows-1252?Q?Mu8Gd0Q7htSYBd/DacZBROHwUOlcuqvAcYW7J/LU1+TDxUEACt0ZxrO3?=
 =?Windows-1252?Q?1pIXbF03RQuIfYIM7QOlKAeYUBNRxTXjWvqRG9tdmpdbMWKzokibdryN?=
 =?Windows-1252?Q?s9CPkaHOtqGVIHFGkndhNAPihngemNHIE3wIcpdPZ8GLLO/8qwmLm7mX?=
 =?Windows-1252?Q?ta9EmW2bUy+djmAjBuJvTsnbhzHpO7pctGXz/7tM1rTms1/fJ+j24c4v?=
 =?Windows-1252?Q?tgHx9wdm/CMSdSMARh8vJiY/e3BUvfDond+ScHpi6emzyRMLWV0Mb6LI?=
 =?Windows-1252?Q?LZ0BqJ/Ocf1gD6drhDYYAHQKE/2g/IM+5ui5q/cRRjHceDzScEjVFHje?=
 =?Windows-1252?Q?VV95RgDkkimrc3KGo1KkBv6wR/YvH+BQYeek2iw1rQBJ0wC7vCLS5NSF?=
 =?Windows-1252?Q?t/CGSpB91qOEyCZQgdKuGZ1MHfnJ7cgCcURGtTJdloe+fKUuJndqszjQ?=
 =?Windows-1252?Q?9qOt84GKkeQyeZr4NYWNNZdIyWtI5aHxUBfcNtXq2/QtZfYAu2jYP/RV?=
 =?Windows-1252?Q?qajLTyWuLdvWba7yKfsFAU15MuNyq4U8bYVRP1YYDVAf+ivUsj4hFbxy?=
 =?Windows-1252?Q?j/8MMI5jdN7nUoPAMg62IAp3YAIXTNJ6dljMSXbjj+EiGIjV4SMtxuhS?=
 =?Windows-1252?Q?ozlIJpUoRyTlS92X4JiGueCfBDw6Su7NK/nlwoEtmb1kMGSE+EwB6fVx?=
 =?Windows-1252?Q?yOPu59rYOV2DKpAId59MDDJHoiyRl8nz/coqghXDMFGy3xya1mcTcaUu?=
 =?Windows-1252?Q?9MjJNx0gvIGasJWJYIAI7LfFpWXNhv8ZAp54zB+C4+LmoE/pJresqgq6?=
 =?Windows-1252?Q?T0EXn3rtdz2Gtg+9zwtLP/J1/1nRMC/UDWBOITC23nr5IfwfH+Y5P+Qy?=
 =?Windows-1252?Q?JjW63jx/HETybZmwjwu/g9BHjoNYqtOhghuiGmkJlZtc8gIM9SbtCZVe?=
 =?Windows-1252?Q?4qnWI7X6C2FNCk7oS4/Xo0nrZgrn9UBmcJJ5OZEgoccl4uhwdu1fqOlz?=
 =?Windows-1252?Q?nub0IOcFvuCBLRsb+0JdISkWS06tj+2r77hVwGDfB9twBQFkRH5qlHTe?=
 =?Windows-1252?Q?lkeHTBwsDRZgqsAEDeoYogISWLeq74Y8bUA7kkMZle0PkgqE9ER4WcNm?=
 =?Windows-1252?Q?vJaqdkZJTWon23Zg/4HtfQvolINPtVMeAktR4fftrxE0roiPSpvIrjqs?=
 =?Windows-1252?Q?HQknM7ftgmCzT3sMkdQPHs2zIQSK3KwU6rfhVpsQGDGLdozzjxla6vzF?=
 =?Windows-1252?Q?S+XqAM70DqsurIOkoY9VQoKsLecKLEY5EqLzH2wjpupXZY9dIVwmBSw/?=
 =?Windows-1252?Q?pd/aD4PUyl9QXggAgN3QC9GDppERnvgmW2loDMJ7twAFk5S/W3HmMtbF?=
 =?Windows-1252?Q?xoZlPz20A2M8/eEHJYOVNuQGQ/Wpc3mR+OOseDv48asU0r0LuinQ4mZb?=
 =?Windows-1252?Q?S/7EUyz3DhZ+ipdhnA2g1mg/+/1SOm1SE+WxjJOX7S6NtRJ7UJszjA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83577d2e-0d0d-456a-0b44-08db716f5236
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 09:18:33.7611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +00egrwfoTw77fyngOCthjSiFBP5CG+0AphPZK1I5vX3gx5SO/bmunGYlI8RSxJEFMxN7ezf7cYjXMq2hiGyI5ny13WGdXhDRm/HwDTAU9o=
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
> This is the start of the stable review cycle for the 5.4.248 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 5.4.248-rc1 (d4a1c8c10f=
cd):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
04359302
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.4.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
