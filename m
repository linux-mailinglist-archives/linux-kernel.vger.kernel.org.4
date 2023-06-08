Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA75727B69
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbjFHJaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbjFHJ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:29:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52A330F2;
        Thu,  8 Jun 2023 02:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuYu0dqaFDCDGZ2fz3bsCQuXt51CVyYHXYe3kmOxmRHr2u7VUe2UBltIMSAxDxTyJyQJHmCqlFu08WQu3JJUnj5zYrRl+j/Tj52SgWnkIT6tshM+/l7vVTvebULWcI8Y0FK2IQ0xwxPKCmiBRezXUD7CwdNGSEEP+YjmC4iUNuIV6TiBIBjnJ1YlRbrSHRZh/PBUQvY/s0nV2O6+69Gppq9QDBqjVP2ZwJSCYtS1+Fd7Vcjs00mPQFGdVK6IqaLkpjHuw8/hb0H40EGZvsDmvW+lbwGaYZ/0a0QVdh9aV2M9GgkqPZSelerDjLWCXpZPWdmvd9eAivTYhNcJer/XYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6e/1NucyXXIgz99UiXoQpzS6kNyeGBypzxqlyuLCw7I=;
 b=YrJaiA2iichlbk0UaMJfnb02eA/XfXT6PIF2psa3P9LEomh+XFgYjzAtsJ3FwDLP7QPg7J8CnkaGY8pntx9lc8ekvtJs8GLKaj3tHKSq2zrmd+BcqfAJTXkQw5cgveXmjr6dqE0kxaTWybH/GPd0OxC8LmbGDI+THBRqdtLgamrUP8NRnHjGacKd28RL9fSZPdG/YQcOYDPkqoH2pxWWUrtvkoBklAJEfzZmDi5TLSxDVTWJOKbjNi+iRhGgfJiVKcB7Q5Nl2ZGSKa/1h7IQ4ypdXSM6qphk+YzSadb45uQ8687t+JwzgcBvgSLGy6QTB/Afi5HezVrbL0shJ3QlRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e/1NucyXXIgz99UiXoQpzS6kNyeGBypzxqlyuLCw7I=;
 b=clXEktNWgO6j+B0FRMqBy8jK9inUIhHGktRV8qDY9iu29rUcwjLP6CJpe14To75YpuEXJm19qly8MpSyNWntUhLdrKks9tQWT30vG8KsHB/Umd3983KUf17egNOHgeA+A4kdq9MRaWOOhoqOiYvjf+CE2CFl32oXYe8sfivZ4hI=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 09:29:11 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::3087:7db7:f0eb:cb8f]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::3087:7db7:f0eb:cb8f%2]) with mapi id 15.20.6455.039; Thu, 8 Jun 2023
 09:29:11 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Pratyush Yadav <pratyush@kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "claudiu.beznea@microchip.com" <claudiu.beznea@microchip.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH V8 1/7] spi: Add stacked and parallel memories support in
 SPI core
Thread-Topic: [PATCH V8 1/7] spi: Add stacked and parallel memories support in
 SPI core
Thread-Index: AQHZg9qvodZvp17JL06akOelv8vWJ69zHxsngA1lVwA=
Date:   Thu, 8 Jun 2023 09:29:10 +0000
Message-ID: <BN7PR12MB28021BC5352C8C1774B64E0BDC50A@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20230511073134.41180-1-amit.kumar-mahapatra@amd.com>
        <20230511073134.41180-2-amit.kumar-mahapatra@amd.com>
 <mafs0bki16b20.fsf@amazon.de>
