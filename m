Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20973693FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjBMI3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjBMI3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:29:07 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15B012F09;
        Mon, 13 Feb 2023 00:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676276927; x=1707812927;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pkjvldausJUY5T/bu3TDuXvIlsx95gXlIte7MRkANGs=;
  b=C2MLFj0QNM0zKw7zPiha2XB8VUgBsNvA7Jmc5NanII5fUU6/HYtMx4QZ
   Tj6Y20X0ixlQaZeTrqsYwuyphS8nWd2xG/1EPkRKRS9yY+Ob0Dz21gFvW
   EofQotfSqzkoonDc3DJdBMkCiyUGKuhcVhII0OlN2GqUMVIrSmOfYb2lZ
   2+S2OH1ZMNH2Vwnqd9qkAz6LOVKDux55J1l+5Mu/UWm2GWg/x3GMMJM6T
   QJabRY7DMGt/9DnjENJovDxAyfjW2G0J8g+D5Om4zRBa7drEl0qEhrAVb
   /OtrcoCBf0B151aFoL19OPc3vw5qDyZGbjq1Em+WU103VXUFGZ4RBO8LM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="328547062"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="328547062"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 00:28:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="618574283"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="618574283"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2023 00:28:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 00:28:46 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 00:28:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 00:28:45 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 00:28:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koe2OaBoYl9nsNxYHm8217NwWAy05f8NPkogWwQYWJsktCn1mSZq3MWfnLbiFsj27THhrVIam+WrUoijB+oSP9Qfo3nkcGkkoOxWLTm0Xo6UFP7RoRZO4a0dI0ODE3EzJhyXj2AOXk2qkPrOLBHih5bSCxqF4AyIwN8wgThBPK5nwePLW1gb78FXbrthQu1fH0te8JRTlREJ2DgIquXTp0jwOn7StQ0OYUoZJd7KxZmC6FEmZOhCo0iNjB1QGghAGeIz23jxLYv7EDFoVbVtyiwI+KiWrOUU3O240u9k1gj/4ONg7CFAEsjrkBGB7kCnYIyn3/R2SP0bc7HX6cqaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KeFrsMKBuEo8mjClKXcSplHsvQHIH6IVqkyqQaPayI=;
 b=ERuOGIM59a0GXXwYgY1H4oRWyc4lUZrMvi7opkVwu6ZVlKYDrtrZpYtnlQT9p8sRikgwZ7ksh60PujPo2Ij3xWSdcW6LIHz1zeNoRIqHO/iFd+A5yuOpdGu258DzsuKYWiF3szM8b58sKfzeR74YvBzN5ATGMC9wzEoI4MSJWhnjCSGeOJcECM5XxLwJePK55X3+pUf/6uTCby3AYHhr/qJkXdMSqrsMj0xc0y9sllf9sngS2Zzv7A77mBUABCejdOhGPPSqvpeKge+BOGpgZhArU+L3uJsGPqTvuuyyt/IYAH8I9+b8wtlfz1Z0T7IXZxw0GkfbjAF46nH9R/BvGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SN7PR11MB7994.namprd11.prod.outlook.com (2603:10b6:806:2e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Mon, 13 Feb
 2023 08:28:43 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%8]) with mapi id 15.20.6086.017; Mon, 13 Feb 2023
 08:28:42 +0000
Date:   Mon, 13 Feb 2023 16:24:01 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Leo Yan <leo.yan@linaro.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Joe Mario <jmario@redhat.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andi Kleen" <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Xing Zhengjun" <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH] perf c2c: Add report option to show false sharing in
 adjacent cachelines
