Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25280690E45
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBIQWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBIQWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:22:31 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FC95A9E0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675959751; x=1707495751;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=lhjG5WABeQHuHJt175xLJT0pitapx3/NWw2/UwJZrkw=;
  b=l5IonTmDC0jqUlK30++IMO9g32JJRnoYNEsnxrOLLj9AwooYqmJEBvWZ
   yXp4niWfl7lgp6s9fdqloYMUexgEDuNUW4fJbQO2YtpmyWbylhUiQ3BDH
   JzSLu1suaqLRvBjNmjAXvDyx2huTBy6oELsgS6Vx7Rka9YGO2BH2Xw1Uy
   bcX9yeTCDOPnrxY6J19cNU6IxkVd5eiSXO400PrLtAq2aFYntAGCproNJ
   zqzY8sUUrk893cuFimem8BPV2w8YUNE2ZiN289qhmo2dRgZN2F2Qn1i/I
   YZSh4XLbEhchzu8wkgW8+zCU7kn1k5rLaA24RUFRUeKloTvHzm00LGCyf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="313803995"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="313803995"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 08:22:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="698087882"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="698087882"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 09 Feb 2023 08:22:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 08:22:22 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 08:22:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 08:22:21 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 08:22:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hATaCZCvIBPA5JHlpWSEVulaVlN5lxsrY/mOvah+9aK/MjhRtHe6ED9TRcohSCI1bbk5A+HJnO/nokBGYO327jYQnD4gwpkheTbE94QnmaJ2OFmOgDttg/PbS6WYq9jVJm7UaK5KaZuzcKq6rNVIHJJc60bUv5JREOkGrQVVzAQJdzEiMzplDr4N+0oons+FX030Lu90g6eywfnheKfBD1LE4TpeQPiWRqYtBCITQ7UzG693Pvi8TF24TsMUwHiesUSG2lHjSAurJ3TVEIuopo3oS+HPZcjydiRxpK6lzCYfLyljSNRi4xbRrkLu2tVeIIQPolAvNW17fuqQjnBawA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wC0g0IGifqXKl1n0wO8A+OfrfcyWBPtLR8vS4EghFkw=;
 b=V/vmbtvr1aNo6rH1rZQgQDmZmpPp2tTlA+8pTivLnJsuNjpI6gojZvZMHwRStxou/CPJcMyAuinB+cSLIF2OSPtpWSG16UspePbM1RRN1WABTbg5H4hbSBAndjdBsj4kj8W8SR92N9M+VAeLfZ6y1uMW8kt/5h6xTpFeOsm1dIcaxH8aoqCMyzu8hlKZCsnrrl14wM0RC0Id0f0jaytcy1tzQgiZgrlPtKQBky/jDtQBtJzCvfPXGF0BCk3ndzFpWmyWiYAIND7PfXFcHXro7AoVifFKBpgLickq2YHVylrqZby47u7NNWeZE9UJTVqrdc9urADaIdaRfUyHQfZb/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 16:22:08 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d%8]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 16:22:08 +0000
Date:   Fri, 10 Feb 2023 00:21:53 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     <pmladek@suse.com>, <juri.lelli@redhat.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <zyhtheonly@gmail.com>,
        <zwp10758@gmail.com>, <zyhtheonly@yeah.net>