In-Reply-To: <mafs0bki16b20.fsf@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|LV3PR12MB9233:EE_
x-ms-office365-filtering-correlation-id: ce5fad95-da09-438e-13a4-08db6802d106
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QKYPXrIN+FBWzH5l/Y3CK6/agK0JK2mEwKH3ec/YEggVOt/cmKybawdi82sOEr20iJCVLPr+hVp0EXYM1W/I3gcHp6eHzFQVP1cdT7Sb/8FdlrRZy+Jp9fWVHXlExs40HMtpJ62fGoCKOiU4AIIwtkLmM8M/vCWPqxd71reJlKIoWqwMBq7SUUSq5T3euD36DKs6GU1EK0hVcPdKhNHueXQvncpqCY9RsNn1B9lYD62f+MvEHXT32BaqXBmd/fDsi/swhO2uIpD+P8Ks9bc+vep45KPdEVkIzfBYPFdShDozKw7SadV/VJ69msUZ6J4casurZy+/DlqpoEfFQ/9hh8KqtrLZjExyKjRajk4r5I8dyI3/OqAq7aOshaYC9mGn0fhmAKQJWiWWCIYZww6N0581mxE6Jcz5PlxhE/7Crh+0/W+ESxjCa8HAo4OHTVLBu6FSlZzbRTORlGuEXUzdRY9nJRNmA8HwD2KqbWMZlI1phx7ty94m/8mbKibsUIldZoVc4V8ZHF0jKNVRUqUylKMdE9k7mS7kh+7wopN2sNrfs137aBckvnvSCctwruebqv3AspuZ8jK8p7IbWSnWBBhDV0fVcYhZzWmTfrcrLFo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(5660300002)(33656002)(38070700005)(30864003)(2906002)(52536014)(86362001)(7416002)(55016003)(71200400001)(966005)(83380400001)(53546011)(9686003)(26005)(6506007)(316002)(478600001)(54906003)(7696005)(64756008)(6916009)(66946007)(38100700002)(4326008)(41300700001)(66446008)(76116006)(186003)(122000001)(66556008)(66476007)(8936002)(8676002)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XS3pxblO0xfPhjpzSir2atSfXMHSuNb0qBo5UFX9zvpzglHR07VvGTAPHVMw?=
 =?us-ascii?Q?mW42y/j7X7nL3ZaswUl5l2YzjX7iwOoOqpKP+Zkgda0OdoWpIJqNFuZyK/53?=
 =?us-ascii?Q?NI9EGP2Od0vJSUP1vd+AuXf3WGDgQSG9kzlSvsZnGVBv0ujgKr3WmjEvv5yH?=
 =?us-ascii?Q?timhz1OAoFH8fjsocPbtbAqRvUZvaa89KGoMTIAsbdVWi6Vh5eWYI6uw2j6k?=
 =?us-ascii?Q?BxajojB85f26wm6OiL4uj4FrvK4rEVi9v2Z31NXMwibUyofhYfxcxlgWBp5+?=
 =?us-ascii?Q?IiU1qHkKjf52amviEG/eh4r1BLJORZicLZedB4zLH3QEKhfa2SHOweHBFt1j?=
 =?us-ascii?Q?LoAL8sFUI1DZRyaXatOCT/nIG4efa0ge3/osaGI9dG+Bs6A+R1KrKOP8LGRP?=
 =?us-ascii?Q?F3dcil8OzZjuvbynhfKxQBTDzeMIy0JH1IuHqFZY0Mgv9Pynp5OGiJnNxKCr?=
 =?us-ascii?Q?db/e56CH+OYygNs8SBlG34bZvM0LpMv0GS9Xq85rjm/eoJbMvwdb7x5/7bg2?=
 =?us-ascii?Q?sP4C1G7QNAqSnhMQt6qL/ehYfqqDFBBJR1EpJuuS/RHPQ9MWCsuCwhRU0z/E?=
 =?us-ascii?Q?1PRDBeYtScIIkLpMkSuKy89Kq9Qrff7PtbhM9v3oiXN08dMEEP0yupCCECn0?=
 =?us-ascii?Q?I8y8X52xxAXuasw4UGaYM0sobTjt9l/eXCrNOBwDFVNe7mfmc+rds0fwXL+r?=
 =?us-ascii?Q?oiS6Fsq1z3l5zkl+LRIJyioItUxOdOCLmoJAVLZFYx/uvwa+3mqlFO8CuRL7?=
 =?us-ascii?Q?zDfb3mLaCd80OL/q35mJm4JevZc0zsQO9uqsjHxHoTcdCuD8ZTaQyUQ4DIpU?=
 =?us-ascii?Q?vgYan55n9C7qe24MrmgUo0iHmBxTfAQAyPHgdzpfaWNeF/jndKClE2a3Z4nb?=
 =?us-ascii?Q?Npuh6R3fi1Bp+fbJfWEmPN4BnzmEfl8J1PVxR+6vEeiJq+RGh6s/AVtkg/CA?=
 =?us-ascii?Q?wF1Kq4vU2ZLZQH3pq+dd/Q1AkpWTabJFkGw7YuQ3EVEb6hlolmdsArBBSZuE?=
 =?us-ascii?Q?mgkcTAm79dKlz5LZqbtisywSdNOrrBKYbaa+xbKJvAnY7zvBUpHJjtNuHqio?=
 =?us-ascii?Q?aOS86edbY+6JWzlmiJIGgH5WJansGB0nXadumRJw4DyTkyenlfm7Wz+SXhQ2?=
 =?us-ascii?Q?fOsbhSxEBKCYKsf8pfMQz6ccZHgtFxGx1spxpg0s76oBFS9D/4xQMYgtassK?=
 =?us-ascii?Q?usnz/GjS5cpJM3ssOdJaTR5LEBApVAeytFKaDBRzxcpk/WcDc7XZyJyDG9iV?=
 =?us-ascii?Q?adEB+6U5LrZyMojK6iMSo03G3qdqR2YY4DDbttDKnRmjfbXXL+pVaUSRwsVh?=
 =?us-ascii?Q?l3ipqzmjSCMHFR6szB+jrfFU61DUxJhEwwJvr1wDBG6CgPfovEtAC2t4g4VL?=
 =?us-ascii?Q?KldAwObDprShy+QBcv3XtqJDf2BDVfM2+nh+yjFNmZvq4+HpG8fYn3TdXRHi?=
 =?us-ascii?Q?DxnyEclfsB7HJP7HMGiRcSZzfpfCYdwFWOXEZ02uAepUxXx0YlkNkBKo9C90?=
 =?us-ascii?Q?STYC1fo0V5aeue45yH5g58zEi4HlJNrFMLKalupj2hR5xai1rU7mL/yYiYw0?=
 =?us-ascii?Q?HIw7o9msNgzfw6F1/Kc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5fad95-da09-438e-13a4-08db6802d106
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 09:29:10.8899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+N+kOYNE10JdAAwuXho+qr1dNa1sZwTQy2l4RGlBUzPFrDcSeExeFeUI6EBIEf0FS/ncIFaoudRMprmwGhJ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pratyush,

