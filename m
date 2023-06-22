Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47B8739723
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjFVGB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjFVGBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:01:24 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393E8E2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfgunBYvigZA2HPvvz3NbadbYGw20UziXMVdovY8HqXd2MktMdG4fHEZaVBFAgpAuLyfhcZUX1yAyP21onY6TugnhzUGpQxSOBH2XnPCuC8cGGKsovmqxe2HA0Ye+ar26QJhVk+GLJUlQHYsfNf35jSinzCL4YjerQGQFem4x+NzHkrWQ+nApns29re4QxPLlvjKGLWA7j+wLuoCmlAS4cajsvz+CjWkBY7Od8C0i+Ks2xPa5QVD6Q9sEolY8PUaalIh7I23Q+MZ+EvYJdHB2TcvNXzkT8ldJgjfKp0b4AfM0OTuNf4uSDd3u/pukV/aw0wJddMki4lrNk3x52VyOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3xvTrWpqgPO+JEFuXpR7GoGtCf8NH72MuodWoMEwhw=;
 b=UIpxSa+bBS0yNetCa/CRGfU9hxDO6HabJcKKertDLCAxVn53sEmQ8uoSk8fGlBvMcpU3iO+Hc2tXFpaj0CAlOeOpaPh5Ya44pPcyMf0jSixwN4r/joX4YbH+9twj7G71jiRdZKy2RGZZ+5gAworn9qQuAakPyuDEbFqHKJQMKcQvf4UulQkTgkLrDiCDc6n2ELF4iVMs2+nd0Dfu82ZryxVkiYqCvDrC40fOQ65KR2Gkf6BGWGC7QneiYd5GQunvPRqy154a9Cv92GTyQH1UUVA/Jq7oWuAlGXZFzj11rNYneuy+2o5zxOX7mqgnLVyNsvLa7hqxvkcIur+U9yPjuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3xvTrWpqgPO+JEFuXpR7GoGtCf8NH72MuodWoMEwhw=;
 b=t+rp/cu++B5jw+bMb7dcDy0ApypRUybaqiZn7E+exmLpPtTg/SYwmONDH5C9NtZofkYgyx5LMX2kkhVPaXu+QAlfaU5gG6WLd/MIeztz++NET1wSDDR5pTxhIq21GO2ncjEeBKEEw/FmsoeUHis052QwlXynbW0xmo2wCysez4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 06:01:19 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::8801:420d:4748:33b1%4]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 06:01:19 +0000
Date:   Thu, 22 Jun 2023 11:31:03 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] sched/fair: Calculate the scan depth for idle
 balance based on system utilization
Message-ID: <ZJPjn9b56eD5S0tC@BLR-5CG11610CF.amd.com>
References: <cover.1686554037.git.yu.c.chen@intel.com>
 <bc96b53efb712337a645e2c2a340975545ed5a28.1686554037.git.yu.c.chen@intel.com>
 <ZIqpI0ScCT5pmrAO@BLR-5CG11610CF.amd.com>
 <ZJKm195gy7X80wjm@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJKm195gy7X80wjm@chenyu5-mobl2.ccr.corp.intel.com>
