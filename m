Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91146B891D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 04:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCNDmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 23:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCNDmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 23:42:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8A41FD5;
        Mon, 13 Mar 2023 20:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hahNe8cxNqiAbE/X4p+06H1NR/X1+DJGyMg83FtueYcVTc2v6clsXeydI2KomoaFS5Zm7Cef4WXCgnKQIFXhh5v109rcUwaAusAAPLkrNy3wdUrc/xC8zLjVxZ5Xb/72k47kLFni35OusHi/3WBJKJU4W8NyUiageLcAzaexsv4TjkdTAFOrDjlsnUXNznuhQLuSGGJ5zu64bJQ594sNq9fOmiWIJJS5ZbO227F5kyJ6eX1tVK5K9aQvzLHr6nMSRplNDpNuPP0j9WdywbOIdmb/CxLXQQXvzRw874lMWVlx9sGdzdVMTQPV8rieUqAqeeuBPTvNEZTHfr2oUcGZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AptHKz5Heln38yknuEijHjHdaJ9glKyWzVMTt3BVm5Q=;
 b=UNHkrr1VQ506B+Yy/AIfLGZUa7UCSjBYDwNxfGNJkFvRQ2AuoLiYIWbONITZZfcS0OP4r4Wghiuv7R1seuFPuKBQjLsoStJLNHo+hqk1tF3fVXimE6cow5mT7dDTmxiBANybSxV16NC5AwC83xlZEa9nllTwURIxtn2Gfo4REmgEbbAsLbPBVAnaPcoEnj1eNi7dDXl2aNTSGdyAw9BOHudpImFCK6DRLDkV75KIH4ZnwL3JWo9BzQZxJHge0ejbupPKI4BnUBkRj+IrbnG8nQgva2G2S8kskqCl8b8dyJ3OeEhuiObY316JSQQagx0rrBu3/2qYEpT2Fhg8st5/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AptHKz5Heln38yknuEijHjHdaJ9glKyWzVMTt3BVm5Q=;
 b=XbMfaWJ9ET59YVGdNC8JulaOUqjKAT1AmLDzKAJQyeAAIFM94iLKQPiN8ggBfI22qBKWm1okBz1nobOdATarG2WR/+uEEu5BFp+xrYu4FlCHS6Wsvu+c7s4zh1eaeQ2B9IvZ9Rbelz14oLun6QVmgU+CfKD+5oMBC2TQzdfltjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by PH7PR08MB8377.namprd08.prod.outlook.com
 (2603:10b6:510:2b7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 03:42:08 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4e0c:f94b:5d28:66e4]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4e0c:f94b:5d28:66e4%6]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 03:42:08 +0000
Date:   Mon, 13 Mar 2023 22:42:00 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>
Cc:     Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/5] Input: add driver for Focaltech FTS touchscreen
Message-ID: <ZA/tCDOceYUZI88N@nixie71>
References: <20230312093249.1846993-1-joelselvaraj.oss@gmail.com>
 <20230312093249.1846993-3-joelselvaraj.oss@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312093249.1846993-3-joelselvaraj.oss@gmail.com>
