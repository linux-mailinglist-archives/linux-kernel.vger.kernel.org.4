Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C7561854C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiKCQvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiKCQvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:51:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894C9A6;
        Thu,  3 Nov 2022 09:51:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAYIUvS6oci5ImTIHV0S90sa17xN+gULzwNF+qmCJNzYUek8ma40ObMoHZQXXDOXRQJmKCcdmWcwlavlvYKXjj5/qEZuuAJzSiNSCh+enPkOEzF5PEuymVU1IBjDXE1IkL02w8bjENW87C0ddTCkEjOG2wlz51kD4KysWQ4a8VPel0phZIOwmD7Sptel7I+xhtcWWcLvnQTrX42WNTGTxZfal5lgrPa92KDG5M1LgBUFpKFi8bL3vrkvEAcCvR1syqf4g9akmfwZYV2RNzYPiZwJuT60SME5bUGE6mli+pAFfH6SAbs71Ly1Vbd1NDKm7uimC85rclS6aj5L41thOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuWPDTkv2hn8jNViiKaE9Ogy+TjfMQ5Hj2vG1Iluzis=;
 b=mJczrNttUjY6k/VvAJPWJ/TBA2bRHQAuDP/I/PDceG7oKf4cV06FiUqnml4kmKDGcqx0wtUQhW/RFEUqwkcBybkr7sN8Q39sHBBLl/gakDfksDHRatIeKKrH/chMbGw2yn/orFZmBdIvXasXpcXDBHwISGuyAmtmdR5ZpE8eAM4W5fHdD6zFAhINRQqVh/q+pEqCRvXTar7a+eBgktJevYOC0J361eo9QA2nR19pVqtBJIFLC83FqLhpbUsTP3FeiS3zA30ctxxDt6TG0rBHvOmGNJplpOhm8Wi1vBbF0UvvgTNosiAfAIWdgoH3BGh9pT+G2om+uZxAIpsnZAT1Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuWPDTkv2hn8jNViiKaE9Ogy+TjfMQ5Hj2vG1Iluzis=;
 b=0mHba5tHNR3xFwDHFXxIieuMsEUyXx/7J7JvmrF9yLG08xvpWPhuUWaS+MYfa+PqGtIzFvkON5hR+mCyXnfPzUSVg9j4dKH8BrczDRWV1wm9c2QXV+aB0JGyDFnlZ1cR8jOBU8XZ913WGnE5EcdztTzKTRKYX2LZLNs/MW0GQOY=
