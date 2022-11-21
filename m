Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194826319CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKUGld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKUGlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:41:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22C6E01E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 22:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669012890; x=1700548890;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FDUO7/Ny09AoNCCngxzh2m9Kh+QmqDzIu/aHwhhD80c=;
  b=WSExp+cw4e5YjRZKig/jmkB4sV9VNTm3O0WmMb27JwB/MChAIyqS7QA4
   bw6h546UUXj3sTnSHGkeL99rSYNyBbDibqE38hzhc5jpk6ct0wqfDnjTN
   reeTWj0PnLc8IvobMC957FVUIpEwOhdlxkJi+WM9i6G3GpF+pfl9B49xx
   Rmsfldl6lk9neDziFIlbzUoRSepqa3RQJDpsQLKZ5p848/0KKieUbonQS
   uSbUYTg99AON/cZ2vWowBw5V0ewc3yoYmoVZZAFafKziwqv0rJbtXZJ31
   aja7rdHqd1oaUhlIYUMkQwgnJ5EWlbrsC50itjt/aBtODcExN1EQAFSB4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="311114358"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="311114358"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 22:41:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="815606161"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="815606161"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2022 22:41:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 22:41:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 22:41:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 20 Nov 2022 22:41:29 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 20 Nov 2022 22:41:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFysQqzaNnsr4ibQCsPixZQCDbi68Lsex5R4XNX1smzpl7n25i2NqBKWFOo/N+YPqOZoR95rJ+37tb1rmibnyHstpivhs/wtl78wXk4YVnAnv/4nQdhCA59OLqt4CzdgSsam1vVbCRQQVOJqoHFtmWW1blm8/LRKhwKzQFFVvELRufua7gedYMGLmbnIlCcvwnRstaAAjn1EITClhE4t6UFrnk5pailLyuDmhdlqiuKNNgBtPt+NC1u13hQwToXbf4yxgPHOo7WRncABtGoRMmL2aq4RoTd4gxk9bVgMR90GINqGY7tX5OzHK9FXkzqAcNVniUrf6bvZSy1m3GZdeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDfiCEJYcPf2SIWNL/reJOTTgp8cb2RmDVfegZSD2UU=;
 b=adwIsLRHFWmGptqcJylD8gudtEgJZWHkAcJElzo1AL4fSytKzA0ahbgkSeZ7Hnn0V50796xJ4NEU6+olpCkDNR3TpTbW5/czWFZVZMooW8nt4afcKepy9QbF+qjwn88BsLLdsumfnsjo1VpCAvgi3S5jZOzI6Mb+2o4UYfWJXq30PsYdd5ulLtbEe5QKEl2MQWyASXM3OiWrh7i/GJz24VPD9DhrPPvtmIoccWvG/R9XuWNovq6wUvgbi9I+GB78TqGCxtuq9Ey1tQs1q5hiVK+GraOHb/dYersx1f/Lm+kuICftxdjHPUti9S8eDIA6RdJCJkaM/h67gYvbfwQ9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH0PR11MB7541.namprd11.prod.outlook.com (2603:10b6:510:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Mon, 21 Nov
 2022 06:41:23 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%5]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 06:41:23 +0000
