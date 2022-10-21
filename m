Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799606074AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJUKK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiJUKKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:10:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4F7A0248
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666347006; x=1697883006;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FiISK/PmQOkpECwRi2FIe1c1ieA8ZD/WP5OU7qsVpe4=;
  b=MiSfTgvUq/nVB5gVquJnzsGXijZqaFrWWVg3FEpPIveyJyw84R+BMj9a
   PfE2i390PI8BTnfGf8FPWhdd94ontqssoYFo7vaoUNxVtTAk/alg7WJFb
   Y7X/amQZu3ZVn/TAkjJcUCLVBlHqNjogIe7Ufd+8Dcn0H0izhePj6Q7Td
   PgBR4qG3iAz81pniEDWwAip7VmaL4Dr+VaW75VARPnWHIGRGnahC6fGGm
   BPmaSIBDao6iBWy6+SqXAeKBfWuB6OiY8kuQMU98RQBgIgoY2cDBvh7aT
   R5JF8nnWINW+NnhvRoex9/eDY41NWdYVaRwgXPnsUNlvcRgBgGkWWyUdJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="290273596"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="290273596"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 03:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="699265819"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="699265819"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 21 Oct 2022 03:10:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 03:10:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 03:10:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 03:10:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 03:10:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLl6+qfotCPrpU00AXT/wc//FVcVfvxlwXPt3qiMme9GmMnCVJIJWp/dtqWAcFLNb44YTuPL6BGFU9XlOVQozIaj2OnbpSWbYrX7D4dpUfppvIgmC1rRvsYyeKYjMQqCXOLNUeLRywNOiN5jcBYbLU+P+qh+nwCuY73zWHTLjKz94M8uKxKvBvPMe1TJ3/4R416ll97Sv5OuZjNxt3frTQo+bWKhT55BK/MLMPuOFQZ52tfoYCHK/uoHCUKWTlc2EPsFs7MJY0zJ3qgdGuBTwKxjCZM8ylofggghhS5sZKSbr2Vbe6TRp3sk4bEIGFbQf/ZiZZkt0wrmORYlu4gjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCx4RqXesIBjsPNV9lfhlBV4ek2cb+0HbQg36PfpLQQ=;
 b=aFQ0Soft38dzo+Pflnuac7uPGkIv7NCWQ4VA1fqVIz97Si8hrRep7ZJfPlm0zc4pjgSf9wLPkXVep0qPS32x7pQWXyEDyHfRfTPbWz7rcbmJhMq+hS/MmfyZMs8/JAqJUY6Q99NPZDOt8tfsGn56ley+Kem9aaDAG+FacuZ1tlR8Rw7ba9Yk2crJHP/Vn+rh6YCh5v3eXbPBb/s8kN2R4yWMW/wlfsRk0xZ259Hf3kyLCP2MEYLmw7GrTtVt1TJExHbMGXjeeVCXEV6hNrM5479eBddK4lSHtvmqLN8AzQ9fBMsQiQ7yxCu3RfHnlFuJyxINGZASxMMEHADn1EU3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW4PR11MB6620.namprd11.prod.outlook.com (2603:10b6:303:1ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 10:09:59 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d%7]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 10:09:59 +0000
Date:   Fri, 21 Oct 2022 18:08:33 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Yury Norov <yury.norov@gmail.com>, <lkp@lists.01.org>,
        <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [lib/cpumask] 6f9c07be9d:
 WARNING:at_include/linux/cpumask.h:#prefill_possible_map
Message-ID: <Y1JvofRR2APc4HK8@yujie-X299>
References: <202210201612.9d7547bf-yujie.liu@intel.com>
 <Y1FzKVLlLPrhb47D@yury-laptop>
 <Y1GHthWAyAq2Q+Yz@yujie-X299>
 <CAMuHMdWtXzO+gv7g+0kRgj2LnV27Jn8Ehv1H4KH3CBSuwen+zg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWtXzO+gv7g+0kRgj2LnV27Jn8Ehv1H4KH3CBSuwen+zg@mail.gmail.com>
