Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D96760B536
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiJXSP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiJXSPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:15:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD201C69FE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666630613; x=1698166613;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1hbp8kaTb4GcgcijNqWwSdVbsOrKOyHhSINyKLFdtr4=;
  b=nCGXicpXJyS2phpDEYum/X/E9PV28AE9CTc/gpzLU5GdpEp9UGA2hGWs
   DFuXsVwhCTzys/6lxD55RI5j29W8qOrxDCir+Ri0tckXtfEthWYNJoCz5
   Kv/mew6pB3lyu5/KMW9muJ6+mjLh9G3kFG+IaEfbfulnVeTjL8bwptEeU
   HDDPS1rVxsXJWWxUCyLpX6eZD14Nvy9tYaLr3dm5FOyRzbuV756ngpWG6
   ekE4DhUJzmWa31AVTBcGUcmcaFgHtbSMHNrAIFLu+QuJIuKiSofDbMhEt
   MnFCWymAFI8fKmSMAyKrfXWQGQN8z21EoaGH/OHMm+ywd5CLMIDdB+LCL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287189603"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="287189603"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 09:54:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="626133202"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="626133202"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2022 09:54:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 09:54:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 09:54:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 09:54:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 09:54:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrHQEARc7qk1vQ2AvRHSX8HcGRy2aNYqKFqMADL7XGJY0NbePi4kei/K6nJsl8hoi3AvDWdCXSD8HTfYleUFnS/M8wtTQvng1I5p+YvMxTW0miHzwPW3k3f9fWNl9kwGbrmRT9xUXJyV4Rs273tlTy9xzkLaDGFm/ljly7VxhXuIJGnNPHYY1d1n+QCfSYV+JU5gLBxddXXy/Axk/GRroVI2zkvb/YNtA44TZ6//7RGf9WcduVazfYy5YGRjB1CKJJG230CBTo+cyKB1dUwZUNInfKgKGWbSVOKEBom88mZxWI8oTUl37OjUm1Z/ByX5f+gCihshJN9JlzlixBGLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/zWozhZIYwHLTJp+Yaqq87HBhkbgsVlXIqvNk4uEDs=;
 b=kPaP17nS+HZ+xTRhbwcXbkSWNbQM4Bjq34OJxCHymJ7jeiFUnJZU1iPDly4Sadjsm99Qy5IwLs8aTVlVnCazbScPWspaajI5JEsMSMgH/r8mrqL8Tz63FF1j1QiTLI0t8Vo5AM93eJdzu5SCBFf3I4oPITaFXoxXoXHQUSrsYzWsVHVedS/2Ed/72lbOZJzSBpIOPPMjHn3b/G7Qh78+f4QHtjXZh+G03eOEKqtzDIr0RJjGPCyq6yp95VrS5gdnrcMM5GRPZLytukKzCiwRWvpebYFrpZWKeSiwoEcMSAyLvDvlDTRYHaCNamdbsO/7bqjUn97KqFlMNNBjCAB9MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5510.namprd11.prod.outlook.com (2603:10b6:208:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Mon, 24 Oct
 2022 16:54:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.033; Mon, 24 Oct 2022
 16:54:33 +0000
Date:   Mon, 24 Oct 2022 09:54:30 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        kernel test robot <yujie.liu@intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for rc] mm/shmem: Ensure proper fallback if page faults
Message-ID: <Y1bDRpmPdYdilJzp@iweiny-mobl>
References: <20221024043305.1491403-1-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221024043305.1491403-1-ira.weiny@intel.com>
X-ClientProxiedBy: BYAPR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:a03:40::49) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5510:EE_
X-MS-Office365-Filtering-Correlation-Id: 1374e254-626b-4c73-92f0-08dab5e06d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pj0WrdUWL5hj55aWBab75R1j0zVVEMRBYENVPQZ1FFvZkyCJsiQBC5GezssPLeFGEnXoyvwryJn0g76YHwGSKVCrlqPHYny6PNXln10a9M1bgya44ZDpPLbLWnHoJxlkvVZ+y7v57CYmoYyI7I90womN8Zn6nJuWwiqvNE5Vyv6EHyqLgTxKfZtWl+PYtEM0e3QSxE0e/9n0nblYYTIbnMdbqobMXbpaiKkxoNaUimopwRijFj1UfagmkdMqnOMVpqtHf8aunhqDz1L8HMNi7m5AM8nVAPVScupm70T8k1JmXonF+B+sOkyuw/YBVf0FBce79o9j532z6CzG4Z2P0zY8ygzE0uwW0YRZgZZ/r1zproMvIhiYye5iSBJBRaVJnvIiNu9RUFuDy+32jtaP1EDHhZY/LQPDjfZm2DlTa7Y45hoOkMtjgXrKryQOSvZaubxfO2YHq8wadl7d6I3GK7Evp9TFthibcVBjYMklVGNed43l1iSqkYFuasFN4+WmTfs8QNUru0zxHX3vg96fLZeq8AtnGLRM/cQ9IiRX2x09bTvsg64Kb8aGjZl3CUC1t9Z5uDrDWKFafONHbVmpqSBXw+mxqQb+Jx0Y8oP9Ffc+QmQ18RMJ9o4acynA0jUaUVohrTCcc9VeADKpWpnX69dlHJ42ykSd8eni5mxj7+Sf2jrCmcTAokABljCQsXPiKHByCfQ1lHolbHGcmZKdV02xezbbbHWcYGD61uhhh8JzxPjiu5t1h8iQ5SSRcrrNBk+J9/2lhbKdVGa4PnsTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199015)(5660300002)(82960400001)(6916009)(966005)(33716001)(4326008)(86362001)(66556008)(54906003)(8676002)(6486002)(186003)(26005)(66946007)(66476007)(6512007)(9686003)(316002)(41300700001)(6506007)(44832011)(83380400001)(478600001)(2906002)(8936002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L1xjQ6Tg3Av7KQn0tEmAyFGaNBbAze6d3EU1NR+ADkg4H+EJYsmZDz/oy2YC?=
 =?us-ascii?Q?B4X4+Woa80UCHBsCcd7/C2lEAvE8SmSFNks+iNbYG5jHD3yzKtFLeLmNKCrA?=
 =?us-ascii?Q?ImMGBafl1R8pOpIwO55mTw2yTqw7QJgspDtzuaiSthULYZ6x1jN2+BD40w9y?=
 =?us-ascii?Q?1zxg7XSHUXrvfeiuL5xR0wxrCkwHo8AWUnLPjFoYiidorn/xjswRAP5K2xIM?=
 =?us-ascii?Q?OaGvHquuFkI3pIUcN3uJxgGroNeVKHkhj9pOsK/7wWPw1kD/j0SJJVqCzt5i?=
 =?us-ascii?Q?psMc5tmrC/6dHyg6BBZQC1lNVjuVqOjbgR65fKlZe45vpfRU8VS7SlvXrn9k?=
 =?us-ascii?Q?VqM3ab977ydpclDQC0KqKcod+AqIANm8W7CDWH1R5kjeipuRv2J0TTFzEVUK?=
 =?us-ascii?Q?x21ES5+Yr6jmXdbN79/WJrEMuEiKf+uagJ/4OAa6c53Es6/NTiNeEs4pDHds?=
 =?us-ascii?Q?O3o6nklCPeIfXHGhc1Ern83cYl+uAFs/ieiYYwZgxQjSlhwpMCH/xK96C0wx?=
 =?us-ascii?Q?in55L5wABT9uY3gwrtcndJ2q//WJXhKyymO10afVqb62XAw1O+KWnn6mFURh?=
 =?us-ascii?Q?u54m7mwMPxWC9C4u0N0GmC1UlhdbCrVtpYxqqQde4X4EoGt5noOqEupfuQW7?=
 =?us-ascii?Q?5VOEOXydQ+LkTijUfMuBdzrXTSaNF4EiDrF6GrLSLpjkSwRrZOx/4FKR+Wcx?=
 =?us-ascii?Q?LrUyCiHD1/YyJR4LJ/Y4NnCzQ4B93qC/NyAmQ8nBSJxgnGQgsXYhEs1POWE0?=
 =?us-ascii?Q?VH+AkAIBiToHo8b2LiX/UT0bBIJuu0rj53q6Ro49MXZpuoz9quhVS1zevpo2?=
 =?us-ascii?Q?Kb+8WkeilkEMSAEuc93QR3N/eHgZ4ywfCxYy7PyWZZSVUHZYlWzXLj8WKR27?=
 =?us-ascii?Q?o3y9CG5aRa6chOb5Eey+S/57pzWy48TGz5M9hzWaVJxHTH5NrtNI3cmFAFh6?=
 =?us-ascii?Q?YubG22J7vwZmRGhHKTSIORcTkzjW2oloulb30BeAUVe/8pziks5iNaDKgc9t?=
 =?us-ascii?Q?e7eD8cnn6CpfiR0s9qBXA9vMg4ava/8IdWsWBX5YNDOERzzxBacpVSKZR9EG?=
 =?us-ascii?Q?/JKfeQSKlDiYkSSt6uKRruyixx8JV547nN//hO7rkSEDV9dW87OnzgXu21/S?=
 =?us-ascii?Q?eG9+Q/o8J4AYAaoS9KCCdYu/idlR0TNwSp9T4Crf6cldAzjdYjL55z3jGYQL?=
 =?us-ascii?Q?nltwYo0597OMVi4Ch/UzhEpA1Du+VbtGisZuHzGIcrKMZ1nMCrXZyfd9NCRe?=
 =?us-ascii?Q?uxzmoxWsBTZCQmuYde//oMZhCvn9ZmI/KKx+FhxSQW26ZHFPH2HA9KMnAVur?=
 =?us-ascii?Q?jFrEymYT63wN11irUNWrez+P7Mjo/tBBltJou9j/QcSi5FdvNempUrJPADV6?=
 =?us-ascii?Q?X2uIJkIOTVzn1f1EGX51mYTuuKJqBZXf4cE7CRp2k8B+aDOn8FU4lEXnvKR5?=
 =?us-ascii?Q?9jSoZX4tPwZ/o4Gi0G/mUx2tQlZ+JFW8ZER9UlTPa6IHB9J8ZRBN/NxZlfcZ?=
 =?us-ascii?Q?0M/Iq4qkdeuYwMnU12hdolXmCPnA9D6bcgqnm5J0eiFn7PnFWm5I/Hrcaduc?=
 =?us-ascii?Q?ACEvXdsau8d3Y/LM01btNauKX2NewUdVlr95czsR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1374e254-626b-4c73-92f0-08dab5e06d40
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 16:54:33.7846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vf9Bv0vGnyoSq+ypStGayHmuxZjGigCHwZ3nfWucQN9BOXL9SlliFAK9Iu+hqtgZn++vQVYpw2KPG0b8NxdO8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5510
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 09:33:05PM -0700, Ira wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The kernel test robot flagged a recursive lock as a result of a
> conversion from kmap_atomic() to kmap_local_folio()[Link]
> 
> The cause was due to the code depending on the kmap_atomic() side effect
> of disabling page faults.  In that case the code expects the fault to
> fail and take the fallback case.
> 
> git archaeology implied that the recursion may not be an actual bug.[1]
> However, the mmap_lock needed in the fault may be the one held.[2]
> 
> Add an explicit pagefault_disable() and a big comment to explain this
> for future souls looking at this code.
> 
> [1] https://lore.kernel.org/all/Y1MymJ%2FINb45AdaY@iweiny-desk3/
> [2] https://lore.kernel.org/all/Y1M2p9OtBGnKwGUE@x1n/
> 
> Fixes: 7a7256d5f512 ("shmem: convert shmem_mfill_atomic_pte() to use a folio")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/r/202210211215.9dc6efb5-yujie.liu@intel.com
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Thanks to Matt and Andrew for initial diagnosis.
> Thanks to Randy for pointing out C code needs ';'  :-D
> Thanks to Andrew for suggesting an elaborate comment
> Thanks to Peter for pointing out that the mm's may be the same.
> ---
>  mm/shmem.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 8280a5cb48df..c1bca31cd485 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2424,9 +2424,16 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
>  
>  		if (!zeropage) {	/* COPY */
>  			page_kaddr = kmap_local_folio(folio, 0);
> +			/*
> +			 * The mmap_lock is held here.  Disable page faults to
> +			 * prevent deadlock should copy_from_user() fault.  The
> +			 * copy will be retried outside the mmap_lock.
> +			 */

Offline Dave Hansen and I were discussing this and he was concerned that this
comment implies that a deadlock would always occur rather than might occur.

I was not clear on this as I was thinking the read mmap_lock was non-recursive.

So I think we have 3 cases only 1 of which will actually deadlock and is, as
Dave puts it, currently theoretical.

	1) Different mm's are in play (no issue)
	2) Readlock implementation is recursive and same mm is in play (no issue)
	3) Readlock implementation is _not_ recursive (issue)

In both 1 and 2 lockdep is incorrectly flagging the issue but 3 is a problem
and I think this is what Andrea was thinking.

Is that the case?

If so the above comment is incorrectly worded and I should update it.

Ira

> +			pagefault_disable();
>  			ret = copy_from_user(page_kaddr,
>  					     (const void __user *)src_addr,
>  					     PAGE_SIZE);
> +			pagefault_enable();
>  			kunmap_local(page_kaddr);
>  
>  			/* fallback to copy_from_user outside mmap_lock */
> -- 
> 2.37.2
> 
