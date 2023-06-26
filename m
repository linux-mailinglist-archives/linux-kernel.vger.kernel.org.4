Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C90473D8E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjFZHwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjFZHwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:52:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4431B0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 00:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687765960; x=1719301960;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=iFohSdtzN2OeoPzPeXEP6zDh0ldRTfaRg/Dt6KvXDZc=;
  b=hW7gUxr6FrbFx2ucSgU8jJdHNmceET2r3zYwLOqD3gUJPjU5JL9yvCbt
   uSln3kCBUm57B/nwF5qNrCjzfhVthQmFO9Dl6hxMkwSjMWYR61/qZcReg
   t2AR9lo4AgsQqMkiwdYbzYtK6iZktbLEc88AXSWqOZ2wAuxv9oCDo+tQB
   wiccbqB/RpgwvtI+1bMYfqFmjd/gNNBIoopG3TxYAzj5+7DYzd5DR9ZJg
   KPEozlNSVeN0xcuSGEl5HEH5Ap7/C+ytUju35f/gtvQLGEYZ9kvV1h5CW
   kJnPz7BFmhUXR+zhTL02F2kMVFHDzQDoLq5fzQsYEJdg+HKxueFtzhIaH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="350976206"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="350976206"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 00:52:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="745699516"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="745699516"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2023 00:52:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 00:52:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 00:52:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 00:52:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 00:52:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGPTyVz3+K2rgwZzmNmjwIp+WltDvNkJE5aE8fToiQCmIFfuyNV58+4a1Brfzo8CyAEi3JDu9kuCznVDbxQHadcMx6mwwUYGtZSb2mKCr61AiQCpeBzpuRebJ7Z9jbnP6pfo1wljh4sI1BBz9VjGdUgRIibZYO1+TYOGyuKs9zMJGGZBNv3oeJ6ollreskBT2v8SF+jC4XuVmcjKMTyYVB2UiwuEDQgMLUy5j5JwdBtfbXJPjSa7bjUnUJfS3PlBuyRIsZBTiSwbZ0c6IKh4+sj0gwZM4G+45gxa9HhYeJu3uZooJSCsA7vrN8iXjh+nTOdB91ojJ6Z6WiOFaiNm+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvED82ujgMkseIcSvkoJmvjWR88taip1SGle1roOrbQ=;
 b=ACKyC25dM/1m92PiRRzX8yI/eeEJsp6GMURIoBU/EBAY3Lewfj4PbQEgQm4umuID0473WkaRF/ds39mgbZze9X329V7tLQ2/4Z9LcbftifrB31fdyBqBOq+p1J80i0YeW75X9lXzyUzmU/jzTFAN2rAK2n1kjUvNUMpQ45XjQd5ztdQbiK3614TuoCMObB8aMV377hYLETPzvvv3M6RC9HepDC3g9h1c6F5A0Ml3YXGiJ9PLcSA0ZoIVpPYVP14MLtfzANuGpQvF+F1NNKLxsIT3gn2r07sryZccxjdzsKUpep+pnwVj8nh+P9V7TqJd23CG8S1KNDFEWBUtBkNiuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DM4PR11MB5344.namprd11.prod.outlook.com (2603:10b6:5:393::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 07:52:36 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 07:52:36 +0000
Date:   Mon, 26 Jun 2023 15:52:17 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
CC:     Deng Pan <pan.deng@intel.com>, <tim.c.chen@intel.com>,
        <peterz@infradead.org>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <tianyou.li@intel.com>,
        <yu.ma@intel.com>, <lipeng.zhu@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Message-ID: <ZJlDsbyNmcKtweg4@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230621081425.420607-1-pan.deng@intel.com>
 <20230626054756.GA435374@ziqianlu-dell>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230626054756.GA435374@ziqianlu-dell>
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DM4PR11MB5344:EE_
X-MS-Office365-Filtering-Correlation-Id: c402bd6e-e7d6-449b-0160-08db761a4e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T9jFghFZcACHQs+6PGrL4xmfERjFWgWDcam99W92nZTvQpk7RPPYmPtTvEdEIhZinXNuRAl4qt/rY0ED92HA8TD1JIHvX29qrxJ9uj3JIeXJmPYnx+EesGVwgnrG4W3Mp/VnPya0HdzPGdMvQ6VwkZLl88gcItN64dXdEO1SP9qVP12tAPh3V/L8bZ6P0h9DgCZVwtnTR/cqw/I5GN803z13/HLN4DqGYvvZ0GEho6EawWVshFx20YVfpdNUBBLs6t9Nv3a8rUd+pCXvr1wMjDl+fLARYGyE8bzYIYoRfUp7V64NiApx8Xf6pVCfKW8/tXlQRk8jHc+DzoM2WzLtPsPutFU8YeIxDv+iPtd+PeB2FhFtqF8hJq31AXUQ/PkyXKjxrkOD6BoxiILDGhPHGsFIZcFXg/HhCWZwGzcM+/1SJBvspCdV2G5xCVg2XSz07im44ARPPwymVDDGW5ia3Dp2RUdKiP/51tlKfs0H1yU4gb80qCJ4LpHY3BIxh22f7uO4u2JYwEd4+3VZWco8htA3MoMGMZNJlzgY3FDiEBuMeYz2Fcn+d+nvEghlOHWh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(82960400001)(86362001)(38100700002)(83380400001)(110136005)(54906003)(41300700001)(6666004)(6486002)(66476007)(4326008)(316002)(66946007)(66556008)(8676002)(6512007)(6506007)(186003)(53546011)(8936002)(26005)(2906002)(478600001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1ZSMnF6RHhGQUV0K1NpVXhVNXo3QkZXNXQ2YzhLVW9NaFVQaW14V3FiTTRo?=
 =?utf-8?B?aGlMVzNtZTBEZjVuMlhwTGRpb0RFOE1TUlk0TVZ2dmcrc0YxRkxjb1BzLzRT?=
 =?utf-8?B?YVpxU0VCT1F3blhySXp6Y1czYThmOWRobWFYNGVBdHlhVWhmdHdCS0ZuUllQ?=
 =?utf-8?B?bHc2S3F6V1YrZ1p6c1JrZnFCU2FpR3hEUVNrVFVrVmRDd093dlhRdk1SNkE5?=
 =?utf-8?B?cVVNZXhtYjEzUTFrTEV6Z2s0Y1VkOFk3STQ4QTJLdXFWM0RRd2ZHdjdtdFJv?=
 =?utf-8?B?OFBzYWF3bW5JQkhWWk9qR1FaUExxQnBZSzcwRVM2cHErVEFla2kzY2Z3THhC?=
 =?utf-8?B?S3phdGVnTTI1MnltdVVCNEdwRTRaS1dwUlRnQnhjVC81Qm9tNXZjUzViSUVa?=
 =?utf-8?B?WEtaalBleWt4TFZlU0JhZTNOZzh0UlJFSGpsSFBYU3pkL0xYQ1dPK25HTjZQ?=
 =?utf-8?B?YW40TjhJelp5UUhKbVdmeEtJd2FjYWxjaWtoUkJOQlUrYklGS3RNd0trZWQr?=
 =?utf-8?B?MmdDQzRscTFqbXZ2eXpRTVdqMGU3cTdyTkNLcUhWUEVaK0sxSGZCTnBhMDEv?=
 =?utf-8?B?OGZhNE93b1ZYakNUcTE2U2VWSTEySVJPQWFSSk1PS2ZRZWVFbWx4ZDdxbVB0?=
 =?utf-8?B?Nkl6L1JDb3d5aEVjWTdGOGhkdHQxNjh4YjJCczVjL0xObDBzNHh0S0h1V2g5?=
 =?utf-8?B?YnltVUFKRVpiOTY3NzVJMTBiZ3JiM0Z5QUJKUDFtQ2JqV0haSU1RamZjQzRr?=
 =?utf-8?B?eS9kR0FwZDRYSmxmNDNCNERjYTFqZUQ2KzRhTlNSOWQrOGoxeWZCTVRKWUJq?=
 =?utf-8?B?SjVCeVZreW5XcWhCSmhzSTJqSXJEQ0ZsOGtsQUpaZTJNc0Z6azR1N3RvSS91?=
 =?utf-8?B?Tm44TXE2S2tBZFpVSXNrVWlPb1k0ci9IWGEyTXA5YXQxcUNSemhmNUc0a3lD?=
 =?utf-8?B?dnRpOWZiR3JlRW1jeFF5WTRxUERoYlBmemhhU0c0a2IyN29icENUZGtJYUxW?=
 =?utf-8?B?Y1JCbUxqclNOL01hZEJmS3RqbUEwWkpiUHdEcE9iSUVzWERvNEwxaFdmSDEz?=
 =?utf-8?B?eDMwK2EvVysxQUdNcVl4NXQwSUpFb2lNK015T0ZVOHRRb2dGZy9kZ3lCRU4x?=
 =?utf-8?B?bWx1R1B6YmNKV2ptOUdvMXoyaEFDUjd3alZIQ3R4Nk1sTDUrM2ZoaFdyVml1?=
 =?utf-8?B?MmlCY1NudlhadXdWeFNMZGdncmtZYndkRmJKYjZ3SStqcjFUSi9LTU9VSmZV?=
 =?utf-8?B?M0pTVzcwSUZlN3hacCtCNkRKaXlQRFBrU2hxRkdjQi90Yml6TzdTRlQxb2RW?=
 =?utf-8?B?NXhxeGdtUnhsUUhleGo2Y0F6S1ZDSzJVZkNPYjEzZGppTVhObXRQWWhXWUZl?=
 =?utf-8?B?QXN0L1VyRVNEM2N5MjBnYlJSU0V6L2M3SmdVZ3crQnkrM3Y2UDRJRk9uSEJF?=
 =?utf-8?B?N2V2aGNtU3NHUGZhVk55eDAvcDhLdHJWaW8xazJQTTh2NVRPV1ZhTFYzeDRm?=
 =?utf-8?B?ZGc4MkYzMTlMdDRNcHZudUhVbEMvVExSQXJDUUoxbUlJdUNiZmRUN1NDMDZS?=
 =?utf-8?B?R0IwcTRBWDEyM2NiUjZEa2taTFcrMFZDYnBhRWlVRXM5aGNYQ1ltTWQ1U0p4?=
 =?utf-8?B?dldKWUw5V3pSTWRIaGVnRS9ZMGx5MGRzUkxuWTFNV3AzRHlhUEU5eTZiRjZH?=
 =?utf-8?B?R09MekNjb1R0TjV0OHBEODdxUEdPZFRDWW96VEYrSlFTQXBueXVsODk5bmVU?=
 =?utf-8?B?OUNJUkFEbHB4ZlhjdGJ3dzdGRXpjUWl3WG5SRGxVa01aWnFGZnJNQUpOcUJ2?=
 =?utf-8?B?dS9nVzNBK1FsL09ZeDBLL0tyVFppSlg2QUJkMHY4WEdZMzhIVnhrV0E1OWFk?=
 =?utf-8?B?MWtPS2xSN3BMK1U0MnF2ZXJHMTU0bGNkbGlqUFNrVUJXTUIvSTBacm1HY0R6?=
 =?utf-8?B?bnhRbGZsdzVmMHFXbE9CeDBhb05abWVHQ3IwRnpMU2NXMVAzV3VISUwrR1hJ?=
 =?utf-8?B?ZHBmU3FlSzFGRGJ0UEMxZndkRS9JZjdNM0M3cVNucGFCeUNvVnhvTVEvOXdG?=
 =?utf-8?B?MThvK1RCdGF1L2dqYzZlWmgrV2RwSTJuQUptOWh2c2hSdXJQUzBTdk9wZEl3?=
 =?utf-8?Q?nqMDbbAJxDbkJTRNbHybrhYYw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c402bd6e-e7d6-449b-0160-08db761a4e76
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 07:52:36.1683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUiK5OPO4twnnsj+XBm79KZizHMt1wCHpW+X1G5AM2AlPC9c9fdTgjA0MaSWhcuQwI8YFM3JYNd6y43V85p0rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5344
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-26 at 13:47:56 +0800, Aaron Lu wrote:
> On Wed, Jun 21, 2023 at 04:14:25PM +0800, Deng Pan wrote:
> > When running UnixBench/Pipe-based Context Switching case, we observed
> > high false sharing for accessing ‘load_avg’ against rt_se and rt_rq
> > when config CONFIG_RT_GROUP_SCHED is turned on.
> > 
> > Pipe-based Context Switching case is a typical sleep/wakeup scenario,
> > in which load_avg is frequenly loaded and stored, at the meantime, rt_se
> > and rt_rq are frequently loaded. Unfortunately, they are in the same
> > cacheline.
> > 
> > This change re-layouts the structure:
> > 1. Move rt_se and rt_rq to a 2nd cacheline.
> > 2. Keep ‘parent’ field in the 2nd cacheline since it's also accessed
> > very often when cgroups are nested, thanks Tim Chen for providing the
> > insight.
> > 
> > Tested on Intel Icelake 2 sockets 80C/160T platform, based on v6.4-rc5.
> > 
> > With this change, Pipe-based Context Switching 160 parallel score is
> > improved ~9.6%, perf record tool reports rt_se and rt_rq access cycles
> > are reduced from ~14.5% to ~0.3%, perf c2c tool shows the false-sharing
> > is resolved as expected:
> 
> I also give it a run on an Icelake and saw similar things when
> CONFIG_RT_GROUP_SCHED is on.
> 
> For hackbench/pipe/thread, set_task_cpu() dropped from 1.67% to 0.51%
> according to perf cycle; for netperf/nr_client=nr_cpu/UDP_RR,
> set_task_cpu() dropped from 5.06% to 1.08%.
> 
> The patch looks good to me, just a nit below.
>
I also saw overall throughput improvements of netperf on Sapphire Rapids
with CONFIG_RT_GROUP_SCHED set, as this platform suffers from C2C so
this patch helps a lot.

netperf
=======
case                    load            baseline(std%)  compare%( std%)
TCP_RR                  56-threads       1.00 (  1.61)   +2.20 (  1.39)
TCP_RR                  112-threads      1.00 (  2.71)   -0.75 (  2.29)
TCP_RR                  168-threads      1.00 (  4.39)  -14.26 (  4.99)
TCP_RR                  224-threads      1.00 (  4.21)   -5.52 (  5.07)
TCP_RR                  280-threads      1.00 (  1.89)  +246.41 ( 61.31)
TCP_RR                  336-threads      1.00 ( 53.49)  +164.89 ( 21.45)
TCP_RR                  392-threads      1.00 ( 42.46)  +162.16 ( 31.33)
TCP_RR                  448-threads      1.00 ( 44.61)  +113.64 ( 41.74)
UDP_RR                  56-threads       1.00 (  3.63)   -1.27 (  3.73)
UDP_RR                  112-threads      1.00 (  7.83)   -4.16 ( 16.57)
UDP_RR                  168-threads      1.00 ( 18.08)  -16.54 ( 17.27)
UDP_RR                  224-threads      1.00 ( 12.60)   -5.77 ( 12.79)
UDP_RR                  280-threads      1.00 (  9.37)   -0.57 ( 15.75)
UDP_RR                  336-threads      1.00 ( 14.87)  +200.81 ( 34.90)
UDP_RR                  392-threads      1.00 ( 38.85)  -10.15 ( 46.04)
UDP_RR                  448-threads      1.00 ( 35.06)   -8.93 ( 55.56)

> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index ec7b3e0a2b20..4fbd4b3a4bdd 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -389,6 +389,19 @@ struct task_group {
> >  #endif
> >  #endif
> >  
> > +	struct rcu_head		rcu;
> > +	struct list_head	list;
> > +
> > +	struct list_head	siblings;
> > +	struct list_head	children;
> > +
> > +	/*
> > +	 * To reduce false sharing, current layout is optimized to make
> > +	 * sure load_avg is in a different cacheline from parent, rt_se
> > +	 * and rt_rq.
> > +	 */
> > +	struct task_group	*parent;
> > +
> 
> I wonder if we can simply do:
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ec7b3e0a2b20..31b73e8d9568 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -385,7 +385,9 @@ struct task_group {
>  	 * it in its own cacheline separated from the fields above which
>  	 * will also be accessed at each tick.
>  	 */
> -	atomic_long_t		load_avg ____cacheline_aligned;
> +	struct {
> +		atomic_long_t		load_avg;
> +	} ____cacheline_aligned_in_smp;
>  #endif
>  #endif
> 
> This way it can make sure there is no false sharing with load_avg no
> matter how the layout of this structure changes in the future.
> 
> Your patch has the advantage of not adding any more padding, thus saves
> some space; the example code above has the advantage of no need to worry
> about future changes that might break the expected alignment, but it
> does make the structure size a little larger(704 -> 768).
>
Looks reasonable that we don't need to adjust the layout in the future.
Besides the cache line alignment, if the task is not a rt one,
why do we have to touch that, I wonder if the following change can avoid that:

thanks,
Chenyu
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ec7b3e0a2b20..067f1310bad2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1958,8 +1958,10 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 #endif
 
 #ifdef CONFIG_RT_GROUP_SCHED
-	p->rt.rt_rq  = tg->rt_rq[cpu];
-	p->rt.parent = tg->rt_se[cpu];
+	if (p->sched_class = &rt_sched_class) {
+		p->rt.rt_rq  = tg->rt_rq[cpu];
+		p->rt.parent = tg->rt_se[cpu];
+	}
 #endif
 }
 
-- 
2.25.1

> Thanks,
> Aaron
> 
> >  #ifdef CONFIG_RT_GROUP_SCHED
> >  	struct sched_rt_entity	**rt_se;
> >  	struct rt_rq		**rt_rq;
> > @@ -396,13 +409,6 @@ struct task_group {
> >  	struct rt_bandwidth	rt_bandwidth;
> >  #endif
> >  
> > -	struct rcu_head		rcu;
> > -	struct list_head	list;
> > -
> > -	struct task_group	*parent;
> > -	struct list_head	siblings;
> > -	struct list_head	children;
> > -
> >  #ifdef CONFIG_SCHED_AUTOGROUP
> >  	struct autogroup	*autogroup;
> >  #endif
> > -- 
> > 2.39.3
> > 
