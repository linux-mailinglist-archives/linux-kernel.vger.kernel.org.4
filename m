Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17E773E0FD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjFZNr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFZNr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:47:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA5397;
        Mon, 26 Jun 2023 06:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpowjqunLZeZLXHRVu++spx5nCA8g6BzXAjyJ4zB+DtUwPL75y5wUA0B9tnAa3w0SADg57hRhM9JagV5AvGiP8dRNupspMjy6RP8uXmZa37jotCKvAc+uHjgeqqgctKjN0IpdzhD6qSL1VT6a1bp5lE8rWxfZWbHycwzLa8W5wubn4S4lqtPANTbtRLmFE5dFs+ONFvwbihIwRQXEKsTGRSP+gcD7iAoY4AncircIReJv6j5G3X4KVjxBx0JHrO2wF2GD+01Vbl9TtAR0gxZFhm0/S3PWmL7q2lE1j99LEgJU2WzvctBdqHZSuhRa5CynAkfXPEx58ZZLFKdScQwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdEwyepmhavtqgzfFdu+hnk15YgGmRIIZsWsVfvEf84=;
 b=EzOrRhDoU1Bvx1kpOoNCR2hffnNbMjSd4WTY8ArFJkCdkYNsHgKx1f2W/ekGn90C9bm2FTpK5yszjNIgTSi/yg+iYDY+xduDQuBLA41w94Q5Iq1Ym8qwfYDE/kroZq7ZlbUHBuaKxSCzLqev4XVvoDN5zNJYlxM+EF6B8K2kwrid9fiTfnF7g1i8iA1XvStgaxu3M8cS0xqQdl5SDDBh5JTeD6I/BB9HFDGJHauEzxCP9Yj+8JuPN4F6T3nm30gyyMgoR9M1W8PbrgQNgthbzMzYWp811NfkbwtZZe4M1Ry1rU4uQl8WtNNfuFPYbNQpyRDggJPNyjLbIOAYmLksug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdEwyepmhavtqgzfFdu+hnk15YgGmRIIZsWsVfvEf84=;
 b=CCM9q8NK/gdk3N6bNZEp+b7Y8IW1d+2044GqLeOjCJp0z+NVrVV+E6Aa0+cUgWpIKKft6K0AZGmfziHtwOJ9WHrlCMa3UaPD2a7+7G94gcht/Dvng1eXtRpWw3ytAfDoPlw6VsDsSfaMO0P8K6iWSy44J+xmg7UWApmoeGBYTeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by MN2PR08MB6351.namprd08.prod.outlook.com
 (2603:10b6:208:1aa::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 13:47:48 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2%6]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 13:47:48 +0000
Date:   Mon, 26 Jun 2023 08:47:40 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] Input: ts-overlay - Add touchscreen overlay
 object handling
Message-ID: <ZJmW/KOCJF25Z79t@nixie71>
References: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v3-1-b4fb7fc4bab7@wolfvision.net>
 <ZJj5VcHvfMMWMRx8@nixie71>
 <89cbb534-9371-c2be-0bad-776b51476ce8@wolfvision.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89cbb534-9371-c2be-0bad-776b51476ce8@wolfvision.net>
