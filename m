Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0725B4B86
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 05:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiIKD5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 23:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIKD5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 23:57:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC089357C6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 20:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662868628; x=1694404628;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qecEAkOoJj+Zc/JLUdqw2sO8ClzoKP8+MZfmsRr6Tb8=;
  b=gRyZhh5Ed5R5LWW/YXP6AkYBy7kHJNl4hVasVHZ5+/42UcClWNf6NH31
   H2isDfSeY4zb7b+dxEgoC2tJpUg5CTj6epf7tkGDfeus+g6F8ZDn9lu/p
   9Jf8nPEsHv3AZ1NGwfIW8HUzTgazC8hNjf2NOcQZVfCfQe+VK2Eu39qOg
   LCFP6YcrqpM0qeMn+wfSImp2U/tELVvB+2DcsJk57cIzhGNSCP0ZBq/Pf
   57ORZwY/RscbAg4ccFre0O3DDlXp5F3J+6A1eHFDkoBEtKrO1k4oRckg6
   3D58k5BnUILi4vTcH+U7H0Qd1oj1uLKcecskEe2eUOXTiqpup+bpHXQTp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="299028700"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="299028700"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 20:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="944232726"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 10 Sep 2022 20:57:07 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 10 Sep 2022 20:57:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 10 Sep 2022 20:57:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 10 Sep 2022 20:57:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 10 Sep 2022 20:57:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmYQJutJjkB5JEIMxllPFgRMbjhI5wb7gS2t4z5BKDhghjgScN3OJMNgdukLCsiuH6Ajwndz9LzuWEsxt1jVV+emRvafK7iHAjDdcEvpECvD4fubg5i/ujZXiE+NG+lvTrkcsFaYgyONNQW8O/FWEcoQDuYJZcH/JLcSHmi6huj9adwNN1+btq93hmP1c5I5c7Xg6YIcdMMEKIh2yBQmXlibE5hxy76HDoOlnhVfJxF5ZhbVwcQbbk5eQlrB8UVsqbyrDCalgC2wcXuN8LRwGJUiUs4QAYmu8tsqpwXq4HnAsS7scUEMN9F0JoQM3+HD8N/yaUeP3616TlUulNm85g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PAdh2eO5UZ7stcNSaqWS7q2jYnNUXCvr4NAUsCgYPQ=;
 b=Us343/z9N7z3GzIM+p8WwHd+DLJ3k3pfVFdbujpfDxfXVavkPNaNi4jT5cvTVUTsOQ5XLwSrv0P6HwczR39qw/WFL4KqAdVlmBjNZY3Fe9ahC1Wx5G/1jcr4fQKXLDgF8O+cXfQBYqCzbckNVGYhSkAKUsj3RKVlP6rdPdzIkRR20Y8D4LynOcbnMMBIZLXbh5hVtW8xnx1DkzDpwOJGZixUgrDTQrnmNBi/qHaZBS/VcwMYLZdwTFraeTVelABBBFN47q88xfjc8cgLafAgcD9PHX6hBhISgZqKycXxqOvOLSSOE7ijdk/W2kDy+H5lG6NAFg2z9Bv+tS/4wmTbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by IA1PR11MB7270.namprd11.prod.outlook.com (2603:10b6:208:42a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Sun, 11 Sep
 2022 03:56:59 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4c8f:1e3c:5288:d77e]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4c8f:1e3c:5288:d77e%7]) with mapi id 15.20.5588.015; Sun, 11 Sep 2022
 03:56:59 +0000
Date:   Sun, 11 Sep 2022 11:56:24 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Sang, Oliver" <oliver.sang@intel.com>
Subject: Re: [PATCH v5 3/4] mm: kasan: Add free_meta size info in struct
 kasan_cache
Message-ID: <Yx1caGQ8R2alhOKh@feng-clx>
References: <20220907071023.3838692-1-feng.tang@intel.com>
 <20220907071023.3838692-4-feng.tang@intel.com>
 <CA+fCnZeT_mYndXDYoi0LHCcDkOK4V1TR_omE6CKdbMf6iDwP+w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+fCnZeT_mYndXDYoi0LHCcDkOK4V1TR_omE6CKdbMf6iDwP+w@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aff0895b-abb5-4001-10de-08da93a9ad70