X-ClientProxiedBy: CY5PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:930:1e::19) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|PH7PR08MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: dda8a982-9ec6-43e6-ff71-08db243e15ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KHpeuwEQOXbDAnqABq32WHt+Q22vTZzleXj+UilmIZJWy1F/LJl+IQss54I3HOhxYkRtmam+mrUf/JI7TJkarf6Agmus0tswmnEqGFPt6cLTfq9X0hlbwuN9E5hBUkMjFi0rO48PvSSyS0Boz+jjbQduGcubZBNuA9pkPmNfB1jd4UiObxI/vh1TA+KqlW4Nbnd+m60aQ3gklc6cnJT+r8W/GrHyWWwM8nHXb2v8rPgNfGY+4epDGZYbUnYwlH7axQB8s0tZQbH2coLkY9EE4SGqYxd4dp9+B/U54L4oGsW8yfSUZUpd9HbA6U1dyu2Bbpa9CHeAHpQryycFz8Wp/kJFNfZxNGIjk9KCHihSm2zkBLToMZcYrRC5nQiMa7A5sm2ZkYeRXSUobNlv5ifARKi3O+sadSHl2ykxBkPUnI3gDkYkVD19tV73uGBoiLp3Wqr/RiqgT1ph7rhxdNvSI7xGw3upYJMmmFMZNE4a6izH23mlxYn5NyK5dGC5i/UXF7oLjvIpfAlMyuSsLSNwRVx8hxtT8i8ZXwrktC51Qbn4GManhgD40R24RkyfWgtr+ilAVZbhq82t2BRvMmzLjWhq9ui54hhdXN01bY5OLq6ciLNSHyWfjMs/jtVysox1e3eCFIzb2yp22MZXDERA6dNQpDdC5nNlHopVMa175YV2R6Hi7fruRucbxOGjrhMyEQWMgz6KOMUJDEAEM0OQI9/+++u028GRHvBoKjknafBRMeP5IWA/wDadDIde74IS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(39830400003)(346002)(366004)(396003)(136003)(451199018)(8936002)(7416002)(41300700001)(30864003)(5660300002)(2906002)(38100700002)(86362001)(66556008)(66476007)(8676002)(66946007)(6666004)(6486002)(478600001)(54906003)(4326008)(6916009)(33716001)(6506007)(316002)(26005)(6512007)(9686003)(83380400001)(186003)(21314003)(2004002)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AJu0LHjjKZentfghx9Tw7Q8NcD0eaZiBuYLJXcPaM0ZNzFCWS6GbTdNG1uj0?=
 =?us-ascii?Q?UN0tmQ/pc4xDUmm9EIZ/y3TQG8h9W7mCWfsSDkG1r6erYBfC/RLelAE3Y3Wn?=
 =?us-ascii?Q?Z5Og+4OWNdQzL8WLMnhKiBBwLr34yXD+7LvaGVOtyBd6SN40JqSB95JvVYET?=
 =?us-ascii?Q?xlnLdMIW+EJgHrUjp/uQu6ixL7z04liE7P/j47Avbi89yujQafxPccSuxj+a?=
 =?us-ascii?Q?mhW8Gk4uakBUVYex3nidjbOikffnFzeo3j3Rrw+E7tZe8cbonA/xLbrHF74r?=
 =?us-ascii?Q?2/Bketg38wLh2ALLoD9IOeDH/zKHy5Hz1udFUTcFvYoBUv+AtjMN8NRBcojm?=
 =?us-ascii?Q?IOeApdeVAFycjAg/9pSz0Pj+A+umWtWtv19frn0SVYC0SVs2PaFRWtlwd440?=
 =?us-ascii?Q?93yEVFNRfu04T//jq9Kr4fLcHo41AXPI+JyQPWzigSNiYT+QNhLERFikWk8m?=
 =?us-ascii?Q?yyFOG1GM7LvSqdbDQ3Ppg+yos8hoX6YSW4gJmhuKYSyEFkOhfpXLTWfT5Xpl?=
 =?us-ascii?Q?uoLU1v6o/Gx/d5Volqdmc1lbQuR37D8w77NWwZODmjKZuUlJIpbQrVmfeN5P?=
 =?us-ascii?Q?Uu4ft15ovo1IaRvJUWJ0Ye1efm9F2SkQl13k8a8eTkE/8cc/gd14srHjbVst?=
 =?us-ascii?Q?OiTB5+nT8VRlJcJZh7agGlp+aHAwJgwTv3khYWjFDVa5kUI5y5EZZvWA4hPF?=
 =?us-ascii?Q?cXCjS8Iiim1yhJyWHUpK2Jf4NYRdaase/9a35Sw2Tst6s+Mx4TbylEt+MV4r?=
 =?us-ascii?Q?mmCk5+D0LFs2xwVTh0HZk0EA0PwJc6kFKI+kLmsPbCZ+ctfYPWIdm5d37wbe?=
 =?us-ascii?Q?xjePUZ7J6Y55PyCag8jrPqTXlGAkdQh+Tv8MzFOIxlOLigMchqmjx/wdtMhK?=
 =?us-ascii?Q?qud0ogCuXrQ649h78N1xU6WV2IzoHWgYkBYcnPVXU4VOsAm9rQB09Ef3Wf6S?=
 =?us-ascii?Q?yDuebkv1xMQelL4YhfM+J0eMynSOEd4qedYlmufoDVkUKSWODYdODu5iRP9H?=
 =?us-ascii?Q?mfW4ZuHu3wo1ER/PmOCKRosGMETMTfXtjx436NJ2dTJHVAyhyUOpl/9Shh6H?=
 =?us-ascii?Q?WBEOidJkCa8CThJIF1vJAMW1g1vOEaNc6rfuAUBCzbZSX5jgo2FZAZAuVc9x?=
 =?us-ascii?Q?MNICVph/zef9WUBY+dtkNmKK4Mf1b2z65+2oFDRe6wxAUAGdNtC0LMo+A2i5?=
 =?us-ascii?Q?gGs5+VjiD/TWdiaasLyBT3e1p/uw/oFh0pNbRqcJmfhZOrKrrXvAFCzdNHLL?=
 =?us-ascii?Q?MLeekdYfbS4l38SqUJ5gRjZl1tY4XvC6x54rPp7u3IkcZpx/ikWD3NqD97Yr?=
 =?us-ascii?Q?CuNbKr3RiEQdsPYMnYWHELTnNwsjmHyHbvRntyAHfkgFEkF5knzGXRsfwRhJ?=
 =?us-ascii?Q?6BhxO9XORkYXylR+qzccNXvEHXR3RIAkEd/1Gsw8c5vaFoq+21/u6UK8qyBi?=
 =?us-ascii?Q?Jk43J1fxWuasqvqm1dgerabo4yubQ2bFdPXby+Z+gNqGKVHikFUycQK5iKI2?=
 =?us-ascii?Q?n4CpOk8Gm3p+oBkMoDrb3mX1nMaukmiItlVNtMtVlgd9+FSZKfhvWqNzLdL5?=
 =?us-ascii?Q?Ju+yzyyJPLZwXsz5ANSlAZEaWiYbXsNnI8ceiSxw?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda8a982-9ec6-43e6-ff71-08db243e15ff
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 03:42:08.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtgBX4UUlhG+INWUwE5eXxkosKKwYe447QxaMqAUcRciZNsRBfgWG/hlEJYj2JVmmxpn8+H6I/cUvD7xyt3hBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR08MB8377
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel (and Caleb),

