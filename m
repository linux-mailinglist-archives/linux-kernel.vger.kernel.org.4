Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A35C6D57C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 06:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjDDEzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 00:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjDDEzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 00:55:32 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9421BCB;
        Mon,  3 Apr 2023 21:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObkBP3cS89kzk81zenxdW0qtzxLM64AtCknYlW1RvbbKhym8KoYiasaZhbPl+UNuWFQktlQSTKyjt+ydGujfh+NOfs8HtdjZ85/JccbnAjiywv+QMRXuY0H3QZ/LTaULn0zPMPQXaB73+ZMFosiqc4Ff6gBkddwXLXMWV4FwSxSdEfJhej4GRX+4pKpE6FHoa53wPi7KBrV/fSB2uVsmMYQKHk4GhTEpZD74YoNCPFIeEThYv3FETQrHiBh7qhsNXFLUOgNTJxi4A2HBzDb65Xi5jDpADJIWYJQQvRprx+zEDHJAiH31hJrYqn+oMdbzGKtrQo+2vJ/CBOijtIk+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qrx6wzp22s3ImoZHwkmTGnleOX/iwEeE4gfkd+/BrtY=;
 b=gAhwV7xjgJvAlwOn4uJ5GZwIHPeUX1epqr8Kpzh4N6Zv8+pLLm+88v7oTq5yjxkjtfvAgvLnGi7R9dqcEvbfVJMxNusbgyj4BZVVr1QRVR/BsSlyUKW8uR7LfUmV9itKES3bhcra7Xob8OKKTC6/NWGwHdw4sRFUkZlhNwCyNKz+dzUNvNmjEWvJOPOhF4IHPJigjs1dNiOSzK0lqtpc5Vf1GQnwqSZfgf3Tv8kG3696mCl0FvYjHZbNCDArA8k93DikqxNfCzGBw68WTkSjJmNwCuivTe3+5u77HfS2kUZK/qzapMwNsVX0t0SlZVtyC/aQeJSmgsZjIgv5Ql25ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qrx6wzp22s3ImoZHwkmTGnleOX/iwEeE4gfkd+/BrtY=;
 b=c8snKh0XqTnwvMbMvxp2rArUmJv+meXHWaExUN9lbdlJJ5Cv4CIXpF+EpvcsHHPZDGTAtZuiQHMl0J2Fi04LGq8Yk7rrguFdCMNNxKWhEjaNKTuhhu9lqJ/4oM3zBTxr7+9/9rEm6YOO6VjRWsQfJYisQfZMcaZJaBTac+f5D/U=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 04:55:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 04:55:28 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 4/5] remoteproc: stm32: Allow hold boot management by the
 SCMI reset controller
Thread-Topic: [PATCH 4/5] remoteproc: stm32: Allow hold boot management by the
 SCMI reset controller
Thread-Index: AQHZY+gfFgW91EuCRkiIW9Op8za+hq8am2Pg
Date:   Tue, 4 Apr 2023 04:55:28 +0000
Message-ID: <DU0PR04MB941747DDF6FD2F157A24183288939@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230331154651.3107173-1-arnaud.pouliquen@foss.st.com>
 <20230331154651.3107173-5-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20230331154651.3107173-5-arnaud.pouliquen@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB8PR04MB7097:EE_
