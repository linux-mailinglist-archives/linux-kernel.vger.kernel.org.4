Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5456F3336
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjEAPxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjEAPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:53:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DB59B
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682956418; x=1714492418;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0iJ32OOMcbZOaI2UCYsPVk//htfN+PdmUwBG93oa9YY=;
  b=eAkA7zATIhrsrJakU7mayP4ePPIky7U7v7t42aNmOZcm0Dkbhml3iByJ
   7bCVPgQmhHQNgbOqdiXi56LFIwUt6K/XOVqc4mqzoiNBEZFpfY9hiDxgh
   I0bHXIS4AXyVEok5PLqMosZ3asEZjE1Z//F47jAjsqTlBPvUIc2HYJn/Y
   jl5Qd7lZQ8Qxc3CkWIFsQw+mY4uXDsPBfqig4+OsmCWGPfuSiFqmhABmy
   am7zfJXFrtMg73AQKCxIJFedvAPB8UmGJ/ewxH45p1CvAYYJHdqRtGd1S
   ATiW44vFGX2k7UgUOw1YFXwBRhZiXa5+/zC3vLkaiBcPzKLkI4y2uhUsX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="413606739"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="413606739"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 08:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="1025669954"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="1025669954"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 01 May 2023 08:53:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 08:53:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 08:53:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 1 May 2023 08:53:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 1 May 2023 08:53:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXJYqwepf0ocOb5B8yn2vGflsNp22HHR7tpTDyU61aMs7EoHQCIifSuhtc32VCD8iaTIkGXLe99zHwmESOAd5HDE8GWf1IDn7BqQQxkA6CMwd4ymFTdQNVVe3RSNUhfj/FUnpA+71CCNQKRm7rVOSeDVGe9HHj8qL0RBBQn8A8MHRLzpv4bgbnh5jYAlP7hFugom9F6ziYVN9YZZOZ2ZD+lbRCzNoJq9AAfPx07bLMfwA7OBX0Dq+dD1LKSvbP6vrBL6QT2vJ8PRqlpN0iG2JG7LmgTwLMH6Hqw/cjjW9VpfHSJMjLL9cAwg+4W2RIGtrAq45JK8zHv3RrDjQzbaPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtYxChsie9vO/EQMFzKtCYAZeFzUkZHKo+snQKJ/BTA=;
 b=TUUmFlNqybQ69gftRaJAfCuQWspW+egDp+IvHADUu3MgxZiGHTztPAaT0e7V1YCGxKzDaJ4NnpfGmRvib6aTGhvOGtWqNUCXfD10xFzy7FQVX214/jhF5vROZjHM20IdeAiFivPR1wsoXA5/MZ38M7g5AJYEjwyz0YNpOqa+oa078vimhZZUhtRuBxnKYGvwWAcOo/o3j3bOI+R8kS0YexDLoJq1Nq/Iwv4Nxa2Uz31bO3xY/fc6A+VMaF/BLLP/GOd+GJWpASnE6uok+8be1uFExdm6bhPcyrUjXhlhmtbVTDPZBvgnRoE3g/t9gwlxWjbC+sa8kdjlHkfpWL9WGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SN7PR11MB7089.namprd11.prod.outlook.com (2603:10b6:806:298::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 15:53:11 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%6]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 15:53:11 +0000
Date:   Mon, 1 May 2023 23:52:47 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>,
        "kernel test robot" <yujie.liu@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/2] sched/fair: Introduce SIS_CURRENT to wake up
 short task on current CPU
