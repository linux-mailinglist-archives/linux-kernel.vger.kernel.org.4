Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C9F746783
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjGDCXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGDCXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:23:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F10313D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 19:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688437390; x=1719973390;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zdSFFAJwcCBwqTcQLzgFSJgkFI6+ttVfA/uXWFN/y7c=;
  b=hQW/HT3rtu8SAeU3L2kNQmECB/rwjUJRuu75qaCiPcHZq8M+7qMSPGAv
   2fzOcaXInpVB4DOqFVjyhjsccrEaw1zsvj9c+Wd7XLujWx/4SHBiPMtxr
   g+DhEU4DW1pi1cDWcoP+JZFCGWQRqdTEP9lqfJWDhwu/gTrOsEj+fWdDS
   KfcLTvV0UIDvjpatv1ovUJZ6pmSQTRuvUqYZMq5b6j+NLPQtcsbMxahXz
   62XKekO/RUJaUmY+i9xZSIQcackQqIEnrIjyY3QnSdKKUAhH3qrIK0pq+
   9WKCmEnEMNWQUSzGvZNPZazRZV7Woql/dV5GOsAk6WRCq5WKEIEjgdNim
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="361871965"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="361871965"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 19:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="808759038"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="808759038"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jul 2023 19:23:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 19:23:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 19:23:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 19:23:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 19:23:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKsi1dTnrjkC4IPXM93lJ+GbqtjtEAcJONfksUMRLAoPuFWdNvTkiC5oPl9P8DXBzjQfE8pmKJfbZW04Re1KAd64crJ26cmqrRX5DDo9ysKMqFhCNV1aLsu2gKRrSb2u9yROXd4Ou8b/KcYUIW8qlR35OWWNo5+SlIjMDxztVkOOwnoqWcnIL15lrEe8dIPke/GhFNpVVQq8gi85hwd2BcuoOlOgHH2sWPuxSFa2cHqY8HAsAcb78B23GANn7YtwjymZaHsVmkQdTlvxkT7WXq0jQHl6AnQJY+xGpvcJrVJNG2/CiDr9wRmFFv6VCbp8ilG73RUgovtSBKh1a+Y4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OuadEYofs52z4aHMEitfLET5rDET5xIQVgZsGaDAvI=;
 b=GnzUUMhAiO2UQJHEQtx/DA5TCAv9WQqx/hIhkOU4U5d4SECVnz8CUYXbj6rFKPRT8PD5h44ofa2HT+7LwvsOny072fBRPrZVcgtOzTEE1bTf+Xv8RQ9N7rBpmbpCLMhkOC+BOG9BOHy70zwjCicN93Nz7BWVxKx5rOaYsAYaBw2wiDVCtGsPLpvU0BAm0caLshI9GMICMcHmauuJJdtRjwX1axmFecQia+ZPLZbpLlaSdb3bBYJ62SPwDrXUsD4xLD+jlzjf72M8MO1c7mb3tSXpd0/udeHMIOXOgnjooViHpmsljY0z6wAfqaTwBRXK5c5PchWLePlSo22WnLdkRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW5PR11MB5931.namprd11.prod.outlook.com (2603:10b6:303:198::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 02:23:06 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 02:23:06 +0000
Message-ID: <ac6802f6-01a2-6b39-38c7-2fe3cea75dde@intel.com>
Date:   Tue, 4 Jul 2023 10:22:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/5] mm: Default implementation of
 arch_wants_pte_order()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-4-ryan.roberts@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230703135330.1865927-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW5PR11MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f55b989-e8a7-4b56-1e46-08db7c359a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: joIuXGZd+Wkj5X23zMhYMHusceMgRRPjiQAz2JGLQMbwnamT7D5TKXk4FEdKY8/+ZjMH7OPou8k+/1tzmsVsOWgijZlbVPl6OEcnx9Xskd9lEalzvkZhZs3xbfm3ONwwR85lDdC1vSYlJfOifnnVc4sYKUpe/kHIaDZvKxL8TqarNQ4w7KTs7rzfLLVjMVQPVZQC9rpjsyWAn6r36vGkdtChOg6CBJlyD7NyPCnt7TiO3UUFeJUuWnQ13e4pcFejlGDj+T/tY9UkrdPMmb9vMCuX3rEeV7mEgCLbVmZH/XZUXgAx/HmWnZECwTC16Y8m2LJaLUGY/cuC3eWcCwQtr9K8Ehqegy+bhXGzVzgvKxcbA6tX6f1mXWHNFYRIjb12CZPwLAyH8BmuCbxWvrCvAGXbsx91HqD7ebD2uLThicC4z+zN4+shL922rg2s0LEC5ZYf1T6C+fN9RI/H4TlUWMgYT9bV9oIuTPMOjlaiY3UqnXtgEnzueCVNeKM/NFptyFJtEv2AqPVJqbl67JLCxE2eV/4+tjNcNk5uYsOoTFvz4TghxqTN6XDEuti1qfUlWyrqRjb07j8S/SWiBJNe1PYU70jr3zmMF87Y83+yRrTByUSbGJIQ6PYMtYv2HYDlNNT2RTPMBf4ey7NpDfCgYdYJomjwNcFhICd+Pg5Ksfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199021)(6512007)(82960400001)(6506007)(53546011)(921005)(66476007)(316002)(4326008)(38100700002)(66556008)(66946007)(2616005)(83380400001)(186003)(26005)(478600001)(110136005)(2906002)(31686004)(8936002)(8676002)(36756003)(5660300002)(31696002)(7416002)(86362001)(6486002)(41300700001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzhBclp6NGNJZUJYeEZnZTlsZ3FMZ1dzSWxYMy9kR3JNbWx2bjNlODFhcWZB?=
 =?utf-8?B?SlZCenFqU2dUcG5FVDBNMFQ2dVdrQWF5ZEdCUURBS0dOemMxOUFLclFHbzZW?=
 =?utf-8?B?ZHJsMDlIQVAzeS95Z2FhQ0tkakJkVG5qVWlVSVRKNmxSRGRLMVViZERJcE02?=
 =?utf-8?B?aHdTdm9JK3RvWG8wNFphT2Z2S283TDVEaEFJREtSWDNmRUpBR2k5clh3UEVr?=
 =?utf-8?B?VzJNQklqQVVkYjNtd2NGWW8rOHl0cHVDbDRhVC9jTGxZYmdxbnQzV3FMSnh1?=
 =?utf-8?B?VStZdVVoNWVYZmZtdVBLTUZGTnErZzMvVGtnMzd1cUV3Tlh2S0ZvZXdVa1FU?=
 =?utf-8?B?cHJ0S1lRNUdWK1pKdFVTR0FYcFgyTnhpQzc2TnBJRlRxV2dvU2hiNDBIb0Q0?=
 =?utf-8?B?Z3FZbmtVWXRMa3d5OGZ5UUlGdEorOGJDb21YM0JKRUk0SG9aQ2pqT0NkcFIy?=
 =?utf-8?B?c1NFeFNQQkxDZzRIT0t0NC9BVlVIakV0VWJKNnNxdmoxcTNsUU5EM0RUUDFM?=
 =?utf-8?B?bk9OS20yVUszOTBxU2ZCc0E2ZE0yaWF1U1FUUXRjY3ZCdy9kcVlTcDRsdUJh?=
 =?utf-8?B?Y091NWUwKzNkclppMG5oN08vVHVlYzRkVHZDWWRlSkFEclYwMjRibFhaemRj?=
 =?utf-8?B?aUlqdDNPV2JHemwxL3l6RE1UdnJ5T1lMREZnTExiL1VXWDhmeFB3bDYySUxW?=
 =?utf-8?B?d3NRWm50eXRiOHl6M25DcEdPM2RiZzN1OGgyY05ubkpwaDJyb0lscDJ3TVpE?=
 =?utf-8?B?SFY3RnN1OS95bEk4MEpYcDlmejhZdGRnS2NnMElrbnlCL3k5QUNRQnVEN2Nu?=
 =?utf-8?B?UjZlWjNKeWFJQllHZjZhWWJwWVduM2oyL3lQcjl2SnZOVVZMZXRDbGZnbjAr?=
 =?utf-8?B?N2ljdkJQamNoSlZzei90VEVPWTV3UE9MaENZZTRpMFhsTDc1TGtBRm0xYnd4?=
 =?utf-8?B?N3dKOTBhdTR4Y1lRVUZaVExOWldudEQ2dkRZenU0cXd2a040OEcyR2lxTWZ0?=
 =?utf-8?B?VG8vUVlSZzhLNW5wM0d3dEJWSkV1VFdIUEF1VmhIb0xoSmpBbjJhbFE0SXJQ?=
 =?utf-8?B?QU55aElvRGJjSnpyclBlNUd5NzllREs2QVpLb2F4TUVqV1BkVFhJMVpBZVFC?=
 =?utf-8?B?YzlMRjhkbG1kQVNDYnVOSy96dmM5KzhxRDZMK0FlZUVMTS85MGt1ckdEMTVi?=
 =?utf-8?B?Sy80Z29BRGgrOEFkd2FCRjNwRXVBL1lxTCtOL2Uxb1ZTZS9tOHIzQmRva3Zq?=
 =?utf-8?B?M1N5Uml1Qko4NlVraWJveXFHRk9qOUprZVpIWUsra09JZWhQc2xzNlRZZHRZ?=
 =?utf-8?B?bUg0bHdFdGx1MzB6MlMrMTQrTVU4S2REallUNE9NYmJuNTZ2Mi9naWo5ME54?=
 =?utf-8?B?WlJzaVdJZlFESmNVc1dOMnRnYk5aaVFDYzR4SG8ybGJ3S0s2amVqMm5YaUxv?=
 =?utf-8?B?ZkpJcWdSVDg4cVhVSEZITzZ6T2RHVHZGN3pHRVZ0U3dxemtpSE9sMllRZ2xW?=
 =?utf-8?B?VmtKbVJZM1NsMnNSdERudC9KVm16d3ZFVVZQTFVQNlNUOEtBMW0wNjhMNVAy?=
 =?utf-8?B?QnU1ZGNYSkF1N2o0MlhhZzJ5Sm9kMnAvUFFOc213ZG9Yakh0S1QrclVLc1dr?=
 =?utf-8?B?TXpYcytwc0VVREluWVZNKzQzUGNmY1p1Y2JXOFcwY294dy9PeGY2RXdqRzhG?=
 =?utf-8?B?MHdSL3RpdDVlUVFhb1BzZzNSR2UyWE1BTVVTdUFLU2Y1ZEd0Tm5Rbm5YR05h?=
 =?utf-8?B?VUdQVUhBYmpRZW9uTGdGeVE5elZvbUUvMHJGblFaNWEzZjVLT1I1V1JRSjJD?=
 =?utf-8?B?dFdKNXNXMktUTTdmTTRLRDY4S3Q2TkVHbytBYUsrOVR2ZlMrZXplMUNnb253?=
 =?utf-8?B?S2dySytDQjJiWEdvV25Oa2xXeStnLzNEdm1oWFB3RmwySmRnd2pscGJSOENH?=
 =?utf-8?B?M01lUVFwRzlMaWVMMGtIOGxDRlJaT0JzbCtyTk1VNEhteXBZOUtybzNpTlJl?=
 =?utf-8?B?RGxZZTE2TWdGR0VEdGdPTzl2Qy9ibjBCYU5hN0t4SGR5cENmQm5rK2Y4V0dB?=
 =?utf-8?B?bFB3QytRK1lJOGI3aTJDYVc1bkgzV0cwd3lMRWl3dTFOT1lYVlhwVVZRS1Y1?=
 =?utf-8?Q?0NW8hK5mlaSont3WsBbUwOfNu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f55b989-e8a7-4b56-1e46-08db7c359a2d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 02:23:06.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuAL8Y3eQansLWsszmHMvOml/4ZsH+wvDV4w/pttsDqSomGx7FyTLvZKc8nVzmnZoVG19yyzDcpGQ1NHBb6pow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5931
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/2023 9:53 PM, Ryan Roberts wrote:
> arch_wants_pte_order() can be overridden by the arch to return the
> preferred folio order for pte-mapped memory. This is useful as some
> architectures (e.g. arm64) can coalesce TLB entries when the physical
> memory is suitably contiguous.
> 
> The first user for this hint will be FLEXIBLE_THP, which aims to
> allocate large folios for anonymous memory to reduce page faults and
> other per-page operation costs.
> 
> Here we add the default implementation of the function, used when the
> architecture does not define it, which returns the order corresponding
> to 64K.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/pgtable.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index a661a17173fa..f7e38598f20b 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -13,6 +13,7 @@
>  #include <linux/errno.h>
>  #include <asm-generic/pgtable_uffd.h>
>  #include <linux/page_table_check.h>
> +#include <linux/sizes.h>
>  
>  #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_FOLDED) - \
>  	defined(__PAGETABLE_PMD_FOLDED) != CONFIG_PGTABLE_LEVELS
> @@ -336,6 +337,18 @@ static inline bool arch_has_hw_pte_young(void)
>  }
>  #endif
>  
> +#ifndef arch_wants_pte_order
> +/*
> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
> + * to be at least order-2.
> + */
> +static inline int arch_wants_pte_order(struct vm_area_struct *vma)
> +{
> +	return ilog2(SZ_64K >> PAGE_SHIFT);
Default value which is not related with any silicon may be: PAGE_ALLOC_COSTLY_ORDER?

Also, current pcp list support cache page with order 0...PAGE_ALLOC_COSTLY_ORDER, 9.
If the pcp could cover the page, the pressure to zone lock will be reduced by pcp.


Regards
Yin, Fengwei

> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  				       unsigned long address,
