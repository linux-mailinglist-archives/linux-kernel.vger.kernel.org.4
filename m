Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC08710758
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbjEYIbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjEYIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:30:59 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3038122
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 01:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRi9SYfSuPDAT/RcibMgVOltpzg5q4YwimXRsuwKTM2v3O2Hpljw5niTEXNknq6EpsbC/AREUxbkvT6nM/FBEQ+Xk1X7AMBSS4yj4oVpRxSKCIJsMLrjkuVBYW+c93ffLAtqGotodHylmfR9y0nNMZjrQHBSQh5J2lKEvZEE7AFPk7Ss5qF1MJJfN7g20UOcEoXtlGk11l14WMB/D9ZdaSWfSwji+QkS9O3+h12KAf0r9GYGrs76/e2s/g03SWbbNHOvCaGZ5PlBEBThAs/5yb6yEI3FRcO6uy69hdTUJUZdZ929snwlkUOEhumQabSpRkLfn6mX/BQoRH5ULDoxIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsBWjH8A9Be+JtGx2m1qpSBNI/MQNbnnaM9Aoqvdgr8=;
 b=Y3p7aizzILmJPAkpdtnhPbhf8/pOrJYwT0f51ngqEp6AUlrlGoDmWQjBz3BiNmvJvLKqBR7DTl/NcdijB9V0XQKNShHwLR5e7S73henhlPKTVmjgs9LWi9xdKqSmLIgTSFaDZ6dyoYVun/M9ZnURpRAyQLME74NAK09q/7PNKeBiw4k9c6ZSbe45Ajm1lsTwG30sdwfK2sHFOAuMejKcxZXtW5CiqwDugu9CwGutXMoWFadVyf6bv+AqiP6srviVdjHUNVDjAuqaQ4JaydqwOwTLgIgAxqaaoq3G2lsuZJABujAff+tMWoAs9EduBHsEIGk2IvU3T281o6rfIHzZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsBWjH8A9Be+JtGx2m1qpSBNI/MQNbnnaM9Aoqvdgr8=;
 b=BwNxCLoiAt533MLNx0hnjPdN0zPI9Bka/G1BR9jMw7hXMlQ6ICUoo0XOJ/rh6p4BHD56RRntW1inOxOnNkVt8yrQxbF+8SFhBLYyRhCbm5R8zLJJAVBxSyrRE9mN2cfmZMthRPyUdpILGb1VmiyYlZeJzaoYI1rJEhfsr+67bJI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7696.eurprd04.prod.outlook.com (2603:10a6:102:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 08:30:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%7]) with mapi id 15.20.6411.029; Thu, 25 May 2023
 08:30:55 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V3] soc: imx: support i.MX93 soc device
Thread-Topic: [PATCH V3] soc: imx: support i.MX93 soc device
Thread-Index: AQHZhvcGw2nYob3zLEmYd1JxpO1fJq9pecCAgACu3zCAAHfKgIAAF3og
Date:   Thu, 25 May 2023 08:30:55 +0000
Message-ID: <DU0PR04MB94176EC79BFDFE2B7521D07888469@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230515063730.2042715-1-peng.fan@oss.nxp.com>
 <33d57180-aa13-4178-86e1-c4cf6ef29a6e@prevas.dk>
 <DU0PR04MB94170FE393AEE4A86ACE386588469@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <fe5e2b36-6a8e-656c-a4a6-13a47f4871af@prevas.dk>
