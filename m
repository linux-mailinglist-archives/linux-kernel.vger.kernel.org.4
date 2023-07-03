Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12749746066
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjGCQIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjGCQId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:08:33 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2DBE52;
        Mon,  3 Jul 2023 09:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFM7xywMGOGvaPlHQu3beB5jXn4NC0rRkRor0bFfTaahqfx4lci0Cu1NdW/zbR1bbvuAkJDRL9btnlF37Gnq8jtgJ6Jp+UTZ0S6yci1qU6/XbSPqv4OVUczNVjId4gTQ3RrB5f7A2q0MJ2SHv231dCidDYvDsEk7egna5+0ar7TerQ8Z0mommwVFtTIpTdG5iCrMFRqmBxd01eZ3p+7bG4g1nZack6yqZTVFbKhCyjTZ+Vp3df+qnT2k+n3HqCTliwzJTwR110HqUx0oCuZwjWEUDbg6+Z4ZZJ/11DeNVGv+ufMKwQnyGDVn2WAViYfP9DHGU9ZfCSZ4rGnygHhoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfMmwAPMTE2TepUyRH88vBdeIw/bsMvnWZOks/nHhqk=;
 b=DYI2Ye6IgJK4uiikHJwNRbxE+OxIfAbt5c+bk8HIAN/jhKuv/RLHraumrPgt9G2ASApCngspXyHRCSdQqg68m1MctX1QRC2epJ8GFJq+FisxgijcUGq+j1DphZ13t5bct8kmr7wWp9X2QONVpMWZ0+3kcP9EVEBiBNAzZ84Wvw+02PAgk9RpyeSoBRrGfdb4VgLLF5n1zLy6jWQez56aZcyhBdmMnrsP+rK17kC6cu2u6A2B64Eo6HG92LYCNDA25zO6n7ORouihr/kfp+JExN9kUlmqSqaVa6SyxE+4Rd+NDCZouPpCmZibLCXJtRSewFP3le353sEUn7IQU5qlnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfMmwAPMTE2TepUyRH88vBdeIw/bsMvnWZOks/nHhqk=;
 b=YwGu4JMIsTZKViZOYpGPngMHa+L8ONa14MKFyKAHQc3sYHLUC73nlrhE0J4IlQWUbLTwYsKUeOzCnx6zo/ct9NVrGTxkTssXHkJ4XhiTr7kZs1rHjK6F40UKlDDv+3w6ODqpLka5XD7+X+456PkM+lzSPAIGYop8aD3vD5pvcfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS5PR04MB9999.eurprd04.prod.outlook.com (2603:10a6:20b:67f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 16:08:30 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 16:08:30 +0000
Date:   Mon, 3 Jul 2023 19:08:26 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vlad Yasevich <vyasevic@redhat.com>,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: keep ports without IFF_UNICAST_FLT in
 BR_PROMISC mode
Message-ID: <20230703160826.5wx5mmszr67hvjmw@skbuf>
References: <20230630164118.1526679-1-vladimir.oltean@nxp.com>
 <ZKKADtxlXyPmBvbr@shredder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKKADtxlXyPmBvbr@shredder>
X-ClientProxiedBy: AS4P190CA0058.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::7) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS5PR04MB9999:EE_
X-MS-Office365-Filtering-Correlation-Id: e54b0bc9-92ac-452d-b804-08db7bdfbde6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5JOsN5yefTutISe/i/8ltEdMRRPLm5Alrf4rztGT2S3qVmcddyMusa6iWUaGUzZ5x4ObvauW3icd43K0nmpoUVgdyZlR8n/U6KLmppPPsT0q3OfeznqQojp5Uy0kF1Mbhzu+zf3fADtmHiCo5wtNJq4KbstAR/flISYISl1ifzZO0EFL4LXvkjSlTnW5RbskYrQeN8Hv/Y9ma2Xa2KCYJuxDBaQvq25FYWKq7EV+jOJ0FONq9DeG8bJBiRSzPE6vQI/Cz75IyPYUAnVNLoOZ75eIKFQqcWycZPlax44zvo04gUcghaTefFSC3S1Yl9TXrMoKcVlo7erkMvamsYqk26eTzSng7ZDioxRupZp7sg6WuPsdbytlEMIPaMMbs3tfqfW6XdEoOeXgFucTggsWnUEVpe/812IBHD/vZZe1EJbSMpiNMVaiM7RmrQtN76ZZqvGALNyT3zlWzZ6riGfwEkzL/9VR7t0GRGbqtRJEvDapLCB0pU7KtQb15f5FaJcAGmeuOXPwf6Zm6RD3bCcorQfXrNiN96n2Pob5CZ++TWg+W4HpiyC0kxl2l3hyQv4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(2906002)(41300700001)(7416002)(5660300002)(44832011)(8936002)(8676002)(33716001)(86362001)(6512007)(6486002)(478600001)(6666004)(186003)(26005)(9686003)(54906003)(1076003)(66556008)(4326008)(6916009)(66476007)(66946007)(6506007)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tQCIspRyyP1BPh1tNZ6uATXzgPsd1QNiRPmBjeSDhBqyB61/NqwM/xJOiEtZ?=
 =?us-ascii?Q?li01loeIfJYcvlorWUIBFy84cRZci9iP0tD6Bv8P2A3mWExyIcM9ZTzmfs7a?=
 =?us-ascii?Q?iVeY5T92kJFcDkOfOcGGrZZcmFVWP6tQJdSF3r/JL5qG/BGI9mMU0vkhNruE?=
 =?us-ascii?Q?SjlCwrrIoKVo5Jmob8U8NLVNIfDvjv8jM+p5b4DxsoZQwPx/UrIZSSVZVELg?=
 =?us-ascii?Q?Z8tf5WC8Zg4BDCDAyXOf9V+IDMpmrQuoPuqFW4qhOHRwGm4UxgujGRW7i2E4?=
 =?us-ascii?Q?WmTDmUG9mVjtAtvqULhUdS4Leq/UHX3P8DXE4zVp/JpSiCXFxeQAOANZt0Yt?=
 =?us-ascii?Q?H6/1Duv7yx2aY0PeDeuZrZhTCZfRdPJ8s5sEvnvg/uqudqnsC+MfjI8qBNaL?=
 =?us-ascii?Q?T2Q8DN1N8YHExRZULTcy1/x9qRHdMSmqqQfNtpkMfxGtkGVDaYo0My9NK/3Z?=
 =?us-ascii?Q?oxP3T8Y4fGBzYUroAcFL/rpkj1wwQk3Btjkh2CJ52PXrQ2vCH93avuqW2AL6?=
 =?us-ascii?Q?8DT7CYmN51ivSf/gE7nnu3YsVGBWqUaxoe1G+9Z8RVXG3tWz+BsdZ+ye93PU?=
 =?us-ascii?Q?eaFbylhsAN/1ro4PSvYyCXvCOOn6f7tmCKO8m4H1IqXJqSWDSbSC9KsVItZp?=
 =?us-ascii?Q?29TckytFyZ1R8uGITC9PT+ME6J9n6RVta6VMDPn6bUOe/RC/hg8cgLZfxXi/?=
 =?us-ascii?Q?TQxmVVTi+5ufgo9rFfjWBulYMQ7J649LImBLFKqBnw+v7s6JQEG1UOulP743?=
 =?us-ascii?Q?zl52/JUxrqGwzUIH8jRT9clDrXfz7HzNbwCJFJHyY92nwkFYCzUviZmpRJIz?=
 =?us-ascii?Q?vOvg/BzBaT3NiR+doZau6NMYJNhdoceMcAuD5JyY6ab8tq+fvj4nAOUEO8Ps?=
 =?us-ascii?Q?blyQX8oS0aj2kfUHUjNQfgDnjIZ/dvHey9I/fz0f9uNIxvVdmllQ7fqnbWUU?=
 =?us-ascii?Q?ZT5WZ/3t1FzcBmrQHlIGthkui7Ey395Y7guQ2KwP0JLrAgCcirDxzyERq3m5?=
 =?us-ascii?Q?Bkn/90MhR0ysuuEaUAjNY0gMVIIN01qOfak8p1R4K4hcqd3dkDXZMoB5Mp+m?=
 =?us-ascii?Q?oeQvgC1cpcZlbFImyubjlRhtWC6NL4FmSPXWxpS1P+rxvghH1CfpQIEHBEj9?=
 =?us-ascii?Q?vp1vxMVPNW8jYzu192pDNffIyxqa+PF3GvTbfEIU5b9uImIXJqMLhx8wsYpN?=
 =?us-ascii?Q?4GxlcSCr1TD6uI4Pvs+P4Yurcday5lnDrMQfUj/9R/uoJEGhIVi5smSTNuuQ?=
 =?us-ascii?Q?HCClqnMNl+laf/jt7omqsbqYQL9oov9atSakSP/+T0/ztBVpv9ZppV3r3r2/?=
 =?us-ascii?Q?NYKG0WYDNYpN21HXM/ewryXu3QdG16ASRBJqzXbBkuc3DJJAQiLuEfVA9hTv?=
 =?us-ascii?Q?P14NfedhE99IjJQp+rGeR5+0ecSorKFEdEY4CQhLU8cEhXMwfw388CeS7aeY?=
 =?us-ascii?Q?4BPBkbnzcSuASgTvXRo6ex5ANxJ6jAx4Cw2qrFOpFAvMlgvz6D6KCaA33Vtz?=
 =?us-ascii?Q?x+aVFNhk3jScQ5PWL6E9/Z5DSpwdDVSRiPsujuFK0esmUY2CbJlgiCXVg45X?=
 =?us-ascii?Q?RmVQ2KtxT1p5jsEt6mht1Twfs1FaAA3ceittW2qTRAt1ZoDjnukhOfJuEvZm?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54b0bc9-92ac-452d-b804-08db7bdfbde6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 16:08:30.0003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4O4YqjCnci9dPd21VA0IOg8QupqpFmX75r68325T7tVzAsIwGFavF2eX3vKhqO8goCz7E8is5qXIS1AlOF/wmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9999
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 11:00:14AM +0300, Ido Schimmel wrote:
> On Fri, Jun 30, 2023 at 07:41:18PM +0300, Vladimir Oltean wrote:
> > diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> > index 3f04b40f6056..2450690f98cf 100644
> > --- a/net/bridge/br_if.c
> > +++ b/net/bridge/br_if.c
> > @@ -166,8 +166,9 @@ void br_manage_promisc(struct net_bridge *br)
> >  			 * This lets us disable promiscuous mode and write
> >  			 * this config to hw.
> >  			 */
> > -			if (br->auto_cnt == 0 ||
> > -			    (br->auto_cnt == 1 && br_auto_port(p)))
> > +			if ((p->dev->priv_flags & IFF_UNICAST_FLT) &&
> > +			    (br->auto_cnt == 0 ||
> > +			     (br->auto_cnt == 1 && br_auto_port(p))))
> >  				br_port_clear_promisc(p);
> >  			else
> >  				br_port_set_promisc(p);
> 
> IIUC, you are basically saying "If the port does not support unicast
> filtering, then set it to promiscuous mode right away instead of waiting
> for the addition of the first FDB entry to trigger it."

Correct.

> If so, LGTM.
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> Tested using [1].
> 
> Before:
> 
> # ~/tmp/promisc_repo.sh 
> 0
> 
> After:
> 
> # ~/tmp/promisc_repo.sh 
> 1
> 
> [1]
> #!/bin/bash
> 
> ip link add name swp1 type dummy
> ip link add name br1 type bridge vlan_filtering 1
> ip link set dev swp1 master br1
> ip -d -j -p link show dev swp1 | jq '.[]["promiscuity"]'

Thanks for testing.
