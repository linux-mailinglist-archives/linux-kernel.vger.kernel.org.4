Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235866BCDA9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCPLLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCPLLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:11:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211FFB71B8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678965109; x=1710501109;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A2zZtkn6YHYsoQIdgt+FiP8S9jQHu/Hy6LJBJ+HjDTM=;
  b=SKbMgKbWB9VFlBfrKsDql06YmljyROQxacWpA4AG558vybNT5sCEt+w6
   xubC7VfhMW/B9g3+2LhOeBxsKYuphtKvprCTnd7amNGnPSwsg+EvMrFcY
   m3NgDMUSSCwQvkJCbZiR58oRjE2eG7kutVKuTaQAi0/HawrgsRsWYdAuz
   j5bemfYbbX6nVML41nOcLLO+deCJlt9Hs13Hgt//ai170m0NNlf0lILxi
   LEsdm3fplT47+wtaN2MEJq5SZMAIrjXK6Bw8ExTYhp2Tab6kab4MURYCC
   ySKMsJ7cIbOzomhj7M9fQNFP90C/0pmNqEvpFCoihmYGn5xMDocgn28kS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="335441018"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="335441018"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 04:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="712316284"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="712316284"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 16 Mar 2023 04:11:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 04:11:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 04:11:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 04:11:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 04:11:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4wPJe0o6WZrdxhV/eJ9rie9s27mIqULw2YWhLnL9qiIa0cycoY2tQuvNCYLsGnwFDrlPJdFTvUj8E6C8NJaDjpuUoTGvPP3cqedieNofAN777CEourD/nn+1RmClRBCceQ/JjqI25sMQkv8rvcN49yr+RjSG1LlY1p7l3tfIySt9G9Udf1N7TTGb+3KnkVUy9cWdi2twd4n1ylIh/zubvMiPRpEQ/Si9ZZXBJuUs4gkjB2UcHfy5KNHCBhyN5V4rkxH9NMvonvxPGKOf2+mSWOvsGnj+VZOzYDz3gmsu2HAtmmldJfozqyhTan9vSwhwge5nc1DoVkIccWK2+kudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGGZv6fJ5lQB5PF70hw/wkVc924i2fG1HpLQlcMS/Hs=;
 b=ApAijOkSUcSF8a9OlnfR2MQaRuk923KxdHjQuzg21RbPzGv7tIz79sT1q/N5aKPvONIqSWX80eGbOi1oUdfmVAV25wXQCHy5jw/DVHtIj2ea7GFu8kVHdylQdowxOQPqRorIKZWoD/Bb8kb3HpvKKoStvlx/69wcKZ1/iss1XdqihSi3Yb7t02jeEdjt/7KRt3Zns3MPpLTanoI1aSPLxH0blT2wXaXio2yqEr3i5qQX7a4WxzFvYYDgSrn/aOelMZ3NhGqYMbGAez42MF6NyTsB0qxOLa2jhGag9K3PaVIbXSftF2Xw++0wWdBTy54lUcellqBLKj93syVrb/iCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB7497.namprd11.prod.outlook.com (2603:10b6:510:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 11:11:41 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6178.024; Thu, 16 Mar 2023
 11:11:41 +0000
Date:   Thu, 16 Mar 2023 19:11:23 +0800
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
        "Hillf Danton" <hdanton@sina.com>,
        kernel test robot <yujie.liu@intel.com>,
        "Arjan Van De Ven" <arjan.van.de.ven@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] sched/fair: Introduce SIS_SHORT to wake up short
 task on current CPU