Received: from BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 16:51:14 +0000
Received: from BY5PR12MB4033.namprd12.prod.outlook.com
 ([fe80::4b1c:dec1:5d46:1dce]) by BY5PR12MB4033.namprd12.prod.outlook.com
 ([fe80::4b1c:dec1:5d46:1dce%8]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 16:51:14 +0000
From:   "Neeli, Srinivas" <srinivas.neeli@amd.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window watchdog
 support
Thread-Topic: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window watchdog
 support
Thread-Index: AQHY0mDPx4RdhC+WcUWOcyuX5wtnOK37UmgAgA18EuCAJNRsgA==
Date:   Thu, 3 Nov 2022 16:51:14 +0000
Message-ID: <BY5PR12MB403330D43906BD6D617DB0DC93389@BY5PR12MB4033.namprd12.prod.outlook.com>
References: <20220927110257.41963-1-srinivas.neeli@amd.com>
 <20220927110257.41963-3-srinivas.neeli@amd.com>
 <20221002162528.GA2900147@roeck-us.net>
 <BY5PR12MB403335B81FB6DF09D65A08B593239@BY5PR12MB4033.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB403335B81FB6DF09D65A08B593239@BY5PR12MB4033.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4033:EE_|PH7PR12MB7163:EE_
x-ms-office365-filtering-correlation-id: 0f02645e-ed17-4aa2-d110-08dabdbb9e7f
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zUxzCYSFjrmY3M4HpuPtF5vIBSA6ANEpIdNCQzSMPoy9wl1ssWwofDKN62nwKr1QL6Dr/9lX5VsIJpU30tajojJsbqAA05oZEU+1BFve2E7Ijo7KzCuaTUEJFsAkmosOdf+dcpURfDDZGPC8X/EVZ1K0Pj+mjhMqSA7erTVb1y5cEN/TyDlTcKZev+u2znpsqwxH3fyDSOS8YFcdZ8XJo5gg4QmrcFzeOOw9xpc1DbvFEXlrN4uR2Iw5BsfaL0gkiA6X9N5CIKDqj+fSoFLGiOhsnheIpYSJqo4bTzBHtuOoLyEWOrL7T9Fzt5Z+5Rw9I2M1Q65UMKPL3d/eowCRRBsZvEyGUTEbIwppcgq7+B5bI69XlSScnUC9hQ0rFUhwxdVtS6KjxyBshP5hs/sJiCiQSr/5LIioat7SHFUzCXu0QVbQreED2+MNWaAtjQynb/OYRxK3G4cEATHFhk347eG05Be7yqeG2V5UsdCTNE9660VZczd+olOd3/JaCunsVydfMkKml2J13aQPNcjp7aEHg7U9vk1baIORgP1KXk3qHTuQ8H02vnef7ZXLHvt1mtCxDKypFzESgdLR1IKQ8Fo7jbwwOh3lBNpzwzO680E8lnZJ9oxtrBWeLamN8X95kkSYKZWKnk5C3byG1MMfppDnDmBwKkKEbV3WwhrqAFt/LvzaB/l+a594DRGL9mRVR6D35R+g1Exa6fBbHP1+9QGhUC20D81Tx7GkRb9VGDIQpdoqf5G6ztRGuZeCt0fjyW1tvxxXV1Bb4gASNZ4EYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4033.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199015)(2906002)(30864003)(8936002)(33656002)(5660300002)(52536014)(122000001)(8676002)(66556008)(66476007)(66446008)(55016003)(64756008)(66946007)(38100700002)(4326008)(76116006)(6916009)(316002)(54906003)(41300700001)(71200400001)(83380400001)(478600001)(53546011)(26005)(7696005)(6506007)(38070700005)(86362001)(186003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jddePbqeSxP1xtzAXsJu4Mn4tEq6uocMT4haYrDrqIYDLcj73cHhfjTaN5l4?=
 =?us-ascii?Q?OlDIZoZRRMO58Z+J7fTV8m0AeV1w4OnMIHCygcUZXZgR9wnPNQkiwoCqHByz?=
 =?us-ascii?Q?Q0ohrjjlveyhcmD01UPZXmYOqbkPZq/MXTYagweq1D3o1tiHGquk458nQQa7?=
 =?us-ascii?Q?yIatzLVF4XStOz1/Uat31/YAXgaWpItm3snWde46+QfEICS94CDDQbzWtda0?=
 =?us-ascii?Q?wsetPU3tt9+HG8IPXz3WxyyC/lQY5gxujmxbbzFTgCuQHk53EA1PymOX8iyw?=
 =?us-ascii?Q?z55eGMkkNEojpWMLOZfPLfkFMy/axK4MO0fazsFNbtZQLJq4feYHXtRMT12e?=
 =?us-ascii?Q?uBF9ECNNSnPKk0ZgMIh+jFOQlxYb9LDovHe/slZFuq/TdO0hmWWHzhkVPnpi?=
 =?us-ascii?Q?zTuugzPD8j3NzfAuNLhAuqeakEQ+7Deee8a2qB4UI/jer0f5TwQJH3HIuMND?=
 =?us-ascii?Q?jnqDb0uxq+43uiurkGVKEqqcHRu/UHmWyn8WH5e7LvGotmcHJga8QXWZuMlN?=
 =?us-ascii?Q?1toj/ao8zO3O+SQ7eon8Pbre9hXiLW/OVnHh0lGIqR2y7mDni+gcALhhfqWk?=
 =?us-ascii?Q?k0L04Pe3SF4cdmAeldqosI39vtuadVUF3Dx1oF7aZeVs0R9tjlx8WR7Lvgo/?=
 =?us-ascii?Q?js2DfFQGCqDr/DDG5mwGYZwj4l3WVU1TyLswnkqY7Hn2B5hTX0HISVYN7587?=
 =?us-ascii?Q?7c/sGMGGDXDlWIjtEgWJ26yIze5HguN0lvTRUWTEyGsHKKAH4n4qoH2UN3sM?=
 =?us-ascii?Q?doGHUFDxm+pJ3Xwo6nz4DCZKMWJtj61jgMJej7ScwFNkmD0lwCSYh8tEmBik?=
 =?us-ascii?Q?2YyCra7t699ZrCp1m39vpJKmOdpsuWrV0Q1vbggN/qZuhvjsBSqXh5w3+ruZ?=
 =?us-ascii?Q?bIrO5lI43QXSJplWTQUQ90dldAibbIRnzuCD9Q3eQA8sYh4d0KEhfbYAdvZy?=
 =?us-ascii?Q?6WdNJtj95TA0ngXb4bAzJ2Kym3oU4OwRi6xPjery+X28c4jqdCHSoKpqzAoT?=
 =?us-ascii?Q?A7KmJnIXx75IcPvRItIo9T3SBjs5dtqh4fu2zpKGGOY6ij5AIRY/gcY6v0Ad?=
 =?us-ascii?Q?N8JB0bmOXGsM7eIEViU9WdztlM+43e9eJBWO7ZcAP+1O9vDbEZOI2yQYGnTs?=
 =?us-ascii?Q?mNOG5L+jcASOv15vSX88ReNvkXmT2G7eFdHyCGQ1OZ3gJraAjx4wzHhoEgFy?=
 =?us-ascii?Q?70FZwdpqC7bijWou8z9Gt7lNhy7f2Ony8kYaHTuprCfCe31H653/b4zHzkU6?=
 =?us-ascii?Q?BFNbQh7vVZ/mwqJPAP8UtWTysz2604hNKFSptqWn4Pk7BUDCzx/OjV4wAYc1?=
 =?us-ascii?Q?AQgF696JPnK+hQqc3PxbckzoqDGx2unVRN/1uk7IbUR+XJ7yBh9lOrAx5URQ?=
 =?us-ascii?Q?ed8A6Il+0hHO//xKxhA9RDByc0NK8qVndsrT50Wb+WZtw9jdQltO5uiN3O5A?=
 =?us-ascii?Q?WFtY1pB4kfM7BvDt7JIxmD9sEKWRlVZnabQ/wWc8Ix/HKtBW+DnRy3djWwEt?=
 =?us-ascii?Q?sYmlLxQBCFF02UlVAEiCPB9xVBf1+oApIQGZsYz1IFZximGZo9e03sPvyfw/?=
 =?us-ascii?Q?38P3ZzsAkR/Z+U7BZP8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4033.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f02645e-ed17-4aa2-d110-08dabdbb9e7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 16:51:14.1744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oIbjymxthp51qjfTPNStUNYA3Q02cBgG3ubtBNIc/3QKXU88df5rnA0/VmjAHNmG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Guenter,

> -----Original Message-----
> From: Neeli, Srinivas <srinivas.neeli@amd.com>
> Sent: Tuesday, October 11, 2022 11:57 AM
> To: Guenter Roeck <linux@roeck-us.net>
> Cc: wim@linux-watchdog.org; Datta, Shubhrajyoti
> <shubhrajyoti.datta@amd.com>; Simek, Michal <michal.simek@amd.com>;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
> kernel@vger.kernel.org; linux-watchdog@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; git (AMD-Xilinx)
> <git@amd.com>
> Subject: RE: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window
> watchdog support
>=20
> Hi,
>=20
> > -----Original Message-----
> > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > Sent: Sunday, October 2, 2022 9:55 PM
> > To: Neeli, Srinivas <srinivas.neeli@amd.com>
> > Cc: wim@linux-watchdog.org; Datta, Shubhrajyoti
> > <shubhrajyoti.datta@amd.com>; Simek, Michal
> <michal.simek@amd.com>;
> > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
> > kernel@vger.kernel.org; linux-watchdog@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; devicetree@vger.kernel.org; git
> > (AMD-Xilinx) <git@amd.com>
> > Subject: Re: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window
> > watchdog support
> >
> > On Tue, Sep 27, 2022 at 04:32:56PM +0530, Srinivas Neeli wrote:
> > > Versal watchdog driver uses window watchdog mode. Window watchdog
> > > timer(WWDT) contains closed(first) and open(second) window with
> > > 32 bit width. Write to the watchdog timer within predefined window
> > > periods of time. This means a period that is not too soon and a
> > > period that is not too late. The WWDT has to be restarted within the
> > > open window time. If software tries to restart WWDT outside of the
> > > open window time period, it generates a reset.
> > >
> > > Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> > > ---
> > >  drivers/watchdog/Kconfig       |  17 ++
> > >  drivers/watchdog/Makefile      |   1 +
> > >  drivers/watchdog/xilinx_wwdt.c | 286
> > > +++++++++++++++++++++++++++++++++
> > >  3 files changed, 304 insertions(+)
> > >  create mode 100644 drivers/watchdog/xilinx_wwdt.c
> > >
> > > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > > index
> > > 688922fc4edb..9822e471b9f0 100644
> > > --- a/drivers/watchdog/Kconfig
> > > +++ b/drivers/watchdog/Kconfig
> > > @@ -304,6 +304,23 @@ config XILINX_WATCHDOG
> > >  	  To compile this driver as a module, choose M here: the
> > >  	  module will be called of_xilinx_wdt.
> > >
> > > +config XILINX_WINDOW_WATCHDOG
> > > +	tristate "Xilinx window watchdog timer"
> > > +	depends on HAS_IOMEM
> > > +	select WATCHDOG_CORE
> > > +	help
> > > +	  Window watchdog driver for the versal_wwdt ip core.
> > > +	  Window watchdog timer(WWDT) contains closed(first) and
> > > +	  open(second) window with 32 bit width. Write to the watchdog
> > > +	  timer within predefined window periods of time. This means
> > > +	  a period that is not too soon and a period that is not too
> > > +	  late. The WWDT has to be restarted within the open window time.
> > > +	  If software tries to restart WWDT outside of the open window
> > > +	  time period, it generates a reset.
> > > +
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called xilinx_wwdt.
> > > +
> > >  config ZIIRAVE_WATCHDOG
> > >  	tristate "Zodiac RAVE Watchdog Timer"
> > >  	depends on I2C
> > > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > > index cdeb119e6e61..4ff96c517407 100644
> > > --- a/drivers/watchdog/Makefile
> > > +++ b/drivers/watchdog/Makefile
> > > @@ -155,6 +155,7 @@ obj-$(CONFIG_M54xx_WATCHDOG) +=3D
> > m54xx_wdt.o
> > >
> > >  # MicroBlaze Architecture
> > >  obj-$(CONFIG_XILINX_WATCHDOG) +=3D of_xilinx_wdt.o
> > > +obj-$(CONFIG_XILINX_WINDOW_WATCHDOG) +=3D xilinx_wwdt.o
> > >
> > >  # MIPS Architecture
> > >  obj-$(CONFIG_ATH79_WDT) +=3D ath79_wdt.o diff --git
> > > a/drivers/watchdog/xilinx_wwdt.c b/drivers/watchdog/xilinx_wwdt.c
> > > new file mode 100644 index 000000000000..2594a01c2764
> > > --- /dev/null
> > > +++ b/drivers/watchdog/xilinx_wwdt.c
> > > @@ -0,0 +1,286 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Window watchdog device driver for Xilinx Versal WWDT
> > > + *
> > > + * Copyright (C) 2022, Advanced Micro Devices, Inc.
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/io.h>
> > > +#include <linux/ioport.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/watchdog.h>
> > > +
> > > +#define XWWDT_DEFAULT_TIMEOUT	40
> > > +#define XWWDT_MIN_TIMEOUT	1
> > > +#define XWWDT_MAX_TIMEOUT	42
> > > +
> > > +/* Register offsets for the WWDT device */
> > > +#define XWWDT_MWR_OFFSET	0x00
> > > +#define XWWDT_ESR_OFFSET	0x04
> > > +#define XWWDT_FCR_OFFSET	0x08
> > > +#define XWWDT_FWR_OFFSET	0x0c
> > > +#define XWWDT_SWR_OFFSET	0x10
> > > +
> > > +/* Master Write Control Register Masks */
> > > +#define XWWDT_MWR_MASK		BIT(0)
> > > +
> > > +/* Enable and Status Register Masks */
> > > +#define XWWDT_ESR_WINT_MASK	BIT(16)
> > > +#define XWWDT_ESR_WSW_MASK	BIT(8)
> > > +#define XWWDT_ESR_WEN_MASK	BIT(0)
> > > +
> > > +#define XWWDT_PERCENT		50
> > > +
> > > +static int xwwdt_timeout;
> > > +static int xclosed_window_percent;
> > > +
> > > +module_param(xwwdt_timeout, int, 0644);
> > > +MODULE_PARM_DESC(xwwdt_timeout,
> > > +		 "Watchdog time in seconds. (default=3D"
> > > +		 __MODULE_STRING(XWWDT_DEFAULT_TIMEOUT) ")");
> >
> > There is no reason to make this writeable. There are means to set the
> > timeout in runtime. Those should be used.
>=20
> Accepted and will update in V2.
> >
> > > +module_param(xclosed_window_percent, int, 0644);
> > > +MODULE_PARM_DESC(xclosed_window_percent,
> > > +		 "Watchdog closed window percentage. (default=3D"
> > > +		 __MODULE_STRING(XWWDT_PERCENT) ")");
> >
> > The above is problematic. This should really not be set during
> > runtime, and the behavior is pretty much undefined if it is changed
> > while the watchdog is running. It should really be set using
> > devicetree and not be changed in the running system.
>=20
> Accepted and will update in V2.
> >
> > > +
> > > +/**
> > > + * struct xwwdt_device - Watchdog device structure
> > > + * @base: base io address of WDT device
> > > + * @spinlock: spinlock for IO register access
> > > + * @xilinx_wwdt_wdd: watchdog device structure
> > > + * @clk: struct clk * of a clock source
> > > + * @freq: source clock frequency of WWDT  */ struct xwwdt_device {
> > > +	void __iomem *base;
> > > +	spinlock_t spinlock; /* spinlock for register handling */
> > > +	struct watchdog_device xilinx_wwdt_wdd;
> > > +	struct clk *clk;
> > > +	unsigned long	freq;
> > > +};
> > > +
> > > +static bool is_wwdt_in_closed_window(struct watchdog_device *wdd) {
> > > +	struct xwwdt_device *xdev =3D watchdog_get_drvdata(wdd);
> > > +	u32 csr, ret;
> > > +
> > > +	csr =3D ioread32(xdev->base + XWWDT_ESR_OFFSET);
> > > +
> > > +	ret =3D (csr & XWWDT_ESR_WEN_MASK) ? !(csr &
> > XWWDT_ESR_WSW_MASK) ? 0 :
> > > +1 : 1;
> >
> > This is confusing.
> >
> > 	return !(csr & XWWDT_ESR_WEN_MASK) || ((csr &
> XWWDT_ESR_WSW_MASK);
> >
> > should do the same and would be easier to understand, though I am not
> > sure if it is correct (making the point that the expression is confusin=
g).
> >
> Accepted and will update in V2.
>=20
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int xilinx_wwdt_start(struct watchdog_device *wdd) {
> > > +	struct xwwdt_device *xdev =3D watchdog_get_drvdata(wdd);
> > > +	struct watchdog_device *xilinx_wwdt_wdd =3D &xdev-
> > >xilinx_wwdt_wdd;
> > > +	u64 time_out, closed_timeout, open_timeout;
> > > +	u32 control_status_reg;
> > > +
> > > +	/* Calculate timeout count */
> > > +	time_out =3D xdev->freq * wdd->timeout;
> > > +
> > > +	if (xclosed_window_percent) {
> > > +		closed_timeout =3D (time_out * xclosed_window_percent) /
> > 100;
> > > +		open_timeout =3D time_out - closed_timeout;
> > > +		wdd->min_hw_heartbeat_ms =3D xclosed_window_percent *
> > 10 * wdd->timeout;
> > > +	} else {
> > > +		/* Calculate 50% of timeout */
> >
> > Isn't that a bit random ?
>=20
> Versal Window watchdog IP supports below features.
>  1)Start
>  2)Stop
>  3)Configure Timeout
>  4)Refresh
>=20
> Planning to take closed window percentage from device tree parameter.
> If the user hasn't passed the closed window percentage from the device tr=
ee,
> by default, taking XWWDT_PERCENT value which is 50.
>=20
> >
> > > +		time_out *=3D XWWDT_PERCENT;
> > > +		time_out /=3D 100;
> > > +		wdd->min_hw_heartbeat_ms =3D XWWDT_PERCENT * 10 *
> > wdd->timeout;
> >
> > min_hw_heartbeat_ms is supposed to be fixed after probe. Behavior of
> > changing it when starting the watchdog is undefined. This will likely
> > fail under some conditions.
>=20
> As I said in above comments versal watchdog IP supports reconfiguration o=
f
> timeout, so every restart we are updating min_hw_heartbeat_ms based on
> timeout.
>=20
> >
> > > +	}
> > > +
> > > +	spin_lock(&xdev->spinlock);
> > > +
> > > +	iowrite32(XWWDT_MWR_MASK, xdev->base +
> > XWWDT_MWR_OFFSET);
> > > +	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base +
> > XWWDT_ESR_OFFSET);
> > > +
> > > +	if (xclosed_window_percent) {
> > > +		iowrite32((u32)closed_timeout, xdev->base +
> > XWWDT_FWR_OFFSET);
> > > +		iowrite32((u32)open_timeout, xdev->base +
> > XWWDT_SWR_OFFSET);
> > > +	} else {
> > > +		/* Configure closed and open windows with 50% of timeout
> > */
> > > +		iowrite32((u32)time_out, xdev->base +
> > XWWDT_FWR_OFFSET);
> > > +		iowrite32((u32)time_out, xdev->base +
> > XWWDT_SWR_OFFSET);
> > > +	}
> >
> > This if/else should not be necessary by using appropriate calculations
> above.
> > Anyway, this is moot - as said above, changing min_hw_heartbeat_ms
> > after probe is unexpected, and the code will have to be changed to use
> > a fixed value for the window size. With that, all calculations can and
> > should be done in the probe function.
> >
> > > +
> > > +	/* Enable the window watchdog timer */
> > > +	control_status_reg =3D ioread32(xdev->base + XWWDT_ESR_OFFSET);
> > > +	control_status_reg |=3D XWWDT_ESR_WEN_MASK;
> > > +	iowrite32(control_status_reg, xdev->base + XWWDT_ESR_OFFSET);
> >
> > Why is this enabled unconditionally ? I would assume that a user
> > specifying a 0-percentage window size doesn't want it enabled.
>=20
> Plan to add a check for closed window percentage. If user tries to config=
ure
> 100% of closed window, driver configures XWWDT_PERCENT value.
> Configuring 100% of closed window not suggestible.
>=20
> >
> > > +
> > > +	spin_unlock(&xdev->spinlock);
> > > +
> > > +	dev_dbg(xilinx_wwdt_wdd->parent, "Watchdog Started!\n");
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int xilinx_wwdt_keepalive(struct watchdog_device *wdd) {
> > > +	struct xwwdt_device *xdev =3D watchdog_get_drvdata(wdd);
> > > +	u32 control_status_reg;
> > > +
> > > +	spin_lock(&xdev->spinlock);
> > > +
> > > +	/* Enable write access control bit for the window watchdog */
> > > +	iowrite32(XWWDT_MWR_MASK, xdev->base +
> > XWWDT_MWR_OFFSET);
> > > +
> > > +	/* Trigger restart kick to watchdog */
> > > +	control_status_reg =3D ioread32(xdev->base + XWWDT_ESR_OFFSET);
> > > +	control_status_reg |=3D XWWDT_ESR_WSW_MASK;
> > > +	iowrite32(control_status_reg, xdev->base + XWWDT_ESR_OFFSET);
> > > +
> > > +	spin_unlock(&xdev->spinlock);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int xilinx_wwdt_set_timeout(struct watchdog_device *wdd,
> > > +				   unsigned int new_time)
> > > +{
> > > +	struct xwwdt_device *xdev =3D watchdog_get_drvdata(wdd);
> > > +	struct watchdog_device *xilinx_wwdt_wdd =3D &xdev-
> > >xilinx_wwdt_wdd;
> > > +
> > > +	if (watchdog_active(xilinx_wwdt_wdd))
> > > +		return -EPERM;
> >
> > Why ? This will be the most common case and means to change the
> timeout.
>=20
> Versal Watchdog supports reconfiguration of timeout. If we try to
> reconfigure timeout without stopping the watchdog, driver returns error
> immediately. Reconfiguration of timeout, Stop and Refresh not allowed in
> closed window.
> User can trigger set timeout any point of time, So avoiding reconfiguring=
 the
> timeout feature using driver API if the watchdog is active.
>=20
> >
> > > +
> > > +	wdd->timeout =3D new_time;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int xilinx_wwdt_stop(struct watchdog_device *wdd) {
> > > +	struct xwwdt_device *xdev =3D watchdog_get_drvdata(wdd);
> > > +	struct watchdog_device *xilinx_wwdt_wdd =3D &xdev-
> > >xilinx_wwdt_wdd;
> > > +
> > > +	if (watchdog_active(xilinx_wwdt_wdd)) {
> > > +		if (!is_wwdt_in_closed_window(wdd)) {
> > > +			dev_warn(xilinx_wwdt_wdd->parent, "timer in
> > closed window");
> > > +			return -EPERM;
> > > +		}
> > > +	}
> > > +
> > > +	spin_lock(&xdev->spinlock);
> > > +
> > > +	iowrite32(XWWDT_MWR_MASK, xdev->base +
> > XWWDT_MWR_OFFSET);
> > > +
> > > +	/* Disable the Window watchdog timer */
> > > +	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base +
> > XWWDT_ESR_OFFSET);
> > > +
> > > +	spin_unlock(&xdev->spinlock);
> > > +
> > > +	clk_disable(xdev->clk);
> >
> > This doesn't work. The start function doesn't enable the clock; it is
> > enabled in the probe function. If you want to enable the clock
> > dynamically, you'll have to enable it in the start function and make
> > sure that it is stopped when unloading the driver (you can't use the
> > devm function in this case). You'll also need to make sure that the
> > unprepare function is called when unloading the driver.
> >
>=20
> Accepted and will update in V2.
>=20
> Thanks
> Neeli Srinivas

Could you please let me know your thoughts on "one line comment summary".

Thanks
Neeli Srinivas
> > > +
> > > +	dev_dbg(xilinx_wwdt_wdd->parent, "Watchdog Stopped!\n");
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void xwwdt_clk_disable_unprepare(void *data) {
> > > +	clk_disable_unprepare(data);
> > > +}
> > > +
> > > +static const struct watchdog_info xilinx_wwdt_ident =3D {
> > > +	.options =3D WDIOF_KEEPALIVEPING |
> > > +		WDIOF_SETTIMEOUT,
> > > +	.firmware_version =3D 1,
> > > +	.identity =3D "xlnx_window watchdog", };
> > > +
> > > +static const struct watchdog_ops xilinx_wwdt_ops =3D {
> > > +	.owner =3D THIS_MODULE,
> > > +	.start =3D xilinx_wwdt_start,
> > > +	.stop =3D xilinx_wwdt_stop,
> > > +	.set_timeout =3D xilinx_wwdt_set_timeout,
> > > +	.ping =3D xilinx_wwdt_keepalive,
> > > +};
> > > +
> > > +static int xwwdt_probe(struct platform_device *pdev) {
> > > +	struct watchdog_device *xilinx_wwdt_wdd;
> > > +	struct device *dev =3D &pdev->dev;
> > > +	struct xwwdt_device *xdev;
> > > +	int ret;
> > > +
> > > +	xdev =3D devm_kzalloc(dev, sizeof(*xdev), GFP_KERNEL);
> > > +	if (!xdev)
> > > +		return -ENOMEM;
> > > +
> > > +	xilinx_wwdt_wdd =3D &xdev->xilinx_wwdt_wdd;
> > > +	xilinx_wwdt_wdd->info =3D &xilinx_wwdt_ident;
> > > +	xilinx_wwdt_wdd->ops =3D &xilinx_wwdt_ops;
> > > +	xilinx_wwdt_wdd->parent =3D dev;
> > > +
> > > +	xdev->base =3D devm_platform_ioremap_resource(pdev, 0);
> > > +	if (IS_ERR(xdev->base))
> > > +		return PTR_ERR(xdev->base);
> > > +
> > > +	xdev->clk =3D devm_clk_get(dev, NULL);
> > > +	if (IS_ERR(xdev->clk))
> > > +		return PTR_ERR(xdev->clk);
> > > +
> > > +	xdev->freq =3D clk_get_rate(xdev->clk);
> > > +	if (!xdev->freq)
> > > +		return -EINVAL;
> > > +
> > > +	ret =3D clk_prepare_enable(xdev->clk);
> > > +	if (ret) {
> > > +		dev_err(dev, "unable to enable clock\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret =3D devm_add_action_or_reset(dev,
> > xwwdt_clk_disable_unprepare,
> > > +				       xdev->clk);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	xilinx_wwdt_wdd->timeout =3D XWWDT_DEFAULT_TIMEOUT;
> > > +	xilinx_wwdt_wdd->min_timeout =3D XWWDT_MIN_TIMEOUT;
> > > +	xilinx_wwdt_wdd->max_timeout =3D XWWDT_MAX_TIMEOUT;
> > > +
> > > +	ret =3D watchdog_init_timeout(xilinx_wwdt_wdd,
> > > +				    xwwdt_timeout, &pdev->dev);
> > > +	if (ret)
> > > +		dev_info(&pdev->dev, "Configured default timeout
> > value\n");
> > > +
> > > +	spin_lock_init(&xdev->spinlock);
> > > +	watchdog_set_drvdata(xilinx_wwdt_wdd, xdev);
> > > +
> > > +	ret =3D devm_watchdog_register_device(dev, xilinx_wwdt_wdd);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	dev_info(dev, "Xilinx window watchdog Timer with timeout %ds\n",
> > > +		 xilinx_wwdt_wdd->timeout);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct of_device_id xwwdt_of_match[] =3D {
> > > +	{ .compatible =3D "xlnx,versal-wwdt-1.0", },
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, xwwdt_of_match);
> > > +
> > > +static struct platform_driver xwwdt_driver =3D {
> > > +	.probe =3D xwwdt_probe,
> > > +	.driver =3D {
> > > +		.name =3D "Xilinx window watchdog",
> > > +		.of_match_table =3D xwwdt_of_match,
> > > +	},
> > > +};
> > > +
> > > +module_platform_driver(xwwdt_driver);
> > > +
> > > +MODULE_AUTHOR("Neeli Srinivas <srinivas.neeli@amd.com>");
> > > +MODULE_DESCRIPTION("Xilinx window watchdog driver");
> > > +MODULE_LICENSE("GPL");
