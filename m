Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C04C73984D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjFVHl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjFVHlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:41:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2120.outbound.protection.outlook.com [40.107.223.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838A2107;
        Thu, 22 Jun 2023 00:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwhYIhILpqq8YTr2Ca+FpURm4bC21Q3N2hSZLGK3PbElqMY20iFRXHAR3D6KU8OB2usBYxAm1I3Zieij9/GFtw4k4qqdRdAoXfq0Zz3HDhVJIkjViy5ZDVDLpjMkLTGUdAxjUkOD9JMn4mmPg5kf4S0z2wRRV8ZqpD9RxBqwQkGNWlINLq9xqw5lavKmLzGy/SnfB17uNewvpk3i03S4pGqGTbLF+8gTIE79iBBEpwbWaYBJg+bgB7Cgmp4ZDpgfQJNILusCWSmz37HDSThte0P4sfo++7R1Krxj78Nz/O5jSPdlQyK9KbldX2aYekzKhyCeYZcvCJGeTxObNB02/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iisP5L7+/p50o1nw0iRcXxwoJvCLF89RaGZx6x+EP4s=;
 b=UuBdYzYOXBjvXq8Wjo9ChM/GMKPlFQtNzhkeOmVRV4Se1nGadMYlkYTT3Xh16XNY2f3nt8QCqG2vim5v7cmLS8kG+NNoQvyCWfoLNW1Gy+hs6UTohwg98HfvfflIluxV2rqLPeoZfJtVXty3Pccz+jzu1G9NYGtnNw77+QGQaby6zGxIZhqzT5H/0zXFRJk0iv5nVqIyFecIlbm/lQKhkw0H1vhFqshOVJ/+XgXxemWfa8gkP8X60yHPGuiDFqvO3sDQ49Z7DVokp6EKrHy7nmzhyHg43nBnvggsyBeJrVIISznoSVOTgVNFsvr1jCOxDCjWEx5WnVxHSBpQtkQkNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iisP5L7+/p50o1nw0iRcXxwoJvCLF89RaGZx6x+EP4s=;
 b=D/3SW2X9nwlsCyWNU8TYWNdnd6U4GT22Bc6764VFSMPM68gjkO5kzEOkC9OoB14WjbHyyhraQy3hboF7c+tbaVwyLhzpR7sTBKnXN+jrpgFDN/14NkorZavPY3zx7HCX0snZ3DU+NMLCwhqQDPlKbCy31lAP3vq6VOVU26Q0/vw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BL3PR13MB5161.namprd13.prod.outlook.com (2603:10b6:208:338::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 07:41:48 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 07:41:48 +0000
Date:   Thu, 22 Jun 2023 09:41:42 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, linus.walleij@linaro.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/6] net: dsa: vsc73xx: Add dsa tagging based on
 8021q
Message-ID: <ZJP7NnKntKPx40S+@corigine.com>
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
 <20230621191302.1405623-3-paweldembicki@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621191302.1405623-3-paweldembicki@gmail.com>
X-ClientProxiedBy: AM0PR06CA0080.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::21) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BL3PR13MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b919ae-bdb4-47e9-4819-08db72f422fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WsA9Seif/oWfqm4IqrtEZzut14SHITk2Mxqtwq1HnhhRSQomxdJh/qk618FvE++y1HTD026wXKBZwEiVkT1K5+AzNVVo4ld5fDUUEw59/eeNFJs/u/2XL6uzI4dhoawpx+eqc2QF/VAe+4vMAkpE7V36IgCghILmqkdZ8FTfgpVUypjjUNOLBEylDRsWn0WWBoiBPlDgCHt5Sx5wHAKD/bTY+NyStAe1YMbWsWqX9Z4wTZMJBLUrF7HRpaw39p/QJgI1KgBGkkon4QBgUD4aHeOzGXNSe+xz+MfDoLZ/pmJ6PJRflnXoiV/EfsIPJT+asrIJOTFlhW8toO+N9JbKC5ErkIZUzsuTJRCsKx0Ckc9bNpkr7Dug/bZJ+wVh5KU9FniZsolxZL3Bn0I9PSMiE4QL/fZ3WbSbXFkzEn6UFao8RfF5C+Tm/a7fEy2kRqPuG88RbJms6e828jtuVaNRRgE+9mY23Oyz3M+4F7nxJ3ouaekk4l7SQn7M4TTnBJ2/1Dl5nIN08pkFrPFVtPN/eN0CeuhxPdvaLosyA69cFRFSKDWa4akrcQnYxMwSelugAc8JFbEbycsQVTNXSJa0RnFaof+wxmDPO7GH4tS/bKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39840400004)(136003)(346002)(396003)(451199021)(6512007)(44832011)(5660300002)(186003)(7416002)(6666004)(6506007)(478600001)(2616005)(2906002)(38100700002)(8936002)(6486002)(8676002)(41300700001)(66946007)(66556008)(6916009)(66476007)(54906003)(36756003)(316002)(86362001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M4pb3QFeMFLFafctX7x0CXAR4xFjEkSeHuikIn8tvSPwMGJME+o2zQTnJH+8?=
 =?us-ascii?Q?7HbIcIyTdTog/gzmBlOcqeo4XOx+JnWuZKZ55vihIZjJ/s9q2IeeAr4S64Zx?=
 =?us-ascii?Q?TkJjXvG39h+Vm+gaUbXq+6voJy3GOyvVBdg6UfG8jLMyMtscpIOeo0DajbVt?=
 =?us-ascii?Q?kiCciiWBbKtfIaX3SLmajZJG8hpi1TdutsedRXf565epY+s7tRDDFf7Iro1r?=
 =?us-ascii?Q?aJ9Nj5z/SWsFpODu6yNGB7X0z70d2f4FnidD/zt0C7EP4Dx7OtUQysnQYde1?=
 =?us-ascii?Q?RxMPyHf0wSr6h9zkpructDJZVNp0yDnE0EgQX/BO0a8rEcCD1VPg8xODbMdy?=
 =?us-ascii?Q?wKhmfBVP5xxg5+Yb/WTpz9h4aRFG/KOA1WDhZ/xZi4qbIII+GWid8XkP3i4p?=
 =?us-ascii?Q?6gD9NY5r6r++kVEeEQpG66U6VrGL+JgAv4KXNyaPl9tkpEhu5lwWwitVI4jp?=
 =?us-ascii?Q?LqnTUSvovhRMA0BOdfri6/5FVJKM/Krha4u5Sumv7mxZHvooQGHjZj1paGo6?=
 =?us-ascii?Q?AAImrX9pIt9nd5avU1aos8YbfxYbJwHPXzgeOnlYskjBs5MsRoU+l2wW7R73?=
 =?us-ascii?Q?93crwzd8fFhApo4LmbEnaja0M0eyQOCT2on51mDe5+44d7/SoWovvoapOyDZ?=
 =?us-ascii?Q?ijssXdxTsuJvBO0k1cC4OY5AnDuHjhLVbCFNcKNuxHUxUcIUllAb96nxrJll?=
 =?us-ascii?Q?tHUpAw7m31UaD99W8s1Xj2REU+gJClJSMqUxYwPlr+TOKNje0McyJZnuzH3w?=
 =?us-ascii?Q?CHBsWA91huJYwi8n4EV73elCi0LQvt8D1SN8jLwP08wcYIKNCmwBrrVq2TaC?=
 =?us-ascii?Q?q4jRH94NGvIB9/z+nUAGelvrEZvio4GHOvzRLCV1JuuhTDtBxvKs/G2MpwAE?=
 =?us-ascii?Q?M6NKC+92kkpSD1zOWLz8NMPzigU7om2AM3XeY/2m+vo0Zg2ZITeZEIOp+v3L?=
 =?us-ascii?Q?Dnnu47PExckUp44okVAdtgIEG3D09YHMDqP2sObsV3/8/rio9PFBz9eKTQMF?=
 =?us-ascii?Q?duTC3YS90tw+7Pj/7b1mqXmwANoEcyWxCLE2+qqSvzYJa93/wTZwORwD/jy4?=
 =?us-ascii?Q?Ss9p80mMZFi1KWSb9Sr2GrqmYighVxALR9C4qEH5q3eFkb7w+qFQw9qnSv2S?=
 =?us-ascii?Q?f9EL7mdB+XvXUS+qwG1Pi0hSdcZA2ZrVD4CptRBBzIomMuwIMCsauXL3S3lY?=
 =?us-ascii?Q?2V/PCrrkY99i47FrBoc9A15yq4veUVJa929MgrhyACupMVuHIxyFwu5S+r/J?=
 =?us-ascii?Q?NIQuCEWmyxBarTvv863aYVKcx0oy1E8F3U2Q8DfcxghWUOSZSc2IyZHdtp8W?=
 =?us-ascii?Q?ECQdhJrR8Ri2UXcJt3rrYon/O7HE8Ed42Dr+7iCAKcCHjiBlbaqyJe3W9q2m?=
 =?us-ascii?Q?7somV1rqxEfR4FVAbfMmu9ulYjCEF2zZGbR0FdO8Vk++CeOdMPBs+it0okoI?=
 =?us-ascii?Q?KxofnG0Y41dljX5nK4rBYgwlvIhVjFNaDfH7v03XM6fxge9CVTJY0o1Hndve?=
 =?us-ascii?Q?e8xh6CPvdFZ30foEiHa7dfSZAeSrDVGmGke+aa13zfglrUMvZWt1HnShfyO9?=
 =?us-ascii?Q?DH59P7DwKFQRTqGzxItsDj7ooDRGKigk4C7l2lHjLBNjY/HmomgMjcvVm+Vu?=
 =?us-ascii?Q?QXsBlc4pl7UaTE0N+6YZUyPBhpKgokRkdYzfQKdPBa9vj19U4Bu8IhMtQDT7?=
 =?us-ascii?Q?TyRjmg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b919ae-bdb4-47e9-4819-08db72f422fd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 07:41:48.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHsOw8fQeWZsKjrzKGcv/hbirlhxHacVO+Z6yhcDTNdToiQ6+wPPjQLTL6cTgvn9C/x+0jWn8RvWHTIHAgVlFeJG/5FBN2Zv/6P/uutmvvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5161
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 09:12:59PM +0200, Pawel Dembicki wrote:
> This patch is simple implementation of 8021q tagging in vsc73xx driver.
> At this moment devices with DSA_TAG_PROTO_NONE are useless. VSC73XX
> family doesn't provide any tag support for external ethernet ports.
> 
> The only way is vlan-based tagging. It require constant hardware vlan
> filtering. VSC73XX family support provider bridging but QinQ only without
> fully implemented 802.1AD. It allow only doubled 0x8100 TPID.
> 
> In simple port mode QinQ is enabled to preserve forwarding vlan tagged
> frames.
> 
> Tag driver introduce most simple funcionality required for proper taging
> support.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Hi Pawel,

a few minor nits to consider if you end up respining this series.

> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index 3ed5391bb18d..4cf0166fef7b 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -125,7 +125,7 @@ config NET_DSA_SMSC_LAN9303_MDIO
>  
>  config NET_DSA_VITESSE_VSC73XX
>  	tristate
> -	select NET_DSA_TAG_NONE
> +	select NET_DSA_TAG_VSC73XX
>  	select FIXED_PHY
>  	select VITESSE_PHY
>  	select GPIOLIB
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c

...

> +static int vsc73xx_vlan_set_pvid(struct dsa_switch *ds, int port, u16 vid,
> +				 bool port_vlan)
> +{
> +	struct vsc73xx *vsc = ds->priv;
> +	struct dsa_port *dsa_port =  dsa_to_port(ds, port);
> +	u16 vlan_no;
> +	u32 val;

nit: Please use reverse xmas tree - longest line to shortest,
     for local variable declarations in new Networking code.

     Also, once space is enough after '='.

...

> diff --git a/net/dsa/tag_vsc73xx_8021q.c b/net/dsa/tag_vsc73xx_8021q.c
> new file mode 100644
> index 000000000000..3d83dfecde31
> --- /dev/null
> +++ b/net/dsa/tag_vsc73xx_8021q.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/* Copyright (C) 2022 Pawel Dembicki <paweldembicki@gmail.com>
> + * Based on tag_sja1105.c:
> + * Copyright (c) 2019, Vladimir Oltean <olteanv@gmail.com>
> + */
> +#include <linux/dsa/8021q.h>
> +
> +#include "tag.h"
> +#include "tag_8021q.h"
> +
> +#define VSC73XX_8021Q_NAME "vsc73xx-8021q"
> +
> +static struct sk_buff *vsc73xx_xmit(struct sk_buff *skb,
> +				    struct net_device *netdev)
> +{
> +	struct dsa_port *dp = dsa_slave_to_port(netdev);
> +	u16 queue_mapping = skb_get_queue_mapping(skb);
> +	u8 pcp = netdev_txq_to_tc(netdev, queue_mapping);
> +	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
> +	struct net_device *br = dsa_port_bridge_dev_get(dp);

nit: reverse xmas tree here too.

...
