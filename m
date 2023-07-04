Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26763746730
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjGDCOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGDCOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:14:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE52C136
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 19:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688436892; x=1719972892;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vmGa5DGy59gYJabMuqSSzA06E+s92qa5eP1RMWGxsNA=;
  b=mUI/nMvAAUV2JsS8a/XKUz77aAoTZhaXImljCHvI707CDXOcauKSdfbC
   YfBy2HCIxhXtVd85V5P38E/6fdoaeFM219vbA6FHADNpRMgKp7tPhFinv
   rWqS9ucSqb3xYclZJroepDLGNBM0FHSJXpE1xGXmyDjP67pMoobruvWjt
   sXpzB2vHsA/yqiJPo5F/ZfM5g34ThckOyHtQDQ1dIatm4cq5ozlP6m92h
   wWvPL6rS0KGfU/ust20s6oWMcW7jrCEzrx7My5zm9PhPG+zxbsO2pfuBP
   V5XYnqU3ql2dCwbfkkcq+2HI7Lrg6dCUUAtuNArH8tb5CrqgkpVKiZMIy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="429048130"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="429048130"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 19:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="721938268"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="721938268"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2023 19:14:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 19:14:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 19:14:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 19:14:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 19:14:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqlMaKjU+xeqUt0LO11e2ElVbczgam9iZwQ/v0V30zFW1UAkuOQyi3UpzQ/Odd3LjHWOc4zP99S1luDB1VHVkWqXxD5nFdMOCrDgA/Tc9FPDKiGplCDrg1geRNf3uruzBtkopk/3c1aKvNKwcCVyHFVlByLiD0WjV4KeMPKrM8Gm89dPzbQ59F9OAhqVzfYsRrUt/w6MNU4FoVFcjYiWnFSuEVhuA+bKmfaPhw+nk5jGYn4fKgP/RTgwOvKIbQcd8QPGTIiMURZgBd44s+zXrJMDz+TeHxgN+M/tcnCT5vF0cDCJW3MpQe5l5h+E5Ge4n3MRz6ZE7n74CYke6GRoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAXLA7pI9LQL12o0oQgaQ4MzqdyCDF0svFjvwaZL4qs=;
 b=h2ugxWvYFF6O8/6uKiF7RqhFdmq/9IvsN2f+3XJ782yy3TYXX3WXwkRfJX2LdSyie77vaE1UgOO7szLDzUNyhcjd4dDk+Mj17dRHMLxeTjYAu7/lN8zMofvFwR78aWoizv42MViNC6aJKJ2asofEfitCsqQnN8jPSZKQu1+COOGEkyrEkcqBonICPqTefSIIX/KpmOrUQ8HKtm1WIXaiTASWN4fBfJZDG167HgSyzLF5yWBcuBBsrNSSoYjQhY/wsSDMZWn1mHd0tIJ49aVNS5AbwDjTlxOOcC/OZUrlNH4taLWTDdOm++IWMOtX1r2hAoZhK6UJWolpaGlx7c9LLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH0PR11MB5904.namprd11.prod.outlook.com (2603:10b6:510:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 02:14:46 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 02:14:46 +0000
Message-ID: <eeed3e2f-1f10-5d42-d4a3-3685a743e19a@intel.com>
Date:   Tue, 4 Jul 2023 10:14:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/5] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
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
 <20230703135330.1865927-2-ryan.roberts@arm.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230703135330.1865927-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH0PR11MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: d591bd1f-f772-4d7f-1ad9-08db7c346fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ItnksG+oB3EiQu/Aql/YMedb3Cz1FZ8cozu/9nePifFtxaymUhny8xDkAjMrSNEl7OHp8rsTd4jXB7KNAjgtvg2dVh0PlN63Y+W6bHP24k3S1vOCUz0nOMsN0poQHqDsIh/XZBd2oCv2CCDUccrVUxmfnTxyHQd5aQZMfLcmWMs/FTqSvl9I2Vu9Wa/6Oye8B1D70+3GM50iRiX8I8RNMUoP+CYxMJuwHN2SvUxPksknCxiOh93qc/1GInKPZaveFaBd2OklhfB8T2u2tNS1M8piZknCixwan6zRO/5Zqs/gDGnSRU983cdmni4kqhNP7FchjkpaAH+0FwJv4rDEp0KC3dfJO9EAaaeO0Z01b8K3GvgW8Yhft5NBe2iAeNlxxNOxyKhdAR3amsAGom9nN4pvjGWTaYfO6Bv+FQTbNGXhFHLy+9ytzHWwEcR+LwpismH7OtQj4/2+VJO9ox4w0LJAzvs+hIr50wIsCjY35YGD2CERoAFoWTs1RCUHjujjKH++jAlHVewY4aXwu4jbxR0NsyEHvV+8dMy+i6auLOZ1BMcxF6fIE5a63PHXDBS++qBD6WFwD3rFl+sZhMUgWHacnL31WFOQjGrSRHALhQlrTHqfoQOuvMZUOqdIcBzhOjeXpKSvHPlsVcY/43Wz7dD1ABpOqDED9Jg9S3s/F/0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(4326008)(316002)(31686004)(66556008)(66946007)(186003)(86362001)(31696002)(66476007)(26005)(6512007)(6506007)(53546011)(83380400001)(82960400001)(2616005)(921005)(2906002)(6486002)(38100700002)(6666004)(7416002)(5660300002)(478600001)(8676002)(110136005)(8936002)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFhCMUMrbFlaR2d2U01UWEQ3ZFVvU1pRT0kweHZiZkZoMHA2bFpKNDcrT05n?=
 =?utf-8?B?TXRSU3ROb01BTnhQSHdaWnNsWVc0RUlCM1ZNMzZZdlVXb2hxT045Z1hUUkgz?=
 =?utf-8?B?VUc5RkJ4MVJuWklPam95WXl0ZGlZQnk5WGRmY0x6dlRoUzVQRStZTXFydGQ2?=
 =?utf-8?B?VHpzSFhtenVFOUxQWExtTDhralcxK1lXUUpCVXdnY1BKM255Yi9MazBwZ3V1?=
 =?utf-8?B?Yk9oVmtwMGwyOGRrY3BxeUxZanh5Z2NHYUFDSk1TTytlUUFUZjVvVGJ2NGtl?=
 =?utf-8?B?eUtsVEpUQ210dWswbVBmalo2VGhqUk1yUE56d01pVXpzOVg1S21rUEpueEJC?=
 =?utf-8?B?MEhobmJEYXc2K1kzWDBHaXF5Y3lFUjNZRnVPekVETVhMbG1lejZxYllvbnh6?=
 =?utf-8?B?U1JVdThKNWUxK0JFMzZZY3VjVEVYOEhvdi90UzRkUThMY0E5N0RUTVZYWkdq?=
 =?utf-8?B?UmVPREZyK094NVJTazl5dTF2NEhwbStZUGtmT2RjaTRlMlQ4UUVwcnFqNnMy?=
 =?utf-8?B?K1I5bnNXZ0RQRDdpOUdpVEZSbXkxUkhDcVAzNDFYVGZZRGs1WFBEY3pROTdj?=
 =?utf-8?B?OUdWVHpSbEkwTmxxQkkzOWFrcFZld2lOUkl2ZFFYNUFXMWhLQmVhbGRFUzVJ?=
 =?utf-8?B?SXFJbGRjMVd3MzJlQVl4eHdWK3BTZEVkMU5hVUhESk5jaGhwa2I5bkxLenNJ?=
 =?utf-8?B?TnovSTY3NyszQXNiMURyM1dOdnArU3FYY0NBcVVnVndmVVRGMUM1TmtjVExj?=
 =?utf-8?B?RzN0c1NvbjJQVkVBWVh4S3NVRnhTMkdkYWdqMlU1bEVlNmthSFZDWTRvWjF2?=
 =?utf-8?B?QjFENGlEdEJkR0YzamVKRm9WRUhnaWZaTDh6QXpTOHhGbDhZM3FTdXcxZlcx?=
 =?utf-8?B?NlFESE96UjVwdUM5UlpLTlR4TG5nNGo3OFFuL2JEc1NZNWwyNjJEWlIwdWk1?=
 =?utf-8?B?NTlNRHQ0NkNQK3lkSUNjWndjdVA2QU1nZ0U5L2lmYnNuRHZ3SWMzTklrZVl6?=
 =?utf-8?B?Rng4ajV1N3BVWGx5Uzg2WEFzU2RIaGQrZWpVRVVNVHFjc29Cb0hDd1ZMaTZH?=
 =?utf-8?B?S3ZqZmFnRy90dVJQUUxqRjRDSmY5WjZQeFZ6UEdWM2R6NWVwalVnTkhRdG1D?=
 =?utf-8?B?R1FMZkhBUzR4cmJQeXJKLzE5ZC9JUFR1cVkvTWxtcS9MNUhvZVhiWnZHcFEr?=
 =?utf-8?B?eUlGdlBPR2J6bEt0dytWR3p4dzduSGc0emk2cDVpR0xTQnNYQVBMUDFraDVB?=
 =?utf-8?B?TEw4bXI2K2JwQjJNRWxKUGVrcmlqak1ZRnlYK0owVWt6SXVZaHdIdHlLa1Ra?=
 =?utf-8?B?R1Z3NTZBNW5waXl6a3doSU52cWkwRGovZ3NFcGFWVmZqdGpLNjdoT0VOT3Uv?=
 =?utf-8?B?bjhTM29QdnZqd0tlSW81MEhwV2lIdnpRMFZvT1FzNjJ5MjdHOEpCMzZTQlhP?=
 =?utf-8?B?L2VteVMyWUFJQ2hLclZXSndHS296UXZ2NzArYW0yaDJRc3JDTFBQaWhOazFV?=
 =?utf-8?B?UncrZ1dvNE5uZ1F3OUFoU0ZLcW9VbkxlRVgwSlUrODFlUjQwdVgyVDlrSHdn?=
 =?utf-8?B?SU5HUkVGSHYrYjN2eVZXOWlybTUvMkhMRTNGK29IYS82L2RKTDc3M3pFVUlZ?=
 =?utf-8?B?S0ZoNEg3b3ZkcFA0VWdkS0VaTFEyOVZUclkydkFQNmpaRVBVSFlPMFhHYXZU?=
 =?utf-8?B?Q1FLV2M0YzYwSFRhdUM2Sm1VUVVoQzc5K01zZ3RyTFBTMEdQWEx6ang0Vm1S?=
 =?utf-8?B?dEUwL1cwZW9hc1hRNitDbllZMnZYaS9CZTB5VlZNakEvZUt2NTJ6c01zYUp4?=
 =?utf-8?B?T1JwanlqMm9XbWI5RW1aQ01peWtGRUVvak0ybEdaeFBOY2hYSDE4dmc0SkZo?=
 =?utf-8?B?T1FEV0RrWWZFbHNVNGhreFJQcVhCVlhiMmt5ZnZVNmdiQlFUaUkySmVDUDBD?=
 =?utf-8?B?UTRnVGh3MHJBNGFmcmYySDRQcnJYdnN1V0Q2S3N3U3VMMVgyNTBNMW5EajZE?=
 =?utf-8?B?VWUxMkl0cnQrSDBKeXJmRU9NWWFDdXVGTllxR1BMZFZocTJhSkpiVFB3SVRE?=
 =?utf-8?B?OG5nMUVQdndFQUtMVDIyOTlXSVBDTjlOMndIUDlTM29aYVB2R2MwVXFEKzR3?=
 =?utf-8?B?VUZzRklNb0E1ekRrbjk1aGsxNnN2VFRMQThsSWF3NkJHNXcvWXlacWdGYno3?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d591bd1f-f772-4d7f-1ad9-08db7c346fdd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 02:14:46.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaBlQshwNuyPoa93VXNDtjSJtstcup8h5i9DThj4rYCtr/EA8g/u95AIsOnmG4RmytZI6aUhXwTygLL0nHY3NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5904
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
> In preparation for FLEXIBLE_THP support, improve
> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
> passed to it. In this case, all contained pages are accounted using the
> "small" pages scheme.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Yin, Fengwei <fengwei.yin@intel.com>

