Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A1674FB89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjGKW7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjGKW7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:59:13 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2041.outbound.protection.outlook.com [40.107.15.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D5F10FA;
        Tue, 11 Jul 2023 15:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEPM/feOnOI9UWceiSzQTydPvqlS/JkIT8rLS009cDcvLi2tq8rhut8e01YOGKX1wl3xiw3k4gvNQOmwAQIc9Gp1VVTGWjNXrSswy8mcuOKvzYQYcbFUVY4KVMW6fAPdgbPMiCRRJ/FbBJyvPja96LKVHjQ3GD1fv+Xrj3rqkPxLJwDZT/vsBQj+wGQn/u/QW3Oj/dndYYbiqWG01SjWfCwWi8l9bhkG7fw+c6CVvHn67RaxKQbjYnJdZzsCL8LEk2dyRKGV4VgegCO/RSepKSY0iPRmC1v2uZVXE4iYzz2g5KcsHLa0af5B0Xx9Etfl6KU5wF0T8kHZig4q6T4f7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJJL33S4QA1qmUfKyQM1v5Icjz+7lDFFzHuSeM+o8S4=;
 b=VAyqAQjv718vG1SO8BLy+3lj2fl4HlMw8rR+Sgqukritihrp57DqtqacnPIG9PuJRR1UeQ2ocRP4kE9tZJDZTfINtPQuoxPGWQDMh14qDE2MMxgRGhL0eCQi+KrcFqwm0vlmF/lReT7Tdt/JKkaY2d8yOgG08AO6iIzUFQTWTmMmfJ2ClcefCkA5KhbUtXIuL/zaQ3bTunMIWHMICXI53MjzRYF7Lg/gvvqAIPFsNopSRr7OEx/YO++wj+xk8MhpR2fK1f9+ZD5JZ0F8wV8OLS1uShsqJpwpnjuul2FxfnyDZ+LsJAEOd5Xrcjzkgnc+XiIK977IxYmHVJHNewJctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJJL33S4QA1qmUfKyQM1v5Icjz+7lDFFzHuSeM+o8S4=;
 b=aDv8ckw/atV5bsop2JSF5jL04h+tFpUIY/OPgaPRYS0qlcV+IHNbsnr/OuKGvR1P/o7umS+OzoI/Q89mckCo4UtIU68Jjd7Xf+ik2Wil77SDvfC/l/Y/C3tyNMl0MU8j8aaeK/LoONC2VmTKFWwTA6Qk83I4BGelfItnvwYl3/k=
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by AM7PR04MB6901.eurprd04.prod.outlook.com (2603:10a6:20b:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 22:59:02 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::7920:7c26:e953:83ac]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::7920:7c26:e953:83ac%7]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 22:59:02 +0000
From:   "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>
To:     Ming Qian <ming.qian@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] media: imx-jpeg: Support to assign slot for
 encoder/decoder
Thread-Topic: [PATCH 1/2] media: imx-jpeg: Support to assign slot for
 encoder/decoder