X-ClientProxiedBy: PN2PR01CA0225.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::20) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3286:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c35e75-8994-48c1-795c-08db72e618d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09ot8ulvsZ0VuD41dTkpyFDue8mBx4q+KGI6Y5lD+tkr+27MrZvvUVvo6lQTlOvWASk9zkWIRsURgyzGh0aRsuAsfZj+n+UIZG1Fqavxle3ayHuVCpLSY8lGloZjuInXDldExQEtf+7FZ5J/fhNY0CD3zU1i/NCH7EO0Duna+GvJ4ya+Ap0YB7dQCzKZoE3JfnUP/Y1RykUE0n55NDV9C7Hsx6TeHunhEO5yLCsfICgSNq+NrLeJi20qC/v36HEe2GCieWLTotL1+Oa7ACYAuFg6JStVVznimr5O8A8WRFNHqGVuLbv/yD6uKO08d1cEg0dd8DkaX59wsHSKAFEm6UIyy3bol8YppceQ7dESRWbUgMpPB1R5Cc+ZG2i+2Q3704bBWEj5Jrcd1ZHm8cSWf99JwDUO4xL6VtVSH31G3N8nXxOGRSVN6UZ/v4IYL6k2sdNacnPKaleTCmH/wSR/bP/aSCd2eO1bLm+0ie9aqAlA0YgmlSRD5jBwxHIPecJyUTD/ReT/bei1blSqmeRHsQHx2eFMnC2EfC5Yb7TnM2w5hJsx7EVKheJGlPY49W0P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(478600001)(66946007)(66556008)(66476007)(6916009)(6666004)(316002)(54906003)(86362001)(6512007)(83380400001)(6506007)(186003)(6486002)(26005)(38100700002)(8936002)(5660300002)(8676002)(41300700001)(2906002)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aEaTjlWDDRYg88dp3K1FolVECsUwy75o09Cov5y52xXDUSgVrC7MAh5fudhU?=
 =?us-ascii?Q?QPNGedW8oQf4KPYlnr0D01VcptvzAKoyWlxWwYVMxnZK7vTL+ebdyyZkZPuF?=
 =?us-ascii?Q?hQp0cL7Fh19CYY3UPuT+bFmQVr4+Nc+U4GLmNGHAYfS+MHJ7ukwBeyJFtKnD?=
 =?us-ascii?Q?7WC91ECRc0mXU+CqDf7ZgJE2cJHRhI1VT4PtLG+X0w077MLi6VIRqLFKuQUi?=
 =?us-ascii?Q?+x75KxzQHJwPPUiiCMcBCah9iJq2tqtXyxFq3I1Q3yw3Ty9GBPptpChlhwnc?=
 =?us-ascii?Q?h44inOUBwQwTih41cuQNck9oPnL4/LGmv2uTkIFNsJ4VOD9qkm6mQ/Id/EC9?=
 =?us-ascii?Q?7aecHyEUAc4MJupBt6xpaDQ8awbfb+XnOHexi0c9zjS9/ZfQWzMi+zb8kl1d?=
 =?us-ascii?Q?+k6/wHKBywjhQG+/NFf0pvd/5hvUv3f3k7aTbgH5PG/u0Plwo/sDSL7tq1te?=
 =?us-ascii?Q?e3oIiiLGGrW5Z9tKpfRH3CkRbWI9sMEeeL+5oE8gDFWegAFlalTweoyB/IDq?=
 =?us-ascii?Q?0dN8KHV9x6pa7j15mTCMi33fmQBoL9S6xBzp2Lm+Muk/QLhYTvBJmmCNH+Ib?=
 =?us-ascii?Q?fisCkAfz71zf4lBoysrgQUG9HjaM7hyYSAggJfbzWMg+1aIzXWcfDyMtOL0Q?=
 =?us-ascii?Q?VovFxuJFB8wiaNwoiFdhr8O06kg953Uh0EFloVNExNkp0nDW7QgTmzFjet4I?=
 =?us-ascii?Q?YeGaMVjDptkCsUAe/wGsb+YDRBohE34JrBRQJVgLveXvWDmcXmmF+puHEFWx?=
 =?us-ascii?Q?IyMglnAer3eoNPWfK/6kbX4jckOdA1VpFlkyMOUgeEgb9JUMcdILBSmPO4Bd?=
 =?us-ascii?Q?AKSLbNPhZSt6qebBZ0bCEcR8QzNG9PPg3hmJTxNvvwUBuDpUgSfBtLIPATxl?=
 =?us-ascii?Q?q328jGLeSMe44wnmnZPkrbE6pe2HQrJfudwi/d5/ppUBvikR890bGk0tUqir?=
 =?us-ascii?Q?0ZuJvAcgo1vKjusJkefebGwmhtOR3SNQ3pwwm8tM9UzavMG1T5Jug2fBGqZ3?=
 =?us-ascii?Q?ucBs+gmthFFjFaf7n3/dQkxdx/ambRN4Oncvxhn2UiOCqCOPE1gTKzKIn36I?=
 =?us-ascii?Q?DdAr3dRQCRo+zZLbwZjMInXoTcDRF9TLYR84AVRv5EvfU7g3G58d1xysu3ql?=
 =?us-ascii?Q?rNJj7tEv/QCOzUlA2ENynwqfI5JQu7pyjDM5trbfSwDKakXZOI/tymabUjup?=
 =?us-ascii?Q?oXz0/o2DfYd/Its1A6qZDZWVsVo/14Gl+T7sWiLOABde4Fl4KELzIAx+MuJG?=
 =?us-ascii?Q?oG4ArvqvxUSP1ffL7FCchL9P7t+I3t8m4+stXFH8oaoW2/6YoBeJdL1zppjs?=
 =?us-ascii?Q?K6L902pib40BBv4d4RbOTaW5DfTb1erxhRgRnzvz9v4oIRJJmENlRRpRukd2?=
 =?us-ascii?Q?PIz3I6PJwQqzFlqQUyVoixM5+W8itdr0tHHaxP8uEvHjqiTPCaN64XWxvZT3?=
 =?us-ascii?Q?SRw4SU3KLd91LtFg8PfRSc3w3bf6PAF+VfrsVdT31Q1BfCAYwqqY4mqecHEj?=
 =?us-ascii?Q?opcHRI4MWQG0Ka43ntBofHnmFl80sUhvW+/APnm/X7rQKKV0940uYuPlDoPx?=
 =?us-ascii?Q?pM1wrWUBiJtHfnqnt1AQiZKD3Q7Rk119vtxI2fyN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c35e75-8994-48c1-795c-08db72e618d4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 06:01:18.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D114QoJSodov8cy4iQP5NWVuf0zeNiIhaRcHmc9iM9LFEpTl5z1l1rBL/BPWH59OwFIzAxlDBQ2twprX8Wsphw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 03:29:27PM +0800, Chen Yu wrote:
> Hi Gautham,

[..snip..]

> >
> I have an idea to limit scan depth for newidle balance for big domains.
> These domains should have CPUs higher than/equals to LLC(MC domain).
> However it seems that in current kernel only domain with SD_SHARE_PKG_RESOURCES
> flag set will have the shared struct sched_domain_shared among the CPUs in this
> domain. And this is reasonable because the cost to access the struct sched_domain_shared
> is lower if the CPUs share cache.

Yes, this was a conscious choice. But now, we may need to explore
using it and consider the trade-off between cachelines bouncing across
LLCs while updating sd_shared on higher domains (I would still prefer
limiting it to below the NUMA domain!) vs having to recompute stuff at
the higher domains, if something has been recently computed for this
level by some other CPU in the domain.

> Since ILB_UTIL relies on the sched_domain_shared
> to get the scan depth, I removed the restriction of SD_SHARE_PKG_RESOURCES
> during sched_domain_shared assignment.

That's what Prateek was exploring as well. I wonder however, if we
should have sd_shared defined only for non-NUMA domains.

> If non-LLC domain's sched_domain_shared is only used for ILB_UTIL,
> the overhead should be not too high(only periodic load balance would
> write to sched_domain_shared).
> Here is a untest patch which shows what
> I'm thinking of, and I'll do some refinement based on this:

Thanks a lot for the patch. I will add it to our test queue.

--
Thanks and Regards
gautham.