> ---
>  mm/rmap.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1d8369549424..82ef5ba363d1 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1278,31 +1278,43 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>   * This means the inc-and-test can be bypassed.
>   * The folio does not have to be locked.
>   *
> - * If the folio is large, it is accounted as a THP.  As the folio
> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
>   * is new, it's assumed to be mapped exclusively by a single process.
>   */
>  void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  		unsigned long address)
>  {
> -	int nr;
> +	int nr = folio_nr_pages(folio);
> +	int i;
> +	struct page *page;
>  
> -	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
> +	VM_BUG_ON_VMA(address < vma->vm_start ||
> +			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>  	__folio_set_swapbacked(folio);
>  
> -	if (likely(!folio_test_pmd_mappable(folio))) {
> +	if (!folio_test_large(folio)) {
>  		/* increment count (starts at -1) */
>  		atomic_set(&folio->_mapcount, 0);
> -		nr = 1;
> +		__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
> +	} else if (!folio_test_pmd_mappable(folio)) {
> +		/* increment count (starts at 0) */
> +		atomic_set(&folio->_nr_pages_mapped, nr);
> +
> +		page = &folio->page;
> +		for (i = 0; i < nr; i++, page++, address += PAGE_SIZE) {
> +			/* increment count (starts at -1) */
> +			atomic_set(&page->_mapcount, 0);
> +			__page_set_anon_rmap(folio, page, vma, address, 1);
> +		}
>  	} else {
>  		/* increment count (starts at -1) */
>  		atomic_set(&folio->_entire_mapcount, 0);
>  		atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
> -		nr = folio_nr_pages(folio);
>  		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
> +		__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>  	}
>  
>  	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
> -	__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>  }
>  
>  /**
