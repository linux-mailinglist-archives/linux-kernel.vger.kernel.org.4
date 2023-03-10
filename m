Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E106B3C69
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCJKgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjCJKgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:36:09 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1b::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF8AF186F;
        Fri, 10 Mar 2023 02:35:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A49Oqhk/m1AAxdA6wY9cOpDgBzc8S5dqJeiaIDh+vdlRwJTohal9PNHphaXHZ2A00Ss+f0Y9HA44n77+K87ASi6nWi92KVJ2r3YWJEeKPnqmmQXpM/msXmzF9nyf5l/nqQCgvxqQ9sZTH4FF+sZLCWq+RFCBmU0P2Q9O90Ylokzy04D0i0TNYT9Wl8CGfEKCK1DKOcojUjhLFy/t6rBBWplBj3zUlgNI9AW5Mu7MpQ+EgDAoFTDThTacycP97WCi6jYzzqLUkEnCd790JqLDQP8UPycbu1SiC3N64JSATZM+T1sqJ8E5ZGBoWReH7ouw5OPPzZ0HSjICpK3lrXiD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0EnPz2aLSr6gGv35AysS4oAtPfRa3noKZ9LCBOAKG8=;
 b=W7sKkREW2q9K9U3+9CtA14qfrlsdiEKiTYn71oF0jXXIZCJ+4OVmqtogAdNCiquTfG0lw/mFgg8/HwhtY6TxXCFpCpchpWBXM7LE3owoi3yPvvZ3Y2LmDhzDY2jGnNd+5x+l7spTotCgmMtzHV3nIRJ7AOhgscE0fDiKulHztiMctHLADwfVQurSlNfXWff7OFLDYLia0/UYq2DuAV8UdDAF+a+uHoniuvGRr2RVPprNxg1+vK5rR/E/VJaoo4aayFEVnrK5XaEz9V7Uq+h4rnxfVG8GawzfoOFK5mFx3w5dlSlz5m8Y2VUWi58PVjb+ulEchMTc1QIyvAsBmTfZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0EnPz2aLSr6gGv35AysS4oAtPfRa3noKZ9LCBOAKG8=;
 b=SpoHIMykwjD54tsaDPSRQWylrtLPLvY3lhrh4wm6FHTL7R2l5d9dsPB/hOpeuKTEsBLpv/pgsDSV1fvRZ9AnWnIVJuWpqcbs8j8B/wUkxcQVuTib6ITISAj2lic0udAe74n549sYGGHi/u4tvlbwb0Hq7d2SGjZMG/V9dgTIP1k=
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by DB9PR04MB9991.eurprd04.prod.outlook.com (2603:10a6:10:4c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 10:34:05 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%5]) with mapi id 15.20.6156.027; Fri, 10 Mar 2023
 10:34:05 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Franck Lenormand <franck.lenormand@nxp.com>
CC:     "vijayb@linux.microsoft.com" <vijayb@linux.microsoft.com>,
        "code@tyhicks.com" <code@tyhicks.com>
Subject: RE: [PATCH] drivers: crypto: caam: jr: Allow quiesce when quiesced
Thread-Topic: [PATCH] drivers: crypto: caam: jr: Allow quiesce when quiesced
Thread-Index: AQHZRRk16ZVto6KADUOju2c7+0vbz67Y5FOAgAvZCQCADy/xQA==
Date:   Fri, 10 Mar 2023 10:34:04 +0000
Message-ID: <DU0PR04MB9563FCF2A6B794584D9757BD8EBA9@DU0PR04MB9563.eurprd04.prod.outlook.com>
References: <20230221054219.2142012-1-meenakshi.aggarwal@nxp.com>
 <20230228183758.448396-1-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230228183758.448396-1-meenakshi.aggarwal@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9563:EE_|DB9PR04MB9991:EE_
