Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51037671EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjAROAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjARN7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:59:47 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F8960482
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674048839; x=1705584839;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9QDiD69fMotePiu/1ZsGZ53CWaxmf+kdbHJSM/6JoOA=;
  b=lj0hHe1UAu0JqDEUZ3ATtUjVMco0yb2kMHHI2avGOJQ47xuRUmTxZyHW
   O7+9jCdxYd6B62/xd/mcJbDLZtcEIdvVz2Fl3ELlDxfNKfZI6aTgER/J+
   afyLkdKouBN+An1Hu8px3dpA0CLvud6UH5cQKN+Iujzf9fYOqr7ENhBq+
   er+GGk4KQ7ERH06jFvwP7YOzAsvoiaC6CdduevVTrfrXEsrU4yWXmH6Ya
   uahm5vZAoElr9ksMJ1r8cazN66gXsGQp/Thp0VN4+8F4xF/aHaxz2kDGv
   /OggN4TK5yAptpMLiVUm4yr8IvbZEGsV5Anu0JfpVSkUTQdlWVQao+FrS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="304662426"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="log'?scan'208";a="304662426"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 05:33:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="783677755"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="log'?scan'208";a="783677755"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2023 05:33:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 05:33:55 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 05:33:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 05:33:55 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 05:33:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmd0K0Ts+NQ8vD3mcR9sMo4paNPlxksqvLp6Qonpd3S7/damqMof1Iq5g5zqd4isjMF/LleLt8UsIHtT20KtqRoTvdamVII3Or77K65JdRL9UNVCuZxgM8DbCCon3/+eex5jjCGRCn6J5yYlftz9BORxUiE0BpTwNpAtKKELFI3wlVxlVit3DKSIBfh/FcligoRbCOAVMlbtV1PU6a9z3MVqzCzO+TROBqRiVi0rL3Zpn3dQfBGirkZs6FgDgJf72VUMuOJCfrX5BMm6za3WSIiLuV/YmsoyhNYsjsIcJWdoP7WWmg6O7tdSxt+obJ5sBrLnZiqGLGzy5mNcjCm+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7RI0zoujOHCSGWShIJhefLDrF/y2/3IcjBFJLyDzQU=;
 b=cOdytZq/7mx1F9Q8oXV03MuF4QDZExpph1ABH09KHtL1HfL0pYuUsJPnvwQZza/zlFa3fhVFVCUq7Xe6q5n+DZwEWbG8/eBwFdN/mTK9Xisv6+d84AC986T2gTNMzyGHOmOQoX8CzWKjIYNExdD+XcvnPKS3nFS5dKn+SvZIE1ZGH1eRGlmd1pDPpZxQEg7tAi0FvJ7sTzliZqyIQ3aG3IcgerfVMTBEBV/IrBhZo+ROoHZ1iR5Gz19GRA2r4IC1J5IR7C+ZZeKuT67SewZPK7uSCVt+rj9nPb6+v0jbvUT0H7VuYbCm5VpoBx3pYwjpOQawg2mKUpA8lDSFqXjjGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH8PR11MB8106.namprd11.prod.outlook.com (2603:10b6:510:255::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 13:33:51 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%3]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 13:33:50 +0000
Date:   Wed, 18 Jan 2023 21:31:06 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        "Song, Youquan" <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>, <hongjiu.lu@intel.com>
Subject: Re: [linus:master] [hugetlb] 7118fc2906:
 kernel_BUG_at_lib/list_debug.c
Message-ID: <Y8f0miUc//BQXN3A@feng-clx>
References: <202301170941.49728982-oliver.sang@intel.com>
 <2f483247-da76-9ec9-3e51-f690939f4585@suse.cz>
 <Y8ZVxJSZdtEk8Nco@feng-clx>
 <Y8aSc5xGO+rW2pyo@feng-clx>
 <CAHk-=wiS84nS9apjs_Vt=jjZ_+j+F8HQ3B+ABSvbzcqtW9x5Kg@mail.gmail.com>
