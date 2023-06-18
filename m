Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F060734703
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 18:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjFRQc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 12:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFRQc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 12:32:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A17B4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 09:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687105976; x=1718641976;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kJxbpGc52MZk18xNKvjvR4W/ruYuC+//60mrUy/bHbI=;
  b=J9YRrjxbn2MNzmK2Auwtno8hUwWdvmbuaCkydMvbL7poiPQ3X/UBDgPY
   e39fctsI1B9kXlJG7BB3VJTnELHiHI9sDWN0K2B8/pvEvZOPZQeMYgA3r
   1vf77tHjk98gDXJev8uH5Zxko7nC/VwaC9s8jrkvmhHZgm51cuUoJJF3r
   mIPgYwKIIt1SmqONRGQF2d519NG03jWBSq71T6csOhuhp4nuho375s+wI
   vrWADAQMZtIeWBUTZffSDtb6KgMCDXib2jHMyT1QIUZzcE12j8qAv1BCv
   R6I98kSmbqRJtmzQWXqPjA+5miiApOXiPxoedkTTZQcf16V3Ijx38Bn8/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="445873016"
X-IronPort-AV: E=Sophos;i="6.00,252,1681196400"; 
   d="scan'208";a="445873016"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 09:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="690844333"
X-IronPort-AV: E=Sophos;i="6.00,252,1681196400"; 
   d="scan'208";a="690844333"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 18 Jun 2023 09:32:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 18 Jun 2023 09:32:54 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 18 Jun 2023 09:32:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 18 Jun 2023 09:32:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 18 Jun 2023 09:32:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmQqJQxLhF1Nj3aM3BAWJjgN5f4TprRKbeL226wecn0xj+Ds6i0WHsRpbDA7W+fxrIM7C5X3Rue4UDU0DPAUcev1Rd9GUv9lkNawSoiAvZQgTNBBFrZ+ZWFqUSFKJLo+XDySMFIHbzCIA2iyh4jpR2gFfX/TGpqpqar7tO9k9jEf2X1z196WoMRIgjG1tQJDvT0VZA840FQ8zwD8qIyDlPH0bm2fkJIVp6dAFbhHew8XE7h0DQ+FlR8rmCNPsGTz4ouxvL0kSJoO8Q8NKEEtvLBWA7JAt43ove3kTUGwt/JkOFqw90tLBOjhrXmdCEy+j0LTb0MSBC19niGoGOyGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsfYtmHIGjjnAuL04CXdNHN8H7eoeCXkYRgQm7NlU+I=;
 b=ZcrD0hsS2ol+Kn9bbbn/QguNGmJRFevx2HF9g83FgVJm+XyGH9OZASOZc+g3Js7FjaJsifgDaiU50FcmPbgSBsIgBZGaIsiH5QZAEbDG8q1d3l12hf2WtGt0iZSRG4GXRrLkv4p6J9IjLfDF0qeUUSiW0gcrj7Zf6iqwMU7D2P7mYN1yS+km8GBFT6f94jdTCN0UW9wreI8JD/rBd3NCkCVrJ+fb5maPtYMH5GBXMJJYKL1+806dfCS3UaD4GPR4Wm2ZinhSr1JU7qAFYBXR9QsPFuJrMZ6eLDT09SjRxw25oQLTkMJ4lV7DhxWqxd7zwW111n9yYfkhhunlXZ7d4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CYYPR11MB8385.namprd11.prod.outlook.com (2603:10b6:930:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Sun, 18 Jun
 2023 16:32:52 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 16:32:51 +0000
Date:   Mon, 19 Jun 2023 00:32:25 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <tim.c.chen@intel.com>, <ricardo.neri@intel.com>,
        <yangyicong@huawei.com>
Subject: Re: [PATCH] sched/topology: remove unneeded do while loop in
 cpu_attach_domain()
Message-ID: <ZI8xmZqmyHF0jhBg@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230617081926.2035113-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230617081926.2035113-1-linmiaohe@huawei.com>
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CYYPR11MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d389da-480c-423d-36c0-08db7019a8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDQoyi9MYxLEdoJnQtGhIib4FWIO5KP5Uh3S/pqsHmewhS3TVcPNpPQweBdo7hrRwmKkt3ty8GNV41byWinaVvYc3yF6J4tvGDFjfhLepnfBGI4ljzMHFrUlAm8zmyT1ZJ5YtKfB23CB+5DatJUT9srla227l6UIxnVR4BD1VsjMXxcMuAm5WVFe3YGkObNl+VfopIJUfroB5z2wHIRD2/5HMalxZ91kU6cDsdaglan8W6UM9rJ/TtUXkh2ZidKOaLhbr/p4Phaaf/sGOc6P7IKsTpRPJPAnhDGNfjqkZBwplNeMUWSlNAKk5UzweCVRBp/GqZ0ZSBLgWmQOGKyobrJQiMKuGyknZAwPXZa4qfPE33yqDQpZg8qOw3tTh4X0Ceiax3bQg9kKMqNkQn6cmuM9YnnUhPZBN3l8TaV83y25iJnqklK+tz/lFl+llM5gT7LJFRtqBlC+TdqArc9BDFOv0MXMPqaKYpUjEBvbUaLjak9h2qoO6R3wa2BaAPZIDmVyWHcxGuRGE+bWJvk+PN7Nxbg2YBf4MxX3AfdU/ZcTBx5Zn6GgAyRFaxXQxy4k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(316002)(6916009)(66476007)(66946007)(66556008)(4326008)(186003)(82960400001)(38100700002)(6506007)(53546011)(86362001)(6512007)(83380400001)(26005)(478600001)(6486002)(4744005)(2906002)(5660300002)(7416002)(8676002)(8936002)(6666004)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dud1g/KfLQxoTl+O/t61qcCL92xSgECqp9p6+UpJDdzboI2nhUEc6p3ZmSud?=
 =?us-ascii?Q?DJ56Nf+71eZk5/awmj8OzDfDgbPavG1jI9HWvJwk4tnMFe+eK1c2Q0wiSFCZ?=
 =?us-ascii?Q?A7D5MOWE+SXxwkl84TxehEI31A+tIsOGz8vXBJW6l5oAwNIUuBqBTES7/4k1?=
 =?us-ascii?Q?NMv3DpuQBwA24+F5e7fgjeXRf9EzuPcru0Qel4VSWb+iO6K3ptj1NmMR3izA?=
 =?us-ascii?Q?NbY3PQT/m4nyJ41VaRA0D2XHBtro+G5dvEuBlS5Uot614dw2nyXWEXdFB4Vp?=
 =?us-ascii?Q?93r522SZLmguqdLVZeVOALq/0fLRvKpmTeABjhUvhBVrdNlv3eu7uDQv9xtm?=
 =?us-ascii?Q?im63T6RjVh6PcT0qKnSS8CjZbAO+tUNAzMF1XmvBWeAgcaq/KtJ4tIxVn6Ez?=
 =?us-ascii?Q?r03RcMsbaG+5ed46z9t9x52tNRHn9JFfRWJOKhX0q0ZqeF3WPH3inyeTKbDx?=
 =?us-ascii?Q?/XUZ1Ii/pu5i55Oc1e5b5SPMosniB0bbHbSHvIYIZPNtbwxWzZvTYpDUDqeV?=
 =?us-ascii?Q?mvMsYzjYjNmC7u9Vl5PTUpyCYfHamy09I/zyF1gTLSgL7qCRhajwV1qFT3KI?=
 =?us-ascii?Q?zIS2nGbLNj8P+GcXl2hpwJ0+hKD1PzeCLuiH53L7fMe2h91uxsCYSnvbYw1S?=
 =?us-ascii?Q?htQ20IJL7MCZnCqw7qQ4+ARQXxtjumOVY2kcXwIMNnzyx9qXY7mxOeT3qcxo?=
 =?us-ascii?Q?CAE9zuM6/maYBSkQRxc7p5fdZKwz+MBFqjui8rKL6hrP9L85VL0iR1YxBz2L?=
 =?us-ascii?Q?WsWDndvoMwqGR8aGP7Z5AR0bI+iMbztjI49HJuQnvZaMFLBGznh8x43UyEWE?=
 =?us-ascii?Q?oOkz+yunrFwPQYzDkI0yHX1aTNN+NmpbsPxJ8PVXKKNLUClr8c8Mc65+nJjz?=
 =?us-ascii?Q?kmx0a4pdNnDAEhXfYEfZHX8+xF2izlSWPq9bZDdXs2pQCL1jibMFjHl5uQZ6?=
 =?us-ascii?Q?NIP8X7vCfyyVtDixVGKmO5brG0NButipQHlLZrKkywzXT9UF1EGQz+oAyxJC?=
 =?us-ascii?Q?vtxK/7G9fj/5UJ5SgdzOJI3Sym4ifE9D0nnHH4najXIcPAX3iCInIjHnX15o?=
 =?us-ascii?Q?VTzexfqVZdtVhsq4mBrqjDGWD+2svicAUL8GkuhU54p/i8ZG+6Jlw0ATrIu/?=
 =?us-ascii?Q?iAo5CSnmO3JEhRwXtiYYsQft9xMzDKfWjJcde+7oU4wM1aWzkCEwe5BEcL6N?=
 =?us-ascii?Q?a8jT5vW1stwb7RZyW6yIg2DT+xjpdowfF9LaASmS6y3l/TT2oH80C8+2TLhy?=
 =?us-ascii?Q?scmIMQNyuHusgRu5xZxcSaGnzBpUJujiweHwhT0eQ316ghHfh2TP0qMTYb9e?=
 =?us-ascii?Q?ufGqjn98c6vrZs0pjnKc1n7ao5N/1W2xqtL70YRnmgcTdUul109zH/UK4H9x?=
 =?us-ascii?Q?i0Wfe+EUFotkFu3/EiVmH+NviTXLnPzI5Xql/29aaXkCR/olucw9ALe6Ek/1?=
 =?us-ascii?Q?tVgCVMUO9lxdhGNf0Dtjd8snKtwFBqcfcPCwZfqoIK9I5OTCKqBbfhIoTYzu?=
 =?us-ascii?Q?uhQqDF+0Vnrzk2WImM/q6VUGhOukW0/nAJCQQZnbOhec8gKz8O0PfVwAhvKf?=
 =?us-ascii?Q?8Jjk4C/8kJbIFGUCARVgb2Oc3JVgQmn+QrZGQ5Cs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d389da-480c-423d-36c0-08db7019a8ea
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 16:32:51.5210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxdOQNrnFWcPhSP7E1pFlz2kmYWZlex+iSkRP7HDW88aIX2UwWpta6NpF6EZJE8tercH8V2Io4EGxZby+ZaszQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8385
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-17 at 16:19:26 +0800, Miaohe Lin wrote:
> When sg != sd->groups, the do while loop would cause deadloop here. But
> that won't occur because sg is always equal to sd->groups now. Remove
> this unneeded do while loop.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  kernel/sched/topology.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index ca4472281c28..9010c93c3fdb 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -750,10 +750,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
>  			 * domain for convenience. Clear such flags since
>  			 * the child is being destroyed.
>  			 */
> -			do {
> -				sg->flags = 0;
I guess we don't need to clear the flag of remote groups for now.
> -			} while (sg != sd->groups);
> -
> +			sg->flags = 0;
>  			sd->child = NULL;
>  		}
>  	}
> -- 
> 2.27.0
>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu 
