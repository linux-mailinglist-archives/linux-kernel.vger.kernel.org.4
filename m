Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DA973D5D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjFZCfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjFZCfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:35:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B84BB1;
        Sun, 25 Jun 2023 19:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVP4UiD5o5qOQEmU1n1w2q+CpqQsDmzbcmVit6swWXbZaJn2zUNPqrwTYK4GTC0FGsBQgBN2GjIe2b4ayqhGrGUZgBcqiThRksTKGKXBl6xPP/G9dH9CmGJDsB/LYZpTlBWZLnX/b96MlYFWWwOsPBRW3/KK0tbKn+FgG4xc4MmO48d0CwTZG4tQiuFnBw4ymt3CsSa0iSW+JGpOibCXd7R5qjEHXQX3FEJzwQ/H2INcSdsVvoAcOuWqfzB1JkHcWrjwfkXF/khWS3vsCZT3AQmQqMXT+Wm30N+FPsfeihk7ywBHFFZuH6eVn5wwRvKZIFWcE6fs/1ZSGPQHHxRVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXdVN0HbTCvj032Fax4QUZNuRdEZvlmzfJje5ACChpk=;
 b=aP8jpzQ1g4PCsFskdAZz2C5hzyB0cfere7AivGnTpXG3c1bidkumd58OCiXbdVOXxwBCm8G+y0U2XS4PwDW8xC7sJRPCVPaLh1mm8lsgP/NKXlIpAQsuiYsKBoSt/2HQUoLHfNAhV1aRM9Vf37s5kf+ETmZSwqrWx+nOqf7oAa4iiHsaTyLvqvsBkcoTPCkgdQz9E5x4b/RGEODY8Pe1iHoIql22zQjPEHz9Hfeb4Nk+iC5W0fMuse2Rc8Raxz+Ow99YJuFpdzs9N8Je+hvIGtpT3Iju8o/Wij+7fmsu5s26BsrZMum2xV6invJ0F0/WldJbEw5t8qWxnvcziRd++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXdVN0HbTCvj032Fax4QUZNuRdEZvlmzfJje5ACChpk=;
 b=QTc0TWD2HYQrVvH2E0FbdB0rS7OjOTFAtqj+WLH0+QT7e5PI6wGvMUqFTaP0K30q7JLKM7w+bgI6qwZIDdt8HkfORBkWA5e3KPraNgvqjVeYOGuXTPNylpcIO3gc39rHSqiotnTYKqNnwc5mSJO2vJk2s3Rs5olu4nCOczAwo5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by LV3PR08MB9704.namprd08.prod.outlook.com
 (2603:10b6:408:213::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Mon, 26 Jun
 2023 02:35:10 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2%6]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 02:35:10 +0000
