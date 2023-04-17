Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D0E6E3D52
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 04:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjDQCHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 22:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQCHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 22:07:02 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E002D53
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 19:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CK5tdx0hTjszxRLaCkQikfuGSmx/pV/jRyUpaTcm8FzIAi7EaUHTXtTLBuonZWTyHlaZjO3/zIFo+42PbTrfhRP5yKmVzJOvVVicKwYTTEiJY7yfWO3V2ASk3vU3O3ge71PHk7LFlrLwXWSM7YBERYlumnPWFdX0SIjv7yi90o+BFJaeO7zpqJbsnjMwi9HCOO9Qig4wRDeuu0RWYXMG3gHt3uFWDPVH722ldStwU9LU1MqFRcZGL2L3qaJ6Xv1AGTg0VGNHkLkTPJ1LaaGEk/beFcG3dKIwWEtBR5ihkHmlx+/Y84OVM1bvSNo3yoWHnHOoLZ5UCxlWgciF5DF/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho+VNuAVYpAUsg8kqJYpuz58lLksdMSxLkMTuECfvo4=;
 b=MBksqeep4bXojqyRruxbnxp9uIKOwNDJ+McIX4TzKXs7bpYPJV0pJj4xa8Y/8parcg6CDYEKlw2EEZCdmg1JAknK0oXLFBWUw849IpU1hIhzPljws2L4yTl9ukWlaB+s923eJOKyVcMIXLlGMASHD6WL13V82aTP91KZ7iI8R+7RKfXn7es3R7kX5kUci4dFhWsPoodfhDduPhKQcaathqvDNzM88Ok/Qmc1ZPY4rzYC40uwdh61Kyg7hRWzsx73t3rFLUMwBzDT9msAvuWlpd+6lUVDkmpSukeuYiomei6NTNgzsQ5ne47p5XhE0huiKePw2LZClKxOgVN+vloVpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho+VNuAVYpAUsg8kqJYpuz58lLksdMSxLkMTuECfvo4=;
 b=lOkCrLZbi/mglez4t0Gbq8kAjRZ2wArQFc+qq2a+zOduCNGomnmkfdB6aEUuadBwOqL6G0enbRT1KHtWPZrag5RW7CxHQq4WxZpV9R/pF3dZnrY70CHmmGxtcFWHB0QIZZvzfI84nt2/VQczgi/B2iL7FPPWasMLPYuueyN2u6c=
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by PA4PR04MB7614.eurprd04.prod.outlook.com (2603:10a6:102:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 02:06:55 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::ebb7:2418:4038:925d]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::ebb7:2418:4038:925d%5]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 02:06:55 +0000
From:   "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: RE: [RFC PATCH] dma: coherent: respect to device 'dma-coherent'
 property
Thread-Topic: [RFC PATCH] dma: coherent: respect to device 'dma-coherent'
 property
Thread-Index: AQHZbqX64aqH8/sqmEm+RldR8MQMVa8tfJIAgAFAtvA=
Date:   Mon, 17 Apr 2023 02:06:55 +0000
Message-ID: <DB9PR04MB9236E1467316DFEE177D5E9E849C9@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20230414080307.35114-1-Zhiqiang.Hou@nxp.com>
 <20230416063028.GA6276@lst.de>
In-Reply-To: <20230416063028.GA6276@lst.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|PA4PR04MB7614:EE_
x-ms-office365-filtering-correlation-id: 3001e7dc-8ab9-4692-dc07-08db3ee86b37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z8JNC2phE8V6aPeYtSyEhBu/Tj3OeUlYnJHMPP37w/tGmlZ0aF4Yu3B6NoT7gpTd6dfcoWQ0bViLmAj3lQpeP+lQdsD9/LCBcwuIiKyBWHr8mvcpbi1NoVU9V6qd3KAXcBlfhnguHR6opzarWmHZ3d07qNUiKVM3NmyAGoYO5mujH7d6TRbleP47eqsPvECXmfRytGy40hayvQO6KbpC8fv4ZNn5C/HtykmTMoIoudtrvxrFjpGAgyAfs1e2sKxN7QRD96vN0CNLQgRVS2aJc4JQX+JeV1IzOfPxu9YBVsIll2c4blly/44YPgOVIRxOZQU44Hp8Aezz7md5ds+RbAiqywjTVCWN/odD/YxHAL9x//XVfz3lbJ8Em2091zY808M+9Ua5YdHmHCpu/1zHQzs9orHA0zacKdITdYVxg2slB32gv03aH85Dle2u/oKmdfZqnatg3a4nm2WCOfzK2Io/XUGb0PGk/7otrD8qwrpNuvvYWMMBgSAS4xhqjB7/y2gLSdJCNMfNuNrwaTDaz+N9mi2lL7otL8VR+rIOMtd2UPjMl05byxdJbW+OZXfReeg8MByNcASPO9Vo26rQqppHHEpy6ITvBZF/0L9Gsmmh3Xb0FWnpcR1U0sx5xmQp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9236.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(38100700002)(8676002)(8936002)(122000001)(38070700005)(52536014)(5660300002)(2906002)(33656002)(86362001)(55016003)(478600001)(7696005)(71200400001)(54906003)(186003)(9686003)(6506007)(26005)(53546011)(66476007)(76116006)(66946007)(66446008)(316002)(41300700001)(83380400001)(64756008)(6916009)(4326008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FJdhaKdhDKzDTbka8/9G49qw4iNGAkF/nkAKooK8hOLy7p8rxbjA6bm6uD3l?=
 =?us-ascii?Q?NeEvOJCRVOTnB0rzMgm/rEMrALUFjzPpMi0IwE4iL2+8yeFe8Bnpwy9tMvVB?=
 =?us-ascii?Q?pPoMqGjTNr0nHMND9aQDmbsVYj9CzNKDiam4nBAWH053JyV6I0hoS8rnJOmf?=
 =?us-ascii?Q?e+N/Mz2h2c8qBQE9369iODtJjjE+8EJXYSinM/yUEVkAlP0FzxKhjDVKuXnu?=
 =?us-ascii?Q?vGC2jSMVB2yErbE39n19jhPSjaHKl/CJcSEKogBqbhHXro7tiPi2Tnq/XfWB?=
 =?us-ascii?Q?Jlkscmhq6uu8YZaOZ/PtuerXdx6wog8ay23ue5F4EWv7i0uImmeIpopr7eaS?=
 =?us-ascii?Q?yAJ1OOifx8HMtYbtXq96YxyZS9nvN2kfukVDkolbc0ss+bSvcuLZdIkFp4TC?=
 =?us-ascii?Q?dv3yUcD5lbBnFVKFX6OBoUJ/cj07+BOdb275ITEBr+0jueWc0OTKbJ/hfkXJ?=
 =?us-ascii?Q?Wfsv5IxLTekZb//8xTvrcYtZTvR8TM27T5O1pMVIXELIzbYKois5uban2joC?=
 =?us-ascii?Q?I2y3qrr0zdO9IpcARXQz3EQsiBtHtSjOpzPpNwy50+tvTYsX/iT3NSZsNl+y?=
 =?us-ascii?Q?veh7m9I4YJpUb2a5tBoasaQZSLsJ1YND3zstceuvIPTQ/kJlEPsfMR/oUcDz?=
 =?us-ascii?Q?Z4Xi7yYsvRt3fQrtxOihDKhdsZNMZRKw108OoK9XZg9CL6i0srdHX2lUtNPO?=
 =?us-ascii?Q?72BVX/iFc5nsBCvXAvjtkBAEiIkRx/YcqsS5mjNiwF1PbAvRCEMYk5cetWCX?=
 =?us-ascii?Q?z2jdo4iqLinJsl0LMN/V6PX87qbw6YD1xd7rVOJKZXu2KKz3Tf0XdXsHSzvc?=
 =?us-ascii?Q?dknKC/BLt4/ZvQfZsWgEeLqtwl5aBfu/EGPRJqwdh15gW2VTkDFuxiRU+y6/?=
 =?us-ascii?Q?zxK+4At4U1tehLSENIzeHQI7/P1ZHebkB7VQ4ulvwvrRBrCMhzWq85i64xoY?=
 =?us-ascii?Q?plUP6q2zVtyONqWdGTP8uEYaSCtOBFHI4+TvBSSRK3WZ5nurKHc8qEIxw1UY?=
 =?us-ascii?Q?PRQcATysavF76CQVSFcMShBu0yAyXW9YHEdWlemZhdjlJ5+Sd4yHAUHFdvwe?=
 =?us-ascii?Q?8wo4NSHn6QZAv6lLgsnZusUC3Kbj7movjSRfGACHQPfhlp74CqRgO9RL/Euj?=
 =?us-ascii?Q?/dZ+sgjIGpl3HS7q/R1VtnlgQrZBOhp5uT8q4BOZ9GmhvA3+BhTBP0lcOWp0?=
 =?us-ascii?Q?TdWaGZ0+wklpgAsxr8i8rKCLite68KPLEo1sKY2nHLpfRLZmeujuhagjSKb6?=
 =?us-ascii?Q?123Jnx1HUFGeLBqGMi9PAdnYHBPGLl+/NXnkcTsLuzqe+bfxol6xKplfvvfd?=
 =?us-ascii?Q?FzC5uW3E2dOEu5jwHnl4pN8rgCVaxJKAtOf9DC0fGca5VDJNDk/qwxz/GNkL?=
 =?us-ascii?Q?QSPPW32hnu+CdGs+r43w6GykRu56zQU+XNbhyGxjf6721vEDHK7ZWUTkD1lL?=
 =?us-ascii?Q?WAIxwd5YSWB/hBkyyIyqvr15cz+T6hwSJwBn9WYEnxAr0vKuPbb6yELtQ0pX?=
 =?us-ascii?Q?mBxWeqnBeaLt5acm9IzU+HwEHw9Xz9uSUSmFRTfJYUupFtG6V8KPxGlpY+o5?=
 =?us-ascii?Q?Cb2ZYtzCZ+7nj6kCtw09STakZ/GoVg+9F3BgTrSG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3001e7dc-8ab9-4692-dc07-08db3ee86b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 02:06:55.5024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kd0p7EMqXNw1fjJfxQ6kZNPa7DiufKepEid0cEddfm+1RT1tJ+p8OkiHenO4TZg7ULbWwa3pnry8RSkkF4RyqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7614
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Sunday, April 16, 2023 2:30 PM
> To: Z.Q. Hou <zhiqiang.hou@nxp.com>
> Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; hch@lst.de;
> m.szyprowski@samsung.com; robin.murphy@arm.com
> Subject: Re: [RFC PATCH] dma: coherent: respect to device 'dma-coherent'
> property
>=20
> On Fri, Apr 14, 2023 at 04:03:07PM +0800, Zhiqiang Hou wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > Currently, the coherent DMA memory is always mapped as writecombine
> > and uncached, ignored the 'dma-coherent' property in device node, this
> > patch is to map the memory as writeback and cached when the device has
> > 'dma-coherent' property.
>=20
> What is the use case here? The somewhat misnamed per-device coherent
> memory is intended for small per-device pools of sram or such used for
> staging memory.

In my case, there are multiple Cortex-A cores within the cluster, in which =
it is
cache coherent, they are split into 2 island for running Linux and RTOS res=
pectively.
I created a virtual device for Linux and RTOS communication using shared me=
mory.
In Linux side, I created a per-device dma memory pool and added 'dma-cohere=
nt'
for the virtual device, but the data in shared memory can't be sync up, fin=
ally found
the per-device dma pool is always mapped as uncached, so submitted this fix=
 patch.

Thanks,
Zhiqiang
