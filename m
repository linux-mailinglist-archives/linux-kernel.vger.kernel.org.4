Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D085B2FED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiIIHds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiIIHdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:33:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59402B40C4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662708821; x=1694244821;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NU3l27O2M8Wy5wrY5Ufm+5l4M6hq89ugXCS96aUmvQs=;
  b=lDkWcKSqYyKMHvhnsQ2RoHguTqS6Ht8XkWdp9UeslI6ay68WJH+BV7BJ
   Gc/2O+e4dj0kLTWfrAMoDPbid+WFI84dDsHiYG6xiY5lE9DbK3RwGLKJE
   Iuo/Z7qEKP/mFuW0LosF0oIzwU4DlGVDKDlvj0gNssIRR8CrW5FvmIysc
   nSLHADR7bYAIxWTgUWT3iImFg6lrevEWf4y0h7tOrAOHBbECHHv9dd/vs
   6+OUuRTS2kWEzIEtHrH+XSiVGE1930LcPhwfZ6uEkNBGyaEAX9dZQP00P
   w9VQwCOr1eiq04Qlmza/IhXwNAWIbtnzawENgFXagy8zZ1f0CNqVcTMGf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="383712739"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="383712739"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 00:33:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="566275191"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 09 Sep 2022 00:33:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 00:33:39 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 00:33:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 9 Sep 2022 00:33:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 9 Sep 2022 00:33:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtAbZqlwdz9ATnj+9Mvcba9SgVzSM2VlaEXftZ4XlJ+XNhWAGsm+O//DHeQ1bjAp9fI1ujbvQtFUnfj7tPfdLo9lbd3aI+K9vCVDcdWn65VVbublSHvmCNENAI6Cf81PVssNh2Hyz+R+c6V7/bSovjb2koQwoeaenva6W/GfF8PE90K4b9xRIhKEiPuns15s1c9sEPH7IRqdl1E4L0WvrusXQUWaX0Ek7RHetbEmsNd/+gT6Zli26AMQZs3gKel6n+2M0j5FsrO9PRY03s25B9NSqRljN3L7BXS8G23foLkTeYEYyWS28KQzIVp9QVhW0ytdNmfAriGkHtIXuM+uNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwKIZBs1W49RVra2C/QKEJgJ7jgsCByNlwqxheEIcbo=;
 b=eg03JDR/Yq/+F3lK0eTWPpQNnvpbCxTt2nUoY08Eol/0/UlOEL0pptAsgcK+aFb0M98/1BOhWtHCGV+2Wj0ChKS7L1XVtfLwiuD0d/hOySDLQwFFNW8/sDd4UWNR7rMnqdcN9cKO8PAA+UiZHwPL7PjKihTFnSt8Kiwt4N17+iR01yK8UGgAC1mXGKWWTfXpTHQSdnp+zeOOFyBeX0UKuPod0DapSltR2yVY6WK83pR0gofNWJoa/xQOs+S64swV7f+ZMsVlEj6pu5sPRq7Zp01ixhZStGxX0amYcl6zNii4yh0yL2SIm8WlLiRh1mFUz22LlD+qIcmSYzTQHoXtqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Fri, 9 Sep
 2022 07:33:33 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4c8f:1e3c:5288:d77e]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4c8f:1e3c:5288:d77e%7]) with mapi id 15.20.5588.015; Fri, 9 Sep 2022
 07:33:33 +0000
Date:   Fri, 9 Sep 2022 15:33:01 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v5 4/4] mm/slub: extend redzone check to extra allocated
 kmalloc space than requested