Thread-Index: AQHZksbIWvMEnmELxku2a2STBGc5VK+1cQJA
Date:   Tue, 11 Jul 2023 22:59:02 +0000
Message-ID: <AS4PR04MB924412B335C0478F54CF33258F31A@AS4PR04MB9244.eurprd04.prod.outlook.com>
References: <cdadb4a23697fdc97def958c69b12cd00f547212.1685430841.git.ming.qian@nxp.com>
In-Reply-To: <cdadb4a23697fdc97def958c69b12cd00f547212.1685430841.git.ming.qian@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9244:EE_|AM7PR04MB6901:EE_
x-ms-office365-filtering-correlation-id: 0cda0db1-5702-4901-a810-08db82626b51
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1eLEJX/3tzmGlABDuyojgi4Bc17bR1Qx9ggGnIqpzitmc4rw63c3z0GikzWTTEqeIEHDk2assepkYGF0ARPcflcF4jSWspcW/MYI+ScC83dcyncqbrJnlOoVnNnvb+Z/v6K2jgurSIUk+EFX6IzYdVFPY6Ircr4b/yYxls3AVrsGxdrieDz3A1/EzTuGBCREshjNklHX1QJEl7/stY08aVx+eKRkjZ7FJNwtZmAKa0ewiD3Ot7WMuu6c4jqnQn1P80f7V/qhyC/bOftLUZ2dd7tqEsP7GVV902oATyvfk4PAMbPvKXEG08YV7F0LZuf0cOQo6NYemFpGzKl700xdcdI3uUA6tqvJmUxZaYFPnfi4z4xTmOnVE8b8URkMxda0ujJI+QC17ZJQP2NPVy3Ab1arLJOAkuXMAQQ9tN4q6kxrQmXXwsQApArk2CZ5SErw/g3EXMbCOJFjNemp/8ik9D4a1NhvpztIgORzim41RXsm/gz16Umve9nmyZUsxXlanoRCz7GcuEAQeGIE3WnEK6xBfdE3Nt3VbpwdjDl3BvR0fBSCtCr3lw1Qe3uuGu3WluzaThyMsH6NGnCRuW2S9Be2wSqfu1gHSQ9IAKpdtXETC6o5NyYGIwS8WvMCQz9M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(83380400001)(30864003)(2906002)(38070700005)(33656002)(86362001)(38100700002)(122000001)(55016003)(41300700001)(4326008)(316002)(7696005)(5660300002)(8936002)(8676002)(478600001)(71200400001)(64756008)(66446008)(76116006)(66476007)(66556008)(54906003)(110136005)(66946007)(26005)(186003)(6506007)(52536014)(7416002)(53546011)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZX44htLcrv9wH52MTebWZKHbg/NZcYy5kUtvucATZJexdwqOVe3rH00HHI3H?=
 =?us-ascii?Q?e6jbgLCzsXX07SFLAHBe5Wjzfmp5VwFj/Ud03Fs56oWMcGxLEm0MeA0uvibC?=
 =?us-ascii?Q?xeLosg5ymNPHQsQuK3A0ZC4z+gdLZ1AphETSd7ju+ZK1PUlHu8tACy1Hi+xw?=
 =?us-ascii?Q?xUUf8lZgi2SbYQDUlClU9yXxmUozYt9vvOYB6+iT805VyLzU+spI2n9PSJBc?=
 =?us-ascii?Q?VPm7ig2PHRZwIEyQSRpYsISAGZwB8CkkulgnPKyyIApJ9tyl/KxgmjyIJ6PX?=
 =?us-ascii?Q?TEtzko5QVgDHigqU8ps3zCWaHWrbdNH97VnIyzWaOmONr0Q9rrkTdORlM6eQ?=
 =?us-ascii?Q?S0Pkf5uqA5sbQgimPk8KnfrRdin1U/F/Hokoakwp8cx30ScUQqW5Ztak6J48?=
 =?us-ascii?Q?BFxOIC3FU9j4cu5/s+1llWKlD8zv1Tz2QLGnGOryd94FHgZWaVZdmf+XO8GR?=
 =?us-ascii?Q?KtvMlrVRsCl4+eUDMr1O/KOFrpLAEsHgvO0DuOUsLpdfMXalIbvuj3Oxoa28?=
 =?us-ascii?Q?AVSEUxsPUKVcxqc4gfK3HS9T6xYr/N//tX3b4yCDkYOksOSqPvxFfnp1t5fO?=
 =?us-ascii?Q?LDvzU6EWQIvWue33K3lQKl/NsaX/ZKm/ET49FNVayEP7iWZkyedUze8kPljk?=
 =?us-ascii?Q?ksJbo6OspQ/LS5VIZ6hbteIw9cpkU/HZRhTy6vyiVozl+cHrCiP09z/561eN?=
 =?us-ascii?Q?QgmOv72LFEzVYU2tYgg5l61CxDof8WIovZg1rUr/QvnWQoQAdd20KGpngHuP?=
 =?us-ascii?Q?iEKXCvQI5sE+yRgwTzq2JYwb2ODIqLT3/VvsUnZnJ4IE/bYoKkmnxlGsdLMd?=
 =?us-ascii?Q?a5ZGhWKFlFY1wVpcHmt2y9U+j8SNQ+hoP2hj448b/EWnFS/m6X0S5Mfqe56X?=
 =?us-ascii?Q?q7AjW+wm14J+BYrgu301Xl1C37p1+STkL0dJ4C0RFNJdHjry6OEWyF80thFa?=
 =?us-ascii?Q?vri7McKC/EPSbMHO2Z0EF7kqScJPZWOpGEV7xiUuWnho4pE4S5K1+e35FTl/?=
 =?us-ascii?Q?8BU/rql27pMjCBmoI4+baJYy6ixKUb43Q6nB5o6GmQztBFl6mM7rxr8lPgx+?=
 =?us-ascii?Q?icPDYKxY8XrFxQg4/guWEzPKdJblY9wumQX83IiigXk/56/kQSDcY/YGjYZA?=
 =?us-ascii?Q?r7oLeJtsr+Ksr2VJLBq1DJJni1/D0U+VtFiSDeOB5WM9Gkq8KJsJf9A2dAf2?=
 =?us-ascii?Q?mC79yKsRyhgZTYIT5szTOAZozVbBMTGa+OO4dCwdNh6BcczYsK6W2C35JzeF?=
 =?us-ascii?Q?G7EbYZopk9HI/R/hECv//U5D1EM9jJ88pqEKcW8qbUI5LrblKRv6mO76zc93?=
 =?us-ascii?Q?5EcvxlrgEoMWR2wTaI4UF786k+hyqvqiHOwuSmEmIcKs+qEWxBs1ym6AnWYS?=
 =?us-ascii?Q?iOXCsHsq8/wAaIYlkq8mdeaopW22vqK/XCHS1qj6hGIMK3sG8jfnLcsjZEZ1?=
 =?us-ascii?Q?Ug1L9debEfklRnyYTTKPYRiLbCF5QdHquxolBj20GXlv2Ytxu9Y7wQwjVj4F?=
 =?us-ascii?Q?ikJU/lO5hx7P/qcbG5MdkW3OuAwpeXa3BaiKtA1YEodNhztP3VQcChB4qguk?=
 =?us-ascii?Q?EXphEL/qxGn5V6s0kRSM4n7Y4F+IsmYBAzgO9y/g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cda0db1-5702-4901-a810-08db82626b51
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 22:59:02.1687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMFoCAvKX8OAIgdhYWJmCJqbrjX1PRi2Plhs+fCIopgNgJ7mOu0HVe3nD2ypb8MK/zTN6p0hTi6/PBdMcxTzCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6901
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

