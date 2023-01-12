Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D5E666832
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 02:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbjALBC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 20:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjALBCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 20:02:24 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3ED202F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673485343; x=1705021343;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Fq1jip0gFzMGYBtZANAXGm/IWDCozAIct0iLhS5ZAkM=;
  b=mQo34TTCfGrohpXsgQus7GbVvy8FvmFxtEf/DY08UecQEPATNpvkPnzr
   8JcavMrifyUEPaqzp6zvaORW9gK3jYTpentgVqjxgHvjXQ0SW86EVArr8
   iOVEcrZiFDXmBGPihMj8xD3oBFi/B30hG8mp0NO10RcndcreSNy7W0TyZ
   LXsSFqTat2C8DIIYHUWAfxW3JWSa/HNEf50qvL6TWGba0IVK5SXgc9Wb/
   WrTCSpFUIKsstIP3dg5tPku8YVlXnaUnKIj3Hz9VU52M1rat6sKII5EJ+
   OC41di9hTkY1uqJPxZnFlMkYbkOzIU8rXtFKAt8n8CZYTD09ZFYQWbduH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="307102730"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="307102730"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 17:01:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659572863"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="659572863"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jan 2023 17:01:59 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 17:01:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 17:01:58 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 17:01:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 17:01:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtZXJ2FM1cKS8pBWzbKSgy2T+0vOmYNza8hH4m8Br92HjU53CQbfkPfTkiD2NKhDde/3GP2xriSJqEZ84f4sUmRBFwjNE/WCuDvcNezKsKHFQfRntvCh0BPpQfNtKWYhKgYn4M1khAXLBPTNL5yL6YkMhWjue1Nd53czZNQ2kwbch4BIAdtuQgbwuKjI+qI0JTnIVBeJqw9fNKDYMLLzYysj6xB5mYQSWziK0SwWTS/s5XpYsAvvG7O0Qpt7mZ8Uk9xNlglHKGg9mi6++lRiy6wS7J3ZZ+Zxjyuu+Cwwnzu6Fv4fpxD0xOPYQlJuYtEHwc+TPqG3HRp8pJkATJ6piw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJsTrPIMcY+wVrRqG4G5XrlSYRDdzSAAt5FY6VVJ8c0=;
 b=J3tWBMiM7ULkRfpcV7Ijr78ZSvA9iGQhWml1Csipevrzc1q+tAdcrjt+SeH8bHZXbabdPLscJ2lguqWi7W/SgLWho2yAF9j6HXb1N7KO6tskk8iu6NEImoKu1VSQznyR90AfBc4AM8Wv7D94wBEqWyMXgLkJojwQAjhDGjnqq88jwfuqnI5PeH2YQVmg2C2kZEYNFcGU4zoHukoYg51CDu/4k9aI4iZoLVefJhBdaf7HLIdMOLKUQLoGMiGwpuS3wYxoOnQEfAzsktfuurRHZ4Nvitcg1K1oy2MpXTCDvujDlV4yo2bEMmi5k/xrLVAseFH3rF9/o28vsRM+TiGSXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 01:01:56 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%3]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 01:01:56 +0000
Date:   Thu, 12 Jan 2023 08:59:12 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <sboyd@kernel.org>,
        <corbet@lwn.net>, <Mark.Rutland@arm.com>, <maz@kernel.org>,
        <kernel-team@meta.com>, <neeraju@codeaurora.org>,
        <ak@linux.intel.com>, <zhengjun.xing@intel.com>,
        Waiman Long <longman@redhat.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [PATCH clocksource 5/6] clocksource: Suspend the watchdog
 temporarily when high read latency detected