Message-ID: <YxrsLc23lWFZ5H4X@feng-clx>
References: <20220907071023.3838692-1-feng.tang@intel.com>
 <20220907071023.3838692-5-feng.tang@intel.com>
 <Yxrcmk6hSvHBCGNo@hyeyoo>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yxrcmk6hSvHBCGNo@hyeyoo>
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f142a764-bcc6-4615-3905-08da92359986
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ReUTwQgrDQQ+UO1ESoTiSk/zh01w3K6kGw07PdOMVLlac10JNK+spQPiiz8fQsgyQlRrUNQG+BMieEZZ7i/UP1ESnXs4SYyM3cbkjUZmkkSzHHJE9wDlnEPLbmW50ger/W2Oq64I+IhjfvM2CPLe1ITWSnSamtHycefS1rlldYzmMIOl7reAIqTphTU/Yk6KeQHbpbjiX0iywINGD6zBwWcMsYueScUjuGMq+uzELEgyhaToMPHPctgukd8hCaetNy7h3rw7ZSCPqQSr4EbkVd7DJo+sQXg4Nx9YecC92FgQ+F4bWed0bwRchKwh3CEVQ6v+hv40NfrCwA+tOC4yH3pm6weW6rgJetxdvzeJe3IAPiEEND5aBFBbSGR3qZMJrZ9IxejLse+h3LlNb23LnuPi+3iPNLXWEWOiqPVT/9y2RPagf90jD1hD25rVQU3wzw7OnnHkSZIfeyJMR5raAzze53TlyCvhFDYdxrrMSZW7T4lub/apgVzqEz3ZbNOjKndePfPfEGJaL1m21xOf71gyl6tHCJI8fKjPMhH4VFeptXzDXvdYd/EDMIfyuqjfERfOJMsJg198RS2G75PrdigqXZktS5GaX+ygFV3nWjo4oVjKGJospqiEATpIGC89dPa78GHepntlsNiOb11cjE2BQif3tLd925EAXKOsz14nqVke9Wgz5VzWG7wpwnpkhvNfrxwfdMe+DYhMSTvdXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(39860400002)(376002)(396003)(366004)(7416002)(82960400001)(44832011)(2906002)(5660300002)(6486002)(478600001)(8936002)(41300700001)(38100700002)(6506007)(186003)(54906003)(6666004)(316002)(6916009)(66946007)(66556008)(4326008)(83380400001)(26005)(8676002)(9686003)(66476007)(33716001)(6512007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HRcJmdsSypecUjZ7vTfZVoBxJx6CfFvOXhEA09dw2d2Sa+R8J3eEAIxybxjH?=
 =?us-ascii?Q?wofEiD9Tczeqj7gVpdsiS1Ro3mtzSzpJWe2IEnJdzqUeEqajVaJxe0EqezLd?=
 =?us-ascii?Q?Naw0Wo/lsNq5rNB+qtiAjpid2JIE4E3MTe181YpqyWpoNt6D8+p4pM/er/Wo?=
 =?us-ascii?Q?nJSW0YY4eKpp6Qab/+Q8rH+sIFVI9F/n2C3RJQHz7TW735lgPsLEgNEiDmw7?=
 =?us-ascii?Q?P9qb9YAKCvtYOgt/G/1pLhJfHUWEZObm+183jhuCTYdqzw1MTc8lOoiWhhZB?=
 =?us-ascii?Q?kRY6/pkBETaoUH8CL3Sf8K7RvmtslWMCUbHQEyxAi7ASaxdiUXz7ZJIJV0qI?=
 =?us-ascii?Q?fdihBQKYK5pl0U5t+4bgQzWPsvOE0WD1mNAE+XeEKE+djWJUTbYQkUcDNshz?=
 =?us-ascii?Q?ccFpXsM0yjIfpKkj9lyI9eW3HQTZAKkyskDhsyqBTy6WaNz1K7felScF7MJb?=
 =?us-ascii?Q?re3TGb3pFzLv6HvOAtlQ1K7h/zXkjYBLH6ozVGxQcFUHW1O5lHbYxcj9ETT/?=
 =?us-ascii?Q?0P32Gh8nEaGZqS4ekurzYXa/N/dp5On3TZYWEvrF0CYkYdChO2fgUdkyQ/PU?=
 =?us-ascii?Q?u6HwUv3dBbAucRqoG8OCDteJDIRfept8plTFOPb+z+nQKVcI3pE5/eyk8RS4?=
 =?us-ascii?Q?BxVcpO6gSl+/juLe18beNcTaI+U+tTTqlLsaq7HD+d7HPWGx70C2TCnIhK71?=
 =?us-ascii?Q?VjvryoEaq3e3lD6XE8QKwIetLK85SPCWUTJKvXaFS/IzESB6uJIWwjje1ihi?=
 =?us-ascii?Q?WXg+BduwiBa6KUVIwdO61UBLNgiIEn7Nip4AD1ioz1vnWDdplS05w5FAsqVp?=
 =?us-ascii?Q?pWO3f4KmOTTwM9663ZJiuAVqMMKsBCxgdv988VivHBTqZq6O8fnFaDFOrfuH?=
 =?us-ascii?Q?hlC+Xh8UTe9sT5pZvcItrLQ60OeZyKLwcoX91lskU2jgAeYS0EHE3BMTaYS/?=
 =?us-ascii?Q?PAvPkZa5t5emrUnSZwhN3FH5fbSb7oN4G4CvjrYNN3JJS6oFqn+TdkxPSVN+?=
 =?us-ascii?Q?dFtwV070Jg+JbeHNLzN8rWlBdfo8gglYseY/hanmTR3GydHdXFPJ8btuw/dh?=
 =?us-ascii?Q?WfGs1fvkrMrBu7tWgAgNEUWm/8fYH5egLuhxg+UhA5dBsglnRRM++VH5xbVl?=
 =?us-ascii?Q?sl3tjF/7umrSxChxWO2qgZTyCovUdDd3WnrxdEcz8tDp+Nh33eqt+lMbiCIr?=
 =?us-ascii?Q?I/GOAduOYIEhP7nsAHhDob0EebSjfzIaXMC8PAQ03qIhSWKWaFVVDiytK752?=
 =?us-ascii?Q?8u9Of8F5xjJZ/vk5buZEjyuyjnkteOQ5jf705jazHOsvJbfAz75Avclu0lUo?=
 =?us-ascii?Q?sc+9Aryw9tC7pWJ2ozD1xmJXjz+iXIhn1aqoSMablymMJddnN+r37iSc57Mt?=
 =?us-ascii?Q?uksqog1Px9wzaCtm4DdsqhKO///+XZP3fzUdnrLKh3Bk6faiD+9m0Y21qidZ?=
 =?us-ascii?Q?mShByn5XV6tPU4wMWsMdV632ZFCVxroTDm6X5nHeMprFEuZpxjPQhkGYlwf+?=
 =?us-ascii?Q?OD6GjPTLDKQdpl9snsCI4G0rwZZ6SVqtoUYTf27v7D14jNMmwQfKK4WGUfGE?=
 =?us-ascii?Q?HR+r4B6DfYc6PBkTDCaMskKUzpCxWf+lVjKt/TfG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f142a764-bcc6-4615-3905-08da92359986
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 07:33:33.6585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZvo9RNimjVnDUv7qJMgnZcYce7rDLM6jcMjPLJXqHWOkWcgU4xwQRpOH26oQ3BbYzZRXf8LnqUGJi4Fhx+Eaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6231
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 02:26:34PM +0800, Hyeonggon Yoo wrote:
> On Wed, Sep 07, 2022 at 03:10:23PM +0800, Feng Tang wrote:
> > kmalloc will round up the request size to a fixed size (mostly power
> > of 2), so there could be a extra space than what is requested, whose
> > size is the actual buffer size minus original request size.
> > 
> > To better detect out of bound access or abuse of this space, add
> > redzone sanity check for it.
> > 
> > And in current kernel, some kmalloc user already knows the existence
> > of the space and utilizes it after calling 'ksize()' to know the real
> > size of the allocated buffer. So we skip the sanity check for objects
> > which have been called with ksize(), as treating them as legitimate
> > users.
> > 
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
[...]

> > -	if (s->flags & SLAB_RED_ZONE)
> > +	if (s->flags & SLAB_RED_ZONE) {
> >  		memset(p - s->red_left_pad, val, s->red_left_pad);
> >  
> > +		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
> > +			unsigned int zone_start;
> > +
> > +			orig_size = get_orig_size(s, object);
> > +			zone_start = orig_size;
> > +
> > +			if (!freeptr_outside_object(s))
> > +				zone_start = max_t(unsigned int, orig_size,
> > +						s->offset + sizeof(void *));
> > +
> > +			/*
> > +			 * Redzone the extra allocated space by kmalloc
> > +			 * than requested.
> > +			 */
> > +			if (zone_start < s->object_size)
> > +				memset(p + zone_start, val,
> > +					s->object_size - zone_start);
> > +		}
> > +	}
> > +
> >  	if (s->flags & __OBJECT_POISON) {
> > -		memset(p, POISON_FREE, s->object_size - 1);
> > -		p[s->object_size - 1] = POISON_END;
> > +		memset(p, POISON_FREE, orig_size - 1);
> > +		p[orig_size - 1] = POISON_END;
> >  	}
> >  
> >  	if (s->flags & SLAB_RED_ZONE)
> > @@ -1103,6 +1139,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
> >  {
> >  	u8 *p = object;
> >  	u8 *endobject = object + s->object_size;
> > +	unsigned int orig_size;
> >  
> >  	if (s->flags & SLAB_RED_ZONE) {
> >  		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
> > @@ -1112,6 +1149,20 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
> >  		if (!check_bytes_and_report(s, slab, object, "Right Redzone",
> >  			endobject, val, s->inuse - s->object_size))
> >  			return 0;
> > +
> > +		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
> > +			orig_size = get_orig_size(s, object);
> > +
> > +			if (!freeptr_outside_object(s))
> > +				orig_size = max_t(unsigned int, orig_size,
> > +						s->offset + sizeof(void *));
> > +			if (s->object_size > orig_size  &&
> > +				!check_bytes_and_report(s, slab, object,
> > +					"kmalloc Redzone", p + orig_size,
> > +					val, s->object_size - orig_size)) {
> > +				return 0;
> > +			}
> > +		}
> >  	} else {
> >  		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
> >  			check_bytes_and_report(s, slab, p, "Alignment padding",
> > -- 
> > 2.34.1
> > 
> 
> Looks good, but what about putting
> free pointer outside object when slub_debug_orig_size(s)?
 
Sounds good to me. This makes all kmalloc slabs covered by redzone
check. I just gave the code a shot and it just works with my test
case! Thanks!

- Feng


> diff --git a/mm/slub.c b/mm/slub.c
> index 9d1a985c9ede..7e57d9f718d1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -970,22 +970,15 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
>  		memset(p - s->red_left_pad, val, s->red_left_pad);
>  
>  		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
> -			unsigned int zone_start;
> -
>  			orig_size = get_orig_size(s, object);
> -			zone_start = orig_size;
> -
> -			if (!freeptr_outside_object(s))
> -				zone_start = max_t(unsigned int, orig_size,
> -						s->offset + sizeof(void *));
>  
>  			/*
>  			 * Redzone the extra allocated space by kmalloc
>  			 * than requested.
>  			 */
> -			if (zone_start < s->object_size)
> -				memset(p + zone_start, val,
> -					s->object_size - zone_start);
> +			if (orig_size < s->object_size)
> +				memset(p + orig_size, val,
> +				       s->object_size - orig_size);
>  		}
>  	}
>  
> @@ -1153,9 +1146,6 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
>  			orig_size = get_orig_size(s, object);
>  
> -			if (!freeptr_outside_object(s))
> -				orig_size = max_t(unsigned int, orig_size,
> -						s->offset + sizeof(void *));
>  			if (s->object_size > orig_size  &&
>  				!check_bytes_and_report(s, slab, object,
>  					"kmalloc Redzone", p + orig_size,
> @@ -4234,7 +4224,8 @@ static int calculate_sizes(struct kmem_cache *s)
>  	 */
>  	s->inuse = size;
>  
> -	if ((flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) ||
> +	if (slub_debug_orig_size(s) ||
> +	    (flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) ||
>  	    ((flags & SLAB_RED_ZONE) && s->object_size < sizeof(void *)) ||
>  	    s->ctor) {
>  		/*
> 
> -- 
> Thanks,
> Hyeonggon
> 
