Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572565FD97E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJMMrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJMMrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:47:46 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4176F037E;
        Thu, 13 Oct 2022 05:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNA9828eB84zVCbC4M2mGuuaTZzWCnvCnZdT65yy1SRh+4SYmRUHhMjWP8OIgoGAdaIH4OSKkiC83lc1BhNkgYaDAD5QT75EgjWC1tsS7Mhouw8lx4AqtOiTwIyjGfQeIlszVeQHaOlzEypUkDrwNpLUFFuitV1vCDyWk767CEey5z8i+LXoKJNWv03jjiFAqMumrKcn9j+woNoXeZE+3se/6KO5gQRXLhNVH/luHUTYWmXzLMivvioNNM2CQzup12j7mf7MZIFMp62oKp07INbco0vd6iI7UdvBazMQ+n2AgJelprAw6lojZNe7SjPN6eSyCzyHuxsM0gZUW8Dltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+527ata8ETzfutNcuQY6MJfcIpaZwZ55MYt6+wi2Xk4=;
 b=fYMdHoiHxXqaV/lWzbpw0abgBbWIt3cpIlt/BlRJjLlG8i7AAW/ceyc6vnNia7n6WLYzegWa6ZLn9xAuJv6+YsX8qXMcbiutb9sQ3+cC2e3BjR7FLdgNydhQNAlFY3yAUTR6IiwqCRQbVyv+zLKzytZ4nj1Yycma15Wd9jO6XUlA8EzNePQAU3fVJbdKMt5p1E38Yd3lXlraq+CyKzgmy60plCozmfGnaBI08TsHnM6n8dpsZGDEDX99DZOqYi+KVhN4HVsTof1p90tcclW+DQ/Uul8CS0jrbdQh/bAvsnjgNskIlkxaVGu4I3TMRHTy8oBVPYMJyLJY7Fdld6Fn3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+527ata8ETzfutNcuQY6MJfcIpaZwZ55MYt6+wi2Xk4=;
 b=edCDCRg/DMouKEyiN8qSpcy7DAmdoG0Xtl0GEHFH7k/xAwU2jUpdTxIiVmhJvShTpmWzwa8uKQdB1eM8xdi65Or/1ful1CkirILoSSj7lS8f0T2WOsPXMt0rVbmq9EKOU8waTsQBEkUNbEXx6Tmn59HAGwL03drpQKwrj1n0S2Q=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9212.eurprd04.prod.outlook.com (2603:10a6:10:2fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 12:47:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Thu, 13 Oct 2022
 12:47:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "S.J. Wang" <shengjiu.wang@nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>
Subject: RE: [PATCH] remoteproc: core: Auto select rproc-virtio device id
Thread-Topic: [PATCH] remoteproc: core: Auto select rproc-virtio device id
Thread-Index: AQHY3q9adSuOrIoTmESz5WeUdSOak64MRjFQ
Date:   Thu, 13 Oct 2022 12:47:43 +0000
Message-ID: <DU0PR04MB941728B0F306EE5FA35738B388259@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <1665628087-20829-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1665628087-20829-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB9212:EE_
x-ms-office365-filtering-correlation-id: adba5df8-ad85-4f21-a4a1-08daad191f02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Uvz19X250DgE5fGBfsWz1R/MCa5X9ATcpd0S0Lc6LVBmAIsA2YwRwbO0tvmZAmOLipQr4HfBsmnH1ITG5P5IXqHbK3jJqG0XQk31Y7lGTi66kPAL+BCRhtr3TDaJiKy6kuE1DDZr4rLfiNqh2RAVRfRjZ5qhNyzUUPDQUTOOrBUaw82qEwcLP0FjP8fjVz3R5EF8cKvnR5IH96D3SqbW0+ZGQcL9BPsZBSYoHFxHmOGqflEq9YSnl/cBkHXyyAHa5uuXFyLaNMkgWkRfKgdSHEV97RdNhKXHtlQ+H2xoRlKpnPDGoDGo2/3ITVyyAbW85LnOZ9ZLnt92VXYyky77c6AzKSdrAFv7Qes/eT8XyMIVi0aSaDPanoYXpWkORrUcBkFNZrkVREm0C5Jy0tsMVv93TJzLMnxMy9PRrA4yvaquj6TNcV5g5x5J2P9XPNIFw9OS/8CvVN2sm1PzDxBRIDHiKGLvbNEonUbtGxX8CszNib68hhx87fC+F946UcbvN4EYcHcgtllGOHHxmcqSUcZaw2oL3aBPtkmexkcUdnRF67d+hBh/HnewP8BVL+blpWP/nJIOSxQ0N7xtFrDXOrTIPhK/mvW6p7K2Io4l1MoZrdlmwqsfvpiMjUGaIYTk6mGHQS/f/ndS5T2LgdDm1Ib1LwQo7ytSkofqxKf/JE6JgoNSmdPScZUCfeXvoo0MtABZFaX9TmDMLcxBNxZEiNLsxzr5ehldJjPrC3y63rpSa1xtMSN7ohM/yUXv6w7+5anoXi/IjChJD2FUKtwbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(38070700005)(5660300002)(38100700002)(55016003)(110136005)(4326008)(64756008)(54906003)(316002)(66476007)(66446008)(8676002)(66946007)(76116006)(66556008)(478600001)(41300700001)(6506007)(7696005)(86362001)(186003)(9686003)(8936002)(52536014)(26005)(71200400001)(44832011)(2906002)(122000001)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VrQRO7CFZysaN2RhBfSZZXc/KoqwFqvDyHcSqsoRzYACGHJ62yQxaAq0yPZV?=
 =?us-ascii?Q?+jwQGNsZzpj6ATXC2I3C4Wk8cesscTCyVFqLJ1MKAdaR8DkS4Fr6tlyrM+m3?=
 =?us-ascii?Q?ygvHQUmSLQ7IH37C1E9/XF9zN5uIBx1hh74DPB3ZzofuY9fij76p3M7a0c5o?=
 =?us-ascii?Q?MFzy4yGHcbvLnX9sEuNw6Jt2FmJd77UnJzjsdGs6jdwq0c6PRqHUiLkR45vk?=
 =?us-ascii?Q?rBB6CiA6u5Nm7wz+4kma0PMym9ChXyxiUqGYNTnFfPvYvXzSRQTf4FwzJEqa?=
 =?us-ascii?Q?qUAZn5NyiVd+4pWW4/f+iKY801+Jw/m2Hv6WXhnyBDhxnRPKAUKC2A/mv9BW?=
 =?us-ascii?Q?UO8XaQYb2alxEXygv9sL9l19tPxqJKICW8uRsoO2lj5VBjIV0Fb774Z33gAq?=
 =?us-ascii?Q?DQ1jX7hbyHtDWpj//2eJ0iv/SQnn0hLs1KIGsULsBjJRZNDvpluhp4O+G64Y?=
 =?us-ascii?Q?AUfZVNAFspQSTN+Uf65y8w22vCTi8+Yf3D9HqG+LA9/iVSJrkF9cwMm8coJK?=
 =?us-ascii?Q?/L6f6UY2Uv7YVGeVRSt8UXMGodioN+MMY1Y0tCrscmMCxlX02wZFL9REy3ak?=
 =?us-ascii?Q?kAKBB4uDBVzc5+UT2QZYwdMA7mgLWdswz3avBLcQlYXPmE5Ed1ar44tryZok?=
 =?us-ascii?Q?UxzjJy4pvMRF9rLxREVl8xw73DbY95Fx6eXrpFe2fU6so8cr2c5xfxwoARIg?=
 =?us-ascii?Q?iz5Ob733Bojb7lKToJW39esAo13lsQ044LfVrIPS/19igGjCHkLiQRoDv3El?=
 =?us-ascii?Q?sXuPxOW5hb0cO3kiV+T1CBrIXGMWmYLkUVKMQuiBYbJ5L4bnRPXFw1EVcl+C?=
 =?us-ascii?Q?x2LNGz31vjyK06T+JWoNufuLtXefVaUDm3LTZz4/U2MpeCEYaoPi3zFm+I8v?=
 =?us-ascii?Q?jRGmIGQeF9I691ctKMF5mxzs4eELttHqwjABBYJOeSWoM0tkg7qceNAQPq1d?=
 =?us-ascii?Q?YFODZ22ecOuJgG8/T0A02qjK/veB8yYol5QcWNeuk89oWPhPyvrnAXGVNrWL?=
 =?us-ascii?Q?fZWGGAVp6JIWNU5Djd0Ypg/2hlr0oXuFdGZ3Ka0396Vu+L0jETS+mE5qc3Ds?=
 =?us-ascii?Q?srC8qacIWtBlnUYOhGM1745ZukoxLc9NI0iLeIL0UbqLpgjAsE7rlxMJP9Tu?=
 =?us-ascii?Q?N+QKatsiwdEagboaHkbUT78WumxcJTF73Z3B/jIAqZnC4WP0AKvQAv0hz5LN?=
 =?us-ascii?Q?mXNcQO4fj5MzGBK7iM9+o9HjFTnsHjesb0ZDSbizJp6KKszYbu0bRaoecLzs?=
 =?us-ascii?Q?sWT37okxEhHMyPT5QUmZPC5VefvBb15pi8uA5Dl/Kc/VOhzF/CNsR0Gzx1an?=
 =?us-ascii?Q?98t4G8v/w0ak05kTCcBxNDeb2yCq5WPH0em93gcRxCs4YcQVDmqAeE6DAYvp?=
 =?us-ascii?Q?d8+lLCVfKKCnvgMTzqN3tt4p+VENM4n43zTaNq8sQj2W6/glRXCDOeY7KTyF?=
 =?us-ascii?Q?Dlw3xP0ymwWyMR3b9Q8U8V56pdixuvCiLlBi5A7NfKAu2d68ROEOZwXAldTA?=
 =?us-ascii?Q?pgS54PqO2X2gIHEj+ym1JoszqBt8MQH+jwEru6HiBQmMXHPArw2/1KllbMbG?=
 =?us-ascii?Q?tfC+jn+yy2/HsfVKX/1h2636pGnbUc4g09ASdImN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adba5df8-ad85-4f21-a4a1-08daad191f02
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 12:47:43.1782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bREGhgXdvkyYqt3xstjobNqUXLnJSQ7biAN+ACOcgLZy7gc5iHOjlbS1tPqCvsGZvMWXkCmODMSP9unIc36VOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9212
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] remoteproc: core: Auto select rproc-virtio device id
>=20
> With multiple remoteproc device, there will below error:
>=20
> sysfs: cannot create duplicate filename '/bus/platform/devices/rproc-
> virtio.0'
>=20
> The rvdev_data.index is duplicate, that cause issue, so need to use the
> PLATFORM_DEVID_AUTO instead.
>=20
> Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the
> remoteproc_virtio")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Met same issue with on i.MX8QM-MEK dual CM4 case, and I tested same
approach as you did.

Tested-by: Peng Fan <peng.fan@nxp.com>

> ---
>  drivers/remoteproc/remoteproc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> index 8768cb64f560..03a26498e879 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -509,7 +509,7 @@ static int rproc_handle_vdev(struct rproc *rproc,
> void *ptr,
>  	rvdev_data.rsc_offset =3D offset;
>  	rvdev_data.rsc =3D rsc;
>=20
> -	pdev =3D platform_device_register_data(dev, "rproc-virtio",
> rvdev_data.index, &rvdev_data,
> +	pdev =3D platform_device_register_data(dev, "rproc-virtio",
> +PLATFORM_DEVID_AUTO, &rvdev_data,
>  					     sizeof(rvdev_data));
>  	if (IS_ERR(pdev)) {
>  		dev_err(dev, "failed to create rproc-virtio device\n");
> --
> 2.34.1

