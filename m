Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB15867F160
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjA0Wss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjA0Wso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:48:44 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9257293
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674859723; x=1706395723;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1xhaSt34MD0SQRvRKF0MmAxAmTrIxga5N3L+FoVHOhI=;
  b=Kn+5+8LPsdoBuZ36qotPZpdUhulvnN0AlLPoVZNOPnQBNx3IttNQ95YR
   67eUPLgJ3CkZDpcrTHHs7WshX4dElkrPpZD/l03H4Hh4kAMnNwa1oC978
   OYzBHN6q3ByGZYq6MPm8Ty6KkPxi9AsimlU87ZVJVPx08fGrr2L5yjO/Q
   nAaSCgEfdlRZKr9cVeiSq36uoTShdXMGUtay0N7B2d10pxH3Owc9avBu+
   E0lyXLzaYMKrbRBzqA9wCrI5GM8tKSbA9aOmXBBuaZrYh3Vm2DvddGu3L
   2KbOM3rLLrCXF0cBDQxe69610lHQW+akP0j48JiSpShZZX43K+O8/Qb++
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="307556055"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="307556055"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 14:48:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="695695618"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="695695618"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2023 14:48:42 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 14:48:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 14:48:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 14:48:41 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 14:48:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND+UWfCATyDGD+vnWn0+LcDlDW4xIUtQdmPV7XJCIrTvXKRxLMLleKlfPdzY9gmbicsYH/4G/i1M05l77k4QAqTbwSu8tLMfjYmf7p9H7qOvTbExKRlF5PR/JTCEuAl7tQ90LZTtMCeTjdVhTMWODNOZxJArrfrfddhXWTfR2WvQlHJqM1lLZKL4hWobrZhvPXuHB4ii0i4zXOugODFjiEDAMZTXzu+xKYV044BFIHB3GlhUNL84G5Jo5fCxOOp7fxA3dASb0IkWpe69fxRnVQj5YLFfIili7h6Umcs7GcP9ukRUK0z7hhC8pQOxj90df24G9WIkQlJNSzynsWvU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgSBgF6PjjbWQRd9uKV67czN5cIBgIIagzFgHtkWv6k=;
 b=guBzJTF3cqXzuHQZHFykLhvIIeZ96qh3G+j0A95ooOMfipbChzjojItkKNy1LR+iu7jIG5buoRCXPJuhGue9cd3o12WNHReoBkEE7rA5+qQE0QVkAvVRxeFTMnOsHyjayR03W2icRkIQgXtF/EbGcL7KRU6n582QjlLYMaDRnN2foc7FN0Qdk6V8PtDPyfiOBLR96pngQqN5EajAwZKGmVO0nwycFDtugnXr5xSnGKpW24fZjjw/LnLF+nf+pNU1nk2B0bJkh8UXtCjM47aXCedc7YbZPiNada+zy7LoxIIYsRbmWypPS5x5qeZX6kQlVQ3yvGUDVIhjht0lDJ/wQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB7751.namprd11.prod.outlook.com (2603:10b6:208:43a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 22:48:39 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Fri, 27 Jan 2023
 22:48:39 +0000
Date:   Fri, 27 Jan 2023 14:48:35 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>, Ira Weiny <ira.weiny@intel.com>
CC:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] mm/highmem: Align-down to page the address for
 kunmap_flush_on_unmap()
Message-ID: <63d454c3ddda7_7f63c294c9@iweiny-mobl.notmuch>
References: <20230126143346.12086-1-fmdefrancesco@gmail.com>
 <63d2d97bce4c7_63e3f29442@iweiny-mobl.notmuch>
 <Y9LoVRYumhvgjsw5@ZenIV>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9LoVRYumhvgjsw5@ZenIV>
