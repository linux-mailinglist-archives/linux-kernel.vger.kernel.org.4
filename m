Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2E85B34D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiIIKKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIIKJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:09:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959AF2E68E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662718195; x=1694254195;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EeUWrCt5Pta97aTJvqgYZPZ1nadr5Goyur7O+LJWFe8=;
  b=ORVSGxbvib6YvS1P95TPejsT7WaBf86+cykGxbsG2BBFW6NiUWtw0m7Q
   fbxXLH7BRTV+nfQ8xetbcafLqhdmbTlyTx2iEJye8XPa2yoMrGwITlug+
   33lijt1EUPI/hsp3nJOm5qyRn5IEjH8EZWy9ilbWKKCo2abdEt7+Ff3Cb
   s1RFSlgguMFG2W44n5u59FWTgh6fd19LDbpFtyJcYODNbfrJZvrrCqtxe
   4O3O4tYIxbwOr0+6sZDXZsTows9aToSD3y+M38UWOivyRcgxx4m9a0Vbr
   SYfnrpyB0zdDbbx3PWYXJ8JSrlI0olDnDrD9z8N8KBlE3FbuIRQnREIPS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="280468195"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="280468195"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 03:09:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="757553496"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 09 Sep 2022 03:09:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 03:09:45 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 03:09:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 9 Sep 2022 03:09:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 9 Sep 2022 03:09:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnRtC3Yiog2zno+sUTd2p+N2TYfzRLG4jmL2rypBRCelbyU+puSVnUTuMfDNBXIDwhUTFqR9MaIIMFzFsdlMyneaMps4AivyPRrW6K5fdDtbe7K562vuUw2q+CegVgmfkM2/9WmrxVJoJhEE7KqcNo/FtVd6dpQujKmnse5oueok8QboYMkBU4FD+DSzAawOgCH2jHGrsr38txNRhsSh1oerAL5hLNWQI8VODCAfzdq+AjTpgzWDa/pyYx4xww+eNFAadJARttt29A3J/paTR2pkK1QXD5vZ8HszUmygx81PEId3J8AZTDUQvXzxZmR8R+wU+kgaNZU5ILt0LYpTww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19G8veN09ixIOlHRLRZmAZWHWz4IYMejEGTA/wX1his=;
 b=gfLegP3NacP/zN3dEVBuIV5YfCdYboVcNsQrgmED1CI+eCb+S7JUuuhSoXb3DR4hW85vxlKr86MVKWqQIlpBUViH+B0kAtiUBkGNmsIXZCJ7k1jtB+GNpo0y07IKduLRB072RqrEYuoNUwQkSumncupkX4h0Lri7W+aT43gywy6Cx/6I4n50VDWIZVeKfurW7xBtCVTv2KKj+7GvMMs2O1IK6RqksNh8CoVPZsnwpwTFDJFFEt3phN5RB0V4SHaqZ6ZUb+1L8FauBbzir9XqVaElzMREY3mW4gwFu8PWprFHhhxD8EyqD0hccFGOmNS4i1EC5n581nOn3DDXMnxYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH0PR11MB5143.namprd11.prod.outlook.com (2603:10b6:510:3f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Fri, 9 Sep
 2022 10:09:27 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::7c1d:1bee:fe96:695c]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::7c1d:1bee:fe96:695c%6]) with mapi id 15.20.5588.017; Fri, 9 Sep 2022
 10:09:27 +0000
