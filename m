Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572DB70C164
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjEVOpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjEVOpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:45:19 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B7999;
        Mon, 22 May 2023 07:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk47RITLzoVjUkMxIbeXfItVe3gTu0rUoFTY4uv2g8VDUjPGkY+jTpnaNQovplD4EbpSjjNvyowHyBxSZQ3tNL+U/7u0+y614vzWkM2A/ilAS/8I7oIsPqx/kg6lIDJyuRyjimMepsA14T6yBd8/c9EHKNj+11k+Xod4vNw7yIUt2kOsz12/Y3X/m7XTnCFs2ijCYpWidv0s/yjd1bm69nTdIXBxNawYD24E21y1CN8gEooO05biQ2Gb2EQ7xBBdavW/P6RPeepBdmFPktu69cgkYoF3XQqKP4Va+xuCSphfF7SziKiXbmiHEq09s0bYvjHRjHfNSiUv6+x78ySqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTswAfQkZClOySWDqzYnVmO/YPso4Dw1sCg72Iowgrc=;
 b=VFBT9WDcEME2+FNK0SrlMs8utGnmY++M0sjwAtYc9Rhwi2XI7N3guqHYf7cPIoxgpi887vh/AgLcT0K4CXUUQGDPiFFbuAnltJg1YFE5BTJkxemGzEpNQflPBTNHoVCi2wTTK7bn2SGgNpBERyB2poiWMt8gp9i53dvWRFk4QmKZscqiNeKnkBQ+4g926ApbYGgizfaRGZ7gUUPeN80JAsDmpWucxPnlwBNzGAuvbxXkDyKkT5Zc7xY0jFwOqk0DGiG14w7l5U/Iaf4ZwS7lqUSbHBWbzWsXhK7aEJkT5WxBWFNcm4Mv/pqRcLlBIdt8vtMPtt7S+4zsgQwfZd4PRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTswAfQkZClOySWDqzYnVmO/YPso4Dw1sCg72Iowgrc=;
 b=BWCaFS0dLnqqf0qMmh6bBJ5SFEHu/ykrixz1dgNPdFNC5XwjpoW9OVLDZs2pO3AQ8nEn8utjAFO627dyIgjhZxeeelYalIuFOvM/S+8WyyJzFfTXmVjy9+GhM0J1Eri4gUdlzCVWa9K3iL7Nl3JrXHgzPsjAm2nLYFzEhC9bSLI=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 14:45:13 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 14:45:13 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Sherry Sun <sherry.sun@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: Check the return value of
 dmaengine_tx_status
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: Check the return value of
 dmaengine_tx_status
