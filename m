Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159D06F8F6C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 08:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjEFGmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 02:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEFGme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 02:42:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8147C2D76;
        Fri,  5 May 2023 23:42:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvwp3rUPQjPIly9XWQMi5AxTzmFdy2s6ntfxZdmkD7A6bxQKcYhzPQK6k5R6zS2R+xb9YEY+9cB3AUMwPjw+YF5moU3IPISsHgR4h3hUS6qXvzr9JG46t57Daj9kVGWm/gj30XRIo56cWPa/+xFylMzfVqzt6/lZtwPbxmrbKvYgmP3+UTwO6deLjP0TLzEaQvNXyAqPmX+2p4GEODduNOT0rrmgZpGsVihKdvLTRMPPBfv0I7ey5kM0hUX4bJPvvbAT695Hhn8Q2nFJp6qVKScQUYxtY7IVglWbxcw37x3fM9PexewSbHlgBm8CZg1vXZeBjxviuKfgT0XhVi1/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dbd/6n788Y1Nk1mkN8AK/xzTyXdFlUajj4O2/9B/DRg=;
 b=FfBjP/p9jDKqrnszq9vKXhvFu8vVtRJdTvrzbEFLWCDW+xYqO0A5zYWH0mPZQyCW85FjT4kgUIzUFAOYkWhICI90cfieQR3rHUhUtBbnoLdAUGbx/ucHZqKZQO0Mwh1cL/b8L8fWu4SGD3djYjAejAWVah9PDqJbXUIEp6hf3AnZc3S+FdUxxEpwqGX0gWFbkxOq7o3Q+SQUmh3YgGHCfyIsgUTzScp1SAMma5TihRQw9eNcYZ88ddpCo3oTi3uTepySDxmLgwGpnPIiZP8yTyQ7RV7gwNmcZNsMAdO06PvQ/k1RK34HOTIjqtEW0qtN0EUdz5QG4mVVGwLC5HZjOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dbd/6n788Y1Nk1mkN8AK/xzTyXdFlUajj4O2/9B/DRg=;
 b=DsZYTYGcUAUK7bFksYbpSifTXfh8QxMlKtD2b8+Lug8xDI5n72c2vrXO7Lm2arjNH0k5O4awhlc/6mgEprRmbqKlzkj89k8YJXChDSJeLPljduLxccU57Y3ghZYLz3oPBczwO5fRHgt6egeAvb/VywUUVgHaoxZR3cQAtK809ck=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8586.eurprd04.prod.outlook.com (2603:10a6:20b:439::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 06:42:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.027; Sat, 6 May 2023
 06:42:28 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: nvmem: imx-ocotp: drop unneeded
 address/size-cells and children
Thread-Topic: [PATCH] dt-bindings: nvmem: imx-ocotp: drop unneeded
 address/size-cells and children
Thread-Index: AQHZf+XLNTIPREWRGkigxjtNtnDjhK9My+dQ
Date:   Sat, 6 May 2023 06:42:28 +0000
Message-ID: <DU0PR04MB94170A54847A6FE914F11E3B88739@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230506064128.34005-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230506064128.34005-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8586:EE_
x-ms-office365-filtering-correlation-id: 97727383-8ae0-4203-0600-08db4dfd0f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRdUcytnwHDcbNeoNcK0RqfVdNTiBfJ2Nk6j95LWAvsrutmfqz4EWQtbR57JzyaxqZFpcB8m9Wg045cRCqLLkp+jVgd0IivW0E+vbZKYTl8SwCOZ+ig4PLtCS0xjwV1mEOgbJvDzQvwg86R6m7sqqEr2IvDjUJZY++sA9kBv9d4gu8yEbKAXldjsgGCoYpq7qs/IqBfb6S7nOMZiGAcAlUL8yUtcW135bna51iAcStbo3uWCDWh1tizwODEM9iJMpeIQe4CcooaZjQydDgujwZoYjSAImxhaJptZoHTHRj68ku8tycnVSX/JXzTxOQ316DFD5Rnb0k4ZJ7ozjaVCg2in8VH6TifdFXQOl0gPdwi23zCRftCZhnYR7nMjfF3ry/D7hj7gJrJTWU06jNrw72cksj/YokPqe+YlCKsnKcdwWRUxaW/OL62DqsULKrnsk7SbEIpKsGeELY9Pty3oLwvageLMsyyWJjj6WifzI/hE86dQFU5b7ZLHUZPtGaNCLDQW7YUxaPrBo/gwamSithX9oEMTDV+rIDLlf9ljDRceysZoLFLYAt4jWpTkf6bwMuFOvBl1pRyQb9zfKyIUPSyoOnjsoCTU+xY8qxGUku0LHhpjdpeC3Sq5E6BKh19iEuxroUPCFgP6IScqBrlGjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(478600001)(7696005)(316002)(110136005)(86362001)(33656002)(558084003)(6506007)(26005)(9686003)(8936002)(5660300002)(52536014)(8676002)(41300700001)(7416002)(44832011)(55016003)(2906002)(921005)(38070700005)(186003)(38100700002)(122000001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+I8D7yYJnWyCCE5gMjiJsCUIDMAdTK6H5wxgPG5eMG+WgcFiT/6vFM7S/AoE?=
 =?us-ascii?Q?trqLOhIiZc4gMC3pXGHEJjbbva32JNXacsY0lQKkaTH0fPkEU01Hs44zKq4J?=
 =?us-ascii?Q?eOppRAgHEWCm7jqh+D3kUC0Y/isMWnIt6h6uZyOAYONZdlaV+WjYKq91Pn+O?=
 =?us-ascii?Q?npQoeYG1gIlgIDlsFRiM27zf0fkHXUxqFX0lm2uEfX8+7GqvzTia5ht/2Zm4?=
 =?us-ascii?Q?o7Go/gRizphdtdBTs6HsB3YDFtBY8MyGfKP6hjsvS+dtxn9Adft8Rh8HSq5L?=
 =?us-ascii?Q?qC2+SKP1QwqwuG7oW42hwfm1FjxYFLAjfFqSYcID0a2E3wQjW4Hc/lpU3Sod?=
 =?us-ascii?Q?9I49bMgIkrpcnY0NTqzb1vU5Rk5+EXdwjXSfT6vlTIt4wk2w0F+yuP2YS1ti?=
 =?us-ascii?Q?xcmGztDJ0lTHOtTzRycfNPA8V0FY9AUdzReK809dr9OXc0pplrgRGp1m0w5Q?=
 =?us-ascii?Q?LP9Y9W7FldJB3kFeXJC6wRRJDEiLIjA1FtyuLGrvGRc41q4WbgijlaAAT3Ve?=
 =?us-ascii?Q?14woK14g5AEc0BSdkw1pA2yBIqEz1TCUdy+TPLsSC+7QuGFNOpPJmWnHcd73?=
 =?us-ascii?Q?FcxvR4Jcus319WKiaPwtbthtFdk+JEJYHHAUVRinkTrqok/OPSiNAwPOQc69?=
 =?us-ascii?Q?FFX/mdRU8yarbBp3bkAaMvAyfv0mHcUw7jjal4QpljaVmvnF5DGy2FGpiTjv?=
 =?us-ascii?Q?PraGU9qqTHqaYgWYB6YQy3K9Ioik/54bF32LJDFlWbCtsQzDTG9m3p9kHL9S?=
 =?us-ascii?Q?W7oHObDUfONyqEC+BRu4HeONvs+5WhfoCLQwrXuFHSsquEoJMO2JKYXydbzu?=
 =?us-ascii?Q?BTCUpX0UbVjBv62NwMOFBjKtJGV6214F/1jkaa1B1ybsU6co9Fb9GQBzsBzJ?=
 =?us-ascii?Q?w51uKYH0MouBhZ5lHdzO32dHoay5OApAq9vzhcon8RDGMNqgwDsY3fjUHSCY?=
 =?us-ascii?Q?pGVbI4RGcjAyfuVbVs8csLIGfANKGx3kuagXjtG51EAVSXqJIT6x9FFTM4gI?=
 =?us-ascii?Q?sMcU3QtjqwaYgvoXmKaXpJ6bhi6w3W9f7h5L8fbSUAnHGBAdVnty7nAciPBo?=
 =?us-ascii?Q?TL/lePo0Y9/BIFskCuQW/YIZquizgZwBAmUkpRu5b+qaF7TAjyz3BCd/hwSO?=
 =?us-ascii?Q?l2YZADzOwGsGyLtSYKx6fV3RyB+chyl/5l+QE7pvhzm4IM0vVJ40EWPY4yZf?=
 =?us-ascii?Q?U3ovka1o9sYHMR7Pmz6bhJGwT4dmLOgNlIpGXAtcr4z5DAb0u2fLgDVcKUeH?=
 =?us-ascii?Q?dd+KgQRcLUJHT1tGYlIEz44Rgii6+NBReXWYI1l0ppZzC0uSa6euTqtyrKv3?=
 =?us-ascii?Q?FjcGjS6BqdtIJaeX4o5PgM6dzuRq0JUANgoWATjZTspZ54kUwKBK4KWG6T0r?=
 =?us-ascii?Q?5u0w9LWsfOgR0FsuYtvdHpyOuXv1BAViObhDjzwUX6K10egUcQU37OFljJFP?=
 =?us-ascii?Q?mvLz913JDTGnaIv0r97inFV5qPv4szdsr8f8IQSBzzq8LZrYsedyeoXEgx0v?=
 =?us-ascii?Q?Vsrq/QDajnDaIbM9gntCWEcrjsEDphpY2gpaAbqnjmtzoYTzUb8ALwMiaT6y?=
 =?us-ascii?Q?un76q4iED9ew/PAiKKw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97727383-8ae0-4203-0600-08db4dfd0f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2023 06:42:28.3150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8WLkd375jvjQxQYXQk1lJGAgQv4HgwBRIM05UA1e7FkMWuDYdoF9YDnqOOAFVOxpiXgWuh68ody5U/U5FEYqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8586
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] dt-bindings: nvmem: imx-ocotp: drop unneeded
> address/size-cells and children
>=20
> Referenced nvmem.yaml schema already defines address/size-cells and its
> children, so remove redundant entries.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
