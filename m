Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699C874D926
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjGJOkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjGJOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:40:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FFDCC;
        Mon, 10 Jul 2023 07:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689000013; x=1720536013;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K0fyK4vipqru9Wrlp198iVRqEqTyOuFERo4g18Z9S4M=;
  b=Wc1+r8xHBZWUIJt/5OCjkAPwc+TW3wNgJIT5BBIzn1Vtwf/en7JGEihX
   qEuxiKNdNtdMIt30Bno+f0UVFYx8LoB8rXK4Dn1qHw0XV9Qul8Xk2JA0s
   xrozUdGfng7R8bHUTXuVYi6qMWbiGH8R+qiu9/KPXCQpF/Rr9MzOGJXaF
   GOpWUGsK7DjCx68hSmHrzgPKoGDgMJuO88z7wDYEZU3EGNOSQaHH7dZ53
   7LZv2uhHPxL8wnLTWJhM1herBGP3zxJC4jf393khrTR88tyuPuYwrgD9f
   KUX3Fa83toN4oUlAyUn+5ekxjXfFcL4IYXG3gRq2+U2Ud83I3RogFos4f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="349163632"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="349163632"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:40:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="967445567"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="967445567"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jul 2023 07:40:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 07:40:11 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 07:40:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 07:40:10 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 07:40:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbSkUJexSrgc6t4U1jf4KiiWmonELv3jkkGpWA8XacquZOv9Opf0MI1a/jsysMYrJkLnEX6Ee4n7ut0hYMCg4bVON036x7cVOyM4NlQVEgbNRIMfF1NtSFkUbPRoiLmM0AXpQxdnlFaAnYebYoVrPhJQ0FL8oN3Sbh1WOvt7w7RDirTA75SlpxGW5mKmJnbRgMHktctYH46eiHQwxN8BXTxP2ILUHxP6o4lU6DGmgGwkPryG8yvIgnosLuTOF2LNBQPZRFM0Vph7cnZnPEeXvvb+AXaWAVj9G9YFmAR5kdQTpe6jRNhfjLjSXPNCiWKHmImk8ww52qNo2YyiAHh8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4V74p+RXRQVtW+wWf5CBwWwCbImLNIC7VspLzY2DnIo=;
 b=DO6VzeVu9yUikSX7Nmsdfcq+nEaC7U3kSzJQkNWmWsz2qEBAkKhigF7PPvrlfoO90BSwcVJo6WUhWs4Xal0TGjW3rJJGWKE/uxov08hQfQRjG2VEvBkzDQe+6deGbtNhBrTyFpXpnYBT4smcLcFNaqLA+Im1Xxi4JQmGI6p0jzz5rx46aVGN1+wXad00l55HEowa1UXysWo/17Q1d8j9colSz/V818Kn93pGnny5rl3qSSCEIgFXEK/YpaedgGl7HhKCCfFay8tM5xQlAkpx/0FgWIfMUMwp1RjZ8NMsHws9I1nkWU3Qg8jrBPukRkEmLAqE0eA2qlvPrr7ShzRLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH0PR11MB5268.namprd11.prod.outlook.com (2603:10b6:610:e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 14:40:07 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 14:40:06 +0000
Message-ID: <e201644d-c9bd-52d9-9d26-a18bc4def21f@intel.com>
Date:   Mon, 10 Jul 2023 16:39:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 RFC 2/6] page_pool: unify frag_count handling in
 page_pool_is_last_frag()
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
 <20230629120226.14854-3-linyunsheng@huawei.com>
