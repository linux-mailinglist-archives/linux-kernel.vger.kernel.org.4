Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5149F743CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjF3NgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjF3Nf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:35:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2121.outbound.protection.outlook.com [40.107.220.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BBB421F;
        Fri, 30 Jun 2023 06:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Syx+i1+F9ux/ELnWrdRRUjqM7QvXxm90eH1kxfZthR1qvqXvjTM9IErQtPWf3OU/HHR+7muKWXvj8vNQKjL0z5ElUTgFJO433wKVML0V275rRJDUsInuudasqXVTlrp6RCcgVtCq7QGKqWACOl9n7nI7uE45fQoTLX0uUYjP2ayaVHShy2ksuYXqMHeX1ITDqh6xFJMM5fJuUZ2V6ZIUcy19nRiiCLv9Vj1jud1LfAdoiuSX20y4/tKDmB2Ici2VmOMgEYQp+gT4ovNdr2T6Atexjw8JH2/7hVAifGny0zKBRD6OYq4jbSwAUVqVDLZ+dyzZ62wf66mcl0WOdxSfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGFToYSIqfakO6XytJMxZX8qXMqwCL0hiPBcXlH5cgw=;
 b=DL64C3zHiagaWDnRTHncy2GRxaKvHYlHilljOR1iz/V7WjsmKfcMKnVrF8RoZkWH7Lr+RXpPQMptFWpG/rnjO4KAkwdtiVTFPwiTjDohMkoyx8X2Ft7vkWsxZgxqPtlcbkAOgYWPaeUyCAyqs6TKKbUDWM75FxOBAFqQBxa6CpMSgGlmNsPpr2GI7BLJxYt7/Z1xbOZyrr/Oq8u/jGEf6DB99XmB2bHAx/h0aNFpJlbMtJ/gH1rzIWeaLJX7v9hJdEWV13fwu0efQropPVs3ChZ7i2Hsl2chrPkQ5vdqeq4UGfKpWZ0vJL2iczTxiPkHemvatDVP8T7Os5YPLIyHkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGFToYSIqfakO6XytJMxZX8qXMqwCL0hiPBcXlH5cgw=;
 b=cvLviQsegr/x3Oe2v3Mibi+8pGltv6Gk/OqiMdJkpvdemAAJnSmCY1pikUx8zzXlBU8W6X471k1mTEm3ttMVT3WalaIvKOlnuu3cd+gpwtiGLl/PTn9+mRRDPanezYa2aRh8ftZn9OGMAdjYIar9ULdp6O2CpeyQTgBAgmPbNvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB5619.namprd13.prod.outlook.com (2603:10b6:510:139::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 13:35:43 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 13:35:41 +0000
Date:   Fri, 30 Jun 2023 15:35:23 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: dsa: sja1105: always enable the send_meta
 options
Message-ID: <ZJ7aG/tzAxutRoeo@corigine.com>
References: <20230629141453.1112919-1-vladimir.oltean@nxp.com>
 <20230629141453.1112919-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629141453.1112919-3-vladimir.oltean@nxp.com>
X-ClientProxiedBy: AM0PR10CA0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::29) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: cde2cf67-5adc-4a1e-b9a5-08db796ee5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ee2bypC3zM6XLp8SdGFYi688e3cRZdt8pWXuugJIkhKBO8G+4I5ixcIxlxdcNfdY3vu/b4I/n3lAICs15VQNMea3QkfCzLfR59rlZ29vm3wJ+a5rkFb5qixCSvhZZFJ88hCvqii8I+wRO5o/B3AhrKB6Ssldn0/J+K4Dbj56BPswp1WL7CA/SCKBPFHoJRTYKQ81OomJzW6Pb8qoXNHI3XqsMbXou//NsORfj8CgQJLUrCtL6k9zXl5tDY+JtgcZfGXABDH0+wsBeoJf/UJFvYjaDKR9cy9ILNLxSkD9bqWBe40JmEPOxKP1NNciDHDkQh4U0I+YHnhzRjJloSDlkHo8lvsIpbWPvw+j33VtTxkOwzScFzP9qfP8k5HvHMGwKGNbuI11e8H8RrU8uJm28JwLsNvD6XnyJvmxfKbRNF47X/C0+rYSilesPy5D/X82HWvGExU8F/WZTJJcdV/sL1Y7+pLNa9L0/F3fiYVL2LAaLdG6/xeCO2NenhN0U9X4Vu8LxzJYh/h51/GSZM9sLKHxhXVC0PQ3bs7vyh0Samh9Y+S32+U4HUyNKnh4MM8i/OT49kQbyWBI3rcGwJHJz6OfZzPIDrOE5O3JLgPxBzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39840400004)(136003)(451199021)(86362001)(54906003)(8936002)(8676002)(5660300002)(6506007)(44832011)(6486002)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(6512007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(83380400001)(36756003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vwzhsLP+DVhVYrokX9gV06BEXnjto5pIpi4L6XBZ+5Qx7ue6+d7zhexYIXaU?=
 =?us-ascii?Q?fkDh1aH3LFBRAgtjm91QW9wFbww7ZYUBuvyCvfSxzJDnCUxfJwgeyAgkVWCS?=
 =?us-ascii?Q?J97mQ73ZnUwm0MrjKX5D1qOS7U93QuoYNg8hKlRPOp0NI+BFeO28TzbI5Fus?=
 =?us-ascii?Q?6qhqZfVuMW0KElWG/FErS/c3alim6Rhe0u8/giT/E5zO4qLn4GJPd3XUTNyg?=
 =?us-ascii?Q?1wb26wm/FtCBTeHoCBGtg0O9/ubtCSK52daOK8u99O1nk8z+8F1kIWDkwCxe?=
 =?us-ascii?Q?yItFlvmYR8KC1Yfi7rz1PBpr9YLYarWFLn1pSmOrbqIBEDMAeSvhBGbNByJP?=
 =?us-ascii?Q?IR1UXFgQe0rnfNf/5AyiGW2jmvgzYCM9DxA2acgN+HzeECfXuvCx9dri3Oja?=
 =?us-ascii?Q?Nr94CW/FsaDQbRlfT1BL8a3vtoK0iUrmcrx7kUfl0AK20Muv3iVHLze7BW6i?=
 =?us-ascii?Q?HNsWAGmJlk01bEgDJCXbXaKl2AwayqtqH4Cn2D/oblmUfOvpMuIt3C7MDr+x?=
 =?us-ascii?Q?1jGVNSXDosThgeFVX9xMsZhlLIAX8YrtQfyUU4+LCFIjScmLpuwGEr9WywmV?=
 =?us-ascii?Q?OgvwxDH5pZM9BpXuv19Nx30Gs5UZyzGOd3b2FhAfAJkjWhiffaSnU0ZbQHp9?=
 =?us-ascii?Q?4WiLGEQ8mDwfN/qY+E09GpQM8/mKlmBS37qTpefyE5stp09M8J/hw2qk8+HQ?=
 =?us-ascii?Q?N76dPMwayV1kMZL6oaTDpuehVadxr4TSmjXcaZ11BjnMyXm9dJfDrHWIUWZ3?=
 =?us-ascii?Q?vLt93RYt3RcCvtb9o8YhTbWTCKMjqf43iabmZGqDoWR8dj1DY5GfsjVPsp/e?=
 =?us-ascii?Q?JmbBAVRh3jurFIIFB8Gs067Ba/tXKw+o0UXNiRsnd491/97PAv1vYgZezw3m?=
 =?us-ascii?Q?tnF0mnzp0fejClVjkxE2GvhwA0onAi+t7WeFG0fKb+KNtJl9nJdG3Sscmmgq?=
 =?us-ascii?Q?f75v5oEKg3P9IL0rJ9e1GwCDqM+Cd9N40BE8/R8+gE4PSPfAsTibSjHtErLP?=
 =?us-ascii?Q?paddVK9tJmcrd8vYu/jyhBnrVEnwvw+oZ1MSPF0E1trYyewu+Na63EsOReLY?=
 =?us-ascii?Q?3oe+LyyYLBW4kaiYTTlPrcJKCeQIBKANxx3He03DFxkJ5DNcCM3rie50fXJ8?=
 =?us-ascii?Q?7URtiHiqiqvNKH18/KiWBJb5YO4CWSsosgjyhB8Wehzz1vF/SUfWhB1Auu3h?=
 =?us-ascii?Q?80AaiKKHgkDkdXkRhOrvUnShi+HlNb7fCwWV6xKZVzPMSL/WRWUuuX/tcFus?=
 =?us-ascii?Q?NxAciRNzNjVUan5YDeeEVQndwPbLBEVraRAGUxZm5SB42v55wIYu5PbWp646?=
 =?us-ascii?Q?KywwbeYqo25XBZvyLeIvkfDr4NR5phcsZr96eVngQi7B/DAZRyiK89D2TQYz?=
 =?us-ascii?Q?l3OklFMzU03wgeOjSzCiB0TAmPKzckKY9IZSRaynRjlDeqp2wgQamAByMtCv?=
 =?us-ascii?Q?JK4+PmWjdKc2oSGmepCv32FQXxEdOV+IUutXh6psHtYyPaKpekLN1IKDylrf?=
 =?us-ascii?Q?hLwLiknwXrckCPWd43mmqX/LkZnhFH+lzQSh5Lz9hefJUAauY1N1C10BTKd0?=
 =?us-ascii?Q?OX0unnblymIYKQnaAJLIGUJssxwJSXeSqRPeep/VZ9qU4iD62A8MDTlY6FUz?=
 =?us-ascii?Q?V4U72gTn4bHMKxLEOLMhyc03leFJrqdhN/iwUb6oGpHGpIU+li6nn/Puze0R?=
 =?us-ascii?Q?fM5w+Q=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde2cf67-5adc-4a1e-b9a5-08db796ee5f6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 13:35:41.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3X22N0I1+RTDzBJ9ILdhqQuJEdT7cPgIqEWAXv6C6aMuXwpw4FIQJGOfcgyxjygsez1bCcwdCh9EiZoAhOqLzujm3sqLNJMyuD6UVlCzsvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5619
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 05:14:53PM +0300, Vladimir Oltean wrote:
> incl_srcpt has the limitation, mentioned in commit b4638af8885a ("net:
> dsa: sja1105: always enable the INCL_SRCPT option"), that frames with a
> MAC DA of 01:80:c2:xx:yy:zz will be received as 01:80:c2:00:00:zz unless
> PTP RX timestamping is enabled.
> 
> The incl_srcpt option was initially unconditionally enabled, then that
> changed with commit 42824463d38d ("net: dsa: sja1105: Limit use of
> incl_srcpt to bridge+vlan mode"), then again with b4638af8885a ("net:
> dsa: sja1105: always enable the INCL_SRCPT option"). Bottom line is that
> it now needs to be always enabled, otherwise the driver does not have a
> reliable source of information regarding source_port and switch_id for
> link-local traffic (tag_8021q VLANs may be imprecise since now they
> identify an entire bridging domain when ports are not standalone).
> 
> If we accept that PTP RX timestamping (and therefore, meta frame
> generation) is always enabled in hardware, then that limitation could be
> avoided and packets with any MAC DA can be properly received, because
> meta frames do contain the original bytes from the MAC DA of their
> associated link-local packet.
> 
> This change enables meta frame generation unconditionally, which also
> has the nice side effects of simplifying the switch control path
> (a switch reset is no longer required on hwtstamping settings change)
> and the tagger data path (it no longer needs to be informed whether to
> expect meta frames or not - it always does).
> 
> Fixes: 227d07a07ef1 ("net: dsa: sja1105: Add support for traffic through standalone ports")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/dsa/sja1105/sja1105.h      |  2 +-
>  drivers/net/dsa/sja1105/sja1105_main.c |  5 ++-
>  drivers/net/dsa/sja1105/sja1105_ptp.c  | 48 +++-----------------------
>  include/linux/dsa/sja1105.h            |  4 ---
>  net/dsa/tag_sja1105.c                  | 45 ------------------------
>  5 files changed, 7 insertions(+), 97 deletions(-)

Hi Vladimir,

this patch isn't that big, so I'm ok with it.  But it also isn't that
small, so I'd just like to mention that a different approach might be a
small patch that enables meta frame generation unconditionally, as a fix.
And then, later, some cleanup, which seems to comprise most of this patch.

I do admit that I didn't try this. So it might not be sensible.  And as I
said, I am ok with this patch. But I did think it was worth mentioning.

Reviewed-by: Simon Horman <simon.horman@corigine.com>

...