Great work! It's nice to see these devices get one step closer to
upstream. In addition to Markuss' valuable feedback, I have left a
few comments throughout.

On Sun, Mar 12, 2023 at 04:32:46AM -0500, Joel Selvaraj wrote:
> The Focaltech FTS driver supports several variants of focaltech
> touchscreens found in ~2018 era smartphones including variants found on
> the PocoPhone F1 and the SHIFT6mq which are already present in mainline.
> This driver is loosely based on the original driver from Focaltech
> but has been simplified and largely reworked.
> 
> Co-developed-by: Caleb Connolly <caleb@connolly.tech>
> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
> ---
>  MAINTAINERS                               |   8 +
>  drivers/input/touchscreen/Kconfig         |  12 +
>  drivers/input/touchscreen/Makefile        |   1 +
>  drivers/input/touchscreen/focaltech_fts.c | 448 ++++++++++++++++++++++
>  4 files changed, 469 insertions(+)
>  create mode 100644 drivers/input/touchscreen/focaltech_fts.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2892858cb040..deb561c356f2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7993,6 +7993,14 @@ L:	linux-input@vger.kernel.org
>  S:	Maintained
>  F:	drivers/input/joystick/fsia6b.c
>  
> +FOCALTECH FTS TOUCHSCREEN DRIVER
> +M:	Joel Selvaraj <joelselvaraj.oss@gmail.com>
> +M:	Caleb Connolly <caleb@connolly.tech>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/touchscreen/focaltech,fts.yaml
> +F:	drivers/input/touchscreen/focaltech_fts.c
> +
>  FOCUSRITE SCARLETT GEN 2/3 MIXER DRIVER
>  M:	Geoffrey D. Bennett <g@b4.vu>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 1a2049b336a6..320925bac3a1 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -388,6 +388,18 @@ config TOUCHSCREEN_EXC3000
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called exc3000.
>  
> +config TOUCHSCREEN_FOCALTECH_FTS
> +	tristate "Focaltech FTS Touchscreen"
> +	depends on I2C
> +	help
> +	  Say Y here to enable support for I2C connected Focaltech FTS
> +	  based touch panels, including the 5452 and 8917 panels.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called focaltech_fts.
> +
>  config TOUCHSCREEN_FUJITSU
>  	tristate "Fujitsu serial touchscreen"
>  	select SERIO
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index f2fd28cc34a6..83ea2e3ce754 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
>  obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+= egalax_ts_serial.o
>  obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
> +obj-$(CONFIG_TOUCHSCREEN_FOCALTECH_FTS)	+= focaltech_fts.o
>  obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
> diff --git a/drivers/input/touchscreen/focaltech_fts.c b/drivers/input/touchscreen/focaltech_fts.c
> new file mode 100644
> index 000000000000..d389c8b88944
> --- /dev/null
> +++ b/drivers/input/touchscreen/focaltech_fts.c
> @@ -0,0 +1,448 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *
> + * FocalTech touchscreen driver.
> + *
> + * Copyright (c) 2010-2017, FocalTech Systems, Ltd., all rights reserved.
> + * Copyright (C) 2018 XiaoMi, Inc.
> + * Copyright (c) 2021 Caleb Connolly <caleb@connolly.tech>
> + * Copyright (c) 2023 Joel Selvaraj <joelselvaraj.oss@gmail.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

