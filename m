Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E979674FB69
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjGKWzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjGKWze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:55:34 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2059.outbound.protection.outlook.com [40.107.247.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0978910CF;
        Tue, 11 Jul 2023 15:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz6PFfvG5BF7ygTmvUH7QJ64j0R69yoCJk0YMPv9YBI2gnj/Tgl0dw4n6SFjtzX/D1uqd/GRH4fTyILz1AuRo2CEySdSOA6TpetXnfBbEgh83xNoOtSPnTlUUs27s6gMejFawuH+xiOdinRfSgKtkxhkRce732y0PJjF880bVOrRsZLLRVuydLbR7STr5Sc/MLkVjVCy8WuFiMucGZsR1xzbMHQRmWdkKUFyXdwUlXHVCUyvM105Q97XMMgYA9QCi12rRp6fJtOXj4Mu/BZfMvClEOGkL4I1RrBS0rFsYifVN3kkgP9GeVVgcWmu6FfjigU0P1flbavaG1H7xVNfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcGAn7WaXKCzNi2oPGaaEckxa3uAWHfAiYlKg9cOa/g=;
 b=hhPzgMaJZ46s9f3eDnBRUtekz4K0W78/uhcUG8pOU4RSXORq0QJhhYTsNBV/Gpl8B9pirqiyQkqbwfGmfPpRus18yMHzXSs5zXpi+q83IbModZsKKfmlLjgwrPiRIhz5gcGdhgUPar8s3KyqfgIlYlK/F1NUajXsudi531Kg8AzBwOzR7zjTOqilD6wNeT0mKfIaocAZhPuOVDc2hpMjct4qcSjWmRYqMkl87huFVTu066bXC9CLjOF/WdXXEzdGmywAg75DwX7KsGb30Dzf0eHVAoZ08jnnmmCtz+kmLHzVy7aBc0cyr+KSMXYnUGZkE7eDDeClYq8SsPSURNUVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcGAn7WaXKCzNi2oPGaaEckxa3uAWHfAiYlKg9cOa/g=;
 b=hkyPjYJ+q/XM14Eo0YAyJX0yzXz8J+Cz+P50IQzD7bm16BHCBs/B2Bk01za5kEXmEm9gt0XTYlBga6pZIB3tpCnC2nkg2Hh8RENbg/+Hoz79hwqlEJ+UyXG/XT/woGy+5awEBtPIT4VaqnhbK3TV965stQHP0oFQHsObulgWO+k=
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by PAXPR04MB8335.eurprd04.prod.outlook.com (2603:10a6:102:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 22:55:29 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::7920:7c26:e953:83ac]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::7920:7c26:e953:83ac%7]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 22:55:22 +0000
From:   "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>
To:     Ming Qian <ming.qian@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: imx8-ss-img: Assign slot for imx jpeg
 encoder/decoder
Thread-Topic: [PATCH] arm64: dts: imx8-ss-img: Assign slot for imx jpeg
 encoder/decoder
