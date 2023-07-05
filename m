Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3574827F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjGEKsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjGEKsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:48:53 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2065.outbound.protection.outlook.com [40.107.105.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F2FCE;
        Wed,  5 Jul 2023 03:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmg84AoVOgXnuxq7aXn3Nna8lWcJSe3or8x+8TzdeS3Nb0is413oV9XUJPxdEjTCUkgUKgtl+3RHc3/eiKh9z1uXle+Nh1OZPO++TQLCFd6DePp13YD89Kl/zotuvIXJ3qKUgMKOqNNO4fHjn5GOVgQckvSRoNqoS3NaLlSx/ct4UYRbVboC4f+kx9tAWnHVRyo3yTrUoY0NynonGRo2RbAKfX+DynAHuz5KB9Vpr0GWp+4snxf2YYIlVtsQhE7S13I+pueiztLcHOJpm0pPNk4YILBK/R5fu2dBy4lhAWzSArcSBRBJcWv3nP/iuh45Wg0oDpKlYeevfuBmb31WfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfO5stsAbtHh4jXcpv5srN8+1VhWYqQrzhhY18MV6Is=;
 b=i+I/b1yQ5HivIhFvRkhem1QVrJT1dSStv5CBIGRc+6UDsnF5X2nSMgoAjD/kj1usRr+hZ6e4puSIKiiOe+LLBwQCH3hqfmujjhnVfB2mgJcEb69E8SsX22F715GkdxoyjqfwsXZ7oWUn2f7VwU9LAPj3VNcy7W/DFt+mDMsMJqJQuzcz4tbPffwGtIJfwLo58UBS/NNYNq1lBXif9AnQXQaeJ4qteKEZnTkDCXat1ao5RB/H3IsqDg1uiOVb7wGjdW7CVKaS5DrWg+0PcpamgcQyIJn8p0AGJrXk7h4rd8WisscS2XKJ89J6kp0sxOy6TRykJIXiSbutD2YR7DcaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfO5stsAbtHh4jXcpv5srN8+1VhWYqQrzhhY18MV6Is=;
 b=UVAgbxGdhwl1zY9wKpyUMR1JjzvOoKfzlFbhQNrlw14snz+uWdlgR+xq2LsfTJ+h4u3hWAtRpsB8RabZ8KtPRIrd5k68uEO/o4JkxwOUeQuzVXSGQ2tytMIdqHQ/2z+bG6FJA48Kx1r5L9SK2EVBe74jhX2gXtyMrDDwDsUMGi3hp1SkOKyO5KKILm1Oqa1kvLMz9OiDl9nn4J5oIgLRHF6xo5A88eQ+coTJiOgm91Xmy/ld8TWJbf1KL/GCMh2u8klp26eszCCoNsA760Cy92i2hodB66NOXuJwWeb32G5bseTCabsAoPxk6TXKaEixz4YbXGbnYOQ4wW/4y6r5UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS5PR10MB8147.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:652::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 10:48:48 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 10:48:48 +0000
Date:   Wed, 5 Jul 2023 12:48:38 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/1] leds: simatic-ipc-leds-gpio: add new model BX-21A
Message-ID: <20230705124838.0e05177d@md1za8fc.ad001.siemens.net>
In-Reply-To: <5109f2da-3b7f-421f-555c-810484d92b4c@redhat.com>
References: <20230531155457.31632-1-henning.schild@siemens.com>
        <20230531155457.31632-2-henning.schild@siemens.com>
        <5109f2da-3b7f-421f-555c-810484d92b4c@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:610:58::40) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS5PR10MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f5abc6-0636-4612-9bdb-08db7d456977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWB90p7z27wR+HBzuvHegoUOwcPCAot4uD0SD3to8v1cjgitmDATnxVX1KeiBtUGBAZA5XkTiMviL9og1S8FqoyFaW4pAxHGwm5ddFXtIuEbtrbbUkpD4KK81j9LGeomPpiWhPkG9R7EQ8uIlrbqmTYOxPpMZSEFDljFrTWcFRKmgKKK7ozQa6zpNaZGCtbxxVTUGD8mtqrV9wSvECxXRRpjlDhQPJWkFDlSfaj3ehJU16peB+0sMcle8yRU0rjFjzA90LpqOpR++lEP13C+IFYc2xV+IaHdKoNZ8Ww+q5GCb71q3UEh8Ie85s+Lthq5/LMYDLnBxgO7HjtBlxL3S5Qoe+DcJUbay4BHiJD48+tLZZlpW+koP8eFAc44K19o+Ke28Y7wElKT4R6VHBw3j6Epm13pUbWQ1h1phcqwQE6w8P/UCLrH8prz60aTtznxT1WgWWLc2056cODhiDcG2Hijd9Ht0C8TWELgu5pHp0wIr6r2PC58ZP6lFwmsbt+1EyWIta4U3YhZKTynpGK3pJ9cbjeFQwprPAuiBVbAlU3r5IH1FErbLgILHNkl3a66
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(44832011)(8936002)(8676002)(83380400001)(41300700001)(316002)(5660300002)(2906002)(82960400001)(66946007)(38100700002)(6916009)(4326008)(66476007)(66556008)(86362001)(186003)(53546011)(478600001)(1076003)(9686003)(54906003)(6506007)(6486002)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AAvImsFdIldwBM3uAezndf1/1iSEbqSkA6Qke8gAmKV2xQThCvbv6hqFIHef?=
 =?us-ascii?Q?gS96kntWRhiwIrN2LPfPMcf7lCJLFAAcsNKXqsJBSGR0/wrC9w5YN5JrTJj7?=
 =?us-ascii?Q?PlJLOUZ3BwEH8u+vPGC5rVO5uIH5lWval3qi3TkFQgDbsNTwy66DbvWQhtSa?=
 =?us-ascii?Q?szchE0fDpny9N6LYf8LP1azCRxUsWugg3uK6WD71nKY4daUKPaDTN+MWzFRB?=
 =?us-ascii?Q?vBjNa2QxqS7MBNPEBKTdsVP4RMjpOeLjvB89PJIGLYi3YEcgb2tU4sujSEVw?=
 =?us-ascii?Q?D4aeJArjIVFEZnTNOjKmt9aM0avsPda0q+wVdnkfyWD83/+cDcrq4c56iJDH?=
 =?us-ascii?Q?Z7L3TohtTkWQSl8NAx1/wC+SRBx2thC5N17Sw9j2mvu6IQMdoAguA6FMvj2J?=
 =?us-ascii?Q?JBMhhCjep9fKaJelC06dSCnjrMfwJxstZAQR1OVRUZ4uwVuSoADH+i/ZXTcu?=
 =?us-ascii?Q?qsBmZ6xXZkoQdbuftroFY03/HzhQEserQ1L2v2zYgcp7NAQ3z8y1GV45cj30?=
 =?us-ascii?Q?1bzD3a1/+5WLLYfd6EMdkgq2hP4XJ2D+LONk1Suj5GB58aHjUXAKjXNGab10?=
 =?us-ascii?Q?ds/DFMcfjkCFUFnMHHisoDf5wvgEhZRw+2btxVD7ewtKt/x/As3QlLR/kTjS?=
 =?us-ascii?Q?sfB8K4DCc/novaOp0N9hy6wSgGtKn5p77favbIeRO4VLEznIUWszXMIASf+A?=
 =?us-ascii?Q?Cg1PfPKrCG3/W/87/F4dt0GSPcjIAp6vEgaj+5+qsaA/5NxBNDXjQuB/snkF?=
 =?us-ascii?Q?MtldWS5qPUh2IdQNtOYVtEYLTXC2Ntk86oY3J+FRSCqs9Y3fzPILDupEJSKR?=
 =?us-ascii?Q?PQ8PH4ck0roSNOFt2ySAA4EQ8Q8FjdOfzgPjF/MXjPVGx9A0j1xe3R0kmMH2?=
 =?us-ascii?Q?TKcIRhSH7kYXmGjXEngJg7sWKQlUnuhYqeyRkX+zhNnNw603P+/xDOpdYxIW?=
 =?us-ascii?Q?Py7NaFYMliATmoi5NmGcZ/vgEMzIRpq2AvypslZDKm/aEspoX16hlDsKgb7J?=
 =?us-ascii?Q?tmSM7WAdYFmwO9pgb7Z91mNiezbDsgsqq+H6fKzbmBF7JI0uoTG4DaNiMWwB?=
 =?us-ascii?Q?BDQfxcllxH5hlSOq8YSBjzn2CdGq64iWf5GKoKmehll1udP8Vs84fsQlkkHx?=
 =?us-ascii?Q?L3MB15foG8WUZNnQPYVkuHfU6M20UiYD10toY2jH7B93c90tv2CGx/Jexsd2?=
 =?us-ascii?Q?6aWbT9vRoGpMHT63ROrYhkXoIrV2wGv2w/Yx9oNT+h9uYw1cVwkPbrFqXsrj?=
 =?us-ascii?Q?bURolKGgNg9KwvZw6F3tX13Pb//Gk7Clab2ReCrmFOHv40NykCK9f4zH5eUX?=
 =?us-ascii?Q?/5EQ1645KnpcoSrjyjqN5SqkEmaElqJ7/R5bQrh3AFpGsfKYU8Ew+uUNcRBq?=
 =?us-ascii?Q?oQOBrJnp4/eQzEDP/OIf+Zx/8RSMCKIg1g7ADyWjfGEXX7LrN3gk+UYUi6h8?=
 =?us-ascii?Q?CAFo/ccUxJCF/so4yky+fXLFN3iYZy+lQ1soehht/txCLZZRxa9i5ap+osgJ?=
 =?us-ascii?Q?gfDOzXe5rT07fbDWkQq3Gtr86t8tLdeoLvXsT1mO2yenyF5FFeEb/wtip6Hr?=
 =?us-ascii?Q?bxyTfYFIbrXDJ2ZKVj3UVpGn6l1SEmFkBVqUtqd1ntyppv/JjeK8eOdn4rE2?=
 =?us-ascii?Q?qEXvicmIraFB0ru1OXdsLYX+h3BsrFgQ8FRLInzOjrltMnE8f2ycsr9QQzEE?=
 =?us-ascii?Q?oFXCcQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f5abc6-0636-4612-9bdb-08db7d456977
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 10:48:48.1777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLRt+UIRHAyIFKJstz8YDeCddGaPK/444EssozgWL2LmBXFTB/oq09Yx5eaBjqHB9afZ8EdRJTQQV4iGYMVxKgAPpgxxkVNacQHIx4drm98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8147
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 1 Jun 2023 10:53:48 +0200
schrieb Hans de Goede <hdegoede@redhat.com>:

