Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6E86A1975
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjBXKE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBXKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:03:49 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835F922DC5;
        Fri, 24 Feb 2023 02:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677232999; x=1708768999;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kt/mbcFbBxVHpxQ2cJ89lnSpLowIH5Bf1qC1lUIfDiM=;
  b=P1GU/rPIUuE7LcNNI6G0X9CF39frQFh656H5HJzVWLz0kNamwwCTd7ZJ
   wfWWXsUTZyjJH0Y+q2BUfJcqaDEcmHwNZ5ux0sIC3rwzSj3I2uTxOqSh+
   +a6OjEtUbYfNnrduD/ZJBRjtZXls7RDWzPPALAK/UzaOF8QqYX4G6xTJ1
   iSEkPILM4TNIMkb7X0n2n6cJ4ivpNfcjH21P53m1DUliKkYwlUgquVRBz
   LrDH2v1MyMXHlWJqxj76Jc7cRtUZmIi3cG/zzfDclzeVMqpxi1OGxnVhd
   MBWdpVPuL46nrYhhveMB/cnE+ej94C4AvAkMElZa1JyCmOEMZSm3GezjX
   w==;
X-IronPort-AV: E=Sophos;i="5.97,324,1669100400"; 
   d="scan'208";a="138886346"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2023 03:02:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 03:02:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 24 Feb 2023 03:02:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX8FLNjVdiopwqdIRMPRFAMWbtUN4CDS/hczrjzUkHt0L4Td4eIGiuAdTfZOwKcwnPqn/g6EmEwm4g4WAGDlWk6zJj/8MCTkMZFl7uzJKWD062CTY1F1zdb4JGpAvgOQfG8O71Qzu4Tv6WsgpTjp43wesOkc2dVkOC9WiYzAYO9AdgUnezriKDyKaBYgCEHM58ytYSqB+l/PA1Sz30kyYS5kSOZQW5uP34yOScNkv35+s+m9z8fhN4ikRKOEiulCOiwdY0w28t4wO8CM1sGh0Igra5Qyx8/XabHW9APeKpejHTDce8McCLLfBd42e39QBHmZfl2z91LI6KnCRztnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qB5/VPsjgVkN1/41jxQYoZPCOP7U9tbrMQ0hKCu0YW8=;
 b=gKPKkcsIFMBYUsGzVq3KzMGSp6y+uSKdv/46AJlNf0hsj9kL/srShIHbgM9Jnb8X/A+sl2lIuycR9m0JyFgrGuwLVPuDJqWk0XktAK7ooOKBxsewn+WBrVWBUqptYbY5aqUSf7TAA+pZ94S2g8HyM8F0GwBGcDOL6X/avPvt5jEF591/nJtBxy7j6u576DpKxa4jhUETWPTdW7v8dDpPpzkkveYG69t/zFc90l1wQFR1V7IrniAOntTwR2NnfDQiNcHWwPUkwg0cygpIuYIbacc5VjQEHcfeLj01fBiACLGL4oN6QECxSm+XeoLAtpMNWW3P/rIsFKLsroIdzB6NtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB5/VPsjgVkN1/41jxQYoZPCOP7U9tbrMQ0hKCu0YW8=;
 b=fB9HTx7nCrhBsPW2sFaErS2D7Na/WBImkcU9rl58Mb74kWjo30uat0fFLRdAcZqpSG61EYKaM5nfYVbUZGURqyLLMB1Ts1bA7W1qHX39eMMhs49sZzmDIzUAt3JDPn9kQcpbp8Ir2VhNc4tJtNEubhfa5OAGPUZQn3oU+Fm2YwU=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Fri, 24 Feb
 2023 10:02:51 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6f3f:f30b:e31e:1fc7]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6f3f:f30b:e31e:1fc7%6]) with mapi id 15.20.6134.021; Fri, 24 Feb 2023
 10:02:51 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <sakari.ailus@iki.fi>
CC:     <Conor.Dooley@microchip.com>, <paul.j.murphy@intel.com>,
        <daniele.alessandrelli@intel.com>, <mchehab@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <jacopo.mondi@ideasonboard.com>, <Prakash.Battu@microchip.com>