Date:   Mon, 21 Nov 2022 14:38:12 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v7 0/3] mm/slub: extend redzone check for kmalloc objects
Message-ID: <Y3sc1G6WEKte4Awd@feng-clx>
References: <20221021032405.1825078-1-feng.tang@intel.com>
 <f9da0749-c109-1251-8489-de3cfb50ab24@suse.cz>
 <Y24H998aujvYXjkV@feng-clx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y24H998aujvYXjkV@feng-clx>
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH0PR11MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 383ec532-cb47-4aff-5434-08dacb8b6805
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Buf6Kg4xZIKQirc4uta8EavePIFYjB77ZjC5JSHjqLXXZzLrAUAj8h8yiwiHEJe0NRR/Trpr13SKcmoNH863wLqdPhDrXNUgow8+CxJlt99Tl3m1NxrYPnoF4L2Nijl+jPcuW2MzxvRE1VB9XwjaC+YSk2qZG18Py9q1jGC1VrwZR6s9Xqquf4U3ay+d8CryD0w7w5DSFVU6eKU6tQ5NZCtB2K9xUbCIbZSfazCoLSs5khOZwP82x1Qj2tiaJnMrvOsAHZANQC6bK1YvGGVUNiHEx3JCGaQy7TYKTyU2b7NcdRM56X+hRP8muEFZsRiWD5E0/Mx8w1we81uKZgU3IY3y5OU297+5xqNEkwavkrWgZMwRN1gXQ745F+rJn+qVmWHJI2U0H9Uf2bu5Hyb0iBrH0LrNo8izz6aeq+4/YWSzb8BilObiFLHqU8YLysC99aZXetUcGTnNH/rruAByJf+ShIsfr9NNJWm9OGiuzbXwAeJkV8BSrzJ7sJsH7hR1ZClyyNgUOCTIJjbMqGgNPWeeweTQc3ffkZEEKdPGWTEjlEIY2ksXHLlVrOQSlLMcubfsbmK8uieaYlDbOia5DtNYpRJhdcv/1fEscdkTd1mR89/VZGPkRWrPePxd938bkW86EMpWUHifnqOLwfLCjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199015)(41300700001)(8936002)(7416002)(44832011)(54906003)(6916009)(66556008)(66946007)(5660300002)(4326008)(8676002)(66476007)(316002)(6486002)(82960400001)(83380400001)(6666004)(33716001)(478600001)(6506007)(26005)(86362001)(2906002)(9686003)(6512007)(186003)(38100700002)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DFetgnptMq6jMcvawt5yhPSAhDLpVCsEE16fUJYO8VEGsJdbHmCDVlS9RemG?=
 =?us-ascii?Q?bpk6egxMTtjD6LjkdSD8QBnY7QNwdGXSaWU80vAosRVkVBX51ekBDOmQM6s/?=
 =?us-ascii?Q?JrItvEKDN2GBuRkv/hRrB2Db8v2dmp95DJgkiXhRg9hU0aPN7l2G+LO21+Cj?=
 =?us-ascii?Q?I3UdnsqE6SBtZ0QvVb71U6jZJRvR2F4uTjF71agXuiOHnv7aegFudRNqUyTr?=
 =?us-ascii?Q?4ikMc1keXWPrsF2YxSCfTiJrfv0OKWqrKyU3wCL502Gnv4gX5+NPx01b2rUJ?=
 =?us-ascii?Q?cShlVoFflRWWtvaZgXLXCksRHM1jK+aGtJZ6LOLcxTGNqNFNRvu9+9N8O0nE?=
 =?us-ascii?Q?NTMz047RqbX6zleLM2z2iqIQbnvtOCHFI3n5YXrBkLJaljpuXDPD8DwDn5uv?=
 =?us-ascii?Q?axU1LLlEeGtaDA1elo4Aodmb3XSmJjEeU8m82c5umeS+/Klyrk1m6cMnChRP?=
 =?us-ascii?Q?42zU6ZIghaXOZdeTgP+CPvQKEui04+qNzgcumbb67NHnNp6Ce/2fYhdSvB2j?=
 =?us-ascii?Q?9oLomA4yRoAns+IXMdFH0efMGDyzBoAx5QlN/Wro6Jcawto7lQuEIw6P9QLC?=
 =?us-ascii?Q?FfnavZpGoWMJoGHSc1zHRB1/h3gk2qgTrTL/9gQqwpvw5vWZB3if7IZB5sY6?=
 =?us-ascii?Q?eEj3ci1nuKLD8Ds/ccTjcv0h6u+N25loILlVUbESOq8sMNJoVI7tfl8dojWy?=
 =?us-ascii?Q?fhXiA7t+KCDtxOdmhpKosu0JR1/QwCkKApHARw0vbTw4yi6tM8NpLEmrJROk?=
 =?us-ascii?Q?HeuSIYQLnQt/ymEW0dqBFseQwVBDxRsiuM3mS3a/HofTpEvhXiAy0j8zzoEU?=
 =?us-ascii?Q?txEDcMs2AjH048a5l1OIfs0rRCBm2+MLRtS9+0sc4fDUeV1xcOWAb9xBCrJQ?=
 =?us-ascii?Q?LS+r9m+YAuI7Z2lq76O/Rf9n12FhFmf19XeI1m0IvTJdEHv82NUJKXReHexD?=
 =?us-ascii?Q?SYYwbt6gSek1FMUUeYKDQbm56EX0cF230fHGlnzN0QLCLa/+PLYfskMEQ0gc?=
 =?us-ascii?Q?Yp+hbj4GBh8h6A3tcH5iIYkDVOcDnneMPfoNv2wo8Bwg73nCJ8gktkHlJYFi?=
 =?us-ascii?Q?Z+1KUFcApfV5cgmP+deT1rJqYkXw6h4KGDOZ3Go8Mj9skRTe7rVRz9cfHLvi?=
 =?us-ascii?Q?z9bHlHks3+ra/8TpiFhIW7EhF0coYrX9D2bTHjWFsA2gsYT/Im9Gqd6euf2z?=
 =?us-ascii?Q?fhJqOgLs7RsJ/X4Oc4Wk6Jb0Tu86NIjXlWeFIc0t8o1iGK4XGcruEjD8TLny?=
 =?us-ascii?Q?1ctTNaaTeFSTcFYS51F2U/ut5zts/pKtLqLIS1oNR+azLqZZPFguCZPen96Y?=
 =?us-ascii?Q?4Dr6JZEjJhG1l3qgTDFR55MDW5e8c6PGz0M80zMhem7ERuE9xRggIf13sLDH?=
 =?us-ascii?Q?BCI/M0Fo063SvJtFjxCMyJenoUjnrPvURIFlOGSJTMBiV9Kv7r7SO9PAAEOr?=
 =?us-ascii?Q?Mp5img0tFYjlpGwCyVAh16UkogibbXITMF8/ZPzALpIF6mHQydxGtOBS4U+C?=
 =?us-ascii?Q?/lxMx3h/fBKRTawGjM039Xrx8YPiXl25ehg9SLHfbCjOSf3jn2vUQTNfgnnu?=
 =?us-ascii?Q?i5adryqhQ03CLsqHs569k6Zn2SUhQQ9wuVDhZ0o1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 383ec532-cb47-4aff-5434-08dacb8b6805
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 06:41:23.6168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MK2mxzfAuFUf+zSmaaM9ABt6ufwmIcI10h1zNO7RaKkNHMTaOmyuBFqo13xvjHBVNMrBwhiyFkVvSgvLVvhHkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7541
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 04:29:43PM +0800, Tang, Feng wrote:
> On Fri, Nov 11, 2022 at 04:16:32PM +0800, Vlastimil Babka wrote:
> > > 	for (shift = 3; shift <= 12; shift++) {
> > > 		size = 1 << shift;
> > > 		buf = kmalloc(size + 4, GFP_KERNEL);
> > > 		/* We have 96, 196 kmalloc size, which is not power of 2 */
> > > 		if (size == 64 || size == 128)
> > > 			oob_size = 16;
> > > 		else
> > > 			oob_size = size - 4;
> > > 		memset(buf + size + 4, 0xee, oob_size);
> > > 		kfree(buf);
> > > 	}
> > 
> > Sounds like a new slub_kunit test would be useful? :) doesn't need to be
> > that exhaustive wrt all sizes, we could just pick one and check that a write
> > beyond requested kmalloc size is detected?
> 
> Just git-grepped out slub_kunit.c :), will try to add a case to it.
> I'll also check if the case will also be caught by other sanitizer
> tools like kasan/kfence etc.

