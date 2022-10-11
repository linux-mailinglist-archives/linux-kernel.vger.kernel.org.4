Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44115FACC2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJKG1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJKG1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:27:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8F87DF51;
        Mon, 10 Oct 2022 23:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abUx0FN7ArXuyi8N3UK7j7d0aKKEdRtwwklc1iTwz3U81sf2mL/4dRKQXW+2hEV9oZox9gP2Pkci9rgo75i0SfuHqZydY/MRV/9dYQBGWZcbnmDPYbCTi+mRAV+eBnJIV6BLanlGTgczK2emQCzyx+s3MuEe80WMI6KjASmmZ7V7TTLxAWfjY7ulYTTB3OEXsGQhcf854NsxdIDpMlSB8Bof0XNP3LNstFqHWVmAuHPRL7f6baU9vJB2rqVUYFQkCiLioVLq3Ib0G0LkJoOnaeFhPKySsA8nLiLZlg6EtvxaltyfS8joIj69m0KafA5LubXt+WZy08NpxcNnnku5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uLxii2e9lgGWiQlw6NYdgwKgOLBwzIK+xHu5K9xCFE=;
 b=imrPPBGMeaWw8tJMrVzIMo6IblUCbgD+x5t/69D2yMUMBMq8SDtGWL+Olx2SXYRwfbBBo+gM64JIZD7SpvTGGQxcXUkQXvVnASZyb3mwdGjXMxJQjyV5UW17rWWNIRCBsRCiRxQqR8M4RP0Ofo8WdM6M2d/kM4LS9c03jBUBgerYSKqIzOtPyrnRpvjnoT3XptQMORwvJ3uedkeHgGy1wO23NYguOOl6UNG13OGZ+DB4m3xuyFUygmHaEB2zEB5gxvSFiXtpm713sNHby6zVdhB+dF6I4Yg5rLljENlTD1zi5x+if9WHykG8jNuy5QAAkjLOnTu8IgCQAHt5kek4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uLxii2e9lgGWiQlw6NYdgwKgOLBwzIK+xHu5K9xCFE=;
 b=XJz3IiGLv/xSJPQMog/c5IJgq81x/WmhiMSD9WQZqNmp4O1ieZ4nTYT+s6Y8H3UhYbTGjEON+UWrtY+FkyoGxuXekctpGMOM4oXc1DJFJVvzsXsDxhkgchaQ74Okwd3DV+eUJA87Mk7Qxl6NHtTTvbn17up3Tv1MU2zJ0/X+zNQ=
