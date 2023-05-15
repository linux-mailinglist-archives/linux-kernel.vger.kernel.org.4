Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8034703EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245380AbjEOUaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240909AbjEOUaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:30:20 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2133.outbound.protection.outlook.com [40.107.113.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916873A9D;
        Mon, 15 May 2023 13:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUr/JDBFuhhxt0o8Kbkl2x6f6Umct2lPizj1ts4Fcx8QAIpKH81jGivUERL2emaAvrn27I6LEX/ow8IKOYIe8HE3hDeJE+S/6IALOZkFtH5e41wfNU7O88tDCRS3ns850z0zdhDdvGR/ItHYt+4FGg/OP/y6oN5NJShpxgY/vgYKSsrUVaoXTNARFiYoMCNpFKnk8249zqlzWijohFv0xzCk1qmwJsEK8S23XSM9ir2yLwME0jz8e4R08miwsM0k9zdw+HHC5pTcxOT2RCRnzoIKi+2oDim8ewgU5jOhoYfXrr3GapKL7bRtCPd3LeUMeN82AZFMKGGV0FtUlOnNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNrmG3QrZgb9zWol/+7LxSaX6mjFEtk4oB1AvFDyO3U=;
 b=I3bdrEhf2MNcCKeLdVOYPZWOBX6BflUCKmMAu1qw9qpsYZOMzp5CJDeBl2/pl9yGbllCOUNm5OKC9UnCwTU5141ruunS4Zh9O8dI7/jWGzpHuMqUoCsYk4s/aLyLBP/jgZcnFKEZzRlfG9fNNlW7XELeYjbpTktHOQ37fNnjeyoDEYARC2tryKoMAxlBPGlXum5usq29/n8hJmY0WlagrSnJBQkISNjjoAGtqBz1SdGlOgmkt/U3sZJx3d24wu8/BCxP505gGr22yC9LVEFCM9ezZAtRJlDM1zgoRw8sAX6zPw0ZtnpSjWkX2qS/VUT6VIW+yvlhcOfgrqfXwQ2RpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNrmG3QrZgb9zWol/+7LxSaX6mjFEtk4oB1AvFDyO3U=;
 b=CdICbDfafSTAKWxMybj+vPYmOq8H2A0GoI0bn43viKHyVOQd/ZxVKYF4IEqLOO0hZ5EvpGPr5f6dM3oEBcBDO7A31IQYk+IcUAwFE0NGUzueXjiDGO35aDgPMqX6QfLh3yqVv3ZiuycRYdkvogMoT6x4OLb5XxtWMuwGtfzNyiM=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB12072.jpnprd01.prod.outlook.com (2603:1096:400:443::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:30:15 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:30:15 +0000
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
Subject: RE: [PATCH 4.19 000/191] 4.19.283-rc1 review
Thread-Topic: [PATCH 4.19 000/191] 4.19.283-rc1 review
Thread-Index: AQHZh0vQqDBn+/X68UCAvZKv1Eoesa9bwcFQ
Date:   Mon, 15 May 2023 20:30:15 +0000
Message-ID: <TY2PR01MB378816E32F1493DEF02A95D7B7789@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230515161707.203549282@linuxfoundation.org>
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB12072:EE_
x-ms-office365-filtering-correlation-id: 4fe9552f-1862-445a-3ebf-08db5583311c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h0wM7Z51oSjmbuf/5OR/liaWnj56N2Qimvd/78Dd7xhN9Tgeo74N23n08G5wnKkUsmnqziJ67LrCxasgg3ZpLsEnxnb5N6wJ76iuc5rI40MovMUQ0DluN/FL7KMKkptkpZrrLryUy8qkS+tmrAEson4qzvkH9ipUCFdEzEEiqAmA7bshK2W2psgXzIuac8HyoU+WG00a7QO28Mw+exbSd2YZRFWdQn1p/szd/b2ZC17+7DLBOixKCgUfcQbABKlH0TipQsnip/7Q+jCeDYMQaV+AgLp5kfRO/urP0gIdEWip6wVj+x/pKNATuuiM6YmeiGFI7FrnM/MaVu94tb//j7Mr2VRmzn1Xyw+TivRIhPSxOQJn3JqypfC8NDnoOiY+tUw2B2CYIQd9VxlAgOCbVZ/8kOJH3XDSX9wLrXnTxkd/TRYbLWCEbkWgTd2LmgkxlsYDHUN3MZfVrG/Z0ohOsZOoVEp+AcjpV8mSGGAYoY6b8pgIdhaDTPSPklExn7OMifidrFOiNnr9TQe5wHICZYmHg/y7+vjq6DxZ2MWxZzvlQqYPCikoRh3WVwxeaiLb1NpnPT95pUsWOrlWH7ZEG08luigUblNuPklIXyce51STthySKwTKP4J3Qw6/gRePW3o/k30fH3i/jQMvNGFmcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(66556008)(64756008)(66446008)(66476007)(4326008)(478600001)(76116006)(66946007)(110136005)(54906003)(9686003)(6506007)(186003)(38100700002)(38070700005)(8936002)(8676002)(2906002)(55016003)(71200400001)(7696005)(316002)(966005)(33656002)(86362001)(5660300002)(122000001)(41300700001)(7416002)(4744005)(52536014)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?3GlbiWiocxbIWYuGlO5ec/tDrrYCnsIVjrUvbmEY+V+HpYvgs4TGWNIL?=
 =?Windows-1252?Q?sI9YdAo+i2GLl7d2w0MVOYppyImbv/0DQW2BR+e/U3f+3Xo7FsljAOFm?=
 =?Windows-1252?Q?5CwTtBFqqkKDYG5ED2/PngUQUypyR7rdszup0UdSy/ld1+z/ZdOLxowl?=
 =?Windows-1252?Q?n9OOMNQbTYXee1M6+0PbitAka3lcPEWZWQ7XTqIzicYZngP3PhmROKLu?=
 =?Windows-1252?Q?tDJF/kK34GA3ptLKfWQM6tLX9qv9IiBJbx8SNKlpRCq/YCXmdrHv9kpz?=
 =?Windows-1252?Q?++woZdJ/ZDwh2Z3fY9H4+G1eiIp4u0pRXQL4ALieafN3ws6WM2V812FK?=
 =?Windows-1252?Q?Ld66dJsAGVuQLDjOBIRMMJrPJKGQS+db/lXd+gqc32BBEaPLl7MGyMf5?=
 =?Windows-1252?Q?iLxiQnixMM1pyVnfq8i0G1N5Hn/DpIlUFxssbz40U+FUqedTsm/1L34Q?=
 =?Windows-1252?Q?Q+YzD6IqH2+lDrytVFz70p+ME3IX2yHeXZ8k7cdEWI1Wn8zv19+z4J6t?=
 =?Windows-1252?Q?CqOxljV3972riYEj6c4u/8jWnJYkubwvjhKkLb00e+c07UvGZHQ4XdYk?=
 =?Windows-1252?Q?D3S/F9S5gfWiTSwalbhUcyWSC5tj+yh47QfebjgHo+hyEjp8lWfoCc0p?=
 =?Windows-1252?Q?63F/s5k4TZ5iQ3Pi46ubbgJScpHbQzsBv/21dfVW5TgeP/p6P4+ulSuh?=
 =?Windows-1252?Q?cWKt2XJFbNm8l0KVgdQEjhi1BwJ6nhinMf89SSH3AQ2q7PWuai007qFI?=
 =?Windows-1252?Q?pg5iKhBNMWCIZQKIhY/j9cHTvSVhOUsC9vtcQL0krejeVHvL/5gzuZcG?=
 =?Windows-1252?Q?WDw9x48UbCxoK2QX4fsLJh9Ld9RZyR7bh8YOQM0BVNKd6DwgdCyuHwBK?=
 =?Windows-1252?Q?XOkxXz2uJdGKGXLvwQnlySIEkfAhOTpxfAnO3d5dArTHm5low8mzOM16?=
 =?Windows-1252?Q?xcsRBF7XM5dVfILacmbcMDncGD6SLjLD0dk8F9t6h9AycpO8iAn/K6Or?=
 =?Windows-1252?Q?ci1DBPSUq5N2Un9eXVojstIA1SXfR5EbPKVKs+gHSx9P8JU8dDMkWNKK?=
 =?Windows-1252?Q?YsfXgl0L4O9OgAQaVYWxvSUN+9ppyghLu7on82FWzdeLjMf/T1Lhr/Qd?=
 =?Windows-1252?Q?eVTliIxcA48FAklj/HxnTQJ1dLEIKdpq1869jiK9BL7wHI9ff5IngWpk?=
 =?Windows-1252?Q?3nKIeLRYBTfUFK8wM99rzURS7UaXAhmQJLAxVj3rm0ZrG6qo4VcYNSwY?=
 =?Windows-1252?Q?6ySFJeA5XunJ5qzY4fCGn1m2CgexW50N5KfmPplLv0oUvsK3x8W2pAeY?=
 =?Windows-1252?Q?GT5nKhpGT8mpPD12DFFqp9w0Mnzm8yZS1Bnui3YIqUBE5aXDsrUIAND7?=
 =?Windows-1252?Q?YQYyJAiXEYsxEJskTl/gUZdXtFBj3Dr3ily2JamRj28yybb6jYznvyaY?=
 =?Windows-1252?Q?KwUP6yU3XG1uFOf7aUITm+EbI5mUkbK6V8sSP4+nOx1xqC6O+Fx1fwIu?=
 =?Windows-1252?Q?qa3Ola5zJXzNQyKY1DTUz2lykbdzamT9E8a2RIj/+pkAaA38q/ii/Eot?=
 =?Windows-1252?Q?DanHQTb+SpCtj+lS41RzKqY5qLihpTlSGHdPE7Gvc39uBwtuBE1wjRtq?=
 =?Windows-1252?Q?O5/LcgtrTtiIZe6clC/xwH7KnOJz1mAbLDcf1BOrFRnNQ0q4At2JYcK9?=
 =?Windows-1252?Q?h1z0nWNsnGdbQ9jwLOSfn3DlpLO2GgTyOTvVaIpTxmDyHzvO8z+6+A?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe9552f-1862-445a-3ebf-08db5583311c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 20:30:15.5955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1ikhDsZhJBO8siWsSKnjjuVLUCKjVXib0O3XiPsPTOhKTURx8Dj/ijv4t75gXUHfbDDwUN2VgBMmK52/NTClHouuXkszVPxrvJn/6L41cI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB12072
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
> Sent: Monday, May 15, 2023 5:24 PM
>=20
> This is the start of the stable review cycle for the 4.19.283 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 4.19.283-rc1 (373cdd8d6123):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
67957606
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-4.19.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