Just checked, kasan has already has API to disable kasan check
temporarily, and I did see sometime kfence can chime in (4 out of 178
runs) so we need skip kfenced address.

Here is the draft patch, thanks!

From 45bf8d0072e532f43063dbda44c6bb3adcc388b6 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Mon, 21 Nov 2022 13:17:11 +0800
Subject: [PATCH] mm/slub, kunit: Add a case for kmalloc redzone functionality

kmalloc redzone check for slub has been merged, and it's better to add
a kunit case for it, which is inspired by a real-world case as described
in commit 120ee599b5bf ("staging: octeon-usb: prevent memory corruption"):

"
  octeon-hcd will crash the kernel when SLOB is used. This usually happens
  after the 18-byte control transfer when a device descriptor is read.
  The DMA engine is always transfering full 32-bit words and if the
  transfer is shorter, some random garbage appears after the buffer.
  The problem is not visible with SLUB since it rounds up the allocations
  to word boundary, and the extra bytes will go undetected.
"
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 lib/slub_kunit.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 mm/slab.h        | 15 +++++++++++++++
 mm/slub.c        |  4 ++--
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 7a0564d7cb7a..0653eed19bff 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -120,6 +120,47 @@ static void test_clobber_redzone_free(struct kunit *test)
 	kmem_cache_destroy(s);
 }
 
