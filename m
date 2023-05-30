Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D79715E08
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjE3Lzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjE3Lzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:55:38 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2130.outbound.protection.outlook.com [40.107.114.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D1412A;
        Tue, 30 May 2023 04:55:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8LzewUOTbTrkBDKn9mqlcX3lx5MDy6ZR90sbFOJ36b96RrZrbh3wQEDfNYdEvizqXYwVCDnmq6fbtjQ2qHfct/0BAIq0oZCEDX7394njh3+yAn/7FefaX6/b8Zsg/YuSbeVqYZG1Bl0zK5H41dMpBIaHYOn3xZYr77fSVUn1kkjxbxiKgKE5vxD1jMIPfHbgOp36SpO89waOAVDf9RRoDmThwIzp21lvpmr6RiqbRGV0ZyyHJOURftqRLQ83eyLmjAExMXnsAXD1OEdKcl7d4JbVKSTuOYH5uqk7wke+cN1KP2UxLP2JyJMD+VizjAiWZA0IoSyTLHhIhG0WoYztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeuEePyemFnUZd153iqD9CexoBGClwcv1npWL/Mj5VQ=;
 b=QK8rnaQCMs2b9EtMRHVA6pMC/Xj0ZqoRGLJWvl0kTEkUMzzZAT7NyNABfwc5412Y28GCLre2ddUlEV8t/lerJA+VbPblVEcNzOZGQrEmTBfAq0cs7XD3pZYpiA0mMZK8bk1FoKuUk0LnKZknPYsmQXbcM4jA6AgSp2LN/pmgCr+vHO1TeUGGBesp9eyDAL8vlFgRjHILJQlKdQCg6sYr7jRS1cEM8cz5CXzTYepON0pevMDWF4sgZh5FgMDFeElv72iqp+KD8MP/rRDPn9t7QDx7O2qGCg3bzrhwx4wEzDOkOlqChs/DvjbrKoZCopnlzGylXdEANrInHIVVDW7wxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeuEePyemFnUZd153iqD9CexoBGClwcv1npWL/Mj5VQ=;
 b=ElxefP1abBw4zdjKmUTtj3D44SdO76jdxZGDTzVNRUzLCQB2fZd46M6+rmBakXdyOy6eciwdHeOu6UQMPTa/kAbtHugNJCW6UPqllActnRLGViH3RMQ/pA8WhryiK7RZSc4Iye3saJysZQhwCF1hRXmLe6PEf0NXjWKm2GE+hNo=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYBPR01MB5390.jpnprd01.prod.outlook.com (2603:1096:404:801c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 11:54:10 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 11:54:10 +0000
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
Subject: RE: [PATCH 4.19 000/133] 4.19.284-rc2 review
Thread-Topic: [PATCH 4.19 000/133] 4.19.284-rc2 review
Thread-Index: AQHZkkPyIPThK4gW60KMzsyjxqH61a9ytAzA
Date:   Tue, 30 May 2023 11:54:10 +0000
Message-ID: <TY2PR01MB37889427803BA0F7848976E6B74B9@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230529153919.729418186@linuxfoundation.org>
In-Reply-To: <20230529153919.729418186@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYBPR01MB5390:EE_
x-ms-office365-filtering-correlation-id: 1e07a8f9-09ba-4985-b32d-08db610494bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tBa9EPBwKyI0kA/gJU8KXAcFkKQSNnrJv62K71l+FPn96S2ZDXF/4ir4j5adWh/8qW7aWIcWEaW881J0+XwVgUPyUZEZ9N4RPWk29ZWgQAyvX0hQkHWz2wCuchUCdiOsTdknsMuLQLZ3X4TyY53AlPe7HxOIdSjT8B/zyQSeFfiyeaog1CZZykx/RXexUQu5gdEcj9cPaWkud/J6AhD23WYaHH+QcJYsWJjl8MuBSZclcDZnv3OfzyNN1SpJgMRHJtXh4a8Pvnad3ZjJHzxcx8Ml5AIN05TwYQpFROItFpFRws67VdTZUBfpoHi9bwaN05z8xhac6hkB32uQfJ/a7/5EfNBCZ1sEB66V1q74571iPo+bsPNFhNmXbD/ZUeRLhyRKQNqr9q2Db7bIEijEX4SeMrfJxtq6yJWnHBq9Uc1ogAIxo8LbxJpQj+vwUhDvdui5JwmjZzLpYm8YrsOpE2YQVvcnSmzJPmsT+eTeNMBUAw2no9vsdKaTCNih4HaOle9Nj4TTtMXBOLcFP0oV9iccFZl5RJvDDCTkq/k7PEUW3ukAXjHvE/0wuO2y0phnsKOHLJn6BNAaelYl69ucwbNqSqJXLui9+2ELwkMpy8272WYTKGAFL8yf5Dj8HO4W3j6U1cRAhFJnLjYBNnOsFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199021)(71200400001)(478600001)(54906003)(110136005)(8936002)(52536014)(8676002)(7416002)(5660300002)(33656002)(38070700005)(4744005)(86362001)(2906002)(66556008)(66946007)(4326008)(64756008)(122000001)(76116006)(66446008)(66476007)(316002)(55016003)(38100700002)(41300700001)(26005)(9686003)(6506007)(186003)(966005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?tepOk39lApPNi2EUexbpc3QFb0R4HFCuGOqQfbllpN+shoecAwoT3o+K?=
 =?Windows-1252?Q?XEvYb+PMRx52Xs/ArcBRpe8AZAgftb8Xs15Wrzym2kPdxF0YtFVuuoeD?=
 =?Windows-1252?Q?UBgc9vOG44RKkKkMFlhZ++t2tLf8BiM4BCebd5UseeDPiioQ17idmEPT?=
 =?Windows-1252?Q?GBEM7/yvx05ps+o4NhG07WwmxpnaTjMaHCibpHkv8IskoGmX2r8kFJ7h?=
 =?Windows-1252?Q?IIvreoez39Ac3PK+O7cwwn94iPf5a2GCOrZ7TWy3kEcIbcqI2IE/DSQj?=
 =?Windows-1252?Q?NquG/ecdfN4CAuFeMA2CQLkppafucF9t7dVWu+pdrlW+aULt2FADtfyH?=
 =?Windows-1252?Q?yA/CEl79FD/o7SjfW9H/YiotWk12KPqITJAXWkY1x347KtBFgGYJOMPY?=
 =?Windows-1252?Q?s/LRAx3vK3CUmJu5xH2hYFay10sL0TGJLRxXm/px7dZs4Fsij6Y+5W3c?=
 =?Windows-1252?Q?k3yFcIHbWAfAyBrto4OBi6meBtVkGjNvYihUNYYqFT4+YamTQ+DAaF7H?=
 =?Windows-1252?Q?fK2gAadxHwu7FwIFRcmPuebdwKhaKLdh8DSdpFai+ZdrmHcSBHalOIwd?=
 =?Windows-1252?Q?7fFnTdGIFkLxbumNn1/guaYMfhXH9EAzVVspxW6TeHn37Ym+BZd5+LyT?=
 =?Windows-1252?Q?e6xxnbK6r7wLmupAWfreLjzeRmjkp6G4XP2mQ/8eFtGNbtjVWRg7DL9s?=
 =?Windows-1252?Q?Fsr1kf31jA/8EBC4/0GxI8hJ/Ard9o0OQ9GffUne6lUWNezBQzJdsQZq?=
 =?Windows-1252?Q?a60IN5WJcft/Cd4ekVwasOBSh51BhDRLmlm/bal8rWyqEySlE4lsRl4A?=
 =?Windows-1252?Q?IJo+zzsZJ+NUE3sj/5p3nlOo5ykxmHK6f6Mx43rAQsEQv0UTtxxNfQ45?=
 =?Windows-1252?Q?BL8PTRhFctgHa/DEu/fZVtufimcq9Y5n4kZhHnb6CHyhY+bwX4LwmCD9?=
 =?Windows-1252?Q?KJDkN9p2FoawwLSn3BUI+54vDA4C5NgvROQ42QJncykM+b/fE5M7dvB3?=
 =?Windows-1252?Q?wkNThISnIm+RvS7i4duaxtTBamYUKnS5NM3KzTaYiS/Ox0P6G8KPKLWC?=
 =?Windows-1252?Q?4H4MdsL5QZHtyLvwqAMTN/O1UjbhsS+BudHI8/BJs+FI5nbTapG70qs+?=
 =?Windows-1252?Q?b5Im3FEjA9FMer4lBfh6ysWRs2YBk3mch/Mz/yVYgR5xd3YvgJGDhyer?=
 =?Windows-1252?Q?2edykS/FkNG/qjpl9VguUXA3uhF1XfGX23/MLMYorFMqwbfTjD2yjj/b?=
 =?Windows-1252?Q?p5Br9y2K9xrj4s2Rptq6mrvZy5oyjCAaxz+QrAtL1VWh0gk0ot0nPePZ?=
 =?Windows-1252?Q?ZgLZPEnZQiu7XILerEYM0Gg5MRMcoqQk8NvPuX3pdVZOlUfIL3VBDAai?=
 =?Windows-1252?Q?dd+FK41qeWcRW52Dn8XWlkf4iyDfw749g1JfDW2gV5o7uL+ZI9LWPRvn?=
 =?Windows-1252?Q?EJRs6lZ9kItwLFSKjBLt1OZlZchE8/H8Tw8KTA1ctNfJYvAiQv4radIX?=
 =?Windows-1252?Q?IQqU8KvsBjdOqj2Ay+3hfh4W2G5cYl1ZysstdbFX6vR7PDSCytaB4/Xh?=
 =?Windows-1252?Q?iHWYYChuVRK0gcBu2RkF1M6zcXlul+L4AvwJ+fDiPNDulwweZghzcUpF?=
 =?Windows-1252?Q?TWDViQKg/wbVyCMt4OF/HqZTbf5RqNL3wYgLAZMYg9helr35kpRWy7mQ?=
 =?Windows-1252?Q?fPQ/uG375vKnBu0We7qcxa5UFVe4lCFTNX0T2lXpPuUPdR4dKj+qaA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e07a8f9-09ba-4985-b32d-08db610494bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 11:54:10.5839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/lkKgJttNy5yR6V2y1r4CLkdBas1zAAAiHe3xWSfVO0FQUkjvsmJBmF4PsTg6j5pLh1kTKH9ck3OUBkO+0XscA1hE3P9w5zAucEZdOOuDo=
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
> Sent: Monday, May 29, 2023 4:41 PM
>=20
> This is the start of the stable review cycle for the 4.19.284 release.
> There are 133 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 31 May 2023 15:39:00 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 4.19.284-rc2 (1b63443ed3b0):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
82149603
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-4.19.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
