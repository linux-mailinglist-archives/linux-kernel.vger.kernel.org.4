Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E536DD643
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjDKJIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjDKJIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:08:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304A49D3;
        Tue, 11 Apr 2023 02:07:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+Uez9GmcV54WjwthFNjZPBBr+EK0xSHxqnbvdVWQdNdmI9cPvdWKUQYUZ0qG9Mv06+tP+0fyv/DSuOmfDSsEw7TNSjld2p1haA511tMdTja7qh2+pewy3t8jDSCndvqsi7EoQb66TtglObqBaNAmtKE9hDCpHlBk73o2I8GxMTWj0Zkly587Ona2VLXiZbkxAbkAiosk5BGqqV6kEFMgx968AN/vOdHTR6WD4AptF/PBJsf+CNaodzaGr2ZB/oMcmKdDbs1wp6meRdrYOp7qBDQoUTcQPSIQxESFZ+EAEFiqvdEeGLYrRf/qDbQQbqloWCyoQWQHGNv4mqB0f/Lxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvGZoNpRn1zHrEEQ2xlw/9jzAp810G/5Mud6wNI40Ag=;
 b=ZlQ9+Q5NR3b7+wEgw7RVCevAk6loJJretcmN2NK4cBrQU6e/LRo7w11+IyOYbppQ5E53/LueWiKKQNoUBJneb320YchMgmN6pY6mYIQiLn6GnkWc2zKyPWqo7AHz12NKPdv1OOOYBFi2xzhDQtsL4e8AqyLallkySFV5LQAEKNwjhS4hu1Xi2RoWQbwTxK2vZqyRmSjrwW4W7ZHy/66AYPcnRsxwl4D9aVZXVIVA3RMFsORX8y0ERGDGj2yDZPwTaF3bVeeDXqynGtXpjAB6muEk3cmOXCblAa92e+s4+pXcg/dVTJI1eoYrcpqnFp/z5PA3Wp0WJniAQpP6/dvxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvGZoNpRn1zHrEEQ2xlw/9jzAp810G/5Mud6wNI40Ag=;
 b=xKZUO39PKddZLa6LD/z23dEftSUr7Bdlj8E21D40vZmJ9Txi/HP5h5DeZapw/oLyLqUDEruJMkoIVsgIYLJRUxbAZdjpb/O8rOJ0eOrzCCl9XaBnaeV3GOOrWdc8qoLVUb0kW8jPxdaj6hbyKSn6zMjrm60AIhezzgXpWxlYqMQ=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 09:07:07 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::f8dd:9a7d:7ac3:6d8c]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::f8dd:9a7d:7ac3:6d8c%6]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 09:07:07 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>
CC:     "git (AMD-Xilinx)" <git@amd.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "claudiu.beznea@microchip.com" <claudiu.beznea@microchip.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "vitalyr@opensource.cirrus.com" <vitalyr@opensource.cirrus.com>
Subject: RE: [PATCH V7 1/7] spi: Add stacked and parallel memories support in
 SPI core
Thread-Topic: [PATCH V7 1/7] spi: Add stacked and parallel memories support in
 SPI core
Thread-Index: AQHZaFSfyRky5k4nrE+wjtXgiGyqUK8eSwSAgAeIDzA=
Date:   Tue, 11 Apr 2023 09:07:07 +0000
Message-ID: <BN7PR12MB2802CF25D5ADA9C8F00FCA0DDC9A9@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20230406065336.10980-1-amit.kumar-mahapatra@amd.com>
 <20230406065336.10980-2-amit.kumar-mahapatra@amd.com>
 <007c01d9688d$d770c670$86525350$@opensource.cirrus.com>
