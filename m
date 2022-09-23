Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7051D5E747D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIWHDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIWHDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:03:14 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D957911E96D;
        Fri, 23 Sep 2022 00:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBkqw0SUKZ8i4FgGBVLWeO5ctuag3YA7ajVsGUYY2VF+gb//KaDjFY0FAmkFijks1msNc3F886ad7lQo4Jg+tadcrVeaQXMrfplEivhobAGDJgs60GWVQ/j8HDIprxHnbsNV+J+bo2KuQYkj358XyLPeBPUIf4vDW2qXHA2DTWU7RvFHl3hit2Lcz4hfTZkqO74MzZbJcajWmdIlFvi7LfCvftQRPw0tPKMKEAcXDsIng52F5WGvQDUl++1hyG9bswrW8jjE78j0vECxGZ1fLmvGR5IPJVBWMoGaNcbJeOpYbo0a8UBX/Phdm2x6+pLPZyKuWmifBFcb0E2nx232Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1S1NLYXxpfzExsvyi9n3NEkasMNZXd4ezbI66VTCn4k=;
 b=VO7Pkb37BYp4IRloouUYneZasgfPPDf3VaPGWQVYI0S5UrZYOth2llTseoopFT8f8sclyRjH7ss3MKpz3JsfLLB+Hyu+WOSx79qr0oLTJ0bC3T1C1TtjiK/ESJePoalbb/Mq0DhbDl78+9BJ2rP9rXnLGi9GqJmRaDTBzcYVLMkUuQ8FDWefsjd6pU9Dmjg6qHsWcuwgt6nmLFGqlFAuYL24NnBb/aBnbnJ4WAFEhNzUbyirjSDT8FijGBQ2rm5dWxzek9uymGKYIrmNOckFJib2pUf51jzAQVLpkT6yCRJv88EEm+PXBXlodDR/CsnmMPup7O63E8d//7x8Zx3Zbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1S1NLYXxpfzExsvyi9n3NEkasMNZXd4ezbI66VTCn4k=;
 b=Li/h5StfgZvSWpjFzLj+Xg596T2ERvHetUfz+FJM6XMBm4lLVlCc0n7FK/+yetaRqn7Ag1SGcULmCYxPLwcXx3osVsSoH5NptDJ+BMAAAgSRNVe0M5bJTXgyJIdBjSkTclaYtsQfio/SHwIFW7lMqFEoa0tOMYU2i5BfkIJavRE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 07:03:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.018; Fri, 23 Sep 2022
 07:03:10 +0000
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
Subject: RE: [PATCH v1 1/3] remoteproc: qcom: q6v5: Send subdevice
 notifications before panic
Thread-Topic: [PATCH v1 1/3] remoteproc: qcom: q6v5: Send subdevice
 notifications before panic
Thread-Index: AQHYxrysL6wqsBKCTUuN3TjRmRDVQK3sp5UQ
Date:   Fri, 23 Sep 2022 07:03:10 +0000
Message-ID: <DU0PR04MB9417F36DDE3B8F933711BA1088519@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <cover.1662995608.git.quic_gokukris@quicinc.com>
 <842a6b6307d26874959d29f2065aad544ff0b86c.1662995608.git.quic_gokukris@quicinc.com>