Thread-Index: AQHZlDIsg2W97I7GdUqCR1rxzYI316+1bSVg
Date:   Tue, 11 Jul 2023 22:55:22 +0000
Message-ID: <AS4PR04MB924427436A88CA83D3A8B4278F31A@AS4PR04MB9244.eurprd04.prod.outlook.com>
References: <20230601023801.25229-1-ming.qian@nxp.com>
In-Reply-To: <20230601023801.25229-1-ming.qian@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9244:EE_|PAXPR04MB8335:EE_
x-ms-office365-filtering-correlation-id: 481a42d8-e222-484a-f109-08db8261e876
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qQpkjcSTizRoCjnFe1miH0wm473ckTFciPpWoPaliJu9QoLZK+VC3iAVf/9duNmGxzakK4+tTQyaz32lq3qmmbpj4fxAwciBzd6ZLEIpPZxXXoMT9+D9Pahw6okmJLMqRfyGAxv81jHIyU+bVmSRWI6xeq0lRNHMfeyJ7YqWwYTlWFThCT3R2eLTxh6DjDDROxAVDgEuMgP3BbnjIbrT92Q30ouN9yHlPf+VlhX0m98kx9uQ3lZItKj26wRWfa2Je4PTCywAUGP5Ht5Z6YuwJQN8vXUyoD9jIUaHhsdDhqjljEUGG1QV7xl9+assEr6BuwXLgJMyh6cBtIWO6cz6EjeEWK15LwYYOKctHCj/3h15i3qp0GIP5szBf238p6Is4321tlqu3nptwtmI8kGwlG+ifNzxhscySBbo+m+zxS2Hg0tS2meosV/nNqD1AvICkZ2r9MbkGRvNN7VXOfV0WADBHnjY1kEnrZC6etjq3ugCAyG6mtMqVMW1ivrgWZzZqnKlxsCx/pajUEPF70Wf5ITHjRIbOzubsGtr6knGV3EjqWiOH/oRMAFDTGhyB81r5mrX4PGfI7hCUHjObBkLjIZ0VsDyQLH6a5+IHuq1+z6NqTQ42+1jLSm8C25mPKcb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(66556008)(66946007)(76116006)(4326008)(66476007)(66446008)(64756008)(478600001)(54906003)(110136005)(55016003)(86362001)(38070700005)(26005)(186003)(6506007)(53546011)(71200400001)(33656002)(9686003)(7696005)(83380400001)(122000001)(38100700002)(41300700001)(8936002)(8676002)(5660300002)(52536014)(316002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gUE10VGpHBV6lHVnI1MpvmCK6lwnYb6Y45OVSAOCi0HoEME9/utzXIFXcPwe?=
 =?us-ascii?Q?QjmB91WtHCswykGwy32HXlhK2WL4DQAcJSqD9YAczDRCn53gJbOixWE8GTcZ?=
 =?us-ascii?Q?tqizllfH5lPTmsBvikxiu9sp4EBp2rv30i3FTV55hwt3r9ibC8ibYD2fSquI?=
 =?us-ascii?Q?7N3t21MHYkxOkjR0LEXxMiqE4kMDdk0zakR/+mvLDCZvQtphgvJQzQOwS9rh?=
 =?us-ascii?Q?UbookMQyXBiePEO4QEtrvSiJ4J6QMfgh3i/6SO7KMruYzR+R8dcBJyc6Wmk2?=
 =?us-ascii?Q?UXabEWiDkJb1auXpQ1oTXrLdVN280NKS3CHMl9XyvZR/CDl+EIsHO/X4KiBx?=
 =?us-ascii?Q?l02JH0uzpqjS6QgX+5Sx459ujS1Z59KtQqueV+ACuU5/oy1miZS/BG5vW3TV?=
 =?us-ascii?Q?lESMvr5qpD9xsSbwSLMBpL2HTiOhkhycIJwvnldYqegEJR4Hudkrh7norCmd?=
 =?us-ascii?Q?eKdqr8euOHHlb+3EkoT36ja7QlMGeRqTPHQlUOt7JNp7Wu+fOOHVVP7wXS54?=
 =?us-ascii?Q?I15lC5emdJwuptj7AYQLHdsnVGqKCTe68IRSDSc2CN5TdJa+triagySlY3G8?=
 =?us-ascii?Q?JxkDXlKOJHePpcg5U28L0/QfeY1xfuHpIekSUM9dzbhpWxxMyQVSRsFkZaNB?=
 =?us-ascii?Q?iwjAHlY5+QMZ47dV1uVHZSzeqxB1ZdEHkHw8kVl/uyznJyQWjYitZOnfXJFO?=
 =?us-ascii?Q?V8gCGKabLTTgT8z4NZ4hiLOV9F5W0qdJ5nOWS5iauvpGK/sDlMovSGwufJeI?=
 =?us-ascii?Q?GDYDxiIg42PBxuAOozqfpTYilGWOFmkKAhLB7NHHP7/YGmJbOOIuP3qWM89I?=
 =?us-ascii?Q?8rYKhEAfrd55jm9v2aSpPJxEE9X9/XJGvEzSdwEX0o2WP8YBLwU2BFLu4Sai?=
 =?us-ascii?Q?jJZJtnbcdNjFt4qHw8jtvKUYPWsQGSGClzmYAnqPsZph+CqFsTqRi9sG7A1G?=
 =?us-ascii?Q?XJ+7fHkBT/ysiqIQ9u/iYUJWlSDa/1Bwx6EFFqGkLkDKOAJs1XjDSs35nJ8+?=
 =?us-ascii?Q?dIT/r2H5s5rT9nH6vfQLoKl2tX7GeENITmzHnwJhQLBrYVtJ4xJfs2NGZts6?=
 =?us-ascii?Q?9XxuOEX5hBzjTiGykN0kMPfYG0r3l0m+4Ok3zLHL0g9pqldsCzTg0ZHWbZn2?=
 =?us-ascii?Q?Jd5PoQp4O3cpd1YIRdyFdjTpfaMmLQGu7+z2bgZTuMsjCcO4t+ceBWzvU/fY?=
 =?us-ascii?Q?+O7Ahx9A7Uog8EDisH5bfGp2FeVgiP/VVgfXmE64Y0o9W+z1eWgfUmJprgpu?=
 =?us-ascii?Q?U+J2dLCqtd4s144GW0i0RN5eeEFcNZWV34TuFm3eFOErdWXd+6fafChJGu5V?=
 =?us-ascii?Q?3+SOtUVHgW3UT0YLlC+rMKMWWMK4WB/qgfdGu18LFk69JFEPHDy/F+pFKYCe?=
 =?us-ascii?Q?3tvIlhylNFRnV+W6l3t0oomLjStXmS528nnEsE2+V5JeuzyPZCCP4yrQe750?=
 =?us-ascii?Q?HUJBhvbDt3GMgfUlllndfQEG5dbQRz664m6DJjZNTAy8vNfkLrYJ3AxE0Vcw?=
 =?us-ascii?Q?UtY82QwEQR9gqfFg/utQpLjyxPOX1W42idBz/zRJeOCZvU2Wcl8Wv9r8m2N4?=
 =?us-ascii?Q?gW+lqOIwWYlWL22UqT1N4dyvw53nUzGKykGH2XYq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481a42d8-e222-484a-f109-08db8261e876
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 22:55:22.6283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ti08jTOQp3u6Cdk2geu6kyPArfszzYIE8kiDUQW1PtVhDrsK+X+xX3gyHTEQx9o04g1PGnkL1UgSX7CWLhy+qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8335
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
> Sent: Thursday, June 1, 2023 5:38 AM
> To: shawnguo@kernel.org; Mirela Rabulea (OSS) <mirela.rabulea@oss.nxp.com=
>
> Cc: robh+dt@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de; dl=
-
> linux-imx <linux-imx@nxp.com>; linux-media@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] arm64: dts: imx8-ss-img: Assign slot for imx jpeg
> encoder/decoder
>=20
> assign a single slot,

