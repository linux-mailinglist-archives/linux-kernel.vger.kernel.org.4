Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E745F247B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 20:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJBSHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 14:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJBSHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 14:07:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE84BC0D;
        Sun,  2 Oct 2022 11:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664734031; x=1696270031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aAEocF0BRw5qA40lgz0fm5KH1ylGC3Oa83ye/62V6Xo=;
  b=FLX3Y42FNHKDlEgpit6NSwA7uvuG4r0w77vAz1V9rZnrbtHBq5C5b3OF
   IUx2iJE3AuVlu04FkZi5DcWdd6lIKFp+ZNOHawnCWy9CZaOSXZInN3UGl
   2Z7Jrx33fUkAY/pX5aZyRbwVp2WfcEhl6200fIW9gsehh9zBKH1wnEcVC
   20te4hoEKdx90+B2j9EO8NNK+jiiqStzC63sjwEp0OOyycyrYpxnr8Ef9
   dLb3sgVX9N47pnC8af58a4+O17y9Hhr5vGVGLE5ryAgWJ3Ps9dlpT1Tuj
   1rIeXih3VO4G0xBP6eauabyWwF2HR97abBdFoYxxP4XnVVimMH3LUZyjX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="300099506"
X-IronPort-AV: E=Sophos;i="5.93,363,1654585200"; 
   d="scan'208";a="300099506"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2022 11:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="685873188"
X-IronPort-AV: E=Sophos;i="5.93,363,1654585200"; 
   d="scan'208";a="685873188"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 02 Oct 2022 11:07:10 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 2 Oct 2022 11:07:10 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 2 Oct 2022 11:07:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 2 Oct 2022 11:07:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 2 Oct 2022 11:07:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpMIVKAN4XCvtDvxEIY1begUOPxcU7G6VjBVhsvnzRC2Uc66v52q8WtyKwYNl78ufEJ3KJf0lXGX+4+ZCEkKMDxF0r3+deGKgGVtl7710YYXipFMS6Gr4bgZ0q+GUkqe2zW5oP8oq7YH/NczdcRLAxsE83hNPCgQmUdzsPGk8FeVF6pCqQTxXP6NFWnHGM6GgyKA9nlUmGbzEZYB2uToXV2bYrvfyskUO5H5mk79wyV2OfUqL+DNy7PHIrY8ooYEyzUdNnrN30ZhWQ2mBysLyoD1Wn/eA9biqdUhEsb97jHuBPkzDfuPH28KCiNSsyGA54XfL3yJaGOOprqTvyq0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWbRI2j9kM30+uE6nFO51uYI0/XIyG7LJyonmCT0Quw=;
 b=V2iMSMHo/+dSo3M2jR7Ca4f3mT6WOBKz1tQeD/c1AoCDwiN8B/ydjxansTI2iJ6VqgMq7B+ogsXbfpqVU758E4/kd9N1JJIRvbVHYf/1aM4tBiRm5HkDVi6IpEoPvZqb9FW/B2/Awek/HcEP7foFuofVREJeQRMDk9HsqZRWhEcDhfVbk+D+99SXPwfz6DvjJXzQLwDpoINU3KWy1RiajURELlPwF/npUPRFOSvlsPM6WrAzslMxoeXOk9i6F6EE42odLNhufff6B7shMfjdu/Gu5ngxwclWdhbA3r5qN5gqFjivn/y8eNdTdMQWm70zT8ec9i+UfugA9uhARVrhzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by CO1PR11MB5139.namprd11.prod.outlook.com (2603:10b6:303:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 2 Oct
 2022 18:07:08 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::9ee7:3ca:b4ab:59c0]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::9ee7:3ca:b4ab:59c0%6]) with mapi id 15.20.5676.028; Sun, 2 Oct 2022
 18:07:08 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iio: pressure: mpl115: Implementing low power mode by
 shutdown gpio
Thread-Topic: [PATCH v2] iio: pressure: mpl115: Implementing low power mode by
 shutdown gpio
