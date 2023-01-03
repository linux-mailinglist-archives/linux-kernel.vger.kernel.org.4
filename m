Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A4365C118
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbjACNrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbjACNrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:47:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237349FFE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 05:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672753628; x=1704289628;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TObLdbmkyIldCQqVsuYGAmTs0lfS2R8MKt3jsZ1YYFs=;
  b=CrgaFSfDyvHhnbyCuXUdj/FsmtOTo6I9r1qDe/l1k0H2J8AEJ3fM/JP+
   iKSGv4GkHSw2kmmlW3t/+IYfv5Vm8pQuUIIbvbxMRI1MOeC/40SB5EQcw
   MXu24RYBOXShYQRuw6ZXM1sMzLrvj/mhuN3sd4KBy1YoASCqQYsZETPuS
   goTBs20pxoa3FkbvdUPh4Pw0ng9u/2CGWvAYMK/X/yGjInabuzoVMAA2u
   7/711Juczb3Q+9mzxmTn3j0z7NuGt6FdIelWfuVG1EwpsM+1AFArVYME8
   2DAjA3DTiaTiMAWSSbatPOgZoUnGOAyCDOAWqS8yjDWCiTkCJOtpeq9/1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="386097374"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="386097374"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 05:47:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="983574476"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="983574476"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jan 2023 05:47:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 05:47:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 05:47:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 05:47:06 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 05:46:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDy/gIsiCllFRxGhQjkQ5ban9bwi8y4qwS7bKwCMl0WmWrWwrc9AlpCE7UB7chQk39U0dBQp2ibSRY5UAYTesJSWURIkdY7E9reoclLCgFwKnlR73fpEBz5oYgJMrRzZ6vEo8lMiS9+sQB7iR8W79SHTMw1DjGNPDs5HV3ycenBuZ7hVPT14jXffikF+vainoX3rFzcubtOK846Qfe7ZxPPq5uar46IG9+ZFYd97nduvJYOo+RKyl7iBqxZYu9I4KahjzjmQEJHq9LS9vomGDiIDqgN0IddHYcUMXdZZrzZEVCA/17I3A4sjCtUEHzvW0tDBQw5Oy1+1IgerQq05kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfQkpq7y4ail93l7K6D0Yotp6pTsKNYhM67HXxqKGX4=;
 b=QvMLXhi9UsdoOoJ/iALR26WGeTmmJNoI/xZCCJ1+k/jb5Lv3wJ0hViAu+NuXqvLnfElaUVN+Y2ZhbTscl/W4EY4C8xnbMD8Ms9VF5x90z9dBiqH2t2a9CmdF2Qq6i2YHKyU9XhwnLKVK0Vo/sNWxJaomZm1JlYlwpvKINt4YSv7yeOR2v4qitUJj2wI4P6qZ9SwfSV6SXJR8uRygg+rUX2osyDhmYM0cGSv69qDtRb67wvhF+IYqSxeCnGRhOws3OKnr7BUoTWk7E9mUs/xdlqlT4JB536Nnnb8dJkCV+dhr4j/kDFmRffD5GzRIQwBN7VoIjYCoEc73CZEY4te5Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM8PR11MB5672.namprd11.prod.outlook.com (2603:10b6:8:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 13:46:42 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::fce6:d181:2417:f241]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::fce6:d181:2417:f241%8]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 13:46:42 +0000
