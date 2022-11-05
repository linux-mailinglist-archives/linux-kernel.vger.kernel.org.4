Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA94261DAFB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKEOdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiKEOdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:33:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DB0DF08
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667658790; x=1699194790;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EDO3r771o+0rI3iLt1cY9nkJhVQseQshIITEz7680jY=;
  b=BORlqD0Y4D/j23/UZd+6Ur9wL2bffOIJw1hWi4eM0xH2evQBsGDtzpSD
   5qOd7A4EyfR2GWNqvY98SZlL46/3ckCUI93OYN0hrqkDzPR6fnE2wlA1l
   cgoz8Jx6cBIKXPlfDhfUNuxFxcDqB9XPAVFqc0cPxGMModfY2cVWEMdaH
   znjHlMwg4+WtWh5i6+tKWJtT7HRTxMvpQYA4PCp8YiMCWQqQm+b+umifO
   hHZPYiKf67MrSV1ohntxCUjlneGLEi/Vv7I4E1ByCEFBC68EuE/d7pOA4
   xhdUNclpJQ5LXHA8IDjodVNJCYS6mTiwRP9/0IFtGqWaUThfLwF57TbqK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="289907875"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="289907875"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2022 07:33:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="637910330"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="637910330"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 05 Nov 2022 07:33:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 5 Nov 2022 07:33:09 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 5 Nov 2022 07:33:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 5 Nov 2022 07:33:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 5 Nov 2022 07:33:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcCgCLaWBocuntrwqB9KWLeqtZGD4LmGG9Xc+/sSJBLMqDZ9TWEWtdyJtEsJiIwszYXGitn9ZYcgjLRRnbyT8QIn53UPOMYE8DpScjBAIogQKN+sJ5wU7zpRyI04EHbqE4TIN4VOokLoeN4B4kF02DREeBlrtDVQsNR21NmRq6sSB8aoK5TIitzrixgVNgQPhte5e0/lIMc1/HCqExSesFMnr4eKSQMI88C6eTYGTQf0hyud3HpRymDETx6B5N/SNd6MOOgJZ4GbChleOOUi1yU6bp+jyYf0kY6UoXkvqhvhARojkOVam/D49v3ucu/b8Yi+TIu187KgntWm0kQ9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJqMlaLaFM9QJtrIT0BM5n5TwnkGzmAsJkQnPsDYSZA=;
 b=JGyfPl++bGPdyjfCrucv54ILM5ZQQmqrBayURu8m5fmzUis8mwgMvayD7KV8KydZejfvcyzCNbolneGrh2c2BzysuRNPFZiY3ooOs/1eM602CdDQmccDKR3b4j/wJ/lwb+/OK8WjSO0vdAhwdp/bJpUKEQkHvOIQqGGgkgel8sRGdYkBSaUZf/iAszr4dAicp5xau7LnNoK7AsO8qRKVEJ8iGM9OMkO8cklZt85LVH4nMtVa4xj11eitEXxlLGHG79WLz03Bjd1t4xen/K/Zy6xRmg/1GzEaAQrbxLTgYoqcqKw7t/gpGWvcK3FyVFiLENs6p2/aGTVr4dfazrlTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by MN2PR11MB4759.namprd11.prod.outlook.com (2603:10b6:208:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Sat, 5 Nov
 2022 14:33:07 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::b6d7:8853:f8a4:ae30]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::b6d7:8853:f8a4:ae30%9]) with mapi id 15.20.5791.022; Sat, 5 Nov 2022
 14:33:06 +0000
Date:   Sat, 5 Nov 2022 22:32:43 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>, <parth@linux.ibm.com>,
        <qais.yousef@arm.com>, <chris.hyser@oracle.com>,
        <patrick.bellasi@matbug.net>, <David.Laight@aculab.com>,
        <pjt@google.com>, <pavel@ucw.cz>, <tj@kernel.org>,
        <qperret@google.com>, <tim.c.chen@linux.intel.com>,
        <joshdon@google.com>, <timj@gnu.org>, <kprateek.nayak@amd.com>,
        <youssefesmat@chromium.org>, <joel@joelfernandes.org>