Content-Type: multipart/mixed; boundary="dD8aPH+a8OyjebKK"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiS84nS9apjs_Vt=jjZ_+j+F8HQ3B+ABSvbzcqtW9x5Kg@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH8PR11MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: ead841ba-74aa-4e9c-991f-08daf958a27c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7P1X1e2lL8qWX6UvGLEHNxFtKX/N61791qFyNuNOcvE/a2felrfNatNG/mYGdSd2YnGCvXZXeZdgYY9Q1fZRm+1yJf8U2LW6SyUjvlebuWLmjFGrXms5RD8b/3p81PKV3z3eOfJ1f3pFu1hIy7d0OeG8rju3QeLbv8P6XU1dmjEDstBZ5LKYrQobipatqNjdnVLM1snwuCc/1lHm621e4mZFvsqAuQq7GGxXLQeGii9tbIaeDCt5nZr0ztuArCJd2gmRp7aXZ8ZS1t1YyhXIWRa1/A2B2xc+53BSrK16rpY8X36W7VP5KaJAxHwU4SwQeRYqgh1ywWLbFb8tk0zV/GPhByM6HRGTOwTq7GOOJHBcSpbSxd7h3/hquPsY0BF+ppeZDCBT9U61hhLgzc7jA1nIH9qQB6Fa/MUZyV3YZWl2NMJoTyH3hCGslhBJrugBGfDsoL9ztx8DJLG4MGmp8EVbt4mq5vA8whkj3VmDt4Q6WnDwJbarK3NjAMHQSplJmmwg25u3pspdyoHsSVQjiJ7gvmPtDMHe2hWFsccClXnK74pAlzTkjH1EGlEdCj622RHm6UbNcxfOkEISiQEnoqQ0vWzGQQvJ/iFjFFl156ksKZ0/tOkJDrknXY3SDUl7wFzrjvRoqS4AX2bQjmOmcPz1cPP2E0xwSNbrFqGfqghHot+M3ZcYwbQJgIA3S/MJUdN3ONMMFlFjRXBDkARwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199015)(83380400001)(33716001)(54906003)(6486002)(6512007)(9686003)(478600001)(186003)(26005)(86362001)(38100700002)(82960400001)(2906002)(6666004)(107886003)(66556008)(6506007)(21480400003)(53546011)(44144004)(44832011)(6916009)(66476007)(4326008)(66946007)(316002)(41300700001)(5660300002)(8676002)(235185007)(8936002)(7416002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mFSAk27HUHPGYb8/+abiJAlJaqHCxIOOluyZO+U+NakhsZCmqT0ysX3HZofu?=
 =?us-ascii?Q?G2i/JIhPY6T4NTw70Bli0f+DqeDZ4L1C4r2WVCYOrgLTFSldyAeS1R1u55b+?=
 =?us-ascii?Q?ewbi+pFYCjmSlnSz06kjdJXq/Y+nP3bIgnrItUCe7YFlYts0PASJCaExtrL8?=
 =?us-ascii?Q?CnPEcmbMDvUqpZuEQn3Xch3OhU6w5QTV0WN0FrOiIK403Qeys208sRfrbjFW?=
 =?us-ascii?Q?UfYCfJn4rDfDgXQ9dirKe8SJGZ2Ht0eCS5IgckVi+Bj4cyTEPod9sb6CARmE?=
 =?us-ascii?Q?4zuGMMymrraXcCZ7G1LHoum1GIUc3xtveQknTpjvDWriOYMIeZuFkLv4mVqp?=
 =?us-ascii?Q?QqKMvAMcbH6EfSDeBEKfWSDm2NoIOqfOn6++m0fdVe2Ioa1ra93qyoneb6Xq?=
 =?us-ascii?Q?hyMJB5R91Wfg7H5oSr2t75pKqxcqHMrExZAJ4SqVKef7ipSB4ZNjE2VvvXI2?=
 =?us-ascii?Q?dRI/QXC7bjkwcR+ydSjjYH4zh2uEYDWlfwc94Vg1bXT0MwX5Or8CRFtIdTEU?=
 =?us-ascii?Q?1a8GYjDMxAZBJ9bGQ8t5XvZtvTs56CTd6O+wIA3yZHUuMKLvJLuxw7Df9n3t?=
 =?us-ascii?Q?lhp4BimLkoSzN9MmPOTcgCx/WYUG0U34ppAlGS0qn73vgBCYq46KoYdQaoAo?=
 =?us-ascii?Q?nhykjydniNeOvKB5HN1G+01X2lLINpCn3prRwxWuo2XXhP46K+Da0GEZ1Cfs?=
 =?us-ascii?Q?uUUT89oA6RySLw5gRJpGCMRJczgl4RPX4O7Mp1QCpWEgTaaQBqEX4y8IYggB?=
 =?us-ascii?Q?oTUyjweHEg7D7fABgxhZ7obT6ZHTKJHfW7s7mznjgPV4tD+Gx6VlrkLbbcVz?=
 =?us-ascii?Q?TNa3tK/ihjb2lrr2OlD04V6w4H4Lyizp6xJ8rGWXO24ba+fGPxofhlAKcXu+?=
 =?us-ascii?Q?3xR8p25Nwl+FI4c0p3cbFIrhqEsPDed4p0OaMBbqDd1BW5f8fChfGOytlnF9?=
 =?us-ascii?Q?Fsvud578dmPs+Q4TDhYvx/2I1VoNDdyrGuzFroN6jla0XMPuXwh7ABa5hT4L?=
 =?us-ascii?Q?ZvuX5boP6VCRZhBT/fOru1Chsu1EKY0iKMh1Kp5oD2cQBQPJfjKI1361O1Es?=
 =?us-ascii?Q?p6SvX5xHDYAf9Dt48aKoIdY5BEq/Gje5RhHFhL62aSATNkCAarUhNdysXga/?=
 =?us-ascii?Q?e5tjH/qeY4GOT+1O8fRkj4LIvJt8JP3LM8fH7b8YdJ1acEFHPxy7oo+iJq6g?=
 =?us-ascii?Q?CSCS542fmyGivEhCEer/0rom6Mq2kzc5jOumXhCcK4dqaXFavhk0fLp8TO+H?=
 =?us-ascii?Q?P5OjnQUMpq5oMekgMOpulhiH0m/bGqjE1RP2H+1LJNdzIl4tWCR3D6KR1d4y?=
 =?us-ascii?Q?YIp1nsZiaWWjAMLSUtUrcSsxHHU908sVcmgcwftlE7YO/WlpSqVr7t2+eafk?=
 =?us-ascii?Q?XOC0SxR1v350rIy1skD3P5nX1g3dZkTYCz8rNeWlYP95IhzWlMxXJoUGkUyF?=
 =?us-ascii?Q?KM8Rzjyad3fAtJzB7sjnI/qhbJsZzxQ2W0Q8Rux02wbl3OnNxip9nYOW2vYD?=
 =?us-ascii?Q?oGPzrCZ4kEZljIuHMMljckPoLWsmbO5Ylkmsjy3CIer0tW7KQdVe8fJaQvQi?=
 =?us-ascii?Q?6jPeK7PAFaU9XjWEEyysEAsdlfOn0UVn32HlVBNA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ead841ba-74aa-4e9c-991f-08daf958a27c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 13:33:50.7983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dakDPiLfuJlnzr4urIrqxziKpCob95JUlWN5Hnesc9huWny4b5xHB/nxjBzrjfLJsqft7rw0TcZ7eSthjKLrqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8106
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--dD8aPH+a8OyjebKK
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jan 17, 2023 at 10:25:17AM -0800, Linus Torvalds wrote:
> On Tue, Jan 17, 2023 at 4:22 AM Feng Tang <feng.tang@intel.com> wrote:
> >
> > With the following patch to use 'O1' instead 'O2' gcc optoin for
> > page_alloc.c, the list corruption issue can't be reproduced for
> > commit 7118fc2906 in 1000 runs.
> 
> Ugh.
> 
> It would be lovely if you could just narrow it down with
> 
>   #pragma GCC optimize ("O1")
>  ...
>   #pragma GCC optimize ("O2")
> 
> around just that prep_compound_page(), but when I tried it myself I
> get some function attribute mismatch errors.

Yes, this works with both my local build and 0Day's build system,
and it also makes the issue gone.
 
> > As is can't be reproduced with X86_64 build, it could be i386
> > compiling related.
> 
> Your particular config causes a huge amount of nasty 64-bit arithmetic
> according to the objdump code, with sequences like
> 
>   c13b3cbb:       83 05 d0 28 6c c5 01    addl   $0x1,0xc56c28d0
>   c13b3cc2:       83 15 d4 28 6c c5 00    adcl   $0x0,0xc56c28d4
> 
> which seems to be just from some coverage profiling being on
> (CONFIG_GCOV?), or something. It makes it very hard to read the code.
> 
> You also have UBSAN enabled, which - again - makes for some really
> grotty asm that hides any actual logic.
> 
> Finally, your objdump version also does some horrendous decoding, like
> 
>   c13b3e29:       8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi

I know little about these tools, and I tried objdump tool from
Cent OS 9 (objdump version 2.35.2) and Ubuntu 22.04 (objdump version
2.38), they both dumped similar assembly. Please let me know if you
want us to try other version of objdump.

> which is just a 7-byte 'nop' instruction, but again, it makes it
> rather hard to actually read the code.
> 
> With the i386 defconfig, gcc generates a function that is just ~30
> instructions for me, so this makes a huge difference in the legibility
> of the code.
> 
> I wonder if you can recreate the issue with a much more
> straightforward config. By all means, leave DEBUG_PAGEALLOC and SLUB
> debugging on, but without the things like UBSAN and GCOV.

We modify the kconfig to disable GCOV and UBSAN, and the issue can't
be reproudced in 1000 runs.

The objdump of prep_compound_page() for the 2 commits are also
attached for check.

Anothe info is, as you pointed out GCOV and UBSAN, we tried to
disable GCOV/UBSAN for page_alloc.c in mm/Makefile separtely
(thanks to Fengwei Yin's tip), by adding lines:

a) UBSAN_SANITIZE_page_alloc.o := n
b) GCOV_PROFILE_page_alloc.o := n 