Date:   Sun, 25 Jun 2023 21:35:01 -0500
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
Message-ID: <ZJj5VcHvfMMWMRx8@nixie71>
References: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v3-1-b4fb7fc4bab7@wolfvision.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510-feature-ts_virtobj_patch-v3-1-b4fb7fc4bab7@wolfvision.net>
X-ClientProxiedBy: DS7PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:8:2b::24) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|LV3PR08MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: 5098fd03-8992-48ad-6ba6-08db75edf646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zLW5poCm6zx+ZNeBRDNQWqN7xzF3f3yS670i01BeHbbkJyCnIY8LxxL/ORVLKu7d+Jl1Lp2SLu9uC2ksKFI7nvE/LLNk8Z0/1tGOX39G/sj5bh5G9zLJXsfc50gYIm0GjgW6qg3M1GFdzgM5M0OcWvjl53CE6YniFzGhsPLSiDRg4b0as0JZypersyENZ3Z3kJQ51xIajUxtbrIoF80HJFgz/i4oCeUp1EbSrHu7e/rb+q8rziTn0JIPhRUeI/3kvVp0s6QDfoLGL+PzBQsXZz/0ugILPUANxA3nCuvsZ90YzorcRR/dpn1+eeQkq9g/MtpKuNqFRICmnNQzE2itX5wGzG0grnqu7oW0K/AHGNzUAJUL/UgVd6x1gHhlptUTtUy4yvhR3Fl6DD0gVu97/17/or95W93ZJxsq0/rH4QtgmEE+Ndm1EMKM6VlNPwqJZ9ZAhAFiFEENs+aAy2RTbWmJ1ueaD1L3W2ntfiUHbiRNYPCMlPZvn3wYECYKou5DVSZ6bSpXPqtXqzIBNSvVcf2WF/wWMzLCgjzD3NWoB/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(346002)(136003)(396003)(39830400003)(451199021)(38100700002)(83380400001)(86362001)(478600001)(54906003)(966005)(6486002)(33716001)(6666004)(41300700001)(66476007)(66556008)(66946007)(316002)(8676002)(8936002)(26005)(6916009)(4326008)(6506007)(6512007)(186003)(9686003)(2906002)(30864003)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YGyWbrAK2bUjix3chRJmsz1FUHRxb2CfJt8Dj6e+EvUifjqz9tEwspbDW/Iu?=
 =?us-ascii?Q?hzM7cmSp41dLJNyULiVuJqab2DUFAQibND2NYaXJ3mraDJ0dWi2JUCH1nYfA?=
 =?us-ascii?Q?j52edty5BoDUOzp1DGQAR6S4dpaBtY4SuZYhPU8Hn8wab0ERaykoro6/qSNe?=
 =?us-ascii?Q?xhOjDjR1N4BMBYtHtTg2S1GEk9dpoMXfJGRS97kdyaNYZ8pu5qJlgth28Hj+?=
 =?us-ascii?Q?B8kZe8aF63T1w8+inZhFdNfcPeMCG3m0i25i9AKoexVlZ92aLcn+xbYryq9W?=
 =?us-ascii?Q?KbNGNE8NPUJyoH24LdWz2R0jyMPACHEoQqLFV34Qd7WWTEKOlNXA8dtedI1z?=
 =?us-ascii?Q?AQs7bfmqqu7hkVA4wupzPMfPrnD4BYDTNUYp2GqCAuiN8jH+uO5hQ8aF5i/l?=
 =?us-ascii?Q?LpAHMwO91PoDGP4EmbX0TptdNUCQeH4xKvnXrGm4BFwgQfdRuqfxulRexa5/?=
 =?us-ascii?Q?t/+ArxNBv45JPZH64rgSqeGbOfwxB13H4ma14AdpRLfefHUZKravvaafANKT?=
 =?us-ascii?Q?PCO3470T9lnwCk1uE6zcDkn5tG+6CvhTurJETCz2B736MRNH4cSC7i0bQsc8?=
 =?us-ascii?Q?uEH0QJUDHJIEOvVD6XIQGckzwcrkAakEPBFjAAJSERfgZUjlzaP4OxTsLDJ3?=
 =?us-ascii?Q?TfKWSKlE45Ydj/XD7/bUL4v8Fq0D+rVc5H/bZMA0gNXEoo98xEwLr7Y4BXEm?=
 =?us-ascii?Q?VdsBzghYDZDPwszfVMRjIrXzYTDTkpdescuKuUOcZ6eeC+80HZb/rnnCbBVL?=
 =?us-ascii?Q?s9cMVFU/2g80dFavubT/7WnwYnvbtUVcLr68TqFNyPAWFc2eKS5w0EkPk2pf?=
 =?us-ascii?Q?/CMXV/gW7iVtF59fbxXXkYxnMPhgDCpC45d581hsLLYvlD0l31F3QR1Kftid?=
 =?us-ascii?Q?VvxG3C+FdZgG6xcZuqeIUIXD3HzVH5FlnTt8jfs+EdqwGP/IvuMFfOB3RYhM?=
 =?us-ascii?Q?RTqMP8HK1iHijNSafbhU2UVpS2GHpxNs+ofSOPRExKFVrjMqpR3Mh0eeVg+K?=
 =?us-ascii?Q?vciniCRd+laprmm+Nqhfk0S1nQBnPfVbKO+oBMwF5PBxC/a6GRkU6dY4hXiz?=
 =?us-ascii?Q?TrID+2aDdXOCajfOBDRWMeX5yDPoPBZQZB9zU+GuiztKksl6G6SgMFtUTmqy?=
 =?us-ascii?Q?e/nb+YYB7CosydvivG7+pcA2AS/E+JB7siCfrC7CRB9V9OJwK/5zMCnFxX+K?=
 =?us-ascii?Q?EZ6Ads10b2Bhd7+9lBhbg7D+O3/m+oi2WMRJcNVgIaSUwgi3l7SEgOO9ocPa?=
 =?us-ascii?Q?MahEoYPOFYGt4Svt1uU38pQBfnggDm/WXhu3A1NEaCiEu83B4wH0ma2f0TSQ?=
 =?us-ascii?Q?8jcHP8Lsc1x9BEOO6aM7N6wFjcj2p9GtI+O6jAxBARbnn8hOFRjow0Kgf3ff?=
 =?us-ascii?Q?CW4lIwjU9/x34VKlzZ5BjRCJixSl6pA5zkq+l5pbJEWN9fP9q8jcasWXgKuL?=
 =?us-ascii?Q?2xp0BgDHoO/RQjCoDoe//P056QypAeHBu7IBsfoQXlBuMcZdg90zWwB6+Qfn?=
 =?us-ascii?Q?El8C0Wtm+H03ZfX4i9ugHmSowJU2N6IQ7FhO4P5VZWDgJykAWc4eafu5Wu9s?=
 =?us-ascii?Q?1ti+Wk7C/Q78PjwTWu+l+Pi2gxsJo7vUo7WbEpSs?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5098fd03-8992-48ad-6ba6-08db75edf646
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:35:10.6697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeUcYG5Mpb8snGf59Xv6qfAAxbINy3CWDGHfcg5WaCo6hHUEmkr5/1CWqj+MqSbyOmLiiCf75gEYdxw1yjbEuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR08MB9704
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Fri, Jun 16, 2023 at 09:28:51AM +0200, Javier Carrasco wrote:
> Some touchscreens provide mechanical overlays with different objects
> like buttons or clipped touchscreen surfaces.
> 
> In order to support these objects, add a series of helper functions
> to the input subsystem to transform them into overlay objects via
> device tree nodes.
> 
> These overlay objects consume the raw touch events and report the
> expected input events depending on the object properties.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---