Message-ID: <Y+nzoaJcnMFokDMX@feng-clx>
References: <20230213031733.236485-1-feng.tang@intel.com>
 <Y+nyakPnVDpVjn24@leoy-yangtze.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+nyakPnVDpVjn24@leoy-yangtze.lan>
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SN7PR11MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: db104136-3346-4ca6-f118-08db0d9c5097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khfDw03QGFzxr+8c0GJvQVH+u7JPJdW0HXiH0VVsFC0WD3yK6X7sXQKvh5ySJiTx9AfFEeJks8adoB5/Q87pQxnnAp90Xo0c1RC218qirdZELe3vCRFO3+fyaSRRJbrMJ1IIFE/bhDwZ6KLHY2u2dxCQ+W+Z5X9ZBAwrefrRPrrTHJS3R/2WTR3r5bN3IQhVHKhPDQ05ofGkjXRS6HJ6EAmV2oAup4u8H0dbSgevFi01dCMV2fQxKBmmAabqX7qedQ73ud4gdnzGq6oZ1AXD48h97vA/7PkuR9NAJQAGsZgres8moeWKuwbn7/J0+CJCMHOWN8AppzpqaUhP7oRs+n9vHHRYt8JHm+f6X47r7T3bR90r3CUZOtJv0iXk7AaOFCnR8z4VLGh7GwA/nMP0umF3QGN4qS0yXUWGbjPwWQVo6DL88Qg/d/iyXXoqhakXJeKO7rq7pN0ls2E7J3Z5GDN/DJmRUKMn2HEmCPO9hbBlNvcxPfOlsxjmrNGmtHRtsLD+ipcyMjKDz/4cghkZO/IlRVxkZNusZzmkwOqubeqshmfNQk/KHdm3m/ye5dVbntw68Yx8yG6IFKDq8zc/A9TAsOb8OSvorDMfC4r2fMzyUy/mtZ49ClCZuZ1gQqq0qMh6f3tR2mpuNB2qb2JhMRO/VKKm7oGE5ZuwjZj/cZevUaUodirVPAccRx0Qhdd7m7J482lfFBj7T1jdSgO61crrwVA/kgjdyY4eUxqUTWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199018)(83380400001)(966005)(6486002)(6506007)(2906002)(26005)(9686003)(186003)(6666004)(66574015)(478600001)(6512007)(41300700001)(316002)(8676002)(82960400001)(66946007)(66476007)(66556008)(4326008)(86362001)(6916009)(44832011)(8936002)(38100700002)(54906003)(33716001)(30864003)(7416002)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0XindfhvPdAvpPtX+/Zc4xH8aMUa0HHlxbHekttILL0BNcVOMK42eCqHkWN1?=
 =?us-ascii?Q?B+m2u9bkbaAhztUz4Adnv8Bq2wS4A6ss21nc6ty5uz3906jgRBiSbnKAODBH?=
 =?us-ascii?Q?V0sJGunE0OaWIYxeexptwiVhLsNtVQch1P7qNl2s281ANJSvTI/5y79yfkq+?=
 =?us-ascii?Q?cpgl6sTu+niCm14aQKOyezQ19bmFzLD3FZglfcoJittE3+zskHdNlKaXWc4F?=
 =?us-ascii?Q?K/uW2oKTxrD42FvEdfgt1U0D1IYlT7EeDgYnP6CnadT4yKbb3dXyWj+wCcVa?=
 =?us-ascii?Q?u3k/1EFd4O9nTdPJsk2qQHbdZBdQWxmdn0HYZR6FT/W4YM2qOuWx0NtIgpzw?=
 =?us-ascii?Q?cNdwjxX3gjxue/EEdKlGNRl/mmW61TSdzxZ0G25pW4hjI0qj0Vl5X4dn+eTy?=
 =?us-ascii?Q?wUKdT56fkCZpcNIaFCP5hgCo7Ye9Fcy9ioTB/PB4NnWGTV/yviFshvd0jKm6?=
 =?us-ascii?Q?ThjvBiQqS4d0mFnqoH4jhx7Fyf5UubG93fNCAK4pe2NOEOMptsYQRJ+mpvTU?=
 =?us-ascii?Q?CVqTkk1dg5S6dEX3y4amKnOXXSs1hxmo8UBJ+15AwFu90oLTdxZIP6LHrVgL?=
 =?us-ascii?Q?bpwduMonSi+7ydduMi/OXD8ERw6+PLiExPIrbtIR5iWcBu59rh/IRZrhD0a6?=
 =?us-ascii?Q?8O5G7ANzpoXEEG126iq+Ml446zwTomhLtZcm3FgOksu7WGraksCkV4wiInKF?=
 =?us-ascii?Q?NyGnE0fB3E68DLZ7gistrCOC6p+lQdrl9TZk+YlUpKoxxQKd6d/yyX143BYk?=
 =?us-ascii?Q?rf+wo0EeWNLN71S7s1T++mY1OAA2jBVQCT0ErI6QDOoRtX3homAeUcb7YTZ5?=
 =?us-ascii?Q?+05sio6KhRi0N68fodwVi0SPAGgqXn7nUISdk7sCHFl7IcfxI3bLYkKMtIMs?=
 =?us-ascii?Q?eFU3FM7pPBqthpBTYx+gMYplAiVThrMfmXi4OmsNXGuH4FSP1xO/9gjvrEgi?=
 =?us-ascii?Q?kXp1kIWLH0Vr4qinC7aShsbOw2sOOjItUe16+uDvgt5EVgITpuFpntVxW6A8?=
 =?us-ascii?Q?f+TXZ3PrKJXAf4yhd2RAvp3tMz2jzkhHwn1zJcUXIeoHpXge7DrqGKOBHx6G?=
 =?us-ascii?Q?FdmY3wHmQ/2yu11wmIce2O3bBN9BpXxtSXUK9r4h8PgiGJoyYQYH1rhrC7/6?=
 =?us-ascii?Q?+mI3udk9DSzzRFix24I3ImzOPLWPuSQRMAxlisqkOadVrCTuubngKFt6xady?=
 =?us-ascii?Q?e9PC/PrM3l/T+5QfC8vFf7U/n6WI5VBBt1aSURMtt8vZYQM8DFdj/Gd6fvFx?=
 =?us-ascii?Q?dtwgvywE0EcFhMlviiYGS8r4fX0fp8zkXWKJ561D1BT8e7+E0hMUR8TgOT1b?=
 =?us-ascii?Q?4tLHE1urpeQBX0G5Km5gtRwm5CkPoseEuwHPmqHCQ4tRmMG3+HDv9MHACBB9?=
 =?us-ascii?Q?r4nLFTfTNwnAIi+kHnl/506Wd6OvoqF4E7FkMHeHPwAnVk844sraFETy5jyF?=
 =?us-ascii?Q?o+6ZI99uU+ljZIDsJP5y7XeS1lZ3wu4JylwI15TcCJFQso4Ts/jD166s33B6?=
 =?us-ascii?Q?+sitH6u+LIkx1Gd3GiDfi6t5Yk+i1JqeV8EABIiQ+qE9veoYFDjgD80euF6r?=
 =?us-ascii?Q?f8GJA3q6eYRzj3CdTSUgoDtY63f9pHsM5RKqtAC+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db104136-3346-4ca6-f118-08db0d9c5097
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 08:28:42.2657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mC+/nbKTS+w+0hgVM5H97Tjl2be0mhoUW9aef0hbXYQOCuNaiWgxZ7udrI84Km/fqyvIoj8B0vfLFLpGidrOCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7994
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Mon, Feb 13, 2023 at 04:18:50PM +0800, Leo Yan wrote:
> On Mon, Feb 13, 2023 at 11:17:33AM +0800, Feng Tang wrote:
> > Many platforms have feature of adjacent cachelines prefetch, when it
> > is enabled, for data in RAM of 2 cachelines (2N and 2N+1) granularity,
> > if one is fetched to cache, the other one could likely be fetched too,
> > which sort of extends the cacheline size to double, thus the false
> > sharing could happens in adjacent cachelines.
> > 
> > 0Day has captured performance changed related with this [1], and some
> > commercial software explicitly makes its hot global variables 128 bytes
> > aligned (2 cache lines) to avoid this kind of extended false sharing.
> > 
> > So add an option "-a" or "--double-cl" for c2c report to show false
> > sharing in double cache line granularity, which acts just like the
> > cacheline size is doubled. There is no change to c2c record. The
> > hardware HITM events are still per cacheline. The option just changes
> > the granularity of how events are grouped and displayed.
> > 
> > In the c2c report below (will-it-scale's pagefault2 case on old kernel):
> > 
> >   ----------------------------------------------------------------------
> >      26       31        2        0        0        0  0xffff888103ec6000
> >   ----------------------------------------------------------------------
> >    35.48%   50.00%    0.00%    0.00%    0.00%   0x10     0       1  0xffffffff8133148b      1153        66       971     3748        74  [k] get_mem_cgroup_from_mm
> >     6.45%    0.00%    0.00%    0.00%    0.00%   0x10     0       1  0xffffffff813396e4       570         0      1531      879        75  [k] mem_cgroup_charge
> >    25.81%   50.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff81331472       949        70       593     3359        74  [k] get_mem_cgroup_from_mm
> >    19.35%    0.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff81339686      1352         0      1073     1022        74  [k] mem_cgroup_charge
> >     9.68%    0.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff813396d6      1401         0       863      768        74  [k] mem_cgroup_charge
> >     3.23%    0.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff81333106       618         0       804       11         9  [k] uncharge_batch
> > 
> > The offset 0x10 and 0x54 used to displayed in 2 groups, and now they
> > are listed together to give users a hint.
> > 
> > [1]. https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > ---
> >  tools/perf/Documentation/perf-c2c.txt |  6 ++++++
> >  tools/perf/builtin-c2c.c              | 22 +++++++++++++---------
> >  tools/perf/util/cacheline.h           | 25 ++++++++++++++++++++-----
> >  tools/perf/util/sort.c                | 13 ++++++++++---
> >  tools/perf/util/sort.h                |  1 +
> >  5 files changed, 50 insertions(+), 17 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
> > index 5c5eb2def83e..a8e1e40d270e 100644
> > --- a/tools/perf/Documentation/perf-c2c.txt
> > +++ b/tools/perf/Documentation/perf-c2c.txt
> > @@ -126,6 +126,12 @@ REPORT OPTIONS
> >  	The known limitations include exception handing such as
> >  	setjmp/longjmp will have calls/returns not match.
> >  
> > +-a::
> > +--double-cl::
> > +	Group HITM events in double cacheline granularity. Some architecture
> > +	has Adjacent Cacheline Prefetch feature, which behaves like the
> > +	cachline size is doubled.
> 
> Sorry I gave my review tags too quick...
> 
> Just found several typos, please fix it.

Thanks for the catch, will fix them.

> s/Some architecture has/Some architectures have
> 
> This is just literal fixing, except x86, I don't know if any other
> architecture has Adjacent Cacheline Prefetch feature :)
> 
> s/cachline/cacheline
> 
> > +
> >  C2C RECORD
> >  ----------
> >  The perf c2c record command setup options related to HITM cacheline analysis
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index 52d94c7dd836..7d495db7e5a2 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -524,7 +524,7 @@ static int dcacheline_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> >  	char buf[20];
> >  
> >  	if (he->mem_info)
> > -		addr = cl_address(he->mem_info->daddr.addr);
> > +		addr = cl_address(he->mem_info->daddr.addr, chk_double_cl);
> >  
> >  	return scnprintf(hpp->buf, hpp->size, "%*s", width, HEX_STR(buf, addr));
> >  }
> > @@ -562,7 +562,7 @@ static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
> >  	char buf[20];
> >  
> >  	if (he->mem_info)
> > -		addr = cl_offset(he->mem_info->daddr.al_addr);
> > +		addr = cl_offset(he->mem_info->daddr.al_addr, chk_double_cl);
> >  
> >  	return scnprintf(hpp->buf, hpp->size, "%*s", width, HEX_STR(buf, addr));
> >  }
> > @@ -574,9 +574,10 @@ offset_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
> >  	uint64_t l = 0, r = 0;
> >  
> >  	if (left->mem_info)
> > -		l = cl_offset(left->mem_info->daddr.addr);
> > +		l = cl_offset(left->mem_info->daddr.addr, chk_double_cl);
> > +
> >  	if (right->mem_info)
> > -		r = cl_offset(right->mem_info->daddr.addr);
> > +		r = cl_offset(right->mem_info->daddr.addr, chk_double_cl);
> >  
> >  	return (int64_t)(r - l);
> >  }
> > @@ -2590,7 +2591,7 @@ perf_c2c_cacheline_browser__title(struct hist_browser *browser,
> >  	he = cl_browser->he;
> >  
> >  	if (he->mem_info)
> > -		addr = cl_address(he->mem_info->daddr.addr);
> > +		addr = cl_address(he->mem_info->daddr.addr, chk_double_cl);
> >  
> >  	scnprintf(bf, size, "Cacheline 0x%lx", addr);
> >  	return 0;
> > @@ -2788,15 +2789,16 @@ static int ui_quirks(void)
> >  	if (!c2c.use_stdio) {
> >  		dim_offset.width  = 5;
> >  		dim_offset.header = header_offset_tui;
> > -		nodestr = "CL";
> > +		nodestr = chk_double_cl ? "Double-CL" : "CL";
> >  	}
> >  
> >  	dim_percent_costly_snoop.header = percent_costly_snoop_header[c2c.display];
> >  
> >  	/* Fix the zero line for dcacheline column. */
> > -	buf = fill_line("Cacheline", dim_dcacheline.width +
> > -				     dim_dcacheline_node.width +
> > -				     dim_dcacheline_count.width + 4);
> > +	buf = fill_line(chk_double_cl ? "Double-Cacheline" : "Cacheline",
> > +				dim_dcacheline.width +
> > +				dim_dcacheline_node.width +
> > +				dim_dcacheline_count.width + 4);
> >  	if (!buf)
> >  		return -ENOMEM;
> >  
> > @@ -3037,6 +3039,8 @@ static int perf_c2c__report(int argc, const char **argv)
> >  	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
> >  	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
> >  		    "Enable LBR callgraph stitching approach"),
> > +	OPT_BOOLEAN('a', "double-cl", &chk_double_cl,
> > +		    "Check adjacent cachline false sharing"),
> 
> I personally think the word "Detect" is better than "Check".