Message-ID: <ZBL5W4bA2aiEEyRv@chenyu5-mobl1>
References: <cover.1677069490.git.yu.c.chen@intel.com>
 <373e6886e274f198608fa1b5f1c254e32b43845d.1677069490.git.yu.c.chen@intel.com>
 <20230315152552.GF2006103@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230315152552.GF2006103@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d0f1eb-9216-440c-4351-08db260f3849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8mFFSW9a6pp9q5OZi/gcV3uoUMUFLL2ulkxH0++KncfghgHyal8MJyLY6srscJ2JnbQK2TMzC1Sz5rJNhe+nWaF3SEgapityrcv2oX5dVdw/ElRomIr0Re8RteufIP7/0lCqI3xorCWDZU+EvvKh53Eg7qoFlkg4qxkCVrCnNZehQRCQpjaeNOtIxbK97F/n1NMo3ZYfAL0vnJ6bAY10fCnOi88WMBtpbn5cWETIxaz0q3jv1dlEiMukGGBhcb2H/QF+bnLdk3B3j0MzT2wjB8xOxKZjVNwq016hilHNGC4sROJFjfOg2X0blLlHnc8ydBVc37FZseOa4tC/043UyQtYh82rimBi/Tgf6RmQ+cajjvgVnB+DOyNBojDQSJiu21CX9vv7vbog2ixC9ATHhgUSh7X9ZcRS8wFiHt8REZoaHr6ZW4fw82Eiso0Twd3SflkQtKZJCpjmUSKHt5O7uLA0b7RtrFE23bkbM7iuVFliAFqkt0zlCMXoW+MyytyGHjcokIiLkvPfBUi715AkRWjQJgM3g598/dcwFemKRKUvCHsPJXdYu6b/3Aux/l3Rg0UNYoBtTJ4mxvF0kVDPmBbq4dIX6ZgILT1+3ggE3gsa3+C2BT+hgo10Q0d1omQe6nlO+N1erJ4zeOQ1wvotww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199018)(7416002)(41300700001)(4326008)(6916009)(2906002)(5660300002)(66946007)(66556008)(66476007)(8936002)(8676002)(83380400001)(316002)(54906003)(478600001)(6486002)(6666004)(26005)(53546011)(9686003)(186003)(6506007)(6512007)(33716001)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F9IfrqkiJSaONR2IcLiUw9Q6ah0OGrZfwhB77oWVX6sHEsN7q1pN0NslZ/YZ?=
 =?us-ascii?Q?Y1U6hQeLEFjgJnHQNjXtyLAYH25gbCnEOYEay4oEPnXHBO1HHgDPDJiPvi8F?=
 =?us-ascii?Q?v6sGp/odeDSoLoTsLBGvr69R0q0FStqSCqLQN17fH3a8gZ+us8t2OA8BXR3W?=
 =?us-ascii?Q?siOyfB0syfINsSXSqsqyTYfPY07Gqob9oVQsudaa3AvATnZ0CWNP6UAwBLgw?=
 =?us-ascii?Q?1oEQ5FVVP3/yryC5bNKBn0WPZpQu7TyVhE8ztmB/cbaU1Q6fTVLgdE1dnnEa?=
 =?us-ascii?Q?0Sc9tUvvSLN+qS21ZRAMf62eeRGv475jVbYtQr+FlHEmzGTKSCyWruNen+mb?=
 =?us-ascii?Q?D34B1NGzx6qvJmbWbEvbtw7hYBnCkw/rQEwTMYes0wZbz8JZLzCoSziP45zo?=
 =?us-ascii?Q?Er0C+a+5DrFpC3wK+2CYcE1tlCWjlA/93iCzH6Hcb1cibykEzF341WwErxx4?=
 =?us-ascii?Q?KyzWhaNnOQqenOpH1HaHM7DE+zDY9vMwQ2alNsy/s3GFSn59/z16NHHvf5eN?=
 =?us-ascii?Q?9MRkses1ZG4R4b+HJv7+4TPbW2pm2h+60ogJsQUIP5zX7nu7UGUXUUHZ/KoG?=
 =?us-ascii?Q?V/qnCO5R6QqsA9JgiwXetCMetz7n5KoovJF6MCRiC4ERn1sXFgfzqc0nx80i?=
 =?us-ascii?Q?GxBu/Q1g1FlwBhMgKPWxpDdrqala9aDdmcc1Dm/oyXtRY4PqCxR4yiitQul+?=
 =?us-ascii?Q?nkzieit/VYIPCWjxgF9o8nqAfFwMHEL++ta4KzOoTgwsR9WKgJsMmcjSxNS6?=
 =?us-ascii?Q?VyhkLU0Bb2rlCeXA8S8vb+SmId0Laha6kGDbclfTueam8GQwwOZiHBGJn5a8?=
 =?us-ascii?Q?g5TGsZ3tE2/oej0OkfiD3q/LVGW0atlflKOew3kH1DIogfp2/tbo89BlwIXx?=
 =?us-ascii?Q?hRLY2w5i55OK2tgbFigWDurCu+tRB9iDkB/QaD/AtnrmLoEeTTh7E3U2YQ6d?=
 =?us-ascii?Q?cBINaksGaI8ZfnWq/urwKrTwR26UHrsYgLHKBPQyh2JUIsH3W2VdPjjd/EeD?=
 =?us-ascii?Q?pqiICVyXRKywwYI5gnOPC/orqLreXimRBWCI9eGH2tgz+nPAZ48hwoFoF2P+?=
 =?us-ascii?Q?EppuUsMW2KIMkmV0vz3gIwJ9bNnVpjB2niK5tGB3y+DcubRZnR1QUTU3Hue3?=
 =?us-ascii?Q?e7+ytGEQWMMFD21UuYQrMIhY4JgpHM7NV7knU97HwWQS/WPXjp1tgrQp4tX/?=
 =?us-ascii?Q?O+OXBYLy01mpO5+e6owR4LkZ0XXdHZHqrtP8tAcmu7g3c4ceEu0GRFOxQYmt?=
 =?us-ascii?Q?pcY4TmcGV4iux1zMRKUPibYEVxtenPOWNHg5mgrVk0QkSxvSuOK7Apx3IsIT?=
 =?us-ascii?Q?T38MpuwjO0QOvVvRPiIkFEJRdoNXlxN91qOQYl9OPDTl5oDqYw5jGjzKLwDq?=
 =?us-ascii?Q?x8vcYpsc1F9W1kjmEsjJIrpAIk1pLBya8tFix7j/utv5nEgp20DCWAD8sR71?=
 =?us-ascii?Q?8rOFaZjulYK8d5Mgq5zXZRasDyTF3jrFwUXOpmaCDneR3ruflzIVpg0JaEd8?=
 =?us-ascii?Q?VQzNHgJhfHN2j8nTZfI6jHibzs5QjaG8DLhNoU+5wtNAMe9Hl4aqomD+qZvF?=
 =?us-ascii?Q?afBOQHTE+7jz3stCCnAh/H2TmqNKX67XgO3JHJHm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d0f1eb-9216-440c-4351-08db260f3849
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 11:11:41.6247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbuOkcuE3g+oLdU5Qmrx0a0Audy0ObTGrYFYqRhu8+e+IL/vWJs/D7BjulFlizv1jexgzqHojfCx4pO5gOZ/pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7497
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
On 2023-03-15 at 16:25:52 +0100, Peter Zijlstra wrote:
> On Wed, Feb 22, 2023 at 10:09:55PM +0800, Chen Yu wrote:
> 
> > will-it-scale
> > =============
> > case			load		baseline	compare%
> > context_switch1		224 groups	1.00		+946.68%
> > 
> > There is a huge improvement in fast context switch test case, especially
> > when the number of groups equals the CPUs.
> > 
> > netperf
> > =======
> > case            	load    	baseline(std%)	compare%( std%)
> > TCP_RR          	56-threads	 1.00 (  1.12)	 -0.05 (  0.97)
> > TCP_RR          	112-threads	 1.00 (  0.50)	 +0.31 (  0.35)
> > TCP_RR          	168-threads	 1.00 (  3.46)	 +5.50 (  2.08)
> > TCP_RR          	224-threads	 1.00 (  2.52)	+665.38 (  3.38)
> > TCP_RR          	280-threads	 1.00 ( 38.59)	+22.12 ( 11.36)
> > TCP_RR          	336-threads	 1.00 ( 15.88)	 -0.00 ( 19.96)
> > TCP_RR          	392-threads	 1.00 ( 27.22)	 +0.26 ( 24.26)
> > TCP_RR          	448-threads	 1.00 ( 37.88)	 +0.04 ( 27.87)
> > UDP_RR          	56-threads	 1.00 (  2.39)	 -0.36 (  8.33)
> > UDP_RR          	112-threads	 1.00 ( 22.62)	 -0.65 ( 24.66)
> > UDP_RR          	168-threads	 1.00 ( 15.72)	 +3.97 (  5.02)
> > UDP_RR          	224-threads	 1.00 ( 15.90)	+134.98 ( 28.59)
> > UDP_RR          	280-threads	 1.00 ( 32.43)	 +0.26 ( 29.68)
> > UDP_RR          	336-threads	 1.00 ( 39.21)	 -0.05 ( 39.71)
> > UDP_RR          	392-threads	 1.00 ( 31.76)	 -0.22 ( 32.00)
> > UDP_RR          	448-threads	 1.00 ( 44.90)	 +0.06 ( 31.83)
> > 
> > There is significant 600+% improvement for TCP_RR and 100+% for UDP_RR
> > when the number of threads equals the CPUs.
> > 
> > tbench
> > ======
> > case            	load    	baseline(std%)	compare%( std%)
> > loopback        	56-threads	 1.00 (  0.15)	 +0.88 (  0.08)
> > loopback        	112-threads	 1.00 (  0.06)	 -0.41 (  0.52)
> > loopback        	168-threads	 1.00 (  0.17)	+45.42 ( 39.54)
> > loopback        	224-threads	 1.00 ( 36.93)	+24.10 (  0.06)
> > loopback        	280-threads	 1.00 (  0.04)	 -0.04 (  0.04)
> > loopback        	336-threads	 1.00 (  0.06)	 -0.16 (  0.14)
> > loopback        	392-threads	 1.00 (  0.05)	 +0.06 (  0.02)
> > loopback        	448-threads	 1.00 (  0.07)	 -0.02 (  0.07)
> > 
> > There is no noticeable impact on tbench. Although there is run-to-run variance
> > in 168/224 threads case, with or without this patch applied.
> 
> So there is a very narrow, but significant, win at 4x overload.
> What about 3x/5x overload, they only have very marginal gains.
> 
> So these patches are briliant if you run at exactly 4x overload, and
> very meh otherwise.
> 
> Why do we care about 4x overload?

