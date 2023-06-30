Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF34743870
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjF3Jfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjF3JfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:35:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B6319C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 02:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688117718; x=1719653718;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UBIV6ENREld67y4BhVuzzd2UyclSEvaHZdujs5wvrFA=;
  b=OeChO9GkSmakl4dvgSeqNmQO97zK+qeMe2RkpWx1j2Vyoyun57KKPyPd
   Pj/SRFL/Ofjowj/RZDuOeWzw3TetFIaWQ8o74bBanQz6AYLwQRdnKBYNO
   7B5D75pptARTwyRadOrm50ahNtpNQVLPJT3R8f7DCRKyw8mmJp23lmwZu
   hWvCB4abVpHB6ibLyPX4jUGNJ9lFi3CGBOMMbYO7MYtKr+c2+DHOh0lha
   jNr9zAegXBp1Bfbdvz9YaejsNQ6Kr7kkL11V1BRCeC0agrF3KtkFfRQsA
   GowP9cIL4JkAtfhccMEKrI5b5aV+bEjwNEDAMEAfEh/+XPrDxbQL3XwN6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="361202212"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="361202212"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 02:35:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="752936679"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="752936679"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 30 Jun 2023 02:35:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 02:35:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 02:35:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 02:35:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 02:35:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLQudUgQhAWKsf0u9E5lrvim1kvU38SE/8Sp3xO8NHPGJgz6GeKn4Ho2QXCfBYXsXiSVPYyJ7KRRguEEb6xD+XF5DbgniNyZQplEqGuCTg2WNAzCP6vjp5nL1h6+qv/HhBnERKxV+dpoaaQ2B6uaMTqG2b9WaDp1aaX2x7hbIyv6E3J/0UzkHwlvJ7Np2q0yvtCMsWXDDf3mHpYmImg+ZD6O+o1on0K+trpDA2ddHMSpxJcVsrdDznKWiRYrpMAzjsUL7tEAia6tdVO0VNgvLgzDCFdgCglqGtzgJwizhL3RLsnwzzPx9/X1ix64fCuUOQlkBeKQfadMYHSKkFq1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Py1iB9/IRz+x46BgMuJB46zCfKpvksD3nQQXh9W7/yI=;
 b=hZneVSz2TAzIWuwbNCrsytPSNiMpbUrpovYytT0qNlP0gtH5NmqmZj0GO+hQnlZVp/hjR7uvzMutSs+Qvqqgx3zPH4JPiOW3mPiEObAjGCaakWA7pJjE5PSyLi+dNfdD12jdIqMajUvFVByuKV+UR4K1YZpw2qkyJ0Lo2E7UbEFBdmIhjLMMI3pmVfovIAa1DLUFzi1dWTmrAjX+wMvSVDuY7e/J7n7LcDIvdVXpy5gB0rNpwpNniLadymvZagvQR7oQ4G2UmfCCqoCfJlC8Tt0p47VHfPxqctvnRckNQF1EvBRhq459UvIvPSpplqKqphz6mItjmFy7eCddJWkT2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by IA1PR11MB7294.namprd11.prod.outlook.com (2603:10b6:208:429::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 09:35:12 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 09:35:11 +0000
Date:   Fri, 30 Jun 2023 17:35:00 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Deng Pan <pan.deng@intel.com>, <tim.c.chen@intel.com>,
        <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
        <tianyou.li@intel.com>, <yu.ma@intel.com>, <lipeng.zhu@intel.com>,
        <yu.c.chen@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Message-ID: <20230630093500.GA579792@ziqianlu-dell>
References: <20230621081425.420607-1-pan.deng@intel.com>
 <20230626054756.GA435374@ziqianlu-dell>
 <20230627101437.GY4253@hirez.programming.kicks-ass.net>
 <20230628051419.GA565419@ziqianlu-dell>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628051419.GA565419@ziqianlu-dell>
X-ClientProxiedBy: SG2PR03CA0126.apcprd03.prod.outlook.com
 (2603:1096:4:91::30) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|IA1PR11MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d99fdc9-9c23-44b1-5510-08db794d4caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Ovj03NWaW4fp55/9s3BQZkT+Dojap56LCi7sdZuOJOiL97IygXz/NL8v5X1juyWMrBk8e32Ldy9rxBwk3kcFaARJwrmxMHbANG8nhIOB9K3PGOC4OtcC8sqqrDGv4NZSFxqMcCA/vqn7C1LINUzW92ZsXHsXTVpjSfoYk6IOmxaARQ2ogAcch/lER936kzlQSOZyJWmOZ7LvIn0UZVvWzsYYIivyg1staI5b3TO39BZN/x9DK5T3yvYtnbKHtGzgtK9SOrArvRkMwj8pxci6hgslPICfChwBGb/V2PkYZSRjOBN0g4Krl3lIcezaj4nAbWCQAOZDEyIim+DutG+XbnOPV8/ShB92NEcrzsCVilAdbMoJB30fmsfeX8FOWApDHFMLqa3XAEx7M2YbaKr+v+WA0+VKbYwCpQPynf5CsiQj+dxG/X3u568XDgS15ywi5Es809eV52PXkKCq0U9scBpaPxhAyjFEnW16i/LNBXl/hsbHFXX4rfZFMtY5rNV/rxHo8DYDzrnLefbhf38ruyTRMsB3Lk9gKLgPTE1+gjvxLgxR0zfVQ9KwMuu/imN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(33716001)(82960400001)(6666004)(6486002)(186003)(26005)(1076003)(9686003)(6506007)(6512007)(5660300002)(86362001)(33656002)(8676002)(44832011)(2906002)(66946007)(478600001)(54906003)(66556008)(66476007)(38100700002)(8936002)(316002)(4326008)(6916009)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MPtdDusMAFk6VnH5coFCUlHVmy4SSM9epZ3UlwwKtEJkCgxYJrHrpjquvU?=
 =?iso-8859-1?Q?/L79l3BXEl+vpKafbGn7A2hvlkWN56F3ivf3jXUXxcQ0BUJfvzhI1zwhJ+?=
 =?iso-8859-1?Q?aDBSoAZr48H4mlW2OIWyIP64zw+u3dDJ9wELo6oBDR1eR/1kZHhNG/jSEz?=
 =?iso-8859-1?Q?yh9LRsAodv+Y4Ucd6U8x6T9kKaTdxvPd2cXm8opqTx3LaJX9V3YckMJVRu?=
 =?iso-8859-1?Q?cd5trwKy1V1jqAbmTuNsaTnML1qkhSqVcv/PmQSdhproyguHXyg6KadiKV?=
 =?iso-8859-1?Q?539lQz7PwdpRAT59E1xPTWrFULhrjsXnwfPxVjmr15pDyHN7/lRbNX5F2n?=
 =?iso-8859-1?Q?t8L9Z2ASYdNWVOR9dFYZi/s64eAOwef/8My1xqZqemmn7waISgDiiDIn6J?=
 =?iso-8859-1?Q?S45mArsNVgckV1q+4lQobr/tEZ7PJJReAvGGOcR0uSMUMDwEIbuIqzmwxW?=
 =?iso-8859-1?Q?nhmNZjb9fsx3BhitVfcpp42Skl15OrtexKj7C8fnsVLfAyZTgpGgiBsAg+?=
 =?iso-8859-1?Q?GFfIMSk2dLQWIEHnbTEDILIpj/JA1FWzDc8aAvVhV8Vkstxl0afTDHcRsz?=
 =?iso-8859-1?Q?tsnmXyFOcKU0MtSCceYUPqKwu5SWijARnTauqWVPEdG8GaVonb6oNCi+gn?=
 =?iso-8859-1?Q?khA26Ls/T9pSBS63uSpbTPdl0CmHPPUFEP2R3KhK5faAxlC1SlBu2p971M?=
 =?iso-8859-1?Q?eksCq1iKWTOOAKKUQwFjpUfSJNrr37LgNyBSWGju4R75QRlgplO2uwLN0+?=
 =?iso-8859-1?Q?Tf7fFgCs3s25qntL2GcHAOrQhR6OtYTMUVp1AO7UmoGE/o3UNh3lgCpAmb?=
 =?iso-8859-1?Q?+587mMw5LHYyioDLRhqPZbcT0+wvQ22vm7cCIh2//OvxrLbzBFF9Er9QVV?=
 =?iso-8859-1?Q?J3CiCAVwnkzCdgfFLT+qXxjpNJKZZlDM9bBXCrkme9V9EYGrhrAA5geeix?=
 =?iso-8859-1?Q?iqYd7tLS1pEIw5YOFZCqY23pdECMGbzwIuiquPIOKnJ4j7c4fJFhv9d9+A?=
 =?iso-8859-1?Q?fOX7aNo4kgIjwtzGLqwvGHofa1wJpI5ewTsbwV8zpMMKMQc7kD5mwalCZd?=
 =?iso-8859-1?Q?byug/nw1ez5EyRjsLZgJjHpqlWwjDtxXYwvBNrWu0Gh2E1t5X0clSYNOxI?=
 =?iso-8859-1?Q?nUrbKN+Om2/y59DraFzwHQQoMwqhMjZ1N8FUmMvqxm8qHp9dWstwmu5hVn?=
 =?iso-8859-1?Q?oLJNjRMfNET/KT6mN5o+fp7+zif3+7IYOtx2kTHBY8sbCBxaCoC0fbFEAN?=
 =?iso-8859-1?Q?/pOaRNsFcW8JXNcXM0BikwDKXpIVtqGQAF9Lz9y6Y2AcVrU3td0GvF3xUF?=
 =?iso-8859-1?Q?4DK63DWr77Q6B+GN9Q3PERM0T4WTwwEwkzw15Oori55pBys3MZ7mHJfW6Q?=
 =?iso-8859-1?Q?hUSLmAEjQKNHz1JXHeNYKL9rE69C4tIWxbSxyx1nDwMCWquVwvq/wQr4Gj?=
 =?iso-8859-1?Q?9PPHFimL2UP/vbKYRkjjecWvdaMmvAPbugCphzp/OuqHHCj32/62MWtUT8?=
 =?iso-8859-1?Q?qOSKJrFdbE419/FCg+qZi6SQTAJwvB9MooTYcetbbXqfmlWgzHVAVu72EG?=
 =?iso-8859-1?Q?p2pRSBSTFEDM7yEL3YbvH8omb88WBwfWzDZ6RURYZkDcEUbkEQf929cuzP?=
 =?iso-8859-1?Q?tPsL0R9x/GdAxzADvZkLh2RzeBUM1qEiVy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d99fdc9-9c23-44b1-5510-08db794d4caa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:35:11.0617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKE9PWleJfZjl86V6vJ9dmJCVfk9hbbKNB3iztKzlw9QLCjM+jCVumcNRbWdO4auY6W100MSxWx9wX4U4k+1Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7294
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 01:18:34PM +0800, Aaron Lu wrote:
> On Tue, Jun 27, 2023 at 12:14:37PM +0200, Peter Zijlstra wrote:
> > and can we still measure an improvement over this with that approach?
> 
> Let me re-run those tests and see how things change.
> 
> In my previous tests I didn't turn on CONFIG_RT_GROUP_SCHED. To test
> this, I suppose I'll turn CONFIG_RT_GROUP_SCHED on and apply this change
> here that made tg->load_avg in a dedicated cacheline, then see how
> performances change with the "Make tg->load_avg per node" patch. Will
> report back once done.

The test summary is:
- On 2sockets/112cores/224threads SPR, it's still overall a win.
  Transactions of postgres_sysbench improved 47.7%, hackbench improved
  13.5% and netperf improved 39.5%;
- On 2sockets/64cores/128threads Icelake, hackbench and netperf have
  improvement while postgres_sysbench transaction slightly dropped.
  hackbench improved 6.2%, netperf improved 20.3% and transactions of
  postgres_sysbench dropped 1.2%;
- On 2sockets/48cores/96threads CascadeLake, hackbench and netperf are
  roughly flat.

Below are detailed results:

SPR: 2socket/112cores/224threads

postgres_sysbench/1instance/100%(nr_client=nr_cpu)
kernel          transactions(higher is better)
aligned         89623.85±0.35%
per_node       132401.37±0.83%

hackbench/pipe/threads
kernel          time(less is better)
aligned         47.43±0.48%
per_node        41.02±0.69%

netperf/UDP_RR/100%(nr_client=nr_cpu)
kernel          throughput(higher is better)
aligned          9415.97±3.81%
per_node        13131.24±2.67%

ICL: 2sockets/64cores/128threads

postgres_sysbench/1instance/75%
kernel         transactions
aligned        62291.58±0.64%
per_node       61561.40±0.39%

hackbench/pipe/threads
kernel         time
aligned        41.66±0.04%
per_node       39.07±0.36%

netperf/UDP_RR/100%
kernel         throughput
aligned        21365.01±3.32%
per_node       25692.05±2.03%

CSL: 2sockets/48cores/96threads

hackbench/pipe/threads
kernel          time
aligned:        48.78±0.61%
per_node:       48.95±1.06

netperf/UDP_RR/100%
kernel         throughput
aligned        25853.82±11.46%
per_node       25264.38±0.85%

I think I'll spin a new version for the "Make tg->load_avg per-node"
patch with all the information I collected.
