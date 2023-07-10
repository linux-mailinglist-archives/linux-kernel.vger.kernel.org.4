Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247CA74D91B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGJOfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGJOfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:35:40 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2110.outbound.protection.outlook.com [40.107.113.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1038F1;
        Mon, 10 Jul 2023 07:35:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFzB8vUOW30ZvHubVkKEspZX0hf5a62MlEFcCQazz3VBoiTK9Ts7xg9wQK28kFhhBfuI3QnjbCTphfDO2D73ln/g2QLdxiz/rg2HEmbfyywlifCrvGoZEj5CE0YhF995wjNsUTmFxiGgxbNuwXeSA4dj2bh6DrWwM6rGnL6+d7yeXlDm1v/4GBiHjNlogjiuVMT1B3crpleK7qBKKQCxU9X//qC3yEaJ+MWfqDyk5EiM7Yuclq5ekKJPkQkoxUBqbz30UIHkjBW7e2qgThed4XjcrrV/6c1s4yUC4Ffbjp7ASHsLbYgJGPYPhKNJZslyJQ3EGAAgu2pyn6J3XWwdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwgJTLFEVvFt5rweikYbshV55Q8Q+IwlqlcfSJyyOG8=;
 b=eg+kzq1ilLHlO6LEZWdHZfyi4uTrJ9fCXtfuiLdEba2yY1o4Qwe82HtWeHbV7TaZkevQO428wfjXlKmoz1Cs+LtuZv1ErETOqmgIEt1QrPWvDwH9Re3sqRcY70punD80pgPlKkWiFFgRifY3+Dhxg6VJ7aFfYJgQTzLAqcwxcvxwBlUH3l8amh24RewnOOUQZ7przhKmpewaRY4APVd4gjZcm7jKXS+y9+BNnSKYC+WjHcR3/68pYrV+iMMJJAdzX2FaEulJnThsAbzq4wTolajQ1K3R/FfUR6Kk6+saH//wX52E02eJl6Ii9ZJmL5yYctP7y9PQl33Ah7B1CYX/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwgJTLFEVvFt5rweikYbshV55Q8Q+IwlqlcfSJyyOG8=;
 b=toj5ARCRvdaK2DYllMHo8b691lkePR9nP81+rCr9zzg1Xrcg8vqyIw+gJi7DNr4+KmIs+O6urfaL4t4tU/K1MXY6XiBPScZk19oT6t8OJ5N7asnUqOigu9lSyst4EJT5Hswec6fPnfZ6sUpcpcRVoC6l8TcPnKLGwquXbOHZlxQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB6303.jpnprd01.prod.outlook.com (2603:1096:400:7c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 14:35:35 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::de3f:f3ca:8629:c80d]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::de3f:f3ca:8629:c80d%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 14:35:32 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFT] mmc: renesas_sdhi: register irqs before registering
 controller
Thread-Topic: [PATCH RFT] mmc: renesas_sdhi: register irqs before registering
 controller