Date:   Fri, 9 Sep 2022 18:09:13 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] sched/fair: Skip core update if task pending
Message-ID: <YxsLXunUjY2vBeDX@chenyu5-mobl1>
References: <20220909055304.25171-1-wuyun.abel@bytedance.com>
 <20220909055304.25171-4-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220909055304.25171-4-wuyun.abel@bytedance.com>
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e65cf37-4e78-4f56-0430-08da924b60ea
X-MS-TrafficTypeDiagnostic: PH0PR11MB5143:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hcKt+yPYq1sPjH1s1SSmGd1e1SME1ARAmebCOnaY+quVFuvLzaSffmRKAvx/2YAC1b+FJPu/aZ+TVqq7K3wcinam/S0JvC0aYRwCw1SuoTunI2/W+Z7lSk2yNwHQsk1DgjXvkGBHyGr4tx1ovNpgj/1Pf074kuj9sO+EPgHIQRhRRmLBPNjFCAMpiygflXKot2+8vldMCDI0FLIYkKOPVU+vk4/YzpHqT3l4jD0XRPnUxL0+R5plaT82pfwdzcBVuW2B8snVkyl4vR6t7Unj23ZZ+AG4ykQq+DsRhj9ge4I0tv0h05JRB5HuNRkyIBtb1UrR3ENlyVTJgCS+iEgI1s9BfdW1HIH7cPN3GU9M6J5I73Xl1iT1UH0vLtOJNX+vLtVsaMz6e4z7hKFjSbUHezD1nFTBe+RZ0jGjk7XZf09JKO/TFGnY3v52K2yqqe2Vss3Ffj9bvYevWbfEblE/lqZIkjf2fEk4GSi16Jsg+cUfztUpxNj0BLb5UsSphGk0m+QvzeNfcXacf9UhhD5qA1i/Cc9qdWP0K4tAewAlipJksusY8711FE9lrDmZ5MRfA0f/41P6KoCXTWX/lGhdLMap1Q2L0DLI5FZDkd7DJID4t2hwv+bpL7vzaXUGuTIz6pNrj7E5vybUT+mJZ17P3oLPL9dGGobik2DiRDvdQ8i3e4x/et1CZb+g8MVK1vi4btIr5mU10Nfq7RsBjeWFfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(136003)(376002)(346002)(366004)(396003)(2906002)(15650500001)(6486002)(8936002)(5660300002)(83380400001)(8676002)(6916009)(54906003)(316002)(33716001)(4326008)(186003)(86362001)(66946007)(66476007)(66556008)(6506007)(53546011)(38100700002)(478600001)(6666004)(41300700001)(6512007)(26005)(9686003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FQ25TMC3dJJpY63kukqyLxkCU1N33oM1QJHdI3l6/azb/KIub+/UeGFnYoem?=
 =?us-ascii?Q?izFR6QlY/9QloMjIUcl2r+FBgpef4xBfls6u6NO2xKVLKlY2fgqIM6SbG86q?=
 =?us-ascii?Q?fCGyhSG7EVAgUNzEIBm4X0bSobxgKcDUR+fEpT2OhW2sjwan59VisWcJaW8i?=
 =?us-ascii?Q?9sdniJSdVYmr3ex5ytyJI2Wj3IPaTpMcdsKAowsYDN1ZuhnpT/VIZ3+V3eVh?=
 =?us-ascii?Q?yklkyzPA8bT2/pMJIUEIRW3xzvDre4bDeTYMdOV9/JLrI1df9i79UbCmAHkb?=
 =?us-ascii?Q?1umClOv5Sj4BUpOPknfjKPajuKBNgi/8Cz+lc8mU0qJplONJ/bDt8UCWHqoP?=
 =?us-ascii?Q?JEa1bYb1LMkCPcg/JuvsS4WYi4DEDnWHlc+php01MP0cBsyIz4VVDcikVNKd?=
 =?us-ascii?Q?OediK3YTygWDfQhuQgWj53NQ+9h2/ingmkhyLY8SKmChVwXALIrxSOgbiXgY?=
 =?us-ascii?Q?zHGn0hEsbRzu798XRtHiJ8E94OOmLUxq7DJRjR5qUS0fP9BF1dU+z8U/IBlu?=
 =?us-ascii?Q?j8QTqx7+nkvj68BD1M4lOe1GJ8DG8iuvjUD5nMexuAMNWTqO7yK4x5d4/Oj1?=
 =?us-ascii?Q?Mf69O4XUWyIHlYpNdQuMz2Mu99uzRYSt8dCRlXW0HMLNbsydb96wq7qyGfWR?=
 =?us-ascii?Q?JnHDcuL/FgnCXu27GcnHGXzuBPVfIVRrcTxP2AtA+XzdhOFJljawk3XanNPt?=
 =?us-ascii?Q?gk3PIRxPg6+kk0We/pSAS7T+ji3vqatijUDLOKbX7BdkzXy7sGeL1FXFeqEQ?=
 =?us-ascii?Q?97nWsJ4J0ozio46xow4qHey26Qe0FvZNj5CP7doPvG2xuaAbJsWlql7pwFbh?=
 =?us-ascii?Q?9c6eXMf4eJIFMqpi5vVmNutW/bTvM/E5hq1+U5iv5AfenbTk/93b/wgc7Stm?=
 =?us-ascii?Q?Jf+wMvnKzKIea2nYlylBrCj/OZoWvzxW3S3BYIF1ylloGJ4y0gJz3tTkdxTS?=
 =?us-ascii?Q?yWzJUzMKVb+OXQ7+liTefDn2H7AhvvKRx4KcC/JxQ7fg55b1t/XSZRNu7ug3?=
 =?us-ascii?Q?8phPYjyQkXPuhH2wTQnHIwOUNHTllhej9bc9FhLsyog4LjcKvpVOepErZiNp?=
 =?us-ascii?Q?DePxr8MFSr4Hwfk9pfyNfj/T1p2Vd2BCgHJwuMv25DUNV/5fSLk5vjP1PA3G?=
 =?us-ascii?Q?jjbcFESLRSIbhKXGhqhl+cS67sLsfdoiVh6+Bebg0v/Yq4whmWkQUjKGGN5m?=
 =?us-ascii?Q?vNVqR1ol3g83qOfCdCh2aLsRdJffkCUMZxId6kMbyuJ/ti8PJe2y7ttL8qzD?=
 =?us-ascii?Q?Xi6p/0adV7mplkR45238Z/iCTJZ08K71/Dm3MhLwg3jsqluYGeKoo1tSqdvL?=
 =?us-ascii?Q?uNA8/hr5R+LbkxzpWcK2Llp4D1yfTU+OOjxCOoHxcqK44gSTQ6tGHFCZ1S2s?=
 =?us-ascii?Q?e8Ow0QV8AW3SfWSQeTXYdaGi5fZPnP5mNcdu15YLWyrjQhqCvHCLbV0qeujG?=
 =?us-ascii?Q?kNuqDxMxFpFB5qIaPh2MGkSi9kxB6AsMGMSQTuEQpKyLOrlcYVke2VQC0tOf?=
 =?us-ascii?Q?xF684PVz1ToaOtEP2g4uU14Gy7yOKRfPYFrtDYk6fbLFnpJHk9TJzRZcnFNg?=
 =?us-ascii?Q?IphFFze+Eg3Xdl666A5MUV2YCbzMINav2OC3v3/e?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e65cf37-4e78-4f56-0430-08da924b60ea
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 10:09:27.5810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WPNynIdEcYCStqhFAjOlu3wBb+NfAru2BO4FkxWjhgIdZq+7Y0iq47VVP32y+JNtajF4KWsRvt8vPE8+kfbqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5143
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-09 at 13:53:02 +0800, Abel Wu wrote:
> The function __update_idle_core() considers this cpu is idle so
> only checks its siblings to decide whether the resident core is
> idle or not and update has_idle_cores hint if necessary. But the
> problem is that this cpu might not be idle at that moment any
> more, resulting in the hint being misleading.
> 
> It's not proper to make this check everywhere in the idle path,
> but checking just before core updating can make the has_idle_core
> hint more reliable with negligible cost.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7abe188a1533..fad289530e07 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6294,6 +6294,9 @@ void __update_idle_core(struct rq *rq)
>  	int core = cpu_of(rq);
>  	int cpu;
>  
> +	if (rq->ttwu_pending)
> +		return;
> +
Is it to deal with the race condition? I'm thinking of the
following scenario: task p1 on rq1 is about to switch to idle.
However when p1 reaches __update_idle_core(), someone on other
CPU tries to wake up p2, and leverages rq1 to queue p2
thus set the ttwu_pending flag on rq1. It is likely that
rq1 becomes idle but soon finds that TF_NEED_RESCHED is set, thus
quits the idle loop. As a result rq will not be idle and we will
get false positive here.

thanks,
Chenyu
>  	rcu_read_lock();
>  	if (test_idle_cores(core, true))
>  		goto unlock;
> -- 
> 2.37.3
> 