> -----Original Message-----
> From: Ming Qian <ming.qian@nxp.com>
> Sent: Tuesday, May 30, 2023 10:17 AM
> To: mchehab@kernel.org; Mirela Rabulea (OSS) <mirela.rabulea@oss.nxp.com>=
;
> hverkuil-cisco@xs4all.nl
> Cc: shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; X.H. Bao <xiahong.bao@nxp.com>; dl-linux-imx <linux-
> imx@nxp.com>; linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: [PATCH 1/2] media: imx-jpeg: Support to assign slot for
> encoder/decoder
>=20
> imx jpeg encoder and decoder support 4 slots each, aim to support some
> virtualization scenarios.
>=20
> driver should only enable one slot one time.

I somehow disagree with this, the hardware is capable of doing context swit=
ching between the 4 slots, unfortunately a feature which we did not get to =
test enough.
The initial aim for the current slot design in the driver was to allow slot=
 assignment per-context (per device node opened file handle), so we could h=
ave up to 4 opens, each one with its context, to be  serviced by the hardwa=
re in round-robin manner. Since this was limiting the number of opens, and =
v4l2-compliance was failing on the unlimited opens test, I moved the slot a=
cquiring to a later point, in device_run, and also limited the maximum slot=
s to 1 instead of 4, due to issues when running on other slots than the fir=
st one.