In-Reply-To: <007c01d9688d$d770c670$86525350$@opensource.cirrus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|SA0PR12MB4477:EE_
x-ms-office365-filtering-correlation-id: 54dcd42b-de3e-43c4-1f0d-08db3a6c2012
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nhE1VBnpf5DZUVeU+eXjohl91vkhv37Nl7M2HBBb6/O3XPb1uYS8zhicJS0VPA3lSfwR2CohErwaok26pwLbnjxn0YivSadz5M42+hoPTXppD6HJC6TcNu0fp7PoxH2eWjC+4tVR+7M0En0LynC4Otr7IOu6lb7tIyQeHcJ3aTXrjlONnfirE9Q1CnF40NclVeB38T5J86qI1pvC1JvxcEojmgMVzIh5PQ5GZM9PuMwJi47i25HV8edr+K/EO3QKtseK2HTM0LC3Ku7RZvYfQyH0ZZV7bEHbWSisiEZbbm9lH1NS0e04geGba5Q7xO+3lE6U5gZL4WtrDRUHnvYdZZmhGcQxIOTaK2O/XNdoGmcCdqjsiiF6YYPQikujVk1ZnRCFW0BZnjqLWUzpJmkNe9nykQgZ8yUyCM5Rzv3PJZxJYTPfPPRTNPgJeaypimdk91oVuv2P4zV5EWjLOGYtBV2aSAWkVHZvSUjo0FwYeMsjNrkKhSBMRAQLdlfzSpXGwcmNfcqeiMKrim9UJGtABgYfGQwNEoM9/k4QEEfUJIwEnSIYvOrqVVZkfdvh9MbkcVF3PyEniP3j+Vz+pzLSTERED2BGFP2F4RdQHkueW5Ni/ZZ4SxFUcCtU2YlzM3fY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(71200400001)(7696005)(478600001)(316002)(110136005)(53546011)(9686003)(26005)(6506007)(186003)(54906003)(2906002)(30864003)(5660300002)(4326008)(66946007)(76116006)(66446008)(41300700001)(8676002)(66476007)(7416002)(64756008)(52536014)(8936002)(66556008)(38100700002)(122000001)(86362001)(83380400001)(55016003)(33656002)(38070700005)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z5yY1skahxI+QkNgcr3sNI6/3D9AHpIw0Lc6tNt1SABsK68bYL6SqJtuYUbz?=
 =?us-ascii?Q?Zev/cUx6Kyg9SeYLTTYnFKKnU0OeEHXYSb8eHM/3HyZ696+MIDxhp3gSgzPQ?=
 =?us-ascii?Q?DLHB2n+tMrVCdB+qpw19yJ5fG0bWdFyjOBLVkaaodPEGKPDNgt9IjzLDW6in?=
 =?us-ascii?Q?B8IDK0d5ebB+47POJR5JOS/gdf8RGtN8fxnLUfUfmpX3zW00GZ5YUzCdP4JB?=
 =?us-ascii?Q?iDN7zvK/50fX0PRKqwBOM2sfFJwqDd99kl9Ys/1f27SGAJoRWUdVy0ItZMQd?=
 =?us-ascii?Q?kOUToh7YJ4TQextTDEXOkkFIyOHu2KOWHuAtUBHLkp5TL5KV0eDRjD6FKyZE?=
 =?us-ascii?Q?/dkgfXnIb+lyIN+OV8PLyx6oIIPG1T6i4mvdSSMeiDZ354FuwhQgKG3v27i3?=
 =?us-ascii?Q?IFkUrZJ0pZgfP2OfE7lIjSU3ReyQPjAW3gA1yJt8iDDBeg8s3XdOMCoCDcaY?=
 =?us-ascii?Q?5ynBpCYHsPJUESAjl7wAKxAQp2aP8s/ks6F96nsVldTvYBvUne8m4ceBI+yd?=
 =?us-ascii?Q?8Zv+HzVQLvKYnUO8c3LBf5g2ytkON3lIgmfMGmd4TPNAeE/YVGkI+pD3XD/Q?=
 =?us-ascii?Q?gUWvMTAyvxzmyGjtKO6PIm16kIAGiaqj6esPnTVitwG+LlpuwP8S42fcw8DR?=
 =?us-ascii?Q?tmEmF5nXc+VFv0ittMN+yHBgrPNrFL6xezP+Ql0iZjvCksWkoU9bo3YbE4II?=
 =?us-ascii?Q?7bOwADQzDruoIMJIzVHybkYSBI6rD8PojTLCGfKWj0U+XQBxll5s/cUyOBSz?=
 =?us-ascii?Q?/ADh20/mQSynpE7TalQprzAJUL+dw9wDQ0n5WPjU4kjk2nnP96tZLeBEFQyq?=
 =?us-ascii?Q?ZEBcVsmw6aVe/6KqHF9RosONrp/JXhhOiT4VM0Ie1ikW4DimHevSquZ46mph?=
 =?us-ascii?Q?Qv+5bVxzMEKlY3KdQO9kXwgl0JNKbtKTkEo9KFazcrL9IABTgQ2Sp7fDA7Fa?=
 =?us-ascii?Q?nUx7VWSaAvBtiKNqEaftUcAtyOGr+ZK//s28B96QE6k5WkoLHPsRK5/XlE76?=
 =?us-ascii?Q?Mwf+HvvIwmsdFnBz6pt93kFwl8EkKABjxNvNApnUo/kQppj9pUgFa0M2T8AP?=
 =?us-ascii?Q?Eh3J8DI2Jhv9Kxj05FZs+8XnMAw4v64zZbu0e6fxkOuyPYhKj9VqaaMLnnZG?=
 =?us-ascii?Q?jQ1ZM4fVIEiVxwGVLzxX1nWDD0RjRQUK2TzNuJYkkSMrD3V/VKhyQ97j6+xi?=
 =?us-ascii?Q?svH/1jzsU0kJzIl8BOULpO4SmFuyqOx0crhrYAAskkEMn12n8UMHa8kus/Jw?=
 =?us-ascii?Q?S2AbKMBOntBXjlXVxD/g0yBsNxj7BnmdDMfhIEL3ibu/o38JaF437wBmWaQX?=
 =?us-ascii?Q?r2JW1RlI5zZT5aY1CJTBQNTA6GQk9u63IV8tpQ++tNTDMTYuk+HjxQFDywpJ?=
 =?us-ascii?Q?SrrlNqc/z+0BBYrXkVFg8CtYotnXGEksR8Gfzd+JOmrqmoodYWkTFqzeQPpK?=
 =?us-ascii?Q?87OG8XG3CkquxF28p1NcsxQh56XNT3lDNoMFxmsuDWDywhB+aPdWNWr2cXe5?=
 =?us-ascii?Q?C+LyeR4tWHgI78eDV8PRu0ZstoW49QFT2k5V1HmgjKYKc/AD3if9V640ngzq?=
 =?us-ascii?Q?uHsk7OyIxqqzGzreU4M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dcd42b-de3e-43c4-1f0d-08db3a6c2012
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 09:07:07.1829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WsoBtZ1VnOyBwhDBygi1w0sgq5dsUhDILceYQuX+I4Py6heWOALJdrox4E5hocNx07LrHflIU24tHnMT2MnP3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stefan,

