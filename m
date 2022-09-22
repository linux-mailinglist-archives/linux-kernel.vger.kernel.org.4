Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DD65E6D07
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiIVUbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIVUbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:31:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EC6109526
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663878705; x=1695414705;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=lzyYLQT0R2tRKfIgpmYIPnq/bLjpSBBQjE5kQgg6flg=;
  b=kecXwn9C9fS5iMKQX/6AntmoD4MxLQ0y34tzyX2UGnGaLN+0oPDF7NMD
   uYAJqmSPAde46BkRGeBTTrgs/NR8wl733sql4Z3aeWOWC14kHXNqgqM09
   BRbaG1jh+DvJoFFuUF+NgRR8gh3suNjO+kZpAq6Tw24U/aw5hBOVHdn6T
   DPNl9E0VgVbFOkldiT88gt8647ky9BhsUIFIxov6eoLKDJMA4bnR8Yh0s
   WqcwVokZLsPeMpMVrqvQ6gT3GBU9FQGxqEAFd5mhvqHZqWnHJ84wmuIlc
   2qaUnlbOIaUXw1kkwV/cLXIZvxiMR5zPWT76gnz39ZpNFVaNhUerYyFBS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301863092"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301863092"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="622257972"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 22 Sep 2022 13:31:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 13:31:42 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 13:31:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 13:31:41 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 13:31:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyVdJ8UyAT8bpDNI6NVBnr7Lg9Lqg/4uW800ZqgWVOUgkvwRddgMRYHWFRTVUfZZ4kBkGiZDyZIWCs2Es4R3p/xqFzXpimbgWRmYAGUhyxgd6KPBsDZSMuSe2IfWUyqQZ4YkbiShXRCrtK8wC74v/0mtMt8jZJ8AvZvrbfFHLMjLLuObOcsWGD3uDlJVYkTITgR7KlRlcc/QRAeGGicE9WrQEM0kZ8TQKHdbDvHOBRje+SB6pTefPviMNaNgBokrKWpwBY38XIT9uCJOytELuugeWqBVyDUzVKGkjsbK9iSIrDRUwJUdaHafCmNDv/3ggtufRReZjidKvUj2WsI+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kx91f42XLC7rATcNHvgTAkwBREDpDbn4ktbzh/GcWeQ=;
 b=hYC+qc4dagricX2OmifYNg/0Jg3LOMoMVbbGIa3z/IcDOOWZCW9D4adWA8vFXLkVil7KfnDFATiBvESWHhJUYbO7IKHjVAlvPJdelpTOCKf9epvzWETrarLXI8Sl9y9xZ2KV5wbVWuuJFtwpIxAetvvjA1Sq51NKSTAYuVkNpoxuwhS17i9CDfG8dnX7UnmO+snNNeohY8RnF/ahUBcsXfIIiM4hRJJaPnzU1I1JPAW30Yvuu2grjxzpzaCDJnAizL6WTkV9u3t1BPLLORLtzPqiAfv1MSKJiSTH8qRAsFbk2Mb7W41Z06745D65u+BiHk8eRQKrwr92VVmNAhucdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4623.namprd11.prod.outlook.com (2603:10b6:806:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 20:31:39 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a%3]) with mapi id 15.20.5632.021; Thu, 22 Sep 2022
 20:31:39 +0000
