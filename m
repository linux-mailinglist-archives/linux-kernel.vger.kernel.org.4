Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC02570674B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjEQL55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjEQL5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:57:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CBA99;
        Wed, 17 May 2023 04:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSNQYX0cMUmzsolnnsIyN4gcCzSxS9wPK64SFtoMq1QUjmaMUBxkrsW6dRSONnl5+6GWSbK4JR4peFoYFO8T+MIA3uWVhUxLL/kaVSiqXaa+JrkKfSWdZZ2GaWRH8+QeUER+1SNfjCpdSeSn5J7g7fVmZKTMVSRyEGO5jA1lNBMAVQi+Wk36ko/etDrKm7J0zpuXlZIlul+cceCu4PG5Zn+EgLMZnQ/cO3nPOUjx71sfOWi5/VKIMzryC5qizEFjnExyJi4ad+rufuM9S7p431+vku7CtCNvkxTDvCeXuz0v/LgCA3w599xP6KM99pIQw2QBGgxHj72G8MUBelO/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1clcbNXy46fJflwbnrtzSxGDZREWtOOW1ULyuoDlAQk=;
 b=mtw/Ej675YHUp9EdJzFrYI3DyEDwfzkN9km6jc6lU79wLv8UdacciNbnQDj/i0oFzZs2nJuGa8bscBwSfzvqnn+E9a34a15ussRaEi2ncZVneFc+76vY5gA4WWQM1acVgz8lOXsue7ZhDE6UK89OvylXnULtbrsKelSads9iBOVG+EFr5+tNYPXPakolpFXoWsLAHmf5gPS1WuDt4pxGWgMZIjV2B7lrnzrvuowKXQJgHQtv5D/2xqIbWHscc9d2xLB4Wo36S9TB4MNR7eh7FTsUdJXE5jjVFjy7yvpz/Un5bGzdvMfwTzxwYIJC4YKA1JrdCnpo8qGxsUKfr6+6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1clcbNXy46fJflwbnrtzSxGDZREWtOOW1ULyuoDlAQk=;
 b=uZ1DIjvGlcReOtgbsBcuZqIABmEl62vC6WJgDR7ncKWPMvbfrihCOT+2iMby9FvF0N4dmIAqy57sgTlvNxWDBLJjQnaFFksRn2iPD1AcPlvAGFmxzu+NnSjwaEXS4O3IUpCQX1gCKUZQPGq3+oT+D4n1Dkyw8Ix8IwPK6YLiDBU=
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.27; Wed, 17 May
 2023 11:57:45 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%7]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 11:57:45 +0000
