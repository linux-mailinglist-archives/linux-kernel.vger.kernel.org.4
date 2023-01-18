Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76327671330
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 06:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjARF0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 00:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjARFZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 00:25:30 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2089.outbound.protection.outlook.com [40.107.7.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3C65688E;
        Tue, 17 Jan 2023 21:25:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVcTh0pkaOE3HGIhylbKWyMuYUj2ynUXqLpu2IxcjnzvdVyJLIZd7PB1MQOF0ysDrpzo5yQ5xA3By1qdtLQg4833Z+nK9IGPLAf0SToyRdl1NvNolsPmL+rw95K/So+2fL7G0lsEYdR0Pzg2rXlBKvjoOR2NHlsvwYjuipLlNWB/8Q3xNn1dgKpl3yIQSTwmI4kGsea9xZ3Vh0Z+cmXd5ZedVI6sozEZLW0Z6C44PnNaopIXpT2IYW++zlc9vx/TpLFGPkQA5JkzqArzzlCux8jmFc1CIA3hEZsTQ/hIIsvtpMKiJCnDmDTyR2d/Q9d+g1d7PzSsjF88b1Spm89G6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LUojM4zNU45s16PMqyvXcc8+89jUMJMWdZpb3SDwn0=;
 b=DAacV2HTwnOdWaugXFXlAugYmO8SGjGLsEMEjRWN7EFWdJOEl5p/TprZlanURrcQGLshQkUlcVxRG3cfr/fL7GQDv8Kv1rvhJIKK4KUyoH33WZ69DGaZEc1BgygrJVtFu3xlC2osvXmkZL+8iOOr7ndvwlglJOORQvCbZqFmCMsSWOe9tR0leOk5XpV4RJyOg0OCo87B2GprLpgZO6+3tW1J9naPPEoENbt99cEdK99AQCIm2vYQlQyOdZkwOY0BU/ynn12ypnq7UWnTWEAayqvUAFV3sjDYdHmTm+dJldj1JpQOfGoD825/VvQTNjyXB78RNwTKNXd52Z8BkZ0I5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LUojM4zNU45s16PMqyvXcc8+89jUMJMWdZpb3SDwn0=;
 b=iIOFcUDHJsDdeGBYkmW51tAZkh8gss7PRgpjX6Wmx0PLPZFkzXVlXjsoTp6VOoZtR+clcUZNcKv1+JcZqzlSSZW9WcU/eoJc2gSI+LH7da3/nKs1DaSo6yKYF1U0hS1xLO/9rEAl8V/WRL1mq4IiGgHLbWLBHiewNYMLu5V3IBk=
Received: from DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 by AM9PR04MB8398.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 18 Jan
 2023 05:25:20 +0000
Received: from DB9PR04MB9355.eurprd04.prod.outlook.com
 ([fe80::be60:a10c:529:dce9]) by DB9PR04MB9355.eurprd04.prod.outlook.com
 ([fe80::be60:a10c:529:dce9%9]) with mapi id 15.20.5986.022; Wed, 18 Jan 2023
 05:25:20 +0000
From:   "S.J. Wang" <shengjiu.wang@nxp.com>
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: RE: [PATCH v3] remoteproc: imx_dsp_rproc: add module parameter to
 ignore ready flag from remote processor
Thread-Topic: [PATCH v3] remoteproc: imx_dsp_rproc: add module parameter to
 ignore ready flag from remote processor
Thread-Index: AQHZKmNw5Y66RDhEYUW5zYO335VDKq6jpRRw
Date:   Wed, 18 Jan 2023 05:25:19 +0000
Message-ID: <DB9PR04MB9355E69A6D75FDCB0143C877E3C79@DB9PR04MB9355.eurprd04.prod.outlook.com>
References: <20230117110357.15091-1-iuliana.prodan@oss.nxp.com>
In-Reply-To: <20230117110357.15091-1-iuliana.prodan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9355:EE_|AM9PR04MB8398:EE_
x-ms-office365-filtering-correlation-id: af69d20f-a1fa-4622-04ba-08daf9146429
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMBv0DQzlTES7PsVWF2crQc0F78uTaLkKYeKg8kDldw/dWzrZv9OJTHKcDB4i+I9OhoBnEpnpJrsAQRVkOpxf7HLrbHhbXQEFc9IUQlkfLfWkH72T/m+zAdffy42MQZW2Pxe1ziaBGLKyD0/yhiEcHThRNrYbHx3ZAHME1GRaDv2jJwscXZARVDopqnDOM5KAzvePFYK+gQ5FQ5dE2zszrXaqCLSul0lL3zBgTbSwaESbS8YIPGL8XPqMB2J/WdKpqBgrvFlJglm+LpGtzATZEkaw3Vowij8QQI5/yW1C5KwaCS/LDnmqQWcMVUaqf9dRB1AyoDn7w0SfpaZSlR3EVkeDlC64Q/oNfdAtWVFAsrl5e4R5NC/8lfyWuS7rQhG1Yi5L748IA6YnbOL57+N0xC57O+L/mPLaMZgwhuBd+W5Bu7HVgVoaMZwgM+aOU7EIo2AECOzFkdCLPKXcLXRDiQhefJxlqb1Hnh4fgXQzJLVagUtdjFalUPSjNbHKd8eQc/yS/MVLFR1c9gLfj1XhArmtBXHdw1hPIE4MPgABunjoUHd4vVidIMwB2osPutLY78By3KJCwSjsorCmtP3a60ZOJmuFfDdeel62ZFi0Bv3oAjLr468diOJSbvDALpGUP8Hj0lY8+txegWomoSOLvXlKFxjHubjs4JN/lje7p9OtUIKVd+ze2bPnMotRM9ydSk8UTPduaKN5fzgeeDSdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9355.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199015)(38070700005)(6636002)(55016003)(33656002)(110136005)(86362001)(316002)(54906003)(76116006)(66476007)(8676002)(66446008)(66946007)(26005)(9686003)(186003)(478600001)(66556008)(6506007)(64756008)(71200400001)(7696005)(38100700002)(41300700001)(122000001)(2906002)(5660300002)(52536014)(8936002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kUJN+mBaSix2e6Ef7YrclK9EnaSe4UR2lTDXk3hiL5Xh6p0w4UGJ2y1bQEQk?=
 =?us-ascii?Q?fx9E/+Ns7dzqFLJl8SbXXGtcWvPrQyw6ZWHb2qxh8oKurzv9jpTIbHb4MA3b?=
 =?us-ascii?Q?sf53FOUmuiiIYx3kehTw/am6EaihKQh29ZMGemnlO3LBXKOVv8SC7jk0LbmJ?=
 =?us-ascii?Q?hx6URV5jOB/sEhjGUs2o8PtlaNTWKgJ/RH6Z6oiQG6y+8ogakPLynZpvsPRt?=
 =?us-ascii?Q?RRcy/1HnPFH0X3nGqz7R0Ah2f6P/MWgTwK1CbM3pJ4AIIXrHXWQZBR7cXmfc?=
 =?us-ascii?Q?a8DptLUbS1+EmHN8jpVG/+06gHboqlxv/6RziDAb079q0imK6wPfqydyTiNn?=
 =?us-ascii?Q?zfdJzU6wTSSVSji1SirmG824NaiKAoBLgK+gtJkD5K4JZh2Aul0rST0gToKo?=
 =?us-ascii?Q?sNLgP7WxzVSb4DqmujrQfKuZUIxKJrWQnrux2z2dSx6edVNlhgFSgRMqGAh7?=
 =?us-ascii?Q?ZLagNFdb8rwESOBt+XQ/YjwL2geORYxvPHBvQuQ+PAaoA9Q6Ok2g2doLW7Sw?=
 =?us-ascii?Q?Tm0286b5+tdBxuWFCsXKoFHNDpr5mDcXQLCJSnKdasQoI2IqQosZJYc/Ymhs?=
 =?us-ascii?Q?YtBCBUGtZVqbaPIj1PrqonEpFpCntsLxW35ZjeByP7KMmgAu19v0ZaaeIbPL?=
 =?us-ascii?Q?FxrUm4r9RPr2ll8GFkqZvKz6NabNdzKsLYwVoIcZ2qkv8UrkvBiDApAISyAL?=
 =?us-ascii?Q?TCsWW+6hyUWbbRhdj2xkIqlMXUkYcO7vNmb/pZzE7k1TeTCkVneOSJYL/6k5?=
 =?us-ascii?Q?aq7dbk7CpNk07xWQOmILkNDpmAO3cSuq+2oFdZOvhnaOxW/GrzcOJtsINrSq?=
 =?us-ascii?Q?oGtL1TGCVTyr1hfWLAMKPNSns7mziGMGXNKIOakX4jrslP7g/Qx4jPZc1iOv?=
 =?us-ascii?Q?iPL7mKLD2epB4pmywdzaQF0uXnkyxGtvSWItkA4NwIFqx4Q8eug2Z/XZBFDP?=
 =?us-ascii?Q?oCiNx6W0LVTnpebh7ZaFks3qayXUjAmCYM0wpV9+Lg8SPPREwpDvIfSThkQ8?=
 =?us-ascii?Q?YRrGb2RVwUrnZMSpH5Hy8RyeQEP9HtsuCRikzjCVQR/fxqtnv3XSXGZnJnqP?=
 =?us-ascii?Q?YkCRkXyx4wq4McmrtLJ52n5RPVo5AviwZQ0sb3lncHunu/7Z16Wz1CZwNJ8H?=
 =?us-ascii?Q?gr/0qTK7fnrfYmLMYncyUm05tGsEZcapxvjsY3T+bk605Blo001LRy86yhUJ?=
 =?us-ascii?Q?S2EQHPimPSqnwJkqnG0y2tHsS6NYI/QRorkerglKdnpaHhBV9uA6goNXsGfW?=
 =?us-ascii?Q?4XEsT9bEzzjvvLOGGhbwvwdq1BKCNNKE53mx1s/FJ/9dnvE2Z8eI4PpVfAhC?=
 =?us-ascii?Q?pAgQy/IVbDZwtOHtq4wFIKzSg9AZNEa4y83d2L1InZnUAKjUcrqp6yE/IVEO?=
 =?us-ascii?Q?rLMs5WMuN88jWRqFi4poRC9ZFNdwH1Osyb9ad6tvzyb6ZRHv6M5qaiRGPoSh?=
 =?us-ascii?Q?ZUIGr+WPhL9td+5gYsTMUmg8Rvdk55dEWBLL99EZvEw2tlc9WGodLPQMXtno?=
 =?us-ascii?Q?4KQZczland1euuXnVe5Q5z6SmVzFE0ZV/X+jo4ZrLUDe2z4ZYdEDpZVT1j8e?=
 =?us-ascii?Q?lLJe0oGgc1Wo1PB5m1TF/17dP+D0K/e2bGpiE08C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9355.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af69d20f-a1fa-4622-04ba-08daf9146429
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 05:25:20.1105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Nb7oBEoevV+xieeir1set4sipMDELzEqhATZP7stMAWQ56Py40x6vQWdLLn+30CXx7u2KqG0/A2UrqEw5n8RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8398
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> There are cases when we want to test a simple "hello world"
> application on the DSP and we don't have IPC between the cores.
> Therefore, skip the wait for remote processor to start.
>=20
> Added "ignore_dsp_ready" flag while inserting the module to ignore remote
> processor reply after start.
> By default, this is off - do not ignore reply from rproc.
>=20
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Wang Shengjiu
>=20
> ---
> Changes since v2
> - s/ignoreready/ignore_dsp_ready
>=20
> Changes since v1
> - change BIT(31) to BIT(1) for REMOTE_SKIP_WAIT
>=20
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c
> b/drivers/remoteproc/imx_dsp_rproc.c
> index 95da1cbefacf..22e2ef068c67 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -26,9 +26,20 @@
>  #include "remoteproc_elf_helpers.h"
>  #include "remoteproc_internal.h"
>=20
> +#define IMX_DSP_IGNORE_REMOTE_READY		0
> +
> +/*
> + * Module parameters
> + */
> +static unsigned int imx_dsp_rproc_ignore_ready =3D
> +IMX_DSP_IGNORE_REMOTE_READY;
> module_param_named(ignore_dsp_ready,
> +imx_dsp_rproc_ignore_ready, int, 0644);
> MODULE_PARM_DESC(ignore_dsp_ready,
> +		 "Ignore remote proc reply after start, default is 0 (off).");
> +
>  #define DSP_RPROC_CLK_MAX			5
>=20
>  #define REMOTE_IS_READY				BIT(0)
> +#define REMOTE_SKIP_WAIT			BIT(1)
>  #define REMOTE_READY_WAIT_MAX_RETRIES		500
>=20
>  /* att flags */
> @@ -285,6 +296,9 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
>  	if (!priv->rxdb_ch)
>  		return 0;
>=20
> +	if (priv->flags & REMOTE_SKIP_WAIT)
> +		return 0;
> +
>  	for (i =3D 0; i < REMOTE_READY_WAIT_MAX_RETRIES; i++) {
>  		if (priv->flags & REMOTE_IS_READY)
>  			return 0;
> @@ -903,6 +917,9 @@ static int imx_dsp_rproc_probe(struct
> platform_device *pdev)
>  	priv->rproc =3D rproc;
>  	priv->dsp_dcfg =3D dsp_dcfg;
>=20
> +	if (imx_dsp_rproc_ignore_ready)
> +		priv->flags |=3D REMOTE_SKIP_WAIT;
> +
>  	dev_set_drvdata(dev, rproc);
>=20
>  	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
> --
> 2.17.1

