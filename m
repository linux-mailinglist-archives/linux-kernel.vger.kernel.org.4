Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDE25ED9FF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiI1KWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiI1KWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:22:40 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DAE326DA;
        Wed, 28 Sep 2022 03:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpm6xA0/ClgcLme60RuTbngA61iTSiFeyWSmP5iDEYUQd0IhEsObI2opzGgIR/T4UZWahifeMsWRznNA6S59h8WNJhSUZX86E8Q8J58H6SzofLL9GXh+02ZizoAD1POj5jHT6pnQShsD9ee3w/Lhy4skDVa/67N0CNerWbERuWZxlVk6bb+AOl8z067YJpt+AUWFWmIP8TWgARU0WgDlL1LX38lmgPiqW1heSOxTADrLBIK6fABMohVNNsPDSOB5dOQLG/oGMPRuMQeJ53SxWpXIRLJQOwL/27250Xc23iK906n95MXPAsSEWd1U0qamcC2HdzrwSNBTfHWthgn4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZzWxUimcJ70X/P5Iiukm9N43IhxFFwstTz88wE34/A=;
 b=MRaTF83ZguOoPXwiNfnvPDrSJ2wayRQMTGEDQmhL7PFoVFr4NxDPUAgtvNfo4mtzMIQjpq8+Gcr8ecsEmXN1WrSxSahezox/DLY48hHvuh7enR0DWKkdkftr7WWkIQbnbmBKQqZt2hHG0Zztn+5K6leuDnaGXcLAMMcSAYrT4i2yWerFDN+wFIudgs94a6RUstNGMWcvgWrI9WtJ6LVLyFTPXaUQeB0w/7d/mUFkvzYciHZjkSG9BFJuKzyaCE2oh49zFNWpgzW4HRMKx7kv+bnVzn+rToo91FnaMh3vJahAThidrv/98JQ/BHTI/X1FMuUEcBWBmmeXFDtxZLRi1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZzWxUimcJ70X/P5Iiukm9N43IhxFFwstTz88wE34/A=;
 b=np/6cOvqmmTk18zYOlYa5LtqJDa+ZD9RvrEJsd1aOnJb7rDXdEswJ/t3n4X5sUs3MQAieb4nF21OL7EHzr1kBwSdAfDPpNf6bSFCEy7h3cUeCkU6SgETBX2q2XIfdree8um7FJTjDJCo19PwGPZ7+BVRQHiQvjGWAnd0Poj1yqA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8177.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 10:22:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 10:22:33 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>
Subject: RE: [PATCH] remoteproc: imx_dsp_rproc: Add mutex protection for
 workqueue
Thread-Topic: [PATCH] remoteproc: imx_dsp_rproc: Add mutex protection for
 workqueue
