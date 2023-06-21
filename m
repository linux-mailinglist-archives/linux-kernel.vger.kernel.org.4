Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA3A737937
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjFUCf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFUCfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:35:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF54B4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687314950; x=1718850950;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JVvQST5dvkSDuVed5oWfHnUUwlzGo7ZA66zyXpCcK24=;
  b=hVNdOeVbQcAxNWTIuzacfWNi9uAWT12UAQMHXPaseSUEifuWT7BtNJwO
   0cfYJIKol9KkK4cfHDC+1Gc0hojSco3c09mnUg+vXE1IbYGzm5UobABKo
   sRY0wU13K749FsVRQL0azW8eJUYX36drtQN1K5ursmOHe/M/oIETns0DS
   b3uDeMSOLfqHsox8O/rMmtgIw79Bup0aVW6zO32J7cXD8GGdOhKHyYgVt
   TJwvml0dQkRWwJab64ivN6ws/4Vu5me9BTLec5+gOWhs6fJui2Fpm+uzI
   hruAVW2Irlrl3RRtOhdEoIZPIg+BPZeqEQf33aR4ZfgGzRHGmVTLFHhLh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="362586629"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="362586629"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 19:35:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664469293"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="664469293"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 20 Jun 2023 19:35:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 19:35:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 19:35:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 19:35:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 19:35:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YORQah6jcgEz912BMf45DnxWN7Ymcix7sZx4XJp+l/AYOLm7sQuEaseFL1eIT1PcGkeZU76RWxYm1hvjl357TipNf/vzVz6/AwEE4snIdiTx8t2lobEwDFmidQna7oL9ushfIBuXtqhGFmDeMxIvdmgG1oFYzgyefK8/AkHUmQkBPcTWf5b1VEhY4rQxUUu2Uj5Ks5pEVi/IWOIPRXDw5HlZlA2f+94oomB429Nx4UooEM4/vanTc4bR4IOmLTqOgicIzM3FsrhF/Ey3pEuNdbmMkHiVcOU+P2Fi1wWdvypR50sZ+pVLi+NF7pmPdf0NmhEBB3ieQ2XzGQEdH/+D8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgmD7CYoVKoXQ/OgR4b7OIhMrc2YGQ991bTq9f5eHlM=;
 b=cJGzE+FseCVNJAv4xBnDiLFAWdkV0F39hN+EbOrzxgzCFULmYq0h2qNKc2YIFQY0Pu/elaX9bPSnvUJr1qI99mHT6ETvAZebdbEvZqFB8p3HgdHWgz3TE8DX17VuRAYQns7jLeQXT4D9yKzw14nxRIS/EaOkSRZyAXNmrrzSbNkC/ZyM+izPaP/sjGzKF70lNv6ocBHnspPHcmctTKG3My8QTsdv8Qiiv1xNPCUm61gBh/pGHZN1AbBCslwGZmdDppBprIbrGyY78FWg39SrwLfkpEwpyrnsIBzKEiDhtupI1l7/xkiZUXz36thDG+8eoOEes0RveDaSxkvqLnuuuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SJ2PR11MB8401.namprd11.prod.outlook.com (2603:10b6:a03:539::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Wed, 21 Jun
 2023 02:35:46 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a%5]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 02:35:45 +0000
