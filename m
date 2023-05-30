Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B1A715DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjE3LyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjE3LyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:54:10 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2102.outbound.protection.outlook.com [40.107.114.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF3B11B;
        Tue, 30 May 2023 04:53:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrEh6j4eK76A16j2p0xUo187NfDV/JDtlOmvjRN9z+AvFiD21CYgM7QvtToPkng6+uhsZWAYmfYx0XLOTSJHgT6gHAuqWSucXzmeBpAI9iqqmdMQHWm4PODAn4N4mObXZBEfiFvS2rtF6urO36wcb6z3p7S9cBtbqDq0Ne/PKQdGEVtSTeH6cxMcctUV4g5O+BepvxyYCAA99AFsh3FfjOn3qIV0RTBT4lav/2I2JxnHyl1bNcBCtjymddIFUHoSR+JFt+t8WHr9EgQHCOxulsbUwJKTHP3EEi7U6H3bNmYNJlecJrtlzsVMnUTiVMuuVJHfa4uzGpXR0m9EmA9bUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEnW4bUUqnpVKwbIx4fvFczrG9iXe+sBsVmERqZFg3o=;
 b=f/OIZkSgEY2NFu1rs8oEcV4ohnpouDjq8dsSAXGSEdreMCr2CwaYInX1EiFzZ2u1FpCF/aWdV/d6eylEUeBUXqSUUrKkSIjilssEZ+nhaB1QKzafPz3ilV3+lQ9YsPpKubfqoqJdfVpco505zCtCSHiFBSBTQi3mD7UvOYni5ztSsHhY9AbIUyFAycGHN42x0uim2sS29yxI1a9HztLVoxWEie2b2MX9v0Gn2q/hdXQP1v+i2lVqqY62O+jlSAFAs3QcsTbFDVfl4NXB0MadDOheR1KF9aOcHDS66eUpAmzkLDXCiBVTXp6+MoMUfqI2rfKzyyTaRzCql/ytJjqaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEnW4bUUqnpVKwbIx4fvFczrG9iXe+sBsVmERqZFg3o=;
 b=A14obDvHBPTJlyCXlaEkHqcKUPU8//2QUXO2LykVm6R66H288ZYcgVFEorLZEtAMxGrKH3wwf+ZqTzWcH7sUhfOtPWzaOK2BXIjgNHvkfAq4VOkQNBQsSatUS5ByBJOAAOUDmGGrVPbygCOPWVwEkt8nlyPfdftdh6EUQjFuFIM=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYBPR01MB5390.jpnprd01.prod.outlook.com (2603:1096:404:801c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 11:53:14 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 11:53:14 +0000
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
Subject: RE: [PATCH 4.14 00/86] 4.14.316-rc1 review
Thread-Topic: [PATCH 4.14 00/86] 4.14.316-rc1 review
Thread-Index: AQHZkZiBHR80iTLvS0Sa6sy/Z07GZa9ytZxA
Date:   Tue, 30 May 2023 11:53:14 +0000
Message-ID: <TY2PR01MB378845DD00A6EE62562A337BB74B9@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230528190828.564682883@linuxfoundation.org>
In-Reply-To: <20230528190828.564682883@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYBPR01MB5390:EE_
x-ms-office365-filtering-correlation-id: 91993e7d-25a4-4767-be04-08db61047365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a5eVuHRKBBpIl/cw2SZWlgdfNiUAxucZMrctXsNr2JVdXcoSxEH4EMlHwnNgsUunYgqXLiZTMPsUGaVGOwOIccAjIaHx7Pkjz+y4Bt7bRcXpKaPW3NLqkOFlHCoflgrZni3rwtS0YyHv1yby74KgjzC6PCTVy8w+BFYBo4bJCQovFW9/QOesoExvTaGCkG4fzwcHSrhQrqGH6IZo8ToMAs3mRZ/+3ZB9lbdXWYR3VTvuyuz1hA3PqUiFzZIL/nTG3+nS5RNwagRqFfAdXSqFbj6FR+NqN7Vl08oy2g/nAj31UJ8o1A68c/iw4W281YFwwVG0ZXmsKbVMtk591Sokd6+5DuQFCTOTClDdPq3MtE9PO7ZudmabxCCmjigq2KVV7XEbXZ1ETpHLuybXE1yDIW5PxMgE7MSdYs1z0ShQnjgs61tq8wL5ikfNTinueuFnZZV74hDiF+06bewPdrJIhdA1AtOpPs1PZJJK3ymaYucIEIpaRqbW9Ma65kfD9WrKjAo8A9/LFLaeIEfj8tjzDQmx+8nh0wzITwtGMztrcpC9xDCjSZ5t2v7+DbJwTq2sOyOv4um33mi9lUidzsnbTB2SjXFVrX/LkECFXnbEC567KT8rLuqB27zKRNvJ7qonYOaG35qop9RTcDYn61SwBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199021)(71200400001)(478600001)(54906003)(110136005)(8936002)(52536014)(8676002)(7416002)(5660300002)(33656002)(38070700005)(4744005)(86362001)(2906002)(66556008)(66946007)(4326008)(64756008)(122000001)(76116006)(66446008)(66476007)(316002)(55016003)(38100700002)(41300700001)(26005)(9686003)(6506007)(186003)(966005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?xampLcM8n6WkBfHrVUb+kGnKdDJsmU/GHCINYkojDhbMhQj7/7TP234b?=
 =?Windows-1252?Q?l5dAO5OI/lOr0wFKALTqrw553Kqy7NiKNCsX2+z3VgKCPdl4UdBL3Dd0?=
 =?Windows-1252?Q?udI6yqQL/ac56Cvaf7YGzhNtmNHfdKb+Cj5mKeiugFE3cfiWhgKnVthG?=
 =?Windows-1252?Q?87OLoKha493XBaidWQbQ48n//bumAGcNJpc4Y1uoAAVXq6purMmAO3R8?=
 =?Windows-1252?Q?vrEX1Cujh7QJgBu6cBWxo696Yd8kdqYuK8IE1CGZFXqWhDpiob3YzmTW?=
 =?Windows-1252?Q?Phy7WXJtpk3T8A8MEWeUwq7RaMr5w/XXqmu0LGpDXQiwkj2eQA5vGWWe?=
 =?Windows-1252?Q?+CB/yiiqx6fq+hcQnZK/WSvs7eK9gjAk/YC77aQLFTWRtJUWKdiYNzk0?=
 =?Windows-1252?Q?xEFEyW2uYpFkkDUFUpMNr51Zyzo/hM99SO0ZPvuockpO6wTsSQaTQ+n6?=
 =?Windows-1252?Q?1yQYBzCy5tDCQ8G00UG1cO0p5OKoKyTX2QFG4BDx+7NDdF1urPHWmfst?=
 =?Windows-1252?Q?ARFcbcRw/4MRwwaqrPOyANK/p6/y+4h5xvrfuvZMxd3UyX7WbLqRjjCh?=
 =?Windows-1252?Q?gl+w9AJWZilEhiQQRd0SZ3LRJhiGDx2Z/hjHRua4UvBvu/SJZq/t00xl?=
 =?Windows-1252?Q?RWyZpN4H9oOCn72VGdtwa1ltzL3+lqP85cCoPFQYrw3rmzL8GzSXmirY?=
 =?Windows-1252?Q?fSJOg6wZazeoYqmrwj0SM9s52WXuAf1yP/aX5jDsWM64GE/QUMVlEEq4?=
 =?Windows-1252?Q?OK/n3zlagsbBWXviE1bfD7GVMe5lbmVXUyJo/cpoDGQbfCF6T6kgDx7u?=
 =?Windows-1252?Q?z0fm3TQLWcTbFs7SKLgDtj7TXwNZrEltKfNAbdrr9jboZLY/yqP2kcav?=
 =?Windows-1252?Q?XfPsk4fOS00QFgDx4pwfSoUoZvsdhpkFvvAQfnS5MRB6JYDezeLo9Q1F?=
 =?Windows-1252?Q?GrX8xjvHeo+S4dETlwRg0/8QIH9z/3+Kct8i6h/DkSTFkR7NCUs+sLMP?=
 =?Windows-1252?Q?VpkPT8CJMEXUXJ+Krr2xWF6Fs0iryPPJXvmo9zUptd3/S8VoBw6rlR8N?=
 =?Windows-1252?Q?+gsFvGSL7LaGENh2sT5hhxAMCgb8mFTeYiZA+0FMa88DwlZGBV3ugbwS?=
 =?Windows-1252?Q?5zK4iaKa3ULrn21E7t3bI+hgmVQciuI4Yfe/EWUaTLfKWr3RA0WzsUKf?=
 =?Windows-1252?Q?S2XOP3K4K0HARYXRUy6Q/h5GlYwGiMK2b3ISG5+/EupTYtX7HoEwL0zD?=
 =?Windows-1252?Q?yV5j0Yh4hYtP3DqFtjBf8LCNNz0milldgjq2j8XGD5inaYInKVEkw/0z?=
 =?Windows-1252?Q?USkKjCL56+1y55UdAdXHXHg6JKBlU0lFj2cx+tPatGCDGpcrMFdoGhQi?=
 =?Windows-1252?Q?36ha3DptTRLKNPdXjWRUY3CQc9oXnpUR2vZN8Lq6qy6eRhDwqCj3qxpg?=
 =?Windows-1252?Q?4ewcwgblQwTH80K1J31/qARuEHF9eW/qKxdYaFTA4Y2HNzFvWFBxc/8T?=
 =?Windows-1252?Q?0x7XezXHiHDcl70o4TBlbM57VlyxJn0J7RWt18pvIBjEtots4dLg+xZu?=
 =?Windows-1252?Q?OFWRqfgStiTuJc583ppK6yxfuwoCBdLAYg+CdtLfhEEsh9k4y8VYIUTi?=
 =?Windows-1252?Q?ea0hHoQyhtKyhsbuG2dydy6jLqXf1auGd6y3XOnLhBoID0XsmUL9MtIU?=
 =?Windows-1252?Q?jOf5GFN7oIMS+RChaWnnpUBijijW3eNzD7zqec4GoCJEKtv4GnShmA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91993e7d-25a4-4767-be04-08db61047365
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 11:53:14.6477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqh/ESiWivW43OC337uFRaieDWcmcSK0NvxEZDgx7f4vjEgU0xVbRLPhvsAs6jZPWgyLkeio/sCrRdlfN6RDe+2+zZ/qOWeRiYYNMvYoFNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5390
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
> Sent: Sunday, May 28, 2023 8:10 PM
>=20
> This is the start of the stable review cycle for the 4.14.316 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
>=20

CIP configurations built and booted with Linux 4.14.316-rc1 (102232d7564c):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
81424998
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-4.14.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