Date:   Tue, 3 Jan 2023 21:46:33 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Message-ID: <Y7Qxucg5le7WOzr7@xsang-OptiPlex-9020>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
 <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM8PR11MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 05813f9c-d90c-42f1-3fad-08daed90f1fa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q06gT4XS13XlJkxVd/U2HrYLndwgXrkzTjUuzMnfRBS+HUQCHbyyimW1c4OP3pJG3fg6sn0zcwVWIDQUKlbEpnXZtCsuqrjp0SR9CtlNKRoVMBuM+KNyWlFyhWuMUcdX8iLCyVoTv8M8/SqNPXn++Dr32KJvFZe9hgXSul5QNgFvlGppKRHKJK6KqTzlvZatY8jO+DL/hJilWIJOI95hrf03Mb21hysHkhJLO0NgfI1wzXGNWQxwWsWq1/yA/kwMQWLUZpbJqoOt0to5orIyPngsZxD6BMqV81pj/Gw+EhMlcG5zC/AjbX7AC8dnkgbyz0ZJsmmL/ki+wp+kCVeWaTwof6w++g0ozQmB4dyw13bZz8YUUJSl56/U28wvId8KEdlWSuvRzSExUvOi4cVcekUfDchQ7Zkks8RY8VumlsAAghAK2a71dj3KHJWeTPtS0Cat5j7imjlmKTPezocymrLLAzV2tP8KC+FliaV7QRn963LsUgpJcSezitaOf2A2kOAL4ELrA7ODXQonZvLHyBsV4y9zDyfR273IWb6VvJPFLnYzWwdQ/jlpxlA+J78ONA0uqa/HXlaXPQPUOZxvWE7NXmo1APJOFGZRh08Rdx02KXrZZBLxnxmA78g68WFXI/ABcbAwPR/Bl5H5P27OkrTn/Ftc8AOlNtZbMLS3lCm6LeKrLGcvYUqJJBZ5IYhtAylfH46Oxfj+ulLtX0g66Cd2bTfDU/r6LG7sF/0wdPdjj09Cr+/7moyeN5yfwa76KQXP+N60v9JLcsrFFEGLzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199015)(5660300002)(2906002)(8936002)(44832011)(30864003)(8676002)(4326008)(41300700001)(316002)(66556008)(66476007)(66946007)(6916009)(54906003)(478600001)(45080400002)(966005)(6486002)(53546011)(6666004)(33716001)(26005)(6512007)(9686003)(83380400001)(186003)(82960400001)(38100700002)(6506007)(86362001)(22166006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BZxz+BCx58kwK71oUXq3knbqqxJIWgGNHYaqmQSNcqO6VoQ2rTxY6RcHC9Ks?=
 =?us-ascii?Q?YLZdO8dnYSP1gfPWsncuAh/0nP5iOh93F7sW90NRS+9+dSKS0CFB3kamPDvT?=
 =?us-ascii?Q?X6wBuGI0xs5XAmqbWoukZ+++pMzLyjFyGrvW4ibeHBi+GHd5q3ycv9jGaABZ?=
 =?us-ascii?Q?IpL8p+NI3vawvTRjDB2fls6OEWdltNZLrRv9baoqdKMcNsyhr9eMQDhDlA5n?=
 =?us-ascii?Q?ZeB1FE1pB+djubdxHDWT2P97xqu9Nafy/XqgHMutfauesFVBJSYY4DWgjMuo?=
 =?us-ascii?Q?AZPD3aXxJORMEq+pLvJAxkX4qAgo6mxmsa7RG7u8MAWOyCdE0TQYu0cnu8YE?=
 =?us-ascii?Q?OrrfrYgVRn/W9u0NQJ8X2Kqoh1/P/1NInvu+YwFGScPQ8f/LMXO3B0yaUD0d?=
 =?us-ascii?Q?p3aOmkRt/xZn+c2nPKgFyPyttwybn5I1nyyLfAFVpMFMYa22gjy3ZJ3wDE4e?=
 =?us-ascii?Q?jsnHznYbW9LLK/8/GmRSJjbWAOb/gFnonOSsnQJMKv9n9vhd9jnUmUyn+6uu?=
 =?us-ascii?Q?cOL+bsxp2Dyni9UEWu7ESK3mnE853k6LeEqPU9ey4NI3nqSAPpxrfsjcXwaO?=
 =?us-ascii?Q?1lNUaXK1wtXNeMGeq5v7VGgyaZy8jDcXa2ydnibzStBUSy9NiLNI4Tl6tOIE?=
 =?us-ascii?Q?5XjkgiIceLd1FGmGrTuSFWe8ry32bN8ZyQ5krXSDxdzytqvL/6ZOzQruWgva?=
 =?us-ascii?Q?A9MUYEbTfyc32t2NCcSHUaueB3D1OGYKP3Fk9D9PstRvy9a4I7/KuwGeFRch?=
 =?us-ascii?Q?IFqsZHi3ycKWkIRy2T+whEBw7+F6qCIBs7/8VpNG0eL23jebgIdBaV5LFMLS?=
 =?us-ascii?Q?EEhLmb6CbNArBAsDfPHyuO0cEqOL8uDXszgefb0a1KVKLG1QFDUitmKWoHmH?=
 =?us-ascii?Q?vHTWl5wra6pBq5A6X2HaDPD0m0Ex4k2ip4wlkp50AAWSjcJtFQ3muHMZNAxH?=
 =?us-ascii?Q?4hUj6zUQDuzC/hjqxf7aRtY5PtYKnYEc1Qllv4jxf/AIv02asVzBLiMUUPOi?=
 =?us-ascii?Q?mmp0nQzB1UXLkXmEy34rGarixgq1+cY6nRctvDEqKItvIL55EE39Q24RIO1E?=
 =?us-ascii?Q?IWRJ5gS2AJnPvYK74QVlnsKVIPSoT+4xqjc0UPlz9W7GDDlz90z+T3Pr0+dr?=
 =?us-ascii?Q?K/WdLLWrFSu5vYi7y6qEhLa6EghIguTObaNQKbFek/NRaPVzqJtIOBvwd9Hn?=
 =?us-ascii?Q?PRU3KU84h2U9aBdbv2YFTqrWzNwa+50kfSefrKbqF9AgBMyjjvqADY6POvNx?=
 =?us-ascii?Q?I8uUpgWOSD0yFB/KvM1TDDi2dUgBJdBiuwfLcXqjHCaERFGGoFbs5B2Hvz1X?=
 =?us-ascii?Q?2cIvur4aLI4fmjIMPjj3sePPtefMEL2lUiJxT0H9R7O0I3BqnN8F4cAzkHFT?=
 =?us-ascii?Q?Mc2gUmpxVJ5TqtRK/T7txmDupo3kEG+vmSPHCGGCbAWwyUIDW7vzK5GUubO/?=
 =?us-ascii?Q?JH5385Kans4J/0kDL8oRnqxfms6C+EWHbmsXaIpwgxfJ/skicgGYx8FAPUac?=
 =?us-ascii?Q?/ivQSl9gvcVywh4Z0DKnbyQdl2HCgoohlanAbzGfWez9+aZOTPwM5M0UFNvy?=
 =?us-ascii?Q?DY6QzTFpIBeeg+Kt125J41tJFwH6uF/7JXZT3KIb9IDQclGM/p/+b0atEoRg?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05813f9c-d90c-42f1-3fad-08daed90f1fa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 13:46:42.4016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95ckZNsFenNgoIQoAH8OLWZkakmz2npCdnDlpFprCIx9qxyItcOARk+hYhIJx+jXsbmCPaYcnsTSzIr/RvCDWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5672
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

On Tue, Jan 03, 2023 at 11:42:11AM +0100, Vlastimil Babka wrote:
> On 12/31/22 16:26, kernel test robot wrote:
> > 
> > Greeting,
> > 
> > FYI, we noticed kernel_BUG_at_include/linux/mm.h due to commit (built with gcc-11):
> > 
> > commit: 0af8489b0216fa1dd83e264bef8063f2632633d7 ("mm, slub: remove percpu slabs with CONFIG_SLUB_TINY")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on linux-next/master c76083fac3bae1a87ae3d005b5cb1cbc761e31d5]
> > 
> > in testcase: rcutorture
> > version: 
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	test: default
> > 	torture_type: tasks-tracing
> > 
> > test-description: rcutorture is rcutorture kernel module load/unload test.
> > test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> > 
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> Looking at the full dump:
> 
> > [   25.780445][  T214] page:e660911a refcount:0 mapcount:0 mapping:00000000 index:0xedaeef00 pfn:0x2daee
> > [   25.781618][  T214] page:0946d53a refcount:0 mapcount:0 mapping:00000000 index:0x0 pfn:0x2daec
> 
> OK, so we started dumping one page but then immediately went dumping
> another. This means page_dump() tripped on itself.
> 
> Why did we dump the first page? The callback is
> 
> > [   25.812675][  T214]  dump_page+0x2a/0xc0
> > [   25.813025][  T214]  ? _raw_spin_lock_irqsave+0x16/0x30
> > [   25.813492][  T214]  folio_flags+0x23/0x70
> > [   25.813945][  T214]  get_partial_node+0x89/0x290
> 
> We walk the partial list, and for a struct slab we check
> pfmemalloc_match() thus slab_test_pfmemalloc() thus folio_test_active(),
> which will do folio_flags(). That has two VM_BUG... checks but one requires
> n > 0 which wouldn't be true here, so it has to be:
> VM_BUG_ON_PGFLAGS(PageTail(page), page);
> 
> So page with pfn pfn:0x2daee is supposed to be a folio head of order 0 or
> order 1 (probably), not larger due to the pfn. But it's a tail page, oops.
> We start dumping it, but also create a folio of that, and then trip on
> !folio_test_large(folio), because we try to evaluate folio_entire_mapcount()
> in __dump_page(), which has that check.
> So we start dumping the folio page, and that has pfn:0x2daec. Which means
> the page pfn:0x2daee was tail with compound_head pointing to 0x2daec. So
> 0x2daec was order-2 at some point, with pfn:0x2daee being a 3rd tail page of 4.
> 
> > [   25.782360][  T214] flags: 0x0(zone=0)
> > [   25.782705][  T214] raw: 00000000 e764d494 e6f205b4 00000000 00000000 00020000 ffffffff 00000000
> > [   25.783445][  T214] raw: 00000000 00000000
> > [   25.783809][  T214] page dumped because: VM_BUG_ON_FOLIO(!folio_test_large(folio))
> > [   25.784455][  T214] page_owner tracks the page as freed
> > [   25.785164][  T214] page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 208, tgid 208 (systemd-udevd), ts 25780391126, free_ts 25780421356
> > [   25.786859][  T214]  post_alloc_hook+0x1fa/0x280
> > [   25.787266][  T214]  get_page_from_freelist+0x226/0x310
> > [   25.787723][  T214]  __alloc_pages+0xdd/0x360
> > [   25.788114][  T214]  alloc_slab_page+0x12d/0x200
> > [   25.788517][  T214]  allocate_slab+0x6a/0x350
> > [   25.788900][  T214]  new_slab+0x48/0xc0
> > [   25.789258][  T214]  __slab_alloc_node+0xfb/0x270
> > [   25.789749][  T214]  kmem_cache_alloc+0x8f/0x4e0
> > [   25.790154][  T214]  getname_flags+0x33/0x2f0
> > [   25.790538][  T214]  getname+0x1a/0x30
> > [   25.790881][  T214]  do_sys_openat2+0xa5/0x1f0
> > [   25.791278][  T214]  do_sys_open+0x8e/0xe0
> > [   25.791636][  T214]  __ia32_sys_openat+0x2b/0x40
> > [   25.792040][  T214]  __do_fast_syscall_32+0x72/0xd0
> > [   25.792486][  T214]  do_fast_syscall_32+0x32/0x70
> > [   25.792899][  T214]  do_SYSENTER_32+0x15/0x20
> > [   25.793307][  T214] page last free stack trace:
> > [   25.793701][  T214]  free_pcp_prepare+0x34f/0x940
> > [   25.794123][  T214]  free_unref_page_prepare+0x29/0x210
> > [   25.794577][  T214]  free_unref_page+0x3a/0x3b0
> > [   25.794988][  T214]  __free_pages+0x187/0x1f0
> > [   25.795378][  T214]  __free_slab+0x1fd/0x350
> > [   25.795842][  T214]  free_slab+0x22/0x70
> > [   25.796233][  T214]  free_to_partial_list+0x125/0x260
> > [   25.796761][  T214]  do_slab_free+0x30/0x70
> > [   25.801249][  T214]  kmem_cache_free+0x171/0x1e0
> > [   25.801686][  T214]  putname+0x9f/0xf0
> > [   25.802023][  T214]  do_sys_openat2+0xe2/0x1f0
> > [   25.802411][  T214]  do_sys_open+0x8e/0xe0
> > [   25.802781][  T214]  __ia32_sys_openat+0x2b/0x40
> > [   25.803192][  T214]  __do_fast_syscall_32+0x72/0xd0
> > [   25.803613][  T214]  do_fast_syscall_32+0x32/0x70
> > [   25.804027][  T214]  do_SYSENTER_32+0x15/0x20
> 
> Yet the page owner info tells us, 0x2daee was most recently used as order-1,
> and now it seems to be (based on the raw struct page dump) sitting on a pcplist.
> 
> So the events leading up to this could be something like:
> 
> - 0x2daee is order-1 slab folio of the inode cache, sitting on the partial list
> - despite being on partial list, it's freed ???
> - somebody else allocates order-2 page 0x2daec and uses it for whatever,
> then frees it
> - 0x2daec is reallocated as order-1 slab from names_cache, then freed
> - we try to allocate from the slab page 0x2daee and trip on the PageTail
> 
> Except, the freeing of order-2 page would have reset the PageTail and
> compound_head in 0x2daec, so this is even more complicated or involves some
> extra race?