Received: from BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 by CH0PR12MB5314.namprd12.prod.outlook.com (2603:10b6:610:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 06:27:06 +0000
Received: from BY5PR12MB4033.namprd12.prod.outlook.com
 ([fe80::abe0:bc67:9f6a:1cc5]) by BY5PR12MB4033.namprd12.prod.outlook.com
 ([fe80::abe0:bc67:9f6a:1cc5%6]) with mapi id 15.20.5709.018; Tue, 11 Oct 2022
 06:27:05 +0000
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
Thread-Index: AQHY0mDPx4RdhC+WcUWOcyuX5wtnOK37UmgAgA18EuA=
Date:   Tue, 11 Oct 2022 06:27:05 +0000
Message-ID: <BY5PR12MB403335B81FB6DF09D65A08B593239@BY5PR12MB4033.namprd12.prod.outlook.com>
References: <20220927110257.41963-1-srinivas.neeli@amd.com>
 <20220927110257.41963-3-srinivas.neeli@amd.com>
 <20221002162528.GA2900147@roeck-us.net>
In-Reply-To: <20221002162528.GA2900147@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4033:EE_|CH0PR12MB5314:EE_
x-ms-office365-filtering-correlation-id: cf72362d-cf3a-4feb-d21f-08daab519e03
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pYUcIHXH44rlP3SMz4HVdZOJURddibTNPMubfV9UyzeXSwzHAdE0uefP/zylLqq9Ct1RjpXznssrleWwSGnTnbfwGy4mFYFRYbZyrC1rirHyoehsA/Tzv/cwualNcLprBh93ceeX+yUjNZr/6KxOyuZlAII9A9a5i6K9kvgV2M+KpYn7Fi0BclJo/R7WkpbFlb/v/TIlqNV4CewrND2Wvm3oDDmnvvNGRxn+OlQRS1JOJI592ycyzVaH5AL0ACKTQwf91cxrz3etLEqXFgnAYLSAakzTbgmxB0aU2E1SqzQjx5M7/aREb5sAWc3AiM98nNnWOXvfuRQGzMZj2aJmE3LF2bz1VHvd72pzMd1P+30g3FIjEYMK6iGfznyeVTV37NY2lWybVlpS70vMkXwVxlJji7aXnAVL00l6qR6+vRJ+x8cUP1MJAgG5uQxWyc9gN/ZNUM8IO2NQzMZ4M02bjA7G3L5vaa1ODVgUnykYYQjlpmuWZEx6oVCTfcVltCMbg4iW7KdqG14pkQyEwxrtr8MIFUsX9WLw/rSaV1Rvg0Klhb9QVc6nbfzQOX5su81LMVKfUO5g5TZgY/iDpXJ2L+nynvR761aQN9NMA7JAdOhTpw430av/M1sqp5b1G3y3XoGw+pu3b7Of7SJfI+XnGNZx9R1Cgmx3lPfEqZ51d22xT5oTF7kyBznbJcrmBmzfOWzuBc96hLL14CU1og4Jb4qziInVRprX7XMkkdOkN+Oa0SkKhZm3GtzCmhqOA1VaBf7zASVEv6N6fkc0tjhy1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4033.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199015)(9686003)(38070700005)(54906003)(316002)(55016003)(478600001)(71200400001)(122000001)(38100700002)(33656002)(86362001)(53546011)(66476007)(83380400001)(6506007)(186003)(7696005)(30864003)(6916009)(4326008)(8676002)(64756008)(66446008)(66556008)(8936002)(52536014)(5660300002)(2906002)(76116006)(66946007)(26005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zysuOv85PpEl43NYL4v4Cn/47hpI9Gs0Hn+1oZd23djlVqOVoCtCoRbS0SCc?=
 =?us-ascii?Q?N5T+PclTbVvexaKtbl9M+IatT9Gs9vGXJDKyO/l3mTDvFPrQUwyDGKSjMp1D?=
 =?us-ascii?Q?KRdG/587smmNggSW5DP1DrssbkVanggfMhhtowPFcP8fXpjqhAaj1UJYLaFr?=
 =?us-ascii?Q?V2h3ZV7+fOdJ7/MUTY+xefRUo6VKbvEqtFnHJXtENgAcLEAvMnly1Y0IHUmU?=
 =?us-ascii?Q?ArCkZHw7VdxoGbX9PRqibjfIOnVJn45/hUylYjoXK/kbZLwSu3SKmm9ArNPj?=
 =?us-ascii?Q?7avobT9B3t5K9J/3ZoWe2xBbmr8iTvWnNpiP9BypOxiHK/FZwWZcUtHOl2U4?=
 =?us-ascii?Q?hK4XRWd9aHF9J92ER8ufcBoc459pUOgmzS3EqKPzXIgR8kDnYJ0kBBEf+Z+T?=
 =?us-ascii?Q?fx6mOqjvYqOuqsF8czifN9741NxTtQmmze6ZmBbE13kv9IwDYEg6ucSoHjRr?=
 =?us-ascii?Q?n4+QTLp78Eb3mU9xNNWTpi3KX84pu6vNy1JtdLbyeLSxYYPMi/BMEg5sDhwy?=
 =?us-ascii?Q?I/yFtq6RFsmXIGm1dKPLS7q3islg3sDUjUi8HSl1WTFdjEUQ5yAyFZHQ5d40?=
 =?us-ascii?Q?3nRzqbviIg5m+zUu8pmHfqK34RFD+ifL+z0zcgCk1kKuXwbAYlWysGbdmWnW?=
 =?us-ascii?Q?Hn/iEpraTFKDUntxGFuMMY06ZuFApwEFzzjMQoEpYjU3zlu6PYF6xlB/emQ6?=
 =?us-ascii?Q?xr4rts950/KcWaXVyRIkA2FPBJ8HdreBJnBho524iM+MaqmcR69tJqOni3+h?=
 =?us-ascii?Q?a2UfhZ+3EZoLA+8lhSqLCDV1+/VpUW8u/SeFgDNP8yyceoiyO44uwyUZvxJu?=
 =?us-ascii?Q?ujA5yG8nP7643nafKm2WjMo2YGogtOUalF+M3JJOiAUoSmAi+RwviZ3iTHM8?=
 =?us-ascii?Q?vGiIzIA5ojcQxv1nveTvrEcQnCyWY+HiDzTGwnzSF59x9nPArmHdjP8gzOVW?=
 =?us-ascii?Q?vk2HtVc+8GK+OhtH6XjjTxKbzHzl7DyQQ0FEgz2dGmrCWNW8FrZDFSkUYe/S?=
 =?us-ascii?Q?QGV0fZEgN5SpiVEsmr+wYqblrxOLP2B1vT9x2LBCLZ47kYu4g6Gu5E3tOCKH?=
 =?us-ascii?Q?8vYpOLmxyy/I7UzZo9t/R/uXGrNIMq9kLqscd5Y03eYbRFV7vUMHPSDYmijy?=
 =?us-ascii?Q?0UfQltIJ8jR2IA5FwDI5n18ZrCEr5InU5KOsRsD43mGKGHu4NgRvkDHGV69C?=
 =?us-ascii?Q?W1S+RViqhE+oNjm7CRmOy4zQQqY5mPpi1vTOKJJ6pcOcMEQjQvyyS5v2oByn?=
 =?us-ascii?Q?CZaWJrPTPWUQx5H4ncgLr55UzL+orH64ii8dGATTAmtFBIWRVkPPjbaM8Fwk?=
 =?us-ascii?Q?8i+lYN/7ZhFwjYVmRKlkzUv1QzNBVuUnELmENJEXKLNa3zSHqwmoPIfl7Rd5?=
 =?us-ascii?Q?V9ZWkZtoJ68ASrMEzP/ZXtJn8e1SIwyxXhKyKECkNJ/HpskkjP6mP9086elt?=
 =?us-ascii?Q?nkYrijH1ARapcLxSuubHl++LzDv36COwu77GGhGPjb8j4qUFwlrqISWqg8/E?=
 =?us-ascii?Q?pJLXQthD3H+wjs76RIOOz21qGAaCIGsza2Kis/QbtrLtH4XzT3FK0DX2pm8V?=
 =?us-ascii?Q?AJowKYTos2VRVRNEHCE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4033.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf72362d-cf3a-4feb-d21f-08daab519e03
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 06:27:05.7785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZAgdfNyC3+CmVt3lP+dacLUG5uPHNM5a/kLsGhE8Ql7dv+vw9/cYVXenHhBDnCj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5314
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Sunday, October 2, 2022 9:55 PM
> To: Neeli, Srinivas <srinivas.neeli@amd.com>
> Cc: wim@linux-watchdog.org; Datta, Shubhrajyoti
> <shubhrajyoti.datta@amd.com>; Simek, Michal <michal.simek@amd.com>;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
> kernel@vger.kernel.org; linux-watchdog@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; git (AMD-Xilinx)
> <git@amd.com>
> Subject: Re: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window
> watchdog support
>=20
> On Tue, Sep 27, 2022 at 04:32:56PM +0530, Srinivas Neeli wrote:
> > Versal watchdog driver uses window watchdog mode. Window watchdog
> > timer(WWDT) contains closed(first) and open(second) window with
> > 32 bit width. Write to the watchdog timer within predefined window
> > periods of time. This means a period that is not too soon and a period
> > that is not too late. The WWDT has to be restarted within the open
> > window time. If software tries to restart WWDT outside of the open
> > window time period, it generates a reset.
> >
> > Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> > ---
> >  drivers/watchdog/Kconfig       |  17 ++
> >  drivers/watchdog/Makefile      |   1 +
> >  drivers/watchdog/xilinx_wwdt.c | 286
> > +++++++++++++++++++++++++++++++++
> >  3 files changed, 304 insertions(+)
> >  create mode 100644 drivers/watchdog/xilinx_wwdt.c
> >
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
> > 688922fc4edb..9822e471b9f0 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -304,6 +304,23 @@ config XILINX_WATCHDOG
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called of_xilinx_wdt.
> >
> > +config XILINX_WINDOW_WATCHDOG
> > +	tristate "Xilinx window watchdog timer"
> > +	depends on HAS_IOMEM
> > +	select WATCHDOG_CORE
> > +	help
> > +	  Window watchdog driver for the versal_wwdt ip core.
> > +	  Window watchdog timer(WWDT) contains closed(first) and
> > +	  open(second) window with 32 bit width. Write to the watchdog
> > +	  timer within predefined window periods of time. This means
> > +	  a period that is not too soon and a period that is not too
> > +	  late. The WWDT has to be restarted within the open window time.
> > +	  If software tries to restart WWDT outside of the open window
> > +	  time period, it generates a reset.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called xilinx_wwdt.
> > +
> >  config ZIIRAVE_WATCHDOG
> >  	tristate "Zodiac RAVE Watchdog Timer"
> >  	depends on I2C
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index cdeb119e6e61..4ff96c517407 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -155,6 +155,7 @@ obj-$(CONFIG_M54xx_WATCHDOG) +=3D
> m54xx_wdt.o
> >
> >  # MicroBlaze Architecture
> >  obj-$(CONFIG_XILINX_WATCHDOG) +=3D of_xilinx_wdt.o
> > +obj-$(CONFIG_XILINX_WINDOW_WATCHDOG) +=3D xilinx_wwdt.o
> >
> >  # MIPS Architecture
> >  obj-$(CONFIG_ATH79_WDT) +=3D ath79_wdt.o diff --git
> > a/drivers/watchdog/xilinx_wwdt.c b/drivers/watchdog/xilinx_wwdt.c new
> > file mode 100644 index 000000000000..2594a01c2764
> > --- /dev/null
> > +++ b/drivers/watchdog/xilinx_wwdt.c
> > @@ -0,0 +1,286 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Window watchdog device driver for Xilinx Versal WWDT
> > + *
> > + * Copyright (C) 2022, Advanced Micro Devices, Inc.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/ioport.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_address.h>
> > +#include <linux/watchdog.h>
> > +
> > +#define XWWDT_DEFAULT_TIMEOUT	40
> > +#define XWWDT_MIN_TIMEOUT	1
> > +#define XWWDT_MAX_TIMEOUT	42
> > +
> > +/* Register offsets for the WWDT device */
> > +#define XWWDT_MWR_OFFSET	0x00
> > +#define XWWDT_ESR_OFFSET	0x04
> > +#define XWWDT_FCR_OFFSET	0x08
> > +#define XWWDT_FWR_OFFSET	0x0c
> > +#define XWWDT_SWR_OFFSET	0x10
> > +
> > +/* Master Write Control Register Masks */
> > +#define XWWDT_MWR_MASK		BIT(0)
> > +
> > +/* Enable and Status Register Masks */
> > +#define XWWDT_ESR_WINT_MASK	BIT(16)
> > +#define XWWDT_ESR_WSW_MASK	BIT(8)
> > +#define XWWDT_ESR_WEN_MASK	BIT(0)
> > +
> > +#define XWWDT_PERCENT		50
> > +
> > +static int xwwdt_timeout;
> > +static int xclosed_window_percent;
> > +
> > +module_param(xwwdt_timeout, int, 0644);
> > +MODULE_PARM_DESC(xwwdt_timeout,
> > +		 "Watchdog time in seconds. (default=3D"
> > +		 __MODULE_STRING(XWWDT_DEFAULT_TIMEOUT) ")");
>=20
> There is no reason to make this writeable. There are means to set the
> timeout in runtime. Those should be used.

Accepted and will update in V2.
>=20
> > +module_param(xclosed_window_percent, int, 0644);
> > +MODULE_PARM_DESC(xclosed_window_percent,
> > +		 "Watchdog closed window percentage. (default=3D"
> > +		 __MODULE_STRING(XWWDT_PERCENT) ")");
>=20
> The above is problematic. This should really not be set during runtime, a=
nd
> the behavior is pretty much undefined if it is changed while the watchdog=
 is
> running. It should really be set using devicetree and not be changed in t=
he
> running system.

Accepted and will update in V2.
>=20
> > +
> > +/**
> > + * struct xwwdt_device - Watchdog device structure
> > + * @base: base io address of WDT device
> > + * @spinlock: spinlock for IO register access
> > + * @xilinx_wwdt_wdd: watchdog device structure
> > + * @clk: struct clk * of a clock source
> > + * @freq: source clock frequency of WWDT  */ struct xwwdt_device {
> > +	void __iomem *base;
> > +	spinlock_t spinlock; /* spinlock for register handling */
> > +	struct watchdog_device xilinx_wwdt_wdd;
> > +	struct clk *clk;
> > +	unsigned long	freq;
> > +};
> > +
> > +static bool is_wwdt_in_closed_window(struct watchdog_device *wdd) {
> > +	struct xwwdt_device *xdev =3D watchdog_get_drvdata(wdd);
> > +	u32 csr, ret;
> > +
> > +	csr =3D ioread32(xdev->base + XWWDT_ESR_OFFSET);
> > +
> > +	ret =3D (csr & XWWDT_ESR_WEN_MASK) ? !(csr &
> XWWDT_ESR_WSW_MASK) ? 0 :
> > +1 : 1;
>=20
> This is confusing.
>=20
> 	return !(csr & XWWDT_ESR_WEN_MASK) || ((csr &
> XWWDT_ESR_WSW_MASK);
>=20
> should do the same and would be easier to understand, though I am not
> sure if it is correct (making the point that the expression is confusing)=
.
>=20
Accepted and will update in V2.

> > +
> > +	return ret;
> > +}
> > +
> > +static int xilinx_wwdt_start(struct watchdog_device *wdd) {
> > +	struct xwwdt_device *xdev =3D watchdog_get_drvdata(wdd);
> > +	struct watchdog_device *xilinx_wwdt_wdd =3D &xdev-
> >xilinx_wwdt_wdd;
> > +	u64 time_out, closed_timeout, open_timeout;
> > +	u32 control_status_reg;
> > +
> > +	/* Calculate timeout count */
> > +	time_out =3D xdev->freq * wdd->timeout;
> > +
> > +	if (xclosed_window_percent) {
> > +		closed_timeout =3D (time_out * xclosed_window_percent) /
> 100;
> > +		open_timeout =3D time_out - closed_timeout;
> > +		wdd->min_hw_heartbeat_ms =3D xclosed_window_percent *
> 10 * wdd->timeout;
> > +	} else {
> > +		/* Calculate 50% of timeout */
>=20
> Isn't that a bit random ?

Versal Window watchdog IP supports below features.
 1)Start
 2)Stop
 3)Configure Timeout
 4)Refresh

