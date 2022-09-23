Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7045E7E70
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiIWPbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiIWPbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:31:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827BD1449F3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663947101; x=1695483101;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WR2ga+kxGkyj2AZa05LX2Bgu96b5WxaVuXse5rSdRUA=;
  b=U+1d79QuletkZUv8pPtLLCRUaFVMEL7ZTO2tenAC2aRzLEhzKNohXTmQ
   C2ndoJbM0gLQSJIfN/kDehFfy2kejH4bPjonMOOZcw37S38b8wvyJhWc2
   pSpSCuxgK7zynYTIbNP+AgO1ZsYCVErHnsJI2CN6sbJdxSoTaVZ6xzJQZ
   aB7vCdtB7Z4VCNKltXYn6y3nL/I4myQx4H067WIBD8tNYac7slICYXFBN
   QTlbQxTujSydBA9rFaqKDDbPgRG5F2d8sCf5PFhlokyhcr25tuG0/78O4
   ptmd1T2W3udbvUGVrxFJZqOTT4J5HwDrGWnXgZjVsnRODJ85uotzzc+Cj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="298214980"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="298214980"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 08:31:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="795537772"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 23 Sep 2022 08:31:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 08:31:37 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 08:31:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 23 Sep 2022 08:31:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 23 Sep 2022 08:31:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PT7ef2g1dsYI1R3Tzuby0kMVYG/z4CbjXuwosdQUhfxqbQYOSg/X/CHdG2acjCVhmMgnTfOnE6ZyVcXqRdfcf90S77QdXJ8f2jGMHkr4934dPehbVXyzlIn0RhEGuMNDJfLFk/upCWZ8sxKIGwjAGtoOf16s9xYW25ZW2Lg1pnkHuVZDTOrFlXVq47kOLwPWGf+/AFmwGq6PMHOL07i384WBev9ynA9fJPf0O9tyUfmJcCf058Fmi8bcSNt5Ub+GQTcP9dvwM6UPtyntySfW6X4cHQq2xHVeffpA1KvnkwbXgzzY0wcRYUiV7FxgwJm0lAO1oRn96BUg8wZ7BpnHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+JEC1r+dlc2+SgNbOURZIR68eKyLEZ/+AA9ewCzNTo=;
 b=RTFMUJ2qpz9IHdU8SvJtxNydzKlz2yDTBrzSutpjMOZ9dkS3Ls7tWurDr9PNh+piy4Ql5YJKyIDhVaPHo7kSP6bLalcG+mUWormBzaQ07TfqcoEafQxhVZEYyqMmudxDda40MOvI/fmzySKwljRouf8TIbyJc1yfTTsvLikzY3FJovwc3byjGpF0xyFx/HwFiJdXXo2g5gJWpVwzr86rCn5OBg57gZeMl86fZD/GS8WQWnBHED8BSNJi7eYV3wDY+DzkO1Ot5ZFYnPt2VR7bSAcaaL9n0g+rgD1/C6G/1koBcqMjgHWGJUGs+aKq8uWeo3wbvcCpKnVgB1A9XkGYAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by IA1PR11MB7175.namprd11.prod.outlook.com (2603:10b6:208:419::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Fri, 23 Sep
 2022 15:31:32 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::5482:e4d0:c7d9:e8be]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::5482:e4d0:c7d9:e8be%4]) with mapi id 15.20.5654.019; Fri, 23 Sep 2022
 15:31:32 +0000