The SPDX tag relieves you of the need to repeat any license terms. These
two paragraphs can be dropped.

> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/delay.h>
> +#include <linux/regmap.h>
> +#include <linux/mutex.h>
> +
> +#define FTS_REG_CHIP_ID_H 0xA3
> +#define FTS_REG_CHIP_ID_L 0x9F
> +
> +#define FTS_MAX_POINTS_SUPPORT 10
> +#define FTS_ONE_TOUCH_LEN 6
> +
> +#define FTS_TOUCH_X_H_OFFSET 3
> +#define FTS_TOUCH_X_L_OFFSET 4
> +#define FTS_TOUCH_Y_H_OFFSET 5
> +#define FTS_TOUCH_Y_L_OFFSET 6
> +#define FTS_TOUCH_PRESSURE_OFFSET 7
> +#define FTS_TOUCH_AREA_OFFSET 8
> +#define FTS_TOUCH_TYPE_OFFSET 3
> +#define FTS_TOUCH_ID_OFFSET 5
> +
> +#define FTS_TOUCH_DOWN 0
> +#define FTS_TOUCH_UP 1
> +#define FTS_TOUCH_CONTACT 2
> +
> +#define FTS_DRIVER_NAME "fts-i2c"
> +#define INTERVAL_READ_REG 100 /* unit:ms */
> +#define TIMEOUT_READ_REG 2000 /* unit:ms */

In addition to what Markuss has mentioned, please namespace all #defines
(i.e. FTS_xxx). I also find these easier to read if they are all aligned
horizontally.

> +
> +#define CHIP_TYPE_5452 0x5452
> +#define CHIP_TYPE_8719 0x8719

A #define with the name equal to the value is a bit unnecessary; below I
will suggest an alternative.

