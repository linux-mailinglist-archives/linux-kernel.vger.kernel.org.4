Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F90173FB8D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjF0L7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjF0L73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:59:29 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2134.outbound.protection.outlook.com [40.107.102.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBDB19B0;
        Tue, 27 Jun 2023 04:59:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF8cxyn/8/7wRSoIVEnoEVaCfXSETLR6G8qc4uAEzhIaSPciqQfu+xySkMrqyPQkeQRBHuRqGL45Ym0JroINPB0eJS/+Z87pMkU6iVuDj1gVE4OV4JLML3s+TdOX6hvJW77/+gMJyEMKkLp8LujZuTOjUgn/um4yh1Dwpx0MLuGM122PfGrk5vybCbNGdKVLdM+SqHViQva2eCMJSCoEuBtKT7bvRanHErqXbmZblCZYFJkm5+Q7l933cNkUqlYI4nkj55lhswlx3Idwry2e1Wytv/Y+a7CAVoVBJaMjUiLzM5vj7ByG+Hnsna6DR4qhNYQoY7ADSBzuPg+NwyA5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSYrisOy/XP6Xb8tcr3Sl05C+e6GA8KCJbjwWZe1RUk=;
 b=iWV2dYgGOnGFp8Iv31PfsaVFWqg5Gv0V/JBXcN0IHXJlqIYKjUhy6PwATq7Y1FkKxuNViRaKApIIi6xdpbR6pQsROFhL1B5JL1y7uDSvhrWl83ILZkZNZM1gDZZq8GmTXZAAmMqS1gbYZVCkj8uw4DNlc//Bx2FnSZDySAMpUhaAx54DFkIBt0tm2OuM1OK0//PhkqSjafB6Yv8H1mZWA8XzBGwZzVlvIpiy46seODaSItL5DTBKjwnJSiUEr4Hxs2u+be7ooeamywR+nIbq3sQSkgiiwEwJfwfkIexCuSSDT97hMPqKSaaNh8Vnz6K316BpieF1Z5P2nMMTfibh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSYrisOy/XP6Xb8tcr3Sl05C+e6GA8KCJbjwWZe1RUk=;
 b=vQ3oD6qIsNckaXKVw/x6PADtg3jhF2XPEScpI2bO4rZCH+oSZv63tfGnkgWsGEXreGHafa36ZyNCbSRJKTYAQ9Qps2QAfs3hXaI2lqaB6gQfeh+fSZAgM+Ds6uMDFl1tQejEdKRCYvaaQuEZObR9mSygKBs3w5AHkTT06lR7pkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB3824.namprd13.prod.outlook.com (2603:10b6:208:1ea::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 11:59:13 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Tue, 27 Jun 2023
 11:59:13 +0000
Date:   Tue, 27 Jun 2023 13:59:07 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: dsa: tag_sja1105: always prefer source port
 information from INCL_SRCPT
Message-ID: <ZJrPC7dqsGPZ5b1C@corigine.com>
References: <20230626155112.3155993-1-vladimir.oltean@nxp.com>
 <20230626155112.3155993-3-vladimir.oltean@nxp.com>
 <ZJnU6WntVQW2AgvZ@corigine.com>
 <20230626221828.qzjeo6dedjnyme6k@skbuf>
 <ZJrEtw15g3a7nyLN@corigine.com>
 <20230627114148.lpyopy6ttuvvciww@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627114148.lpyopy6ttuvvciww@skbuf>
X-ClientProxiedBy: AM0PR04CA0071.eurprd04.prod.outlook.com
 (2603:10a6:208:1::48) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB3824:EE_
X-MS-Office365-Filtering-Correlation-Id: 80789c40-5655-4d64-a7a8-08db7705ecc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8zwtj03hKffOJPLYP6rezA3pkSYQsPEk/GivyoaxBsb8dMaOxaI+c1jQbdti7Uoj9wH7fYV/7YtX0qa9CS+jq65Z+lV7WZX+A8jNVQeemIiprqSQ48vxigJM0Q1LKdY60B94Bo97+sI6hWzmgjl7HkhOlTKmIRT21yFsowKpNcleF1qrbK/qkIue48G5fCwe3kSDKjo1BmjGEfD6DBRxZl6JcErpPKm2zdmyHs/04E3W5KltXzG8e2X1ipFkX2XmqzqsGzl311RaCSkErNoEJ2Zcx+b4UVhAKsQV1JUJWsfsQEcrRbCrmZMFX228+NG622AxCXBcCXQprZf4No4XXxuJB+MbiivM6vBrXTbBmsOcwQZaDlZH4ppXIS2JE7hOWl//T+O5wn90jTFQSa7zQwNYRl5CcoH7AW3SlKbidpNlrf47kaKp6thbudzqWf0EG673bXYK1bnu+u6B2N5HHsdHo2DytI8ZMyF6ET60c0qZnrfKhWm7k2RAno71sqmaofyExNRbKkAUAvkjSikAf6KBb3DeOiXsclnyLWjeOsV631k4fvJghq1JdWpgJ6WdzP+rExSLGZIyEz9kDYPWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39840400004)(346002)(396003)(136003)(451199021)(36756003)(7416002)(5660300002)(44832011)(66476007)(41300700001)(8936002)(8676002)(66556008)(86362001)(6916009)(316002)(38100700002)(66946007)(4326008)(966005)(2906002)(6506007)(478600001)(186003)(6512007)(2616005)(54906003)(6486002)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o1kNs7mLp7hifV6oj8CIULprSJ9Kn+lWYOzGuuvt3IvapxPyTYwxNbKraL/S?=
 =?us-ascii?Q?DijH67IaZqBhjaIVSccDmPPON92HhkTCbs1NIDMhMajFDtFRll7V1242zTWv?=
 =?us-ascii?Q?cJfl+r38bDZ1XbJJ59a95D2UYy1GwbdA33m9YvTkfDzPDOVsXjf4KM3w/1VD?=
 =?us-ascii?Q?gdMXTInu2h1rw1w8ACM5926KFldTg0G576UOHFMIpnp1+k5jm6mcqvwgyRNj?=
 =?us-ascii?Q?uIFVFHTK9ReX2ZB3+XVlyfPkcip2G6AdChsgvdcJErl7ILZP1o8Kis1bRDoN?=
 =?us-ascii?Q?wBscx70gp6SpxCfzstSlBTa20HiK1d0n055lvPXHoOti3NqysdiZ47lpu0DE?=
 =?us-ascii?Q?y6n50ZRdPl3bQTEJT+pO34yxj0u9KTV24OHD5HVYJuIepAvMvbttup30FDRy?=
 =?us-ascii?Q?mNs47qD4/ClQCtdgBNj+PdW3yp7jl8m14Yj6UCEtlaLHHImiLWahMpgU6OMQ?=
 =?us-ascii?Q?0Nn13m+pbJ27B99h8s9nxmqEtszV6FtsW2+iN+D25SH0/5imH/efbYuEFiO5?=
 =?us-ascii?Q?H4ISnhYZJmELp2MjWAcJi77WLrLfTPYfSW1pILs73SjbsUqO0joJzKg5/t7n?=
 =?us-ascii?Q?1JvDLu7wS5XdzT4YxZRbY/XG8q7NmZeP6OMf7hN2pYVZ4l9SyQPC00w5INu0?=
 =?us-ascii?Q?fVhL/evSRL52bhuSwPLGpP1Uzo0M/se1Tr18BzZYnUVxsgRs6VfoRkYNQT6M?=
 =?us-ascii?Q?OjYSnWkDQe9o1c2t0qTz11n11xGA8dwstmO+tkQy8Bpy7T7wX76VlLxvzHbD?=
 =?us-ascii?Q?IcYF2/a/ggFl2yYDRNYDL0D0CMbpNpugWUExNsqfuiCUxr/eZN4bT7rO/6f2?=
 =?us-ascii?Q?h4ctJuu/OYTPko8DsMSK1Rn4j1Sh3E3XTq6S6vREK+WMkCS/1KleGyjxdTWQ?=
 =?us-ascii?Q?ZlcxAg7HTXeOHu8G8i03TJMi3FFEprdTjBol/ZXvd4FIxYWMx6EBS42/tOzs?=
 =?us-ascii?Q?EkAlS08GV0yVxZPaNSVTqy/c1K9biyxZ1oFF0cKrxFLW9vUQpNOE9fEi6Mmj?=
 =?us-ascii?Q?KaM5g5FIfxCIiOYsGuleG5LpSP9cZFtO0BDGTU0agHRzrOeA6ypLNuR+PUpT?=
 =?us-ascii?Q?E8acYYRS99yOwbM2MImsvxXRXpk/Vds+vl161UozUzESqgoee+/Gv/WHWF5M?=
 =?us-ascii?Q?SM+yxRrpob9Z3XA+lKxMcmGNhYTrVgz27Rdzoz8OfNLmCnyR9rzzDc0FUVrx?=
 =?us-ascii?Q?SIRGH9zlAW1u5YIrFtVY7vhHHb9FGznlvZa+sojRk82tlIQBQK5ZC9Wo9cGe?=
 =?us-ascii?Q?lT50KQP7kby2rCTNhBDpl7JOWlgh7siSTRwvGAvSelLVZTK9J8m6LSFztt3D?=
 =?us-ascii?Q?X93rlWNS/y2RP4eO4HpEprnbu5ONS/+z50OiLtZK1/60XSNvztHT1EWNQsG1?=
 =?us-ascii?Q?9gwamozrgjhWeIb3KiHZLm/q+coWrpSKW45xWnnGi4kSBzZG3G2hyZade3PK?=
 =?us-ascii?Q?IBij9zI2I6D/4rAgmGnPOOLe/xhTgrRAPIoDD8x18RfsAmgxEU3ZaomhtIKh?=
 =?us-ascii?Q?jdm4CvREnJQTbQK92CyEMu23aUtdTccaFEol3SBRrz85jqqPe1jn99lXMJSO?=
 =?us-ascii?Q?+Tlzc5lRFh4dtBeGEYodS9bkesBlUFmtow9YoJYVOxUcxqWOzSpWO0f6fIUu?=
 =?us-ascii?Q?xoACjwx4bzZf1OnQwt3R0S15AEu/FFXeADGO6QBQT0Dj2JLaqWEbnm3fQVpM?=
 =?us-ascii?Q?5s0qlA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80789c40-5655-4d64-a7a8-08db7705ecc8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 11:59:13.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raZVLHQHQxWdiE/2M7FDbvqgAAqA1qzbPU+66F31vRe59pj8bvUBXcqn6Lh7OJdjqxJyCu0f8jd5hLSRdx33XNJCaswniyxFdQk+XqJbLQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3824
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 02:41:48PM +0300, Vladimir Oltean wrote:
> On Tue, Jun 27, 2023 at 01:15:03PM +0200, Simon Horman wrote:
> > On Tue, Jun 27, 2023 at 01:18:28AM +0300, Vladimir Oltean wrote:
> > > Hi Simon,
> > > 
> > > On Mon, Jun 26, 2023 at 08:11:53PM +0200, Simon Horman wrote:
> > > > Hi Vladimir,
> > > > 
> > > > A similar comment to that made for [1], though the code is somewhat
> > > > different to that case: are you sure vid is initialised here?
> > > > GCC 12 and Smatch seem unsure about it.
> > > > 
> > > > [1] Re: [PATCH net-next v2 4/7] net: dsa: vsc73xx: Add dsa tagging based on 8021q
> > > >     https://lore.kernel.org/all/ZJg2M+Qvg3Fv73CH@corigine.com/
> > > 
> > > "vid" can be uninitialized if the tagger is fed a junk packet (a
> > > non-link-local, non-meta packet that also has no tag_8021q header).
> > > 
> > > The immediate answer that comes to mind is: it depends on how the driver
> > > configures the hardware to send packets to the CPU (and it will never
> > > configure the switch in that way).
> > > 
> > > But, between the sja1105 driver configuring the switch in a certain way
> > > and the tag_sja1105 driver seeing the results of that, there's also the
> > > DSA master driver (can be any net_device) which can alter the packet in
> > > a nonsensical way, like remove the VLAN header for some reason.
> > > 
> > > Considering the fact that the DSA master can have tc rules on its
> > > ingress path which do just that, it would probably be wise to be
> > > defensive about this. So I can probably add:
> > > 
> > > 	if (sja1105_skb_has_tag_8021q(skb)) {
> > > 		... // existing call to sja1105_vlan_rcv() here
> > > 	} else if (source_port == -1 && switch_id == -1) {
> > > 		/* Packets with no source information have no chance of
> > > 		 * getting accepted, drop them straight away.
> > > 		 */
> > > 		return NULL;
> > > 	}
> > > 
> > > This "else if" block should ensure that when "vid" is uninitialized,
> > > either "source_port" and "switch_id", or "vbid", always have valid values.
> > 
> > This is kind of complex :)
> > 
> > Can I clarify that either:
> > 
> > 1. Both source_port and switch_id are -1; or
> > 2. Neither source_port nor switch_id are -1
> > 
> > If so, I agree with your proposal.
> 
> They are integers assigned from the same code blocks in all cases,
> starting with -1 and later being assigned rvalues either from u64 fields
> limited to 0-255 (meta->source_port, meta->switch_id) or from unsigned
> char fields (hdr->h_dest[3], hdr->h_dest[4]), or from
> dsa_8021q_rx_source_port() and dsa_8021q_rx_switch_id() which return
> limited-size positive integers due to their implementation.

Thanks, in that case I think we are good.
