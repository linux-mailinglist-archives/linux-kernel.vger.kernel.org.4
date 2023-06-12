Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3628772D3A3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbjFLVyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbjFLVyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:54:02 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2137.outbound.protection.outlook.com [40.107.114.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B246AE57;
        Mon, 12 Jun 2023 14:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7YY300aHm329DkOMOKBLSH/06bNRqHp9QDtjYDCLI2atX9ZLKg56i6qUohMQ4NGYPz/Nvawt9zBfHfkgNBnZM8vn8op6jtyQllw6AyVGVnjCZplvtaIrTN46E0D10uL9bcft3MN1SJQy7P57TJaWmaUmqOatd8zpTfh36ifCNXeC8IvVv5tdWk0sYI6sgUllp6/ipvTmQnHNcRAuRK5OX5oXUppqOCnoWGs3a+cQTJn6X4PfNr/E5U/K52swpYOxg3iHZ4Dp/SFufVD/1Kj9KYjBi+KPA3Mlp0czSN56HmBHot3XJrxKuaW1LBGqBT6movuTDowOarHiNb06UUZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lh7X97iAJlF0zKUDgvDwjE6PEfABZuwW6QQR0XXfg0=;
 b=XmjXFuD6clZtoyQmgrzEAA0sXqSWuoC+nzG/6l22dm8pvd452e9m6VhgYFqfvM002PBQLyiQ0BGyE+cLufD0ysBxLYhW/4LI6fSNWEYkOolMwog4r535WLJsflkMzJJRVBlmBsj4u2XJqPnFr6KkLSGUBbE3SamjQ3giKXVCuo0SGDULjoMgL/pQT46In02VGSREnRrG9RoaZXzO8tQyEkYobGiJ+KAhFKLYFPvwNAowUlHTMYNKt0Ci+iArZAak+uSNZlKLBfTOLbZ2G7EPvt6JnbWZb0OS9hTwTlhsdH5VsSzHywci7K+tUyENFLNNWBCOsPbK44H0Zw+l1UCnTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lh7X97iAJlF0zKUDgvDwjE6PEfABZuwW6QQR0XXfg0=;
 b=J4fRHUvGcrGHAllkl2W6OKPJxGGCxYIXIDdcij1UUh6cxcmOf9eqIosRO8tWjjDLQf46FwE6TzXj64vwJHv2EWQ9xVppYIzBXtZBMVayvImRAkbYtXVEimo26OjHdAzrtpI6fJ7lex07e2nJ5Fpp2rxm/Ap5bcCOjT3S9Z9Q8fo=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYCPR01MB8680.jpnprd01.prod.outlook.com (2603:1096:400:157::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 21:53:56 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:53:55 +0000
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
Subject: RE: [PATCH 5.15 00/91] 5.15.117-rc1 review
Thread-Topic: [PATCH 5.15 00/91] 5.15.117-rc1 review
Thread-Index: AQHZnRvtd1gHifkYBkKTrgDEoTUGrq+HtH/w
Date:   Mon, 12 Jun 2023 21:53:55 +0000
Message-ID: <TY2PR01MB37881D33A19ED6FFD8B82589B754A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230612101702.085813286@linuxfoundation.org>
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYCPR01MB8680:EE_
x-ms-office365-filtering-correlation-id: 33136178-2092-4f1c-401c-08db6b8f84f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YVRzuveNWAOats6BCdqZwQELY8//wQBcCfx4dD2LCyD6xMGTCSOURvkDA+c0XGxLbUt5EWyab+vZmHcIqMJ23IyB2LjMGcNkIyip5s1d8l8iq0gAdFUPYPVaU8NoEu0YBS1i8gEAlnedJviuWcHr5uAgwZK3VJFKFOaH6q8UYRY5W3zkkyaZMtVXf5MkmN/lWJqTi7mwRw7evBnjtIEs3SBG8MX/i5iz0TqUK429mOkeqai+0lvnc/XPCAOqatJDydUc+ksjQHticVST/LXqKT/Mm1IOxK5ErhTTBZa24+ok37co+md3Oy1LLBw+dS/mA3K3Rai1G+5zD2vUrM9IPOcdJO6RIknTTmaKmTHSsvfqoBCoaY7jtLTn8UKsmzifBpy8yrvsmBaK5McIzxSGuTbpTjQmufmIItivl2YK7oz+1XhCEoRd8328R/4eCEHc6WwTZtDFWqNyqfak3RgpELgoDRA8JDgl5Kb5/BkfQ9CRWaThqs9BsyUwfwc3Lpo3LCnBKJr/UjFxVnnQwtS5lq5Oli13dcu90/oTyveXuPkRBCekT6a8YgvwAFO8ZIdoWVhcziYvBihuwu9S/PmwteqiGyD0M2NPf2DKWxYg+CmVQIEzUI3j8QhtDwuiy2scqfKlrF05hlc7MObB+puVAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(64756008)(66476007)(66556008)(66946007)(316002)(7416002)(4326008)(66446008)(41300700001)(76116006)(186003)(4744005)(2906002)(110136005)(54906003)(478600001)(8676002)(8936002)(5660300002)(52536014)(71200400001)(966005)(7696005)(6506007)(33656002)(122000001)(26005)(55016003)(9686003)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?XQHrIJofFd/gbfzARjIEAEVHl5ZzI6npUQQdbQyRXpxkh5fvuLXRzzIJ?=
 =?Windows-1252?Q?P1K+dPBY9yhlHJl1Dzf9E2IYcg6phYIXedQhgbNnxljgKVQBe8l7bmU2?=
 =?Windows-1252?Q?Z7uAZJbZh7dtn1MQuqTA0WEirFfB5/JJ6JprMMiyVF8EFdrfYCz0/ufs?=
 =?Windows-1252?Q?4mCLd7WLqSvDer9tt1IKjw1cf/Ti6irU8GbipVj4ni37XKiPAQu5kqUN?=
 =?Windows-1252?Q?KaI+DR3PqA1qdNV7YRNI/hVZ6Mu5iL/RZGaXCUAjCPaWkdb8XuPsW6At?=
 =?Windows-1252?Q?NgbqZRj+drdqPEoR2N8wxX3sckZUyiuwqQy1ac/WlOZNjjQrI8+aMJiM?=
 =?Windows-1252?Q?i/Hh1SpmQhelFvw5/MhX2iTKPBt2oTWI2mkMW4howr3PKJSNw8DGk5+O?=
 =?Windows-1252?Q?2jPxYzDrfnmK4tEKGogsmbmkmrM1QEVcZdneC2jgANw3H1xD4pDZYwYU?=
 =?Windows-1252?Q?a9IoPeoH32DSLSzElWvWlO9oFF6neSK1/OVfQEzQUPKT5WIxotoJh0+7?=
 =?Windows-1252?Q?FYsA3QXS1YfIQWjnQpjo9vbW0Lqr/VGpX9W+p4vTc/XXojLamc+TRpCv?=
 =?Windows-1252?Q?bcs4V3Ch1nVfxgpaMu6kVI4GPieu4IcJnC4/saeYRlZGfceY2OBTyzvt?=
 =?Windows-1252?Q?2Mhkirppj9QVKWSsCu0QY5LFewqEqnXQ3SBNTvn6dGfTWxn14OojAvSy?=
 =?Windows-1252?Q?EQCXOD9zcITK+L81LQvzHNdz8KPs1Nd5OZCjsnNpWw26jNdV4ir/JVih?=
 =?Windows-1252?Q?AF9LCUQBH9eDGNN8ahZqpv4kylhGLEybWlNSC0SRQUKbKnEzJD0C1oLY?=
 =?Windows-1252?Q?z00aUPJo1hH9ExnJm2FTB4jRrt4XGy1TkShOFuElALqoZz1uAwtcWrbV?=
 =?Windows-1252?Q?uzMjCUn0vwcXyk2V8dA6zYCKVYNXy62V104msIUNidXjk5FeK7mIlI2B?=
 =?Windows-1252?Q?TTAB30Z+9jLbFApaduqPCByuZF5po9mytsfPtkQ/DbOpaF80nB5q6b75?=
 =?Windows-1252?Q?ozxIOBvKehJyFMLKao68TiB9mwx3PJoMWwGNtDwedoro7spjsJD5eLmK?=
 =?Windows-1252?Q?s/xAIZbq+45Tk73L998NMPvHkkGqtmngWpRi2gWwHSkkOCrW/5iwKWFL?=
 =?Windows-1252?Q?3nmfbVVGABKoJNbPf/KLjvQVRB/B4j49mETc5/7J+dEaOrgqIegY9My+?=
 =?Windows-1252?Q?cpUO1aFsxrxLDpRS5LiUCWOcEkmVL0AaQwxOKRkR9iN6AlLMzdu4qvuF?=
 =?Windows-1252?Q?8Qd008KOh+vcdx8C6MvgB8ghesSPGtJbgKrEi6WflHtLS8W4vt/2Hi8/?=
 =?Windows-1252?Q?kT1rU2dkgbPQQkSv3c10Fz4IFiYBXqnP6jp/495KIW7GSRh5zZeQxz/Y?=
 =?Windows-1252?Q?0H7LGoVhFDsyRx1OGSMsPah1DaQGPeBJlvJM5TJbG1GatxgYn1Vr6JhS?=
 =?Windows-1252?Q?cZjXxEWDZH+cGgJaUu4435DJBMOo/8kk9OS2D/3/3jAStEYxfj1g6Ee+?=
 =?Windows-1252?Q?t6bIk+RVKkUuSk5E/cXsg7JUCpeiv1NvuR1qEPRB3zBCnXfUZktwz5q3?=
 =?Windows-1252?Q?srNHHu+sGIEsKsIM9/8H8R27/Ll1pul7DrhFGRHMsHuou6r9pOG7laI8?=
 =?Windows-1252?Q?QB5qcEBQRHMYSgD1UpUtrtttIvRsqPXKy+RKUHCDiiHD3p0JtwySJ1yQ?=
 =?Windows-1252?Q?p3bBnyyhU4zPg0xt8R9+Mj60IrZ+rOsy8KYqWMBiR2wjPcEiwJ3DVA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33136178-2092-4f1c-401c-08db6b8f84f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 21:53:55.8179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kiQekt7ygwfjN79snm16N4zAPNzMsNyPKY3zJzeGl2b4aWyven7abqRu5bIZG5Yqhr/7wqSaK2ajGoYnPL4Fxy7t+QX19tbyGeLKc1gbdt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8680
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
> Sent: Monday, June 12, 2023 11:26 AM
>=20
> This is the start of the stable review cycle for the 5.15.117 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 5.15.117-rc1 (09ab3478a=
cfd):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
97026205
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.15.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
