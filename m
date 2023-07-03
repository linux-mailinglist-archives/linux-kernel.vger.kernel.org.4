Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43755745B0A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGCL1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjGCL1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:27:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5FEE3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 04:27:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QvkC66FhPzTlX6;
        Mon,  3 Jul 2023 19:26:26 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 19:27:26 +0800
Subject: Re: [PATCH] mm: memory-failure: fix potential page refcnt leak in
 memory_failure()
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230701072837.1994253-1-linmiaohe@huawei.com>
 <20230703063713.GA3012709@ik1-406-35019.vs.sakura.ne.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1e8ff9bf-c81b-9c39-9f44-2f82efcd36ec@huawei.com>
Date:   Mon, 3 Jul 2023 19:27:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230703063713.GA3012709@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2023/7/3 14:37, Naoya Horiguchi wrote:
> On Sat, Jul 01, 2023 at 03:28:37PM +0800, Miaohe Lin wrote:
>> put_ref_page() is not called to drop extra refcnt when comes from madvise
>> in the case pfn is valid but pgmap is NULL leading to page refcnt leak.
> 
> Is this test scenario realistic one?  I don't think that we can call madvise() for
> such a device memory page.  If this is the case, this issue can be thought as
> potentioal one (so no need to send to stable). 

This is a theoretical problem. If pagemap can ever be NULL after page refcnt is increased, this
would occur. I think it's not needed to send to stable too.

> 
>>
>> Fixes: 1e8aaedb182d ("mm,memory_failure: always pin the page in madvise_inject_error")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Anyway, the patch looks good to me. Thanks you.
> 
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Thanks for your review and comment.

