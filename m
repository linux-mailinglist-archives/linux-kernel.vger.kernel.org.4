Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8802C74C992
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 03:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjGJBYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 21:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGJBYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 21:24:08 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFED4DF;
        Sun,  9 Jul 2023 18:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhYRhdtf7n+6DaBG/vuJPY99KOEc8pq8bfLsu6WsW3Q/DnzQhbe2Da42GNZyMhV0G3VWgh89j9EIqvP05NF7r5/u/khBIKPgMtGM0YaPZciu1xXPsMp5XV17+BO0/tDNgMT3vIKyQGjsqB8ji1VI6Q96byHDH6o+LGo34+qrt+CMtVRklTHMNAInAY4QMi+y6mO4B9bMVJ9V74jbHSp94P7HraRvUkP8m0iJwlal/l6jGKBWHDjLb4RO2TrZllGWi7vK1tGZVmQfutFzEqMlUeEeETzJ8u+h2BtnEBT6rkvx2flaU3fND4ZNbfX+t1mIVAVHr2WgbZ+dqyRQ5LGUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IyuNs5iwUHOKth50MHKwY6Cp2UGxOfdmA1p7Fq/z/Q=;
 b=Tna0bPv9pdhp7THvIV6p6xDaZz+tVe50NCfOetCUS3x3arEBGAZy3+NaPfd3wxCDfSGviO/KSCaDsO2vEXNXLtHo+3g1LbNnFL9+BZ2nRS6V3Hbd8FSMXOewHpYcf4TYj+NmhFj/xAcKQB/UhccNEhwW4F8tWtBdUEWPnlbqLIA11k2ZIffKz9DjKCblNgBnoqnxJ7J9D++2OlYlIsVoqltClRtY1mKvpbMnweewNn5kXdq+y8QrHt8G+sP8/KNBkr+gbH4Iwu/lhpSL/vRGTWp/oH4VQKXmBo67ipHucBrSFqa/B1A0qCzFDCSDTF1VrBPwRHXLi/B6lUObz/hAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IyuNs5iwUHOKth50MHKwY6Cp2UGxOfdmA1p7Fq/z/Q=;
 b=QkXYxFgoZCiI+wH3ZijrXZ32uqee8TtnMTIamAIO7gbJP9dp4MTInwF3owYmkgkWzNdhIfx8cok3wf7jutfM3KRaM5IufRbcV9UUDUqpqX/lYT7/jXVOseOSZuntdlK2zrQsXaWoFKV/ttgFrtBySHVw6+QMgDhaITotaTdPpZo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7707.eurprd04.prod.outlook.com (2603:10a6:10:1f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Mon, 10 Jul
 2023 01:24:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 01:24:04 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] clk: imx: clk-gpr-mux: Simplify .determine_rate()