>=20
> but due to some hardware issue,
> only slot 0 can be enabled in imx8q platform, and they may be fixed in im=
x9
> platform.

I don't think it's ok to limit the driver to using just one slot, the slot =
which is hardcoded in the dts. I suggest to hold off this patch series unti=
l we have a more clear picture how we want to change it for imx9.

>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  .../media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h |   1 -
>  .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 135 +++++++++---------
>  .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |   5 +-
>  3 files changed, 68 insertions(+), 73 deletions(-)
>=20
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> index ed15ea348f97..a2b4fb9e29e7 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
> @@ -58,7 +58,6 @@
>  #define CAST_OFBSIZE_LO			CAST_STATUS18
>  #define CAST_OFBSIZE_HI			CAST_STATUS19
>=20
> -#define MXC_MAX_SLOTS	1 /* TODO use all 4 slots*/
>  /* JPEG-Decoder Wrapper Slot Registers 0..3 */
>  #define SLOT_BASE			0x10000
>  #define SLOT_STATUS			0x0
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index c0e49be42450..9512c0a61966 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -745,87 +745,77 @@ static void notify_src_chg(struct mxc_jpeg_ctx *ctx=
)
>  	v4l2_event_queue_fh(&ctx->fh, &ev);
>  }
>=20
> -static int mxc_get_free_slot(struct mxc_jpeg_slot_data slot_data[], int =
n)
> +static int mxc_get_free_slot(struct mxc_jpeg_slot_data *slot_data)
>  {
> -	int free_slot =3D 0;
> -
> -	while (slot_data[free_slot].used && free_slot < n)
> -		free_slot++;
> -
> -	return free_slot; /* >=3Dn when there are no more free slots */
> +	if (!slot_data->used)
> +		return slot_data->slot;
> +	return -1;
>  }
>=20
> -static bool mxc_jpeg_alloc_slot_data(struct mxc_jpeg_dev *jpeg,
> -				     unsigned int slot)
> +static bool mxc_jpeg_alloc_slot_data(struct mxc_jpeg_dev *jpeg)
>  {
>  	struct mxc_jpeg_desc *desc;
>  	struct mxc_jpeg_desc *cfg_desc;
>  	void *cfg_stm;
>=20
> -	if (jpeg->slot_data[slot].desc)
> +	if (jpeg->slot_data.desc)
>  		goto skip_alloc; /* already allocated, reuse it */
>=20
>  	/* allocate descriptor for decoding/encoding phase */
>  	desc =3D dma_alloc_coherent(jpeg->dev,
>  				  sizeof(struct mxc_jpeg_desc),
> -				  &jpeg->slot_data[slot].desc_handle,
> +				  &jpeg->slot_data.desc_handle,
>  				  GFP_ATOMIC);
>  	if (!desc)
>  		goto err;
> -	jpeg->slot_data[slot].desc =3D desc;
> +	jpeg->slot_data.desc =3D desc;
>=20
>  	/* allocate descriptor for configuration phase (encoder only) */
>  	cfg_desc =3D dma_alloc_coherent(jpeg->dev,
>  				      sizeof(struct mxc_jpeg_desc),
> -				      &jpeg->slot_data[slot].cfg_desc_handle,
> +				      &jpeg->slot_data.cfg_desc_handle,
>  				      GFP_ATOMIC);
>  	if (!cfg_desc)
>  		goto err;
> -	jpeg->slot_data[slot].cfg_desc =3D cfg_desc;
> +	jpeg->slot_data.cfg_desc =3D cfg_desc;
>=20
>  	/* allocate configuration stream */
>  	cfg_stm =3D dma_alloc_coherent(jpeg->dev,
>  				     MXC_JPEG_MAX_CFG_STREAM,
> -				     &jpeg->slot_data[slot].cfg_stream_handle,
> +				     &jpeg->slot_data.cfg_stream_handle,
>  				     GFP_ATOMIC);
>  	if (!cfg_stm)
>  		goto err;
> -	jpeg->slot_data[slot].cfg_stream_vaddr =3D cfg_stm;
> +	jpeg->slot_data.cfg_stream_vaddr =3D cfg_stm;
>=20
>  skip_alloc:
> -	jpeg->slot_data[slot].used =3D true;
> +	jpeg->slot_data.used =3D true;
>=20
>  	return true;
>  err:
> -	dev_err(jpeg->dev, "Could not allocate descriptors for slot %d", slot);
> +	dev_err(jpeg->dev, "Could not allocate descriptors for slot %d",
> +jpeg->slot_data.slot);
>=20
>  	return false;
>  }
>=20
> -static void mxc_jpeg_free_slot_data(struct mxc_jpeg_dev *jpeg,
> -				    unsigned int slot)
> +static void mxc_jpeg_free_slot_data(struct mxc_jpeg_dev *jpeg)
>  {
> -	if (slot >=3D MXC_MAX_SLOTS) {
> -		dev_err(jpeg->dev, "Invalid slot %d, nothing to free.", slot);
> -		return;
> -	}
> -
>  	/* free descriptor for decoding/encoding phase */
>  	dma_free_coherent(jpeg->dev, sizeof(struct mxc_jpeg_desc),
> -			  jpeg->slot_data[slot].desc,
> -			  jpeg->slot_data[slot].desc_handle);
> +			  jpeg->slot_data.desc,
> +			  jpeg->slot_data.desc_handle);
>=20
>  	/* free descriptor for encoder configuration phase / decoder DHT */
>  	dma_free_coherent(jpeg->dev, sizeof(struct mxc_jpeg_desc),
> -			  jpeg->slot_data[slot].cfg_desc,
> -			  jpeg->slot_data[slot].cfg_desc_handle);
> +			  jpeg->slot_data.cfg_desc,
> +			  jpeg->slot_data.cfg_desc_handle);
>=20
>  	/* free configuration stream */
>  	dma_free_coherent(jpeg->dev, MXC_JPEG_MAX_CFG_STREAM,
> -			  jpeg->slot_data[slot].cfg_stream_vaddr,
> -			  jpeg->slot_data[slot].cfg_stream_handle);
> +			  jpeg->slot_data.cfg_stream_vaddr,
> +			  jpeg->slot_data.cfg_stream_handle);
>=20
> -	jpeg->slot_data[slot].used =3D false;
> +	jpeg->slot_data.used =3D false;
>  }
>=20
>  static void mxc_jpeg_check_and_set_last_buffer(struct mxc_jpeg_ctx *ctx,=
 @@
> -855,7 +845,7 @@ static void mxc_jpeg_job_finish(struct mxc_jpeg_ctx *ctx=
,
> enum vb2_buffer_state
>  	v4l2_m2m_buf_done(dst_buf, state);
>=20
>  	mxc_jpeg_disable_irq(reg, ctx->slot);
> -	ctx->mxc_jpeg->slot_data[ctx->slot].used =3D false;
> +	jpeg->slot_data.used =3D false;
>  	if (reset)
>  		mxc_jpeg_sw_reset(reg);
>  }
> @@ -919,7 +909,7 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *pr=
iv)
>  		goto job_unlock;
>  	}
>=20
> -	if (!jpeg->slot_data[slot].used)
> +	if (!jpeg->slot_data.used)
>  		goto job_unlock;
>=20
>  	dec_ret =3D readl(reg + MXC_SLOT_OFFSET(slot, SLOT_STATUS)); @@ -
> 1179,13 +1169,13 @@ static void mxc_jpeg_config_dec_desc(struct vb2_buffe=
r
> *out_buf,
>  	struct mxc_jpeg_dev *jpeg =3D ctx->mxc_jpeg;
>  	void __iomem *reg =3D jpeg->base_reg;
>  	unsigned int slot =3D ctx->slot;
> -	struct mxc_jpeg_desc *desc =3D jpeg->slot_data[slot].desc;
> -	struct mxc_jpeg_desc *cfg_desc =3D jpeg->slot_data[slot].cfg_desc;
> -	dma_addr_t desc_handle =3D jpeg->slot_data[slot].desc_handle;
> -	dma_addr_t cfg_desc_handle =3D jpeg->slot_data[slot].cfg_desc_handle;
> -	dma_addr_t cfg_stream_handle =3D jpeg-
> >slot_data[slot].cfg_stream_handle;
> -	unsigned int *cfg_size =3D &jpeg->slot_data[slot].cfg_stream_size;
> -	void *cfg_stream_vaddr =3D jpeg->slot_data[slot].cfg_stream_vaddr;
> +	struct mxc_jpeg_desc *desc =3D jpeg->slot_data.desc;
> +	struct mxc_jpeg_desc *cfg_desc =3D jpeg->slot_data.cfg_desc;
> +	dma_addr_t desc_handle =3D jpeg->slot_data.desc_handle;
> +	dma_addr_t cfg_desc_handle =3D jpeg->slot_data.cfg_desc_handle;
> +	dma_addr_t cfg_stream_handle =3D jpeg->slot_data.cfg_stream_handle;
> +	unsigned int *cfg_size =3D &jpeg->slot_data.cfg_stream_size;
> +	void *cfg_stream_vaddr =3D jpeg->slot_data.cfg_stream_vaddr;
>  	struct mxc_jpeg_src_buf *jpeg_src_buf;
>=20
>  	jpeg_src_buf =3D vb2_to_mxc_buf(src_buf); @@ -1245,18 +1235,18 @@
> static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
>  	struct mxc_jpeg_dev *jpeg =3D ctx->mxc_jpeg;
>  	void __iomem *reg =3D jpeg->base_reg;
>  	unsigned int slot =3D ctx->slot;
> -	struct mxc_jpeg_desc *desc =3D jpeg->slot_data[slot].desc;
> -	struct mxc_jpeg_desc *cfg_desc =3D jpeg->slot_data[slot].cfg_desc;
> -	dma_addr_t desc_handle =3D jpeg->slot_data[slot].desc_handle;
> -	dma_addr_t cfg_desc_handle =3D jpeg->slot_data[slot].cfg_desc_handle;
> -	void *cfg_stream_vaddr =3D jpeg->slot_data[slot].cfg_stream_vaddr;
> +	struct mxc_jpeg_desc *desc =3D jpeg->slot_data.desc;
> +	struct mxc_jpeg_desc *cfg_desc =3D jpeg->slot_data.cfg_desc;
> +	dma_addr_t desc_handle =3D jpeg->slot_data.desc_handle;
> +	dma_addr_t cfg_desc_handle =3D jpeg->slot_data.cfg_desc_handle;
> +	void *cfg_stream_vaddr =3D jpeg->slot_data.cfg_stream_vaddr;
>  	struct mxc_jpeg_q_data *q_data;
>  	enum mxc_jpeg_image_format img_fmt;
>  	int w, h;
>=20
>  	q_data =3D mxc_jpeg_get_q_data(ctx, src_buf->vb2_queue->type);
>=20
> -	jpeg->slot_data[slot].cfg_stream_size =3D
> +	jpeg->slot_data.cfg_stream_size =3D
>  			mxc_jpeg_setup_cfg_stream(cfg_stream_vaddr,
>  						  q_data->fmt->fourcc,
>  						  q_data->crop.width,
> @@ -1265,7 +1255,7 @@ static void mxc_jpeg_config_enc_desc(struct
> vb2_buffer *out_buf,
>  	/* chain the config descriptor with the encoding descriptor */
>  	cfg_desc->next_descpt_ptr =3D desc_handle | MXC_NXT_DESCPT_EN;
>=20
> -	cfg_desc->buf_base0 =3D jpeg->slot_data[slot].cfg_stream_handle;
> +	cfg_desc->buf_base0 =3D jpeg->slot_data.cfg_stream_handle;
>  	cfg_desc->buf_base1 =3D 0;
>  	cfg_desc->line_pitch =3D 0;
>  	cfg_desc->stm_bufbase =3D 0; /* no output expected */ @@ -1408,7
> +1398,7 @@ static void mxc_jpeg_device_run_timeout(struct work_struct
> *work)
>  	unsigned long flags;
>=20
>  	spin_lock_irqsave(&ctx->mxc_jpeg->hw_lock, flags);
> -	if (ctx->slot < MXC_MAX_SLOTS && ctx->mxc_jpeg->slot_data[ctx-
> >slot].used) {
> +	if (ctx->mxc_jpeg->slot_data.used) {
>  		dev_warn(jpeg->dev, "%s timeout, cancel it\n",
>  			 ctx->mxc_jpeg->mode =3D=3D MXC_JPEG_DECODE ?
> "decode" : "encode");
>  		mxc_jpeg_job_finish(ctx, VB2_BUF_STATE_ERROR, true); @@ -
> 1476,12 +1466,12 @@ static void mxc_jpeg_device_run(void *priv)
>  	mxc_jpeg_enable(reg);
>  	mxc_jpeg_set_l_endian(reg, 1);
>=20
> -	ctx->slot =3D mxc_get_free_slot(jpeg->slot_data, MXC_MAX_SLOTS);
> -	if (ctx->slot >=3D MXC_MAX_SLOTS) {
> +	ctx->slot =3D mxc_get_free_slot(&jpeg->slot_data);
> +	if (ctx->slot < 0) {
>  		dev_err(dev, "No more free slots\n");
>  		goto end;
>  	}
> -	if (!mxc_jpeg_alloc_slot_data(jpeg, ctx->slot)) {
> +	if (!mxc_jpeg_alloc_slot_data(jpeg)) {
>  		dev_err(dev, "Cannot allocate slot data\n");
>  		goto end;
>  	}
> @@ -2101,7 +2091,7 @@ static int mxc_jpeg_open(struct file *file)
>  	}
>  	ctx->fh.ctrl_handler =3D &ctx->ctrl_handler;
>  	mxc_jpeg_set_default_params(ctx);
> -	ctx->slot =3D MXC_MAX_SLOTS; /* slot not allocated yet */
> +	ctx->slot =3D -1; /* slot not allocated yet */
>  	INIT_DELAYED_WORK(&ctx->task_timer,
> mxc_jpeg_device_run_timeout);
>=20
>  	if (mxc_jpeg->mode =3D=3D MXC_JPEG_DECODE) @@ -2677,6 +2667,11
> @@ static int mxc_jpeg_attach_pm_domains(struct mxc_jpeg_dev *jpeg)
>  		dev_err(dev, "No power domains defined for jpeg node\n");
>  		return jpeg->num_domains;
>  	}
> +	if (jpeg->num_domains =3D=3D 1) {
> +		/* genpd_dev_pm_attach() attach automatically if power
> domains count is 1 */

This looks like dead code to me, we always have at least 2 power domains (e=
x: IMX_SC_R_MJPEG_DEC_MP & IMX_SC_R_MJPEG_DEC_S0) ?

Regards,
Mirela

> +		jpeg->num_domains =3D 0;
> +		return 0;
> +	}
>=20
>  	jpeg->pd_dev =3D devm_kmalloc_array(dev, jpeg->num_domains,
>  					  sizeof(*jpeg->pd_dev), GFP_KERNEL);
> @@ -2718,7 +2713,6 @@ static int mxc_jpeg_probe(struct platform_device
> *pdev)
>  	int ret;
>  	int mode;
>  	const struct of_device_id *of_id;
> -	unsigned int slot;
>=20
>  	of_id =3D of_match_node(mxc_jpeg_match, dev->of_node);
>  	if (!of_id)
> @@ -2742,19 +2736,22 @@ static int mxc_jpeg_probe(struct platform_device
> *pdev)
>  	if (IS_ERR(jpeg->base_reg))
>  		return PTR_ERR(jpeg->base_reg);
>=20
> -	for (slot =3D 0; slot < MXC_MAX_SLOTS; slot++) {
> -		dec_irq =3D platform_get_irq(pdev, slot);
> -		if (dec_irq < 0) {
> -			ret =3D dec_irq;
> -			goto err_irq;
> -		}
> -		ret =3D devm_request_irq(&pdev->dev, dec_irq, mxc_jpeg_dec_irq,
> -				       0, pdev->name, jpeg);
> -		if (ret) {
> -			dev_err(&pdev->dev, "Failed to request irq %d (%d)\n",
> -				dec_irq, ret);
> -			goto err_irq;
> -		}
> +	ret =3D of_property_read_u32_index(pdev->dev.of_node, "slot", 0, &jpeg-
> >slot_data.slot);
> +	if (ret)
> +		jpeg->slot_data.slot =3D 0;
> +	dev_info(&pdev->dev, "choose slot %d\n", jpeg->slot_data.slot);
> +	dec_irq =3D platform_get_irq(pdev, 0);
> +	if (dec_irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get irq %d\n", dec_irq);
> +		ret =3D dec_irq;
> +		goto err_irq;
> +	}
> +	ret =3D devm_request_irq(&pdev->dev, dec_irq, mxc_jpeg_dec_irq,
> +			       0, pdev->name, jpeg);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request irq %d (%d)\n",
> +			dec_irq, ret);
> +		goto err_irq;
>  	}
>=20
>  	jpeg->pdev =3D pdev;
> @@ -2914,11 +2911,9 @@ static const struct dev_pm_ops
> 	mxc_jpeg_pm_ops =3D {
>=20
>  static void mxc_jpeg_remove(struct platform_device *pdev)  {
> -	unsigned int slot;
>  	struct mxc_jpeg_dev *jpeg =3D platform_get_drvdata(pdev);
>=20
> -	for (slot =3D 0; slot < MXC_MAX_SLOTS; slot++)
> -		mxc_jpeg_free_slot_data(jpeg, slot);
> +	mxc_jpeg_free_slot_data(jpeg);
>=20
>  	pm_runtime_disable(&pdev->dev);
>  	video_unregister_device(jpeg->dec_vdev);
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> index 87157db78082..d80e94cc9d99 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
> @@ -97,7 +97,7 @@ struct mxc_jpeg_ctx {
>  	struct mxc_jpeg_q_data		cap_q;
>  	struct v4l2_fh			fh;
>  	enum mxc_jpeg_enc_state		enc_state;
> -	unsigned int			slot;
> +	int				slot;
>  	unsigned int			source_change;
>  	bool				header_parsed;
>  	struct v4l2_ctrl_handler	ctrl_handler;
> @@ -106,6 +106,7 @@ struct mxc_jpeg_ctx {  };
>=20
>  struct mxc_jpeg_slot_data {
> +	int slot;
>  	bool used;
>  	struct mxc_jpeg_desc *desc; // enc/dec descriptor
>  	struct mxc_jpeg_desc *cfg_desc; // configuration descriptor @@ -128,7
> +129,7 @@ struct mxc_jpeg_dev {
>  	struct v4l2_device		v4l2_dev;
>  	struct v4l2_m2m_dev		*m2m_dev;
>  	struct video_device		*dec_vdev;
> -	struct mxc_jpeg_slot_data	slot_data[MXC_MAX_SLOTS];
> +	struct mxc_jpeg_slot_data	slot_data;
>  	int				num_domains;
>  	struct device			**pd_dev;
>  	struct device_link		**pd_link;
>=20
> base-commit: a23a3041c733e068bed5ece88acb45fe0edf0413
> --
> 2.38.1

