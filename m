Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C519467F205
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 00:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjA0XH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 18:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjA0XHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:07:53 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB1CFF3C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 15:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674860870; x=1706396870;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ej70RgkIgMaf6NIsEArBZq4E9aSO8eIdbHXK/4ML2kU=;
  b=lgNR9F8SrqJ2x+6+d8f1ZyWxI3ioGWzu3ZVmMbFjTPHMoyUcuUre1ygr
   WHEZeSIRjFt2cIlX3bl7DvxoMoYdlHqaRYjSmPKwvzyiznJsqrbSxFi+t
   i9YTHTny3+9mRB+KXefr6tMzb2pC7hpsKPRuXsUalL9NZcsvY+6qCgBUL
   0Is5Y05hUwR+ouM0WjXu4y+KiK2f1VUQViMCCFxrzD0J5BsAuJUlEXJZF
   r/s8PPjH1xRJmU6N7fdFtUd51IxUBsFd5qyFS28xGBM28RBrgNlHwEWLs
   16U2MSrTwRxD2rAqrhM04oZpsXeleMrcVag1wphsuv+lElcxMs8oXqaxl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="391768882"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="391768882"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 15:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="663437673"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="663437673"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2023 15:07:49 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 15:07:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 15:07:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 15:07:48 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 15:07:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDKnC5myCQGI5AbZhRCnDyR883xs4rY+Fv9E1M4dTNXinvQhPoFcr3ewliTU04ypNriWBesgM9VzwsAgSoeeYpK41cG6X6+h8Om3nI9jUaDjU2H6F06PTvbeDfPDao5N3mOwJscVfY+PDgdv0UdtWkDeBV+p5+h6CM3voWsjWYL86it3dwNnM2ff0CsRQuuKR0SFyC0dsjNJGj/u5n9rHzGMgCwc9vCVJPqFKSMIU2+AkFSHp+Po4Wc4nNXk7vZd92cTvJ5QJyaYqmu2QulDZAGCziWpEmoAo0c9zAvRr897+QWng5yDLmcdE0ev7qFnj6R3S1oADl/bxsKtuz7YPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUdBCyQcBzgEQwfd0732x9X+YkBkI4B/ALMF1PIbxWs=;
 b=T0H+j6B1bmEyRQiiFHwflVblWm4m+gZZYfeLeBN1UP5IDBRdQvJFqJOzZ64niuWUdncVL/BU6IqG6R4PjqxZ7QNbrtpPZZAizI5STL3MGGyrcWz5wblde0A1akfSRo7pd1kEF3cc3xNKj9beiMlej4qcPhvmkz8AoYxxUs2T22JiUwXJAzpA78iJFthtN6aFBGVmRA6BGOL0e7HtPqX29nPhAgaOQWRMPqSX8vH0D8qohKzl4i/2TJemrOQgUCAdcdu0eK4XlnwVg2Kq2SHjBP6ZQx93VArUl9xU4BiL/Sz3DC5oSJC0KwUkK+62UN3LPEviiSQiN6nSqAfJMoMlEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4728.namprd11.prod.outlook.com (2603:10b6:208:261::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 23:07:46 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Fri, 27 Jan 2023
 23:07:46 +0000
Date:   Fri, 27 Jan 2023 15:07:42 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>, Helge Deller <deller@gmx.de>
CC:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] mm/highmem: Align-down to page the address for
 kunmap_flush_on_unmap()
Message-ID: <63d4593ebc66a_7f63c2942b@iweiny-mobl.notmuch>
References: <20230126143346.12086-1-fmdefrancesco@gmail.com>
 <63d2d97bce4c7_63e3f29442@iweiny-mobl.notmuch>
 <804f9617-cdad-d3cb-f4c0-7d99d12f49d6@gmx.de>
 <Y9LnZ5wS9Sh3pwSH@casper.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9LnZ5wS9Sh3pwSH@casper.infradead.org>
