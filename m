Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CA074D337
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjGJKUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjGJKT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:19:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACE11BF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688984396; x=1720520396;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=opBhJeLFUFjFV01B1/DdWIIof/9GUzqDaqkKJ0VAofA=;
  b=HlEtxYaMI9Ae9tramSAipmnyCgj8wFDi5efJ9fcIfHNjSRUoFxXniMd/
   pqDjEeiAD7WLb2DAVDb4T5WRZLBkHhhleNIorcQWDAYUKURqxZ3IU2+qC
   6a9/LPupNj/rwBm4ykkG/AXuMBOC+Wxktlf5Jbyu8GNVHGdNbbqPSGNWu
   QIJLLkOjsxx61i4F3qSCrm8Cjld8J2eJsiaOgtadqVsl9bALsEDefMbsh
   bsMSl7/TBQ0sqCSRtLhbgP/snnFTdZgmMnYmB0G7c2lW74MaGSbuOA4rP
   5u+7mHXt/HZoA9zCyvctyd7ENYrK+WuucgZHCe3x686/jpZk4JdPGLiZt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="343899046"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="343899046"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 03:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="723957558"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="723957558"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jul 2023 03:19:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 03:19:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 03:19:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 03:19:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 03:19:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJ/HskXncj1vIoz9FIhQ00jo9b70WnHLMzps0WGdvwmbjxqmtyJxKhCyRtgKzWkgPufsEpO7ecsBDweL0fe+xlFWIVNYKSAXk3NnB1LK+ufv+p2FB9JALLP0Q3DEqxCytavLmIPhHqiopyqQ0M7xOqCryXwmAECGV5n9oUMAcC4ZVhWGcA7VZYETZ7Ma+quviqdRqTm85KkHHVnrChoJ2c5TOsdIT21gkPO/x893YXUhq+AVLfTm3Mf+Y/SJduBgQcDD1I85XchG7dEHCPCheiXfq/+kTwyZHOpCU0jdJlgiv0JPS7Yz7ncH1dxt/jXwcTRMplqQYv1b6FYUo2UByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYYusdhuZ7j3RtKRMo8XP2e2ELYHRstg7Xd/ZEMIn0E=;
 b=RERVYRrMu9btwq6gfZX29Tzg35gONSn/ROI9UFYYYpjDlfbP6s6282LBsfTyV3jgiyOHfi3mYwo9L0mmJeP0OE1YYSckqz4Ez6OMYZ2qL0XH9v6/0+WxtMJ8aVyx7/Qfn4rOqAILqR0wyr3BdnvpamrRvzabJc/P1QVuyAJTWjwmn9mF0jZXSrqRfZQGHt2w0YftD9VydCPmq3im9I57FM6bOUj2ooQm7U3fiw+Q3+ib/hWBUryMpr8NCHZj9uRP37xsJDRromvNWfItiQ+79qVkLUSHak5jqgwUKAPK9lVIvEMlXjvf5+NngNmXtsCvksz8KPj0ATEQkL8F5YCarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW4PR11MB6909.namprd11.prod.outlook.com (2603:10b6:303:224::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 10:19:47 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 10:19:47 +0000
Message-ID: <af1ee9a7-2c6f-0450-e44e-59e5eeb50d6b@intel.com>
Date:   Mon, 10 Jul 2023 18:19:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yuzhao@google.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>,
        <akpm@linux-foundation.org>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
 <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
 <ZKhiGLpIWi5Z2WnY@casper.infradead.org>
 <436cd29f-44a6-7636-5015-377051942137@intel.com>
 <ZKjfwYWh/n/LbTZv@casper.infradead.org>
 <676ce1b3-6c72-011e-3a4f-723945db3d31@intel.com>
 <04efd5eb-06c2-d449-8427-d7c30df962d1@redhat.com>
 <b598c796-7bec-5ac7-9e7e-9a8b5d9ecba2@intel.com>
 <967ccf33-0982-6042-e4ce-b0c859b4c3b1@redhat.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <967ccf33-0982-6042-e4ce-b0c859b4c3b1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW4PR11MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 110b6b6f-2f4d-496d-5d68-08db812f2fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJxyAiGF9aQhedp4Nw6O0jdbINYchRFC9iWRU54xyeF0zuh1ySEqWCMD17Gyh9A1i74Pmt2F0ZG3ZO58eyc3SJzZKYvwQgZxjxS2CDhcKOQRbQk/e809ieyVim+DfkvOrh2qt9EQv+DIi7LHE6TKYYxHmlbAWY29aU+p3KGz8KC6DLPrPPaRmlaWXsfy8IqJlu2Om3lHCDD2S9nnwHpKEoX1SgfC/LG4ZKXyh31fv+xzxLmY/n47YBah50Y7QG3Sv625VaAkwix4flKdjqg8eUP2HXGxb4U2NdvYzeyG9ZKLP1C93TMK+zQH8t97rxfZfp4MieIuMJe+60TUbLI0FvRNMcKS/cUHkm1CBgSq9ffh8wZ0smBp4PZyRkAhAWbbrRpiW75wi6U5/TfIyeJ4jI0DVz7X0BdA8CZMORI+oM6/TC5oTbRr+iL+WSjRFU2zBQJ3NC8TowoW3UySsa/uPTk2TpOGmrlxAO6zn11ZUqjQOHq9od+CQhHZsmthehgX1+3qrF2Gq2oez2POdMggPf4VSvT5LECiRbZ8UUzp8N6Rqz6ylJZXYyhA7OKei4nCFFMCcK/z2bgF0JbXYhkxBeXwOS144kcfSPizGkraNJ+0aII0GhU5GkBRUDNLOhS7zbe4bN4502IuoabKtAd0WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(36756003)(86362001)(31696002)(38100700002)(82960400001)(478600001)(110136005)(6666004)(6486002)(6512007)(8936002)(8676002)(5660300002)(316002)(2906002)(4326008)(66946007)(66556008)(66476007)(31686004)(41300700001)(2616005)(26005)(53546011)(6506007)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEcvWXY3enRRZmJGQURNS1ByUWdLMy9lU0FqcnhuVU9BdUFhK1lzNW9XZWFq?=
 =?utf-8?B?ZW1sN3M2eU1kYVlteDdsRFZLeitpaURWVitYbXJQS04zTXN0TFV2WmFiNTh1?=
 =?utf-8?B?SDE5YUVDQllvTEUrdFMwdFgzOHdyYllwR0w4MmRYS3F6WHNxR0JoNkxhS1RX?=
 =?utf-8?B?VU5Rd0NsakZETlhORERzcFBKSlh1VEdtK2dvWEFjTEYydUZFN251OVI0NkJP?=
 =?utf-8?B?cll2aXN4Sk13czhRRWYyeStTcFVRVUk1MDVTU1ZOZENqZlY3Z2ZwaXRyUkV0?=
 =?utf-8?B?SkJzN0I4MURucjJ4ZkVxU3dvMVVqRmkvbkJWNzA2K3BjZlFxV1FTYlpBMWlB?=
 =?utf-8?B?SFFybFlyMlkyTStCdUZTNFhneWc2aEFPQXV5ZWF0SVJkR055OHViNFB0Q0Ew?=
 =?utf-8?B?UnB4NVY3WGZGYkhSSjc0bWsweWlWUnNXMks0bUQrM3YwVWM4dGVmUGNscUtq?=
 =?utf-8?B?cXozZ2dNTkNDTWUwcDhPdjdoVzFadmtZT09YU3ZxSWFrNGkrd0pFQ09LSVhT?=
 =?utf-8?B?TXg3SDg2NlpKc0FQazQzaXQ3TzJEcGJOV3UwMkMybVU5YTJvNFJuSVI5T2Jh?=
 =?utf-8?B?K2VwYjVxM2c3cFpLVHBoK3R4bXdNQTZUQkgrc1VMSDBvSTlrOGduM0YxNnJM?=
 =?utf-8?B?c3E1dHl3ZmNwWUhrODluNVJoR0RMY3M1RjNNcUlOYjNiUXZMaTMrNkE2ZGk1?=
 =?utf-8?B?SkloVHlxNmt5aUZWSDI4L0p1Qmw1Tm1jYzVaMHhXbnF5K2YwTjNTekpkcHoy?=
 =?utf-8?B?enc4bG1ZOUlSbGhreWlLM1dPV3lLazdNMFJJeXhaQ0U4a2dmSkI0bzNMbUVO?=
 =?utf-8?B?NGJjMlcxbnVJazgrZDFYRTdaQ0RTNFNwK1FmSW9peG16QVJIYVlVY2Y2T0Fz?=
 =?utf-8?B?UTI3NHZWNE1PV29ScmFYTUUvV0FDcHpKV0dhR1FmM2hrQzRTNEIvTUI1Mjgw?=
 =?utf-8?B?RTFpZWxKY2xSRlVUOUt1SVlqYTYva041L09HcktLMTNHbzIrMzB3a00wRjl6?=
 =?utf-8?B?cThibkM1WjlOQlZFUEF2QlhQbC9GZ0Fjb0tZeGg5YUlqaEN5VW5aTmszbXls?=
 =?utf-8?B?NlM1UGNIZGVvaWtuTU1qNDJhTy9NazE2RHNwelpZU3hjWkVNcnJ3RHRWQVhl?=
 =?utf-8?B?RHFHL3p6K2dPV1NJa3pTVlhKdGxaR2RHTHdiMGpWQnIzZ1B6VXB0d01CeE1y?=
 =?utf-8?B?MzBiTHZXWWwxMmljTmRoV2Y2eDRFNytuK0hRZmJiN3Y5b0U3NkcwSXVGUUFa?=
 =?utf-8?B?K2lZUEVUWUpvL0wwM3o3VWtrdFNaL1JzWndPRWdIQW5lN25PVlhBRW1TS3NQ?=
 =?utf-8?B?M1pkY2tTZ0Z2Q0VoelZlR2lUUG5YZ0tjeEdCR0wyMGhwWU9xQ1JIeXF0ODkv?=
 =?utf-8?B?YWk2VVhjWWlrZGQwaHBuNEcrNzMydGlKV1YrQXYrai8rUXBxSU5SWTRRVHl1?=
 =?utf-8?B?cUMyNVBjcUlUdmd6ZXB0blN0TkZTQWFtNWlKYXNTUGVtWmJMdnR0VzVzZFZO?=
 =?utf-8?B?SW84dG1Fc1ZGKzdkbjUxd1VtYmcyWHVXNXhnbFZTWHNqNDVyMjc0SWFBNDBC?=
 =?utf-8?B?cllndEI3cE4wcEtwcHlDMVN5OTBPc1VzVkRwRUEwR25HREtITTNURXVEUFZP?=
 =?utf-8?B?MnVvd2lIU09Sa3YzNmJEZGEzTksvckNnZkpXVlVPVEIxUXgyZHFNbFJFNWZr?=
 =?utf-8?B?TVZub3RheGdGVHMxYTlKcUwrakZKMHBlamtuWDgreHJWVEIrTFUrbXE3OVVI?=
 =?utf-8?B?cXZheUFick93OFBSdk5PVGxTOGJlZXMwQ0gxM2NsNHBZcXJYVE9jTTNBaUZ1?=
 =?utf-8?B?M0E1SjZSR25MVDFyL3ZxbVllZnREeGcxTzhwTFNnSDVXbEVKSWUvWVlEZk5a?=
 =?utf-8?B?aThMMHM4N3NuUEVBK3dPSXlGQ1NjWEVlVnpBeGVORnZwWEtZdGx4ZFpRT3ZO?=
 =?utf-8?B?Q0lFbkxWNDFzaHNqYStOeEFINi9sOWhXOVFtb2NzK1V1Ly9OajJCanZaTkFF?=
 =?utf-8?B?M2VENXAvRzc1N24rcWM4ZEZRN2dhczZIQVBXQ0pXcE1aSjRNS25LeVZ4MjFH?=
 =?utf-8?B?TzBZazQrcElRYVZkblNHVWRUZENKTW5sbmV3cHVkaS8rL0IvelAvWkk5UHl0?=
 =?utf-8?B?bUcvMEEyeHNGSmJMTE94YmlPa2xMb3pwVWJwSEtmdDh0cXhKdmVINkRFdnJL?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 110b6b6f-2f4d-496d-5d68-08db812f2fcb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 10:19:47.2314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bPPbqGZnvVwF7EEk/ZWfSX2oYFYXDGRn9kER/K/BiFL3g4z1ypj8SqlhUPRPlwog5TgW9qvp1PrKQoJE9DRFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6909
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/2023 5:57 PM, David Hildenbrand wrote:
> On 10.07.23 11:43, Yin, Fengwei wrote:
>> Hi David,
>>
>> On 7/10/2023 5:32 PM, David Hildenbrand wrote:
>>> On 09.07.23 15:25, Yin, Fengwei wrote:
>>>>
>>>>
>>>> On 7/8/2023 12:02 PM, Matthew Wilcox wrote:
>>>>> I would be tempted to allocate memory & copy to the new mlocked VMA.
>>>>> The old folio will go on the deferred_list and be split later, or its
>>>>> valid parts will be written to swap and then it can be freed.
>>>> If the large folio splitting failure is because of GUP pages, can we
>>>> do copy here?
>>>>
>>>> Let's say, if the GUP page is target of DMA operation and DMA operation
>>>> is ongoing. We allocated a new page and copy GUP page content to the
>>>> new page, the data in the new page can be corrupted.
>>>
>>> No, we may only replace anon pages that are flagged as maybe shared (!PageAnonExclusive). We must not replace pages that are exclusive (PageAnonExclusive) unless we first try marking them maybe shared. Clearing will fail if the page maybe pinned.
>> Thanks a lot for clarification.
>>
>> So my understanding is that if large folio splitting fails, it's not always
>> true that we can allocate new folios, copy original large folio content to
>> new folios, remove original large folio from VMA and map the new folios to
>> VMA (like it's only true if original large folio is marked as maybe shared).
>>
> 
> While it might work in many cases, there are some corner cases where it won't work.
> 
> So to summarize
> 
> (1) THP are transparent and should not result in arbitrary syscall
>     failures.
> (2) Splitting a THP might fail at random points in time either due to
>     GUP pins or due to speculative page references (including
>     speculative GUP pins).
> (3) Replacing an exclusive anon page that maybe pinned will result in
>     memory corruptions.
> 
> So we can try to split any THP that crosses VMA borders on VMA modifications (split due to munmap, mremap, madvise, mprotect, mlock, ...), it's not guaranteed to work due to (1). And we can try to replace pages such pages, but it's not guaranteed to be allowed due to (3).
> 
> And as it's all transparent, we cannot fail (1).
Very clear to me now.

> 
> For the other cases that Willy and I discussed (split on VMA modifications after fork()), we can at least always replace the anon page.
> 
> <details>
> 
> What always works, is putting the THP on the deferred split queue to see if we can split it later. The deferred split queue is a bit suboptimal right now, because it requires the (sub)page mapcounts to detect whether the folio is partially mapped vs. fully mapped. If we want to get rid of that, we have to come up with something reasonable.
> 
> I was wondering if we could have a an optimized deferred split queue, that only conditionally splits: do an rmap walk and detect if (a) each page of the folio is still mapped (b) the folio does not cross a VMA. If both are met, one could skip the deferred split. But that needs a bit of thought -- but we're already doing an rmap walk when splitting, so scanning which parts are actually mapped does not sound too weird.
> 
> </details>
> 
Thanks a lot for extra information which help me to know more background.
Really appreciate it.


Regards
Yin, Fengwei