Ok will use this. The possiblity of finding a false sharing of
adjacent cachelines is indeed much less.

> s/cachline/cacheline

Will fix.

> >  	OPT_PARENT(c2c_options),
> >  	OPT_END()
> >  	};
> > diff --git a/tools/perf/util/cacheline.h b/tools/perf/util/cacheline.h
> > index dec8c0fb1f4a..630d16731b4f 100644
> > --- a/tools/perf/util/cacheline.h
> > +++ b/tools/perf/util/cacheline.h
> > @@ -6,16 +6,31 @@
> >  
> >  int __pure cacheline_size(void);
> >  
> > -static inline u64 cl_address(u64 address)
> > +
> > +/*
> > + * Some architecture has 'Adjacent Cacheline Prefetch' feature,
> 
> s/Some architecture has/Some architectures have

Will change.

> > + * which performs like the cacheline size being doubled.
> > + */
> > +static inline u64 cl_address(u64 address, bool double_cl)
> >  {
> > +	u64 size = cacheline_size();
> > +
> > +	if (double_cl)
> > +		size *= 2;
> > +
> >  	/* return the cacheline of the address */
> > -	return (address & ~(cacheline_size() - 1));
> > +	return (address & ~(size - 1));
> >  }
> >  
> > -static inline u64 cl_offset(u64 address)
> > +static inline u64 cl_offset(u64 address, bool double_cl)
> >  {
> > -	/* return the cacheline of the address */
> > -	return (address & (cacheline_size() - 1));
> > +	u64 size = cacheline_size();
> > +
> > +	if (double_cl)
> > +		size *= 2;
> > +
> > +	/* return the offset inside cachline */
> 
> s/cachline/cacheline
 
Will fix.

> > +	return (address & (size - 1));
> >  }
> >  
> >  #endif // PERF_CACHELINE_H
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index e188f74698dd..148b28f0a7e2 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -52,6 +52,13 @@ enum sort_mode	sort__mode = SORT_MODE__NORMAL;
> >  static const char *const dynamic_headers[] = {"local_ins_lat", "ins_lat", "local_p_stage_cyc", "p_stage_cyc"};
> >  static const char *const arch_specific_sort_keys[] = {"local_p_stage_cyc", "p_stage_cyc"};
> >  
> > +/*
> > + * Some architecture has Adjacent Cacheline Prefetch feature, which behaves
> > + * like the cachline size is doubled. Enable this flag to check things in
> 
> s/Some architecture has/Some architectures have
> s/cachline/cacheline
> 
> With these typo fixes, you could add my reviewed and tested tags.

Thanks a lot for the review and helping to test on Arm64 platform
which I don't have access to!

- Feng

> Thanks,
> Leo
> 
> > + * double cacheline granularity.
> > + */
> > +bool chk_double_cl;
> > +
> >  /*
> >   * Replaces all occurrences of a char used with the:
> >   *
> > @@ -1499,8 +1506,8 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
> >  
> >  addr:
> >  	/* al_addr does all the right addr - start + offset calculations */
> > -	l = cl_address(left->mem_info->daddr.al_addr);
> > -	r = cl_address(right->mem_info->daddr.al_addr);
> > +	l = cl_address(left->mem_info->daddr.al_addr, chk_double_cl);
> > +	r = cl_address(right->mem_info->daddr.al_addr, chk_double_cl);
> >  
> >  	if (l > r) return -1;
> >  	if (l < r) return 1;
> > @@ -1519,7 +1526,7 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
> >  	if (he->mem_info) {
> >  		struct map *map = he->mem_info->daddr.ms.map;
> >  
> > -		addr = cl_address(he->mem_info->daddr.al_addr);
> > +		addr = cl_address(he->mem_info->daddr.al_addr, chk_double_cl);
> >  		ms = &he->mem_info->daddr.ms;
> >  
> >  		/* print [s] for shared data mmaps */
> > diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> > index 921715e6aec4..04f0a6dc7381 100644
> > --- a/tools/perf/util/sort.h
> > +++ b/tools/perf/util/sort.h
> > @@ -35,6 +35,7 @@ extern struct sort_entry sort_sym_from;
> >  extern struct sort_entry sort_sym_to;
> >  extern struct sort_entry sort_srcline;
> >  extern const char default_mem_sort_order[];
> > +extern bool chk_double_cl;
> >  
> >  struct res_sample {
> >  	u64 time;
> > -- 
> > 2.30.2
> > 
