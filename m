Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D72069B8A9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 09:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBRIPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 03:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBRIPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:15:24 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2121.outbound.protection.outlook.com [40.107.113.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847702C649;
        Sat, 18 Feb 2023 00:15:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPvt5BoE8nJuiBTGwhrAJdXDnJ+2dr1ivUZwOq2JlWF+R9U6Glr0/gpYX2iWElYFWVu/hOmt4cxi0w5Iwdc4PpJsSD9XRBDGSdf2C5tsj2UzEfHRjaJHjbCZs85bXchQxloxOLZtQ/9oyIoFC6EtlLlSd7poEppqQbF3UZFtu3Dd7EC6joRVcYEG/mukWMAwhL1GXf2K1l2F9c1b6UpXSAwFQ7HqNctBDSBtetpSnuVLOQTh6fUuETHHBeui8B5C13eYO+ZYwrSMyEFZ5FOm+fJjhlwUsGnysc6TQspeYR2ARAe7iRgsozEMncgZK86rB/vQIIdaVWO/gUoju1280w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfMmlNSgItdO3I7ge7VuB8xkOxT2LqjQh77NRpM8yZ4=;
 b=gQ5mBjUd+SyOJzHMVfQYNV504jVvycO2Ujn8E6FM761yx+eCEoBugANs2YY+LSVuM1byOc12ECvQkxxjy75JOfOariR5tzXxh21gocgnpJhxSWWsNN2aiwvr9RON2YEJuwRBOLJ3KeUSAflKlawd0gOPAEk1UY/rXA+MTsa+C+fUDQ+XPvBj6A+vAabq7vbhdA3mO4LVAg1aHescWDMTG7ZEK/sLvHxvtYyZ8mn67ygAkHmByUUsmforkDgbt5xBvlr+B7kvfpl+i9myeCku2rAO0mT3wIN6DYZsgkJm3gixvB77+d+pEgE4ByAN5HgIWBQi31xiBCAhAmHi+oEkUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfMmlNSgItdO3I7ge7VuB8xkOxT2LqjQh77NRpM8yZ4=;
 b=Wy3O4L7mzES/V9bdDAD9QjrQXsyvKcS3NM1V1VTw76xMp+21xqmC5aEwOJFZlMdN/M534z6QUskcVW72eBED4I73WJjiOqjKB86bAsYGdjy/vzXeK2ro5bkr91JQ1+yBdqO3xaElchor5ZxctlUNDx5moN48wJkKGSgZdIcnjG4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5905.jpnprd01.prod.outlook.com (2603:1096:604:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Sat, 18 Feb
 2023 08:15:17 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%7]) with mapi id 15.20.6111.018; Sat, 18 Feb 2023
 08:15:14 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 2/4] ASoC: sh: rz-ssi: Update interrupt handling for half
 duplex channels
Thread-Topic: [PATCH 2/4] ASoC: sh: rz-ssi: Update interrupt handling for half
 duplex channels