Planning to take closed window percentage from device tree parameter.
If the user hasn't passed the closed window percentage from the device tree=
,=20
by default, taking XWWDT_PERCENT value which is 50.

>=20
> > +		time_out *=3D XWWDT_PERCENT;
> > +		time_out /=3D 100;
> > +		wdd->min_hw_heartbeat_ms =3D XWWDT_PERCENT * 10 *
> wdd->timeout;
>=20
> min_hw_heartbeat_ms is supposed to be fixed after probe. Behavior of
> changing it when starting the watchdog is undefined. This will likely fai=
l under
> some conditions.

As I said in above comments versal watchdog IP supports reconfiguration of =
timeout, so every restart we are updating min_hw_heartbeat_ms based on time=
out.

>=20
> > +	}
> > +
> > +	spin_lock(&xdev->spinlock);
> > +
> > +	iowrite32(XWWDT_MWR_MASK, xdev->base +
> XWWDT_MWR_OFFSET);
> > +	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base +
> XWWDT_ESR_OFFSET);
> > +
> > +	if (xclosed_window_percent) {
> > +		iowrite32((u32)closed_timeout, xdev->base +
> XWWDT_FWR_OFFSET);
> > +		iowrite32((u32)open_timeout, xdev->base +
> XWWDT_SWR_OFFSET);
> > +	} else {
> > +		/* Configure closed and open windows with 50% of timeout
> */
> > +		iowrite32((u32)time_out, xdev->base +
> XWWDT_FWR_OFFSET);
> > +		iowrite32((u32)time_out, xdev->base +
> XWWDT_SWR_OFFSET);
> > +	}
>=20
> This if/else should not be necessary by using appropriate calculations ab=
ove.
> Anyway, this is moot - as said above, changing min_hw_heartbeat_ms after
> probe is unexpected, and the code will have to be changed to use a fixed
> value for the window size. With that, all calculations can and should be =
done
> in the probe function.
>=20
> > +
> > +	/* Enable the window watchdog timer */
> > +	control_status_reg =3D ioread32(xdev->base + XWWDT_ESR_OFFSET);
> > +	control_status_reg |=3D XWWDT_ESR_WEN_MASK;
> > +	iowrite32(control_status_reg, xdev->base + XWWDT_ESR_OFFSET);
>=20
> Why is this enabled unconditionally ? I would assume that a user specifyi=
ng a
> 0-percentage window size doesn't want it enabled.

