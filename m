Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EE366D704
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjAQHg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjAQHgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:36:52 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844C6A24B;
        Mon, 16 Jan 2023 23:36:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7AsnrYjHu5WsOXoG2ouoFBdmXRxjgM69zao/UC/Id5B9v3B+xuw8VYxqiWp8aKBPrl07RnYguDflK7gsZyCsaYJHcLNBYmU8CbEzvMLXXlDXTmqsRsfVOH1muGSkr9M4dnEFXJfXqi23U+VvixnLo2gWs+XiQJu5PSp7tJ2I9mSnV0spln5EdUXeV7CeniDJzBjkhG8sByA+lAZhKdzkCrmOaI5fH8BLda8rT2HIO6BJlAV26EnTIons3is4ULI9DUoqA+TQxzSFt1drA+slTZZGx2rbL+v02ZzccOn6MW4X1TmurDmOTNCSxD5R92ILHFnw70DTXrhqbKjQ895SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaXhGcQ5hgdruNqH4YMmyHymaSxyZU6H9GGA1HVPvIY=;
 b=dlCWqvOWDScGoJdsiL/riOapO7yBLvEwYePb4hLY5e2TE3wN8OHVuW61QVpieXwOGgFdXWYHi2TIma7dqqGAVGwq+JwqZVfIGQnch77NFBFWrziyMCzrCD+6XP9AhiTFDoXVwJ0CdcpWI5NxJv2GvFq/q15AlK2/zCqsEUKllW6FhUWc4HFV4AmWFosRntmYfOwpyjtHBttjTThzZ7yjD7KHU6lDm7NbxAeDhqF+77qMS7sdl68Pgo3zi3NadWfGQB2P83TaAXqh4rkOvyZ60dFZCExMf5YHlmhPuYu8KqA8RqrEDYuSEsgD335RGPyTJVezl8ETDw7cl8jiSxMRiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaXhGcQ5hgdruNqH4YMmyHymaSxyZU6H9GGA1HVPvIY=;
 b=VWlg1x3mDM3AA4hdTNteTSBRqUXamWk6Z4iFxhD+RhU+bqps5nGMwGnLB917ZmBs01swyzN8ny6s9c3ANnEBXLiwt6VmnLcx1pZXsiNew5Jk94Nc+FU6s1pcGAMpbif7C8zhgwp2fCIIAt/DYlf/xIlWlUK6BkXCzUXxj32WkRU=
