Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD366625561
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiKKIdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiKKIdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:33:06 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0407E981
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668155586; x=1699691586;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gREuau1ZIFlVxxBJZYKXYlVC3QhBgvLHaHmjq31fM5U=;
  b=Sh76OZ4h9Y5llbkjygtOr3mZzxcZi18V/gCkezL73EvuYPePn89ezqlh
   cunOchwEmUeOI9OnQyhFhSbl6fqvKoQsch+/seyndGZwXxfMZWR+ofHIy
   N3bnEEgMHKZWzIw2LFimV0psUZSGEXYwwkCw3MOI28aZNBlXmVADIh1c/
   EXfVaPR4abpPtKw8Jwh9DaWqnCkKI0JsHq3tPg4JsSM30ZTKJzY/0BZjc
   BDKa5d+wbpl/L+XvUrTDnE54tjQC+ymr7Y299aCuDvdWZde5ZTZ22w2fx
   IoT8hq8SBFmliZHzxA0FKuAxPiuaLBcqcKqjYlVvRULNkLzDJS+9p/dS/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="294915083"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="294915083"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 00:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="615423560"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="615423560"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 11 Nov 2022 00:33:05 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 00:33:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 00:33:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 11 Nov 2022 00:33:04 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 11 Nov 2022 00:33:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qrq5P9j2u6mgMUfUL+Chr5R0hPex0cTRKzMUOoCFTX/L4+nV11QivrPtcIlJOAl3KmKvnkCDI2YNTge1wRmHmI2GcBhGL5od51JsmJ+24+8ILBxKBE6IgtrrFrDjusGCikrjNL1y8GrYr5eyF60CiaBy46ZqZIhOUk/1dwJ/aynPifCLCJlgJavRRBS3HYdPdVXm4fvNVX+uUGZBBJzm9VkCYDrdsPLuj5zwhWpTvBFjCkEVZbQmuc95SfX2TLPRFDAGuviFH0YwSLHGVVbTq0nQ3uHcArLHdjAlUHoZkUOYrL8ej1xosC3EdhAj8vsR+GL5dUjMb/g0XXHZrVHhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELtJPQP2atiOLXmD8Se9LjPtYEfHHH2Bkpef02Hw5Zg=;
 b=clVB/alE6/nzZhOtG5De2In+TnXFvFY3m0uRuV27CGMC+RqzcH0qKTeWR9Gn18FECbzItoo7e8VWBIPQrTdk4yshieyWUnk9tzasDdM+FM/mzyyWrLbio6R3WF9GDAAgvFBy0nZkslszbMiMtS4saie4xIf6LUUcfdQKuYhyTWaySXsDZYLqy3D0vA4Jee2k9cNlnnir0n5ddWhejymlUVbly+adZr0PuTrkYWmHcqbFxTdrLw5hdGfc0DeiJ96UoWeFWCWjAfcdH13XYkkc0PsctU9CrMXM1uwqHRAsGKlFgTTboyeR2rPDAv+d4bgIiYZOekk/Q2LtVaZqtlqG+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MN2PR11MB4599.namprd11.prod.outlook.com (2603:10b6:208:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Fri, 11 Nov
 2022 08:33:00 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 08:33:00 +0000
Date:   Fri, 11 Nov 2022 16:29:43 +0800
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
Message-ID: <Y24H998aujvYXjkV@feng-clx>
References: <20221021032405.1825078-1-feng.tang@intel.com>
 <f9da0749-c109-1251-8489-de3cfb50ab24@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f9da0749-c109-1251-8489-de3cfb50ab24@suse.cz>
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|MN2PR11MB4599:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b3ab60-46ec-4f97-a333-08dac3bf5686
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJN03ZC6UDm15+SJqWon3Cf/Jix7tjUGJ/DShJ8BJ1n4lW69iQ4xmbtU6kLCvu9e6Sou4CVjCKVFwUJQYxyOktHGsWP5CuMnl6BE8Ei+D7bMhQecFBy3mKGZ+srVqEOORhJHGqXLF73N+0f/DP5GK9L549g0Luo2tiCa3sJOLSeTgE2oDFr6J6Z3MK3zxsfC6RTWXpLheLtTt0DBi5HGakUjBei4VQ0jp8hPwDavdikkzN0PS4ba44m37Kolcr2RNtpnVboiNuk7wYLpMqHf/WYvv69DmhITl81yDVPCmD8lKqIhvCrOr1A44PvmnGOsosBASEiLtrQVsbHayH8TDC20mVfsR9HMvcls90y1b/RvwPetd7ri4QRU1XTop3SOq2xRXfbZcgT3smynWXS8nma5k90h3eyuH1MUb3IsF8ST474zY5pmU9WaUdKMOouZubVWcHg8pHD8xglzFYbd3X4jn77QogeQXLnrNW360aOgMS1CBAwMbhObdVYwmkbr1mlWxZac076xXVLiPkYrdZXteDdS5Vkp20Ccc7XfiYMzqJKjSJYaXUoUMmFQnl+0mQBn6IUTpVnlWjXZy/HtXVeKjozL9NUQCQmagRF0tqOjuJhbWllep0Gz+yH/tQzZVJRe1Hx3G8X0tRtQa9ht+XLkbD7QEY4lYH6GJaDkglYPvcMvRUxeM/H5qo7BtT8vtrQtMpBl3CzCTAxjGNDVew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199015)(186003)(5660300002)(7416002)(8936002)(33716001)(6666004)(53546011)(6506007)(316002)(6916009)(41300700001)(54906003)(9686003)(4326008)(8676002)(26005)(6512007)(86362001)(66946007)(66476007)(66556008)(478600001)(83380400001)(44832011)(82960400001)(38100700002)(2906002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xp9NVgGXR9FlqHlaoHaIOoUaRgQQ0iHu/dUS9cXxptNqw8+Psn4iIglJkasT?=
 =?us-ascii?Q?YefeQSLDOcHNOgz0alTVMS1Ve3ta1IiAmYCqUvlwvto5KQlF4X7M+fll+nCh?=
 =?us-ascii?Q?T+cFoL82jDxCASFm3u1v1lQDtjcM82SmYj2yexkYC2RQf11yMq4VFLDXJ1KQ?=
 =?us-ascii?Q?MB4TK+alIUdaH83jXDDKdVpjuQP7DJD4spuDrsGlh8Ho7wICIAyvzbcCnvcP?=
 =?us-ascii?Q?bMz7j14PJMwcZ7rspsNaMWck2920unvWiKPR/DuuCLxPYmU1N7ng3DsQZG1B?=
 =?us-ascii?Q?/Et66srIo9oUOhN6MpQEKMjOC0z3DPQ0TdflYhSrZ4WwAPr2tUamQImoIFoz?=
 =?us-ascii?Q?Eubvuu+2GwTLIQrSFNnfPZemVd6zpxhKeL1CSs/CBmk51Lf7rs19++4bwQU1?=
 =?us-ascii?Q?jnAQJVz1ODFyP2u0uQW4FWC0zy+4D5A78QX1C4ox4We9NS/g2oQsZJ0WElza?=
 =?us-ascii?Q?sBeBzYJol8J7ZEnEzI8+CX6tdtUBsAvzmQHF2VRqUkEzUxVmLX4DQjRSU5xm?=
 =?us-ascii?Q?ZqJ9V/2obxAN+7QNap+jrwNesXNWe/QfKYGw8R1Bc6LInes882X8biLRvoaX?=
 =?us-ascii?Q?P16GCvdufmRgb+n+W3yylaV3kxJ9ewaiKAE99IBVmmbLuiEHwp+wDAX3qWvl?=
 =?us-ascii?Q?ItYby639Bxmditq5FMWt6CLDDJOI33BC2l4l+b5Yy7Q9bI2dwDSQlzRvCh6C?=
 =?us-ascii?Q?WE23FFO0CfKStulqU0mL937iuzVLEeLJPMr5vfRLMf5lpwowM0Az8jlE2m4Y?=
 =?us-ascii?Q?d8Z2kYBY8OWl7Lu5uCcrlaBs39sWFjXCiVhZW5B8FywiL2Ep9/9HC1I/sYOI?=
 =?us-ascii?Q?1CwFlujC1OcRL8u2CkI4IAWF/N9YW7VLXWg6OzejSo64PiXEXPzebpIVBtcT?=
 =?us-ascii?Q?Z5WOMr+zdWcunm5f63NF3oerMLKre5PImU+h7Sk+barQ4l1YXXsXcLP+mrKo?=
 =?us-ascii?Q?3VFQ3FwioaudAMfALf7geDvzmI7Lb4y14V6yc750YczheUS59XyQ8/Hw5aJG?=
 =?us-ascii?Q?hpmUlCBXr1FXSfg/Yr0GgpGNA/HYZo01X8C+phElTv/PrrKhPe4BL0OVxGQb?=
 =?us-ascii?Q?xtmnrJgcDIZCLiNNu5LFysJM9bOCSRT1clM+J2BTfq4pPlcHp4uL5nPPdV7E?=
 =?us-ascii?Q?a20Eb5Fiv2sGAA5M13C98naK+WElOpEwUG+HPjcgAf0geC0/VSiOF9ubb8UB?=
 =?us-ascii?Q?bRvEHC9ngQSpZcifqZ936HgGxBH9hmcMjX2P5uPqLn0fqNqBtpp76x0EMNpB?=
 =?us-ascii?Q?yb13iH7XFNorSxBFvSqYzAT0B+u1kus9nzSk1BhsJVkvsJd45MVWQxy7fm4E?=
 =?us-ascii?Q?dX8wgLXkSybqq8xV/KvgogRPiZKEZerDwhaT3tHF67LEGKB+yzEun/2HVawI?=
 =?us-ascii?Q?IdOw9RFod7wHe9J2eIwG+CUrhTuBJrFl/6eaCxxt6gh4rxq4E3ozJG2J7zeQ?=
 =?us-ascii?Q?pvphbVe8ZKq84H4k5JbNzVDmarEqpSKxkuRV5qOYOMUK13hfyM100hpmuN70?=
 =?us-ascii?Q?4gmsC5NiJU0llpoJ4kZ8TrXJY0RhlUlY+7o1Uf7GgcI+Zj1SJvuE1xL9aSJm?=
 =?us-ascii?Q?nkJHswfMlJ3b+5EcM1rYksJ2aMywpiTIZ15bBLZB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b3ab60-46ec-4f97-a333-08dac3bf5686
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 08:32:59.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ccFgd5oJm9uqkEauj9Ac4ZHocn1Vw46RsU1glAdT/vl7uSqGo4ZfQ52vMNy2e9YLSMr7XDKjuxVAebb+ixx5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4599
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 04:16:32PM +0800, Vlastimil Babka wrote:
> On 10/21/22 05:24, Feng Tang wrote:
> > kmalloc's API family is critical for mm, and one of its nature is that
> > it will round up the request size to a fixed one (mostly power of 2).
> > When user requests memory for '2^n + 1' bytes, actually 2^(n+1) bytes
> > could be allocated, so there is an extra space than what is originally
> > requested.
> > 
> > This patchset tries to extend the redzone sanity check to the extra
> > kmalloced buffer than requested, to better detect un-legitimate access
> > to it. (dependson SLAB_STORE_USER & SLAB_RED_ZONE)
> > 
> > The redzone part has been tested with code below:
> > 
> > 	for (shift = 3; shift <= 12; shift++) {
> > 		size = 1 << shift;
> > 		buf = kmalloc(size + 4, GFP_KERNEL);
> > 		/* We have 96, 196 kmalloc size, which is not power of 2 */
> > 		if (size == 64 || size == 128)
> > 			oob_size = 16;
> > 		else
> > 			oob_size = size - 4;
> > 		memset(buf + size + 4, 0xee, oob_size);
> > 		kfree(buf);
> > 	}
> 
> Sounds like a new slub_kunit test would be useful? :) doesn't need to be
> that exhaustive wrt all sizes, we could just pick one and check that a write
> beyond requested kmalloc size is detected?

Just git-grepped out slub_kunit.c :), will try to add a case to it.
I'll also check if the case will also be caught by other sanitizer
tools like kasan/kfence etc.

Thanks,
Feng


> Thanks!
> 
