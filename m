Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F2A73FAD9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjF0LP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjF0LP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:15:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2136.outbound.protection.outlook.com [40.107.243.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C661FE2;
        Tue, 27 Jun 2023 04:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQgswWd+qLgZ7lRelYtbAe7KpKIlAqWJfjt16yP1xzc+rTn5h7ZLmVA9vo1qpHbOjzJgiBrlSoQbO2N6wwDURsYOtXuffIg8VbTReyaDKQHaPxSyQ1itRV69pe0CgdOvu7TqlKSdR+GlfMc032d7+RRLEKLKF7NlSI4wNEQLYk2Nw2vlK+zyn0Xv6TBH8VTlnS6cUCzsR8+aMvTxceJfThIctYXvBzRok2FxAkzgZvHBBVmPmV8emkb+v1H29EnilAAuZWYa1eCJb4MXu1nEIQFXJgDgQ6gx+wImJNAQFT/BY9kZ29ES36QoV8Sbf92UkxlLAxDCXeg3AxV/rQK6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bbI8PDcpMVhhXKue10/nkYGVVDMQ7GlzzpWWtDoD5g=;
 b=ToE0wMsWIpNiM+vsOP/j+UkJ+X0pndgWr7DsqDaBVRtycMQb/DdCSfIDoliQdd00LfDYOrsdKo91heZ66iGtqdYo2sNDv5drqqIySOPakW1YylIAjpLW4ue9gP10dlMo5XxVf1umO60f1heIgkoMCTXAqXyLtk7D037nRzqHMPo9XKTRI7nT9zbQu5Wsou3eLy2HJFeiM95RgNoEa5MkEcvAotX4YM8YAKii52SVq4GSk+uKixZDZXRcBS59tfUpKD0paMTnFibs/luV/aM/ARCefqcI4cON0RkgbZLpSSzAQW/lQAGlWiMKF+ktaJcSlR1+DrIghvBOs1CNUhNe+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bbI8PDcpMVhhXKue10/nkYGVVDMQ7GlzzpWWtDoD5g=;
 b=PGJsueuFFBT5IwODJOH+am5/NHhPWsjBmJo28ts7jfN13wW0C8LrHp9cQKNXh3X5Zg6LERaPxf/wYBbOu1+ov86pvYyYTwLqwyev1sZdsjQ+UYl68C30APfWJjmWrjxAUv3fr+EJe52FBNHIKofz6S9ItMgYMQtvFFPd3W0bhq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB6124.namprd13.prod.outlook.com (2603:10b6:a03:4d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 11:15:22 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 11:15:22 +0000
Date:   Tue, 27 Jun 2023 13:15:03 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: dsa: tag_sja1105: always prefer source port
 information from INCL_SRCPT
Message-ID: <ZJrEtw15g3a7nyLN@corigine.com>
References: <20230626155112.3155993-1-vladimir.oltean@nxp.com>
 <20230626155112.3155993-3-vladimir.oltean@nxp.com>
 <ZJnU6WntVQW2AgvZ@corigine.com>
 <20230626221828.qzjeo6dedjnyme6k@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626221828.qzjeo6dedjnyme6k@skbuf>
X-ClientProxiedBy: AM0PR02CA0117.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::14) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c852de7-21c6-4c47-2704-08db76ffcc39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfTVpGTGwTzRSCXmgjdgAvrSGYqPLxtUCez5L4KOvNmIJ1rWOVqhdTA/yXVlvZm+0Vv3VOda+9/0n740Ydbl4A+/itWWrFHJhq6/RcUxhcOWzp9TwRmIFy9mhdw6he0T2dRnwL0pDxMFnIg3BYROzYWz1llpTqS0/iPh5vrzuMW8y5QdgEG3PZQJcB3ZxpLEgZCOD9678vlT1GFpcrmphJmEHTKAaAxFqIVUbsnDK4Nm47WxvgRENtNvhxRlGnRMTbjvH1dIQDWDt9trJI4o0FbQr/FpGLnTfdGIQ9nu2z8q5xcF9qyCylgMkLwegFz16s6HfWx4/ZA17b3lg0l5ccwMoq69JxBXvc4mYO44fsTTcTzzldVDw8YdE1uYSdf1IShobWXgHFd2q2E48VMb/bqG1FKTe7RBkFN7BXq3ocz6E5BVjX/8yLbGgFczSPfX0/dp0iaPHeFOO4Wu1E3WSjBSgzFPe8ZYwYw7OnX/mhliqUee3gxCyDtQRBsEf3b44WApQGQvg33gNVDpq31e38xQibGwOXveOeCoDsC7zn3EAlttdaR+8KHEDwQhRcH8D9iZHZ3JkSsSVYLtAnwOtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(346002)(39840400004)(451199021)(2906002)(186003)(6486002)(38100700002)(2616005)(83380400001)(6666004)(6506007)(6512007)(966005)(41300700001)(54906003)(86362001)(316002)(478600001)(36756003)(66556008)(4326008)(66946007)(66476007)(6916009)(44832011)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vGOFyh1uJMAD0R2Vf27DHwAy+Gac5S+UZW9JWThnyB+QYqzW0jnxgTYbriLs?=
 =?us-ascii?Q?MFUWzRJNuVjPZbX4mvpP7OGaAjRXyRUFXfTwv3YfJoaZl8TmDndmRc6hdmpc?=
 =?us-ascii?Q?5gIQJiK4pXFrIJe1YO6CD24Dsxx8rr4OcqzjbWLHaGlMwejwY4e3a6gBEsIx?=
 =?us-ascii?Q?bnAaTXAR+O5umAu3dfS/llSLSWKLLftUU1W5ExCK6kEZJEbDEEFoHU1lGzMW?=
 =?us-ascii?Q?64gecOatKYmpMYY4EN+NnODQDPeqhepZSynoKVQdwzp/9uur07LdvmpcxD/h?=
 =?us-ascii?Q?1ycoS4fSK1HBjULqoKtsDVvWkYi0k3P/YZw8ROdAgwmJmv2IxqTor6QBQcPw?=
 =?us-ascii?Q?uk3GaB2/NO4WkD1F0If8IUA9yTJFT0RLjufjA7E69h+hteL0nUzsQ/Mr4sk3?=
 =?us-ascii?Q?rRCKfCFj5yUZ60+YONWY8v7V6j8iOqgF8Kls7wn2VlzkO3xEpsOO+Hd9BbOT?=
 =?us-ascii?Q?CKe4ycpLNSBkITLgyTbCsel1KwzaFzXMyiky2twof1r1aI7jOT2Vxn3BYlng?=
 =?us-ascii?Q?pzOWHMUflBKgpyflQFDDYrAwUag+GP8ZXX1jy4YcPxvTlQreLUC04Rky7/nl?=
 =?us-ascii?Q?gA7ywJbvnrkkT27fM8v6rUlQKKIwAsVlPgXk/EXliQUCeq2ZJudF7DptStBd?=
 =?us-ascii?Q?bdrB/Zoe/EL+Rd9cxStr+XTpOj70aIrIMuXxNqDCDY2OieUC4rb9krT1fzOT?=
 =?us-ascii?Q?VJpqiOZpx8k0F2nGefpqJZWTCQno8JDWAeYwUfjz6UASagXxZlEJF0RNS7d2?=
 =?us-ascii?Q?qSmDehiNjk+/TBh9RDIHgvsbt0rIX+hvIRJaBfXU3ip3RU+gIihZbURnAZPk?=
 =?us-ascii?Q?TZBiNwKKQzerK3tLYSRglbmh2Moh4+cgUW0WjE1mMyphlPLUZyUoUJCxXb+R?=
 =?us-ascii?Q?tvW9cpRjWbDZDekrdy6tuVAXmWWJCuVxVDm3/q6pkNq3PY7XkZXQQdfgXTAh?=
 =?us-ascii?Q?2UVEXyAfqOtm3Lr1D62AL5cPdwUP9ouYiiMfsRWU2V30B4cgzvWDSHTTymFX?=
 =?us-ascii?Q?YdjM3F3uzp3rFB1IPM/x6jNnxxTdvm9+hvyAGHCNA9nBZ0zQcat8RPMeMzln?=
 =?us-ascii?Q?iZ4+DyNuCzCZi1CLieyPJiSsvGtnYSz4eudN0i2Y+7PUr+oAwECyudIfHLC7?=
 =?us-ascii?Q?gcOYuUqGg0oFdLJtr0nSYp3hDMzFkFRfi1uveVY416xottDnK2x99N0p7w3R?=
 =?us-ascii?Q?dl28bqnnJNmf41LlSViZ700P83KhWoOdJMAVysyZh9iVJtT6EvTFddqrqSQE?=
 =?us-ascii?Q?Cqh472e+794qBOJtVDqrk7vN5jN7RuIgpIz4w98W8bCxuNTuhStxHcqDgTTa?=
 =?us-ascii?Q?GyE5sBdk/2SwJos8M6D5o5qOwn2GwgngM84B9DomSh2LH8BcSedqGiEh6oDV?=
 =?us-ascii?Q?vH/XcbpM+KPARV4x522aZiGfXwdscMJvaj8f0k1rYaKbsQeqibqsryKZfwZB?=
 =?us-ascii?Q?xg/NHpEm7fM2p1r844mGXVig+Ccd4+kyDu315xHhXU3XNBGu/DX9xw7bR5qF?=
 =?us-ascii?Q?zbqaJi4jAr8lUWgBCFk1bgM6NZkxNNogvCQyQYgasqIYi+vGJVilkIg92SM5?=
 =?us-ascii?Q?CmHnWf1ynqBl4JNBrprlBcjzz8+iCjm1wfXd0ACjy2Cyv2v0VbpCmeb8WAy+?=
 =?us-ascii?Q?BejDpLvGdesEDeO1C30XjHuK3A+8XLeOkbW3lN+nQmkjx/4jW4YaWpdjgdi+?=
 =?us-ascii?Q?GNvAIg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c852de7-21c6-4c47-2704-08db76ffcc39
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 11:15:21.9279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRubbJNj5jO8w1lEUm5bbLNYOvTAjzUxznyYy+EhNutWQzTn7wQdNV+kUVTFwg/mvIbq8Zv/FM+JNUjhJj594FYks6wPTeIO/eVFersPDDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB6124
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:18:28AM +0300, Vladimir Oltean wrote:
> Hi Simon,
> 
> On Mon, Jun 26, 2023 at 08:11:53PM +0200, Simon Horman wrote:
> > Hi Vladimir,
> > 
> > A similar comment to that made for [1], though the code is somewhat
> > different to that case: are you sure vid is initialised here?
> > GCC 12 and Smatch seem unsure about it.
> > 
> > [1] Re: [PATCH net-next v2 4/7] net: dsa: vsc73xx: Add dsa tagging based on 8021q
> >     https://lore.kernel.org/all/ZJg2M+Qvg3Fv73CH@corigine.com/
> 
> "vid" can be uninitialized if the tagger is fed a junk packet (a
> non-link-local, non-meta packet that also has no tag_8021q header).
> 
> The immediate answer that comes to mind is: it depends on how the driver
> configures the hardware to send packets to the CPU (and it will never
> configure the switch in that way).
> 
> But, between the sja1105 driver configuring the switch in a certain way
> and the tag_sja1105 driver seeing the results of that, there's also the
> DSA master driver (can be any net_device) which can alter the packet in
> a nonsensical way, like remove the VLAN header for some reason.
> 
> Considering the fact that the DSA master can have tc rules on its
> ingress path which do just that, it would probably be wise to be
> defensive about this. So I can probably add:
> 
> 	if (sja1105_skb_has_tag_8021q(skb)) {
> 		... // existing call to sja1105_vlan_rcv() here
> 	} else if (source_port == -1 && switch_id == -1) {
> 		/* Packets with no source information have no chance of
> 		 * getting accepted, drop them straight away.
> 		 */
> 		return NULL;
> 	}
> 
> This "else if" block should ensure that when "vid" is uninitialized,
> either "source_port" and "switch_id", or "vbid", always have valid values.

This is kind of complex :)

Can I clarify that either:

1. Both source_port and switch_id are -1; or
2. Neither source_port nor switch_id are -1

If so, I agree with your proposal.
