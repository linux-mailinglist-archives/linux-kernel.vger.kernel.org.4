Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29B35FA051
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJJOlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJJOlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:41:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB3761D40;
        Mon, 10 Oct 2022 07:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665412876; x=1696948876;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o83SONTqcZJBbvlv/v1SpfVtVqhBs02ToJIvxIINDM0=;
  b=YK3+Jin331AMXlwbo3z6Z1sA4YWzTQQIt+h5OM2QzMbkhpY/EI8xrrOV
   ufR8zwiAyYY31bKVg6GCcMuaq+srz4Er252E0uk/F3nvRYEoR/229JYRR
   C+EsaScOcK6JeYDudz1zm5Xeg0icUyPiT9yDvewIkdUaR1vrwgBXtvxYe
   AgDTkNXGm5DboD4fHxuoN9kpzxjbM8ZQHxswHxkm7XtKN+0LVojMkU5fV
   O0lZwa2tbxuWsg2cGxZij7NsmtmFEXzv27XFhmU77oiTLnFtZdJT4hyK5
   sn4vKjPcLxN8qTUeTfQTjlCO56cM6OdazG40X1D7fofqn3YKuy9Tf8ASt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="301850592"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="301850592"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 07:41:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="659168492"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="659168492"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2022 07:41:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 07:41:14 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 07:41:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 10 Oct 2022 07:41:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 10 Oct 2022 07:41:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDUJ5JrRZsN3nIZIPUdwMdBpUDprAF60iZS89cJRFq4HmHEcPSiySpc0FA0DVmju0o8cYmlhL/CtkpehcO/NnwqTnRvfMDvgoxNz0AfnYeE5leq4p9EW+grBe2K2a+Kz5CtcSw8lnLDkZjFNQPXGmshLqUy1fJldxw1ovXQbYr4FK5CKmX2u+UeKrHzaxonPNiO7Tw4fyisgA61rE/EYx/aRknDwp5AyJcc8Sy3/Op4jIlRXbJRsbf5vx3klMOZu4nWHfyHoB+EAzZzcNF0+k5ImVlXw9sR5scaPEWkAiKxBu4Oe6xDCrXlqQL84AAZBxVVnRN87PxU+0+J61MYflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9H/7IQFjjMtHujIiIT/cotgEpOvqNpwCypkrLU4O2k=;
 b=HACzbJW0+FJW4Q3ievjeutYmV1Q58JRonUnQnnh+KFpYEXVCFhttedj3oCPCvbnYmyiCJ3D0aJKADAbAcV74k3EMXsXwsuCumNBRIYUD5efhSjdBviJOnfN9xJ0PsIl6Jy0JAvTBPQYiVkPGeI8QVaiDaS+2jFhdmfm5igDdLCG+PdXdvK+I6tTQo2vE82Biqb5ikmx6/CTnNBVV6g6SRRC0KsUJS1f6HNPF04917sA7Axq0xT/u07DShOmcgcuC/8kwIpy7yS0Tya/EjmOHdNv1CkAUuLrQsITrHPU92Qgnxyf32/x3tEjFJm83nyeVglnuK0ng2nwEND52exfqwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5409.namprd11.prod.outlook.com (2603:10b6:610:d0::7)
 by PH7PR11MB6835.namprd11.prod.outlook.com (2603:10b6:510:1ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 10 Oct
 2022 14:41:11 +0000
Received: from CH0PR11MB5409.namprd11.prod.outlook.com
 ([fe80::54de:6030:7501:b7ae]) by CH0PR11MB5409.namprd11.prod.outlook.com
 ([fe80::54de:6030:7501:b7ae%8]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 14:41:09 +0000
Message-ID: <9ee27342-75d4-a9b3-27e9-4885bdfcf966@intel.com>
Date:   Mon, 10 Oct 2022 17:40:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] overflow: Refactor test skips for Clang-specific issues
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        "Daniel Latypov" <dlatypov@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        <llvm@lists.linux.dev>, Vitor Massaru Iha <vitor@massaru.org>,
        kernel test robot <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20221006230017.1833458-1-keescook@chromium.org>
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
In-Reply-To: <20221006230017.1833458-1-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::13) To CH0PR11MB5409.namprd11.prod.outlook.com
 (2603:10b6:610:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5409:EE_|PH7PR11MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ba826f-882e-49e6-0ab9-08daaacd7828
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Z39WPxp6UqXFFiQN/CgP7Weei2wR7eeuDDCikNZ1vp8ItDyyPKejmt4z2cOU020DP/wAw5LJboBoi+9+SU6x0sMOkf0TwavG9UyUKnOadux3SnaswOd7CjQ4SA+uuurlENVGvwMupDerpdznJ3lz2xwhBjEX0vxK3+MgCjpHRJx55LbN32isXLHm8/L5DT16y5gmkFW4EHv6fpBWSzkmsYTOJq1h6laJgwh+mVe7vjp4fvhmz3VlDtCLkRBqgs+ONQh5N+GG7Xwx5rf6OHIyUtkpG5fSnUID0TGZPo1bf9u+KHnzKSaEkXNqMPWvXjofvYWeSvd59m/4MubGDs1qwVGJ1rptJY2V4KAmgSrxfNnzEoXK6Cgs8W4/F+jrnZPkFK24O6AUgFG9lSFypEqGEBSHF8in0tLEpMrG0nTnw0oALCwoSgaE56Ra9egLdWDib/lAj2nNt/AILsoN/xGnD+Zwb/wFJzs21t8gMYCDI1l9D191p7kcsdXyMJ4qIrb6oqZ8G84nrNti6cfoHN0bF1hE8RFEhmpuqsCDaBVVZoiUu2FoZq2I+4rIqT3v0aYr1CR1vExL4HW5xEC8ICfQvCUp0r6qmeW8FFjf8tXa01MCXzQf2RH8KhrmNpewxbow2Uf01HQsdCRN4X2x/p9GoLt6p4ZZ/kDE2UtAhtre9/uGyrvQGZY6xSGieSzoT+7IbZZ2kPSmrZ0sLylwLc5dPUvIn0MihZ98F3oBV62WnpRCSNScK3mm3MuUMdM0POClt8k5Ql3roMweW4D+bfUjV0O28BhsocfHcU8OlOA+A8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5409.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199015)(6506007)(31686004)(186003)(478600001)(8936002)(41300700001)(82960400001)(6486002)(86362001)(36756003)(7416002)(31696002)(4326008)(6512007)(26005)(38100700002)(66946007)(53546011)(110136005)(2616005)(66476007)(8676002)(66556008)(5660300002)(83380400001)(54906003)(2906002)(316002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmRmeE1DS283dkFpMkVpWFBERXpCOW1MdTFITE9jMWQ1c25hbUo4MjZnSWE1?=
 =?utf-8?B?b0czM01KeXo3OGFISXB2Z1BCRWRIdEVHNWtJcEgyQldScVFCTjVCZHVnUHI0?=
 =?utf-8?B?ZE4xTUlHOEJQRFhmSmpsQ2dsQzRRbjAxOGs1eTZleXF2TjFQNHV0TnRVNkt0?=
 =?utf-8?B?dHNMckFTb1RLTFh3SGxHYmxCSUQ0YngvcE9heFRUaUIzWndJZGZzM2VRTWpL?=
 =?utf-8?B?RkE3R3BxV3pRa0YwbTVScHVIcFY5cGg2ZmhxQXBVNmpMVngzVkpSYzJ3NlFm?=
 =?utf-8?B?YmJ0K1R0TzNiK3ZtdlZuVWxwQ25zMWdoQ2pBNDd1Y2dhSGRvU1JoVFB2ZFFD?=
 =?utf-8?B?RTFtODJZckpYYnZRQ2tqYVR1RWZrT2J2U2xoMUJlbENrenpENmFNaHYwNjJZ?=
 =?utf-8?B?TmUzT2F6TzlXeS96cE5EZzJNcXlaYjR3RFk5eUdSOUp0OWg3NDFJcVNpcUlX?=
 =?utf-8?B?NEpHcXhEY3dlcUpnMExOZnJheXZhaEdLdTFGdHBsWm9PTTlwR1B5UndabERk?=
 =?utf-8?B?OHFGeUlkSVU1SmMwRkxYZVlYaUIrZW5YSThjWVVOcGl0bUVheXIwK2FMdGND?=
 =?utf-8?B?bGtEK2RwcWxrRHd5eURsK095RkVxQTNsaUkwLzdTTmtMYXM0ZVVUTmZQVlJG?=
 =?utf-8?B?c2ZLdDdyM1R4N2FZdDhtM2VtZUVWa1phR0lMTmRUNGdUWDZlTHU4TE8wcEcw?=
 =?utf-8?B?Wnk2eElHcE1xMHFQa0VMQ3RMbEIrUktrSnVLVk12NkJaeWFibTRSK0RwMkVh?=
 =?utf-8?B?K0FsQlV4NjN0UmNLV3dxTURGZEozUmd0eXNmOWQzRVBJSTZKVFF4bk9ZM0dr?=
 =?utf-8?B?VmpBQlVTRmhneVdtU29BM1k0TzRYM0hjQkFKMHgwSE81UzhwbnNSdGpraGkr?=
 =?utf-8?B?ZUZqQnVMR2J4QzZwdVFUU0JtUExDcURKbUlLNW1uK1pJeWxQSmNYTUNqbEVu?=
 =?utf-8?B?Q0ZDemZaQzlwTlZvelZZbEVKWndTT1QvdGxjZ0kvSVVscS9UdGx5VHFFUzhU?=
 =?utf-8?B?c0NadHVkN3BaVkx5dGhhQkJSdjNOWGJJVHhmL1pTbXdONVFYMmhVaUFZZjZH?=
 =?utf-8?B?T0NZSk1WeVZNV3l2dHNnZWlHZzVCK1ZvUlNHNDRxSFVMZzZXaXNPQzQyeHhO?=
 =?utf-8?B?SHM2NU0vMUYwOG5TbXkzTThGcFNvaVVtaHkwT29RRk1iN1NNMHF6OVI1cS9h?=
 =?utf-8?B?d2RpU3RiVzZZWnV4ZlVSWVl1NVRnSm5RM0lKZVdkMEh5VW5TL3R3NzZmTEEz?=
 =?utf-8?B?UFNHZ09QZUpZRkcvUjk0djJvbGdweHkyT0haaFF0T2lzNlFCdWgzWHRaQVpV?=
 =?utf-8?B?UU9SWGFRa2FEY1FHaFdlSnczNytkT005djJSM2lIS3R5andWbyt6eEExa0ly?=
 =?utf-8?B?WXNJMGpUako1aXNDWmlRZWxJcmNHZWlZd1NWZXdNTjBvY0VSTUhxQnQzdnZv?=
 =?utf-8?B?VVRtM1JYdE53TkdYZlA2cEpwNXNjQWI5ZlRaWlA1dGNrYzBGQU5IOVIxNDdq?=
 =?utf-8?B?K2twNjlDVkZhNFl6dnVCMnFFRDZoVWhiZ2xlL1lYSk8zSGhmZzZVS08va3pJ?=
 =?utf-8?B?eDExbGtjREpPZEdDOVRQQzFzNTdEd0QzbSszQ2FVeTdNNXAxd2JmTkpEMm9W?=
 =?utf-8?B?TWY3ZEQ4VWdDa0g3UUFoU1dSZWY2V3JHbDUxbUdobE5xLyt1SWh2Y0JTN2Zu?=
 =?utf-8?B?cyszejlMYlZmamZFc2RZMmt4ZXlES2s5MHdEd2ZxRDg0UFBrT080dTIvVTV2?=
 =?utf-8?B?VVQ0MzlWc1B3VkZSMjJaaDZYQ0o3a1ZOVHZBdkozZlpTOVowWGFWMGxlMzY0?=
 =?utf-8?B?eERKT3IyQ2pmaEwyd1N1NTMzTDEwQzJRL1FudklNaHdpNDNKTngxb0g0TDRX?=
 =?utf-8?B?MCttZGlDM2NOWTUvaWxEUGxQT0NSU0cycjNFc21OcEJZZkg2dVArWDNGWnVX?=
 =?utf-8?B?djNCTnBTSlRmRzh2blp4ektkUzBTMXQ1R3YrODZ2Smp1blJ3T25EbHZtTXAw?=
 =?utf-8?B?M25DOHl6bmhFQlErSWpCdnNNTkN4R2ZtdVlHcE8wckFjbE5qY25YcE53c0dX?=
 =?utf-8?B?RUw5M0ZrTzdRTG1SMlBrRmg0UTBIMEpIeW5TcUhmM0l6OE5QcG9BanA1U1Fy?=
 =?utf-8?B?bHVHYTBLcllMR1NaYWIxMnZ5Nld2cWhORHZ0MXU0c2hUT2pEN0k4SEN6MUIr?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ba826f-882e-49e6-0ab9-08daaacd7828
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5409.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 14:41:09.5221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8Zx1AXNLfKLfr7a7dXKpjkBigfsG/3OsAifdwFn8ZOPbhYHMxgHhxNT4sYvZxpQOPEdwKqkzUxZVIW780w9ZB8kmNqwnVrv31lpxvRENqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6835
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for updating it.
Looks good to me.

Reviewed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>

On 10/7/22 2:00 AM, Kees Cook wrote:
> Convert test exclusion into test skipping. This brings the logic for
> why a test is being skipped into the test itself, instead of having to
> spread ifdefs around the code. This will make cleanup easier as minimum
> tests get raised. Drop __maybe_unused so missed tests will be noticed
> again and clean up whitespace.
> 
> For example, clang-11 on i386:
> 
> [15:52:32] ================== overflow (18 subtests) ==================
> [15:52:32] [PASSED] u8_u8__u8_overflow_test
> [15:52:32] [PASSED] s8_s8__s8_overflow_test
> [15:52:32] [PASSED] u16_u16__u16_overflow_test
> [15:52:32] [PASSED] s16_s16__s16_overflow_test
> [15:52:32] [PASSED] u32_u32__u32_overflow_test
> [15:52:32] [PASSED] s32_s32__s32_overflow_test
> [15:52:32] [SKIPPED] u64_u64__u64_overflow_test
> [15:52:32] [SKIPPED] s64_s64__s64_overflow_test
> [15:52:32] [SKIPPED] u32_u32__int_overflow_test
> [15:52:32] [PASSED] u32_u32__u8_overflow_test
> [15:52:32] [PASSED] u8_u8__int_overflow_test
> [15:52:32] [PASSED] int_int__u8_overflow_test
> [15:52:32] [PASSED] shift_sane_test
> [15:52:32] [PASSED] shift_overflow_test
> [15:52:32] [PASSED] shift_truncate_test
> [15:52:32] [PASSED] shift_nonsense_test
> [15:52:32] [PASSED] overflow_allocation_test
> [15:52:32] [PASSED] overflow_size_helpers_test
> [15:52:32] ==================== [PASSED] overflow =====================
> [15:52:32] ============================================================
> [15:52:32] Testing complete. Ran 18 tests: passed: 15, skipped: 3
> 
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Daniel Latypov <dlatypov@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   lib/overflow_kunit.c | 52 +++++++++++++++++++++++++++++---------------
>   1 file changed, 35 insertions(+), 17 deletions(-)
> 
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index 2914c9d36b0f..3062b33e4bb1 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -16,6 +16,34 @@
>   #include <linux/types.h>
>   #include <linux/vmalloc.h>
>   
> +#define SKIP(cond, reason)		do {			\
> +	if (cond) {						\
> +		kunit_skip(test, reason);			\
> +		return;						\
> +	}							\
> +} while (0)
> +
> +/*
> + * Clang 11 and earlier generate unwanted libcalls for signed output
> + * on unsigned input.
> + */
> +#if defined(CONFIG_CC_IS_CLANG) && __clang_major__ <= 11
> +# define SKIP_SIGN_MISMATCH(t)	SKIP(t, "Clang 11 unwanted libcalls")
> +#else
> +# define SKIP_SIGN_MISMATCH(t)	do { } while (0)
> +#endif
> +
> +/*
> + * Clang 13 and earlier generate unwanted libcalls for 64-bit tests on
> + * 32-bit hosts.
> + */
> +#if defined(CONFIG_CC_IS_CLANG) && __clang_major__ <= 13 &&	\
> +    BITS_PER_LONG != 64
> +# define SKIP_64_ON_32(t)	SKIP(t, "Clang 13 unwanted libcalls")
> +#else
> +# define SKIP_64_ON_32(t)	do { } while (0)
> +#endif
> +
>   #define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)			\
>   	static const struct test_ ## t1 ## _ ## t2 ## __ ## t {	\
>   		t1 a;						\
> @@ -94,7 +122,6 @@ DEFINE_TEST_ARRAY(u32) = {
>   	{-4U, 5U, 1U, -9U, -20U, true, false, true},
>   };
>   
> -#if BITS_PER_LONG == 64
>   DEFINE_TEST_ARRAY(u64) = {
>   	{0, 0, 0, 0, 0, false, false, false},
>   	{1, 1, 2, 0, 1, false, false, false},
> @@ -118,7 +145,6 @@ DEFINE_TEST_ARRAY(u64) = {
>   	 false, true, false},
>   	{-15ULL, 10ULL, -5ULL, -25ULL, -150ULL, false, false, true},
>   };
> -#endif
>   
>   DEFINE_TEST_ARRAY(s8) = {
>   	{0, 0, 0, 0, 0, false, false, false},
> @@ -194,7 +220,6 @@ DEFINE_TEST_ARRAY(s32) = {
>   	{S32_MAX, S32_MAX, -2, 0, 1, true, false, true},
>   };
>   
> -#if BITS_PER_LONG == 64
>   DEFINE_TEST_ARRAY(s64) = {
>   	{0, 0, 0, 0, 0, false, false, false},
>   
> @@ -223,7 +248,6 @@ DEFINE_TEST_ARRAY(s64) = {
>   	{-128, -1, -129, -127, 128, false, false, false},
>   	{0, -S64_MAX, -S64_MAX, S64_MAX, 0, false, false, false},
>   };
> -#endif
>   
>   #define check_one_op(t, fmt, op, sym, a, b, r, of) do {			\
>   	int _a_orig = a, _a_bump = a + 1;				\
> @@ -246,7 +270,7 @@ DEFINE_TEST_ARRAY(s64) = {
>   
>   #define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
>   static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
> -{							   		\
> +{									\
>   	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);	\
>   	check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);	\
>   	check_one_op(t, fmt, sub, "-", p->a, p->b, p->diff, p->d_of);	\
> @@ -254,10 +278,15 @@ static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
>   	check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);	\
>   }									\
>   									\
> -__maybe_unused								\
>   static void n ## _overflow_test(struct kunit *test) {			\
>   	unsigned i;							\
>   									\
> +	SKIP_64_ON_32(__same_type(t, u64));				\
> +	SKIP_64_ON_32(__same_type(t, s64));				\
> +	SKIP_SIGN_MISMATCH(__same_type(n ## _tests[0].a, u32) &&	\
> +			   __same_type(n ## _tests[0].b, u32) &&	\
> +			   __same_type(n ## _tests[0].sum, int));	\
> +									\
>   	for (i = 0; i < ARRAY_SIZE(n ## _tests); ++i)			\
>   		do_test_ ## n(test, &n ## _tests[i]);			\
>   	kunit_info(test, "%zu %s arithmetic tests finished\n",		\
> @@ -273,10 +302,8 @@ DEFINE_TEST_FUNC(u16, "%d");
>   DEFINE_TEST_FUNC(s16, "%d");
>   DEFINE_TEST_FUNC(u32, "%u");
>   DEFINE_TEST_FUNC(s32, "%d");
> -#if BITS_PER_LONG == 64
>   DEFINE_TEST_FUNC(u64, "%llu");
>   DEFINE_TEST_FUNC(s64, "%lld");
> -#endif
>   
>   DEFINE_TEST_ARRAY_TYPED(u32, u32, u8) = {
>   	{0, 0, 0, 0, 0, false, false, false},
> @@ -716,18 +743,9 @@ static struct kunit_case overflow_test_cases[] = {
>   	KUNIT_CASE(s16_s16__s16_overflow_test),
>   	KUNIT_CASE(u32_u32__u32_overflow_test),
>   	KUNIT_CASE(s32_s32__s32_overflow_test),
> -/* Clang 13 and earlier generate unwanted libcalls on 32-bit. */
> -#if BITS_PER_LONG == 64
>   	KUNIT_CASE(u64_u64__u64_overflow_test),
>   	KUNIT_CASE(s64_s64__s64_overflow_test),
> -#endif
> -/*
> - * Clang 11 and earlier generate unwanted libcalls for signed output, unsigned
> - * input.
> - */
> -#if !(defined(CONFIG_CC_IS_CLANG) && __clang_major__ <= 11)
>   	KUNIT_CASE(u32_u32__int_overflow_test),
> -#endif
>   	KUNIT_CASE(u32_u32__u8_overflow_test),
>   	KUNIT_CASE(u8_u8__int_overflow_test),
>   	KUNIT_CASE(int_int__u8_overflow_test),