Content-Language: en-US
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230629120226.14854-3-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::20) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH0PR11MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: e98d4b14-fcec-4583-ed81-08db81538dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2UlS4+wyNE2kOG1Fc+2s4qZ4g9zDbejwYfiUps6Jk+k0WWx0Ax36++aJM7QlZ3X0yVxc5/+SdrkXflDbB6wxcUcZ+b6vgi3iofyn2wD34yoznn5+EoN7RrW95COnjJzMfOyXH+rwJ7B9y9Dcht/x+H7EH4VGl4vBdnMoaVwYZfcrtWRVya7Koi1UlQ6br7bdYIo/UETqSWuQSLAl9jJCztsaYxCLt8b7vqWQDUPji6zIYrN25xt5hPvyi52EFLsdLL1/F2udOzPFQHmrHNb/Qxp9GRtLWckgY36RAF2Y6BpWIdO6BB6VGHBULg0y2JIyA8KfNL2KGRv099uCAblIqADQIr0n09t/gPRzUS2GlJUaAXWR8CCcYg0MAoh06302GlioylWVXeHeQt4w4u4OIA21j6iT48nLUpxUezUHSuYnfd005xe1pyr351tq44kaah539EXlYRDQVxYWo4Ry3BZGxl1i0tYQ+e09YZnZug+EJxZ3Pueotfb4Z1QO/n7lVKIjhz3V17NFjFYd1KB5JxRTS5t4xIUwWfFs7b/BCn0ShA7Cr/jHxw5NryJ00FooEM/7mffzvak2WgowdDif8/wzxRC9Jyz7gN8Xrj9fOtZSBEFU12hK9tClQ7tivXNO0P2msTQua5hGstMQBRGEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(86362001)(31696002)(38100700002)(31686004)(36756003)(6666004)(6486002)(54906003)(82960400001)(26005)(6506007)(186003)(6512007)(2616005)(7416002)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(83380400001)(4326008)(6916009)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU9wYlpBK1lJMWp5V1Uxa3UzT09vYTV1dVRKdEQraWdXUkRWVHdTYkViWmdy?=
 =?utf-8?B?L2hqWitJNm1qMEZVRG1EQ3hCS2NUY05wWnFCb2dKY3hXUnBMVEREYlZtelBy?=
 =?utf-8?B?VHFmVURhdzlCNWtPdEZQdk1lTUVKOGNDWTM4MHFyWk9VK1A2TlB5djBLbzlk?=
 =?utf-8?B?YjZqWVZyZjlPQm82LzlKR09XYTVKQkVibkRKNkpKWi9QbFZvQkgxalVNdmMv?=
 =?utf-8?B?SUI4c3dVckVHekpwdGF0V3dtNGZldE81TDE0VG9LMVJESDFEYkxWTjBMMUE3?=
 =?utf-8?B?QVduVHJBbzRtNDdYOWhPZmlac1RvK2hPU0lDcDhKWHVvS3I1T1JMZ0o4SWI0?=
 =?utf-8?B?RzZENEVoSXlxT1U0a2NyUUx1eGM0TlR0eVdtTzN3Vy9LY28wNG5nalpjaUkv?=
 =?utf-8?B?RlB1U0ZocFA2UE9oS1RnQjJFczFuc1gwWUFlUHkxNTgxU0VReEZNNW52UzN6?=
 =?utf-8?B?NUhydHlCQ0RTWVNkTW5DcmhJUjE3dlgzckZBVDZyMkdtV3B6SitONWtSL1dM?=
 =?utf-8?B?a3VGYU4raTZtYzd6cUJGcGs4RU5kY285bmUwZ1Nrb2VMdHRSZHY5YTd6WEta?=
 =?utf-8?B?cHNXaC9ZSktPY1Z2Zmo4Vm1qYU5oVDdmLzU0VjJ4VG5qRFRPTk42MTg0QVdH?=
 =?utf-8?B?alFxN29abmlDOGtqZTRWcnFuZXJlYy9uSzU5QmtXRVZqMDVlVTlpTC9OZWNv?=
 =?utf-8?B?c0JxMks0OVhoVzFtQjdtV0hwUTBhZjdhUWtKWFBLWExTbmRkQ1gyM05icERC?=
 =?utf-8?B?L2phRktEKzhzOUxBcEFPanBSdFBTdUhQOWRpcVAzWFl6M2sva2hwN1kxaS9w?=
 =?utf-8?B?MHBSS2d3NzFHUXM4cFdKaERMNHdxVDhDRTR3cThEekFCVVpVb2tLZE1MSHVO?=
 =?utf-8?B?WmpCM3ZYWFJvL2hGWjVRV0lRMndvMHp3T09kWURyeDI3ZzZXUEJRbUVHVWg4?=
 =?utf-8?B?Q1hhemNLUEc2RFNCSUlQNzVyeHlPSVpmY2ZrOVpGaXE1a0M0YXdXeGhWMzk5?=
 =?utf-8?B?ZEpweUlXcis1MnlaT2RxRzhaVmFVaExPWHBSZ28vZG8rYjNFUyt4RHVtd0t3?=
 =?utf-8?B?dXBVcEtrVWxyS2FQYnY2Q0tKVitLLzVRLzluUkxKeTNnbVJZNU5IS0EvME5I?=
 =?utf-8?B?UGtqa015L2NFNXhzZHgyaXFzRno1NjU4eEo4K0ozMkwyZXVkdEdpVjJ4TzJi?=
 =?utf-8?B?emJ1OEIxMVpJTTNzWEE4bkhwQnc4ai83Rm50V0lwcDBLUStrQmo2b2FyYkFV?=
 =?utf-8?B?RlozcC9GM1p6ajNpSlkzeDZWOFdTdnh3ZDdsOUpaTmhmK0VUR3NDOTFna3Y4?=
 =?utf-8?B?UTF3TVgvTURrQWpKY0tTdXJ6dkppQWE0YmN3SzJGTHRLVStWcmN4VDNwbktO?=
 =?utf-8?B?a2ovMEdocVA5dkFUem56YVk4Tlc1M2hDZVFQRlFTN3RZenI0ajE4TS90cXlz?=
 =?utf-8?B?SVJDUjdlZWlGbzNDRGUzNVNQU2tOS1k1RVJQQ2dZRUx5M1lNTW9odHpqYUlX?=
 =?utf-8?B?ZW1OUzFlWHUwK2JOSzJrTGpzZi8xMS9hRHdWM3JDa1dNejNWWEUyRFhkYTNj?=
 =?utf-8?B?QzdEcUJ1YkErZTFvenVhbzdJeU0zL3FVV2Q2NWZhcFBBVE1uWmtWODFwTXZh?=
 =?utf-8?B?UlRHazVmaEdTRmVJVnhpSmJUUTZXZDdJcVNXRHhUQWV2SlUySzZ4UTRZQ25w?=
 =?utf-8?B?YXlBcS9WMG9kMkYwZmExQzhVdFlzSjBXc0pkRk9KdS8rV092cGRjZHMySEZJ?=
 =?utf-8?B?ZFMzaTVVcVJ2N0toZlZUaWVpZkkzb3h2blpSbVFSSFZwSEZId1prNDJGTzhk?=
 =?utf-8?B?eWp3b0ppZk96TDNzRVI0UXRKb0F2TSsxUU4wVDZJc3laVm90RmNSQXp6UmR5?=
 =?utf-8?B?V3lTdGlBbmRaMXFJTDhVMGpIdjdaQjFZTVh0K0lJbkovOFUwSmJlREkvZ0po?=
 =?utf-8?B?SmlveGpERHpid0RzWmpta2VYS1o0ZllQU3I4VzNTd2RNS05Rb1RTd1dkYk5j?=
 =?utf-8?B?eGdIL1JKZjROczJHU0VrcENJcTA2eVlHVmJmYjlMMnVRekpLa3lSRGw3ZzN6?=
 =?utf-8?B?aUhmTG9ib1IyVU1yNW14M0lDZWxIMVViSis4clh1dnBtTWNGKzU4WHovR2xz?=
 =?utf-8?B?Sk5RL2tqb2hMYjdJaFJBaTU2MmQ3Zm41ajNlUHd1TWY1QUpxMEZYdG91QjZx?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e98d4b14-fcec-4583-ed81-08db81538dcf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:40:06.7071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hm/jNeGh/2Pjzq983q8Zr3Uv1uB3iBE0UDkXjwHMkV/EyP9Ei7R7SkZFSfd+/37mO5E+sZPEr5neeD5ZQeP6Y4Nn9B9hcaU3GeGld7/+w4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5268
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Thu, 29 Jun 2023 20:02:22 +0800

