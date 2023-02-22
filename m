Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A2C69F292
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjBVKVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBVKVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:21:01 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DB732CEB;
        Wed, 22 Feb 2023 02:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677061260; x=1708597260;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eCPXg7g6YUaiQXHbqJ9Q3FdaA2PQAiT1DfgSC77RHuY=;
  b=KeCHlEdf2NnwGyKsuUqQ5FnXqFrJNfKRySR82d4cMpQsZZ6UZmVC79sV
   nGOKvDcG6f6xG+Up5OIn6jDg+jeW7cuO400t9ffkQZH1lR9x/c9FTu3Z7
   2JiKDtbStRvv2yPnEDfaMPit34f6YrcOa4ss2yFb+ekjQb0m+kx6x3HFv
   KIaw6VdDV+qWLt56kExqIXcGTiVit5rF3xUUhL4yeJsE6y059c6aVuYLb
   Jp+SIdLU9WREnsUd3mrCuCIrbzWABfm1KQtBcNuJ22iTUI0C4Zu5NPkJY
   eHiWq+MCXYFpNAxcAkZMfrz+cNnZvGSuxLc7p12GxF5SRLhNDyJ2Cw65o
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,318,1669100400"; 
   d="scan'208";a="213139345"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Feb 2023 03:20:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 03:20:59 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 22 Feb 2023 03:20:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GS7K7nbT32AnmglaGAvsoGOcnXIYxvA40nxmC/JdK7hKF86QE8+lbIejV2c2D/oVSO6oSGShEB/c2c3WxvpcBSs4u59VKslLldldH7m3XW8UE/5MmBeTKBBhoAxlrdwtMtbpuxiHUHhE7EbT4LE7beyAD1ufjPUwblStWDfy2qQk+258x5PnDGewyGEVcdzreM/4JP6AqrO3EKLn2bxA2SnTSFmeiPJseLYY+FEAP4+DTXAz8HwsUurPQalQ363PuczJ4+UkDPtZCgwc5RLyU3ggz8cAOhviYZ5SEqeE0CkntBYvkBrpOBjhPT6lDotWyL6Xn9VAz6NLimV2GTq8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BAvaU87ZGXAbWyiljMP1hrHBmudDbLM9/oP1D7fASA=;
 b=GKR7Yseuob2zi5ojASvfzQKfz8rS1xuPCPh5Jl/XKVik0ByLUbSn3JMtjYh5/VrDOO/3Jl/DKv4ikm4VS4ahCcK9GJ1Af9w8MBy9J1t0F/ZOse/ACp6FL/KKGQNAG5GQNZqraqDANjtdW8RCfrWij20+NXD03c1C90uAbXPc7uzLM12GKIe2M/uHNP4RoYHtXB+Gwso/0oQwyp1rEJV5flRrMrNprNdVAFVjNm2zVPcxYQUb7Rxmw3M6x95Csoc01FuL2fiDGPCBRrd+4HGLIF/IhL9l2ZvsaENz1NzY/Eeb4b4xUR6tkWEjkpGjd4BfAi1CXIVU1miU+PBMMSJs+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BAvaU87ZGXAbWyiljMP1hrHBmudDbLM9/oP1D7fASA=;
 b=WDXbHV0IvdOU4d5C2yW1YnbiDadWTW6ZhSfVFTZp4Esmff0PyY13MTfIJd9N/N7B9XouH67+vU5m6VfFTTS+x0lYmYSSvuir/9fhJM5K8/c43IozLym4cWID+UelpJpJ3QmrWBJrtTz6P6GWFdNr/73aT+pojXm5tqszlrAVHvs=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by LV2PR11MB5998.namprd11.prod.outlook.com (2603:10b6:408:17e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 10:20:56 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6f3f:f30b:e31e:1fc7]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6f3f:f30b:e31e:1fc7%5]) with mapi id 15.20.6111.020; Wed, 22 Feb 2023
 10:20:56 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <sakari.ailus@iki.fi>, <Conor.Dooley@microchip.com>
CC:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <jacopo.mondi@ideasonboard.com>, <Prakash.Battu@microchip.com>
Subject: RE: [PATCH v11 3/5] media: i2c: imx334: support lower bandwidth mode
Thread-Topic: [PATCH v11 3/5] media: i2c: imx334: support lower bandwidth mode
Thread-Index: AQHZO3ug43tURBtLfk+08iGSApZCqq7axSqAgAAMYgCAAAE3gIAAAM8AgAADkHA=
Date:   Wed, 22 Feb 2023 10:20:56 +0000
Message-ID: <PH0PR11MB5611D8EE3F896FC0BE9A842E81AA9@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20230208050915.1958183-1-shravan.chippa@microchip.com>
 <20230208050915.1958183-4-shravan.chippa@microchip.com>
 <Y/Xc9RCmO8P8eKtL@valkosipuli.retiisi.eu> <Y/XnWOomz2N9fCvc@wendy>
 <Y/XoXZJUKKGzGVVL@valkosipuli.retiisi.eu>
 <Y/XpClyi9KMtLKcF@valkosipuli.retiisi.eu>
