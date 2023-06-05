Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ECF721D2A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 06:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjFEEl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 00:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFEElW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:41:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE165BD
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 21:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685940081; x=1717476081;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u7QqBp/3D4z/oAC1PlrRlGboFQ91SLvZusZT3gIityM=;
  b=TNVj83bMdOch1DkuWFDP6YPl0UoIr626Nwg+9ePo/0wntMF61EWZE63/
   0ldAbFB6MhKD9Ccrx6e80Of1UXlOj9YLWfVuVC7DrX8qyV9/4szdgLjnW
   qY/xVufqA2UppKIUCR+ix6ybJkOG1XgG6cFYq3evKB3M6Ku6tTNERCfp7
   D56CCMcfr3QTAypNUhJUpyGasgLjqPSLSQJ9XBZBt6TPrtuN5iVf0KcUz
   L5s3wFnV5NfBvh7U1AFu7SPnKh6W3FNIgVkc795FMbiVMxteelOvvNYNe
   nB8rtxPxipXSZl45SII7kHV2NGRT2y2lyZMFYdvuPH3lHlgQtRJvxoibE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="335898459"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="335898459"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 21:41:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="1038636028"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="1038636028"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2023 21:41:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 21:41:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 21:41:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 4 Jun 2023 21:41:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 4 Jun 2023 21:41:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QX4bqV7hadmBBpMRH0W4py1mZKdQJ0QRSRd/ATyAgzH/Dz4JiSp4piyvrO7WcKIoG5zwsIPY2iv1G9RbA/crgSIy7eR1GT8padp0UTSt8kagZz0ZjB9Xp4lNuVwQPSfmpczRcnavFzWZ4Wy76KDOXM/WbxQY4CYQK2fHI4UT4TAO6BVEy3eLy/VBMyA0HoP5LBJzKwmJhAdiCftJuWzkUKmQBKbCCiy0EfJkhqlgVQaTlkpAb8wzPw8WUv0fDVwhpo40ERAtUzPCl7NDY4OYU/r4V2w9xhJM32LdBP0TWeLW9ISyndDNs6JfTZ3frfYn0sSxFdcs1i1YeZEsT/uCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPbVxa4cmAjbFB/uUmYuhe7sVCJZTWdgYZbQ0gd7LJs=;
 b=NajAWZ+qH2ouInZell/SLZ+S6Vz9h+P+i7enh0r2HNyZGHfHNWTxdNwJjXtOEitGy5YCj4YRfBVpIaDG4thbdXmuJAiOg0QjS9okNG0mtCATMbvFoYm0vI+BGSNrEINATjQbWCFMRHsGtD/h3y4anaynwHB8LGdC3gr5CMshpI4fTSL5T8dw1Y5CXM60mR8DgxE2ZM+T4txMxduOD5j93itZ/vmc973tEsXcf+O4f1SCsEbrirqCPtfUJEV8CcVG3zSQObn/HR0YAZO1JqWzz03bgmY5qMBxF7ARE8mAVfLNyeC2XUfq/RuRR1t4oU7+4STzSu/8yhjALDBJ4UdOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM4PR11MB6501.namprd11.prod.outlook.com (2603:10b6:8:88::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Mon, 5 Jun 2023 04:41:17 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 04:41:17 +0000
Message-ID: <a9d2ab1b-23a5-8c06-9f7a-6872c726db03@intel.com>
Date:   Mon, 5 Jun 2023 12:41:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 00/14] Reduce preallocations for maple tree
Content-Language: en-US
To:     Peng Zhang <zhangpeng.00@bytedance.com>
CC:     <maple-tree@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, "Liu, Yujie" <yujie.liu@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
 <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com>
 <fad3c833-1ab3-2d34-aa85-dcc7c40c3587@bytedance.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <fad3c833-1ab3-2d34-aa85-dcc7c40c3587@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DM4PR11MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e4172ac-8b91-40ca-1e03-08db657f1967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFwDFZKz9vrwUh/RChVngeKb6+7Op1GFVCjfno+/Wxk5gtO+1S+/I8exeU3fjyaxG45WClkNRGpblC3HYjIqDl6AM85iZUggIh81Tzs2A0I41QhpcXeK1uYG7WxkFmfJrXh+ljRSyL2Fok/geKRlRldMOaUop2PGSXUH5DApxXxndZT+90Oreo6oiAeBlymRLrh1divKN45/PSJqhsWyb8c9JWWV0JyTJS/nj8ZqxD/MntjAsgUKQUobq57jNlSAbvTXN3+HlemwO9kMoI4lHURlGXTJuNuiBPf0we0LB/+p/HAz0eh64m6mJhf+v7Cz7Yl/dsAN1/6bfOY6Kz7jeXL+AHfp6IScATf+tj6zwWPwlD8jWP7Tevf+mfKxBPBaFVInrPK4itKAjmaRNE4HYbPDcu0GPJE8INT1GcUDCoyr+AApmjop1ZBPFI/h4zwsTi5U7gs7t4jk6DhL1fBliTG6+sHVes+4bq6/X9Ar54mqrcMRoL4k4d5rZ2sdvGCnkQgiO1pI6/OhJzyPlc2W9V88Y/FCZydobJESGs3GkME8bs8PHAv8in5nU4Hp933Wsq9B9T5bMhomQ38RdoUILKzSBMENZQvkLqTYfgBNGMpInHERIBjPImcX0cbla9b+9TjWVn6D/9NyARo1NSmehw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(8936002)(8676002)(478600001)(54906003)(966005)(41300700001)(5660300002)(6666004)(316002)(6486002)(26005)(186003)(31686004)(4326008)(66556008)(66946007)(66476007)(6916009)(6512007)(53546011)(6506007)(2616005)(83380400001)(2906002)(38100700002)(82960400001)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkdCYUNYZ0QrbnlORWFnVDhZVkNZKzR5SC9aN1VjVUoremxQS0g3VStIVlRq?=
 =?utf-8?B?ZUdXWHZpalVOM0pNcWtBUVpwMEVjVkYwck5pMzYvdWZvYzV1UVhZby9CbXFE?=
 =?utf-8?B?TTNuNElKWkVJcmpnWXZYYXdSQllxbC9PSkNGaExUeU4yVzYrQkZObjBoSVZI?=
 =?utf-8?B?ekV1UXp1UEZJdUVNamJOTXEreXh0eFYrWi9XaWNkN1k2Mjh4L2k3YlNwenlD?=
 =?utf-8?B?QnA5d3MwbllXVzV6b0tlRVNaay8wWkdjM2diV3BlcER3a1Rzbkt5WmxnMVhH?=
 =?utf-8?B?MXgyMzV4MFpDYjBXdVJ1S1Q0QlVrNFNaWXVNMUxpSi9OSkdwQWxqVmIvdVlN?=
 =?utf-8?B?SWlXcFczMCttTkJDcmlSUFpwWFhoVysyVGpNaVFrcHNwc1lGRU12NXl1aVB5?=
 =?utf-8?B?VXdOOGdkQ2hiYnN6UW5lMHdabWYyanhLOHFCSVZ6T05LS0V3VmdBVUFKSTBx?=
 =?utf-8?B?ZnZSL0xZYldOcWdyc1dlZThxWWE3OTFwM3lUMzg3ZmVpNC8rQXBWbFZWOS8y?=
 =?utf-8?B?djZ3c1F5Ylo2R3J2Q3AzR254RitZa2ZmL0JjclcybTMrcGh6d0N3dXp5ZDgw?=
 =?utf-8?B?WmRTYmpuZTFrRGRxZlY4RHZEODFyVHQzV0RMNmhidi9IYm5RMEM0QWdQRitt?=
 =?utf-8?B?eW5ZMG9pR20xeEJ4b0VsVFYwOTdQL0tXZDVlZGo1cEc2T2ZKaXRpZW55SThS?=
 =?utf-8?B?OXpnS1pFVmpIYVRVZzYyWmc3b01jdTIzeEFEaC9pcHFCbStCZW9zQ2FtZEdQ?=
 =?utf-8?B?Sm5EZUVsTllPamxzelhQRjVFZWxPOUg1bHpVR24xaS9rWkxSWjdiMWFsNVJS?=
 =?utf-8?B?elJ6cTU2YmtZeEdYSzB4TDl6UDZ2ajFCR3VoTFFibkN3VTMzU0puRk1KVHpk?=
 =?utf-8?B?OWh3UGF5MGIvbmRaVHlrcGNFK0w2dmluRUVTUnFNVDZ0VWVSaXlsa3VRa1J5?=
 =?utf-8?B?TmVabXJzTTZUNU5ZVC9rbmdWbmQwVWVEbUdMendOQnB2SUdwMjc3MEtaL3lM?=
 =?utf-8?B?ZERaRCtJSHFSSWIrMXFJNklOYXFiMFNKeVlQSDBiNXRPTVJqTGd3bWdMRVpq?=
 =?utf-8?B?U3U0YjdJTUpxZmhhZDI1alVieFJwTjZ5Nk5hcllXUW5zeWFyV2d5djh6ZkQ0?=
 =?utf-8?B?SEErYlVTN1d3WXZhMGRieFJTUjJpTHVQZFJoaHpGU1ptVXE1VUdoSFJoTGx5?=
 =?utf-8?B?VElPeml3UGlOWlRJY1BSdVYwM2ZQK2c0cDdRQUZkcGplV09xa3pOZ3VSZGxJ?=
 =?utf-8?B?aGh4Qm5ScGZYWmJjNlA3a3Z0RWhnVEdlQU5DRlREaFFkU0NJa0IzYi8zYXor?=
 =?utf-8?B?NFZpNHgwc2dTcGd2YTdGNEpnYzRuVFpza1N0WVdWRHNZYXNFUmM4NmtNeHpL?=
 =?utf-8?B?bzZDWXJWdy93dlVZUGJXK2lSS0hjaGFGV0Z1eFExaE9vNXFiN1hHR0pFTG1D?=
 =?utf-8?B?bk5yNjdnTXg0TEtxQjFITDZEZXRoc0VsV1ZtU3FlckpZOXN6a3ZabG1DUlE3?=
 =?utf-8?B?ZGpRcHBRRjVFVm42MGd4RDlSejVLK1pzOFRxVDFsMXFEa0poUFBQOFhKa2xU?=
 =?utf-8?B?bzA2VEJCWThpc0NsYlU1MGpzWjcxYlRtRk5kSDRoTWNGK3MyUE9VbXA0cDNV?=
 =?utf-8?B?UThoV2NFbkJseHQ1a1JkY3ZQZ0g3cGFQQ2dPN3BGSnNpaENQUXNHUXVma2dx?=
 =?utf-8?B?eUQvd2l3U0RxNTBCczY3SHB3Y09NRXE4dFd6a2NTUVJoOTh1T3QwTEtiU2xK?=
 =?utf-8?B?c28xcXA4RldQbW93bmtpU1o5d1RTaGtvSFlDT1BHcSsySmhtTkhmY1BSYU1V?=
 =?utf-8?B?YnpaNkh4S1QrK0RRa25GeW5kQkN5SXc0Ullmc1lxc0gybm14bTFSQ2JJbGJa?=
 =?utf-8?B?cHcxVHFEMXp5TDlyMnNiTnBRYXY3bE54SDdJaGZzZEpJSkhqUkI5d3BxaVh1?=
 =?utf-8?B?VlJJbXNmRFZXcjNGcnB0T2ptSitHNnNkSFdiODFnSmRWdFNtV3V0T1h4UWl3?=
 =?utf-8?B?M1JrVWFTbXRtL2hZRmcrM1FaUWo3TXY2dnYzVjlxSjRqZDBxNjZoZUNwUFdz?=
 =?utf-8?B?eHl3TTBTQTNFQUpmQTljMzZwVTNVZHpIcEM3RzlVQ2lsNWJiMWVvQ2xGMFNF?=
 =?utf-8?Q?aq179+AAXyFrW9mHXZYcvcVKd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4172ac-8b91-40ca-1e03-08db657f1967
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 04:41:16.6117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aM34Bsu7Pf5KNu+dAcowx4syy6ncv946DTtYK+e48sLlSX37D23+AUo0fdnv4YBiz7DyMqkA+EQiaO5KgFf92A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6501
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 6/5/23 11:28, Peng Zhang wrote:
> 
> 
> 在 2023/6/2 16:10, Yin, Fengwei 写道:
>> Hi Liam,
>>
>> On 6/1/2023 10:15 AM, Liam R. Howlett wrote:
>>> Initial work on preallocations showed no regression in performance
>>> during testing, but recently some users (both on [1] and off [android]
>>> list) have reported that preallocating the worst-case number of nodes
>>> has caused some slow down.  This patch set addresses the number of
>>> allocations in a few ways.
>>>
>>> During munmap() most munmap() operations will remove a single VMA, so
>>> leverage the fact that the maple tree can place a single pointer at
>>> range 0 - 0 without allocating.  This is done by changing the index in
>>> the 'sidetree'.
>>>
>>> Re-introduce the entry argument to mas_preallocate() so that a more
>>> intelligent guess of the node count can be made.
>>>
>>> Patches are in the following order:
>>> 0001-0002: Testing framework for benchmarking some operations
>>> 0003-0004: Reduction of maple node allocation in sidetree
>>> 0005:      Small cleanup of do_vmi_align_munmap()
>>> 0006-0013: mas_preallocate() calculation change
>>> 0014:      Change the vma iterator order
>> I did run The AIM:page_test on an IceLake 48C/96T + 192G RAM platform with
>> this patchset.
>>
>> The result has a little bit improvement:
>> Base (next-20230602):
>>    503880
>> Base with this patchset:
>>    519501
>>
>> But they are far from the none-regression result (commit 7be1c1a3c7b1):
>>    718080
>>
>>
>> Some other information I collected:
>> With Base, the mas_alloc_nodes are always hit with request: 7.
>> With this patchset, the request are 1 or 5.
>>
>> I suppose this is the reason for improvement from 503880 to 519501.
>>
>> With commit 7be1c1a3c7b1, mas_store_gfp() in do_brk_flags never triggered
>> mas_alloc_nodes() call. Thanks.
> Hi Fengwei,
> 
> I think it may be related to the inaccurate number of nodes allocated
> in the pre-allocation. I slightly modified the pre-allocation in this
> patchset, but I don't know if it works. It would be great if you could
> help test it, and help pinpoint the cause. Below is the diff, which can
> be applied based on this pachset.
I tried the patch, it could eliminate the call of mas_alloc_nodes() during
the test. But the result of benchmark got a little bit improvement:
  529040