> +
> +struct fts_ts_data {
> +	struct i2c_client *client;
> +	struct input_dev *input_dev;
> +	struct touchscreen_properties prop;
> +
> +	struct regmap *regmap;
> +	int irq;
> +
> +	struct regulator_bulk_data regulators[2];
> +
> +	/* Touch data */
> +	u8 max_touch_number;
> +	u8 *point_buf;
> +	int point_buf_size;
> +
> +	/* DT data */
> +	struct gpio_desc *reset_gpio;
> +};

Technically the touchscreen_properties can be DT data too. I think the
comments and newlines in the struct definition are unnecessary.

> +
> +static const struct regmap_config fts_ts_i2c_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};

I personally find the driver easier to read if this definition is closer
to probe, where it is used.

> +
> +static bool fts_chip_is_valid(struct fts_ts_data *data, u16 id)
> +{
> +	if (id != CHIP_TYPE_5452 && id != CHIP_TYPE_8719)
> +		return false;
> +
> +	return true;
> +}

This isn't particularly scalable; we would end up with a massive if block
as we add compatible devices. Instead, define an array toward the beginning
of the driver as follows:

static const u16 fts_chip_types[] = {
        0x5452,
        0x8719,
};

And then this function could turn into something like this:

        for (i = 0; i < ARRAY_SIZE(fts_chip_types); i++)
                if (id = fts_chip_types[i])
                        return true;

        return false;

This would also get rid of those obvious #defines.

> +
> +int fts_check_status(struct fts_ts_data *data)
> +{
> +	int count = 0;
> +	unsigned int val, id;
> +
> +	do {
> +		regmap_read(data->regmap, FTS_REG_CHIP_ID_H, &val);
> +		id = val << 8;
> +		regmap_read(data->regmap, FTS_REG_CHIP_ID_L, &val);
> +		id |= val;

There are cleaner alternatives for this, such as:

        __be16 val;

        do {
                error = regmap_raw_read(data->regmap, FTS_REG_CHIP_ID_H,
                                        &val, sizeof(val));
                if (error)
                        return error;

                if (fts_chip_is_valid(data, be16_to_cpu(id)) {
                        dev_dbg(...);
                        return 0;
                }

                /* ... */
        }

Please also note that there is no reason for fts_chip_is_valid() to
accept 'data' as an argument. One could also argue this function is
not doing enough work or being re-used enough to warrant being its
own function.

> +
> +		if (fts_chip_is_valid(data, id)) {
> +			dev_dbg(&data->client->dev, "TS Ready: Chip ID = 0x%x", id);
> +			return 0;
> +		}
> +
> +		count++;
> +		msleep(INTERVAL_READ_REG);
> +	} while ((count * INTERVAL_READ_REG) < TIMEOUT_READ_REG);
> +
> +	return -EIO;
> +}
> +
> +static void fts_report_touch(struct fts_ts_data *data)
> +{
> +	struct input_dev *input_dev = data->input_dev;
> +	int base;
> +	unsigned int x, y, z, maj;
> +	u8 slot, type;
> +	int error, i = 0;
> +
> +	u8 *buf = data->point_buf;
> +
> +	memset(buf, 0, data->point_buf_size);
> +
> +	error = regmap_bulk_read(data->regmap, 0, buf, data->point_buf_size);
> +	if (error) {
> +		dev_err_ratelimited(&data->client->dev, "I2C read failed: %d\n",
> +				    error);
> +		return;
> +	}
> +
> +	for (i = 0; i < data->max_touch_number; i++) {
> +		base = FTS_ONE_TOUCH_LEN * i;
> +
> +		slot = (buf[base + FTS_TOUCH_ID_OFFSET]) >> 4;
> +		if (slot >= data->max_touch_number)
> +			break;
> +
> +		x = ((buf[base + FTS_TOUCH_X_H_OFFSET] & 0x0F) << 8) +
> +			 (buf[base + FTS_TOUCH_X_L_OFFSET] & 0xFF);
> +		y = ((buf[base + FTS_TOUCH_Y_H_OFFSET] & 0x0F) << 8) +
> +			 (buf[base + FTS_TOUCH_Y_L_OFFSET] & 0xFF);

It seems that the interrupt status registers can be represented with a packed
struct and then unpacked with be16_to_cpu().

> +
> +		z = buf[base + FTS_TOUCH_PRESSURE_OFFSET];
> +		if (z <= 0)
> +			z = 0x3f;

z is unsigned; how can this happen?

> +
> +		maj = buf[base + FTS_TOUCH_AREA_OFFSET] >> 4;
> +		if (maj <= 0)
> +			maj = 0x09;
> +
> +		type = buf[base + FTS_TOUCH_TYPE_OFFSET] >> 6;
> +
> +		input_mt_slot(input_dev, slot);
> +		if (type == FTS_TOUCH_DOWN || type == FTS_TOUCH_CONTACT) {
> +			input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, true);
> +			touchscreen_report_pos(data->input_dev, &data->prop, x, y, true);
> +			input_report_abs(input_dev, ABS_MT_PRESSURE, z);
> +			input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, maj);
> +			input_report_key(data->input_dev, BTN_TOUCH, 1);
> +		} else {
> +			input_report_key(data->input_dev, BTN_TOUCH, 0);
> +			input_mt_report_slot_inactive(input_dev);
> +		}
> +	}
> +	input_sync(input_dev);

