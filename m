Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A6372EC0D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbjFMThi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFMThf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:37:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BE0199;
        Tue, 13 Jun 2023 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686685054; x=1718221054;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uxM8+3chatd4aG+3xV1JFo9YgQfO0PUa3GPJwIS22cc=;
  b=WEubFRhvB0RArHmO7qHG5hCYPQ2NLjUbryrLtHpAX7DI1+u8osYcnQkd
   q/tpXx7ukP2YzmJlutEHlHeGkkvws3omidjMJDqILsOfIkrQpdAyX9Eb5
   zGZ6+y13mPITMDn7d4xufqnCRYX45dwHoRcOo7YKlJP6AMzuozx0X1mdX
   NzT4I3JQ5APHd/1TD4qXTZIrV/pK0PHbkcbnrti+Gsg0A9UbIyZZyEBqJ
   cU0P8+nF6bkt4vWt4koZwdmwY/a80YLswUFGBtek9Y+RrdnpDWgNeiG/H
   ZX7oPHOrbWd5Nx8dsOY29MREehgPwER9XMd55l256ow19GB7GQK3AfFkp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="355934394"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="355934394"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 12:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="824528794"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="824528794"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 12:37:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 12:37:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 12:37:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 12:37:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 12:37:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoNg8f7l4lYVo7pCmzL/bu4JN4z/gutUDSBPeSkJTNCrZvme+T2vOcEdrFgtVtx3i0cR1MF440Rz7WPl7CACNrEELd8ofjTnzo7MlOCCaqg6bkoQuhq9OIGh1N5FBzMtw6JHiavsB9fAtewb46kFCvVnbC2Fb001VoEbNrhfU30WwhvJ5aLBZ3dkoLF+izM+Uu1cCSxbvPZVVlv33bAWhB+gr2s5pjk9FKGb+x9MtReNBpS9wtP3o3pzxOR6v0E6VBld4ydz9COWopcGxm0BhzXoILZn0qanyzImCuce9mNmnXX97Aqp5nP9mbHA+Rt0a82ZFEOv7MhzoUh3LGCa/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KC+PjH8ZnBzr0VG6kw8bpEoGsWlRHvr6e7+Tlj/oQDE=;
 b=gnRT9wX+D93kABZihtYjiKsrZTSw/fiOQsX91zhM0b3duL3e63hUg1TpdFvyCM6BJBOSnKnRe7zncq371FwwTur9x8nTFHVdrVXuB9zVA8m87raNJbqCRrEfCaou0QWPIamkWvpdMkDBkyR5xzYRHV1h/wP8QuDbQvbDITq/Dd5Zm0CFY/IrDuu3PB0WO0PMKfMrpPZmiz4gUnRQBiOoTRd3rUfXzKDJblLV9MWlsbYr97qLqSElkeehdfkDwkVQRFAvj23nBa22yWUmDvqiLjqWOeWoOmtMzgx6RS1s9y27l3uQp4vWNAeB3bT79qSg6niGf4gfw3pnW+eLnPsCWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5539.namprd11.prod.outlook.com (2603:10b6:610:d6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 19:37:30 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%6]) with mapi id 15.20.6455.037; Tue, 13 Jun 2023
 19:37:30 +0000
Date:   Tue, 13 Jun 2023 12:37:20 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Deming Wang <wangdeming@inspur.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Peter Collingbourne" <pcc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] Documentation/mm: Add kmap_local_folio() to Temporary
 Virt. Mappings
