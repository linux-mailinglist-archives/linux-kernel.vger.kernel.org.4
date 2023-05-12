Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED96700129
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbjELHMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbjELHMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:12:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD9611D80;
        Fri, 12 May 2023 00:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683875385; x=1715411385;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d5BCSLHt299WOV+CmKuYPDfmRRinxSe1qn1biQMRj6s=;
  b=GHIIK9WHcdEX/WxrTgdtkwgtPKHgRAI5Ksu0vQz1xEnYSDE7ZmBCeeK8
   +UjaXh0f7Whf849cpavrxpZQqvOk7Jlc+jfm5hJmjHIrw8a9ObC95gJmB
   ONnvt3tOARlhcp7jTATuZ0QMhzkedxxksp7b/uklbEWrumV5sEKhLsa1J
   RpaVqH0YsShXP004zxHJfi6+8ZKgK0Lnt/OUoySdax3bwF4Pm7JNyzUUV
   /Ah4bcMTr4P3CLLItChFWYnri0Wln38+r9KR9BkSCa7cznGNsV7LrFUkl
   hfvw1C1+v4bxU0cLQD6KmLN4hpAYexN14UsJYBJCap0xsW+mxpXuw/jCk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="340034066"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="340034066"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 00:09:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="694114180"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="694114180"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2023 00:09:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 00:09:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 00:09:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 12 May 2023 00:09:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 12 May 2023 00:09:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8FZom864zoO1kReHzyQ14KEfyVpMEv7ilwVlODzKbixC0ByHbwfZaP3i8EO+0AAytSvjUJaOHnMytwvUl5KbHw1YeEMyoTa1515aFWeYT+IVcB2C4pqdByqZ4P7M1Yw0T0d1ne50we2cbT25Xp9Cww/XCkiU52+NUw+ZjpNPMxESwpVGsjj6ttt5RL0hfRygTnse/XJmIRjOZ8lF+axcNjPu6OPPYTa1TAu6KsWl0AhW41nEK1pXJnurT4jpduhGHzvQbGsOW0g+GIR3rCtfJTMl0S+ZovcEv3eP0pafa0+9nalLhxyfPR9MF+ym0E6P12AZZl9IWR973mcxEHGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMC7+x2YOT2dUB+VBo0ZsLLJv41Lz0OzzxeTFtcptAI=;
 b=ER+9bykN22ZahT0nIKYDTgCJ4/HS39xQSGRqkTofebh+3+GHSRal9oE6/KYAGoLWXSrXI/jNDc1aYFZZAi/urJOc2FUbEJmfQyiQagAJgDO7b9d2Q/sK8qVFDDl6Vd0pA7OwyGPT4DgE4Hz13d4WzAOp0tiQyFD2erR1sgnvi4JkPVIZOQ8U440j0F+WjvubfgZBUMle/pwD3m/VaSbnkQOPUtoJxNEWJflebSaSuZUfQC8jjii2payJrWi+dUx7SfZnmjbv0RmIVFRg+aBonPU7OutbxpH0nzlobzaD9j9Jo2KdcpdqiGUKtqUp3uBRJ3ce/qO3S2A3NxdIaKJ+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SJ0PR11MB7701.namprd11.prod.outlook.com (2603:10b6:a03:4e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.30; Fri, 12 May
 2023 07:09:36 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d7e6:2d0c:3393:229a]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d7e6:2d0c:3393:229a%7]) with mapi id 15.20.6363.033; Fri, 12 May 2023
 07:09:36 +0000
