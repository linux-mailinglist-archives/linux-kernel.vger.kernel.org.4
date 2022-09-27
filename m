Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531225EB854
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiI0DKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiI0DKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:10:14 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5061EA5731;
        Mon, 26 Sep 2022 20:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ld8DKMTisZPQaKBcgOBh1x3KgjyPw43yHvfVr+rNVNCd3jXzLZDtjBKHw5Er29daE+IubbIK7gWGdYgAzPNaAPcMPe+WE6L0gNTvt1gs6E/p3XxFRtWfueZuMsDe291OrdWAxBX8+DhmTscY41qdGOtKG6AKIAlsV9yKGHNGpuyLwT7nngFwgKAsUUN2Lx0JRnueTFVVDTRMFd4dkI7JrC7WZGO7M4sVwdt80T7zzJRPiUn4k7ubvb5pWEYkJxBVeuV+T9BYC+giMbh92ySDPvtrd5M77QAXj3W0rp88C/voSGnRhtY2bDSUj0FjQTns5Tme6flxD4HQt29UJPUbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yT/NPt387VsjwbCRBF+vFTMQrXXZQLzX/Shii6vydQ8=;
 b=nXNoWGcl0nMj0P/Eg/0s8r316ACTCGq1fz5bKya7P1Q7aFbdwoWtMZT5jkz1fWlrCo95lirWQK0MOLKhojOLjUOjzYg3iBoX8ju2fdIWbK3P5Q+b6xGardOXigYy2w/tRaQFgL/6pRDui0bkIHq6m8vUU9B9x3g7l9D8F5caSmuTFH8axwdY0/AxxeluXX+DS/T1pl/M72efNrHBnhhnZ+t8rPIQCZfJYMzqvWA5B4p5/m31KYHTh/+K9H9tztTTNQwGhsHCf52gWBSD2JGec3zu2nv9I4uGGg2l1uK3dO+AVvVcEDirla3GLDCM40Y9QvNpukyI8BRIZSr46opI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT/NPt387VsjwbCRBF+vFTMQrXXZQLzX/Shii6vydQ8=;
 b=O/zvzXNe7zNijp8SL+FXDIo12BOXWWG93RAJ5N4Edfdo1d1YLGQ9xPhSgU+HX+5CY4qR8M/zZzjhPF1vlBdTbO24B6Hxp2iX7IVGFxbegnePhCTY+/alkR90bDeymL6CR+dHyOXqjGM1FgldYt71SLQyNK0X/Y34PMP8EEPqAwo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8900.eurprd04.prod.outlook.com (2603:10a6:20b:42f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 03:03:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 03:03:07 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V7 2/2] remoteproc: support attach recovery after rproc
 crash
Thread-Topic: [PATCH V7 2/2] remoteproc: support attach recovery after rproc
 crash
Thread-Index: AQHYkAx8ptlj9Q9SikKeYc8v9edOla3yyEUAgABQJgA=
Date:   Tue, 27 Sep 2022 03:03:06 +0000
Message-ID: <DU0PR04MB941767AEDD07DBA7E7FF9B6E88559@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220705011527.2849057-1-peng.fan@oss.nxp.com>
 <20220705011527.2849057-3-peng.fan@oss.nxp.com>
 <20220926220610.GA2817947@p14s>
