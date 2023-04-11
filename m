Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1B06DCF56
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjDKBbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjDKBb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:31:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D1E2D5B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 18:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681176663; x=1712712663;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WGZIYBMEkUoN7eZ+BBrBmtqReWSwRgkLmOyuaXxqj1I=;
  b=Fkiqnlj/07etPCFFRCFkK3BvtzJiCC25FafzuOhrQWmAcglgwPiiNbJ0
   huWTgn9P9N4zVreGrPS5UCPA1a6f3mAsi8g6+iKwDvfMnM9Qyk03QrpRY
   +XEMJwbdmdjG7+HegHAYYRorH4m4OTsVtp4ARskDgd7ChZpMVzidAQtK+
   1HVH/jsQThqwQss/j2qLbGrfBdgTVY9Crmz5NS9bbhZSLvRGdK4+cS95l
   PhYyv4ZHATIFbU9U3dN4b6p/xQc0sGM4DkcVU7Bc2xBS8ZLgbIA1QVR52
   ppDsJKRdTHwNMgf7BinAwQGMM5tK+t1CxRBvLIm4FVGieQHlc1y+NXOlH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="340988126"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="340988126"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 18:31:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="862673875"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="862673875"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 10 Apr 2023 18:31:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 18:31:02 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 18:31:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 10 Apr 2023 18:31:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 10 Apr 2023 18:31:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFXTb0ohiVcv+TA883otdieb/nEHlouDMpKDfmJyHCcQR73ic3Qnkh34hx7SSSVnUdI+fgfiKhCG1zf5Om3u463oGFqAfiK/m9kcXeJY/E9uqxjaoZJihcQGzBf4bOYRRvF72/n7d7BDCyBtMm+rLj7SVFz0Juo9TplvM/aFeX4HvH8gnGHzHtGVbXn7fgmjpqr/hx8PBtoeFqMN1Mop69J+y8u/4PF4fibB29ELpm/6XJghVK3QRqut6Oho99bLtgps4jfUIJEOAEyk+ynC6/TnHFIzjmVum0PuOZ+WOtXN0ZySIjmC/38IawU6I8ARm5wzlxs2SIZwN6nOzju16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XClaCXzakO5ZHxPNUIu6FjlKkj86/SU8t9PolpiyAD8=;
 b=HLs0j4fqAs0PiFJg0GweFhgAtzdFIwGnmWMkUOGYqlI7VaZAfz95rLPARCjcOzgfqQTqiSfMk3iNgItsVoWT7S9FSjzin5U/I8sM3ufcjYLtQWSLTIXwnzTSMrFPJu3MmV6OCSPXs4RI4L03rj7wuJnssQzUXt/n2t+TR/LLH04pxLQMHkfJ9N0D7QvFL1iicba9phSiKEtGkLbwgmuFUYhrnBBiKAbcluOR+I5SqFERB5P+DwPBqSMJadM+J4z654kUV8sDF3jAG3ixF5IjaxWA/FpD6OiW6jP6mu5ChxprnhG7XSADQBLuu1VF0HfEj4smW56eTN3AX3eOdP5sIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA1PR11MB7725.namprd11.prod.outlook.com (2603:10b6:208:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 01:30:58 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f670:cacc:d75f:fcc4]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f670:cacc:d75f:fcc4%6]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 01:30:58 +0000
Message-ID: <9ba8e120-a505-bc1a-7f63-c3a5e68ce8c8@intel.com>
Date:   Tue, 11 Apr 2023 09:30:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v5 3/6] userfaultfd: convert copy_huge_page_from_user() to
 copy_folio_from_user()
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        "zhangpeng (AS)" <zhangpeng362@huawei.com>
CC:     Vishal Moola <vishal.moola@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <sidhartha.kumar@oracle.com>,
        <muchun.song@linux.dev>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>