+
+/*
+ * This case is simulating a real world case, that a device driver
+ * requests 18 bytes buffer, but the device HW has obligation to
+ * operate on 32 bits granularity, so it may actually read or write
+ * 20 bytes to the buffer, and possibly pollute 2 extra bytes after
+ * the requested space.
+ */
+static void test_kmalloc_redzone_access(struct kunit *test)
+{
+	u8 *p;
+
+	if (!is_slub_debug_flags_enabled(SLAB_STORE_USER | SLAB_RED_ZONE))
+		kunit_skip(test, "Test required SLAB_STORE_USER & SLAB_RED_ZONE flags on");
+
+	p = kmalloc(18, GFP_KERNEL);
+
+#ifdef CONFIG_KFENCE
+	{
+		int max_retry = 10;
+
+		while (is_kfence_address(p) && max_retry--) {
+			kfree(p);
+			p = kmalloc(18, GFP_KERNEL);
+		}
+
+		if (!max_retry)
+			kunit_skip(test, "Fail to get non-kfenced memory");
+	}
+#endif
+
+	kasan_disable_current();
+
+	p[18] = 0xab;
+	p[19] = 0xab;
+	kfree(p);
+
+	KUNIT_EXPECT_EQ(test, 3, slab_errors);
+	kasan_enable_current();
+}
+
 static int test_init(struct kunit *test)
 {
 	slab_errors = 0;
@@ -139,6 +180,7 @@ static struct kunit_case test_cases[] = {
 #endif
 
 	KUNIT_CASE(test_clobber_redzone_free),
+	KUNIT_CASE(test_kmalloc_redzone_access),
 	{}
 };
 
diff --git a/mm/slab.h b/mm/slab.h
index e3b3231af742..72f7a85e01ab 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -413,6 +413,17 @@ static inline bool __slub_debug_enabled(void)
 {
 	return static_branch_unlikely(&slub_debug_enabled);
 }
+
+extern slab_flags_t slub_debug;
+
+/*
+ * This should only be used in post-boot time, after 'slub_debug'
+ * gets initialized.
+ */
+static inline bool is_slub_debug_flags_enabled(slab_flags_t flags)
+{
+	return (slub_debug & flags) == flags;
+}
 #else
 static inline void print_tracking(struct kmem_cache *s, void *object)
 {
@@ -421,6 +432,10 @@ static inline bool __slub_debug_enabled(void)
 {
 	return false;
 }
+static inline bool is_slub_debug_flags_enabled(slab_flags_t flags)
+{
+	return false;
+}
 #endif
 
 /*
diff --git a/mm/slub.c b/mm/slub.c
index a24b71041b26..6ef72b8f6291 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -638,9 +638,9 @@ static inline void *restore_red_left(struct kmem_cache *s, void *p)
  * Debug settings:
  */
 #if defined(CONFIG_SLUB_DEBUG_ON)
-static slab_flags_t slub_debug = DEBUG_DEFAULT_FLAGS;
+slab_flags_t slub_debug = DEBUG_DEFAULT_FLAGS;
 #else
-static slab_flags_t slub_debug;
+slab_flags_t slub_debug;
 #endif
 
 static char *slub_debug_string;
-- 
2.34.1