Thread-Index: AQHY0a9PUexT6xrsH0SQuEOAj4mH/K30o4tA
Date:   Wed, 28 Sep 2022 10:22:32 +0000
Message-ID: <DU0PR04MB9417A858260FFB3E0A00CC1788549@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <1664192893-14487-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1664192893-14487-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8177:EE_
x-ms-office365-filtering-correlation-id: 3a62ebc5-a0ed-4b68-ae17-08daa13b5b10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x0eHhmHx+zCsYFW6Xh5zxmhZCO6VxhFJFJ3exLi8d7PamWPcB5+GO5fvcdkJtBXcW/U/2MrYow/Mq3/YyNgxJiCUJO/1eo2/vKeQIeFDTJcZXCfw8QfhhTeBKhz8Ughfw5qGYEMQnX7sE+qlj3+9nnyqDBZvinqUV1ukb4ISg3WZF+U2v70jCgk2NEhjL7/Da6zB4y92eTCB0+NQt2cxieolZT/WuG39VW9/r+DIkTBr+aTNVWdcqsdN2LuzlIJb05LSSqp2JH3EOgJCc4rSlRYG/04OhR4MzoKSNfrEIpI8ux3fYpzQPRadPgYhYq2fq9XBmWd5x/kLyACx+g+dMLd8wCao+ZD+XdC2iA3ktilJIosABMTkgaD0BwlSVXRDS3MJOZ4V6e2KLojDovvS7gRHsqs2TJP1c2lIMYfHLwWvWZCwpIR7zGZ/y7kIi2qSK2Xsj31YIQjvugBVCvPcZjbf0WfGWf/qMzmCn49TWwb+IRfkWRBngEUMqSm10bbklvvcfZkS2aqHA3PrtHXUrg/fC46tGpjTYvufOddLpFqaUqJBtQf4ByhZ/3aqbTfzoZpLB92SKZQV8Y7l8JQVReNavpQD2stvoxc9ex4ei3aM+zm/BX+5AlXy+vksKyMwBN9Z8j+KVbt49EwUX/pgJhzYgzAZeUFFtSlBuAWZonDr45uVF4ap879ZcMgQF5GcudIzWHsiHf/hNw7SYzcxOktnpYhtCZiDHM7NCnL52WupiNxVGCX6gWUT4zAN+1NPCAPrUqGPVz0ZD8fbetkgqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199015)(83380400001)(38100700002)(186003)(38070700005)(122000001)(44832011)(2906002)(8936002)(5660300002)(41300700001)(52536014)(55016003)(9686003)(478600001)(71200400001)(76116006)(26005)(7696005)(66556008)(4326008)(66446008)(66476007)(6506007)(8676002)(64756008)(66946007)(110136005)(54906003)(33656002)(316002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ggN2iMtJ5Ll/8Vh6KMp2Aq3IeTNrA3c8vBQW5kiIQnYQkrABs6E1aeEVwYcG?=
 =?us-ascii?Q?ZKHlUe1O0h+92gFaVx5W02/8qrYo746FRIPUiuhjnpwnN2+kym8uHKy0AjXp?=
 =?us-ascii?Q?cc5HZ4UdG2JuWvE5Xt+HGBb5ygki9h3AybHrZc7qqQmsjqQnOuYCOMFDlx8j?=
 =?us-ascii?Q?E7Qv+P4lCgP88wsA+czAYKPdaGfXYdfnhKBqOEW5ZmC61uPUkRIMhhg6Sw10?=
 =?us-ascii?Q?JzUfpGaDSkxiPIwbJrEezgxeq7JhHqgCFPfTfmk+s17PPD2Npjn1aVWyDMlT?=
 =?us-ascii?Q?kaHI5tKR0CPabSq++wisl03S9ObccTRwBngfzmZ+14buNywJZy2jXjWRzISY?=
 =?us-ascii?Q?y25T09XJwaHUrkCNRf/6U5/AqCiMVkpmq3uKLqCGe9j2htgN6NNWni6xoRwM?=
 =?us-ascii?Q?kUKzrJGWRjnzNDr45e/gnYXffmBwcmDb7Lk4CqwE2RGJpQchLk1GTv1UOK8n?=
 =?us-ascii?Q?+Ex+z41mP/aR1VDT02/8YYW+hf+NCoThp9jP5PyXuxeQBoxOFykojiOzt0Ui?=
 =?us-ascii?Q?WQfH9NU/We2Nj72sXP6VpnNmT2KKYx0LQu53Sf0wSkHPmEKyHR/f+R9aIe1a?=
 =?us-ascii?Q?opTea+d+p1gGuEo6eBBBaQZaathpQtbBaDue9xSwv2PFziJ1w4UZSzsy6GLf?=
 =?us-ascii?Q?tWsjETIpc/qK7rixFbN/6I1i672c/hb0+2O9vpEwIwhZzJoCaNIvzwtwogVA?=
 =?us-ascii?Q?1FQf5fsKpja8lDcn9V+s3vEDmRf5+bscDt7gpNfSf8MSo7ywqht1K7qNzOHY?=
 =?us-ascii?Q?Nj9eOwrgnhUuCtO3rtW5k+wejNOPlXkYMveXvyaSFATWIHin7Lujmj91wnoU?=
 =?us-ascii?Q?kBXVd20etPGG1ERUAAGq7dgM1eIK+fNeEJr2722Fg13JSgo5Chzg2Opk8uLh?=
 =?us-ascii?Q?tpKdLyNPZd59R0pfxVmDjuIJTXfn0I81rwp5Ub7Sx4AS512QgbzB7B0ZP9Um?=
 =?us-ascii?Q?Rc2UUDjnJIL43R6JaCOSEcy9mbAfh9+O/jvucdD84tMk+XoRRRqPNbjLbqiQ?=
 =?us-ascii?Q?eQZbTlatsKUgCzlXaKwf1CYqVln/hVkrD7pq05l86hzZTWxsP8xpg1KHbTWq?=
 =?us-ascii?Q?4VisdJnJHmEJzP9vessJL4eEOYI0s4mHB/w3NCprfjq/aRAB8b7UODJojkFG?=
 =?us-ascii?Q?ttNL1+SkxKYBWQGI3Fg3+qtdrZxFHZMywVtiVkCzAD8B4kZ4OkvobF7FHMgC?=
 =?us-ascii?Q?5phGRI5MKmPUvDlH3xFWJfkhSJ8jquYKrCm2V0bYbUd/RosL3KbHyHMFw/5P?=
 =?us-ascii?Q?jWPy1kxex6WeIzIa8taEd2+6eV6cFhmlhKRkWTGTgUo7vkBUqnqC7MnwZK2/?=
 =?us-ascii?Q?teg8fFf8SydkmQMy1th3IZL+I629lTu0F1fkOa1fGP3EmFWvfHD5X67679pW?=
 =?us-ascii?Q?zxSpGmoSRxTizZ9lhH38bxRZyovQ0KmUfouhWbmiWmfZEfCzEmUxPjGXADTf?=
 =?us-ascii?Q?jtNP3vSqRGCwuCTkHMv41EOiwMq2JI7iHTe+L30NQbToYg3D83Wrhs4sPUbD?=
 =?us-ascii?Q?50SGuSuA8Q2aevtOWRada8x/UF6CqTQ35DWRSX/CJK2ML8zjJAco1wKuqrcd?=
 =?us-ascii?Q?h60L4S8SJiNmg4U4K/9cIS0alJaHI40hw0iJ7V0i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a62ebc5-a0ed-4b68-ae17-08daa13b5b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 10:22:32.8996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +++RiLDaFccDTc2XRjJzHLwwm6o/K6Q7lf7Wu3ziKh/IDbC2RxO5z1IuNBIKqiOrYFEEiX2zDFRlW7i+nFBRDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] remoteproc: imx_dsp_rproc: Add mutex protection for