Thread-Index: AQHY0c9qroXigyh3d0CNZ/vjgEF5xq37ICoAgABPNeA=
Date:   Sun, 2 Oct 2022 18:07:08 +0000
Message-ID: <CO1PR11MB4835CEA31B29A8235312281096589@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20220927174212.1776567-1-rajat.khandelwal@intel.com>
 <20221002142134.4d7c5fe9@jic23-huawei>
In-Reply-To: <20221002142134.4d7c5fe9@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|CO1PR11MB5139:EE_
x-ms-office365-filtering-correlation-id: 367ce9aa-2350-4cc0-0868-08daa4a0eba3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cMiXRmXroaJJU+0AwAcq+XFa2H7tRN30wIww2awwBlqp/+cSTjzMC0VQrAF7eEi5J1V7omIy9OzZcZzClMR4AuVNFVsEuPm3PAOmSHSCDw6XRlQDlwdT02ufuCoCx9sxKuoiTv5S/4hgQatKROFpADqNGByq1egCIb5cQ31hGkOToMYIw4ds8xuh6Jxi4VZ0tw4UU9DXKUjMvN4Ab9oRvz/dS5VPFc4ab9tKzLJTOBM0c7Rffl/bN0y1CzjN/PyZyyby4PXr//JQSka3eDT1ih+Flgfm0RcxVoNnRhNSg8J0py5A3z1DYj7eQAeiZEeHPzaG+HGVcvdVvkK4bmJIQZoAltmyWRwVCZ2IqaPT7XJMyMMUTdYEwmHClXQX7pG6oM0Z7Ly4/VDSAk0H9HJAv6EtNcgz6VqIaaZNpESp+gPsRCOLt9qToHQrI5dBrPvhywOUu000wqgVEPIeXtzIBKJILAEc4FGDLFsEsRF9pVqM+jHh6ec/BhnqCxa+GoVRvaEJde5QioerR+ttXWEda2YUt9LLd8AS0lP1SkPNblDhB3LfUG3IXF5sQJe9EJWww4zhvB7d3dLEAMQwERdKD3xDurG5Jh87mR53OP5+1aXcSjOx/Tqkx/BUgGJK9RUXbl2gdpyCkCr46DtQKdqKY57WAj6/evzp+8vQkyBPZ5RT1DC77npBe2W7iSSYE6jKMkBdahKou3hsK/6IsM3piMzGhfeAutPhEu7Xy6yuLlAiTdr3y3vyXL1qblux3a8oj7AS9MGxys0c9t3+5lJvrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(5660300002)(8936002)(52536014)(2906002)(76116006)(33656002)(4326008)(8676002)(64756008)(71200400001)(83380400001)(186003)(41300700001)(38070700005)(66446008)(53546011)(66476007)(66946007)(66556008)(26005)(86362001)(9686003)(7696005)(6506007)(478600001)(55016003)(38100700002)(54906003)(316002)(6916009)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NgY+QIo32kOVuNQ7o1LIIM6KeWy6WDQrqJsjNZ9Y8S7DJWR3e7zKyCVdwi7R?=
 =?us-ascii?Q?aXl96Xa71YGJ6TcxEeWAUmkHvKsCKlUrxAEEVJb1biidlkNt98LmmTcxGlWs?=
 =?us-ascii?Q?MjuRitP2WiWS+vEl+Z1snTndMLb3JOAx9qpNCSslTRSqxHuZjDwabkpZzce+?=
 =?us-ascii?Q?x203PXullf3+VCKQHp7vBMHhnk/ZCmeGf1gKHsGgZg/pbGARBSI0awk/+619?=
 =?us-ascii?Q?fTcyo3WTVGAXc2mewLDqjuMtp8FBP+ekDAeFtfyFc3zDK0tKShQaZkE1OItb?=
 =?us-ascii?Q?icLfVv6qkH8CqwCvl6hsp4RddgWntLxjV8zoa3nej2kYMZX2qd/uYkjjUxlC?=
 =?us-ascii?Q?HST7WXz67pLWCTVFsisufPRwnM+z8glgQBCwV+nKucG6FM9IPFVSHBhUd98A?=
 =?us-ascii?Q?Z6GjKApzzsCxmeHeaKxXH8mB8oW2f/DnKrNyX1nyEW0QlcXniPsVvvCWhPzL?=
 =?us-ascii?Q?awVFu1t4LQZdMff7pwaK6bmU1Czx4d/cYiW8rbQ1kxWBsfxojaAbY4l68lCk?=
 =?us-ascii?Q?Cupu5USzN9rI52Pfjqlhoo4QdnLVq2G1pN/oY1jHVFPUKnzS730vIwyk0PwO?=
 =?us-ascii?Q?5Y0TKQ7kKiAaeVyCzA9LYXWrGWHoLklWPeWakZMnT2i1gKowxmo0kYxFQjwE?=
 =?us-ascii?Q?6bBNFSgtLdRc+k2CrU3USWfnZDoiyd3SsVJFSi8GwBz2vgm54Pya/mBTFwnD?=
 =?us-ascii?Q?9Bv/0zZlTsILtz8o4xwzpDy6xTm+sB/j3AZpbhXP2Z0nv5d5NQryo3XcF3wR?=
 =?us-ascii?Q?Gm0gI7KxT+dn6+f5KgFQhHVWDcUE8GNBhgxr0/MEPSTVBYh8D5ekEcKcY6h1?=
 =?us-ascii?Q?atrFRhvMaAUqrU4rcM/hHxJe9WIBJxX9YqHH6QygqHxbgd3q+OSYCbCQKZeL?=
 =?us-ascii?Q?vlvEUWyTtp+CeJyFe7fzGuR/7Zfg/M+alTho7kGgjYAOq2FxmoXvxcxJVXRk?=
 =?us-ascii?Q?govXR/WYP1IJ/zlLufAQrMb1W1mBl7hKErWH933ty/TEbEW5dlBJRrbZcogd?=
 =?us-ascii?Q?wvNLH2ik6poLNfmo2alGCEjMCJJ1oART8Lu2X4QIyewotU8WmyQ5Z4pZuN//?=
 =?us-ascii?Q?xTORoUMG3wnDRmY6E4VNcnbmwc82nCJJy1Lene1Jkl3/QblypnQxlalKR1/e?=
 =?us-ascii?Q?b6PxeTvHRr1GDYYH/TFsLY+NwwkPvisQe39wtcBg3a5bYbDpak5L+4if9BmX?=
 =?us-ascii?Q?rYAj59mNA1bPsebTnmIz8EDJ5UEbCGmnav4rLnRs0GOmOm+VPfa7rhdn9VZy?=
 =?us-ascii?Q?AZg1vIftjoislcm+3icNyxCrNcVrG1BZ3D+oJ0zGDlhWB5sUe3U62hCQ+eDO?=
 =?us-ascii?Q?IEb00fjsXfcpfkG4lHePtwKao6XS9VBpGgFHfi+w9hkH1FHMdSx9eN1G6yL3?=
 =?us-ascii?Q?+Ocfdua1zYyxFtoP7lHXmNaI2J91FW68C8PSNcwuQYTxZ8USZ9sxs+O6h77c?=
 =?us-ascii?Q?xLfNyXbB1+xLfaA0dy2VVUmZTpIDMXuvc0KqMOybr8jT9yX/P6ahIw/Bmrtw?=
 =?us-ascii?Q?Xd4L4VmR2HPLZ8NzQz6pjJQ96EIWXORfwCLW+H3S3Ea2r5tqIonYAsqunDqF?=
 =?us-ascii?Q?+QlS+DQYf9arP8wo0lOOWTj0Oiva+tTz9hCE3SxLoKKvuL+Sn04HRlS6jAi6?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367ce9aa-2350-4cc0-0868-08daa4a0eba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2022 18:07:08.0930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcVEOVSUXvNohXCbdKWBi0XToQsAxXkbFFdiR5tCIL+9bq6Xr/QkmyeFoTeBZTwzl1ADu+GOLugdK6ShqyRUyRrrO2Hli2LJZyUEGSZQEyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5139
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>Ah. I missed there was a v2 and replied to v1.
No problem Jon and thanks for the suggestion. A delay of 5ms
was not worth it when calculation itself takes only ~3ms.=20
I have implemented runtime PM keeping a delay of 200 ms
which I think should suffice. Have sent you v3.=20