In-Reply-To: <842a6b6307d26874959d29f2065aad544ff0b86c.1662995608.git.quic_gokukris@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB8903:EE_
x-ms-office365-filtering-correlation-id: 3cd6f600-59cd-4f6c-a50e-08da9d31acbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A0rRcgFMvC7Q74n8UPp1C3ZXpg9uxCkTA1pK2SoL3eT/bN5X3o1h/zWhr6Y8gG10E2sDeGnUL4rXFe41XM9UFiuY1gXVWTzBSnGJd/dCyJoSoIyQrIXHcp4gWSUE9h5tniBNl9qzA+rnL/Mh4TfAg9KgtiUzWE1ktFQyXT2sf5KhCL1VOaQOVpcFv/UojkvZ0BIbUedTVq/xRaYwrenVa6K17lAysswZWA41l9+Fm34pWHkqdETG6/dZeRaZ374Qe7VQYhYEZ0vyM4Mlh8amd1M2jJi8YAazgHJwy6+IkuuiuDIWQ82YMRRPo+PlaSBuOcUidMItXICVmMJVQnrAivRoEACWuOx9ikRjn/nahqHKoH9fn3XkzI4Gr21mdqSxDEHElOMaaLdeF5MCXryoRcZ/YwaUPxvQPY3DEA4QXMUaKOiMqSXt83zHiiuMV9zaDmeBzjomOFSr4dGmqul8s/D/538Urww1e7FvnkG3FNeGpqrEhkHFtUnp1phuXraPmrouYIbRZ4raWqDXX8/lYUF0vXbAmyxakjF1IVXKypKbrATTxm9afqcxjzCYNe4qXVjV1A+aLtiiViUb7LE4jK4Uef7SA/qvGQYHiEB3Mx4uwxBTr2e+AZph2C2/4lXR/2te3q7nafnpAEOTGFwS+hyVXCgnLU98WLG6YzmLI3/krG9UpNCJWDR+HAHdHzPXee2LOrAMYfi6nbRsb9nGm4lavEkJV5EBlYp4EHryXR3PfHio6IC5GZ+hZfFgRCF1xoR7r4WEiQDnLoy9L+W0Dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199015)(110136005)(478600001)(54906003)(316002)(71200400001)(122000001)(83380400001)(38100700002)(41300700001)(55016003)(7696005)(186003)(33656002)(9686003)(38070700005)(6506007)(26005)(44832011)(2906002)(8676002)(52536014)(15650500001)(8936002)(66556008)(66476007)(7416002)(64756008)(76116006)(66446008)(86362001)(4326008)(5660300002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hAqU4QqaLOMKQAQcJIXhi9IkApLRAkOzr80g00bLPu9DUwPjtlD1LvkBHWVp?=
 =?us-ascii?Q?EiGNgU+JAIURbyQ6Y1h3+k2DoGIXEjoc5XdJQmkwyM1qbX1BIdhD4ZyL8hqc?=
 =?us-ascii?Q?5FIwZmcr8zC6HP97L48AhoNttM/UrY3csq6Dw2wfmq/TnmxHCdA5mH2wKrU0?=
 =?us-ascii?Q?oB5rmAutvepvdwHVc2GWQ7JLM9TvMEg4KR1jmQDhf3kBEarj8zxqlZOi0iPD?=
 =?us-ascii?Q?v1y3oJVcnXTcSLdbwZOrTJNHVKCNbebbpTLJKI0vodlGB7kmH+2e+BmCVEf+?=
 =?us-ascii?Q?ZlrvysXFP09clFXBuIUJLwxklfLa03edPSsHrQpzkRK2+rNk9pv4gs45zUzU?=
 =?us-ascii?Q?wgFbZIGbz6EfQ7uF9wkd/OkBru0Smy4BV3yLZcbsshaEi5r4Mhag5kbhguOU?=
 =?us-ascii?Q?tT75+d1lopRtcYkz54uD7yTIspBeSwHknMZN9dUDNd7xO0TWqMngNeXAUDZz?=
 =?us-ascii?Q?AG7i0OSU1D88O1oIQmlwZEzeiXH6HJerN/oP06Cf+xkkwwOimWB+U8onqilL?=
 =?us-ascii?Q?VlsToMEDQhxLq4V4ihaYewofU0O7OOjICy49UqEiinisnuxh/rxbKhogYzmV?=
 =?us-ascii?Q?Noq5FH4b7UD+0vysj22+uUiWpbxONJI2I5XaEgKWbB95kZXoPO7OZb+rutpw?=
 =?us-ascii?Q?dM1Dsw71dflh5PgXbVRil5ZAFaVSUFjNhjWfVN99wmTfjLU52cnDamjdI61O?=
 =?us-ascii?Q?obCQ/1dR0B7laLqRO5zXh6dsgeAVVGFFsQzbJPrSagiXgkkHDXX19IfNxe4I?=
 =?us-ascii?Q?1iANcX6ePxzO/m4AjoGvjuowQ5boJfKPVwEIqGs+OXH/lsFhakAO8s1YJEbP?=
 =?us-ascii?Q?VeQgDCHEFG9gmapb0DsRD8H2l0U1/F9WNxFNOExgEMU7WNboCI2poDDUY8NP?=
 =?us-ascii?Q?TfzwuUjrNrRvZCIGHDakAT2AW7bBhs+2bxNNNMjfcokClnFsEvIBX97nrveA?=
 =?us-ascii?Q?bzwfts2yd7sDNlke7CSahvs52uMfhMUJi497OpU11+mvq4l375QxY1GzaAg5?=
 =?us-ascii?Q?g4Rm5bViKv7q1WSShoTw+rg82nAxlIaDCXggAA9uxyqK3wkGmPtsLnzolTPR?=
 =?us-ascii?Q?BJKl2LgM25SGYj6orRpUWJlwK0zgwVv8+ArsroXHxXnWkakiAXUKyOXQaPC/?=
 =?us-ascii?Q?0fNCGvcMrvxblyyLL9lCNBvFl8PsQqR6DHVNhpLOeUZQFIOsxads6BmGk86k?=
 =?us-ascii?Q?EuBSnWpolMxBNWIL3x2UwbbkdbGFSLr7faShdbp5VbiU+fWVTUd3QeguUlqK?=
 =?us-ascii?Q?q9zgJh+f92VdzGAZmgSZcq8GkH50zaSAMqJXZwl95fzrAutwO4UXDyIwszgD?=
 =?us-ascii?Q?/e+hA9q2oeEhnmGFBP+OYADH+KIPSXqW/g0344VVR/Qab3S0G+0LND7falUg?=
 =?us-ascii?Q?r22+8yfV8+hb/+4eCIZcVa6xsSk0JTRnDknEv9o/eaUQlJHFSWO2dAOgpeX/?=
 =?us-ascii?Q?8DrpGbzL9W2KB+7fzfZWMbvcjI9fCY4WNkWhPNf2icphfKL5eTGgKKnzCigv?=
 =?us-ascii?Q?C0wf/MtrhHKO5m+plGcz6s0dTWbfCt71wbzYVEM90aZhl9b1BgIb+rBcx14o?=
 =?us-ascii?Q?ucfw3loh3mAVCmHw5hHPk/JJZeme0vqFQg4/mJHG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd6f600-59cd-4f6c-a50e-08da9d31acbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 07:03:10.3127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w/1u72WTCVyUjqnEpeXZQPVGvD26CzEYIc6ipbeHHsi9WF81QOTHsaokC6JNi0rL92f4b/gpRTS0gvpAgz8Eyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8903
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v1 1/3] remoteproc: qcom: q6v5: Send subdevice
> notifications before panic
>=20
> Subdevice notifications after a remoteproc has crashed are useful to any
> clients that might want to preserve data pertaining to the driver after t=
he
> remoteproc crashed. Sending subdevice notifications before triggering a
> kernel panic gives these drivers the time to do collect this information.
>=20
> Change-Id: Id6e55fb038b70f54ff5854d2adff72b74b6a9570