The issue also cannot be reproduced with either one (with
original kconfig)  

> > I also objdumped 'prep_compound_page' for vmlinux of 7118fc2906 and
> > its parent commit 48b8d744ea84, which have big difference than the
> > simple 'set_page_count()' change, but I can't tell which part is
> > abnormal, so attach them for further check.
> 
> Yeah, I can't make heads or tails of them either, see above on how
> illegible the objdump files are. And that's despite not even having
> all of prep_compound_page() in them (it's missing
> prep_compound_page.cold, which is probably just UBSAN fixup code, but
> who knows..)

Yes, from what I can tell that old 'prep_compound_page.cold' is mostly
calling UBSAN functions. And after disbling GCOV+UBSAN, there is no
more prep_compound_page.cold. 

Thanks,
Feng

> 
> That said, with the i386 defconfig, the only change from adding
> set_page_count() to the loop seems to be exactly that:
> 
>  .L589:
> -       movl    $1024, 12(%eax)
> +       movl    $0, 28(%eax)
>         addl    $32, %eax
> +       movl    $1024, -20(%eax)
>         movl    %esi, -28(%eax)
>         movl    $0, -12(%eax)
>         cmpl    %edx, %eax
> 
> (don't ask me why gcc does *one* access using the pre-incremented
> pointer, and then the rest to the post-incremented ones, but whatever
> - it means that it's not just "add a mov $0", it's also changing how
> the
> 
>         p->mapping = TAIL_MAPPING;
> 
> instruction is done, which is that
> 
> -       movl    $1024, 12(%eax)
> +       movl    $1024, -20(%eax)
> 
> part of the change)
> 
>              Linus