In-Reply-To: <20220926220610.GA2817947@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8900:EE_
x-ms-office365-filtering-correlation-id: 39fe97af-2b78-46fb-b65b-08daa034cd56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: noPqFLAGKpCink43+owJGtFHz5zE1iLUNIjC54glJCon6Nt72ww3iAjBGT0WBNsAK1vtqXHnTbjfC48l1NFqxyaCdpXMd4huA1AKBpwq0yPZQvPr0sPyCPMfH4jdTdFgDRDelp/R11QNZx43L95B6rYExCs8HwRle4FSbVbUV7u/dOtFMH1v2zb346VcIGtTSa/3Wwyq3No29elZhOsoSQ8e+9SFFuSFIfjeWXUzTtNA1KXE64Oec0bql9iyzIsYk2MWNokoAHID3ei6pzJ/+pyBbz0J5GeFGjhb9SXz+qVBE6iK09UTRi/kJ/wKv4FncX7EvP5jCJ7dWMjnhzK2dUDxAO6Nl6yDHExcfgNhuWu+pYmzYRIMvl+D6ukOC9drppW4/yeR2ffsArYb0VVhl1eEcn/jXPOc0R97iTM2nnRiWH5kOGiFJQ9fQtFqM3GgAHR0psI32VV77X2mzF2NwzrmzsZb9/IYlYOBzCT+I7/PQcvcNx4U59DlwaU7WIQfHe2K/qfpy09EiWr+R9xgCyK2lh1LovdKUH67Aieg/9zb7T9O4Sd9IvyQR3reARrWJFJFZfbXEMhTpT6Sw4MbEc31UNlyoX8P/aUsxGt3NZdXjoQ4IfusbhDBS8gAxK/8tjdtJEfDaixfvaoBxbO/BrAKV9DHvKlkUc+k0v+Z8uVI0TRkGHx6DlzP4+cRFTUTkazhLmTZHRmUrgHD3Z7kBKkVf/DTTdoSs5nW2ic/iDT2EXEZL/IGTrzPBmKlh9zY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199015)(38100700002)(122000001)(38070700005)(86362001)(33656002)(44832011)(26005)(9686003)(2906002)(55016003)(83380400001)(71200400001)(186003)(6506007)(7696005)(478600001)(76116006)(316002)(54906003)(8676002)(110136005)(8936002)(41300700001)(66476007)(64756008)(66946007)(4326008)(5660300002)(66556008)(52536014)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xc5FuMcu+xXZ6xZqJqkkmAPPsar/KCHDrpY6qVdv2EjPb25LeqWz2FVZewz/?=
 =?us-ascii?Q?3XqIJ690WmARffWIxW9x1LhEo6VMVeoAJdJeiIBIR/m8YlatlrtFcInile7j?=
 =?us-ascii?Q?g+3kMMZjjP/VV7XYAKXGWXLRM4lbU6Lw8eWDB7WBFaQeb6bJn5b76Oraao6e?=
 =?us-ascii?Q?c6OH3a8tyt7GXq2cuz38iXKDtkdms9Eb8lQB3eyGVRa6T+nECnspoUjbwUIB?=
 =?us-ascii?Q?XNQ4Ga23ufoGZkPsPwt3qns+FXIXrbLJEOWgdvv9055Gz2g+AJu1F17wMtIx?=
 =?us-ascii?Q?QReWeHRxZ1eA4R6Irg3M16mw597wDkKnw0w4S6Wg1ywGH35hu4lGDCZQA5mh?=
 =?us-ascii?Q?75UWcNadF+/8LB2KMf7Susa5HYPsCgQ5f+D8wdYeKyY28c30eyB4qxklt3BV?=
 =?us-ascii?Q?nskC8SMHt2pdzTFcAmgSjORC4uleMowzqaGfjUy+QXIfnjxId3tBJK7HLq76?=
 =?us-ascii?Q?e9i8z0stdBD+avsF5q2aJWYqCKPwWjTHbDJwRpe5S8Av52SxXrI7NdCFl6mF?=
 =?us-ascii?Q?EN/NZ/xkdv0ftZo+OI9WT07mBP5WnHnZFTS444frNwlmrDLcb3W+AAfEUNrR?=
 =?us-ascii?Q?U4IlkraXd5Khe5blbEC0VX+3w1jOchlyEfqzTqyzmiVXoqI0YvoA1FKfxWE7?=
 =?us-ascii?Q?DIhAbY2CUzEjWfY9v6ttNRfHinEDQwQYcsBlPT8JflkoO7drDTwnyLSBfovT?=
 =?us-ascii?Q?9T7jOkkuyqZrMa9bwujzRdC+PiseEnmJ90X4KPqoN3NBjPQQKEZngGko0gMI?=
 =?us-ascii?Q?ILDhiOpKjC/ZD3VmscH6j1S337/0h1IcZ3qotcq2Z4COc34wWcsGmhSW1aRX?=
 =?us-ascii?Q?mBmoZNPXdXuhDEz3eHFK9GOVZ5mHiby61x9fmVBVXeNVfYvV8xwx4oRJhdch?=
 =?us-ascii?Q?8apJ7uRyhM8XZMM4N91iyBYecDWJIadsNPSs/iRvqP+5ZwYxxWMLgIJ2vTs5?=
 =?us-ascii?Q?5t0B07L8nLWlRrvl7KAm5eqXepNs9iuMdr6XEBCY2/65XAWdbTnNRdzfM97O?=
 =?us-ascii?Q?M77cHDY6FR9kL0gqZeutABpqmge2FK6ZaM2K462FgzurBDwL4BLFO1s3mOk8?=
 =?us-ascii?Q?ttauSVArrtoc/jQOlWYn3o3QDA+yJ60eI3cnhf7DQ0Sm51XThz+lLEZ5hg9s?=
 =?us-ascii?Q?nKyiuhlYs7aPfssyqeeXu9XFuGWLBr+Gt59g/87YrcUtIwxx5aGAq/4uEWep?=
 =?us-ascii?Q?iLL85AJimiRRuFg6At1BI0ZlcVsNUI44QDbcknr8Oc/kJ1mQnqTlCwM/aLT0?=
 =?us-ascii?Q?FjAgjMDe7FcVdTuB7Kg92o6AFyai0u1726LxvHQip7gBt3ecgCabaZpvkjJf?=
 =?us-ascii?Q?K5dG4u8CdkDl1sGOyL4PH85t5lzvZRp67LkaMw1M4j+rZ6mKCTrPHsGaEBsN?=
 =?us-ascii?Q?rYvNXnPKbGyKJGKUapG5CFFeClBuRhOGWuUALwu6/UIIiyaS2cWis8BSE4YU?=
 =?us-ascii?Q?EvgAwiJmQqVxdYeN3/ucSL6kniYEaXdZef8+zkjxvGvwU7NVvVafr53lHPg5?=
 =?us-ascii?Q?bPswBqPfXSSsKuBlONEudR7xhWquM/dbygYFxoozgbdbLLbep585b/i1KbuZ?=
 =?us-ascii?Q?YsK3ok8VqXRjWP6vjRU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fe97af-2b78-46fb-b65b-08daa034cd56
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 03:03:06.9945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYNmFqcbSKUC9LatGVmsML9RnaGJErbqfjLO/ZbJ1PYKu1qpveA6vk2gHl4mtK0NYG/XbfVkPdyadndu4dzyrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8900
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

