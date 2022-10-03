Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452F75F2E6D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJCJsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJCJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:47:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB3930F41
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 02:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpEZAVuLv5WwB/izuCq0JZFgf7a7RyCdCVQNn4/jzHMm6v6PQhyZ1vlKAWEnJxIWc0pljMGvAUSLzNPkRksvIWlzoOQGvs3kRwDaLnd6vSFrHDAbx7lU5lt4h0UHXQVVwG6WxKHE1Sq4yHW9Af5wb0pgp5Ba5B4DAKnQI4XjRGi9J0qpK1/McxR7hEmOF6xCh+ssjtp4bFynweQ76CAQd9S4eGK9rsSfqXvqNgbUBrrZpUUqxauVGYUIGu1BdHClsguHO8vSDYEjPe0bD08DbXLl/KdYIanad0AhwROWbo78lROzqMn1v/imi/H+aQoBJXMsHUNsPtGq6x1oajF1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGir+vm/ZkJVphqvKUEird/yiz59/6T4bKGPQuNg7lM=;
 b=aEdkqwk0E0fiHekNlRL7eLWjgmPiinVgMLurj2dQQrI2GoZNHr5wsUwygLYmviHVJRNRpCY1cEwko07Iac4ad+jfts7etlS7L1gLB6GmtZ2xfVCwIUWB2TTTyZroBxk6IiFXW6k5CsZEAaEJifjiDEgi+9UYgEgoo+brTLE65txoJ7Nrxwu8UN+fjj6a+IDYB+tOjljpsKQW97m3xlGmep2gq4CkpNQGo15/Lpu09Uq49Z4jSKUPTvWtLVY19GMPJmitDhT/6PvvIaZTom7W4omO/aD0FHnpRUoJXptKN8IvFqPm7AAVHGZJCb1gcfiOmnRdznBWtMYxVrU88zL6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGir+vm/ZkJVphqvKUEird/yiz59/6T4bKGPQuNg7lM=;
 b=prDOOcVVoh0BslyRTBCwlx51rVmY76VZEcCZlE5JTyVCikHbAI0XS+Lt0MJgpyb9tWx8mZ3MCMQgHK/VWCdd17c2oGB6le9llyOJrMQNCDH3Xr3wAZlHGOjuTKDLjQ9Htg+JE9zvvfntNhjw9dzz86Otqw8WZCxnruQNHuNfGQY=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by AM7PR04MB6773.eurprd04.prod.outlook.com (2603:10a6:20b:dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 09:45:44 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::a67a:849c:aeff:cad1]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::a67a:849c:aeff:cad1%7]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 09:45:43 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Biwen Li <biwen.li@nxp.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v4] irqchip/ls-extirq: fix invalid wait context by
 avoiding to use regmap
Thread-Topic: [PATCH v4] irqchip/ls-extirq: fix invalid wait context by
 avoiding to use regmap
Thread-Index: AQHYopBXddIttVt6zkGyOalTC33MGK201CiAgEgAhQA=
Date:   Mon, 3 Oct 2022 09:45:43 +0000
Message-ID: <20221003094542.tlh6xoee77akuubn@skbuf>
References: <20220728144254.175385-1-vladimir.oltean@nxp.com>
 <20220818141309.ifl3kddmxojqc2jl@skbuf>
