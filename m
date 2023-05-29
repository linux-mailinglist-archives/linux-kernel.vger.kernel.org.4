Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042A3714254
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 05:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjE2Ddv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 23:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2Dds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 23:33:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3183B1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 20:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDdAMiITmQSkqO4fjWlbwF8mihpLe98SUh4HE0M5RGJP2fc0erP36WyXt9WqUtLy212ZhqOKqI0ZFtHIgZ0FD/eVMlCrtDXIC7aCgKZ4Ez1DGnFBK4p3gEof5uFSbh8E/oIjvG5FKOQoAt/DQl09FQ4t1/4eyP4+hvXNAc6hCvhB+NguH6ebpbOUsnJkU5YrnpnGnnwOqE6hOZDEGG6YOWi6oxJi0/8GzaMKaFF9Yzhnm1DFaZmYzgYklU4Yns2K6Colh+rxS0+8A05isOsNPsHI/+m6Q3JXX4U7Leu5u1XJILW6YGE71QKz3h6Gk590EYdcOKU/Fc9NyRH+KcocaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVKQKB98FxZcypcZH14yhCqQ3xt7rJBiU5wOIOmJH34=;
 b=BY9lK27lO+S449paUb0a393SkBX/QjQF1Ryvd2hA9/khrNfYUobnK/V7++usNKhEXC0nUGq+rRaM3ilyCeTTu0HvZ8y2Wcr+8X10ylEZvu9ojKLiW71J66GquFzgW1KdoH3b+JypvDlxVBJapH5IpV7i+AvN4xjcTMLDXGNspeCDyqNu1dZ07WXeTZ7foRvf6dw2M0AzvB9AYqAtfF3uaKzSUKc8N8FtRI9spsgtaH9dyQ0VV76mIvM+GsDXlPfGVrrz5HOvpq4X1WVtZ+d/VtSfF9m7Grlb5dc3BNcnq2ixrIQT7e3BHmvvJwmgIV+vA1NytBDUfu5urEAeDSsF4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVKQKB98FxZcypcZH14yhCqQ3xt7rJBiU5wOIOmJH34=;
 b=hSFnKYZqhi75OUOWqull1FAx95cI+RjWigULeI5tZP5mJSKDTJ802fzyknO8mvMHdfP03BGbqtyQDi7hfVgHnLbOC/xWcJIeBbLt9nQsQ7hIMc1sw2+L0rbS9XtGWT4pTfy/JarXySy93WuqZJ0o2irrxlUEKUfAKpiZQFRvvGQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9062.eurprd04.prod.outlook.com (2603:10a6:20b:445::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 03:33:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%7]) with mapi id 15.20.6433.020; Mon, 29 May 2023
 03:33:44 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V3] soc: imx: support i.MX93 soc device
Thread-Topic: [PATCH V3] soc: imx: support i.MX93 soc device
Thread-Index: AQHZhvcGw2nYob3zLEmYd1JxpO1fJq9pecCAgARgjICAAtQdEA==
Date:   Mon, 29 May 2023 03:33:44 +0000
Message-ID: <DU0PR04MB9417C357D4A919288E4D42FA884A9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230515063730.2042715-1-peng.fan@oss.nxp.com>
 <33d57180-aa13-4178-86e1-c4cf6ef29a6e@prevas.dk>
 <20230527082037.GB528183@dragon>