As I mentioned for the first patch of this series, I don't think it's ok to=
 limit the driver to using just one slot, the slot which is hardcoded in th=
e dts. I suggest to hold off this patch series until we have a more clear p=
icture how we want to change it for imx9.

Regards,
Mirela

> configure interrupt and power domain only for 1 slot, not for the all 4 s=
lots.
>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  .../arm64/boot/dts/freescale/imx8-ss-img.dtsi | 22 +++++--------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
> b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
> index a90654155a88..176dcce24b64 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
> @@ -18,10 +18,7 @@ img_ipg_clk: clock-img-ipg {
>=20
>  	jpegdec: jpegdec@58400000 {
>  		reg =3D <0x58400000 0x00050000>;
> -		interrupts =3D <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupts =3D <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks =3D <&img_jpeg_dec_lpcg IMX_LPCG_CLK_0>,
>  			 <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
>  		clock-names =3D "per", "ipg";
> @@ -29,18 +26,13 @@ jpegdec: jpegdec@58400000 {
>  				  <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
>  		assigned-clock-rates =3D <200000000>, <200000000>;
>  		power-domains =3D <&pd IMX_SC_R_MJPEG_DEC_MP>,
> -				<&pd IMX_SC_R_MJPEG_DEC_S0>,
> -				<&pd IMX_SC_R_MJPEG_DEC_S1>,
> -				<&pd IMX_SC_R_MJPEG_DEC_S2>,
> -				<&pd IMX_SC_R_MJPEG_DEC_S3>;
> +				<&pd IMX_SC_R_MJPEG_DEC_S0>;
> +		slot =3D <0>;
>  	};
>=20
>  	jpegenc: jpegenc@58450000 {
>  		reg =3D <0x58450000 0x00050000>;
> -		interrupts =3D <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupts =3D <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks =3D <&img_jpeg_enc_lpcg IMX_LPCG_CLK_0>,
>  			 <&img_jpeg_enc_lpcg IMX_LPCG_CLK_4>;
>  		clock-names =3D "per", "ipg";
> @@ -48,10 +40,8 @@ jpegenc: jpegenc@58450000 {
>  				  <&img_jpeg_enc_lpcg IMX_LPCG_CLK_4>;
>  		assigned-clock-rates =3D <200000000>, <200000000>;
>  		power-domains =3D <&pd IMX_SC_R_MJPEG_ENC_MP>,
> -				<&pd IMX_SC_R_MJPEG_ENC_S0>,
> -				<&pd IMX_SC_R_MJPEG_ENC_S1>,
> -				<&pd IMX_SC_R_MJPEG_ENC_S2>,
> -				<&pd IMX_SC_R_MJPEG_ENC_S3>;
> +				<&pd IMX_SC_R_MJPEG_ENC_S0>;
> +		slot =3D <0>;
>  	};
>=20
>  	img_jpeg_dec_lpcg: clock-controller@585d0000 {
> --
> 2.38.1