Received: from DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 by PAXPR04MB8457.eurprd04.prod.outlook.com (2603:10a6:102:1d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 07:36:47 +0000
Received: from DB9PR04MB9355.eurprd04.prod.outlook.com
 ([fe80::be60:a10c:529:dce9]) by DB9PR04MB9355.eurprd04.prod.outlook.com
 ([fe80::be60:a10c:529:dce9%9]) with mapi id 15.20.5986.022; Tue, 17 Jan 2023
 07:36:47 +0000
From:   "S.J. Wang" <shengjiu.wang@nxp.com>
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        SOF-Team <sof-team@msteams.nxp.com>,
        MPU AUDIOSW-AUDIOSW <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: RE: [PATCH] remoteproc: imx_dsp_rproc: add module parameter to ignore
 ready flag from remote processor
Thread-Topic: [PATCH] remoteproc: imx_dsp_rproc: add module parameter to
 ignore ready flag from remote processor
Thread-Index: AQHZKf14CghgbIrDOUyXQHWXGPt9Ha6iLbIQ
Date:   Tue, 17 Jan 2023 07:36:47 +0000
Message-ID: <DB9PR04MB935597568D763916CA4ECA13E3C69@DB9PR04MB9355.eurprd04.prod.outlook.com>
References: <20230116225343.26336-1-iuliana.prodan@oss.nxp.com>
In-Reply-To: <20230116225343.26336-1-iuliana.prodan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9355:EE_|PAXPR04MB8457:EE_
x-ms-office365-filtering-correlation-id: f869d8a3-b32b-4d27-3481-08daf85d9716
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Shqw4ChwkmSdrO6L5I5s/JghKgecPjw7hE3ZvJ7umryRG75grUG0WLHaOWziwKUKNTO7RMs5YDKD4oeFCea3atjNR3rZAavDhwooSlk0KcFGrYi76+7MobA1X9apqW3rt6HFfbhb8cjnbCSslWKuyE9ZSOaKIsc4zf6f2ZpdLz2hLbxf+w9GoJbaEvzNMsksnq9Hx2/Av2rZCy81k/2D//wvb8VT5z3ueQoS98V10UC1X3M0g+EjrfLB5l14tQqwPJ/HZk28x+sUqWRX2lJGYdO9faDS3L4YpZDmULXUsj4y6f5GQcsKxK7oGKLOW2PkKheQZzXtrkkhC5T4XNOboJhWnIT1+ia3BindB8UnnnA8rj3s6utHJTjU+roPRNmHBsak7FdiXMrk8rsc2I9KB9utCSBkhlGfx+QDEGUPgQuJWvHxg17Urcl9t01kJ1j76/3DKFiXIkj4UcQgJPN13dWmJa44iGE93B9t0Mj55fGV+W32zrNnQiQyXBiS4xZ0BdU6geUnodVeG4C0o8lFwPap2emQkPda06xmtCEBut+mzfmUE2EWEMBikUk2vZHfbVAH0sFKiFwvyLrNTrWLPPTtTUWhVJXt2u/qv+WSqa9Z4WnQ4YIndzdni5NbmUl+Wdy4AfvbLyt4DlWzNAvfEnsTY0jIHsTzEUjsqu2scKUkBdu2m/aK5TEDitZAKB+0R7DMQg9lDWNmzp5bGTtpjLoP2f6Sk/9/BWHvq+On2aM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9355.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199015)(38100700002)(86362001)(921005)(38070700005)(55016003)(8676002)(76116006)(66556008)(52536014)(4326008)(64756008)(66476007)(66946007)(66446008)(2906002)(8936002)(5660300002)(83380400001)(33656002)(122000001)(478600001)(7696005)(71200400001)(110136005)(54906003)(6636002)(316002)(41300700001)(9686003)(26005)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UKzHkcyp1Y0mu5o9EIV81dy6S1N94+aWZMysNpUfEEldF5mDGb9TxwUdVK4K?=
 =?us-ascii?Q?+kavJO2xXWaDqo4BrI0kiFEwKnxjkYvp6T7NzuSF2gOBperwvrXyYV00EVT4?=
 =?us-ascii?Q?7CY2ns+lllyBs/OE18x9An1wAbHDjEl/vKQbfbYv1BAHOrE4t+2ehEjtQszt?=
 =?us-ascii?Q?TPQ9C6gh+O+/a7QUFJSfWQSfaADeJAHBOPFAhhg1erk5kQRG6bc4oSl3pcM0?=
 =?us-ascii?Q?kqq32jxXhF6Fk5dpqmS7mqCPLpMCSrxhutBfg+4ksnvbIdX/zhmhgX8k43Hz?=
 =?us-ascii?Q?/u1CBm+BaZGNlXM2KbJF+552GeWjxQkCcYQnKv4xwvok4L4XTsl5E2sFqqfD?=
 =?us-ascii?Q?GuzaV0ugMGnQc449w9NZZENNx+qzumZazJSRAeTq72OA1dEzOOR51nIoVF6f?=
 =?us-ascii?Q?T3vNR/EkDnkJKVfvyZ7z879cEhZfySSYtu6M+Ejm+3zb/bC8i3EjuxLtsGCE?=
 =?us-ascii?Q?qAkE/YJcR/2YycQiR+/1R6Fg42ecl2sW4jngaNq6kzmpIxlioFxwbDrkvzH2?=
 =?us-ascii?Q?S6jXnhjkxVf5YXC6o1zy25YlrUAU+bHXsJwcvvs0PQ6YD5ame4ECEcevck2N?=
 =?us-ascii?Q?+QUBqfIRv+Vg5K8aV1w8lHDG2YvR/wJifrAlumhlwqVwOFx3Gu88IdUytqxF?=
 =?us-ascii?Q?lNvInuNl2KXrw1pjsAr6oe7hweN8KEknsL35IgFpI3xKDKBLbRHe1ADe+i45?=
 =?us-ascii?Q?zpVNCTAjMdmKJVbXI1zmEdOEwjBo3cTt1+jSy/9SJ0Nmq2SzP1cEOBYXHOp1?=
 =?us-ascii?Q?n9kLw9UF/5VvPNCwb/WOfHKYWEW2kfJZtqbevVePYQ1qmCoR3ThXhuUI3d/j?=
 =?us-ascii?Q?Mns6TVjymyq4VmjyS3zTK0IFSM38MRkhLX43VIHvpSAyV2j5zzw7FErFZ5F2?=
 =?us-ascii?Q?MRMt5+Opi0yTQfjAb+yV449dCdf1ChaDG2kWwQ951QXBjcoojXI13BRhG4BT?=
 =?us-ascii?Q?Yr0NQvDTilU0wkQCt2ANs0VINcyRjmOdv83eEzI2uayRVdEI9L7HALgpNfKm?=
 =?us-ascii?Q?jmJNu4O453uKzYqWf1YpaR0xcadNIvWgaIZlcvUm8XDLeIY35AbrHsIDy9IR?=
 =?us-ascii?Q?rITC1rpZvRPq10S6hp1zwHjBDa8/YXrJPUbvyW2Dy10cg7A1y1MnQtHE+/Zc?=
 =?us-ascii?Q?/ffEElmGv21X6HHg2O0cVrjgUiEKLQho27xq+0DiRfXtcmkGYOfjQztc0MFC?=
 =?us-ascii?Q?+ciKkeY6E6+/f1JNvJlkdu454bnqANJ/Cxjk+8+TikUK5qXbZQRtFrJduDyb?=
 =?us-ascii?Q?tWKk9YtX6FAC6ryXxJQC7OzuHzidbTiomIqS8PE0DZ3AvuGsZAxUC9uFpc58?=
 =?us-ascii?Q?saXovYPYwgmB5ez6LnB4kNVmXHXf9IuNDP4hIgLk4qPjvj0bJ5mPE6SffG+5?=
 =?us-ascii?Q?e4lrfJ6GtB8iIBRP1uSYnCqazTheiq5r23d9HKbHZ/U9jwJ0jTa2GzDh7Xkx?=
 =?us-ascii?Q?6XzcE2GJ3IWDuwUhBFZXeo+XWLYu8WWXq/Be3i7sk1BsVE1cElvlmfEdWKyW?=
 =?us-ascii?Q?u6ILuXzvMJ6fLDxJbzAhsxV769eDD2gWIoZmobvL0qQU99uV6QjdHK9vQ+5d?=
 =?us-ascii?Q?TtM/pCcbm4UwewWuVB9ZgzYcCuI08XQjWUOuMxzG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9355.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f869d8a3-b32b-4d27-3481-08daf85d9716
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 07:36:47.6495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mWbklB+axDQ7wmrWfsCn/BPdm/GKxU+Aou2u+wgewSxhDwjC5cWhc3/NmKxj1vGd3zawBXR4OAgBsHapsQJNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8457
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
> Added "ignoreready" flag while inserting the module to ignore remote
> processor reply after start.
> By default, this is off - do not ignore reply from rproc.
>=20
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c
> b/drivers/remoteproc/imx_dsp_rproc.c
> index 95da1cbefacf..ec298f8b019f 100644
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
> +static unsigned int imx_dsp_rproc_ignoreready =3D
> +IMX_DSP_IGNORE_REMOTE_READY; module_param_named(ignoreready,
> +imx_dsp_rproc_ignoreready, int, 0644); MODULE_PARM_DESC(ignoreready,
> +		 "Ignore remote proc reply after start, default is 0 (off).");
> +
>  #define DSP_RPROC_CLK_MAX			5
>=20
>  #define REMOTE_IS_READY				BIT(0)
> +#define REMOTE_SKIP_WAIT			BIT(31)

Can we use a close bit with REMOTE_IS_READY,  like BIT(1)?

Best regards
Wang Shengjiu

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
> +	if (imx_dsp_rproc_ignoreready)
> +		priv->flags |=3D REMOTE_SKIP_WAIT;
> +
>  	dev_set_drvdata(dev, rproc);
>=20
>  	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
> --
> 2.17.1