X-ClientProxiedBy: SJ0PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 24037af5-17b2-4665-d88f-08db00b8a1e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCxKsAoe83chF5RikybvbPJWSiLZ8+xnV1866Y350ZPaJLrkbP7GCh34NG5vg+OXu1sv7TIFFaXbEyJVaYCYeHbB5A+utFgDV0MBNo2MKsbUMb/IsPwLtxPSIqS5oZhTmk0+YwKR+SLEZegB5t+xsEjLu0zQYB/vr5e/91iXEI55cp2iMxpgwEmy8AabSKTybZmfxNSHCwNSJC+Myf1FLn19i7xzzZgcf/vl7u9FzjYkJA9qO4I250UthgoSNiW3tzzyXAn4+yYfkIkfwsD5LdN7VVx/x0+dzwlBBDcl+9bI2BdJ2c7Pab8Msxu4QfEoakAMWM9bqPYBm2QA5nUYR1SF9mjuGlGA0L3ZYRy5wLuHN5d1XXBx0cuJnzngBW5O4/m/btmjIdAYgm95kczNF4Nmr5Uk9V3OW3925vud5vuh1Mt7kOJMEuB3pdrNYw+wbrbGdFpKVdsBK3Pa3O4MSUZmjRRjiwdC0roLhONqnuKxcDxyauhN8wwO7ToEEkLEbwEACliDVEOnwVpb6nWM49lzTiAyc9mjCEb4M4/4capMF2BqNbzR4MmQi9qJFhJkik+zKgZi77nGniiwg+BKoa/pImffv9lQBctRiyv8dd9c5eRSx+oZhirjLqO3jTupeD8pWCN3RqnTwwqxdp6rNHMurHxQjIWF2zVkZ8ABqRFBO033spH1sp7aYudn2xlTbzPezvnsOMj5hkCuLPLKMI/0o4Z80Wvpw6i4RXHq7jM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199018)(82960400001)(186003)(6506007)(966005)(2906002)(6512007)(26005)(38100700002)(9686003)(54906003)(478600001)(110136005)(8936002)(41300700001)(66946007)(316002)(8676002)(86362001)(44832011)(6486002)(83380400001)(4326008)(6666004)(66476007)(5660300002)(66556008)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xtLnieDSVVoRrgzI4c4jiQELSwBjKphuCMqsd4l8F6dUVWIundVr3cZuoE6T?=
 =?us-ascii?Q?TmDKR3HJscjLtZ8KExtZhIhiXHa2h1VxZVdOxyewDlj/BauxqFR1JfPL9WcJ?=
 =?us-ascii?Q?kFpmll5odSPtzaVC87qu5ILzZdRuBedBmVjrvEZNL2E3TJ4SxmGEczQpo0NR?=
 =?us-ascii?Q?JcnWpnbFfUqIMzJrShcTl0LuwgSvmGJmN/3eMa5o5aRm2s6UvWIW7Ck6BUw3?=
 =?us-ascii?Q?5zOjLcbpon8/qNvne2p9KDCyu9NXaxAZdKtvpicy9wb5BTg/AEgwlj344L5E?=
 =?us-ascii?Q?SOYX0waB5DJjWfClHbZU3CpiaJ2FEsUqkeeCsU0IjVahXKWFeuW1Yz0qEGR6?=
 =?us-ascii?Q?08TnlOjgDo6NZQEXTf1kutZ+W4dWGqDo4yCmBEtCOqQcMXI5fLQjVpCuXCTQ?=
 =?us-ascii?Q?XnrDpWVykVE8x0TUSn6ug0rjZiMfPSANEbzWKapqh5xch3UvUgpTckXsLfym?=
 =?us-ascii?Q?cJvVrKpbm2V84+c0NBJArSQyVDlEuwzar20LR6VYzR8JCXim9UdT08SK0iow?=
 =?us-ascii?Q?soUjiR+qhN1HdFbuqvt+pJ1/b//JJeMH9v87Gjko9Y9EWzhSAWN4jJLSA6G6?=
 =?us-ascii?Q?ToewDQ7VWow489qtWOe8fKUedQVSwMmS1I1ArUqFlGIBwVFW2u3GMm2D8vPg?=
 =?us-ascii?Q?IshDjEyS2p7NjbPP3YacggYtSUZ28P5gafPXxECkI2o0URQ6KiUfSuYlvSLb?=
 =?us-ascii?Q?N03GWFTsnOJxCmNU1XKNzKfUHzuuzQGlCbgX/4bAfdnBHKJkMDDF7i6L/t0K?=
 =?us-ascii?Q?eECj0sL7NA4FoL0msqmMRjESgho32zzb/f2OvC2+vY/QchB0JcrG5s1Wq8yy?=
 =?us-ascii?Q?impQEvKifrqkGu0ATReW9FbF7Qd1jMEBbmzmB00Ius4unH456iB6Vc5W+6Kl?=
 =?us-ascii?Q?EoRqbkr2lvXNFmX71mIU6pU1Am+O/p2cQJrQIj5X+t+AMo9ivper5E+fYoVi?=
 =?us-ascii?Q?++u2NUCO/bwLqSB+xtrTC3nQpdPMOZPtupKlabvn649ZpcAaHZk4T2lNTROw?=
 =?us-ascii?Q?wZxTiP7ZV79Isk49EE9ZoWxVTyVrgmXtebasQuiuxMn7GdNIqBaJrp0v4Ezs?=
 =?us-ascii?Q?iZSnJ1hIFaT2sNnpwsHxFCKEd8k6k8ARB78pHMK+wAsnQqdB5vh3i6BAYmMu?=
 =?us-ascii?Q?eFX6aod58YtcoD4oCdcE8AC6l7W+kXZP+PRIqo+z16RqTSHOZlgDpEf7eUwp?=
 =?us-ascii?Q?Ozr7KNk8PhrvUiT9pcJLbbWSTLhrdsuJzovIYGyUx+WTs/1vYynhYR/6LsZa?=
 =?us-ascii?Q?IYGrD7UrUaMH2ENeqNx7tx3iYQ7uktuKZQ6CqGnsCiSudUczGKbKhbQQVcWD?=
 =?us-ascii?Q?tnKc4yEbfQmPmNVOamfP/WzdOUv5XSdMKn7OOa3LuNk8f6xuBxmachH5qU6D?=
 =?us-ascii?Q?XH/o4QiSx3zvO1mQjAw30CeCcw8B2GvEnif4L8RqC/m8fQkO1xfiaZ2fLAuK?=
 =?us-ascii?Q?s6OiSYDap24DwMtaBrEcVi3KtsqBygLKumGQ/tnUB5nn2CKY2+GUbaSR9F0F?=
 =?us-ascii?Q?yj3HsNuYctQTJnqDXwTgWoSK5OXdNsRil4B33tdzVQTC2oLjBtXHSOWQanGI?=
 =?us-ascii?Q?LPcURJWzqv3QWOGx1dh/keVlw9cNif14jWegpY8S?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24037af5-17b2-4665-d88f-08db00b8a1e6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 22:48:39.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnAAwT30Rbi1hfDb2vV604sv/HlCZG/H1z2flzBkAuySxpEAAsmWJPcrOALwJcL518jM8rZ8md2xCwXmlEaG4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7751
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Thu, Jan 26, 2023 at 11:50:19AM -0800, Ira Weiny wrote:

