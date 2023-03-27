Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618BD6CA6C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjC0OFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjC0OEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:04:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2010BE5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679925884; x=1711461884;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QcBWbmGxLd8Wu+Y42UXrxT/HVOmA3jM/1D83TCCKUac=;
  b=MmCzZ8U3ZZwmldKlFWR7adcaGXq1pbzQ079KKk+55GqZQA5XD4Xbq3LC
   PqO91ixrR7CNUXnG7Cp6/pb8EHoDGp2jDq1LAXUAu7JW7iakLc0U52B23
   xjckhjBQba4NYq/TWwkLpzd2viAhilA5B1mI4PT18DpjMTL9iNOuQmmTs
   Juqi2/p87RJpzMalqtcR8WYcgY35WhtUMSlLJKKf/5wUDP0HU5k3gjzMg
   EZXn6orw2hzXeItvfFzXE97SP3aaTgZpNjNtse21H5dn+pINGvirrBPGr
   peIZpZzsTZbCYqdhNrPVlF2ipQ1VxH3qreaVkcMpQ8eIf14oSaCmam0JA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="340298088"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="340298088"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 07:04:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="713870620"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="713870620"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 27 Mar 2023 07:04:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 07:04:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 07:04:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 07:04:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 07:04:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aX32caX1+KZOSSSrXDFqKGcH9aigFky0KtGm2ypQ5mD9Ztxtfnj0lEiGQqpnb/lGIwfUUFlHFpmER5oZryOZVa3yGFFoxo/yinQHoHFrpY5mVOFTKYQRV99L7CiQT9SEsvcLuwIbane/xPNVM3gi3KarHx/O2cAFMCoab4NGxXx9RS73+5nHCUqzZ4tIIKYazuFHH9IaS3O0QB1RBhIzFl4eUWzwRlaoqoT+1+/XRmwg9oS+G0R9+qX4Q3i2L0bo7WggiXoPSY+5DmZJfVCIihzYi/FQo1q+yqX4UFqQYK+afVXY2iVClBoNyKMjVLcAyVgM3mPsAa+M9P/mbzMy1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPmk+aF8PZtphomENG5l7GeXTOkXva0n+EF4H8bXM+Y=;
 b=WuDrlxMj8hzjXms2S+j/lths09RoHIa8WY+IP3ZTIik/4PfBO6azku7qlabYU5DAZgV74ISlLV/OnAzAbIizS6jQERJKBG41lx6c562M15mKhcDLJk6hy2M+9MW2vWK2Y85FLEV03Xatj1ar18TcfbSke01KJrpxdmzLE4yeAI1MSb9XI5hv8DcvKJa+unl9EDY18XWMcn4vtn9MB2RNM6fxTZFzV0DXkzTkJSFsNJ4slXKAziuUYvwnfMGC6MVhrIwEjEQfAkfve0agkrM/B+S1SY8Xf9uy57eyXogRkWz6P2IIuyW1LsXfcX3I1bpwLY6B6JFLQ27p4dSbrveiTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Mon, 27 Mar
 2023 14:04:36 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 14:04:36 +0000
