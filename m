Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C86747333
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjGDNsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjGDNsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:48:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2118.outbound.protection.outlook.com [40.107.93.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12E71990;
        Tue,  4 Jul 2023 06:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLQhrlBL5s1DAOwEHNoktnNi0pCVfK+EgUJ2CFgGfSX5jGn729LUjkzBpF0jwfuHWATAxIaEi75+ha/8uYhlnZXym4S87lsXBk4tUjsgdi3/LEz+nphX0fBy3dvz/ERTEsUILszBwpKqZp9x9Dw6tnMytIi1ZQrEnfeGr/0yx1/SEuDL8Ha1KSW4YHggPKPUMn0dwxv1/AKZ8a227C1XyFxBoYwH+UCQIuVVaYinGaV9WHtml4g3Cg/uAzYc8leOpNFR0Fs3sq7WQK7xa1FmUaqRpZ8X+WE2dVlLak5w1YVm2MeTN/qS2PhJAFbCgAFRT/jHwbA1/rOnfPQNePThJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWnIGjKQiiRFokyREQ5J47HJGJsbqQa5IM8Vtb+dO0M=;
 b=JZKpdmC3zeTdJC8WV6yaajwgvR+PUfAEBLgU4XRJg9UVYwyrtk0eXA8LW5NLgs2BqJtySuyFf7l00PcaPkobUv2UKyTkpLZn5+RMVxJ+2DfiVHpgToNvg/w3LHFmSXNxvIkHmC9yUUNav7MAi7+Qx1t9aS12OW31DmerHm14qrf2OW/S37sz43DmnkSwV+lxB0oZvanbMI7lO9NeDKuuV6HrzGMUuhT6Cb5Hu4IaCwCJe67czcqylJBFVNNeyTViRcM90EMgluw2X6/Ie082j3xbdjkv79YiS7R+zgD+SxGJb/gQ9tMQWfAZ52Lu3sGMKbVTexcl2y6+auekFSWEvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWnIGjKQiiRFokyREQ5J47HJGJsbqQa5IM8Vtb+dO0M=;
 b=iAXQTd2hs9diq/Jhc/zZlfRR4yYwsfV7gBdfpzOKc1AmoTtr6tE6QzwVYinuHpugsQ5kVGxb0L0ljpMde2cpHcGFXWFLppIyWzd17jQzudNj98lxvYXjWZyMjJxZke1gDKgRmXJtpp2QvcSuI0CX5ChtMgW3TwWYLu/niK9AyXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY5PR13MB3794.namprd13.prod.outlook.com (2603:10b6:a03:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Tue, 4 Jul
 2023 13:47:19 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:47:19 +0000
Date:   Tue, 4 Jul 2023 14:47:04 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] octeontx2-pf: Add additional check for MCAM rules
Message-ID: <ZKQi2HiT/yu/vSr8@corigine.com>
References: <20230703170054.2152662-1-sumang@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703170054.2152662-1-sumang@marvell.com>
X-ClientProxiedBy: LO4P265CA0161.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::8) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY5PR13MB3794:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5ab914-c737-41ef-e7ed-08db7c952f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rCySm09yJl72T0C5PDrFyyCL0xJKdbsLg6TFBh/azuH4kMtLroIPNXgZQ6qsqbJKl2fiN7jyMDpD5bpNVb1JtfAWj2KoiC11IDEofIjDKnzsvDC6TtomKmbthXS5Xdf/hf8bIzUcXsb4w3o27ux050YlOWjA5q+zQ/Zl/hXlbwMgZ6VAPjn5nyM6cRBi+nhAfIQjnKv/qE9KXyxELcao4mLJzLf8+ffwV9498AdjPbvWCgxm2GV3Zer1ahqMQ8agnNDuRhN8kcJot44gDi1RODUqPbtzcMdFZcV9T+M6cdUH2wuknT35lM69eNj/aHxjugCZSDSjxoERaXL+9B/MCerc+qLjKSvbfiCuH1lOd0Kug3JhdMTWG+vTmIKquo5T2Dv8jflgGT0a1wiLvfzoNsTPfIFkR9rbdfbUmRUQPLAkqft114nwZBm3gClzG7CNZ7gQXNyMlL0HTAtDK1b3UIsiU4uY/lnfT8k436k1CPw5Nxg8ACKF9GCe7/EALkrGS1KMPt995s3+hfum66VE1yIi3gaU2131PYD1gyfheHmyaXkn7OxftTGk1RpOVn0jdLF7p1fQd8oJfaUHPzS0CDfGikUCBmFQHS0/jbKp6ho=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(346002)(39830400003)(451199021)(41300700001)(7416002)(8936002)(8676002)(36756003)(6486002)(44832011)(316002)(5660300002)(2906002)(6666004)(6916009)(4326008)(66476007)(66556008)(6512007)(478600001)(38100700002)(186003)(86362001)(66946007)(2616005)(83380400001)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oe+hH6x8uBrj0YCFeV7kjMe6gtUjvyFbh/okdzebUkg/kbZhUVpcW7JhI/Vz?=
 =?us-ascii?Q?8m2KNxFQTJf319+fNuMsFC6XKSsDETxtgju6S6DZHFz+0kvm/OtatXAnjrMT?=
 =?us-ascii?Q?uJwcZqaAcdal1hk412WbAlanrfFW5BRaN8SbrlZOGUa8/w4yh/TIGcVrszyk?=
 =?us-ascii?Q?YMgFgXitAWJcQ1SIYeYTkMiGLQefyfDj58W2aL7s0eBi8ahtejAXSXm5I9cY?=
 =?us-ascii?Q?8E9sJ9sw5FxxhSM62rGE5W9ZaLVG1ch7wOeH5+h2AteBE7piElXdYcB+NI3w?=
 =?us-ascii?Q?zBzSWlSa3yPCcqlTGyzWeJbEjYl8ft0kvjJ8DE1DqqwwpNIIg7rkSYt/ZM7w?=
 =?us-ascii?Q?MIjUqGyXoaHnJcjwY9og7RmK6gWuzTWxI7TqWYOVcWjAiLyojLXEmk6t9I6r?=
 =?us-ascii?Q?oaJYH+VhHiaAMePnFTymth4zJasJ40T9iioPMOYd3o3i7eZgqX7hrCHO+HyI?=
 =?us-ascii?Q?Ew2waU6OpwPZYYLg9LmMOTP9Mwl/k4LIa4ldeWSqiJAEDix+H04kzLZBVxU9?=
 =?us-ascii?Q?jZ93rCOCcx6r6zs8NjDc/no0vIQdT661MZUL/K8luhYyt1EOXK6CdXpjH25R?=
 =?us-ascii?Q?x7sTgVsCrh4lVaIz8jzeqV3SuX53oP5XXAdGETOJ+njA2ZddppJ1V7M0SL+8?=
 =?us-ascii?Q?d9tdPy8bM4sINb5+PcLi5cfXl7VYG0sURn8CtZb1bieD6AsNZtYKADHsG4Q5?=
 =?us-ascii?Q?wl4U0CwPzSs0J1a9Jcx1NAzBNjhF/SIWnejoGDfM622Zdo0N9cZS/LPGI8Ca?=
 =?us-ascii?Q?8cxOhpcYv1s5XUkdk1+pPWbNOO/6yYFcYEWwI3PKQQEIzzhhUHaWq8mWRJJ/?=
 =?us-ascii?Q?gEiKHn6+L7Ha1z1JmgiyjCW8vFT0PMqyIPaW+uTuuL0iwewvEGFQtUp83QCw?=
 =?us-ascii?Q?QaftRw9aNvQ2dDQMv/ZpGw+jyacVaU9R1BMR2OYMWvNC1njOxfIp4otQ24xO?=
 =?us-ascii?Q?7Wq26FRkDF8UE09GclJRA3TOIkIzkjkl/Y/oUQwAIcMy10ixa4IBG2+iX1Lf?=
 =?us-ascii?Q?zmhUo0Pj5eEnxBGql4WYn6lan6UZZHQrtv584PFiCsWLnmM/yHSTs00mjjv+?=
 =?us-ascii?Q?loMuV4GowAKSnSXywnES81YX6+zGYZCfGm4/IqNwbP03aK3BBuPaOU7tCApx?=
 =?us-ascii?Q?krMh504exui4XDUYNumpQxaU3kKZuFWpnlAcmgaDppMOtElmJHB4R0bhdG7L?=
 =?us-ascii?Q?JvplBp9LpW1W/NOxMu/1s+/lV835Q3j2UVjHvnRWYp1vvaFg7ezCEZY/Qq7m?=
 =?us-ascii?Q?VFjJcKT2YEDuIXJs0iYc5vYOYRDEsIrFGMRcX70dveG1rwm+eXFpYpSud9vf?=
 =?us-ascii?Q?JV2VwJa3VapAVjSaa09i8W064e5mxjL28jim5xhIRRDlyuqAC3R9Hp4XpblD?=
 =?us-ascii?Q?a+52HeSWHXJPprqt+djfs2JvY6spEhK0xtqOqGhroOIBJUNQVim+fcbezUmQ?=
 =?us-ascii?Q?o4IYwfK+mgsCM9HaOwPgAqzdgxmQRA5VzRSkuqQcHHji7EPfAveUMO/GRfA0?=
 =?us-ascii?Q?6Ea7nU5IsDIyTnkiwCFdqeA3JnNkNMo8CI2z7Mvz0XhTU6eAcfVWc5S4nRT1?=
 =?us-ascii?Q?q2yIn4ODTK9P9PJEARawuMym+geq6TFzYOjBT8cYzWOJWCf8ZLFG/ZI/lhFQ?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5ab914-c737-41ef-e7ed-08db7c952f6e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:47:19.3866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IudyYiZA9NHEfjtcwMXlN3fNE5TsdSdf2ia/AwiA2mlKudc9iSKQqLNdAxSVpdraEq/rlnwCgKdQym0qYL4LZZJHesRsFHuo8SVQSJbXbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3794
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 10:30:54PM +0530, Suman Ghosh wrote:
> Due to hardware limitation, MCAM drop rule with
> ether_type == 802.1Q and vlan_id == 0 is not supported. Hence rejecting
> such rules.
> 
> Fixes: dce677da57c0 ("octeontx2-pf: Add vlan-etype to ntuple filters")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
> Changes since v2:
> - Added "fixes" tag
> 
>  .../net/ethernet/marvell/octeontx2/nic/otx2_flows.c |  7 +++++++
>  .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c    | 13 +++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> index 10e11262d48a..49ba27875111 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> @@ -871,6 +871,13 @@ static int otx2_prepare_flow_request(struct ethtool_rx_flow_spec *fsp,
>  			if (be16_to_cpu(fsp->m_ext.vlan_etype) != 0xFFFF)
>  				return -EINVAL;
>  
> +			/* Drop rule with vlan_etype == 802.1Q
> +			 * and vlan_id == 0 is not supported
> +			 */
> +			if (vlan_etype == ETH_P_8021Q && !fsp->m_ext.vlan_tci &&
> +			    fsp->ring_cookie == RX_CLS_FLOW_DISC)
> +				return -EINVAL;
> +

Hi Suman,

vlan_etype appears to be uninitialised here.

>  			vlan_etype = be16_to_cpu(fsp->h_ext.vlan_etype);

Perhaps the new check should go here.

>  			/* Only ETH_P_8021Q and ETH_P_802AD types supported */
>  			if (vlan_etype != ETH_P_8021Q &&

As noted by Jakub elsewhere, please allow 24h from the posting of v3
before posting v4.

-- 
pw-bot: changes-requested
