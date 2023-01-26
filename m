Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB2867D5AC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjAZTuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjAZTua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:50:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92260468E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674762627; x=1706298627;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LDf0DEdH69936QJsi3N2DcuJo5p2FmvMwgISYMxaWc8=;
  b=cyX4jHm3GR1Zc+cedgerO68jpRmd/Ye6O3/UIz+tky9KrVckp6q7py9a
   5pMCNG72efyRxsbWB7jXi4kdfae+zyFs1cukZ/CSuH3Ezm1sv0GIcXH7x
   0mP3vdMH0daXzDL1/zc97svdqUPTA9BGSpzvLFexewRfQR2eYWcbpajBG
   NlYe3EsOhjfIy2KZJNweCwt5qwg/H+Gq0CwG2qk3b0ZCA8Hl1f4AUPAcm
   P70ejorHN/4F7fjcmpW1GRBlEt0ma8/BcFF2+jYTIS3qHytmLpw2fVQjP
   BSUL8uoIS26KdkAk4UXb/Yl/WmJ2bb2NeZtYd8NsuptNXUaEim+OkyBYW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="325604126"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="325604126"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 11:50:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="751715529"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="751715529"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jan 2023 11:50:27 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 11:50:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 11:50:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 11:50:25 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 11:50:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXK6L5xVYipn5DzrX8PQVAfaQ3nMngYwwRN5crxb3W9UaMtW2uSjNJEOvZMsz7Qlz0yU/ncxiahMLICAeCUyQYGaUx1lMLxhJ5p7TtZdzxmtvmxBER0wHZFX6qeNB43CB30rioQAcMAQD2y6kCU7NLiDFj44IwlY1UPbMjKM1REtbo9/ypfQxitsYsk+CPcJFHVjCikVeyx3u5aHjWlx2Hn8AKgMxgY8g3zjHUMat/0qexyfq0RubO9flYHPCrkZChqQtEMyt3mqt5sWVD8Ya1BavDPdL5q5DfBjB7tUtX8Bs0FkcrSd4LqbrRgyzVFZoDUosmo92zjUoVhCC12Y/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUIKtQgqZXmJMOeS1+CTm+491gUjYZVl9FcKp/Fzvfs=;
 b=AzfKroDbd5ioIK1AxgZHhbwdyEFm4DGkjvyRuNpK6HIwcMjA4VZdsThVAskue1XY/zHghmJRoUbyUBRoSYD8UoueVBR/XmB+23D+Ej+a+CMPmcKjPQJ2xMXOZowtPfm1OWjKAL08ijJI0X16INAJOrJgNFMGrzSQP9XbCKTTnZK6ZNiZxzTYDB9kx9CTKAyu35SUDRV76bYVG/cWoAMuRhdYvXn+/EYZtc7FW04r2Kyzc2JkyxcdWBMGd+JvMLDyfeeEzrx3Hk2cp4Koc+0ZnnlKoEbUeL6QnZPago5peSh/92/B4p3rBmkjbQh7OtjoleWjnO5XcwdIQTr+TrqrzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6824.namprd11.prod.outlook.com (2603:10b6:806:29e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 19:50:24 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Thu, 26 Jan 2023
 19:50:24 +0000
Date:   Thu, 26 Jan 2023 11:50:19 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] mm/highmem: Align-down to page the address for
 kunmap_flush_on_unmap()
