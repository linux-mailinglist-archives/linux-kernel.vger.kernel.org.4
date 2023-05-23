Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DB270E560
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbjEWT34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238331AbjEWT3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:29:54 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F04018C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6k1MuQygX6t2usdE06WTGZLH8win478zVQ9OMBbbCARGgvC1I6SggcjDkaGd0PNkqwRa+cX+P1oUNdZPGiJ2xqx+lwO5WtbW0MKJZy8gZ7vZvKHzIhdELx+FhDfsNwvGwNnL7tl6CVhYlXGEfC70g9ynCpo4qGeXRzKSMImVHP7TvA9wRzqyhtwlBrxq7M5zVUtbw4KYU0ZhvMm5PvzAeq+vPRR8ElcfbjcMtniLfDhAcUlF+0icufkWc+R95EbXQIF/j1lvql8TIgIa43LmJxYW5TJHNV5CmboGkif+P015FcG6XKpE3KhB+lCRgeKmYi5BskuO5HkQbeLBBgqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlEQcZkjViCgjwc4rzk4OlHmQDJZSzNrAgvnxOQS6dU=;
 b=gFIMilJ4CNRMIgrYe7bbZmyQzjvlS/PTJxCVV5HHV2pwJ9YQwnRPMAyotUHx3IfgPUsKxIVk12cvF1dp8YULOgNKgvhIukSNCnah7K3VdBSdOjrC+3a7xzFGJm1/0SWjhYh6j0qoAqxLQ+UJsLnu1niJzYSVlLOQBdJIYG6iDPYPTxjaXf0Iwu7uGj4SGLuqFQNyrVwqGX0QPDPmDhEoeCtmWnbGIG/5ba4xuyRRUSneoVpJKJMoCU8/6gKEZf20UuUL54SOXIA1dnu+R8+ossLpQ5EZ0RXn06oP0kQ88YxHjlYdcSjHM16IuXhYgCDxmTtWXQrNiZH6RNBhQlpEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlEQcZkjViCgjwc4rzk4OlHmQDJZSzNrAgvnxOQS6dU=;
 b=145ZQNHnjGtuD9tq3dJvZFLLmn1DQMtMIJ77I6+SzMQGsyNjiuKf2CoOw98U7/0DP6Phqe8E7vpdeOb7VrPnjtbGVLmclk973WuRxUfkrrjLmOg/Cs9uGhWh+Wtw2UszRAq2zQkq0lUAueIikBb6pHmLcx6/Ug/pYR5EKsr8lDA=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 19:29:24 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::723a:4152:5bb0:3763]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::723a:4152:5bb0:3763%2]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 19:29:24 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     "Simek, Michal" <michal.simek@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "git@xilinx.com" <git@xilinx.com>,
        "Neeli, Srinivas" <srinivas.neeli@amd.com>,
        "Kiernan, Derek" <derek.kiernan@amd.com>,
        "Cvetic, Dragan" <dragan.cvetic@amd.com>,
        "Harsha, Harsha" <harsha.harsha@amd.com>