In-Reply-To: <20220818141309.ifl3kddmxojqc2jl@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5136:EE_|AM7PR04MB6773:EE_
x-ms-office365-filtering-correlation-id: 30e0bd5e-8eb4-4bf2-8d2d-08daa5240a6a
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CXkjMpt5Opkc1kJGQTONAcPqiuIE51RIYctw9M2I2kXvWP4hw4OTWNRggGE+6lv+/Yj+T8dfDaxwrnCjkUCx9I1v7zPvBzO25o4bQWCVuq9D8dechb0Y/bQRATpFdIOO3lfIikT/Z03yTRCLdkHsZQCIOjDkHDFQ1kGh/b2GY2pjhHr04siPqKIHZ7lGaA71t1GhOzz6g/yHEleY2XwLfvkc9tMqxfQ0jw/F1QCwjHY5KP7rOMaEkqoq0t6BJzzCqXvNZN5zjuUrae54KsBuPl6f3nuGbuD58RXnCt0K7YyPLd2RjqLqDihjkoqnTjBXL1T7bIi5M7Zq1ekLJ4Dj+ZqqPn5RTXcKAaRRcQAmzgTkT0A7t4Yke8XWAYuCIvBivwesFC57wUOK7d3ZPSTur6QiIAqaRHtXYAPLXmZAYxhUQl4BDq55Pjx0/D4HdnpcznYRyGfDXeXBWklAaCPF05lJbRp76cFo7EWOZ9PsfvjK+Rxk0GFdRhKtq7u1SETX0i92XXANQ9HLjB3mvuJ3cgx/+/aeEAYl0wR7Dp4jCWayW9wDnE1Hi7qsOHCHO8kWFHjhbCA3QQE0OZcy0TkBHwq8b+51Y5d6uIjAkRdmkJROAiaV1HhFw2sZSUbBiE0L30ulvudGqLvy9S6+caCsuSrYAplcWyrz9zmJUkje2qsx1I3LKUjiFnUtmPH+DbGVTTkQ490PUZCSY0X3JgCGLJXZGP4Ep9e31RtXASjcY7PbwX/ar2T5vXqTOMFpi11obNHyk9Ba2Ix92w53lgsM2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(6506007)(66446008)(66556008)(64756008)(66476007)(9686003)(6512007)(26005)(8676002)(54906003)(110136005)(4326008)(478600001)(316002)(76116006)(66946007)(71200400001)(38100700002)(122000001)(86362001)(38070700005)(6486002)(1076003)(83380400001)(186003)(33716001)(5660300002)(8936002)(41300700001)(2906002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WGDuOzWK52UKV+gFgswKKNUOLSel7/RJ4QH+IPmV3y6jivMnT+IlKeJSIb6Q?=
 =?us-ascii?Q?dnV6+TYaGx0iLIhNZtISz00azXFnM/tFQu7K9EP8uMxFyTIfhZWjU7OVjDWj?=
 =?us-ascii?Q?7vmwmc8piMQfuAy9Swi5cItL3tLIQT71BhQOuda4zCfOCwBtinH5s0ILAGYx?=
 =?us-ascii?Q?ITmKlNDYIHlEslTRLw/9tDL6ReMKUq/doBpe5w1xZvhKKyALWmwQHD50zslX?=
 =?us-ascii?Q?BwyAJodhWEEFYXh3VeD2kp40b2BlJdGvhPsuFgV0SWLP6Ig9xf/oRRNuolUg?=
 =?us-ascii?Q?bc2apJWQQGjYuzNyNV0L1FpkwGFSkvd6Nd5wa+Ed3cWfkQxIyvaKJ/irWJ+v?=
 =?us-ascii?Q?syjBbBCF/c0BeT7tNxWVAvQxayzYUmmE4Yu1JfPQz9ibF9atAQ7Z3+0igNGy?=
 =?us-ascii?Q?MiFIdQZUJOZVwO6bQsRKQDFPFz/faKJ8xxg95FfMYnwTL+6ix5/94+ypWXfR?=
 =?us-ascii?Q?xoytcHhjZcc4XHJZviGQ+2Bt1jBTu9yFQ4PGncf4y4gHkNkKDU2r75IVNl/n?=
 =?us-ascii?Q?d7YC4PY6ER+FxDzcsk+81WmCw2qf1D7ul+lyUh/qgBtVQcQVa1Og4BRDoMv+?=
 =?us-ascii?Q?UBpeDE/7IBxLPAF9iGTlbOCOKSuO6ewtHgAKSgVuF9sU58LsXcBZsKgOa/Ce?=
 =?us-ascii?Q?mRqy8CKrxVsy4qXFANodcb5ssoRnYH1AluoEUv6WGM0DITwDW7sez0GqCzK2?=
 =?us-ascii?Q?yZeC3SzG0E9I0UTVT5FQKLPhEHqF8iIggBdGA5CFgV1+iOnVmnvqnGPzJJ7i?=
 =?us-ascii?Q?9IJ9RWht6BCWqhiXp0JQ/rNti2yIBG04tgZedDZ1k4SjJAKT/DBF/Vfng0uM?=
 =?us-ascii?Q?I6o6jyxbJLWD1LSZQmx0rtK1HQqOEgqo7iBqsOmMbQsLGWXlvdABSxLdZVvX?=
 =?us-ascii?Q?5AHgswnymWSqY+QY4JHBrowA9dFGCi76yvipDbuhUdjQaxHLhrMra+NFR7LJ?=
 =?us-ascii?Q?1QQJBTzq3W12uMb0cbTkW2WNFy0xlEbD3sF1UyLpYHac1f09DOxEgJjCS9Cq?=
 =?us-ascii?Q?zWwd2wJiNaglSM5luzOF6z4Lkd7kOpLuJGyG9mcbLWuylv23uxiev0pQ1Dzz?=
 =?us-ascii?Q?HpUueVI8zm+MuseW4Xuxn7vfyp83d9VhjGEN5WrL2LJK3wpe9CH6gz3Jq32+?=
 =?us-ascii?Q?S07805oAxHn57I4IRdB0RnOnZRjl4eZLbG2v4rNIPR/EHV29EyC7AzWpGQPW?=
 =?us-ascii?Q?vpZl/eeFKuVjzKL9Kvcnwxpsr+wF2B9TwGk8l18VMG4YZcrdxu+S25WwKOce?=
 =?us-ascii?Q?dvQsLI6pxmORKjbR7q5qwkbYr0hdDq/JsrfLvIdgYZ7jK3tXfGCDPXTqNqcF?=
 =?us-ascii?Q?UYHHono+vBY+j/1/UP3P6lpFqhVRHF/T0uGqd4Kdl7lzBHb3aaLWGBD+IMvf?=
 =?us-ascii?Q?i29ws0PsMHYobV9HePsgHasHc+ESLVZmRk/Nq4LN6BspH1Vhw/eINiWZYOLx?=
 =?us-ascii?Q?gQZryoef0t0EOwv6HLZGblH7Mq1CHIm8yMuKQw+WnhOgYswnxqbkW0gp5233?=
 =?us-ascii?Q?ywJDSKR4GRDv+n9/XutQRhZzSfD115t29MDSlN2xJd5ewTBRUKd7fR47wamz?=
 =?us-ascii?Q?P5jKdjpAUoKcgI0vRO9s/y9XbcbrBEwtgZNCLcdtHyxoIAL2S7DosWPpUNoC?=
 =?us-ascii?Q?Bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CAB27A2CCDE9914B87BCD935FDAF8BB4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e0bd5e-8eb4-4bf2-8d2d-08daa5240a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 09:45:43.8038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWWh2Pm7nSFwtTxrIQIknU3YOM8SlAGLZ17k/KyjxTd3oplpQkR04prcQ9Uqiw6r86OyHrutSYJsnbqcrQlhIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6773
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Arnd,

On Thu, Aug 18, 2022 at 05:13:09PM +0300, Vladimir Oltean wrote:
> Hi,
>=20
> On Thu, Jul 28, 2022 at 05:42:54PM +0300, Vladimir Oltean wrote:
> > The irqchip->irq_set_type method is called by __irq_set_trigger() under
> > the desc->lock raw spinlock.
> >=20
> > The ls-extirq implementation, ls_extirq_irq_set_type(), uses an MMIO
> > regmap created by of_syscon_register(), which uses plain spinlocks
> > (the kind that are sleepable on RT).
> >=20
> > Therefore, this is an invalid locking scheme for which we get a kernel
> > splat stating just that ("[ BUG: Invalid wait context ]"), because the
> > context in which the plain spinlock may sleep is atomic due to the raw
> > spinlock. We need to go raw spinlocks all the way.
> >=20
> > Make this driver ioremap its INTPCR register on its own, and stop
> > relying on syscon to provide a regmap. Since the regmap we got from
> > syscon belonged to the parent and the newly ioremapped region belongs
> > just to us, the offset to the INTPCR register is now 0, because of the
> > address translation that takes place through the device tree.
> >=20
> > One complication, due to the fact that this driver uses IRQCHIP_DECLARE
> > rather than traditional platform devices with probe and remove methods,
> > is that we cannot use devres, so we need to implement a full-blown
> > cleanup procedure on the error path.
> >=20
> > Fixes: 0dcd9f872769 ("irqchip: Add support for Layerscape external inte=
rrupt lines")
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
>=20
> Just checking in on this patch to make sure it hasn't been forgotten.

Is there something else I need to do such that this patch gets accepted?

Thanks,
Vladimir=