From:   "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>
To:     "Simek, Michal" <michal.simek@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "git@xilinx.com" <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Katakam, Harini" <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        "Gajjar, Parth" <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "Sagar, Vishal" <vishal.sagar@amd.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] arm64: zynqmp: Switch to amd.com emails
Thread-Topic: [PATCH] arm64: zynqmp: Switch to amd.com emails
Thread-Index: AQHZh/wyjcLjr0uhpECo9tGeIEJak69eXIGg
Date:   Wed, 17 May 2023 11:57:45 +0000
Message-ID: <MW4PR12MB56676DB6C82A14A6A2451ED1917E9@MW4PR12MB5667.namprd12.prod.outlook.com>
References: <4c3426077075683b866f144b633cf5218a688c7c.1684244480.git.michal.simek@amd.com>
In-Reply-To: <4c3426077075683b866f144b633cf5218a688c7c.1684244480.git.michal.simek@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB5667:EE_|SJ2PR12MB8135:EE_
x-ms-office365-filtering-correlation-id: 25dcb3d0-d6fe-42bb-d98d-08db56cded77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uyzFALUnEVyACkDkdXENkM/M92PNDwWUQZ4Glz8TStrPZZDrsDTxRdO4Nsg7Dyhy51AwFoU+0Jum+FzawOf4ddYZqAjyT9u85CDd9RvmnRZk5Oho75Ihcs7sHjkPJK2LJGLgCYs48CqAtsLBlNWhdAtt7/cVspxPrFlhM8PsTlDuouTexqkzqcUriO6f1/FupDGUHKayQt/nW1jYAWWyqbAZldilF5l9TTjwWGX9GjP+UzpEYm67hTvarVe3UMjzJ2IYTxJQ16RMv1ozsjhOxqDftlSTYLjyTRldKYfZYpkOCocBOPWAT6mmpVmTZ38dDCyuakpLEQj6Pb1D7C6JsGmBoTXOkIZr5BSDpQ0TMs39DRqfnu8wS7b56Xzbmc1CbtO3Fd1R7Chk66uNDvBKOmF5pXuict12rfcCfe+6qEnw6NzEWHmIQD2jSqBOTVaCsBu1cSdoPySenfLmHUEpC5k3hjOL349E83Vm/pLCl+dmynpR0i94LzjZIMubs+ihxxAzqRJH/j2ctppv9Q82bxU4fV1FuD+KubrrkegqYN+czLa3caEtJCUtINmc0wzwl57BhFjEc7+7JQ7fIcnf+2ApVI/hiQyOeLH7uFccm4qTdHuEwixikJHO0758RG72
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB5667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199021)(4326008)(86362001)(76116006)(316002)(66556008)(478600001)(66946007)(64756008)(66446008)(66476007)(54906003)(7696005)(110136005)(33656002)(83380400001)(26005)(9686003)(186003)(53546011)(8676002)(5660300002)(7416002)(55016003)(71200400001)(8936002)(6506007)(38070700005)(41300700001)(38100700002)(2906002)(52536014)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tsmFJQxdMqYM9+LX3kVWtedf02AhY8s3Fq0jEUn/4XLhKF0qJY0+FxS5zfKF?=
 =?us-ascii?Q?q0mAVVG/0Of0fJ5YR9caxG5tM59w1f7tvUwm4upLeEm+j04bAT+C0u/Q8ze6?=
 =?us-ascii?Q?hgl4DwqR5vYm2Vfb4eBEwtRPmtCvCagni/tXFZph9/0z/yUJSyc0Rp9EcP/a?=
 =?us-ascii?Q?XFFlpMhELD1pxIH8y3kkRiz8IbnZBw6GCA86XTlNs79Snh0VJu+GuS49pzjN?=
 =?us-ascii?Q?kcClSMMcqyoQtvwn3mS0XmsNke5b5y3V0bvjWlZwbyjfuS0xME35Zniw0EkK?=
 =?us-ascii?Q?4HYW7MXHwYoa/cN7+KvCKlpP6XqdhjV3XaYDwghyi0TyW0q3X89KQumXmqmd?=
 =?us-ascii?Q?Q9V8oKA/ijXBi6h6WScygPl6TSahOePzyaEJMwhzAyuNYTj6dElvmlQdm1KA?=
 =?us-ascii?Q?PhzAeRPvrIC6zmwwP2iuLcZskQeyuQ95kUwM0sC7p724bo9clSnSfNR0g2/l?=
 =?us-ascii?Q?SM8pe5hrJ0IC3pKHK+5Ak4VEbLfeygOcL4KNUYOyXHYuaEC3v7WpuoFkRM9k?=
 =?us-ascii?Q?kvHmoHgBICy4YbdRQwy0AXyb5cuMstNnPyo6TDmmYkHsxqc2tTpfyxexjy2h?=
 =?us-ascii?Q?RYYCoRbNaV5+oLLwiCounQe2Krk9DWRzz0l0y65dPWpwc+LFe007XfW0ZALi?=
 =?us-ascii?Q?afk4+Zf8E8B27lH/jzJ/pKXye06yb5sR5VtNyq2Qjq60BIpjHfbbuE3MmpXu?=
 =?us-ascii?Q?CYOCpxlpAzlPejrX6+5eblxavh8RrYgaHIlfAttOtiYxr8MGE9KQIUwPFlim?=
 =?us-ascii?Q?+KyXSTHdTmDL6f/ElYmU+qZk6dLjow9E6Cx8khxAMnelnesCk2hieOX+m0LI?=
 =?us-ascii?Q?qN1tP/sY2HlQJmYyACd2+5C+B1QI/4OtUNUt4Z6m630sIaOMJXN1qC5M7ab0?=
 =?us-ascii?Q?UJoJhu5gFdpFdSIjrqBHNcOP7+imuaD39IDaBNXOgw9NTFelhZWDChuQh1Ck?=
 =?us-ascii?Q?hCufYZBR+bpE76y78DXOBj5RIJNvAvjbvb/mp+3Rk+81fzcw3/rqRr47Rp+P?=
 =?us-ascii?Q?ZteHt5RFI19YIsx3/9LSNDnqGYblJa3cDV/P6h7PGuJRyZrw6mSkV4Hy/2q8?=
 =?us-ascii?Q?tcedRjj/OlAKY+5Lvfy2UkV4w+nZzYp6i0AjSlpLA1ay/WCOV+/xoX8RHzFt?=
 =?us-ascii?Q?UYp/ugHhqJ5oKYrxGXtQWZgm5wcruK5VcA5N4fGAZxUeYw24cE9x1sXyX8W/?=
 =?us-ascii?Q?Pu/sb7xHtYccPtPnsVsztZX4TpInNRlK4gSqT+38+C85/Fgt24eeN5tP+PMl?=
 =?us-ascii?Q?LIxqrql6sX/Sta6iQAFG++mgF+8A7z3hKNrA2AlE2rPTYn/qeULOTa4ZZmrl?=
 =?us-ascii?Q?9Ur9fCcpCK4qVSefEomOj1zdBzlDttL5k6bSWaycmQNHUh/gwSoOA7sxjZeI?=
 =?us-ascii?Q?8noBu2neQ/dXdcYWuDWdnwO/4lV2fQx51o2bylOEZF36hSJV1imU4yngf9wH?=
 =?us-ascii?Q?BlWvYZRRw0NQ9hGVMQf0k8ldHwAdvfUYawsUAvfsHVsPW3wAtRKD98g4+OLb?=
 =?us-ascii?Q?5qjF5c+x+EF++AY0tHbEG/f7HVR/Wlfo/phM09/gvxJ+HP3xsM5stOQqeqtB?=
 =?us-ascii?Q?/ZRAvNzni2eNNG4Hsvk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dcb3d0-d6fe-42bb-d98d-08db56cded77
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 11:57:45.4782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AaxzCUEaFMR4CAcB+y+bhUg3O9HhsomuKKT3zmiyVdDkahmjSLUUpj2TVgL1vuBJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Simek, Michal <michal.simek@amd.com>
> Sent: Tuesday, May 16, 2023 7:12 PM
> To: linux-kernel@vger.kernel.org; monstr@monstr.eu; michal.simek@xilinx.c=
om;
> git@xilinx.com
> Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>; Andrew Davis
> <afd@ti.com>; Conor Dooley <conor+dt@kernel.org>; Geert Uytterhoeven
> <geert+renesas@glider.be>; Katakam, Harini <harini.katakam@amd.com>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Laurent Pinchart
> <laurent.pinchart@ideasonboard.com>; Michael Grzeschik
> <m.grzeschik@pengutronix.de>; Michael Tretter <m.tretter@pengutronix.de>;
> Gajjar, Parth <parth.gajjar@amd.com>; Piyush Mehta
> <piyush.mehta@xilinx.com>; Rob Herring <robh+dt@kernel.org>; Robert
> Hancock <robert.hancock@calian.com>; Srinivas Neeli
> <srinivas.neeli@xilinx.com>; Shah, Tanmay <tanmay.shah@amd.com>; Sagar,
> Vishal <vishal.sagar@amd.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: [PATCH] arm64: zynqmp: Switch to amd.com emails
>=20
> Update my and DPs email address to match current setup.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>=20
>  arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts      | 5 +++--
>  arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi         | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso   | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso   | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts      | 5 +++--
>  arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts     | 5 +++--
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts      | 5 +++--
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts      | 7 ++++---
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 2 +-
> arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 2 +-
> arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts | 5 +++--
> arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts | 5 +++--
> arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts | 7 ++++---
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts    | 5 +++--
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts    | 5 +++--
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts     | 7 ++++---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi                 | 5 +++--
>  24 files changed, 51 insertions(+), 39 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
> b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
> index 88aa06fa78a8..1495272e5668 100644
> --- a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
> +++ b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
> @@ -2,9 +2,10 @@
>  /*
>   * dts file for Avnet Ultra96 rev1
>   *
> - * (C) Copyright 2018, Xilinx, Inc.
> + * (C) Copyright 2018 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>=20
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> index 719ea5d5ae88..f04716841a0c 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> @@ -5,7 +5,7 @@
>   * (C) Copyright 2017 - 2022, Xilinx, Inc.
>   * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>=20
>  #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> index bebbe955eec1..669fe6084f3f 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
> @@ -9,7 +9,7 @@
>   * "Y" - A01 board modified with legacy interposer (Nexperia)
>   * "Z" - A01 board modified with Diode interposer
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>=20
>  #include <dt-bindings/gpio/gpio.h>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> index 8e66448f35a9..7886a19139ee 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
> @@ -4,7 +4,7 @@
>   *
>   * (C) Copyright 2020 - 2021, Xilinx, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>=20
>  #include <dt-bindings/gpio/gpio.h>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> index 464e28bf078a..8d1c54e00556 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> @@ -2,9 +2,10 @@
>  /*
>   * dts file for Xilinx ZynqMP SM-K26 rev1/B/A
>   *
> - * (C) Copyright 2020 - 2021, Xilinx, Inc.
> + * (C) Copyright 2020 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>=20
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
> b/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
> index c70966c1f344..664ea7d99049 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
> @@ -2,9 +2,10 @@
>  /*
>   * dts file for Xilinx ZynqMP SMK-K26 rev1/B/A
>   *
> - * (C) Copyright 2020 - 2021, Xilinx, Inc.
> + * (C) Copyright 2020 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>=20
>  #include "zynqmp-sm-k26-revA.dts"
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> index f1598527e5ec..774fb773886e 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> @@ -2,9 +2,10 @@
>  /*
>   * dts file for Xilinx ZynqMP ZC1232
>   *
> - * (C) Copyright 2017 - 2021, Xilinx, Inc.
> + * (C) Copyright 2017 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
>   */
>=20
>  /dts-v1/;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> index 04efa1683eaa..7c27b0e9a522 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> @@ -2,10 +2,11 @@
>  /*
>   * dts file for Xilinx ZynqMP ZC1254
>   *
> - * (C) Copyright 2015 - 2021, Xilinx, Inc.
> + * (C) Copyright 2015 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>   *
> - * Michal Simek <michal.simek@xilinx.com>
> - * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
> + * Michal Simek <michal.simek@amd.com>
> + * Siva Durga Prasad Paladug <siva.durga.prasad.paladugu@amd.com>

There is a typo in my name here and everywhere in the patch, Please fix thi=
s. Paladug -> Paladugu

Thanks,
DP
