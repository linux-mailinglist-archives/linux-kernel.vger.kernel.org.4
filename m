Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5716D5DC4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjDDKmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjDDKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:42:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4511110F2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:42:49 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PrPRQ0DqmzKtdk;
        Tue,  4 Apr 2023 18:40:18 +0800 (CST)
Received: from [10.174.177.229] (10.174.177.229) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 4 Apr 2023 18:42:45 +0800
Message-ID: <5e604ce7-8f06-392b-d56a-249abf9b4635@huawei.com>
Date:   Tue, 4 Apr 2023 18:42:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/2] mm: ksm: Support hwpoison for ksm page
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "sunnanyong@huawei.com" <sunnanyong@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20230330074501.205092-1-xialonglong1@huawei.com>
 <20230330074501.205092-3-xialonglong1@huawei.com>
 <20230331054243.GB1435482@hori.linux.bs1.fc.nec.co.jp>
From:   xialonglong <xialonglong1@huawei.com>
In-Reply-To: <20230331054243.GB1435482@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.229]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for your reply. Your suggestion is indeed very 
helpful and I will take some time to consider how to implement it. Once 
I have a clear plan, I will send a separate patch to make it happen.

Best regards,
Longlong Xia
在 2023/3/31 13:42, HORIGUCHI NAOYA(堀口 直也) 写道:
> On Thu, Mar 30, 2023 at 03:45:01PM +0800, Longlong Xia wrote:
>> hwpoison_user_mappings() is updated to support ksm pages, and add
>> collect_procs_ksm() to collect processes when the error hit an ksm
>> page. The difference from collect_procs_anon() is that it also needs
>> to traverse the rmap-item list on the stable node of the ksm page.
>> At the same time, add_to_kill_ksm() is added to handle ksm pages. And
>> task_in_to_kill_list() is added to avoid duplicate addition of tsk to
>> the to_kill list. This is because when scanning the list, if the pages
>> that make up the ksm page all come from the same process, they may be
>> added repeatedly.
>>
>> Signed-off-by: Longlong Xia <xialonglong1@huawei.com>
> 
> I don't find any specific issue by code review for now, so I'll try to
> test your patches.
> 
> I have one comment about duplicated KSM pages.  It seems that KSM controls
> page duplication by limiting deduplication factor with max_page_sharing,
> primarily for performance reason.  But I think it's imporant from memory
> RAS's viewpoint too because that means we could allow recovery from memory
> errors on a KSM page by making affected processes to switch to the duplicated
> pages (without killing the processes!).  Maybe this might be beyond the scope
> of this patchset and I'm not sure how hard it is, but if you are interested
> in this issue, that's really nice.
> 
> Thanks,
> Naoya Horiguchi