Date:   Thu, 22 Sep 2022 13:31:34 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Subject: Re: [PATCH] fs/sysv: Replace kmap() with kmap_local_page()
Message-ID: <YyzGJl1AuSD4BwNz@iweiny-desk3>
References: <20220826175041.5381-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220826175041.5381-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4623:EE_
X-MS-Office365-Filtering-Correlation-Id: 40103a2d-d242-4741-9cf2-08da9cd973b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXNE6Y3s1YY8EChOgvqcS0AvRltvJOn9KhAYTyoVygtvIRB9vUl92lqF5hJ1sjHUuFSKRVb5RdVNdtZKa+d2bACfrXrBPBRtSexYLzCKn6FQ0R1Qtdxjrn0jMl/IiRGlKAc0p0eqiynOGP4vQYQF+BEWzmGr+UxUvrEeTYsCvggeLCxy7wO+MVbrG8iUOF0PFFahDJxrq6UonD7EtpLSPtDUFPEEXb1CZkGA2o2C1JtbNTw7+hkUfElcdgilqGn3KJtxuoTmgrmbgDC/UZgwFQIv74tLqp0K/yOQlGm3Eyvwxbljl0KdwgF5dt/JTGvuOBAMNLjyk96HfMrFxNPuGZZAbWNadHqXPlnWZVDAB2Ww4kXATQeFQgXr8qGNPJFjQCVDSNELMxnKqnMYC4Vl23F7pt/46HEbl1decihOl4Du4lqNrI5S+RIY06/BRCtohIROu7mTsw86M1SqJhXcGkhuwOTB+0ktuFra7yMKAydPLEVa5ZBX7XwS/QkzbTydCfgpNQPsmypS+NoLSlSH7KnSPtIFbQNjYdNHoEwg6hVug2bGgAHCrEWuxqce5tWvLXAKYdXNb4d8PcBhzEWuD8y4y22iYaWw0ko+gPgHxxQZImmsrPbABKQuGR387uoWPXftmGt9Iq3AW/5XirKtN9a0jvNwDGhLT9BlUu133dAHdyvZYL7qhCs5kaBnSedidSL9igKjrCffkGXt58Su0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199015)(2906002)(33716001)(86362001)(82960400001)(38100700002)(107886003)(6666004)(9686003)(6512007)(26005)(6916009)(316002)(54906003)(6486002)(478600001)(41300700001)(8676002)(66476007)(44832011)(8936002)(5660300002)(66556008)(186003)(4326008)(6506007)(30864003)(83380400001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHpZU3gwbWhmSVVSbkJGc2RxVVY0Wit2SVNoTWxCenQwTkswbEFBQlc1V0w4?=
 =?utf-8?B?bW9JT0NiK0I2QVVzb09nZlgvOHJxUFg4M1IwNUJSUXQ4V2FTelpSZFVYKy96?=
 =?utf-8?B?LzNVUU5ycHBkK3BtSXhSMXZNaEtuWlIxK3BKcnJWblJwU2N3dkxld3pkeFhl?=
 =?utf-8?B?MWk2TVlIVEdWdVlqbzlYL0l0ZnRMVFQ2ZlhWTktyR3dXWlRpZ2hOeGFvVWpH?=
 =?utf-8?B?K29nZ0tMSGRQOFdFSWJFdkVIaisvVzlIdk13TTFHK2orU2RPdkxYeVduakxJ?=
 =?utf-8?B?UmtmWTY2cGtEYWtmcnRFYkZURHVwa0VGTDlpU3hiSG92bGdxa3ByZmo1Qm5h?=
 =?utf-8?B?Z1FmZzdIWUN5MFBReCt6WDVXN1BpWVBqTFJwcW95N1h4a1hoTVFpa3UzWEFy?=
 =?utf-8?B?OExjTWlKT05rb1NXdWg0S1JNTTdiQTNwZ1dkcEs3Y2tYYm90VDYrSDVIOE83?=
 =?utf-8?B?Ukkrby9NcW9yeC9wZDY1THBtZnJKWXhSaEhCZ0hIN3hTcUZnYTJmUWtWaUhj?=
 =?utf-8?B?YlBCYzNPa3hjaVJCQTRESWowd0pwN2lVK2s1eFNPZWdtZ3UxQUQ3ZE9UZEVX?=
 =?utf-8?B?QUtudzdvMTdGOUZlaXZIZU1YZjBqOFdzd3d5OXQ2MUdHdzNqNnFKMEE0M2Jz?=
 =?utf-8?B?TXdUODQrT3Y2dnNvL3dvOS90WDNzYlN1TTkzTU0yZHlQdlpoR25XOFdSQVpI?=
 =?utf-8?B?V0g2SE1MYlJwa0JTY0lnVStiSndLWi9EbzZGWnhmNm5ETjRFeFBNWmFIUG9r?=
 =?utf-8?B?WFhkenNHckNFZlVJeFJCOStmYy9xaFJOMjQ4NU83Sk96dE5YR3NCTjJ6Tkti?=
 =?utf-8?B?bHNpdVZ5cWdvU0kyWnRsbjRIQkhuay8xTHdRTGVmVHg4TFB2dXpaUkVWM0Nt?=
 =?utf-8?B?MHE3Zmg1Q1RHZEZuay9ia2cwUjI4ZmZ0Vy9qZmZpQ293bzBoaUZHZVNOdXla?=
 =?utf-8?B?TVRzZXBHZkRObStTUW1tTktKdDdwSHU2NUJySFpldElBQVZiMDBKNEswV3V3?=
 =?utf-8?B?Vng5SzB6UUd2eWpPNjRnUDlCWmd1aEo5T3ZTMWdDSWFKVmdnRWR5T25nM1A0?=
 =?utf-8?B?bGFUSGhDN0ZFYmp1RFJ6SXI5QjZabE9tOEwyZmtjbWs5Z3dnKytLWmxxT0Zz?=
 =?utf-8?B?YTJ5UG9hdlhIRHdLUnlYdmEzSTgwMmlVa2tkelBRMy93ZlBUckxjTHdmTFJt?=
 =?utf-8?B?Q2dYUUdQZWl5MFRQOTlwbVdwNXcyT2FRbTgvcERKUFpPZUt1TDBsU01JYzF2?=
 =?utf-8?B?RFRvaFFMNVplSU15U1p6MW4wWmxTTWg2Y2VTTk43VmZRcmJ2U3NTb0NvcnBW?=
 =?utf-8?B?TUxObzhMVGZnVlkzMnJrTVFucjhSTE54RWdGeUNKSS9HSmdxYURjWGp1c2FD?=
 =?utf-8?B?cDA3Tk9kL1dYY3F1dmZQY0g5UTFXQk51WkQ0UGhhbnpQSlk0WHc4WlhEa0tJ?=
 =?utf-8?B?ZWplQTdqWlBURko0Z00xbTR4YW9sSk5ucGVyYUNqcTlhOW5iVzVTSmIxQ1dW?=
 =?utf-8?B?ZWRZaVpXcnFDY3RzK2UrWExmb1FjaGMyWjJ2VzBFZUV0cCsxMWdLSk51UnNM?=
 =?utf-8?B?bVMwamMvZm11Sy80c2dWVndQVXlzNm9xd3Z4MC83eU5FVlN6dHdEK1dGUWg3?=
 =?utf-8?B?cjJHZ3kySUM1V3ZaMkhZNGVYaUU0VHJoeWNlbEswQXBhV2RLaFZjTGd1UWpa?=
 =?utf-8?B?ZlJrK0tEQ1lPMnNzUWJuMUtuNWE0M2NpUGFxNmVoczZsN2NtcG1ReFlsdjRW?=
 =?utf-8?B?eG5tVWZqcVBiYVlYV2c2QWwzUnVWa01LbGNXZkNJU2ZuZVJsT1VnV0VBQTI3?=
 =?utf-8?B?eW5XZmh6ZlVleEpvS01DYnhpK0hNNzdhYlZTQXNlbkZUSmFTWEdDMm5iNlln?=
 =?utf-8?B?eVExa1RockVIZThkdWJEUTYrdEtMNTFuYWpZUC9EYVVYNFdNaXRaR0pRc2Z3?=
 =?utf-8?B?bWJIZEorZlhZcEQ5czZlcFU5aVVWQmFKdGZvRWZuMGZOdFhERVljQ1RwNWtj?=
 =?utf-8?B?SCtCWXhrMzhzeURkWnZUTDU5MDlNcWJuVEh1d2xZMWIxR3UyOU1SSmhXZWF4?=
 =?utf-8?B?ZWlCRTlQY1NNKzdmU3QzWlVyUW5rWXNMSXNkbmErWUhrSGgwK0ZTNGZTY2E1?=
 =?utf-8?Q?A5+0eV8RjkIiuN9YhYy8Q99N2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40103a2d-d242-4741-9cf2-08da9cd973b6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 20:31:39.1093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELgEHJVuu2FpS1iW3OHE3mpblFt04/HonV8f1kpO+fNuUytHtfq8TUHKlYEZwKP0EAG6h9ihKLNDxcYwgGLcqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4623
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 07:50:41PM +0200, Fabio M. De Francesco wrote:
> kmap() is being deprecated in favor of kmap_local_page().
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
> 
> Since its use in fs/sysv is safe everywhere, it should be preferred.
> 
> Therefore, replace kmap() with kmap_local_page() in fs/sysv. kunmap_local()
> requires the mapping address, so return that address from dir_get_page()
> to be used in dir_put_page().
> 
> Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> This code is not tested. I have no means to create an SysV filesystem.
> Despite nothing here seems to break the strict rules about the use of
> kmap_local_page(), any help with testing will be much appreciated :-)
> 
>  fs/sysv/dir.c   | 83 ++++++++++++++++++++++---------------------------
>  fs/sysv/namei.c | 26 +++++++++-------
>  fs/sysv/sysv.h  | 19 ++++++++---
>  3 files changed, 65 insertions(+), 63 deletions(-)
> 
> diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
> index 88e38cd8f5c9..130350fde106 100644
> --- a/fs/sysv/dir.c
> +++ b/fs/sysv/dir.c
> @@ -28,12 +28,6 @@ const struct file_operations sysv_dir_operations = {
>  	.fsync		= generic_file_fsync,
>  };
>  
> -static inline void dir_put_page(struct page *page)
> -{
> -	kunmap(page);
> -	put_page(page);
> -}
> -
>  static int dir_commit_chunk(struct page *page, loff_t pos, unsigned len)
>  {
>  	struct address_space *mapping = page->mapping;
> @@ -52,12 +46,12 @@ static int dir_commit_chunk(struct page *page, loff_t pos, unsigned len)
>  	return err;
>  }
>  
> -static struct page * dir_get_page(struct inode *dir, unsigned long n)
> +static struct page *dir_get_page(struct inode *dir, unsigned long n, void **page_addr)
>  {
>  	struct address_space *mapping = dir->i_mapping;
>  	struct page *page = read_mapping_page(mapping, n, NULL);
>  	if (!IS_ERR(page))
> -		kmap(page);
> +		*page_addr = kmap_local_page(page);
>  	return page;
>  }
>  
> @@ -80,11 +74,10 @@ static int sysv_readdir(struct file *file, struct dir_context *ctx)
>  	for ( ; n < npages; n++, offset = 0) {
>  		char *kaddr, *limit;
>  		struct sysv_dir_entry *de;
> -		struct page *page = dir_get_page(inode, n);
> +		struct page *page = dir_get_page(inode, n, (void **)&kaddr);
>  
>  		if (IS_ERR(page))
>  			continue;
> -		kaddr = (char *)page_address(page);
>  		de = (struct sysv_dir_entry *)(kaddr+offset);
>  		limit = kaddr + PAGE_SIZE - SYSV_DIRSIZE;
>  		for ( ;(char*)de <= limit; de++, ctx->pos += sizeof(*de)) {
> @@ -96,11 +89,11 @@ static int sysv_readdir(struct file *file, struct dir_context *ctx)
>  			if (!dir_emit(ctx, name, strnlen(name,SYSV_NAMELEN),
>  					fs16_to_cpu(SYSV_SB(sb), de->inode),
>  					DT_UNKNOWN)) {
> -				dir_put_page(page);
> +				dir_put_page(page, kaddr);
>  				return 0;
>  			}
>  		}
> -		dir_put_page(page);
> +		dir_put_page(page, kaddr);
>  	}
>  	return 0;
>  }
> @@ -124,7 +117,8 @@ static inline int namecompare(int len, int maxlen,
>   * itself (as a parameter - res_dir). It does NOT read the inode of the
>   * entry - you'll have to do that yourself if you want to.
>   */
> -struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_page)
> +struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry,
> +				       struct page **res_page, void **res_page_addr)
>  {
>  	const char * name = dentry->d_name.name;
>  	int namelen = dentry->d_name.len;
> @@ -133,8 +127,10 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
>  	unsigned long npages = dir_pages(dir);
>  	struct page *page = NULL;
>  	struct sysv_dir_entry *de;
> +	char *kaddr;
>  
>  	*res_page = NULL;
> +	*res_page_addr = NULL;
>  
>  	start = SYSV_I(dir)->i_dir_start_lookup;
>  	if (start >= npages)
> @@ -142,10 +138,8 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
>  	n = start;
>  
>  	do {
> -		char *kaddr;
> -		page = dir_get_page(dir, n);
> +		page = dir_get_page(dir, n, (void **)&kaddr);
>  		if (!IS_ERR(page)) {
> -			kaddr = (char*)page_address(page);
>  			de = (struct sysv_dir_entry *) kaddr;
>  			kaddr += PAGE_SIZE - SYSV_DIRSIZE;
>  			for ( ; (char *) de <= kaddr ; de++) {
> @@ -155,7 +149,7 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
>  							name, de->name))
>  					goto found;
>  			}
> -			dir_put_page(page);
> +			dir_put_page(page, kaddr);
>  		}
>  
>  		if (++n >= npages)
> @@ -167,6 +161,7 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
>  found:
>  	SYSV_I(dir)->i_dir_start_lookup = n;
>  	*res_page = page;
> +	*res_page_addr = kaddr;
>  	return de;
>  }
>  
> @@ -176,6 +171,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
>  	const char * name = dentry->d_name.name;
>  	int namelen = dentry->d_name.len;
>  	struct page *page = NULL;
> +	void *page_addr = NULL;
>  	struct sysv_dir_entry * de;
>  	unsigned long npages = dir_pages(dir);
>  	unsigned long n;
> @@ -185,11 +181,11 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
>  
>  	/* We take care of directory expansion in the same loop */
>  	for (n = 0; n <= npages; n++) {
> -		page = dir_get_page(dir, n);
> +		page = dir_get_page(dir, n, &page_addr);
>  		err = PTR_ERR(page);
>  		if (IS_ERR(page))
>  			goto out;
> -		kaddr = (char*)page_address(page);
> +		kaddr = page_addr;
>  		de = (struct sysv_dir_entry *)kaddr;
>  		kaddr += PAGE_SIZE - SYSV_DIRSIZE;
>  		while ((char *)de <= kaddr) {
> @@ -200,14 +196,13 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
>  				goto out_page;
>  			de++;
>  		}
> -		dir_put_page(page);
> +		dir_put_page(page, page_addr);
>  	}
>  	BUG();
>  	return -EINVAL;
>  
>  got_it:
> -	pos = page_offset(page) +
> -			(char*)de - (char*)page_address(page);
> +	pos = page_offset(page) + (char *)de - (char *)page_addr;
>  	lock_page(page);
>  	err = sysv_prepare_chunk(page, pos, SYSV_DIRSIZE);
>  	if (err)
> @@ -219,7 +214,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
>  	dir->i_mtime = dir->i_ctime = current_time(dir);
>  	mark_inode_dirty(dir);
>  out_page:
> -	dir_put_page(page);
> +	dir_put_page(page, page_addr);
>  out:
>  	return err;
>  out_unlock:
> @@ -227,10 +222,9 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
>  	goto out_page;
>  }
>  
> -int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
> +int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page, char *kaddr)
>  {
>  	struct inode *inode = page->mapping->host;
> -	char *kaddr = (char*)page_address(page);
>  	loff_t pos = page_offset(page) + (char *)de - kaddr;
>  	int err;
>  
> @@ -239,7 +233,7 @@ int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
>  	BUG_ON(err);
>  	de->inode = 0;
>  	err = dir_commit_chunk(page, pos, SYSV_DIRSIZE);
> -	dir_put_page(page);
> +	dir_put_page(page, kaddr);
>  	inode->i_ctime = inode->i_mtime = current_time(inode);
>  	mark_inode_dirty(inode);
>  	return err;
> @@ -259,19 +253,15 @@ int sysv_make_empty(struct inode *inode, struct inode *dir)
>  		unlock_page(page);
>  		goto fail;
>  	}
> -	kmap(page);
> -
> -	base = (char*)page_address(page);
> +	base = kmap_local_page(page);
>  	memset(base, 0, PAGE_SIZE);
> -
>  	de = (struct sysv_dir_entry *) base;
>  	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
>  	strcpy(de->name,".");
>  	de++;
>  	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), dir->i_ino);
>  	strcpy(de->name,"..");
> -
> -	kunmap(page);
> +	kunmap_local(base);
>  	err = dir_commit_chunk(page, 0, 2 * SYSV_DIRSIZE);
>  fail:
>  	put_page(page);
> @@ -286,16 +276,15 @@ int sysv_empty_dir(struct inode * inode)
>  	struct super_block *sb = inode->i_sb;
>  	struct page *page = NULL;
>  	unsigned long i, npages = dir_pages(inode);
> +	char *kaddr;
>  
>  	for (i = 0; i < npages; i++) {
> -		char *kaddr;
>  		struct sysv_dir_entry * de;
> -		page = dir_get_page(inode, i);
> +		page = dir_get_page(inode, i, (void **)&kaddr);
>  
>  		if (IS_ERR(page))
>  			continue;
>  
> -		kaddr = (char *)page_address(page);
>  		de = (struct sysv_dir_entry *)kaddr;
>  		kaddr += PAGE_SIZE-SYSV_DIRSIZE;
>  
> @@ -314,22 +303,21 @@ int sysv_empty_dir(struct inode * inode)
>  			if (de->name[1] != '.' || de->name[2])
>  				goto not_empty;
>  		}
> -		dir_put_page(page);
> +		dir_put_page(page, kaddr);
>  	}
>  	return 1;
>  
>  not_empty:
> -	dir_put_page(page);
> +	dir_put_page(page, kaddr);
>  	return 0;
>  }
>  
>  /* Releases the page */
>  void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
> -	struct inode *inode)
> +		   void *page_addr, struct inode *inode)
>  {
>  	struct inode *dir = page->mapping->host;
> -	loff_t pos = page_offset(page) +
> -			(char *)de-(char*)page_address(page);
> +	loff_t pos = page_offset(page) + (char *)de - (char *)page_addr;
>  	int err;
>  
>  	lock_page(page);
> @@ -337,19 +325,21 @@ void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
>  	BUG_ON(err);
>  	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
>  	err = dir_commit_chunk(page, pos, SYSV_DIRSIZE);
> -	dir_put_page(page);
> +	dir_put_page(page, page_addr);
>  	dir->i_mtime = dir->i_ctime = current_time(dir);
>  	mark_inode_dirty(dir);
>  }
>  
> -struct sysv_dir_entry * sysv_dotdot (struct inode *dir, struct page **p)
> +struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct page **p, void **pa)
>  {
> -	struct page *page = dir_get_page(dir, 0);
> +	void *page_addr;
> +	struct page *page = dir_get_page(dir, 0, &page_addr);
>  	struct sysv_dir_entry *de = NULL;
>  
>  	if (!IS_ERR(page)) {
> -		de = (struct sysv_dir_entry*) page_address(page) + 1;
> +		de = (struct sysv_dir_entry *)page_addr + 1;
>  		*p = page;
> +		*pa = page_addr;
>  	}
>  	return de;
>  }
> @@ -357,12 +347,13 @@ struct sysv_dir_entry * sysv_dotdot (struct inode *dir, struct page **p)
>  ino_t sysv_inode_by_name(struct dentry *dentry)
>  {
>  	struct page *page;
> -	struct sysv_dir_entry *de = sysv_find_entry (dentry, &page);
> +	void *page_addr;
> +	struct sysv_dir_entry *de = sysv_find_entry(dentry, &page, &page_addr);
>  	ino_t res = 0;
>  	
>  	if (de) {
>  		res = fs16_to_cpu(SYSV_SB(dentry->d_sb), de->inode);
> -		dir_put_page(page);
> +		dir_put_page(page, page_addr);
>  	}
>  	return res;
>  }
> diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
> index b2e6abc06a2d..1371980ec5fb 100644
> --- a/fs/sysv/namei.c
> +++ b/fs/sysv/namei.c
> @@ -152,14 +152,15 @@ static int sysv_unlink(struct inode * dir, struct dentry * dentry)
>  {
>  	struct inode * inode = d_inode(dentry);
>  	struct page * page;
> +	void *page_addr;
>  	struct sysv_dir_entry * de;
>  	int err = -ENOENT;
>  
> -	de = sysv_find_entry(dentry, &page);
> +	de = sysv_find_entry(dentry, &page, &page_addr);
>  	if (!de)
>  		goto out;
>  
> -	err = sysv_delete_entry (de, page);
> +	err = sysv_delete_entry(de, page, page_addr);
>  	if (err)
>  		goto out;
>  
> @@ -196,26 +197,29 @@ static int sysv_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  	struct inode * old_inode = d_inode(old_dentry);
>  	struct inode * new_inode = d_inode(new_dentry);
>  	struct page * dir_page = NULL;
> +	void *dir_page_addr;
>  	struct sysv_dir_entry * dir_de = NULL;
>  	struct page * old_page;
> +	void *old_page_addr;
>  	struct sysv_dir_entry * old_de;
>  	int err = -ENOENT;
>  
>  	if (flags & ~RENAME_NOREPLACE)
>  		return -EINVAL;
>  
> -	old_de = sysv_find_entry(old_dentry, &old_page);
> +	old_de = sysv_find_entry(old_dentry, &old_page, &old_page_addr);
>  	if (!old_de)
>  		goto out;
>  
>  	if (S_ISDIR(old_inode->i_mode)) {
>  		err = -EIO;
> -		dir_de = sysv_dotdot(old_inode, &dir_page);
> +		dir_de = sysv_dotdot(old_inode, &dir_page, &dir_page_addr);
>  		if (!dir_de)
>  			goto out_old;
>  	}
>  
>  	if (new_inode) {
> +		void *new_page_addr;
>  		struct page * new_page;
>  		struct sysv_dir_entry * new_de;
>  
> @@ -224,10 +228,10 @@ static int sysv_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  			goto out_dir;
>  
>  		err = -ENOENT;
> -		new_de = sysv_find_entry(new_dentry, &new_page);
> +		new_de = sysv_find_entry(new_dentry, &new_page, &new_page_addr);
>  		if (!new_de)
>  			goto out_dir;
> -		sysv_set_link(new_de, new_page, old_inode);
> +		sysv_set_link(new_de, new_page, new_page_addr, old_inode);
>  		new_inode->i_ctime = current_time(new_inode);
>  		if (dir_de)
>  			drop_nlink(new_inode);
> @@ -240,23 +244,21 @@ static int sysv_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  			inode_inc_link_count(new_dir);
>  	}
>  
> -	sysv_delete_entry(old_de, old_page);
> +	sysv_delete_entry(old_de, old_page, old_page_addr);
>  	mark_inode_dirty(old_inode);
>  
>  	if (dir_de) {
> -		sysv_set_link(dir_de, dir_page, new_dir);
> +		sysv_set_link(dir_de, dir_page, dir_page_addr, new_dir);
>  		inode_dec_link_count(old_dir);
>  	}
>  	return 0;
>  
>  out_dir:
>  	if (dir_de) {
> -		kunmap(dir_page);
> -		put_page(dir_page);
> +		dir_put_page(dir_page, dir_page_addr);
>  	}
>  out_old:
> -	kunmap(old_page);
> -	put_page(old_page);
> +	dir_put_page(old_page, old_page_addr);
>  out:
>  	return err;
>  }
> diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
> index 99ddf033da4f..b0631ea6b506 100644
> --- a/fs/sysv/sysv.h
> +++ b/fs/sysv/sysv.h
> @@ -119,6 +119,11 @@ static inline void dirty_sb(struct super_block *sb)
>  		mark_buffer_dirty(sbi->s_bh2);
>  }
>  
> +static inline void dir_put_page(struct page *page, void *page_addr)
> +{
> +	kunmap_local(page_addr);
> +	put_page(page);
> +}
>  
>  /* ialloc.c */
>  extern struct sysv_inode *sysv_raw_inode(struct super_block *, unsigned,
> @@ -148,14 +153,18 @@ extern void sysv_destroy_icache(void);
>  
>  
>  /* dir.c */
> -extern struct sysv_dir_entry *sysv_find_entry(struct dentry *, struct page **);
> +extern struct sysv_dir_entry *sysv_find_entry(struct dentry *dir,
> +					      struct page **res_page,
> +					      void **res_page_addr);
>  extern int sysv_add_link(struct dentry *, struct inode *);
> -extern int sysv_delete_entry(struct sysv_dir_entry *, struct page *);
> +extern int sysv_delete_entry(struct sysv_dir_entry *dir, struct page *page,
> +			     char *kaddr);
>  extern int sysv_make_empty(struct inode *, struct inode *);
>  extern int sysv_empty_dir(struct inode *);
> -extern void sysv_set_link(struct sysv_dir_entry *, struct page *,
> -			struct inode *);
> -extern struct sysv_dir_entry *sysv_dotdot(struct inode *, struct page **);
> +extern void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
> +			  void *page_addr, struct inode *inode);
> +extern struct sysv_dir_entry *sysv_dotdot(struct inode *inode,
> +					  struct page **page, void **page_addr);
>  extern ino_t sysv_inode_by_name(struct dentry *);
>  
>  
> -- 
> 2.37.2
> 