Subject: Re: [PATCH v2 2/2] sched: print parent comm in sched_show_task()
Message-ID: <Y+UdoShroyR3iynv@chenyu5-mobl1>
References: <Y8qSjUbVhjYaRFg4@alley>
 <20230131080911.GA1601@didi-ThinkCentre-M930t-N000>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230131080911.GA1601@didi-ThinkCentre-M930t-N000>
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|MW4PR11MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 45dd0605-679f-4273-4e3f-08db0ab9ca63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wNwF+N/1gmg3Byw32qyCfzsQKsNTXHtUAQU1NvhjKdQP4Y2jH+GgxtqxTkEzvi8quANbpqZztHVb1lyPNPzkhboS6PX8TRUzzW/8r7AY6tsf4IBrajRwchtEN36WHMhMBgg9vW/zhH6J0iPDP/dGAhEpacfwn+u/EuloVNaKib3UHQtAIOIQrDSyI4pzFGbNdTpcn7GaqR8jouEffEmdyUgFjTJSmUrHscIdSV7s6cQ8x/Bk3tC2469dW64+jbaII8X8yX3dcmMGjofv3PTYWylOnbZnDRf0bcO9QaseFmOsovfJfzytKjVnioZYz4yFkSMvSoMSYKXZNsnw1duwPDeo3XCrzHOHJYqGUx1tgbmNadWjHDsvYHQEpnZMrzg7J8WAPujUVvtFsBjN8/vGw3Oqt2cpg+kIfi/76s34WRZYyU/nWcnVkub0pEoF1UZgMx/aeTICSzwSP988I4dUnAUkwbxQd9SaAFvS1bSuwpLgiEdJtg75o8TNBGmpIxMrlZaNmu39djnsrmts8P7aKdS+L/H+crRvmTJrhF/vEiFe/3rx9zrmpB0/Gp9GiUaDUtBh0uFAfpqNxbxLmrf2t322g9s06y6/i3PW01f3YT1waMjZv8v7sJRwgAwLT8dnGmi2OZ89nq7xgT11BApccZQwrb3mWPoVHqVMRZk5lr5JOCZPeWcrVKVkTQ/ce0u1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199018)(38100700002)(26005)(9686003)(6512007)(186003)(33716001)(53546011)(6506007)(6666004)(6486002)(8676002)(66476007)(478600001)(86362001)(66556008)(66946007)(82960400001)(316002)(4744005)(2906002)(5660300002)(8936002)(41300700001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cjHHdTC5vhobOzgjH7ms3FIeS4CMV21E/PRbUhtOPv3QMlcCw12SViZl4GvB?=
 =?us-ascii?Q?rzn8OB69gSPxj6Z1v/gXmN/TkhksjEYZzH+QUumTtmHU9PLRS3bdVa1dGZV/?=
 =?us-ascii?Q?5oVhm0b7O8V6Q8oqTNXXJ/o5OKDbsUqr938PAr48gZfAIofKgX5kR++eUQDu?=
 =?us-ascii?Q?0LS35yMZtslAmdHg0qqRU2lHB0eo+goo6krDuevARVgp9gIlDit8Wuce9RA/?=
 =?us-ascii?Q?u5Zi3AaXn+HdBj+qiwkBO+AqcyJxMEpIYfxMAvxdx04sVQIxN+w1qccA0qZX?=
 =?us-ascii?Q?T7THXj1Whp0uh9C31GawQJ84PtMmxp/mdrgTFcP9Nn4GSiNPF2NdIaOgqALT?=
 =?us-ascii?Q?OV0/nt+/f0cenk/9U7NGbg/zSo8d1+iCKAIRsYTkWo5wnT64O5424/RKqjVX?=
 =?us-ascii?Q?hoRe4US3/FenlQlUtY4SiFMPtWdn9fid4oEi2KOKrO3vU3yrIFZvG8Xlurae?=
 =?us-ascii?Q?GfqRSPwLjruHOe1LZV1MJt09bWSnE8QFBaR6Eit5BYXAd/kcO77xYD2vbEug?=
 =?us-ascii?Q?/Er7MDrpmU7TfbwaDNHUbJkN2jvclvImgfNjwvIlmE2PqvLVvdDDd7dfqH9j?=
 =?us-ascii?Q?lEALQNV8+k0l4e7Y3eAvkbiiKRFS+M6UwnF5Ba93pFj6gb7gJoQfX6U9trD0?=
 =?us-ascii?Q?u/GRb8OLmrsvNCh2eN8k10OesN0p3waQ6J5VaKltvDUHOvS1DRkM9SM7Wpd8?=
 =?us-ascii?Q?14eA+uXsSeHSPtqL+XbHnt9/qmTSTQ/ILtQfifLNeTZF+H2IIlYZLL8usfG1?=
 =?us-ascii?Q?rFtdl2iYdIlhZO6Pcmw+DhvXjEirWWr1rlhJRv9P4QxxV1tZoo9HCZsdoUuO?=
 =?us-ascii?Q?PEsVcs7sWpbdjEgSG85z5S/NsnTmHqpL7ASztdzqTiB34/w6X1ZjnQ4QBOKf?=
 =?us-ascii?Q?3Elh3SewjVjI6+OUh8m8i6+10ly6yQcdir6QfUrU9TwJFTi7UU3g/1AsjW++?=
 =?us-ascii?Q?lMjnVpmpLWDkjZnhJp6WTr+zccgaQj5E/caOZIRlYZQ0yYLZNUssVSvUJ98n?=
 =?us-ascii?Q?wMLLbq/ZROs7nDrHR4CI3UCvBQfk820Vl1rg/c4ZvhuD5u0QLiaXviw7pKRg?=
 =?us-ascii?Q?r6Hi2iNN6qmimbahN1ecNONlOXDsCz/6Nm53RIRHw8n7N+jQy8VYdp0xq60U?=
 =?us-ascii?Q?5kSpL+yD+MF1P7udhF7oPJj5V5E6k5fl9/efQhFOCZ1itx7aYGRnsehgIcGK?=
 =?us-ascii?Q?34PA2RCWYA16VWtR06Oe+f4MvNtYBgbG+luT5mM88yBR5XPhhxnumtQc386m?=
 =?us-ascii?Q?W0FymzlWhMtuWJllXh3h0XYiKJEJBMhTLpF2AqeMaLR6dD4Pl2u1rK4RWJ1z?=
 =?us-ascii?Q?aEHscZMPDzdzEElgiahpE4Tuvll1WmbQyVw910jHz5QS7ier5tYRVdpX8sKn?=
 =?us-ascii?Q?o9LjK5eQ9gsKcTQbctxlc4gYUKDPoHRHH15lXPI2z9nJO0BmDfsrnwXnmF+V?=
 =?us-ascii?Q?Dmmnmz+WbpWQLwdBVBtmjefkgffy8eC3HvqZMPcUByI4lbvH49XmU1wOgTUN?=
 =?us-ascii?Q?mkcXKpngDEDRotcn1sayEPevTWdLUIic409HEjj0gdSdcHXkY+2hYLtT1qYr?=
 =?us-ascii?Q?FTzgR5uz/Ivm0tqWVturyWIf8/w3j6SSouqkQ89e?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dd0605-679f-4273-4e3f-08db0ab9ca63
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 16:22:08.6446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roCxGlo0Xp3BFlyLt6uMX7JNtlgti7nBmye9YLWfOmWnhSjVoPZFRlbCQ1yZJNjmuPRiSSZvVMJcw3kFe/4q3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5933
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-31 at 16:10:26 +0800, Tio Zhang wrote:
> Knowing who the parent is might be useful for debugging.
> For example, we can sometimes resolve kernel hung tasks by stopping
> the person who begins those hung tasks.
> With the parent's name printed in sched_show_task(),
> it might be helpful to let people know which "service" should be operated.
> Also, we move the parent info to a following new line.
> It would better solve the situation when the task
s/would better/would be better/
> is not alive and we could not get information about the parent.
> 
> Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
>
Looks ok to me,
Tested-by: Chen Yu <yu.c.chen@intel.com> 

thanks,
Chenyu
