Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2416D6F32AE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjEAPQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjEAPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:16:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1B01A1
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682954164; x=1714490164;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Fm/lrGt7/oIZE3JdRlrYbRfih43iQPOyn+yI7jOvNyc=;
  b=gnWedxxOw38ckGEgWSP92UyAKJNWCBY5nPSJ8g9Eyzbg6p7pKkrNXu82
   m2KDYCjROWfF2rOvwZshHKEOJcgiINJglE4vJpUlud3uXCyKeRmMGpxRx
   xKAPKNPHvOALgRmVKcpsU6bTb9cupmy/n5ZUBByhGndVnSEOadHAgHpA9
   P2DqUhckh4dJ/4MO/KAa8Scx30zJAjOyY/KefvQo4KxjEPUQT2e5I2ICt
   QVkqVSEaFQT0pcq41sj1HF540MxpipHltjWKt/txztRdcYusEo+qfUYzu
   p5ItOe3alpELDwlYzv41E+AzMrF8DA0syJOylexngX2lyBz1z6aE7BM1C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="348210127"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="348210127"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 08:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="942066468"
X-IronPort-AV: E=Sophos;i="5.99,241,1677571200"; 
   d="scan'208";a="942066468"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 01 May 2023 08:15:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 08:15:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 08:15:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 1 May 2023 08:15:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 1 May 2023 08:15:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhU6cPNcHNTIOcUaUyDrur9rzFEg01msgjJsmeIB0Mvhe5zpu+06aMzFMwqPDHUkc+2EHhrp+QktrV/Erp4cAjlfeAnoyOWxV9N3Grqn/o5Ax/unkcp/82vcEPYHPpFgH7jr3E9RZ1H5DXrO4fG2oAgPVNNyhBiKQZ/AS1/62vv1wb1N+nuiVcoIZrCo4wbr3IC0Mdu+1YNfAck8MwGs6MiLaFeH82qGpm8uYu8f6rjbA08XR60ym1g6sJfUu2vY09gEZoQQmsLZI5g3BJX5jmGGaY8PfUPzpKXMPLsEg3Dqm1p4mQq+raLM2Ud9F28EMYRS6wuklB7S7MhSXuX7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYN+2rCBjPYaX3ASadaj7aWz2wvtDHKdtQCKu2DhopM=;
 b=ije6BcvQ5D7gL/HNnJ9KDmsGnt9BBXSBPppl71q/4oYQQXfH9th9gG1MC2Sohy+zY6kTrRtYuQxYpdoeXbYOg0wDsyvXPJ35geW/0G/8/+YtWbsZQLYUE0+3VgUM8/UsMtt0BAquyiIQxVnPWiwsLMYRQT4Qxc/QxPbB/g2JE+R7Al2Zp3GJ61+vg8wcVvISjuxMc7UWiYt0zIit/RFi61WHwTEaAsCWJofHp9iSjaUG8MP7U85gVLxZFcb09q/mfc8/mvZUe6/Gg6HAiLWW1vTsq7qq6mQdHJ7u+ViPG/U7n7heTtlyeNBSRQwM1jUv37qyEY4BfN7wzjchyzFagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DS7PR11MB7860.namprd11.prod.outlook.com (2603:10b6:8:e9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.28; Mon, 1 May 2023 15:15:40 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%6]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 15:15:40 +0000
Date:   Mon, 1 May 2023 23:15:17 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mike Galbraith <efault@gmx.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "K Prateek Nayak" <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        "Yicong Yang" <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        "Len Brown" <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>,
        kernel test robot <yujie.liu@intel.com>,
        "Arjan Van De Ven" <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/2] sched/fair: Introduce SIS_CURRENT to wake up
 short task on current CPU
Message-ID: <ZE/XheuZdT5pGDgl@chenyu5-mobl1>
References: <cover.1682661027.git.yu.c.chen@intel.com>
 <4081178486e025c89dbb7cc0e62bbfab95fc794a.1682661027.git.yu.c.chen@intel.com>
 <66406be50c8e040870217f5c9131b901d4dd2013.camel@gmx.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66406be50c8e040870217f5c9131b901d4dd2013.camel@gmx.de>