Date:   Wed, 21 Jun 2023 10:35:34 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     David Vernet <void@manifault.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <rostedt@goodmis.org>, <dietmar.eggemann@arm.com>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <joshdon@google.com>,
        <roman.gushchin@linux.dev>, <tj@kernel.org>, <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230621023534.GA236337@ziqianlu-dell>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <20230613083203.GR4253@hirez.programming.kicks-ass.net>
 <20230614043529.GA1942@ziqianlu-dell>
 <20230615000103.GC2883716@maniforge>
 <20230615044917.GA109334@ziqianlu-dell>
 <20230615073153.GA110814@ziqianlu-dell>
 <20230615232605.GB2915572@maniforge>
 <20230616005338.GA115001@ziqianlu-dell>
 <20230620173626.GA3027191@maniforge>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230620173626.GA3027191@maniforge>
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SJ2PR11MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: de642b92-2898-4b61-6623-08db7200368b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/F4TOox4ZARMRlTadcdM2Rm1tefNtoFahS22hDbIjyeoTbE1lLDr47g+oJRlhco74BbDr9/0oaTZnTnB4fl0RCjxw0sXaaFOosKNLtM6N6Jy/PhYwyyDGH+iMz1uRXG4gzIcxfh6q7ESe2HGCpsHb4mYLL1iRl3Vj65RHU2TKqzWJxmeY+yAXItH+Mi6rp6n9fxZJe+Phe4qAokx9BAhsX3loiYmWjrFHzPetNnfFyswclwPE3d+pJ7OYBcrpnAJFPz+YALV+XaUZ3uIJWSIcXLumUpkUzTsYx5pzP/aP7LaEMhGenflXcfLOaFzXGJd7a+cEmgAfKDvCl/l5AiCAAT8pDQBob8UnWCAH4v+ozzujtMBKpMKahjwvT4xDk+pqSmfXeV+nfAtO4ePG0PsV2HGcLc7FisidlIF4JZ5ADxKcsaEj4iYTAw9JHkZAiaSDRDKPSCVdkzVRSvDXq5UT69BIwpCCoQzoDmsZ7+xSgh+NR6YrM16GBXHAzS1WRwytS1e4DiNJfOoaNvWfC4bLmkp25Ebm6bndR4d0efCRRmxm2c1Al8XEResE7CMzx3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199021)(5660300002)(8936002)(83380400001)(33716001)(82960400001)(66556008)(33656002)(38100700002)(316002)(41300700001)(6506007)(44832011)(26005)(6916009)(66476007)(2906002)(6486002)(9686003)(66946007)(6512007)(478600001)(7416002)(86362001)(4326008)(8676002)(1076003)(6666004)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jGtM7R3w5QT7XsG67pKReFEMZS3b4ydTgO1Vn9ZtF1PBbkg5jNiYObIfaKcX?=
 =?us-ascii?Q?0n57BjzwMaYOwmCC/vr3jGI0c472BPOEmkde9IiCcsyO4BCbZ84tRgzWnvP4?=
 =?us-ascii?Q?qm4pLOyLayvpJOpJmUILl2NT3kY2abH/ebEYBBD94mTHFLw+Ix6UqQ97Pwj3?=
 =?us-ascii?Q?AtZEuCbg74wwTXQ0GEgR1hFSwnnKPYVM4iVyp3t8W0gwiVL3jFk549A94Tue?=
 =?us-ascii?Q?GdWc+dOb00+fyi1PYKxDPxwZVMBciyaQAiPpOzeFZrFMi4sGRwD9se//PHKK?=
 =?us-ascii?Q?Wlh1jHDPRy2+NH0n5dLyjcHYQJHeZqm1P5E9w1iR86Qo+syiY0G062J/m9ah?=
 =?us-ascii?Q?WNv1pZLsl6gaURh+eAVCk9jNzIje7RygfCKIzN70TF54se6UecC/mnKgu/Zx?=
 =?us-ascii?Q?q0Rozykxrekrc/ukeLgi6P9jxh9jqRjSTBwrBPUrdF/jiANjydPsaFyWrT+h?=
 =?us-ascii?Q?1t+cjue9TRSst/V9E1h0VhJqUIHLBhffHtjIqtJhMwBvNkHIXDDMKGCeCsag?=
 =?us-ascii?Q?erTOPCxG2s6GR6D8PzEGEkVslPWUCcmHFBp19oZ5/AWLSHLUzeMVG/KJLrcK?=
 =?us-ascii?Q?h6AzSYTdwX446yCsh1GytB5szZRFw8o3BSG/wKNHypi98sUcO4VekACFBPM8?=
 =?us-ascii?Q?DVuiyBj4SgMB8veFhzKVaGyimwSp34BQXNtGsDYF2BsEb5Z4K6hrTBtYhZW6?=
 =?us-ascii?Q?x3o3hldY2KnCyn17ziN00Nb31FMPR5LtL3o2ZuxC1gP4LiPknL+mCH5LVCQW?=
 =?us-ascii?Q?ou+Kov8nDQyAMyZCJLpiVTNNRCU6SN/JeWXQE+q+uTo/m/zQUgzatLmd6jwy?=
 =?us-ascii?Q?fTGe1OzXQU+ICQ7VgGlcKLRIBrXGPyiiM6DSY+8WnF7tNey6KOv6IHfuak/r?=
 =?us-ascii?Q?zvaj+spS6JDY5y9k5h/8jhi1YxCrQpcGKCnCd6ZUFnEBi+pRnvhI08BFTuAJ?=
 =?us-ascii?Q?o0A8e+L/aBqywETCXcGtNMqKzpaxNEhDp4j5EAbcHy7eK7mHoRfNhjoiF85Q?=
 =?us-ascii?Q?iwU8LcPvVZTnCSOpIg9n3xR4+Qsv8c3XiT8xsPldEnXGRkR+PbOw0cKpReBh?=
 =?us-ascii?Q?6lXf75eGbtGUyztAM4uSXUqutuPFSm/9q0Di5yNkTrsZmVvOE0HVYAfFQabB?=
 =?us-ascii?Q?lwOZlRMtFpYazgUWv1gNzlQsloeH7QGcfi+fSK4J6K8Xv9Sx9rMAdJTQUBpG?=
 =?us-ascii?Q?/ptOA5gwkC9DGPkFjKYgIkjvp91DkyoRDtmoYKwtgabvDEEchY1snfpI7P91?=
 =?us-ascii?Q?5IzCClopB+b6eBKcc5wTR24HPB2qU0qxxo8lv2xknD7Rzt2zxm66OpWM6y3G?=
 =?us-ascii?Q?Zl+9Jz9JpigkvUfz6U4CYZnSAxwYMamObsUOjR2X8gyWkxax4KhZE+yyN++8?=
 =?us-ascii?Q?sIbW5mrmwkvuZvqcnbjCTWEKelPBIFTwBtdNaTp0KCKWSZtLlCvPsDedwwcC?=
 =?us-ascii?Q?LOfsGDnyAXpLD2YHtcXvM3WCG3ujEMtyKDs3CfQv0b352ovfOUQpXBaSvqJe?=
 =?us-ascii?Q?Sj49V85iqPc7jJN8cvWVs1qxtF2ThA3Hnk4c3vMnoIfpQsGyMhM9MMU+PeEL?=
 =?us-ascii?Q?jBrwETkE4IL01w8beKXKkUtbLhf6K6s24Ve8+2zz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de642b92-2898-4b61-6623-08db7200368b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 02:35:45.0021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PbmMYM9HqRHxpD8qN2YJNOJHGHBrRqT7ictPLex7hsqDeu/NPjX6CrugZ48d+TunpohQ0cR4RipjXATYubeew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8401
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 12:36:26PM -0500, David Vernet wrote:
> On Fri, Jun 16, 2023 at 08:53:38AM +0800, Aaron Lu wrote:
> > I also tried that on the 18cores/36threads/LLC Skylake and the contention
> > is indeed much smaller than UDP_RR:
> > 
> >      7.30%     7.29%  [kernel.vmlinux]      [k]      native_queued_spin_lock_slowpath
> > 
> > But I wouldn't say it's entirely gone. Also consider Skylake has a lot
> > fewer cores per LLC than later Intel servers like Icelake and Sapphire
> > Rapids and I expect things would be worse on those two machines.
> 
> I cannot reproduce this contention locally, even on a slightly larger

With netperf client number equal to nr_cpu?

> Skylake. Not really sure what to make of the difference here. Perhaps
> it's because you're running with CONFIG_SCHED_CORE=y? What is the

Yes I had that config on but I didn't tag any tasks or groups.

> change in throughput when you run the default workload on your SKL?

The throughput dropped a little with SWQUEUE:

                 avg_throughput    native_queued_spin_lock_slowpath%
NO_SWQUEUE:      9528.061111111108      0.09%
SWQUEUE:         8984.369722222222      8.05%

avg_throughput: average throughput of all netperf client's throughput,
higher is better.

I run this workload like this:
"
netserver

for i in `seq 72`; do
        netperf -l 60 -n 72 -6 &
done

sleep 30
perf record -ag -e cycles:pp -- sleep 5 &

wait
"
(the '-n 72' should be redundant but I just keep it there)

Thanks,
Aaron