X-ClientProxiedBy: BYAPR21CA0003.namprd21.prod.outlook.com
 (2603:10b6:a03:114::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4728:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e21a81a-a215-43f1-82f8-08db00bb4d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMe3a6c5SvDOHDkYdK7Ra5/jEptBxWYR9YPWkPWIjM6xM/8/bZERJCPH2yNDS5+7JmWC0W26x/EndE+jk0eHWw7N2mdR35b+hR1FYGSvaBAbV9IQ/Qg8tAVH56M9Zo8qfDC0QdHhjOJGIt7yLMTAv9hl4SHXZ8Jz8yGiB+zTNw4uu2dhcl2WoEjPNVsPvieK3rl1WHmgtdppUpo8I9lwUe86SxXSwcVNA4Gj3eHL5LtaK/4JhZF3PeoQeL3zoWvTNStXLK83ueZi3bdPjRhxngIpluM6FQTCjSogdO0Azooj3sfKRFaPn1xoF3oKhNBRQmbl4p3TjlWQsH2Fq+gkJp8tLS+vew6hrc9y9Scp25gOAzTr4tn9f8rEMB4QE7jpyCaqt721ZEFrr+QD6/+v0ROinBPhdYeavKFvQ3hjK3i5iMlBxukc+b4wt4kHX3aOlU473HKr+gqMX8441F7rx66ylP+L6KAOM7wG3oR8CGqWDqJWsDLNV3dklsehjGIz/Y+C52cMqiTajokiO9/uau5iuyXPyv1tialDRx/oydJsNd5BGrP3lhwaDDLDlRepTv8e85jkiqL8FW7qk5WdXyZR5DHiXWssu8vkWkJoaGTNplfN9e/jIKe1Ss9s1wvM1OrPnpRPrBETdrB66kTLzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199018)(44832011)(110136005)(2906002)(38100700002)(8936002)(82960400001)(6506007)(6666004)(7416002)(86362001)(9686003)(186003)(6512007)(26005)(66556008)(4326008)(8676002)(66946007)(5660300002)(66476007)(316002)(54906003)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lc6Ti78J5e+aeZt1wxrWl6I4TflG6AsH+ia5Ebg6E4t9QjiEn4dDanvNF/rp?=
 =?us-ascii?Q?V3iOkws9BaZj5jI7f5Whcoh7OWqpp9glCFBkaXeFzaYDkl8Jb6NVY3JTmuyc?=
 =?us-ascii?Q?bbynJNvsLjBhLqHfYATVXxBv/g/xFsFlqjSEt5xcDaACqmIUMNBp9zS5Rl46?=
 =?us-ascii?Q?Zrpbqmk1m/w95WbQpyMoVV3tEsitb/GF+Yx/w8rUdbE+zUA4gHZAa7LwcK4G?=
 =?us-ascii?Q?Oypk3Qjo7NVX7wdq7+0kPNAK3C3Q2Bg2TiuzKK1r0zF2TQIBQacHAtx/Lbjt?=
 =?us-ascii?Q?F7f8JjObOOgzGWKmeeOdrwdrUIg6izCJzwhP2aABGfjJcsQ4mE0LYCtgrhB8?=
 =?us-ascii?Q?ASNI183AQ0SIkvxUrya2/hwvVzgJs7hV1mSRWAuAA18wyhJMH9IiD0IGL9UR?=
 =?us-ascii?Q?nq7lgq4XRaJHx1rFVrmMvZYm+WE92LcQT56Iq4KkU8H9m42S/VMDy8IBPqO/?=
 =?us-ascii?Q?KOpw/b7nu0JzZJ8T6k7MgWM6glBgRX317jFY9qqBM08DDPUeMKkhEi9+AeUi?=
 =?us-ascii?Q?ceFuxUOxk0ds0f53RhVzJox0ZDBZxX1PFHyNR/CACZgXL2GiSxgBkAtXPsPd?=
 =?us-ascii?Q?Q4PBIafhhR1L+sgoEsLyG4eu0LIfbH6VZwDRd4bs0Hdl1gNhUYw7Um7HF81O?=
 =?us-ascii?Q?XYVjiXOZueNGe2lRZ+taEU3pphIrurk8nqP2DAi2E+7rfiGY7/+mze8WLamJ?=
 =?us-ascii?Q?gfUxoeY2OgHgrpm+K/it35UVePeZeLqbJ/RtLrnzvVpagxbm2Wyb9QoRfbnW?=
 =?us-ascii?Q?+7myYvJ80vLCxGxyADScZ89rCw/ayqJ+IBAqxgzrfrMdDisc0OMgortvua9F?=
 =?us-ascii?Q?UXJeaMgoSiM/tGO0LAmGiKh/j5t+vc373yI7c+zsZ3zqN0IHAssaQGHGRlk/?=
 =?us-ascii?Q?9LgNUzuKOaMxA8YWJ0FvhIZfjvRrBUx0+YIXmvKoCzlBX1ywgja3Ysn0FUst?=
 =?us-ascii?Q?jBRFk8fcrkOI7IM7FntM6Xe8VOIoPbz2XI7J7kMwB15t9fbGd+ConGro4rIW?=
 =?us-ascii?Q?kWDlt6UeMHjtk65z52CqRhn5K/IJicbkYJyy8ON4Vjmdb2wx1+DgdSDtA/Pb?=
 =?us-ascii?Q?zIcg1ygwrBKWzB82XlsTb3lVf/CofdMx551c6b32HQx9i8jgfzzmJ77UAtwz?=
 =?us-ascii?Q?nv0dcxJhYwzmdYtTXps3sqKdn1sSEOsWxIzCgROAQzvcZyPbXsF9XKLx4fkA?=
 =?us-ascii?Q?vsRsLwAyNllqUnraXWeqGOhE47S0h7mqs5bL2ZIBe3bdQZiv7EhsYZc7OXtN?=
 =?us-ascii?Q?PTATLQzpbDA7ZoDgCjWynOCzSEwbHNpiQMakBSQAPI+3EeO3GquxpEjj3Vvx?=
 =?us-ascii?Q?RSLmvroRq+4pfBAf2XOevMJu4tkPCZT2KJ9mp3cNzRtNishP6zMqwRc3R+wu?=
 =?us-ascii?Q?BO9dJ8nc1SQtPcef9Rw4aVYDq5BNlWqcxFQRLhV0wXSE6GBvV6dS73WZD12c?=
 =?us-ascii?Q?/ATd5+7q5yq/k2f9eIMQeMQf/0xSP6LVo8aRYsVy1kE4Lhx2EBMgAGLV/mmA?=
 =?us-ascii?Q?eK+a6TARNS8fWwgPIU/tu+HYdJz2b3DomXtSRO0Qy0SlY4UQRafFeJsMggcR?=
 =?us-ascii?Q?X6hnv03zNLNv91oLlRX940/nk47cQww4cc5wgYod?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e21a81a-a215-43f1-82f8-08db00bb4d5d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 23:07:46.1947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIpFEf7TpB7w1KApEtp/TM8tSTySodpous1jrRYd0r+PME3g3muV/CjCa6hLySUMlp9cuMQVfwj0RFuaB3970A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4728
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Thu, Jan 26, 2023 at 09:37:08PM +0100, Helge Deller wrote:
> > > This 'fixes' looks correct to me.  I don't know how many folks are running
> > > highmem with parisc but if they are I am sure they would appreciate the
> > > extra knowledge.
> > 
> > It seems nobody is running highmem on parisc, because it can't be enabled.
> > AFAICS, it's not in any parisc related Kconfig file.
> 
> But this isn't being used for highmem on parisc; it's being used for
> cache coherency.

<sigh> right!  I missed that.  Thanks to you and Al for setting me
straight.

> 
> > > I do wonder if this should be cc'ed to stable to ensure it gets
> > > backported?  Helge do you think there is a need for that?
> > 
> > For correctness I think it's nevertheless good to backport it.
> 
> I cc'd stable on my version of this patch, and included a Fixes tag
> to indicate how far back to backport it.

Thanks!

> 
> > That would be another possibility:
> > 
> > diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
> > index 0bdee6724132..ce5d1f8a23bd 100644
> > --- a/arch/parisc/include/asm/cacheflush.h
> > +++ b/arch/parisc/include/asm/cacheflush.h
> > @@ -77,6 +77,7 @@ void flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned lon
> >  #define ARCH_HAS_FLUSH_ON_KUNMAP
> >  static inline void kunmap_flush_on_unmap(const void *addr)
> >  {
> > +       addr = PTR_ALIGN_DOWN(addr, PAGE_SIZE);
> 
> I considered that, but thought it a shame to do it here when all the
> other users are passing in a page-aligned address.
> 

I think this also keeps the kunmap_local() API intact better.

Patch reviewed.

Thanks!
Ira