X-ClientProxiedBy: SG2PR01CA0109.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::13) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MW4PR11MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: d378ad46-0fe3-470d-bf54-08dab34c692f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KnT1TWpkMx1FoNwAMxbn+qWoe52x4yXJULPcZDbAPWVvh0c9pXRcOoBogUJGa5gway2wg1Fx8Jl+QPM6LbWP9SE4m9NZjFbbNHnBVXIaXSkfA3n7IOLy6xz4OnAANkh5ATsUkTyUFVgn4nBIosIgFdLUImUT5LzkZppjekQ771aQCy+/CjdgSeucZI6PrPSN44y5o9F/rG8T2TpGoUQcsEQMlrvxSN0602OUM8QgjOtvZCJ6rk8BVKhXwD3qEFGs3UeiJXWaB48HowdQNqaqpmyks3abc+inILHHLQTTgEmTlVSnwMaDohAStH2gPqcfj3LBSRtNKVA4aV1fxLGMFF+aV2k5o5ZltRaekLaoaNNoU3Whg0cY5NxntrL7jBgxKXYIeVcJyFnRb+vB/jXKVZxg54CeV5JcV2mAyjTAZ2OE6lKj8wo9nvyejUMwoTFVWKoraWqybXuq8piLhvE21gyxo3b+I6n2qaGesXO3YO+7G30tx5f9QgrnDOcH/MNFqs/TTsgYwc4icnVuKSCqvhNhBGBpyt/x/VMXZ7pK0FH+VxL9zTNQvUxU1ned3z1Ics3NM2yt0hg+Up8YrXDIs8tuPEx7VJKqOy/CSk5mfM1SvVN3MD/Np15EKo60e0AMHg1h3NnHZ3s4VhIHpXKuUR+VZG9M/ouMNzniqIQ/pgbjQIJRndSQeJCRWFf08yzeqxATmjzpzJu+vZGZVI3CNqMpQhUa7DjTlKf+iTFQ2ILEN+QBKAvpdnx3eCUr8GfG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199015)(33716001)(478600001)(9686003)(186003)(82960400001)(2906002)(6486002)(38100700002)(966005)(6916009)(316002)(66556008)(66476007)(41300700001)(66946007)(6506007)(4326008)(8676002)(6666004)(54906003)(53546011)(6512007)(26005)(5660300002)(44832011)(83380400001)(86362001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GsynSX1fKGHtpiaG4CqjOOLcqLy25yCw732RFbuMVWNBXhHNzi6jr1RIt4i/?=
 =?us-ascii?Q?5BBCVLmUFgTtIv97AyGzBqGiy9a1uuwnMYc9w+uRfZdGmSYTvjRqw0Y1im9z?=
 =?us-ascii?Q?291CvYQP+UOr6Bv2p44ISM2oSw3OQQNhAGxTNnM9JNVLXhYxEl0u2CoLquhU?=
 =?us-ascii?Q?68zAQbcFOMuG4AoxXFKUNtl9bAV6eFdoWA6jtvWTD0n9GWhziHCCSaq5imUB?=
 =?us-ascii?Q?Whhjg1xWwHa4vT9cog1YpZXDXtQNoK7mksIN0YjmVgoJLfK8SYgDDumxPlNg?=
 =?us-ascii?Q?FgaE/4JGhan7u49wv6kuyYZMKoxCB2qTpmzOqr9V3fDDUfCK6UgY8/FUcQns?=
 =?us-ascii?Q?a20zh7KUQG6o7qUJcUjwctujqN3Jy4+9Y11G9+oktfwlQoiS3SJ4UbpzQiZ3?=
 =?us-ascii?Q?cjYmIBQzqxDuXALhylqpWmD0sIVPjLml8nF7K/0anNUe2VAUgWKsXid41Zlq?=
 =?us-ascii?Q?1+lM+0D+PionOr6ihAjxVX1hrEY5lCEcUX/QusXnTCnf6phTRuxQ9nuSlmBl?=
 =?us-ascii?Q?lhgg7GUAxzjLjDVOhNyJcbEB0hb0jysQSU0uH0362XqYFRjwS3eZu9l+WcBo?=
 =?us-ascii?Q?3XHgi/Kmcg9Zd90ZUo0F9kmEy/okObMn3pMNgAmhR43leF49/5y0cwEWYA4S?=
 =?us-ascii?Q?z493p2ssWqu1a8fQb4EOvITI8JHzy4lSJKXXyDHG1a/9NYc4N9iVbJzoNIzC?=
 =?us-ascii?Q?eGfsO1igYOXtmo2ghKcopN6zvAcM+c1BN26BYo4/TjlO3OPAOlWQZnRZJoG3?=
 =?us-ascii?Q?Xp+belFBkw1pWFDtSzHVxGEiEQ8DwwRvCKQN+6zwVtto57DFnKjycU1w95yF?=
 =?us-ascii?Q?ORLxadeY9uOIvNw2l/NcCkt2wb4IFPkJ/nEi7z3sGIwWIyrtKXfvFbt7X6cc?=
 =?us-ascii?Q?ZpF1X4BZH+gNLgxicu/AVKMUSH6lTvPCjcxg4Wb9+Qo6lczEjtMuf13mg0va?=
 =?us-ascii?Q?pZU9pW8hl3VJGY8kwRpFzmPQUc5o+g56Rf3Jo3Yw1w8GBvRr6f9v3mOhlknk?=
 =?us-ascii?Q?nEf/PZIgiJEIpogBDLWLUM+7QDR7qmpW5XR1jUkRF4dhWzXXPo8NomtNTeOF?=
 =?us-ascii?Q?uJuS4xoWEXouruiucWqSu2lmWOIL9q7oMGpYhQ97mtMFfRQjTKQAfdUK/qeG?=
 =?us-ascii?Q?X/MMAYrt+I4q8b2RwmyEGyyZvcSapzpFuJxWU8VJyh+QeUq7SrekTJscfLTX?=
 =?us-ascii?Q?BzCJm1vxekSS5K9TrntryVDCHABkAfcSJm3SKC2WA1Y4agsH4QDlHubFF6VJ?=
 =?us-ascii?Q?MVWX+Zk2V6CCNqwHXM7OFq/4TWLPRRZR4cUWrSjAv7Q9gbpRbhxY6I7+s88J?=
 =?us-ascii?Q?laTLHCiltB7FW9NIojPpSd99auGi5InYeuZLSZhCwY4ER1sGiAzXwkf3+Wsg?=
 =?us-ascii?Q?7mLRN4DUBOSqTSCgPMhxP2bRd2QJ2bQISVIQIWUT9WAlHnUJ3y7y/uldREQq?=
 =?us-ascii?Q?CNq0zj/u5ctspgXEzMisyap6BTUZqV85vGgjYInp+T+VemJVHC7chNjy1PqF?=
 =?us-ascii?Q?6FoOJOGYOQhNRqFBUhjiwZLDesT78frybkqQ228Ai4Ld3FV/28ip6hZxNgEY?=
 =?us-ascii?Q?JURw/n0FhLP32F5dg04CI/LAn5fAAkJr+oMu+X1QiL7JbCWcc39GsTr8XuXM?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d378ad46-0fe3-470d-bf54-08dab34c692f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 10:09:59.3875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DY7gVrY5adngdjR3i3xolRNgfExuBX24Hbo+G+0ykNpzSlwqJvCHUngiz3MBBUUAwemVezocWElvBZx0BkoXjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6620
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, Oct 21, 2022 at 08:39:10AM +0200, Geert Uytterhoeven wrote:
> Hi Yukie,
> 
> On Thu, Oct 20, 2022 at 7:40 PM Yujie Liu <yujie.liu@intel.com> wrote:
> > On Thu, Oct 20, 2022 at 09:11:21AM -0700, Yury Norov wrote:
> > > On Thu, Oct 20, 2022 at 06:05:51PM +0800, kernel test robot wrote:
> > > > We noticed that below patch adds a FORCE_NR_CPUS config, and it is
> > > > expected to show a warning when this config is enabled and
> > > > CONFIG_NR_CPUS doesn't match the actual number of CPUs we have. But we
> > > > also noticed that it not only shows a warning but could also break boot
> > > > test in some cases. We are not sure if the break is actually related to
> > > > this patch or not, so we send this report FYI.
> > > >
> > > > We noticed that a fix patch was posted at:
> > > >
> > > > https://lore.kernel.org/all/20221019225939.1646349-1-yury.norov@gmail.com/
> > > >
> > > > FORCE_NR_CPUS won't be enabled by allmodconfig or allyesconfig after
> > > > applying the fix, but looks it could still be enabled by randconfig. Not
> > > > sure if this is an expected behavior, but since our test robot runs many
> > > > randconfig tests, this warning could still be triggered frequently and
> > > > go to boot failure at last.
> > > >
> > > > Please kindly help to give some advice on handling this config in our
> > > > testing. Thanks.
> > > >
> > > > Please check below report for more details:
> 
> > > Indeed, if FORCE_NR_CPUS is enabled by randconfig, it may cause at least
> > > boot warning. I'm either not sure if the following alloc_pages is
> > > related to the config, but anyways...
> > >
> > > The most logical solution would be disabling FORCE_NR_CPUS in
> > > randconfig before building the kernel. We can do it in a post-script,
> > > like:
> > >
> > > make randconfig
> > > scripts/config -d FORCE_NR_CPUS
> > > scripts/config -e UNFORCE_NR_CPUS
> > > make
> >
> > This seems to need extra work to run config script for each randconfig
> > build.
> 
> While randconfig is great for doing build tests, I would not use it
> for boot tests, until you have some way to make sure critical options
> are enabled (or disabled).  A plain randconfig kernel is almost
> guaranteed to lack some driver you need.

Thanks for the comment. I just realized that we do have this process in
our test robot. It will fixup randconfigs to make sure critical configs
are properly set to fit our boot test environment. I should also disable
FORCE_NR_CPUS in this process and this issue is easily resolved.

> > > Or we can create a pre-configuration file, so that randconfig would do
> > > its work based on that. We already have such pre-configs for powerpc
> > > and risc:
> > >         arch/riscv/configs/32-bit.config
> > >         arch/powerpc/configs/32-bit.config
> > >         arch/powerpc/configs/64-bit.config
> > >         arch/riscv/configs/64-bit.config
> > >
> > > Maybe it's time to create a generic config of this sort.
> >
> > It would be nice to have a pre-config file to ensure this config won't
> > be enabled accidentally by randconfig if users are not aware of. This
> > would also be consistent with common build flow so no extra steps are
> > needed.
> 
> The above configs don't contain any options controlling included
> drivers.
> Which options would you add to it? This is very platform-specific.

By disabling FORCE_NR_CPUS in randconfig fixup, seems we don't need to
have above config constraints. My apologies for raising this naive
problem, we should have addressed this issue internally before seeking
help from developers. Sorry for bothering.

> > > Please let me know if that sounds sane to you. I'm not very familiar
> > > to build system things, but I'll be happy to help implementing this,
> > > if needed.

--
Best Regards,
Yujie
