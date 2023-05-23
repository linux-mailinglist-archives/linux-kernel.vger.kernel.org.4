Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D00E70E4AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjEWS3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbjEWS3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:29:13 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2122.outbound.protection.outlook.com [40.107.113.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498D091;
        Tue, 23 May 2023 11:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJ4Wan/cmlDq4DaIVY+lLno/lxktAVhnKxQSlDpKwp0PguWpVtbMPDVsqeznZ+iRTAgJltFipV6zOrN+6UoH20C/xPDYe1uiVvVlcj3VfW79O2hbwEKUJMKhQf2mYWd4J9KvIWh8Axl2AAVV78qcQ2JrYRX2EnspfhXGekFaYX89LpThlewA7hV6ycyE8rn8IkZuuiOlOsuEhAT7ysT9nOdhszFRFBIN5WcubneeJQKxL9HkYKZQT5GQmv4n5SJiWUzL8pjPrM7Fl6YEiQxU+OQaWkHpA2Zc7lZrdJGvF8Mvth+B0c3gHXVDD6QpS/gNjEdAFXIg2AvLAsv0dn8gCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbz8VVBQtYR5yCwomN7K4KHFRh/3pzRn/f4TmmY2ksk=;
 b=MPr8dic/U+3GmE3LIDxlyZ6jCfJXt7P3REga2hQwKMHM3Aud6qyINlyi9vvfe0HWiU8KdsiYPBgBRBEWl68fn9zQ5RIuJ7sig6qopxojftujopUy+Sh8zDnLod+5kiLnCGglQjroFQUNX+PH96NB5xuDIvvxybNFHsm2r6h0AVNBYwVAcoBkRU+IEKRApB5IqK2Plrn6p0vMQ6z4Ns3My1L1+xNKII3pg7iQ692gDcM1EorCt6df33WDZHlqZnRZWG+Eb0/ik0tW5+9Car9VGusqHMx/ZHWATYAqx9Jtm7ZwTGGqmeeCnfVwNy/yDi30o0nnKGYD7wHk4pCVbEzYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbz8VVBQtYR5yCwomN7K4KHFRh/3pzRn/f4TmmY2ksk=;
 b=QMAxAPPfYdfN8ulBrW+9aMBeecFnL1Q3GVJZ4rzvSs9IGdvpT9cVtWMVg/7euV+2e4/DggwnI4pQxotHvc/KAwgVmE91C0sJbpZ2c9TFR+OSmiDkXnbza+dTlsUkyvB8ZG0PKUx5ZV6ZOMrxF6OpAsyKpDbXGbMwQ9jYDrvV07E=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB8725.jpnprd01.prod.outlook.com (2603:1096:400:167::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.30; Tue, 23 May
 2023 18:29:07 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79%4]) with mapi id 15.20.6411.030; Tue, 23 May 2023
 18:29:07 +0000
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
Subject: RE: [PATCH 6.3 000/363] 6.3.4-rc2 review
Thread-Topic: [PATCH 6.3 000/363] 6.3.4-rc2 review
Thread-Index: AQHZjZhCK7yCKXtut0yiUs/pgCiLYK9oLOnQ
Date:   Tue, 23 May 2023 18:29:07 +0000
Message-ID: <TY2PR01MB378842462A7B9C62AAC058F0B7409@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230523164950.435226211@linuxfoundation.org>
In-Reply-To: <20230523164950.435226211@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB8725:EE_
x-ms-office365-filtering-correlation-id: a564fe05-589f-4f7f-7fb7-08db5bbb9835
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qAPVFeWLefikgay1uPvN9G59iWBHVB52q8R5FxGPLrMdpQo+D8vX8RvQWs2F3x5aBJOdYoZ4OLG+5FYdRldKWZ7Blrxoy9KW/rSGntcj6fHHDlffwVhlC7U02i60ugmi8AyrcIODElL1yslrhux40o+T5i+tZgrpLSWJUvfg44v8Ydg1UkPeZFwaGUsk55zcPRGLo+Dtcctn8nneeDxvF1WxTU/z4/IP4CWl7xQrTLgquo1ZD33BiLmZE9HLLY8IdRQ+GXCrM/aDHzXC4lS3esnW4UPUF9nzM0h1Z8i/fUTTdDL9dUfKhCFiYrWkJOvdCYcoyI82UNVa34YOSBbMzEaY0ZdC+YxkA0w8x1RX4RUzzXp3Hd8msM01+MxSjZVYZQjI3PMJmPHqjClu8J2dpKJAIrXOh4VgD+SkBRzJXleJE8y26MkLjSbLzpbYzw+kjV6rXEygPTPaMSja1lo+3vvP2StzqAwaFhR3LrnTnkoUzWga4KPjFeiQv1tRHXwgsD3V4zRFS/D+hAO1EMD9aYZtPDIAw42XntCBiKy/mpIS6zH3HCFIeZswTnoTXK1iU7ozLd4PSxDHPG7SObm6P3LFAKrepsvtI3BZIs0qFq82PNneQn04GZs/smb3o8/oYtYCC8JKYJ0Tcn1QVDMMLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199021)(4744005)(2906002)(316002)(4326008)(41300700001)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(8936002)(52536014)(7416002)(8676002)(33656002)(38070700005)(5660300002)(86362001)(55016003)(71200400001)(9686003)(122000001)(26005)(186003)(6506007)(38100700002)(966005)(7696005)(54906003)(110136005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?x924EPQFWgrmvWX9b0r48ecoQWcC3dF9XNc+Pid1mTVUG0FwBCdYz92j?=
 =?Windows-1252?Q?nnca7tuPW3CyYax8UfaWP1ZIo4UkIHMfWSSXBBLjv8jfXCnRCXlDEcxB?=
 =?Windows-1252?Q?esUZq850VotyLpaIU8WjRIv7eQfD9jsQWyxViqwIUR39zC6HVlxDm7fr?=
 =?Windows-1252?Q?NNLlyCIa3crSc5sA6OAbiGJBSHKbWxmpo8/S3i0cdASL5iafXDOvuA5z?=
 =?Windows-1252?Q?0ilk7S8YaVQhiVGIdP6QCM3rvn09wVqUL9D978Xfp8RXyO/EZ7HY44m5?=
 =?Windows-1252?Q?6xaYfYzFzsZXUY4+oiCBBxsFPlPaYWhsITey766PxhMhf0y6kEtR/Qj0?=
 =?Windows-1252?Q?qq50e25he1QP0/G+YHk3vVx8lBZZMJhY4KwPHUaoobqB20kZ4yDqbUjX?=
 =?Windows-1252?Q?iZW00hTOPIjBhlxOydS0yLB7PtEA5gwljPnqplNDw/fbIYZVXlCOpuGA?=
 =?Windows-1252?Q?mXhDv0x76LoCIetA+xQ16BoqEz4273hMwIbdtcYwBfLu9KTZwzGd+pIF?=
 =?Windows-1252?Q?e8OXSQlRaApQLexg/IwQKSLUxxDelyZ3sm0VrXYYy5A9vewMxpUDXmMf?=
 =?Windows-1252?Q?g9uO9R0YinrIEe0Vf6bNKnkP7akNQw3SPANL+V/eQcAfQrFUjX6SZJTr?=
 =?Windows-1252?Q?ePTeyf/rCvJGY9RNV5gIr83saEaMF1iUbkRrjKapbumXputCs0iMcUaJ?=
 =?Windows-1252?Q?y3X0obM46SUVOCQfp1hEBdIfpVIaRjo2OLuMWdwg6UfnumTKowgKT0Sc?=
 =?Windows-1252?Q?FWtY9M4HrMHvIL7/wHrRDV+LShv7DJbZ212QuNXAbAVuU1WJI0EXrYX8?=
 =?Windows-1252?Q?rpv/xyHESDhKXRgp6w+c1ILRiHmMTazVYjGJVrMhtMJjfTBH3BJQKtSN?=
 =?Windows-1252?Q?PZL141jmGCVVwfbRd1ikB6SncrwoEX3WX4xGhj9DytndAJU4RNtYdJ1x?=
 =?Windows-1252?Q?0fuNJv0ztCB5FVq2zqa8P4/OZ6UvTydeBOFnS/b4ll1Y0HU2A0eq9sCa?=
 =?Windows-1252?Q?Wv6ZALXZWvdJ6Vzp9Yz4snj3oEZKEUtSWQZQOzXKcxG0C7I0Isbz6VgH?=
 =?Windows-1252?Q?iK2kjaaUurd3VS/te23K/HdumIxjgpzioYvoiitzLQpWNWwZbxOkZrHF?=
 =?Windows-1252?Q?2eQkRuNgSD3lBu2zoQzOeNqAgqF1L/YjW9q1LqDgvZdNMwDL4GyO3UNL?=
 =?Windows-1252?Q?gvmS4AlCjEwUoci6BFvH6K/25e/nkR4FNw/lceh+a49nQqLZ2vpDuKuC?=
 =?Windows-1252?Q?AVWgMbmL7SQ0q/nDyV6n3qAE+3+QUePY3oJkBbgNVGAQQhicpkExx34z?=
 =?Windows-1252?Q?z8N7/EjcB34IjptFPxdTCIBNcep6GW1+O7Bo/1mPv/+WVsYyBpT95xRS?=
 =?Windows-1252?Q?tXPLDQESvgnohuKP6AzR2p3WPrE2CaATkLY7H+BW2ZKLIwFDA5X9xTeR?=
 =?Windows-1252?Q?kp2p9YEB2DkbxNeOrLn/XBumJl8hYuM4wgNy18ztUC1FDqZZVZCm5cNx?=
 =?Windows-1252?Q?qTQLFwF+W1JqvSC3HL/uj/MfVJYD3U9uYdSh5mMvefPEU4+PXApaqj2s?=
 =?Windows-1252?Q?5otvMKdLBXj+t9JnzGFd7RcORO2KbSLzLSu6GP4iMq4u0MwtOZ0SH5Iv?=
 =?Windows-1252?Q?gekB3EAPfAj74SFgN2hZdX+7wK/b141Nlo4qYLi/EITpZSUncs6jp10e?=
 =?Windows-1252?Q?X8mkvySJHyzYcj6e7Zl48B2T9emiZ6X/WCFt5R10sC4t/GQw/CyfWg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a564fe05-589f-4f7f-7fb7-08db5bbb9835
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 18:29:07.3092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3dX0lxfVo3DtljO31n2O75DpG1/znRp3XfeJYAn1wFNOyxSHIqeXzpp/HA+pZc4ojnirbYDZW6bOfdLqR4XPVuIKiVt1cBOmMyX8BnP57NA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8725
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
> Sent: Tuesday, May 23, 2023 6:01 PM
>=20
> This is the start of the stable review cycle for the 6.3.4 release.
> There are 363 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 25 May 2023 16:48:37 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 6.3.4-rc2 (a37c304c022d):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
76475389/
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.3.y

The previous xhci_try_enable_msi() issues have now gone.

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