> -----Original Message-----
> From: Pratyush Yadav <pratyush@kernel.org>
> Sent: Tuesday, May 30, 2023 9:56 PM
> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
> Cc: broonie@kernel.org; tudor.ambarus@linaro.org; pratyush@kernel.org;
> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com;
> michael@walle.cc; sbinding@opensource.cirrus.com; git (AMD-Xilinx)
> <git@amd.com>; linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-mtd@lists.infradead.org; nicolas.ferre@microchip.com;
> alexandre.belloni@bootlin.com; claudiu.beznea@microchip.com; Simek,
> Michal <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org;
> amitrkcian2002@gmail.com
> Subject: Re: [PATCH V8 1/7] spi: Add stacked and parallel memories suppor=
t in
> SPI core
>=20
> Hi Amit,
>=20
> I did not get a chance to look at all the old comments in the previous ve=
rsions.
> So apologies in advance if I comment something that has already been
> mentioned before.
>=20
> On Thu, May 11 2023, Amit Kumar Mahapatra wrote:
>=20
> > For supporting multiple CS the SPI device need to be aware of all the
> > CS values. So, the "chip_select" member in the spi_device structure is
> > now an array that holds all the CS values.
> >
> > spi_device structure now has a "cs_index_mask" member. This acts as an
> > index to the chip_select array. If nth bit of spi->cs_index_mask is
> > set then the driver would assert spi->chip_select[n].
> >
> > In parallel mode all the chip selects are asserted/de-asserted
> > simultaneously and each byte of data is stored in both devices, the
> > even bits in one, the odd bits in the other. The split is
> > automatically handled by the GQSPI controller. The GQSPI controller
> > supports a maximum of two flashes connected in parallel mode. A
> > SPI_CONTROLLER_MULTI_CS flag bit is added in the spi controntroller
> > flags, through ctlr->flags the spi core
>=20
> Typo: s/controntroller/controller/

I will fix it.
>=20
> > will make sure that the controller is capable of handling multiple
> > chip selects at once.
> >
> > For supporting multiple CS via GPIO the cs_gpiod member of the
> > spi_device structure is now an array that holds the gpio descriptor
> > for each chipselect.
>=20
> General comment: For large changes, it is useful to describe a high-level
> overview of your new design so reviewers and future readers can get a
> mental model of what is going on. I did not see anything of that sort in =
this
> series.

