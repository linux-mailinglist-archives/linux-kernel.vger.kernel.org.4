Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B797B70CB16
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjEVUb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjEVUaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:30:55 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2092.outbound.protection.outlook.com [40.107.114.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E328B6;
        Mon, 22 May 2023 13:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFjGoSGzWTOJQRGRhFPioNMu9r5aW7HirdL7Q8QBzch+TbgXb5BCwDHy9UNnumnNeXx+XuLwxrXmJFyeuOZmACvoG+tIySQOBuirfR9u6O78h00Twb6r2r7j1Mdq8Z+866koCFInFql215JaEJjj+qPHZv0B7VvWXyf891tYsI2oFsP1LaygPjJbti5FIFw8IXmqoOuID0SRfiGX5oSTcaCg1NvuKucbhd3Yi2tIa28kKWABkz2NU/Px1HIJTi6M/2dbIs8hv941VJ2Fec/u0WlXvrzPrUWYjjU8bTEHvQDuBOgDWm9Wrp3JCZgeUOK1uleG9ZEYQlDLynSiXRMj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wILpAvqcK6KtWbrpvevGBInqa//wYoaFUEjPF4BdG00=;
 b=iLlvwX9B5g/hMiKPWJwiTmLch0C/tMSXJGeDRniSGmZpBK/rCIFLazXIpM9asWCwCNKGfoMWrjDKaQnQEtAcDU1f9nlo1fbts2jKpUF/imEZWVkBnigdlp9Q0U2pECvBDs1vuqVGXhr+LcblGfWLmB55rBqzRanRyrwjUBok0Kw+xCWxgUwWK5Eh6kK+80tqT4YLm3tN9NlQWMGWGjRTcoDiBAw9oW3zZXtJ6pvpoRf5C9W0l5wyjhYoblLI8gC1L+Q8E4+Cz1MTkZkEJH6FQrLWrr8uB0oKQZNSb+vgJzShy+9ojUdaZQ8cenpJLpqer7HgbSxbWVNsItO1tr+ieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wILpAvqcK6KtWbrpvevGBInqa//wYoaFUEjPF4BdG00=;
 b=Z98FGsVljLO75XknsgUJpNeP60FNjFGeFM+jwIBp79Arxy4AgWuX8uPHSjQn6cL6bJrEhVfx1rIN/K0/kQO7HiO3+zEBzJ6aDA+5+jnmyzn44bnH/jbbtrbojgjjs87rHrUcqjeqONBhAPjVU6COqTRbnnhkDa/TzC+tJZts180=
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com (2603:1096:604:43::11)
 by TYVPR01MB11128.jpnprd01.prod.outlook.com (2603:1096:400:364::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Mon, 22 May
 2023 20:30:50 +0000
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::edc3:42b8:8199:d907]) by OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::edc3:42b8:8199:d907%5]) with mapi id 15.20.6411.029; Mon, 22 May 2023
 20:30:50 +0000
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
Subject: RE: [PATCH 6.1 000/292] 6.1.30-rc1 review
Thread-Topic: [PATCH 6.1 000/292] 6.1.30-rc1 review
Thread-Index: AQHZjOLjckdePdZV9UKJELBLAwSk3a9mvmsQ
Date:   Mon, 22 May 2023 20:30:50 +0000
Message-ID: <OSBPR01MB3783582473896370ED1B8194B7439@OSBPR01MB3783.jpnprd01.prod.outlook.com>
References: <20230522190405.880733338@linuxfoundation.org>
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB3783:EE_|TYVPR01MB11128:EE_
x-ms-office365-filtering-correlation-id: 29200bbe-617d-4dd2-c975-08db5b036edf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uj1+n+/VRT3JfnB0+rZbnswFynxwNv3R+5xVd9CDs84dFkMnUoLWfZtDk/9bWW6wtVnj2/lItnetV7wzmWpw1q/XYqm+Kjmm5PlTZDNNUczOrGK/NrSgVRYlLo9vbTl38EdR95tpHSUjDTGQUSWQwQ4v0AxMfIwoxCU3v1MiOWVvX/faQPciVo25YfLt2/BEyLWIOv13UPrRTzcmSAlHfFoHRZ+W6aliIygcwW2IB+ctaB2j0NxGLdkgjSZHy2XoCI8myVHIh4FHWK9smjoff5YtYf8WTOk2C59ayb4TbspZhC0Qj4yUHJ945g7gpQkUe9w3lF/2a206iUbndcKjMTwakRFhi7PMFWLVxkf79f5d6FZG5MkxnTHYtgbSRFZn6DaMu2bTujwwuC/2GstriLZ+/UqKt+UNodvXM86xnW8rzvY9scjQ8pOzJWhH1gIIRUVqWCVppu3KlqwHNBPOn9FKAaK095QV65/KEPC1guZjQRfPPLWcvSA96gPI6zATaQQYrpxjR6yD5ATbwlLFY4/FVEtScR18/vdmbMyUl0wSTyzywsw0SstZesffrRfqCGKniRMx22PUO/jDvrjKbEnJNOrEYw5o1DM1lT/XtzFEUTynBNVhawp4YFuAINUfho2YmLFRJqzTV1r+50VlEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB3783.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(86362001)(52536014)(5660300002)(8936002)(8676002)(122000001)(966005)(9686003)(6506007)(2906002)(4744005)(186003)(7416002)(55016003)(64756008)(4326008)(66446008)(76116006)(66946007)(66556008)(66476007)(71200400001)(316002)(110136005)(54906003)(478600001)(7696005)(33656002)(41300700001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?0h0FhPMD8sc0Wfk/BR67Mt6amJyps4M6WzawV5gbLEMy/rH22bI0PlGOaN?=
 =?iso-8859-2?Q?bL8d26kSKFNe4LADUazUpqmbRsMvAYOraWngBoF2YvNkDsKpeDRrhnufVU?=
 =?iso-8859-2?Q?gqC4aztqBgZtI9tx6EkTGpkQI19zCqs+VWZqjr8ZQUvpi09ESqLd0VZrBA?=
 =?iso-8859-2?Q?M3TIvD6FvF0gqXBE87sGCGqe1vfaygJcB26rSjAwH4ckh2dlWIpjcZCNjQ?=
 =?iso-8859-2?Q?M81udr/WXBwQeni/67brZspTDvqohxFY1yXJsN4OlZiwS30n57F/sk0SKc?=
 =?iso-8859-2?Q?3hO3Q1FsTRqGVBQbfxEmorcIOKFUxBtGmX98twHYwzP9VDp77wO84PaT8y?=
 =?iso-8859-2?Q?9fqyWg5/9TvSBKOiffBCvsQI2zpff8mbZ7FzLkZa61HThMTWsbVS4Kk7ik?=
 =?iso-8859-2?Q?DJy7jncWRt6RZbpIAepgl+6ailvtiWudjPuAFpd7bY/9eWbLgq1cpEKv+M?=
 =?iso-8859-2?Q?WzjJCzRB3+dD+oQUxlAnSh4Cyfl4OFe823SonXy1Wem+52c9xU4demj5HM?=
 =?iso-8859-2?Q?qR6xEnvPaUgyQSww1GBcb61AUSQOZ9q2AwIXlF+FzzNBfDWK0FIg0wHyFu?=
 =?iso-8859-2?Q?AFAceCKKtWxjRnYhv/S1oEBzdE+cuVh9xC2+aw3h6wxUFIvZ/uz9iakmDC?=
 =?iso-8859-2?Q?0koUpLJi35CwdMiwsaIf4p4+wRpHOUUmGcCLAl8f+9zsp7B7xm05IZjwtZ?=
 =?iso-8859-2?Q?Xi2HkOtxy8oytPckt+6R0tYvXUqddxPyGQyYggBdn19w4p/Vn6/UjUJFJ3?=
 =?iso-8859-2?Q?q7ugkytQcP/bPa5sUHCSievDFmZ1urcg/0zKJFeaRTxFPwym4L8sLF9VVn?=
 =?iso-8859-2?Q?qMLfnQCRoH+bI7mE1qW+UX6kl6EOwu6pC8pv2yX1gh0lKgIARR+8Xyq03v?=
 =?iso-8859-2?Q?mEGrT9mt+/IK4sAr4loo+Ig8GunQIeMtBLcoX5pDSrz/fonbPOblyk7VyG?=
 =?iso-8859-2?Q?dJsKcId7BIN+pXH6om9j7k78fRcgOopnxVv5T61wAlwAaoZICKhNLHPSOv?=
 =?iso-8859-2?Q?StcUaFzu0wLvlCTTEHrFHwPYUXvJsPV2YcZG6M3lQkZmVsiYQYU7VkB8R8?=
 =?iso-8859-2?Q?qstJ13XYOs1sFzYWZGwGrPiCVrvjqo3W3h5bBOIEmHxtZMPu48nw5rlMxD?=
 =?iso-8859-2?Q?Hsd2iq+4vOICz445Dj6HeewA3MN8DUbGVXpTTGNon1rdknQzSzzf5BS75H?=
 =?iso-8859-2?Q?fRcYcAPkx+Hf/1JzojwFAW4Fxj384tVC5x4VidBARIjKaxdRDcNy4o+Ml7?=
 =?iso-8859-2?Q?TievDik4fIV1REUPa1TdLUVNdY8Az/36qwwcx/k16tkw/vs49Olm0jWfzi?=
 =?iso-8859-2?Q?6Nkq8iwNF6Kuh+h/Pk6cRmkgmrcBjlaocYxaRqAHOggwwoFR6Lvj7eS86v?=
 =?iso-8859-2?Q?p96g1Lr1s3jfiSH4w0Uecan6aTSftsKkeWJbIIr+V26CbQbi+ni5VAnwc7?=
 =?iso-8859-2?Q?BEqEUrFw4lIJbpNANKd7aqJnedq5hydtwBatUfM52Z3a8sdRXmcGBHEVDi?=
 =?iso-8859-2?Q?ZhMyRxeCy1E1Y/l/Y9UXlSBR91W/4jhZjfpmZBCh1PSIb5DgNmVnti9u33?=
 =?iso-8859-2?Q?4+LxLTByqcyfL3aVr141vlqHPC3GoCXuqARu/Ag+hnflRhcmeY58I8i7Fg?=
 =?iso-8859-2?Q?FPCnu/7EyZrJw=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB3783.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29200bbe-617d-4dd2-c975-08db5b036edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 20:30:50.6125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fx5MIyQ+yDT9RDYGf53ZAjmR8GiPwNxOo9MTJOakt8fi8mAAbRrSetAIHBz1JcPiSv3m3JoC0w3lfIe4cWw3aouE/C0seTnnVp16RlowB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11128
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
> Sent: Monday, May 22, 2023 8:06 PM
>=20
> This is the start of the stable review cycle for the 6.1.30 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 6.1.30-rc1 (e00a3d96f756):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
75108845
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.1.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