Subject: RE: [PATCH v11 3/5] media: i2c: imx334: support lower bandwidth mode
Thread-Topic: [PATCH v11 3/5] media: i2c: imx334: support lower bandwidth mode
Thread-Index: AQHZO3ug43tURBtLfk+08iGSApZCqq7axSqAgAAMYgCAAAE3gIAAAM8AgAADkHCAABSwAIADCyOw
Date:   Fri, 24 Feb 2023 10:02:51 +0000
Message-ID: <PH0PR11MB5611BB17A5DFAB0645D8DEB781A89@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20230208050915.1958183-1-shravan.chippa@microchip.com>
 <20230208050915.1958183-4-shravan.chippa@microchip.com>
 <Y/Xc9RCmO8P8eKtL@valkosipuli.retiisi.eu> <Y/XnWOomz2N9fCvc@wendy>
 <Y/XoXZJUKKGzGVVL@valkosipuli.retiisi.eu>
 <Y/XpClyi9KMtLKcF@valkosipuli.retiisi.eu>
 <PH0PR11MB5611D8EE3F896FC0BE9A842E81AA9@PH0PR11MB5611.namprd11.prod.outlook.com>
 <Y/X9YiLJxDfLPNUX@valkosipuli.retiisi.eu>
In-Reply-To: <Y/X9YiLJxDfLPNUX@valkosipuli.retiisi.eu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|MW3PR11MB4556:EE_
x-ms-office365-filtering-correlation-id: f302aa99-d204-4c2a-147d-08db164e4a90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d0JRbrKeFa6PVYqGCAO4XKq8rp/BUQIHHo6Txuxi5ZPLTJAiXFWV2rM/IPTVBylRXPB5+t6m4J56tRWMwqu4absNbBwNdJnRPPJZ61vMNSgZcOjNReWew+qRrgA8zxb53etHKe+ADuIhPvhzMxXOIJn8lz8Lrhh2WEvkaEcWhygMLywiofKcBdmjQEjHC96iInx5wMT6qEcEAvMg4gjCme57mn+BtVlHgO81ikcGQ8RB4SGpruUH09qbm6E9dqeYKyGpE7UdHw5bi+uI7KwH2IeCzizxzXcVlVlW8G8Ld5yzSUrTtkAl9LmvwToh+vcKiVdN1q+mm57FLk3T+FMTGwj8qvqu1zaHrusKQBeF2Enq529TNiB3o8SYxAcO215X65GnMWfVQP8/7GlATzWctC2G1a6svy97mU+j3/mZXYKdrDz0dJcifzPEDc0E7OHxMAiJ0qCEORzuCZKa3wRX4wZv6mfga2c8Onivr3zSlrGF3aQmq+6AvYNkC8oLKEX8nFKX+SP4tebXSVfVxu2Ve4K7lS2KyjzOKX+TQ+JpO2u6WgTEh6MLKq0613y9iHtqMdwWg9o1U8uTnwq+FFaVjb5/ClbUI9gIr5RuX208CICQWKIVwFGGoUKVr8plvElPmOuHjz/gj/7chuNu4bT2yOi3PYjZwyd1jNBRlgykaD3bbAVPP8ye6vGsaPIsVJWiA0txAx7dDtMMeQGGN3CoRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199018)(38070700005)(33656002)(86362001)(55016003)(83380400001)(54906003)(478600001)(71200400001)(26005)(9686003)(186003)(53546011)(107886003)(6506007)(2906002)(316002)(7416002)(7696005)(122000001)(38100700002)(66556008)(8676002)(4326008)(66946007)(76116006)(8936002)(66476007)(6916009)(66446008)(5660300002)(52536014)(64756008)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0bc9PDrtBN96ksQYS/+hwXgJ00cR5G8aBYnn+sMQDv5z1cw5XlWIMUZRYqds?=
 =?us-ascii?Q?BWVtEeXN/z0lj1wt20eE52dPj0SDnEs8v7MQf8Jjv/Vd8Qp1hhSE8U5T2QH3?=
 =?us-ascii?Q?uTUVPEfbqO0y0ht9RlOXJEFyPJoQRFE0Nnvq6SDsZ0rDBUUzBZ6weUgeGHW9?=
 =?us-ascii?Q?i2hMLWg8BWWXFLibQF6wZNWwpJpbBV2ffa8yhU1bw3JpJUYU6lfgQlB3owuj?=
 =?us-ascii?Q?3KAZA3BokXZvcK7shh59jqN74/ZkiC8x8kLVfmVY2rK0TdN7Jr+flIsZ4+LM?=
 =?us-ascii?Q?uhiMV0h8C6Gq+a+0Ph6RHJhXdHdg8Fo+j1dL7omA4MnJxuEwcFYlkR0jpEw9?=
 =?us-ascii?Q?mz+7UrnHq92Ac0sMcvTT6h65uPUwtZRp4URZkWi2reilmZtAGNcYsxs6YUYG?=
 =?us-ascii?Q?kwiDhDYWBYC8b6yhVkcPEdn8WZZKwjhGobUAjaqVIEk2rdd1YWYQ/ujcaTOf?=
 =?us-ascii?Q?CyMT0yVkHqMsulBd58JexjsGcLNEEKkxibETAi9PFO3e7cDWPGR8ix20Tzdk?=
 =?us-ascii?Q?LBMg0KtaNOleumvzGtrpzcpGfZtFXrtK9FvNJuD++3R+7lcln+zYxDWjnUvT?=
 =?us-ascii?Q?TTqOoJIfn9PnYnwjHq39yMtK0v6/Ch51dAUGq/rNxYmJdEij6PNRmF4XFlgK?=
 =?us-ascii?Q?lZQ6oNbi/PJ51Jdc22vCC0kyLhzdMnY7sGJO9GyM53FFFLX4ZPh29pAgjQvb?=
 =?us-ascii?Q?HB13h8fJfkIiL9fEPeVPdgKcKDvlvkQ27sxEJXC8vg9vf2Q506ykz/QkRUnf?=
 =?us-ascii?Q?7jkcp4vq407Vf6n1lxemAuK3NbR05KYUWQosueMSkORKyBEva5hq79ogtoFk?=
 =?us-ascii?Q?4nPtH+MzleHPp1vxAF13nkcdXVt6QraYHBgXHpHittiKOpAIQZtKMZNJkR0z?=
 =?us-ascii?Q?1VUvIrqkoDcL2LNKXo3ubTrdvAfYQONm1biFHtsRFB7Xze7BDZrqJF+wxdej?=
 =?us-ascii?Q?Am4GHuQHq+9PWI3M5FvFicGLp08ar/ga6JhDjTr2WXM7HnrFxHeN/r2WSuIb?=
 =?us-ascii?Q?s3lKR4S1yL3TAhSgoN4omNhFiUY931yv/D6xF6VFMcfLu3QsTPUp1pofuXLQ?=
 =?us-ascii?Q?oAVWTCwFkh/zkF8459XNR4XZa3fxrIiZeT5RJUfOxsm05AOZQ9e0SVd6EDgr?=
 =?us-ascii?Q?72YCoWYBJ3MMqcxwOTY9sl8W7mhKMF1/wdNc8l+P/5UyMEK0/u+2DmKucMCh?=
 =?us-ascii?Q?mR+ym3CUHdSW0NMeB/DeEm7Is0ePyzbMJ4s21MAu53lJhWyh/h6R9rDtGJxu?=
 =?us-ascii?Q?80njctkn1mBEnRRp9/uV8Nh+AXMd96RlhxmnN1I31iOeoCQauGbeuJCeMRFU?=
 =?us-ascii?Q?wzMOXyOQlDFVW7Rie07yH4RQAMLwyqRHxmiIKtOO8IOaisqQOKmYj/uxgIIR?=
 =?us-ascii?Q?N9M6w2ewZ7lgiGq7AWpRvGGuclG6flb4KX7HVL8d+QcN/AaclbkcZG+5I2NT?=
 =?us-ascii?Q?8jzZFEo36xCd/vdmc1S+6nr6UaqTM47cD9erOs2P2cXTq7c58lTNsu+8Kmem?=
 =?us-ascii?Q?NY8ZaR8KqLrHr4e/HRKBg0+b/mDLEEBcubPp9j2ORoNwROhIuVJecg0rvpSL?=
 =?us-ascii?Q?Srt0MUAKDsAYIANcmRpK3LRbgvLGuVsxFJBOHRH7G8HHrPLO0cWFpjBnuwBX?=
 =?us-ascii?Q?kA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f302aa99-d204-4c2a-147d-08db164e4a90
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 10:02:51.6648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FT8tzgU4DkDNw2iDfyZ7YkrzykoPEen6POUftWF9M8BnsP8e2NUXIH1OgxM+z59PKfhhd1dISnPON8isrGBBO237+LOiDrbpDPMRrzmyM64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4556
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
> Sent: 22 February 2023 05:03 PM
> To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> Cc: Conor Dooley - M52691 <Conor.Dooley@microchip.com>;
> paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> mchehab@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> linux-imx@nxp.com; linux-media@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; jacopo.mondi@ideasonboard.com; Battu
> Prakash Reddy - I30399 <Prakash.Battu@microchip.com>
> Subject: Re: [PATCH v11 3/5] media: i2c: imx334: support lower bandwidth
> mode
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Wed, Feb 22, 2023 at 10:20:56AM +0000, Shravan.Chippa@microchip.com
> wrote:
> > Hi Sakari,
> >
> > > -----Original Message-----
> > > From: Sakari Ailus <sakari.ailus@iki.fi>
> > > Sent: 22 February 2023 03:36 PM
> > > To: Conor Dooley - M52691 <Conor.Dooley@microchip.com>
> > > Cc: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>;
> > > paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> > > mchehab@kernel.org; robh+dt@kernel.org;
> > > krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> > > s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com;
> > > linux-imx@nxp.com; linux-media@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org; Jacopo Mondi
> > > <jacopo.mondi@ideasonboard.com>; Battu Prakash Reddy - I30399
> > > <Prakash.Battu@microchip.com>
> > > Subject: Re: [PATCH v11 3/5] media: i2c: imx334: support lower
> > > bandwidth mode
> > >
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > know the content is safe
> > >
> > > On Wed, Feb 22, 2023 at 12:03:10PM +0200, Sakari Ailus wrote:
> > > > On Wed, Feb 22, 2023 at 09:58:48AM +0000, Conor Dooley wrote:
> > > > > On Wed, Feb 22, 2023 at 11:14:29AM +0200, Sakari Ailus wrote:
> > > > > > On Wed, Feb 08, 2023 at 10:39:13AM +0530, shravan kumar wrote:
> > > > > > > From: Shravan Chippa <shravan.chippa@microchip.com>
> > > > >
> > > > > > > @@ -666,11 +885,26 @@ static int imx334_init_pad_cfg(struct
> > > v4l2_subdev *sd,
> > > > > > >         struct v4l2_subdev_format fmt =3D { 0 };
> > > > > > >
> > > > > > >         fmt.which =3D sd_state ? V4L2_SUBDEV_FORMAT_TRY :
> > > V4L2_SUBDEV_FORMAT_ACTIVE;
> > > > > > > -       imx334_fill_pad_format(imx334, &supported_mode, &fmt)=
;
> > > > > > > +       imx334_fill_pad_format(imx334, &supported_modes[0],
> > > > > > > + &fmt);
> > > > > >
> > > > > > Now that there are multiple modes supported, this would appear
> > > > > > to get the width, height as well as the other fields (apart
> > > > > > from mbus
> > > > > > code) from the first mode.
> > > > >
> > > > > Is this statement supposed to be a request to change something,
> > > > > or just a throwaway comment? It's a little hard for me to
> > > > > understand your intention here, sorry.
> > > >
> > > > Just pointing to what looks like a bug.
> > >
> > > Ah, my bad. Please ignore the comment.
> > >
> > > This is indeed about init_cfg(), not s_fmt().
> > >
> >
> > I will try to fix init_cfg()
>=20
> There's no problem with it. Please ignore my original comment on this.

Just checking, Do I need to do any modifications or the current code is fin=
e?

Thanks,
Shravan

>=20
> --
> Sakari Ailus