X-ClientProxiedBy: SG2PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:4:91::18) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DS7PR11MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: a8bd9d3c-1615-42f2-d5d2-08db4a56ec79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: haMUvl2bUPwWQgmBiLTKmAue0n8/G3sLg53DWnA+vogoB11ZTz6MQA//IiDeSGcqnBHQsEizutrSEdwmFnF2T8kw4mTror8VOoKGhlmxusvQUDoASqwKl2dUuUuw/+n/DvVsB6jP7JJh35D2FiB1dtfugTxyUnqfHDvdTjizyu4HupiaS3Xk9u/GRQ/ww7n53hSs+tavlyHegNAtyeABqxmpw6sRD9mSoiFj6y+lXjZY8ZZQZlQb57A1qGfS0LBAprp7iVBxLvwf9juhKiV8KFfX/JRK/J3Ux+mPeFjXjRjRhajJcZ2IjWDo1NvD3to3fwasRh0n9w63bCaHolTo8AxZOLLhYrxe6QcUV/dbsW6wns6bWQqYiFv5LC6Fso7wJFZ3m92EkbXx/Yv9s3zcYSjdHCYAruY8V8OsW9ZMlpuFadCbjB//celZ5CzOz5pM4f+YBF7wj/Sz71fRVfhAW9og/cAUjOGTHpDz3eq+Dd7qcB/kt0o7upTYvDJWCvMvF+2XNbWUj0Ojc0sMoU528HPmlcINDDuUos2st9F5S7ZUb7ZrC4CStLl2RTbetncj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(53546011)(33716001)(9686003)(316002)(6512007)(6506007)(26005)(186003)(41300700001)(83380400001)(66556008)(66946007)(66476007)(478600001)(54906003)(4326008)(6486002)(6666004)(6916009)(38100700002)(2906002)(82960400001)(5660300002)(86362001)(7416002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?rdwIM0ymTqRSy5pouluv0G/86tJrFr/bZQd1YXobnSuk8DD8hPaSuN3iMO?=
 =?iso-8859-1?Q?+WfqnuYY8arvJBCFX0mnwya4lYhHuG3uUiYojx0tgW3TQAZxRa6zYrIENG?=
 =?iso-8859-1?Q?MWd+1qvCJtF3e1ACudLOBhPagYE6whQT/fkCiSwIyrbn8TpXuq0WlkXX2/?=
 =?iso-8859-1?Q?r7pQ6lPyQhqJxbcIfJhgIVyHWg6jKuzM/tS7tqhRWcjvB0YGkUbR2SvVYQ?=
 =?iso-8859-1?Q?RG3rxdbB1WKsRabJo50FBFtwzUfQXnRj+tMT0DD96/UjC3qkiXu5q+oOK9?=
 =?iso-8859-1?Q?//pFghx2Q45VvRZ7Is37T2DE/8tDYAZx9Ui9VAY4yuON8af56k11LBc8Bj?=
 =?iso-8859-1?Q?9fnxg/NYp1B8ys/GCbohfctXPGJGyga2MSne+dwYf0EAtiiVyqPoM4bPKY?=
 =?iso-8859-1?Q?gp7p5/ypn1Rh/zaynJAykAK8kbLWNuV1QXMLmhu4rGMBB/C3SJoQLI7KHR?=
 =?iso-8859-1?Q?S2Qm8MLLI+/+9qaaGeFTrgkYXtQIhFiCeSsBrAgeQCCgtxGiXw2srPSjkC?=
 =?iso-8859-1?Q?d06hEXDz1SLhYwxQ7L6yVA32ZqtO/BXATRUF45ETHYey89PyufgtkZENa1?=
 =?iso-8859-1?Q?ZqxLmgQgGpEBNHOTC+rBnOtGFeDiJzHzhq6hrXCRaiFfstKwiYeYXBWXOu?=
 =?iso-8859-1?Q?G1Q8gMkOs9offLktcbtVimKBXClnLkAEslIzoma0LIMu2CGH9qP1Q5eVSF?=
 =?iso-8859-1?Q?eX42pqI0j4hH9mJUiAaXFbMp/arTVLJoBQWzpGqUuYvP5hgSQ2qG6t+8bt?=
 =?iso-8859-1?Q?eku0lhWdkxlsQkD1j0sbz17v6hXx79aGwcgc/oXP4DEQ7ijIytJnwMAhMp?=
 =?iso-8859-1?Q?tf/8B2VdN0xDD4+6VQvk4m4EkAwlLclTOA9oh+Nl/EJEplNGv/yOQq1Vyn?=
 =?iso-8859-1?Q?Is4s3xPGVRh6mWW1ePr2mXp/iSKf2XNuICp/lNugljStuor5SN9h1mle+X?=
 =?iso-8859-1?Q?gJsXMBN115Ryyt9wPGQOSh1z7Zw3w5L5vTxuSP86lQ0+4MEXkKq7FhDCoD?=
 =?iso-8859-1?Q?/qn9WVFUVgmaUKTXMTMqVZ4Umf+CzUeQfQv1f05dFia6bB+kW7WQ9atM54?=
 =?iso-8859-1?Q?HOqBaWxrfklqOthgzQGfADG7AgyHA2xPTtbNR0+5JzlG0TGaf6BCTfgN0u?=
 =?iso-8859-1?Q?ixXAOmqPd9+/aqK9r+LtTMRlq5FXgwOvwwdGp78UwVDAj+am5XgKqhWdJA?=
 =?iso-8859-1?Q?3GI0VGSnnIomVFMulN96p+7wVEU7izYkOj2LLhq+SK8zqI9If/avqSxLzZ?=
 =?iso-8859-1?Q?GK4wHEe40Ppqw8qbWxkrvufjvOt9iGQbfh8qV0BusU3yE8mY7DyjJHh6Kw?=
 =?iso-8859-1?Q?gJKSjz7BVoIxmPeRz+4zaKNFpmgioiinwhR8m5cql/qvVM1IhnOfJaXS1U?=
 =?iso-8859-1?Q?+WU9TLtzZGDt6TnXeKhPquDh6TM6sUINyE2+299tgRZk0n10sXBagEUbV1?=
 =?iso-8859-1?Q?mZqybjHQIinvxZlo3g7raHhXcPlWQQbW9XVvtlGCNZrOO/o+8cbGhszddT?=
 =?iso-8859-1?Q?9ZPi0oFXgErQ7vfc6jLkvVh+BUY3owaLbWKL89qtQenIcw0cI8EUKIHPm7?=
 =?iso-8859-1?Q?yWVglpPHR2vOt0A7bNjrRAEMts7FSXTDz00D+hMFETguX/dgxEv74sLsXH?=
 =?iso-8859-1?Q?jXHTQRYcnpof+Z64qaB4MLVoKiTWYNgeC5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bd9d3c-1615-42f2-d5d2-08db4a56ec79
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 15:15:40.0742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0voQDBYNWvCRBauLstm6FuWGniP5MnS1kQwtKGtNMJch7T8v4oMQiT3Kivv/YPq1340ukDClJHa8IT0dbeB3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7860
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,
On 2023-04-29 at 21:34:06 +0200, Mike Galbraith wrote:
> On Sat, 2023-04-29 at 07:16 +0800, Chen Yu wrote:
> > [Problem Statement]
> > For a workload that is doing frequent context switches, the throughput
> > scales well until the number of instances reaches a peak point. After
> > that peak point, the throughput drops significantly if the number of
> > instances continue to increase.
> >
> > The will-it-scale context_switch1 test case exposes the issue. The
> > test platform has 2 x 56C/112T and 224 CPUs in total. will-it-scale
> > launches 1, 8, 16 ... instances respectively. Each instance is composed
> > of 2 tasks, and each pair of tasks would do ping-pong scheduling via
> > pipe_read() and pipe_write(). No task is bound to any CPU. It is found
> > that, once the number of instances is higher than 56, the throughput
> > drops accordingly:
> >
> >           ^
> > throughput|
> >           |                 X
> >           |               X   X X
> >           |             X         X X
> >           |           X               X
> >           |         X                   X
> >           |       X
> >           |     X
> >           |   X
> >           | X
> >           |
> >           +-----------------.------------------->
> >                             56
> >                                  number of instances
> 
> Should these buddy pairs not start interfering with one another at 112
> instances instead of 56? NR_CPUS/2 buddy pair instances is the point at
> which trying to turn waker/wakee overlap into throughput should tend
> toward being a loser due to man-in-the-middle wakeup delay pain more
> than offsetting overlap recovery gain, rendering sync wakeup thereafter
> an ever more likely win.
> 
Thank you for taking a look at this. Yes, you are right, I did not
described this clearly. Actually above figure was draw when I first
found the issue when there is  only 1 socket online(112 thread in total).
I should update the figure to the 224 CPUs case.
> Anyway...
> 
> What I see in my box, and I bet a virtual nickle it's a player in your
> box as well, is WA_WEIGHT making a mess of things by stacking tasks,
> sometimes very badly.  Below, I start NR_CPUS tbench buddy pairs in
> crusty ole i4790 desktop box with WA_WEIGHT turned off, then turn it on
> remotely as to not have noisy GUI muck up my demo.
> 
> ...
>    8   3155749  3606.79 MB/sec  warmup  38 sec  latency 3.852 ms
>    8   3238485  3608.75 MB/sec  warmup  39 sec  latency 3.839 ms
>    8   3321578  3608.59 MB/sec  warmup  40 sec  latency 3.882 ms
>    8   3404746  3608.09 MB/sec  warmup  41 sec  latency 2.273 ms
>    8   3487885  3607.58 MB/sec  warmup  42 sec  latency 3.869 ms
>    8   3571034  3607.12 MB/sec  warmup  43 sec  latency 3.855 ms
>    8   3654067  3607.48 MB/sec  warmup  44 sec  latency 3.857 ms
>    8   3736973  3608.83 MB/sec  warmup  45 sec  latency 4.008 ms
>    8   3820160  3608.33 MB/sec  warmup  46 sec  latency 3.849 ms
>    8   3902963  3607.60 MB/sec  warmup  47 sec  latency 14.241 ms
>    8   3986117  3607.17 MB/sec  warmup  48 sec  latency 20.290 ms
>    8   4069256  3606.70 MB/sec  warmup  49 sec  latency 28.284 ms
>    8   4151986  3608.35 MB/sec  warmup  50 sec  latency 17.216 ms
>    8   4235070  3608.06 MB/sec  warmup  51 sec  latency 23.221 ms
>    8   4318221  3607.81 MB/sec  warmup  52 sec  latency 28.285 ms
>    8   4401456  3607.29 MB/sec  warmup  53 sec  latency 20.835 ms
>    8   4484606  3607.06 MB/sec  warmup  54 sec  latency 28.943 ms
>    8   4567609  3607.32 MB/sec  warmup  55 sec  latency 28.254 ms
> 
> Where I turned it on is hard to miss.
> 
> Short duration thread pool workers can be stacked all the way to the
> ceiling by WA_WEIGHT during burst wakeups, with wake_wide() not being
> able to intervene due to lack of cross coupling between waker/wakees
> leading to heuristic failure.  A (now long) while ago I caught that
> happening with firefox event threads, it launched 32 of 'em in my 8 rq
> box (hmm), and them being essentially the scheduler equivalent of
> neutrinos (nearly massless), we stuffed 'em all into one rq.. and got
> away with it because those particular threads don't seem to do much of
> anything.  However, were they to go active, the latency hit that we set
> up could have stung mightily. That scenario being highly generic leads
> me to suspect that somewhere out there in the big wide world, folks are
> eating that burst serialization.
Thank you for this information. Yes, task stacking can be quite annoying
for latency. And in my previous patch version, Prateek from AMD, Abel
from Bytedance, and Yicong from Hisilicon have expressed their concern
on the task stacking risk. So we tried several versions carefully to
not break their use case. For the WA_WEIGHT issue you described(and
I also saw your email offline), it is interesting and I'll try
to run similar test on a 4C/8T system to reproduce it.

thanks,
Chenyu
> 
> 	-Mike
