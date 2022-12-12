Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF1964A36E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiLLOdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiLLOds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:33:48 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F4011A1A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 06:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670855627; x=1702391627;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M31HwumFCX/+bsv5jiTYGwZAw9JC4OM9ej4ZlLVCAaA=;
  b=cpyeeEb+J7zRNEQKnhn8O55XdUCr+1kMIYxY1p/vIsIk5T0w6h7uYsDS
   kEnlGf5KoJQuqJzL+D7ghM7A+xi/YGQ7qNtxQA2USuOEU9qAIQ/w1qm7T
   dhFwHl32EYYNZapPFWcWEVAvLV/3QpJYXIO1UeOdGYg1ysTAJNu1/sK4u
   OB8hrsI5aUdKtOSUDsUDTfDbs/m9cz9c0ZBxz/yx8hZe3MZwoaqQjQ2Nn
   klFtzHu27GXxOKpfVuYTfM1zPBMCxNsK2kPDXVfyhXydJdJdoi7OJLHdx
   ruFz1xZsHajo7cgkHN1pM14iVT6XH4S3wq9dnzCjasTEPAREDYsyAJm42
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="380074582"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="380074582"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 06:33:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="790512467"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="790512467"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 12 Dec 2022 06:33:36 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 06:33:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 06:33:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 06:33:35 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 12 Dec 2022 06:33:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTZC9tLddZ+hmYhxxFr8ZuCtRxcYnPvQ/YZRGs7dVveERVMZtcHw93g2h+GwjgsfTsJ0tye3CmPVDrV0WjaEZ6rESMBfqYB9llJNXSOLWuyLQ/o+Ricw+Nl/4+x5GJVq2/u+e9nk+Ci0k54hHdm5fwWcC86J1RrELt2OitIlk2JGTCKsiAC/uH2I1bP838YERJV65LW3zStjZeTn0F8jNRsgMfuwOZHJkyGH8lRTnEm0qeFsrr9WEA5MM3tORz4Z51Cw0Z0H4jjpgKCXIR4DzO/Q7DxfZ1kS1kgraRS+ETwhcf0OUiNoTx1YI5t7/S7smu9erbwWUmPW4A19YGhXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcO4t1gErIivGJXu+15KbWZ+ZgQkb4tPODc8zRQkq10=;
 b=R7hJ8pcDM17mVNDJWU+Omq6JkRAH+HpzQudAMWo8+O8WLanqx492AfWveqAI7lh9xCmrsmkT1p1BsMC+903j/rnQJeZA7w1dTfyJNaa+6Vp7p5FAYpnSsHwEZJYqkUnM3KFUlqX7iT98VBQ5S8kbRGTRW+NeRyUP128bn3Y1soQLNXNH/XZfYtF9jKCR+3RbtsTG9A5iJodRnkLMaX/Tvxv5g/Dq2V9MLWIZPYXEjJOpMoQAN/jvXcY+0xWmenmp8mA6egwz+Co+rUEUw5oONVyEPGsdobQ2RAa7LfWzUSw/IY35dMWvc7QumpapzqjMP4tlO0SRwS/mVIhPGksMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA1PR11MB6872.namprd11.prod.outlook.com (2603:10b6:806:2b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 14:33:33 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7%7]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 14:33:33 +0000
