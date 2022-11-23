Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB65635CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiKWMUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiKWMU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:20:26 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4779F3FB89
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669206025; x=1700742025;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HPzv4OaUkVMuDaQu5/HA5goit6cVrEy1OeyVF6ik88g=;
  b=iCMptPNp4H5Z7R5o92EBCuvzmkWR7uF3nBh6CVyyXwbYRk6kHpDlRPM6
   Qg/IvA08tk63ojxo4eJ+eW+iLN8rivBMj+O2ZzxGO7aLJj817V9KyJ5Cs
   7NCeLirAofInu0EcUOMHetUG2NYdg+X0uNyZu2HUr0JdUDwyUMEmC8XE9
   XLhyMxvDZDgB7tj1youKhsQqwSiD7q5L6VSv33/2AlyUzFkSx+GiJCE8L
   jSZ27VrcTXz/+inmB0LBL6vp3xeX0uoOeyI71SbRGQbo1xOwpt0eWAA11
   dtXQ2BYQyjDzg1y9+t5P22IylNxw7esJpKug1jvpdVRpk+vC4lfpfD2+m
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="301612646"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="301612646"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 04:20:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="970846417"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="970846417"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 23 Nov 2022 04:20:24 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 04:20:23 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 04:20:23 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 04:20:23 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 04:20:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9aCrcO1bXR+MB0Zg2iLo6KyHjoJTYmVzBoA4WpPSR5ukTcmBN6TeZNALQbtvreooMg3u8FD9t8do+8eA+PAKv705F2WpZrFdnsJYBubmpjwK+R7OS29l/cEthi94EVEJK/pHwPo3crasCnuvVLd8f6pRtaSdpxhsAhA1XlYPq55OM9LR/USfXWbwrjj1wCifZDbP6yM/qUDaNtm78jCSA/zTVjOllsjiyXrPxCVAxgpSGD2WDozDjgYzSebWKRcZFHM+vYLZRB9gOX1DJfv2Tg+NP4bllfLpfSwDlKUaViWgTMxz3udzm/L+oc+DjyKo3N7SNzbx9cpJ3NBR30NEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3fy3KWRBy0IOiglOvrPdSzfwnzDXE5l9miqLPvJ2NA=;
 b=gaEN7YF6IdUUk9ztuAizLCY7vZCxxwg2AK3OSAnmIikM9+oP/txypLSf64I+GY7sJqVzF55EV3U5nvAA+tOdUH6od8PbjxH2uMQKW10ZsZFqrh7FTGApDEot+USXRWXD6zVSraaiwrgoOaJztlMde/r9JFZfTjdkEBVMfp/GXcgucIETG+b1c7LU9cCVuh+Fx5sC/nWD83M7QpWvJmy1QCGCUqgf/ol35r78plEFHhxX8seMChGX5w8kIsVmqmbABKFtYeERzI/0CHJzkhiSmT9vv8kx2wb9I03O0XKxCKohLdHx1BP/5AhCJ+y3SYgJCwhoR4tkq+5A1YH+LWzScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ1PR11MB6177.namprd11.prod.outlook.com (2603:10b6:a03:45c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 12:20:15 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%5]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 12:20:14 +0000