Excellent work; it's great to see this series move along.

>  MAINTAINERS                            |   7 +
>  drivers/input/touchscreen/Kconfig      |   9 +
>  drivers/input/touchscreen/Makefile     |   1 +
>  drivers/input/touchscreen/ts-overlay.c | 356 +++++++++++++++++++++++++++++++++
>  include/linux/input/ts-overlay.h       |  43 ++++
>  5 files changed, 416 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e0b87d5aa2e..db9427926a4c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21434,6 +21434,13 @@ W:	https://github.com/srcres258/linux-doc
>  T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
>  F:	Documentation/translations/zh_TW/
>  
> +TOUCHSCREEN OVERLAY OBJECTS
> +M:	Javier Carrasco <javier.carrasco@wolfvision.net>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	drivers/input/touchscreen/ts-overlay.c
> +F:	include/linux/input/ts-overlay.h
> +
>  TTY LAYER
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:	Jiri Slaby <jirislaby@kernel.org>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 143ff43c67ae..8382a4d68326 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -1388,4 +1388,13 @@ config TOUCHSCREEN_HIMAX_HX83112B
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called himax_hx83112b.
>  
> +config TOUCHSCREEN_TS_OVERLAY
> +	bool "Touchscreen Overlay Objects"
> +	help
> +	  Say Y here if you are using a touchscreen driver that supports
> +	  printed overlays with keys or a clipped touchscreen area.
> +
> +	  Should be selected by the touchscren drivers that support
> +	  this feature.
> +
>  endif
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 159cd5136fdb..f554826706ff 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -117,3 +117,4 @@ obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_FW)	+= raspberrypi-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
>  obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
>  obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)	+= himax_hx83112b.o
> +obj-$(CONFIG_TOUCHSCREEN_TS_OVERLAY)	+= ts-overlay.o

