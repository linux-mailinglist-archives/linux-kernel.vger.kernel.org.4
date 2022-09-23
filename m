Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2CD5E7487
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIWHF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIWHF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:05:26 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D946D9E8B7;
        Fri, 23 Sep 2022 00:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxNdyWbyjAVLL2+u87DoobHWsaSUVdIuwKGakYIFvcge13mFEQ0kahzodZcA2/GnxkK2p/ylfz9GLPTSqdSaVLkaEz8D8qmhIDTjg3CaSLo44R8qjdEzJAb1/DAB4prTpXT2X0GIiVNbgKEqDZJ+dWRiMy/NuOK0ejMxO0wdgAphgIYKZzPGLMSxX0yJcvfX77hvBobMXtTDyL2OdPUaUSuEMedd/GWN9qbo8YQO4FMm+eOzpkdlWjcsIkVbVev5Lv+ru6alEkfVssPKZalujsoxKhq304Xo1jxALbtliGMu/L/pGq5Ja+u7kO7nYeaE1HPKpLM2NnMROS8fEhMI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTAnJt/pcwlPm+cImB83ZvyftY2TQmc4r0kASuQyq4E=;
 b=T+EZ0yf9CMUIZkGeJQRbji1l8LxLsmhhpAi0Z6dL+rjrF4Qd2Ht6lksBo84Q9mj72n1JsGwdeAIllgyyEMKXRIU2rVYvxbqmXn3lAEhAD3l0X2OvOXmEEs+rXvyagkKX8FUmkViXmf1MtCzIk2fp2mPNA9TBb5t22Iu22mA/ENh1eTrxa+U/9TbkYehh0lS8TUMC/5bul3mpyGENbcG1hyfg3Txe1j5v6Me/N1J0ncp+9Vj2K/xkGjfQCLXBfNTjudtBWwbdKMhVw7mwW8A89xFgZlikcTFk0+HQnyUeZv6mOGUkdCMA/O5NEwKMSxxi1uKP8ara0O2gPHCbAnVo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTAnJt/pcwlPm+cImB83ZvyftY2TQmc4r0kASuQyq4E=;
 b=dd3FMw2r9RtNvre8W/ifdAmfuxW3p8voTza/po+5/EGAJZxBouEGifbrpKPKVI9mMxd2zxvVP6QBNrD09SNMVFuHDQQHfTNzY3T5zougILrvrmBnxBJUJH2gMXRh3S+CdulsRL8nSWsHiGb1uDhKfe/i/qlUtKvAngotGpYpfgw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9084.eurprd04.prod.outlook.com (2603:10a6:10:2f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 23 Sep
 2022 07:05:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.018; Fri, 23 Sep 2022
 07:05:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: RE: [PATCH v1 2/3] remoteproc: qcom: q6v5: Do not report crash if SSR
 is disabled
Thread-Topic: [PATCH v1 2/3] remoteproc: qcom: q6v5: Do not report crash if
 SSR is disabled
Thread-Index: AQHYxrysWY3viP99vUe/cqDy0C4uGK3sqDFA
Date:   Fri, 23 Sep 2022 07:05:19 +0000
Message-ID: <DU0PR04MB9417DA4FD12B3C9A1D6054B988519@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <cover.1662995608.git.quic_gokukris@quicinc.com>
 <1a548f4e7373c12159f8d866dc0e12d224460036.1662995608.git.quic_gokukris@quicinc.com>
In-Reply-To: <1a548f4e7373c12159f8d866dc0e12d224460036.1662995608.git.quic_gokukris@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB9084:EE_
x-ms-office365-filtering-correlation-id: 7e07824f-af6b-403a-a5a6-08da9d31fa00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ibEk6JRoeFV6fxVA/n0pZSY9GXJupiB9eU6MGBAx+g1X4rzclZ0tlL1XI8DkYQPFsd9IKi0r5+hMRmgXwpR0whooRlyjULNuN3tuSy5NK/6XqrLXPxkEImMJh/AJUHWp/AUzJ0YvfUyYl/ez8+THCXENBwuneyLt1dWUsGJAhxudbRTPMvsT3vTrd6YD6bqbiSmamU6zk/BylWg9m+/CSdd7O46bOxiz/kEE24aPNpXdyi1SLjVMKXWTo0BNELs9AULGFYW0eJmvHPstphHXa/psITXOhRj3GN4l0O9f6ToB27tkUFu3ovxQB/gkrXUIdfyEVdIBFfdBhXEtK+Ewa1QpevkbcywN2KREn8RzYB4zWWl8ZWx28mc+/bIGARwUy53LdcMo55UkcrS7roLtds53zN1tHTj/uRIVzb0sfxpgPefuTTHKYiG2w0w3NIiwXKaOWdP1xuJfTQc31mFUEQVfnwB9UFRcVQnHdtft+YI8EWRCyIsGs2Z66nIcJyxH16rffqOsqgYs1w8wJJbT17LaLIE+/+KhmuwQZUnu3vwOQvITeOO+zAHtSnmx3ZxwYIb4Q50Q1cWF5GbC0UEGWEVt6MTUOY57k8X0nVtY7tzmPa8X21xdDIJffbxBJxY3ldfxmHrAznJafys04I9y1I3mpL/MaCZSY6A3xU7X5G7BakQ6s/LzKvpyKmdOxrh53xKCrclTpc0w66Xxyy/B8htvnn9sxP0oagfvHkoZj5AfnYCQ0jEIIy1qWUuAt4787nqGs66jXEEknV7Jp8AcEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199015)(66946007)(8936002)(38100700002)(66476007)(66556008)(122000001)(33656002)(38070700005)(64756008)(7416002)(44832011)(9686003)(5660300002)(83380400001)(71200400001)(186003)(55016003)(6506007)(26005)(110136005)(2906002)(8676002)(54906003)(478600001)(7696005)(41300700001)(4326008)(52536014)(316002)(76116006)(86362001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lSB2E6ePIhRH+hF+1Ne1GLhacocJErq1Xk0+61YU4BUXkj2q37lAmftRF7Gn?=
 =?us-ascii?Q?HptHbJXj0q8g0LbpIxc0MF0JWFuyMtPa6LiqcZyAjFHFUg4fi+nkCUPVdzl8?=
 =?us-ascii?Q?G6U5A47rY1CzHun36mR03JjIFOJldzNs2jSsJsvOWTd8PI4fg/nlvE/+P38j?=
 =?us-ascii?Q?OPVzEAjUAUXnntu0nn29ydF5NC1u4UzfZAOV8t7+C5R9bqt9k/M0L+z5qkHJ?=
 =?us-ascii?Q?nal0FkQddvtRlm8ksQZk3mmYUduAPRR/ph5GOX8JgxY7KcEnhJ55pSguKf8j?=
 =?us-ascii?Q?JVzgspOHhMtYQ+BMeCzNZr7pKTwot20zu5prtFLgDtxNW0h5/AWUrKbsDp9E?=
 =?us-ascii?Q?TZi5WNuZXkZOwJQzURFJNQZTw7lEoa/wZP22wlkz+x2diFj3Y4iUu4H6pCJ+?=
 =?us-ascii?Q?ZlS8ayrexSazVsZ74NVC48CrWqQ8Uf0Wsl0y+SCt55aeeEun6I+KBen5rE1T?=
 =?us-ascii?Q?iW1rH55Yia5M4/p/8ozHD4B38d62Z1NsC6/2l4L3B98sGHv6f8B3EKXxH7j0?=
 =?us-ascii?Q?TJgLijhRQQ5Kva4Uy2Cx0a/81cUY2oOPEtvOjfyCc0JkvIIGgWLVDw9/VHDK?=
 =?us-ascii?Q?Va75EkMhm4N32yLfXlzRct2dzEvQbTrj3Ehg/Ve2h5lI06Hs4AinpeE6qbE2?=
 =?us-ascii?Q?qSsh6aAtttLw6EKxAjCJ4GYoCP36BXW0t/Q28wQtf89PQoJy7V0iEpx/9F7P?=
 =?us-ascii?Q?aegW0YRbwz/nLzPOu0nt9YkNmFRUk1njaISHC/4AL36Jwf1hjqT+uncXRrI4?=
 =?us-ascii?Q?+BSaL38927xjwhR76VXuxOs1v1d7E6tB5sd6TTbLw3J2EPkeswb82P1YGmfd?=
 =?us-ascii?Q?JViAOV0HnHhzPvalIJnNPreFK1pQ0X4koxj7tlDNrj/88IsNQxuSVAABGCkM?=
 =?us-ascii?Q?TL1U9XVd7oPfhE315JM7QMWAtfygf62suvz2Sl3v7RmcAJA2W6GJ4R5VkKQb?=
 =?us-ascii?Q?yugjdnOFRy8j/dmAXqgsxnf8DTnPAj1OIEfaxgQcfNwes0vaL9fz0UFrDRZp?=
 =?us-ascii?Q?0LR2aM0AmlMQXUWNpqi7xSQ5IGFvMc+3ZIWG2PenbY7yjN34z+VZwn38wSB5?=
 =?us-ascii?Q?q9Ecf874Xyto0tg1H5VedlpNxX6kQvLM2UegGPjBVObtVPVcn6qrUvB0XJvm?=
 =?us-ascii?Q?YxZ0LAl0SDtSNupnK/Qp3OzJXsrFmOBV5+I3EeFEUSoGpGezSPdQCweLjbPR?=
 =?us-ascii?Q?FKqst1JOIl6C4SzaPN2yC9hVwP38+YfInw+SKfrsX6BKkiiqhsRsXiBC5BsA?=
 =?us-ascii?Q?s4DBiE0aaE+tpk7BdCW9YMaSJaQoq/38Yz6GcGCjR0/1BtAoTKYFUmm8kdsG?=
 =?us-ascii?Q?Fj1UcYs7YTIMqiZ5R2IkzrIcYiHsa083L5r+PZWKv1kr8XTmSDK41okKPU5D?=
 =?us-ascii?Q?0nUizHACqpYseXHFDnrylVsNIWuxnsxjvJR6oa1k1NMIPtf+v+3U0+WVFFIL?=
 =?us-ascii?Q?klJYS50DCkZYnYGW4fwK4SqfbjqnKFY8WHVLQuGW8z/aWpdtP9rPT3EhkcYd?=
 =?us-ascii?Q?EQQWDCwPZ1Ghy4MQbWzNhpqtCIyiFTEieMgvPtQOUi4yx4c8aNcpID2QfrF0?=
 =?us-ascii?Q?wFnSEpuhGqh0eCRROq4686rSLeJ6fKae33IwsRbt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e07824f-af6b-403a-a5a6-08da9d31fa00
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 07:05:19.9182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2MBaAqzMgSK5EJTTrlTNBCgEGyIsydm6+1FuUZ/tvOnXoPhYrtZJbp3heQ1S5lpVtSkAnbsq6uhKbQyVu8ELA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v1 2/3] remoteproc: qcom: q6v5: Do not report crash if SS=
R
> is disabled
>=20
> In case recovery is disabled, do not report the rproc crash to the framew=
ork.
> If recovery is enabled after we start the crash handler we may end up in =
a
> weird state by informing clients of a crash twice, resulting in undefined
> behaviour.
>=20
> Change-Id: If0d9bf5aa2c6f9e25adcefaca14b2de60fcb1a7a

