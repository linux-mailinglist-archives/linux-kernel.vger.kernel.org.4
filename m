Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5C960C560
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiJYHgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiJYHfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:35:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4073B317DB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666683320; x=1698219320;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wEHz88z3NRDxbASRmlHZFiIy2JLlHmTjerq/tbuFsq8=;
  b=cekxIm+7pGhi+nB8olx1siJmGlkOYGj2tTk9gpntpftWwcGPZS5wPIc+
   nDWZpvmrs1Bq0qOHF3uNnQFy6CzJnRixHeDyNK81Nh6c1b1WGpneDOxz5
   tWNd1LjXUxorctgGlfnRM+xs6H6VX6jKOUdstSzSmx0irCqS3VoYRo/yl
   B6VY43/u7Obc7GJ+24xIFxuCBwArHjzFsES3RXT2xnUo/3dM9w8uJOP2p
   CpVEl+bbx9HwWFKed/uvgWwlSRJhPNbOTNK6bPJM1JAbUR6gOCCQrv7lu
   qZxgZ1EEFMmzTUy3t1i7i/9vO8fupe8iH6JtV75iDLoA7nh8daXgFFNCN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="369678816"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="369678816"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 00:35:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="633998056"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="633998056"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 25 Oct 2022 00:35:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 00:35:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 00:35:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 00:35:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 00:35:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrGWXG6v4Me1fEzi+ZzV5uuiE+45G+dkckKTRBPm9beJ2R/jRw764TfNxIiV+uN5VCPIykEzHmz+KIuQ1jsZBtGdTzYxvsRZuOD/4icm7Q4bqFTpoY+bDGBjZqfSWbvQw9f93MzGHozapmUDjwwkQaGkswATbn/yhvu4tX9JG+uqkeeJ0eSYXqqVRxdSqO82JZeUMPRhToxcdywdIl4SKGZiSbPVRz4KVqKniGpN5TvzFvGdfNI6O5yx0GQu3CtpOCO3jDX+pjw0Q2gRD7cViN1lrHO2jMe0e+hbyu6ZaYbR3ct1t5nypIg1mHo5V1chTbn5buO9xNHSepEh2HZbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rv+kZ61NgjguWf5Vfn2oeJMPa225ibfilwcGp0cUlMo=;
 b=SyqLyDftKXr54a3dBX+eHYQsChAeR6maa6o6PsFuwtTPPGbgxbsed+J4+uqAJ2RR+KfxZfzVAmXcJInIq+BEKj1oeRqQZaaNdEEz8toFUj22gA67347rcVl2sCt0yvKkCpvCtj3e+FKRN3Ogp+uaoYiDL5FILYyY7HTKA3qVh07kZq5EGzK56VIkKAFBbYVLXU7wm7uvFNgBvvvXIjI9zHAtmZ/eqJecL0p/Ov1OfwNCcjHhBubaeywnWGPWWbECFEXtkENsUf/AdSqWVEjFvk+rFKvGlJ5OFsKcj2EvfksHtw8Kyu7frDRmnD02CxI6a8Ndll05jSo4w3jQNUEwuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Tue, 25 Oct
 2022 07:35:15 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.033; Tue, 25 Oct 2022
 07:35:15 +0000
Date:   Tue, 25 Oct 2022 15:35:04 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <tim.c.chen@intel.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        <liaoyu15@huawei.com>
Subject: Re: [PATCH v1 1/2] x86/tsc: use logical_package as a better
 estimation of socket numbers