> Subject: Re: [PATCH V7 2/2] remoteproc: support attach recovery after rpr=
oc
> crash
>=20
> On Tue, Jul 05, 2022 at 09:15:27AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Current logic only support main processor to stop/start the remote
> > processor after crash. However to SoC, such as i.MX8QM/QXP, the remote
> > processor could do attach recovery after crash and trigger watchdog to
> > reboot itself. It does not need main processor to load image, or
> > stop/start remote processor.
> >
> > Introduce two functions: rproc_attach_recovery, rproc_boot_recovery
> > for the two cases. Boot recovery is as before, let main processor to
> > help recovery, while attach recovery is to recover itself without help.
> > To attach recovery, we only do detach and attach.
> >
> > Acked-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 62
> > +++++++++++++++++++---------
> >  1 file changed, 43 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> > b/drivers/remoteproc/remoteproc_core.c
> > index ed374c8bf14a..ef5b9310bc83 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1884,6 +1884,45 @@ static int __rproc_detach(struct rproc *rproc)
> >  	return 0;
> >  }
> >
> > +static int rproc_attach_recovery(struct rproc *rproc) {
> > +	int ret;
> > +
> > +	ret =3D __rproc_detach(rproc);
> > +	if (ret)
> > +		return ret;
>=20
> I thought there was a specific reason to _not_ call rproc->ops->coredump(=
)
> for processors that have been attached to but looking at the STM32 and
> IMX_DSP now, it would seem logical to do so.  Am I missing something?

ATTACH RECOVERY is to support recovery without help from Linux,

STM32 and IMX_DSP, both require linux to load image and start remote
core. So the two cases should not enable feature:
RPROC_FEAT_ATTACH_ON_RECOVERY

Also considering the recovery is out of linux control, actually when linux
start dump, remote core may already recovered.=20

>=20
> And this set will need a rebase.

I'll do the rebase and send V8 if the upper explanation could eliminate
your concern.

Thanks,
Peng.

>=20
> Thanks,
> Mathieu
>=20
> > +
> > +	return __rproc_attach(rproc);
> > +}
> > +
> > +static int rproc_boot_recovery(struct rproc *rproc) {
> > +	const struct firmware *firmware_p;
> > +	struct device *dev =3D &rproc->dev;
> > +	int ret;
> > +
> > +	ret =3D rproc_stop(rproc, true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* generate coredump */
> > +	rproc->ops->coredump(rproc);
> > +
> > +	/* load firmware */
> > +	ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> > +	if (ret < 0) {
> > +		dev_err(dev, "request_firmware failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* boot the remote processor up again */
> > +	ret =3D rproc_start(rproc, firmware_p);
> > +
> > +	release_firmware(firmware_p);
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * rproc_trigger_recovery() - recover a remoteproc
> >   * @rproc: the remote processor
> > @@ -1898,7 +1937,6 @@ static int __rproc_detach(struct rproc *rproc)
> >   */
> >  int rproc_trigger_recovery(struct rproc *rproc)  {
> > -	const struct firmware *firmware_p;
> >  	struct device *dev =3D &rproc->dev;
> >  	int ret;
> >
> > @@ -1912,24 +1950,10 @@ int rproc_trigger_recovery(struct rproc
> > *rproc)
> >
> >  	dev_err(dev, "recovering %s\n", rproc->name);
> >
> > -	ret =3D rproc_stop(rproc, true);
> > -	if (ret)
> > -		goto unlock_mutex;
> > -
> > -	/* generate coredump */
> > -	rproc->ops->coredump(rproc);
> > -
> > -	/* load firmware */
> > -	ret =3D request_firmware(&firmware_p, rproc->firmware, dev);
> > -	if (ret < 0) {
> > -		dev_err(dev, "request_firmware failed: %d\n", ret);
> > -		goto unlock_mutex;
> > -	}
> > -
> > -	/* boot the remote processor up again */
> > -	ret =3D rproc_start(rproc, firmware_p);
> > -
> > -	release_firmware(firmware_p);
> > +	if (rproc_has_feature(rproc, RPROC_FEAT_ATTACH_ON_RECOVERY))
> > +		ret =3D rproc_attach_recovery(rproc);
> > +	else
> > +		ret =3D rproc_boot_recovery(rproc);
> >
> >  unlock_mutex:
> >  	mutex_unlock(&rproc->lock);
> > --
> > 2.25.1
> >