Thread-Index: AQHZjFjqXVRxV5mPFEi3tl7qfJLida9mXzjQ
Date:   Mon, 22 May 2023 14:45:12 +0000
Message-ID: <PAXPR04MB918546704F3DB435675B747A89439@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230522025111.3747-1-sherry.sun@nxp.com>
In-Reply-To: <20230522025111.3747-1-sherry.sun@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AS8PR04MB8673:EE_
x-ms-office365-filtering-correlation-id: e0515245-5fbe-4f2c-3177-08db5ad3263f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bNt+9raCXcc7UsUe/UyCl5cDvknswnV8UOn2JZDUW1rixhHEiV0qkfUqjbVYjCpZvOaiUQBVWFx1dvbNAsFSo5um0r3yXMce0LzRt0EzLHnbGUnK6m+bCn5izadJoyRogsPOKkcnOg6AOX9vsE865HOxgRqF5vMemNWsaWC0DqTWDS4OOINge8MRZKmAMXQj91B/0ILsnxrfUzX/N9IJSe6eOnwGe3Irsz7rUzC5ZGmvVklQGoCPBF1LsPh4uNp/7F1vrWhr/RlHe2QjKCnZygTb7tB3wE+YL9Mm10d1KaJXo/HDtK+U5w1cn6N8GahL9gzFIT9jdwisPESwu2H+V2liwquOYT8W1skqAe5nvutJVZVY79sQzZRb1VdJxfOBr5jA6RgR00HxU9mUakK36JUNYrJYLKFXqMGiiiekv/DqkkrXnaxRvtY7G/q9mrvaK+b82TuXDuTY3icVwlgInYH/m9zX4j1zuAH8M/auP1b/CVFKvy8pco9SoFRe7o5qolOhKP0VD5Fww01XMh6Jrmte5pBufDD8qetOAw2TE9kaZE/K7rViiDw7qROCqegwB/YhlAVgLsisWqC6O9t11VbLrLIiUvQwxiV05TxWi3ddy3RiV7fOpuEgnCaIteAM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(8676002)(8936002)(44832011)(52536014)(5660300002)(83380400001)(53546011)(55236004)(9686003)(186003)(6506007)(86362001)(26005)(122000001)(38100700002)(38070700005)(55016003)(41300700001)(71200400001)(66446008)(7696005)(478600001)(33656002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(316002)(54906003)(110136005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hK8T1jBoqqBPyaBR2o7NOQ37tFxchJkCD5RStnGwWg6G3Q3DEX9n9D0nLw6O?=
 =?us-ascii?Q?aoQWNWcT7dldSxqXkxavWR5cn6IYy23nFeTzOEVMT/TZfC08FUT8D6NUeIxK?=
 =?us-ascii?Q?3oEj0bL59yK+XXeWP6PdbgYu7UtowOc9ECEPzE4JG55a97v5ZHZtXV9RCCxH?=
 =?us-ascii?Q?W9EG6Sp0SQ+EgkVU9zkJBKTkg28XvzslGxtnVaBDmxsOrfarzNeWJw6+Q9W/?=
 =?us-ascii?Q?yaikC/osUIB0PMjKMsQExAEcXyxIoIMEj1Jr5Zs1n9hBeaWgEixkEM+cGHXx?=
 =?us-ascii?Q?BRVqHg8AKBLIkjbCNDiSt74Hbab1xYgLEsgK3E5QNlv7+szexu+wcRfX8gCJ?=
 =?us-ascii?Q?hr/U0Yxyd7wD0Wa+c2mOvBh89C/cepeevSQfXvTiiz5er0sLiMrn59KMOX8H?=
 =?us-ascii?Q?5TKP28uYI4PplEFgfvS4EFuHkmDu6/LmNs+4573U9l/OEE7xtnM92T50gx2w?=
 =?us-ascii?Q?e2+BEx2gtf/8NJyFNe1xsgGef3dAlTXUDGakD4RZ/cSNjs+Kk5/wOUhqbjfP?=
 =?us-ascii?Q?s9Z5ZyYk3wjb4HOLmKJPvLW5OrqEg+4diyMq9sPwIzfXkQaBHveAC8PgF9ig?=
 =?us-ascii?Q?bDIb7wuovONS54j1SpCZC4yAIKNIA36fsSi/dQajklZ43GRbxVQzYplQqCMh?=
 =?us-ascii?Q?EojRQA9Qve3TKlPuyppuEp+2RMXlb4MYAwkVxUPhzRtVYi/efxCqmYMl/b7G?=
 =?us-ascii?Q?/8eUPaQCoypBxum6HLcQ3nnPENgZ56fFau4515/KwuwDatS/j39D0rznQTpZ?=
 =?us-ascii?Q?UGW//Y/XVhmeYbt01jTi+o1/cjXq+I6KnOIZyDylMEPx6hPsjQ4lvGD4A85i?=
 =?us-ascii?Q?qGrh/N/mrzDzejjz/ljKpsaqZ6f+2OW33lBHrZjavE9liiyE09dL+IZ0FAmF?=
 =?us-ascii?Q?P2T8ABODcM25/Rs7NyCWcnyHhTIDKY7HpD3ESXKbKi3TPLt2bIVewbUQFL+9?=
 =?us-ascii?Q?XrnywT18n1oWK9BvT3s9lFLjADvp2aWwSk4ZNMwe43qNUjHP27oHWHnXwFRr?=
 =?us-ascii?Q?pkRmUGZ/FadCfGIhIkxcyo86Y0js2WqvdsxveUl247aEMlYKTTC349Jpdzu0?=
 =?us-ascii?Q?97kinL26RF121pWTlLu9ZPNwRwmgQl4zmbC4z2YooTaT7h4xphnfU/X5f/uW?=
 =?us-ascii?Q?AKfrNKEagM98iZ9mXlIcGUMsZuX7PMumFq0lj9HF/hpZCSPuFZGnxE4ykq1F?=
 =?us-ascii?Q?h8Cl0YVLBMVWe54Ek3qmwCwxYHAucfxWBE01dtvbGgSQsuTw0QEejr46k7Jw?=
 =?us-ascii?Q?7blRgDv5YvPcDLIiE6P7r+imTqImz/O6fXwPI1LpmsxsaYT/3x5kTFs6yYao?=
 =?us-ascii?Q?pmoUldoH1G2ZXJ+13ZFSlFEUKkskDE5sOnHGwga56pSnObREqJ3zxJFj9TjF?=
 =?us-ascii?Q?7vl8kDEryWN2Ps24xfHV/5SXetWOuJHlyMuvqtCfYwb/patfDTVk7Ophz1Hq?=
 =?us-ascii?Q?KqkU1Fxw3ig4g3BW2gkQeAlGf3FzjyHw5QW4IFrgIuUvfvnuxzcwRZcdgE0L?=
 =?us-ascii?Q?+Tf05tu0aLIWMZAEnFgzY4m/xHk9HfjPk+dV2pe2MZjHFcSb+8Kgazj6uxND?=
 =?us-ascii?Q?H7yvJs/eU4z95bb9r2TpSlsxJdN9oiEMwiEcoIKr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0515245-5fbe-4f2c-3177-08db5ad3263f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 14:45:12.8811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2A8l0+eXzWUgApfxP5mWjOomZbnp6/pZ5m6Xsoy209Ch8j9PP7KhtfES0PzXlSLFrqngD0Dnf1uW52DBi+LGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8673
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sherry Sun <sherry.sun@nxp.com>
> Sent: Sunday, May 21, 2023 9:51 PM
> To: gregkh@linuxfoundation.org; jirislaby@kernel.org; Shenwei Wang
> <shenwei.wang@nxp.com>; ilpo.jarvinen@linux.intel.com
> Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-=
imx
> <linux-imx@nxp.com>
> Subject: [PATCH] tty: serial: fsl_lpuart: Check the return value of
> dmaengine_tx_status
>=20
> Coverity reports the Unchecked return value (CHECKED_RETURN) warning:
> Calling dmaengine_tx_status without checking return value.
>=20
> So here add the return value check for dmaengine_tx_status() function to =
make
> coverity happy.
>=20
> Fixes: cf9aa72d2f91 ("tty: serial: fsl_lpuart: optimize the timer based E=
OP logic")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> 92a3bd0f4158..f2a47a8c5b85 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1286,13 +1286,19 @@ static void lpuart_dma_rx_complete(void *arg)
> static void lpuart_timer_func(struct timer_list *t)  {
>  	struct lpuart_port *sport =3D from_timer(sport, t, lpuart_timer);
> +	enum dma_status dmastat;

Should be reverse Christmas tree order.

Regards,
Shenwei

>  	struct dma_chan *chan =3D sport->dma_rx_chan;
>  	struct circ_buf *ring =3D &sport->rx_ring;
>  	struct dma_tx_state state;
>  	unsigned long flags;
>  	int count;
>=20
> -	dmaengine_tx_status(chan, sport->dma_rx_cookie, &state);
> +	dmastat =3D dmaengine_tx_status(chan, sport->dma_rx_cookie, &state);
> +	if (dmastat =3D=3D DMA_ERROR) {
> +		dev_err(sport->port.dev, "Rx DMA transfer failed!\n");
> +		return;
> +	}
> +
>  	ring->head =3D sport->rx_sgl.length - state.residue;
>  	count =3D CIRC_CNT(ring->head, ring->tail, sport->rx_sgl.length);
>=20
> --
> 2.17.1

