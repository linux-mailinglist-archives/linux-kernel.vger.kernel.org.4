Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3451672E344
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242187AbjFMMpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241943AbjFMMpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:45:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7221B10E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686660299; x=1718196299;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ESfnpC16jgVn3r4e/BTqqVTxpjDWppiDRnYepS32HBQ=;
  b=nKAOcgqS3LEusmAaIQ9ttM961thjDFzkJFG3qopy8q//5t0xHNYsxEtQ
   u7SmG4LDNU7vtb9l0nsdhTbbS6bx/KLUB7W0PqJsRlOCLSByHyAbQSIkO
   tMWLDZY0EVf2YMOETCxgltSxjEC2z9uJG8gHJSPuqiz6jekg9eeGpO3mH
   gieGVSfIAPNYDjHYeoZJks3OfgqIy3nF5Z4U4kPLSh11Evqj4vBoEzsgA
   XAY7XWmQFIk9rh1cTPUN08lyny73I+xgW3zl783VW2r6bZ/Ee7zI6BwJT
   jQc0wJn6GrkCKCOUSRzUtusl0peon/EXJzY+DtCebnQpXDMi3TR5WR0z6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="337955438"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="337955438"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:44:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885835997"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="885835997"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 13 Jun 2023 05:44:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 05:44:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 05:44:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 05:44:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 05:44:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKUiGPIJqJKYD0+YscoJhOxuHBzr0V9ZGMXOH7WKTeineAvqkY9QiekKfSuDKJ7D0plPTbIChIj8P17d9wVTtbpalzUK/AA5BHJo0zIg59Hx8Uxum2MxKrfWdJm4MF/IJmui15xh5/RwgSDfISP3Gs79JE66EjvwVo6yeeAQei35Z+mBnosBFhKh66MvnJ/NOImMs1ffasfP5cWz05gzJBw6dW58KxI7IbcFLY0qWq0iQiLk4oyE62rNlbV425Ph0XZqslgLKghEBBGC1/cFPl+AyNYm11stJQk+SH9S0xZ8s0yTAJ2r+fMP9xGshR7iuTj1+5cp/DQQtjvZF/n8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oultCHej7IuCA6PaTILtJNpLQ93cQaYpIpAcuTfk2CU=;
 b=MfcgY9cCeUF9iZNsnQ1ZCTx1N+/m4NNKTDATaOhfQCDrr6yCBOCSbx+P/TE8Oj+b0G55Cl6yrOLfWhqGgq+iuuUFS9VgHlRbbrVVsaP1QQ+Stn5FE+afHLU/TDt2DGBEFWxQFijuyPR0WeEC3HAbaLPN7byFV7w1HZp2Dfq5HIr2T2h3tnSFeOs8TGDbFHXTZrz5aRmlzoX3U/k9OROqQ5Ym+9X0LGxGEEr0OaWuaODBN+R/zLtnj97WAdoziWDPgj6zSAN8nG9OW/NMVWHOXuOg5cl3hTpXn2GfuwRF/7p86uWhAWD1ln2oClxOjxl3kQCFCvDSv77c5N2SN8N+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BN9PR11MB5321.namprd11.prod.outlook.com (2603:10b6:408:136::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 12:44:54 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 12:44:54 +0000
Date:   Tue, 13 Jun 2023 20:44:31 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <yangyicong@hisilicon.com>, Peter Zijlstra <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <tim.c.chen@linux.intel.com>, <gautham.shenoy@amd.com>,
        <mgorman@suse.de>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>,
        Barry Song <baohua@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v8 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <ZIhkr5xIijJG6AKF@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230530070253.33306-1-yangyicong@huawei.com>
 <20230530070253.33306-3-yangyicong@huawei.com>
 <20230530115527.GC156198@hirez.programming.kicks-ass.net>
 <8fcba5d4-eea5-d7c4-2bf7-482321b333b7@huawei.com>
 <ce714341-af58-2522-69a8-321f02c82893@huawei.com>
 <ZIFKf2PkIkiRmUaK@chenyu5-mobl2.ccr.corp.intel.com>
 <85e29dd8-60f6-1e84-b3e4-061e5a2a0037@huawei.com>
 <ZIMEEnozzC+Uyluv@chenyu5-mobl2.ccr.corp.intel.com>
 <f534ead9-56cc-d834-90a3-67f8532230ff@huawei.com>
 <be1f2bcd-fe03-2b0a-0754-1054a09663a2@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <be1f2bcd-fe03-2b0a-0754-1054a09663a2@huawei.com>
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BN9PR11MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: 26863f0b-aa7d-48b9-9ffc-08db6c0bfcb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lI/mDpg7ScZjr0cOds0iiAenseCARRZ5g8uf9A9PSaXzvmo/9+CITQy+hJZQ0bglNZoxBfbfxIfsrNsVlE4HXTr6QCuk6oC27Sb+hgbqukH7C/tKH1ovmgUhqMgmXM6FnKA1KA9hc/pjPtJtV0YIvf4DyAkZRwALYLjZ5laiEpTaFBpIc+obYKKQHEafRq5Y5/YM4dBu+sqbc+p/oTAb+E8GN/QikVNNdcsQtrKC6qfXuQQfqIpIog83zLt5zoZwhkLfV+b1qqpDwILduIEKs/K6KDm0/LqKKxG3vOh3Whe0x2PolsftoO4Si0RCNWAVQmRDKIqt6lX0V/9/+gkeIQuVwhkqa17ikIsNJ48so6tD2LQ/OtMoAx10O2OVxb1lt/XJXt+3EhjCpSmvqqfOEQ755jO3JRMRw3jPy+/GQhoM85EOCboml7cEANvcbF4NxOGg5cG+8KY5gBYoxyYllzSzeG6z1lZRZUrTCv6ckOc9xMlqM6rteGqbeO5vnzCUjOwYsB5Dai6Oq6MLZgypWtpF21PXx6iwynNEGALQEUmvwh+Xtw1g+U0ZbfrPWSRTLBTbbmVTWoYQOqHzObvXxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(54906003)(5660300002)(66556008)(4326008)(6916009)(8676002)(316002)(7416002)(66946007)(41300700001)(8936002)(186003)(30864003)(2906002)(478600001)(66476007)(6666004)(966005)(6486002)(6506007)(6512007)(53546011)(26005)(83380400001)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qIOEWUPgz/EMyJ5YiTG6iRuSFZq24bl5Y+u3cECotaQdoZIGMCzsWAzrPmqO?=
 =?us-ascii?Q?uAZKgvWFWanXHOWqpMZPAU9VF6OQDRtj2R+ucGX4k8Omiq66TLyj9yWwj+ER?=
 =?us-ascii?Q?zk1SObs8DngIYImxoLrYZ8MAySPczSlNULDCWHwQMJQ01S6We2OYhVY5HRAY?=
 =?us-ascii?Q?MB3pyrz4XkvvlOEJCp3FVVqxQ741zpGN7OvPnHWtYk1XWqpBsVRlKBy5qNKL?=
 =?us-ascii?Q?WXb9JFf1P+x+J2I274A+DPOZINncZEStm5w8V9KiJTZWhRQFqVedX3zP/q3R?=
 =?us-ascii?Q?du99VngpVeysCGDUoxeLdgqikL0D+O4C6pNKaebpjzGIfKxXDa3Rl7AHKSb4?=
 =?us-ascii?Q?CNFwuUUtFdjHE9SnFV2xPJN+eYNZoYklVGUOkh3+WpktCLB/t1s0tkvmTqG7?=
 =?us-ascii?Q?2PDX3IeU3tX6VOSSvF5/WZ8ElROYkJCclmAYAA0rrvB5nWFDvPge4KD6pAA1?=
 =?us-ascii?Q?cWzTYr+g+nKrrPauHp8EZdENM+mo218qf3M6QfYDrYee/yY5n+IEvIHy3UBK?=
 =?us-ascii?Q?lKqgkOCawm8oWbNYEzP8WqDR20Lpbx6kXKh2ZX60EFRwca1OsOQTNheZUZOT?=
 =?us-ascii?Q?wV9yPatD80hyH8BPT5GFslZzmNmF5AIczfevGVpLxcM0A99OINVSxRX+2zFy?=
 =?us-ascii?Q?Qae2RUC5UKJBICIDCNzf4NEzxcxdDv4uORGNJ/iQieIIqtn/OTgyuszI6R7/?=
 =?us-ascii?Q?6lN8NCDMS397YQTvimbXMejj69cUzPSndtem4Rrb05hR6Fx5N4mvMplYJDBs?=
 =?us-ascii?Q?vUFho9tQJ+YxGVtFdwvT07q/o3VVecg8crjCMhRnF6zqYTmponv7EVTGNSpT?=
 =?us-ascii?Q?Td2hb5PWaiuEzjbGIf4YsTOCv+gOt23510cIw4Q3H4BlG4E6vwOc1eg07IcG?=
 =?us-ascii?Q?PTiBiuzEhrERFs8VgJM1HYzUmbVV/wjnSA9ye4y5ICDTHy7Hexn1VJ4VLcVe?=
 =?us-ascii?Q?kF20UTiR+kchLf4f61ePTC/kC0oa2iHjBqXHuUXpgkyTT8TN3lR4BGacA/cC?=
 =?us-ascii?Q?Xfx7p8DaKBXzzdXSzKN5+DIn5bHcdsKLX39lUCcW1GUFxmvUdmj0tuhkcmbo?=
 =?us-ascii?Q?99yED7jus7CAIlA2KK/EB+7hiWif5G6afJPZtbrIH8uK7pqzYYKG3fNQWuiU?=
 =?us-ascii?Q?XxaoudZ4gGqYPKf9cFBRW/TqO+5Z6czuVSd2gQ6QvWkdzJeQetq6jW+GVzJx?=
 =?us-ascii?Q?Zi4uHQVtuV3Q74lzVVelbGqPFHsUpA+qA3fu5WPns8XIRq5eEXhhT3zCIHyT?=
 =?us-ascii?Q?fKkQVNTDtkd7t/4rr3a3/27R7XlP90wAm76ud2lRB18fOCZYrRtK6UrlmiU/?=
 =?us-ascii?Q?ugFclsZFvKW0Hv9HE+Z9Cy+Ipx+CGsS4gMj94qicwnFIx3OavwIkLTMXicoL?=
 =?us-ascii?Q?YcjSjeAQ3/ECh5ALEDXR4fio+D2ssuj0FRlRN1J7ewC6dna8u5VN/CuT/T50?=
 =?us-ascii?Q?CAwE1F7YeEqQrJGb2aEhY8dFMtANxPEVLgP/QN3UUuc1xkLmnXiUG+DYa7OW?=
 =?us-ascii?Q?Au9SNyHuAylLb5WzdcyKKCr4CEV3ZRRKAFUay0gHkweEaeKSY8a/ProcicTC?=
 =?us-ascii?Q?xeTG7LlGsq/lRFKZqr2FBlaT5eFa8Xl+NDLT/UOn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26863f0b-aa7d-48b9-9ffc-08db6c0bfcb4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 12:44:54.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txUOnr8JL5QCo2tT2EWQC+fjfbCSMJaOGIAkwz/OY3rn11R9JIV5prBWm21lYRiPN+FGo5yiqk7ehWI4nTTotA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5321
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-13 at 16:09:17 +0800, Yicong Yang wrote:
> On 2023/6/13 15:36, Yicong Yang wrote:
> > On 2023/6/9 18:50, Chen Yu wrote:
> >> On 2023-06-08 at 14:45:54 +0800, Yicong Yang wrote:
> >>> On 2023/6/8 11:26, Chen Yu wrote:
> >>>> On 2023-05-31 at 16:21:00 +0800, Yicong Yang wrote:
> >>>>> On 2023/5/30 22:39, Yicong Yang wrote:
> >>>>>> On 2023/5/30 19:55, Peter Zijlstra wrote:
> >>>>>>> On Tue, May 30, 2023 at 03:02:53PM +0800, Yicong Yang wrote:
> >>>>>>>
> >>>>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>>>>>> index 373ff5f55884..b8c129ed8b47 100644
> >>>>>>>> --- a/kernel/sched/fair.c
> >>>>>>>> +++ b/kernel/sched/fair.c
> >>>>>>>> @@ -6994,6 +6994,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>>>>>>>  		}
> >>>>>>>>  	}
> >>>>>>>>  
> >>>>>>>> +	if (static_branch_unlikely(&sched_cluster_active)) {
> >>>>>>>> +		struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
> >>>>>>>> +
> >>>>>>>> +		if (sdc) {
> >>>>>>>> +			for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
> >>>>>>>> +				if (!cpumask_test_cpu(cpu, cpus))
> >>>>>>>> +					continue;
> >>>>>>>> +
> >>>>>>>> +				if (has_idle_core) {
> >>>>>>>> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >>>>>>>> +					if ((unsigned int)i < nr_cpumask_bits)
> >>>>>>>> +						return i;
> >>>>>>>> +				} else {
> >>>>>>>> +					if (--nr <= 0)
> >>>>>>>> +						return -1;
> >>>>>>>> +					idle_cpu = __select_idle_cpu(cpu, p);
> >>>>>>>> +					if ((unsigned int)idle_cpu < nr_cpumask_bits)
> >>>>>>>> +						return idle_cpu;
> >>>>>>>> +				}
> >>>>>>>> +			}
> >>>>>>>> +			cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
> >>>>>>>> +		}
> >>>>>>>> +	}
> >>>>>>>
> >>>>>>> Would not this:
> >>>>>>>
> >>>>>>> --- a/kernel/sched/fair.c
> >>>>>>> +++ b/kernel/sched/fair.c
> >>>>>>> @@ -6994,6 +6994,29 @@ static int select_idle_cpu(struct task_s
> >>>>>>>  		}
> >>>>>>>  	}
> >>>>>>>  
> >>>>>>> +	if (static_branch_unlikely(&sched_cluster_active)) {
> >>>>>>> +		struct sched_group *sg = sd->groups;
> >>>>>>> +		if (sg->flags & SD_CLUSTER) {
> >>>>>>> +			for_each_cpu_wrap(cpu, sched_group_span(sg), target+1) {
> >>>>>>> +				if (!cpumask_test_cpu(cpu, cpus))
> >>>>>>> +					continue;
> >>>>>>> +
> >>>>>>> +				if (has_idle_core) {
> >>>>>>> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >>>>>>> +					if ((unsigned)i < nr_cpumask_bits)
> >>>>>>> +						return 1;
> >>>>>>> +				} else {
> >>>>>>> +					if (--nr <= 0)
> >>>>>>> +						return -1;
> >>>>>>> +					idle_cpu = __select_idle_cpu(cpu, p);
> >>>>>>> +					if ((unsigned)idle_cpu < nr_cpumask_bits)
> >>>>>>> +						return idle_cpu;
> >>>>>>> +				}
> >>>>>>> +			}
> >>>>>>> +			cpumask_andnot(cpus, cpus, sched_group_span(sg));
> >>>>>>> +		}
> >>>>>>> +	}
> >>>>>>> +
> >>>>>>>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
> >>>>>>>  		if (has_idle_core) {
> >>>>>>>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >>>>>>>
> >>>>>>> also work? Then we can avoid the extra sd_cluster per-cpu variable.
> >>>>>>>
> >>>>>>
> >>>>>> I thought it will be fine since sg->flags is derived from the child domain. But practically it doesn't.
> >>>>>> Tested on a 2P Skylake server with no clusters, add some debug messages to see how sg->flags appears:
> >>>>>>
> >>>>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> >>>>>> index 69968ed9ffb9..5c443b74abf5 100644
> >>>>>> --- a/kernel/sched/topology.c
> >>>>>> +++ b/kernel/sched/topology.c
> >>>>>> @@ -90,8 +90,8 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
> >>>>>>
> >>>>>>                 cpumask_or(groupmask, groupmask, sched_group_span(group));
> >>>>>>
> >>>>>> -               printk(KERN_CONT " %d:{ span=%*pbl",
> >>>>>> -                               group->sgc->id,
> >>>>>> +               printk(KERN_CONT " %d:{ cluster: %s span=%*pbl",
> >>>>>> +                               group->sgc->id, group->flags & SD_CLUSTER ? "true" : "false",
> >>>>>>                                 cpumask_pr_args(sched_group_span(group)));
> >>>>>>
> >>>>>>                 if ((sd->flags & SD_OVERLAP) &&
> >>>>>>
> >>>>>> Unfortunately the result doesn't match what I expected, the MC domain's sg->flags still marked
> >>>>>> as cluster:
> >>>>>>
> >>>>>> [    8.886099] CPU0 attaching sched-domain(s):
> >>>>>> [    8.889539]  domain-0: span=0,40 level=SMT
> >>>>>> [    8.893538]   groups: 0:{ cluster: false span=0 }, 40:{ cluster: false span=40 }
> >>>>>> [    8.897538]   domain-1: span=0-19,40-59 level=MC
> >>>>>> [    8.901538]    groups: 0:{ cluster: true span=0,40 cap=2048 }, 1:{ cluster: true span=1,41 cap=2048 }, 2:{ cluster: true span=2,42 cap=2048 }, 3:{ cluster: true span=3,43 cap=2048 }, 4:{ cluster: true span=4,44 cap=2048 }, 5:{ cluster: true span=5,45 cap=2048 }, 6:{ cluster: true span=6,46 cap=2048 }, 7:{ cluster: true span=7,47 cap=2048 }, 8:{ cluster: true span=8,48 cap=2048 }, 9:{ cluster: true span=9,49 cap=2048 }, 10:{ cluster: true span=10,50 cap=2048 }, 11:{ cluster: true span=11,51 cap=2048 }, 12:{ cluster: true span=12,52 cap=2048 }, 13:{ cluster: true span=13,53 cap=2048 }, 14:{ cluster: true span=14,54 cap=2048 }, 15:{ cluster: true span=15,55 cap=2048 }, 16:{ cluster: true span=16,56 cap=2048 }, 17:{ cluster: true span=17,57 cap=2048 }, 18:{ cluster: true span=18,58 cap=2048 }, 19:{ cluster: true span=19,59 cap=2048 }
> >>>>>> [    8.905538]    domain-2: span=0-79 level=NUMA
> >>>>>> [    8.909538]     groups: 0:{ cluster: false span=0-19,40-59 cap=40960 }, 20:{ cluster: false span=20-39,60-79 cap=40960 }
> >>>>>>
> >>>>>> I assume we didn't handle the sg->flags correctly on the domain degeneration. Simply checked the code seems
> >>>>>> we've already make sg->flags = 0 on degeneration, maybe I need to check where's wrong.
> >>>>>>
> >>>>>
> >>>>> Currently we only update the groups' flags to 0 for the final lowest domain in [1]. The upper
> >>>>> domains' group won't be updated if degeneration happens. So we cannot use the suggested approach
> >>>>> for cluster scanning and sd_cluster per-cpu variable is still needed.
> >>>>>
> >>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/sched/topology.c?h=v6.4-rc4#n749
> >>>>>
> >>>>> Thanks.
> >>>>>
> >>>>>
> >>>> Is this an issue? Suppose sched domain A's parent domain
> >>>> is B, B's parent sched domain is C. When B degenerates, C's child domain
> >>>> pointer is adjusted to A. However, currently the code does not adjust C's
> >>>> sched groups' flags. Should we adjust C's sched groups flags to be the same
> >>>> as A to keep consistency?
> >>>
> >>> It depends on whether we're going to use it. currently only asym_smt_can_pull_tasks() uses
> >>> it within the SMT so I think update the lowest domain's group flag works. For correctness
> >>> all the domain group's flag should derives from its real child. I tried to solve this at group
> >>> building but seems hard to do, at that time we don't know whether a domain is going to degenerate
> >>> or not since the groups it not built.
> >>>
> >>>>
> >>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> >>>> index 6198fa135176..fe3fd70f2313 100644
> >>>> --- a/kernel/sched/topology.c
> >>>> +++ b/kernel/sched/topology.c
> >>>> @@ -713,14 +713,13 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
> >>>>  
> >>>>  	/* Remove the sched domains which do not contribute to scheduling. */
> >>>>  	for (tmp = sd; tmp; ) {
> >>>> -		struct sched_domain *parent = tmp->parent;
> >>>> +		struct sched_domain *parent = tmp->parent, *pparent;
> >>>>  		if (!parent)
> >>>>  			break;
> >>>>  
> >>>>  		if (sd_parent_degenerate(tmp, parent)) {
> >>>> -			tmp->parent = parent->parent;
> >>>> -			if (parent->parent)
> >>>> -				parent->parent->child = tmp;
> >>>> +			pparent = parent->parent;
> >>>> +			tmp->parent = pparent;
> >>>>  			/*
> >>>>  			 * Transfer SD_PREFER_SIBLING down in case of a
> >>>>  			 * degenerate parent; the spans match for this
> >>>> @@ -728,6 +727,18 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
> >>>>  			 */
> >>>>  			if (parent->flags & SD_PREFER_SIBLING)
> >>>>  				tmp->flags |= SD_PREFER_SIBLING;
> >>>> +
> >>>> +			if (pparent) {
> >>>> +				struct sched_group *sg = pparent->groups;
> >>>> +
> >>>> +				do {
> >>>> +					sg->flags = tmp->flags;
> >>>
> >>> May need to test on some heterogeous platforms. Does it always stand that child domain of CPU from
> >>> remote group have the same flags with @tmp?
> >>>
> >> Good question, for heterogenous platforms sched groups within the same domain might not always
> >> have the same flags, because if group1 and group2 sit in big/small-core child domain, they could
> >> have different balance flags in theory. Maybe only update the local group's flag is accurate.
> >>
> >> I found Tim has proposed a fix for a similar scenario, and it is for SD_SHARE_CPUCAPACITY, and it
> >> should be in tip:
> >> https://lore.kernel.org/lkml/168372654916.404.6677242284447941021.tip-bot2@tip-bot2/
> >> We could adjust it based on his change to remove SD_CLUSTER, or we can
> >> replace groups->flag with tmp->flag directly, in case we have other flags to be
> >> adjusted in the future.
> >>
> > 
> > Thanks for the reference. I think we can handle the SD_CLUSTER in the same way and only update
> > local groups flag should satisfy our needs. I tried to use the correct child domains to build the
> > sched groups then all the groups will have the correct flags, but it'll be a bit more complex.
> > 
> 
> something like below, detect the sched domain degeneration first and try to rebuild the groups if
> necessary.
Not sure if we need to rebuild the groups. With only

if (parent->flags & SD_CLUSTER)
	parent->parent->groups->flags &= ~SD_CLUSTER;

I see the correct flags.

My understanding is that, although remote groups's flag might be incorrect,
later when other sched domain degenerates, these remote groups becomes local
groups for those sched domains, and the flags will be adjusted accordingly.
> Works on a non-cluster machine emulated with QEMU:
> 
> qemu-system-aarch64 \
>         -kernel ${Image} \
>         -smp cores=16,threads=2 \
>         -cpu host --enable-kvm \
>         -m 32G \
>         -object memory-backend-ram,id=node0,size=8G \
>         -object memory-backend-ram,id=node1,size=8G \
>         -object memory-backend-ram,id=node2,size=8G \
>         -object memory-backend-ram,id=node3,size=8G \
>         -numa node,memdev=node0,cpus=0-7,nodeid=0 \
>         -numa node,memdev=node1,cpus=8-15,nodeid=1 \
>         -numa node,memdev=node2,cpus=16-23,nodeid=2 \
>         -numa node,memdev=node3,cpus=24-31,nodeid=3 \
>         -numa dist,src=0,dst=1,val=12 \
>         -numa dist,src=0,dst=2,val=20 \
>         -numa dist,src=0,dst=3,val=22 \
>         -numa dist,src=1,dst=2,val=22 \
>         -numa dist,src=1,dst=3,val=24 \
>         -numa dist,src=2,dst=3,val=12 \
>         -machine virt,iommu=smmuv3 \
>         -net none -initrd ${Rootfs} \
>         -nographic -bios $(pwd)/QEMU_EFI.fd \
>         -append "rdinit=/init console=ttyAMA0 earlycon=pl011,0x9000000 sched_verbose schedstats=enable loglevel=8"
> 
> The flags looks correct:
> [    4.379910] CPU0 attaching sched-domain(s):
> [    4.380540]  domain-0: span=0-1 level=SMT
> [    4.381130]   groups: 0:{ cluster: false span=0 cap=1023 }, 1:{ cluster: false span=1 }
> [    4.382353]   domain-1: span=0-7 level=MC
> [    4.382950]    groups: 0:{ cluster: false span=0-1 cap=2047 }, 2:{ cluster: false span=2-3 cap=2048 }, 4:{ cluster: false span=4-5 cap=2048 }, 6:{ cluster: false span=6-7 cap=2048 }
> [    4.385378]    domain-2: span=0-15 level=NUMA
> [    4.386047]     groups: 0:{ cluster: false span=0-7 cap=8191 }, 8:{ cluster: false span=8-15 cap=8192 }
> [    4.387542]     domain-3: span=0-23 level=NUMA
> [    4.388197]      groups: 0:{ cluster: false span=0-15 cap=16383 }, 16:{ cluster: false span=16-23 cap=8192 }
> [    4.389661]      domain-4: span=0-31 level=NUMA
> [    4.390358]       groups: 0:{ cluster: false span=0-23 mask=0-7 cap=24575 }, 24:{ cluster: false span=16-31 mask=24-31 cap=16384 }
> 
>

I did similar test based on your config:
qemu-system-x86_64 \
        -m 2G \
        -smp 16,threads=2,cores=4,sockets=2 \
        -numa node,mem=1G,cpus=0-7,nodeid=0 \
        -numa node,mem=1G,cpus=8-15,nodeid=1 \
        -kernel bzImage \
        -drive file=./ubuntu.raw,format=raw \
        -append "console=ttyS0 root=/dev/sda5 earlyprintk=serial ignore_loglevel sched_verbose" \
        -cpu host \
        -enable-kvm \
        -nographic

and print the group address as well as the SD_CLUSTER flag:

[    0.208583] CPU0 attaching sched-domain(s):
[    0.208998]  domain-0: span=0-1 level=SMT
[    0.209393]   groups: 0:{ cluster: false group 0xffff9ed3c19e6140 span=0 }, 1:{ cluster: false group 0xffff9ed3c19e6440 span=1 }
[    0.212463]   domain-1: span=0-7 level=MC
[    0.212856]    groups: 0:{ cluster: false group 0xffff9ed3c1a8f3c0 span=0-1 cap=2048 }, 2:{ cluster: true group 0xffff9ed3c1a8fac0 span=2-3 cap=2048 },

Yeah, group 0xffff9ed3c1a8fac0 has SD_CLUSTER, but...

                         4:{ cluster: true group 0xffff9ed3c1a8fe40 span=4-5 cap=2048 }, 6:{ cluster: true group 0xffff9ed3c1a8f700 span=6-7 cap=2048 }
[    0.230214] CPU2 attaching sched-domain(s):
[    0.232462]  domain-0: span=2-3 level=SMT
[    0.232855]   groups: 2:{ cluster: false group 0xffff9ed3c19e66c0 span=2 }, 3:{ cluster: false group 0xffff9ed3c19e6400 span=3 }
[    0.233971]   domain-1: span=0-7 level=MC
[    0.236463]    groups: 2:{ cluster: false group 0xffff9ed3c1a8fac0 span=2-3 cap=2048 }, 4:{ cluster: true group 0xffff9ed3c1a8fe40 span=4-5 cap=2048 },
                          6:{ cluster: true group 0xffff9ed3c1a8f700 span=6-7 cap=2048 }, 0:{ cluster: false group 0xffff9ed3c1a8f3c0 span=0-1 cap=2048 }

group 0xffff9ed3c1a8fac0's SD_CLUSTER flag will be cleared here.


thanks,
Chenyu