--dD8aPH+a8OyjebKK
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="7118fc29.log"


c11e56e0 <prep_compound_page>:
c11e56e0:	55                   	push   %ebp
c11e56e1:	89 d1                	mov    %edx,%ecx
c11e56e3:	89 e5                	mov    %esp,%ebp
c11e56e5:	56                   	push   %esi
c11e56e6:	53                   	push   %ebx
c11e56e7:	89 c3                	mov    %eax,%ebx
c11e56e9:	b8 01 00 00 00       	mov    $0x1,%eax
c11e56ee:	d3 e0                	shl    %cl,%eax
c11e56f0:	83 3b ff             	cmpl   $0xffffffff,(%ebx)
c11e56f3:	0f 84 87 00 00 00    	je     c11e5780 <prep_compound_page+0xa0>
c11e56f9:	0f ba 2b 10          	btsl   $0x10,(%ebx)
c11e56fd:	48                   	dec    %eax
c11e56fe:	7e 21                	jle    c11e5721 <prep_compound_page+0x41>
c11e5700:	8d 73 01             	lea    0x1(%ebx),%esi
c11e5703:	ba 28 00 00 00       	mov    $0x28,%edx
c11e5708:	d3 e2                	shl    %cl,%edx
c11e570a:	8d 43 28             	lea    0x28(%ebx),%eax
c11e570d:	01 da                	add    %ebx,%edx
c11e570f:	90                   	nop
c11e5710:	c7 40 0c 00 04 00 00 	movl   $0x400,0xc(%eax)
c11e5717:	83 c0 28             	add    $0x28,%eax
c11e571a:	89 70 dc             	mov    %esi,-0x24(%eax)
c11e571d:	39 d0                	cmp    %edx,%eax
c11e571f:	75 ef                	jne    c11e5710 <prep_compound_page+0x30>
c11e5721:	c7 43 34 ff ff ff ff 	movl   $0xffffffff,0x34(%ebx)
c11e5728:	b8 01 00 00 00       	mov    $0x1,%eax
c11e572d:	c6 43 30 01          	movb   $0x1,0x30(%ebx)
c11e5731:	d3 e0                	shl    %cl,%eax
c11e5733:	89 43 38             	mov    %eax,0x38(%ebx)
c11e5736:	8b 43 04             	mov    0x4(%ebx),%eax
c11e5739:	88 4b 31             	mov    %cl,0x31(%ebx)
c11e573c:	a8 01                	test   $0x1,%al
c11e573e:	75 50                	jne    c11e5790 <prep_compound_page+0xb0>
c11e5740:	89 d8                	mov    %ebx,%eax
c11e5742:	8b 10                	mov    (%eax),%edx
c11e5744:	81 e2 00 00 01 00    	and    $0x10000,%edx
c11e574a:	74 24                	je     c11e5770 <prep_compound_page+0x90>
c11e574c:	83 38 ff             	cmpl   $0xffffffff,(%eax)
c11e574f:	74 42                	je     c11e5793 <prep_compound_page+0xb3>
c11e5751:	8b 10                	mov    (%eax),%edx
c11e5753:	81 e2 00 00 01 00    	and    $0x10000,%edx
c11e5759:	74 0d                	je     c11e5768 <prep_compound_page+0x88>
c11e575b:	80 78 31 01          	cmpb   $0x1,0x31(%eax)
c11e575f:	76 07                	jbe    c11e5768 <prep_compound_page+0x88>
c11e5761:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
c11e5768:	5b                   	pop    %ebx
c11e5769:	5e                   	pop    %esi
c11e576a:	5d                   	pop    %ebp
c11e576b:	c3                   	ret    
c11e576c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
c11e5770:	8b 50 04             	mov    0x4(%eax),%edx
c11e5773:	f6 c2 01             	test   $0x1,%dl
c11e5776:	75 d4                	jne    c11e574c <prep_compound_page+0x6c>
c11e5778:	5b                   	pop    %ebx
c11e5779:	5e                   	pop    %esi
c11e577a:	5d                   	pop    %ebp
c11e577b:	c3                   	ret    
c11e577c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
c11e5780:	ba 10 5c 97 c2       	mov    $0xc2975c10,%edx
c11e5785:	89 d8                	mov    %ebx,%eax
c11e5787:	e8 e4 ae fd ff       	call   c11c0670 <dump_page>
c11e578c:	0f 0b                	ud2    
c11e578e:	66 90                	xchg   %ax,%ax
c11e5790:	48                   	dec    %eax
c11e5791:	eb af                	jmp    c11e5742 <prep_compound_page+0x62>
c11e5793:	ba 10 5c 97 c2       	mov    $0xc2975c10,%edx
c11e5798:	e8 d3 ae fd ff       	call   c11c0670 <dump_page>
c11e579d:	0f 0b                	ud2    
c11e579f:	90                   	nop



