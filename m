Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA368700D89
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbjELRAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjELRAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:00:43 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6126358A;
        Fri, 12 May 2023 10:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPOiAz0uIX5Vgq8v3B8Q8bWGg01/7ImSJQvIeqSYYUmM/xV4izikmMjmneU9ZlFJ3NSWBQ5IgzwPinfojNLrXvi3w/ka6+6prJbae0wRCEN/eV025VXl3FnfMbH3iy8yTi2HtFssYFDlBs2ajTbuvaWSz0mdiNMVM13kbIzCNF0d+JHMs8YIjpBm0PavQmMalj/nvj8yfGCoYmzkAsDJMnQ76t5S6SdUM58cIYvcJWXvkOMrxG6UH2SNla50eJQx+woK87wYOnMQfCaBlpMZXPHaxMFm2/TsrSdKwcqfqp9pGF3NhDzcui42YK2NAf8rXpxwOjhvL3jmPXZtjK4HIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrnNU2qGQEe9tGqLzbT2WONPrRr/e9LuvYP0ki9izWU=;
 b=hYeQlrbhaallbAsZzApL/RwEArISrwu6cUSJjK8YObz8kjrrXx/TFucUFogt6OABLvTzHTMJihVxvm7vsIHrn4VPRXICZC7CTX5UEafiRWa5QxuGsla/diuWusiD1IDBZMZcoL5XNFSXeO0Xn/t/l3fZlKL2Vrnme77zkyTbz1vN47IVYeEhdFbiZSzz182YqHXPDY3PguMpaGQAS2Kya0/fQfj5kX3bsF0UX1rGa6PVQxjZi1mHb6W5saK9AsaDTv6zFwTpA2PBB27vYQXq+XSyuWto7cO2C6+np8jxXobi/jhv+Liy1rkisJoIqRDOaE8QHpUDt92kVOrFIWCVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrnNU2qGQEe9tGqLzbT2WONPrRr/e9LuvYP0ki9izWU=;
 b=X4rEF6TLjMZU5qZkdG2KkzlAOmf7+AV8EiULtPCPI4T/UC2Z4ZFkTTwndnF4cxWHXxo47Kf4FeNV2EN7uBTDJOSZMmXFJAt1PTUsMAam0uK6cLWHlNhhyARnsrIoGb76I/7Z5g23jcIknYgqWybOB7c03kQrsQ4g/fIoh2SxkVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SJ0PR08MB7718.namprd08.prod.outlook.com
 (2603:10b6:a03:3d0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Fri, 12 May
 2023 17:00:36 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 17:00:36 +0000
Date:   Fri, 12 May 2023 12:00:33 -0500
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
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] Input: add driver for Focaltech FTS touchscreen
Message-ID: <ZF5wsVxIK8/jjPN0@nixie71>
References: <20230415020222.216232-1-joelselvaraj.oss@gmail.com>
 <20230415020222.216232-3-joelselvaraj.oss@gmail.com>
 <ZEXr1hC+Q5Bo/3Tc@nixie71>
 <e25468f4-e3a3-bcf7-c2c0-826edb0600c2@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e25468f4-e3a3-bcf7-c2c0-826edb0600c2@gmail.com>
