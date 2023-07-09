Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3381A74C8CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 00:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjGIWTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 18:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGIWTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 18:19:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818B1115;
        Sun,  9 Jul 2023 15:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFRWz4zTOqU6FO00rqpj3nXSsD4PPdk00HnpbHB/VoP7y1Ro/JlojuFMU/E9QpiIBdd0NI7zikNMjAoM6v8ilX5vvyATi/4XIQ8wOK3VqJcBSWRq5uLmWqB4aJSgTkVFul/ZXH/wtw5+Zdk++kpV69nJdSIiBbrBLsCUnxgpjGndTDXMym0Syl9TSNm+IUsGq1cFZjBWbqbwtcks3zZol0/rkhiaxUYHZ5tkkED37W2jKxYTgz748r63e9JgepTM4iyHPqzf/Pzh+EHps33RWCy/qDFBFYBhRblgsIbnk6s9IUNBoHaWHUk0TaXqmEAxFqpxBBt8cdpEb52PiwZisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eV+kix0TJ9zpAPIYojPo/cn9QnwpMVkSC4nOoA+4IE=;
 b=Ez1C0HoTtshTWMqHHRsa2FbQ/0e3XpXRocNphGy3LIdwEQPLNP16G1gXbpPP5heKvSPUQs3mi+kgB8cPUX/MenqZPFWvTQyT34uQ8wWBFK4aCybiUo1gs2fqGK8QgfQ7IeXS0VDhxTfbOzXPJR+YQxrBMfI1Nb72PEVn8EbOynDckAxWDGJc8egrb3z8nJnKuqj78WkxzAQJ4iXCoLd5CC0hEsxsRqRZ8g9V8bNRgVrwQcu/+FTPFkETyBUb2WZX/AbOHZfwbw+jnuzfVSaQZObXTVbhiuFDh3ovD2MBLBH30G8rwdat0yOLLACDRwGwJOjly0xayyyDduzsI6Hwwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eV+kix0TJ9zpAPIYojPo/cn9QnwpMVkSC4nOoA+4IE=;
 b=HqBl8ZqGtBJHDEIGp765nSXLHm3tPRDjjIbMm4lyYqRzWq63G6ORAeo/Zgw+xXDStn/dSBsWvvG8lr8ay5/T02ZmJ1TAYutf8CxOTszHHq+g+fM3MYL+G0WMChx+m9Tm9sBV3Z/aVzuzJjLmV4bSOFsijvcvUwvn2W2rNrKD3gM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6974.eurprd04.prod.outlook.com (2603:10a6:803:133::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Sun, 9 Jul
 2023 22:19:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6565.026; Sun, 9 Jul 2023
 22:19:14 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Marek Vasut <marex@denx.de>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] thermal: imx8mm: suppress log message on probe deferral