We need to call input_mt_sync_frame() as well.

> +}
> +
> +static irqreturn_t fts_ts_interrupt(int irq, void *dev_id)
> +{
> +	struct fts_ts_data *data = dev_id;
> +
> +	fts_report_touch(data);

Assuming the act of reading the interrupt status registers is what prompts the
device to deassert its interrupt pin, I recommend promoting fts_report_touch()
to int type and evaluating its return value as follows:

        return fts_report_touch(data) ? IRQ_NONE : IRQ_HANDLED;

This way if the register read fails and the interrupt is in theory not serviced,
the IRQ subsystem can mute the device and prevent an interrupt storm.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void fts_power_off(void *d)
> +{
> +	struct fts_ts_data *data = d;
> +
> +	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
> +			       data->regulators);
> +}
> +
> +static int fts_start(struct fts_ts_data *data)
> +{
> +	int error;
> +
> +	error = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
> +				      data->regulators);
> +	if (error) {
> +		dev_err(&data->client->dev, "failed to enable regulators\n");
> +		return error;
> +	}
> +
> +	gpiod_set_value_cansleep(data->reset_gpio, 0);
> +	msleep(200);
> +
> +	enable_irq(data->irq);
> +
> +	return 0;
> +}
> +
> +static int fts_stop(struct fts_ts_data *data)
> +{
> +	disable_irq(data->irq);
> +	gpiod_set_value_cansleep(data->reset_gpio, 1);
> +	fts_power_off(data);
> +
> +	return 0;
> +}
> +
> +static int fts_input_open(struct input_dev *dev)
> +{
> +	struct fts_ts_data *data = input_get_drvdata(dev);
> +	int error;
> +
> +	error = fts_start(data);
> +	if (error)
> +		return error;
> +
> +	error = fts_check_status(data);
> +	if (error) {
> +		dev_err(&data->client->dev, "Failed to start or unsupported chip");
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static void fts_input_close(struct input_dev *dev)
> +{
> +	struct fts_ts_data *data = input_get_drvdata(dev);
> +
> +	fts_stop(data);
> +}
> +
> +static int fts_input_init(struct fts_ts_data *data)
> +{
> +	struct device *dev = &data->client->dev;
> +	struct input_dev *input_dev;
> +	int error = 0;
> +
> +	input_dev = devm_input_allocate_device(dev);
> +	if (!input_dev)
> +		return -ENOMEM;
> +
> +	data->input_dev = input_dev;
> +
> +	/* Init and register Input device */

This comment is obvious and not entirely true, as we're not actually registering
the device until farther down.

> +	input_dev->name = FTS_DRIVER_NAME;
> +	input_dev->id.bustype = BUS_I2C;
> +	input_dev->dev.parent = dev;
> +	input_dev->open = fts_input_open;
> +	input_dev->close = fts_input_close;
> +
> +	input_set_drvdata(input_dev, data);
> +
> +	__set_bit(EV_SYN, input_dev->evbit);

No need to set EV_SYN; input_register_device() does that for us.

> +	__set_bit(EV_ABS, input_dev->evbit);

No need to set EV_ABS; input_set_capability(..., EV_ABS, ...) does that for us.

> +	__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);

Same here; input_mt_init_slots() is already doing this.

> +
> +	input_mt_init_slots(input_dev, data->max_touch_number,
> +			    INPUT_MT_DIRECT);

Please check the return value of input_mt_init_slots(), and move this call
_after_ your axes have been defined. Otherwise, this function cannot copy
the multitouch axes to single-touch axes, and drivers such as libinput will
ignore this device.

> +	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
> +	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
> +
> +	touchscreen_parse_properties(input_dev, true, &data->prop);
> +	if (!data->prop.max_x || !data->prop.max_y) {
> +		dev_err(dev,
> +			"touchscreen-size-x and/or touchscreen-size-y not set in dts\n");

Note that dts may not always be the source of these (see comments below).

> +		return -EINVAL;
> +	}
> +
> +	data->point_buf_size = (data->max_touch_number * FTS_ONE_TOUCH_LEN) + 3;
> +	data->point_buf = devm_kzalloc(dev, data->point_buf_size, GFP_KERNEL);
> +	if (!data->point_buf) {
> +		dev_err(dev, "Failed to alloc memory for point buffer\n");

Did checkpatch not gripe about this? No need to print a warning for failed
memory allocation.

> +		return -ENOMEM;
> +	}
> +
> +	error = input_register_device(input_dev);
> +	if (error) {
> +		dev_err(dev, "Failed to register input device\n");
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int fts_parse_dt(struct fts_ts_data *data)
> +{
> +	int error = 0;
> +	struct device *dev = &data->client->dev;
> +	struct device_node *np = dev->of_node;
> +	u32 val;
> +
> +	error = of_property_read_u32(np, "focaltech,max-touch-number", &val);
> +	if (error) {
> +		dev_err(dev, "Unable to read property 'focaltech,max-touch-number'");
> +		return -EINVAL;

Just return 'error' rather than papering over the actual error code.

> +	}

Please switch to the device_property API to allow easy adoption of ACPI
at a later time. To that end, it is not necessarily appropriate to use
the term 'dt' in the name of this function.

That being said, I do agree with Krzysztof's point in the binding review;
it seems you are relying on the user to know the hardware limitation. In
my opinion this is the driver's responsibility.

I think it is OK if you want the user to have the option to artificially
limit the number of points, but in that case the property should be optional.

> +	if (val < 2 || val > FTS_MAX_POINTS_SUPPORT) {
> +		dev_err(dev, "'focaltech,max-touch-number' out of range [2, %d]",
> +			FTS_MAX_POINTS_SUPPORT);
> +		return -EINVAL;
> +	}

Since FTS_MAX_POINTS_SUPPORT exists, it seems FTS_MIN_POINTS_SUPPORT should too.

That being said, why not to support single-touch applications? It does not seem
you write this value back to a device register, so will the device not simply
report one contact if that is all that exists? input_mt_init_slots() is perfectly
happy with one slot.

> +	data->max_touch_number = val;
> +
> +	data->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(data->reset_gpio)) {
> +		error = PTR_ERR(data->reset_gpio);
> +		dev_err(dev, "Failed to request reset gpio, error %d\n", error);
> +		return error;
> +	}

Having a hardware reset pin is nice, but often it is given up in case the board
designer runs out of GPIO and pulls the reset pin up locally. Can it be optional?

> +
> +	return 0;
> +}
> +
> +static int fts_ts_probe(struct i2c_client *client)
> +{
> +	int error = 0;
> +	struct fts_ts_data *data;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(&client->dev, "I2C not supported");
> +		return -ENODEV;
> +	}
> +
> +	if (!client->irq) {
> +		dev_err(&client->dev, "No irq specified\n");
> +		return -EINVAL;
> +	}
> +
> +	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->client = client;
> +
> +	error = fts_parse_dt(data);
> +	if (error)
> +		return error;
> +
> +	i2c_set_clientdata(client, data);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &fts_ts_i2c_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(&client->dev, "regmap allocation failed\n");

It would be nice to save and print the error code as you do above for the
reset GPIO.

> +		return PTR_ERR(data->regmap);
> +	}
> +
> +	/*
> +	 * AVDD is the analog voltage supply (2.6V to 3.3V)
> +	 * VDDIO is the digital voltage supply (1.8V)
> +	 */
> +	data->regulators[0].supply = "avdd";
> +	data->regulators[1].supply = "vddio";
> +	error = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(data->regulators),
> +				      data->regulators);
> +	if (error) {
> +		dev_err(&client->dev, "Failed to get regulators %d\n", error);
> +		return error;
> +	}
> +
> +	error = devm_add_action_or_reset(&client->dev, fts_power_off, data);
> +	if (error) {
> +		dev_err(&client->dev, "failed to install power off handler\n");
> +		return error;
> +	}
> +
> +	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					fts_ts_interrupt, IRQF_ONESHOT,
> +					client->name, data);