Message-ID: <ZE/gT7bkmIFkLdkg@chenyu5-mobl1>
References: <cover.1682661027.git.yu.c.chen@intel.com>
 <4081178486e025c89dbb7cc0e62bbfab95fc794a.1682661027.git.yu.c.chen@intel.com>
 <20230501134827.GB1597538@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230501134827.GB1597538@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SN7PR11MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 2276ab61-8297-4d7a-f58f-08db4a5c2a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhUigttzC3/L4jh7wdL6DVJvlLTrbp+OEndpHNPpV9fs05eUdOMb7h4goYOu3yUXItfRCkuKehPJ1jhSzZ3dkrRMCbNQF3j3oBaA29SlHWWfBXX0559jjzhxxYxiVhKsLoWgtifWscg+WYEnSmzSqlOoN9nmAa6pqspyb/KVhodb2IeS0GBZAuQPKHdegLI2+/HZMHyeqGXiVhCCpg8i/sj6O8iJozicygSMb6Foo8VFVL7jr5G3cRtMe3nZxlOa9kySoNB7qPkFfztRWJyzgxhqCoxprrLszYR9PbG2SX+9+lvgxbs3LbGONUzpWri2O2RelCFfxdof13yq7KWcUVM8UxnXtPWa4xWTagSvQDzIioz9SOWH6+2gnwPveoH1imp5pFlDjCTqMPU7L9Pgu8I6B5UgtIk9KlaRbnJwExx4xMEFRG5OnDdaX8cPZh6MnTDwrxJltAUoh3cj05Kkl5gpMkFOtmbMPZLRQuVQ+DQtYdKQ7e22Gd1GpBt05oIFZxLK/qRTtWa3KERjpCrDznTBzEd3Sf6ILLukkgf0ruU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199021)(316002)(53546011)(9686003)(26005)(33716001)(6512007)(6506007)(8936002)(7416002)(5660300002)(8676002)(86362001)(478600001)(66946007)(66476007)(66556008)(41300700001)(83380400001)(186003)(54906003)(38100700002)(2906002)(82960400001)(6666004)(6486002)(966005)(6916009)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/elce+OND+TDmBGlZ/Ge76vgLIK1OlhGk/Zht5KyFjP4F8AdywxiUJhqDJvP?=
 =?us-ascii?Q?GdvENQHAqDIo6/bQhnUehGjmMtOjQ2A9K2HC7vZChUx9cPOFKUxcMWRolXOl?=
 =?us-ascii?Q?A7mz5Lq2yIv3f2/9CYa6C5Qw+ssyAmeaFB877aszmQHwmYtbYmuPAT8WDfaw?=
 =?us-ascii?Q?R8hkdW+hu7trplB5OuFnOpYM049C1v3Qj3OlUZ1I+1gc/1VF05vy5ZLob+JR?=
 =?us-ascii?Q?o+eBS3CGogsJ61B0b2C6RwDS2dzEETh0G2i5MALrDMGlFDalbP2yHuXFPgf2?=
 =?us-ascii?Q?UthBroRcJFov+22qUpzjn4sKY3mc5F5Ty8rHIsSO4Gu2bKctwVIFwT9iYxcZ?=
 =?us-ascii?Q?y4ydGwmrceDGVYF12+WGCSAgU7gjIAnqfhZkprK4jbiV0VZbxY57BGrD92Kq?=
 =?us-ascii?Q?z2Roko+MgWYdI2imZlOB4TwZ0wEyksfzaDbbGXhiRM/TmkSsmP525lpDbAT+?=
 =?us-ascii?Q?cN56nFD5TWAjqxfjZMDechpiYAjFj7FEbsNvo5RGA6BK0ZAyHFPTkWarxwOK?=
 =?us-ascii?Q?Hy7RWTkzcIPlMSCIXPIVf41tv3JV4UtM8p7vvZbIf6+O3qdUlKheD5+1kKQq?=
 =?us-ascii?Q?7xZj+3TbQXqpwnP+HOUzVZ3ekJNAKL9TlllHedIupo7dqQZTxgSfDhDWkID9?=
 =?us-ascii?Q?YA8+W2OfKAqog8Y80GSruaukscvEqD292ybFqkbGavUH3Knfo3a6pcU//CWO?=
 =?us-ascii?Q?qhwHu/cv/cqnT9zxBiycFqiaCQYuZHH3SnerYKw8y40IgJ/lkAgOn4qZIhmn?=
 =?us-ascii?Q?ZtIvgrhLX4jksrnoUoyz1f6I9eZgskWtkRxzzMUX/FX3vW44f3QONvUN6ANE?=
 =?us-ascii?Q?uXkWOe+PO8oHIVj41Sigk5swuoGXsPmUx3d0ifL3qVNgsBlhfpGITV6DpsPW?=
 =?us-ascii?Q?T76eQ+XS5Qs7+DAnoEGTczirye+AyUTRXegKmyiz2wXRB1d0sDVgl3rpfIzy?=
 =?us-ascii?Q?Br822Fs2ApvT4LueXl9Ly5qXcVfcycFtAyQKFKr7mbsoFuW6QzqKAQrks+Or?=
 =?us-ascii?Q?hUey6b8biTmuzlxprwyo09udm1lLxAxsj8KElap2GTN+H4k124/QYDZ703BW?=
 =?us-ascii?Q?jcBDUNEFzSa1LH1v0n/ITzrovcoBnHsSJQiFolUruscLZAAI17JQMvIk4BbQ?=
 =?us-ascii?Q?3OoRH32FexnQtJtaxcg2qeFFZ3P6p8VjnBm2jxGS4LaWPlxMssVdvKwjBUIK?=
 =?us-ascii?Q?6AfDElw6zCScpRH+rXak08UdEkgWRVW/PEfZciQWcbgdoc+CEPWCSA5zJODG?=
 =?us-ascii?Q?r40RXAQ5R7R0DbdbaGMRpBTPp5SmbpeehhRvyS2uHvdiHGKsiDP6Qjxj9pNF?=
 =?us-ascii?Q?sktem7jQGhiyvNR1UfeUcSFr2P479uF3ZhfWPOBM4oUXwow2cgEL804VBiYr?=
 =?us-ascii?Q?U2Rz013yyWgtKwmXIFAGeWr2A7temiWPVHLxApilIxX8u1lxN5ORB38Dw8Qi?=
 =?us-ascii?Q?XzKrcYIWcCE6iFJAb8yw20VT4Zbv0+lV7atGHxFUAOrNZVrcjs0T0KEt2NL3?=
 =?us-ascii?Q?/pIwP8NQ7WdvDzDj65g27Nr8bNrG90oBbKcVMMkhaXoQBzvs1hYQdmm17q8j?=
 =?us-ascii?Q?kHxITglUGQA5IQTeZGsHEAlra1olnt6WA2VmoTNU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2276ab61-8297-4d7a-f58f-08db4a5c2a0a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 15:53:10.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofSNnA2a3m9c2W384HRJj6TPqQteIl7Bw+S4Cy5F0RHZrc5WGQD6BDkRf80bQ5okxyMqVOmYSedzjjCYVfQmxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7089
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
On 2023-05-01 at 15:48:27 +0200, Peter Zijlstra wrote:
> On Sat, Apr 29, 2023 at 07:16:56AM +0800, Chen Yu wrote:
> > netperf
> > =======
> > case                    load            baseline(std%)  compare%( std%)
> > TCP_RR                  56-threads       1.00 (  1.96)  +15.23 (  4.67)
> > TCP_RR                  112-threads      1.00 (  1.84)  +88.83 (  4.37)
> > TCP_RR                  168-threads      1.00 (  0.41)  +475.45 (  4.45)
> > TCP_RR                  224-threads      1.00 (  0.62)  +806.85 (  3.67)
> > TCP_RR                  280-threads      1.00 ( 65.80)  +162.66 ( 10.26)
> > TCP_RR                  336-threads      1.00 ( 17.30)   -0.19 ( 19.07)
> > TCP_RR                  392-threads      1.00 ( 26.88)   +3.38 ( 28.91)
> > TCP_RR                  448-threads      1.00 ( 36.43)   -0.26 ( 33.72)
> > UDP_RR                  56-threads       1.00 (  7.91)   +3.77 ( 17.48)
> > UDP_RR                  112-threads      1.00 (  2.72)  -15.02 ( 10.78)
> > UDP_RR                  168-threads      1.00 (  8.86)  +131.77 ( 13.30)
> > UDP_RR                  224-threads      1.00 (  9.54)  +178.73 ( 16.75)
> > UDP_RR                  280-threads      1.00 ( 15.40)  +189.69 ( 19.36)
> > UDP_RR                  336-threads      1.00 ( 24.09)   +0.54 ( 22.28)
> > UDP_RR                  392-threads      1.00 ( 39.63)   -3.90 ( 33.77)
> > UDP_RR                  448-threads      1.00 ( 43.57)   +1.57 ( 40.43)
> > 
> > tbench
> > ======
> > case                    load            baseline(std%)  compare%( std%)
> > loopback                56-threads       1.00 (  0.50)  +10.78 (  0.52)
> > loopback                112-threads      1.00 (  0.19)   +2.73 (  0.08)
> > loopback                168-threads      1.00 (  0.09)  +173.72 (  0.47)
> > loopback                224-threads      1.00 (  0.20)   -2.13 (  0.42)
> > loopback                280-threads      1.00 (  0.06)   -0.77 (  0.15)
> > loopback                336-threads      1.00 (  0.14)   -0.08 (  0.08)
> > loopback                392-threads      1.00 (  0.17)   -0.27 (  0.86)
> > loopback                448-threads      1.00 (  0.37)   +0.32 (  0.02)
> 
> So,... I've been poking around with this a bit today and I'm not seeing
> it. On my ancient IVB-EP (2*10*2) with the code as in
> queue/sched/core I get:
> 
> netperf           NO_WA_WEIGHT               NO_SIS_CURRENT
>                                  NO_WA_BIAS             SIS_CURRENT
> -------------------------------------------------------------------
> TCP_SENDFILE-1  : Avg: 40495.7    41899.7    42001      40783.4
> TCP_SENDFILE-10 : Avg: 37218.6    37200.1    37065.1    36604.4
> TCP_SENDFILE-20 : Avg: 21495.1    21516.6    21004.4    21356.9
> TCP_SENDFILE-40 : Avg: 6947.24    7917.64    7079.93    7231.3
> TCP_SENDFILE-80 : Avg: 4081.91    3572.48    3582.98    3615.85
> TCP_STREAM-1    : Avg: 37078.1    34469.4    37134.5    35095.4
> TCP_STREAM-10   : Avg: 31532.1    31265.8    31260.7    31588.1
> TCP_STREAM-20   : Avg: 17848      17914.9    17996.6    17937.4
> TCP_STREAM-40   : Avg: 7844.3     7201.65    7710.4     7790.62
> TCP_STREAM-80   : Avg: 2518.38    2932.74    2601.51    2903.89
> TCP_RR-1        : Avg: 84347.1    81056.2    81167.8    83541.3
> TCP_RR-10       : Avg: 71539.1    72099.5    71123.2    69447.9
> TCP_RR-20       : Avg: 51053.3    50952.4    50905.4    52157.2
> TCP_RR-40       : Avg: 46370.9    46477.5    46289.2    46350.7
> TCP_RR-80       : Avg: 21515.2    22497.9    22024.4    22229.2
> UDP_RR-1        : Avg: 96933      100076     95997.2    96553.3
> UDP_RR-10       : Avg: 83937.3    83054.3    83878.5    78998.6
> UDP_RR-20       : Avg: 61974      61897.5    61838.8    62926
> UDP_RR-40       : Avg: 56708.6    57053.9    56456.1    57115.2
> UDP_RR-80       : Avg: 26950      27895.8    27635.2    27784.8
> UDP_STREAM-1    : Avg: 52808.3    55296.8    52808.2    51908.6
> UDP_STREAM-10   : Avg: 45810      42944.1    43115      43561.2
> UDP_STREAM-20   : Avg: 19212.7    17572.9    18798.7    20066
> UDP_STREAM-40   : Avg: 13105.1    13096.9    13070.5    13110.2
> UDP_STREAM-80   : Avg: 6372.57    6367.96    6248.86    6413.09
> 
> 
> tbench
> 
> NO_WA_WEIGHT, NO_WA_BIAS, NO_SIS_CURRENT
> 
> Throughput  626.57 MB/sec   2 clients   2 procs  max_latency=0.095 ms
> Throughput 1316.08 MB/sec   5 clients   5 procs  max_latency=0.106 ms
> Throughput 1905.19 MB/sec  10 clients  10 procs  max_latency=0.161 ms
> Throughput 2428.05 MB/sec  20 clients  20 procs  max_latency=0.284 ms
> Throughput 2323.16 MB/sec  40 clients  40 procs  max_latency=0.381 ms
> Throughput 2229.93 MB/sec  80 clients  80 procs  max_latency=0.873 ms
> 
> WA_WEIGHT, NO_WA_BIAS, NO_SIS_CURRENT
> 
> Throughput  575.04 MB/sec   2 clients   2 procs  max_latency=0.093 ms
> Throughput 1285.37 MB/sec   5 clients   5 procs  max_latency=0.122 ms
> Throughput 1916.10 MB/sec  10 clients  10 procs  max_latency=0.150 ms
> Throughput 2422.54 MB/sec  20 clients  20 procs  max_latency=0.292 ms
> Throughput 2361.57 MB/sec  40 clients  40 procs  max_latency=0.448 ms
> Throughput 2479.70 MB/sec  80 clients  80 procs  max_latency=1.249 ms
> 
> WA_WEIGHT, WA_BIAS, NO_SIS_CURRENT (aka, mainline)
> 
> Throughput  649.46 MB/sec   2 clients   2 procs  max_latency=0.092 ms
> Throughput 1370.93 MB/sec   5 clients   5 procs  max_latency=0.140 ms
> Throughput 1904.14 MB/sec  10 clients  10 procs  max_latency=0.470 ms
> Throughput 2406.15 MB/sec  20 clients  20 procs  max_latency=0.276 ms
> Throughput 2419.40 MB/sec  40 clients  40 procs  max_latency=0.414 ms
> Throughput 2426.00 MB/sec  80 clients  80 procs  max_latency=1.366 ms
> 
> WA_WEIGHT, WA_BIAS, SIS_CURRENT (aka, with patches on)
> 
> Throughput  646.55 MB/sec   2 clients   2 procs  max_latency=0.104 ms
> Throughput 1361.06 MB/sec   5 clients   5 procs  max_latency=0.100 ms
> Throughput 1889.82 MB/sec  10 clients  10 procs  max_latency=0.154 ms
> Throughput 2406.57 MB/sec  20 clients  20 procs  max_latency=3.667 ms
> Throughput 2318.00 MB/sec  40 clients  40 procs  max_latency=0.390 ms
> Throughput 2384.85 MB/sec  80 clients  80 procs  max_latency=1.371 ms
> 
> 
> So what's going on here? I don't see anything exciting happening at the
> 40 mark. At the same time, I can't seem to reproduce Mike's latency pile
> up either :/
> 
Thank you very much for trying this patch. This patch was found to mainly
benefit system with large number of CPUs in 1 LLC. Previously I tested
it on Sapphire Rapids(2x56C/224T) and Ice Lake Server(2x32C/128T)[1], it
seems to have benefit on them. The benefit seems to come from:
1. reducing the waker stacking among many CPUs within 1 LLC
2. reducing the C2C overhead within 1 LLC
As a comparison, Prateek has tested this patch on the Zen3 platform,
which has 16 threads per LLC and smaller than Sapphire Rapids and Ice
Lake Server. He did not observe too much difference with this patch
applied, but only saw some limited improvement on tbench and Spec.
So far I did not received performance difference from LKP on desktop
test boxes. Let me queue the full test on some desktops to confirm
if this change has any impact on them.

[1] https://lore.kernel.org/lkml/202211021600.ceb04ba9-yujie.liu@intel.com/

thanks,
Chenyu


The original symptom I found was that, there are
quite some idle time(up to 30%) when running will-it-scale context switch
using the same number as the online CPUs. And waking up the task locally
reduce the race condition and reduce the C2C overhead within 1 LLC,
which is more severe on a system with large number of CPUs in 1 LLC.

