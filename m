Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86D66334B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 06:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiKVFdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 00:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiKVFdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 00:33:41 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF3B1D646
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669095218; x=1700631218;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=VLFuxYTmqLo2YJDYMbLHn6KgNzetbzq7E6s/zlOLrwE=;
  b=gni4bwVpP2Jkhw2P6sPIcbwa0JlGahEN/Alncj1Ckv66qoj9iFa9BehF
   VmL79CYqttrGJm4T1fS1uoAqImwo1xBf05CFP9nyh0OWcawcEOcYkF9kP
   WZjtmXYKWWsFRg0e5Z4evxyF2YxQGckD57xvG65kodAc0BE+wDL5/RP09
   SzljZ4Ms3OHe9VF+xZoUHaDER7Qzh6RMW/oCXr8clKW3M1xfXgg/arlRk
   DQ7qEBENfxhdWWkNTM9N7g8f5/QTfB9LzWaf+lM6DYPpmCGlj5+bmKoD4
   GOsltN6aWeKDbHXgNGq1obEXFRLqRuj/tzS9clRpBctDcTLsAQqzi/2WM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="293445966"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="293445966"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 21:33:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="641291969"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="641291969"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 21 Nov 2022 21:33:37 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 21:33:37 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 21:33:36 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 21 Nov 2022 21:33:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 21 Nov 2022 21:33:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dG8yfgr8PctWi74r/16o8N3ELlcyx5Q2NLWoLdPXTX4nNWQ9UHcV9iwRLT5B3mXPbxOOzVyx52sUDWUV1E4X6HtWyvcD5jsLnMmtOoKmqeVvauCi4T/Tr7BTS3z9FzJ4WN15/8xPOEcqCoOHECfGaR9+eGZlPuVLzwnNqq1au1EtBTYIg3ldR3Xa4AH3mOQXrkX2Zj2Lo/bApiTKuloIJGEy+w74VUlQM2F0hOippvYuLyr2JXx74tViv8J4XD3on83ZaK7GJoA/Apf21t2bbkbIKRPW6jtbO2k2HH5Wus1D2tsl28hYIfTLsnLNLwrcCpTH13qKZ0DBtiQ+tiqhGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohFrW/XMPrgXRWF1BdJXsZr09tohW3MCpODfu74bJ6Y=;
 b=ZzXsi/kwDWVALunGBJcDS0yNIPbgyATJg9+uhTkuMoNAfsYedDS008EiUWAndnKe5QkVIH4x12E2FS1go9xNCDplW4iOzHbuhAFZ4FJu+mwUV1d3+KhXW4kE6sPvys4iixgNARCCmzOdNnUKBmzBQMwRH6kvSbc9MdDkhwFf8F8NhJfxrjED957cDC4FPXMOJremLHMZTQTM6FVdlc5LCxCRBm878k4CQtJzkBKM516LjBYq8VoOXkttzFVUKq9YBJ/xMAmYcoQB9AFvFWWVMP5/3I6RGBpnAn3XfxMrtNltPSe7TB0W209WZwcG3FP++9XJVinhlTdDw2dTy3FN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CO1PR11MB4963.namprd11.prod.outlook.com (2603:10b6:303:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:33:34 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%5]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 05:33:34 +0000
Date:   Tue, 22 Nov 2022 13:30:19 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        "Pekka Enberg" <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        <linux-mm@kvack.org>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 1/2] mm/slab: add is_kmalloc_cache() helper macro
Message-ID: <Y3xeYF5NipSbBFSZ@feng-clx>
References: <20221121135024.1655240-1-feng.tang@intel.com>
 <20221121121938.1f202880ffe6bb18160ef785@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221121121938.1f202880ffe6bb18160ef785@linux-foundation.org>