I will add a high-level overview of multi-cs and stacked connection mode.
>=20
> >
> > Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> > ---
> > CS GPIO is not tested on our hardware but it has been tested by
> > @Stefan
> > https://lore.kernel.org/all/3f148a0c-8885-0425-28f4-2a53937a388f@opens
> > ource.cirrus.com/ Stefan, could you please provide your Tested-by tag
> > for this patch
> > ---
> >  drivers/spi/spi.c       | 231 ++++++++++++++++++++++++++++------------
> >  include/linux/spi/spi.h |  32 ++++--
> >  2 files changed, 189 insertions(+), 74 deletions(-)
> >
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> >
> > index 9291b2a0e887..a793e56f6a21 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -612,10 +612,24 @@ static int spi_dev_check(struct device *dev,
> > void *data)  {
> >  	struct spi_device *spi =3D to_spi_device(dev);
> >  	struct spi_device *new_spi =3D data;
> > +	int idx, nw_idx;
> >
> > -	if (spi->controller =3D=3D new_spi->controller &&
> > -	    spi_get_chipselect(spi, 0) =3D=3D spi_get_chipselect(new_spi, 0))
> > -		return -EBUSY;
> > +	if (spi->controller =3D=3D new_spi->controller) {
> > +		for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
> > +			for (nw_idx =3D 0; nw_idx < SPI_CS_CNT_MAX;
> nw_idx++) {
> > +				if ((idx !=3D 0 && !spi_get_chipselect(spi, idx))
> ||
> > +				    (nw_idx !=3D 0 && !spi_get_chipselect(spi,
> nw_idx))) {
>=20
> Hmm, from what I can understand, spi->chipselect[i] gives the correspondi=
ng
> physical CS for logical CS i. So for example, if both old and new devices=
 map
> logical CS 1 to physical CS 0, this would not detect the conflict.

Yes that's correct.=20
>=20
> What exactly are you trying to do here?

Initially by default all the spi->chip_select[i] are initialized to 0.=20
If a single slave device is connected to the physical CS 1 of the=20
controller, then the spi->chip_select[0] will hold 1 and=20
spi->chip_select[0] will hold 0 (the default value). =20
So, both the old and new devices spi->chip_select[1] holds the default=20
value 0 and spi_dev_check() will error out by saying that=20
physical CS 0 (i.e., spi->chip_select[1]) is already in use, which is not a=
ctually true as=20
spi->chip_select[1] doesn't contain any valid CS number.=20
To avoid this false trigger, we have this check in which we assume that=20
except logical CS 0(i.e., spi->chip_select[0]) if any other logical CS=20
holds 0 then it's not a valid physical CS but rather the default value.
This logic though has the downside as mentioned in your previous comment.

As an alternate solution we can initialize all the unused=20
spi->chip_select[i] to FF, in that case we can remove this check and any=20
combination of logical CS to physical CS can be covered. But if some=20
controller has FF (which is unlikely but still a possibility) as a valid=20
physical CS then this logic might not work.

please provide your thoughts on the same.
>=20
> > +					continue;
> > +				} else if (spi_get_chipselect(spi, idx) =3D=3D
> > +				    spi_get_chipselect(new_spi, nw_idx)) {
> > +					dev_err(dev,
> > +						"chipselect %d already in
> use\n",
> > +						spi_get_chipselect(new_spi,
> nw_idx));
> > +					return -EBUSY;
> > +				}
> > +			}
> > +		}
> > +	}
> >  	return 0;
> >  }
> >
> > @@ -629,7 +643,7 @@ static int __spi_add_device(struct spi_device
> > *spi)  {
> >  	struct spi_controller *ctlr =3D spi->controller;
> >  	struct device *dev =3D ctlr->dev.parent;
> > -	int status;
> > +	int status, idx;
> >
> >  	/*
> >  	 * We need to make sure there's no other device with this @@ -638,8
> > +652,6 @@ static int __spi_add_device(struct spi_device *spi)
> >  	 */
> >  	status =3D bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
> >  	if (status) {
> > -		dev_err(dev, "chipselect %d already in use\n",
> > -				spi_get_chipselect(spi, 0));
>=20
> Nitpick: No need for the braces around if anymore.

Will fix it in next version.
>=20
> >  		return status;
> >  	}
> >
> > @@ -649,8 +661,13 @@ static int __spi_add_device(struct spi_device *spi=
)
> >  		return -ENODEV;
> >  	}
> >
> > -	if (ctlr->cs_gpiods)
> > -		spi_set_csgpiod(spi, 0, ctlr->cs_gpiods[spi_get_chipselect(spi,
> 0)]);
> > +	if (ctlr->cs_gpiods) {
> > +		for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
> > +			if (!(idx !=3D 0 && !spi_get_chipselect(spi, idx)))
>=20
> Again, I don't get why you do this. This would simply fail for any device=
 that
> maps logical CS 1 to physical CS 0.

I have explained the reason above.
>=20
> > +				spi_set_csgpiod(spi, idx,
> > +						ctlr-
> >cs_gpiods[spi_get_chipselect(spi, idx)]);
> > +		}
> > +	}
> >
> >  	/*
> >  	 * Drivers may modify this initial i/o setup, but will @@ -690,13
> > +707,15 @@ int spi_add_device(struct spi_device *spi)  {
> >  	struct spi_controller *ctlr =3D spi->controller;
> >  	struct device *dev =3D ctlr->dev.parent;
> > -	int status;
> > +	int status, idx;
> >
> > -	/* Chipselects are numbered 0..max; validate. */
> > -	if (spi_get_chipselect(spi, 0) >=3D ctlr->num_chipselect) {
> > -		dev_err(dev, "cs%d >=3D max %d\n", spi_get_chipselect(spi, 0),
> > -			ctlr->num_chipselect);
> > -		return -EINVAL;
> > +	for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
> > +		/* Chipselects are numbered 0..max; validate. */
> > +		if (spi_get_chipselect(spi, idx) >=3D ctlr->num_chipselect) {
> > +			dev_err(dev, "cs%d >=3D max %d\n",
> spi_get_chipselect(spi, idx),
> > +				ctlr->num_chipselect);
> > +			return -EINVAL;
> > +		}
>=20
> Since this function is doing a bunch of sanity checks, I think you should=
 also
> make sure multiple logical CS don't map to the same physical CS. For
> example, make sure that spi->chip_select[0] !=3D
> spi->chip_select[1] and so on.

I will add the check.
>=20
> >  	}
> >
> >  	/* Set the bus ID string */
> > @@ -713,12 +732,15 @@ static int spi_add_device_locked(struct
> > spi_device *spi)  {
> >  	struct spi_controller *ctlr =3D spi->controller;
> >  	struct device *dev =3D ctlr->dev.parent;
> > +	int idx;
> >
> > -	/* Chipselects are numbered 0..max; validate. */
> > -	if (spi_get_chipselect(spi, 0) >=3D ctlr->num_chipselect) {
> > -		dev_err(dev, "cs%d >=3D max %d\n", spi_get_chipselect(spi, 0),
> > -			ctlr->num_chipselect);
> > -		return -EINVAL;
> > +	for (idx =3D 0; idx < SPI_CS_CNT_MAX; idx++) {
> > +		/* Chipselects are numbered 0..max; validate. */
> > +		if (spi_get_chipselect(spi, idx) >=3D ctlr->num_chipselect) {
> > +			dev_err(dev, "cs%d >=3D max %d\n",
> spi_get_chipselect(spi, idx),
> > +				ctlr->num_chipselect);
> > +			return -EINVAL;
> > +		}
>=20
> As adding a new device gets more complex, we should stop duplicating code
> between here and spi_add_device(). So you should either move this code to
> another function and call it from both places or add a new parameter call=
ed
> "locked" and merge spi_add_device() and spi_add_device_locked(). I do not
> have string preferences for either, but I do like the latter a bit more.

Agreed, will try to merge the functions into one.
>=20
> >  	}
> >
> >  	/* Set the bus ID string */
> > @@ -966,58 +988,122 @@ static void spi_res_release(struct
> > spi_controller *ctlr, struct spi_message *mes  static void
> > spi_set_cs(struct spi_device *spi, bool enable, bool force)  {
> >  	bool activate =3D enable;
> > +	u32 cs_num =3D 0;
> > +	int idx;
> >
> >  	/*
> > -	 * Avoid calling into the driver (or doing delays) if the chip select
> > -	 * isn't actually changing from the last time this was called.
> > +	 * In parallel mode all the chip selects are asserted/de-asserted
> > +	 * at once
> >  	 */
> > -	if (!force && ((enable && spi->controller->last_cs =3D=3D
> spi_get_chipselect(spi, 0)) ||
> > -		       (!enable && spi->controller->last_cs !=3D
> spi_get_chipselect(spi, 0))) &&
> > -	    (spi->controller->last_cs_mode_high =3D=3D (spi->mode &
> SPI_CS_HIGH)))
> > -		return;
> > -
> > -	trace_spi_set_cs(spi, activate);
> > +	if ((spi->cs_index_mask & SPI_PARALLEL_CS_MASK) =3D=3D
> > +SPI_PARALLEL_CS_MASK) {
>=20
> This check only works if you support a maximum of 2 CS in parallel. If yo=
u
> support up to, say, 4 then a chip which sets only CS 0 and 2 would not fa=
ll
> under this check.


Yes correct, this support is not added.
>=20
> I think your code in general should treat SPI_CS_CNT_MAX as an arbitrary
> value and should be able to handle changing it to any reasonable value.

I will rework on the logic.
>=20
> > +		spi->controller->last_cs_mode_high =3D spi->mode &
> SPI_CS_HIGH;
> > +
> > +		if ((spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing)
> && !activate)
> > +			spi_delay_exec(&spi->cs_hold, NULL);
> > +
> > +		if (spi->mode & SPI_CS_HIGH)
> > +			enable =3D !enable;
> > +
> > +		if (spi_get_csgpiod(spi, 0) && spi_get_csgpiod(spi, 1)) {
> > +			if (!(spi->mode & SPI_NO_CS)) {
> > +				/*
> > +				 * Historically ACPI has no means of the GPIO
> polarity and
> > +				 * thus the SPISerialBus() resource defines it
> on the per-chip
> > +				 * basis. In order to avoid a chain of
> negations, the GPIO
> > +				 * polarity is considered being Active High.
> Even for the cases
> > +				 * when _DSD() is involved (in the updated
> versions of ACPI)
> > +				 * the GPIO CS polarity must be defined Active
> High to avoid
> > +				 * ambiguity. That's why we use enable, that
> takes SPI_CS_HIGH
> > +				 * into account.
> > +				 */
> > +				if (has_acpi_companion(&spi->dev)) {
> > +					for (idx =3D 0; idx < SPI_CS_CNT_MAX;
> idx++)
> > +
> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
> > +
> !enable);
> > +				} else {
> > +					for (idx =3D 0; idx < SPI_CS_CNT_MAX;
> idx++)
> > +						/* Polarity handled by GPIO
> library */
> > +
> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
> > +
> activate);
> > +				}
> > +			}
> > +			/* Some SPI masters need both GPIO CS &
> slave_select */
> > +			if ((spi->controller->flags & SPI_MASTER_GPIO_SS)
> &&
> > +			    spi->controller->set_cs)
> > +				spi->controller->set_cs(spi, !enable);
> > +		} else if (spi->controller->set_cs) {
> > +			spi->controller->set_cs(spi, !enable);
> > +		}
> >
> > -	spi->controller->last_cs =3D enable ? spi_get_chipselect(spi, 0) : -1=
;
> > -	spi->controller->last_cs_mode_high =3D spi->mode & SPI_CS_HIGH;
> > +		if (spi_get_csgpiod(spi, 0) || spi_get_csgpiod(spi, 1) ||
> > +		    !spi->controller->set_cs_timing) {
> > +			if (activate)
> > +				spi_delay_exec(&spi->cs_setup, NULL);
> > +			else
> > +				spi_delay_exec(&spi->cs_inactive, NULL);
> > +		}
> > +	} else {
> >
> > -	if ((spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) &&
> !activate)
> > -		spi_delay_exec(&spi->cs_hold, NULL);
> > +		if (spi->cs_index_mask)
> > +			cs_num =3D ffs(spi->cs_index_mask) - 1;
> >
> > -	if (spi->mode & SPI_CS_HIGH)
> > -		enable =3D !enable;
> > +		/*
> > +		 * Avoid calling into the driver (or doing delays) if the chip
> select
> > +		 * isn't actually changing from the last time this was called.
> > +		 */
> > +		if (!force && ((enable && spi->controller->last_cs =3D=3D
> > +				spi_get_chipselect(spi, cs_num)) ||
> > +				(!enable && spi->controller->last_cs !=3D
> > +				 spi_get_chipselect(spi, cs_num))) &&
> > +		    (spi->controller->last_cs_mode_high =3D=3D
> > +		     (spi->mode & SPI_CS_HIGH)))
> > +			return;
> > +
> > +		trace_spi_set_cs(spi, activate);
> > +
> > +		spi->controller->last_cs =3D enable ? spi_get_chipselect(spi,
> cs_num) : -1;
> > +		spi->controller->last_cs_mode_high =3D spi->mode &
> SPI_CS_HIGH;
> > +
> > +		if ((spi_get_csgpiod(spi, cs_num) || !spi->controller-
> >set_cs_timing) && !activate)
> > +			spi_delay_exec(&spi->cs_hold, NULL);
> > +
> > +		if (spi->mode & SPI_CS_HIGH)
> > +			enable =3D !enable;
> > +
> > +		if (spi_get_csgpiod(spi, cs_num)) {
> > +			if (!(spi->mode & SPI_NO_CS)) {
> > +				/*
> > +				 * Historically ACPI has no means of the GPIO
> polarity and
> > +				 * thus the SPISerialBus() resource defines it
> on the per-chip
> > +				 * basis. In order to avoid a chain of
> negations, the GPIO
> > +				 * polarity is considered being Active High.
> Even for the cases
> > +				 * when _DSD() is involved (in the updated
> versions of ACPI)
> > +				 * the GPIO CS polarity must be defined Active
> High to avoid
> > +				 * ambiguity. That's why we use enable, that
> takes SPI_CS_HIGH
> > +				 * into account.
> > +				 */
> > +				if (has_acpi_companion(&spi->dev))
> > +
> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, cs_num),
> > +								 !enable);
> > +				else
> > +					/* Polarity handled by GPIO library */
> > +
> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, cs_num),
> > +								 activate);
> > +			}
> > +			/* Some SPI masters need both GPIO CS &
> slave_select */
> > +			if ((spi->controller->flags & SPI_MASTER_GPIO_SS)
> &&
> > +			    spi->controller->set_cs)
> > +				spi->controller->set_cs(spi, !enable);
> > +		} else if (spi->controller->set_cs) {
> > +			spi->controller->set_cs(spi, !enable);
> > +		}
> >
> > -	if (spi_get_csgpiod(spi, 0)) {
> > -		if (!(spi->mode & SPI_NO_CS)) {
> > -			/*
> > -			 * Historically ACPI has no means of the GPIO polarity
> and
> > -			 * thus the SPISerialBus() resource defines it on the
> per-chip
> > -			 * basis. In order to avoid a chain of negations, the
> GPIO
> > -			 * polarity is considered being Active High. Even for
> the cases
> > -			 * when _DSD() is involved (in the updated versions of
> ACPI)
> > -			 * the GPIO CS polarity must be defined Active High to
> avoid
> > -			 * ambiguity. That's why we use enable, that takes
> SPI_CS_HIGH
> > -			 * into account.
> > -			 */
> > -			if (has_acpi_companion(&spi->dev))
> > -
> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), !enable);
> > +		if (spi_get_csgpiod(spi, cs_num) || !spi->controller-
> >set_cs_timing) {
> > +			if (activate)
> > +				spi_delay_exec(&spi->cs_setup, NULL);
> >  			else
> > -				/* Polarity handled by GPIO library */
> > -
> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), activate);
> > +				spi_delay_exec(&spi->cs_inactive, NULL);
> >  		}
> > -		/* Some SPI masters need both GPIO CS & slave_select */
> > -		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
> > -		    spi->controller->set_cs)
> > -			spi->controller->set_cs(spi, !enable);
> > -	} else if (spi->controller->set_cs) {
> > -		spi->controller->set_cs(spi, !enable);
> > -	}
> > -
> > -	if (spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) {
> > -		if (activate)
> > -			spi_delay_exec(&spi->cs_setup, NULL);
> > -		else
> > -			spi_delay_exec(&spi->cs_inactive, NULL);
>=20
> I did not read this blob of code in detail yet. A couple of general comme=
nts
> though. You seem to be special-casing the multi-CS path. I do not think t=
hat is
> a good idea in general. Can you refactor it in such a way that the same b=
it of
> code handles an arbitrary number of chip selects being asserted at the sa=
me
> time?

Ok, I will rework to make a common code for asserting an arbitrary number o=
f chip selects.
>=20
> >  	}
> >  }
> >
> > @@ -2246,8 +2332,8 @@ static void of_spi_parse_dt_cs_delay(struct
> > device_node *nc,  static int of_spi_parse_dt(struct spi_controller *ctl=
r, struct
> spi_device *spi,
> >  			   struct device_node *nc)
> >  {
> > -	u32 value;
> > -	int rc;
> > +	u32 value, cs[SPI_CS_CNT_MAX] =3D {0};
> > +	int rc, idx;
> >
> >  	/* Mode (clock phase/polarity/etc.) */
> >  	if (of_property_read_bool(nc, "spi-cpha")) @@ -2320,13 +2406,21
> @@
> > static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_devi=
ce *spi,
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
>=20
> This error message is not very helpful for the rc > ctlr->num_chipselect =
case. I
> think you should make them separate checks and error messages.

Ok,  will separate the error checks.
>=20
> >  		return rc;
> > +	} else if ((of_property_read_bool(nc, "parallel-memories")) &&
>=20
> Nitpick: Why make it an else-if chain? Independent if statements would be
> better since these are not directly related.

Agreed.
>=20
> > +		   (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
> > +		dev_err(&ctlr->dev, "SPI controller doesn't support multi
> CS\n");
> > +		return -EINVAL;
> >  	}
>=20
> You should also make sure that no cs[idx] is greater than

Agreed, I will add the check.=20
> ctlr->num_chipselect. Perhaps also check for multple cs[idx] pointing to
> ctlr->the
> same physical CS? It might be better to check that in spi_add_device() th=
ough.
> Not sure...
>=20
> > -	spi_set_chipselect(spi, 0, value);
> > +	for (idx =3D 0; idx < rc; idx++)
> > +		spi_set_chipselect(spi, idx, cs[idx]);
> > +	/* By default set the spi->cs_index_mask as 1 */
>=20
> Nitpick: We can infer this fact quite easily by reading the code. The com=
ment
> should instead explain _why_ it is doing so.

I will add the explanation in comment.
>=20
> > +	spi->cs_index_mask =3D 0x01;
> >
> >  	/* Device speed */
> >  	if (!of_property_read_u32(nc, "spi-max-frequency", &value)) @@
> > -3905,7 +3999,8 @@ static int __spi_validate(struct spi_device *spi, st=
ruct
> spi_message *message)
> >  	 * cs_change is set for each transfer.
> >  	 */
> >  	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits &
> SPI_CS_WORD) ||
> > -					  spi_get_csgpiod(spi, 0))) {
> > +					  spi_get_csgpiod(spi, 0) ||
> > +					  spi_get_csgpiod(spi, 1))) {
>=20
> Again, you hard-code this to only ever supporting 2 CS in parallel.
> Please make it generic.

Ok, will make it generic.=20
>=20
> >  		size_t maxsize;
> >  		int ret;
> >
> > diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h index
> > cfe42f8cd7a4..d0f9a9a8b6d8 100644
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -19,6 +19,11 @@
> >  #include <linux/acpi.h>
> >  #include <linux/u64_stats_sync.h>
> >
> > +/* Max no. of CS supported per spi device */ #define SPI_CS_CNT_MAX 2
>=20
> This is fine, but...
>=20
> > +
> > +/* chip select mask */
> > +#define SPI_PARALLEL_CS_MASK	(BIT(0) | BIT(1))
>=20
> ... as I mentioned above, the way you write this patch you makes it diffi=
cult to
> change the limit in the future. Please refactor it so that if you just ch=
ange
> SPI_CS_CNT_MAX to any arbitrary value, the core is able to handle it.
>=20
> I also think calling it "parallel" can be a bit confusing. Perhaps use "M=
ulti CS"
> everywhere?

I named it parallel to align it with the DT property "parallel-memories"? =
=20
>=20
> >  struct dma_chan;
> >  struct software_node;
> >  struct ptp_system_timestamp;
> > @@ -166,6 +171,7 @@ extern void
> spi_transfer_cs_change_delay_exec(struct spi_message *msg,
> >   *	deasserted. If @cs_change_delay is used from @spi_transfer, then
> the
> >   *	two delays will be added up.
> >   * @pcpu_statistics: statistics for the spi_device
> > + * @cs_index_mask: Bit mask of the active chipselect(s) in the
> > + chipselect array
> >   *
> >   * A @spi_device is used to interchange data between an SPI slave
> >   * (usually a discrete chip) and CPU memory.
> > @@ -181,7 +187,7 @@ struct spi_device {
> >  	struct spi_controller	*controller;
> >  	struct spi_controller	*master;	/* Compatibility layer */
> >  	u32			max_speed_hz;
> > -	u8			chip_select;
> > +	u8			chip_select[SPI_CS_CNT_MAX];
>=20
> Should also update documentation for chip_select.

Will update it.

Regards,
Amit
>=20
> >  	u8			bits_per_word;
> >  	bool			rt;
> >  #define SPI_NO_TX		BIT(31)		/* No transmit wire */
> > @@ -212,7 +218,7 @@ struct spi_device {
> >  	void			*controller_data;
> >  	char			modalias[SPI_NAME_SIZE];
> >  	const char		*driver_override;
> > -	struct gpio_desc	*cs_gpiod;	/* Chip select gpio desc */
> > +	struct gpio_desc	*cs_gpiod[SPI_CS_CNT_MAX];	/* Chip select
> gpio desc */
> >  	struct spi_delay	word_delay; /* Inter-word delay */
> >  	/* CS delays */
> >  	struct spi_delay	cs_setup;
> > @@ -222,6 +228,13 @@ struct spi_device {
> >  	/* The statistics */
> >  	struct spi_statistics __percpu	*pcpu_statistics;
> >
> > +	/* Bit mask of the chipselect(s) that the driver need to use from
> > +	 * the chipselect array.When the controller is capable to handle
> > +	 * multiple chip selects & memories are connected in parallel
> > +	 * then more than one bit need to be set in cs_index_mask.
> > +	 */
> > +	u32			cs_index_mask : SPI_CS_CNT_MAX;
> > +
> >  	/*
> >  	 * likely need more hooks for more protocol options affecting how
> >  	 * the controller talks to each chip, like:
> > @@ -278,22 +291,22 @@ static inline void *spi_get_drvdata(const struct
> > spi_device *spi)
> >
> >  static inline u8 spi_get_chipselect(const struct spi_device *spi, u8
> > idx)  {
> > -	return spi->chip_select;
> > +	return spi->chip_select[idx];
> >  }
> >
> >  static inline void spi_set_chipselect(struct spi_device *spi, u8 idx,
> > u8 chipselect)  {
> > -	spi->chip_select =3D chipselect;
> > +	spi->chip_select[idx] =3D chipselect;
> >  }
> >
> >  static inline struct gpio_desc *spi_get_csgpiod(const struct
> > spi_device *spi, u8 idx)  {
> > -	return spi->cs_gpiod;
> > +	return spi->cs_gpiod[idx];
> >  }
> >
> >  static inline void spi_set_csgpiod(struct spi_device *spi, u8 idx,
> > struct gpio_desc *csgpiod)  {
> > -	spi->cs_gpiod =3D csgpiod;
> > +	spi->cs_gpiod[idx] =3D csgpiod;
> >  }
> >
> >  /**
> > @@ -398,6 +411,8 @@ extern struct spi_device
> *spi_new_ancillary_device(struct spi_device *spi, u8 ch
> >   * @bus_lock_spinlock: spinlock for SPI bus locking
> >   * @bus_lock_mutex: mutex for exclusion of multiple callers
> >   * @bus_lock_flag: indicates that the SPI bus is locked for exclusive
> > use
> > + * @multi_cs_cap: indicates that the SPI Controller can assert/de-asse=
rt
> > + *	more than one chip select at once.
> >   * @setup: updates the device mode and clocking records used by a
> >   *	device's SPI controller; protocol code may call this.  This
> >   *	must fail if an unrecognized or unsupported mode is requested.
> > @@ -564,6 +579,11 @@ struct spi_controller {
> >  #define SPI_CONTROLLER_MUST_TX		BIT(4)	/* Requires tx */
> >
> >  #define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must
> select slave */
> > +	/*
> > +	 * The spi-controller has multi chip select capability and can
> > +	 * assert/de-assert more than one chip select at once.
> > +	 */
> > +#define SPI_CONTROLLER_MULTI_CS		BIT(6)
> >
> >  	/* Flag indicating if the allocation of this struct is devres-managed=
 */
> >  	bool			devm_allocated;
>=20
> I only took a high level overview of this patch and I think it needs some
> reworking. I will take another look later when it gets in better shape. I=
 am
> especially worried about interactions with SPI MEM (not sure if there nee=
d to
> be any, but still I should take a look) and ACPI support. But I think you=
 have
> your work cut out for you for the next version :-)
>=20
> I also want to look at the SPI NOR parts, let's see if I can find some mo=
re time
> this week.
>=20
> --
> Regards,
> Pratyush Yadav
