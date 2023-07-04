Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1EB74672E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjGDCOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGDCN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:13:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75633136
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 19:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688436837; x=1719972837;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZlEflSOUjo+nY1x3xKvF+XMnX+jFKmpEZS5A4JK4pkc=;
  b=iL0yH/CrxCNqmJW81FLLehc3EnvNYxJj2EsT2bxJxaxljcIMk6mqp4Cg
   b54SEmK+5gVioiaQJ4UqbwaOzLacr1CQIStOIQrneUTSWrMc3bl4G5Ab5
   /S3EDfwVvKrCCPSCuPt6680lpPX3+zX06FLhkv38ZzgNwD7BbOUTC08m5
   AeB3eUV6XmhW8UFz8RZum+2AOsNDX02EUiziAiaGwTM9pEbV7JksErIDp
   xwFGbIt98UHi/69aH+GKT1vQDuMefXxFDFsQrRh45Degf4ItoB6mdnVJE
   s3aJ/f1ZmhUeVTFgmOeaL2O1EZZyps8bRLxwUeMighi16IDzCX9iCU0RH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="429047965"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="429047965"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 19:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="721937921"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="721937921"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2023 19:13:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 19:13:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 19:13:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 19:13:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 19:13:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHG0PFb2KPcgD5ypnfUucpm65PhTU9bhpHDBmJ/1unFrMpXgczc3/H93MxM1ynnr3sdUqCUcWvSrkkQ8YJ5BHX7cx6NMurKj1Uds1xOzIC1dcAEBbYmYTIBQQdZBnWIKBLcLr8/AZ2l0OKrlFy+ufaCIIz/EZxnvD4HVitwG+/qJl04eww5GL5NDC1FyFwVs6/p3vUR4ZrwWwKuO758XLuUQvCT/gHj8MBdsNAMn5ZlUoRSePPqCcYyxctPlwaWNsl7jlv4HJUqdA3MWB1o4s7VhMpYVA+MAln8oCZ3KfFxGYE6zu44QCIkLjyny1blf++JM1Nlg7ddc4lWe8aLk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdU576tY2o8dajexviNWb22PUou7TXBOANf9VuTQzNE=;
 b=NCIkV1q4T+K57MOSLUoZrhkoPP54eQ2IIIcDuHBKj4yHmQHqxAKElZ4cYRtbNvnIqh2RIxgBXQUA5NfvJ2mFGDjm89afnzv7mhmKpBvcPv1vAXE0MOtJckHkFlAe+tb8Dr7Eo2/lA1IAXmIY41BnbFEGS964aHoPldSV7eG7TZGioItTJ1NND2EymEFP0af/Qc5uav4TK435zgtDiMs5eIkbqDTNP+mz1NulIWTNWd4UD8XVhVGwrwmygT7zybIuxb06yU+Wl+VBWRWbIB58hRFZ/PzTOKepRLeZdfGYPPEIRXSiFW8Qdl+vt5hzVH9OZ1ozLkdEn+56VCA0Tkm7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH0PR11MB5904.namprd11.prod.outlook.com (2603:10b6:510:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 02:13:45 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 02:13:45 +0000
Message-ID: <9e2fe34e-7615-119c-43b3-31d0b8be3af0@intel.com>
Date:   Tue, 4 Jul 2023 10:13:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/5] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>, Ryan Roberts <ryan.roberts@arm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-2-ryan.roberts@arm.com>
 <CAOUHufYtW+6Svaq7pcyBiModTSKn1VU-LKxB_Xwnja=f83X2YA@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufYtW+6Svaq7pcyBiModTSKn1VU-LKxB_Xwnja=f83X2YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0122.apcprd02.prod.outlook.com
 (2603:1096:4:188::10) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH0PR11MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d8826d-3bf4-4001-45d0-08db7c344b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQ6AzmyGcuf3UVqy//BvcYKi5cDnQBlO/OjCfX9DkOeGCAp5esCkK9PzBU2OtB1S4+afPr+KLJnfSIBt4z2DgdtiRFV9GYc7iOdxmA8l/UwYI+/xCspZM+Mo4vlh/o1aALTrMOLXCdOjz90lyjxTwW1PN3yIEOi9tDxlVlX+ThnzbE/CNlWvWUqni3000je2KzEi3AqbaMycLiPX/bEQyCTWPjrPgLzfy5vc142eiB9XLpNGsLk9XwAeEKglPXlMrcCQ7+DE+M1zFWADwt+sXAjVKHZm4/VZIFpEArhVTcR81bQlQRPFsxR7FIGPA2OArjKmD5sJD1A2HobJ5/BbfGG2CwXYroLnSto2BuCMB6Z8zcb7SLSO8OSpQvjbfWRYxUIrc8hImn8Y3rJxlQLsg9e2F6EM49IF+ZwB/Gt6gPb1QtpcAyFf2di+od/qBb+3IiBj5fijdD71OVTlOJEfEXOw/l9tRXR16dTdKG00Y6OJfnJIm/NcjMtdS8rmtWr1KGqSPb18qHra7FUSbGE2UwzEcyRfbnX0oplUuwaWXkMIo3BwJ/kMgWjyIOhuMhQosijdsl19jZkk83gm2N1JE11R1sueN9qPG5FOJB/HxQg6nY1O4VnGq9qQGuKNYrzuCfLW94Vr0KTUrzPl9VzuIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(4326008)(316002)(31686004)(66556008)(66946007)(186003)(86362001)(31696002)(66476007)(26005)(6512007)(6506007)(53546011)(83380400001)(82960400001)(966005)(2616005)(2906002)(6486002)(38100700002)(6666004)(7416002)(5660300002)(478600001)(8676002)(54906003)(110136005)(8936002)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWhaakRGQmw1VmFqYktaNzNmdlo4dE4wcENOemU4VVFvT2R5UXVMTS9MRStl?=
 =?utf-8?B?TU9xN3RjQkRRUWVBeHpJTFNYN24wZUJVQTVwSVlCdmR2cDlvQ2RWV0NuQlFR?=
 =?utf-8?B?K3NrVEwxL2x4TVpYQTMzT0lpYndSL0dkRFZSTlVVRUk2RnU3NC83amNJL2xj?=
 =?utf-8?B?N0VjVUxJQXFsOFhQNjNXZU1wMDlmNENsQ0U1cGZTM0RVTFpJalhCbjVtTERY?=
 =?utf-8?B?a0lnU1JnZWdVWDhyemYxaDlsT1JvZFNSNUphOS95TndOcDhlYjZsWXV2Z2ZV?=
 =?utf-8?B?ZWltdDJoc3VUYTBKeVFncjMra2ZvL2VlaitHN3dxYTVXSDBWeVJsZnRER3JZ?=
 =?utf-8?B?eTRQMitJMVJRMURMQWhsM1RpeWZHQ3MwbFRqSDRtMHZmNlk5c3gxakI1VXdZ?=
 =?utf-8?B?WTZ6NHpXQ1lMTTNPZTJWR2hlQXUxczc4clVhb0hLWnFuVU40d0c1NmFrb3J6?=
 =?utf-8?B?aDlTMTFXQURWNWdnRVFSV1FiYVB5anZXYXM0Rjh0NDA1cjF6NU82N0tuRVN6?=
 =?utf-8?B?ZUNxRCs5bUpaaTBYRGNxcVBsd2VjVHpPNEFHYm9vMUp1NjdoYjVrZnY2ai85?=
 =?utf-8?B?YnFMNkkzNm5QSForVFlrTUFIVitVRFVxb1MyRm5FTVRaci9mdFBxUUtIMGM3?=
 =?utf-8?B?aXNqU3dEL3c2Y0pLR3FHNWhrSEtPYTFrb3Z3ME1Gc2JQYzRhZGk5b3FuU2FC?=
 =?utf-8?B?RjY0LzRacVorRzV1alc2ODVSdXZaWng4VlJBWkNacEZqSThTcndLZy9UV2NI?=
 =?utf-8?B?ckM1S3ZZNnZIcnlUM3lNUW1uQkQ0MEJvcFVlVzUwak5vdHdLcFo1UmQweFor?=
 =?utf-8?B?bGhhbkFRWVRIYjFtRnFMdm5BYkRlMkZPb2p0eDRjMXpiOXA3Rml5SlNPNE1U?=
 =?utf-8?B?SW10S0lubDNFNUxFaWt4akhsOXR1VUcrMjl1Tlhna3hzZHdLeXRWRUt4dmVI?=
 =?utf-8?B?SmdHM1JxSXE2RVgwTlVCQ0U4YXlyejYrQk43SDRiMjMvUElCd3o0YU5hd1B3?=
 =?utf-8?B?czlmcGhJQ3hyQkFYTXZBQjg3bnJXajVjUVpkaFhMTlZ4SHc4dW5CYk5aN1hO?=
 =?utf-8?B?ai9mc3dPWHFQRktHYStkZVAxOVdxNU5yYlFJdW9IcFhlaFk0YjJvT2Y0R3Nr?=
 =?utf-8?B?Ly9WSG5aMS9SclQ2alUyS2xuZnd1Ky8wK0JjWENheDBoWTRHUW1CaUJZU1cw?=
 =?utf-8?B?OWFRc01aSHVCb0pPeVMrQjBlSEVRTnpmalR1N1A1NGw3MzVlVU5uQ2RNQ3ht?=
 =?utf-8?B?U2tSdytoOW5HU0lZN3pIVWhlRnJDWktBUVlHZmFiaksxQXBmRk43UXFwdWJa?=
 =?utf-8?B?Y2doR0RTaTlQOGFJelJkZk14d3JISGdsRWJZRGQ1SDliaElYYW93UGFidTIz?=
 =?utf-8?B?VjZhV0duaVhjL2NnMTM1RExLcUp0ZEJWSTArbXZUWEU1ZHkwZ21KUUE4SzZz?=
 =?utf-8?B?Q2gwSnRrTDZEemo2b3NKRnpubmc1NGJYNnVvOTNyYjFUL2s0a0FqU1FKS1hP?=
 =?utf-8?B?akwvS2hDT3YwU2xZaklJRXRYYVkxRUlyVmMzZjJZZXBZMUdleW1mSmpONUpv?=
 =?utf-8?B?dCtaNlpWMU92N1FweklxS210bnBHL3dNSWQyT1Zic05hd0FzeEFkQ1did1E2?=
 =?utf-8?B?L1cxUmRPcExqUDA3MTZjQVZuV1ZuWExtSzN3NXRCdHBjWXhSWUR5S3lQMklw?=
 =?utf-8?B?UG5FVnZibGVqL2dtaDJJSXBXSjU4cG9nUkF4eXUybWU5SDU3Y3BEamF0SFFo?=
 =?utf-8?B?cGdNdEpqRlV1Wk5DbjNXd2ZNclk0SkpyN0pDUjI2S1krR0F4WXMwdHZIMDBJ?=
 =?utf-8?B?MERjZGhyeVBaT0pzMFdsZWdBcWlxN2VQcmlGLzUyeDByVlgwSjlaTExUOVAr?=
 =?utf-8?B?ZStmNXRmUWxXZHAxMkw0UGkxeURwRmFIUkt0WHpPTUp2bG84b1lXdVgrMkNw?=
 =?utf-8?B?a0FLanp2UzAxcUI3L29QSFUrUnhWK2VFYnlNL2d4d2Y5MDBlK1hJQUhRbmpt?=
 =?utf-8?B?N0d0disrVnJjd1RLK1YvTldSdS8zNnNxMlZ0bjBseC9XYlF3UnlvVDFRUXVC?=
 =?utf-8?B?aU5pZXdiZ2VYOU02L1o0amxJU0pEZDM4YS9wblV3RktsYWo5OE16RkZ5QVZj?=
 =?utf-8?Q?Z+9hMeQzgn2g6YAKX1fo+ZbQI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d8826d-3bf4-4001-45d0-08db7c344b72
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 02:13:45.0118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCUu59+a5ZfY8+pHw+m6xMv8W4IOTXv5+ZRwQfZZLNV0FKaCkWlf6Diu5PMCo1H70ZN4ZUfddMa+5MiKSdZ1kQ==
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



