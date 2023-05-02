Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BC16F3D11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 07:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjEBFjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 01:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjEBFjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 01:39:17 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2105.outbound.protection.outlook.com [40.107.114.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AADA7;
        Mon,  1 May 2023 22:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJOPtUrv5uOxQs4ufm9t7lcduz3oTmAS7QhvXz3qoFOJk/4qKv3BchSAI8imbKqT2nA02cKaB/hpe6h/yyY7QUmsfJYQb2aLCkCUBrMx4A4fp2UnYXBEFJEvcv8bVs3qMphJKYmFJmpxQ2fSexvWh9zreKN4xwstqg1EBv9FXHxk+Mk6FUbtOXOx0dGeLlmSOFpdcnPQShb4KJ6/L12n5Pehkb8i4hJoaef8qP5h0pGiuxk1Y3UOCTw8TahOcOksJzsgnUh7MI17kq6SFsb5rJmfRMfwanYCcGv3TkTtAiMiuogWfQNdisWJorxIR3ePLxwffwE1MIJxQ5zMTKgJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vpTlrKJKLnryuQ1+6l8mXlFKJFGbOay3mirt4XZwF8=;
 b=I2T9J3WDX4RrzZbyQa8Y8Yv3LqdbCeFh3ZmbwVwoJHbbv4ARi3HbEfd37X1Oo9AE68AnmcXN140k6dyov6ZGrw8FqM6o5uV5JUW/FInfVEZbozZ1Q1HI34QDeHZM5rwrApRqoaTWhMbUvQBDEhX5w1H44DZsTYu4WO4eKkChn8o4VVdhFAdSJ+Ciyezd7hKcSYVtDzWqmtrUBoSRlrWjT4E/kqnFC2EsmquNY4PMWdVhqvgY+iZtJpCQGwlCG/gtKqpdDPzpXYsa/hG5ljLKkF6gNB63NHxMHHMs2+oQpJF9tEA5MLGYgJ3H8cpnCz4kErlrgapPrM61oJwE8DGU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vpTlrKJKLnryuQ1+6l8mXlFKJFGbOay3mirt4XZwF8=;
 b=H64HzD3eSGkwZRilA6q6BtLyLpwgwD0ZBYehog0jXeCyi/d29O1K1srPBnd9LbKvDbYH/2+NcLQunIGKgoFPnVrUqDciUGhqnE2LA//tYor26LO7EJGhbc34LnBSyN+/VruAQ9zkXXsFFgrLAVUfNJT+RkuER7/cwifXwKAdqgI=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB9389.jpnprd01.prod.outlook.com (2603:1096:400:1a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 05:39:11 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8b5:5f09:5a0f:370]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8b5:5f09:5a0f:370%7]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 05:39:11 +0000
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
Subject: RE: [PATCH 6.2 00/15] 6.2.14-rc1 review
Thread-Topic: [PATCH 6.2 00/15] 6.2.14-rc1 review
Thread-Index: AQHZecSpB3jQ4X9gB0GFjN/aHuIEj69GfCFg
Date:   Tue, 2 May 2023 05:39:11 +0000
Message-ID: <TY2PR01MB378886087FBE653B525422A9B76F9@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230428112040.137898986@linuxfoundation.org>
In-Reply-To: <20230428112040.137898986@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB9389:EE_
x-ms-office365-filtering-correlation-id: 036fc2c4-d051-4cc6-ffc5-08db4acf8e7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I5qfF4PI3f9VxcDqsexSgRUlrKrcebwCvoZXvoj8ZE5QociAPrJQ6o1xvSX7JGR4hiBRFphNrhxtIkdq8BQo2Kk4P7vG5KZZwzLZGxDo4v/vdrdH9cAdW9Y0mDvikGgNe2i/2OP5ksnqx5H5eviP21p7hP0UI/WFbFdSAzTBMkKj9UbguHBNClVG1As5TE+mR+K9fcYzcMztHkTnDRikN6j9MEtWc2Hz/jDiCsHYFcF+AZ1ytpy4dGNzRZ2WdKlzth/4OW9Ivciosj/AAH6pUsTpeCb9igdK96L/VxwnE6XD33TLiNH+qJRbkLi3xew1/jUo/GiVXFTZILUhQ3yMKeDL9R44/4DbiGNBFiANSD+LQuFueiXv1w7YEL3izAyKpp9rgK4VYYo1F9e1Ll+NCauBw+O5HSi6DdrFlIU31XVUGHSVzkqZBZ6f+Vj0LYc6NjZR2DMFCojfUDiNL/jntpMbCFCBC7lbZwLh/5eKLJCvzPrWUQ/wfR6y68Nhc98YnLPfwFl5t1qGfdrsTcCf58X60JcV8Ojbfw7p+D17WQMFonGlObpP1yv2ZAnv4Y4vswJ/2+cRUBgafhMlyhnfaX1vuQgl67tXc12/qXfgYRugH9HEQL6lry8ql7tq8D7M5Zyi+cLOPmvV3XZqOL1JDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199021)(7696005)(316002)(66946007)(66476007)(66556008)(66446008)(64756008)(71200400001)(38070700005)(54906003)(4326008)(41300700001)(110136005)(76116006)(86362001)(33656002)(966005)(26005)(6506007)(8936002)(5660300002)(52536014)(7416002)(2906002)(8676002)(478600001)(55016003)(4744005)(122000001)(186003)(9686003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-3?Q?cIrT60sGcrJFklthHt8Zx7TrUVJwPHrV51dDfV3MfNe6a/vxkhol+B4v/d?=
 =?iso-8859-3?Q?pcT6ib699vrZBG8USzpcmmqdItFWdetGEgvwRTE2XGhst1bzI8vFRK9JPL?=
 =?iso-8859-3?Q?7dERYiOgT4Lpv2sVlU+r/HZuQ3ZucznhxpyAoU7DqG8yTo2LpgXBjNy9r9?=
 =?iso-8859-3?Q?wp/BOFJ4xYMbKHV6z51vF6uarwjNgR/GL9d4WYtTgw8kVa7XgfFr5x9cK3?=
 =?iso-8859-3?Q?80UrMQogPp13DyW9312vDajQqazao/TF/X1Oay5ErBIghKuDZCdF2ChfnP?=
 =?iso-8859-3?Q?Lxm+dxTKFuebdSxyYMYu7GXl0TM/7Rl7XNDYUXsMBgQYl7tsJtSd16iP23?=
 =?iso-8859-3?Q?emtu1sBSvFrNK6iRM2bEuqgX6XqcS9HpPukFts0jJMHvgLt27dWKHEgpES?=
 =?iso-8859-3?Q?Sx/EijNs9qordbe1zlCC499XiKCzB8xCrfF1U8To6McLVZfNozRnSO+TBN?=
 =?iso-8859-3?Q?RX22LeAy2OnFspmVecanErvV1wCbzaxPJczH+/F3xmeQ75oJaunyMSRchg?=
 =?iso-8859-3?Q?m5Kihem7ER1gTqK8mdbi4PN9yR6fn+WFjqWUjgNFdDvpigAjlLAZMYHRkZ?=
 =?iso-8859-3?Q?vcuz2YwHtAF+JecGzCok6OPtvWqRp25W2IXZEm+8ZarGCqf3W2qCJGUwJF?=
 =?iso-8859-3?Q?xdOFUutvlhllitUgKgLmvh0CqaQm4Qqs5D8Sr6PVpXC7TCAOAsfE0oF6Xk?=
 =?iso-8859-3?Q?8bA/6D/QPXjD4oGj0IqaXbNj3b/mQkF7zfZZPdQLeD7cyPZ3sIw8I58ko4?=
 =?iso-8859-3?Q?cfaRWo5gv3RcTsk5OM7Q2pYY/c8A09MzmPY7JiYQVOSOjn05T0otXx3ulA?=
 =?iso-8859-3?Q?MsNzuhYkMgm+ymQrNF77Mnocfob5DyrsJoZTr6alkbquiIpCzA4B6KX68K?=
 =?iso-8859-3?Q?2XSLU3c0UFJIxBmvX8eqF14WUjgCjkds325QVY7+6V+SIpFta+Zpo1IVEc?=
 =?iso-8859-3?Q?Cb37TT2il0iVdw9tqBjoYvwormIGd+6jsf0eCwXrwZrxP+lSp4TfTVyVCE?=
 =?iso-8859-3?Q?5H/qEdbCsVfz4rq3wcYNfTzZT92+boGaAlGL8jq8xQhmXC3lOMsJzcX+kz?=
 =?iso-8859-3?Q?k/RLsnuv81r/WIegCkb0BCqI5MvLBuL4NEaOwrv7DidTKRiyKv9X4ljiGC?=
 =?iso-8859-3?Q?NtmR2cl5wm7rtAo7dJFTswkHUNlfeYbpdvOKuIyV2PJ8MfMgf1V9dqLL5F?=
 =?iso-8859-3?Q?qExMeKkpyJFXXn0ocv2WA+lxopDpNHA6COLdIYuVGpObqadyi/oVKWY4OT?=
 =?iso-8859-3?Q?aOpwEhwkqgBYNVMXaco+HabqGnIAt9RpSM8bwInc2Yk4mND/TVPE2WxA/v?=
 =?iso-8859-3?Q?eCKSfpLtWtDOVqnqUEvDKshBNth0SefF8ribHwCHKgBGzuwsDyiitYPH4z?=
 =?iso-8859-3?Q?OhF/DX4qrSqSUMWMcC12zJyMXwXbrcf5ytWs7jPWqBTIMu79CwkIJjKYr6?=
 =?iso-8859-3?Q?Wp7Avbn6vX6OUJNrhw/hQCWbL4MYGXkcGWbH1HkP2XT/JWuUpib/srTgPK?=
 =?iso-8859-3?Q?Kuf9Mb66N5/7twcd5o19diRfYK6mb3Ksgu9R/X/CZ48klimeIfaIAzlYfJ?=
 =?iso-8859-3?Q?uk2eYle2ZvAy1j9n9F+fXylv56ZKaC6oJYiIdDjoTPOXTWgmg4bUAYQH5q?=
 =?iso-8859-3?Q?OSKyPBJ2ISVojL/Im7Uk6ZenVhHFQZKJDJOHzN2cskbDriIDumeIbpdg?=
 =?iso-8859-3?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036fc2c4-d051-4cc6-ffc5-08db4acf8e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 05:39:11.1729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzKjQDlxhuwzk7yMXQMcfHh/x5uWP2R6QGannEHGQ8oT61mNI/bYUd7pqx9F3mLdIQV+yKf05NtobZuNpmyeC6WV0E+QpFaXIIs6OnoraFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9389
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
> Sent: Friday, April 28, 2023 12:28 PM
>=20
> This is the start of the stable review cycle for the 6.2.14 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.

Sorry it's late. Weekend & national holidays in the UK etc...

CIP configurations built and booted with Linux 6.2.14-rc1 (a451b003c306):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
52034529
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.2.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