x-ms-office365-filtering-correlation-id: 7f39aaf0-c225-464e-39c7-08db2152f8e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4X0I6zLICixvhY/xBQgrmX5I2GUxZbd4GD6+3piPYmdxL81wVTHAnxrs1WpaF6Dg6Gc8Z3V/uWi3eXklB4VeRWmTI3rc+UAdkj/gpA41hTCvOchaPFNIooUCO/gUzl60kRulPVvLaQjZwmGBNc5PjVppdXiTdwrI7K/8sZccGZEpCXiqA1YA//VCU+tJIsUQWpME56A+P4z3oXIBRpPrS30R+0i45e5//u/uE9z3cL/9m5kF+iG/NwpkkN8gj5L1/wPSdqmdtcurYSFxPsNoBZPBzXTPwYhRrDLB1A4a4BO8nokO31kYROrNJnt6SYnMCrhodaTLwDuxUS3NpDCLzjS7Gs3vomfplqMQLJcSQkG1gJ0bjSAd159LZWcFcGtdZC/RBS9PrksArGs5uEClY0hE4ERfM01i4+p6M/cHakDOr9mN4QXURyiSoEhnd2tnnvEY+bE/Lq+GqiEP/c2bKOOaDRugaPmsVvEZYQ23RuRtbrc2nX01hqwNaYJL4N/Tlt5mjnq+fCCQDC9ecugogO2+jZShQq//35BB+9Ump30rfu7dUPm39dAkZhH4er0Fhi2ESMCCaR8BR+iFYeGjl0tk8Vz07/O02ZHKgOZ7OJ+Pk/Ip2zoEeItddNsUg35bRUf0i2O+VpMD7EbRjmYSk5AbfnLZ0V07bquUMWGpQjl1tbKS0c2r/dbrMTmdMJdntogIcskSuboDwES81wG44lnt9wmPqnGwA3D2GGJe12c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199018)(110136005)(6636002)(316002)(33656002)(54906003)(55016003)(38070700005)(921005)(86362001)(38100700002)(7696005)(122000001)(6506007)(83380400001)(9686003)(53546011)(26005)(186003)(8936002)(71200400001)(52536014)(5660300002)(478600001)(41300700001)(44832011)(66556008)(64756008)(2906002)(66476007)(66446008)(8676002)(66946007)(76116006)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OUT35XDv5Fhqel0DNUhYObFbi6xFXiC6H2LVS4R7tDUmVfmGcP/fKrrPQ9jT?=
 =?us-ascii?Q?zImSWeTdPnFKP9nOzn4IH2/CN44Rl32/85UJnDsb9hVAWRDIC2vdQaonBO4Y?=
 =?us-ascii?Q?rmLJ5qHnweXTXHj17mKUgxmU26KAh6pjf1sOHHnztQW8BOfEGUYhM+1er/8a?=
 =?us-ascii?Q?CnFx8v4FtP27drrQa/q7Z0wCWLKptMv8AAnsRiGufsxLQas4AXMsUO/k55o0?=
 =?us-ascii?Q?3FRdVV4vy1rCdTkhx3OFw38+x0SdHuzJUr/LSKlIF0KCvTnDMuVnQThnMKCJ?=
 =?us-ascii?Q?cOiYxGoOci+UbkNFpXF3Xi5sslzXQx/uKRXmFgkkfzQCxHZeiLzK1wDVU21l?=
 =?us-ascii?Q?Y/unNRdWF/0ddTlqDBDnAATGlEfmHW7Fti4NZdN8uARLUpsTMpeMyhOUA42b?=
 =?us-ascii?Q?L9GuWuN6fZYGN2af0fu6VBtC7CkloGJlDSPAb10VzxgAflZ26vdUEL+yJ7Wd?=
 =?us-ascii?Q?qMtw/uB+P3YMTdcafBoyFhiIfpB+gCMbULr3QGjtzMKjWoe6NtPj1C8VB1Fp?=
 =?us-ascii?Q?xTJ4LbVcsoYhvrtem6o52J3GPYsnFXqNARGmfaAnKrNgZLycMX8lblG+2LtY?=
 =?us-ascii?Q?ZvhRoXSUXExYNfCgo3rGa36ZpW/erR1YggxnzEMDwjOLl92yq2y4jFNaZiTS?=
 =?us-ascii?Q?106d7UAxngYCP/sA0BAm0uKMvZqlYhMRZefQkqqf178KUaQnJVUymN+UFxqF?=
 =?us-ascii?Q?tblMJm11KYehVg3gRro71eOI7SeyULi8TJMK3Rd16GPuMtjsH2csPMuCTdm/?=
 =?us-ascii?Q?K9QzNh4HFoMIjzjcTy1ofDMqsYbaXSmU65gK0BXfyWXJ7aH6zeHa+O/Kbbrt?=
 =?us-ascii?Q?/Wn3GX6ujblV7GP6/ASeW7kF1hiivIY8PZp9cxNeFq0nghmy2498TMb/ynAp?=
 =?us-ascii?Q?B2io0QfRbwRhtJoVPyLo7oXS1rR46KMl8ridsp0lMlmmU40x/UVgBVeCSvU9?=
 =?us-ascii?Q?xhhr0mJYsTM9wYOZc9ssPatrOnhgIQ+4QX43vNMKhYXBMk9SSK9deHGMUb/B?=
 =?us-ascii?Q?rgJ70KId6MQ/nkKXy0XfnxjCPwST5y9d7yPVZOq+LBM9H/7NK/sRX7PwzCqL?=
 =?us-ascii?Q?QefRwFwOgo0iSAZXuCXgqoqjmDMknFhLiE8mE8KaVW2UIW5XG4rRzDawFB6p?=
 =?us-ascii?Q?/5IBHgplopB+MGPNp8xSOdusq0NlUgEzkpD8Sq729EyL7Oc1FG0joOpF5jWm?=
 =?us-ascii?Q?ZCv4OVqABePzk0zA2IbuBPeI79FfFetAcMWr8E1dFVzoQriYHERnxsZEDilO?=
 =?us-ascii?Q?Uhcqu0VDArQRVWnfWsdO/4S2aSyYqzIEGJC1d/87AeH7ZvvRrhnKZkqrzDpa?=
 =?us-ascii?Q?OkK05flvuCMPENAAm9vZ+fvMCh8r+Pr8cMesb6WO4Bi3O0pu2NlwqS5naCiH?=
 =?us-ascii?Q?ggC5dxB2ITL3NbmSTLumtipVdSy4dNVaripQxefsVpi2jLjXpaNqIwIPFo4Q?=
 =?us-ascii?Q?p/2jaSl6d7sRZc3c+Sur4hzKFxVcoGg0m+CpZGemYUbOccphKwWTOCpB+9XY?=
 =?us-ascii?Q?kx2Gh/sxRwBpew3xv7Tkr6dqylXzNR2s9qzuFL89jvtmJeSQYn4VmS4de6Ie?=
 =?us-ascii?Q?XRmfbRm2zdUzGm2NJJpbOo25DHIvuNRdYWdjKUSdH5p5R7ZpsDOpiwM5GYRG?=
 =?us-ascii?Q?uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f39aaf0-c225-464e-39c7-08db2152f8e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 10:34:04.9370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DLxevxs/6lOuKld1vqcye2qvqkKGa4gJY7TmvYtIa8RqruYAuF99W05kjb9Qi9t5rXgmP+lu81mnwT2Gbpx8FiDoZ3K9fIX/Hi4Sadye5Uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9991
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