Plan to add a check for closed window percentage. If user tries to configur=
e 100% of closed window, driver configures XWWDT_PERCENT value.
Configuring 100% of closed window not suggestible.

>=20
> > +
> > +	spin_unlock(&xdev->spinlock);
> > +
> > +	dev_dbg(xilinx_wwdt_wdd->parent, "Watchdog Started!\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int xilinx_wwdt_keepalive(struct watchdog_device *wdd) {
> > +	struct xwwdt_device *xdev =3D watchdog_get_drvdata(wdd);
> > +	u32 control_status_reg;
> > +
> > +	spin_lock(&xdev->spinlock);
> > +
> > +	/* Enable write access control bit for the window watchdog */
> > +	iowrite32(XWWDT_MWR_MASK, xdev->base +
> XWWDT_MWR_OFFSET);
> > +
> > +	/* Trigger restart kick to watchdog */
> > +	control_status_reg =3D ioread32(xdev->base + XWWDT_ESR_OFFSET);
> > +	control_status_reg |=3D XWWDT_ESR_WSW_MASK;
> > +	iowrite32(control_status_reg, xdev->base + XWWDT_ESR_OFFSET);
> > +
> > +	spin_unlock(&xdev->spinlock);
> > +
> > +	return 0;
> > +}
> > +
> > +static int xilinx_wwdt_set_timeout(struct watchdog_device *wdd,
> > +				   unsigned int new_time)
> > +{
> > +	struct xwwdt_device *xdev =3D watchdog_get_drvdata(wdd);
> > +	struct watchdog_device *xilinx_wwdt_wdd =3D &xdev-
> >xilinx_wwdt_wdd;
> > +
> > +	if (watchdog_active(xilinx_wwdt_wdd))
> > +		return -EPERM;
>=20
> Why ? This will be the most common case and means to change the timeout.

Versal Watchdog supports reconfiguration of timeout. If we try to reconfigu=
re timeout without stopping the watchdog,
driver returns error immediately. Reconfiguration of timeout, Stop and Refr=
esh not allowed in closed window.
User can trigger set timeout any point of time, So avoiding reconfiguring t=
he timeout feature using driver API if the watchdog is active.

>=20
> > +
> > +	wdd->timeout =3D new_time;
> > +
> > +	return 0;
> > +}
> > +
> > +static int xilinx_wwdt_stop(struct watchdog_device *wdd) {
> > +	struct xwwdt_device *xdev =3D watchdog_get_drvdata(wdd);
> > +	struct watchdog_device *xilinx_wwdt_wdd =3D &xdev-
> >xilinx_wwdt_wdd;
> > +
> > +	if (watchdog_active(xilinx_wwdt_wdd)) {
> > +		if (!is_wwdt_in_closed_window(wdd)) {
> > +			dev_warn(xilinx_wwdt_wdd->parent, "timer in
> closed window");
> > +			return -EPERM;
> > +		}
> > +	}
> > +
> > +	spin_lock(&xdev->spinlock);
> > +
> > +	iowrite32(XWWDT_MWR_MASK, xdev->base +
> XWWDT_MWR_OFFSET);
> > +
> > +	/* Disable the Window watchdog timer */
> > +	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base +
> XWWDT_ESR_OFFSET);
> > +
> > +	spin_unlock(&xdev->spinlock);
> > +
> > +	clk_disable(xdev->clk);
>=20
> This doesn't work. The start function doesn't enable the clock; it is ena=
bled in
> the probe function. If you want to enable the clock dynamically, you'll h=
ave
> to enable it in the start function and make sure that it is stopped when
> unloading the driver (you can't use the devm function in this case). You'=
ll also
> need to make sure that the unprepare function is called when unloading th=
e
> driver.
>=20

Accepted and will update in V2.

Thanks
Neeli Srinivas
> > +
> > +	dev_dbg(xilinx_wwdt_wdd->parent, "Watchdog Stopped!\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static void xwwdt_clk_disable_unprepare(void *data) {
> > +	clk_disable_unprepare(data);
> > +}
> > +
> > +static const struct watchdog_info xilinx_wwdt_ident =3D {
> > +	.options =3D WDIOF_KEEPALIVEPING |
> > +		WDIOF_SETTIMEOUT,
> > +	.firmware_version =3D 1,
> > +	.identity =3D "xlnx_window watchdog",
> > +};
> > +
> > +static const struct watchdog_ops xilinx_wwdt_ops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.start =3D xilinx_wwdt_start,
> > +	.stop =3D xilinx_wwdt_stop,
> > +	.set_timeout =3D xilinx_wwdt_set_timeout,
> > +	.ping =3D xilinx_wwdt_keepalive,
> > +};
> > +
> > +static int xwwdt_probe(struct platform_device *pdev) {
> > +	struct watchdog_device *xilinx_wwdt_wdd;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct xwwdt_device *xdev;
> > +	int ret;
> > +
> > +	xdev =3D devm_kzalloc(dev, sizeof(*xdev), GFP_KERNEL);
> > +	if (!xdev)
> > +		return -ENOMEM;
> > +
> > +	xilinx_wwdt_wdd =3D &xdev->xilinx_wwdt_wdd;
> > +	xilinx_wwdt_wdd->info =3D &xilinx_wwdt_ident;
> > +	xilinx_wwdt_wdd->ops =3D &xilinx_wwdt_ops;
> > +	xilinx_wwdt_wdd->parent =3D dev;
> > +
> > +	xdev->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(xdev->base))
> > +		return PTR_ERR(xdev->base);
> > +
> > +	xdev->clk =3D devm_clk_get(dev, NULL);
> > +	if (IS_ERR(xdev->clk))
> > +		return PTR_ERR(xdev->clk);
> > +
> > +	xdev->freq =3D clk_get_rate(xdev->clk);
> > +	if (!xdev->freq)
> > +		return -EINVAL;
> > +
> > +	ret =3D clk_prepare_enable(xdev->clk);
> > +	if (ret) {
> > +		dev_err(dev, "unable to enable clock\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D devm_add_action_or_reset(dev,
> xwwdt_clk_disable_unprepare,
> > +				       xdev->clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	xilinx_wwdt_wdd->timeout =3D XWWDT_DEFAULT_TIMEOUT;
> > +	xilinx_wwdt_wdd->min_timeout =3D XWWDT_MIN_TIMEOUT;
> > +	xilinx_wwdt_wdd->max_timeout =3D XWWDT_MAX_TIMEOUT;
> > +
> > +	ret =3D watchdog_init_timeout(xilinx_wwdt_wdd,
> > +				    xwwdt_timeout, &pdev->dev);
> > +	if (ret)
> > +		dev_info(&pdev->dev, "Configured default timeout
> value\n");
> > +
> > +	spin_lock_init(&xdev->spinlock);
> > +	watchdog_set_drvdata(xilinx_wwdt_wdd, xdev);
> > +
> > +	ret =3D devm_watchdog_register_device(dev, xilinx_wwdt_wdd);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_info(dev, "Xilinx window watchdog Timer with timeout %ds\n",
> > +		 xilinx_wwdt_wdd->timeout);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id xwwdt_of_match[] =3D {
> > +	{ .compatible =3D "xlnx,versal-wwdt-1.0", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, xwwdt_of_match);
> > +
> > +static struct platform_driver xwwdt_driver =3D {
> > +	.probe =3D xwwdt_probe,
> > +	.driver =3D {
> > +		.name =3D "Xilinx window watchdog",
> > +		.of_match_table =3D xwwdt_of_match,
> > +	},
> > +};
> > +
> > +module_platform_driver(xwwdt_driver);
> > +
> > +MODULE_AUTHOR("Neeli Srinivas <srinivas.neeli@amd.com>");
> > +MODULE_DESCRIPTION("Xilinx window watchdog driver");
> > +MODULE_LICENSE("GPL");