Message-ID: <Y1eRqOZIRYtC7ZAE@feng-clx>
References: <20221021062131.1826810-1-feng.tang@intel.com>
 <f27e4b3f858890c657df9a7d6f34dc2d60b89757.camel@intel.com>
 <63dca468-c94d-844a-5b19-09c03cf84911@intel.com>
 <6636557f617ea5a1a1ab6f30f7aea0ececdd2a36.camel@intel.com>
 <dfd2fb43-2a19-545a-fea8-f793a685ef30@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dfd2fb43-2a19-545a-fea8-f793a685ef30@intel.com>
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CY5PR11MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 0544ba80-0ac6-4511-c92a-08dab65b7559
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6Qoh5bgWqSEXVZ1I6O79PxfDhWuOwy8MteZDSQlAw2JACvHHCbE/m4RDcYKr9ahv96aQBSY132LAPRwHu7x1QUqfH8CQHPmDVrad/kkk5SJl1rWsX3mBJMgtj6nixcz+JiXZMdrCxcLtrFuh1Z7CjzsIFR9X6FJu4qWp6ZzpAS5PpVXV8KX+aifhtk5hBTj2kT03zbC3IH5OTMeL6WqmGlcGvHZElmz5YAPjNLUUXuwtF270aGyoSHeDV2bmdowDwcj59F28BhNQh53arORTRLmHUgyp8KItP3kEBlLxeTg0geTn0K2QeGaA6XD12O25bChkHxXDfe7u0pFc3v0PK9rTy6j5DZK3iz8L/pRjyOurFCIC/I1xnrx3fMxEzP0ozdPDKZQouwXt+/UL+uyTnWmpVQv0IJfgfs3pTc8Ts6/TjGktTi6HXKYTpVRvSLDGzF+Ykde6pl+u8tjWzuObhd8V6C7naTxlrmmdOzutrzgvCHRIE9h564IewbaOfbn8/kPRrMvHoMS1s95Jw+7EKzPVcCI6EizKGh7Tr1wScEJe0c4q7EmUD0VWIXTtQzdorud+RLk7BRAedcakNq0tpj0X4YDqKCy4kYf0QXkBtpGdzg2/YqKiV+6ZNI0SbR2ogkPuZnXlSJaFymARMTfHZ29lIDlVspshqZOsDHdNVnVY8kccIDkwTF2KaegaG/taGSZ2BlKVPa6mRymuJvf5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199015)(66476007)(66556008)(66946007)(8676002)(4326008)(8936002)(2906002)(6862004)(54906003)(86362001)(41300700001)(316002)(5660300002)(6636002)(44832011)(82960400001)(186003)(38100700002)(83380400001)(478600001)(6486002)(6666004)(6506007)(53546011)(26005)(9686003)(6512007)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7x8xbO/9IgviBUfL7OZiR4vBOY9P7DHIQ0R9BtYBbSgjmvPc004EM7v159ko?=
 =?us-ascii?Q?f8GGI5/s0b2ibEiUe+KIMAX8jKIoQvSUE77tVZLGAMHvx4sXs7s7/Q823GtF?=
 =?us-ascii?Q?EINFrvx91LnUsUOBkEmFHpvdwi3iWfYyJfbf4RudyTU1rkcF5ROTlQbMpNQi?=
 =?us-ascii?Q?8PHdMuCnc6hdgqbEOlKaNvygqAu8A0bRpi2WVhDdW62DHiKsQ7B4kbrYQ5Bh?=
 =?us-ascii?Q?JAm2PtCc0CqZc3Ev1iHf1ig0/IAm3osK+7uLyjG/eIBG7uKULla4AVudLwG5?=
 =?us-ascii?Q?1UrpapuMAweJyutZORcAnQ8Ucp+jPzn32A0/clY2/szVkMhp5ZfV/b9/pnAw?=
 =?us-ascii?Q?20b4V0zjA9/Xi9uc5jZDQWvWDDwPLJZAUJ0S9O0wkyjUEeq4aRxC1lE5yq71?=
 =?us-ascii?Q?TJRMmIrOFrJOEn7+OK8J6wRb0GiW/pT5fF5GDaoJoU2IztHss0DnqKzt9wma?=
 =?us-ascii?Q?AiCyM/t9OCm3gJegjKS205pmhjbv1Kam7rG+S+YmJN2EqFskVCj2YPfARlb+?=
 =?us-ascii?Q?xh1qasXk4caoM/N2nSja/qFhJUNPkXokEB/BBA0iS8VtSp4OC3vn37bUrV1I?=
 =?us-ascii?Q?LLM3m0JpOXiHxm7mBgiWkFejh4PbtKfrmqp9n0DrHozbMkcZV5D6b8ozzvyT?=
 =?us-ascii?Q?d0Q4MMHwOevfOE8ot7gJ1+hMNz5Qufb99v2TtdTkmBX/KRFC5uPMeqJOeMXB?=
 =?us-ascii?Q?3I5lBVuzyMIfn1JtdZ+6HahZA2+1gFwMkvYG+JguNHsZWHvpmvyiE0aRnFlq?=
 =?us-ascii?Q?yxsuFsxeuUKxJLo96h+TWcamXcqiiHmeivNt08VNOzgMytpyXqLh/RvwrkSi?=
 =?us-ascii?Q?cgz5NsoOdsGudKwGIuR6qVFujI0xv52hgOQV4UVxhRbF1hwyMvLOLEOTklxt?=
 =?us-ascii?Q?lFXX5PYNA4IV4H1mYUqOSYJhIBetienMzrn5vl2cLVJMUI+zOMMv6yu/7HQZ?=
 =?us-ascii?Q?n2PJSt5PVcinBG9TY9QrfSw5gbgn0zhI0dj3kCetRqT0fknipg7sb+YozP05?=
 =?us-ascii?Q?kTuWOvUk4RWphAirXqnEwQCsWAPnUsySK6JePt+tq79+iHxh7qBxs1+P+Fi0?=
 =?us-ascii?Q?J7I4h3t8fF/bVSra4cYA5Kcn6FsxBFBPVQ5laMPJHXyzugAQ2YAdVPxn8Ue/?=
 =?us-ascii?Q?QonhV9/j1dWwUppBDt9pElbpgQcNv5JYdpiIoavtVVc0kteF8Rxmhl6ID08n?=
 =?us-ascii?Q?Tup+XPp9oJb6XcA/ib34xLP3Xa7rYTau2/h31hN4agbl5KYh+sj7dQAacB1b?=
 =?us-ascii?Q?idO9eAnHHsDq7mZQXu3dZXI646+e52NTM6oNbeK9UrrEH2OAANPM8jlwduUu?=
 =?us-ascii?Q?Iw1xznuFaOaVWoG9bjrP76p/TZtqA3/Me0o9NnLA20Br2Q04OR+MX/mdQJXt?=
 =?us-ascii?Q?W7Qrt79HDYK5Eytpumj7rv3dcdA8yZF2NJ6NJ87oPocKiFBV8EU3V8vFawOb?=
 =?us-ascii?Q?g3buDkO3r4RWYyv5niBlwB0evxK98//FmVo1sXBuXMMeKAvWDmypRA53exMF?=
 =?us-ascii?Q?uYZIhPJ+pPiwH312MqWcDc4sQS5LMIjkJUg9kjcz+BXPxCfkjvvaMKARC34X?=
 =?us-ascii?Q?TZ2XvbV6c8lNEH7xUdbd8tXxo9u0XKEbcCF50Ahv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0544ba80-0ac6-4511-c92a-08dab65b7559
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 07:35:15.5006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9o3QjSSDz1iijgZ0+isImqf492D+kpZ/kE2ZfCdaILsjivXQuK7hxGzsi4A+DO8Jq1zzyojf2cz0/O9TX09a0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6257
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 08:42:30AM -0700, Dave Hansen wrote:
> On 10/22/22 09:12, Zhang Rui wrote:
> >>> I'm not sure if we have a perfect solution here.
> >> Are the implementations fixable?
> > currently, I don't have any idea.
> > 
> >>   Or, at least tolerable?
> 
> That would be great to figure out before we start throwing more patches
> around.

