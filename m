Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE1170CB46
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbjEVUgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjEVUf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:35:56 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2097.outbound.protection.outlook.com [40.107.114.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70362E7C;
        Mon, 22 May 2023 13:35:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ac/4MZvVVMhYx5jGHONQRD+UjaA/TlOGmSvldqIouGs5X4sl0tSad9ub8QqHxbq7tECGFUlXZLwQnLtFGkR3YCXFh98zunUV978BqXLIv5zffBE+p61UOh6AEZnew7YfOpcQ/woBa9RLNYlpjXbBGhUUVOzFUGFFtQBwdB8KR2ihnHuDBUXz7ZrIQgC9saG8iUxxjEFPVez9yLDhfne7lA3/FbzM/AdWwagIcO9Cip4y1BpCuBi1dmJd93gU0hgbRDBEG9mQKwJkd6M9c8l9lrWeDpy7qA697eei7BYTiPTtKXxQGO9THZACryqQiX4VYRmsyTzSQ/TL/JBvqldcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZP0RQhKdEoiw8bxUKzB/CrGFNXiWCquQLHhqTJOww4=;
 b=Tor56vuXCA3FD/V1glYPlhGXpG4S5/uU73QrEpdZNM1/hPund6nwlO88xrh1E+NIh6E1EiE3jPdHbt7TErU3hfilgpm5daRR7ee40RBVx9ZsUwC+xlWPcr5L2KL0/h1eHh26DfNYzyndIAyzBxxtxk2XPkX03jprn21807nav8xhRarTrfzBIkUpdYBoDqtroaaKyfoKF6eIJFNm39yO5okDYXFjhIngMREZn+BrmHmBIUbweK1ITOoqd52f44rcaeJZwuQIG5fz6PDp0Ww1BDi/AoLH4p+Lp7y5/Wl89HnhWJH4eyWMvOgzKzKNRsbxl82BZAaTT+SZesbnDDIDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZP0RQhKdEoiw8bxUKzB/CrGFNXiWCquQLHhqTJOww4=;
 b=aWFFP4WdaEUkw0eHlm4ESBJTsHQ/IazZCNSSug0qDRAp1Hb8tVF3lMaUxRlIYO+/5FosStihvJDjmvzydTfBLA1jDjTDucxJinSg/dOYbqVcM8J53Tm1SFD0GGWKkNk2QogwLOThOX4Nwe8y3duT/S1bf8OGmypGOxCXwFb3deo=
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com (2603:1096:604:43::11)
 by TYWPR01MB11194.jpnprd01.prod.outlook.com (2603:1096:400:3f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Mon, 22 May
 2023 20:35:35 +0000
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::edc3:42b8:8199:d907]) by OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::edc3:42b8:8199:d907%5]) with mapi id 15.20.6411.029; Mon, 22 May 2023
 20:35:35 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Chris Paterson <Chris.Paterson2@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: RE: [PATCH 6.3 000/364] 6.3.4-rc1 review
Thread-Topic: [PATCH 6.3 000/364] 6.3.4-rc1 review
Thread-Index: AQHZjOUKmjF8pgLDVEmQr5ERjywh/K9mvVcAgAACeGA=
Date:   Mon, 22 May 2023 20:35:35 +0000
Message-ID: <OSBPR01MB3783D6B86C75DCC0FBE2E2A5B7439@OSBPR01MB3783.jpnprd01.prod.outlook.com>
References: <20230522190412.801391872@linuxfoundation.org>
 <OSBPR01MB3783F0D4C6006FFF6DF9AA28B7439@OSBPR01MB3783.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB3783F0D4C6006FFF6DF9AA28B7439@OSBPR01MB3783.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB3783:EE_|TYWPR01MB11194:EE_