Subject: Re: [PATCH v7 1/9] sched/fair: fix unfairness at wakeup
Message-ID: <Y2Z0C2whs6pnPLvi@chenyu5-mobl1>
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221028093403.6673-2-vincent.guittot@linaro.org>
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|MN2PR11MB4759:EE_
X-MS-Office365-Filtering-Correlation-Id: 429cea9e-8264-4f21-d151-08dabf3aa78b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xITVGJCuByFSsr1WlZY4sgIZ0wLZ+QU970yroH0R3Sz7cqUzjYvTgVtnsVbOxtdIBbCzYmnNOAC9TzR+2wRMYiYeyoj5X/gz8BVsZOlWbrgZLMfCBrZiMzmoW9raPz/kC8pBX5Yd3lY9E/FNGQEL/dGZQnlYZRZDh08JY0woqqjJ5Uqv1puDHBV0Cm4RNZ6kD1bZbMY+eaZxDybK2K2L3INgylXqR0q0vYZ5L8SRXSlRqEo3NPFx1AQipGA6kvI8gvyGPvtj+apEJuXCPoRXFtkYa7R1eYbDIcPUg7jHaI5GbkUQMNpatW7Se2+9HrQW9XgYIguOpF/YecUC8MBzDsJDKQRvlv0tBtaxrB6P8Re74WAxY/qpMtfUnMI4QkIOPX64ggTzrA4rJg2Rhns4me+qAqMtwp2IfJBJeL+AfRva1F6LeYEpTaJKebvSkV8WW3O0xjYUQiw/ySk0350TSTCBct1jcQO4A6gTUyN4HXgFBGPdbJLkRKcsnphwCdxuwsFbgrsQrUOAzqshHK9mbAjWMNi/8yF3NIrRofrpaE9do1t6iQxbcjQJcGb52sI2ZW/B9BAsEs/zeaw6rIMW4awHGzyMgcXbcVRsc7Ks0NxFxwJHJ9k1ZoTX3QBAf/e+4FvxFJ7/hZAWkY/hHOAblh8QIG6TnWf92rUVna+cTLMq+EkeyKizfUzaAL3X6IkE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199015)(33716001)(478600001)(6486002)(38100700002)(82960400001)(6666004)(86362001)(26005)(6512007)(9686003)(4001150100001)(2906002)(8936002)(41300700001)(5660300002)(6916009)(316002)(4326008)(53546011)(8676002)(6506007)(4744005)(7416002)(186003)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oPxdtg6n3a8WMeL+xAaFXJ+6e2H69tzkbHaNl0Sp7QtTjSpbC6F+ftis8to5?=
 =?us-ascii?Q?qGTWrlLplC4FZRuP+EgI62yoHzt64Da9PXYnrQJlUdEvlr9Bh2Ezf3rHsd4o?=
 =?us-ascii?Q?6SkL5Ac63v60jbcChnm7S1YcBCmk12YY2nrEDdsUUcGcw+MvVU8B96lE29mq?=
 =?us-ascii?Q?zNoCeHBOcbVVco/5OJVoiuLzAYRbksWwsQWk7SGhw0MvMMiYWbRkLWe8Ag7W?=
 =?us-ascii?Q?WGggjmqmW0cDJlwMEj8zBt5OZm/cP1Yg5ORAmQObmcx9B8u8QCnsKyGIrrD5?=
 =?us-ascii?Q?FFPcsEGvIzpnO8d7Yp+MpHJiK5Ja1jM/du0/4xIfSKKU8EJSvdIyp8X5Zg/z?=
 =?us-ascii?Q?AvOb43w1XShhugTa9q+ChB25YxIYUIKWVTNIT5wzoGlYE5zsaH0tAwUn8Ijm?=
 =?us-ascii?Q?wIj00KYXYCP4YYTq8gcuF4Xak/9RAT6EfLdFTFOIbG+Dv8D/w9xhZ7WKC1Yw?=
 =?us-ascii?Q?ApqNf4Wcvd7WfN8QjgVBz0+N+GS41ZS6Y5wCFikifkTFGXJdXZTme6FvRRl1?=
 =?us-ascii?Q?6ZyXgTtLkUHvHeBqWs5aq1IihPl2Jur6qDZ7K+eLyqdM/O6YoJN0uuLMEgQh?=
 =?us-ascii?Q?U1nJ7dogW+PySypjJcNxNmq/OuPUgiqk2UvAA0CP2EvjNgQ8mA6ysAKwMG/2?=
 =?us-ascii?Q?dABvBrDTsl67bm0j8H+2Av6O+1s98Un2D7a0jNeUyfqvHkXEvH8ziTyVJdkT?=
 =?us-ascii?Q?qvV1Q2IDZKOcgi5GK9YoNzbopqIPedDNhvFe88kCJfaueqf1MAp0s92ekx0w?=
 =?us-ascii?Q?+arlvJohvVXSCHT7SYqmMozFOUzGJA3xB6UuHTe5Xh+3mryzDm/QA3Tf1FwG?=
 =?us-ascii?Q?2skfbLC0sjjxd5bYKdLpG/e13eyVRVfFSrJ6viI2albtKV6ngCH8GPNgu3au?=
 =?us-ascii?Q?q0RTT2Ok+tuL7GBOg2qMhQmWCnZdns+TTShBMUaVvlp88cz6iO2Dg3Ve6gd3?=
 =?us-ascii?Q?vvUSqpds5ftnm8pVU9/XQIXf15qV/1Ga1gT9AwfyGoS5NpLyKBVxiw7zuPAr?=
 =?us-ascii?Q?FiM8wHXIdOjWq9ZS/kLCikLvbJTwxkiY0CtgR1WgTCaFspo9oiudlRX/QoUw?=
 =?us-ascii?Q?2KSKXk9HZT9tUVQ+A22G3dMdYP3Q94YHL8O+h25J92PX3uhsRZH7zJn1n8+r?=
 =?us-ascii?Q?N4e5i5lbh29ukHjnSVtHBTs+7xh0Nk1ut3feg/eDarSApv8Em8XX7dYmtXfQ?=
 =?us-ascii?Q?uYawmqf6N6eykoJY2lOH0sftrR+KQtA/2m4Lc2JAAMj9gZZws1L1dG96qbXT?=
 =?us-ascii?Q?cxBjzOJLMeV0NI9lL2DeGHN8LXyTwAKN1DQgO9t5gFFsgp7BN8RDv4Bkqqlr?=
 =?us-ascii?Q?36/l5HnzSp5RUkXqO8u39p7KeaNK1jELibnL/i0BCBd9m2GNIVbskNCYL1IS?=
 =?us-ascii?Q?cOpyF0drca0iOhC8FFaqSCkIPf+Rx5RKP5suFUFsg9Z0l77fUSDOJBKLVDVh?=
 =?us-ascii?Q?QO5lffqBO6vOjvnMZHavzcaOKliN9q2FDk33IzXgq5mMZxyqGr6XaXsLNIZi?=
 =?us-ascii?Q?T/m0D9vdlZdzVFi38Rp6+2dSLOzWPfgdaX4oARTK2kw4lxi8Ri0WvJ+6BNyq?=
 =?us-ascii?Q?HwaZE7cc0kZmTCvoUDGU3Z2Qt2L3ZNH+h+DF5kxw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 429cea9e-8264-4f21-d151-08dabf3aa78b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2022 14:33:06.7719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 976/Xdcj7ogOswiOa0dJQexzO46Sw9LmP7Y9TogGZ90dRDgcUEU1a353NRPEicF3AFUvwPUnASE4GidkOwTzRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4759
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-28 at 11:33:55 +0200, Vincent Guittot wrote:
[snip] 
> +static inline unsigned long  get_latency_max(void)
> +{
> +	unsigned long thresh = get_sched_latency(false);
> +
> +	thresh -= sysctl_sched_min_granularity;
> +
May I know why we substract sysctl_sched_min_granularity above?
I thought thresh -= 1 would be enough to let the waking task preempt
the current one, because:
When a long sleeping task is enqueued on this rq, its vruntime is set
to cfs_rq->min_vtime - latency, so
diff = curr->vtime - cfs_rq->min_vtime + latency,
since (curr->vtime - cfs_rq->min_vtime) >= 0, if we set the thresh to
(latency - 1), the diff is guaranteed to be bigger than thresh and
the waking task can preempt current task.

thanks,
Chenyu
> +	return thresh;
> +}