X-ClientProxiedBy: SN1PR12CA0055.namprd12.prod.outlook.com
 (2603:10b6:802:20::26) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SJ0PR08MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 70870987-0e90-45e8-65c1-08db530a67e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+oQQ12RRxBrB2D0Vr0/qRy1bm0YZ+Auf8r84idkpp/ay39FBX/TjDrmXZMWijzhT83QdRUJQ1EmiN2hDoeD0o5PUFQOPX0lu6OJNb1mt8C42ZjYB/qAOOTGTb/SUffazT91oseoWiYb0j0Ad3OpwG+X4qj11884WgVOMzUlBImxOD89yGxc4CLZ7UXQW/yg1FQ9qDfaeAb5nGUINcM3LVZMAOdZy7ZC4QEzd7+GO7vSzgJJGbgYqUc9mrpkv9enYHWfDGk82U0FFmpbl8Xf0AdFiNGqb0vasgkruqS+/4PfvddoEBE7wmjH9z32SFVVTnmsBSWdfBmd0U7hx1CjjO/BPT0renRPv1yQddMvGHTOIcqnWsjXixhHw+3NFGgtdq95BXgTWfU8FmrcUy8f5bLHq7Mg38VIi/qc2OPJG4HwXAba+gczVdjUeSQw90ZKOg1g82J0hlE/h02qLN9J53iuwos8CHiB+K/o8fYiPtcNvzRtU4yuZGVl8gWyGbKsm6XB+gL7u9lkdQCVaCekPpaYirkDGw3t76FG8+VNNF3PYRPwxsv67foIK3kpsByAXuOjSAklm1CwWDj98sK2evSf+JspWqz5PWddtNEjd+qK6zx7kB1Qb44O/57STKtM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39830400003)(366004)(136003)(376002)(346002)(451199021)(83380400001)(86362001)(38100700002)(6486002)(478600001)(6666004)(54906003)(2906002)(8936002)(6916009)(7416002)(66556008)(8676002)(5660300002)(66946007)(41300700001)(4326008)(33716001)(26005)(316002)(53546011)(66476007)(6506007)(186003)(6512007)(9686003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qgnslOrcozXVgLCiSnM8EzWb9r4dKctAyUCnwXy0Bgq6O7HSTymV8Wbk9Mfb?=
 =?us-ascii?Q?HQWT1B67qpMHwlQR9ssqP+i9ljM8x7sTZHE9pJ11uFdDOEQEtGiY/DJiwk+K?=
 =?us-ascii?Q?MtOOybgMTvOKM12qMJi+BMNjaEUJhLu5GDZn6PtmkXZWRue2N6lSgntduxSg?=
 =?us-ascii?Q?96Z7tbLPyWdwoZ0Zd751GelMP3GkNC39nNCQTu4c8KvHJXK/AoaIVDglIxFd?=
 =?us-ascii?Q?TJuYGwuRkH+5IEze+FxPU7tL1y7ElWC1GtVgtq+VTHdIYZ3scC5W5Huh0NdH?=
 =?us-ascii?Q?nqvR98Xczw032ctl/6/k+rzp88qljj0lGk99EYufOCv6duQqBZaCZlLl2D77?=
 =?us-ascii?Q?S8/idwa3ZyaBpSgdp257jpJpYj3+FcwWVm4zh1Iygf/zVSSYZYySEzfK+tZ0?=
 =?us-ascii?Q?k7/gEZwUgc/juAWTIfktSiHXlMIXq0Q8StK+MkMeEr8EEU+C1SuT75xpKL5z?=
 =?us-ascii?Q?MFm16TekwMsaUSgAJll06Apa4mVNc1prT81hCHQPz2jogeFJG1zmUD7Osuqq?=
 =?us-ascii?Q?r7NyYF14V+V57b2yEGwonztZ8ut/tO0cDILJUitwUHhyKDTOAq9EoIxReTnC?=
 =?us-ascii?Q?0z53LjCc3ycKjnsrlz3TNzmkJZVFTAFEWwCc6SSYJjTempjRLVYwhLWON2bK?=
 =?us-ascii?Q?MG3Gx7DwfwP1Ar25S519NcAfLRhKd3CpzRuX5P6MbELIqHmAqh9mVtFnVPCd?=
 =?us-ascii?Q?u1CmrjCYlXCoklLP+ocIQSeI4zGOYIxr9WKns0De5/K3myNR7Z4TDwR+qJS7?=
 =?us-ascii?Q?6m5mvUbqx0fFDx2C0A6va5OoS0Xg5OQORwVjKya9lpWgJtUvygw2dzpr0Pdp?=
 =?us-ascii?Q?ONkWKqrdL8nkm91SYAt8xLd8h1x3GwYmsw7HtPqIDHdMr5gJxpMaq7boHJEb?=
 =?us-ascii?Q?XFYJ7KQK+0LknVoOIThuWNiJk8LxTU4vada/RupPJSuABVq7zaOiUV563NnN?=
 =?us-ascii?Q?Sfi9mcf57IsTNtW1VUAaOxkjbe/eaJNbIRi2q/hrb2aTM72t2aUBC+QGJ8v5?=
 =?us-ascii?Q?K/6B7LXcnIUJB+ja67bD8B35hG6nLuqbMO4NaGwjdlVFJcXBI5SkM5/4iHwq?=
 =?us-ascii?Q?pUBgUbbxOmyc2jxzYbHIhMNrnJEyYhHNBByWZfDiU1sdZCkalpooDnhlhTrJ?=
 =?us-ascii?Q?kiCPC69jsPZpwTDlqM0rdsNYrbAhzRxdIVJpEktW6lRsCOYyFkNdeI+FP4i0?=
 =?us-ascii?Q?EsV16tUwTuXJrrmhaxEcRw7BpZBm/XqCPqd2pxPXpeh/Pw1ymwduXaBH5H7Y?=
 =?us-ascii?Q?1Q9pihotDbSvz51VgFc1T3aqtfJLfhYpYZmMeW9ZDa89PLRcNmLVvUjkgFgk?=
 =?us-ascii?Q?DWtbHD1WGxQwWT0cvAnjeg9SWgBmT6Sx04eWMgxZc2tWcUFU1/i22TXQXGVQ?=
 =?us-ascii?Q?sXq10g3ZSEi9PJ+bD1JWx2egkzccWSCeQxafHKuo0P2dV/UAc9SG5t3qI1AS?=
 =?us-ascii?Q?uaWx1okK7FL+LMNUw8EZMVPHS6TwstDiYEMoctv0MyCl6zT91v4Q02x1Jnhe?=
 =?us-ascii?Q?Hsv7fImsMaL+gCqft1iWe/qmmZwwK6ZpZ1QcqwftKMF33o7u0zbBqybZgQqF?=
 =?us-ascii?Q?C2Tt6sdopviGdcSPnBjK2DkuyrZLSdZAuVgS4+A5?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70870987-0e90-45e8-65c1-08db530a67e5
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 17:00:36.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwLHFMOWfCgAAMXs5fUy0ZR2bBxz0qKHW/b5MujNGIOQjy0wnbQ3vLrPu37FoYyZ4jYYGnuk/XZXRjBZymp/yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB7718
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Thu, May 11, 2023 at 07:43:28PM -0500, Joel Selvaraj wrote:
> Hi Jeff LaBundy,
> 
> On 4/23/23 21:39, Jeff LaBundy wrote:
> > Hi Joel,
> > 
> > Great work so far! It's coming along nicely. Please find my latest
> > feedback below.
> 
> Sorry for the late reply, university semester end got me hooked up.
> I have a sad kind of good news... As pointed out by Hans de Goede, the
> edt-ft5x06 driver works out of the box for the fts8719 touchscreen in my
> device. So I think this patch series is no longer needed. I did have a look
> at the driver once when working on this patch series, but it looked
> different/not compatible at that time. After mentioned by Hans de Goede, I
> had a more closer look and the main touch buffer handling seems to be the
> same.
> 
> I am sorry as we put some considerable time in this patch series. I should
> have noted more carefully. Thank you though as I learnt things working on
> this patch series.

There is absolutely no need to apologize; the review process is just as
informative for the reviewer as it is the reviewee. The important thing
is that the most optimal solution lands. "Less code is the best code" :)