X-ClientProxiedBy: SG2PR01CA0188.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::10) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CO1PR11MB4963:EE_
X-MS-Office365-Filtering-Correlation-Id: 45688f1f-eb30-4b10-054e-08dacc4b18f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pa3QlzN/1yfgsPvJZ0n6hbwZkBbfAhvrsVBUvHgppDlIZnueW+j0t8H4ljeno1KaVkjhuzgP2sIhboXSLGd3AICd72+mrcAhoGnB9eFmhm8P/YImxzw4is13KbefdD1/SujMinS0iSRZSwmakzHsm7CRYb/gKbIVCoBZavOFv38P6zz5Ux2/0XYZcL1XDY0hC3lcAIqJtxceYHtSBQEtovQ2YCfJxvetUC8WQj5CuxNtqot8P65eOmV4Y9XdZV/UL9ZaVp42eIiqnajbHa6scDVwEjupZ8jZ1M1MEs5FCJjTEq8xhB0ptJ13HR76u3VCv4RJgnAA4oFvqH+hoBcdY4BBPaJGsDbF1apBzkJamlHsg70CRn/ITG10ifbca4Orptxcgz4jMLbPvmTboCsEy018BIS8bYENxyOlWMuDG+GBYJR92+IwrP5XWFQ+NhqlBWI+g57fPAZpnvfxPfj6dZEOP0bc4J9wzuw3Z3KZOvNlu/WGk9fiPDdmhq75GGY2hXNbCNd0w6lst1RIP7LneUK0vUI8ZsC+TlZ08nB7434VTTvFC7oeVdf6DnUdUrrg9ncIOz183QNQXFX4Lmtl/lTYnsPYKrYl5hwbw7rG5oLVyxWepgPme1jRCkLmP5hxjY+n7debky1WBQyUHVs3eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199015)(66899015)(86362001)(5660300002)(7416002)(44832011)(26005)(2906002)(186003)(9686003)(6512007)(38100700002)(83380400001)(82960400001)(54906003)(6916009)(6486002)(66556008)(33716001)(6506007)(41300700001)(8936002)(4326008)(66476007)(66946007)(478600001)(8676002)(6666004)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUs1SHFxR09mbkZHSU1aMkhGUEptTDNpcFNvZWY5VUliUXdVVTdyalF3Y0xQ?=
 =?utf-8?B?Y0p6QmQ5L20rbnE3ckl2MldETWZSdlp6MjZPK1FlUUpaWmdvMWlsSWR6bHFn?=
 =?utf-8?B?OG8xNWRLSUFlenVjUkVML3h6YXF2b3lNdjFGc3JHZG9PWVl2dDR1ZDJGbUNQ?=
 =?utf-8?B?ODhDY0t6aWIwZk1YbFdmNGxjN3IzaXpKQXdmQXk0WFhZa3BGNW45VzVWWEZ5?=
 =?utf-8?B?bzdoeWo2eTZjMEF3QXZURG94eWJweXF2MFpyVGVidGpkd2R0dUFXZGpvYTg2?=
 =?utf-8?B?YTBVTU96SkRrRDVIb1A4OUxCMGYrUFJJVjN1NThJV0piUXdlWXE3VEcwVzdM?=
 =?utf-8?B?TlVJdUZTRWdRZnBVb0UwOThybExKc0ozSytZRmRYSkxZYnR6VEx2YjRsQU9C?=
 =?utf-8?B?cFNQN0ZvRTljUVBmamJ3dDR5bWVHYUd5bm1ISUZuc3JXdzdkSHN4SFpaUzBr?=
 =?utf-8?B?SzNWMEppemw0bU5vc0JtY004RXFEbjBNUmJVOWxjU2JvRktNRlhUeHFuUHZ6?=
 =?utf-8?B?NW11UFVtRzVOMU9lbFVNSTR3WTdJVkxqTlUvNXR6bFFWQldUczJBMVRFMUtN?=
 =?utf-8?B?VkJySGhLdmFzUTRET0F3dHJJMnUxOFFwY1FIZjJSVGlpamcwYjYrUUtyRWxh?=
 =?utf-8?B?bCtiS3BDdmVLUHhFUFl0bWhJS25CRHdkcVBoc3ozUklGOW44U3J3a3BlRUQ4?=
 =?utf-8?B?VHhFSi9EclFPWnoyUXdpcHpDRXFRdFlOM3NVTmZHRUQxTGRWZXpNRUp6b3k1?=
 =?utf-8?B?Y0lTdDBjaHp3QnU0NGFrcGpiRnpyUlZWRCs2T1llMFpjMVgvWkh6N21qcHAz?=
 =?utf-8?B?YkFZL0I0ZVc1SVJzS1c0MFhmMkgrNzR1OXdkSFNBeW1OYWVrUFloT05CdHdZ?=
 =?utf-8?B?SmVWWWgzUVhkWGhqUWFJWjNPcThaa0ZNczZTQ041M2hHWkVXZU9WZHFqWVJq?=
 =?utf-8?B?Z1djS2xjektRdFBxL1Q5NHBNa2tUVzE5ZnVRMEk1NE1hK01sNSthL0pWc2tK?=
 =?utf-8?B?bWlGbkxRQXhIODB4RW4zMXl6bnIrTllXaW42K3IwcytWWUEyKzFreXpvN1VN?=
 =?utf-8?B?djB6ajhFRkllL1VLVXVCQ1k2L2xROVppd3UwdmdaV3lIbkFtMXZEL2dPSFF0?=
 =?utf-8?B?NEswUFR3TUtFV3EvdGxONG1RMmp3YmhlOHlSbGNLMUVlUzlrV0JRemJLUmNx?=
 =?utf-8?B?c2lqYVM5eTkvRk9lUTNVMTkvUmlwbDA3YWVWODdOOWx5bWpoWjBFYXdiQTY0?=
 =?utf-8?B?cmlVNEloYUZZdUcxaUJIR0ZaNGNyOG9wemhwcVY0WS95T0N0RHFxT3JlRG9C?=
 =?utf-8?B?S0RqYUljcWZjYmNNbVBOOEhhb0JpRjl4V0VkMXFsWUdJZStrL083b1ZZaDkz?=
 =?utf-8?B?akRQTVFYZmI4NG8zai9sM05saTNwSjJWRXVEWG1KcGs1RTdWaDZJQXdpRmht?=
 =?utf-8?B?Mkk0VUFIZlp4SytaTHZpaU00Z0x4eDJwMG52NENBdWxsL0h1S2pxb0FwbXla?=
 =?utf-8?B?a1M1dVptOERWcE5jOGJJb0pZRzRGRXJkQnFzQWd1Qitrdk1iOWxyaVRNUTJT?=
 =?utf-8?B?dE9LMnBieDJjZ2d6MFEyY0tPRGRjaDRNRVZTZll6R1FRWnJZdDJFVnlTZnNQ?=
 =?utf-8?B?ekEzOUwwbEFpa2hEdTFtQlc0eDVGbC9xTGVoNE1sYWtuNUxuRGYyamthb2Ev?=
 =?utf-8?B?bm9mbzIwaHV2a2lrVk5wRDJUWW4xZWFWRFU1ZHZRTU5wbkQvU1NvSUNtM2NJ?=
 =?utf-8?B?M2Jnb3FNUGZ1M2h0N1I5ZWtvdEFkVHhmNTRYZFlxcU11c2dSY2dIYnU2MlhM?=
 =?utf-8?B?ZjBEL0lvQ3VONGJST2VNYldSY210VmNXSDBNZmVOOWt4TWxuYXdYOS9aVTJB?=
 =?utf-8?B?NUxRT3prQ0ZwbkFmNzJuQ2RTYjhpSFkyY24rNzUrM1JTWE9TL3gwNFlWeUI4?=
 =?utf-8?B?NUdiaEo3YmZGSDZjVVBuRGhhSktoUjAvQ0pIT1kyN205NTFoejRIbGt5SS9X?=
 =?utf-8?B?SUNYdWxGMXFBMFNYbEdQcEpWQU50RXhJUkt4ZzBUMVZ2M2JxWHpvV3Y2UzZG?=
 =?utf-8?B?UHcwVFo2Y0tJdjBJT2drWDZXZGtxMG9yQkliYmhUTE9ISE1JWVFqV2JvaUR6?=
 =?utf-8?Q?VWUeylH8WgO8FijljNnJb9yCc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45688f1f-eb30-4b10-054e-08dacc4b18f3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:33:34.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRULEFoLB4rH28M4zG1YJqlF1rCg3birLJOCNRfGh6AvpD5AJFOmEI2dgozhiwB4mB+m9TZukN6VHnAUWEtKkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4963
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 12:19:38PM -0800, Andrew Morton wrote:
> On Mon, 21 Nov 2022 21:50:23 +0800 Feng Tang <feng.tang@intel.com> wrote:
> 
> > +#ifndef CONFIG_SLOB
> > +#define is_kmalloc_cache(s) ((s)->flags & SLAB_KMALLOC)
> > +#else
> > +#define is_kmalloc_cache(s) (false)
> > +#endif
> 
> Could be implemented as a static inline C function, yes?