FYI, we ran tests more up to 500 times, then saw different issues but rate is
actually low

56d5a2b9ba85a390 0af8489b0216fa1dd83e264bef8
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :500         12%          61:500   dmesg.invalid_opcode:#[##]
           :500          3%          14:500   dmesg.kernel_BUG_at_include/linux/mm.h
           :500          3%          17:500   dmesg.kernel_BUG_at_include/linux/page-flags.h
           :500          5%          26:500   dmesg.kernel_BUG_at_lib/list_debug.c
           :500          0%           2:500   dmesg.kernel_BUG_at_mm/page_alloc.c
           :500          0%           2:500   dmesg.kernel_BUG_at_mm/usercopy.c

> 
> In any case, this is something a debug_pagealloc kernel could have a chance
> of catching earlier. Would it be possible to enable CONFIG_DEBUG_PAGEALLOC
> and DEBUG_PAGEALLOC_ENABLE_DEFAULT additionally to the rest of the
> configuration, and repeat the test?

ok, we are starting to test by these 2 additional configs now.

> 
> Separately we should also make the __dump_page() more resilient.
> 
> Thanks,
> Vlastimil
> 
> > [   25.804432][  T214] ------------[ cut here ]------------
> > [   25.804917][  T214] kernel BUG at include/linux/mm.h:825!
> > [   25.805402][  T214] invalid opcode: 0000 [#1] SMP
> > [   25.805820][  T214] CPU: 0 PID: 214 Comm: udevadm Tainted: G S                 6.1.0-rc2-00014-g0af8489b0216 #2 1c4d7707ec0ce574ed62a77e82a8580202758048
> > [   25.806944][  T214] EIP: __dump_page.cold+0x282/0x369
> > [   25.807376][  T214] Code: ff ff 83 05 e8 5d bb c5 01 ba 4c c4 2f c4 89 f8 83 15 ec 5d bb c5 00 e8 f2 92 ed fd 83 05 f8 5d bb c5 01 83 15 fc 5d bb c5 00 <0f> 0b 83 05 00 5e bb c5 01 b8 ac 85 a3 c4 83 15 04 5e bb c5 00 e8
> > [   25.808960][  T214] EAX: 00000000 EBX: e764d530 ECX: 00000003 EDX: 4108888f
> > [   25.809578][  T214] ESI: e764d4e0 EDI: e764d4e0 EBP: ed89db3c ESP: ed89db00
> > [   25.810168][  T214] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210046
> > [   25.810803][  T214] CR0: 80050033 CR2: 00616abc CR3: 2d878000 CR4: 000406d0
> > [   25.811407][  T214] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > [   25.811999][  T214] DR6: fffe0ff0 DR7: 00000400
> > [   25.812390][  T214] Call Trace:
> > [   25.812675][  T214]  dump_page+0x2a/0xc0
> > [   25.813025][  T214]  ? _raw_spin_lock_irqsave+0x16/0x30
> > [   25.813492][  T214]  folio_flags+0x23/0x70
> > [   25.813945][  T214]  get_partial_node+0x89/0x290
> > [   25.814357][  T214]  __slab_alloc_node+0xbb/0x270
> > [   25.814860][  T214]  kmem_cache_alloc_lru+0x8d/0x4e0
> > [   25.815289][  T214]  ? __lock_release+0x3ec/0x410
> > [   25.815697][  T214]  ? iget_locked+0x78/0x310
> > [   25.816096][  T214]  alloc_inode+0x93/0x150
> > [   25.816469][  T214]  iget_locked+0xdd/0x310
> > [   25.816829][  T214]  ? lock_is_held_type+0x80/0xf0
> > [   25.817264][  T214]  kernfs_get_inode+0x24/0xb0
> > [   25.817670][  T214]  kernfs_iop_lookup+0xb5/0x1a0
> > [   25.818087][  T214]  __lookup_slow+0xd9/0x2a0
> > [   25.818479][  T214]  lookup_slow+0x50/0x90
> > [   25.818847][  T214]  walk_component+0x19c/0x2c0
> > [   25.819244][  T214]  path_lookupat+0xa3/0x270
> > [   25.819627][  T214]  path_openat+0x307/0x3e0
> > [   25.820007][  T214]  do_filp_open+0x7c/0x130
> > [   25.820409][  T214]  do_sys_openat2+0x113/0x1f0
> > [   25.820807][  T214]  do_sys_open+0x8e/0xe0
> > [   25.821211][  T214]  __ia32_sys_openat+0x2b/0x40
> > [   25.821622][  T214]  __do_fast_syscall_32+0x72/0xd0
> > [   25.822057][  T214]  ? trace_hardirqs_on+0xa2/0x110
> > [   25.822480][  T214]  ? __fput+0x19f/0x390
> > [   25.822842][  T214]  ? lockdep_hardirqs_on_prepare+0x242/0x400
> > [   25.823346][  T214]  ? syscall_exit_to_user_mode+0x5f/0x90
> > [   25.823823][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > [   25.824259][  T214]  ? lockdep_hardirqs_on_prepare+0x242/0x400
> > [   25.824767][  T214]  ? syscall_exit_to_user_mode+0x5f/0x90
> > [   25.825254][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > [   25.825696][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > [   25.826155][  T214]  ? syscall_exit_to_user_mode+0x5f/0x90
> > [   25.826627][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > [   25.827056][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > [   25.827486][  T214]  ? __do_fast_syscall_32+0x7c/0xd0
> > [   25.827929][  T214]  ? irqentry_exit_to_user_mode+0x23/0x30
> > [   25.828423][  T214]  ? irqentry_exit+0x7f/0xc0
> > [   25.828812][  T214]  do_fast_syscall_32+0x32/0x70
> > [   25.829223][  T214]  do_SYSENTER_32+0x15/0x20
> > [   25.829589][  T214]  entry_SYSENTER_32+0xa2/0xfb
> > [   25.830003][  T214] EIP: 0xb7f8c549
> > [   25.830330][  T214] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> > [   25.831929][  T214] EAX: ffffffda EBX: 00000006 ECX: 006142a1 EDX: 002a8000
> > [   25.832522][  T214] ESI: 00000000 EDI: 00000001 EBP: 00614024 ESP: bff3c4a0
> > [   25.833123][  T214] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200246
> > [   25.833738][  T214] Modules linked in:
> > [   25.834062][  T214] ---[ end trace 0000000000000000 ]---
> > [   25.834522][  T214] EIP: __dump_page.cold+0x282/0x369
> > [   25.834960][  T214] Code: ff ff 83 05 e8 5d bb c5 01 ba 4c c4 2f c4 89 f8 83 15 ec 5d bb c5 00 e8 f2 92 ed fd 83 05 f8 5d bb c5 01 83 15 fc 5d bb c5 00 <0f> 0b 83 05 00 5e bb c5 01 b8 ac 85 a3 c4 83 15 04 5e bb c5 00 e8
> > [   25.836574][  T214] EAX: 00000000 EBX: e764d530 ECX: 00000003 EDX: 4108888f
> > [   25.837183][  T214] ESI: e764d4e0 EDI: e764d4e0 EBP: ed89db3c ESP: ed89db00
> > [   25.837772][  T214] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210046
> > [   25.838414][  T214] CR0: 80050033 CR2: 00616abc CR3: 2d878000 CR4: 000406d0
> > [   25.839011][  T214] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> > [   25.839597][  T214] DR6: fffe0ff0 DR7: 00000400
> > [   25.839995][  T214] Kernel panic - not syncing: Fatal exception
> > [   25.840554][  T214] Kernel Offset: disabled
> 
> 
