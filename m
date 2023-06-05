Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4AC722457
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjFELPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFELPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:15:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D96B8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:15:05 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QZWCQ2KbgzLqTy;
        Mon,  5 Jun 2023 19:12:02 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 19:15:02 +0800
Message-ID: <188bd60a-e58a-a0f7-727f-bb2ce2a40d94@huawei.com>
Date:   Mon, 5 Jun 2023 19:15:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] mm/hugetlb: Use a folio in hugetlb_wp()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <muchun.song@linux.dev>, <sidhartha.kumar@oracle.com>,
        <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>
References: <20230602015408.376149-1-zhangpeng362@huawei.com>
 <20230602015408.376149-3-zhangpeng362@huawei.com>
 <ZHpORDg3JltVUwNb@casper.infradead.org>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <ZHpORDg3JltVUwNb@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/3 4:17, Matthew Wilcox wrote:

> On Fri, Jun 02, 2023 at 09:54:08AM +0800, Peng Zhang wrote:
>> From: ZhangPeng <zhangpeng362@huawei.com>
>>
>> We can replace nine implict calls to compound_head() with one by using
>> old_folio. However, we still need to keep old_page because we need to
>> know which page in the folio we are copying.
> Do we?  It's my understanding (and I am far from an expert here ...)
> that the 'pte_t *' we are passed *inside hugetlbfs* is not in fact a pte
> pointer at all but actually a pmd or pud pointer.  See how we do this:
>
>          pte_t pte = huge_ptep_get(ptep);
>
> and so the page we get back is always a head page, and we can go
> directly to a folio.  ie this is different from the THP cases.

Yes, I'll remove ptepage and old_page in a v2. Thanks.

Best Regards,
Peng