Thread-Index: AQHZQwEPs7F2ITfA90KVmjY6nFIq5q7UWeuA
Date:   Sat, 18 Feb 2023 08:15:14 +0000
Message-ID: <OS0PR01MB592203E429BEB581034811BB86A69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230217185225.43310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230217185225.43310-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230217185225.43310-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS0PR01MB5905:EE_
x-ms-office365-filtering-correlation-id: 8bc9c4eb-ff56-4798-9c94-08db1188435d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8uJZHwDPt+ePe6IUbSuMcqzctMOGV3D+gvrXjw/GBYroB2tmYyphx+AxOijE8b86evBoPpDxGxGsjA1y1J9ssh0GoWuXJziSBylNsXvobUQjWZKMro645mEJXJj1nC4SaIwXHiobkW0JMJgvSw7RL1oXyaWap06MjGjAkDAVThDscc7WXPjG/CNyOyK7KTxS+WC82UfXD+9wniKFQ7ZaFMc24rw+RkvDKHLqxuzVnwIW6awAhjV5Pb+2891W/AJeRhpHVej5zBygDJawFofvaTPqLTqtvqb14b9esavmzrJaFEenom+FRH3QJVwTupvB/V/hdsFAkKbg/GVwtEfE7xj2De2OA0uGNIRl1lU6LnNIDvBA3gYCfkNKfNl4Vjwx6KDKskqt05LkdZdyg08GPFHg/+Hze40TnoBKNPgEAgx3IM5qMSwWv7D+OgWBT7olEghuH+Ni/MomIPWYA1fWVUgs11m8xxv4tQfiWQ/T7Gh0MvIdlKbGpfOO/MIeQj+TmAMwnyHqdP/DUZiSDFVlM/uhxzIfPsJ+l/xrTs/wchN8tnHtYhjF8VD1M90pbASEl32fn6bx+z3NJ9kKVnDHGzDbiUNrKVRJQdJ2OFd4RuNle2J49xZgARR/TME/vYNdDFVz4cs/jLAFaAqcV5IRdPe4ry1AkP8HpHMnI/n8qlIZfu6C49QEVnoiE1pmFubzAbluk2wKaowkE4fcSvIt+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199018)(7696005)(64756008)(66446008)(33656002)(66556008)(55016003)(66946007)(8936002)(52536014)(4326008)(2906002)(66476007)(76116006)(7416002)(15650500001)(5660300002)(38070700005)(38100700002)(86362001)(8676002)(122000001)(107886003)(478600001)(54906003)(316002)(71200400001)(41300700001)(110136005)(9686003)(83380400001)(6506007)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CFbNo4BI+30GtD0LK/f8gIuTm8JlMxO7180u/edVOipyf/T4qzJnCcD1vUI6?=
 =?us-ascii?Q?amElDDp3nPIF+X9rdLFKCAshTmEs6W6Xqfv24oFRIEW+/9dHMgue7We6aloJ?=
 =?us-ascii?Q?V5kFX9hKLx1Rf4Dbg+GaZIiXdvA4QdRK600N6yLzI7aCdClaFo1LN/yQBNfx?=
 =?us-ascii?Q?/LZmhIcKjHLs6n0hJo2m7mMjHiHSGdEZOPc4Xk+m3FRRU3SWe9cDnys9VHjc?=
 =?us-ascii?Q?qW5VIQ0vKr0L5V8RDSq/5Ay2lJsd6rXEjI5354mWPDDu+sP5rukOgwIU2NdH?=
 =?us-ascii?Q?7r6hBk4CVToAsMtnqxEeTfI7oE49Q0qG/M0e4bTN4RvgjrUuI/FHY1DO7qpx?=
 =?us-ascii?Q?2kyfy1nrDRAaeQtk8SpvFYNF0+C+DCwSgxhbEq77hQeYAac8s5an7ywE4qA2?=
 =?us-ascii?Q?ZT8pN1q2kfV+BeVFU9KiJEL40i36Dg/fo/SvZUpaXUsSW1P7f7pSqf+RKlVi?=
 =?us-ascii?Q?38Hy7uBeQQKgvGzAm0rDovH8lMe5pnS/uEceJl1lHyBypWY84T8VvdxqS5eK?=
 =?us-ascii?Q?gbUrSjeUzDwV5PkLs6XXOb5LC3kXowvrXqnO8rW3R9hlaWHJMrtjnC5mYJQ7?=
 =?us-ascii?Q?e181Ah+0afGHATdXqW2qnQECNtkRaNC7fGp+vPi+xjH1Y2GqaOYtdGzDS4jM?=
 =?us-ascii?Q?jFEpq7+PbdkW8GnV3/rmqDJJgZml9Mj1Qwx7Da2lBCleV7SCSVEHxkZMX+/K?=
 =?us-ascii?Q?iD60a6pxDff/3KdPOL1Xo7rVTL17BAjiJo3mtdh35iKSBE74mfxtJq3X+KOF?=
 =?us-ascii?Q?wGGKtFQXXQ3RB/NxZG3BQ2/EOHwHAj5pZ+toJyID8e0kf1JAZ+Hm/vPsxOtN?=
 =?us-ascii?Q?Bndgahvgs/EFHe0YEh2idvteIkXyaV39dBqziZ0zBF/Qt/RWJh7G6f5mZEhv?=
 =?us-ascii?Q?UjlwKf+RiTM0cvrLxvmvecxbzRCmKan8er3FzP17kbfaS05WPwBaWBXpVwD2?=
 =?us-ascii?Q?NAP+/uQOlwhlv39ALhokiVqb/d4O30lvn1j8gLfRpHmqb5ZJsu6QMNkcz5GK?=
 =?us-ascii?Q?XVCcYy6cB/KpconsNRBSxHv68ZhyUAAJqe+DmVCanz/qisn8gwbCwNoGqrJa?=
 =?us-ascii?Q?5NUp23OzfI+WW6ZG1OYlP5AlBHNQPMNEXl/Xl3WgYwtQaISLwYyv7XNFeuRX?=
 =?us-ascii?Q?kofjchl364n+7TR0fB72TO2DhmX49lSYlpxee4cogxI2uZfmsLY34vrfT/XM?=
 =?us-ascii?Q?1Aqh3lQG110N6qJPZWyzFdX2qjTKNUCprTrA3K8Jo0/ZPxwE4bJzOoU2fKhL?=
 =?us-ascii?Q?jCR0Qks7DUCwi9anuG7H+tL/Sh7lGOYJK0oc9m6paVkowxZPtIV7A68D6DcR?=
 =?us-ascii?Q?GzMekgbXNGH+MiK8rW5P9KBQnzN4hL3MuVWe0xExyU6QdSQDgIfPyJWczfkz?=
 =?us-ascii?Q?j7MNIRyxzfFtfau8ojwUGWW2p7c0BkEpIEQ37KtO2Qwzh/XARjVbo72qI4Ey?=
 =?us-ascii?Q?nE35AzxmoWW/KVALyKufL2k76M3zlSmHeGaARI+LH4IOePdpefXeeiVLNKxT?=
 =?us-ascii?Q?rfIk+zhcJ6x9CXYH2AcJYWAhWYFDd/IBw8IgkCo1plF8zdftlg4Z0YRTExoD?=
 =?us-ascii?Q?pIFBz9iLL9K0grHei189YtWEUuSXzoosbrJ1569FJG+G94+/zYEVamjuwRNr?=
 =?us-ascii?Q?8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc9c4eb-ff56-4798-9c94-08db1188435d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2023 08:15:14.5865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ij8bxSk9gxCfMJa7slk88wruRL0Juv3czKsb4upVwSmQg3IQQMNFy7COMWcOX37//qq75rJH7JRG0aCBnRnpW89usEk1leSp13wzqIafEuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5905
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thanks for the patch.