This should be removed.

> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
>  drivers/remoteproc/qcom_q6v5.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/remoteproc/qcom_q6v5.c
> b/drivers/remoteproc/qcom_q6v5.c index 89f5384..1b9e1e1 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -103,6 +103,8 @@ static void qcom_q6v5_crash_handler_work(struct
> work_struct *work)
>=20
>  	mutex_lock(&rproc->lock);
>=20
> +	rproc->state =3D RPROC_CRASHED;
> +
>  	list_for_each_entry_reverse(subdev, &rproc->subdevs, node) {
>  		if (subdev->stop)
>  			subdev->stop(subdev, true);
> @@ -139,8 +141,8 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void
> *data)
>  	q6v5->running =3D false;
>  	if (q6v5->rproc->recovery_disabled)
>  		schedule_work(&q6v5->crash_handler);
> -
> -	rproc_report_crash(q6v5->rproc, RPROC_WATCHDOG);
> +	else
> +		rproc_report_crash(q6v5->rproc, RPROC_WATCHDOG);
>=20
>  	return IRQ_HANDLED;
>  }
> @@ -163,8 +165,8 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void
> *data)
>  	q6v5->running =3D false;
>  	if (q6v5->rproc->recovery_disabled)
>  		schedule_work(&q6v5->crash_handler);
> -
> -	rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
> +	else
> +		rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
>=20
>  	return IRQ_HANDLED;
>  }
> --
> 2.7.4
Regards,
Peng