Thread-Topic: [PATCH] clk: imx: clk-gpr-mux: Simplify .determine_rate()
Thread-Index: AQHZsQ4ER45aLU0AXUWJc+qBXt4fV6+yOCmQ
Date:   Mon, 10 Jul 2023 01:24:04 +0000
Message-ID: <DU0PR04MB9417C52E8E1B15E194BEE74F8830A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <ac8bd50c41b84f244bb0ec94e8aed25c513c9037.1688760152.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <ac8bd50c41b84f244bb0ec94e8aed25c513c9037.1688760152.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBBPR04MB7707:EE_
x-ms-office365-filtering-correlation-id: 55c510d7-a78f-40f0-a299-08db80e459b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 517ImrTMaloSUX4QUYqOFnGGBx8tqXmsNTO/CceZVDOvbkZfQsrFEPoDygmjujs4cqA0bEecPXZnB3MgG5T2ymjczA2Ld13gsJmfQwEG7Ku2SNECfXWblNXxCK2mgBeHIa0oKfklLtyQnggt0Y+0f+SpmXipiRlYHJYx5M25h2KInuobLxDZvzPtBAfMCextL13esP7hraH3dQsSTUCh3Hlcd9Tld+kmsmb3mb1spKdbNGgL9PPu/fSnUJc/CAoXUHe74NCbDLoRItDJhxQ/lOD8pGrf9gSSq3GkzjEwqfe86Pbp3VozWibl5OH3P/QHze4/kt1qZPVegv9lLrNKU2wflnFKPAMaPbxhbmuIHF9DVxqP1QvU3xTGrWzj4bmLxdxwNP4/ITgmNJrdL+PQw3253lweNbCWptn4FPyHz6oETcKL2i3EL7rCZqyV059zP3xs52umnhvCTeVNuxjuVOvKsPg8W/cg/jnvDAXkUM/Sdi1hHntGMqU1TBjNxMUG4lHeEp7hRKDqcdSvx+QmPJ0xRjMqtNLNdv+RN/Am+9AXQNUQF1b2eMYnVxRQAfcowy893+zE1qiCzfzpW4hlKf5wPwDcn+0ErJ1WuK46vUTijYx79uuw9fAzSb+m3AzakhfZJt8UhmUH2idiqxcTXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(66476007)(26005)(478600001)(6506007)(9686003)(86362001)(71200400001)(186003)(110136005)(316002)(54906003)(38100700002)(6636002)(7696005)(66446008)(76116006)(122000001)(64756008)(66946007)(66556008)(4326008)(52536014)(5660300002)(7416002)(8936002)(8676002)(44832011)(38070700005)(41300700001)(2906002)(55016003)(558084003)(33656002)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XAcH36gVwbf0/P72otWK+ywUwUROdzflL0r7zd8cufUWQ3i4syT7qS9PtUac?=
 =?us-ascii?Q?RmSfNChlW6M4mLrnnX6S40vSA9k6P9338VxM2QaaEXY4ryzrh8XPi7D/VuPD?=
 =?us-ascii?Q?exHGrpu1FcqoQavztNr6gesMk+uLK+5YxEwn34G501p1WuhmqXJuXCx+tNO2?=
 =?us-ascii?Q?wlUxyBVcWvECbQuPb/Ihw8AifZWTy/7hyKPY8YKaw1f5FxvHW3VUDkHcetBf?=
 =?us-ascii?Q?8edrzx5KT8M1bOyAXmaujcU9VBEQXS0qPcsMGv1TAPR6Mk8D5/Jd0cmPT5wC?=
 =?us-ascii?Q?k4kd0+jShfrhZ/VsY+PoRvuUNjAIwymK2BdiGkzvRAjgHl7vqvxFfvQFOt2x?=
 =?us-ascii?Q?7rhd8KKbX+xxu3dwY1YfI5GXnWDOctOCRNPz15rdgFpwhvf44f+aAM+49B5S?=
 =?us-ascii?Q?sVmvL8XhWetD1EAh/zV3btAYU+DgdP8N4/tRFaanohZV8cWkfI9pxVSSwKSk?=
 =?us-ascii?Q?T0EAmdLqrLF5WTv+eJkSYritTme3D5p6JNqCBZYgaf2QZ/0FgJdR9fKkhzAu?=
 =?us-ascii?Q?JtfxMt5RgZqWCz9Oyiz+xiXTbcWGRM+GCbw3ivi6sbrozzWnvOPaNGBCVN7o?=
 =?us-ascii?Q?VhYBUqsv2dfQ0cb+N79YNQATU4dZYjtnMPy26ZqeVzwBVxBdd8l8z4lHg/TT?=
 =?us-ascii?Q?thoM52uIsYAoab9zfh9YKmCiMVdndt8TSLT3dAAjE1sKbTurUZqOUw8v0aJJ?=
 =?us-ascii?Q?ojDbyZD1bO8JMPUn29vEvrbpPU4lA/oNANZeo2u3PZTH2I008PgyfrNtyin4?=
 =?us-ascii?Q?YFMVEOgxj4bxndF+n8zdicx0d9yMH6J6Bi4mHlEYWjbjHHezepgnrOh+XiMU?=
 =?us-ascii?Q?Plipd32BSv62xOhLkBeson+UbFOOFAqhjjQC0l1/DLk6BZ+4oFs7dVZQpOv8?=
 =?us-ascii?Q?Kjpgp4khcZxhWE6LrWaiPzX/+fyibfUjwU+4K0XT3bN22XfQHxG8JHF9obXF?=
 =?us-ascii?Q?IutNwyMbgTGMdFOhUm2EDVjiDln2Msa+oU7MRe8X50vijfhSMNtjIbAuuMAG?=
 =?us-ascii?Q?KXYBUmtwosO9eBRFuFDHvW4mt4SsJbhmAl/sKMsVwqcVL62m0PNaufQD1crC?=
 =?us-ascii?Q?lLVgIuH0sYfzfAL4+oAzjX53pY/gZUwRitmdRt1bNUTQ4sUaWxXCJTKz9+qU?=
 =?us-ascii?Q?gJyA6qeYxtCZKN85xjt3P9suaUhvtO/Z5OV7qdvE6QyBsmHgXyrXXLz9UMFg?=
 =?us-ascii?Q?dcRI/Xkh/bvh4wZsktgA1STsC3BE92T1HbxKaqlYJu8J9vYBWcVHyRZdScpC?=
 =?us-ascii?Q?neXyfA5cZLJxAwwM4RCkNnE9B58cFxMohySai3Jq7z3y4NC6MfKHce6T1SZE?=
 =?us-ascii?Q?JusZH4GWGVojmSM2NhsdMXXwxHLPw/lsLXC38Yvpc8kNkJTXp1wmm31l8kMF?=
 =?us-ascii?Q?4Rb9RP289uOJgfy8aC9e16/fVGZcnudTMPIMnFM8oQaD9umWd57mHCooMv3k?=
 =?us-ascii?Q?0mp/KYaAF1NLxdUoPaVd74w8/xiZpD3c7xiT8IPTDHj+X0+Z3UaPytD9eUWj?=
 =?us-ascii?Q?/vzHqqXA6+DQZmqz35Z58ddmhpoJpZhARF1BdcVY9T3sF4xTDZBpmtDnWMd+?=
 =?us-ascii?Q?XQ5X5RcAFiUgGjyuBtg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c510d7-a78f-40f0-a299-08db80e459b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 01:24:04.8744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+TNy6pZiY45q5+aGW9GxwPvw73j4YEfDPAjHmlPyukmwGDlDf5oKgiaynx4uoAO5NmaEZFb7WRWjL9JVj8uYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7707
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] clk: imx: clk-gpr-mux: Simplify .determine_rate()
>=20
> imx_clk_gpr_mux_determine_rate() is the same as
> __clk_mux_determine_rate(), so use the latter to save some LoC.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
