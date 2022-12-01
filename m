Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9076863E998
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 07:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiLAGFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 01:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLAGFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 01:05:51 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFAE9FA88
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 22:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669874750; x=1701410750;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PTWb5WqDE/18KkEvT8xONSkNOFK8nGNEbHtwAnhudBE=;
  b=bFjOV9X1KRi2H3wr3JFYctE6SsDVOY99DRzm04xp8f/SVpOoeSDG0Q3A
   jMf6mAvBJslGhICUHI1Zs5WLjo4qrYO51JAVW5TDtyi9rwZvmXmZAutX9
   yfdibepD/b22H8UBe9viYKo9lUJ2ZQyaBzLmj9mEkuvuZniEiCMD/KE1k
   50t/cUNWNV3in79OaD2TvlAwRck/kAWqNNuoq+B8cf+75LV1NBjTkID+J
   CXPq4KSlDYsHf2q1547+Z1yLTR4TkkDm1VkecVqZocPJ9I+KCnhzMFh+T
   m0JqtoJxTWyISi6tApJ9NjQhDvRb0HPWEtQ/eGJRUNK2illYf6fQBoT1H
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="298964771"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="298964771"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 22:05:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="638271789"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="638271789"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 30 Nov 2022 22:05:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 22:05:47 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 22:05:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 22:05:47 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 22:05:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeLqHM3y7u2dOt4iQBeDRddb9PEDZezk1RR/EmR3iulPUIHNtm5yoEhKgJR9sw2+FPkBvm0iKcSSehF9iMLhbQsvICDRenxZmr6wPvjboiT+YTZlllACSkEmarQHSgSZ/Hhm40dqWLxhqnqVuYwYBSOvwdgvT7JECFLzV13aA9qUzP8MUh7jYgSY8MNQIMt4MayIeXdXcFBUUK33JihlnExvxIM0Zk1SXRwojmDOUEWCHslMl27LLowBy7TG1o3UZbAkXbtNQQ23FbpYIlWwgYorHapP3KW11l0ZcPh0OIg3Lrn/HpMa08B/DGYfEXomBO10+M9RMcpBd50nsOR8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNiydFcp9iX5ziYGb5gEs5qH6GDthg7RjYqGYkUNIqY=;
 b=bOctp7bzo5DHIRWlX08DFb5DdL97GZmqbVXDxKJ/a7kRQdqH0bEI10ejc1avlyO3UTB18UB5pJhzbB737Zj829QYsYmAPolxwrBuTsZ3qnGx7ZFGHwTSMKTvW+2BYlXAktwE9iFM1hWxSkjrt/8utuxc77/qxIlI/qnDFg6P4ZDVFKTaMw320kjyzFQfAVGFzFVI2rd8zqrdB5LhsQLwgRc52rUrHEIoGjhq5nW/JZ3s0s8H8FE0iSO1Wnhihr6/O1Zk75p9LRM1QGK5o/YXx9FXn8Q/LtAwPWIQNRJey3CPm59rXa70RUDiFISV/aoH04Rs7p+ZjkGbxtsmerInqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA2PR11MB4905.namprd11.prod.outlook.com (2603:10b6:806:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Thu, 1 Dec
 2022 06:05:45 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%6]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 06:05:45 +0000
Date:   Thu, 1 Dec 2022 14:02:40 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oliver Glitta <glittao@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        "Pekka Enberg" <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mm/slub, kunit: Add a test case for kmalloc
 redzone check