On 7/4/2023 3:05 AM, Yu Zhao wrote:
> On Mon, Jul 3, 2023 at 7:53 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> In preparation for FLEXIBLE_THP support, improve
>> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
>> passed to it. In this case, all contained pages are accounted using the
>> "small" pages scheme.
> 
> Nit: In this case, all *subpages*  are accounted using the *order-0
> folio* (or base page) scheme.
Matthew suggested not to use subpage with folio. Using page with folio:
https://lore.kernel.org/linux-mm/Y9qiS%2FIxZOMx62t6@casper.infradead.org/

> 
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> 
>>  mm/rmap.c | 26 +++++++++++++++++++-------
>>  1 file changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 1d8369549424..82ef5ba363d1 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1278,31 +1278,43 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>>   * This means the inc-and-test can be bypassed.
>>   * The folio does not have to be locked.
>>   *
>> - * If the folio is large, it is accounted as a THP.  As the folio
>> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
>>   * is new, it's assumed to be mapped exclusively by a single process.
>>   */
>>  void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>                 unsigned long address)
>>  {
>> -       int nr;
>> +       int nr = folio_nr_pages(folio);
>> +       int i;
>> +       struct page *page;
>>
>> -       VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
>> +       VM_BUG_ON_VMA(address < vma->vm_start ||
>> +                       address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>>         __folio_set_swapbacked(folio);
>>
>> -       if (likely(!folio_test_pmd_mappable(folio))) {
>> +       if (!folio_test_large(folio)) {
>>                 /* increment count (starts at -1) */
>>                 atomic_set(&folio->_mapcount, 0);
>> -               nr = 1;
>> +               __page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>> +       } else if (!folio_test_pmd_mappable(folio)) {
>> +               /* increment count (starts at 0) */
>> +               atomic_set(&folio->_nr_pages_mapped, nr);
>> +
>> +               page = &folio->page;
>> +               for (i = 0; i < nr; i++, page++, address += PAGE_SIZE) {
>> +                       /* increment count (starts at -1) */
>> +                       atomic_set(&page->_mapcount, 0);
>> +                       __page_set_anon_rmap(folio, page, vma, address, 1);
>> +               }
> 
> Nit: use folio_page(), e.g.,
> 
>   } else if (!folio_test_pmd_mappable(folio)) {
>     int i;
> 
>     for (i = 0; i < nr; i++) {
>       struct page *page = folio_page(folio, i);
> 
>       /* increment count (starts at -1) */
>       atomic_set(&page->_mapcount, 0);
>       __page_set_anon_rmap(folio, page, vma, address + PAGE_SIZE * i, 1);
>     }
>     /* increment count (starts at 0) */
>     atomic_set(&folio->_nr_pages_mapped, nr);
>   } else {
> 
>>         } else {
>>                 /* increment count (starts at -1) */
>>                 atomic_set(&folio->_entire_mapcount, 0);
>>                 atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
>> -               nr = folio_nr_pages(folio);
>>                 __lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
>> +               __page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>>         }
>>
>>         __lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
>> -       __page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>>  }