> 
> I guess I will send a different patch to add the compatible data to the
> existing edt-ft5x06 driver and dts changes to include that driver to my
> device.

Sounds great.

> 
> > On Fri, Apr 14, 2023 at 09:02:19PM -0500, Joel Selvaraj wrote:
> > > The Focaltech FTS driver supports several variants of focaltech
> > > touchscreens found in ~2018 era smartphones including variants found on
> > > the PocoPhone F1 and the SHIFT6mq which are already present in mainline.
> > > This driver is loosely based on the original driver from Focaltech
> > > but has been simplified and largely reworked.
> > > 
> > > Co-developed-by: Caleb Connolly <caleb@connolly.tech>
> > > Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> > > Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
> > > ---
> > >   MAINTAINERS                                   |   8 +
> > >   drivers/input/touchscreen/Kconfig             |  12 +
> > >   drivers/input/touchscreen/Makefile            |   1 +
> > >   drivers/input/touchscreen/focaltech_fts5452.c | 432 ++++++++++++++++++
> > >   4 files changed, 453 insertions(+)
> > >   create mode 100644 drivers/input/touchscreen/focaltech_fts5452.c
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 7ec4ce64f66d..1a3ea61e1f52 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -8028,6 +8028,14 @@ L:	linux-input@vger.kernel.org
> > >   S:	Maintained
> > >   F:	drivers/input/joystick/fsia6b.c
> > > +FOCALTECH FTS5452 TOUCHSCREEN DRIVER
> > > +M:	Joel Selvaraj <joelselvaraj.oss@gmail.com>
> > > +M:	Caleb Connolly <caleb@connolly.tech>
> > > +L:	linux-input@vger.kernel.org
> > > +S:	Maintained
> > > +F:	Documentation/devicetree/bindings/input/touchscreen/focaltech,fts5452.yaml
> > > +F:	drivers/input/touchscreen/focaltech_fts5452.c
> > > +
> > >   FOCUSRITE SCARLETT GEN 2/3 MIXER DRIVER
> > >   M:	Geoffrey D. Bennett <g@b4.vu>
> > >   L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> > > diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> > > index 1feecd7ed3cb..11af91504969 100644
> > > --- a/drivers/input/touchscreen/Kconfig
> > > +++ b/drivers/input/touchscreen/Kconfig
> > > @@ -388,6 +388,18 @@ config TOUCHSCREEN_EXC3000
> > >   	  To compile this driver as a module, choose M here: the
> > >   	  module will be called exc3000.
> > > +config TOUCHSCREEN_FOCALTECH_FTS5452
> > > +	tristate "Focaltech FTS Touchscreen"
> > > +	depends on I2C
> > > +	help
> > > +	  Say Y here to enable support for I2C connected Focaltech FTS
> > > +	  based touch panels, including the 5452 and 8917 panels.
> > 
> > This language is a bit misleading, as it seems to suggest three or more
> > models are supported. It seems the title should simply be "FocalTech
> > FTS5452 touchscreen controller" with the description as "...FocalTech
> > FTS5452 and compatible touchscreen controllers."
> > 
> > As more are found to be compatible (e.g. FTS8917), the compatible strings
> > can simply be appended.
> > 
> > > +
> > > +	  If unsure, say N.
> > > +
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called focaltech_fts.
> > > +
> > >   config TOUCHSCREEN_FUJITSU
> > >   	tristate "Fujitsu serial touchscreen"
> > >   	select SERIO
> > > diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> > > index 159cd5136fdb..47d78c9cff21 100644
> > > --- a/drivers/input/touchscreen/Makefile
> > > +++ b/drivers/input/touchscreen/Makefile
> > > @@ -45,6 +45,7 @@ obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
> > >   obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
> > >   obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+= egalax_ts_serial.o
> > >   obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
> > > +obj-$(CONFIG_TOUCHSCREEN_FOCALTECH_FTS5452)	+= focaltech_fts5452.o
> > >   obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
> > >   obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
> > >   obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
> > > diff --git a/drivers/input/touchscreen/focaltech_fts5452.c b/drivers/input/touchscreen/focaltech_fts5452.c
> > > new file mode 100644
> > > index 000000000000..abf8a2f271ca
> > > --- /dev/null
> > > +++ b/drivers/input/touchscreen/focaltech_fts5452.c
> > > @@ -0,0 +1,432 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * FocalTech touchscreen driver.
> > > + *
> > > + * Copyright (c) 2010-2017, FocalTech Systems, Ltd., all rights reserved.
> > > + * Copyright (C) 2018 XiaoMi, Inc.
> > > + * Copyright (c) 2021 Caleb Connolly <caleb@connolly.tech>
> > > + * Copyright (c) 2023 Joel Selvaraj <joelselvaraj.oss@gmail.com>
> > > + */
> 
> [skip]
> 
> > > +static const struct of_device_id fts_of_match[] = {
> > > +	{ .compatible = "focaltech,fts5452", .data = &fts5452_chip_data },
> > > +	{ .compatible = "focaltech,fts8719", .data = &fts8719_chip_data },
> > > +	{ /* sentinel */ }
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(of, fts_of_match);
> > > +
> > > +static struct i2c_driver fts_ts_driver = {
> > > +	.probe_new = fts_ts_probe,
> > > +	.id_table = fts_i2c_id,
> > > +	.driver = {
> > > +		.name = FTS_DRIVER_NAME,
> > > +		.pm = pm_sleep_ptr(&fts_dev_pm_ops),
> > > +		.of_match_table = fts_of_match,
> > > +	},
> > > +};
> > > +module_i2c_driver(fts_ts_driver);
> > > +
> > > +MODULE_AUTHOR("Joel Selvaraj <joelselvaraj.oss@gmail.com>");
> > > +MODULE_AUTHOR("Caleb Connolly <caleb@connolly.tech>");
> > > +MODULE_DESCRIPTION("Focaltech Touchscreen Driver");
> > 
> > Nit: mixing 'FocalTech' and 'Focaltech' throughout.
> > 
> > > +MODULE_LICENSE("GPL");
> > > -- 
> > > 2.40.0
> > > 
> > 
> > Kind regards,
> > Jeff LaBundy
> 
> Thank you,
> Joel Selvaraj

Kind regards,
Jeff LaBundy