Date:   Mon, 12 Dec 2022 22:33:05 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <yangyicong@hisilicon.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tim Chen" <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        "Tianchen Ding" <dtcccc@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>, Josh Don <joshdon@google.com>
Subject: Re: [PATCH v3 1/2] sched/fair: Introduce short duration task check
Message-ID: <Y5c7oTIRIQYYkdW1@chenyu5-mobl1>
References: <Y4r/iuqyLG4MOK4d@chenyu5-mobl1>
 <3A5DA66F-4330-4FC4-9229-998CF98F663E@joelfernandes.org>
 <Y42uH5fglluWYOm7@chenyu5-mobl1>
 <CAKfTPtA61DDk-VbNDvAycp8Et5fTwaOS=Q3559rBF7QDHDpJfQ@mail.gmail.com>
 <CABk29Nuc+VVOpAwFsbBo+OppayszebT29Hadc8qK-xeyZpY6NQ@mail.gmail.com>
 <Y5CiN010QAwklahh@chenyu5-mobl1>
 <e0b20fe3-6528-41ca-f53f-d78e76cd122a@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e0b20fe3-6528-41ca-f53f-d78e76cd122a@huawei.com>
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA1PR11MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb74156-9ff7-4344-176f-08dadc4dd888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/Znvh9H/Z9EON62CWVLla1mEikwkMxjdCf4pP5YvyaYOxmLAxmWCxFqfev8oIGOyRxPPg6ok/MpoGwNaEs2kii4Hu8F9qralAXcuM/up1b+ldS7YG/rqhrER28OLCNacte8+gkXjZFNFg0yhw6aDLyV2qGqBkdbSjEbJtd7Goy8KFQYFySWdVw4jpb7C1Iz7TcQRbMOmuJJdst4vAGRYLFWXJpyawkaupD27qbblzneOjiIZANt2D00pI8N4d50yg0ud1a8iQsLTn5RTyXrKf22XtrAbplebbFKuV5UbnbwWikjl+ajVCr83ALn6Nhnaq0COIO73EmRS0q2s/dZjm1NItjlfAp3iFEl9yFNp/daSQwg9BZdOa1jTsED1NqOI/kalYCRzTJJNmzsPO10jxg/PiQC7mz06G9Q/vbCrk9k+knzKeVIwtB2RHQOg9sRmra6vlUlM/ckD6wTEwoHDqN0A1w3twAicikb3oUb8F0sPeEEdhJEU9Dkf+dRdEXZcD5kivxLsp1Bq3W9rf1i5j5HwwMLRfH8mxu7EFHanEFkSxWikQZj8FVqvWFnGucxnCkZvuM6/TaoJPiIo8lAJC80RaaBUWWz0yodxKuHxQor2lRGoTIj69aZpU7ZYXxXtuSSbFczy5omm36pGU4bfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(66476007)(2906002)(86362001)(6916009)(4001150100001)(54906003)(83380400001)(5660300002)(7416002)(4326008)(8936002)(38100700002)(316002)(66556008)(8676002)(66946007)(41300700001)(9686003)(33716001)(6486002)(6506007)(53546011)(186003)(6512007)(82960400001)(478600001)(26005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WpkidtiDLf8J+U3zIrK3Pk8+8Os1Zo1O869c0m66JBLGb8L/sMJ7XBfsec38?=
 =?us-ascii?Q?PoEcB873fSNTes+uWUKDveBpidDVMP4kw+IgHtc2M28i54bVLK9QQ9PnY9j2?=
 =?us-ascii?Q?e7wwd54L96xUIse+ZTE72hJOHeARNAsdaJYvGgmw4vb5j6w5kiP2TRp299YR?=
 =?us-ascii?Q?l/9ajV1mb5YAYjQPNrJhq+iHvyDYQXJlLwYjg1xEGcv59OYO48zZNFi+5sBr?=
 =?us-ascii?Q?ahV3fpTfQmj5jXtYgqdTGvKWoNGDvW8Z956WD0D0WHCivTbyO5nyZJ6mmDqT?=
 =?us-ascii?Q?fDYwgLyprle0M3WzJUn7R2foQNn6n8kxagJcf5R4/OOGmRRlhixn7d1X4Hfo?=
 =?us-ascii?Q?lRN8dmKtuRsTUMhTsVHqlRUzDwWKIz4erV8ykLyRBRy6mtt4nvnHOCO8UcFn?=
 =?us-ascii?Q?C3w4bFGAgkrTbTu1bbY2QcGE63i2/JubVzsn+RNWsTmMw950ouc7UY/nnnuu?=
 =?us-ascii?Q?kU46z8OJFbgPoB7xay+mPWyT8Ok5Ot08F+nUe8OY538QPoH2R9uGLoq2BVHZ?=
 =?us-ascii?Q?WZuAvMDaEKIhW/Hm4eXekqp15s//ciuXusmrr0AknKmb0vSXy2WMIYLkr4T4?=
 =?us-ascii?Q?eIVGXogf/cSaJsfLOmaZJrE5q1wD8W0j57sC0rs5iTtRvedF8Yd67LU6+t7T?=
 =?us-ascii?Q?2SgtqjqqQYWJzAxBk2v5S27XakbLe6uzM3A62aGp36FeOrM6PGiHOEEuc8Yx?=
 =?us-ascii?Q?ro+D+MBuVOHdFThN6ms5L6cs9JVyfV+YTjsYOIIL6TsVKRqcfyd6FhFfzPo+?=
 =?us-ascii?Q?4MVNKyV2ru/mS718H/Fq8UDYX7hicdkrNr3vz1g6yyBxZ4BQ72w5SHhlbylW?=
 =?us-ascii?Q?Tej7Lskl9HrtzuRZL/uKGVOtUZm9LkAPhcVFDf+ryWMSOr4j6bU7DzvYFywu?=
 =?us-ascii?Q?34Bz+dXSH774hsg7xy6kbv4vIvGZo4yL00Dp/NbRee/CKUjSm/Z1+C77gH3l?=
 =?us-ascii?Q?4DfP8IpK12LtN5//TFwBlOtvL0rkRoahnCmfqgorvyOkt7GX1eFMi+K7kYYs?=
 =?us-ascii?Q?CvHZI/q5LEyPlxWTgNu6HHz8bfz8F991j9+FcO6BTobGvEJ8X2P4nJm/lfZJ?=
 =?us-ascii?Q?c3GzWtcF10ZpmkHoJ1Q9utx7RpOIpvwzpvHoA2LQeRkt6eRvB4Dyuu/TVb6V?=
 =?us-ascii?Q?QHo2oUMxo1J0/VBZowjanegZHUwWHuO12MWlJogibcR/MLZzjGAasKZUKCN8?=
 =?us-ascii?Q?ibgA9IlfGoJQKvi8PJcUR8q+26MR4wG9opvc6SX+c1o6UpsLHFD2eu6+Zwsc?=
 =?us-ascii?Q?1wyKLbUFo4adtLHPD9GkYWYZUW+TNDUO6h01SxmX8hpRGKji9F+Q/KwUcDt6?=
 =?us-ascii?Q?/78JAb8HOJ/ke9IMMazG/mZwdb3X5I7wnL2f/cj53Bg8Dx+0/x8YD5q3vJ4d?=
 =?us-ascii?Q?Q4nMTqSDRR9VaF6sOGBZb9WqUQZsHKb5vAFm2CjsQ7OpNeckWyRnpy/W0UkG?=
 =?us-ascii?Q?sk4EkvbfiCQagv3y7d0v8t+F1AC0dnvD/ZvI1+2ZTbd4B4xiSOz6mZ/9k7KE?=
 =?us-ascii?Q?8lHK0ZGEL4xXlt3Eojz0MUEEGLLhI1sq4VG0uxil1S6u4m1xWCDF/DZHoWAR?=
 =?us-ascii?Q?QY1J1H2vxSU2ySyLdPjgsTtKmLxXRvlhKzaCaXaw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb74156-9ff7-4344-176f-08dadc4dd888
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 14:33:33.3032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4W6ghviyiHEbkV8rZZkXnoxqJ1xsxt1bn0NRK5qX+l4H5zQVn4NkIek9dPo1ylohZ5vskIbxNa1dsxNpLZ0Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6872
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-12 at 19:22:48 +0800, Yicong Yang wrote:
> On 2022/12/7 22:24, Chen Yu wrote:
> > Hi Josh,
> > On 2022-12-06 at 18:23:47 -0800, Josh Don wrote:
> >>> We don't want to add more dedicated knobs. So using
> >>> sysctl_sched_min_granularity as you are doing in this patch looks ok
> >>
> >> If not a knob, then maybe at least a smaller hardcoded value? Several
> >> milliseconds seems like too long for this optimization; the
> >> opportunity cost of not doing the idle search likely doesn't make
> >> sense if the waker is going to be active for several additional
> >> milliseconds. I would have guessed something on the order of 100us.
> >>
> >> Chen, what is the run duration of tasks in your ping pong example?
> > OK, I'll measure the duration of all the tests and summarize the data later.
> > 
> 
> If we decide to use sysctl_sched_min_granularity as the threshold of a short
> task, can we also export p->se.dur_avg (somewhere like /proc/[pid]/sched)?
> It may be helpful to choose a proper value for sysctl_sched_min_granularity.
This looks reasonable, I can add one in next version.
BTW, I've changed the threshold to (sysctl_sched_min_granularity / 8) in my next
version, as this is the value that fit my previous test case and also not to break
the case Josh mentioned. Also I've changed the place where dur_avg is updated from
put_prev_task() to dequeue_task(), which could fix an issue in v3. Will send v4
out after the test finished.

thanks,
Chenyu
> 
> Thanks.