x-ms-office365-filtering-correlation-id: 60787d3a-2d9a-4330-e199-08db34c8cfcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SQUKPm3ypAgqeS6LCCQ4SPdcOqOybH+kgf4+PD2s6QtBuDMlqi/Gs7BUozytQg9ESxqcVasirTHClD/5aqq4SU5kxWzeGVr+ZdFCVQcE2Lxl4bFWByAo/czE5U8fPV6wdkv3msIdWYAAeyif7kuj4JQRuR4QRF3vNqLxonAJ9MJqbr86wBrT2BDVCU+Mko1cyiP25v1JmwdByFrZxK5inXnOBpXrx7FENRehaiMyE72azDWzzGV7VlgapNhUco72h+DFogR53GI9a6jJa9At3e8hAp9lLv91Rvyr79TraEjHzLdhugX6MHC70ddw2I0PlYLkBTtXy1xgbHYpasnG8GSQJrQzMOKGARFmPFeEznhcW5ljUVIptbOxM34g2Ur2N0Z2yrqZaVF1hh87M7rH7vkzDvmx8dJi6aOsyxYPiBIJR1yk8HIZNtm7O53VGBgJqNTjN69+21HQRSp3J15r8EbQo8ZXMMzcr3ygTkNoatI1tyD5sQnHfNEUg4uZWCdg4yc32irYlrXhNPnQ8z5VE97eeVBje3sdJy/KiZ2+/85tRC7ZoM0I1vNWq3fJeb5MN4iTbYQh24lICvwekaUd1HVe8vlN5F0qMbYDVCuDzTrqWserOfxXNiJhkKYWjcJb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199021)(66946007)(26005)(6506007)(9686003)(83380400001)(122000001)(66556008)(66476007)(66446008)(38100700002)(41300700001)(7696005)(71200400001)(186003)(54906003)(110136005)(316002)(478600001)(7416002)(2906002)(44832011)(33656002)(86362001)(4326008)(64756008)(76116006)(8676002)(55016003)(5660300002)(38070700005)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FKG+gHLUIvsj6/x8Hhr7t6EcG7vCR9SpXaSMR4/RPJHqhn2gVaCeOZOS/rph?=
 =?us-ascii?Q?LvPHbYS74oadQWktn4LFn+Bgbdu6THOvTv17eagO7MKmnmSh6NXWPtrnBJpb?=
 =?us-ascii?Q?K2GFmDsO0cb2Iu2YtfBQsYLMI9LRs/+sFb8hAhXXL80IUwN0MX88IZsBR3SB?=
 =?us-ascii?Q?olHHYRnQa/ugAnamPc5RoevpErCUB0B9798MhQ6NUm9MZsJz2vi779FAGOv9?=
 =?us-ascii?Q?j8r4Ns7Y+NtezizB7S8EaEFDy9VwrFV1F5JQx9VKbjZW5Ib5LGIfe6sS3gzD?=
 =?us-ascii?Q?Q6u8UJPUo8ACImpusu6tktQODNpmlyHZUMc7BkzRkJ8W+aWSw9DohSMQxFy+?=
 =?us-ascii?Q?G8U2ITNVMn8Sdde/1Cmtq7f3InqBXB2gSnVvk0ZffyJ1D7k5ABEY2THq9miZ?=
 =?us-ascii?Q?ACj7SdRPnA39foXUQlPVGUl81icsDz7OZTuM1s7YHyzfGaOTs5FfRPNbSHib?=
 =?us-ascii?Q?jviGq18RcYg/CZFtft+tJlfJtUiuPnQryivDdhlMPzo4z9B4QgVmdMUY4qF6?=
 =?us-ascii?Q?cevqlIDvms/o6lwkOoqYiktj+j0itFnZ8KwhvlEKj2cydTjtCPMMk9RYJHVn?=
 =?us-ascii?Q?QjN2036izfFxFOuWDIc9yiO23gjbquYs7Y+l6sOWrVitBVoZS8kwTCuz6sff?=
 =?us-ascii?Q?Mw4stW3HtPcKqGjDr1lshUeLAmlc8vdbXvzS4+wTB9tOuYtPJvUlUSveNK8B?=
 =?us-ascii?Q?xmsMUa3L0PxWxg0Kwy0l5OKsj/91myy6I6YZuXEG8rOgNt/sVvN7lK6RpdQu?=
 =?us-ascii?Q?8qt105W4gUr8xpSjCKpWNVq9lCt5ENyEiKpebv11ftY4vg81hxK+3PerLiJl?=
 =?us-ascii?Q?MAusBEUyvKLqhUD6z2Ir06gnsKybUivlA7lB42DiZmlOzmDdAUauUwyWEfUP?=
 =?us-ascii?Q?V9+fnrw7vzhNvXYo9RwcmtqCI6CHqtr2iCckDdd+aG747cpNM8j676/K71Hs?=
 =?us-ascii?Q?pQM4KBw9DV3gjcjjRJvRHGjEqjDCoMNOcH5ZlaGS6MpcQY5j4/Qg2OlY1imo?=
 =?us-ascii?Q?w3WcrW2JSMBkX7eMJZau1+1e6FNv01LKlWjMC8X5T/8t597rKSxLvFA9Zb+F?=
 =?us-ascii?Q?qghiIZlriggXXZ1Bvxi0nf90LccXuVRdS5xETYDdns0opezvjdO8HbfeR1mD?=
 =?us-ascii?Q?KWFYBOsO0qUCacnohkKc2AUoymTrj0znOEde0b19mi7bMaZHIs3vYzgC3QxP?=
 =?us-ascii?Q?GCJbkYale/DkfREpeku2X2pjceWUtmsYNTdfcCZSpHerS4Lk0VUU0lJuzeYV?=
 =?us-ascii?Q?57hfYK40ZDCcLAAxjX2OiG3n8x6kgwtD/8xZjdKYUArNz8kFB7L6p88ennDb?=
 =?us-ascii?Q?Vy2r66wxCqY2p7VTw6DUM2fpNuowVySXrlYghjMMQuwmCkGymJxTH+Qliau9?=
 =?us-ascii?Q?mmuPJGRLiFn5Ndd9GU0OhldsLNpju52VLAph1Ux0TuB2pRp50AZ4+qzFZtOk?=
 =?us-ascii?Q?kvvDBYRBHGDW5jwO26ovnSJLAywzSvuIUrFEjoMipEgaRNoiObfBF08Vn/ur?=
 =?us-ascii?Q?Wj0ylidyrTCww4oxF7etcfmBjEgFmrLV1XAHQLPmHJuEhIxpdzMOZbFZQZ+q?=
 =?us-ascii?Q?UMhjG/AMYQODFcMw5s8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60787d3a-2d9a-4330-e199-08db34c8cfcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 04:55:28.7043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvslKpa3pe/mpRk1PmdcFNmAuRdIAibVm8ibvmUqr0AuU/twCmxl0nj1rNERZRtaSs359n+Dey7R1D4tgsIK3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7097
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 4/5] remoteproc: stm32: Allow hold boot management by
> the SCMI reset controller
>=20
> The hold boot can be managed by the SCMI controller as a reset.
> If the "hold_boot" reset is defined in the device tree, use it.
> Else use the syscon controller directly to access to the register.
>=20
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/stm32_rproc.c | 34 ++++++++++++++++++++++++++-----
> -
>  1 file changed, 28 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/remoteproc/stm32_rproc.c
> b/drivers/remoteproc/stm32_rproc.c
> index 4be651e734ee..6b0d8f30a5c7 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -78,6 +78,7 @@ struct stm32_mbox {
>=20
>  struct stm32_rproc {
>  	struct reset_control *rst;
> +	struct reset_control *hold_boot_rst;
>  	struct stm32_syscon hold_boot;
>  	struct stm32_syscon pdds;
>  	struct stm32_syscon m4_state;
> @@ -398,6 +399,14 @@ static int stm32_rproc_set_hold_boot(struct rproc
> *rproc, bool hold)
>  	struct stm32_syscon hold_boot =3D ddata->hold_boot;
>  	int val, err;
>=20
> +	if (ddata->hold_boot_rst) {
> +		/* Use the SCMI reset controller */
> +		if (!hold)
> +			return reset_control_deassert(ddata-
> >hold_boot_rst);
> +		else
> +			return reset_control_assert(ddata->hold_boot_rst);
> +	}
> +
>  	val =3D hold ? HOLD_BOOT : RELEASE_BOOT;
>=20
>  	err =3D regmap_update_bits(hold_boot.map, hold_boot.reg, @@ -
> 693,16 +702,29 @@ static int stm32_rproc_parse_dt(struct platform_device
> *pdev,
>  		dev_info(dev, "wdg irq registered\n");
>  	}
>=20
> -	ddata->rst =3D devm_reset_control_get_by_index(dev, 0);
> +	ddata->rst =3D devm_reset_control_get(dev, "mcu_rst");
[Peng Fan]=20
This may break legacy device tree.

Regards,
Peng.

>  	if (IS_ERR(ddata->rst))
>  		return dev_err_probe(dev, PTR_ERR(ddata->rst),
>  				     "failed to get mcu_reset\n");
>=20
> -	err =3D stm32_rproc_get_syscon(np, "st,syscfg-holdboot",
> -				     &ddata->hold_boot);
> -	if (err) {
> -		dev_err(dev, "failed to get hold boot\n");
> -		return err;
> +	ddata->hold_boot_rst =3D devm_reset_control_get(dev, "hold_boot");
> +	if (IS_ERR(ddata->hold_boot_rst)) {
> +		if (PTR_ERR(ddata->hold_boot_rst) =3D=3D -EPROBE_DEFER)
> +			return PTR_ERR(ddata->hold_boot_rst);
> +		ddata->hold_boot_rst =3D NULL;
> +	}
> +
> +	if (!ddata->hold_boot_rst) {
> +		/*
> +		 * If the hold boot is not managed by the SCMI reset
> controller,
> +		 * manage it through the syscon controller
> +		 */
> +		err =3D stm32_rproc_get_syscon(np, "st,syscfg-holdboot",
> +					     &ddata->hold_boot);
> +		if (err) {
> +			dev_err(dev, "failed to get hold boot\n");
> +			return err;
> +		}
>  	}
>=20
>  	err =3D stm32_rproc_get_syscon(np, "st,syscfg-pdds", &ddata->pdds);
> --
> 2.25.1