> -----Original Message-----
> From: Stefan Binding <sbinding@opensource.cirrus.com>
> Sent: Thursday, April 6, 2023 7:14 PM
> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
> broonie@kernel.org; tudor.ambarus@linaro.org; pratyush@kernel.org;
> michael@walle.cc; miquel.raynal@bootlin.com; richard@nod.at;
> vigneshr@ti.com
> Cc: git (AMD-Xilinx) <git@amd.com>; linux-spi@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-mtd@lists.infradead.org;
> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
> claudiu.beznea@microchip.com; Simek, Michal <michal.simek@amd.com>;
> linux-arm-kernel@lists.infradead.org; amitrkcian2002@gmail.com;
> patches@opensource.cirrus.com; vitalyr@opensource.cirrus.com
> Subject: RE: [PATCH V7 1/7] spi: Add stacked and parallel memories suppor=
t
> in SPI core
>=20
> Hi,
>=20
> > -----Original Message-----
> > From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> > Sent: Thursday, April 6, 2023 7:54 AM
> > To: broonie@kernel.org; tudor.ambarus@linaro.org; pratyush@kernel.org;
> > michael@walle.cc; miquel.raynal@bootlin.com; richard@nod.at;
> > vigneshr@ti.com
> > Cc: git@amd.com; sbinding@opensource.cirrus.com; linux-
> > spi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > mtd@lists.infradead.org; nicolas.ferre@microchip.com;
> > alexandre.belloni@bootlin.com; claudiu.beznea@microchip.com;
> > michal.simek@amd.com; linux-arm-kernel@lists.infradead.org;
> > amitrkcian2002@gmail.com; Amit Kumar Mahapatra <amit.kumar-
> > mahapatra@amd.com>
> > Subject: [PATCH V7 1/7] spi: Add stacked and parallel memories
> support
> > in SPI core
> >
> > For supporting multiple CS the SPI device need to be aware of all
> the CS
> > values. So, the "chip_select" member in the spi_device structure is
> now
> > an
> > array that holds all the CS values.
> >
> > spi_device structure now has a "cs_index_mask" member. This acts as
> an
> > index to the chip_select array. If nth bit of spi->cs_index_mask is
> set
> > then the driver would assert spi->chip_select[n].
> >
> > In parallel mode all the chip selects are asserted/de-asserted
> > simultaneously and each byte of data is stored in both devices, the
> even
> > bits in one, the odd bits in the other. The split is automatically
> handled
> > by the GQSPI controller. The GQSPI controller supports a maximum of
> > two flashes connected in parallel mode. A SPI_CONTROLLER_MULTI_CS flag
> > bit is added in the spi controntroller flags, through ctlr->flags the
> > spi
> core
> > will make sure that the controller is capable of handling multiple
> chip
> > selects at once.
> >
> > For supporting multiple CS via GPIO the cs_gpiod member of the
> > spi_device structure is now an array that holds the gpio descriptor
> > for each chipselect.
> >
> > Multi CS support using GPIO is not tested due to unavailability of
> > necessary hardware setup.
> >
> > Multi CS configuration with one native CS and one GPIO CS is not
> > supported as this configuration could not be tested due to
> > unavailability of necessary hardware setup.
>=20
> I've tested this chain on a released laptop (HP EliteBook 840 G9) which u=
ses
> SPI to interface to 2 amps, one amp uses a native CS and the other uses a
> GPIO CS, and I noticed that when using this chain, the second amp no long=
er
> works.