Thread-Index: AQHZszgc+Vl30+EInk2/Gdg8FTk7p6+zEISQ
Date:   Mon, 10 Jul 2023 14:35:31 +0000
Message-ID: <OS0PR01MB59222DB7B5BE666FE8774F308630A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230710140825.47793-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230710140825.47793-1-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB6303:EE_
x-ms-office365-filtering-correlation-id: 571e5c87-bfd0-43ad-21ea-08db8152ea2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k3I94zjAGWHiSSgkFhYhW5bDRdXmPx1kwdihWyNg1RmhpbXNGH+sXnQxkOY/S9xiSM4hX4kFpYyZv0wIDy6CAeHKPYgwAxINnU8gK28XSVaOw6foJ1i2jGV9GQfQyM1WAQsFFo41wFH/kLfLOfbIR2Hgb8+IeysrJzP3250u4JY+1dwVLYXJ/+UTTrW07MWW+qGGY72sMX/2l5QA+jaO7BN5NUnMHyKnu/AjhyqogsPvHc42cu3MTW4LBH5G47J6+jTGhT8OOmhyQ+rPn8undM31xU3Mr1kCW+WPJwMZa4vyFEIsVqX4lJ5xHzmTqCwwpVgIyBX4xQV1UTp7MeE1vb6D5bZ64Oon+l4aomYQ5zFgoDGaPC8FWVzMqvCFgaBcsalWwgJFnlV6TJqcF5JHrC5OoOUDx8QBSM3EklHs6gV9h3UtA5uk5P+FXx55A3d7JiS0QQVINAVmoFy/fx+EH0m58aRUhN5LtPyqoOLP165Wzts0l7Gwgks7qMxgPMP93fWgnk6deZb1hJMINxI59ejAVUXdgfHd1r9XFNQdnkRM1xSGsLQ2AIDaRNyuauqkyyNkbLqkmD4XEBwu0GDsAPWNoFZk4+WF70b9t53abo4xSVW1UlWjN/rfUTyFFP0c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(86362001)(38100700002)(38070700005)(33656002)(71200400001)(55016003)(7696005)(110136005)(54906003)(76116006)(122000001)(53546011)(6506007)(9686003)(186003)(5660300002)(52536014)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(83380400001)(4326008)(64756008)(66446008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HzufElIuNFLcJKV6OY9KZyKWMCSLAZt3PlsY0WPnn+SKgCdFlNieRHCeTDAO?=
 =?us-ascii?Q?XGkvIPcDUX3cqbIGY6kRTL7lXEIz9c6btuSuiNh6dLbcw6lUITAft+grwVVr?=
 =?us-ascii?Q?z0DDYOwQFHKGivNkUa5fqJEkjqgB+2/TbJ3LMCxLMBojR6Tm7mYhVD1fMF7G?=
 =?us-ascii?Q?nBaK13y0aKGHIK+fCh53GkxRm68Mq1YFuCi+k+3BIjRF330BADFgXScajOFD?=
 =?us-ascii?Q?0OE1wEzbrR9tPP/8G8CW77Lp0BqZePAgeQuuqqRMcDhfyBatMItAfnEQrVSc?=
 =?us-ascii?Q?1QnNnhQx7EWmFx6egYUVDX7zvpZHOacI1yNLlY6YDbfqWw/jeI7RefgmenMn?=
 =?us-ascii?Q?2g2FQHZp1OCNV6m1b2cPxEI7EsbH9BswrYZm55UxUtcaJbMMWHNStBVlnjde?=
 =?us-ascii?Q?NAT17lAqL4XVV8JHEu6XOf1zkcyDeomgtzcLamRMFYnZi+c2hbXTOS1hT/GF?=
 =?us-ascii?Q?krFTGT6GR95ougxP8jKLK+ks9sOWHEZMzhdcMzP8q4e605LvLrCpAuHMDZ0V?=
 =?us-ascii?Q?zpdmsKYeUyTl5MbbjMyghkimE1uCEuTiav3YMd6416XabktRK5DzNe+xuckk?=
 =?us-ascii?Q?s05b8HNUMQiDvfWmtCUJIj/cjXV5iyf486BFmKUBGVJwiaTdSWQRrkLCCfWr?=
 =?us-ascii?Q?cpypu9PcnVkheyuGLAaDh4hO3DAbLIXJLE4UELM7oKMCQA9XXqhJFgeMjHFE?=
 =?us-ascii?Q?MMjSER2Ej2kySn9PYYESVNIsJ5Y8QhFgsEkUiqITCK12QXZMgVT2OPQWmk+E?=
 =?us-ascii?Q?Br6OjZrPvuddGCuOjZSYICQ32O/tKO8VGq49ZhzNdZdYCnwuqE9E8nGNqaxq?=
 =?us-ascii?Q?+zqfetkElN7I4UTpj/2lIvwgXFjqGL1g44lc4D9S3haDacjVbMzPr+BMLrRM?=
 =?us-ascii?Q?XyyhAeBiJ26k6yOV1wLWdJIZQKtVXAaiR2qwvPge7T1DEOyTEYPowmPjA4It?=
 =?us-ascii?Q?G8Slsk+BKjt2Ng0eOD4gzDjhXlKKWNInf3t1MudwctubWTftPoFVwZpQM9/1?=
 =?us-ascii?Q?txIrbYdrHHsJwVZTME6Q9v1wancvPCOmzXm6uSX46e5y9KNf2Tl2XD4zBohP?=
 =?us-ascii?Q?NyDclTLPyodY640VXn5tJGwrWrBxslfh4DjBqKSEJb55oLraXadu1rAok+46?=
 =?us-ascii?Q?kO3Z52zagLOVFmYiv0l0nvaZlUvYL6C5sh60NkB0lNMBhuRl5JM77tqJEkVy?=
 =?us-ascii?Q?JOlASmX7vInQPS1Ye/O36m6nG3ohNRHwhTaZMJt+pVYrWDyMTAhM36F3IsAt?=
 =?us-ascii?Q?VU80Z7du94Fc7NxxnuNVsBe/HYirTxknCm7b8wtUu0DkK8QATA0V0W6ibtrq?=
 =?us-ascii?Q?zfsKUn3i2xpyM1YKsrF/Ndql8ebfJoZcSEhnf4ujfBTflQspznj8wt5jUb3b?=
 =?us-ascii?Q?1gbk6iq3El5TkC3SLNWcg+rwYLuf2g3vHhMt12o9v+v8cueI+dhLaaYdKMDO?=
 =?us-ascii?Q?RMlZAhdOdFL9+rQqIwOSDSmVdg2AFTprAkiJztNsn91wrEj1qfusp3D3twiq?=
 =?us-ascii?Q?rRsScNTSpyeb7IuMuiF1vpMy9Zq0N10qljy7MJhPWGFoKTEazIJbcQgsVQuo?=
 =?us-ascii?Q?xvizjKEWLb6JRh0iFFQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571e5c87-bfd0-43ad-21ea-08db8152ea2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 14:35:31.8811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWSayIaAfLa2g/Syunl7ksglokknySsDyer6GHiA6e9tlevkej00Sp7tbpRdWRdw1bBu+ibfxuuXtr/1FgYSWGPVr7tzs/dUu+HG/T9tKtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6303
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram Sang,

Thanks for the patch.

> -----Original Message-----
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Sent: Monday, July 10, 2023 3:08 PM
> To: linux-renesas-soc@vger.kernel.org; linux-mmc@vger.kernel.org
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>; Ulf Hansson
> <ulf.hansson@linaro.org>; linux-kernel@vger.kernel.org
> Subject: [PATCH RFT] mmc: renesas_sdhi: register irqs before registering
> controller
>=20
> IRQs should be ready to serve when we call mmc_add_host() via
> tmio_mmc_host_probe(). To achieve that, ensure that all irqs are masked
> before registering the handlers.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>=20
> Based on 6.5-rc1 with bf54dec9e953 ("Revert "mmc: Revert "mmc: core:
> Allow mmc_start_host() synchronously detect a card") reverted. That base
> alone shows the regression. This patch works fine on a Salvator-X with a
> M3-W. I'll test more boards. Yet, I send it out so people can tests with
> boards I don't have.

Tested on RZ/V2L SMARC EVK, after Revert "mmc: Revert "mmc: core: Allow mmc=
_start_host() synchronously detect a card""

Cheers,
Biju

>=20
>  drivers/mmc/host/renesas_sdhi_core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c
> b/drivers/mmc/host/renesas_sdhi_core.c
> index 345934e4f59e..499d043f034f 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1004,10 +1004,11 @@ int renesas_sdhi_probe(struct platform_device
> *pdev,
>  		host->ops.start_signal_voltage_switch =3D
>  			renesas_sdhi_start_signal_voltage_switch;
>  		host->sdcard_irq_setbit_mask =3D TMIO_STAT_ALWAYS_SET_27;
> -		host->sdcard_irq_mask_all =3D TMIO_MASK_ALL_RCAR2;
>  		host->reset =3D renesas_sdhi_reset;
>  	}
>=20
> +	host->sdcard_irq_mask_all =3D TMIO_MMC_MIN_RCAR2 ?
> TMIO_MASK_ALL_RCAR2 :
> +TMIO_MASK_ALL;
> +
>  	/* Orginally registers were 16 bit apart, could be 32 or 64
> nowadays */
>  	if (!host->bus_shift && resource_size(res) > 0x100) /* old way to
> determine the shift */
>  		host->bus_shift =3D 1;
> @@ -1100,9 +1101,7 @@ int renesas_sdhi_probe(struct platform_device
> *pdev,
>  		host->ops.hs400_complete =3D renesas_sdhi_hs400_complete;
>  	}
>=20
> -	ret =3D tmio_mmc_host_probe(host);
> -	if (ret < 0)
> -		goto edisclk;
> +	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK,
> +host->sdcard_irq_mask_all);
>=20
>  	num_irqs =3D platform_irq_count(pdev);
>  	if (num_irqs < 0) {
> @@ -1129,6 +1128,10 @@ int renesas_sdhi_probe(struct platform_device
> *pdev,
>  			goto eirq;
>  	}
>=20
> +	ret =3D tmio_mmc_host_probe(host);
> +	if (ret < 0)
> +		goto edisclk;
> +
>  	dev_info(&pdev->dev, "%s base at %pa, max clock rate %u MHz\n",
>  		 mmc_hostname(host->mmc), &res->start, host->mmc->f_max /
> 1000000);
>=20
> --
> 2.35.1

