Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4F96C28A2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 04:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCUDer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 23:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCUDep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 23:34:45 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAB16A67;
        Mon, 20 Mar 2023 20:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ft7HwojaA9GbwoDYZd/GDpQ/qbh4USwW4wLv23kxUxeVz5c1/7hQGoCpCMb+VjHSFNuDMSmMlFgqIc9sx3W2PFZ+Y0EoSQn7X4OWFn8KjrPZVnXHm3UdnFny4fdwmgi55w/rUlH+49vR4SCdwJ7AFtRSlzkXU4OATsr/p6qx29NCwbQZVrtBMKxHIc+MR8WpOhGWPOFCcrRYoIt/fEwcsa8VkMwpgvSsy5wDABPcrGyPRsaIQoKyTnyGQ78HWbwes72R9jYPdVx31BJG9ucSzDixTR3bBNrR+FVm5tJEkYEgOSGO34HTlJ9bRUobJy8eHtRqsEA2ZBHkxkOIbbujGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I6EiGfMFvZ7JTjYEb4dUmK++NX9unvVY5NCfGI0CW8=;
 b=H8aLdJQdXzT2ELtB0mjSP0taVNAhtulXROUtrReVb9OJXypfPOUwkLP3YzT/KRtBn3j765smLAPqtcwaNqmOKv9dDDjSF+nGn3JHafOdQxHWsvjcFi+DiUODTtXe3ytbxnbiprMS18WayOr8wkjlxtbyir60qYRWy+22swdTjuuLIoeArN3AXm7AU3QXj2+T+V7huptpsYD0BWqvaEMD6nf+sAZP8erGTWoJL2HZlVKXjBhinRzhSVpxZ6VK3Fl1MqbXRjnTR5Wv5ndcjwclCDaW9LUJe64mjqUNeM3Vo4pFN0jAALsvYrz8rbSZc4nF/WQOLxuJCeoXZbbBIrFYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I6EiGfMFvZ7JTjYEb4dUmK++NX9unvVY5NCfGI0CW8=;
 b=WQt3EZvwPkkT8o3OqJnPy2swGiqce1YnoItFH9NonN1tol1Tt4+iQvoQafEwAVuASv1LCKDmAvHa9Bb6EkH+H8V4bHCcMOLTgz+JyOJDEBAsisigAI5IKg13c8saOcpxxcw/IHyU24+rpS1XemBRUm0xFB0Z4zg99be7+338eQA=
