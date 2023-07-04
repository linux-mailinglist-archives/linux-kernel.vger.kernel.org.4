Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D05474698E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjGDGWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjGDGWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:22:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E5EE52
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688451761; x=1719987761;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bjhx/pG4ktzoTAOYCFOwHkCQkZb5PpHdwv0g91HTbk8=;
  b=J0cFewd0Y5pBceB0gnZScOkplROafPjWbGvTAi2J8Tg9bPQHHFCUuhWq
   XfRziUpCWzsMHDbLuCg4zXzg4g4mQ8RtJ3fRbNQhSRAPLHKh3X9YsKUy6
   OSeup6kVGFPBVdqsKlb4c3Z8N4e8ofFXa2VWuur5iMQG2egRF4dvGRitN
   GWBtVabJ+IVTYGSxug/dSuqqx2e4J4AJvHOZUuFOiMd48iP6uIsvl1N7R
   HUYtUdOS+kYmDLt1rOaPW9g+WMGUkLXZAqvoZlQ4lkR3zVXGpxvSUY7PR
   eawzZUM1e2mqdElYyZLON3wV65daiwvc4ngsiEthdr9p9yNjszZ+a7gyH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="342636918"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="342636918"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 23:22:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="892761483"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="892761483"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 03 Jul 2023 23:22:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 23:22:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 23:22:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 23:22:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 23:22:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxK8mSomJ/CxjJYnY36bhATolaKUrPcLdqebplfHpDum40TaUA2Ol0i/uA+YakPPZPjJWHqe0njYOUBBIt4heaeQW6iP6n9eUSxGhyxVtL9mWlikIUtEUGB7pZR7fp9FaK6VP2c4lpgkCnxjzN0T0ujXso3edbH87CUXdjoaIjC2ynaYMUvhw0uR8Tf6UavL7Z6SqBL4mvVjQreuyagaKNKB6jP1i1nBk5RzT4U20Qnomiy2KO088uO5QjhLOBWRCtvX9OFx+EGmY9Fj1RkxXarCRqc6UXilpaiTCY7z6GaQrgivcJjtGN2DGGBZWBVQ1erxl3zqaEZXZjXTCvPB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZvheMwxy/0LfbWStMlvbJ0/DTuUjuob1i3G9s9Xmoo=;
 b=ed98jFTLb/oukH+V30DpnkK7mZoZAbRnCOFgpSIyz39sqpZa7GDRIZoJcb76ca965rNbxlQOZgSfFMUWm9fDPIQmD/nNSX3/Xpb90K8sMRgqf8a0jRLOIZmZ0hV0ohh/EwR7GVdkosJUv28zOGcRrhtzZfPSkA9UF5u0rpRSekw2uD1iNi+xCywXVhzY/do5ZZLNvlW3hjuHMCE2fco9GFaUrsJ2m3y5/Wg2tCN6frCwDyXcDjqnb0OIDe7r4f3+RAWYeO8tZNSYvujnwZ4r/9MjQCY9l2MDbpFfckr3qdNcxZMRGErCtSJmKRRNpJrgqdER6Hn6FJ3TCT/H0a7s8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CYYPR11MB8305.namprd11.prod.outlook.com (2603:10b6:930:c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 4 Jul
 2023 06:22:37 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 06:22:37 +0000
Message-ID: <69aada71-0b3f-e928-6413-742fe7926576@intel.com>
Date:   Tue, 4 Jul 2023 14:22:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>, Ryan Roberts <ryan.roberts@arm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <CAOUHufYB2kB0r9hhSbzfEzdF85MkXVfWoFOhy3LwLfJ5Qo8H6g@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufYB2kB0r9hhSbzfEzdF85MkXVfWoFOhy3LwLfJ5Qo8H6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CYYPR11MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af86952-419a-4382-9218-08db7c570ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYcaCI/xtj6J08k5elQ/6fAo2zFmDMq99tQevS/UknhTQl+1MsdxWRgBEvOTsV7K56zjemSPcp1Vc1un0Ni0wipbph6QYI/Dqa3lMJqkoLzg7jehUftChOyNaN4gMWCIm0KbXxjGCX7sHpJGSEZ0XCpEjQf7guaSJRb6KdHDKBvIFllW64iSCYosM6Uo6S+Q3kBu+IHOVyGEG3p+J78W+qzd9iO5KnbtFLxr3AumUfuUWjGNwgLMqtlX0VoprtXFocLPLpTH7ATX2jEOAyILGm+Z4GT+QCZPWU+trIs90NHvTBoeRC2O3a9tsJ9mvMvIKvqSzYitoqhCF+t+ikHa3dt68eYoTfRrNNW868HscjbEGS9gItLXjH+teGPCUbHhkLdWW/cvTkkmMijkAjQIWUUTeRa8MsyHMO2SnPEuEZnnP6lOLIFtUX/GKmKfGZh0fi4sOt+cIMs09mR7cIap1CbpCuVDM6E5QEy/dyHwx93f5SY06MhpFWPHUY93faO5cbVVl+q++gTilMJZceDedOkN/QhBydit9R15w5+35iRdHGjqkwwqLiWrRlJWLyQWtmwCHXQfgOxGcOjvr4IU6G7NPebVUIM2NU9amxslocEkSUaWo1BK/QX2caAdZo4sN7Tgqjak8lhCjkwzmEFhJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(7416002)(31686004)(5660300002)(66476007)(66556008)(36756003)(316002)(66946007)(478600001)(4326008)(8936002)(8676002)(2906002)(6512007)(110136005)(31696002)(54906003)(86362001)(41300700001)(6486002)(83380400001)(6506007)(26005)(2616005)(186003)(38100700002)(82960400001)(6666004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SndBOXZGMTRzNXBPSEIzRE15WHpJWkdOYmtrMVlsS0JQK3NWK2NIdklRQkV3?=
 =?utf-8?B?NXovbUlLZ0toZk8rUThIOEQ4dlh6bW9PWlM2OUo4Q3BKVWNZaVlKU1VzajY4?=
 =?utf-8?B?MnNkaXdlb2Urby8zNzdvOW5aTVVFZENzTDAxL0ZSQ3JPeWVxSml4WkpjSDJo?=
 =?utf-8?B?ZkRqamhsbWp6L2FOUmR4YjRDMXhkU1VKbUd1anpFekpaVjJobGFzWExDMmMv?=
 =?utf-8?B?Q2dsZGpPeWUvYy96b3pURFZqejlvZjVWZXYvelVPZTlWQ0hVclJzTXk4azRo?=
 =?utf-8?B?NTV5QWNNZDhUNFlPVzFhWEt0V2tqZitRRE5nVllyK1NhazZlR3NsMmJYd09Y?=
 =?utf-8?B?M01tRjVDekpJamJlOUdYMllNa085aDhuTDBVYUp1bFY3TlhqaTVEVFh0RGI3?=
 =?utf-8?B?RGt5MmZmNFN2Vm5XMGI5SWM1L08zQUFBcWdTUGhtZlFqUnJNaEgxNWJsOWxT?=
 =?utf-8?B?Z0x4ekxGQjlINWdIMHFxeDIrRFRvbEVVZzFueVFNd1ViRnVadVpWQ2laZE9z?=
 =?utf-8?B?OWlLbnZ0bHcvMXRsY09XNzFxeGM4cE1ITi9wMEdpNDZMOEY2N0s2Ymc3RmZB?=
 =?utf-8?B?NWhnUEZGVHN4VXNNenMxd2hiejRQTE5BTXVDUDM0S1k2TXlmY1J1Ym1mOHVi?=
 =?utf-8?B?L0RuYzFSQ2hqdVNWNytHYUpoVmpoWld0WVlsR1ZxQnVtaENKMmZudk4ycStQ?=
 =?utf-8?B?VWlpUU43T3BacldpbXgxRmg3SDU3VEZrYlc1ZE1WMGxJMUNYWVRnVUdBTTE2?=
 =?utf-8?B?eFkvRWdEbEhCZ29nVm90WjBpYnZTODJxVzBlWHNxNDdNeHoyb0tQTUpSYmVa?=
 =?utf-8?B?dFV1MC8wYWpkdGtiM2htTzNOTFZtQUIwVmtxVG01cVhSRDlCcGltY2JKQkxW?=
 =?utf-8?B?TzJIS3NkTm05b3YrR1hDa2ZBNUlrcU5aREFtUzg2Z0xaZU1FOXhEaWZqUnA3?=
 =?utf-8?B?L0Z1WTRDZTZ0ZHZaSjZDalppckN4TGJxa3lQOFJzbFlncU5oVE5GYVF5bjk2?=
 =?utf-8?B?WU4xSThxUjlnYis2Uk5na3daVkd3dzhXRVFzWW1RbnNPdk5KS2wwTlBLWGlO?=
 =?utf-8?B?a1luZEloVy9FZDZpS0pJbjZYWXN4VmRjQ25CQmtsVjU1dUxpL09KVFpiRlEy?=
 =?utf-8?B?NUZNNWp0NTF2WGJFVmpGWjA5dXJ2YjlCeHRQL09qbER4MFR6dmdLT3dYbGFh?=
 =?utf-8?B?Vm9XWDRZeDhwUjhJL0tUVWFEWVAwczlUSndRM1J3OXFnZHdod25WR3dHajBy?=
 =?utf-8?B?SDkra0QvbzBWVWZIanZXTjArK3FmdmhUNFowMWh6aG40akpBK05pYXFQcnFp?=
 =?utf-8?B?aGdPeWlkWndTY1JiSml0eHFRalFkNWlnMWcySmhETDFJdE1KQXg1R0xleGlK?=
 =?utf-8?B?THkvbkxUMTFNMVdBVXhvNjNETVF6cXU1c1ozUjF2K0lMSXY5S1dJbmJFT0h6?=
 =?utf-8?B?WDQ4L3JOVlloQWhORGFwRWNvemxDV2lZMm1YdG9IVTBaWVlITjJDWVpTSEpU?=
 =?utf-8?B?aTBSSFp4b2t1UGdDckhOOVV3TGRESzVDbXl0K3c2cm1ZWUVpbGlPYXV3d3lM?=
 =?utf-8?B?dC80RXdMOURTNEMxRWRqQTQ0Z0pJQXduWktPdmVLNjRuc1pjR1h0UFJtYmho?=
 =?utf-8?B?WlZGc0hQS0lsek5XdERNZFFHMXkvK2JLbyt6a3A4YnRLV0pPMldkRllPbDFJ?=
 =?utf-8?B?UmkxTEdMWFJ3V25hU2ZJQnlncTZrTVBhaVNJdzJKR1Q4VCtpa2s5R3QwcGdF?=
 =?utf-8?B?KzZCRE5OcjBKRXJpd3RuUk12RXI2WmpEdzY5bVBzR2lDT3hDVmxLYnRldWg3?=
 =?utf-8?B?QU5hSlViZ0VCejZRNGJMR0NoeWVodUF3S3c3WEZrUUM0ay9obUE0OEwwa3hn?=
 =?utf-8?B?ZmY0cVVEWFFRano2RmhxbFJFODBBcmxsNDBNOHMzUFdsd2tkb1JOYXgxbCs2?=
 =?utf-8?B?RDNXbUJ6Y1Zkb00vQ0N6YU9BUjdGdFNEQnpQbzdxcFdaRDB2TGdLT2k5dmE0?=
 =?utf-8?B?QURYMzJiWkpQR0FTYkZiUzlwc2ZBTlNuM1BheFhvcHlWR3ZXMWxGR2lHc01C?=
 =?utf-8?B?YXhhL2hzamw1RG5sdFgrYmtaVGFkMzdqOWpSUi9RaWovRHVNUFB1Y29RazN0?=
 =?utf-8?B?STIzeThodVRzUXg1ZWYrdy9OdG4zZURsYlhFQXRYM3ptcEZYd083LzZiWFMv?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af86952-419a-4382-9218-08db7c570ff9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 06:22:37.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szrTUSjaBz86C1uN/NqAa48NSQn2R/wDs54HA04raLPTEE3uRkPKmEC6/A3h3NlapxeqLaPRfjj9KczQBln5gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8305
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/2023 10:18 AM, Yu Zhao wrote:
> On Mon, Jul 3, 2023 at 7:53 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Hi All,
>>
>> This is v2 of a series to implement variable order, large folios for anonymous
>> memory. The objective of this is to improve performance by allocating larger
>> chunks of memory during anonymous page faults. See [1] for background.
> 
> Thanks for the quick response!
> 
>> I've significantly reworked and simplified the patch set based on comments from
>> Yu Zhao (thanks for all your feedback!). I've also renamed the feature to
>> VARIABLE_THP, on Yu's advice.
>>
>> The last patch is for arm64 to explicitly override the default
>> arch_wants_pte_order() and is intended as an example. If this series is accepted
>> I suggest taking the first 4 patches through the mm tree and the arm64 change
>> could be handled through the arm64 tree separately. Neither has any build
>> dependency on the other.
>>
>> The one area where I haven't followed Yu's advice is in the determination of the
>> size of folio to use. It was suggested that I have a single preferred large
>> order, and if it doesn't fit in the VMA (due to exceeding VMA bounds, or there
>> being existing overlapping populated PTEs, etc) then fallback immediately to
>> order-0. It turned out that this approach caused a performance regression in the
>> Speedometer benchmark.
> 
> I suppose it's regression against the v1, not the unpatched kernel.
From the performance data Ryan shared, it's against unpatched kernel:

Speedometer 2.0:

| kernel                         |   runs_per_min |
|:-------------------------------|---------------:|
| baseline-4k                    |           0.0% |
| anonfolio-lkml-v1              |           0.7% |
| anonfolio-lkml-v2-simple-order |          -0.9% |
| anonfolio-lkml-v2              |           0.5% |


What if we use 32K or 16K instead of 64K as default anonymous folio size? I suspect
this app may have 32K or 16K anon folio as sweet spot.


Regards
Yin, Fengwei

> 
>> With my v1 patch, there were significant quantities of
>> memory which could not be placed in the 64K bucket and were instead being
>> allocated for the 32K and 16K buckets. With the proposed simplification, that
>> memory ended up using the 4K bucket, so page faults increased by 2.75x compared
>> to the v1 patch (although due to the 64K bucket, this number is still a bit
>> lower than the baseline). So instead, I continue to calculate a folio order that
>> is somewhere between the preferred order and 0. (See below for more details).
> 
> I suppose the benchmark wasn't running under memory pressure, which is
> uncommon for client devices. It could be easier the other way around:
> using 32/16KB shows regression whereas order-0 shows better
> performance under memory pressure.
> 
> I'm not sure we should use v1 as the baseline. Unpatched kernel sounds
> more reasonable at this point. If 32/16KB is proven to be better in
> most scenarios including under memory pressure, we can reintroduce
> that policy. I highly doubt this is the case: we tried 16KB base page
> size on client devices, and overall, the regressions outweighs the
> benefits.
> 
>> The patches are based on top of v6.4 plus Matthew Wilcox's set_ptes() series
>> [2], which is a hard dependency. I have a branch at [3].
> 
> It's not clear to me why [2] is a hard dependency.
> 
> It seems to me we are getting close and I was hoping we could get into
> mm-unstable soon without depending on other series...
> 
