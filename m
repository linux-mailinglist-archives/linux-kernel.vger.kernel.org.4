Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65C463C9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbiK2Uu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbiK2Uum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:50:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9E3E15
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:49:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F44DB8190F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 20:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCD0C433D6;
        Tue, 29 Nov 2022 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669754985;
        bh=0mzuQKQ6ZSk8geHPXv2MySKivpc1Sg+tc+ZvJOAilYA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N4VbFD/yPTNW+kJNXgFAk4RlYu7ZXH/Tron1X0lywmfayU8XBrdgBa9w0xSPtgiNi
         0JDyr4wb/h59ZxtX7uHGtYbK9prjiQ+VpvmGgSqHpMvBHyX0CYhc7xAK01aAnfbjym
         7fjJXrDA9vbbbWxcd3kuyr/vw1JW4YXDWl9P+uE8=
Date:   Tue, 29 Nov 2022 12:49:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 00/10] mm/hugetlb: Make huge_pte_offset() thread-safe
 for pmd unshare
Message-Id: <20221129124944.8eff54cda65d0f5a8a089e22@linux-foundation.org>
In-Reply-To: <20221129193526.3588187-1-peterx@redhat.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 14:35:16 -0500 Peter Xu <peterx@redhat.com> wrote:

> Based on latest mm-unstable (9ed079378408).
> 
> This can be seen as a follow-up series to Mike's recent hugetlb vma lock
> series for pmd unsharing, but majorly covering safe use of huge_pte_offset.

We're at -rc7 (a -rc8 appears probable this time) and I'm looking to
settle down and stabilize things...

> 
> ...
>
> huge_pte_offset() is always called with mmap lock held with either read or
> write.  It was assumed to be safe but it's actually not.  One race
> condition can easily trigger by: (1) firstly trigger pmd share on a memory
> range, (2) do huge_pte_offset() on the range, then at the meantime, (3)
> another thread unshare the pmd range, and the pgtable page is prone to lost
> if the other shared process wants to free it completely (by either munmap
> or exit mm).

That sounds like a hard-to-hit memory leak, but what we have here is a
user-triggerable use-after-free and an oops.  Ugh.

Could people please prioritize the review and testing of this patchset?