Yes, agreed!

> >> For instance, I can live with the implementation being a bit goofy
> >> when
> >> kernel commandlines are in play.  We can pr_info() about those cases.
> > My understanding is that the cpus in the last package may still have
> > small cpu id value. This means that the 'logical_packages' is hard to
> > break unless we boot with very small CPU count and happened to disable
> > all cpus in one/more packages. Feng is experiencing with this and may
> > have some update later.
> > 
> > If this is the case, is this a valid case that we need to take care of?
> 
> Well, let's talk through it a bit.
> 
> What is the triggering event and what's the fallout?

In worst case (2 sockets), if the maxcpus falls to '<= total_cpus/2',
the 'logical_packages' will be less than the real number.

> Is the user on a truly TSC stable system or not?
> 
> What kind of maxcpus= argument do they need to specify?  Is it something
> that's likely to get used in production or is it most likely just for
> debugging?

IIUC, for the server side, it's most likely for debug use. And for
clients, socket number is not an issue.

> What is the maxcpus= fallout?  Does it over estimate or under estimate
> the number of logical packages?
 
Only under estimate.

> How many cases outside of maxcpus= do we know of that lead to an
> imprecise "logical packages" calculation?
 
Thanks to you, Peter and Rui's info, we have listed a bunch of
user cases than 'maxcpus', and they won't lead to imprecise
'logical_packages'. And I'm not sure if there is other case which
hasn't poped up.

> Does this lead to the TSC being mistakenly marked stable when it is not,
> or *not* being marked stable when it is?

Only the former case 'mistakenly marked stable' is possible, say we
use 'maxcpus=8' on a 192 core 8 sockets machine.

> Let's get all of that info in one place and make sure we are all agreed
> on the *problem* before we got to the solution space.

OK.

Thanks,
Feng



