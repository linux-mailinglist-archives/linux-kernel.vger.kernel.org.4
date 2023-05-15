Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0549703E25
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244019AbjEOUIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjEOUIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:08:45 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2113.outbound.protection.outlook.com [40.107.113.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2319E10E53;
        Mon, 15 May 2023 13:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nti8oeg8iTdTlkeo2A9P+PozS8qYScZ7aEdsciJqH6PgambjdHsJtXz5Twhyy7LE2rR/oyUPlJa3y65R62O5ZvrcE0+wMCNRLbLRh448SUDS9mG4NZYd1H5hn7d2l7DDo0hFEBnJdz19hIkUjLODpfE/Fsj/2UCf2J+Id8hLmcFGci49cPIDFms+ZmeE8j8kFZQ6F7biLgqQMpkt0q/hhuFJsJ9B+D3OHsQHjbx/GKk+r7g3VXmmMacXX644I5gJcqXjTccHdT8vXYv7bXBG4sWpQnI5jI5/sxvZdQpUnCANKuv3Xx1CZ8PFQBJcpSGGh/t2yRm+D3bh7duzC/Gagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdBLGFMYQuSq3FFOlIuqmtE3cxY6fuPt3oGGXxYCn7c=;
 b=h/oWoMjtbi21cNNZtCOaV5prcAL3FpABz1hXD7S1YS4lZhxGudeUYeaW5q0GHFmuVozlmeC+uPxwGvzkw63cJLd2DgmGNSjnkXW7F+yGuqFpwxfwbCQ/bw1g1RTqVRjR3qMKnWgI0Ms8x3emYEzCHw400iF3rQ97Z0ACkVlctQPOIQ7FfjzOGggJ07arjPYzw3a+EnLvYiJ77YIPEihPmQz6aKtLjwZjVgYMqymEbJoHi8ofT6ifCJgNGdN9e8wpIpZ13GYdKX2f11IFd0GiT2Prk5MW/jMFsdcsGEAZutWSM0VPqBVWHXAW52ndew6dv6WuU8e8kB1lj0g7l1mCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdBLGFMYQuSq3FFOlIuqmtE3cxY6fuPt3oGGXxYCn7c=;
 b=nMK/pgwgEzadjdgtAtH+IYJ/t9F+SLrWSOnhzyMYrY6effavJjUx+L1Xfoke4T27pC6DZN0jCoIbEZNUNSJ+T9Ft+i6bPAagPrMWj2V/kBoVWMprsXgbo4iEnRgUuOPT//Vy4spHyjhtSk+cb7M8kF/RG7GaL615fFl5WXWekRc=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS0PR01MB5459.jpnprd01.prod.outlook.com (2603:1096:604:af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.31; Mon, 15 May
 2023 20:08:41 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:08:41 +0000
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
Subject: RE: [PATCH 4.14 000/116] 4.14.315-rc1 review
Thread-Topic: [PATCH 4.14 000/116] 4.14.315-rc1 review
Thread-Index: AQHZh0rzdjxuQfRDNkK9RH108oNyMK9bwZSA
Date:   Mon, 15 May 2023 20:08:40 +0000
Message-ID: <TY2PR01MB378833B54AAD1CD74A942D55B7789@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230515161658.228491273@linuxfoundation.org>
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS0PR01MB5459:EE_
x-ms-office365-filtering-correlation-id: 612ef25a-da60-4a6b-6a26-08db55802d52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t36nH9qGktqwxSq7b4e0Njb4jKlbeyGqH3p7ML5ffj29q5HBMrfXtD84hfYEMQS3oseWAYUpMUuJvoc6wKyYDhh5cADg6zbLiU9Db/HiMgJy670swGcIavHIOeAzg4MnA6lz7xOup0jYbYGAdAm0mDa+2T+i0EpMKvRDETjHQwyd1ceK77HqCAzVJW/aTCYX0+tkYrgp8ByI1VyTMfbH0CEx4xOz1i7HJ/nYmnXigbGZFwi9Wpgqhc6oqPDzF1eQtzMkrfWYBRZFPnHsH5iSqzHW/qRKfOpKLCqye5qtxBny88Rx0ValmN0OTO+vmM6uwd/aEuQ4y0ghePMRLTQlgfdmcNp7uVhfyHTv1XHVUCS06wJWIXn0zviQRWiEXZ0sgdWUXINdgBkZ4OzTF7avpamHKMNstl27Htvd4GTbmKN25jqYd058p/IlbwdrpFtGMf/2qAawXfcXHV/1O5w+4xwf6X7Txczzpfn3z2AmfaJYy3b5w7KP8O+7Tf2mUXv06jx9//HOxUSQ7+M6MvBXF/X3I2tXaOamM9/uzy2T/0uKVsUNAcb6k9vThT2jyI3H3oJu3U/RdPjdo8XP+6kBd9zYdfBK0FvKxKDSAvpsak3n1LNa8/CpnEPzwAVKhRPLCHOb1eo+A9NbSr/Hkj8Y5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(52536014)(8676002)(8936002)(5660300002)(7416002)(4744005)(4326008)(316002)(41300700001)(2906002)(478600001)(66946007)(66556008)(66446008)(64756008)(66476007)(76116006)(55016003)(54906003)(33656002)(110136005)(7696005)(966005)(26005)(186003)(9686003)(6506007)(38100700002)(38070700005)(71200400001)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-9?Q?a6DPdiqjUz3rKcl0F+pXySwz7wtHyrvOTnF+tSEn+IkZp79/Zkpr+Xl5fS?=
 =?iso-8859-9?Q?ftw/5oLwT5F11MZ2wsLFUxHcURvyT0eSeJGhwYQi14Pl8eEdMmbwVZE22g?=
 =?iso-8859-9?Q?rSoEFVuXlgj0UDn11jJnQMBggS1ewmk9qv6aQBD8SCd+neN7PNsWk1visx?=
 =?iso-8859-9?Q?PXLp4K6v76dQxYq6N8NKCgZgHubxukrwQDHAtACDbM+g5RneE+rqsrLCjt?=
 =?iso-8859-9?Q?8k2a8UqejR4k1pep4a8GMaPPTdmxaMNeEZqXCZ+3F59V7WwTFgBK3Q6AV6?=
 =?iso-8859-9?Q?215BclITcwxnmfVN35rFtmM2T8w56pFBfrsW7Qo2B8nZ2PmG0TRGeE3ION?=
 =?iso-8859-9?Q?RmyLf2w8/A/PIUsLkaAaHzWcrjrfkUHF/W3B94JDaGwBxNlb4PFNlx0zdz?=
 =?iso-8859-9?Q?xOIqnWM1DOdvKeir/V7Z1ZDVIqbgc9CmJrH54FLVEap5KAHd0pIacZ3Q3r?=
 =?iso-8859-9?Q?ey0cTcc9QtzC248aimxY12MrVo/uZeb4sImbI2QvPDU2mr9RmIU+AVuT7U?=
 =?iso-8859-9?Q?paO2b743y79Yf6p6RRs+RF5CAw9vWsUxh8fw0hc/8iUmf2XSny368dHZVE?=
 =?iso-8859-9?Q?ui772OnBqJ2cPnQCx4bIXoh1PRZfM537u2YlYXI8PqHn8Do7rhAV47MWV5?=
 =?iso-8859-9?Q?hxxutMnGU3qFr81iCFnp4GEfYGtDIbAl6NiDDGJkml15Cm1+BMkjZDCXZt?=
 =?iso-8859-9?Q?4sbF5rgV2MWggRtSOwyYW7hMJbLPNaJdwsfqb1bYLMF+zQZ31oVl5KnPfY?=
 =?iso-8859-9?Q?dmTpVg6UkYfuT70wR7x8prDdTEmbfxIw5Wrz2fQJYN9HmHs9LDoeTVMzkl?=
 =?iso-8859-9?Q?qeMJgSiAEkQDD/D3tJExMV//qPikgtbTV9G61OaRHgmueHI+iZOUoOEs4p?=
 =?iso-8859-9?Q?iEqgup+kDEgfWPirxxxQaQYC7M4jC8kqFTjXX3J8KxBk0I/e+FclRpR+3Z?=
 =?iso-8859-9?Q?WNchyce+J0nvWdUFvo5mKUuBbNn4FiigKVMj7eS0q47UNBQE8TxaPFyAFE?=
 =?iso-8859-9?Q?D5VShJZbYVENlCET76EDIrdG6RmyCXztN2rtqegB1asHTwYMJ3XRxgkxtI?=
 =?iso-8859-9?Q?7HPmxcWNiDSUd54DG5RfAQ+x0zPVae04SCRDObvp3BwuGh6YMhD5hj5GYw?=
 =?iso-8859-9?Q?bwvmzMcqMiskRUaacTwJXeQvkO+Z+Dxc6FXQ/nulUw0ehlQ0WoVPSbUf6D?=
 =?iso-8859-9?Q?mDYhMPpAmyic2lKzV2V4MIIfy/u1MgiXvhiphlpwv66ufzTHU8YyQE8u7g?=
 =?iso-8859-9?Q?lJqqKuyCk6F5hy22t3IWKpklkBMWLp1JaVMvDmU+gG2JEKm+1OR5tbDHrq?=
 =?iso-8859-9?Q?xpmiftFDlZejuU5gzcrMg2yDsCH7i4kyUZswXKPzSX9LAjc97UKjFndWAg?=
 =?iso-8859-9?Q?3eqwFMCGJ9NjOEDU0agC0r+4NBJROhIeu42O1tIeuPKN/AMsduN6lAE0ij?=
 =?iso-8859-9?Q?8v/P8S+2dP49mOPhZNkX8Wq5MT7EfBEFeaKHWu0I+aby5MkNeZdlIgEnzx?=
 =?iso-8859-9?Q?DStIlC7PZTC6ojYp3gzJ/yUrCj+tdiU2cPLh7hC3OaXm8f+Jlyq5shGZ9I?=
 =?iso-8859-9?Q?OBUvLsvr0+CSWNW1jgDuduSNYI517fUtLJJ+hCsTJR80jkZZmB3cHDfCQz?=
 =?iso-8859-9?Q?YUfvdGN2pkFcW043WEZ4yDnXJ9NULE7l6DPAVNNizhMpwJdduDYZczTQ?=
 =?iso-8859-9?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612ef25a-da60-4a6b-6a26-08db55802d52
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 20:08:40.7072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JONYbA8XaJZTEPAmNJejQO1KNT8YeB/W/guKgM++UBza3UnEV6MOkzYR/jPJGcSb8zxVoY/oYowDsZi3yIPZ1WftwpVNEq1jjcJcRlGqP3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5459
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
> Sent: Monday, May 15, 2023 5:25 PM
>=20
> This is the start of the stable review cycle for the 4.14.315 release.
> There are 116 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 4.14.315-rc1 (854d9237fbd3):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
67957506
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-4.14.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