In-Reply-To: <Y/XpClyi9KMtLKcF@valkosipuli.retiisi.eu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|LV2PR11MB5998:EE_
x-ms-office365-filtering-correlation-id: b35aeb9a-4459-4abf-b9f5-08db14be7c2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /rvPmpD1vxuMU9i9u+vwyVqkfoTwwI4ISICQds/aY5lXbgYe7x4lp9KYy6MHt+36WDW3C71mtiqRectvfOwCK9zlctknwRY+maje5SGUjo9sNnkkBoOdu5N+OXITFPd3DOHaJ9KW2a0VGIAjfhInYP3MYjr2LYzBQRLgSzGVn4+vDEJKCWYRwFjh+0SkZTnv1pcBwS+JnhpcZnkPPYu1vCciER8+w4PlKw/sHgrs/4OavMIzT1JRU2THHz0mnpJQ0tbwSJCcTUc95r3XtfBGaUENZoQOwDjopFxzBNgl/h8s4o2/5rS/o9PxnuZoBkNITTRf3MR7NHkLzxyHn99I/bUKdxPPpIX2ujhaHkB2EPKAZVeFkBj3UyrtuTGo4DgMOyvbzIHnIMLSgenx9a9dxs71cLLiCKE3f46OauN+IysG/cRAmd1dLFtCkR/2nXF9+1W28xIzdTYbCRENwnA8PNBB/tzrvMyIi15BtS3QifW9u4COCkfDWxgmpWsR5i+MdjRJPO8myt8IJv+cS27bb8E2ltODxkoZXy0KddU1CLfwenfbOWBxkn8fJyHXxzbJ+K+VQnRbjjePwrEg7jV0+YOPyM25Vm4LcIR0MEZUUj4HkWe+J9t3T9QohI6bKE4luttZqUU2ht5QrD/SnvpiN0J+2xRtrXiyRWj5xK73PtLAQh/VJ7etqpcRMW08g7Fk0EXY/s9EKaL5jwROHpnbYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39850400004)(376002)(136003)(396003)(346002)(366004)(451199018)(2906002)(122000001)(9686003)(6506007)(53546011)(26005)(186003)(38070700005)(38100700002)(107886003)(7416002)(5660300002)(52536014)(8936002)(41300700001)(66556008)(7696005)(83380400001)(33656002)(86362001)(64756008)(66446008)(76116006)(66476007)(4326008)(55016003)(66946007)(71200400001)(8676002)(54906003)(6636002)(110136005)(478600001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?awPcR6eCSwGhtorJXehgdgwHZUTKEBRH4KqK5B4Y+PdkBLWteOnyMyFarU6n?=
 =?us-ascii?Q?BSf14YyZRzkclzC9YzNTaBzQGU62WA0SDARFURlD4T4YPe7J/1Al3s0d279O?=
 =?us-ascii?Q?0E+axmxszi/HcsnJ9d5tCx7D74XU8dSR9MRZCxLt8ovUpL6VQrgG7bAcrQIK?=
 =?us-ascii?Q?JelUTKydi6qRUWu4qZVQaWOF+2930/EmdC/qK4cKIddCp+dvNcJdGR0Hf9Fl?=
 =?us-ascii?Q?JJhDJo4Zc3gb6Yrtob+GSQUNs1Amag7nEsRdUre/pHYze1tbjgokbMHqL6yW?=
 =?us-ascii?Q?sNIZq8P/mMlh3Grv7oU7nkvtqjxk/xYoNJgrTBp+rUw4cNsEOlWgfOvRVxkz?=
 =?us-ascii?Q?Yf/kK75VKoSB5CHS/YvL5kgRGAc1YVPAPPfGkhBTbRO/dJMikcmebr/JxFl5?=
 =?us-ascii?Q?/Z8IuzVRIynVGOvlCdXoejC4KEa/PiY/35SCdQKyfQ+XY7pUNTkIfqQfmcjA?=
 =?us-ascii?Q?4H9GWu/4VpgeogeZqm6xSjfFUeWi6xv4KLhqXFa3xw8o8PxffeHLGdF32LCd?=
 =?us-ascii?Q?NuQTr+/StspH+H0x/hp7BTaTzChftTXrl0uI1u/JQLywYNKtgjDyfsf1TE8w?=
 =?us-ascii?Q?3810eXW+mDtFL3Qvtu0tmwSFZ63QfUTHalL2tF/mh9oL1zkVKOQ1atKGsraP?=
 =?us-ascii?Q?6SEiaKodAKxQgFyGTh3ixkGk1QKcEw/LaLT0SoRJ/bVh3SryDbAQJBb5Pf2Q?=
 =?us-ascii?Q?vhzX/hL01Bcs3ZztUIwxNji9X7lPiWFOtTbaxORYU/7nL2YBc+gUfS0O4D/Z?=
 =?us-ascii?Q?GSLbjDxVFHQw2IsbcZfwMlEp1nO7FrCT0Rd7iMb4p52I/ovP7L1bq/xFv2Fg?=
 =?us-ascii?Q?TWjdD8D89y6+RbGkQFZCc7Q1EexdEu8G0D4bfSAF05aa8k6wWAVhbbXEaFpb?=
 =?us-ascii?Q?3QCGaJuMkO1gDpDzHMoYgzQfK0UvxOMtQU4tSNTvU/XqRwc/sOYZl+yapG4Z?=
 =?us-ascii?Q?GeGf01uu1bX6wAeAXfW7bChYhp7aFuPceChdfEKc9gEsVOb0GzlvIb/WZ27v?=
 =?us-ascii?Q?lnFOTxazlJLALfYCXYGZH9glB+PtqsdXvG/CKrOIPKJKF/Cm/13IpGWnpFWk?=
 =?us-ascii?Q?xW+NDKMLv1/a+y7ut2H1iVlImlO2OBs6A6Ut2/ndNQtnLNo1YYjHZSCxwYb4?=
 =?us-ascii?Q?IfI5d9W57N+F5XXf/JDVkj33N1sH7sTwmjv1urbqHUaVGjJNw9LJazP3sTn2?=
 =?us-ascii?Q?2GqvsqmMKd/3S3mENjT6Dh2ZrLRbkaO5bWvkLlrjROTYbMrxL8udnP7n6ebZ?=
 =?us-ascii?Q?anxtlw3Hn0mbOf53tEDTvFY45ld+NdtDGOtsg/onQfSsFhHn+7xVkpYc4CeI?=
 =?us-ascii?Q?jnDJ4rq8Gg/ovpTaOI7q5Gafhqnklrzc8oKLfKNHV2jBgs/AitRUUrw9I6D0?=
 =?us-ascii?Q?vUe8tJt4ADG1gwT0S5XuiQeQ6W56VlV1BYW88AQs3Wl9ieW6YFRW7boqNcKt?=
 =?us-ascii?Q?W7QvidhbFJXbKxWbgVvML8s/AqA4AHnLlALv3Wc2rc+xmv6cFFSVPJXnSgdd?=
 =?us-ascii?Q?5N/Dpy0tFzKFkZM0AZbjaymC8GOJ4efAj0ELNAqtelyOQrHbFvdzdvotLkL0?=
 =?us-ascii?Q?FrqmqrOicjoX9J/rEUqS2ce7sb+t3eNUHJzjcZw3gCMoZf3qYOyKGhLt5ELi?=
 =?us-ascii?Q?vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35aeb9a-4459-4abf-b9f5-08db14be7c2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 10:20:56.2211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yBVEuBNh41szpDHZ+k03FSRyHksISu0dkW4jtXlzPthX3RZHn4+FysC5h/PQo2f5OmGAsb4xZfhWwYe7eQIkcQ4kLiscTCiQu5tYZeDPfNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5998
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

> -----Original Message-----
> From: Sakari Ailus <sakari.ailus@iki.fi>
> Sent: 22 February 2023 03:36 PM
> To: Conor Dooley - M52691 <Conor.Dooley@microchip.com>
> Cc: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>;
> paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> mchehab@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> linux-imx@nxp.com; linux-media@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Jacopo Mondi
> <jacopo.mondi@ideasonboard.com>; Battu Prakash Reddy - I30399
> <Prakash.Battu@microchip.com>
> Subject: Re: [PATCH v11 3/5] media: i2c: imx334: support lower bandwidth
> mode
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Wed, Feb 22, 2023 at 12:03:10PM +0200, Sakari Ailus wrote:
> > On Wed, Feb 22, 2023 at 09:58:48AM +0000, Conor Dooley wrote:
> > > On Wed, Feb 22, 2023 at 11:14:29AM +0200, Sakari Ailus wrote:
> > > > On Wed, Feb 08, 2023 at 10:39:13AM +0530, shravan kumar wrote:
> > > > > From: Shravan Chippa <shravan.chippa@microchip.com>
> > >
> > > > > @@ -666,11 +885,26 @@ static int imx334_init_pad_cfg(struct
> v4l2_subdev *sd,
> > > > >         struct v4l2_subdev_format fmt =3D { 0 };
> > > > >
> > > > >         fmt.which =3D sd_state ? V4L2_SUBDEV_FORMAT_TRY :
> V4L2_SUBDEV_FORMAT_ACTIVE;
> > > > > -       imx334_fill_pad_format(imx334, &supported_mode, &fmt);
> > > > > +       imx334_fill_pad_format(imx334, &supported_modes[0],
> > > > > + &fmt);
> > > >
> > > > Now that there are multiple modes supported, this would appear to
> > > > get the width, height as well as the other fields (apart from mbus
> > > > code) from the first mode.
> > >
> > > Is this statement supposed to be a request to change something, or
> > > just a throwaway comment? It's a little hard for me to understand
> > > your intention here, sorry.
> >
> > Just pointing to what looks like a bug.
>=20
> Ah, my bad. Please ignore the comment.
>=20
> This is indeed about init_cfg(), not s_fmt().
>=20

I will try to fix init_cfg()

Thanks,
Shravan.

> --
> Sakari Ailus