--dD8aPH+a8OyjebKK
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="48b8d744.log"


c11e56c0 <prep_compound_page>:
c11e56c0:	55                   	push   %ebp
c11e56c1:	88 d1                	mov    %dl,%cl
c11e56c3:	89 e5                	mov    %esp,%ebp
c11e56c5:	57                   	push   %edi
c11e56c6:	bf 01 00 00 00       	mov    $0x1,%edi
c11e56cb:	56                   	push   %esi
c11e56cc:	89 c6                	mov    %eax,%esi
c11e56ce:	53                   	push   %ebx
c11e56cf:	d3 e7                	shl    %cl,%edi
c11e56d1:	83 ec 0c             	sub    $0xc,%esp
c11e56d4:	83 38 ff             	cmpl   $0xffffffff,(%eax)
c11e56d7:	89 55 ec             	mov    %edx,-0x14(%ebp)
c11e56da:	0f 84 c0 00 00 00    	je     c11e57a0 <prep_compound_page+0xe0>
c11e56e0:	0f ba 28 10          	btsl   $0x10,(%eax)
c11e56e4:	83 ff 01             	cmp    $0x1,%edi
c11e56e7:	7e 38                	jle    c11e5721 <prep_compound_page+0x61>
c11e56e9:	89 75 e8             	mov    %esi,-0x18(%ebp)
c11e56ec:	8d 48 01             	lea    0x1(%eax),%ecx
c11e56ef:	bb 01 00 00 00       	mov    $0x1,%ebx
c11e56f4:	8d 40 28             	lea    0x28(%eax),%eax
c11e56f7:	89 ce                	mov    %ecx,%esi
c11e56f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
c11e5700:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
c11e5707:	3e 8d 74 26 00       	lea    %ds:0x0(%esi,%eiz,1),%esi
c11e570c:	c7 40 0c 00 04 00 00 	movl   $0x400,0xc(%eax)
c11e5713:	43                   	inc    %ebx
c11e5714:	83 c0 28             	add    $0x28,%eax
c11e5717:	89 70 dc             	mov    %esi,-0x24(%eax)
c11e571a:	39 df                	cmp    %ebx,%edi
c11e571c:	75 e2                	jne    c11e5700 <prep_compound_page+0x40>
c11e571e:	8b 75 e8             	mov    -0x18(%ebp),%esi
c11e5721:	c7 46 34 ff ff ff ff 	movl   $0xffffffff,0x34(%esi)
c11e5728:	8b 4d ec             	mov    -0x14(%ebp),%ecx
c11e572b:	b8 01 00 00 00       	mov    $0x1,%eax
c11e5730:	c6 46 30 01          	movb   $0x1,0x30(%esi)
c11e5734:	88 4e 31             	mov    %cl,0x31(%esi)
c11e5737:	d3 e0                	shl    %cl,%eax
c11e5739:	89 46 38             	mov    %eax,0x38(%esi)
c11e573c:	8b 46 04             	mov    0x4(%esi),%eax
c11e573f:	a8 01                	test   $0x1,%al
c11e5741:	75 6d                	jne    c11e57b0 <prep_compound_page+0xf0>
c11e5743:	89 f0                	mov    %esi,%eax
c11e5745:	8b 10                	mov    (%eax),%edx
c11e5747:	81 e2 00 00 01 00    	and    $0x10000,%edx
c11e574d:	74 41                	je     c11e5790 <prep_compound_page+0xd0>
c11e574f:	83 38 ff             	cmpl   $0xffffffff,(%eax)
c11e5752:	74 5f                	je     c11e57b3 <prep_compound_page+0xf3>
c11e5754:	8b 10                	mov    (%eax),%edx
c11e5756:	81 e2 00 00 01 00    	and    $0x10000,%edx
c11e575c:	74 0d                	je     c11e576b <prep_compound_page+0xab>
c11e575e:	80 78 31 01          	cmpb   $0x1,0x31(%eax)
c11e5762:	76 07                	jbe    c11e576b <prep_compound_page+0xab>
c11e5764:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
c11e576b:	83 c4 0c             	add    $0xc,%esp
c11e576e:	5b                   	pop    %ebx
c11e576f:	5e                   	pop    %esi
c11e5770:	5f                   	pop    %edi
c11e5771:	5d                   	pop    %ebp
c11e5772:	c3                   	ret    
c11e5773:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
c11e5777:	90                   	nop
c11e5778:	89 45 f0             	mov    %eax,-0x10(%ebp)
c11e577b:	31 d2                	xor    %edx,%edx
c11e577d:	e8 5e 06 04 00       	call   c1225de0 <__page_ref_set>
c11e5782:	8b 45 f0             	mov    -0x10(%ebp),%eax
c11e5785:	eb 85                	jmp    c11e570c <prep_compound_page+0x4c>
c11e5787:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
c11e578e:	66 90                	xchg   %ax,%ax
c11e5790:	8b 50 04             	mov    0x4(%eax),%edx
c11e5793:	f6 c2 01             	test   $0x1,%dl
c11e5796:	75 b7                	jne    c11e574f <prep_compound_page+0x8f>
c11e5798:	83 c4 0c             	add    $0xc,%esp
c11e579b:	5b                   	pop    %ebx
c11e579c:	5e                   	pop    %esi
c11e579d:	5f                   	pop    %edi
c11e579e:	5d                   	pop    %ebp
c11e579f:	c3                   	ret    
c11e57a0:	ba a8 5b 97 c2       	mov    $0xc2975ba8,%edx
c11e57a5:	e8 f6 ae fd ff       	call   c11c06a0 <dump_page>
c11e57aa:	0f 0b                	ud2    
c11e57ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
c11e57b0:	48                   	dec    %eax
c11e57b1:	eb 92                	jmp    c11e5745 <prep_compound_page+0x85>
c11e57b3:	ba a8 5b 97 c2       	mov    $0xc2975ba8,%edx
c11e57b8:	e8 e3 ae fd ff       	call   c11c06a0 <dump_page>
c11e57bd:	0f 0b                	ud2    
c11e57bf:	90                   	nop


--dD8aPH+a8OyjebKK--
