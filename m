Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17AA74FD09
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjGLCZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGLCZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:25:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB4D1722
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 19:25:44 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R11jF5LJGzMn13;
        Wed, 12 Jul 2023 10:22:25 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 10:25:42 +0800
Subject: Re: [PATCH v3 2/4] mm/hwpoison: check if a subpage of a hugetlb folio
 is raw HWPOISON
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Jiaqi Yan <jiaqiyan@google.com>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <songmuchun@bytedance.com>, <shy828301@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <duenwen@google.com>, <axelrasmussen@google.com>,
        <jthoughton@google.com>
References: <20230707201904.953262-1-jiaqiyan@google.com>
 <20230707201904.953262-3-jiaqiyan@google.com>
 <6682284d-7ad3-9b59-687d-899f4d08d911@huawei.com>
 <CACw3F50k9WJr7WgHS-dRxJRfuXPbq2adUBLeFcKRjmm2D6qf-g@mail.gmail.com>
 <CACw3F52Pj+SeB+dD2Cjkr-bX-OZkmCpL1s6SO1aHDvaD37YZBg@mail.gmail.com>
 <20230711180159.GA3887@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c306d999-fa2b-60d2-b2b3-6e835389806e@huawei.com>
Date:   Wed, 12 Jul 2023 10:25:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230711180159.GA3887@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/12 2:01, Mike Kravetz wrote:
> On 07/11/23 10:05, Jiaqi Yan wrote:
>> On Mon, Jul 10, 2023 at 8:16 AM Jiaqi Yan <jiaqiyan@google.com> wrote:
>>> On Fri, Jul 7, 2023 at 7:57 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>> On 2023/7/8 4:19, Jiaqi Yan wrote:
>>>>
>>>>> +             if (subpage == p->page) {
>>>>> +                     ret = true;
>>>>> +                     break;
>>>>> +             }
>>>>> +     }
>>>>> +
>>>>> +     return ret;
>>>>>  }
>>>>
>>>> It seems there's a race between __is_raw_hwp_subpage and unpoison_memory:
>>>>   unpoison_memory               __is_raw_hwp_subpage
>>>>                                   if (!folio_test_hwpoison(folio)) -- hwpoison is set
>>>>     folio_free_raw_hwp            llist_for_each_entry_safe raw_hwp_list
>>>>       llist_del_all                 ..
>>>>     folio_test_clear_hwpoison
>>>>
>>>
>>> Thanks Miaohe for raising this concern.
>>>
>>>> But __is_raw_hwp_subpage is used in hugetlbfs, unpoison_memory couldn't reach here because there's a
>>>> folio_mapping == NULL check before folio_free_raw_hwp.
>>>
>>> I agree. But in near future I do want to make __is_raw_hwp_subpage
>>> work for shared-mapping hugetlb, so it would be nice to work with
>>> unpoison_memory. It doesn't seem to me that holding mf_mutex in
>>> __is_raw_hwp_subpage is nice or even absolutely correct. Let me think
>>> if I can come up with something in v4.
>>
>> At my 2nd thought, if __is_raw_hwp_subpage simply takes mf_mutex
>> before llist_for_each_entry, it will introduce a deadlock:
>>
>> unpoison_memory                       __is_raw_hwp_subpage
>>   held mf_mutex                         held hugetlb_lock
>>   get_hwpoison_hugetlb_folio            attempts mf_mutex
>>     attempts hugetlb lock
>>
>> Not for this patch series, but for future, is it a good idea to make
>> mf_mutex available to hugetlb code? Then enforce the order of locking
>> to be mf_mutex first, hugetlb_lock second? I believe this is the
>> current locking pattern / order for try_memory_failure_hugetlb.
> 
> I think only holding mf_mutex in __is_raw_hwp_subpage would be sufficient
> to prevent races with unpoison_memory.  memory failure code needs to take

Since soft_offline_page, memory_failure and unpoison_memory both holds mf_mutex,
I think this should be enough to prevent races between them too.

Thanks.