Date:   Fri, 23 Sep 2022 23:31:21 +0800
From:   Philip Li <philip.li@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        Alan Maguire <alan.maguire@oracle.com>, <llvm@lists.linux.dev>,
        <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: s390x-linux-ld: kallsyms.c:undefined reference to `__tsan_memcpy'
Message-ID: <Yy3RSR9MTSXMoShd@rli9-MOBL1.ccr.corp.intel.com>
References: <202209231726.eAy8Z0ZF-lkp@intel.com>
 <Yy3PxL973jtEtEUK@dev-arch.thelio-3990X>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yy3PxL973jtEtEUK@dev-arch.thelio-3990X>
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|IA1PR11MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 899efdd7-71be-4afa-3dde-08da9d78b14c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IOlGrdRfMbKLHXUyfUY/ntjHkV/wWzokV3bLWmguY3qHviSyuBZxfrhQxDFapRamn6yk6/lgFjgnSEf7NluT0sDaL4kL9jiCSwrLPnMEXBPvptTuliCVKnpp7lhgSYXUhPCJKqzE/OmXig1nhMwRR1/bzAUX1oTDqhSgYC2cVqb5qf8t6gvHchv+dygClwptD3XS76Nld/qMXpLNexHKvXxpsmQZb/nY1+PbT0q3h9a1l1wgzyf3YQW7joJdr4uK9jBBShm6xJ78LpxSR3iKsW6Itp42xJVvz2jOZ9w+5fuuFSFyUGxNjgUF3pwpFIpUX4lrbwY/+8+qVDSpemOL/LIMQiusTinrIVtHbqs9QX/Pil66lm1fFtExGmt9szzW2RmHn5yYm1oig7tXStj3SuaPFSQPpeKyVffOIspaaQFqkST8g9FvCini+eu3ee+CdfbYoZSju4tfvLkwzWyeUo8fewg03L6TK54ahLAH17oftzexdsvmh0jjjnOSWdRZCPbJnOhCzE2L5/9t9PIMTWuMlUG731DkvPgkzwRRDHXeuddo5lGujjAad7+HeLFdC8fAQ4HES/jnmkTyhQO0P565Qon56bc/22raYP6SSKAzF55hYbIm5kkwj9ZRt8zmu9cZQY0+zIrPn70wXZQytiru3uGqDFiQ7Uz7C/0YvK3pjWVTwuHvyo4jvHR4G+bsiBA3H0uinGd4fJOMun4FLLoCtwco0X3cAFQ2TPQ3ziKXDNYBYu2BG6meEzUWWg5KCOmGmFB4JZgetRzNKpnNbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(376002)(396003)(366004)(346002)(136003)(451199015)(966005)(6512007)(26005)(8676002)(6666004)(6486002)(41300700001)(316002)(6506007)(6916009)(186003)(54906003)(2906002)(5660300002)(83380400001)(44832011)(38100700002)(66556008)(66476007)(30864003)(66946007)(86362001)(4326008)(478600001)(82960400001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0s4PUzhpOKxdSWBBHpaKJKp+qILYJAfG2TNLc3Iz4tgKWSNTDNcYXrUqaeO9?=
 =?us-ascii?Q?Y/b1NM2OY6AFMco0j+c2v/p4k5NCFUawf0b4drUd4KB3E5mSJPSFno2Rn+SL?=
 =?us-ascii?Q?500Mcxvgz1TZtj08tTUScosX+D2jGceAI+1LWhLnI37DWMwb/tniYpqpXalC?=
 =?us-ascii?Q?7J8f/805dEkzkQNG2NFzzOIWms3HIR+NEzAvW/Bt6Rf1bow+kaCNLs4sl07q?=
 =?us-ascii?Q?dcxgeMCFilLqxMFRyDjx75TjTTTf2Na3/ChKV4gQe2gJlaLK3J6kaW2TWCZM?=
 =?us-ascii?Q?sFehR728ZOuHZ/YSSxYgDE1XgNFK2Yqmy/R9FhWhzObt4XRrmo1z+d3gQCkt?=
 =?us-ascii?Q?Pj7Oh2ub1r7mMRfw/mmtYEbEmaW87NoyRD08fEMMNrYo9iCByTO4p33+hd4n?=
 =?us-ascii?Q?w+QGOTNM1KB+CYGHLj0c2P1VCXhtHreQ2ljIAnhMtZwgOIgB1Rxea/cIJjZi?=
 =?us-ascii?Q?82iOupFphOoPcrCFdhDeuPfuxEnO8i4Li5Sd8SCPbZScRo2ZLkEs7LnNla68?=
 =?us-ascii?Q?m98j7VdLBd4a7e1uhA8bLPTIKgPFO5QN+2a1qk1edzQ1TyQVHAqxi21vCzSc?=
 =?us-ascii?Q?+A6T5VTBoXTgSL13KYgyTHES06I8g1j2h8JGENYoCIw5yC9L0x5CPCeg6HZX?=
 =?us-ascii?Q?0l7IRRK8TlKKYbrAufKKkkGwLlC621iJDx3onvczmfpBCHP1kS2zgyYzVGaT?=
 =?us-ascii?Q?T3azOKFZRZX5B1OTk/TnYqgNfddtBW+QpTKfLkEGXHG/kOA6CjgqLLS+r6Hw?=
 =?us-ascii?Q?YZXF3yhV+qbEr1GPRNsaIx2fY+TEHmUGrX7Wj+4WFOKr0/pGpujoQFTfakil?=
 =?us-ascii?Q?vsQJz9tnPWLVGegCQX1xWJTuh+dmVlh065hMmMpGipCu/HbEhuM3R2v8niON?=
 =?us-ascii?Q?MEb1wRMLGZQrokk7k47vM7RnUa538zn/HqpXmJn5a/TYwSDCjn8YlGFni//F?=
 =?us-ascii?Q?JgFOg/aLmGODqlZlc33nt2o5G1nXCmjjLYHJYsmzkKeUfW714Tu2Ql38IVKs?=
 =?us-ascii?Q?kZPGd0RNfVcEqszFkMwQTa9WiMi0bXFuQUQyftmjp/vC/wMhAG9NyMJJMMz6?=
 =?us-ascii?Q?KyGjRfeAf5cmyfELZQNZM2ckrKZNJXLMqQwsxzh/7Whng93IKbBGUaC/c8WJ?=
 =?us-ascii?Q?2vzfhYBTUAFReMmoByD2drd3n7RKHRnYsQW+1MHILgvpazaBzZv+c5Dv+DTU?=
 =?us-ascii?Q?v9T6CJFx4Q7BOqNmzKibBDahf1RjfAqPI4NpNm1QYNLFv4rK9DCTc06TtHhg?=
 =?us-ascii?Q?qNBLyuXAW9rTRSWF9z10sW6MRdoVLf2SmR8nKjnFFKtj3D6e3yUletJauxej?=
 =?us-ascii?Q?fEnIOkzm9H+SK5Xxda4mzyzoqA2t1Zzu8sKzxHePNaba20F8FNQg9+S0d9FG?=
 =?us-ascii?Q?FC3ULUipLzVNLetCU3+Eeu2c32zJpdP2bQshNTT482nCQGhMVBjtoWP0Z7mG?=
 =?us-ascii?Q?U2knPDElfXxQFjjbWOXaZdRXWjkFX1FJBBpobCxpHVZcNDWO9NLeAvTBWJ6q?=
 =?us-ascii?Q?HIITZe9KcON2dAwrrGzzatc30Z5b7UAMzXcW05+GfAB5Qb3vO7+Scmo+zXSL?=
 =?us-ascii?Q?em96qU8T5eHfhjxy9v3+AOKqINpbrdsdNn18qbM04aED+GdD8DxlHi9xe8xl?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 899efdd7-71be-4afa-3dde-08da9d78b14c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 15:31:32.6140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZEOfXMR9Hw52w1nGHpAcbg2hekfs4sloxVjcP92pA2u1vIZvMVfT9Ex5CqqMKub+vS47wGiLK9qGN8bhJV47A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7175
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 08:24:52AM -0700, Nathan Chancellor wrote:
> Intel folks,
> 
> I thought these reports were not going to be delivered to kernel
> developers?
> 
> https://lore.kernel.org/Yx3HnuEDyFG0+G62@dev-arch.thelio-3990X/

Sorry about this Nathan, we will fix this asap. The configuration is
wrongly set for objtool related pattern.

> 
> Cheers,
> Nathan
> 
> On Fri, Sep 23, 2022 at 05:44:55PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   bf682942cd26ce9cd5e87f73ae099b383041e782
> > commit: 647cafa22349026a8435030e9157074ab7fe5710 bpf: add a ksym BPF iterator
> > date:   2 months ago
> > config: s390-buildonly-randconfig-r001-20220922 (https://download.01.org/0day-ci/archive/20220923/202209231726.eAy8Z0ZF-lkp@intel.com/config)
> > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install s390 cross compiling tool for clang build
> >         # apt-get install binutils-s390x-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=647cafa22349026a8435030e9157074ab7fe5710
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 647cafa22349026a8435030e9157074ab7fe5710
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    hrtimer.c:(.text+0x1e92): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/hrtimer.o: in function `hrtimer_nanosleep':
> >    hrtimer.c:(.text+0x332c): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/hrtimer.o: in function `__se_sys_nanosleep':
> >    hrtimer.c:(.text+0x350a): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/hrtimer.o:hrtimer.c:(.text+0x36be): more undefined references to `__tsan_memset' follow
> >    s390x-linux-ld: kernel/time/timekeeping.o: in function `tk_set_wall_to_mono':
> >    timekeeping.c:(.text+0x3a7e): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_update':
> >    timekeeping.c:(.text+0x3d64): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_inject_offset':
> >    timekeeping.c:(.text+0x3f64): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: timekeeping.c:(.text+0x417a): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/timekeeping.o: in function `read_persistent_clock64':
> >    timekeeping.c:(.text+0x4de2): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_resume':
> >    timekeeping.c:(.text+0x517e): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: timekeeping.c:(.text+0x5190): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/timekeeping.o:timekeeping.c:(.text+0x5432): more undefined references to `__tsan_memset' follow
> >    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_resume':
> >    timekeeping.c:(.text+0x54c8): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: timekeeping.c:(.text+0x55fc): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: timekeeping.c:(.text+0x5620): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_suspend':
> >    timekeeping.c:(.text+0x584e): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: timekeeping.c:(.text+0x58c0): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: timekeeping.c:(.text+0x5956): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: timekeeping.c:(.text+0x597c): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: timekeeping.c:(.text+0x59b0): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: timekeeping.c:(.text+0x5a5a): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_advance':
> >    timekeeping.c:(.text+0x5f92): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: timekeeping.c:(.text+0x6572): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: timekeeping.c:(.text+0x66f2): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/time/timekeeping.o: in function `getboottime64':
> >    timekeeping.c:(.text+0x67b4): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/time/timekeeping.o: in function `do_adjtimex':
> >    timekeeping.c:(.text+0x7382): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/timekeeping.o: in function `update_fast_timekeeper':
> >    timekeeping.c:(.text+0x794c): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: timekeeping.c:(.text+0x7970): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/time/timekeeping.o: in function `read_persistent_wall_and_boot_offset':
> >    timekeeping.c:(.init.text+0x46): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_init':
> >    timekeeping.c:(.init.text+0x7e): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: timekeeping.c:(.init.text+0x90): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: timekeeping.c:(.init.text+0x146): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: timekeeping.c:(.init.text+0x198): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: timekeeping.c:(.init.text+0x1b6): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: timekeeping.c:(.init.text+0x1da): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: timekeeping.c:(.init.text+0x34a): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/time/ntp.o: in function `__do_adjtimex':
> >    ntp.c:(.text+0xf8c): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: ntp.c:(.text+0xf9e): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/clocksource.o: in function `sysfs_get_uname':
> >    clocksource.c:(.text+0xdd0): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/time/clocksource.o: in function `current_clocksource_store':
> >    clocksource.c:(.text+0x10d0): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/time/clocksource.o: in function `unbind_clocksource_store':
> >    clocksource.c:(.text+0x1142): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: clocksource.c:(.text+0x118c): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/time/clocksource.o: in function `boot_override_clocksource':
> >    clocksource.c:(.init.text+0x128): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/time/jiffies.o: in function `register_refined_jiffies':
> >    jiffies.c:(.text+0x36): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/time/alarmtimer.o: in function `trace_event_raw_event_alarmtimer_suspend':
> >    alarmtimer.c:(.text+0x26a): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/alarmtimer.o: in function `trace_event_raw_event_alarm_class':
> >    alarmtimer.c:(.text+0x35a): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/alarmtimer.o: in function `get_boottime_timespec':
> >    alarmtimer.c:(.text+0x149e): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/time/alarmtimer.o: in function `alarmtimer_init':
> >    alarmtimer.c:(.init.text+0xaa): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: alarmtimer.c:(.init.text+0xd8): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/posix-stubs.o: in function `__se_sys_clock_settime':
> >    posix-stubs.c:(.text+0x56): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/posix-stubs.o: in function `do_clock_gettime':
> >    posix-stubs.c:(.text+0xfe): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/time/posix-stubs.o: in function `__se_sys_clock_gettime':
> >    posix-stubs.c:(.text+0x16c): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/posix-stubs.o: in function `__se_sys_clock_nanosleep':
> >    posix-stubs.c:(.text+0x2c4): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/clockevents.o: in function `unbind_device_store':
> >    clockevents.c:(.text+0x1808): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/tick-sched.o: in function `tick_cancel_sched_timer':
> >    tick-sched.c:(.text+0x1f62): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/test_udelay.o: in function `udelay_test_write':
> >    test_udelay.c:(.text+0x30): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/time/test_udelay.o:test_udelay.c:(.text+0x15c): more undefined references to `__tsan_memset' follow
> >    s390x-linux-ld: kernel/smp.o: in function `smp_call_function_single':
> >    smp.c:(.text+0x1084): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: smp.c:(.text+0x167a): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: smp.c:(.text+0x1bf0): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/smp.o: in function `smp_call_function_many_cond':
> >    smp.c:(.text+0x295e): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: smp.c:(.text+0x30b6): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: smp.c:(.text+0x395a): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/smp.o:smp.c:(.text+0x3fae): more undefined references to `__tsan_memset' follow
> >    s390x-linux-ld: kernel/kallsyms.o: in function `update_iter':
> >    kallsyms.c:(.text+0x1370): undefined reference to `__tsan_memcpy'
> > >> s390x-linux-ld: kallsyms.c:(.text+0x13a2): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kallsyms.c:(.text+0x148c): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/acct.o: in function `__se_sys_acct':
> >    acct.c:(.text+0x390): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/acct.o: in function `do_acct_process':
> >    acct.c:(.text+0xf50): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: acct.c:(.text+0xfd6): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: acct.c:(.text+0x10ee): undefined reference to `__tsan_memset'
> > >> s390x-linux-ld: acct.c:(.text+0x112c): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/crash_core.o: in function `append_elf_note':
> >    crash_core.c:(.text+0x72): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: crash_core.c:(.text+0xa2): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/crash_core.o: in function `final_note':
> >    crash_core.c:(.text+0xde): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/crash_core.o: in function `crash_update_vmcoreinfo_safecopy':
> >    crash_core.c:(.text+0x13a): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/crash_core.o: in function `crash_save_vmcoreinfo':
> >    crash_core.c:(.text+0x228): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/crash_core.o: in function `vmcoreinfo_append_str':
> >    crash_core.c:(.text+0x260): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: crash_core.c:(.text+0x272): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: crash_core.c:(.text+0x30c): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/crash_core.o: in function `crash_save_vmcoreinfo_init':
> >    crash_core.c:(.init.text+0x9fa): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/kexec_core.o: in function `kimage_load_segment':
> >    kexec_core.c:(.text+0x1126): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kexec_core.c:(.text+0x1272): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kexec_core.c:(.text+0x1290): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kexec_core.c:(.text+0x13bc): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kexec_core.c:(.text+0x14d6): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kexec_core.c:(.text+0x14f2): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/kexec_core.o: in function `__crash_kexec':
> >    kexec_core.c:(.text+0x15b4): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/kexec_core.o: in function `kimage_alloc_pages':
> >    kexec_core.c:(.text+0x1ca2): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/kexec.o: in function `__se_sys_kexec_load':
> >    kexec.c:(.text+0x240): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/backtracetest.o: in function `backtrace_regression_test':
> >    backtracetest.c:(.text+0x9e): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `trace_event_raw_event_cgroup_root':
> >    cgroup.c:(.text+0x778): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `trace_event_raw_event_cgroup':
> >    cgroup.c:(.text+0x8ca): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `trace_event_raw_event_cgroup_migrate':
> >    cgroup.c:(.text+0xa60): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `trace_event_raw_event_cgroup_event':
> >    cgroup.c:(.text+0xc7a): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup.o:cgroup.c:(.text+0x1c5c): more undefined references to `__tsan_memset' follow
> >    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `task_cgroup_path':
> >    cgroup.c:(.text+0x61b0): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `cgroup_migrate_finish':
> >    cgroup.c:(.text+0x67ee): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `cgroup_migrate_prepare_dst':
> >    cgroup.c:(.text+0x6d76): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `find_css_set':
> >    cgroup.c:(.text+0x6f8c): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: cgroup.c:(.text+0x6f9e): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: cgroup.c:(.text+0x7676): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: cgroup.c:(.text+0x76f4): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `cgroup_attach_task':
> >    cgroup.c:(.text+0x8ad2): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `css_task_iter_start':
> >    cgroup.c:(.text+0x9f76): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `cgroup_mkdir':
> >    cgroup.c:(.text+0xa992): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `cgroup_addrm_files':
> >    cgroup.c:(.text+0x103aa): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: cgroup.c:(.text+0x1048a): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup.o:cgroup.c:(.text+0x10654): more undefined references to `__tsan_memset' follow
> >    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `features_show':
> >    cgroup.c:(.text+0x17c54): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `cgroup_init_subsys':
> >    cgroup.c:(.init.text+0x246): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup.o: in function `cgroup_init':
> >    cgroup.c:(.init.text+0xc48): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup-v1.o: in function `cgroup_transfer_tasks':
> >    cgroup-v1.c:(.text+0x1c4): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: cgroup-v1.c:(.text+0x1d6): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup-v1.o: in function `cgroup_pidlist_start':
> >    cgroup-v1.c:(.text+0x930): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup-v1.o: in function `cgroup_release_agent_write':
> >    cgroup-v1.c:(.text+0x142a): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/cgroup/cgroup-v1.o: in function `cgroupstats_build':
> >    cgroup-v1.c:(.text+0x1588): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup-v1.o: in function `cgroup1_release_agent':
> >    cgroup-v1.c:(.text+0x1d60): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: cgroup-v1.c:(.text+0x1d72): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: cgroup-v1.c:(.text+0x1e7a): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/cgroup/cgroup-v1.o: in function `cgroup1_parse_param':
> >    cgroup-v1.c:(.text+0x1fa0): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/cgroup-v1.o: in function `cgroup1_reconfigure':
> >    cgroup-v1.c:(.text+0x2640): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/cgroup/freezer.o: in function `cgroup_freeze':
> >    freezer.c:(.text+0x123c): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/legacy_freezer.o: in function `freezer_read':
> >    legacy_freezer.c:(.text+0x956): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/cgroup/legacy_freezer.o: in function `freezer_apply_state':
> >    legacy_freezer.c:(.text+0x1834): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: legacy_freezer.c:(.text+0x18da): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/kheaders.o: in function `ikheaders_read':
> >    kheaders.c:(.text+0x3a): undefined reference to `__tsan_memcpy'
> >    s390x-linux-ld: kernel/stop_machine.o: in function `stop_one_cpu':
> >    stop_machine.c:(.text+0x70): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: stop_machine.c:(.text+0x82): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/stop_machine.o: in function `cpu_stop_init_done':
> >    stop_machine.c:(.text+0x110): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: kernel/stop_machine.o: in function `stop_two_cpus':
> >    stop_machine.c:(.text+0x334): undefined reference to `__tsan_memset'
> >    s390x-linux-ld: stop_machine.c:(.text+0x3b8): undefined reference to `__tsan_memset'
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
> > 