[snip]

> 
> > > 2) I'm not sure whether or not the "Fixes" tag is appropriate in this
> > > patch. Can someone either confirm or deny it?
> > 
> > This 'fixes' looks correct to me.  I don't know how many folks are running
> > highmem with parisc but if they are I am sure they would appreciate the
> > extra knowledge.
> 
> parisc doesn't have highmem.  That's not what flush_kernel_dcache_page_addr()
> call is about; if you look at the kmap() there you'll see that it does
> *not* create any new mapping - it simply returns page_address().  It's
> really about D-cache flushing there; kunmap() and its ilk serve as
> convenient points for doing the flush.
> 
> Not sure about the "fixes" tag, TBH - AFAICS, currently all users supply
> page-aligned addresses anyway.

Not all users supply page-aligned addresses.  Partly because
kunmap_local() was documented to not require it.  But more importantly
because those of us doing the conversions were focused on what would
happen in the highmem case.  So we did not catch this side
effect/requirement in flush_kernel_dcache_page_addr().  :-/

kunmap_atomic:

 * @__addr can be any address within the mapped page, so there is no need
 * to subtract any offset that has been added. In contrast to kunmap(),
 * this function takes the address returned from kmap_atomic(), not the
 * page passed to it. The compiler will warn you if you pass the page.

kunmap_local:

 * @__addr can be any address within the mapped page.  Commonly it is the
 * address return from kmap_local_page(), but it can also include offsets.

> Their life would be easier if they could
> just pass any pointer within the page in questions and it's easy to overlook
> this corner case and assume that kunmap_local() would handle that as it
> is, but it's more of a "bug waiting to happen, better get rid of the
> corner case and explicitly document that property of kunmap_local()" than
> "there's a broken caller in the current mainline kernel, need to fix
> that".
 
FWIW there are callers like this in mainline.  Here is an example.

commit 8aec120a9ca80c14ce002505cea1e1639f8e9ea5                                           
Author: Christoph Hellwig <hch@lst.de>                                                    
Date:   Tue Jul 27 07:56:45 2021 +0200                                                    
                                                                             
    block: use bvec_kmap_local in t10_pi_type1_{prepare,complete}                         
                                                                     
    Using local kmaps slightly reduces the chances to stray writes, and                   
    the bvec interface cleans up the code a little bit.                      
                                                              
    Signed-off-by: Christoph Hellwig <hch@lst.de>                                         
    Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>                          
    Link: https://lore.kernel.org/r/20210727055646.118787-15-hch@lst.de 
    Signed-off-by: Jens Axboe <axboe@kernel.dk>                                           


> Anyway, I would rather keep the sysv etc. series independent from that;
> for now dir_put_page() explicitly rounds down there.  Once those series
> *and* your patch are both merged we can do a quick followup removing the
> explicit round-downs, marked as dependent upon your patch.

This seems reasonable.

Again, thanks for all your help Al!
Ira