> workqueue
>=20
> The workqueue may execute late even after remoteproc is stopped or
> stopping, some resources (rpmsg device and endpoint) have been released
> in rproc_stop_subdevices(), then rproc_vq_interrupt() access these
> resources will cause kennel dump.
>=20
> Call trace:
>  virtqueue_add_split+0x1ac/0x560
>  virtqueue_add_inbuf+0x4c/0x60
>  rpmsg_recv_done+0x15c/0x294
>  vring_interrupt+0x6c/0xa4
>  rproc_vq_interrupt+0x30/0x50
>  imx_dsp_rproc_vq_work+0x24/0x40 [imx_dsp_rproc]
>  process_one_work+0x1d0/0x354
>  worker_thread+0x13c/0x470
>  kthread+0x154/0x160
>  ret_from_fork+0x10/0x20
>=20
> Add mutex protection in imx_dsp_rproc_vq_work(), if the state is not
> running, then just skip calling rproc_vq_interrupt().
>=20
> Also the flush workqueue operation can't be added in rproc stop for same
> reason.
>=20
> Fixes: ec0e5549f358 ("remoteproc: imx_dsp_rproc: Add remoteproc driver
> for DSP on i.MX")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

I also give a look at other drivers, seems almost all drivers use rproc_vq_=
interrupt
has same issue, should use mutex to protect the mbox rx callback.

Regards,
Peng.

> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c
> b/drivers/remoteproc/imx_dsp_rproc.c
> index 899aa8dd12f0..95da1cbefacf 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -347,9 +347,6 @@ static int imx_dsp_rproc_stop(struct rproc *rproc)
>  	struct device *dev =3D rproc->dev.parent;
>  	int ret =3D 0;
>=20
> -	/* Make sure work is finished */
> -	flush_work(&priv->rproc_work);
> -
>  	if (rproc->state =3D=3D RPROC_CRASHED) {
>  		priv->flags &=3D ~REMOTE_IS_READY;
>  		return 0;
> @@ -432,9 +429,18 @@ static void imx_dsp_rproc_vq_work(struct
> work_struct *work)  {
>  	struct imx_dsp_rproc *priv =3D container_of(work, struct
> imx_dsp_rproc,
>  						  rproc_work);
> +	struct rproc *rproc =3D priv->rproc;
> +
> +	mutex_lock(&rproc->lock);
> +
> +	if (rproc->state !=3D RPROC_RUNNING)
> +		goto unlock_mutex;
>=20
>  	rproc_vq_interrupt(priv->rproc, 0);
>  	rproc_vq_interrupt(priv->rproc, 1);
> +
> +unlock_mutex:
> +	mutex_unlock(&rproc->lock);
>  }
>=20
>  /**
> --
> 2.34.1