> Hi,
> 
> On 5/31/23 17:54, Henning Schild wrote:
> > This adds support for the Siemens Simatic IPC BX-21A. Its LEDs are
> > connected to GPIO pins provided by the Intel Elkhart Lake pinctrl
> > driver.
> > 
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>  
> 
> Thank you for the patch.
> 
> Since this mostly touches files under drivers/leds I believe it would
> be best for this to be merged through Lee's LEDs tree.

Lee i saw that your tree got merged recently. This one was not yet part
of it.

Henning

> Here is my ack for merging the pdx86 bits through that tree:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> > ---
> >  drivers/leds/simple/Kconfig                   | 13 +++++
> >  drivers/leds/simple/Makefile                  |  1 +
> >  .../leds/simple/simatic-ipc-leds-gpio-core.c  |  4 ++
> >  .../simatic-ipc-leds-gpio-elkhartlake.c       | 57
> > +++++++++++++++++++ drivers/platform/x86/simatic-ipc.c            |
> >  3 + .../platform_data/x86/simatic-ipc-base.h      |  1 +
> >  include/linux/platform_data/x86/simatic-ipc.h |  3 +-
> >  7 files changed, 81 insertions(+), 1 deletion(-)
> >  create mode 100644
> > drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c
> > 
> > diff --git a/drivers/leds/simple/Kconfig
> > b/drivers/leds/simple/Kconfig index 44fa0f93cb3b..626ab18ac09d
> > 100644 --- a/drivers/leds/simple/Kconfig
> > +++ b/drivers/leds/simple/Kconfig
> > @@ -34,3 +34,16 @@ config LEDS_SIEMENS_SIMATIC_IPC_F7188X
> >  
> >  	  To compile this driver as a module, choose M here: the
> > module will be called simatic-ipc-leds-gpio-f7188x.
> > +
> > +config LEDS_SIEMENS_SIMATIC_IPC_ELKHARTLAKE
> > +	tristate "LED driver for Siemens Simatic IPCs based on
> > Intel Elkhart Lake GPIO"
> > +	depends on LEDS_GPIO
> > +	depends on PINCTRL_ELKHARTLAKE
> > +	depends on SIEMENS_SIMATIC_IPC
> > +	default LEDS_SIEMENS_SIMATIC_IPC
> > +	help
> > +	  This option enables support for the LEDs of several
> > Industrial PCs
> > +	  from Siemens based on Elkhart Lake GPIO i.e. BX-21A.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > module
> > +	  will be called simatic-ipc-leds-gpio-elkhartlake.
> > diff --git a/drivers/leds/simple/Makefile
> > b/drivers/leds/simple/Makefile index e3e840cea275..783578f11bb0
> > 100644 --- a/drivers/leds/simple/Makefile
> > +++ b/drivers/leds/simple/Makefile
> > @@ -2,3 +2,4 @@
> >  obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)			+=
> > simatic-ipc-leds.o
> > obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_APOLLOLAKE)	+=
> > simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-apollolake.o
> > obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_F7188X)		+=
> > simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-f7188x.o
> > +obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC_ELKHARTLAKE)	+=
> > simatic-ipc-leds-gpio-core.o simatic-ipc-leds-gpio-elkhartlake.o
> > diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c
> > b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c index
> > 2a21b663df87..c552ea73ed9d 100644 ---
> > a/drivers/leds/simple/simatic-ipc-leds-gpio-core.c +++
> > b/drivers/leds/simple/simatic-ipc-leds-gpio-core.c @@ -57,6 +57,7
> > @@ int simatic_ipc_leds_gpio_probe(struct platform_device *pdev,
> > switch (plat->devmode) { case SIMATIC_IPC_DEVICE_127E: case
> > SIMATIC_IPC_DEVICE_227G:
> > +	case SIMATIC_IPC_DEVICE_BX_21A:
> >  		break;
> >  	default:
> >  		return -ENODEV;
> > @@ -72,6 +73,9 @@ int simatic_ipc_leds_gpio_probe(struct
> > platform_device *pdev, goto out;
> >  	}
> >  
> > +	if (!table_extra)
> > +		return 0;
> > +
> >  	table_extra->dev_id = dev_name(dev);
> >  	gpiod_add_lookup_table(table_extra);
> >  
> > diff --git
> > a/drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c
> > b/drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c new file
> > mode 100644 index 000000000000..6ba21dbb3ba0 --- /dev/null
> > +++ b/drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c
> > @@ -0,0 +1,57 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Siemens SIMATIC IPC driver for GPIO based LEDs
> > + *
> > + * Copyright (c) Siemens AG, 2023
> > + *
> > + * Author:
> > + *  Henning Schild <henning.schild@siemens.com>
> > + */
> > +
> > +#include <linux/gpio/machine.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/leds.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/platform_data/x86/simatic-ipc-base.h>
> > +
> > +#include "simatic-ipc-leds-gpio.h"
> > +
> > +static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
> > +	.dev_id = "leds-gpio",
> > +	.table = {
> > +		GPIO_LOOKUP_IDX("INTC1020:04", 72, NULL, 0,
> > GPIO_ACTIVE_HIGH),
> > +		GPIO_LOOKUP_IDX("INTC1020:04", 77, NULL, 1,
> > GPIO_ACTIVE_HIGH),
> > +		GPIO_LOOKUP_IDX("INTC1020:04", 78, NULL, 2,
> > GPIO_ACTIVE_HIGH),
> > +		GPIO_LOOKUP_IDX("INTC1020:04", 58, NULL, 3,
> > GPIO_ACTIVE_HIGH),
> > +		GPIO_LOOKUP_IDX("INTC1020:04", 60, NULL, 4,
> > GPIO_ACTIVE_HIGH),
> > +		GPIO_LOOKUP_IDX("INTC1020:04", 62, NULL, 5,
> > GPIO_ACTIVE_HIGH),
> > +		{} /* Terminating entry */
> > +	},
> > +};
> > +
> > +static int simatic_ipc_leds_gpio_elkhartlake_probe(struct
> > platform_device *pdev) +{
> > +	return simatic_ipc_leds_gpio_probe(pdev,
> > &simatic_ipc_led_gpio_table,
> > +					   NULL);
> > +}
> > +
> > +static int simatic_ipc_leds_gpio_elkhartlake_remove(struct
> > platform_device *pdev) +{
> > +	return simatic_ipc_leds_gpio_remove(pdev,
> > &simatic_ipc_led_gpio_table,
> > +					    NULL);
> > +}
> > +
> > +static struct platform_driver
> > simatic_ipc_led_gpio_elkhartlake_driver = {
> > +	.probe = simatic_ipc_leds_gpio_elkhartlake_probe,
> > +	.remove = simatic_ipc_leds_gpio_elkhartlake_remove,
> > +	.driver = {
> > +		.name = KBUILD_MODNAME,
> > +	},
> > +};
> > +module_platform_driver(simatic_ipc_led_gpio_elkhartlake_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:" KBUILD_MODNAME);
> > +MODULE_SOFTDEP("pre: simatic-ipc-leds-gpio-core
> > platform:elkhartlake-pinctrl"); +MODULE_AUTHOR("Henning Schild
> > <henning.schild@siemens.com>"); diff --git
> > a/drivers/platform/x86/simatic-ipc.c
> > b/drivers/platform/x86/simatic-ipc.c index
> > c773995b230d..4402cd354104 100644 ---
> > a/drivers/platform/x86/simatic-ipc.c +++
> > b/drivers/platform/x86/simatic-ipc.c @@ -48,6 +48,7 @@ static
> > struct { {SIMATIC_IPC_IPC477E, SIMATIC_IPC_DEVICE_NONE,
> > SIMATIC_IPC_DEVICE_427E}, {SIMATIC_IPC_IPCBX_39A,
> > SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
> > {SIMATIC_IPC_IPCPX_39A, SIMATIC_IPC_DEVICE_NONE,
> > SIMATIC_IPC_DEVICE_227G},
> > +	{SIMATIC_IPC_IPCBX_21A, SIMATIC_IPC_DEVICE_BX_21A,
> > SIMATIC_IPC_DEVICE_NONE}, };
> >  
> >  static int register_platform_devices(u32 station_id)
> > @@ -72,6 +73,8 @@ static int register_platform_devices(u32
> > station_id) pdevname = KBUILD_MODNAME "_leds_gpio_apollolake";
> >  		if (ledmode == SIMATIC_IPC_DEVICE_227G)
> >  			pdevname = KBUILD_MODNAME
> > "_leds_gpio_f7188x";
> > +		if (ledmode == SIMATIC_IPC_DEVICE_BX_21A)
> > +			pdevname = KBUILD_MODNAME
> > "_leds_gpio_elkhartlake"; platform_data.devmode = ledmode;
> >  		ipc_led_platform_device =
> >  			platform_device_register_data(NULL,
> > diff --git a/include/linux/platform_data/x86/simatic-ipc-base.h
> > b/include/linux/platform_data/x86/simatic-ipc-base.h index
> > 57d6a10dfc9e..00bf18ecb160 100644 ---
> > a/include/linux/platform_data/x86/simatic-ipc-base.h +++
> > b/include/linux/platform_data/x86/simatic-ipc-base.h @@ -20,6 +20,7
> > @@ #define SIMATIC_IPC_DEVICE_127E 3
> >  #define SIMATIC_IPC_DEVICE_227E 4
> >  #define SIMATIC_IPC_DEVICE_227G 5
> > +#define SIMATIC_IPC_DEVICE_BX_21A 6
> >  
> >  struct simatic_ipc_platform {
> >  	u8	devmode;
> > diff --git a/include/linux/platform_data/x86/simatic-ipc.h
> > b/include/linux/platform_data/x86/simatic-ipc.h index
> > a48bb5240977..1a8e4c1099e3 100644 ---
> > a/include/linux/platform_data/x86/simatic-ipc.h +++
> > b/include/linux/platform_data/x86/simatic-ipc.h @@ -2,7 +2,7 @@
> >  /*
> >   * Siemens SIMATIC IPC drivers
> >   *
> > - * Copyright (c) Siemens AG, 2018-2021
> > + * Copyright (c) Siemens AG, 2018-2023
> >   *
> >   * Authors:
> >   *  Henning Schild <henning.schild@siemens.com>
> > @@ -34,6 +34,7 @@ enum simatic_ipc_station_ids {
> >  	SIMATIC_IPC_IPC227G = 0x00000F01,
> >  	SIMATIC_IPC_IPCBX_39A = 0x00001001,
> >  	SIMATIC_IPC_IPCPX_39A = 0x00001002,
> > +	SIMATIC_IPC_IPCBX_21A = 0x00001101,
> >  };
> >  
> >  static inline u32 simatic_ipc_get_station_id(u8 *data, int
> > max_len)  
> 