Right, I also did try inline function first, and met compilation error: 

"
./include/linux/slab.h: In function ‘is_kmalloc_cache’:
./include/linux/slab.h:159:18: error: invalid use of undefined type ‘struct kmem_cache’
  159 |         return (s->flags & SLAB_KMALLOC);
      |                  ^~
"

The reason is 'struct kmem_cache' definition for slab/slub/slob sit
separately in slab_def.h, slub_def.h and mm/slab.h, and they are not
included in this 'include/linux/slab.h'. So I chose the macro way.

Btw, I've worked on some patches related with sl[auo]b recently, and
really felt the pain when dealing with 3 allocators, on both reading
code and writing patches. And I really like the idea of fading away
SLOB as the first step :)

> If so, that's always best.  For (silly) example, consider the behaviour
> of
> 
> 	x = is_kmalloc_cache(s++);
> 
> with and without CONFIG_SLOB.

Another solution I can think of is putting the implementation into
slab_common.c, like the below?

Thanks,
Feng

---
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 067f0e80be9e..e4fcdbfb3477 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -149,6 +149,17 @@
 
 struct list_lru;
 struct mem_cgroup;
+
+#ifndef CONFIG_SLOB
+extern bool is_kmalloc_cache(struct kmem_cache *s);
+#else
+static inline bool is_kmalloc_cache(struct kmem_cache *s)
+{
+	return false;
+}
+#endif
+
 /*
  * struct kmem_cache related prototypes
  */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index a5480d67f391..860e804b7c0a 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -77,6 +77,13 @@ __setup_param("slub_merge", slub_merge, setup_slab_merge, 0);
 __setup("slab_nomerge", setup_slab_nomerge);
 __setup("slab_merge", setup_slab_merge);
 
+#ifndef CONFIG_SLOB
+bool is_kmalloc_cache(struct kmem_cache *s)
+{
+	return (s->flags & SLAB_KMALLOC);
+}
+#endif
+
 /*
  * Determine the size of a slab object
  */