Date:   Fri, 12 May 2023 15:09:26 +0800
From:   Philip Li <philip.li@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [kbuild test robot] random-order parallel building
Message-ID: <ZF3mJlMuH2HbNxWp@rli9-mobl>
References: <CAK7LNATrFbr7kT9HEFgYO6ZstaSx1FB+Q4SQrAX+D8VwG5K0dQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK7LNATrFbr7kT9HEFgYO6ZstaSx1FB+Q4SQrAX+D8VwG5K0dQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SJ0PR11MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df30297-8bf5-4a27-765c-08db52b7d766
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqIRWaOAvRXeA8V/mbQwGLd93LhgyCV3iVT+aHM0ezMIBgqTxE4ADm4Hk+UcR8MOduLEmCXy8YLUp0Wjr2MJwbxOpv8aX8wIsL7DtqdAxBEzc5KFpr5lOZEloKvmHULCOl0UvNS0vu1ggrMxS9yrHZ3pEpIUOQ43HnVkimGomFFtarWLTuD1RiJ+EwgctP7x42HwNzYQ1u9xAcF6bFX26Uc5dqA7VxH/ITtP6PFSmaNouoD8X0Vvl0ifbjGhS3RRYHUZAe8QuQafoySitgBQHh50Scqg6kji0SEmN3Vbsvn8SzbDhQiTQjrV5xwKi2MjStr5XRIE0yOkV6lXtsbprIe6EojCrv2qGgJgWHw3YRgU9AL1uMJV/SwRmkhSuF7X+JUENSoy1wGgMVi6q1yKDQA8CO1k4u0Niz2aPZspkwM4vfJT9+zkCj6/LfRbZcmBYPKB/ISONqSZCUyAbHnuVkVVS+8NeyCX+auyNjO+wzRCHgNiTq5VZho8iham6Pp3sktikG4L+gAXcqJ1WscuXCO538i5hFY70Us9B7jgJog=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(83380400001)(6506007)(5660300002)(82960400001)(66556008)(54906003)(41300700001)(478600001)(6916009)(66946007)(66476007)(38100700002)(2906002)(8936002)(4326008)(44832011)(86362001)(8676002)(316002)(6666004)(6486002)(966005)(33716001)(26005)(186003)(6512007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M+qZddtSCHxDTg03bz/zdUImsc6MIibk1II+Z/T+dJJIRMdj3Ra+tseh4gS5?=
 =?us-ascii?Q?ir7Ulthz2Qt0SpGLPCdfgi2sQwrthWyKtz1JegDvYC68TRqwNQhPIt6rJnih?=
 =?us-ascii?Q?AIkehbko23LZIOpoVtoUkkf4REuBE1q7QPsPh+Ix7MOLLmUv5y3GCbOnl2rc?=
 =?us-ascii?Q?59R1VkYr8KJNdXK1Ul4uPD8OqDOjuHxifdxJgW1gpZBHhFD6ea4iiriOs58d?=
 =?us-ascii?Q?3ufR4bjzmDmZeMo0aSux4qCu4cObGqUlmRUOrWXfg+euhqmmdb5Xce4aNqg/?=
 =?us-ascii?Q?qijw0i9SVb+uL1gGNjwh7petwm0IluHks9690ptDReJ1quYp4wx3oE+I6lHH?=
 =?us-ascii?Q?dSp1TQlnsMdqvKMKXhGWR4z/qTi25K7dSHVIaoB4gB6QsujpWtX9MoA5L0ba?=
 =?us-ascii?Q?EZrbi48b3pbg+ZVd3hYWXFJ9E9wm9dO1aLYTw8rfBoPBm9zACIgU7ZIxxpnM?=
 =?us-ascii?Q?3xNVOe7/KSSQ1wgtwN2uJGhCQEI2owVHLD99VJBHAdXu+kypIgB9rCHFC1ii?=
 =?us-ascii?Q?G9ftf1FLlmsaC4UMufP9OgNSEz8EMHywAhYBqTEBIaQcZkgSRYg2KzFcMJuC?=
 =?us-ascii?Q?3Ly61aSzbH6V5e7yDgY4MLM4+yopPTrZfTnMV2Xtc/zpBfZW4d/Z6KEbrki3?=
 =?us-ascii?Q?27KGBW88XpwcO0oF34sjTrfaHq0Egjak+jNu0kOQIiaXE+IckGll4ghpicac?=
 =?us-ascii?Q?hgUzQyTzwAYDX1ddKHE42K62Thsi5MxHZBfThrCeHWpIr2iKl7paQpe0rrjC?=
 =?us-ascii?Q?AxKHAcYw6gNuRdDDWqQfDYQos04tevMkkq/4V+oET6VJanF7gRTRQZ7Hiwrt?=
 =?us-ascii?Q?w2ajZWkzI9W2No6wnB4Ykm3gynb3i+6GMKyc/EGGB2eRKy/yZf5tzyUDwiwH?=
 =?us-ascii?Q?6uULX08JlbEJvAV3ehWss7y3Z8c4FHFVAQRPA0mU9fVRJRD5BxN4eLdXICpP?=
 =?us-ascii?Q?HIn33v6/BReClRgDueIQlx/acriDoYk6ja3E4fpQF5whxuqByt07Xh3UNNAW?=
 =?us-ascii?Q?wjJ/+C92+SLawIT7S1wrlsUnzawAFV9KGrOm6Y6cLa2jSXV9tkbqB/2mFggq?=
 =?us-ascii?Q?1R0F3S705AnhzJp4Cof20gZNL80Om1aqNFAMXUYupfU1xHisPd5sPGkCZNpD?=
 =?us-ascii?Q?YF/eaiMw0pNXRnfVATmEshGWfZb+4kQNvUqTUErx32nZamIGnG0mY0w7KJzh?=
 =?us-ascii?Q?NEWZeQY4zORty2RLg7SQYOrnIKMtpKK0x3aDKllVg595p6txIaoAe8KedD27?=
 =?us-ascii?Q?SAiqTmsSyJmoyyNOxY82NGvW2LtULCir8GHdUUYilvGTRdHVjEXzl81aQoQq?=
 =?us-ascii?Q?hlUhApijtPaZmZ4gKXkh0XYG/OqNpi/7mOetTlMMrqvRXo1wO25MPl7Uugmc?=
 =?us-ascii?Q?LmP91WI0b+9Hg8Kcf0b7JQSvGSNMAug31kBH+96EiRnlcAnzTTc1nvOJN6d0?=
 =?us-ascii?Q?Yz3UjhhB9YWY9euutOKoSQgda7IRn1fmfJ+FwdScHmwoqLakUBct4FsUqiDy?=
 =?us-ascii?Q?rIHufoBT3w79VlnyEqPw6oqkLJTxvwwdfBKgryOyuD+e/csuKYyZj5BMH/FY?=
 =?us-ascii?Q?tlI9ZEucHdD0vjfXLM2SZVDxFewuWb/L0ih37c0I?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df30297-8bf5-4a27-765c-08db52b7d766
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 07:09:35.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxihi6PmcpH2+TW3jlu/UNgY4LbdealS7C4CYz6WVh9sQLfeoF3hjHya09rWOQPBDqSCv/H04x4d3rXI+fLGWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7701
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 12:25:13PM +0900, Masahiro Yamada wrote:
> Hello, maintainers of the kbuild test robot.
> 
> I have a proposal for the 0day tests.

Thanks a lot for the proposal for the shuffle make, we will do some
investigation to try this random order parallel build. The gnu make
we currently use is 4.3, we will try the 4.4 to see any problem.

For the timeline, we may provide update later this month.

> 
> 
> GNU Make traditionally processes the dependency from left to right.
> 
> For example, if you have dependency like this:
> 
>      all: foo bar baz
> 
> GNU Make builds foo, bar, baz, in this order.
> 
> 
> Some projects that are not capable of parallel builds
> rely on that behavior implicitly.
> 
> Kbuild, however, is intended to work well in parallel.
> (As the maintainer, I really care about it.)
> 
> 
> From time to time, people add "just worked for me" code,
> but apparently that lacks proper dependency.
> Sometimes it requires an expensive CPU to reproduce
> parallel build issues.
> 
> 
> For example, see this report,
>   https://lkml.org/lkml/2016/11/30/587
> 
> The report says 'make -j112' reproduces the broken parallel build.
> Most people do not have such a build machine that comes with 112 cores.
> It is difficult to reproduce it (or even notice it).
> 
> (Some time later, it was root-caused by 07a422bb213a)
> 
> 
> 
> GNU Make 4.4 got this option.
> 
>   --shuffle[={SEED|random|reverse|none}]
>        Perform shuffle of prerequisites and goals.
> 
> 
> 
> 'make --shuffle=reverse' will build in reverse order.
> In the example above, baz, bar, foo.
> 
> 'make --shuffle' will randomize the build order.
> 
> 
> If there exists a missing dependency among foo, bar, baz,
> it will fail to build.
> 
> 
> 
> We already perform the randconfig daily basis.
> So, random-order parallel building is a similar idea.
> 
> Perhaps, it makes sense to add the "--shuffle=SEED" option
> but it requires GNU Make 4.4.  (or GNU Make 4.4.1)
> Is this too new?

Our production environment is 4.3 right now. It will take extra
time for us to upgrade the environment but it's doable for us.

> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