Subject: RE: [PATCH] MAINTAINERS: Switch to @amd.com emails
Thread-Topic: [PATCH] MAINTAINERS: Switch to @amd.com emails
Thread-Index: AQHZh/0xnwds/Avvhk2n1MQxJAKjX69oSIHQ
Date:   Tue, 23 May 2023 19:29:23 +0000
Message-ID: <MN0PR12MB5953895503602BCAE5B01BD0B7409@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <f7773fdd002f89578b9e5262692a563fe7be4123.1684244928.git.michal.simek@amd.com>
In-Reply-To: <f7773fdd002f89578b9e5262692a563fe7be4123.1684244928.git.michal.simek@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CH3PR12MB9251:EE_
x-ms-office365-filtering-correlation-id: 6ec7af36-89dc-405f-d59c-08db5bc403e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aIIDdBhk5mkUp04G+IuUVkaMw2Dq+8FDZwY1gF1tzmB1muaeUnKBamsYosScwxZoLUw8ZvSjVt6KLmyNKREglQH5XJd51Uf69anHmdRnIr0WHtGoe1Nyiq7rrHM8ZopDU3BTkPNj+2gayVKF8aOlgOZKvOEUCnDWza9SOqEK/z7CjmZMM10FL7/veRL4hVXaqig+3G+rD7ScMXXUxJXPO7pCQHa2ZoU4umdb8Dw9VWwYfe7LC6Xw7t1JyKDk1eM33NKmn96bhlsG4nuNEJV487eFdMoYjESUga7hgkqiiI2Yfzeum9zHQRs1yrMiBeRsqZQgpYf0Pcod/JO6sW5vJzJxv/5yluAuTP8xVL2/MQR3xb2ZY/VnvKl3WGbQwsKbIAweTFxvuz/wlF0BSC5nuMcrrUt4mDW1wOhr1HmV8HehVzaKlqSGA2vzAJHa83XnbnLlQwYN1HcMcclIKoVNlr/pFlg3WzYbMGLFJ7WlXFW5HNUukePdr0VEFHsrO4UWBt+9wAYI0+r6pWXRdKtuZRwpGP9yOcenHVVa1B5+hY4HGlcKjVb2rswJHs6FMNNk4ZrC4zyK3X+O4s0hhTkN3bqymrQ4/EYVkhEb95tb74rq82mPwCPcY1a/D8+CrCBLM7aNzrM/F/bcjAgkgXaKxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(38070700005)(110136005)(83380400001)(86362001)(478600001)(38100700002)(33656002)(186003)(76116006)(66476007)(66946007)(6636002)(64756008)(66446008)(66556008)(2906002)(71200400001)(316002)(9686003)(53546011)(6506007)(7696005)(41300700001)(52536014)(8676002)(5660300002)(8936002)(55016003)(122000001)(921005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JFpFF2IEMMy8KTXMB/ObrJUfwtZzjSYEz7V9lGIDU76WZLVPbPkYg8IyTMKC?=
 =?us-ascii?Q?AKgrcK1cduQaxPbdaKmh71bU149pY/o6539VzSGHcMmJbEOlAxJKp4SOnUgF?=
 =?us-ascii?Q?hVIrTcrOSUmA/nlXPdPaLErqkYMQ1jHn23UbyMxXLazU1SRsxDfalB4SKmkU?=
 =?us-ascii?Q?wQfSxnNyHjazyR0wO7c0wyKZrdoTDrw/ZdSdJc2BrZQq4tv79t6x7rudnkIB?=
 =?us-ascii?Q?CC8rGdntIzYWVMDMnjac8iF7L2WVbgZ7tvdHeM0K6iS3XhgvdmDhzYgMuHP+?=
 =?us-ascii?Q?4U6E+79TothbqIrrY6W/abQmCCLZdnduW3pZXUNLkQq4vr+xdUwXfrrSQCiX?=
 =?us-ascii?Q?qurUJfWdPV8RoWEig3mLWXs+ncJ+N6P4h3EdjQQWF/azj3t4k1dy3v3gvWKU?=
 =?us-ascii?Q?HyV/usMG/DZ68uScXv6X5YVlvXiQQLJO2Y2IHU4vU6HREQo7MBEVlk6jqql/?=
 =?us-ascii?Q?Xht2R32xT8EZghMlgF6L9FpyQgFF7oX7F5skhC3hDzD3TY3bNjtJR2TLfWw5?=
 =?us-ascii?Q?8Tj1Cd7usrbSSwMVs/1FUW3ZdaYe26dqTYJ1+uk8CbWKXctXoMK9DVTpB4vL?=
 =?us-ascii?Q?K8JAsxesWco1UdjLVMDe5MIKUK0Fl77X6HWEXtDBQfF98FO8sYYZyYmrOWxa?=
 =?us-ascii?Q?JbYjtstbSTg4uWiBdswoiamVwcoLpkWVf0WyuzSW41LaGINn5PEyxN7GWqM0?=
 =?us-ascii?Q?cexxpbI0MmEcgLdQrD44dx9DC8RaLEIxUtY3A3BBK2ktLPdTCmdmOK76VM/L?=
 =?us-ascii?Q?W9bWbaWQLliDVCv4SUdvkWSdSOf692vhD6qZpurAJvvRVdPt7+2+gm5Wq+Yx?=
 =?us-ascii?Q?9UdxgBeFeZg5vg0KnrF5EFDcG5iCUvg7OPMfi60F3d43emIONOyu5mFktrYg?=
 =?us-ascii?Q?JV5PjlKcULzDP78ICkd2GUl40jfg+ZgoM0IT2S5oNLX753LDKGBAfGfSdMav?=
 =?us-ascii?Q?YN0BcDmA4bwM8JnJmCPhDFHhdH/P+qAjlRmRLPLwjRFR2S/aJp7DVG7fV42d?=
 =?us-ascii?Q?hLkhqzIqC0SANY+pjUXxYNe+v7meNg5Om9OyPXqAXmUwwW4Omu9MWGeldG/N?=
 =?us-ascii?Q?gFu/1y9D68Qd+LuV0C9IJSqHkyKsWARw43fLRWvpX1pWSolv1rcVjcinW/3P?=
 =?us-ascii?Q?4EmEiHDPlME530NvHMNUkgb/1YOOPpur+ubruwRTvoIZwWKLT6/GzkGLASr6?=
 =?us-ascii?Q?79fdX1BYNzoWRC4Mc6d/DoC+r1azxr+EJqBwJLRraya/YN20W9CCqegmngeh?=
 =?us-ascii?Q?QChB8osUeijOmsQf9QX+PEgSBCL4gFGqKE+7ajM/d/Zh1U+EdUw/o1hDfBoS?=
 =?us-ascii?Q?UfRbMdYkwjRhec2gA8SZpNDdu5Z9uAocqB0Misa8ykst/sr2f52v5pdFj2Cm?=
 =?us-ascii?Q?EE44MnAlV04fdYlkvJ2UmXHYaSt6KZ1jEAGILOo9N2ivkyAMy8EnlNem7jB0?=
 =?us-ascii?Q?7BF+BuYkACjgMU01s1CFkZI7PS/NJSFsWARg+s32xTYsih+tTvV9wWLM/KHD?=
 =?us-ascii?Q?YCRNl/eULIwxmB5JtflFLRTlH5qcuW1t8KoEr/t0v9isbS44RhpgLFVSEXSq?=
 =?us-ascii?Q?5AAo8+w6ZZoeoV+IufqMi1K2FQHKIwWfVDPBw3N8nUO+wnTlgffyyONRwtCn?=
 =?us-ascii?Q?jS72dquC54gsOVpcwBXgaBc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec7af36-89dc-405f-d59c-08db5bc403e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 19:29:23.9711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gctuwubJQMbmbke20WCIzLci5RZUPZjrCR1Q5ILtRYTuqMWGOcJOD6Hzd8TKMTXE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Simek, Michal <michal.simek@amd.com>
> Sent: Tuesday, May 16, 2023 7:19 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; Datta,
> Shubhrajyoti <shubhrajyoti.datta@amd.com>; linux-kernel@vger.kernel.org;
> monstr@monstr.eu; michal.simek@xilinx.com; git@xilinx.com; Neeli,
> Srinivas <srinivas.neeli@amd.com>; Kiernan, Derek
> <derek.kiernan@amd.com>; Cvetic, Dragan <dragan.cvetic@amd.com>;
> Harsha, Harsha <harsha.harsha@amd.com>
> Subject: [PATCH] MAINTAINERS: Switch to @amd.com emails
>=20
> @xilinx.com is still working but better to switch to new amd.com after
> AMD/Xilinx acquisition.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---

Acked-by:  Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>=20
>  MAINTAINERS | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 60f6effb168c..4b2ef60a4d01 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23115,7 +23115,7 @@ F:
> 	Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
>  F:	drivers/iio/adc/xilinx-ams.c
>=20
>  XILINX AXI ETHERNET DRIVER
> -M:	Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> +M:	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>  S:	Maintained
>  F:	drivers/net/ethernet/xilinx/xilinx_axienet*
>=20
> @@ -23128,8 +23128,8 @@ F:
> 	Documentation/devicetree/bindings/net/can/xilinx,can.yaml
>  F:	drivers/net/can/xilinx_can.c
>=20
>  XILINX GPIO DRIVER
> -M:	Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> -R:	Srinivas Neeli <srinivas.neeli@xilinx.com>
> +M:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> +R:	Srinivas Neeli <srinivas.neeli@amd.com>
>  R:	Michal Simek <michal.simek@amd.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
> @@ -23138,8 +23138,8 @@ F:	drivers/gpio/gpio-xilinx.c
>  F:	drivers/gpio/gpio-zynq.c
>=20
>  XILINX SD-FEC IP CORES
> -M:	Derek Kiernan <derek.kiernan@xilinx.com>
> -M:	Dragan Cvetic <dragan.cvetic@xilinx.com>
> +M:	Derek Kiernan <derek.kiernan@amd.com>
> +M:	Dragan Cvetic <dragan.cvetic@amd.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
>  F:	Documentation/misc-devices/xilinx_sdfec.rst
> @@ -23212,7 +23212,7 @@ F:
> 	Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
>  F:	drivers/phy/xilinx/phy-zynqmp.c
>=20
>  XILINX ZYNQMP SHA3 DRIVER
> -M:	Harsha <harsha.harsha@xilinx.com>
> +M:	Harsha <harsha.harsha@amd.com>
>  S:	Maintained
>  F:	drivers/crypto/xilinx/zynqmp-sha.c
>=20
> --
> 2.36.1