Nit: alignment

> +	if (error) {
> +		dev_err(&client->dev, "Failed to request IRQ: %d\n", error);
> +		return error;
> +	}
> +
> +	error = fts_input_init(data);
> +	if (error)
> +		return error;
> +
> +	return 0;
> +}
> +
> +static int fts_pm_suspend(struct device *dev)
> +{
> +	struct fts_ts_data *data = dev_get_drvdata(dev);
> +
> +	mutex_lock(&data->input_dev->mutex);
> +
> +	if (input_device_enabled(data->input_dev))
> +		fts_stop(data);
> +
> +	mutex_unlock(&data->input_dev->mutex);
> +
> +	return 0;
> +}
> +
> +static int fts_pm_resume(struct device *dev)
> +{
> +	struct fts_ts_data *data = dev_get_drvdata(dev);
> +	int error = 0;
> +
> +	mutex_lock(&data->input_dev->mutex);
> +
> +	if (input_device_enabled(data->input_dev))
> +		error = fts_start(data);
> +
> +	mutex_unlock(&data->input_dev->mutex);
> +
> +	return error;
> +}
> +
> +static const struct dev_pm_ops fts_dev_pm_ops = {
> +	.suspend = fts_pm_suspend,
> +	.resume = fts_pm_resume,
> +};

Please use the new DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr().

> +
> +static const struct of_device_id fts_match_table[] = {
> +	{ .compatible = "focaltech,fts5452", },
> +	{ .compatible = "focaltech,fts8719", },
> +	{ /* sentinel */ },

Nit: no need for a trailing comma after the sentinel, as no patch would
ever add a line below it.

> +};
> +
> +MODULE_DEVICE_TABLE(of, fts_match_table);
> +
> +static struct i2c_driver fts_ts_driver = {
> +	.probe_new = fts_ts_probe,
> +	.driver = {
> +		.name = FTS_DRIVER_NAME,
> +		.pm = &fts_dev_pm_ops,
> +		.of_match_table = fts_match_table,
> +	},
> +};
> +module_i2c_driver(fts_ts_driver);
> +
> +MODULE_AUTHOR("Joel Selvaraj <joelselvaraj.oss@gmail.com>");
> +MODULE_AUTHOR("Caleb Connolly <caleb@connolly.tech>");
> +MODULE_DESCRIPTION("FocalTech touchscreen Driver");

Nit: inconsistent capitalization

> +MODULE_LICENSE("GPL");
> -- 
> 2.39.2
> 

Kind regards,
Jeff LaBundy