Change-Id should be removed.

> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
>  drivers/remoteproc/qcom_q6v5.c | 31
> +++++++++++++++++++++++++++++++  drivers/remoteproc/qcom_q6v5.h |
> 2 ++
>  2 files changed, 33 insertions(+)
>=20
> diff --git a/drivers/remoteproc/qcom_q6v5.c
> b/drivers/remoteproc/qcom_q6v5.c index 497acfb..89f5384 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -15,6 +15,7 @@
>  #include <linux/soc/qcom/smem.h>
>  #include <linux/soc/qcom/smem_state.h>
>  #include <linux/remoteproc.h>
> +#include <linux/delay.h>

Seq the head file order.

>  #include "qcom_common.h"
>  #include "qcom_q6v5.h"
>=20
> @@ -94,6 +95,29 @@ int qcom_q6v5_unprepare(struct qcom_q6v5
> *q6v5)  }  EXPORT_SYMBOL_GPL(qcom_q6v5_unprepare);
>=20
> +static void qcom_q6v5_crash_handler_work(struct work_struct *work) {
> +	struct qcom_q6v5 *q6v5 =3D container_of(work, struct qcom_q6v5,
> crash_handler);
> +	struct rproc *rproc =3D q6v5->rproc;
> +	struct rproc_subdev *subdev;
> +
> +	mutex_lock(&rproc->lock);
> +
> +	list_for_each_entry_reverse(subdev, &rproc->subdevs, node) {
> +		if (subdev->stop)
> +			subdev->stop(subdev, true);
> +	}
> +
> +	mutex_unlock(&rproc->lock);
> +
> +	/*
> +	 * Temporary workaround until ramdump userspace application
> calls
> +	 * sync() and fclose() on attempting the dump.
> +	 */
> +	msleep(100);

I have no knowledge on your system setup, but just guess this is
not reliable.

> +	panic("Panicking, remoteproc %s crashed\n", q6v5->rproc->name); }

It is remotecore crash, why use panic to crash the Linux side?

> +
>  static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)  {
>  	struct qcom_q6v5 *q6v5 =3D data;
> @@ -113,6 +137,9 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void
> *data)
>  		dev_err(q6v5->dev, "watchdog without message\n");
>=20
>  	q6v5->running =3D false;
> +	if (q6v5->rproc->recovery_disabled)
> +		schedule_work(&q6v5->crash_handler);
> +
>  	rproc_report_crash(q6v5->rproc, RPROC_WATCHDOG);
>=20
>  	return IRQ_HANDLED;
> @@ -134,6 +161,9 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void
> *data)
>  		dev_err(q6v5->dev, "fatal error without message\n");
>=20
>  	q6v5->running =3D false;
> +	if (q6v5->rproc->recovery_disabled)
> +		schedule_work(&q6v5->crash_handler);
> +
>  	rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
>=20
>  	return IRQ_HANDLED;
> @@ -354,6 +384,7 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct
> platform_device *pdev,
>  	if (IS_ERR(q6v5->path))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(q6v5->path),
>  				     "failed to acquire interconnect path\n");
> +	INIT_WORK(&q6v5->crash_handler,
> qcom_q6v5_crash_handler_work);
>=20
>  	return 0;
>  }
> diff --git a/drivers/remoteproc/qcom_q6v5.h
> b/drivers/remoteproc/qcom_q6v5.h index 5a859c4..b1654be 100644
> --- a/drivers/remoteproc/qcom_q6v5.h
> +++ b/drivers/remoteproc/qcom_q6v5.h
> @@ -29,6 +29,8 @@ struct qcom_q6v5 {
>  	int handover_irq;
>  	int stop_irq;
>=20
> +	struct work_struct crash_handler;
> +
>  	bool handover_issued;
>=20
>  	struct completion start_done;
> --
> 2.7.4
Regards,
Peng.