Message-ID: <63d2d97bce4c7_63e3f29442@iweiny-mobl.notmuch>
References: <20230126143346.12086-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230126143346.12086-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BYAPR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 89fb8c82-7b32-4204-47a7-08daffd69081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ENi8E3Br9j1BRsMj6zVAPJf/A4eiT5lmwFBo47YBpx8BIxmAuxtA7/LpEbDJ3RPhki+B+zCQofa7+Rpl2MxsR189JWY3gnjcVXDW4foI+FrHB/EDzgLixhmtUKSv2/xZM4Z4lOfOmGosc0thL5hsZRfnPvnCEOrW2zduxuYhswBUkUYemJGlWX6z7uAsBYNLN6LxFpyJRRt/h/INSnJfzwnEEahX3yKwbGpTDZAcAR8kmowVSPOk8FSBFB3xpdTxj63it7UC4VXDTUCc9rQHHPDThc8oYO3WwAkUwYqGjJ7K+sToW6GzCUDxnb5hVPSZnKIZ5w/Uvfhtgv6KBCS2hgAje1YszZ6sy1v6Zgd7WdKx4ncn24pHZTu3JYDxAv+K0+1Ma9UiZjcaOgMaPryJAPdzTNuPgAbi2NHZ9BcryWfMXRpaCGMdkwo79L5g8kZCfVSgj1CV3600wwPTyyFxZTUXFv2PcjVWx2IxHwPcHKuUTrtGNcicvI551peABrE6GoSKKU/+X7Nih5yMuDTHtuq2M6DNJnTXax772hF2hEgxje/N/THx44tITXEe00uZO5LDYQwjjrkHJ54OGjeL3u7jOzr2YitxDtea8qFo2cvETksbnPm1gtoG/4+E/Pusmmow+6EzlgFAeijAgWhOCvTzPF9WD09keU22E+jwWobFI6oUJ6qKrKmfIFgrhUro
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199018)(478600001)(41300700001)(921005)(2906002)(7416002)(5660300002)(82960400001)(38100700002)(4326008)(86362001)(44832011)(83380400001)(6486002)(8936002)(8676002)(186003)(316002)(66476007)(110136005)(6512007)(6506007)(66946007)(26005)(9686003)(54906003)(66556008)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?83sl1xzS14Ja3zRPOGtcQ8D7etyzQOJruGGXOG3Z/MFMV6CvvRK5FY5l9FyW?=
 =?us-ascii?Q?kaL/xF2OHx7SbtGxApteUWoeIrOBHpizL9eWMkVk5TxHdiOoTgbccZTxB/pb?=
 =?us-ascii?Q?sahliJTzeFaRoIwIJXXfmB51ynZrLsT1V0jEhVeTXlN3IRLMAVs8ynmw8Z50?=
 =?us-ascii?Q?XSLu7XwcFuvpjA078dxFG1WbMStM+G68V3mBARACjrg6rRzzkRIj9NrKl5ZM?=
 =?us-ascii?Q?vwfygBYYIyYejCkbk6dRa2vi6kfYzy9i7H2xnXYJAn+Zb0vq6eGGIHbyFFo6?=
 =?us-ascii?Q?M11FLOaD+P05m1cP6/MC9TcpcTb0x4bXlSin1w4dOkEVSfbW0FG15FjKyNL1?=
 =?us-ascii?Q?Bqx2aQ9iV+slXT2j0564HbUQQppw5cre73ypjjka+1IbIp8teZdYYmjkZ7TT?=
 =?us-ascii?Q?8GkAU4mPqXyHT8XpUw95diKpRl9Kq8NISKzpkS4pgjRmBQH57gxLdsU39e+V?=
 =?us-ascii?Q?zBf5ypvX0Av10g3yi+ZbQ69XbU6QI19rQth+jcnUtCuLH4inGoHP4F/CbXuM?=
 =?us-ascii?Q?r4fj5tJaMJiOGLwXhohQTBQoABXOn/hljxkoabGOlCfuDZi3MGMyrLeBL5hY?=
 =?us-ascii?Q?xlucPc9/csHMeAgHxLJFykpcvyXAxp+Uyb4lIZT2iC79PWQYrbimWEbdUqqi?=
 =?us-ascii?Q?/bGbQxlH74qCDXAE7uRPGTAkH8XM7tanjgrp2rRQTsJlj9vt8GnLg+43Ml1B?=
 =?us-ascii?Q?w2/YzAB6lSI8iTYXUtO5IhHKrGo6Jq2ZiH+aQGSf2cJx5BdmjupjNJ/l3ytN?=
 =?us-ascii?Q?FrZk/oeb29dNevTIyUnD9o94Uv/dvCQGIga3/h6mLPo0/uVaZBE2teT54rhB?=
 =?us-ascii?Q?/r3KEjBRGoGVBx6csTj2fXJR48L+jaNvcryXZNMsSqspprVa9kcV2JUBEBcf?=
 =?us-ascii?Q?QYs7e7wM77xasjSw/Y8fGkNe9I9Q0fGoTKHPfsmi1G5wwAl1PO6Q6s5TRyC9?=
 =?us-ascii?Q?iU2nPM0mn01C8x0RgIR4sY/RuMyYC2OOVwnWuZleINbp6bR4zFpl0eW+5ioY?=
 =?us-ascii?Q?c25f/lgatv4xUfXTmowH5WsPkjpSMsiqD4yE+CYcX1Q5f20JArxYyamnFMIO?=
 =?us-ascii?Q?8pgjcLKmK7ygNFxNmpnMFIPygvTMZdtj564MkJZxA8udo7aB4WmkKmszF9Uc?=
 =?us-ascii?Q?NoXqArFCBJWUofCf4lN4jYRDHn3YUw15eb9uWhn6A1XCz2lNRmvKSqLLJq36?=
 =?us-ascii?Q?L0IIf7lnkaChD5gQdT4EP9C+JIgQbkBg/PYfXOeTsuN+wWHo/yX0AS4yzW7r?=
 =?us-ascii?Q?CIFm/toIzS/mwubb5rLLzE8EZKEmKdwVRkTISz1IYU1+SDX5WcyOl8W1Gj6F?=
 =?us-ascii?Q?rC8PsOyhtUyiOTHt0j96A7hXumaA6+qu8+ueQuz/DjU8F6ZJs9D2WmSX7IBx?=
 =?us-ascii?Q?HDvbTDOejGUggZNDKLaz7QDSOhLWPHR84hoLRzBgeTFbU0vldcERn/zWuZqP?=
 =?us-ascii?Q?znNmA9LjaLKEDa7/Yl7jDdHHIvM2bfOjkgFLNoHtgF9gcJmzGnDVqDKT3M1C?=
 =?us-ascii?Q?GXyn4bB5ec1nVdBjo+EoFEuYQhkY++K+vFpWRYu4n+e85XgZ1fSljuYoH46d?=
 =?us-ascii?Q?Qm9QrswjT+VjRilGS+T/66gY7ztaM5naa5pcqHhS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fb8c82-7b32-4204-47a7-08daffd69081
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 19:50:24.0852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSQR1i6GHlAvDk6hnOQ3TUJCxeB4ItOj5u79s9qmXG/VBQudG/Nxf/Y4FqDtQt2L6BzDboSR3wh6t7ai9D5nmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6824
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio M. De Francesco wrote:

FWIW I think I would simplify the subject
[PATCH] mm/highmem: Fix kunmap_local() on flush on unmap architectures

Or something like that.

> If ARCH_HAS_FLUSH_ON_KUNMAP is defined (PA-RISC case), __kunmap_local()
> calls kunmap_flush_on_unmap(). The latter currently flushes the wrong
> address (as confirmed by Matthew Wilcox and Helge Deller). Al Viro
> proposed to call kunmap_flush_on_unmap() on an aligned-down to page
> address in order to fix this issue. Consensus has been reached on this
> solution.
> 
> Therefore, if ARCH_HAS_FLUSH_ON_KUNMAP is defined, call
> kunmap_flush_on_unmap() on an aligned-down to page address computed with
> the PTR_ALIGN_DOWN() macro.
> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Confirmed-by: Helge Deller <deller@gmx.de>
> Confirmed-by: Matthew Wilcox <willy@infradead.org>
> Fixes: f3ba3c710ac5 ("mm/highmem: Provide kmap_local*")
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> I have (at least) two problems with this patch...
> 
> 1) checkpatch.pl complains about the use of the non-standard
> "Confirmed-by" tags. I don't know how else I can give credit to Helge
> and Matthew. However, this is not the first time that I see non-standard
> tags in patches applied upstream (I too had a non-standard
> "Analysed-by" tag in patch which fixes a SAC bug). Any objections?

I think you can add Matthew and Helge as Suggested-by:  All 3 had input on
the solution.

> 
> 2) I'm not sure whether or not the "Fixes" tag is appropriate in this
> patch. Can someone either confirm or deny it?

This 'fixes' looks correct to me.  I don't know how many folks are running
highmem with parisc but if they are I am sure they would appreciate the
extra knowledge.

I do wonder if this should be cc'ed to stable to ensure it gets
backported?  Helge do you think there is a need for that?

Ira

> 
>  include/linux/highmem-internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index 034b1106d022..e247c9ac4583 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -200,7 +200,7 @@ static inline void *kmap_local_pfn(unsigned long pfn)
>  static inline void __kunmap_local(const void *addr)
>  {
>  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> -	kunmap_flush_on_unmap(addr);
> +	kunmap_flush_on_unmap(PTR_ALIGN_DOWN(addr, PAGE_SIZE));
>  #endif
>  }
>  
> -- 
> 2.39.0
> 
> 