Message-ID: <6488c5706b99b_1ad8992949@iweiny-mobl.notmuch>
References: <20230609030908.31373-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230609030908.31373-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5539:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd2b733-85c8-44dc-f761-08db6c459ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wzTW1ME9jf0q5GYvUjNH6QKspWLibbgJKUMENCgy4v6gchfHQ43N4GZRRrQxQ4IWEeajffN2VM+wNANj3bRZEmFTSeNF6xmaplhYq1Y8NJ/Cipy2ZR2nF5c4vUO+TquhnUz0WBwb9jjg0GsZUxuWTicNgPR6Odr9TAjBTmMoulJO8juebhxfe2QQxbrUMJszd1vb7H5lgyYjUgpdLNvx/hHoirdnh0oXorZ9w9DeQIM0Hwn8vv5SttK/K6Q9mjD4+sEl3DH8cIppnyE09fdah7ZYQe4sKnxfO895IdRpH2DuQ/+XDCDwigVPPok14ZrEq6csEBqckBcq+FIiWGhHQuAzM1pJ9qj5Qa4KHz1P/zIDFzbBysQlWPiYues6wrFxHYI8eI7GYWzRdS1i0WhML6KWeL4luqwWfRkv+oz0xhKqxw/JBH/QPCXBtu9mDCOfbcKqtmjsEYA3SZTNqtkxFMFelb6YH5d1mJApsO4APYOYj/gle2DVwdhivpAn93z28J8HicWOPWd9eOfj2FMFhjezRfzpzzxG3HFcnJAu6AROgV0AiWTZ8oTAkzkBAD0D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199021)(86362001)(7416002)(6486002)(316002)(8676002)(41300700001)(83380400001)(82960400001)(26005)(5660300002)(6512007)(38100700002)(9686003)(6506007)(6666004)(44832011)(8936002)(66476007)(66556008)(66946007)(4326008)(478600001)(186003)(54906003)(2906002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xFNbHszEAO03uslS8tCUbOBanvHmlLPA28i/T1Xb0MN3Iweb+iBlSd32rl1+?=
 =?us-ascii?Q?MjEUZAqn0j6+dx/ChGLnzfRIdQnmMbtkOfeHo+7OtAFUqm3M5KgUuZ3ag1/+?=
 =?us-ascii?Q?0Qh5+w2fQ9cjS9FMw3DOBN/ntyjWNOImC7otCOE3PFH9fGFZdxlmxhOnFbhI?=
 =?us-ascii?Q?rXHLzfzJp56XifcmGk5uE91CCalyy2eiR8QqGFWFp9OLYoa9UR2ELKmxd/nv?=
 =?us-ascii?Q?KcHP4XgwDrvx1jS+fWfYIkZ2FTHhcDec25lyIHNDQVLWdk95zJhFXPItmY8c?=
 =?us-ascii?Q?dHEfCo2AQixxPneSIVVtZz5pMJy/NE5OJRJj+pz4vUiWczv9p2eMgJPI6Ors?=
 =?us-ascii?Q?r/JBr7dcQgou4zuSIBaG/byMtqMZqrB2tagQLbhzSgvyRRhvETRZim5OwJfH?=
 =?us-ascii?Q?HfM+e8Ki3455I4+g6COV3w0ltW5hg4aZJn/W+0FCTO/Elo7qh57EXsuPXhzg?=
 =?us-ascii?Q?Isu9TQLQMKjIRgSyFKQMl6VETJCEqg9QN7QD1Y9An/BS+UxRj9gfw5o4zT1o?=
 =?us-ascii?Q?xwYd9erqMvWYJqD+rhZz1apr0Mvb/EtB2eK6Gy9jGRBDHHQ4nUqNcmG3IMiS?=
 =?us-ascii?Q?EUxJt8RzUyRQ0YM4s4xIrLlg+UsG/o+GVbH47F7ena/N8HC0KuePlHe+0fBu?=
 =?us-ascii?Q?Vhn53RHniTA4Z0Zs4Mjh/mg+hnS4HA+y/hPdou/Km9DV7Vi/e+6X1mTRpZQW?=
 =?us-ascii?Q?7IWZY1a9r3Kq6eJ4wdNQJwynH1fIrJvo/452mui8nXtkDlShhLY4TdTG7JkW?=
 =?us-ascii?Q?a7mzJHEfAEOPpUZXPhDyI5CcGPxH6MZaCEsa2Qd4zf1aRfQKk/2b8VDuIdBu?=
 =?us-ascii?Q?q045FAR6fp5oIqULZCC2JR2pMd3pReYJHjkJxTaw3v7mwAPqa4HyTLQkZ4cJ?=
 =?us-ascii?Q?ZS4IOY2MueW4AFTnSnwXV3jkuT8c3vRpS0fajMgm83vcW4H/KfPGm2QyZZsf?=
 =?us-ascii?Q?g8dACDOc3gdy8APpvDpdel5E0ca/7qQNhYesaqO8jZeX3CNu7MhJ2RXQqo1A?=
 =?us-ascii?Q?YxoqAyArocfxndXCUZ4NOZ8O8Bv9UTbq+Pgsnhx/4ZWwcW4EnkyISXZU2APB?=
 =?us-ascii?Q?7RCnfZFRvO6lqZuHv+jnUTxTQ8hmnWSjLvmY0evPwocTkTXsc17xvoaS5Mka?=
 =?us-ascii?Q?9h3q1AwV62A8jfMltjpCDaTHVvg1C9myFkkE4J8biCNGvpodZX8ueysXypw7?=
 =?us-ascii?Q?Sm7jEzHv2eeYfQPogurSUnIhhVX2kYZCVS7oG04tv4dnV2ufAjYZWeAT2KUX?=
 =?us-ascii?Q?9U9wzPYnyZ2BAYk/5V+LaS24UflVNANaxZ1SzCcdtxhzi/tpTwORNFCcEjSg?=
 =?us-ascii?Q?Y24ywmmvs9tUaEJIr8yQiRI9d81cnEe3LONAkVK4s1V4D6Hu24OxfogYlBFB?=
 =?us-ascii?Q?9Ze/ymEJE2PbKiRl8ik4Ryi6+lta8oE0x8bGYB66ayPWrlpFEUsgkd4F1Ipj?=
 =?us-ascii?Q?U3JwZMlTQP918AcDnxOmB8WApizjRuStqiBtXnx+OVRhQKilhV1AJ5W6FunS?=
 =?us-ascii?Q?OCx7JALLe/zXyuJaLR9ulDu2T2ojh5HmwppJM7XGua4cNVZGQdXo+Z7e8FSm?=
 =?us-ascii?Q?4//7d23E+gnnzqKjsluAdnRI5M0gM8TdsV0sVhrx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd2b733-85c8-44dc-f761-08db6c459ff1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 19:37:29.9007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fxAm7WTOkoowPmoA3pOlqE+Uaz6ONovH7filmhdfOolX8XwJ4pMUBWoT8CsNTWhGqfm7TPuCS5EFd3SlxMq2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5539
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio M. De Francesco wrote:
> The differences between kmap_local_page() and kmap_local_folio() consist
> only in the first taking a pointer to a page and the second taking two
> arguments, a pointer to a folio and the byte offset within the folio which
> identifies the page.
> 
> The two API's can be explained at the same time in the "Temporary Virtual
> Mappings" section of the Highmem's documentation.
> 
> Add information about kmap_local_folio() in the same subsection that
> explains kmap_local_page().
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Peter Collingbourne <pcc@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>

Good to keep the doc up to date with reality.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  Documentation/mm/highmem.rst | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
> index c964e0848702..bb9584f167a6 100644
> --- a/Documentation/mm/highmem.rst
> +++ b/Documentation/mm/highmem.rst
> @@ -51,11 +51,14 @@ Temporary Virtual Mappings
>  The kernel contains several ways of creating temporary mappings. The following
>  list shows them in order of preference of use.
>  
> -* kmap_local_page().  This function is used to require short term mappings.
> -  It can be invoked from any context (including interrupts) but the mappings
> -  can only be used in the context which acquired them.
> -
> -  This function should always be used, whereas kmap_atomic() and kmap() have
> +* kmap_local_page(), kmap_local_folio() - These functions are used to require
> +  short term mappings. They can be invoked from any context (including
> +  interrupts) but the mappings can only be used in the context which acquired
> +  them. The only differences between them consist in the first taking a pointer
> +  to a struct page and the second taking a pointer to struct folio and the byte
> +  offset within the folio which identifies the page.
> +
> +  These functions should always be used, whereas kmap_atomic() and kmap() have
>    been deprecated.
>  
>    These mappings are thread-local and CPU-local, meaning that the mapping
> @@ -72,17 +75,17 @@ list shows them in order of preference of use.
>    maps of the outgoing task are saved and those of the incoming one are
>    restored.
>  
> -  kmap_local_page() always returns a valid virtual address and it is assumed
> -  that kunmap_local() will never fail.
> +  kmap_local_page(), as well as kmap_local_folio() always returns valid virtual
> +  kernel addresses and it is assumed that kunmap_local() will never fail.
>  
> -  On CONFIG_HIGHMEM=n kernels and for low memory pages this returns the
> +  On CONFIG_HIGHMEM=n kernels and for low memory pages they return the
>    virtual address of the direct mapping. Only real highmem pages are
>    temporarily mapped. Therefore, users may call a plain page_address()
>    for pages which are known to not come from ZONE_HIGHMEM. However, it is
> -  always safe to use kmap_local_page() / kunmap_local().
> +  always safe to use kmap_local_{page,folio}() / kunmap_local().
>  
> -  While it is significantly faster than kmap(), for the highmem case it
> -  comes with restrictions about the pointers validity. Contrary to kmap()
> +  While they are significantly faster than kmap(), for the highmem case they
> +  come with restrictions about the pointers validity. Contrary to kmap()
>    mappings, the local mappings are only valid in the context of the caller
>    and cannot be handed to other contexts. This implies that users must
>    be absolutely sure to keep the use of the return address local to the
> @@ -91,7 +94,7 @@ list shows them in order of preference of use.
>    Most code can be designed to use thread local mappings. User should
>    therefore try to design their code to avoid the use of kmap() by mapping
>    pages in the same thread the address will be used and prefer
> -  kmap_local_page().
> +  kmap_local_page() or kmap_local_folio().
>  
>    Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a certain
>    extent (up to KMAP_TYPE_NR) but their invocations have to be strictly ordered
> -- 
> 2.40.1
> 


