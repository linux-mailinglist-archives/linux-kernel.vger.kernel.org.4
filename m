Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921F164F73E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 03:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiLQC7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 21:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiLQC7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 21:59:51 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F8F19C1F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 18:59:48 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NYrJj334wz16Lg7;
        Sat, 17 Dec 2022 10:58:45 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 17 Dec 2022 10:59:46 +0800
Subject: Re: [PATCH 2/2] mm: Fix a few rare cases of using swapin error pte
 marker
To:     Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>
References: <20221214200453.1772655-1-peterx@redhat.com>
 <20221214200453.1772655-3-peterx@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9669705e-1bee-c789-86c7-6e3f6e28d109@huawei.com>
Date:   Sat, 17 Dec 2022 10:59:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221214200453.1772655-3-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/15 4:04, Peter Xu wrote:
> This patch should harden commit 15520a3f0469 ("mm: use pte markers for swap
> errors") on using pte markers for swapin errors on a few corner cases.
> 
> 1. Propagate swapin errors across fork()s: if there're swapin errors in
>    the parent mm, after fork()s the child should sigbus too when an error
>    page is accessed.
> 
> 2. Fix a rare condition race in pte_marker_clear() where a uffd-wp pte
>    marker can be quickly switched to a swapin error.
> 
> 3. Explicitly ignore swapin error pte markers in change_protection().
> 
> I mostly don't worry on (2) or (3) at all, but we should still have them.
> Case (1) is special because it can potentially cause silent data corrupt on
> child when parent has swapin error triggered with swapoff, but since swapin
> error is rare itself already it's probably not easy to trigger either.
> 
> Currently there is a priority difference between the uffd-wp bit and the
> swapin error entry, in which the swapin error always has higher
> priority (e.g. we don't need to wr-protect a swapin error pte marker).
> 
> If there will be a 3rd bit introduced, we'll probably need to consider a
> more involved approach so we may need to start operate on the bits.  Let's
> leave that for later.
> 
> This patch is tested with case (1) explicitly where we'll get corrupted
> data before in the child if there's existing swapin error pte markers, and
> after patch applied the child can be rightfully killed.
> 
> We don't need to copy stable for this one since 15520a3f0469 just landed as
> part of v6.2-rc1, only "Fixes" applied.
> 
> Fixes: 15520a3f0469 ("mm: use pte markers for swap errors")
> Signed-off-by: Peter Xu <peterx@redhat.com>

Looks good to me. Thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin
