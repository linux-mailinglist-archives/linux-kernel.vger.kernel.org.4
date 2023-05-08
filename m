Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1016FA2A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjEHIy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjEHIy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:54:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3994234;
        Mon,  8 May 2023 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683536063; x=1715072063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KiyIXJhUs6lwhedJOIQXPZLK+7/1visd1brL31ZHG5Q=;
  b=M9eI1f9F6ktHk75oviExBEMdmd+PMIZghXqBOAJaVWy7eEZLeWRVYnmR
   m2phahUUE4oyWqKRmDzrvEn7WgXX/NQn8SaMydOzOEA89d7/zbKuHsBup
   QNwT3i8JyFlRPCWGuAxEtagHReBY6PuWG5Dxt4F8fCAX7hL7UFZPrUNH1
   AnMcHpqknfNaMQypXmhKf89Y170CcSiGYktkwAEpWBTU480yaWbRamPuH
   Xcv8Zydn4+xI8xIATg8O2RFk/rRlcAp4Vw0SsfNOpfr/6S+fDkCldiWGv
   t1HoaegFV6SpwJnyT2y5RcRH4QUZeRTpE+9mYCHDN1mdIuNmKHyTvBGGu
   g==;
X-IronPort-AV: E=Sophos;i="5.99,258,1677567600"; 
   d="scan'208";a="224282762"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 May 2023 01:54:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 8 May 2023 01:54:23 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 8 May 2023 01:54:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iowNc/9JTsyXdj5z5MxskSOM32P1/wdZCzHTDbSr6DA0Cnadxs7EJjyoj0/Ruk21a1o+9pIGnUsTM2jS5+uaELHuSAp/jbNFusNKwcqDDLxl+GVFeGcdT1KXrDG0vnG/4xU85WJIxln//DW+9iuUH/5/wazkCgtvN78unCzWtLCV5CniQDQzRKm2G3unVhFU2JrooY7Zpvv6FIKOdlIWg6j7GHm9k6QqjLVq5y31c9ZEuMLF9Bx915kL3eJVoKLfLySLcsRWjk9OfwY34zw+cGCEmPJhhtEG3ScFFzphSGec4y7V6vPToUF82RfQFwIqnAfrei+sL5TkV/axZnPuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGXmRKVIjYyWQeNJs7TWqxKQFjhgjOLh1te45Lc1l7c=;
 b=USBVinOUM7COdrcHNxSsh21a6JEMIn8+g9rUulTOLvkYtlXnbr2luJr6BktRoPChJKSazjvimQSdzirWWpxfCgBEZ7VOyH6/ymsG3DwjRuSfUx0Ql52CKHTxjY0bkPDg+2K4aGrt95n0WNPpHuxq4sXY9lh9mB9G953o52bEG77QClgbIgesxa06iuz0i9mVAmSUCYDCFdL7PLRfsD6SIVedCnZu5jHHkUBv0LyonpRpmj5f1OL1gi7cZpb2UZ5E/uRjzI9qIlGSy5h9+PJEZuuHeqJNfIg9oGoyxyM2skynL5/bMrDuVknnOrXb0R3BEutJ92/attN3cYP4qlnGUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGXmRKVIjYyWQeNJs7TWqxKQFjhgjOLh1te45Lc1l7c=;
 b=p4O87wXB+BDK0+NWtkM9XkwUVk583vFN8kDyCsx1bQV+tGnLwY7p1hZaR49Vzgoj0ToKxS9mD/HN/o1m7uvWAe8lKghcKvYGAbBRSNCknCdaN0k3D9NkThGb2Ntnu435+xvVPlZc37L1JFWt5HfZA68Xi401YvcV1g16xc/DiBk=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by CO1PR11MB5092.namprd11.prod.outlook.com (2603:10b6:303:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 08:54:18 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::c13:dcee:8af:bbfb]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::c13:dcee:8af:bbfb%5]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 08:54:18 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <mailhol.vincent@wanadoo.fr>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <marex@denx.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] can: length: add definitions for frame lengths in bits
Thread-Topic: [PATCH] can: length: add definitions for frame lengths in bits
Thread-Index: AQHZgPxeZaBnd1NvTEynohb4vwVjlK9QCmFw
Date:   Mon, 8 May 2023 08:54:18 +0000
Message-ID: <BL3PR11MB64842FA5ECB64DD2C6C9FA76FB719@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <20230507155506.3179711-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20230507155506.3179711-1-mailhol.vincent@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|CO1PR11MB5092:EE_
x-ms-office365-filtering-correlation-id: 004c4878-e451-4feb-813b-08db4fa1cef0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uy0gEDHSaXLGSH0+zGozLqdS/WHJDKB/TSDY3ISlp6dlVmJtuqLYrgceeYRYMtbWrXYhux6CiJi56k/Olny5ub96L8i2FoflG/TlgBJ5IAtN5fWdVqZkeK4kxL8BIHsYhpOpb6h2cnX9Gcq1a5815Dd68RLQ+AWr7ouwreAx2MhFjr7/Zt8Lp3q1oaXE24jp+T9XPZwVB0gceW70OuZZjam5ta9dMlVXb1xWlYfY12wejdqBgRFaupGClzXsnqcgI8xDiJKFTXrOw5dgncepu7jo+Hmco+lEg8BvLSPqBPONFxfE886KOnaAZf4/+2oxmDAV4vaEcEU/l4J8nBn/6nljOzeWLGduVgbLGvAsAHTU92atjXrFYAqWtrLKAjd2HXTKhonMcpP9O8U3007Q0EmxU+1tBggwhincmmBcGT8SyeJ5SGIXEQghBlCslKhjEVvhy/x1gQHoXn7ZeSGrRZ7nOxM4OrETFc7to182Ym+eS37SC/+9T2jmw2TTWWe8HYNfzUUYBBJ+i2EZNqMW1MF//ROlUX5RXBTV39Og1ab9lWZgnUxQkCtgLGcbNiZPvPcc0HnLs/dh1vU1uDhSNMbEkcDo2AoI7N7Qfj+CgLeFv2A32sheHXVE/KmVyZ/j2KODOIt6ZOYE80nrnZ1uVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(83380400001)(966005)(45080400002)(7696005)(478600001)(71200400001)(110136005)(9686003)(6506007)(26005)(186003)(2906002)(33656002)(52536014)(38100700002)(66946007)(76116006)(66446008)(66556008)(4326008)(64756008)(66476007)(41300700001)(122000001)(8676002)(8936002)(5660300002)(38070700005)(316002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9kX2i7KOwf55bRNa615l27fbWyeP394SpwT0b0mYSFdq/EeVR7gK72joJwHi?=
 =?us-ascii?Q?k0LvoaAU7J+Q6eR3N0iTbRKT+z5v9wcERv/0yT/umCCRQ5PT42MIpBFlMsMF?=
 =?us-ascii?Q?2e5QqFeC9DoC78vhYQyGrw/ES4zcz8xZ8fH0KG79mBfXRxP9lNYf9PHNtCSG?=
 =?us-ascii?Q?SfrFEMMsEQnjH6q7ClOhsngUq+gKGHsTJ2FIQKQIgjPzT3MevR/xbdnxBmSF?=
 =?us-ascii?Q?rIfEWfc9gTOCNUf2calDHsCNieO/+x4FjdIRdgSEqH9OJGHYTR51KwNsGBwt?=
 =?us-ascii?Q?ymI4owtH2q4qlrpdEdytMHIeH7ZH5/StjATTenj8RbhrEFA7iC1NqeZGRKJU?=
 =?us-ascii?Q?koPd8Veu7OxVsvIwp5wudyFx3BldQ1CRR6xzuFOG2jNMUjUryjqgQ1XleghC?=
 =?us-ascii?Q?GWrDrXpsYvPVwlXp6R6ki73QWl32RsjX17Z/WaTu+U2HhfFL8XEPTwGZQkAS?=
 =?us-ascii?Q?RD169CKBNS3cs0cjgulFmJE4cRT9aHX5a17JajImk9Tu/+fwVglxWyH02Vxi?=
 =?us-ascii?Q?inXsUht4vYSMMS2Ul7Kf2hy178Q3URUSsfyOnr3s2Tf+QZqjm6Wy52Q7ZsFd?=
 =?us-ascii?Q?JfEYo1PQchlzJP5rkHVQKReWAaEEFhAITEWyb3BANXBSdcOhsjAkk0JmQqG6?=
 =?us-ascii?Q?kTO1epHdZmN4NUz0kWJRfPjCJSUMeteZMwRLqhAErmTrC+nNoLKqCGpgeGfL?=
 =?us-ascii?Q?3TBuG/Dpn5DUndm4WcHZ7+EaBR2Is4HmLshU2yXdbtlBLYx0UcBzllKcuxa2?=
 =?us-ascii?Q?351b286lAbFAb+KAAs3Pz8Wev2TDWQG/StLE5nZHqgMVaWzGj2CsQe/4qELV?=
 =?us-ascii?Q?Fguo4ZeZjI5hynJcZm18K6p6snc2ZO/9ve31gXhtinISajghYdHC/sTJKUx2?=
 =?us-ascii?Q?HoyY6X8grxY0ycVY/Gy1jMI+/eZvmfd3DAPy9uEaIFE4gwIYp9lsEuz5IUcQ?=
 =?us-ascii?Q?bj4nCqo4BXdtJQMcTsk8TP+L6k8zALU6kGy41Y1XDANl2LXha1YTMR0CDwz+?=
 =?us-ascii?Q?48ipC4NJWfWkmD+1t/fvlECOXVsJcFaSCUr76Or+6X8OaYgrddABVJS2DcEa?=
 =?us-ascii?Q?eS8MJC8ReUOw7z2Hbb5bB1/rcWWwcfObC2SOLUh37rwXhIVwpW0F4+Ld9ria?=
 =?us-ascii?Q?gTwr+OMpCqK+wzB9linX5BQBlnE2KclMDpnnRRsbf+IEn0oQJBTgq2b1PiXx?=
 =?us-ascii?Q?kkQA3StfHQrG+Wl1yPNr4XWA9yyeZhP2+o56JyOfTUgHikJFoKaYK6FJsqWD?=
 =?us-ascii?Q?YWWLCNmCaE0zfaPIsiXcZjE1x0b0Mjl1iEdW8Aa9rwazrOSrlyb87Tlo8O8R?=
 =?us-ascii?Q?C1DlAUqk2L++h31MfNZtPPN0A/l3qobsMNr/pbPHTXZk4zRzCerKhDfvkEPY?=
 =?us-ascii?Q?ohgbknH/c1zivZRUCBp0Kk2BXR2lyjo2gErk87ckR0rqsK3Y343lnqylT/qQ?=
 =?us-ascii?Q?VFtniTdfIgJpu4G/FLCYGNfFkG/Cf6Y+92zem7MlJQeCCA1Skw8bYrA4/pLS?=
 =?us-ascii?Q?WtaeIceI1OfQDXw4mGplhqYCKqsujbwCQ7zU7jGk2wxK1I+o8laF17d4tZ5z?=
 =?us-ascii?Q?RQGrCc23ni0GujbAfuGuxv3DH6eppGc5hGkDY7vu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004c4878-e451-4feb-813b-08db4fa1cef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 08:54:18.2726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sr8wDJ5sYL2okCLhvcZd4NtvcNsN6Y7kMC1QWGxZfGGmbHEHk09aevQmbfhGTKuUlt0mddB5KdpdsFPViu8Dxy8b+Hyna9t3L4aDXJpyYsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5092
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When created in [1], frames length definitions were added to implement
> byte queue limits (bql). Because bql expects lengths in bytes, bit
> length definitions were not considered back then.
>=20
> Recently, a need to refer to the exact frame length in bits, with CAN
> bit stuffing, appeared in [2].
>=20
> Add 9 frames length definitions:
>=20
>  - CAN_FRAME_OVERHEAD_SFF_BITS:
>  - CAN_FRAME_OVERHEAD_EFF_BITS
>  - CANFD_FRAME_OVERHEAD_SFF_BITS
>  - CANFD_FRAME_OVERHEAD_EFF_BITS
>  - CAN_BIT_STUFFING_OVERHEAD
>  - CAN_FRAME_LEN_MAX_BITS_NO_STUFFING
>  - CAN_FRAME_LEN_MAX_BITS_STUFFING
>  - CANFD_FRAME_LEN_MAX_BITS_NO_STUFFING
>  - CANFD_FRAME_LEN_MAX_BITS_STUFFING
>=20
> CAN_FRAME_LEN_MAX_BITS_STUFFING and
> CANFD_FRAME_LEN_MAX_BITS_STUFFING
> define respectively the maximum number of bits in a classical CAN and
> CAN-FD frame including bit stuffing. The other definitions are
> intermediate values.
>=20
> In addition to the above:
>=20
>  - Include linux/bits.h and then replace the value 8 by BITS_PER_BYTE
>    whenever relevant.
>  - Include linux/math.h because of DIV_ROUND_UP(). N.B: the use of
>    DIV_ROUND_UP() is not new to this patch, but the include was
>    previously omitted.
>  - Update the existing length definitions to use the newly defined values=
.
>  - Add myself as copyright owner for 2020 (as coauthor of the initial
>    version, c.f. [1]) and for 2023 (this patch).
>=20
> [1] commit 85d99c3e2a13 ("can: length: can_skb_get_frame_len(): introduce
>     function to get data length of frame in data link layer")
> Link: https://git.kernel.org/torvalds/c/85d99c3e2a13
>=20
> [2] RE: [PATCH] can: mcp251xfd: Increase poll timeout
> Link: https://lore.kernel.org/linux-
> can/BL3PR11MB64846C83ACD04E9330B0FE66FB729@BL3PR11MB6484.n
> amprd11.prod.outlook.com/
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> As always, let me know if you have better inspiration than me for the
> naming.
> ---
>  include/linux/can/length.h | 84 ++++++++++++++++++++++++++++++++----
> --
>  1 file changed, 72 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/linux/can/length.h b/include/linux/can/length.h
> index 6995092b774e..60492fcbe34d 100644
> --- a/include/linux/can/length.h
> +++ b/include/linux/can/length.h
> @@ -1,13 +1,17 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* Copyright (C) 2020 Oliver Hartkopp <socketcan@hartkopp.net>
>   * Copyright (C) 2020 Marc Kleine-Budde <kernel@pengutronix.de>
> + * Copyright (C) 2020, 2023 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>   */
>=20
>  #ifndef _CAN_LENGTH_H
>  #define _CAN_LENGTH_H
>=20
> +#include <linux/bits.h>
> +#include <linux/math.h>
> +
>  /*
> - * Size of a Classical CAN Standard Frame
> + * Size of a Classical CAN Standard Frame in bits
>   *
>   * Name of Field                       Bits
>   * ---------------------------------------------------------
> @@ -25,12 +29,19 @@
>   * End-of-frame (EOF)                  7
>   * Inter frame spacing                 3
>   *
> - * rounded up and ignoring bitstuffing
> + * ignoring bitstuffing
>   */
> -#define CAN_FRAME_OVERHEAD_SFF DIV_ROUND_UP(47, 8)
> +#define CAN_FRAME_OVERHEAD_SFF_BITS 47
>=20
>  /*
> - * Size of a Classical CAN Extended Frame
> + * Size of a Classical CAN Standard Frame
> + * (rounded up and ignoring bitstuffing)
> + */
> +#define CAN_FRAME_OVERHEAD_SFF \
> +       DIV_ROUND_UP(CAN_FRAME_OVERHEAD_SFF_BITS, BITS_PER_BYTE)
> +
> +/*
> + * Size of a Classical CAN Extended Frame in bits
>   *
>   * Name of Field                       Bits
>   * ---------------------------------------------------------
> @@ -50,12 +61,19 @@
>   * End-of-frame (EOF)                  7
>   * Inter frame spacing                 3
>   *
> - * rounded up and ignoring bitstuffing
> + * ignoring bitstuffing
>   */
> -#define CAN_FRAME_OVERHEAD_EFF DIV_ROUND_UP(67, 8)
> +#define CAN_FRAME_OVERHEAD_EFF_BITS 67
>=20
>  /*
> - * Size of a CAN-FD Standard Frame
> + * Size of a Classical CAN Extended Frame
> + * (rounded up and ignoring bitstuffing)
> + */
> +#define CAN_FRAME_OVERHEAD_EFF \
> +       DIV_ROUND_UP(CAN_FRAME_OVERHEAD_EFF_BITS, BITS_PER_BYTE)
> +
> +/*
> + * Size of a CAN-FD Standard Frame in bits
>   *
>   * Name of Field                       Bits
>   * ---------------------------------------------------------
> @@ -77,12 +95,19 @@
>   * End-of-frame (EOF)                  7
>   * Inter frame spacing                 3
>   *
> - * assuming CRC21, rounded up and ignoring bitstuffing
> + * assuming CRC21 and ignoring bitstuffing
>   */
> -#define CANFD_FRAME_OVERHEAD_SFF DIV_ROUND_UP(61, 8)
> +#define CANFD_FRAME_OVERHEAD_SFF_BITS 61
>=20
>  /*
> - * Size of a CAN-FD Extended Frame
> + * Size of a CAN-FD Standard Frame
> + * (assuming CRC21, rounded up and ignoring bitstuffing)
> + */
> +#define CANFD_FRAME_OVERHEAD_SFF \
> +       DIV_ROUND_UP(CANFD_FRAME_OVERHEAD_SFF_BITS, BITS_PER_BYTE)
> +
> +/*
> + * Size of a CAN-FD Extended Frame in bits
>   *
>   * Name of Field                       Bits
>   * ---------------------------------------------------------
> @@ -106,9 +131,32 @@
>   * End-of-frame (EOF)                  7
>   * Inter frame spacing                 3
>   *
> - * assuming CRC21, rounded up and ignoring bitstuffing
> + * assuming CRC21 and ignoring bitstuffing
> + */
> +#define CANFD_FRAME_OVERHEAD_EFF_BITS 80
> +
> +/*
> + * Size of a CAN-FD Extended Frame
> + * (assuming CRC21, rounded up and ignoring bitstuffing)
> + */
> +#define CANFD_FRAME_OVERHEAD_EFF \
> +       DIV_ROUND_UP(CANFD_FRAME_OVERHEAD_EFF_BITS, BITS_PER_BYTE)
> +
> +/* CAN bit stuffing overhead multiplication factor */
> +#define CAN_BIT_STUFFING_OVERHEAD 1.2
> +
> +/*
> + * Maximum size of a Classical CAN frame in bits, ignoring bitstuffing
>   */
> -#define CANFD_FRAME_OVERHEAD_EFF DIV_ROUND_UP(80, 8)
> +#define CAN_FRAME_LEN_MAX_BITS_NO_STUFFING \
> +       (CAN_FRAME_OVERHEAD_EFF_BITS + CAN_MAX_DLEN *
> BITS_PER_BYTE)
> +
> +/*
> + * Maximum size of a Classical CAN frame in bits, including bitstuffing
> + */
> +#define CAN_FRAME_LEN_MAX_BITS_STUFFING                                \
> +       ((unsigned int)(CAN_FRAME_LEN_MAX_BITS_NO_STUFFING *    \
> +                       CAN_BIT_STUFFING_OVERHEAD))
>=20
>  /*
>   * Maximum size of a Classical CAN frame
> @@ -116,6 +164,18 @@
>   */
>  #define CAN_FRAME_LEN_MAX (CAN_FRAME_OVERHEAD_EFF +
> CAN_MAX_DLEN)
>=20
> +/*
> + * Maximum size of a CAN-FD frame in bits, ignoring bitstuffing
> + */
> +#define CANFD_FRAME_LEN_MAX_BITS_NO_STUFFING \
> +       (CANFD_FRAME_OVERHEAD_EFF_BITS + CANFD_MAX_DLEN *
> BITS_PER_BYTE)
> +
> +/*
> + * Maximum size of a CAN-FD frame in bits, ignoring bitstuffing
> + */
> +#define CANFD_FRAME_LEN_MAX_BITS_STUFFING                      \
> +       ((unsigned int)(CANFD_FRAME_LEN_MAX_BITS_NO_STUFFING *  \
> +                       CAN_BIT_STUFFING_OVERHEAD))
>  /*
>   * Maximum size of a CAN-FD frame
>   * (rounded up and ignoring bitstuffing)
> --
I was working on the same thing on Friday but didn't get around to sending =
it off, so here are a couple thoughts I had when working on the defines in =
length.h

The definitions for IFS in here are called intermission in the standard and=
 I'd argue they shouldn't be part of the frame at all. To quote the ISO: "D=
Fs and RFs shall be separated from preceding frames, whatever frame type th=
ey are (DF, RF, EF, OF),  by a time period called inter-frame space."
So, my suggestion would be to pull out the 3 bit IFS definition that's curr=
ently in and introduce 11 bit Bus idle and if necessary 3 bit Intermission =
separately.

index 6995092b774ec..62e92c1553376 100644
--- a/include/linux/can/length.h
+++ b/include/linux/can/length.h
@@ -6,6 +6,26 @@
 #ifndef _CAN_LENGTH_H
 #define _CAN_LENGTH_H

+/*
+ * First part of the Inter Frame Space
+ */
+#define CAN_INTERMISSION_BITS 3
+
+/*
+ * Number of consecutive recessive bits on the bus for integration etc.
+ */
+#define CAN_IDLE_CONDITION_BITS 11
+

The field currently called Stuff bit count (SBC) is also not correct I'd sa=
y. I'm not sure about the history but given that this is dependent on the D=
LC I think what's meant is the number of Fixed Stuff bits (FSB) . The ISO d=
oes not define a term for the Stuff bit Count but the CiA did define/docume=
nt it this way. What's meant though is not the number of fixed stuff bits (=
FSB) which the comment implies here but the modulo 8 3 bit gray-code follow=
ed by the parity bit. So for the FD frame definitions I'd propose something=
 like this: Renaming the current SBC to FSB and adding the SBC.
/*
  * Size of a CAN-FD Standard Frame
@@ -69,17 +87,17 @@
  * Error Status Indicator (ESI)                1
  * Data length code (DLC)              4
  * Data field                          0...512
- * Stuff Bit Count (SBC)               0...16: 4 20...64:5
+ * Stuff Bit Count (SBC)               4
  * CRC                                 0...16: 17 20...64:21
  * CRC delimiter (CD)                  1
+ * Fixed Stuff bits (FSB)              0...16: 6 20...64:7
  * ACK slot (AS)                       1
  * ACK delimiter (AD)                  1
  * End-of-frame (EOF)                  7
- * Inter frame spacing                 3
  *
- * assuming CRC21, rounded up and ignoring bitstuffing
+ * assuming CRC21, rounded up and ignoring dynamic bitstuffing
  */

Best Regards,
Thomas