Message-ID: <Y79bYIAfZ8sBjvUs@feng-clx>
References: <20230105010429.GA1773522@paulmck-ThinkPad-P17-Gen-1>
 <20230105010701.1773895-5-paulmck@kernel.org>
 <87r0w1ia65.ffs@tglx>
 <20230111175056.GW4028633@paulmck-ThinkPad-P17-Gen-1>
 <87wn5sepl5.ffs@tglx>
 <20230111213210.GA4028633@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230111213210.GA4028633@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM6PR11MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ba1a66-f613-4770-ab8c-08daf43899c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgtmgcF6W5iViyqfNNL30g52xUHyadRkvnBUiPziQZb/Vkv7pIEZzLDazCZmcOuV6HBp6Fs0QGKrQv2r44YOEMJ54m+rHBwr3Bp+hywJFKiBGoql7Lsq6QKIV11znkNQox7pVwOEbOyZ9YgAPGZEyMIupk5j6xj8RIpxD9q9EdeY8j5Qgkrw4BIeEy6jojP4fc6GJiaoicykZruPEtGXFH0w1bZ6WUQj13JYzxaro60xc8Uia7rOeG8g1AjwvxEAWIRScQafK0UzqaZsplfRbhIBVxiNv0G6zWzRh0uaA5qxRYSqo1/s8Sfd7mV8/S70T54VNyjZsENCnejsUeIRFsCtcXVXCu69PeckRiJO00kmlKm1+D09rCsNEimGaDanxA2FNQyXW94gto6KSy7Upn71zN/DeVvb36niw6I8AFCijMuZKN+mtr4jW8lo0yxVEtmIHR7xE7NFx2+NaXu7cLX6tC3IaCdrX5YluI64qWAwqS7aHxm5lqyJ70KK/pg7KiWYXFOBK1j8Kd8O54aj7rWcIqblVHn4GR5qv7P6y1fGp1RZA/SKXBww8Yw66bE5Yq2ktyUSmFy1SMSo4brhlClRXsxyCWcmjH27/Q8mEN+IEY0oU/TSPXrKM439FGdByHQDa+HC9lGO7aQQhraMgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199015)(6506007)(7416002)(6666004)(2906002)(4326008)(5660300002)(15650500001)(83380400001)(8936002)(44832011)(8676002)(6916009)(9686003)(38100700002)(6512007)(82960400001)(41300700001)(6486002)(478600001)(66946007)(26005)(66556008)(33716001)(66476007)(186003)(86362001)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VfFItx9MEHL8T6iRn8jek1h54UQYhm+L2m4BWG5JFqt77VJ7zJnwrO+2HZN/?=
 =?us-ascii?Q?N/1UE2l1FKNqVTeozscLk3Bf9yKYkXFfs2WhSYN27Wc4GMyN21tLAoSRX/7A?=
 =?us-ascii?Q?PMohWKG+tGa0rz/wmSrhtQU9u6vog8ahMTKlIGw9CDPVUqHZAszmcDdyvWmr?=
 =?us-ascii?Q?F70dPSQueNXyR0X7KmMg9v7/Tp/bY5NClv2YuR0EgacSBQ4pMc+GjqmShwQi?=
 =?us-ascii?Q?EOtlMHmeik2O9MseSRTs7LivSwka5TaOyWp+DZMRi6ssk0cf3wdPWadOSUmK?=
 =?us-ascii?Q?38VsY+svbP3E1RiDFWoum2vZb2Lr0/cQ5FVInFkZKiU2YzIgax/Dqku0pOIu?=
 =?us-ascii?Q?bisv7EY8HoSD/mSNyLilxNpL6C4ucYbhgXH1tTQ9OoYwH26QCblMu2TYUG4n?=
 =?us-ascii?Q?WC3h6h8n0kCXZCXEnh27lnQWGzqPoIekLQAf0RgW3x5z/Fy3OAYaCT6Wec1K?=
 =?us-ascii?Q?JGbGno9tjqdQfJzapU8BH0IW22BH4yIqzLNfBVUjUbddWlTWRYNwyrad9rwQ?=
 =?us-ascii?Q?ZN+bgJHfmpIOv883P4kSLgbvNy0S7CexLFhDi9DvTc0pmcY5CLTDLEAnM4JD?=
 =?us-ascii?Q?qSyTtiowrAJ9KsDPg330GS6v+qx2ZwA1wyY0Zmk9ffV4pkj8i5P5f52b0lUy?=
 =?us-ascii?Q?MIVunR7zHWo8Lt+lvcYX4kjd/rV9hwygfbWx4sOvjvG+++lv9vgsZG9TlAd0?=
 =?us-ascii?Q?N3dNEhnBseHzRSUeJUD2Y5VFgvEdPZHz0UiMRP25m7IygkYiW2i2IfVl7+Wl?=
 =?us-ascii?Q?QMKNl9zQwbkCt9eRUP/coh64JcwCt5ug5SM0uNz1PKLO3/VSXJVlLtV8fhZo?=
 =?us-ascii?Q?XToZ4YhrRK973d8jBoysnbMQ1lGNeRZsaWzmPAWGgL5X9Ddmj6SYJtM2kqQX?=
 =?us-ascii?Q?ky7AhJJ1V/R9NbcndkRjO489KeF9gbWPAQqaFnrLMk1VSyTxnjZaet5an6IS?=
 =?us-ascii?Q?VnjnWFHjr7MlziYa0Aa5IPB4XYYhHjQkcFIC1idQdeq8mGfQesbq5ITZ6OHT?=
 =?us-ascii?Q?iPa60Gp1EpDMoE97+F+7JoVGzgEBHCRIieNAnGF3JOQ9IYtfXPPkYPTdbCvU?=
 =?us-ascii?Q?ZtD6PqMhJVolYbqrwX2E8wPicnS09eVdYbN4L30onYSuuH1iZ0iemB729ecZ?=
 =?us-ascii?Q?JGj3HD07n4WcmDO7fc+mrdJu63cwLpGigvr5F1VMGPkzGLO8iwvR4ens05+p?=
 =?us-ascii?Q?o7e0ji3EiA3HRaDGULxJqgBoNIm0jE4sA0Wajtk7y8w3g3o9nKJhtIL5B1Ra?=
 =?us-ascii?Q?3Mcrn7eNWPHRaJylr15uSL8itu3SiziAi0bTDz65HIpSqT+OPY99e1xY0uQm?=
 =?us-ascii?Q?sYxF5jgkypE+FA7wnyg+ArvlzYTlSbR2YTaPKcxNLbikg2Rq7AyNELCOTz++?=
 =?us-ascii?Q?YHItSUMKC1Yje+Qt8IZD3quyXIbp8NkLvgCPjzhH0HnRpkOsA3CajIoJyzpD?=
 =?us-ascii?Q?n4d8ovqzZq3ihs0w6cwoIxQlTdKGsuthfbUDaDE6ZxmC8wj7xsugq7g21IMK?=
 =?us-ascii?Q?3/c5eyfF+TUdulrEBlBuydwm1YBq3DD6/MgKfWVyDnp2gJJotEWH+0v0ju+Y?=
 =?us-ascii?Q?DuvXIP2o8w84IJBmNs4qSDCe3ZpTSGem5o4wZTEO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ba1a66-f613-4770-ab8c-08daf43899c7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 01:01:56.3614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /keqZlsgMBp9AKjKUcbu+32EtgDgM6L/v2T4503QemYXgz1sfGR1RchGCxhd5sJ5fDyZzimqrAzpCwFLOsEnYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 01:32:10PM -0800, Paul E. McKenney wrote:
> On Wed, Jan 11, 2023 at 10:19:50PM +0100, Thomas Gleixner wrote:
> > On Wed, Jan 11 2023 at 09:50, Paul E. McKenney wrote:
> > > On Wed, Jan 11, 2023 at 12:26:58PM +0100, Thomas Gleixner wrote:
> > > Yes, if a system was 100% busy forever, this patch would suppress these
> > > checks.  But 100% busy forever is not the common case, due to thermal
> > > throttling and to security updates if nothing else.
> > >
> > > With all that said, is there a better way to get the desired effects of
> > > this patch?
> > 
> > Sane hardware?
> 
> I must let Feng talk to his systems, but most of the systems I saw were
> production systems.  A few were engineering samples, from which some
> insanity might be expected behavior.

I've tested with several generations of Xeon servers, and they all
can reproduce the issue with stress-ng stress load. Those platforms
are not bought from market :), but they have latest stepping and
firmware, which are close to production systesm.

The issue originally came from customer, and there were engineers
who reproduced it on production systems(even from different vendors)

Thanks,
Feng

> Clearly, something about the hardware or firmware was insane in order
> to get this result, but that is what diagnostics are for, even on
> engineering samples.
> 
> 							Thanx, Paul