Date:   Wed, 23 Nov 2022 20:17:05 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "Alexander Potapenko" <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        <linux-mm@kvack.org>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 1/2] mm/slab: add is_kmalloc_cache() helper macro
Message-ID: <Y34PQan6HOucgj4M@feng-clx>
References: <20221121135024.1655240-1-feng.tang@intel.com>
 <20221121121938.1f202880ffe6bb18160ef785@linux-foundation.org>
 <Y3xeYF5NipSbBFSZ@feng-clx>
 <74d14df1-faa7-dc12-d406-ba038682e134@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74d14df1-faa7-dc12-d406-ba038682e134@suse.cz>
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ1PR11MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8cd41c-1e83-45be-00f8-08dacd4d1353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VeB3KOFS/LVRAYJHZbsm8L6Xl2mqhnQfG+PVCqcrZ1wEEdGIxFC4N1DmwA0CE0ekX3zI5fU8jf2rs8BqSXf30IVqRV0Qi2FGDLntodzMLkE/b5Idhv0G3gqI/pc58nFPNzfdu4Jl2Jo4WFwPAa9zNrHf3U3TeSr0LhhEtF97PZgKXwH3J+RB3KqjKkfWTUXxGt6+zs8/VfvOzBVX89K7fJLj7JvCQoHQeXcgdNfOlMz1E2ebTodFYCfAwKKKGqN1jFzGwyYjNF+JyfAAKcobk/D6MZV0/sVOa8ErdRCqPimKFMs0Rzk/+/xkiFWJ+YJ49v7jXvP84ZyfGv+HGXMRZmgVNt/poeMvmrByNFSpoStg87chDh3CyxJX9sYvgsBKWuOVxMi9X+KAqZlidz1gJ6bUsMejSx8wuXjX7tnJiKC3Nl0bFXkveecPTButJYJ5y8xEoRDXo1/v9ibpqxrQbhHr0IPeRQRG6Cv/56cQkqzCrPBuokhFHo3rWy06hJXrQOM6m99ezp/HruvixSk+kRgB7O3RlMqPTcg+r5wkAfsOAU1J1x1T56QdhjQs1P0XEZU/hhLCBZHlVr1xAp1DfeBlOIFHn6i+Fq/BOEpVTR6YlV00GoEWGLbWuFX/u6nMVQQ52nL/nKF/WZTjj0lSdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199015)(2906002)(66899015)(44832011)(7416002)(5660300002)(316002)(41300700001)(8676002)(6486002)(66556008)(66946007)(66476007)(8936002)(110136005)(54906003)(33716001)(4326008)(478600001)(53546011)(6666004)(6506007)(26005)(9686003)(6512007)(86362001)(186003)(83380400001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFNHTWVQNVZMZ2MvRzkvTzJqL3VkME1pNVBBemdEc1RVYzQ1YllzK0M5TEJC?=
 =?utf-8?B?bGJSSmRhTkhZWVEycU5sMGx0cmdGUGEreWxJVmtkQWJiODZoemVHb01yL05G?=
 =?utf-8?B?akhIZHhZTEJlN3RmMExqSmhwcDhWc2tEWERycXdDZGZCU2RXZFl5ZXgvK3dW?=
 =?utf-8?B?QTNjaC9MR1h5S0JwT2dmY01EbXlZNEdHREJYK0FLckZGSU9DWU9LK2cxc0Yr?=
 =?utf-8?B?bTl1UTFFU3EyVHhOWU45OFh0VGF3ODdxUDQyZ3RKa3hqQWdCVG5ISEt1bm9S?=
 =?utf-8?B?QVNONG9oWGtoaXhHdndrdFU4TC9nWmI0NzhQQUYzRnhSSG1GemRhQitOeEpy?=
 =?utf-8?B?UWY0TkR6WjJ1amNyd1RXRGd6WkErNUNCd0xQMjN1ZGVPeDlsZE1Gd0h2TkNu?=
 =?utf-8?B?cWJERCtrWVZua20wZzY1OTVLUnRuRGRheDBzU0o2M1RxMDQxU2puM0JhU3Fa?=
 =?utf-8?B?bEt6Mlg4YVVjNTFIU1JFOTB4TFY4eitpTW13elhneTZPRFhOYkl3aG56WGlu?=
 =?utf-8?B?WWFQMFYzbjVIZlBrTVkyVlM2RjZCaHM4WXYrN1gzTWFoWUFRcmtLQWVtdW44?=
 =?utf-8?B?Nm1KaHFiZDcxelpxSFJWZTd0ajR3ZTVVZ3JNTUllTnpOVmw3RmN0SEFpWTN1?=
 =?utf-8?B?Y0JldkxYZ2psdGdtSmduRmRwZi9JcHhTRnp4bEU5eldlMWh5ZUxhcWNUVSs0?=
 =?utf-8?B?SjgvSFVSbXdkTjkzNGVha3FEQXZKd2xpWXE0RG9MNHowNExMZno5QjFtZG55?=
 =?utf-8?B?dWR0elRiUVZqVk8xdStncjY2K041MVlyQzIrZVZ4cUFEdWNiNEtNVmlBLzV2?=
 =?utf-8?B?VDBZUWZONnljeFh3bGhLa1FsSjc0bkI4b3h6ZkRmOXJXc2djS0lLdk4rRmRh?=
 =?utf-8?B?NEY2RXdNVWZ1dnlwbGhPditDS2VIVThpdi9uTFpsay9uSUxpU1BoY0pHV2FS?=
 =?utf-8?B?cW5SOVdwN0k5VXc3YXloZGJlU0pNQk82UTJnRUFKTFlFWWhWTzZNenNZcUR3?=
 =?utf-8?B?Nkxac2tFUjRhYjdiL3o2M0pEMDdmSS9OdXhIaHE5T2JzMXJMQ0lyUGNyeVFm?=
 =?utf-8?B?ZmhhRXVSWFJ1ZForbzlKWWxpTVRGeThVd2E0MW1YNWNIZEJNR2RWekc2UUNT?=
 =?utf-8?B?U1V3OTdQNkRZbnJRbTZ3cWgwckQwZnd6Q1ZmeGw2NmsvMmpXbEhreWRsRzBw?=
 =?utf-8?B?OUFCYnVOYU9TMmE0OTZLUUhZNC9KZkFDWE1kTWErSG1KQzRnSGtJS1RiemNQ?=
 =?utf-8?B?dGVONlZkQlp6ckpXWHJaM0tteFkzRlFNYWQzK1B2SVpVRXZXTmRPTEJQc0ZH?=
 =?utf-8?B?Qkw4eFN0KzRWZWRwTW9XUTB4Q3RML0VUaXRMbGRnZnYyTkJqZkZNVUdSSWNG?=
 =?utf-8?B?MlNHOTVlNm1Cb2FkTXdqSU5TcjIzMG1yRFpnejI4YllvUDFoN05RYjBTcERX?=
 =?utf-8?B?QjN6YXd6SUhISHdSR3ZUbFJiTzBYbnVtYUppN056VWd2dmNUYnVrejJ5MEtu?=
 =?utf-8?B?M0t5Z0JkRDBMUlAya2xYM1JPYUFINWRsQWUyT216TDVackFRb1ovQ3ltbDVn?=
 =?utf-8?B?M2tiMmhrTkJJRWJhQmVQYnFJbklacHdiemlYV3dJdXI3YmtucGlVVGlBRFli?=
 =?utf-8?B?aHZTRHZhbnp1RGtXcmxvKzN4enZ1dmZ2bHZjbW9Dem9uNkg0MXFYdDQ2VWZM?=
 =?utf-8?B?Vi9KelFpM0RXZWtIRm5xOFFNWGdyWEYvNGhyWUtkZytMQTBVNm5IK2prV0hz?=
 =?utf-8?B?ck81blFyeDMrMWdVMkFWVExaUmFXRlVXVis2UUNXUVRPLytEWWQ4Qm5Hd3BF?=
 =?utf-8?B?VW1rbzd3K3BQWUtEME8wMmRocGZLdkhiNjJ2UGFGakp3a1dhcENGQ2IramI3?=
 =?utf-8?B?Mk9VdkFoUmlaajVsMTJWVVpuMTI3c2tHQ2VnaHl3T3E2dEcxSjQzM0tFSnBJ?=
 =?utf-8?B?QmdHZEdHSlF4RElLM01VNTg0TnAvbUNLN0hobWlZdmRLM1lNSWFmc2plbW1E?=
 =?utf-8?B?V285Qjg4NHlUOEtCcHN5WDliVmRFOE5NeDJERTlxMnJCdm9GUitZdkJoVjUx?=
 =?utf-8?B?WXh2VUJkOGdCRnVxK09GMEVQQ2lOREdWbkJUUEI0TVMrM05FQUNKenJYbGRN?=
 =?utf-8?Q?+vyjlghcQZd/BMzET6Mn1C2eX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8cd41c-1e83-45be-00f8-08dacd4d1353
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 12:20:14.8290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCs6aN2lq543Ij+7SsxXSoV5rlI7xRFvyTr1AFubfIRSK4HHfVRfw9/F2Y1KcWBVKuMh3m+V2u6evMyrRH3LQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6177
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

On Wed, Nov 23, 2022 at 10:21:03AM +0100, Vlastimil Babka wrote:
> On 11/22/22 06:30, Feng Tang wrote:
> > On Mon, Nov 21, 2022 at 12:19:38PM -0800, Andrew Morton wrote:
> >> On Mon, 21 Nov 2022 21:50:23 +0800 Feng Tang <feng.tang@intel.com> wrote:
> >> 
> >> > +#ifndef CONFIG_SLOB
> >> > +#define is_kmalloc_cache(s) ((s)->flags & SLAB_KMALLOC)
> >> > +#else
> >> > +#define is_kmalloc_cache(s) (false)
> >> > +#endif
> >> 
> >> Could be implemented as a static inline C function, yes?
> > 
> > Right, I also did try inline function first, and met compilation error: 
> > 
> > "
> > ./include/linux/slab.h: In function ‘is_kmalloc_cache’:
> > ./include/linux/slab.h:159:18: error: invalid use of undefined type ‘struct kmem_cache’
> >   159 |         return (s->flags & SLAB_KMALLOC);
> >       |                  ^~
> > "
> > 
> > The reason is 'struct kmem_cache' definition for slab/slub/slob sit
> > separately in slab_def.h, slub_def.h and mm/slab.h, and they are not
> > included in this 'include/linux/slab.h'. So I chose the macro way.
> 
> You could try mm/slab.h instead, below the slub_def.h includes there.
> is_kmalloc_cache(s) shouldn't have random consumers in the kernel anyway.
> It's fine if kasan includes it, as it's intertwined with slab a lot anyway.
 
Good suggestion! thanks! This can address Andrew's concern and also
avoid extra cost.    

And yes, besides sanity code like kasan/kfence, rare code will care
whether other kmem_cache is a kmalloc cache or not. And kasan code
already includes "../slab.h".

> > Btw, I've worked on some patches related with sl[auo]b recently, and
> > really felt the pain when dealing with 3 allocators, on both reading
> > code and writing patches. And I really like the idea of fading away
> > SLOB as the first step :)
> 
> Can't agree more :)
> 
> >> If so, that's always best.  For (silly) example, consider the behaviour
> >> of
> >> 
> >> 	x = is_kmalloc_cache(s++);
> >> 
> >> with and without CONFIG_SLOB.
> > 
> > Another solution I can think of is putting the implementation into
> > slab_common.c, like the below?
> 
> The overhead of function call between compilation units (sans LTO) is not
> worth it.

Yes. Will send out the v2 patches. 

Thanks,
Feng