X-MS-TrafficTypeDiagnostic: IA1PR11MB7270:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSTTmAFdXcPULF1sbaoYlS2LeIWFfumug8bBVrjYRJ+Wtjg9W483PyZVMPyRr97Qmhy3TszCD42vz9S4omACrGoinFQrcA+MsMib3bYVHOT6ezPaSq2mbNnCu3j/A2QppjFoS38EipJPdTdLOeCK3WjueiISNj8AKpZQLeiYJD0PND0tdg05RTeORawT7SXBUNouH2lirtoEBvuH2gV/21ITakleXmZJNIvUv1NOB8nzJo4ttuqvN1k7QxaDU7/lOv7SGRiPUW9Ca4E0dgubHo8aqvlUqr/nMVSPso1EexpKyI1x2ki5i8CVpvWojlRIVEZayFtjaPzug8ejK+DRIuku66zF3chQPO0wVEkiCZ8587SF5nz63uKlJXoS7VHeLgz6XcGLewZffVEN+Nd63LALJeJleMqFRlTVP2tYmRV3vC6OSYysb7YPzHYhncSTqVU701UqATTwHhOdct0bwcRFO5edE4A+KgfBq7OlIgty77p62zmSkhZgQZPIgXH/FFWTKDIKJ82kTN5KiYAcc1HClVnC/6BQO8x28cjyyX6NG4NGvq0U7QoKiMdyCCmFHFhT3T+V7NYuGFOV6Ma5HJsXnDCvnp10pj+Z5g9evqNJdSeeYuXjQmHz99KUCSTREd4EH9aIaOMYb+R37i+8+0ZBeOw+dbHvmoITMs7W0BTzL6KGn3J9zr3Q4RrOV0ukYp1S5H51YMFK4WGeP+Y6cvlpIW8wShfgkLLedoDQ2LA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(136003)(396003)(39860400002)(376002)(6512007)(41300700001)(26005)(7416002)(2906002)(6506007)(44832011)(6666004)(107886003)(186003)(38100700002)(53546011)(9686003)(5660300002)(82960400001)(86362001)(33716001)(316002)(66556008)(6486002)(54906003)(6916009)(66946007)(8676002)(4326008)(966005)(8936002)(66476007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0auiaTjlBN7p9OggMBAzVEZMpTLs6KW57Ps80b1mr9Vjiub4D3rM+yeONqtF?=
 =?us-ascii?Q?sb/x8+k+NTrmCvS6dGWpEV+k156f9IlCTiDBm0TaVPnhW0lXBKm1lII9OHq/?=
 =?us-ascii?Q?gbfM76wL4Apr47gEtc4hnv2Amj8SD1KqidTs7vk8mWhxLu2mwmM0aOOwkjuQ?=
 =?us-ascii?Q?/UoQk5bx+cx1vTYKSJVFNhqFW8/tqZqkIjvEGSX5WmuXoN8DTXyR9hKm2Dsw?=
 =?us-ascii?Q?E35tpQY7hYpthE0sBgG2EOrR1gmEO/PAr9bn1w/tTnMVoRlhUBzt/z+0C9N8?=
 =?us-ascii?Q?lkWQCqF5YcI64ybsuKjbKhWwk1obL61lRl7IFjbvpOrEYYMVnM0Fb34IwOjC?=
 =?us-ascii?Q?i8QM/x9kjjCxI7h7mj2gB1iuBqYLW50EF/5KEO3LsPHBeVWzU7lhbemOJrDB?=
 =?us-ascii?Q?V4o3vvHcWButL80UdHxnblepw95zfmYQjmBsVp18oyfc8Df1UJlY91swXaEF?=
 =?us-ascii?Q?ds81PMTi10UaDLJ18D3PSLmv9v6pqx3RYmZbdPSX9ySVIRDH25vNTWeIHrJd?=
 =?us-ascii?Q?WnJ3+a6yuE/s3sPggW+/anDk0odLFekNIKb6wmpBBu1pVDByv0Oor8gH4Kys?=
 =?us-ascii?Q?Y+TdpTY3RrRthu40TdLcc+D+RlOKY7wflypyzF0C0cvi+v2BhX5aY3kP1kOB?=
 =?us-ascii?Q?1X3Cc514lLrONMTElnwipoD5ujKbhHPHAAnMopKld79gQ6Io+fCN2wKfKF0r?=
 =?us-ascii?Q?LgytJ+GqDWSZj7I0aEjZjmPOLnTPWhbqW/BXR17ksLifc7yIEVZolmQZg0sb?=
 =?us-ascii?Q?owVQPMDw56Tstzo+/zsunp62RC0/1vKeUGEGJ/RoXOX/kWA3lBNxlulftFiE?=
 =?us-ascii?Q?KgWsSQNRQtomUvw3TDkM4UMJLQ1YnrsuVwDaSfoqM47ZdZiQLs0b/IAzqPqA?=
 =?us-ascii?Q?+D7r796w6jgFXKM1OYWDRp6D4bOB2WMNTEN/dfvaoDdtkyzq+wmghszE+jNN?=
 =?us-ascii?Q?kPieXG151APpoR0EIGgwpnxMV/z+mPsayoMFCgMaV9qKGqTZSf8D4Y2CjdAk?=
 =?us-ascii?Q?CEXxF6HwfmbXDIsBYdynbtqEEevA7Fm9u/lkZe9PdvkfDlwpsUFGFzpSVVUJ?=
 =?us-ascii?Q?B07PTsF/4+/oAekZ72pIfr64GSLI5lLzcl5efoISOC7IxTrf14T9+41tdVsu?=
 =?us-ascii?Q?KjeK18rm6azbIlW3B+Nz7oaf9+6Hl34ZrmNapJc6CecggCDk1TjgEeWunzxn?=
 =?us-ascii?Q?z0h0MJk/PAnvrTgPf81DFqcuYJLnjGI29HtrEEEwukD2Y9A9nqw1zSCHEmNF?=
 =?us-ascii?Q?8ewjYN8VZyekaz7Hiv/ovwiOyeRnpEZV+oJIZO+PGB7oX1e5Oqz0sC67GAfF?=
 =?us-ascii?Q?h04IiRMih+b5zvVazGJ2c9Ho66DJTfsLIiWbMJWN+ebnrfmPhuZlScrFUH2D?=
 =?us-ascii?Q?vG6pcAoQAGfsmfwv0A6iWrQJptzGlWApCgFcr9okQlOcmunTskcsTVRITfEh?=
 =?us-ascii?Q?OIZsy0jPBzF0fpvcr7NEZUacbaaqgNb6FpAsY4CDMNUbjOwyb7PYw5Oiz26/?=
 =?us-ascii?Q?e+988Zv4PGqP68kXaujWQumPazeiMygVFMZNDgolj8u2pKbsXQtE32341XqC?=
 =?us-ascii?Q?f3ORwCT+LYXQFmbD3K1Vfk1d2ymg5zYaGO/nNXZR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aff0895b-abb5-4001-10de-08da93a9ad70
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2022 03:56:59.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxgjnm3XJx/8DQoOgzlSh9sjuXgtF3ggKbo3PiSr1xCOSqgcnlyDpr8e4OgGhGj+UMuUg9K2zRkS2/+9xUNYMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7270
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

Hi Andrey,

Thanks for reviewing this series!

On Sun, Sep 11, 2022 at 07:14:55AM +0800, Andrey Konovalov wrote:
> On Wed, Sep 7, 2022 at 9:11 AM Feng Tang <feng.tang@intel.com> wrote:
> >
> > When kasan is enabled for slab/slub, it may save kasan' free_meta
> > data in the former part of slab object data area in slab object
> > free path, which works fine.
> >
> > There is ongoing effort to extend slub's debug function which will
> > redzone the latter part of kmalloc object area, and when both of
> > the debug are enabled, there is possible conflict, especially when
> > the kmalloc object has small size, as caught by 0Day bot [1]
> >
> > For better information for slab/slub, add free_meta's data size
> > into 'struct kasan_cache', so that its users can take right action
> > to avoid data conflict.
> >
> > [1]. https://lore.kernel.org/lkml/YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020/
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > Acked-by: Dmitry Vyukov <dvyukov@google.com>
> > ---
> >  include/linux/kasan.h | 2 ++
> >  mm/kasan/common.c     | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index b092277bf48d..293bdaa0ba09 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -100,6 +100,8 @@ static inline bool kasan_has_integrated_init(void)
> >  struct kasan_cache {
> >         int alloc_meta_offset;
> >         int free_meta_offset;
> > +       /* size of free_meta data saved in object's data area */
> > +       int free_meta_size_in_object;
> 
> I thinks calling this field free_meta_size is clear enough. Thanks!

Yes, the name does look long. The "in_object" was added to make it
also a flag for whether the free meta is saved inside object's data
area. 

For 'free_meta_size', the code logic in slub should be:
  
  if (info->free_meta_offset == 0 &&
	info->free_meta_size >= ...)

Thanks,
Feng
