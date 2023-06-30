Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CF0743BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjF3Map (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF3Mai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:30:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED303213D;
        Fri, 30 Jun 2023 05:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688128235; x=1719664235;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lWVDxsv0kPuEozenuRxhzUWGxhhIPxob3+t0/Br+fjA=;
  b=kCTXRGsNN0HYGMLCpsOuhoJooPm9aO0ttKtyFpbKW7WjiCa0ZBCGvjTd
   +o2gdxMsvNcs1dQ5OjZn0Y6CEJUlZIxFSl2054rwnZEJwOy4gA1oeAdDb
   ZmbQPCzxs9QeRYFGLKl9BVdG3nt4Z2PS2Avkw+IZXWKCoxuGtdO6ZN4NM
   TTzMM+TjvS8jYr3fgHv200peNK+RO6hx4O28wB5d/9FP9/lQhUfTBMAUH
   cbP7oEYagCYhUKAZXDJMhSie3EB7etxof/71X4sui4Kz37mkGWF/JM14P
   00SdM5OSzClT7XCiCReBIPosxkBE8UgHW8TG8T4bFkGUB5fONv2+2AcC5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="365865481"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="365865481"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 05:30:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="720942209"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="720942209"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2023 05:30:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 05:30:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 05:30:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 05:30:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 05:30:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfMoVn+Ac1R2ha/koKpzDQ9UjCr8WB+1DpK1PQ6/wxuIcJvcZbiPkz9XD2cUYU6WFb6vAahj/vR4kNdVqEVnezRdE1SePtLECFHG3ytggjd2ij5TBgLKy0J9U3pXJSNbh7KOqIDSPNPCCl41OrVmzD2Iwxg7oo+V2nM/qHEvNU9BTtc606sONM/YyOeSvaKMi+ArcQsQCCr638YUVRs0z1tu0xqxd1EpnojL58aqYxpkFrduHDBmthKxm9UR9nD+2/jTX0WPAC0/TiOCfeU0Uw2gyw1Zt72QDscxq/oz1fANS/XYVKa8Or0sre8G87RcgMxw5w7WJQaK3vkRD+0VuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leaGDUgVlFHXUPbYrEx8isAEGAEjxyLMfiSz8Rjsgl4=;
 b=RH+RGcdzDMhidoG7cCRbj4WwiLGf+376m8HrEwS/VaJB7XtUkT9uEfG7pEwNAYdcdcLn5MEcxeA7NWBfAcvqmAimxwFO0S4YF8SdI8RLP3jRnl9km3/j2Ijy32OtmkisnUV9NK6yidyXniggV431u0d72VpGJRIwY3yClvJBO/SBYlJsJwX6eHQNV9NUPNvdvvxvGva8qsuZ5xGxNxCy5aLqAwIACnKgpJxfvS0jCsHqleENnSqit4VXVeGTRHQwQzQFwPNHW7z5tpbgQCDCXQ/UC4b7/HZ6fVST23qFbwLkaOgqgvhVSYhbutp6qjVX+3cjwyHTzez1jLZUnNYrmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ0PR11MB5616.namprd11.prod.outlook.com (2603:10b6:a03:3aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 12:30:30 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 12:30:29 +0000
Message-ID: <ac4a8761-410e-e8cc-d6b2-d56b820a7888@intel.com>
Date:   Fri, 30 Jun 2023 14:29:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next 2/4] net: page_pool: avoid calling no-op
 externals when possible
Content-Language: en-US
To:     Alexander H Duyck <alexander.duyck@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230629152305.905962-1-aleksander.lobakin@intel.com>
 <20230629152305.905962-3-aleksander.lobakin@intel.com>
 <69e827e239dab9fd7986ee43cef599d024c8535f.camel@gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <69e827e239dab9fd7986ee43cef599d024c8535f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0340.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::23) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ0PR11MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c55ecd-487c-4df5-ae2f-08db7965c9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aKeV34x6+Z5aimadthFCYibQ/Y0UbBk+MWkf5X7Vcr1fT7Rdr7wFCWBn8167lMaROQ+AneNsLM/UgRMFVZZrZRuEdwpLCHbNvf7a9lrGVRg00EQLQz1RcEaAMO08wwjxco7Yr1k1MdoTfOtglrN6+V1cpMTm5hLagYcDEwGwiFQJwAld3oMZM/bQwirU+qpinkB6t/Ed1QxqijG6pfK2qklkJL3YGq5KWu6KJb7TS2eQ6nU3HzGGB8cRDNHjOtMoMot07gayusCgNwm0PoHnUhjXTVj9/nbrEVtjrrV2Q34wLWkgguO05sxVkRrIGAyocU7Dt11KdRQQmBKJ2oBZhyiGk2o2/3DWDaYIs+plcKOA4r6t+tRfyuPwGyUPV6fOaOLd9KGZK7c7vGoCvyARhQ+VIM3dCYARNBDSGnwItjhzBMMvY0R9RpUg+uyT+E3r6fDFPha01L3PndHg4LaNlPXrq0ejVaa9lk6pKkiranEkzcJeMKpH0lP1QGXzjXRgGvWQ6eojDXvZX5BlxytQjhWVoapo4HIGgergOla8AsV6+jvaDfSTW2jppg1UFkqamVsBBDbMHgAygqdbgRiNO0+YGcXjvVWCDEHmYGZJuPR796BvtpcEnQH/Qm0C+IZUD0n46QjnJxhyDBRt4Bf87Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(31686004)(86362001)(54906003)(8936002)(8676002)(5660300002)(31696002)(7416002)(26005)(6506007)(6486002)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(6512007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(36756003)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzVuWUlDZkRxeVpZa3ZlNHV4UTVhZG5DNHBBUWQveE1ab293WHdmUHdkMzBB?=
 =?utf-8?B?L2VXOW1rM2RSYURLSVRvKzdzMTQwaVRGblBGL0JwdVY2TVN0cTlybE01N1JK?=
 =?utf-8?B?Z0hwakorcnNabnQ3bFdHNnl3WGVKa3oxWWRjdktyckdwWnV3cW1QVWczUXJ3?=
 =?utf-8?B?NnRpdHAvRmxyM284ZlVlQnlQUTF3bHZhUTdZdUs3Z09lWm9xSkVhYk4wcDFv?=
 =?utf-8?B?L1JTOHBLaEZtSy9Ed1ZlVnl2S2s0M2gxYm9MQStWbzloYkhGQnh5bVlBemR6?=
 =?utf-8?B?cFFMa3NxSkdaRVdBbGZSampxUit3SlZTcGRNYjdKcGdpa2xJakg5MVd4cHZG?=
 =?utf-8?B?clRZam5IMFRVT2tRM1dpdVhFZVlSd1pVV2hpYVFZNG9IdXp5MFFQbU0zdU9M?=
 =?utf-8?B?VUROa2JzWk04ZkpQMTkzcDVrczVZNFA0Nml4anVCOWxncGFkdkluTkhpWkRS?=
 =?utf-8?B?bUU1dmNlU2I0aGNlQ295U3VTMHR5Vm8reHRLOVpTa0xXSzFJbkRVOTBwcHBy?=
 =?utf-8?B?eTJMVTExM0F4S25mMVJ4NVp3WmxKNGNCdG4rcmdGY3lPelRlejZqZ1ZGM0lM?=
 =?utf-8?B?WWZ0RkFXejhrOERSVGlFNmVydW00U0RJK1JwU3ZtM0ZWd3d4RnJrWFAzL2xW?=
 =?utf-8?B?WW9QOC8rKytoTzlHdHZsbGlqZ1JaSzNmL0hwTWduUEVBY1MxY3BUZk1BWUph?=
 =?utf-8?B?SncxVmhERk1EeGJyUmo4eDVWTEhXbEQxdEtVNGJaUHlhR0c1ZVBhM0M0aUZO?=
 =?utf-8?B?K1hpWWo0WjFkSzdoZUF3UDdTaEJTZVVNQUhINThxNkFjeW91TDQvalhWYlJ6?=
 =?utf-8?B?VDlhYzJRWkd2QUpJdUMxUG9saTNJUElLamVmMkI4OHUwVERDNjZqT1d3d2lC?=
 =?utf-8?B?Q3hBU2o3RFZYN2VLdUoyR3VmMWxnd0prdmJKVmY4bXpKZGova2VTS0I0cnQr?=
 =?utf-8?B?dlZrV2JocWtQcWY5SThGTHVmZGFFOUtUTS9QTEd6SzZLQXJ5OFZsbGhMUjQ2?=
 =?utf-8?B?RXpjK1BlQ1B2dTVPMll3QVM2Y2dHUE1BN1dNT1ZCS1VmcDFJaGVJTG9LRkFo?=
 =?utf-8?B?bW1QRXJlbExjYU8rM3p6R04rQUJjRWJUWklnaExQMTUydmlMUTZJRk1tR0FE?=
 =?utf-8?B?RUdSMDhNNDdpNXhMZXZ1R21OT05ZTzZjM1ZWMGV4ajZybVh0Ujd0UzhTWjZx?=
 =?utf-8?B?T0FQcEhXN2pudThaZ3NiaUxCU2hPbW05b0IyWEhhQlFxc1JYRFFJL3NHZkZu?=
 =?utf-8?B?MTI4MnhkcFBoUG12VFVQS2JUc3d4azh5d1QzRktrcUFrTzBmN3V3clQveG9z?=
 =?utf-8?B?cUtEYmpnK0JDRUZyc010bXJ2RS94ekdCNStESzRqZGI5S1U0dno2SHJuUGxT?=
 =?utf-8?B?OGhZeUlUTG8vR20yTTd3RzY4Ujl5ZTFaMnU0dGF4c3czS3VSOXVuREFLOTAz?=
 =?utf-8?B?NURCaU4wWlNlRUFYaXFqaDFDK1c0UlBaUEtNLzg4SW8xSzBCL1hSdEJpLzlP?=
 =?utf-8?B?a21VODhrTXRjaE91M1lZdXZZSm9JNEFWR0I4WFY1ajExbnRRU2FZMzdEUUxh?=
 =?utf-8?B?a0RFMURtdUZJZTNxcHozREtGOE1wS3N2R1VoTjEzc2tZMno4eDV3Zmttb1kr?=
 =?utf-8?B?R3NudnY0b2pXSk5icnk0WElhOWNDNHVDaUZIVXBmaysrYUh1VVdNUDZTdnNB?=
 =?utf-8?B?eWg3MG9Qc3UwbjRGb0t5aXA4cDZjVVV3TWdMc3JrdmdRYWFlTWpESXZuRDZV?=
 =?utf-8?B?c0RRS1BnTjhWQU9Mb084WnYzVlFRQ1BUNk5vbHE0Vk93MkNQODNzbFowQ1lZ?=
 =?utf-8?B?WG8xOGFzN2ZsTm5IMGVwbGRaU0RDNFlTNEJxS0NFQmE5ZGpyVENTVC82MjJG?=
 =?utf-8?B?ZUFJUUhsbE1tYXhVRkJ0SklwZFBEUllWUWdWb0tIUDY1d091QS9ka1ZqVVFE?=
 =?utf-8?B?K04yL3JycmI5Q2ozbFJ3RkRnVzlRRmtEcXN3L0JNODMwbDcwTlpTTXRsL0dv?=
 =?utf-8?B?anJ3Vml6RWpEUmZkRnVnR21KOFBsc3JISzBDeG9WTWNXTGRVVFNnOHVMUUJU?=
 =?utf-8?B?UFdkbDVXTWtpSm54Z2dhZmQ2bnpiZVU4ellBKzdzS2lIODJsb0QzNWJoOTR4?=
 =?utf-8?B?RFpvT0tFQjcrR0JZWHIwbDkwMnlja0FMWjdSUGk3Wkt6WlZiLzRjM2hTU1NH?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c55ecd-487c-4df5-ae2f-08db7965c9f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 12:30:29.2439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcj7qQqCRnXK0Wya+bNa5I/suR7ILANUIbdMpsBKVbB9Lrhhpf/HcPsFEZZK7i3XIOfI/0XfQKA6ucJRHYpSJewpimEEIJjeEySDt7dqcBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5616
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

From: Alexander H Duyck <alexander.duyck@gmail.com>
Date: Thu, 29 Jun 2023 09:45:26 -0700

> On Thu, 2023-06-29 at 17:23 +0200, Alexander Lobakin wrote:
>> Turned out page_pool_put{,_full}_page() can burn quite a bunch of cycles
>> even when on DMA-coherent platforms (like x86) with no active IOMMU or
>> swiotlb, just for the call ladder.
>> Indeed, it's

[...]

>> @@ -341,6 +345,12 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
>>  
>>  	page_pool_set_dma_addr(page, dma);
>>  
>> +	if ((pool->p.flags & PP_FLAG_DMA_MAYBE_SYNC) &&
>> +	    dma_need_sync(pool->p.dev, dma)) {
>> +		pool->p.flags |= PP_FLAG_DMA_SYNC_DEV;
>> +		pool->p.flags &= ~PP_FLAG_DMA_MAYBE_SYNC;
>> +	}
>> +
>>  	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
>>  		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
>>  
> 
> I am pretty sure the logic is flawed here. The problem is
> dma_needs_sync depends on the DMA address being used. In the worst case
> scenario we could have a device that has something like a 32b DMA
> address space on a system with over 4GB of memory. In such a case the
> higher addresses would need to be synced because they will go off to a
> swiotlb bounce buffer while the lower addresses wouldn't.
> 
> If you were to store a flag like this it would have to be generated per
> page.

I know when DMA might need syncing :D That's the point of this shortcut:
if at least one page needs syncing, I disable it for the whole pool.
It's a "better safe than sorry".
Using a per-page flag involves more changes and might hurt some
scenarios/setups. For example, non-coherent systems, where you always
need to do syncs. The idea was to give some improvement when possible,
otherwise just fallback to what we have today.

Thanks,
Olek
