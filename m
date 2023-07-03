Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD53745F04
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjGCOsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjGCOsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:48:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54607B2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688395710; x=1719931710;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u9lIbv+p4Ojc9Nz0yNEKEYbhbXcx2GPlBRJ2WMZUK6Y=;
  b=D1bycVBNvIZk0C0Jje2I0FJcalgXbPHmsAlKGl07a1Wwyb8/NCKpRKO3
   rdg8SrcJcAQkImmI8/+KGoR692VmF3ybmUNjYCv7MSSUiF7Kcs4cy2Bwz
   yi9Dsl4nQrD8Ns5Mzu31FjHKTRcAR1vcLHA6YwRwLx5t1ujdacao1/S7W
   WjNP9ir2zRcRSpjf+EqF/MXOI5l9tK6FrBtYpFgwlFAQT/7t5PDmKnSkt
   TO1In0jaWexysgwASUH/PICZCqie0Og70GfT/rMqhYVSESGH7wLM8Xqno
   XlYp25tXwtjpC112DOB5Cl4OJXs7XMyrGarFTYNI4+dMZGZ2ETbUgwC/D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="352726072"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="352726072"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 07:48:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="721794713"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="721794713"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2023 07:48:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 07:48:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 07:48:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 07:48:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 07:48:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFVNXygpA53Ef50I/FLzkcX3RO9/5CNG0l++8x0zcdA0p7yzF0hIIR+l4mXUbcPsa8HayMleL9xytQSncYMWko0mA0JqtncGKbQJjozhoFP3QCHl2UhHr4sR9gDuDaSREZbKQQze1XzwPoNxWjGsch9NQ/n2XXqAkyaqD+eO1aUzyvqnUxpYhENXIk5U0ZvCxPy9wZmvf7YDryKLUXsyNPa5wyLjl5x4O75YdLIvo61Lvwe1ZuKmnkP+KUQaJZYxiJcbbnsimWCRUPf85KSKRhE+yDhx+5olnKbssTSj3irFGa49nyv75JJGCwhG1CdCWSf3K1AiZsiph4LLpSoCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqFmBnTy+5i+tk2zYxYhxBc2k1WfrXRNkyo/QxYrZ90=;
 b=ePwVnTL6TOdbOYO7IC81V1Rhw3QLF8bMR/r9lguIB0kaZvsghlGdnrn2P4Ezw35JzrB7JCIpmA2EbcgNmgj0Zy0BvnMRQcfwIvrYRpEEcLC5WVyn5GJ4X5tcjCWue2YTxD2dVFq+8nnIh+E9Maxmrk2QsSbTKGuiQkalxm3KeXAn7TukhR5/vSi0Kvf1nsd8KOS4bq1HM4gBwR+cQxK8iktUDzUslpl7zDq3eF2yf4rKbcL5QV1lCEl1BCoB6DFc4g2/P3SDcC5Fy7kKP5/Ux2W7wtmNmNmjN2784ral7UbrC8llCCwi9f69HKVTiN6538GGkxrCGbP0YanjgYjt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by IA0PR11MB8417.namprd11.prod.outlook.com (2603:10b6:208:48d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 14:48:18 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::1439:6bf2:b876:cec5]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::1439:6bf2:b876:cec5%3]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 14:48:18 +0000