In-Reply-To: <fe5e2b36-6a8e-656c-a4a6-13a47f4871af@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7696:EE_
x-ms-office365-filtering-correlation-id: 7655b3b7-9384-4ff7-9c15-08db5cfa5bca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 594YUu9uDMd30iHh7+i38MsVNuxDGjOab0XozB+wmB9LXF06nBRftKoksujQKExfdx4oRGwRlcCVEMWMO59Fk3Xw3ao2bpJ/StjWDrqGc6w/3h6byV7DHm4nwSkUXeNicuiltJrGn7wz17Bm7ILHp3g2G1rrbVD8bBXEtFGQLgfIAomNOs/BqwY8HYodETUIIYUSQ2iYQl8L7FbrdTR7FRYE8/FwyUnix1KtIUaxx5A+fTCQj8D8RbDpOOr4oss9mdy4XeQSJ2NACBoH4RFu6B/s+InJTobzvnNQdgRDwAz3LXJxdOncIeZjU+559ucz20KiXablH0Lvyi75Y7R5/Sc08Mz8cSs5c82Q1qPa/csqPdvFZvkDIucWse3hD04wm7V0dZw6MM3An5/Uzwqo9tI0xw7wFNdb37PjohxuFs+8u95UlyL71V8an2afMqB7oAhwQ5uTuus+aHFwOmR3nhx1LA7HEfXVLxqmXWBODHgPlkt7MyGR5gRpmws3ikY7ZphTlar4Q5Go2L4y3ER4VeLPq9LuPt/f218DkCVDKHhJS2Q/GKzFmv4gSKWOVdrX8O56rcXjTxdgCfNEO8Be+H7P/ASYyOxsDFgIuU7lLtFLPrrb3UHF6TGrX2Qw/vVp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(83380400001)(2906002)(186003)(86362001)(33656002)(38070700005)(122000001)(38100700002)(55016003)(8936002)(8676002)(54906003)(110136005)(52536014)(5660300002)(4326008)(45080400002)(64756008)(66446008)(66556008)(66946007)(76116006)(66476007)(41300700001)(7696005)(478600001)(71200400001)(316002)(9686003)(26005)(6506007)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DrNTfO8nmAPJoj1t/Ks4NvH3WXwFUM6L4Ndk5aSlPwkj5yhjpdMBWUf9/k+E?=
 =?us-ascii?Q?Pjw+V/sU8W+wY4PnHNEOllEO+X7l/GFVLuw4TWX0g1iDYYYb9Oiuy3dHX2Mn?=
 =?us-ascii?Q?PhlYVvINiVLNyQg5aaL1heEWDXlhoYApIY4yRfM93WcbG+zEq36QCjJlt4gh?=
 =?us-ascii?Q?MAsmUX1v3aR8R4+MEz7PTyE6Dga1k/x4ZvAoOidEuRmrp2U96LJIHYOSUX0/?=
 =?us-ascii?Q?vaQ7LkgRf//dxU+ogk4xynOyyL9xu3xtPZT3fi9Osg2WN7IEw4CDn96Chd7x?=
 =?us-ascii?Q?XWVcxq6YXKKDXr6ognSubKI9ee2umUPiSOkHy6uOFZznquM9GWaNsR65AbTi?=
 =?us-ascii?Q?Z9BDgvj9ul7f0zpam8+12QoDploqfkGGek1QjBFPXfBsQ3PB8Q+7ImxCjMRH?=
 =?us-ascii?Q?dqxWvvcDKUrcta4nRIcoc9droV2Bt+XC9qG7adz7Kyqkr9/fGyLqIGsa/ZxN?=
 =?us-ascii?Q?IoMiTjRgQOFTwDeMYMNdo/cXTD+lH1E/DZMPX9nwDNNmvkdlSjjzN0iDuoPR?=
 =?us-ascii?Q?dd3oxUBKPcyUjW2gOpJ+oGBavlFwSIw5P+8J+hogTOa1LwcQscsTk477b+M8?=
 =?us-ascii?Q?BpIeoebxRwTldp86ipYXFTHrL481oCeHGd7P+tArHnAW36lwwu5kqNznglwm?=
 =?us-ascii?Q?vuQnXDTAPc7YSr7on0Ujkv3o5piLXCDQCZWEm216NR4lYbFafd5ERGp1JJHx?=
 =?us-ascii?Q?f2LMeUwWvuJ0pEIBnxP4TdTEVnBZzvvt0ADfcNzQk6nhLCwblV7khEybhLNZ?=
 =?us-ascii?Q?/CRMQbsIv+h8zgaFmHwyl5RPF8GxJK8QSxTmpwyvXnbx11anH8KyjtZwRw1Q?=
 =?us-ascii?Q?wQukfge1eNkUVMYUDezpWv5f8Nt7Akh0MZ3TGOMjqvXWB56fAXA2eeg8yNlk?=
 =?us-ascii?Q?GE+kslA7k2Iu1+s23mrDcEimU8ZmE/ziVbLGXdZKaXfBzpZM1rrYeKBIv2Sw?=
 =?us-ascii?Q?2a81z75Nhi6MtvPAE6a+1IeJjC7nn32H+LFQaoljLoJ+C1OUR3f/7694Hd83?=
 =?us-ascii?Q?EY7xJgoMGVjcOP/WK9Arj2jO2q88BW4nLlEe9G4rPQftE4nf7DvDvpwNy5t3?=
 =?us-ascii?Q?JagpNu7E6TCzdhuDbFvgqSF9nb/UxVD6oNFw8c7fOwmt2MEreAs4X/+hLuz/?=
 =?us-ascii?Q?Q4Yct0mbnnaAUfxN/xfnlOQ7OzJRwrLjXA+on+TgSiSno4B11db5q7bIyasC?=
 =?us-ascii?Q?fVpF6zxjAM1lNkMe9uN7IuyY5rQKyg8O8aNC/rLd9AEnvz5+zuuN1FmMxI43?=
 =?us-ascii?Q?lUhlUboLIL/RSwY93bFn3cj5TteKMKMYUGJ6RV6wEMRvPBa7z4M5XXiGUW9Q?=
 =?us-ascii?Q?ryFpqvjy5noHNijt2Lva1HYAnCRfoIlt4CPbPTLDeR9lBP32nXAW2HHG+R+e?=
 =?us-ascii?Q?cgu+hKTi75FxbX+hzJTxKtOBJxB71aUD8Qxf9r2GxtadIyWfwfNk0jPovmWL?=
 =?us-ascii?Q?RVT+a7omaKBt6gzVSQetEgoXG9NuLz4BbH/Niyhm0ZE/Kr+lxCsDWOjZhG0O?=
 =?us-ascii?Q?gQCHb3ww+K4U16LO9C7qF1Ktb6kscWhwkwsxDeDOcEvxsdqFs1zqiIlbc9VE?=
 =?us-ascii?Q?GTFjYjb8D5Lj0+41A1E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7655b3b7-9384-4ff7-9c15-08db5cfa5bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 08:30:55.4168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxCWiJahapmSxF+wpP4iO71HRKt/91Ia01w0Ox09iu7nUrI4LE+YDTcISPTnOMWFcOjfejDeeNOdFHRzMKQojw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7696
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V3] soc: imx: support i.MX93 soc device
>=20
> On 25/05/2023 02.01, Peng Fan wrote:
> >> Subject: Re: [PATCH V3] soc: imx: support i.MX93 soc device
> >>
> >> On 15/05/2023 08.37, Peng Fan (OSS) wrote:
> >>> From: Peng Fan <peng.fan@nxp.com>
> >>>
> >>> i.MX93 Device Unique ID(UID) is in eFuse that could be read through
> >>> OCOTP Fuse Shadow Block. i.MX93 UID is 128 bits long, so introduce
> >>> soc_uid_high to indicate the higher 64bits.
> >>
> >> So apparently, the imx8mp also has 128 bits, at least according to
> >> the
> >
> > It is 64bits. The RM maybe wrong.
>=20
> OK. I assume you've raised a ticket internally with the documentation tea=
m
> to get that fixed?
>=20
> And while you're at it, could you draw their attention to the lower bits =
as
> well:
>=20
> 0x420[10:0] UNIQUE_ID[42:0] 43
> 0x430[15:11] UNIQUE_ID[47:43] 5
> 0x430[23:16] UNIQUE_ID[55:48] 8
> 0x430[31:24] UNIQUE_ID[63:56] 8
>=20
> I mean, it's a really amazing piece of hardware that manages to cram 43 b=
its
> of information into a 32 bit word.
>=20
> >> reference manual, which mentions a "UNIQUE_ID[127:64]" at offset
> >> 0xe00 -
> >> 0xe10 (i.e. bank 40, words 0 and 1).
> >
> > Which chatper?
> >>
>=20
> In my copy, which identifies as "i.MX 8M Plus Applications Processor
> Reference Manual, Rev. 1, 06/2021", it's in Table 6-35, page 823.
>=20
>=20
> >> obvious follow-up question is: Are the currently exposed
> >> (lower) 64 bits unique among all imx8mp SOCs, i.e. does those 64 bits
> >> by themselves actually work as a uid?
> >
> > Just as what the driver indicates, UID is at register address 0x420
> and 0x430.
>=20
> So, for the record, for the iMX8MP, the SOC UID consists of precisely tho=
se
> 64 bits found in those two words. And no two iMX8MPs ever produced will
> have the same value. OK. Except:
>=20
> > For bank 0x40, I could not reveal information if RM or Secure RM not
> > say something.
> >
> > You could raise tickets in community.nxp.com to ask people follow up
> > on RM issue or else.
>=20
> Very interesting, though, that somebody else tried to do just that
> (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fcom
> munity.nxp.com%2Ft5%2Fi-MX-Processors%2FQuestion-about-UID-
> UNIQUE-ID-of-i-MX8MP%2Fm-
> p%2F1582383%23M200077&data=3D05%7C01%7Cpeng.fan%40nxp.com%7Ce
> e14840685854a192dc008db5cee5230%7C686ea1d3bc2b4c6fa92cd99c5c301
> 635%7C0%7C0%7C638205950874432380%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C3000%7C%7C%7C&sdata=3DfEXtlp0UTJjo8GGpdqqRurJd3yfamxZmiHkI4Zs
> MKMo%3D&reserved=3D0)
> and have unambiguously been told by "joanxie" from  NXP TechSupport
>=20
>   refer to the reference manual, lower 64bits from 0x420[10:0]-
> 0x430[11:31]and higher 64bits from 0xE00-0xE10
>=20
> and later
>=20
>   the higher 64 bits thus bank 40 word 0 and bank40 word1.
>=20
> and again
>=20
>   since this soc uses 128bits as UID, try to use 128bits
>=20
> But you are clearly stating the opposite, that bank 40, words 0 and 1, do=
 not
> form part of the UID, a statement supported by the experimental fact that
> those words are not locked down from the factory.
>=20
> Apart from the still unanswered question about what those two words then
> actually contain, represent and/or are used for, this leaves me with yet
> another question:
>=20
> - What's the value of asking questions at community.nxp.com if the answer=
s
> one can expect to get are not rooted in reality?
[Peng Fan]=20

Sorry, I am wrong, RM is correct, I overlooked the fuse at address 0xe00.

Regards,
Peng.

>=20
> Rasmus