X-ClientProxiedBy: SA9PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:806:28::12) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|MN2PR08MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbc596b-9c72-42b5-50f5-08db764bed55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8kj9lxXoHL5P9rSiRCvdxrmeN7Q7VPATA7UrEqmHiIzQRJFYUPJERwtgUQz3wMkDhUK1CUshrNhTI9OrmGeflxQjBXh6dgRSv+tpuChSWiXxemqHkvca1V/Og76JaplAOx1/CSuJHwk/FeFoKMkfYNxEU0b7fiuGt22JrTE2+YfoD13VjHVal4TFyI7Cxw20T7+xh+N+I7rYzyipMwHdilok/jf1J4cbmcX9hKRumOqJfLSNMxPRVMEGL5qtXcaUS7z8Z0AISVHgGW5/FAaJc6kUOyOfoc2de5siIRH2WO6+Li2Xa7KVwvHrlJg2oDVlp5/dxyOV84b4BipnmpANKaP6cdUJDw4fofnY/kxBYdFLnkZArJg+n3h8VlfyGcNlB+L6xql9rr97hkg2qMA8Ipl6JCFdiWtR8xTR7B/H2qmAXJjQORxmkVUfnISKrTTVLGwQ5F4v7zqvyg6u+OzjtUHnNkGtnZOWwwBl1mjr9yR22zChKlFZqEzb0VT9o6Qv/zI/VonDAP6KoP95QavW1tlyPIWXdIcsDN73/W4occ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(376002)(346002)(366004)(39830400003)(451199021)(966005)(6666004)(6486002)(478600001)(54906003)(53546011)(2906002)(9686003)(6512007)(26005)(186003)(30864003)(6506007)(33716001)(66476007)(66556008)(66946007)(7416002)(316002)(8676002)(41300700001)(5660300002)(8936002)(38100700002)(6916009)(4326008)(86362001)(83380400001)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UOEXJ8mcTwfhujT1sU+joSL6BArgkGUdnTaiSsyXchlIumGMvsWsepMyOKxr?=
 =?us-ascii?Q?6g7COOXWNGhqmFG8Z/0yMVCFRPXDBKvYB/zJJvIJkUDRzB00oN5m5eeVX/9x?=
 =?us-ascii?Q?gac7cK2VoOdOviX5etwG9DlOiZHgYKAU7iNNcLYImkShbb3m8u/5d7t/Ocm2?=
 =?us-ascii?Q?Z4e3N0pQoEsIQddb1ADq6xQlsOdWj283REcWWZnjR3Q1p36ngcdBTYVVhx2n?=
 =?us-ascii?Q?OtlmtVjZKGbha3vINjecTw515MYhy95Lt10ZZosRxITXRKwV7MI8jHx90gnp?=
 =?us-ascii?Q?1cvycHkYnIubtj2cWc7Yno2hX4OqP9kjZqn+7uJ8YVQUSP6mIH+QT35tSpVN?=
 =?us-ascii?Q?/X6vvdJR5pqF/b5iccxiSxx/koaNy7I64A7HLKeS1/ukMVuOXoeiCJVI0+pk?=
 =?us-ascii?Q?IxyR9jgz/G1+YqGWp7sopzDNRViEJPq3OCidVQh+tRWuPeafQuEe9BCnorp1?=
 =?us-ascii?Q?MorhHJhl5cWJwOfxJdVWXZg7VPmzhgFrSuHjEhRNgF+Irti4pCfnwEriHy9n?=
 =?us-ascii?Q?BAfsl6tmAPKIFFCYxydKybZJp9cQMeA/rWY+oVRDic/XhDYW2K7x0pyy5NMp?=
 =?us-ascii?Q?MGzRozgITxB5jDFqQBIaW+DuVTAxVCTInBpHnq4gY2axmDimcPFOOv5sKlJg?=
 =?us-ascii?Q?3JA1YgW4La866Zoybk8tLhApYuMnOXoV8L+GIgkiFgGBCePCAU8KeZ15/L+/?=
 =?us-ascii?Q?vZPEDG2lGsTZBpO9WKrv7fe/HRWeUL0vlCBabREefBSD+IOp3VGkpcCFwhB2?=
 =?us-ascii?Q?oWFNrne1Go8mhCjaE+bVqLfvRJfpa9Q4sg4Dn2gVe1DYaWTZRVreiDN0aq92?=
 =?us-ascii?Q?9XzMUUGGJxS6pgDGYoKjyUIHekwm2/K4zlp/A+9h29z8v/cdGssItUo4t//n?=
 =?us-ascii?Q?e9fU2glS3NwNIYX59ZcnrZfjL1U8/FJb+i6QWNCqMspkX2O993swf92QsEWh?=
 =?us-ascii?Q?AVYO+so8uNqrLREOYOtEXaPH28ICMatfObrZmAWqoATUj90gMxQIy/FgQmm6?=
 =?us-ascii?Q?snCJADh8F6GiFlgeYMCmM0ycMW5YYhShogoDcLzhgsi96EMKHsQ/CL7mryfY?=
 =?us-ascii?Q?pTz+X6MyuECP1ip6wiNJKEcdUABte1adjxryHcfkk+12emieoYt/IuR1f7LG?=
 =?us-ascii?Q?qENmP8EVJ+EkohU12XyUx+yynm5kp9VVuTmLde46L9YlxBOqZDJKZrdHf+M+?=
 =?us-ascii?Q?bjDwC4eFQNR7VGxE11P/YSQhfAUUAtWgD8V3VoOEmVAnBdxIefQ1Dtez+pKH?=
 =?us-ascii?Q?2NgPzsLNufPNqPZsTOSPAE/tGbL235jOu0aunXDBe0Ewo3Y2vYJttGdKNqYu?=
 =?us-ascii?Q?dfsm4MDxT6OHJI3I+TrRWMXijl8jHPxO2+k4xphUBsKmSnL9ldNwhPD8B1gp?=
 =?us-ascii?Q?MGNTE/PP5aJ4PVK57e2Mgf045DwZLB0Q8QjY+PB6gkuW+MwT80MUbhdMxL+y?=
 =?us-ascii?Q?6q7nAk+FG0Fubo3BE+15kJ32b8lVVnfYOumiyDJz0pCG50ajIYxuHzDf5UNT?=
 =?us-ascii?Q?3FoQvm0f8ZK/+PpKpFe5ozZ/jVwSb+odt/3yrL0Wdd5s/MDKJWixZrAHxQmQ?=
 =?us-ascii?Q?nFZq/dCM7B7SjVaHXcPDbLHqO4N6zZIBv6cM8HGU?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbc596b-9c72-42b5-50f5-08db764bed55
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:47:48.2428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZgcVYkuhzBO1Mm8NCrYELJx/0xuSMAewitbMWkjjruEJeBqRiLlVNQjBk1TOlJTo02qnTO0BkoZybaroV1DVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB6351
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Mon, Jun 26, 2023 at 12:31:21PM +0200, Javier Carrasco wrote:
> Hi Jeff,
> 
> On 26.06.23 04:35, Jeff LaBundy wrote:
> > Hi Javier,
> > 
> > On Fri, Jun 16, 2023 at 09:28:51AM +0200, Javier Carrasco wrote:
> >> Some touchscreens provide mechanical overlays with different objects
> >> like buttons or clipped touchscreen surfaces.
> >>
> >> In order to support these objects, add a series of helper functions
> >> to the input subsystem to transform them into overlay objects via
> >> device tree nodes.
> >>
> >> These overlay objects consume the raw touch events and report the
> >> expected input events depending on the object properties.
> >>
> >> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> >> ---
> > 
> > Excellent work; it's great to see this series move along.
> > 
> >>  MAINTAINERS                            |   7 +
> >>  drivers/input/touchscreen/Kconfig      |   9 +
> >>  drivers/input/touchscreen/Makefile     |   1 +
> >>  drivers/input/touchscreen/ts-overlay.c | 356 +++++++++++++++++++++++++++++++++
> >>  include/linux/input/ts-overlay.h       |  43 ++++
> >>  5 files changed, 416 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 7e0b87d5aa2e..db9427926a4c 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -21434,6 +21434,13 @@ W:	https://github.com/srcres258/linux-doc
> >>  T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
> >>  F:	Documentation/translations/zh_TW/
> >>  
> >> +TOUCHSCREEN OVERLAY OBJECTS
> >> +M:	Javier Carrasco <javier.carrasco@wolfvision.net>
> >> +L:	linux-input@vger.kernel.org
> >> +S:	Maintained
> >> +F:	drivers/input/touchscreen/ts-overlay.c
> >> +F:	include/linux/input/ts-overlay.h
> >> +
> >>  TTY LAYER
> >>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>  M:	Jiri Slaby <jirislaby@kernel.org>
> >> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> >> index 143ff43c67ae..8382a4d68326 100644
> >> --- a/drivers/input/touchscreen/Kconfig
> >> +++ b/drivers/input/touchscreen/Kconfig
> >> @@ -1388,4 +1388,13 @@ config TOUCHSCREEN_HIMAX_HX83112B
> >>  	  To compile this driver as a module, choose M here: the
> >>  	  module will be called himax_hx83112b.
> >>  
> >> +config TOUCHSCREEN_TS_OVERLAY
> >> +	bool "Touchscreen Overlay Objects"
> >> +	help
> >> +	  Say Y here if you are using a touchscreen driver that supports
> >> +	  printed overlays with keys or a clipped touchscreen area.
> >> +
> >> +	  Should be selected by the touchscren drivers that support
> >> +	  this feature.
> >> +
> >>  endif
> >> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> >> index 159cd5136fdb..f554826706ff 100644
> >> --- a/drivers/input/touchscreen/Makefile
> >> +++ b/drivers/input/touchscreen/Makefile
> >> @@ -117,3 +117,4 @@ obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_FW)	+= raspberrypi-ts.o
> >>  obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
> >>  obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
> >>  obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)	+= himax_hx83112b.o
> >> +obj-$(CONFIG_TOUCHSCREEN_TS_OVERLAY)	+= ts-overlay.o
> > 
> > It seems like this feature is useful for any two-dimensional touch surface
> > (e.g. trackpads) and not just touchscreens. For that reason, the touchscreen
> > helpers in touchscreen.c were moved out of input/touchscreen and into input/
> > such that they are not guarded by CONFIG_INPUT_TOUCHSCREEN. A growing number
> > of devices in input/misc are taking advantage of these.
> > 
> > Therefore, I think this feature should follow suit and be available to any
> > input device as is the case for touchscreen.c. As written, the newly updated
> > binding is misleading because one may believe that any device that includes
> > touchscreen.yaml can define an overlay child, but the code does not currently
> > support this.
> > 
> > To that end, it seems like touch-overlay would be a more descriptive name as
> > well. I understand that the name has changed once already, so hopefully this
> > feedback is not too annoying :)
> > 
> changing names is no problem at all as long as it makes the feature more
> comprehensible and/or takes more suitable devices into account, which
> would be the case. So I will move the code from touchscreen to input and
> I will update the names and descriptions to make them more generic.
> 
> I guess then I will need to move the properties to a separate binding
> for this feature because it will not be an addition to the touchscreen
> bindings anymore, right?