It seems like this feature is useful for any two-dimensional touch surface
(e.g. trackpads) and not just touchscreens. For that reason, the touchscreen
helpers in touchscreen.c were moved out of input/touchscreen and into input/
such that they are not guarded by CONFIG_INPUT_TOUCHSCREEN. A growing number
of devices in input/misc are taking advantage of these.

Therefore, I think this feature should follow suit and be available to any
input device as is the case for touchscreen.c. As written, the newly updated
binding is misleading because one may believe that any device that includes
touchscreen.yaml can define an overlay child, but the code does not currently
support this.

To that end, it seems like touch-overlay would be a more descriptive name as
well. I understand that the name has changed once already, so hopefully this
feedback is not too annoying :)

> diff --git a/drivers/input/touchscreen/ts-overlay.c b/drivers/input/touchscreen/ts-overlay.c
> new file mode 100644
> index 000000000000..7afa77d86c1f
> --- /dev/null
> +++ b/drivers/input/touchscreen/ts-overlay.c
> @@ -0,0 +1,356 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  Helper functions for overlay objects on touchscreens
> + *
> + *  Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
> + */
> +
> +#include <linux/property.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/module.h>
> +#include <linux/input/ts-overlay.h>
> +
> +enum ts_overlay_valid_objects {
> +	TOUCHSCREEN,
> +	BUTTON,

Please namespace these, i.e. TOUCH_OVERLAY_*.

> +};
> +
> +static const char *const ts_overlay_names[] = {
> +	[TOUCHSCREEN] = "overlay-touchscreen",

I'm a little confused why we need new code for this particular function; it's
what touchscreen-min-x/y and touchscreen-size-x/y were meant to define. Why
can't we keep using those?

> +	[BUTTON] = "overlay-buttons",
> +};
> +
> +struct ts_overlay_shape {
> +	u32 x_origin;
> +	u32 y_origin;
> +	u32 x_size;
> +	u32 y_size;
> +};
> +
> +struct ts_overlay_button {
> +	struct ts_overlay_shape shape;
> +	u32 key;
> +	bool pressed;
> +	int slot;
> +};
> +
> +static int ts_overlay_get_shape_properties(struct fwnode_handle *child_node,
> +					   struct ts_overlay_shape *shape)
> +{
> +	int rc;

In input, the common practice is to use 'error' for return values that are either
zero or negative. The reasoning is because the variable quite literally represents
an error, or lack thereof. And then:

	error = ...
	if (error)
		return error;

> +
> +	rc = fwnode_property_read_u32(child_node, "x-origin", &shape->x_origin);
> +	if (rc < 0)
> +		return rc;

It seems like all of these properties are required; if so, please update the
binding to make this clear.

If the binding is correct and these properties are in fact optional, then you
must evaluate fwnode_property_read_u32() against -EINVAL.

> +
> +	rc = fwnode_property_read_u32(child_node, "y-origin", &shape->y_origin);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = fwnode_property_read_u32(child_node, "x-size", &shape->x_size);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = fwnode_property_read_u32(child_node, "y-size", &shape->y_size);
> +	if (rc < 0)
> +		return rc;
> +
> +	return 0;
> +}
> +
> +static int ts_overlay_get_button_properties(struct device *dev,
> +					    struct fwnode_handle *child_node,
> +					    struct ts_overlay_button *btn)
> +{
> +	struct fwnode_handle *child_btn;
> +	int rc;
> +	int j = 0;
> +
> +	fwnode_for_each_child_node(child_node, child_btn) {
> +		rc = ts_overlay_get_shape_properties(child_btn, &btn[j].shape);
> +		if (rc < 0)
> +			goto button_prop_cleanup;
> +
> +		rc = fwnode_property_read_u32(child_btn, "linux,code",
> +					      &btn[j].key);
> +		if (rc < 0)
> +			goto button_prop_cleanup;

The binding needs to list this property as required, too.

> +
> +		dev_info(dev, "Added button at (%u, %u), size %ux%u, code=%u\n",
> +			 btn[j].shape.x_origin, btn[j].shape.y_origin,
> +			 btn[j].shape.x_size, btn[j].shape.y_size, btn[j].key);

This seems like a dev_dbg() to me.

> +		j++;
> +	}
> +
> +	return 0;
> +
> +button_prop_cleanup:
> +	fwnode_handle_put(child_btn);
> +	return rc;
> +}
> +
> +void ts_overlay_set_button_caps(struct ts_overlay_map *map,
> +				struct input_dev *dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < map->button_count; i++)
> +		input_set_capability(dev, EV_KEY, map->buttons[i].key);
> +}
> +EXPORT_SYMBOL(ts_overlay_set_button_caps);

