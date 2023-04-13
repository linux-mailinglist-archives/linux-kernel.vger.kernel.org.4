Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286EA6E03E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 03:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDMBzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 21:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDMBzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 21:55:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305DE59ED
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 18:55:35 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PxjLw5zTszDsg7;
        Thu, 13 Apr 2023 09:54:48 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 09:55:33 +0800
Subject: Re: [PATCH -next] mm: hwpoison: support recovery from HugePage
 copy-on-write faults
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20230411092741.780679-1-liushixin2@huawei.com>
 <20230412181350.GA22818@monkey>
 <20230412145718.0bcb7dd98112a3010711ad0b@linux-foundation.org>
 <20230412222138.GB4759@monkey>
 <20230412155618.720e6b3aa5be6444f7889ea6@linux-foundation.org>
CC:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Tony Luck <tony.luck@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <muchun.song@linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <5202b6fe-7008-6e1b-eaae-03edbe7c055c@huawei.com>
Date:   Thu, 13 Apr 2023 09:55:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20230412155618.720e6b3aa5be6444f7889ea6@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/13 6:56, Andrew Morton wrote:
> On Wed, 12 Apr 2023 15:21:38 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
>>>> Commit a873dfe1032a ("mm, hwpoison: try to recover from copy-on write
>>>> faults") introduced the routine copy_user_highpage_mc() to gracefully
>>>> handle copying of user pages with uncorrectable errors.  Previously,
>>>> such copies would result in a kernel crash.  hugetlb has separate code
>>>> paths for copy-on-write and does not benefit from the changes made in
>>>> commit a873dfe1032a.
>> I was just going to suggest adding the line,
>>
>> Hence, copy-on-write of hugetlb user pages with uncorrectable errors            
>> will result in a kernel crash as was the case with 'normal' pages before        
>> commit a873dfe1032a.
>>
>> However, I'm guessing it might be more clear if we start with the
>> runtime effects.  Something like:
>>
>> copy-on-write of hugetlb user pages with uncorrectable errors will result
>> in a kernel crash.  This is because the copy is performed in kernel mode
>> and in general we can not handle accessing memory with such errors while
>> in kernel mode.  Commit a873dfe1032a ("mm, hwpoison: try to recover from
>> copy-on write faults") introduced the routine copy_user_highpage_mc() to
>> gracefully handle copying of user pages with uncorrectable errors.  However,
>> the separate hugetlb copy-on-write code paths were not modified as part
>> of commit a873dfe1032a.
> Sounds good.  So I assume cc:stable is desirable.
>
> I can't actually get the patch to apply to anything.  Can we please
> have a redo against current -linus?
OK, I will apply this patch to mainline again.
>
> .
>