> Subject: [PATCH 2/4] ASoC: sh: rz-ssi: Update interrupt handling for half
> duplex channels
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> For half duplex channels we dont have separate interrupts for Tx and Rx
> instead we have single interrupt Rt (where the signal for Rx and Tx is
> muxed). To handle such a case install a handler in case we have a dma_rt
> interrupt specified in the DT for the PIO mode.
>=20
> Note, for backward compatibility we check if the Rx and Tx interrupts are
> present first instead of checking Rt interrupt.

Just a thought,=20

As dt-binding doc mentions, a way to distinguish half duplex and full duple=
x by
Counting the number of interrupts. Maybe we could use that property for
detecting channel with full/half duplex mode.

See below

>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  sound/soc/sh/rz-ssi.c | 63 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 44 insertions(+), 19 deletions(-)
>=20
> diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c index
> 5d6bae33ae34..d502aa55c5a8 100644
> --- a/sound/soc/sh/rz-ssi.c
> +++ b/sound/soc/sh/rz-ssi.c
> @@ -109,6 +109,7 @@ struct rz_ssi_priv {
>  	int irq_int;
>  	int irq_tx;
>  	int irq_rx;
> +	int irq_rt;
>=20
>  	spinlock_t lock;
>=20
> @@ -565,6 +566,17 @@ static irqreturn_t rz_ssi_interrupt(int irq, void
> *data)
>  		rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
>  	}
>=20
> +	if (irq =3D=3D ssi->irq_rt) {
> +		struct snd_pcm_substream *substream =3D strm->substream;
> +
> +		if (rz_ssi_stream_is_play(ssi, substream)) {
> +			strm->transfer(ssi, &ssi->playback);
> +		} else {
> +			strm->transfer(ssi, &ssi->capture);
> +			rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
> +		}
> +	}
> +
>  	return IRQ_HANDLED;
>  }
>=20
> @@ -993,26 +1005,39 @@ static int rz_ssi_probe(struct platform_device *pd=
ev)
>  	if (!rz_ssi_is_dma_enabled(ssi)) {

Here, Detect Half duplex or full duplex by counting number of interrupts.

If half duplex get IRQ associated with dma_rt

If full duplex get IRQ associated with dma_rx and dma_tx.

>  		/* Tx and Rx interrupts (pio only) */
>  		ssi->irq_tx =3D platform_get_irq_byname(pdev, "dma_tx");
> -		if (ssi->irq_tx < 0)
> -			return ssi->irq_tx;
> -
> -		ret =3D devm_request_irq(&pdev->dev, ssi->irq_tx,
> -				       &rz_ssi_interrupt, 0,
> -				       dev_name(&pdev->dev), ssi);
> -		if (ret < 0)
> -			return dev_err_probe(&pdev->dev, ret,
> -					     "irq request error (dma_tx)\n");
> -
>  		ssi->irq_rx =3D platform_get_irq_byname(pdev, "dma_rx");
> -		if (ssi->irq_rx < 0)
> -			return ssi->irq_rx;
> -
> -		ret =3D devm_request_irq(&pdev->dev, ssi->irq_rx,
> -				       &rz_ssi_interrupt, 0,
> -				       dev_name(&pdev->dev), ssi);
> -		if (ret < 0)
> -			return dev_err_probe(&pdev->dev, ret,
> -					     "irq request error (dma_rx)\n");
> +		if (ssi->irq_tx =3D=3D -ENXIO && ssi->irq_rx =3D=3D -ENXIO) {
> +			ssi->irq_rt =3D platform_get_irq_byname(pdev, "dma_rt");
> +			if (ssi->irq_rt < 0)
> +				return ssi->irq_rt;
> +
> +			ret =3D devm_request_irq(&pdev->dev, ssi->irq_rt,
> +					       &rz_ssi_interrupt, 0,
> +					       dev_name(&pdev->dev), ssi);
> +			if (ret < 0)
> +				return dev_err_probe(&pdev->dev, ret,
> +						"irq request error (dma_tx)\n");

Typo dma_rt??

Cheers,
Biju

> +		} else {
> +			if (ssi->irq_tx < 0)
> +				return ssi->irq_tx;
> +
> +			if (ssi->irq_rx < 0)
> +				return ssi->irq_rx;
> +
> +			ret =3D devm_request_irq(&pdev->dev, ssi->irq_tx,
> +					       &rz_ssi_interrupt, 0,
> +					       dev_name(&pdev->dev), ssi);
> +			if (ret < 0)
> +				return dev_err_probe(&pdev->dev, ret,
> +						"irq request error (dma_tx)\n");
> +
> +			ret =3D devm_request_irq(&pdev->dev, ssi->irq_rx,
> +					       &rz_ssi_interrupt, 0,
> +					       dev_name(&pdev->dev), ssi);
> +			if (ret < 0)
> +				return dev_err_probe(&pdev->dev, ret,
> +						"irq request error (dma_rx)\n");
> +		}
>  	}
>=20
>  	ssi->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> --
> 2.25.1

