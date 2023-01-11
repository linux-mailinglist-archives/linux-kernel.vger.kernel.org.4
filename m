Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E45665F95
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbjAKPrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbjAKPqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:46:36 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C921C35927;
        Wed, 11 Jan 2023 07:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673451856; x=1704987856;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hAIFfWfngfCoXFSwjI3AUvREs9oiELVVpYsqFfh+3EE=;
  b=WQx/n34UwqJn8FQWbbFZ+l8voqobDXzsIlFCb6/zIL6xJt6oMQNa1r+s
   LIUcjt2/T+Wr+Pnz6xefSC6R+3SjV3R4IqUvp+aB5U6BzQ21Uxvz1P6AM
   aiflur81ulZLrEXgVueHGPeNvDxszVRylNhTAlVHKXysNyS8T8TeD1YsQ
   B1PK3pOoF/aTIxtd34uMnM7a7pvYL9OlJlZvvEREQSzkSCggSgsxCi8Cn
   ZeSTS7I2Q8bVOel6BDl5Df1lmpPtSNRxq1caXYvhJAFoe/r/0Im0I+bf9
   OAKe4F/h1lopY4FOxCfWuznvCYyTNHp6lXjL36pGCdI04bsiJqyo2RIBj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324680356"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="324680356"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 07:43:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="781438184"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="781438184"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 11 Jan 2023 07:43:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 07:43:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 07:43:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 07:43:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 07:43:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VufvObY8HXjznwrg9c2DbOg5aPQ+yxhzikwB1sluEd7KdXcURt0dZAakyZJ1iaUgajrtF/6woixcpltdGeRmqEDphsnajo2ntmdMbyS5rf2mRW/sOz+Hmwp0X28y1G6JRjNt38TD/8xvgPgaFidw4DdnPI9OGaECvbJCLvfm4Ool73V/tQuFKSF6/7NllDkXyvQMKajmSTnR1JE/9BAhA/bB7fEP4iqIWw/EIDV9oazQQddq9/rbSgDQZk6N50WotQhKwyl7DQEIdUuHlvNV0iyHdnevyfhqRg3mwBuZRsTkdfcTluq/QYHvdLV2+X23GUeV/gIEuJFejfXtzXXQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBhLmdIui0HbEaspN75tl+FR2Nqe5JD1Xup76fUjsh0=;
 b=hjIiSbLvuhwAtZFyKL6NNYl8csb8fNM08CgOyDeyDOzhzTxZsyJQuybWC17OHTIBD/XjmUyWBc1dwbs34MLPQuC3DILaDSK6++e43kV+jbK+LufnZRaxP4yWGdDMwrfWqRCGMt16SFjdTKSCUFzCPE0mDq2jYKsuc4ZceUX03DvBVIoH3vgZvqDzN29LoNKkx7NJ23qbigM8rbr1dLgSuVRla2ojwMivsJALpNXrPjmVgG6d2MnwMfBc/f2nJmoz9Z6NXAILRntfspulOL4FTOW4hOSwPi+9c0OgkIBd6HtzTTSeq7wsYa35qjapu5aBCbJZJLVYXHRLDPjoK6gpAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by IA1PR11MB7387.namprd11.prod.outlook.com (2603:10b6:208:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 15:43:03 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%9]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 15:43:03 +0000
Date:   Wed, 11 Jan 2023 07:42:57 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "Moger, Babu" <Babu.Moger@amd.com>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v11 01/13] x86/resctrl: Replace smp_call_function_many()
 with on_each_cpu_mask()
Message-ID: <Y77ZAfhc48W41FGp@a4bf019067fa.jf.intel.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-2-babu.moger@amd.com>
 <Y7yiwOerGiEKAF9i@araj-dh-work>
 <MW3PR12MB4553FFAA412FB741A73009A195FF9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <DS7PR11MB60772F09B9749307CFA0ED0DFCFF9@DS7PR11MB6077.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DS7PR11MB60772F09B9749307CFA0ED0DFCFF9@DS7PR11MB6077.namprd11.prod.outlook.com>