References: <20230331093937.945725-1-zhangpeng362@huawei.com>
 <20230331093937.945725-4-zhangpeng362@huawei.com>
 <CAOzc2pzr7VJRdsx1ud_ceBhbu2XP7Ay72jFETtN8eOt5yR7S=Q@mail.gmail.com>
 <a874c84b-4a83-c12f-e064-eab6a792c1e6@huawei.com>
 <20230410212612.GA8315@monkey>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230410212612.GA8315@monkey>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0199.apcprd06.prod.outlook.com (2603:1096:4:1::31)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA1PR11MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 797f67be-7c18-432b-4a69-08db3a2c6676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5vzLbXGkK8MVkx4R5Lqjs8OoIY0dT/sRWooM7Bfn+Geb7x2ZPuUOO7Rk9WPK022mJMqsf9FBp6sDlbuxBXMy1PMVjXp/b4uq/YIxTx0ol/RS3PGaeMm4ZMglzGYB03on1/uYxRQdcFEFaK8w+Byr0KJteR8ZOx8d6R00RrGcRfi8lNgr4+KjITwb4ViVzLe0ALPGA09V1aEBlJtByw7MKTvEp8ckwt8+jQ526L3IkRLbk2KBpuxUTAfjO5m0Slv7COm8L2bvJfcN9Egf9GNWtFLEFTTANbmgEV1lywZ0R/u4dKqcgl30mXe8iBxNU4TTXHkbglDjnxK1pgwid+i8tCDyswTgT6xhUaVflZAIW0cMYyf1Y65Rl0ykkLBdOiTwydXvsCLfBD4O++RgbTgpjNZYLLOKmckbWy/8TAqtV18yWVkVKBAuFLZBM0vhimV/uK+9KZtoOcchfGNXtKQamQrTvUsSidJsCJWbnGtrIito/XnS57x2BmHQWUZHc4PtuOhU+dv7o/6v/fkQxNsN9eYPqpQSEhO/4Q+dF6gCgyMTnrhGUJRAAgDyMR+ysIMXpCgmM4DEu8euXRjE8iS6qC5p8z1N6LcIQGYrIriEMjTiL4fLREG24RzTeBoG7rUYSMhlLXHaimiFhP4tYl42UIpkombJ9+C9MUBnpMghhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199021)(478600001)(6666004)(53546011)(110136005)(26005)(316002)(6506007)(6512007)(186003)(6486002)(2906002)(66946007)(66556008)(41300700001)(8676002)(7416002)(5660300002)(66476007)(8936002)(4326008)(82960400001)(38100700002)(86362001)(31696002)(36756003)(2616005)(31686004)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzhuV2JSNm12RUNSaER5OTNadERWT2w1NnRRRnRBTHdEZUtlTmlEUTExaUNY?=
 =?utf-8?B?WXAvREJpd3VvaHFXclp6NGZFTTY3b2pTYlA5UktkTVZPZCtwR2pHaGVGTlJN?=
 =?utf-8?B?WWNQa2c0UDJrL0V0SDRtNjB4OWVWSnNGcFZwUFVnMFZDY0tqaGMxbyt4Smtt?=
 =?utf-8?B?NjBJclpOTy9leE93OUJhaCtIQVdYWHM0VEtjVXVOYlVwZnhhN3IrRkJkdXdB?=
 =?utf-8?B?bzJCdlZWT1pEMGVYVGJDQURnSzVCV0x4TmlYb0JqaERvdzJ3K1VGbTFUZkVT?=
 =?utf-8?B?SWhsUjBpazhSSCtsRGVHYTNqWi95dEV4U2s0dWRTM1FPUllZOEkwQmsrWE5H?=
 =?utf-8?B?dHB1TFYwalBrNGNNQkdCaiszbEpQc2pTWE1EUjVsSVBCdjJEeE1qMmNCOUVH?=
 =?utf-8?B?YTJCNG50QjN4VGNQK25VejNFVE9NYkh0akczL25JV1YzSmZxYUY4YVBacEVC?=
 =?utf-8?B?dVlRZkdSU2lDMDgyWVE4SUVzV0tFTldRUERDVElLQkxYRWxmTHlFd3V3TEY1?=
 =?utf-8?B?RlpqU1JhYkk3UENLMEg4aXBvb2d1KzIxbmR5Q1M5V1dBZGlLZS9qakpDb1Ur?=
 =?utf-8?B?OXBOalYycnpTZGZJemZYdTFBYW9WMWFBSjEybGUrNUNtUlVOYWU3NmpuOGZn?=
 =?utf-8?B?eW9IdXRlT0IvcTNHSnI0bW9IQTRsNTg0STV1NFg2dlR4SFBaNlNydzdWZ0lW?=
 =?utf-8?B?KzdVQXJoVmsveW1YUUlrZEUvL2Rka0F0c0dRRm5KcExmeksxMnl2OUY0NWFZ?=
 =?utf-8?B?RzhUdFRaRXJvaTdKenRGamdBNjVHRElDUW1QcVZ4R2xVK1UyTEd3K2xVeWpW?=
 =?utf-8?B?cUcxN3ZyOGQyYkJIa1ZOVzUzRGhpaEVJVy9TOFZOMmlUV0VSTFNrVkNWTGc3?=
 =?utf-8?B?U1BoSGJLZ3I5bkNlTE1peWZGTWRHYU5wdHB6anhEamhIMUVhNlBoNWNBaS95?=
 =?utf-8?B?WW9nU0wzcFJmNHp2ZEZvUys4TFoxZS9wT0ptV0lrT3BBZHBST282RnRpekJW?=
 =?utf-8?B?YVJpRFVvZTZiYXJZY3ZidlZNa2VHdzh1ZitlWmY2STdPOHg5eGk4S282K2U3?=
 =?utf-8?B?WXJKc2N5WmtvOFdpWFRhRUdBN0Z5UEVYYkF6RXBkaVdYS2Q0dUNnK1AvRWR1?=
 =?utf-8?B?WFpDNWhxS0F5MFRsbXRmUllXK2xIVVN3R0tya0NyVVY3aUlvaXBqWVo4RlVi?=
 =?utf-8?B?aExKcU1hSnVrRDVRZm1nUjFoSm9tMGFaY0V2Wk45akczUGtUZk0vNjYwOSt3?=
 =?utf-8?B?MG9wMzFzWkc3cklQUUw5cThXYzZ0UU4vVlh6VTJOQ1ZaeHF2WldNY3JmbGNB?=
 =?utf-8?B?czJ4ZXhOVVdoZzVCTFdxdTdDWVBpTEJ5WWlsS1Zwb1dpVVdxZ2tHdnAvODht?=
 =?utf-8?B?UHpRS0xDcWEwaWNzaUdNdGU5OWorNzRzcFg5ZTJrMHk5ZWUzRGcvbWlBMnQz?=
 =?utf-8?B?cGNXdlNKRDNSOFhqNjVLZDZYRno5RnBnV0dra0VrZmt5WXljVDdiekw0NnlV?=
 =?utf-8?B?TklMR1ppSVBLMVU5b1lqUGZhTDZlZjRKOUlJUGl4NVZWZktZK3pyMzUxTmU4?=
 =?utf-8?B?ZEhoZDhWRDFBYVFubjJJVnpveEIvTUVFQnUzSm9tY2NYWnBRczBsZ0JGLzBr?=
 =?utf-8?B?dkFxclp0Rlk5bXpFWjVxWU5oanJ1Rk1sd3gxcVM2QUN6YXlOby9vYlVwd2xj?=
 =?utf-8?B?RGpydXlUS2hlb3F0aXRxUHJ3S1RlTlVIQ2xKUUl0bHF5QUc1T3p0R09HUGpr?=
 =?utf-8?B?MjVKZlVmWTF2d09DNmJ6S1Nob29MclFCRjVFUndqZ2k5c0ZndEFndTd6TkRz?=
 =?utf-8?B?RWtFYW5yU09TZjVoaFN3NGd5Q0UzNld6MkhsSVptN05rNzVNZFRDTVFJdzRM?=
 =?utf-8?B?WXZPMFZRcGt3YStUOVgvd1g0MkQ3WWpvd3NFaFJYUmcybjFxbXRQYW40ck1H?=
 =?utf-8?B?S09qU29QblQvZXpvb3d4V2lTcHZhcDNmS0tXcnYwQmwzb045K0ZzTmtYZmdp?=
 =?utf-8?B?MTdKQWI3UXc4U05tTE9HS0VtYnQ1K1VWNFZqZDZIZElQSHVXUi9MVTVRQ0R6?=
 =?utf-8?B?OERPaUwya2VyRlZqNFRpekZQL3hoQnJZeEs4WU9RWEtiWDZUSEVtY0xObTAr?=
 =?utf-8?Q?tx9abFdVWDC5fHSv2481CpfVi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 797f67be-7c18-432b-4a69-08db3a2c6676
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 01:30:57.8480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpLyivD31/ke0Te+SmUGZKkOqxGEWXpmfMqaLxbOnM6PevIE6erR2cLuSG+PjEO6xSNYzJWdaksU9T/nhGiVEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7725
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/2023 5:26 AM, Mike Kravetz wrote:
> On 04/08/23 12:43, zhangpeng (AS) wrote:
>> On 2023/4/7 10:28, Vishal Moola wrote:
>>
>>> On Fri, Mar 31, 2023 at 2:41 AM Peng Zhang <zhangpeng362@huawei.com> wrote:
>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>
>>>> Replace copy_huge_page_from_user() with copy_folio_from_user().
>>>> copy_folio_from_user() does the same as copy_huge_page_from_user(), but
>>>> takes in a folio instead of a page. Convert page_kaddr to kaddr in
>>>> copy_folio_from_user() to do indenting cleanup.
>>>>
>>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>>> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>>> ---
>>>> -                               bool allow_pagefault)
>>>> +long copy_folio_from_user(struct folio *dst_folio,
>>>> +                          const void __user *usr_src,
>>>> +                          bool allow_pagefault)
>>>>   {
>>>> -       void *page_kaddr;
>>>> +       void *kaddr;
>>>>          unsigned long i, rc = 0;
>>>> -       unsigned long ret_val = pages_per_huge_page * PAGE_SIZE;
>>>> +       unsigned int nr_pages = folio_nr_pages(dst_folio);
>>>> +       unsigned long ret_val = nr_pages * PAGE_SIZE;
>>>>          struct page *subpage;
>>>>
>>>> -       for (i = 0; i < pages_per_huge_page; i++) {
>>>> -               subpage = nth_page(dst_page, i);
>>>> -               page_kaddr = kmap_local_page(subpage);
>>>> +       for (i = 0; i < nr_pages; i++) {
>>>> +               subpage = folio_page(dst_folio, i);
>>>> +               kaddr = kmap_local_page(subpage);
>>>>                  if (!allow_pagefault)
>>>>                          pagefault_disable();
>>>> -               rc = copy_from_user(page_kaddr,
>>>> -                               usr_src + i * PAGE_SIZE, PAGE_SIZE);
>>>> +               rc = copy_from_user(kaddr, usr_src + i * PAGE_SIZE, PAGE_SIZE);
>>>>                  if (!allow_pagefault)
>>>>                          pagefault_enable();
>>>> -               kunmap_local(page_kaddr);
>>>> +               kunmap_local(kaddr);
>>>>
>>>>                  ret_val -= (PAGE_SIZE - rc);
>>>>                  if (rc)
>>>>                          break;
>>>>
>>>> -               flush_dcache_page(subpage);
>>>> -
>>>>                  cond_resched();
>>>>          }
>>>> +       flush_dcache_folio(dst_folio);
>>>>          return ret_val;
>>>>   }
>>> Moving the flush_dcache_page() outside the loop to be
>>> flush_dcache_folio() changes the behavior of the function.
>>>
>>> Initially, if it fails to copy the entire page, the function breaks out
>>> of the loop and returns the number of unwritten bytes without
>>> flushing the page from the cache. Now if it fails, it will still flush
>>> out the page it failed on, as well as any later pages it may not
>>> have gotten to yet.
>>
>> Agreed. If it fails, could we just not flush the folio?
> 
> I believe that should be OK.  If returning an error, nobody should be
> depending on any part of the page being present or not in the cache.
Maybe we should flush_dcache because this function returns the 
bytes copied successfully? flushing cache to make sure the copied
pieces to RAM for sure.

For the range not copied yet, flushing cache or not doesn't make
difference. Thanks.

Regards
Yin, Fengwei