-----Original Message-----
From: Jonathan Cameron <jic23@kernel.org>=20
Sent: Sunday, October 2, 2022 6:52 PM
To: Khandelwal, Rajat <rajat.khandelwal@intel.com>
Cc: lars@metafoo.de; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.or=
g
Subject: Re: [PATCH v2] iio: pressure: mpl115: Implementing low power mode =
by shutdown gpio

On Tue, 27 Sep 2022 23:12:12 +0530
Rajat Khandelwal <rajat.khandelwal@intel.com> wrote:

> MPL115 supports shutdown gpio which can be used to set the default=20
> state to low power mode. Power from all internal circuits and=20
> registers is removed. This is done by pulling the SHDN pin to low.
> This patch sets the default mode to low-power and only exits when a=20
> reading is required from the chip. This maximises power savings.
>=20
> According to spec., a wakeup time period of ~5 ms exists between=20
> waking up and actually communicating with the device. This is=20
> implemented using sleep delay.
>=20
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@intel.com>
Ah. I missed there was a v2 and replied to v1.

> ---
>=20
> v2: Grammatically completing subject line
>=20
>  drivers/iio/pressure/mpl115.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/pressure/mpl115.c=20
> b/drivers/iio/pressure/mpl115.c index 5bf5b9abe6f1..c0ad3e941d05=20
> 100644
> --- a/drivers/iio/pressure/mpl115.c
> +++ b/drivers/iio/pressure/mpl115.c
> @@ -3,13 +3,12 @@
>   * mpl115.c - Support for Freescale MPL115A pressure/temperature sensor
>   *
>   * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
> - *
> - * TODO: shutdown pin
>   */
> =20
>  #include <linux/module.h>
>  #include <linux/iio/iio.h>
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> =20
>  #include "mpl115.h"
> =20
> @@ -27,6 +26,7 @@ struct mpl115_data {
>  	s16 a0;
>  	s16 b1, b2;
>  	s16 c12;
> +	struct gpio_desc *shutdown;
>  	const struct mpl115_ops *ops;
>  };
> =20
> @@ -102,13 +102,27 @@ static int mpl115_read_raw(struct iio_dev=20
> *indio_dev,
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> -		ret =3D mpl115_comp_pressure(data, val, val2);
> +		if (data->shutdown) {
> +			gpiod_set_value(data->shutdown, 0);
> +			usleep_range(5000, 6000);
> +			ret =3D mpl115_comp_pressure(data, val, val2);
> +			gpiod_set_value(data->shutdown, 1);
> +		} else
> +			ret =3D mpl115_comp_pressure(data, val, val2);
> +
>  		if (ret < 0)
>  			return ret;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_RAW:
>  		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
> -		ret =3D mpl115_read_temp(data);
> +		if (data->shutdown) {
> +			gpiod_set_value(data->shutdown, 0);
> +			usleep_range(5000, 6000);
> +			ret =3D mpl115_read_temp(data);
> +			gpiod_set_value(data->shutdown, 1);
> +		} else
> +			ret =3D mpl115_read_temp(data);
> +
>  		if (ret < 0)
>  			return ret;
>  		*val =3D ret >> 6;
> @@ -185,6 +199,17 @@ int mpl115_probe(struct device *dev, const char *nam=
e,
>  		return ret;
>  	data->c12 =3D ret;
> =20
> +	data->shutdown =3D devm_gpiod_get_optional(dev, "shutdown",
> +						 GPIOD_OUT_HIGH);
> +	if (IS_ERR(data->shutdown))
> +		return dev_err_probe(dev, PTR_ERR(data->shutdown),
> +				     "cannot get shutdown gpio\n");
> +
> +	if (data->shutdown)
> +		dev_dbg(dev, "low-power mode enabled");
> +	else
> +		dev_dbg(dev, "low-power mode disabled");
> +
>  	return devm_iio_device_register(dev, indio_dev);  } =20
> EXPORT_SYMBOL_NS_GPL(mpl115_probe, IIO_MPL115);