X-ClientProxiedBy: BY3PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:217::31) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|IA1PR11MB7387:EE_
X-MS-Office365-Filtering-Correlation-Id: d53de974-5581-4470-700a-08daf3ea8682
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0X7SPrmL9IUGiTglkVV+gndwrZBdGVgFJIMYYJlIehr1IcChXyX4TtOoqp4gFdVIS63u2KIvD+fO8LgiJYLBwwx9o1hFlr96QdyHve4wY1xTQ/iDfGfndn54s338L2UAWqgCscGgAAZF7nARREmms1Y1xEffOe4zcZ7OhXg2QZVyVbQBt76nDk0T1xAqnjGCi+mkqkLNJu8PFbaUvtZ8ZRas7NjcNgU8Vh/t787nNLZwM+qgnsdEDZ2YRpHw/EABzufwfvxkuWN4OxG7UfnDDV9q7xXcEgnRghPOPpzmIUn7nv5GAuAUUU/FxQELM9jte2oirgTKvMw7au2nO7f4EeBEUnQIN7VaBCwZbKQbafD4/6vvRzy4YUQwktcKDWZLYY/J3OC9ASoQWMqycCUqZejSdNPeDQA3Rz3+qw3fedUuuzJH1Blvsj01EBQdGAPVqHldRiz/yuQE99jicQc6dbSyWxa0xw6Ch3xPq3YdEwqg08sustBM0hD2H7YuFCp6CczfRvfW6H+Kw6ZzdnrWAJDlN4eItDykyTVntaYvby7T4Uz3Tn7cmwqFr5obRRovThvAEM/6pQyfbRe/V46PfQK0tsTdinqA7Qsl+jcTG1wGd/zDsBw20Be+8CcYOg+3K956HfJwf39ooNcd+MqI7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199015)(41300700001)(54906003)(4326008)(316002)(8676002)(66556008)(66476007)(66946007)(7406005)(6862004)(86362001)(83380400001)(82960400001)(5660300002)(6636002)(8936002)(38100700002)(44832011)(7416002)(2906002)(6506007)(6486002)(6512007)(186003)(6666004)(26005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sUWRlILNtSX4yI4/1FhEYdvGs3yV7nt6xz8kFfKecHCbKLIgAI0ZuHP39Iii?=
 =?us-ascii?Q?if+RPBclJ6FP3Yj4supOJ5F/C71Dvy7ceq6WdZsYT8m9P5SNyfqLxpYsxRea?=
 =?us-ascii?Q?E4FT5udWs9pnGw5AYb42WoEEinm4XRLyoYgddGPTpuFd4ayJN4nPjoSUpCI9?=
 =?us-ascii?Q?xb+ja4oNq1V4YdNb4so/VhMZxaPGHhpludl54TpPbrEH8Wtuf+gsEFMu75ms?=
 =?us-ascii?Q?3evDvmjgCZ0M4D/IKAlUVxBqIE9pcGNOO42TB0lriBhHEYMUDb2Zo5uWJI45?=
 =?us-ascii?Q?C6kzHXaQoALwkrSDmsmQCAznB1FKedZyXtPspDYxnOVgRR0UVu0e5zkeCSiK?=
 =?us-ascii?Q?B65PRgzp13N+YFyX3kaIUSE427l5WP4VlTy2ApLAA/G9T+ymLwSuQcZS6LN6?=
 =?us-ascii?Q?FEzhbW05cFCn4FDA64oM9kzViM/zKhsBY2UvGMnag9gTnn8tV1DW5I600tKR?=
 =?us-ascii?Q?vtH3ohl+KGzMfno6KoQUvh2Yvg91jBa5YoyTyOdLXjf43YWn++M+XGjkRsLV?=
 =?us-ascii?Q?JBlonwkd6AGe4ADws15Oo/Ms7NdoCtsGqB8b23+DkYRXGKZqph8ec1Tl7QYv?=
 =?us-ascii?Q?q/tdambMKeln/Vq4iALkLy/HZTS6uOa2ja/GvenxVQI9VISjxWJteqhCRHJA?=
 =?us-ascii?Q?YuRYAo7I4yci4y5kNWkSLbBo/VrDny93wIHiUiObpgkm+VnCGCKbr8pdOFU7?=
 =?us-ascii?Q?rIzCD0nd1CbA5bQ9pNYLu+Ep7wSkcmlVkDwJxk5mq2ZiNxZd4ZV91rc9YZff?=
 =?us-ascii?Q?7KMgR2POZwofSG/XxzhJFd0qcYHW1IDVORpsEL5Rcsd2vKW6nYq1/MMjqFgN?=
 =?us-ascii?Q?llSuDWSvodrQsOvwdHOxUGCcqvNO19hw537rqpPRKxmYNOCC6sohNcD6TRez?=
 =?us-ascii?Q?eCv2d1zQCC5/7PwQE96NExZ41STrekF2n6LSMdkpeyF+4U20UGmXIDft9lZ3?=
 =?us-ascii?Q?jYZkioFl6LcojnimpUCdSOTajb8IeO0AtqkiHDZ80VO8mnq4zCfFZr+1jWfK?=
 =?us-ascii?Q?n4lCAlDKXd2ow9/FEaskOR/wV7WMe6rdIuYSBTUjzgqQrlHA5ue1MDJa1QYE?=
 =?us-ascii?Q?ghljYy1UrFMMn84vAoFruQTrYhifwzxfWjjcwY9//OT8Fe21d8zMn66Q4UPx?=
 =?us-ascii?Q?wwQbCB3eTLRcE0WKW089Q00jiS4DDZ2DQfPtzk8g0uAUEZ/+rsoTfEcbgaXb?=
 =?us-ascii?Q?0X7giXvMTLxKuY3gD3ce/s01PL4zNxC54WNISO7QTsSwa8hbUCThyCdHdxNi?=
 =?us-ascii?Q?g83ltDXka0zYo1SHg7yD8KZzbaVyS7h7JlCfxIShY3PvRsOHAAwuVVyC2emK?=
 =?us-ascii?Q?6UMzNiMIvHFoF9UoGzDpUTcaKNwDgiFiddDrVzN+DR6CTu+9kn18i5yPvgtK?=
 =?us-ascii?Q?5fO4k2hsHkuLV0Fn5M7dZsewL/ztD2Cdsfpp1tYkOHTDYOKHnOyus/gTf+Z+?=
 =?us-ascii?Q?zi5O/pxfrv+Os+Uv8AXIKBWIL/yanvb33x/NyZwPfBlfwM2ci+OkWQjei6JT?=
 =?us-ascii?Q?iuO7ds3MzlLTZ6Okx2wLcurYtae80AnoOgszFMBGD//a6rlbDUu3Ig2d0SDW?=
 =?us-ascii?Q?D8cAv6HRVLtZB9GDy0W3IyxYyKIoTBd4QP10SVpYV7NcZTTwsV0JNpdOhuzk?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d53de974-5581-4470-700a-08daf3ea8682
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 15:43:03.2657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MO8/mmYriMW6sUbD1hj61HfmbdL6/icMNZA6Gp5C5n55RAt4s9Lc3e6VS/PrF9WJ1O5hZysMmnOMWkkqtAVP3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7387
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 12:58:47PM -0800, Tony Luck wrote:
> > > > + /* Update resource control msr on all the CPUs. */
> > > > + on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);
> > >
> > > Do you require these updates to done immediately via an IPI? or can they be
> > > done bit lazy via schedule_on_each_cpu()?
> >
> > I have not experimented with lazy schedule.  At least I know the call
> > update_cpu_closid_rmid should be completed immediately. Otherwise, the
> > result might be inconsistent as the tasks(or CPUs)  could be running on
> > two different closed/rmids before it is updated on all CPUs in the domain.
> 
> I think this does need to happen somewhat urgently. Imagine trying to give
> some extra resources to a CPU bound real-time process. That process will
> keep running with the old resource allocation.

If the resctl was setup before spawning other threads then the thread
starts with the right values from the start, probably inheriting from the
parent?

I wasn't sure if the few ms difference is going to make much material
difference for that process. IPI's does shake things up and introduces
other overheads not related to this process.

Instead of victimizing just this process, we hurt everything else.

Does it make sense to do an experiment and see if there is any other
functional failures?

Cheers,
Ashok