> Currently when page_pool_create() is called with
> PP_FLAG_PAGE_FRAG flag, page_pool_alloc_pages() is only
> allowed to be called under the below constraints:
> 1. page_pool_fragment_page() need to be called to setup
>    page->pp_frag_count immediately.
> 2. page_pool_defrag_page() often need to be called to drain
>    the page->pp_frag_count when there is no more user will
>    be holding on to that page.

[...]

> @@ -352,12 +377,10 @@ static inline bool page_pool_is_last_frag(struct page_pool *pool,
>  {
>  	/* We assume we are the last frag user that is still holding
>  	 * on to the page if:
> -	 * 1. Fragments aren't enabled.
> -	 * 2. We are running in 32-bit arch with 64-bit DMA.
> -	 * 3. page_pool_defrag_page() indicate we are the last user.
> +	 * 1. We are running in 32-bit arch with 64-bit DMA.
> +	 * 2. page_pool_defrag_page() indicate we are the last user.
>  	 */
> -	return !(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
> -	       PAGE_POOL_DMA_USE_PP_FRAG_COUNT ||
> +	return PAGE_POOL_DMA_USE_PP_FRAG_COUNT ||
>  	       (page_pool_defrag_page(page, 1) == 0);

Just noticed while developing: after this change, the first function
argument, i.e. @pool, is not needed anymore and can be removed.

[...]

Thanks,
Olek