It was tested on a 224 CPUs system(2 sockets, 56 Cores per socket).
So I guess the 4x here should be 1x?
That is when the number of workload instance equal to the number of online CPUs,
it benefits a lot. I think this could be one of the most common use case:
every CPU has 1 instance.

The reason why 280/336/392/448 threads do not have benefit might be that,
these overloaded case have been taken care of by SIS_UTIL. Because SIS_UTIL
will inhibit idle CPU scan when the system is extremly busy.

The reason why 168 threads do not have benefit is because the system is not
busy enough to trigger the short task wakeup optimization. Currently the threshold
is >=50% utilization. The reason why 50% is chosen is because we don't want
to break other platforms having less CPU within a LLC, and they prefer to 
spread the tasks rather than aggregating them.

Besides 224 threads case, I also tested other load around 224-threads:
netperf
=======
case                    load            baseline(std%)  compare%( std%)
TCP_RR                  210-threads      1.00 (  3.39)  +66.12 ( 72.21)
TCP_RR                  238-threads      1.00 (  3.48)  +752.93 (  9.58)
UDP_RR                  210-threads      1.00 (  9.85)   +7.33 ( 18.27)
UDP_RR                  238-threads      1.00 ( 19.02)  +178.96 ( 18.78)
And improvement are also observed.

thanks,
Chenyu