Thank you for testing this patch series on GPIO CS setup. As I don't have a=
=20
GPIO CS setup, is it possible for you debug the failure and share more=20
details/logs where the problem is?

Regards,
Amit

>=20
> Thanks,
> Stefan Binding
>=20
> >
> > Signed-off-by: Amit Kumar Mahapatra <amit.kumar-
> mahapatra@amd.com>
> > ---
> >  drivers/spi/spi.c       | 226
> ++++++++++++++++++++++++++++------------
> >  include/linux/spi/spi.h |  32 ++++--
> >  2 files changed, 183 insertions(+), 75 deletions(-)
> >
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c index
> > 9036d7a50674..04d7322170c4 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -612,10 +612,24 @@ static int spi_dev_check(struct device *dev,
> > void *data)  {
> >  	struct spi_device *spi =3D to_spi_device(dev);
> >  	struct spi_device *new_spi =3D data;
> > +	int idx, nw_idx;
> >
> > -	if (spi->controller =3D=3D new_spi->controller &&
> > -	    spi_get_chipselect(spi, 0) =3D=3D spi_get_chipselect(new_spi,
> 0))
> > -		return -EBUSY;
> > +	if (spi->controller =3D=3D new_spi->controller) {
> > +		for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
> > +			for (nw_idx =3D 0; nw_idx < SPI_CS_CNT_MAX;
> > nw_idx++) {
> > +				if ((idx !=3D 0 &&
> !spi_get_chipselect(spi,
> > idx)) ||
> > +				    (nw_idx !=3D 0 &&
> > !spi_get_chipselect(spi, nw_idx))) {
> > +					continue;
> > +				} else if (spi_get_chipselect(spi,
> idx) =3D=3D
> > +				    spi_get_chipselect(new_spi,
> nw_idx))
> > {
> > +					dev_err(dev,
> > +						"chipselect %d already
> > in use\n",
> > +
> > 	spi_get_chipselect(new_spi, nw_idx));
> > +					return -EBUSY;
> > +				}
> > +			}
> > +		}
> > +	}
> >  	return 0;
> >  }
> >
> > @@ -629,7 +643,7 @@ static int __spi_add_device(struct spi_device
> > *spi)
> >  {
> >  	struct spi_controller *ctlr =3D spi->controller;
> >  	struct device *dev =3D ctlr->dev.parent;
> > -	int status;
> > +	int status, idx;
> >
> >  	/*
> >  	 * We need to make sure there's no other device with this @@ -638,8
> > +652,6 @@ static int __spi_add_device(struct spi_device
> > *spi)
> >  	 */
> >  	status =3D bus_for_each_dev(&spi_bus_type, NULL, spi,
> spi_dev_check);
> >  	if (status) {
> > -		dev_err(dev, "chipselect %d already in use\n",
> > -				spi_get_chipselect(spi, 0));
> >  		return status;
> >  	}
> >
> > @@ -649,8 +661,10 @@ static int __spi_add_device(struct spi_device
> > *spi)
> >  		return -ENODEV;
> >  	}
> >
> > -	if (ctlr->cs_gpiods)
> > -		spi_set_csgpiod(spi, 0, ctlr-
> > >cs_gpiods[spi_get_chipselect(spi, 0)]);
> > +	if (ctlr->cs_gpiods) {
> > +		for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++)
> > +			spi_set_csgpiod(spi, idx, ctlr-
> > >cs_gpiods[spi_get_chipselect(spi, idx)]);
> > +	}
> >
> >  	/*
> >  	 * Drivers may modify this initial i/o setup, but will @@ -690,13
> > +704,15 @@ int spi_add_device(struct spi_device *spi)  {
> >  	struct spi_controller *ctlr =3D spi->controller;
> >  	struct device *dev =3D ctlr->dev.parent;
> > -	int status;
> > +	int status, idx;
> >
> > -	/* Chipselects are numbered 0..max; validate. */
> > -	if (spi_get_chipselect(spi, 0) >=3D ctlr->num_chipselect) {
> > -		dev_err(dev, "cs%d >=3D max %d\n",
> > spi_get_chipselect(spi, 0),
> > -			ctlr->num_chipselect);
> > -		return -EINVAL;
> > +	for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
> > +		/* Chipselects are numbered 0..max; validate. */
> > +		if (spi_get_chipselect(spi, idx) >=3D
> ctlr->num_chipselect) {
> > +			dev_err(dev, "cs%d >=3D max %d\n",
> > spi_get_chipselect(spi, idx),
> > +				ctlr->num_chipselect);
> > +			return -EINVAL;
> > +		}
> >  	}
> >
> >  	/* Set the bus ID string */
> > @@ -713,12 +729,15 @@ static int spi_add_device_locked(struct
> > spi_device *spi)  {
> >  	struct spi_controller *ctlr =3D spi->controller;
> >  	struct device *dev =3D ctlr->dev.parent;
> > +	int idx;
> >
> > -	/* Chipselects are numbered 0..max; validate. */
> > -	if (spi_get_chipselect(spi, 0) >=3D ctlr->num_chipselect) {
> > -		dev_err(dev, "cs%d >=3D max %d\n",
> > spi_get_chipselect(spi, 0),
> > -			ctlr->num_chipselect);
> > -		return -EINVAL;
> > +	for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
> > +		/* Chipselects are numbered 0..max; validate. */
> > +		if (spi_get_chipselect(spi, idx) >=3D
> ctlr->num_chipselect) {
> > +			dev_err(dev, "cs%d >=3D max %d\n",
> > spi_get_chipselect(spi, idx),
> > +				ctlr->num_chipselect);
> > +			return -EINVAL;
> > +		}
> >  	}
> >
> >  	/* Set the bus ID string */
> > @@ -966,58 +985,118 @@ static void spi_res_release(struct
> > spi_controller *ctlr, struct spi_message *mes  static void
> > spi_set_cs(struct spi_device *spi, bool enable, bool
> force)
> >  {
> >  	bool activate =3D enable;
> > +	u32 cs_num =3D __ffs(spi->cs_index_mask);
> > +	int idx;
> >
> >  	/*
> > -	 * Avoid calling into the driver (or doing delays) if the chip
> select
> > -	 * isn't actually changing from the last time this was called.
> > +	 * In parallel mode all the chip selects are
> asserted/de-asserted
> > +	 * at once
> >  	 */
> > -	if (!force && ((enable && spi->controller->last_cs =3D=3D
> > spi_get_chipselect(spi, 0)) ||
> > -		       (!enable && spi->controller->last_cs !=3D
> > spi_get_chipselect(spi, 0))) &&
> > -	    (spi->controller->last_cs_mode_high =3D=3D (spi->mode &
> > SPI_CS_HIGH)))
> > -		return;
> > -
> > -	trace_spi_set_cs(spi, activate);
> > -
> > -	spi->controller->last_cs =3D enable ? spi_get_chipselect(spi, 0)
> : -1;
> > -	spi->controller->last_cs_mode_high =3D spi->mode &
> > SPI_CS_HIGH;
> > -
> > -	if ((spi_get_csgpiod(spi, 0) ||
> !spi->controller->set_cs_timing)
> > && !activate)
> > -		spi_delay_exec(&spi->cs_hold, NULL);
> > -
> > -	if (spi->mode & SPI_CS_HIGH)
> > -		enable =3D !enable;
> > +	if ((spi->cs_index_mask & SPI_PARALLEL_CS_MASK) =3D=3D
> > SPI_PARALLEL_CS_MASK) {
> > +		spi->controller->last_cs_mode_high =3D spi->mode &
> > SPI_CS_HIGH;
> > +
> > +		if ((spi_get_csgpiod(spi, 0) || !spi->controller-
> > >set_cs_timing) && !activate)
> > +			spi_delay_exec(&spi->cs_hold, NULL);
> > +
> > +		if (spi->mode & SPI_CS_HIGH)
> > +			enable =3D !enable;
> > +
> > +		if (spi_get_csgpiod(spi, 0) && spi_get_csgpiod(spi,
> 1)) {
> > +			if (!(spi->mode & SPI_NO_CS)) {
> > +				/*
> > +				 * Historically ACPI has no means of
> the
> > GPIO polarity and
> > +				 * thus the SPISerialBus() resource
> > defines it on the per-chip
> > +				 * basis. In order to avoid a chain of
> > negations, the GPIO
> > +				 * polarity is considered being Active
> > High. Even for the cases
> > +				 * when _DSD() is involved (in the
> > updated versions of ACPI)
> > +				 * the GPIO CS polarity must be
> defined
> > Active High to avoid
> > +				 * ambiguity. That's why we use
> enable,
> > that takes SPI_CS_HIGH
> > +				 * into account.
> > +				 */
> > +				if (has_acpi_companion(&spi->dev)) {
> > +					for (idx =3D 0; idx <
> > SPI_CS_CNT_MAX; idx++)
> > +
> > 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
> > +
> > !enable);
> > +				} else {
> > +					for (idx =3D 0; idx <
> > SPI_CS_CNT_MAX; idx++)
> > +						/* Polarity handled by
> > GPIO library */
> > +
> > 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
> > +
> > activate);
> > +				}
> > +			}
> > +			/* Some SPI masters need both GPIO CS &
> > slave_select */
> > +			if ((spi->controller->flags &
> > SPI_MASTER_GPIO_SS) &&
> > +			    spi->controller->set_cs)
> > +				spi->controller->set_cs(spi, !enable);
> > +		} else if (spi->controller->set_cs) {
> > +			spi->controller->set_cs(spi, !enable);
> > +		}
> >
> > -	if (spi_get_csgpiod(spi, 0)) {
> > -		if (!(spi->mode & SPI_NO_CS)) {
> > -			/*
> > -			 * Historically ACPI has no means of the GPIO
> > polarity and
> > -			 * thus the SPISerialBus() resource defines it
> on
> > the per-chip
> > -			 * basis. In order to avoid a chain of
> negations,
> > the GPIO
> > -			 * polarity is considered being Active High.
> Even
> > for the cases
> > -			 * when _DSD() is involved (in the updated
> > versions of ACPI)
> > -			 * the GPIO CS polarity must be defined Active
> > High to avoid
> > -			 * ambiguity. That's why we use enable, that
> > takes SPI_CS_HIGH
> > -			 * into account.
> > -			 */
> > -			if (has_acpi_companion(&spi->dev))
> > -
> > 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), !enable);
> > +		if (spi_get_csgpiod(spi, 0) || spi_get_csgpiod(spi, 1)
> ||
> > +		    !spi->controller->set_cs_timing) {
> > +			if (activate)
> > +				spi_delay_exec(&spi->cs_setup, NULL);
> >  			else
> > -				/* Polarity handled by GPIO library */
> > -
> > 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), activate);
> > +				spi_delay_exec(&spi->cs_inactive,
> > NULL);
> >  		}
> > -		/* Some SPI masters need both GPIO CS & slave_select
> > */
> > -		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
> > -		    spi->controller->set_cs)
> > +	} else {
> > +		/*
> > +		 * Avoid calling into the driver (or doing delays) if
> the
> > chip select
> > +		 * isn't actually changing from the last time this was
> > called.
> > +		 */
> > +		if (!force && ((enable && spi->controller->last_cs =3D=3D
> > +				spi_get_chipselect(spi, cs_num)) ||
> > +				(!enable && spi->controller->last_cs
> !=3D
> > +				 spi_get_chipselect(spi, cs_num))) &&
> > +		    (spi->controller->last_cs_mode_high =3D=3D
> > +		     (spi->mode & SPI_CS_HIGH)))
> > +			return;
> > +
> > +		trace_spi_set_cs(spi, activate);
> > +
> > +		spi->controller->last_cs =3D enable ?
> > spi_get_chipselect(spi, cs_num) : -1;
> > +		spi->controller->last_cs_mode_high =3D spi->mode &
> > SPI_CS_HIGH;
> > +
> > +		if ((spi_get_csgpiod(spi, cs_num) || !spi->controller-
> > >set_cs_timing) && !activate)
> > +			spi_delay_exec(&spi->cs_hold, NULL);
> > +
> > +		if (spi->mode & SPI_CS_HIGH)
> > +			enable =3D !enable;
> > +
> > +		if (spi_get_csgpiod(spi, cs_num)) {
> > +			if (!(spi->mode & SPI_NO_CS)) {
> > +				/*
> > +				 * Historically ACPI has no means of
> the
> > GPIO polarity and
> > +				 * thus the SPISerialBus() resource
> > defines it on the per-chip
> > +				 * basis. In order to avoid a chain of
> > negations, the GPIO
> > +				 * polarity is considered being Active
> > High. Even for the cases
> > +				 * when _DSD() is involved (in the
> > updated versions of ACPI)
> > +				 * the GPIO CS polarity must be
> defined
> > Active High to avoid
> > +				 * ambiguity. That's why we use
> enable,
> > that takes SPI_CS_HIGH
> > +				 * into account.
> > +				 */
> > +				if (has_acpi_companion(&spi->dev))
> > +
> > 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, cs_num),
> > +
> > !enable);
> > +				else
> > +					/* Polarity handled by GPIO
> > library */
> > +
> > 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, cs_num),
> > +
> > activate);
> > +			}
> > +			/* Some SPI masters need both GPIO CS &
> > slave_select */
> > +			if ((spi->controller->flags &
> > SPI_MASTER_GPIO_SS) &&
> > +			    spi->controller->set_cs)
> > +				spi->controller->set_cs(spi, !enable);
> > +		} else if (spi->controller->set_cs) {
> >  			spi->controller->set_cs(spi, !enable);
> > -	} else if (spi->controller->set_cs) {
> > -		spi->controller->set_cs(spi, !enable);
> > -	}
> > +		}
> >
> > -	if (spi_get_csgpiod(spi, 0) ||
> !spi->controller->set_cs_timing) {
> > -		if (activate)
> > -			spi_delay_exec(&spi->cs_setup, NULL);
> > -		else
> > -			spi_delay_exec(&spi->cs_inactive, NULL);
> > +		if (spi_get_csgpiod(spi, cs_num) || !spi->controller-
> > >set_cs_timing) {
> > +			if (activate)
> > +				spi_delay_exec(&spi->cs_setup, NULL);
> > +			else
> > +				spi_delay_exec(&spi->cs_inactive,
> > NULL);
> > +		}
> >  	}
> >  }
> >
> > @@ -2246,8 +2325,8 @@ static void of_spi_parse_dt_cs_delay(struct
> > device_node *nc,  static int of_spi_parse_dt(struct spi_controller
> > *ctlr, struct
> spi_device
> > *spi,
> >  			   struct device_node *nc)
> >  {
> > -	u32 value;
> > -	int rc;
> > +	u32 value, cs[SPI_CS_CNT_MAX] =3D {0};
> > +	int rc, idx;
> >
> >  	/* Mode (clock phase/polarity/etc.) */
> >  	if (of_property_read_bool(nc, "spi-cpha")) @@ -2320,13 +2399,21
> @@
> > static int of_spi_parse_dt(struct spi_controller *ctlr, struct
> > spi_device *spi,
> >  	}
> >
> >  	/* Device address */
> > -	rc =3D of_property_read_u32(nc, "reg", &value);
> > -	if (rc) {
> > +	rc =3D of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
> > +						 SPI_CS_CNT_MAX);
> > +	if (rc < 0 || rc > ctlr->num_chipselect) {
> >  		dev_err(&ctlr->dev, "%pOF has no valid 'reg' property
> (%d)\n",
> >  			nc, rc);
> >  		return rc;
> > +	} else if ((of_property_read_bool(nc, "parallel-memories")) &&
> > +		   (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
> > +		dev_err(&ctlr->dev, "SPI controller doesn't support
> multi
> > CS\n");
> > +		return -EINVAL;
> >  	}
> > -	spi_set_chipselect(spi, 0, value);
> > +	for (idx =3D 0; idx < rc; idx++)
> > +		spi_set_chipselect(spi, idx, cs[idx]);
> > +	/* By default set the spi->cs_index_mask as 1 */
> > +	spi->cs_index_mask =3D 0x01;
> >
> >  	/* Device speed */
> >  	if (!of_property_read_u32(nc, "spi-max-frequency", &value)) @@
> > -3907,7 +3994,8 @@ static int __spi_validate(struct spi_device *spi,
> > struct spi_message *message)
> >  	 * cs_change is set for each transfer.
> >  	 */
> >  	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits &
> > SPI_CS_WORD) ||
> > -					  spi_get_csgpiod(spi, 0))) {
> > +					  spi_get_csgpiod(spi, 0) ||
> > +					  spi_get_csgpiod(spi, 1))) {
> >  		size_t maxsize;
> >  		int ret;
> >
> > diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h index
> > 873ced6ae4ca..6453b246e0af 100644
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -19,6 +19,11 @@
> >  #include <linux/acpi.h>
> >  #include <linux/u64_stats_sync.h>
> >
> > +/* Max no. of CS supported per spi device */ #define SPI_CS_CNT_MAX 2
> > +
> > +/* chip select mask */
> > +#define SPI_PARALLEL_CS_MASK	(BIT(0) | BIT(1))
> >  struct dma_chan;
> >  struct software_node;
> >  struct ptp_system_timestamp;
> > @@ -166,6 +171,7 @@ extern void
> > spi_transfer_cs_change_delay_exec(struct spi_message *msg,
> >   *	deasserted. If @cs_change_delay is used from @spi_transfer,
> > then the
> >   *	two delays will be added up.
> >   * @pcpu_statistics: statistics for the spi_device
> > + * @cs_index_mask: Bit mask of the active chipselect(s) in the
> > chipselect array
> >   *
> >   * A @spi_device is used to interchange data between an SPI slave
> >   * (usually a discrete chip) and CPU memory.
> > @@ -181,7 +187,7 @@ struct spi_device {
> >  	struct spi_controller	*controller;
> >  	struct spi_controller	*master;	/* Compatibility layer
> */
> >  	u32			max_speed_hz;
> > -	u8			chip_select;
> > +	u8			chip_select[SPI_CS_CNT_MAX];
> >  	u8			bits_per_word;
> >  	bool			rt;
> >  #define SPI_NO_TX	BIT(31)		/* No transmit wire */
> > @@ -202,7 +208,7 @@ struct spi_device {
> >  	void			*controller_data;
> >  	char			modalias[SPI_NAME_SIZE];
> >  	const char		*driver_override;
> > -	struct gpio_desc	*cs_gpiod;	/* Chip select gpio
> desc
> > */
> > +	struct gpio_desc	*cs_gpiod[SPI_CS_CNT_MAX];	/*
> Chip
> > select gpio desc */
> >  	struct spi_delay	word_delay; /* Inter-word delay */
> >  	/* CS delays */
> >  	struct spi_delay	cs_setup;
> > @@ -212,6 +218,13 @@ struct spi_device {
> >  	/* The statistics */
> >  	struct spi_statistics __percpu	*pcpu_statistics;
> >
> > +	/* Bit mask of the chipselect(s) that the driver need to use
> from
> > +	 * the chipselect array.When the controller is capable to
> handle
> > +	 * multiple chip selects & memories are connected in parallel
> > +	 * then more than one bit need to be set in cs_index_mask.
> > +	 */
> > +	u32			cs_index_mask : SPI_CS_CNT_MAX;
> > +
> >  	/*
> >  	 * likely need more hooks for more protocol options affecting how
> >  	 * the controller talks to each chip, like:
> > @@ -268,22 +281,22 @@ static inline void *spi_get_drvdata(const struct
> > spi_device *spi)
> >
> >  static inline u8 spi_get_chipselect(const struct spi_device *spi,
> u8 idx)
> >  {
> > -	return spi->chip_select;
> > +	return spi->chip_select[idx];
> >  }
> >
> >  static inline void spi_set_chipselect(struct spi_device *spi, u8
> idx, u8
> > chipselect)
> >  {
> > -	spi->chip_select =3D chipselect;
> > +	spi->chip_select[idx] =3D chipselect;
> >  }
> >
> >  static inline struct gpio_desc *spi_get_csgpiod(const struct
> spi_device
> > *spi, u8 idx)
> >  {
> > -	return spi->cs_gpiod;
> > +	return spi->cs_gpiod[idx];
> >  }
> >
> >  static inline void spi_set_csgpiod(struct spi_device *spi, u8 idx,
> struct
> > gpio_desc *csgpiod)
> >  {
> > -	spi->cs_gpiod =3D csgpiod;
> > +	spi->cs_gpiod[idx] =3D csgpiod;
> >  }
> >
> >  /**
> > @@ -388,6 +401,8 @@ extern struct spi_device
> > *spi_new_ancillary_device(struct spi_device *spi, u8 ch
> >   * @bus_lock_spinlock: spinlock for SPI bus locking
> >   * @bus_lock_mutex: mutex for exclusion of multiple callers
> >   * @bus_lock_flag: indicates that the SPI bus is locked for
> exclusive use
> > + * @multi_cs_cap: indicates that the SPI Controller can
> assert/de-assert
> > + *	more than one chip select at once.
> >   * @setup: updates the device mode and clocking records used by a
> >   *	device's SPI controller; protocol code may call this.  This
> >   *	must fail if an unrecognized or unsupported mode is requested.
> > @@ -554,6 +569,11 @@ struct spi_controller {
> >  #define SPI_CONTROLLER_MUST_TX		BIT(4)	/* Requires tx
> > */
> >
> >  #define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must
> select
> > slave */
> > +	/*
> > +	 * The spi-controller has multi chip select capability and can
> > +	 * assert/de-assert more than one chip select at once.
> > +	 */
> > +#define SPI_CONTROLLER_MULTI_CS		BIT(6)
> >
> >  	/* Flag indicating if the allocation of this struct is devres-
> > managed */
> >  	bool			devm_allocated;
> > --
> > 2.17.1
>=20