Thread-Topic: [PATCH] thermal: imx8mm: suppress log message on probe deferral
Thread-Index: AQHZsY8sHydGaWVaLEW9WywB2ePPqq+yA4Uw
Date:   Sun, 9 Jul 2023 22:19:14 +0000
Message-ID: <DU0PR04MB9417FF2B84CC1B43665FD2698833A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230708112647.2897294-1-a.fatoum@pengutronix.de>
In-Reply-To: <20230708112647.2897294-1-a.fatoum@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB6974:EE_
x-ms-office365-filtering-correlation-id: 9bddfcd0-a5b5-4e3e-3871-08db80ca8714
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2F23+Vjo5no+JMWJDwyLa5+7c6Zj35jCyBEYmgU9IvIlkjlV861qzOtp1YZ25GMEx0yCFcV54eESDBhhPiIYI7tvQ55JBXwGipyGABFje6RhpXJpILFpP1nmc1fVvp7OyYTNtrIcd2fSqjc3gsRbh50b4Fb/VNXjWM9c2RX09uHrMI9yIVQuC+0NkJJ3bMHNJe2M7MFXZ95Y+ts9eBT3n8Htc7dYzj/DM6J7mloFHQ2GL/5v3vYPR3LdTRBI03E8SDNUX2m5fPGvau+zpTYjARnXLEzSYhPAqVu5tNxI2zE3pDTomtpX3a1PsIkoVRcZfcApqvngUXwbasPGR7V6Nf4VQX//xY6C0VuVejmmEpF7VSojq7lmWt5kSkhTattpBi1XD041adFFgKeJcYqZ4Y77xBzO2cGbEyODUHIvhcQ1FXzPqAVgMcvH+B5girqXLqss2qIR/6SldKR8+jn/8Wgy2yPrEFvXHAr4bXW8hC0bAU6ZXMBN9tkq9aQymu39kuKvOYM8G0BzVg04Xb4md7w5x2GM2lH3/L2WA/Gkf5rCd+KdCrixvlZQi+V+JIF+WGRzZZ0UIyr8i2kl8Jal3PFpxyHR+Kw7J2sEyxcB/oeeVZzNWo8M1TBUtAICG7Ve4mtzOXI4asELPggwKe41bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39850400004)(136003)(366004)(451199021)(7696005)(478600001)(71200400001)(76116006)(110136005)(54906003)(6506007)(26005)(186003)(9686003)(15650500001)(2906002)(66946007)(66556008)(41300700001)(66476007)(4326008)(66446008)(316002)(5660300002)(52536014)(7416002)(44832011)(8936002)(8676002)(64756008)(38100700002)(122000001)(921005)(33656002)(86362001)(38070700005)(83380400001)(55016003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IjAMlyTwDdhXDFg8M1D7ohE+O2MrcZTNCTAKwyk9ugb3ZPm95mFGYlQ+aKx/?=
 =?us-ascii?Q?hGg4unIgGS8MrTEoWYCSuAOm62asQMhPVR0PGuLJhOcFpoANz/lF3o5pj5AZ?=
 =?us-ascii?Q?ufSfnsFbaOjGNtzyYktM2L+0DulEf7P8vLHxgz3IkRMHb06VCPPUm14t6XaU?=
 =?us-ascii?Q?dzVgkgo+BwrNEOINW+UNGBUfa8kTztwIC643RKAQi8PjJYPWCqLBWZChKcex?=
 =?us-ascii?Q?poe46qvqNtbhBblUlUbdv9IMjJvQW2SMuhStN3RertY+9VR5GzAyLd9nmX9q?=
 =?us-ascii?Q?F0W7m1Ilxmu6k14+3XdYBnuOjZvI/FX2qdaoRTnXTJCW0BRRo8w1hmmRUgMQ?=
 =?us-ascii?Q?tCKHvxiFTBIi3Utzwv7FQ67d4572fTAubHv3/rAXaC4QXC0IUYYaXWi2Kvc9?=
 =?us-ascii?Q?kHScmx682YD431rHDWtsvLkjYPAPLibwcjrFeZRMIwLKcDldT6cm1YNW0z0w?=
 =?us-ascii?Q?9Rsad71TBO5jGp5TS9bccOO77yMMQgKW6hMDtxqivw0Za/jWSM6sNg9W7DY2?=
 =?us-ascii?Q?nMzsgfZRlyM1S2AuKERCNgefwZhsJTktxhMPBfDuW2RllayevRkamk2MUGmu?=
 =?us-ascii?Q?uWGGuINTbuvbQ0ujF4l7IFvL7iJTdmr3y/y15RkQhnMIYeSFdRT8WH6d2J7W?=
 =?us-ascii?Q?OF8UuIt367jguO0NGWDwAv4DoiKBlkop7NH0PYbKiCtfAlOHEXYrapqG79pl?=
 =?us-ascii?Q?76h/kGxR82xyvOIfmjrqhh9/cGjGSk5/tSyarufZJbvawda912XWaEWlIcw1?=
 =?us-ascii?Q?i/+oZUnRD4XmuZ7zp3vQrtQtHF3GgMOCUfZFq5nYZxfuw5RGUZcVuL1ga2HG?=
 =?us-ascii?Q?gRMn8q+VIbQB7u9tgjVBGe2F8KEoBtcueVPatKJQtXVPL+dR5Qn3W2pi/TFs?=
 =?us-ascii?Q?cNAksxZaIvi0TpOlE8xuORBjHfzI9FxUDMBU3JRhCy5r41Ahx2LpC3Bc3fuW?=
 =?us-ascii?Q?SiRAHZCDRhK40hvEMNxJb/uM14usOEnA6GFaYo6OCnqFsnY/fzco17YvLMRU?=
 =?us-ascii?Q?rAH/3ZJVmJjsp34UUl1W5Y5m3pP+fR17yGlaq4/CPelaAeSpUeQN0IKrXK6E?=
 =?us-ascii?Q?bJwULA8B1nk6rZMpHohKxYcmQQrFbjYBaZCGxEp3IyekPMQzeVEFtcExI4Sd?=
 =?us-ascii?Q?sKpk6uP+tHA0LJFwYB6eB+8gHmv0xblxShzcBAsrfwwPxRj9kPqaHFT6SQ/E?=
 =?us-ascii?Q?+55JTLz1I/T54mYheefq1oMdnEHzsB3c67DE0q9psqlQUOsEGBB9I8JEuFyn?=
 =?us-ascii?Q?JzFPxXyGGsQucpafUiYeuedcf/pyNVK4v1aVg9TT+ydllSqI4OEQVTHrErzE?=
 =?us-ascii?Q?u/QKDZEXVLdykYU1PodwCTUvQATEXDueH502+g6D3O9Gt97MymMKE7fmo9MF?=
 =?us-ascii?Q?kFr3WDs28RBKuqyV42Px4Ho4lHzu2GNQasVhpHdLdg+cLEMMhQOVnU5+1LTs?=
 =?us-ascii?Q?wcIIsIURncb9trLxxunp2aaFxO7bIWm4xbH8aarzI/7MLmNiaznbWdBefJop?=
 =?us-ascii?Q?fM1eqlxZ6uXOtlu916BmKIjKSSn/LcLK8Bw1ZiEK4xTLB+kwEv2T1IdehpQc?=
 =?us-ascii?Q?o//nBQU+p0FD8XDYwvc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bddfcd0-a5b5-4e3e-3871-08db80ca8714
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2023 22:19:14.0848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pflA+u4R0HoYYrUPCbe//8gaEkrBa/eeRX+SPwHuYFwt721/op0dEmjLq59panGclWuol5t8qxhvG6AZ81J+QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6974
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: [PATCH] thermal: imx8mm: suppress log message on probe deferral
>=20
> nvmem_cell_read_u32() may return -EPROBE_DEFER if NVMEM supplier has
> not yet been probed. Future reprobe may succeed, so printing:
>=20
>   i.mx8mm_thermal 30260000.tmu: Failed to read OCOTP nvmem cell (-517).
>=20
> to the log is confusing. Fix this by using dev_err_probe. This also eleva=
tes
> the message from warning to error, which is more correct: The log message
> is only ever printed in probe error path and probe aborts afterwards, so =
it
> really warrants an error-level message.
>=20
> Fixes: 403291648823 ("thermal/drivers/imx: Add support for loading
> calibration data from OCOTP")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
[Peng Fan]=20

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>  drivers/thermal/imx8mm_thermal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/thermal/imx8mm_thermal.c
> b/drivers/thermal/imx8mm_thermal.c
> index d8005e9ec992..1f780c4a1c89 100644
> --- a/drivers/thermal/imx8mm_thermal.c
> +++ b/drivers/thermal/imx8mm_thermal.c
> @@ -179,10 +179,8 @@ static int imx8mm_tmu_probe_set_calib_v1(struct
> platform_device *pdev,
>  	int ret;
>=20
>  	ret =3D nvmem_cell_read_u32(&pdev->dev, "calib", &ana0);
> -	if (ret) {
> -		dev_warn(dev, "Failed to read OCOTP nvmem cell (%d).\n",
> ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read OCOTP
> nvmem cell\n");
>=20
>  	writel(FIELD_PREP(TASR_BUF_VREF_MASK,
>  			  FIELD_GET(ANA0_BUF_VREF_MASK, ana0)) |
> --
> 2.39.2

