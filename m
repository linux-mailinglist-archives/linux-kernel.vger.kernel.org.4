Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159D174D8D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjGJOT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjGJOT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:19:27 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2096.outbound.protection.outlook.com [40.107.114.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A690D2;
        Mon, 10 Jul 2023 07:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpoYN0kiHtgHnyxk22oUvtmQ1J3Ii9HFhsheo9xA7AqudgGwxgq2D6Gd1hvrYBepAz0xgxws3h9z1NdIQG/dlhfBUxQNJVXbR+TjkxbSlrujPs40jLZYpiH7scax2SsOaJRO8/RR8/0DLsUuddFmFM+RW3KnlgxP0LU2g9mM77Sw84XBVJSOVbXsqMd+08tRQmROhiwCCQxGEtjqFXM7gPjGPSinBjzZTEmaxGxymlDYKsd1kVFNQpDyG3DQYjptH9cx9iqj2ebwA2bz+AoHgVOVpLRIzHH25CJZIkG23dVeeQzjaKn7nA7kWwGK0QbpJJau/XWcQz82Yek2sCRB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jWgIOH51bTOMBRx9uwp0/8saAFS8fIOUYXCQ9rUBSA=;
 b=jchDM0sQ+VVjBB4wDl0K9yxAEZnH8p/io3XnHBzV224JztmBUhHcyChuH5S9VHpPXuigZzFLQiM/MqSJJyYY4ciG6BeV0yMRkgoIl7VVQXCrNRYVRHN3NB8hXv/krycQZvWV1O57CDA81grd+BqCwe34v98Rw+qp2wo9XSpuN9/RnSIY1h2UrnXVZjaAgDKzrd5lQHvB0A6fsKflklYOc4eB7pF10UC5MXuwKGKh5Z3yip3CE3rFHM+7jroRiEQmTn0nGmtiM57FrdOZ/J5aaY6rR3kDvlv/OutpEzs7TDpxrD+GkRwDODEd0lQMXKv1gw01+KqboHCuYGss/qDipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jWgIOH51bTOMBRx9uwp0/8saAFS8fIOUYXCQ9rUBSA=;
 b=mjUviFBHeLcCxzGof2pfZp3Lx3zdmMHUw1QRdV1wiz+EkE4wCrpleoaBinV0ffA1iFs0JtxGZVxud2pkAcZ1DKB7rfs3DF5vMxl5zVgY+XxvlahyJJHBmWvCd2ssup08QU2/I4wztkQOVzk4RjK4GMwDuSsKfjIN2q3vklXLxpE=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TY3PR01MB11259.jpnprd01.prod.outlook.com (2603:1096:400:3d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 14:19:23 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::6f67:84a4:13d9:2f28]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::6f67:84a4:13d9:2f28%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 14:19:23 +0000
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
Subject: RE: [PATCH 6.4 0/6] 6.4.3-rc2 review
Thread-Topic: [PATCH 6.4 0/6] 6.4.3-rc2 review
Thread-Index: AQHZsqZUbbvybBc3W0yYcUqMddzI7K+zDYMw
Date:   Mon, 10 Jul 2023 14:19:23 +0000
Message-ID: <TY2PR01MB3788B6F5CEDF6800E56BA784B730A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230709203826.141774942@linuxfoundation.org>
In-Reply-To: <20230709203826.141774942@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TY3PR01MB11259:EE_
x-ms-office365-filtering-correlation-id: 11c91919-40ad-4081-4aea-08db8150a8ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UxQkGu77rAD7gkWlixARlWBY/g/3frmiwiGwtNoYbaNESlPMHRPaXuSlFsdgT8lLntRP1cc6Gqz9qP9vUd3R1C5e7HG1cjo/6z7WUiYrrBV7yLsYqxaGi6/9MU6mSNH48jbtkFsb/zcItPMYnL+m5eR/Q9vxVjohehwyPEXwBk+dgktn962g2zVzz5ZH+iIuWrpgdqnFvUfLw1TjUfK/dqxRJQl+9cs2GWx8ruELs3oHZ+tH95afo7sU3PI30XJ+DKhea7WdPsnzlnVFpmSvnc94W8t9TLB7viXq+6K9g/o978LSynIGwsytQJmVzcJNaMWjMwUwjTciz75NK4kLNk/w2GWMc2Snf0JXkFbRFq8zAgc2k+8hJKE6Z+ECFZX3HzPsav9k7Fbm52usKDipc065y3asqBy4ydwfG1dSjDyxuUvha2fX3FuubnfMKx2ZcdprxWu6Ufvxs8rI075o4ALXwHz8SZBLHXwBKXGZ4b/cwXmUETdtl4KmMVVCJ2w/fpY0b+fW8QrsfuVOcaYVvvnbwwqF0s75Ldh9EzJABZlxuhuuV7CCOM++NKiz8zA1W4ggYRi/GIHyImEWOea43Fsg7EZYsVArRys6sqS0MRkVccPvALmpkqKxaLFAqObeEQRzvM6hRgwmMW4xiU+FSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(7696005)(33656002)(71200400001)(478600001)(26005)(6506007)(186003)(9686003)(55016003)(966005)(316002)(2906002)(41300700001)(4744005)(38100700002)(122000001)(64756008)(66446008)(66476007)(76116006)(66946007)(66556008)(4326008)(86362001)(7416002)(8676002)(8936002)(38070700005)(5660300002)(52536014)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?u62XlYmZ631IKq4iqT8LLlHAU+TUcSPccpZ2yUYukTO8jcX/uExNr450?=
 =?Windows-1252?Q?CW6HPQc8ox7J89sG/IqSZygpV7qokDGOy9mxZOs3scztMKEA9IDu0zjn?=
 =?Windows-1252?Q?9x/AcgNp1hyBHICelSTkJeepk7IXa1Ze42H4IdKfGnmXW8OmYhreH+Cq?=
 =?Windows-1252?Q?50sho1lpictg8UWW9mkVrH7brEofh0HBSCu+QyAeucedoiTkVC2GTQgL?=
 =?Windows-1252?Q?SNoOfaG89onENteha/By1zv6VaLdgWE3CwDdhnL+nGW6rGaD3CO9zCsy?=
 =?Windows-1252?Q?7Ren8pMmx9fEALrxM4DyNEneNw9n9d18fvwZADhWf63HNfJvrRReortB?=
 =?Windows-1252?Q?nLfCscXmcoK6LzYgR5yZV6QyZcmYMFaC6o0FUEz/F5VIgTbeogcZWZTL?=
 =?Windows-1252?Q?TJ93hX0yUEkGBuG2amooeWuB/Z2mLK2zqgRpvmQOISObby7POWNxr/bn?=
 =?Windows-1252?Q?nv0O7HkL42IzmkRa0FyX0xGQTGQwwO/4Q2wPehPgZj6J/yLr6GJmLYHV?=
 =?Windows-1252?Q?w1CfEDGXFhXPtZxlX87w/vf7HlguUdMxmMCbV1t4MpoO90EkDVqE8k0u?=
 =?Windows-1252?Q?apBc+90PBR0mfHfjoXJaEGLMq43enf9p7LEJk0ZNjplVfkeMaI2Thebb?=
 =?Windows-1252?Q?mfwbcRQoUldkPLeQY8XLrJJEkNbFsgl6kKx0Tj3gxLUwQXIK9guVv1R7?=
 =?Windows-1252?Q?jyGXTqqh5tmNNpufReUNdx9xiLR9OInbi8FZ4+wlyrpsBPv8XN9pdANe?=
 =?Windows-1252?Q?clvAzzDvo0pqpfNyMAAUC96vVyzyLZBT6Okp/fKP3Kn87bxNvxsiIEHo?=
 =?Windows-1252?Q?2eOrarSbP081EOUSIPbx1SByW4Rz6392Dh9n6DlbQ9PxXYL5IkWSxzuJ?=
 =?Windows-1252?Q?lUmARjHc9xnvY0SOAwRxEkE2LyJ6o2bf6VhLl3zZages7XB30qKW1hOe?=
 =?Windows-1252?Q?OY99ZdZW/XQV6N0jmtjHy5lsceusUMWR/n0a2MqZyh53/McNhX93jw17?=
 =?Windows-1252?Q?6xIVkVUaqoMYu1bb1II3uLCxMIHislEv9iw/WVvHrHjFrGBxgqOW43RT?=
 =?Windows-1252?Q?wpXVRj/6IYHqLpM47OwZUA/rQLo69cEOBa7XkoPIyJ7y2Ccd57L23pio?=
 =?Windows-1252?Q?yGBECacHLJMGPzVCSgToUtB5Se/0aOFNoyXg3vXErCqwq3f7Z3oGB1+p?=
 =?Windows-1252?Q?S2StwPQ05X3q38xHgkG2B2nJs+g3aoIoR67fC1djDtlU6wnv3ZOhYts5?=
 =?Windows-1252?Q?xYXje3r2EznS6hWS92ySXgMOF+5+qwGPGyoWKhs4OmVHBY3eElT89lpJ?=
 =?Windows-1252?Q?r07hAPb/l3zHNJX0S7AHs/9XaxKM7zK5tDqFbda3PUd9rQxIxRco9lHN?=
 =?Windows-1252?Q?EmkkrZA7wsJ6Rmpuvdi4FvjekgeCLndHalgv5GrvwjbyuRtMVg0cQbOS?=
 =?Windows-1252?Q?OjvwJWW8R2zdIVjHoKS+KW0XX3uVv1zXd1TPIqHfeIh8q1BdNOjjTtoj?=
 =?Windows-1252?Q?F5FKgkCa79gqAsCf6logi8SGBXVKIqMvj1IxNXrt/1ytUQEeJk+jDcmK?=
 =?Windows-1252?Q?sAvlCB2G3MgfEKpvJZWXsg1BIUjY9hi2zaOAjTstJLMHad+w6yZRbWBU?=
 =?Windows-1252?Q?P5+FZ16WOT4dEBzReuZSXoJXlGs9wm8ntZ0PcMJi6FTfDiqx6SpiL6Ye?=
 =?Windows-1252?Q?LtxC/iwE8+e6kI3wA9ZPIX+WmX86cZaweMJH1KBydpwnMzLqmfh5XQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c91919-40ad-4081-4aea-08db8150a8ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 14:19:23.4284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1lsA72ky8kGJEGsrriODbph56P9Aj3MO/F8Jc+CJioADKOfkqHwsYBlXgIWxMFQ3G6Risf4cvkTY1UFD2no3Hm8XGLh6O7MTJEqQJ3XwVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11259
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Sunday, July 9, 2023 9:45 PM
>=20
> This is the start of the stable review cycle for the 6.4.3 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Tue, 11 Jul 2023 20:38:10 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 6.4.3-rc2 (3e37df3ffd9a=
):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
25644687
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.4.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