But it's still much less than none-regression result. I will also double
confirm the none-regression result.


Regards
Yin, Fengwei

> 
> Thanks,
> Peng
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 5ea211c3f186..e67bf2744384 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5575,9 +5575,11 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>          goto ask_now;
>      }
> 
> -    /* New root needs a singe node */
> -    if (unlikely(mte_is_root(mas->node)))
> -        goto ask_now;
> +    if ((node_size == wr_mas.node_end + 1 &&
> +         mas->offset == wr_mas.node_end) ||
> +        (node_size == wr_mas.node_end &&
> +         wr_mas.offset_end - mas->offset == 1))
> +        return 0;
> 
>      /* Potential spanning rebalance collapsing a node, use worst-case */
>      if (node_size  - 1 <= mt_min_slots[wr_mas.type])
> @@ -5590,7 +5592,6 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>      if (likely(!mas_is_err(mas)))
>          return 0;
> 
> -    mas_set_alloc_req(mas, 0);
>      ret = xa_err(mas->node);
>      mas_reset(mas);
>      mas_destroy(mas);
> 
> 
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>> [1] https://lore.kernel.org/linux-mm/202305061457.ac15990c-yujie.liu@intel.com/
>>>
>>> Liam R. Howlett (14):
>>>    maple_tree: Add benchmarking for mas_for_each
>>>    maple_tree: Add benchmarking for mas_prev()
>>>    mm: Move unmap_vmas() declaration to internal header
>>>    mm: Change do_vmi_align_munmap() side tree index
>>>    mm: Remove prev check from do_vmi_align_munmap()
>>>    maple_tree: Introduce __mas_set_range()
>>>    mm: Remove re-walk from mmap_region()
>>>    maple_tree: Re-introduce entry to mas_preallocate() arguments
>>>    mm: Use vma_iter_clear_gfp() in nommu
>>>    mm: Set up vma iterator for vma_iter_prealloc() calls
>>>    maple_tree: Move mas_wr_end_piv() below mas_wr_extend_null()
>>>    maple_tree: Update mas_preallocate() testing
>>>    maple_tree: Refine mas_preallocate() node calculations
>>>    mm/mmap: Change vma iteration order in do_vmi_align_munmap()
>>>
>>>   fs/exec.c                        |   1 +
>>>   include/linux/maple_tree.h       |  23 ++++-
>>>   include/linux/mm.h               |   4 -
>>>   lib/maple_tree.c                 |  78 ++++++++++----
>>>   lib/test_maple_tree.c            |  74 +++++++++++++
>>>   mm/internal.h                    |  40 ++++++--
>>>   mm/memory.c                      |  16 ++-
>>>   mm/mmap.c                        | 171 ++++++++++++++++---------------
>>>   mm/nommu.c                       |  45 ++++----
>>>   tools/testing/radix-tree/maple.c |  59 ++++++-----
>>>   10 files changed, 331 insertions(+), 180 deletions(-)
>>>