x-ms-office365-filtering-correlation-id: fe735dd4-3152-469c-ca9a-08db5b04186d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KZ0a4b8VUbOXiA4qfZPa+qPKnlQEXWCoBCVCJRp1hh7myKdu0nnJkcyLLkFGKQLucQmpmYIdliTMBWoFCiM/kaQzNY3EbG2iBLk9mD/UQpy4b+lOyyVqoEnH1InQUvYvo24jufedDx+qx3fK9KJbd1uxoMFb293OOFpIOT+Njq9ZzmOj1Yl6px2QSOfajS7DjsztjjxCMpb/i3AXPxmcXJhXidabzp/o5aKWC/x4Ge3c/iWjrEX7xw/tiAwtHZbfyOroPNkGRH0dHbFWRF+GarS/qaigTnHONSJHMCy5guNpZwKshjya49qvXvW208GK+vYMkKfYU0vBfpqWYAeqEx5dGdgRdpDTa8GRX5rIPccVzMkqDJ3oLvA9vg9AxFFayGpVpFE5Rrc0T01ML1iQYpgwhJKMFpyjgRkXfQSkDNAMviUp8DqGHLvzIR/9NF+gCn5dH+Eq21T6sDepAqFu9pKhSOQXqvyrkIdVO3KjqFb15SH3UBjmZc8a7sKLLWPsO/eD5VOAPofbqoW2NHw03OwsXCd34hx+ZL/k8DX36GnjuSuQUBsIKIHO0iINf/4Qb8/zVytzz1UVF3FCJWzWnu0dHWvyretu2ArPGHkebXF4XUdUbn44Jga46RuNqokW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB3783.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(64756008)(86362001)(4326008)(66446008)(66556008)(66476007)(316002)(2906002)(7416002)(52536014)(33656002)(5660300002)(45080400002)(478600001)(41300700001)(66946007)(76116006)(8936002)(8676002)(38070700005)(55016003)(110136005)(54906003)(966005)(83380400001)(7696005)(122000001)(38100700002)(71200400001)(6506007)(9686003)(2940100002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?4Kn5E6QN5W3v4VZ8nEPGs1ELZwKxSyygqb9pLHwRd7+ISTolBWPbJWDV?=
 =?Windows-1252?Q?NxfVgkkfyjtETpV9/itIBLv/9WfmrVglmr6j2DDQXuKQFz3WXE+7c3qC?=
 =?Windows-1252?Q?b3kiuDrNec0mn1Ew+bwbbTxZRa8IXi8W1f3rHc7t39d7oTP1obYrayLs?=
 =?Windows-1252?Q?HcFBCcjMIbtTnZSsnxBoFb1m/W2rZM1D5iSu2JYhE0CJAMXmh8gmZZ8F?=
 =?Windows-1252?Q?kOCQ0S1b4SNIneHPARzNlNkvSZP1DDEzVnT09Wf88Ejj/lN6HO8ZG2jk?=
 =?Windows-1252?Q?yjtHVIInYgoBtko+A21iv0KPcFRRowy6o32/h+iY7O7CW6huJLneqOtE?=
 =?Windows-1252?Q?EY2QypiooMe8HBby84f8t4hRfb5XccpDVKTzz2QSInazKf5QT4XrirqU?=
 =?Windows-1252?Q?m/V4wwze7A/6i0YlkrsOb4lyjit+upf2ra+Nw9PwU6HbUn/ctzrL3TLk?=
 =?Windows-1252?Q?YGye43RSOED5sRsZdccioxAegfQKh1PbeuX6X3cnclO1BIZYhXLqGubd?=
 =?Windows-1252?Q?rq46qQrMreWGbmjtZlPBF+eqTitQ9p/FKk09+OLihjWsnP/aMF6L/w47?=
 =?Windows-1252?Q?Sgbn7IaIC814QDuQI7GirLmEFvqIBnpNR6Wu2US5fAvKaT4S4pPqKjCL?=
 =?Windows-1252?Q?WLnVPXbMxdqh8y7did42WLbjRaKhhvjJrsUVYTng2kwS81yeW6kjNMXx?=
 =?Windows-1252?Q?FdpJPCQwJzpSnvEQ7hh6j0AJZd/ki3pe2A9MN/rbHrDAPw5lzcMpJ2LB?=
 =?Windows-1252?Q?Unzj9TDxfzzIxLtURrDO6GdxcVetE9uEczLCJzRaavkKAlcd59NKnOab?=
 =?Windows-1252?Q?TjZgpF4ddNLixQGRds4SqNFdPFolisLcppSE4pLtNqQ5as0u5SnJmifE?=
 =?Windows-1252?Q?KXjLvNO+LkVG5WZ3rfbw92E5oElR7A+aSvh4XPmSMqgXFEQ5beVukxUA?=
 =?Windows-1252?Q?/mJKixrVDfvr7f9r6vDfwQGrfNqjYTIZxTsJQJg5Vg40wxkeJAnjULqD?=
 =?Windows-1252?Q?k8l1e8mIxmbLKNfiwubczDkfIJqRncQ4bc8M5VmvqEk7iGs4ejaSZQHc?=
 =?Windows-1252?Q?avaF/52R+rSFNUqKmp5j5I3kvLIrh77f3oW/93N7WCHj1fZ4v9CrdVQh?=
 =?Windows-1252?Q?K8X7gST2IBtlqdBd1ZtWXgMILHcx+o+qyqUXrURcyMfLyZwq7EONkI79?=
 =?Windows-1252?Q?UO5ahSizAutVvDaZFqWRdZ5+KU1sSSfqJbwNAB5iAGnY/34EiOYn2mRM?=
 =?Windows-1252?Q?N3NE6oL7S275q8VV7Q7/j1aV95QHXBJADuzi0UlP2cr8WYNqRKriUFHB?=
 =?Windows-1252?Q?32W0AtDOy3Uwo/7bIWhM12NhGFcA875iaMuDNlX9NcQSLQXEA7ggUDjy?=
 =?Windows-1252?Q?+LKoA7NTAE2YonJrfEqZKAA8eSQJU/6iD2NJSC3kXHcGOy8u+P8ElMi+?=
 =?Windows-1252?Q?7x0QAC0voN/9b1PHT8Z/XNZeJQhIUbHnnw61GSoQu0sjbX7fhf1okZlL?=
 =?Windows-1252?Q?pEm/xo6x6TmZMbCVS0J37r5ezoWpbd3i98IaYfHV7DI4fRknRKRglxKv?=
 =?Windows-1252?Q?CU/dtoBxlPVfPL7odmtHcCl6Li2us34W6WObvpF6zdT0b9MdBHkoRiFm?=
 =?Windows-1252?Q?ResODPIVjQs+bW27YUQ4RVv6zd6/TmVBBt2V6vxIn51iwZxAvhP3+vtV?=
 =?Windows-1252?Q?/5zKcuX08Yw=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB3783.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe735dd4-3152-469c-ca9a-08db5b04186d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 20:35:35.0633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cApRydSbrTTuYxx9GTCHa/nZVUuLzcgrZpmDtBqnEZloUy3Co1sEDEASb1ohlf7DCOwmjeT4VHcvn1NysyYVZ9bLd2ery89zi1+cs/zJqq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: Monday, May 22, 2023 9:29 PM
>=20
> Hello Greg,
>=20
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Monday, May 22, 2023 8:05 PM
> >
> > This is the start of the stable review cycle for the 6.3.4 release.
> > There are 364 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> > Anything received after that time might be too late.
>=20
> I'm seeing a few build failures with Linux 6.3.4-rc1 (20efcce0526d) due t=
o the
> drivers/usb/host/xhci.c driver:

Just to expand on this, the builds that are failing do _not_ have CONFIG_US=
B_PCI set.

Kind regards, Chris

>=20
> drivers/usb/host/xhci.c:497:19: error: static declaration of
> 'xhci_try_enable_msi' follows non-static declaration
>   497 | static inline int xhci_try_enable_msi(struct usb_hcd *hcd)
>       |                   ^~~~~~~~~~~~~~~~~~~
> In file included from drivers/usb/host/xhci.c:22:
> drivers/usb/host/xhci.h:2146:5: note: previous declaration of
> 'xhci_try_enable_msi' was here
>  2146 | int xhci_try_enable_msi(struct usb_hcd *hcd);
>       |     ^~~~~~~~~~~~~~~~~~~
>=20
> Example build failure:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-testing%2Flinux-stable-rc-ci%2F-
> %2Fjobs%2F4328533790%23L2178&data=3D05%7C01%7CChris.Paterson2%40re
> nesas.com%7Cee949d7c9a134da2c00b08db5b03423f%7C53d82571da1947e49
> cb4625a166a4a2a%7C0%7C0%7C638203841845350992%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> I6Mn0%3D%7C3000%7C%7C%7C&sdata=3DBM6vgJJYqirsEZpt5T0Mm5qmQudai
> fCbXerKqHfnUbQ%3D&reserved=3D0
> Pipeline:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-testing%2Flinux-stable-rc-ci%2F-
> %2Fpipelines%2F875108293&data=3D05%7C01%7CChris.Paterson2%40renesas.
> com%7Cee949d7c9a134da2c00b08db5b03423f%7C53d82571da1947e49cb4625
> a166a4a2a%7C0%7C0%7C638203841845350992%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000%7C%7C%7C&sdata=3Dp0q0Dr4l20Tf6cJcb6PFmL3K%2BrIt3R4fVr
> WYFFwMg2o%3D&reserved=3D0
>=20
> Commit 78887e3e5f00 ("xhci: Avoid PCI MSI/MSIX interrupt reinitialization=
 at
> resume") adds the offending code.
> I'm only seeing this for the 6.3 rc.
>=20
> Kind regards, Chris

