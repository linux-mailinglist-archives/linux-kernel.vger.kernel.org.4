Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A550B7221F2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjFEJT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjFEJT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:19:56 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2133.outbound.protection.outlook.com [40.107.113.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575A9E3;
        Mon,  5 Jun 2023 02:19:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHVmeHWF2KNBeDkhJSnt33bTuafP6OYet/v2EWAxCOG8RgnaK42WHNwV+Om7wBJ4uFXspQkVtS83jx4i4kkZh+ETxxDA6Z4nzpB80yXgnvyJyoHt97qz+DUBHNVD0dtJxmmMnfuIIwtJrRCGi2BsRFJSD7lPMiy4oMgD+HKv3L7+XHeJSECLDVE2qMhUwo0dLuXvWbX9zCkxRa9KzYC45r5hv2IPT8Nzx2caKnVxW12gb1jeDl+jzKQACcnU8O/GlfRhnQNcRABrwLBlqT0MhKJWj7QkTu/UmCBJq6U8UFFkXR2S+q88vosYQ3TU9+9CyHf5I/Sr+Zt1JCR4iyBM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzEecKdep3Mh8OXSOpGyvUglmSLhhopPgLQ/SB6R9PU=;
 b=fxRX/JKeEnVWoHl/qvCoifK92H8omwhcU4n3BagU53mQSI0aWFn7aZAqGgJrMUwNMYWwyEsb9/ETvGrviqJypzu4gMXbyoo7M/Sjh1QQliJ0qeOr4A+U3yBWfHJEK3Lw2CihD7WuKvDy76oyARvdN3rPUeESfDpTYDJABCfsIIVc5DdurDMqMx3CjJe+AJLPNob1todOUya5zT7D2NWwn5+VqRjbVbKKCrcczS5RaWH9wJrJwvsiQu6mntJUNSRP/MHDGtvAkfSXHn34cl2AScMI4d9Yl33zoqCDke0vJgJx3YXnXlwAyhGRSVuHPPu0p8K1HvybgNOCxE4D3WziUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzEecKdep3Mh8OXSOpGyvUglmSLhhopPgLQ/SB6R9PU=;
 b=pqakMhBIqM2xfa89Dbs969aGMn7e/aOgjBK1RMDZtbDiT3/Ac991zzVd2yjxIEKH9J5mkTrXjyypHeGFPN1VNileVk+wb92I9/Nps+UjZ1wnZMgbG3ExfaKBttEW5fbIl0z0/Mk6xbCofAvLW04RKnuW2y9/ZopauajVDrQ04jU=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB11377.jpnprd01.prod.outlook.com (2603:1096:400:3f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 09:19:49 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 09:19:49 +0000
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
Subject: RE: [PATCH 5.15 00/35] 5.15.115-rc3 review
Thread-Topic: [PATCH 5.15 00/35] 5.15.115-rc3 review
Thread-Index: AQHZlisAlwKpt9b2UUmocHMRZi3hC69774SQ
Date:   Mon, 5 Jun 2023 09:19:49 +0000
Message-ID: <TY2PR01MB3788BBA0C12F9454906ED14DB74DA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230603143543.855276091@linuxfoundation.org>
In-Reply-To: <20230603143543.855276091@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB11377:EE_
x-ms-office365-filtering-correlation-id: 6f53e3e2-294f-4458-77fc-08db65a6035a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g+7QOuac7vsAba381Jwb8tgDv1GMRLxsumDstfSNl4Drmuo0PFoKncNKlAiD6DlBwEWmYXffgmbndw/vtjmMBHtwuYWE/d+dqXAek0Ui1wGa0w3VLtw71i/vbNUOphcrRguf3i3iC1siPemA/iO2haUkm5O6nFJAL/WiTBfxImAtoLVnDXSmOBPwGtqdTs3juhPvurC/j5tdA5x+4LLphO3VNvWwET5vVRDYbin+0yc3O/PIMmVtUo77kCG2XxoJEW0fvg/tTIDwDAh54mRXR6A4x9/ehUF4yMTSE+cKayMf8rxd1eFA1kSrMRspV+mOYzvBHFcBu6WvPEvL2Weq5bElE6SPzDlFoIYOf43E5Pya6ooWR4h29BFqtRldowDpy2UU1t3cRbBgx1xXxE2w2dsvKLaXln7Oht6bkmjDFcted4rxXRUuW8ABQroKYsqq7B+iUqlFBAc3Dzv1xF7iCApchwzZfg7LH22ibzTIE3z1a0cmL3AE35ZG/8UbGzUzH6aL/4yrik6vr+78TufUhvzqrknmvY5D2OAB1ESZngDcWKtcKKZqvQnMtzAB3ubDBoHermTLliwcgbtooR699kmuQXxvTgNxWKhm36Nh31s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(9686003)(26005)(6506007)(38100700002)(41300700001)(7696005)(186003)(966005)(71200400001)(478600001)(54906003)(110136005)(4326008)(122000001)(66446008)(66476007)(66556008)(64756008)(55016003)(76116006)(316002)(66946007)(7416002)(8936002)(8676002)(52536014)(5660300002)(2906002)(4744005)(86362001)(33656002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-9?Q?J4VtA63+QGn/ihGZvCKY3mfKTeyjTA0lTADA1WhSPYMdl9BrfLgPY+p8GJ?=
 =?iso-8859-9?Q?vayqMtjCP8QMgW2QRQWeWnkuTTLpd9LjXBWzwVV2pFaVBHA3P1lPX8PIJ8?=
 =?iso-8859-9?Q?lR2/+CO4HFwTKBr822maP8pkQsp7XsZHP4G4RhfSGhAAxJbx8aIP693E9x?=
 =?iso-8859-9?Q?ubeVZ28tYZTeeaub3TymSR6vmQTnWBuigzV9NbkIQZXv8hk42QiwA8iGIp?=
 =?iso-8859-9?Q?TmBp+q3JWIcSxlMmCjJmFg2fSrz/+t3A2TUvgKHkGDHe+XMyau/IeYUe+V?=
 =?iso-8859-9?Q?DMoP21tfngTeTAiSIqemB6v9duMqxUxSN68qEL2OgkvgZ85JH0tu/su5TP?=
 =?iso-8859-9?Q?lRKk/aGnzWB7DvdaZrjnTOczW5I+67yuYFUZP12iHF4BwOruspgIhjfnbv?=
 =?iso-8859-9?Q?mTdEDUt62ZrQHKhncEW1Tx/U62sA0An8+lOYCd89raqiHxLCIZatPYAej0?=
 =?iso-8859-9?Q?+93ADQANYS+QjD0Ks0h2RcqXp6s+f/hP9/7Udqe+6DciAFbv7Ki+KIBSYg?=
 =?iso-8859-9?Q?6SI+Zs3v0eR7sOaqoqabuZXGkU8f0j1wnCB/qzWt3X1KClATq7nVzdbeFB?=
 =?iso-8859-9?Q?4Q7lTAwjwV6dZ5qVMZn8ESHLwO9gVaUnjkZmsnWWkIZVGzmxRmzguD5EOU?=
 =?iso-8859-9?Q?7HFZzKRqexvJi3tao1RtYTOKkk15QqMy1MDT6aMbMHGPwxWcZCcFHkCKe8?=
 =?iso-8859-9?Q?Rh32FYSem+MNraHhrqxaCnx4pCN3yp2E3B8xcR22TA8uUDKzq+Rxqxg924?=
 =?iso-8859-9?Q?N2yOabK26rBF05RrvWdd7XciXqwK6aPtGEGoPTGkbtaPDx1dYoq/XIzJ8d?=
 =?iso-8859-9?Q?Hxsv4PDuswtbIYt2pynv8HCimwoLNER2oJ6tP0FVX9BU4OQTOJScCTniZd?=
 =?iso-8859-9?Q?tJYf6oJZLMLeA4e0KfxZjLbreT0RW8NFfKWJ0Z3+4qHVqATwADlOGGqsU4?=
 =?iso-8859-9?Q?O9oOQkK0wI/DMIYNIOjzhiADx1HECRzlWbwGpb6Crff1Vba4cehQgzgYJj?=
 =?iso-8859-9?Q?H2cZhg56fpXGW/jxHQ6utXMzEg8/xLq+YnhwrmiajcHrXAuGmg5vGx+n6X?=
 =?iso-8859-9?Q?jbEQhsbfhSoEGaadShatgFby12jjXgQ2dWU3nV//iP5hs9olcC11GmOST/?=
 =?iso-8859-9?Q?o8kg3PZW50gj1tRNcbqUVsUjjcDje2aXnerXvMRA169+M7OrvUDqcNbzsc?=
 =?iso-8859-9?Q?7fGQCP14NfaPHL6RbWLM0AzGleLUL0fYA1PRDxblUbeHTaYc78d81Ae447?=
 =?iso-8859-9?Q?ckNU6VM8lBirqH4dPjZ7bZ8rPf7xX2nNEmt7P4jBWFPmCUT/f4Vm6uiOEY?=
 =?iso-8859-9?Q?M/0+OM3GkGjxRF+gQtnAZttLvpu60o6lK0BBf9MdSL2yWodFNlY8fXpVEG?=
 =?iso-8859-9?Q?/LEg9E3nsq0D/5MksqII0hwDCDRLM52pcwSO0cqymVgmHn8uAvq6wzGjIP?=
 =?iso-8859-9?Q?sea2VFzMcbDt4Y1aObTBafQ2d3W0qMxx00VkcjNtWf6sW6Edaet+zBZcx5?=
 =?iso-8859-9?Q?Z8afxTKvv19FtKt5yIciyTetHYuPDJlrX3f5tG3JMhH18RiaFXws/Sskp/?=
 =?iso-8859-9?Q?XjawuoNWUMx4F1IA52LeufvhcvFlkwnAF5eJRD11vq729PMbCIepv1HdSG?=
 =?iso-8859-9?Q?NHU4aNZvpd6T7ETriH8HE+RZTUMO+pPh8tWEDv7Mw75Xj+8ygnsl8MgA?=
 =?iso-8859-9?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f53e3e2-294f-4458-77fc-08db65a6035a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 09:19:49.7701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ek7OnS79QhwUiDsNWOKDGowrgh/Ulwgt5MilTYdHWtdNJDkbQW7oocxKy/WR1uzem8cE6A3j62xRL+pr8T5c3jwAbwfBPqWGlern5rk8pOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11377
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
> Sent: Saturday, June 3, 2023 3:37 PM
>=20
> This is the start of the stable review cycle for the 5.15.115 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Mon, 05 Jun 2023 14:35:25 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 5.15.115-rc3 (e43ef124b08b):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
88485438
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.15.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