In-Reply-To: <20230527082037.GB528183@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB9062:EE_
x-ms-office365-filtering-correlation-id: b8d998aa-a490-4f01-4aaf-08db5ff58163
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aevGsy0uDxAX4ryr+SY72y0bW8MDFrOsqh7IMwQ7ePoL7eqZvhJKRS0MidwAF9PaFcf9O9mFC0E5ok9QdH1/Xt8Q2c16Bfd9NaqZO9cGsh11bcbp3IFcphQ4TZmStHCdoy4yAXcIDdPFgKxZt8eGBSHwDkvznaDKa/Bkl6X6QtCNbLiGEUkyC3XUQdJTX68T43R0Mg5DDXRnPyDMpQgZspyM3rZTl4NAuLr7tKrmMQIuGw5P1Vewkgd4R19woMg6fqBAe6Z/U4hmVnnea5TpicgBI2cXfDUkE26Aw/WTMdrx4hxGfYSLn4XJIiKGhApKSHL0SCJX5228TfqFsDYJ+nNJQJWWRmG//Fk4swXnm0HIwRKD287Ss0okJV0PE5F7ZPK8gg5nV0WVpE2Ekubpz+Ch9l1JYhD1dLsR9JwWYUPOIbXaqhqL1jZSPpsYW8z9eFglHA7mkmfl6x1vtyXxReYEKvh2SHQ2uHTgUxo4uJxB8VcXjbysFNP+2Gj9Z2EmxWwVij9VlEpQyyyXqFcz7SvbL0Vkhtx+fBsVY3Q2aah53yIPx63LDOMf4lHRh25h+u6jbaKVVvpFIUSBFUtbORlAAYFrw7r4QtdPBCwfTLB2m3u3rZBmic4L057XwJpj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(66946007)(76116006)(4326008)(64756008)(66556008)(66476007)(66446008)(83380400001)(52536014)(5660300002)(44832011)(86362001)(41300700001)(38100700002)(186003)(8936002)(7696005)(8676002)(2906002)(122000001)(55016003)(38070700005)(71200400001)(6506007)(316002)(33656002)(26005)(478600001)(110136005)(54906003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UlMuHLRBR1FmchAKre7MnZ0SC0z3OsBuqKAom95pP1aJe4YiFbSbU9xtdbmC?=
 =?us-ascii?Q?wR3XBf9zA9yZqQtO5cEs4fCR/iMZEdigHOrSwRyrhIepv/DQABHHWZKVTMA+?=
 =?us-ascii?Q?qLNiiObrthLV+k8fq07WgL1fsFqvtrJMqaqWGxBQS1Gya5vWaRhD6xKNmPUj?=
 =?us-ascii?Q?WWpf1W5e0C4wK9hX1r+HJGeadQ0GRIF+1bU6/XqvVPCDuYdkrqj47XiVLGsj?=
 =?us-ascii?Q?nSC0Ft2T8Dim8KVPv9FU+8PC86tv/RMR9KHrID2Efc8VwDTUY8xzBSCtm1CL?=
 =?us-ascii?Q?v12MdNSeBI5cZhEFyv6bc1o2elGJs+UH3bmjfHOUHYKGAAy976eKKanOvdMC?=
 =?us-ascii?Q?FVZAkcnTIbwW4fOc+Nn5BFPvHVQBWAJ6FYAj5YtPXZHmcx+SBHSMFzZt8UtV?=
 =?us-ascii?Q?qFFBX6l7kleIO6cicSqzIEwRle6LB347aXmuUdlUHC9mHh0MOMZpUuFOtJGg?=
 =?us-ascii?Q?3TtQam9KfMe62WyXYhT0NJfW2VpT5pL/i7iEGEqdfQ+JqLUpg/7gjiFJ7S2W?=
 =?us-ascii?Q?r99DAh86iAOoxIChVvlSupFi0HxoyjWdbuf2ChvkeHiyBVweUe6CJcbXVGJ5?=
 =?us-ascii?Q?PWF7GKDWswWgFcEYkhRAZeLxqrPdrKMM+pvnpdGiQwZwrO6IHBR1shS2Wqh9?=
 =?us-ascii?Q?3s3e4uv9tq+8JA5kLFDlLHBxvATi7gUgSbiwdHXJSUksPRsTjaXwazY4cQcX?=
 =?us-ascii?Q?QwegJ1jXJa1ugQQknxUS8pMHz5F/f6BxS4JMgxITsLzRpfq6PbPJRpUpakob?=
 =?us-ascii?Q?9WahTkWYnH+dVmdA0G8RtvmlB6YWOrntYpBFc2YMBL4meNy22pWt8EI6fnqj?=
 =?us-ascii?Q?cdVC+O0MVmeKt/GJc1HUTU5ManjLoi9XEKF6oqEk0XzRphG01QD5RqffjhHv?=
 =?us-ascii?Q?8XvtVwKzMIXgQQXe4TrWTeArO6K9hf0MaNL8EmBlJApom4kHId3qb1tBIpAK?=
 =?us-ascii?Q?VTBmNKaeSPoi0SByXsUFEtoqnYJdNKT8HhEoZ3E+JZAkVU5A8xlnKwyXaBHj?=
 =?us-ascii?Q?Bgg1sCOnMfAvZeNP3XPsK4flqK+RUVfafx5MZfsdkQK5u/QuEw7OfCrLsIim?=
 =?us-ascii?Q?1ypoZLpkAwyfyVuB6sO3MXNF/H+zDP5faTAky1tk3DswW7U2LZFuOND0hhbI?=
 =?us-ascii?Q?XgigPafzgQ7UhBKTqT7OZlFz9dRstmXCKdpaQHqlpIsvXUwRFgk2mezRRatt?=
 =?us-ascii?Q?cXsl71AqRQwoooiCU/9i0DngrliFs/TYOwmjWlkvw1p8myxEYtujduBJ/CY4?=
 =?us-ascii?Q?vlNSQ/pUwNttaxVq7x4yXnwBDhWgerFhtoeZYYrRugOcz/KvNhFO2a1fHYMT?=
 =?us-ascii?Q?I9FsTiHb3uKS39UnJKT+1oRwY8EAU2R5HEmVb6GZDpDdfG/yLeVuAKPJkHSE?=
 =?us-ascii?Q?crKXijHffQaFDB5Cmy9xDPATn527fMch8kcP8jcZk2RxQ4W6V/sbtwZGz29E?=
 =?us-ascii?Q?AgTt6NRN6FrG8ms8jeAmrqoC8uSSDCuvnFmYDHXCzbEM9Y37NF4zG/gEGa8T?=
 =?us-ascii?Q?5MTKbA/4vYXGWR9YLBFIDAYcFu33IxtntScR6pPTC0IU3Ampj05K1yvoYrQ2?=
 =?us-ascii?Q?+oCDi9ULaOlTxRdH6Vo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d998aa-a490-4f01-4aaf-08db5ff58163
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 03:33:44.4917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6krw3sM8OXz7JSNgGw0t6JepnfYJ16UaTZsaA6KQbM1OaCPigKGGbQKOeh+pXfq7ihLOdZAv3PUsZVd2fH7mRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: Re: [PATCH V3] soc: imx: support i.MX93 soc device
>=20
> On Wed, May 24, 2023 at 03:30:01PM +0200, Rasmus Villemoes wrote:
> > On 15/05/2023 08.37, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > i.MX93 Device Unique ID(UID) is in eFuse that could be read through
> > > OCOTP Fuse Shadow Block. i.MX93 UID is 128 bits long, so introduce
> > > soc_uid_high to indicate the higher 64bits.
> >
> > So apparently, the imx8mp also has 128 bits, at least according to the
> > reference manual, which mentions a "UNIQUE_ID[127:64]" at offset 0xe00
> > -
> > 0xe10 (i.e. bank 40, words 0 and 1).
> >
> > However, no further mention of these upper bits can be found anywhere
> > in the RM, or in linux or u-boot, mainline or downstream NXP.
> > Furthermore, quick experiments on both an imx8mp-evk and a custom
> > imx8mp board reveals that those words are not locked down (they do
> > seem to have some contents from the factory, but I can still set more b=
its
> in them).
> >
> > Could someone from NXP please explain what exactly bank 40, words 0
> > and 1, on imx8mp are for? What do their initial value mean, why are
> > they not locked down, and why does the RM indicate that they should be
> > part of a unique_id?
> >
> > Also, assuming that the RM is just wrong (wouldn't be the first time;
> > the description of the lower 64 bits is also wonky in its own special
> > way), an obvious follow-up question is: Are the currently exposed
> > (lower) 64 bits unique among all imx8mp SOCs, i.e. does those 64 bits
> > by themselves actually work as a uid?
>=20
> Rasmus,
>=20
> Are you fine with the patch itself?  Or do you expect more clarification =
in the
> commit log?

Rasmus's comments is for i.MX8MP, this patch is for i.MX93.
But anyway I just sent out V4 patch to address i.MX8MP support and
then add i.MX93 support.

Thanks,
Peng.

>=20
> Shawn
