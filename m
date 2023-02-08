Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B5F68E8BE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjBHHOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHHON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:14:13 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E125422A03
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675840451; x=1707376451;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VziWqBKQjF9YNhklfCYcGuuiqh80GI12R2R38X/YOQc=;
  b=kfQVnsLQIqjzmUbge2/VeVtiJLhLGgqWBgHAVq/7v/4IVp4buTR3FqZ6
   FaHcZUtmv3ffo0z1T7tfTr1IYSoPErEICB2PP27wqYOtPU2p+mfDLfWRX
   IXxOTmN/1e9on6KY1MqPP+R/Z1GkdvHs3QHohbe08lVIVk+8PznrFuNTl
   ZQ6twiijKzp2MTRVkeiDnpQr9CPjrTWFC0lFtapQPKzmbt9NatCBCOZqz
   5cppMwVstRVqj5wYHRN3igtk/IT/WJE1bfqh8MuwEc8S6TqaEkgpUxYIW
   qllzltAu1bM6B9Q97gWQE2ZgCALwt6Hpl7QzlhEH98xyi7WjtpYfgtH+7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="317729301"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="317729301"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 23:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="699544681"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="699544681"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2023 23:14:02 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 23:14:02 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 23:14:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 23:14:01 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 23:14:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJccnqiI9rOLj5jPMNvDIR+RkBxPvPLWHHc2SwZvNS0RNLkNveb+wu/I0ylpyEtVig8+fheppNbUvlDIOgYHj9oXkDaObNSBTgfeo5+DxSHkPQimgGuHdAGXa/HRaVUziCXxrtMT1+4TtuSaffz/JSnEq+8y/OvW+bpE9I1N/1ZLEsBNX/paA35ANExW4O4We0kCGP8zfw3kUWrjkmhkUltBHOe8SUPMNDnU0T0VlUsDrJ2gGh3d//cd0Uhpa7OSZ1uci+9kSWyAsZyLpR+BWIb9mroqgOuVZlBCfTxN2/SM7Fuhm53jZ5UJ7L49QUaerG+CBG3XDTGrBk+PZpNKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8FvAszS2z0ykYNnu1GFYpIWKunrVh0POKOuMkT/DuA=;
 b=NLhUViEXl+5SnTzpYJVQ4icB6igIwuq6qDExTmushi+xzE6DJ+j20LLyMfiSKWv6GgGXq93Bmpt/6uz6FeZUf4sPihDGgJMAJzree58Kq0ihaA+JFZCwfBR2CLSIoSDHW7xVCFlfDX3iZWaMPiQyns1pxglAKIfPgibfn57ZLTDfdIPpZ2GmwMFqM8TOJNBIpC6svQH1HfYSuvroo8hhj1XWs7nYW2+g7pJ9UrSC3LyQ01S+PL+bN4glPynNePvFfDY7EeILeIFL1ZVYPMEkFvfUVzhhDLiFsNkyV2iAa2YO2Kr805NhVRe/fffBI7x2Ms6AZG0eDGLNLmf/2rokfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) by
 DM4PR11MB5519.namprd11.prod.outlook.com (2603:10b6:5:39e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.36; Wed, 8 Feb 2023 07:13:53 +0000
Received: from DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::390e:494c:f177:5ca3]) by DS0PR11MB6397.namprd11.prod.outlook.com
 ([fe80::390e:494c:f177:5ca3%3]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 07:13:53 +0000
Date:   Wed, 8 Feb 2023 15:11:21 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: arch/x86/kvm/mmu/paging_tmpl.h:106:24: sparse: sparse: cast
 truncates bits from constant value (ffffffffff000 becomes fffff000)
Message-ID: <Y+NLGY7ztExSFGpi@yujie-X299>
References: <202302070638.iEBPQ4gL-lkp@intel.com>
 <Y+Lf8w9h29cRmcJG@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+Lf8w9h29cRmcJG@google.com>
X-ClientProxiedBy: SG2PR04CA0175.apcprd04.prod.outlook.com
 (2603:1096:4:14::13) To DS0PR11MB6397.namprd11.prod.outlook.com
 (2603:10b6:8:ca::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6397:EE_|DM4PR11MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: 0002113d-552d-4678-546c-08db09a408d4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m5aALy0oVo6EE+8Z5n7WvyXl1gxhtTWu61Hxh4UaQ60pJTyJ4Svm9HIC9hsTAvto0Dbepg5KQBRb9f6pYozm6TO1PSFGgj4TbchfFuzkeBgysuMeAjPplrUoaAF52J7VyjWDJCFoCRTQTS2uHvLRPLE7fxFZaQsb0IQAlS/MCSJmS0UauGyHuHO2+T+twkACLISUOUwTwM0sIA3ysG2xkSrP8K9M9hzN60kfwEG+uuNKakwFd4T8ZgUdZgGLp79jGEL1sxyeCT3mdUHzrpbWtx0l5tXQo+6/cH22dYYpiA4tjvZam4ayvsWPfLGBmRcgXIQptYxGhlb6jOpuLTsSGE2hFL2gkXEYE4PqcMYC9M0hx0n4b4FhtS8b/GETOvs5N34UZM+TZidFiN/f8I3Ak7wmnExG44oXeecRa1jAD+OYk4lBxOD+Y0swkZqQ9+2ins2wJ71RNfycLfTpmJ6XZYfBqnv6EHT6ptw8ZZ3xfbeYMPnhWjuYNrtXX3atj+EgeqDuPSkgt2Uze8z03SluzNByuhawrjwJltPui3e7qtdRdspECa0i34yxkVZ5KQHDbdJpa+2J0TNeMVwy1OhZ9uDvpFLeIRFtEtadPsyXid5FIxZtRvxPjuWkk1xGc5YbwL8njv+ft9eTObsCg4l6T6adkE9VCnm2djA7bSvOkXyxscO4zjjueF1uOk81urnDJwXjOb6D6zidQzvOe8Ia+r1Ox2Cyn1mv/ynw/UONyn1c3KR0GnfBlrA7NOk3gyF0t8elCbigz2QqSdv1bxKQpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6397.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199018)(316002)(2906002)(38100700002)(82960400001)(83380400001)(4326008)(41300700001)(8936002)(8676002)(6916009)(66476007)(66556008)(66946007)(5660300002)(44832011)(966005)(9686003)(6486002)(6506007)(26005)(478600001)(6666004)(6512007)(186003)(33716001)(86362001)(54906003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Qb10Qc/XESwlHzBQHElupZNWPlbHiBcBI4vEHRcI8YSjIEr48RzKcJYAFZ3?=
 =?us-ascii?Q?9P4ilAWd7waTf5nhWJ5YteyMwhPJRhy+EFVjz+uKQ1CsaeCSGxu1411jCbLw?=
 =?us-ascii?Q?vfGENDzvzenf/xUhCdJkIyHqBNDnmWUQtMZkYYNYcKFWdMKdIKShZBTw5y07?=
 =?us-ascii?Q?4LrR3AJc03Uav6zmfsrNCOpFp1BnbFV/vFG3V+HFKzZHoEZl+Yi2S9MLyXCT?=
 =?us-ascii?Q?8XG+CXtxNlkzriRlSYeAJBPA/JGvqxM7iQ1RrUPDUV+UqDsgLqvIy3i7oOZa?=
 =?us-ascii?Q?ZkpezoFosFfD1fLsjQo2nrHWwYiB/utpLYpFhm9i1cqxdV1yp6EK0e8YDrBB?=
 =?us-ascii?Q?cIpesz+klD4672gK0MIsCBunby+inZDWBN+5h7kw63sF0cBWVffQRwKvqM+J?=
 =?us-ascii?Q?C6I0qEV0I+NhJwrpUadRUiOvvl+5I5qgQOYyYWZBeARw42itX4x/VS23h/9s?=
 =?us-ascii?Q?Xme+MWv/o6r5Pq0IbpXJp/fvsbbvxHk+KwI4oMb7DBWM67yXYA4A+/SaKG0H?=
 =?us-ascii?Q?Vzt8K9+ylhr4W1QzqXBo8B/jtqx9osnSHXJW1BBDdp3TQRDet05LomK16Zqy?=
 =?us-ascii?Q?ano8rL6uht53ptqhxfOsMcwe55mDAKXMBakh4vh1nup9Lfzb0oYHNMlPdEe8?=
 =?us-ascii?Q?x5yNRNlHnKKjjhFldUvAH9xudTrXozFIoI1KZgjZ4L33ku7t95z47DEYkRnI?=
 =?us-ascii?Q?LZWFq/q7RZLCAqQNM43G60laq2zQq5DXBDCIIi6m0dL4apvTtprTfEFEyBf7?=
 =?us-ascii?Q?ETAi9P9UN69RDLXm6Igqt0ARGsMa1mGRoc29uwNvJ25ULFGFPNGlSjkYyzi4?=
 =?us-ascii?Q?2U3uoth4VDyF0Z3ra1VfuKG0ZUT3zvb0kIRaFsr3W4b0NmEI9iLuGt87OHzH?=
 =?us-ascii?Q?ImR01mgNVXadxzkHmrbJN731AtjwOCH1tP+1NmiHEKl5yVuco9SxRqz8auh9?=
 =?us-ascii?Q?GmrvkiD07+uahd/3cFp02u+eGf1qX6E32706W+hrelXdxBe+24IYW+rjBW/m?=
 =?us-ascii?Q?Yf6m0uP5lMW4XVUbwxKJpVh23nFniS4pIImNtY7wKvrJ28ebPYabDp4UPCtf?=
 =?us-ascii?Q?spcBSxiCuwd5/aO4pwYgIRdNWxZ3nEEbp3fP3EzPeSTSJhycoBr8V1oXHqI9?=
 =?us-ascii?Q?dZes4GBwWRfOz34S0TOPB6nscIzrkuHpkJHMkMYJMBTEMUWDvyVjX2P7DgRx?=
 =?us-ascii?Q?9A9T908qiJ1aUSWWIhsVQ6WVXQ129Z445MKT0duiaNCm2zdOPSPanTQ/HNuj?=
 =?us-ascii?Q?Fl5rihUl2+DSoW+sou4HyCmDYTra8uvXrWlUENnFtV9Pml9hea4WH7xp9TF6?=
 =?us-ascii?Q?0/+oXwQV9OKIexM2qd41nq0OVJFh6/h0GZgatuoUwkJV9kQwr/lP8QAB6CNb?=
 =?us-ascii?Q?q2HwNGC7MnDzJnvWEUtrcUuVlM00YC3CX2/Mpf+1F0k34EIFCGRIa41Qfa2K?=
 =?us-ascii?Q?LZILhzlpHbAAjB4uMB9TOt8vj2CNhh4kIBSGiRU5k4wEln06JSsWvRQTZEff?=
 =?us-ascii?Q?RtmMVlGSZwBX/TneOj9r/G1eJ2MEB9YhPBNVjOYZczbD69nQvfRFX0dDMZ5B?=
 =?us-ascii?Q?orQz0wvHkD40Ts3Aa+TlqH5+BKEgBvoIhOPN+drb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0002113d-552d-4678-546c-08db09a408d4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6397.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 07:13:53.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nM8Gb+5cZ4SNjS19h/he9qQ0YFo0GqHIBuhnfO4IBEURUIA5nuX6cSHoBhy10NgoAx5gYiu1IFoP+Ji+3dIW0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5519
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On Tue, Feb 07, 2023 at 11:34:11PM +0000, Sean Christopherson wrote:
> On Tue, Feb 07, 2023, kernel test robot wrote:
> > Hi Sean,
> > 
> > FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> Is there a way to mark this as "working as intended"?  The truncation is intentional.
> I've been ignoring the reports, but they just keep coming :-)

Sorry for reporting this warning repeatedly. We've added it to the
ignore list for this particular commit.

Best Regards,
Yujie

> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   d2d11f342b179f1894a901f143ec7c008caba43e
> > commit: 70e41c31bc7776b262cd9f524df3dfc2b5869a0a KVM: x86/mmu: Use common logic for computing the 32/64-bit base PA mask
> > date:   8 months ago
> > config: x86_64-randconfig-s023-20230206 (https://download.01.org/0day-ci/archive/20230207/202302070638.iEBPQ4gL-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.4-39-gce1a6720-dirty
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=70e41c31bc7776b262cd9f524df3dfc2b5869a0a
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 70e41c31bc7776b262cd9f524df3dfc2b5869a0a
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
> >         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kvm/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > 
> > sparse warnings: (new ones prefixed by >>)
> >    arch/x86/kvm/mmu/mmu.c:610:9: sparse: sparse: context imbalance in 'walk_shadow_page_lockless_begin' - different lock contexts for basic block
> >    arch/x86/kvm/mmu/mmu.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, arch/x86/kvm/irq.h):
> >    include/linux/rcupdate.h:726:9: sparse: sparse: context imbalance in 'walk_shadow_page_lockless_end' - unexpected unlock
> >    arch/x86/kvm/mmu/mmu.c:2550:9: sparse: sparse: context imbalance in 'mmu_try_to_unsync_pages' - different lock contexts for basic block
> >    arch/x86/kvm/mmu/mmu.c: note: in included file:
> > >> arch/x86/kvm/mmu/paging_tmpl.h:106:24: sparse: sparse: cast truncates bits from constant value (ffffffffff000 becomes fffff000)
> >    arch/x86/kvm/mmu/paging_tmpl.h:426:24: sparse: sparse: cast truncates bits from constant value (ffffffffff000 becomes fffff000)
> >    arch/x86/kvm/mmu/mmu.c:4618:57: sparse: sparse: cast truncates bits from constant value (ffffff33 becomes 33)
> >    arch/x86/kvm/mmu/mmu.c:4620:56: sparse: sparse: cast truncates bits from constant value (ffffff0f becomes f)
> >    arch/x86/kvm/mmu/mmu.c:4622:57: sparse: sparse: cast truncates bits from constant value (ffffff55 becomes 55)
> > 
> > vim +106 arch/x86/kvm/mmu/paging_tmpl.h
> > 
> > b3fcdb04a98035 arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2022-06-14  103  
> > e04da980c35d75 arch/x86/kvm/paging_tmpl.h     Joerg Roedel        2009-07-27  104  static gfn_t gpte_to_gfn_lvl(pt_element_t gpte, int lvl)
> > 5fb07ddb183eb4 drivers/kvm/paging_tmpl.h      Avi Kivity          2007-11-21  105  {
> > e04da980c35d75 arch/x86/kvm/paging_tmpl.h     Joerg Roedel        2009-07-27 @106  	return (gpte & PT_LVL_ADDR_MASK(lvl)) >> PAGE_SHIFT;
> > 5fb07ddb183eb4 drivers/kvm/paging_tmpl.h      Avi Kivity          2007-11-21  107  }
> > 5fb07ddb183eb4 drivers/kvm/paging_tmpl.h      Avi Kivity          2007-11-21  108  
> > 
> > :::::: The code at line 106 was first introduced by commit
> > :::::: e04da980c35d75fa050ba4009ad99025432d8d7d KVM: MMU: make page walker aware of mapping levels
> > 
> > :::::: TO: Joerg Roedel <joerg.roedel@amd.com>
> > :::::: CC: Avi Kivity <avi@redhat.com>
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests
> 