I don't see a need to expose this function and require participating drivers
to call it; we should just have one over-arching function for processing the
overlay(s), akin to touchscreen_parse_properties but for the button input
device in case the driver separates the button and touchscreen input devices.

That one function would then be responsible for parsing the overlay(s) and
calling input_set_capability() on each button.

> +
> +static int ts_overlay_count_buttons(struct device *dev)
> +{
> +	struct fwnode_handle *child_node;
> +	struct fwnode_handle *child_button;

These names confused me; they're both children, but only the second is aptly
named. How about child_overlay and child_button, or perhaps overlay_node and
button_node?

> +	int count = 0;
> +
> +	child_node = device_get_named_child_node(dev, ts_overlay_names[BUTTON]);
> +	if (!child_node)
> +		return 0;
> +
> +	fwnode_for_each_child_node(child_node, child_button)
> +		count++;
> +	fwnode_handle_put(child_node);
> +
> +	return count;
> +}
> +
> +static int ts_overlay_map_touchscreen(struct device *dev,
> +				      struct ts_overlay_map *map)
> +{
> +	struct fwnode_handle *child;

Same here; there are two layers of children, so please use more descriptive
variable names.

> +	int rc = 0;
> +
> +	child = device_get_named_child_node(dev, ts_overlay_names[TOUCHSCREEN]);
> +	if (!child)
> +		goto touchscreen_ret;

I don't think we need a label here; just return 0 directly.

> +
> +	map->touchscreen =
> +		devm_kzalloc(dev, sizeof(*map->touchscreen), GFP_KERNEL);
> +	if (!map->touchscreen) {
> +		rc = -ENOMEM;
> +		goto touchscreen_handle;
> +	}
> +	rc = ts_overlay_get_shape_properties(child, map->touchscreen);
> +	if (rc < 0)
> +		goto touchscreen_free;
> +
> +	map->overlay_touchscreen = true;
> +	dev_info(dev, "Added overlay touchscreen at (%u, %u), size %u x %u\n",
> +		 map->touchscreen->x_origin, map->touchscreen->y_origin,
> +		 map->touchscreen->x_size, map->touchscreen->y_size);

dev_dbg()

> +
> +	rc = 0;

rc (error) can only be zero if we have gotten this far; I don't see a need
to assign it here.

> +	goto touchscreen_handle;

Please think about whether this can be reorganized to prevent jumping over
small bits of code; I found it hard to follow. Maybe one or more tasks can
be offloaded to a helper function?

> +
> +touchscreen_free:
> +	devm_kfree(dev, map->touchscreen);

This set off a red flag; it's unclear that it's necessary. Regardless of
whether the participating driver is smart enough to bail during probe()
if the overlay parsing fails, or it happily continues, this memory will
get freed when the driver tied to 'dev' is torn down.

Calling devm_kfree() is generally limited to special cases where you are
dynamically reallocating memory at runtime. In case I have misunderstood
the intent, please let me know.

> +touchscreen_handle:
> +	fwnode_handle_put(child);
> +touchscreen_ret:
> +	return rc;
> +}
> +
> +static int ts_overlay_map_buttons(struct device *dev,
> +				  struct ts_overlay_map *map,
> +				  struct input_dev *input)
> +{
> +	struct fwnode_handle *child;
> +	u32 button_count;
> +	int rc = 0;
> +
> +	button_count = ts_overlay_count_buttons(dev);
> +	if (button_count) {
> +		map->buttons = devm_kcalloc(dev, button_count,
> +					    sizeof(*map->buttons), GFP_KERNEL);
> +		if (!map->buttons) {
> +			rc = -ENOMEM;
> +			goto map_buttons_ret;
> +		}
> +		child = device_get_named_child_node(dev,
> +						    ts_overlay_names[BUTTON]);
> +		if (unlikely(!child))
> +			goto map_buttons_free;
> +
> +		rc = ts_overlay_get_button_properties(dev, child, map->buttons);
> +		if (rc < 0)
> +			goto map_buttons_free;
> +
> +		map->button_count = button_count;
> +	}
> +
> +	return 0;
> +
> +map_buttons_free:
> +	devm_kfree(dev, map->buttons);
> +map_buttons_ret:
> +	return rc;
> +}
> +
> +static bool ts_overlay_defined_objects(struct device *dev)
> +{
> +	struct fwnode_handle *child;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ts_overlay_names); i++) {
> +		child = device_get_named_child_node(dev, ts_overlay_names[i]);
> +		if (child) {
> +			fwnode_handle_put(child);
> +			return true;
> +		}
> +		fwnode_handle_put(child);
> +	}
> +
> +	return false;
> +}
> +
> +struct ts_overlay_map *ts_overlay_map_objects(struct device *dev,
> +					      struct input_dev *input)
> +{
> +	struct ts_overlay_map *map = NULL;
> +	int rc;
> +
> +	if (!ts_overlay_defined_objects(dev))
> +		return NULL;
> +
> +	map = devm_kzalloc(dev, sizeof(*map), GFP_KERNEL);
> +	if (!map) {
> +		rc = -ENOMEM;
> +		goto objects_err;
> +	}
> +	rc = ts_overlay_map_touchscreen(dev, map);
> +	if (rc < 0)
> +		goto objects_free;
> +
> +	rc = ts_overlay_map_buttons(dev, map, input);
> +	if (rc < 0)
> +		goto objects_free;
> +
> +	return map;
> +
> +objects_free:
> +	devm_kfree(dev, map);
> +objects_err:
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL(ts_overlay_map_objects);
> +
> +void ts_overlay_get_touchscreen_abs(struct ts_overlay_map *map, u16 *x, u16 *y)
> +{
> +	*x = map->touchscreen->x_size - 1;
> +	*y = map->touchscreen->y_size - 1;
> +}
> +EXPORT_SYMBOL(ts_overlay_get_touchscreen_abs);
> +
> +static bool ts_overlay_shape_event(struct ts_overlay_shape *shape, u32 x, u32 y)
> +{
> +	if (!shape)
> +		return false;
> +
> +	if (x >= shape->x_origin && x < (shape->x_origin + shape->x_size) &&
> +	    y >= shape->y_origin && y < (shape->y_origin + shape->y_size))
> +		return true;
> +
> +	return false;
> +}
> +
> +static bool ts_overlay_touchscreen_event(struct ts_overlay_shape *touchscreen,
> +					 u32 *x, u32 *y)
> +{
> +	if (ts_overlay_shape_event(touchscreen, *x, *y)) {
> +		*x -= touchscreen->x_origin;
> +		*y -= touchscreen->y_origin;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +bool ts_overlay_mapped_touchscreen(struct ts_overlay_map *map)
> +{
> +	if (!map || !map->overlay_touchscreen)
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(ts_overlay_mapped_touchscreen);
> +
> +bool ts_overlay_mapped_buttons(struct ts_overlay_map *map)
> +{
> +	if (!map || !map->button_count)
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(ts_overlay_mapped_buttons);
> +
> +bool ts_overlay_mt_on_touchscreen(struct ts_overlay_map *map, u32 *x, u32 *y)
> +{
> +	if (!ts_overlay_mapped_touchscreen(map))
> +		return true;
> +
> +	if (!ts_overlay_touchscreen_event(map->touchscreen, x, y))
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(ts_overlay_mt_on_touchscreen);
> +
> +bool ts_overlay_button_press(struct ts_overlay_map *map,
> +			     struct input_dev *input, u32 x, u32 y, u32 slot)
> +{
> +	int i;
> +
> +	if (!ts_overlay_mapped_buttons(map))
> +		return false;
> +
> +	for (i = 0; i < map->button_count; i++) {
> +		if (ts_overlay_shape_event(&map->buttons[i].shape, x, y)) {
> +			input_report_key(input, map->buttons[i].key, 1);
> +			map->buttons[i].pressed = true;
> +			map->buttons[i].slot = slot;
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL(ts_overlay_button_press);

The level of abstraction here does not seem quite right. Rather than force
each participating driver to call a press and release function, I think it
is better to expose something like touch_overlay_process_buttons() which
then handles the press and release events internally.

You're also relying on each individual driver to decide whether a touch
coordinate is inside or outside the overlay, and selectively call the press
and release functions OR report coordinates which is non-optimal.

To me, this says we actually need one wrapper function that accepts handles
to both the touchscreen and button input devices (which may be the same at
the driver's discretion) as well as the coordinates. If the coordinate is
within an overlay area, handle press/release; if not, call touchscreen_report_pos().

> +
> +bool ts_overlay_is_button_slot(struct ts_overlay_map *map, int slot)
> +{
> +	int i;
> +
> +	if (!map || !map->button_count)
> +		return false;
> +
> +	for (i = 0; i < map->button_count; i++) {
> +		if (map->buttons[i].pressed && map->buttons[i].slot == slot)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL(ts_overlay_is_button_slot);
> +
> +void ts_overlay_button_release(struct ts_overlay_map *map,
> +			       struct input_dev *input, u32 slot)
> +{
> +	int i;
> +
> +	if (!map || !map->button_count)
> +		return;
> +
> +	for (i = 0; i < map->button_count; i++) {
> +		if (map->buttons[i].pressed && map->buttons[i].slot == slot) {
> +			input_report_key(input, map->buttons[i].key, 0);
> +			map->buttons[i].pressed = false;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL(ts_overlay_button_release);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Helper functions for overlay objects on touchscreens");
> diff --git a/include/linux/input/ts-overlay.h b/include/linux/input/ts-overlay.h
> new file mode 100644
> index 000000000000..b75df0dec3ab
> --- /dev/null
> +++ b/include/linux/input/ts-overlay.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023 Javier Carrasco <javier.carrasco@wolfvision.net>
> + */
> +
> +#ifndef _TS_OVERLAY
> +#define _TS_OVERLAY
> +
> +#include <linux/types.h>
> +
> +struct input_dev;
> +struct device;
> +
> +struct ts_overlay_map {
> +	struct ts_overlay_shape *touchscreen;
> +	bool overlay_touchscreen;
> +	struct ts_overlay_button *buttons;
> +	u32 button_count;
> +};
> +
> +struct ts_overlay_map *ts_overlay_map_objects(struct device *dev,
> +					      struct input_dev *input);
> +
> +void ts_overlay_get_touchscreen_abs(struct ts_overlay_map *map, u16 *x, u16 *y);
> +
> +bool ts_overlay_mapped_touchscreen(struct ts_overlay_map *map);
> +
> +bool ts_overlay_mapped_buttons(struct ts_overlay_map *map);
> +
> +bool ts_overlay_mt_on_touchscreen(struct ts_overlay_map *map, u32 *x, u32 *y);
> +
> +bool ts_overlay_button_press(struct ts_overlay_map *map,
> +			     struct input_dev *input, u32 x, u32 y, u32 slot);
> +
> +bool ts_overlay_is_button_slot(struct ts_overlay_map *map, int slot);
> +
> +void ts_overlay_button_release(struct ts_overlay_map *map,
> +			       struct input_dev *input, u32 slot);
> +
> +void ts_overlay_set_button_caps(struct ts_overlay_map *map,
> +				struct input_dev *dev);
> +
> +#endif
> 
> -- 
> 2.39.2
> 

Kind regards,
Jeff LaBundy