Date:   Mon, 27 Mar 2023 22:04:25 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: rq lock contention due to commit af7f588d8f73
Message-ID: <20230327140425.GA1090@ziqianlu-desk2>
References: <20230327080502.GA570847@ziqianlu-desk2>
 <b5e09943-36e6-c89b-4701-5af6408223e8@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b5e09943-36e6-c89b-4701-5af6408223e8@efficios.com>
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|MW4PR11MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 8184ab3f-deb0-49ce-1c6e-08db2ecc327e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IyVXkCqr9bq8jYx/rYgJycWjaIoFItCO9UBoZkwgT0GkW3bNuP3gfkNsjUmwB48nDpz3hwEiVZTNnbvCGj0ZL8HgMg8o9XgS+H+N4W+ID6YfGpB2z2rQT1xRHjg+7vCdsnGD8HWkqDnNmWwOhY61e+5Ba90N17kHPjFy4QT0fVH4OmcYS59CT1h/VZT/SM0B1FRvjsaro6rsdRRoC1nQlSYqdFjueXCY6v91iKTBQP6leKrUYI/Xdpb0vEpfYMSVZ7SBhQu9Mbhy2SXhycE4PumtlfLw0QYuFMarQlmyaltHcJvw7Sj4m18FYjnkEiRcyeIcu6Sz/5fhAbfmFAj1my5D9RCqsq9+bNECTokHhiSNBryLUh8jgRBJvhjauVnyyd0XwmAeVNOlCrG1NytfdvL2292Wx1YVHshIo1VEV9T3Xw+h6djJlUCGlRtv/2pbgB6Ml1quYrCm99aApJnmP8cNfxpVEUOhDH6VWyEYscK89BYI4Ep94p6GxmPqHAyo/4duUQl+V1W0p0DI3D3PjZbXil5cLHSk/xYCu6+FH/LHI8fcNV3IiQFX4DMC7nQn1KeKyaZUZFsueXXeQJ09caZo+9JIAafEtBMLnQQDobg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(53546011)(6512007)(8676002)(33656002)(4326008)(41300700001)(38100700002)(26005)(66476007)(316002)(66556008)(6916009)(44832011)(66946007)(5660300002)(478600001)(83380400001)(8936002)(6486002)(6506007)(6666004)(186003)(2906002)(966005)(86362001)(9686003)(82960400001)(33716001)(1076003)(98903001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SI7D24PbmgtIOvkWh/oDhXD5p9Luv3iqVYvmMI6eZ4FRVuQ/jTL1jeRg+fJx?=
 =?us-ascii?Q?ri/Tffk2eDkXAeMF/NXDEUbBSQxU6WlCxK28RtYTqt/6R/L9JsNUYxoNnzLc?=
 =?us-ascii?Q?naUPLgnnNCzMG6H1l9L1q0ZuRKqaJNggozddwZBcnvIkxqnwtT+ByQSQ/7a0?=
 =?us-ascii?Q?vcIFzx+CIeYOyt570euVTtnrfnWpDm8rBeY2t0re3iVR+eXgLl0ZOrFZuw+4?=
 =?us-ascii?Q?z7bkMc4eRgm/065/80Mt70PSohX/sUIm9/aEJ3kU8sJ/hzM9EaHTH3AWrxqP?=
 =?us-ascii?Q?8HMasQXZgpz+bd5s8Ka7g+FjPJQ4RAUM9Uv00syee1vHkuLe80Sau3F/VUMI?=
 =?us-ascii?Q?gel9z5UfIWwdGGzz+W1GEfZvytYc6kDZ0K1Rvg/yHJN3DxNlcvVsiMKSlknM?=
 =?us-ascii?Q?XJK6uWX/D9NUWBGEcuXqldDrj8w8q8yRU1eB8dkwVzK4MqexVxIvOf2+XtPB?=
 =?us-ascii?Q?iLfXbInziWA96UColO3EDwvcKNBjuUsPue2FrYJSURTTzGGza9A+UzvdyMDQ?=
 =?us-ascii?Q?MaKEuX4SagsmrSI5lig8txmm5Uh0qj3kQonjG5lr+DG2FwY04vWDmPPiIjLr?=
 =?us-ascii?Q?TM28SVnx7PsnVIyB2BcCLKxTsUcb9J1d8P5H/34K2rcollEWhN0KwsEIzIfs?=
 =?us-ascii?Q?Q4N56+oJqYD2AGidFe6FPHTkA/eBjWJn7TTs3AT4Sc839uJAl/qyEoCpJtk1?=
 =?us-ascii?Q?JZvnCBhpfZIE5g1KYi+wDKdG1bnK7ybW+0VYwClmoEXb35AajsUQmCYcnnHI?=
 =?us-ascii?Q?8ToPvQMzFb6wd1b1LLRCAlem+0c+XTLTEktlCnYqN/utE7ZTjiVZp+dWv1Fk?=
 =?us-ascii?Q?BLWXBMR7RJpSFUg5q4FdZ0Kt7j8UZ0VUQf2sh+6VQlgSKEnyUuDztLLLDpdk?=
 =?us-ascii?Q?CLLIti3ZbntASaoreqcj/kgiQ2oV/4cJMDzpAJfHfTXHVsEU6Ohp15+th6MM?=
 =?us-ascii?Q?Id/0RI7sOZz0GtnOUZ4U/U4bolRDZVFBysecFAuxplGhVIyiZyHt2MNpP3i0?=
 =?us-ascii?Q?iAYEgyBbOmBsMk3UPpF1NadIVM2fiU7/CdZXlCPH2Q8OW4XfzdALMMtmAZ74?=
 =?us-ascii?Q?CH+hjNOimg73c6aKLUpQ1Y5kDA+pbukgVmKi9MxSSfd5PE3i39GGKM9zsYl+?=
 =?us-ascii?Q?2I6M9t6a6YxMR/SSoPw3nfhBEAvxMYWCYrgjpp3LqlHMqLEHx+3HDbTK67yA?=
 =?us-ascii?Q?0WCWKm5JATJSRIsDZPgcHBuOhiKLE14t/K1FRBGZIqtXL+0yzBJTW6v1PhfF?=
 =?us-ascii?Q?7XluNrLaI8ZgHZtFLTsw3oH/K7Cl/yIOpxLEVIYtcqQefySsmalgcbCXPKTE?=
 =?us-ascii?Q?wdi7HEC/2uQNEFvl8nUB40vCa6kOn6DTdcrDo2aNnKWHAEkMLVsARrWrQi9e?=
 =?us-ascii?Q?wKOrBGrKs+rZMK3FUwbDghvtvxKqovPPu2skiZh9+nylQmQFvRnGLRE5ludy?=
 =?us-ascii?Q?wrULCTZiHpC7/PBuErisvK4WV2MlVLFhdBcWBMOUBruRx9FlODpcAisLPUXy?=
 =?us-ascii?Q?5psLdy8TQacgtzxbfItr9XfcIduQuLxl4FhTdMQAre319o37b75sGMb1QgYM?=
 =?us-ascii?Q?B/dNtiW+TnXxWXCLEs2tOwBibxyWfpp9LWgydT67?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8184ab3f-deb0-49ce-1c6e-08db2ecc327e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 14:04:35.9638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZA7yD2Peqnhj2Zv9LnNeXvPShJn6eEzVe4+ilLeJ+C24IWdW8cFsQaItMGbywt1Cfixf95pBAg2xbgtgZt4hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5936
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 09:20:44AM -0400, Mathieu Desnoyers wrote:
> On 2023-03-27 04:05, Aaron Lu wrote:
> > Hi Mathieu,
> > 
> > I was doing some optimization work[1] for kernel scheduler using a
> > database workload: sysbench+postgres and before I submit my work, I
> > rebased my patch on top of latest v6.3-rc kernels to see if everything
> > still works expected and then I found rq's lock became very heavily
> > contended as compared to v6.2 based kernels.
> > 
> > Using the above mentioned workload, before commit af7f588d8f73("sched:
> > Introduce per-memory-map concurrency ID"), the profile looked like:
> > 
> >       7.30%     0.71%  [kernel.vmlinux]            [k] __schedule
> >       0.03%     0.03%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath
> > 
> > After that commit:
> > 
> >      49.01%     0.87%  [kernel.vmlinux]            [k] __schedule
> >      43.20%    43.18%  [kernel.vmlinux]            [k] native_queued_spin_lock_slowpath
> > 
> > The above profile was captured with sysbench's nr_threads set to 56; if
> > I used more thread number, the contention would be more severe on that
> > 2sockets/112core/224cpu Intel Sapphire Rapids server.
> > 
> > The docker image I used to do optimization work is not available outside
> > but I managed to reproduce this problem using only publicaly available
> > stuffs, here it goes:
> > 1 docker pull postgres
> > 2 sudo docker run --rm --name postgres-instance -e POSTGRES_PASSWORD=mypass -e POSTGRES_USER=sbtest -d postgres -c shared_buffers=80MB -c max_connections=250
> > 3 go inside the container
> >    sudo docker exec -it $the_just_started_container_id bash
> > 4 install sysbench inside container
> >    sudo apt update and sudo apt install sysbench
> > 5 prepare
> >    root@container:/# sysbench --db-driver=pgsql --pgsql-user=sbtest --pgsql_password=mypass --pgsql-db=sbtest --pgsql-port=5432 --tables=16 --table-size=10000 --threads=56 --time=60 --report-interval=2 /usr/share/sysbench/oltp_read_only.lua prepare
> > 6 run
> >    root@container:/# sysbench --db-driver=pgsql --pgsql-user=sbtest --pgsql_password=mypass --pgsql-db=sbtest --pgsql-port=5432 --tables=16 --table-size=10000 --threads=56 --time=60 --report-interval=2 /usr/share/sysbench/oltp_read_only.lua run
> > 
> > Let it warm up a little bit and after 10-20s you can do profile and see
> > the increased rq lock contention. You may need a machine that has at
> > least 56 cpus to see this, I didn't try on other machines.
> > 
> > Feel free to let me know if you need any other info.
> 
> While I setup my dev machine with this reproducer, here are a few
> questions to help figure out the context:
> 
> I understand that pgsql is a multi-process database. Is it strictly
> single-threaded per-process, or does each process have more than
> one thread ?

I do not know the details of Postgres, according to this:
https://wiki.postgresql.org/wiki/FAQ#How_does_PostgreSQL_use_CPU_resources.3F
I think it is single-threaded per-process.

The client, sysbench, is single process multi-threaded IIUC.

> 
> I understand that your workload is scheduling between threads which
> belong to different processes. Are there more heavily active threads
> than there are scheduler runqueues (CPUs) on your machine ?

In the reproducer I described above, 56 threads are started on the
client side and if each client thread is served by a server process,
there would be about 112 tasks. I don't think the client thread and
the server process are active at the same time but even if they are,
112 is still smaller than the machine's CPU number: 224.

> 
> When I developed the mm_cid feature, I originally implemented two additional
> optimizations:
> 
>     Additional optimizations can be done if the spin locks added when
>     context switching between threads belonging to different memory maps end
>     up being a performance bottleneck. Those are left out of this patch
>     though. A performance impact would have to be clearly demonstrated to
>     justify the added complexity.
> 
> I suspect that your workload demonstrates the need for at least one of those
> optimizations. I just wonder if we are in a purely single-threaded scenario
> for each process, or if each process has many threads.

My understanding is: the server side is single threaded and the client
side is multi threaded.

Thanks,
Aaron