Please apply the patch if you have no comments.

Thanks,
Meenakshi

> -----Original Message-----
> From: meenakshi.aggarwal@nxp.com <meenakshi.aggarwal@nxp.com>
> Sent: Wednesday, March 1, 2023 12:08 AM
> To: Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>;
> Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Franck Lenormand
> <franck.lenormand@nxp.com>
> Cc: vijayb@linux.microsoft.com; code@tyhicks.com
> Subject: [PATCH] drivers: crypto: caam: jr: Allow quiesce when quiesced
>=20
> From: Horia Geanta <horia.geanta@nxp.com>
>=20
> Issues:
> - Job ring device is busy when do kexec reboot
> - Failed to flush job ring when do system suspend-resume
>=20
> Fix:
> Flush the job ring to stop the running jobs.
>=20
> Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
> Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
> Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  drivers/crypto/caam/jr.c | 55 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 45 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c index
> 724fdec18bf9..eb3b9a7e9a35 100644
> --- a/drivers/crypto/caam/jr.c
> +++ b/drivers/crypto/caam/jr.c
> @@ -4,7 +4,7 @@
>   * JobR backend functionality
>   *
>   * Copyright 2008-2012 Freescale Semiconductor, Inc.
> - * Copyright 2019 NXP
> + * Copyright 2019, 2023 NXP
>   */
>=20
>  #include <linux/of_irq.h>
> @@ -72,19 +72,27 @@ static void caam_jr_crypto_engine_exit(void *data)
>  	crypto_engine_exit(jrpriv->engine);
>  }
>=20
> -static int caam_reset_hw_jr(struct device *dev)
> +/*
> + * Put the CAAM in quiesce, ie stop
> + *
> + * Must be called with itr disabled
> + */
> +static int caam_jr_stop_processing(struct device *dev, u32 jrcr_bits)
>  {
>  	struct caam_drv_private_jr *jrp =3D dev_get_drvdata(dev);
>  	unsigned int timeout =3D 100000;
>=20
> -	/*
> -	 * mask interrupts since we are going to poll
> -	 * for reset completion status
> -	 */
> -	clrsetbits_32(&jrp->rregs->rconfig_lo, 0, JRCFG_IMSK);
> +	/* Check the current status */
> +	if (rd_reg32(&jrp->rregs->jrintstatus) & JRINT_ERR_HALT_INPROGRESS)
> +		goto wait_quiesce_completion;
>=20
> -	/* initiate flush (required prior to reset) */
> -	wr_reg32(&jrp->rregs->jrcommand, JRCR_RESET);
> +	/* Reset the field */
> +	clrsetbits_32(&jrp->rregs->jrintstatus, JRINT_ERR_HALT_MASK, 0);
> +
> +	/* initiate flush / park (required prior to reset) */
> +	wr_reg32(&jrp->rregs->jrcommand, jrcr_bits);
> +
> +wait_quiesce_completion:
>  	while (((rd_reg32(&jrp->rregs->jrintstatus) & JRINT_ERR_HALT_MASK)
> =3D=3D
>  		JRINT_ERR_HALT_INPROGRESS) && --timeout)
>  		cpu_relax();
> @@ -95,8 +103,35 @@ static int caam_reset_hw_jr(struct device *dev)
>  		return -EIO;
>  	}
>=20
> +	return 0;
> +}
> +
> +/*
> + * Flush the job ring, so the jobs running will be stopped, jobs queued
> +will be
> + * invalidated and the CAAM will no longer fetch fron input ring.
> + *
> + * Must be called with itr disabled
> + */
> +static int caam_jr_flush(struct device *dev) {
> +	return caam_jr_stop_processing(dev, JRCR_RESET); }
> +
> +static int caam_reset_hw_jr(struct device *dev) {
> +	struct caam_drv_private_jr *jrp =3D dev_get_drvdata(dev);
> +	unsigned int timeout =3D 100000;
> +	int err;
> +	/*
> +	 * mask interrupts since we are going to poll
> +	 * for reset completion status
> +	 */
> +	clrsetbits_32(&jrp->rregs->rconfig_lo, 0, JRCFG_IMSK);
> +	err =3D caam_jr_flush(dev);
> +	if (err)
> +		return err;
> +
>  	/* initiate reset */
> -	timeout =3D 100000;
>  	wr_reg32(&jrp->rregs->jrcommand, JRCR_RESET);
>  	while ((rd_reg32(&jrp->rregs->jrcommand) & JRCR_RESET) && --timeout)
>  		cpu_relax();
> --
> 2.25.1