Message-ID: <cf8b0163-56c9-0540-c635-b541132a77cd@intel.com>
Date:   Mon, 3 Jul 2023 22:48:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] iommu/vt-d: debugfs: Increment the reference count of
 page table page
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230625022808.42942-1-Jingqi.liu@intel.com>
 <BN9PR11MB527672460238BCBA63CD3CA58C29A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <BN9PR11MB527672460238BCBA63CD3CA58C29A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To DM4PR11MB5469.namprd11.prod.outlook.com
 (2603:10b6:5:399::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5469:EE_|IA0PR11MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 24565dbf-aa35-4b95-19ea-08db7bd489b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lvoZcAim80KY3A2Zu8I5iees+eG7/QUOXWdLHsa4Gi9BmlwDd3E72D5JZ8dQYBOd0sAwfFgBjKj4dAR8LrESn+NO1XuuCbQXPeXSV+f5rPUQR3cYnbbWra6dwmUYy1GqpRkCpxqc8dX99O27SNp6Pq7oA7M8BsVED12HCCNpDCKrK7R0Zanp6jIKN6gjYTil1teOin3TKOTDgmYrVKtv81V5txpw/45sehI0HnOcZMaYG42aNFvmh2u5vxka3LeNB9oT3UbkOK6NaOaLcL8d3no9ZSS2OByD3h4L1dWhxDI9Iza3xbMGuy9agpV9BJ4wZ7JsoNpjMjXbgRAgdURxor+7BE0ewWkYlRSbFNjwDWQepjFxkpdbJcpyZY7TmjbpcbKwsKT8yWuesELgP0NS3cTVLGpgXebezjuWk2J/wN+FK0dPLjp+0HDxIzDgUth5zsDyJewxPtd+k2U1xJwgugqX8vpp900cKJOyS+TFacaBo9DVa8scc2XvJrmNtNzNoJPOIziwssJ+w8DHZD7i/sAA6iZi8qY0+T79VQwZRpZWouMM9PDogdERQHCR5DCk1coegnaIEO/q4Vc0lCYCeBADKWPAY5cJAG6WcvlzkW1GGbG/Xg6Fmt9ngpOvcZY7uEekzvZWR8bw6ajr0aTf2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(6512007)(26005)(8936002)(53546011)(186003)(31696002)(86362001)(36756003)(8676002)(6666004)(2906002)(110136005)(31686004)(6486002)(5660300002)(41300700001)(478600001)(38100700002)(66556008)(6506007)(66476007)(66946007)(4326008)(82960400001)(2616005)(83380400001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWlTMWplNFltUDNXeGhlbmlkSWNjdlZqUS8wejhlTG9IWFExbjVPbkYyRXVD?=
 =?utf-8?B?K0R6cEFDMjVnVG11ZkJwcWxBTHRzQmtVQnlOcVNUZXhrckluTmRKWVRndDg3?=
 =?utf-8?B?MXZ1K2F4eUZqejdjZXkwM3IrZTJiMkZ1T29RSlhFS2Y5YjM2Z21Vd0VOZnVR?=
 =?utf-8?B?MFN1YndwSVVvYXR4NDF4OTBvR1B6NXRxU2lzcFArb1FueHBwY2ExRFAySUR3?=
 =?utf-8?B?TFVLaC90SHc3ZGRQbVZ3M2Fkai9PTWtwRTRkMkhaVEVYb1h5Sm5IZjRxL1F6?=
 =?utf-8?B?azZWNDVRQzRhdWgwMmVtclprYWNKZHJyZkVBVVB0M0NFWWlLaW9wWXlxSkh2?=
 =?utf-8?B?RnVJYitJazEvM0RUajR6NHFERGc4OEJkTEpVUS9jZlA0SlFXbng0VldROHJz?=
 =?utf-8?B?RjBOMlJnQjZuYjJtZFMya3UzUWFwV1FUNGpnQ1YxM0tJR2U3L2dMdWlYS0pX?=
 =?utf-8?B?ZWthWGp3ay9iNkVJNjM5SUJ3Q2Zrc1NOUVRhdDE3VUNHcVBhOFNNSC9tUm1P?=
 =?utf-8?B?Q2NyUlZMNnd4bXdBcUc5Z2pJaGU1MnVqMXd4V2lxNmtJNDVuN0lDWFdjZ2d3?=
 =?utf-8?B?cnFzeDBzOTBjQ05RU1hIUlJwSGhhSDFEUG0xRGhRUmhLeU5ST0szeVZjZUtK?=
 =?utf-8?B?SitNNVBqa1pvUG5tcmhubW9OalN4M1JtOUowcUJHeXg2VitiSHlPK2FsenV4?=
 =?utf-8?B?RHl3QmJiL25PVWltVlpmd1ovc256UG5HT2pBZ1lzYmJsa0tmSG8rUTBDNGJJ?=
 =?utf-8?B?b1p6WjU5cENpTllYTXZ2c2lJc0xaUURlSDFZVXkvS2l4WXJZOGNqVVd3a21P?=
 =?utf-8?B?OXdyZ25halh5RVNCVDZjdlFBNTdyNHFHZFRaOUVQL0JtdUd4djU1cHVEblAw?=
 =?utf-8?B?TW1hc0RocXJuVENOTXdWQzJZV0tzeEx0SWFEWGRyaUlQRU5XTlBibzR6S0NO?=
 =?utf-8?B?cUpoZDNySHUwMkYxRTU1NXdweWNlZE5uWEREdzZoU1daZ0Y2bk1uNnMwQUJo?=
 =?utf-8?B?elBSNVViSFJSMVh3eDJha0djSE5MWVZFOHhlQWhzQlFzc2RSU2lrMHFwSjNI?=
 =?utf-8?B?ZzY0Sk5DbHJtbGVjL0M0VW9haEpZQ0hjOFhUSlZza1FGU1RTWjhUUGtOM1FS?=
 =?utf-8?B?NElNTXN0WUZGckR6T3VRZk1tMzNGOE1HVXo4S0RJdXV2MHdmY0d2aFdhQkt0?=
 =?utf-8?B?NW1ldU5taTVYaXdVaTY2R3FjQ0xBQllEOWR2ai9jakg3eU81RmsvVjk4Sjdh?=
 =?utf-8?B?Nnp2WTMyVU53ZmNDWGE2TmRTNEtuRVhRNWxVbHhZZFpwNE1kampLaFFBWnR2?=
 =?utf-8?B?dDNlMGEvZ3F2dFVLb1Z4cUE5TnBjdXdFOXZXNWZ6YzlTcTVqenZMRTlSa0ND?=
 =?utf-8?B?ZStQbU1NdkRkRGxTNjZGTlVZeTJTTWZhbWZIMkM2WnVsWDVndURLM1J5NURm?=
 =?utf-8?B?SW1jL0JzaXFvdHRDYnQzSDg4KzAvUzFPanYwUENGek4ycGVyb0VrSHpCcVdU?=
 =?utf-8?B?aHZiM3k2NXQzUjcydTdRMzFTdDhGdXYyUUtCS1JTTWxPa0RQTzdTQUIxNUsw?=
 =?utf-8?B?bUhqU2hDNElkRGpGZ0N3SWtvUU0rSEdYem4wbS9vcHo2UjBMRGhqUXZMMno4?=
 =?utf-8?B?OG5IdlFqUUxFdHdyUjErNnlndGloMmMwVUdmQ2xSTlJQbVFUZ0VsSVF2L211?=
 =?utf-8?B?UHlQS0NUaUtUUmsybVJBK0ZjNFNyNUVOSGlLOHI5VHNrUnhwd1lIMnp6NWRD?=
 =?utf-8?B?ZERJS2oxbVhPcStBeDJva08yeUR6a3NlZkVvQVBLMlpodEtWSzYvRUk1ZElo?=
 =?utf-8?B?UGE3UzVMNzhEN3Z1Tk9YamRXbzUrbDNnM0xlaDZIVTlXUnd6ckczR3FaYmhx?=
 =?utf-8?B?U01Tb0VLUEtaZjFldHFvNkZtcVR0OGx3VW4vU3kyNmVKakNXME5JQjN1bnBV?=
 =?utf-8?B?anJMKzN6T1pVQjM1aWdteU1ocTZWbGpwRzQvUk8xWE1yMUYwQmRabGp3cjNH?=
 =?utf-8?B?Vms0ZW9LOVJER3JSVjlUUy9HdW0vUnQ3cXBUYWU4UklobTBzYmxuMWFxVDJw?=
 =?utf-8?B?ZUc2MVJSbnVPMC83NXJVQUsyaHViTmRIQXBhaTh2bm1QR21qR2VaM0hoKzly?=
 =?utf-8?Q?U+4Rz2aEEEH2jQGbfD5k4ED/B?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24565dbf-aa35-4b95-19ea-08db7bd489b2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 14:48:17.9661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ER/DdmGEjC3uE9nOTO+GSU1n0vqZqLSDqaZTpTcyvGq2LnTo58P5DZjIuR7Na0h/iC+zHaa5XN2Flj1YaCj5KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8417
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/3/2023 3:00 PM, Tian, Kevin wrote:
>> From: Liu, Jingqi <jingqi.liu@intel.com>
>> Sent: Sunday, June 25, 2023 10:28 AM
>>
>> There may be a race with iommu_unmap() interface when traversing a page
>> table.
>>
>> When debugfs traverses an IOMMU page table, iommu_unmap() may clear
>> entries and free the page table pages pointed to by the entries.
>> So debugfs may read invalid or freed pages.
>>
>> To avoid this, increment the refcount of a page table page before
>> traversing the page, and decrement its refcount after traversing it.
> I'm not sure how this race can be fully avoided w/o cooperation in the
> unmap path...
Thanks.
Indeed, in order to fully avoid this, need to cooperate in the unmap 
path. :)
>> Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
>> ---
>>   drivers/iommu/intel/debugfs.c | 36 +++++++++++++++++++++++++++++++++-
>> -
>>   1 file changed, 34 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
>> index 1f925285104e..d228e1580aec 100644
>> --- a/drivers/iommu/intel/debugfs.c
>> +++ b/drivers/iommu/intel/debugfs.c
>> @@ -333,9 +333,41 @@ static void pgtable_walk_level(struct seq_file *m,
>> struct dma_pte *pde,
>>   		path[level] = pde->val;
>>   		if (dma_pte_superpage(pde) || level == 1)
>>   			dump_page_info(m, start, path);
>> -		else
>> -			pgtable_walk_level(m,
>> phys_to_virt(dma_pte_addr(pde)),
>> +		else {
>> +			struct page *pg;
>> +			u64 pte_addr;
>> +
>> +			/*
>> +			 * The entry references a Page-Directory Table
>> +			 * or a Page Table.
>> +			 */
>> +retry:
>> +			pte_addr = dma_pte_addr(pde);
>> +			pg = pfn_to_page(pte_addr >> PAGE_SHIFT);
>> +			if (!get_page_unless_zero(pg))
>> +				/*
>> +				 * If this page has a refcount of zero,
>> +				 * it has been freed, or will be freed.
>> +				 */
>> +				continue;
>> +
>> +			/* Check if the value of the entry is changed. */
>> +			if (pde->val != path[level]) {
>> +				put_page(pg);
>> +
>> +				if (!dma_pte_present(pde))
>> +					/* The entry is invalid. Skip it. */
>> +					continue;
>> +
>> +				/* The entry has been updated. */
>> +				path[level] = pde->val;
>> +				goto retry;
>> +			}
>> +
>> +			pgtable_walk_level(m, phys_to_virt(pte_addr),
>>   					   level - 1, start, path);
> What about pde->val getting cleared after phys_to_virt(pte_addr) leading
> to all the levels below 'pg' being freed? In that case this code still walks
> the stale 'pg' content which however all point to invalid pages then.
There are 2 cases for the page pointed to by the PTE below 'pg'.
1) the page has been freed.
      It will be skipped after the following check:
                         if (!get_page_unless_zero(pg))
                                 /*
                                  * If this page has a refcount of zero,
                                  * it has been freed, or will be freed.
                                  */
                                 continue;
      Debugfs won't walk further.

2) The page has not been freed.
      The content of this page is stale.
      Dumping these stale content seems to be acceptable for debugfs.

      If all the PTEs below 'pg' can be cleared before being freed in 
the unmap path,
      the following check can avoid to walk these stale pages.
                 if (!dma_pte_present(pde))
                         continue;
> It's probably simpler to just check the format of each PTE (e.g. whether
> any reserved bit is set) and if abnormal then break the current level of
> walk.
Good point.
It seems the bit used to check must be differentiated between valid and 
stale.
But the PTE may not change whether it is valid or stale.

Thanks,
Jingqi
>> +			put_page(pg);
>> +		}
>>   		path[level] = 0;
>>   	}
>>   }
>> --
>> 2.21.3