Received: from DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 by DB9PR04MB9257.eurprd04.prod.outlook.com (2603:10a6:10:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 03:34:39 +0000
Received: from DB9PR04MB9355.eurprd04.prod.outlook.com
 ([fe80::b3c1:52ad:772a:ce82]) by DB9PR04MB9355.eurprd04.prod.outlook.com
 ([fe80::b3c1:52ad:772a:ce82%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 03:34:39 +0000
From:   "S.J. Wang" <shengjiu.wang@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "andersson@kernel.org" <andersson@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "arnaud.pouliquen@st.com" <arnaud.pouliquen@st.com>,
        Hongxing Zhu <hongxing.zhu@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/5] retmoteproc: imx_dsp_rproc: Call of_node_put() on
 iteration error
Thread-Topic: [PATCH 5/5] retmoteproc: imx_dsp_rproc: Call of_node_put() on
 iteration error
Thread-Index: AQHZW6YQ5Fy2rWK450m9+8GGXUXYxA==
Date:   Tue, 21 Mar 2023 03:34:39 +0000
Message-ID: <DB9PR04MB9355AD6C01ED0A0B6E102996E3819@DB9PR04MB9355.eurprd04.prod.outlook.com>
References: <20230320221826.2728078-1-mathieu.poirier@linaro.org>
 <20230320221826.2728078-6-mathieu.poirier@linaro.org>
In-Reply-To: <20230320221826.2728078-6-mathieu.poirier@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9355:EE_|DB9PR04MB9257:EE_
x-ms-office365-filtering-correlation-id: 5f37645e-6a06-4152-d9c9-08db29bd3382
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VPZGFW9nUaxL3sFtPfFcSVmMinkhyX6xIiD26OFRsZ7PCZrtSXgQNCW3ZSvoLsR/PB3dqxANkjhbX3C+/TSfqLs+eeaPjZQqJS47QvzYYQU0XIf6aIFYtDjjw7fR8mr/MCXS69z4yHK+5NzQI0bLXHwEKPcv1VlCqTdPLoyMsF1hY50Vh3zjMGLXs631pTGIb8sM71AP9+aXkeisjYF/3pPUMp2H9Y/n/UT+tWk6vKbsiJIfn6zTwxC5Jzzchs917TG+y73wkqpWccbL9ZJ3243/81fD9psWvkUmzJ7ORaFp2CixEUENT6tBcFLv+X6hovYcoYcuD59jVsvvxZ0hSzBcuosro3NokUmyGMNgwZY12TlXB9R6Lo4GTS5HVgEZaf0IZxvx57cKlPPTkE3q0G26uxM687DawHIFoHL8QUqk6YLpTsMM6liGyxKJhaW56VdNMuNJNSpRcR//Sjaf3KbVX29QhRRjxdFU9dbt3eg5xr0u1wea7jIibNtVS2EaDVcAMGXOM7XZfRXA/mVAO7TT2c5kGCtdKV6qXXJFPD7mmUhpXV6653cH8ZGHcrUU2XuOfq9lkvwF3NfBY9TidEOB6PTKh9IU27+80q7JbffC2qcVjVOhNzo+Lazl0zQP75qTsZytuIRby3bSk/Ys/dBXEXM3lnJ6jj5e/+OaLfOASHKma+S9X4Mdy+teuyqAMplDPIWYlQQb3fvwr54vww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9355.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199018)(54906003)(71200400001)(7696005)(55016003)(110136005)(478600001)(26005)(66446008)(66476007)(4326008)(8676002)(76116006)(64756008)(66556008)(41300700001)(66946007)(6506007)(7416002)(83380400001)(5660300002)(52536014)(2906002)(9686003)(186003)(8936002)(316002)(38100700002)(33656002)(122000001)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?imDBmOSw38Puqptm/zY+fMoWJiDWj/UfjA966WQEVNcGsGC4896bDz6DP3iH?=
 =?us-ascii?Q?4fXkey5c1ZowfEZdJAX5TmBtIq5UukVjh0CMeqDYM2zOwWNhA47vHz9hH57d?=
 =?us-ascii?Q?taDVbTmYJbxR5eC/1/V21Z5htS5lk/3zA3WNUoH7XBAuW9WXpBijA6F5ciYw?=
 =?us-ascii?Q?kndMJUBP4p1eEk4McFRW02yPR/kIzVP+RIqI4rgneJa3r4rQQsYeD4oe+Tj+?=
 =?us-ascii?Q?FO+sJJCSn+tJEmCD4qjSc3NSJfdR4eoNp18b1pOHit/ehAdDqM8kaaa7WF3P?=
 =?us-ascii?Q?xjx/2wQTAejsM0UA6eag0d3fDvU7KIFhJFi1wT75t7VO8oVfJVfw9uMp9GrF?=
 =?us-ascii?Q?4OfJNPGCTvK1Sio2ylp7qfe+U6u1nsjXVQtAypF8U5RxaaaJVk4+WARdfY1f?=
 =?us-ascii?Q?px3RQDQb0z0BAf9qAMXpSob8z3vaqBkYh1k/FlGFkabHQjZz/Xkb4o0/ICmu?=
 =?us-ascii?Q?5Ir0RdHa7asMpCOLBgUVJOD85O51AaPpuiB1vLFS2K9RF5U/QsCJFy4Xl77q?=
 =?us-ascii?Q?TEYxvgyEYzDMd/ljvTMTn5aJuKnhc1PgCZHoNkNm5Yn5pVPD3szctT94l8Q2?=
 =?us-ascii?Q?YihhGiwkrnFJTv0RbWYCsQOC/0HazDWomt80/8DJ+ZsvczkE1PwN6jvpZ1Dr?=
 =?us-ascii?Q?xinvr8ELQ3Jb14sUb4nl7ILhvtqyyp403T2JCvVrRsTytdCOToslBNkdbecI?=
 =?us-ascii?Q?jn6nMe6i/WOUYUGkEJA4E2fo68Htwvjc6My+A6WyRMOEgo14IyrL9+u2Vu6Q?=
 =?us-ascii?Q?5CNheQmJDGAaccyEEUhnfVmLVLE9dZ0Z9QuBlsRvgIMzo6df4EqctWTtWcHi?=
 =?us-ascii?Q?uBtwzmiF9Y/RR6y8e6ue1Ty/XCdYlDfTdSGbws9WwfZxSEC4meChseepWwng?=
 =?us-ascii?Q?UHaFUpbhgivRAG53PjwTKNi/t6zodfs5cdLCo9zHB3mBFrjeNgUH1KKSmqNu?=
 =?us-ascii?Q?UmaVDjVUgPBhVnYLt6ChBZ+z/waZ2/nJlii27K3mM8kh5JwY9J42T7UsO8Q5?=
 =?us-ascii?Q?Wj6/HfZhoMIUYu1Pg9pssGQJO33iVuL7V+fzUADmmOkrZjBTm8MiBmeeqHGo?=
 =?us-ascii?Q?rDMQeltg48as3ScOXeQwhmo85Do2Urf5ImGnvDnJND1yJfcvZ3UfL8T66LNm?=
 =?us-ascii?Q?Cesegxdg8k9rGCJi2WD2RwevJUinqlashgda+w2mPMiaTdYsj63Yr58/Y/pf?=
 =?us-ascii?Q?QVy1eSc4VTkAXMfa5ISXhXZ+YYFon+SP7dOuvRgAtehCIX0Zx2Q/zUxPwhqZ?=
 =?us-ascii?Q?Ir8xQSnZfjcSgCSjjG+8g/s8bptA3V/kPRiKq9eEWj4GG+1wNno6GaeRIzyw?=
 =?us-ascii?Q?wqpE6fqEjGhwVsLddK+xk09lR94OGiTsXMsGNZfRIucMGYcOtpWzoPTPYgL5?=
 =?us-ascii?Q?UprLsvTf3As1ISnIvgXnTmzjs3gn86Dexdf5WzVYJ2uP5J9X4eF/VAyF1RNp?=
 =?us-ascii?Q?9K0vF6d9Uv81jwY4XznlIzEEIAjibM84TqtKkngt/yvPDvBPOvbpNhhI1BZJ?=
 =?us-ascii?Q?HuFJSF/maDbgUHgPISrmAXlOIzQsXKHIC4HhqOfIZ5CPiZCfxgNfttfFCNdg?=
 =?us-ascii?Q?FqjQLS7v5G76kQ/E7yrRJ1ZfzfQyOg1KMkCkzfix?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9355.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f37645e-6a06-4152-d9c9-08db29bd3382
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 03:34:39.2359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xh6eWs2oWus9Jhcwt7vQ+yywRlFBKakGExoQcM8KVpAsZ48U67jQNFXIfR5007P0D3dBrx1+s3+xdSpf9Wy+PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9257
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Function of_phandle_iterator_next() calls of_node_put() on the last
> device_node it iterated over, but when the loop exits prematurely it has =
to
> be called explicitly.
>=20
> Fixes: ec0e5549f358 ("remoteproc: imx_dsp_rproc: Add remoteproc driver
> for DSP on i.MX")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Wang Shengjiu
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c
> b/drivers/remoteproc/imx_dsp_rproc.c
> index b8f268d41773..21759d9e5b7b 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -650,15 +650,19 @@ static int imx_dsp_rproc_add_carveout(struct
> imx_dsp_rproc *priv)
>=20
>                 rmem =3D of_reserved_mem_lookup(it.node);
>                 if (!rmem) {
> +                       of_node_put(it.node);
>                         dev_err(dev, "unable to acquire memory-region\n")=
;
>                         return -EINVAL;
>                 }
>=20
> -               if (imx_dsp_rproc_sys_to_da(priv, rmem->base, rmem->size,=
 &da))
> +               if (imx_dsp_rproc_sys_to_da(priv, rmem->base, rmem->size,=
 &da))
> {
> +                       of_node_put(it.node);
>                         return -EINVAL;
> +               }
>=20
>                 cpu_addr =3D devm_ioremap_wc(dev, rmem->base, rmem->size)=
;
>                 if (!cpu_addr) {
> +                       of_node_put(it.node);
>                         dev_err(dev, "failed to map memory %p\n", &rmem->=
base);
>                         return -ENOMEM;
>                 }
> @@ -667,10 +671,12 @@ static int imx_dsp_rproc_add_carveout(struct
> imx_dsp_rproc *priv)
>                 mem =3D rproc_mem_entry_init(dev, (void __force *)cpu_add=
r,
> (dma_addr_t)rmem->base,
>                                            rmem->size, da, NULL, NULL, it=
.node->name);
>=20
> -               if (mem)
> +               if (mem) {
>                         rproc_coredump_add_segment(rproc, da, rmem->size)=
;
> -               else
> +               } else {
> +                       of_node_put(it.node);
>                         return -ENOMEM;
> +               }
>=20
>                 rproc_add_carveout(rproc, mem);
>         }
> --
> 2.25.1