Message-ID: <Y4hDgEh2PP/SJDKu@feng-clx>
References: <20221130085451.3390992-1-feng.tang@intel.com>
 <20221130085451.3390992-2-feng.tang@intel.com>
 <b98a61ae-da11-00c0-60a9-30a3c043f761@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b98a61ae-da11-00c0-60a9-30a3c043f761@suse.cz>
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA2PR11MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: 376b3284-7161-4fd2-268b-08dad3621580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8d4vc828Vbm8NzZmIqTzGR1MppryAIzq1QEaPbKvwOmTSfmnThiOfPZSfvMIMIs7LRFZRTx/3w5MBhKUoqzZOXzh62ARGjPnK+m1HItrDqG5fxAn2iMa5qKKsCB+BkHFvVKtZxkWlmAB6Gy8hUWdWApojSjsEZHYRmZaE/akOJJVdxDy+qeXtK1nGQj6/cZ0rw8+s0vdIzKjtHHr5B2IEuYfDp46I2Hk20Y23tIt6T0f8SvOgGtwfl0nAFNczF6Vhja+sFt3SFIbqrPVaqOEq6V1GByuJQva4Tuuz+YRcbRpA3Oja5Cw9NxVRIizzooSFXcGHRnZWe49ycVwflwA5y3qVpH8qgs69qMXYqXnt+L5LuIb1AK1EzOOEJFG233OAeYoVaC3BzEqUcYXixga2deGLrB4tE8DykdVfK+9e1xpKE0/90XrFDu21t5nMrpxwz0+X033mFN1oVxBGhMLhQAxDNo+T4CXJwywfrRPCQi5xzPMTTiiqOVo7c0sVi+zk201GhvI0DmHAUxOTOR9t1r4UyxKBC/zW1lkbvH2ITI/y70mRSXm5ZootvsmcHmvEi/QnrfYeUeDYwEVv3I46/gfKCTP+Yp2DGWgR03p3z0Ywha7oQrnG2x2cMsHP2NSvx+OQtSoG6eQrrS2iW1z/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199015)(2906002)(83380400001)(186003)(66946007)(8676002)(38100700002)(66556008)(6916009)(478600001)(54906003)(41300700001)(33716001)(86362001)(6506007)(44832011)(6512007)(5660300002)(66476007)(4326008)(26005)(9686003)(7416002)(82960400001)(6666004)(316002)(8936002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hLW08faQNvcZ308pIy2FcBYeOW1HAoimNf4nAueIZcbZ1//Z9/8u9qeGkQJY?=
 =?us-ascii?Q?85KDAgfmMibK1+KhYGDwZ7bDx8bk0NzN4/vXPPLhEM/oXxQu9FCknP0a1AXg?=
 =?us-ascii?Q?rEK2QOP27jmgGfxnxVKpAOA7eQVn2+Ri5UcmQksX1JMuB+2/HjzfH4vmgN2/?=
 =?us-ascii?Q?YGC+zURs40vdMUw3UQU/p36SAhf0cBiVDZfTpUfF4YOKZwax6wTfTfCIYOH7?=
 =?us-ascii?Q?gOhnI5dJcL65D8NuxxctXIEVjbGbKXNq5ssY9p+7ZcT9fhCbCBCgm2i1rwZ1?=
 =?us-ascii?Q?80K8yScf92SyFX4T2coSB8yLldqTjlOUVRwYIaetZlXSbrYfEMJIW3HxXMwZ?=
 =?us-ascii?Q?tkrE4o4Ralyu5zmUccwKnhjJNN3JUU8r2qrafbQLA3OVCYhDQXcvpuwh9hC3?=
 =?us-ascii?Q?I4bTDIsL+QjTjQjn0/fCniJESF9IWhR6IeqDJlHjENfnQyP4BSS5sqywobqB?=
 =?us-ascii?Q?U64ICCwhpOG5haUnLljdYxemcbpffVNIkNyb1wYmqKlrqHbTEUP87p+bCNlx?=
 =?us-ascii?Q?c5S7ATA/VEcNjpXcXZFEthAEN4Fs6ogVyX69GacY5+QD+Jz+7e+cMJQZ5UR8?=
 =?us-ascii?Q?b2UKdAE0haPtYO9+r28SWzx4a2DyeFKqguDFqsp7yYxNz2pg1XZ+g7A7Xhnz?=
 =?us-ascii?Q?KKZ21Z/up2pkjgtdUYa8BCGNRS/ZkgsB31ae2QjJqdrmm6exwLhQMw1FKCJZ?=
 =?us-ascii?Q?Fe4SHlQqk5d44WMzIK516NCy/Oc9YhRNVeAjNxfWXGfV4j3UYllex/Vn1FZk?=
 =?us-ascii?Q?h6U+Hyq+iKm6XBpLTp5MNmvvVDq9Ujb+8Rjk2fUUau+uhgaVo5W8O/bXurLh?=
 =?us-ascii?Q?94K3/3IUsGGWMTZIcSEWOs8sDK/RSLF3SNxXCapbzCijwKLKoPXJ0dOEdXAz?=
 =?us-ascii?Q?KnVXd4k6Ln85cBHJApysBLiRV3dymy3t0nfKRId82mBK/PqDaAzQ9GGE1jZj?=
 =?us-ascii?Q?F4fLpYJHzSzL9u1W1Rnv6oZQ9hRYajtGoFy0XvmdoIMXHsyiFfUX9dpfNPeW?=
 =?us-ascii?Q?wbc/C9FL5R1n3xXtOmGm0vAJG60YcO/rwE38WtZkXYDDlqmOY0K7IZ1xGs+V?=
 =?us-ascii?Q?95PbmxvN63ywI8BVv58xivADOtXfaJrIYCo1/yIn2morQfdPApIFOy5Lrk8a?=
 =?us-ascii?Q?3Ic5AttDcs1BnY5YZGnQLgy5s9iNUQnds+cmw1HQty3HCIU8P/Wc/r/Lp188?=
 =?us-ascii?Q?DQiuO7qFDlR5nDXg1tX6EjkZzZ4CpWrhqQ5d3agti8w0RjZXU/EFHfx6lzJg?=
 =?us-ascii?Q?QTxrf3brRHBRkxQ/+TsLnDqHQlayV4DuL7y0hrtuMkwu4DHkDhacNNxiemup?=
 =?us-ascii?Q?JZjjNRX8tP4kfZvTPHSc5Y7os2Om7zMLuelQsiYyiJ+L+CRtPuw6q2h8y3MO?=
 =?us-ascii?Q?9BKpmfC8cm5/lBcz5/09acJpXqrzxBYJUM20LxGELRblzgh7Yi9py11LXo63?=
 =?us-ascii?Q?cmXeLu97i2qyvJbiPXi88Qv7WSawpGWSg4He4V31QFCOVVA/1VhKP9/vKXwI?=
 =?us-ascii?Q?9UsguVp6jarQCBNXwifNK7rVb2sfrTx9hieL9peN/H4TMroanb1xi2ZOKAiD?=
 =?us-ascii?Q?+O09oDin+JkNLAoXUWzyaa1qMFNmQX/b66gRUS2S?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 376b3284-7161-4fd2-268b-08dad3621580
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 06:05:44.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbT8IrrsLdAjw/OWd01EctHmlOhXaUMYA+WdE4q4FBgoWimshWOBLR1vI9TZStDwRPMJSYqaxh8NFKH1cY4oFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4905
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 12:05:41AM +0100, Vlastimil Babka wrote:
[...]
> > diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> > index 5b0c8e7eb6dc..ff24879e3afe 100644
> > --- a/lib/slub_kunit.c
> > +++ b/lib/slub_kunit.c
> > @@ -135,6 +135,27 @@ static void test_clobber_redzone_free(struct kunit *test)
> >  	kmem_cache_destroy(s);
> >  }
> >  
> > +static void test_kmalloc_redzone_access(struct kunit *test)
> > +{
> > +	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_kmalloc", 32,
> > +				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
> > +	u8 *p = kmalloc_trace(s, GFP_KERNEL, 18);
> > +
> > +	kasan_disable_current();
> > +
> > +	/* Suppress the -Warray-bounds warning */
> > +	OPTIMIZER_HIDE_VAR(p);
> > +	p[18] = 0xab;
> > +	p[19] = 0xab;
> > +
> > +	kmem_cache_free(s, p);
> > +	validate_slab_cache(s);
> > +	KUNIT_EXPECT_EQ(test, 2, slab_errors);
> 
> With this ordering the expectation was failing as slab_Errors was 0, had to
> fix it up to look more like TestSlub_RZ_alloc:

Thanks for the catch and fix!

I checked why it worked in my test, and it should be related with
kasan. My test environment has both kasan and kfence enabled, and
kasan could delay the object freeing, and with the original code,
when validate_slab_cache() is called, the object is not freed yet
and gets redzone-checked. 

> > +	kasan_enable_current();
> > +	kmem_cache_destroy(s);
> > +}
> > +
> 
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -148,11 +148,11 @@ static void test_kmalloc_redzone_access(struct kunit *test)
>         p[18] = 0xab;
>         p[19] = 0xab;
>  
> -       kmem_cache_free(s, p);
>         validate_slab_cache(s);
>         KUNIT_EXPECT_EQ(test, 2, slab_errors);
>  
>         kasan_enable_current();
> +       kmem_cache_free(s, p);
>         kmem_cache_destroy(s);
>  }
> 
> With that, added both to slab.git branch slab/for-6.2/kmalloc_redzone
> Thanks!

Thanks!

- Feng