Technically this feature was never bound to touchscreen.yaml in the first place.
touchscreen.yaml defines scalar properties under a parent input device; your new
binding defines a child node and subsequent properties under the same, or another
parent input device.

That said, it is highly unlikely that one would use your feature without also
using the properties from touchscreen.yaml. It is perfectly fine in my opinion,
and perhaps more convenient, to define the overlay child in touchscreen.yaml as
you have done so that binding authors need not reference two files.

I do agree that it seems more natural for code living in input to be bound by
bindings in dt-bindings/input and not dt-bindings/input/touchscreen/, but there
was push back when the same question came up for touchscreen.yaml [1] some time
ago.

[1] https://patchwork.kernel.org/patch/12042037/

> 
> >> diff --git a/drivers/input/touchscreen/ts-overlay.c b/drivers/input/touchscreen/ts-overlay.c
> >> new file mode 100644
> >> index 000000000000..7afa77d86c1f
> >> --- /dev/null
> >> +++ b/drivers/input/touchscreen/ts-overlay.c
> >> @@ -0,0 +1,356 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + *  Helper functions for overlay objects on touchscreens
> >> + *
> >> + *  Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
> >> + */
> >> +
> >> +#include <linux/property.h>
> >> +#include <linux/input.h>
> >> +#include <linux/input/mt.h>
> >> +#include <linux/module.h>
> >> +#include <linux/input/ts-overlay.h>
> >> +
> >> +enum ts_overlay_valid_objects {
> >> +	TOUCHSCREEN,
> >> +	BUTTON,
> > 
> > Please namespace these, i.e. TOUCH_OVERLAY_*.
> > 
> >> +};
> >> +
> >> +static const char *const ts_overlay_names[] = {
> >> +	[TOUCHSCREEN] = "overlay-touchscreen",
> > 
> > I'm a little confused why we need new code for this particular function; it's
> > what touchscreen-min-x/y and touchscreen-size-x/y were meant to define. Why
> > can't we keep using those?
> > 
> According to the bindings, touchscreen-min-x/y define the minimum
> reported values, but the overlay-touchscreen is actually setting a new
> origin. Therefore I might be misusing those properties. On the other
> hand touchscreen-size-x/y would make more sense, but I also considered
> the case where someone would like to describe the real size of the
> touchscreen outside of the overlay node as well as the clipped size
> inside the node. In that case using the same property twice would be
> confusing.
> So in the end I thought that the origin/size properties are more precise
> and applicable for all objects and not only the overlay touchscreen.
> These properties are needed for the buttons anyways and in the future
> more overlay would use the same properties.

Ah, I understand now. touchscreen-min-x/y define the lower limits of the axes
reported to input but they don't move the origin. I'm aligned with the reason
to introduce this function.

This does beg the question as to whether we need two separate types of children
and related parsing code. Can we not simply have one overlay definition, and
make the decision as to whether we are dealing with a border or virtual button
based on whether 'linux,code' is present?

> 
> >> +	[BUTTON] = "overlay-buttons",
> >> +};
> >> +
> >> +struct ts_overlay_shape {
> >> +	u32 x_origin;
> >> +	u32 y_origin;
> >> +	u32 x_size;
> >> +	u32 y_size;
> >> +};
> >> +
> >> +struct ts_overlay_button {
> >> +	struct ts_overlay_shape shape;
> >> +	u32 key;
> >> +	bool pressed;
> >> +	int slot;
> >> +};
> >> +
> >> +static int ts_overlay_get_shape_properties(struct fwnode_handle *child_node,
> >> +					   struct ts_overlay_shape *shape)
> >> +{
> >> +	int rc;
> > 
> > In input, the common practice is to use 'error' for return values that are either
> > zero or negative. The reasoning is because the variable quite literally represents
> > an error, or lack thereof. And then:
> > 
> > 	error = ...
> > 	if (error)
> > 		return error;
> > 
> >> +
> >> +	rc = fwnode_property_read_u32(child_node, "x-origin", &shape->x_origin);
> >> +	if (rc < 0)
> >> +		return rc;
> > 
> > It seems like all of these properties are required; if so, please update the
> > binding to make this clear.
> > 
> > If the binding is correct and these properties are in fact optional, then you
> > must evaluate fwnode_property_read_u32() against -EINVAL.
> > 
> If I end up writing new bindings for this feature, it will be more clear
> what is required and what not because I will not be part only of the
> touchscreen anymore. These properties will be required.

The question of whether to split the overlay child definition from touchscreen.yaml
is orthogonal to this point. If the code fails in the absence of these properties,
then you must add a "required:" heading within the overlay child node definition to
call out these properties.

> >> +
> >> +	rc = fwnode_property_read_u32(child_node, "y-origin", &shape->y_origin);
> >> +	if (rc < 0)
> >> +		return rc;
> >> +
> >> +	rc = fwnode_property_read_u32(child_node, "x-size", &shape->x_size);
> >> +	if (rc < 0)
> >> +		return rc;
> >> +
> >> +	rc = fwnode_property_read_u32(child_node, "y-size", &shape->y_size);
> >> +	if (rc < 0)
> >> +		return rc;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int ts_overlay_get_button_properties(struct device *dev,
> >> +					    struct fwnode_handle *child_node,
> >> +					    struct ts_overlay_button *btn)
> >> +{
> >> +	struct fwnode_handle *child_btn;
> >> +	int rc;
> >> +	int j = 0;
> >> +
> >> +	fwnode_for_each_child_node(child_node, child_btn) {
> >> +		rc = ts_overlay_get_shape_properties(child_btn, &btn[j].shape);
> >> +		if (rc < 0)
> >> +			goto button_prop_cleanup;
> >> +
> >> +		rc = fwnode_property_read_u32(child_btn, "linux,code",
> >> +					      &btn[j].key);
> >> +		if (rc < 0)
> >> +			goto button_prop_cleanup;
> > 
> > The binding needs to list this property as required, too.
> > 
> Do you mean "linux,code"? It is already listed with the same pattern
> that some other bindings use:
> 
> linux,code: true
> 
> Is that not right? I did not want to redefine an existing property that
> other bindings already make use of.

These are separate things. You must additionally list 'linux,code' under a
'required:' heading if the code fails without the property defined. If you
adopt the idea above to decide whether we are dealing with a border or button
based on the presence of this property, then it goes back to being optional
of course.

> >> +
> >> +		dev_info(dev, "Added button at (%u, %u), size %ux%u, code=%u\n",
> >> +			 btn[j].shape.x_origin, btn[j].shape.y_origin,
> >> +			 btn[j].shape.x_size, btn[j].shape.y_size, btn[j].key);
> > 
> > This seems like a dev_dbg() to me.
> > 
> >> +		j++;
> >> +	}
> >> +
> >> +	return 0;
> >> +
> >> +button_prop_cleanup:
> >> +	fwnode_handle_put(child_btn);
> >> +	return rc;
> >> +}
> >> +
> >> +void ts_overlay_set_button_caps(struct ts_overlay_map *map,
> >> +				struct input_dev *dev)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i = 0; i < map->button_count; i++)
> >> +		input_set_capability(dev, EV_KEY, map->buttons[i].key);
> >> +}
> >> +EXPORT_SYMBOL(ts_overlay_set_button_caps);
> > 
> > I don't see a need to expose this function and require participating drivers
> > to call it; we should just have one over-arching function for processing the
> > overlay(s), akin to touchscreen_parse_properties but for the button input
> > device in case the driver separates the button and touchscreen input devices.
> > 
> > That one function would then be responsible for parsing the overlay(s) and
> > calling input_set_capability() on each button.
> > 
> >> +
> >> +static int ts_overlay_count_buttons(struct device *dev)
> >> +{
> >> +	struct fwnode_handle *child_node;
> >> +	struct fwnode_handle *child_button;
> > 
> > These names confused me; they're both children, but only the second is aptly
> > named. How about child_overlay and child_button, or perhaps overlay_node and
> > button_node?
> > 
> >> +	int count = 0;
> >> +
> >> +	child_node = device_get_named_child_node(dev, ts_overlay_names[BUTTON]);
> >> +	if (!child_node)
> >> +		return 0;
> >> +
> >> +	fwnode_for_each_child_node(child_node, child_button)
> >> +		count++;
> >> +	fwnode_handle_put(child_node);
> >> +
> >> +	return count;
> >> +}
> >> +
> >> +static int ts_overlay_map_touchscreen(struct device *dev,
> >> +				      struct ts_overlay_map *map)
> >> +{
> >> +	struct fwnode_handle *child;
> > 
> > Same here; there are two layers of children, so please use more descriptive
> > variable names.
> > 
> >> +	int rc = 0;
> >> +
> >> +	child = device_get_named_child_node(dev, ts_overlay_names[TOUCHSCREEN]);
> >> +	if (!child)
> >> +		goto touchscreen_ret;
> > 
> > I don't think we need a label here; just return 0 directly.
> > 
> >> +
> >> +	map->touchscreen =
> >> +		devm_kzalloc(dev, sizeof(*map->touchscreen), GFP_KERNEL);
> >> +	if (!map->touchscreen) {
> >> +		rc = -ENOMEM;
> >> +		goto touchscreen_handle;
> >> +	}
> >> +	rc = ts_overlay_get_shape_properties(child, map->touchscreen);
> >> +	if (rc < 0)
> >> +		goto touchscreen_free;
> >> +
> >> +	map->overlay_touchscreen = true;
> >> +	dev_info(dev, "Added overlay touchscreen at (%u, %u), size %u x %u\n",
> >> +		 map->touchscreen->x_origin, map->touchscreen->y_origin,
> >> +		 map->touchscreen->x_size, map->touchscreen->y_size);
> > 
> > dev_dbg()
> > 
> >> +
> >> +	rc = 0;
> > 
> > rc (error) can only be zero if we have gotten this far; I don't see a need
> > to assign it here.
> > 
> >> +	goto touchscreen_handle;
> > 
> > Please think about whether this can be reorganized to prevent jumping over
> > small bits of code; I found it hard to follow. Maybe one or more tasks can
> > be offloaded to a helper function?
> > 
> >> +
> >> +touchscreen_free:
> >> +	devm_kfree(dev, map->touchscreen);
> > 
> > This set off a red flag; it's unclear that it's necessary. Regardless of
> > whether the participating driver is smart enough to bail during probe()
> > if the overlay parsing fails, or it happily continues, this memory will
> > get freed when the driver tied to 'dev' is torn down.
> > 
> > Calling devm_kfree() is generally limited to special cases where you are
> > dynamically reallocating memory at runtime. In case I have misunderstood
> > the intent, please let me know.
> > 
> Would devm_kfree() not free the memory immediately if the parsing fails,
> making it available for any process instead of waiting until the driver
> is torn down, which might never happen? Otherwise that chunk of memory
> will not be accessible even though it is useless because the operation
> failed, right? Or am I missing something?

If the participating driver does not immediately fail to probe (and hence
free all of its device-managed resources) upon failure to parse this or any
other required properties, that is a bug in that driver.

> >> +touchscreen_handle:
> >> +	fwnode_handle_put(child);
> >> +touchscreen_ret:
> >> +	return rc;
> >> +}
> >> +
> >> +static int ts_overlay_map_buttons(struct device *dev,
> >> +				  struct ts_overlay_map *map,
> >> +				  struct input_dev *input)
> >> +{
> >> +	struct fwnode_handle *child;
> >> +	u32 button_count;
> >> +	int rc = 0;
> >> +
> >> +	button_count = ts_overlay_count_buttons(dev);
> >> +	if (button_count) {
> >> +		map->buttons = devm_kcalloc(dev, button_count,
> >> +					    sizeof(*map->buttons), GFP_KERNEL);
> >> +		if (!map->buttons) {
> >> +			rc = -ENOMEM;
> >> +			goto map_buttons_ret;
> >> +		}
> >> +		child = device_get_named_child_node(dev,
> >> +						    ts_overlay_names[BUTTON]);
> >> +		if (unlikely(!child))
> >> +			goto map_buttons_free;
> >> +
> >> +		rc = ts_overlay_get_button_properties(dev, child, map->buttons);
> >> +		if (rc < 0)
> >> +			goto map_buttons_free;
> >> +
> >> +		map->button_count = button_count;
> >> +	}
> >> +
> >> +	return 0;
> >> +
> >> +map_buttons_free:
> >> +	devm_kfree(dev, map->buttons);
> >> +map_buttons_ret:
> >> +	return rc;
> >> +}
> >> +
> >> +static bool ts_overlay_defined_objects(struct device *dev)
> >> +{
> >> +	struct fwnode_handle *child;
> >> +	int i;
> >> +
> >> +	for (i = 0; i < ARRAY_SIZE(ts_overlay_names); i++) {
> >> +		child = device_get_named_child_node(dev, ts_overlay_names[i]);
> >> +		if (child) {
> >> +			fwnode_handle_put(child);
> >> +			return true;
> >> +		}
> >> +		fwnode_handle_put(child);
> >> +	}
> >> +
> >> +	return false;
> >> +}
> >> +
> >> +struct ts_overlay_map *ts_overlay_map_objects(struct device *dev,
> >> +					      struct input_dev *input)
> >> +{
> >> +	struct ts_overlay_map *map = NULL;
> >> +	int rc;
> >> +
> >> +	if (!ts_overlay_defined_objects(dev))
> >> +		return NULL;
> >> +
> >> +	map = devm_kzalloc(dev, sizeof(*map), GFP_KERNEL);
> >> +	if (!map) {
> >> +		rc = -ENOMEM;
> >> +		goto objects_err;
> >> +	}
> >> +	rc = ts_overlay_map_touchscreen(dev, map);
> >> +	if (rc < 0)
> >> +		goto objects_free;
> >> +
> >> +	rc = ts_overlay_map_buttons(dev, map, input);
> >> +	if (rc < 0)
> >> +		goto objects_free;
> >> +
> >> +	return map;
> >> +
> >> +objects_free:
> >> +	devm_kfree(dev, map);
> >> +objects_err:
> >> +	return ERR_PTR(rc);
> >> +}
> >> +EXPORT_SYMBOL(ts_overlay_map_objects);
> >> +
> >> +void ts_overlay_get_touchscreen_abs(struct ts_overlay_map *map, u16 *x, u16 *y)
> >> +{
> >> +	*x = map->touchscreen->x_size - 1;
> >> +	*y = map->touchscreen->y_size - 1;
> >> +}
> >> +EXPORT_SYMBOL(ts_overlay_get_touchscreen_abs);
> >> +
> >> +static bool ts_overlay_shape_event(struct ts_overlay_shape *shape, u32 x, u32 y)
> >> +{
> >> +	if (!shape)
> >> +		return false;
> >> +
> >> +	if (x >= shape->x_origin && x < (shape->x_origin + shape->x_size) &&
> >> +	    y >= shape->y_origin && y < (shape->y_origin + shape->y_size))
> >> +		return true;
> >> +
> >> +	return false;
> >> +}
> >> +
> >> +static bool ts_overlay_touchscreen_event(struct ts_overlay_shape *touchscreen,
> >> +					 u32 *x, u32 *y)
> >> +{
> >> +	if (ts_overlay_shape_event(touchscreen, *x, *y)) {
> >> +		*x -= touchscreen->x_origin;
> >> +		*y -= touchscreen->y_origin;
> >> +		return true;
> >> +	}
> >> +
> >> +	return false;
> >> +}
> >> +
> >> +bool ts_overlay_mapped_touchscreen(struct ts_overlay_map *map)
> >> +{
> >> +	if (!map || !map->overlay_touchscreen)
> >> +		return false;
> >> +
> >> +	return true;
> >> +}
> >> +EXPORT_SYMBOL(ts_overlay_mapped_touchscreen);
> >> +
> >> +bool ts_overlay_mapped_buttons(struct ts_overlay_map *map)
> >> +{
> >> +	if (!map || !map->button_count)
> >> +		return false;
> >> +
> >> +	return true;
> >> +}
> >> +EXPORT_SYMBOL(ts_overlay_mapped_buttons);
> >> +
> >> +bool ts_overlay_mt_on_touchscreen(struct ts_overlay_map *map, u32 *x, u32 *y)
> >> +{
> >> +	if (!ts_overlay_mapped_touchscreen(map))
> >> +		return true;
> >> +
> >> +	if (!ts_overlay_touchscreen_event(map->touchscreen, x, y))
> >> +		return false;
> >> +
> >> +	return true;
> >> +}
> >> +EXPORT_SYMBOL(ts_overlay_mt_on_touchscreen);
> >> +
> >> +bool ts_overlay_button_press(struct ts_overlay_map *map,
> >> +			     struct input_dev *input, u32 x, u32 y, u32 slot)
> >> +{
> >> +	int i;
> >> +
> >> +	if (!ts_overlay_mapped_buttons(map))
> >> +		return false;
> >> +
> >> +	for (i = 0; i < map->button_count; i++) {
> >> +		if (ts_overlay_shape_event(&map->buttons[i].shape, x, y)) {
> >> +			input_report_key(input, map->buttons[i].key, 1);
> >> +			map->buttons[i].pressed = true;
> >> +			map->buttons[i].slot = slot;
> >> +			return true;
> >> +		}
> >> +	}
> >> +
> >> +	return false;
> >> +}
> >> +EXPORT_SYMBOL(ts_overlay_button_press);
> > 
> > The level of abstraction here does not seem quite right. Rather than force
> > each participating driver to call a press and release function, I think it
> > is better to expose something like touch_overlay_process_buttons() which
> > then handles the press and release events internally.
> > 
> > You're also relying on each individual driver to decide whether a touch
> > coordinate is inside or outside the overlay, and selectively call the press
> > and release functions OR report coordinates which is non-optimal.
> > 
> > To me, this says we actually need one wrapper function that accepts handles
> > to both the touchscreen and button input devices (which may be the same at
> > the driver's discretion) as well as the coordinates. If the coordinate is
> > within an overlay area, handle press/release; if not, call touchscreen_report_pos().
> > 
> >> +
> >> +bool ts_overlay_is_button_slot(struct ts_overlay_map *map, int slot)
> >> +{
> >> +	int i;
> >> +
> >> +	if (!map || !map->button_count)
> >> +		return false;
> >> +
> >> +	for (i = 0; i < map->button_count; i++) {
> >> +		if (map->buttons[i].pressed && map->buttons[i].slot == slot)
> >> +			return true;
> >> +	}
> >> +
> >> +	return false;
> >> +}
> >> +EXPORT_SYMBOL(ts_overlay_is_button_slot);
> >> +
> >> +void ts_overlay_button_release(struct ts_overlay_map *map,
> >> +			       struct input_dev *input, u32 slot)
> >> +{
> >> +	int i;
> >> +
> >> +	if (!map || !map->button_count)
> >> +		return;
> >> +
> >> +	for (i = 0; i < map->button_count; i++) {
> >> +		if (map->buttons[i].pressed && map->buttons[i].slot == slot) {
> >> +			input_report_key(input, map->buttons[i].key, 0);
> >> +			map->buttons[i].pressed = false;
> >> +		}
> >> +	}
> >> +}
> >> +EXPORT_SYMBOL(ts_overlay_button_release);
> >> +
> >> +MODULE_LICENSE("GPL");
> >> +MODULE_DESCRIPTION("Helper functions for overlay objects on touchscreens");
> >> diff --git a/include/linux/input/ts-overlay.h b/include/linux/input/ts-overlay.h
> >> new file mode 100644
> >> index 000000000000..b75df0dec3ab
> >> --- /dev/null
> >> +++ b/include/linux/input/ts-overlay.h
> >> @@ -0,0 +1,43 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +/*
> >> + * Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
> >> + */
> >> +
> >> +#ifndef _TS_OVERLAY
> >> +#define _TS_OVERLAY
> >> +
> >> +#include <linux/types.h>
> >> +
> >> +struct input_dev;
> >> +struct device;
> >> +
> >> +struct ts_overlay_map {
> >> +	struct ts_overlay_shape *touchscreen;
> >> +	bool overlay_touchscreen;
> >> +	struct ts_overlay_button *buttons;
> >> +	u32 button_count;
> >> +};
> >> +
> >> +struct ts_overlay_map *ts_overlay_map_objects(struct device *dev,
> >> +					      struct input_dev *input);
> >> +
> >> +void ts_overlay_get_touchscreen_abs(struct ts_overlay_map *map, u16 *x, u16 *y);
> >> +
> >> +bool ts_overlay_mapped_touchscreen(struct ts_overlay_map *map);
> >> +
> >> +bool ts_overlay_mapped_buttons(struct ts_overlay_map *map);
> >> +
> >> +bool ts_overlay_mt_on_touchscreen(struct ts_overlay_map *map, u32 *x, u32 *y);
> >> +
> >> +bool ts_overlay_button_press(struct ts_overlay_map *map,
> >> +			     struct input_dev *input, u32 x, u32 y, u32 slot);
> >> +
> >> +bool ts_overlay_is_button_slot(struct ts_overlay_map *map, int slot);
> >> +
> >> +void ts_overlay_button_release(struct ts_overlay_map *map,
> >> +			       struct input_dev *input, u32 slot);
> >> +
> >> +void ts_overlay_set_button_caps(struct ts_overlay_map *map,
> >> +				struct input_dev *dev);
> >> +
> >> +#endif
> >>
> >> -- 
> >> 2.39.2
> >>
> > 
> > Kind regards,
> > Jeff LaBundy
> 
> Thanks again for your feedback, I really appreciate it. All the comments
> without a reply can be taken as acknowledged and accepted as they are
> without further discussion. I will work on them for the next version.

Sure thing! Thank you for your efforts.

> 
> Thank you for your time and best regards,
> Javier Carrasco

Kind regards,
Jeff LaBundy
