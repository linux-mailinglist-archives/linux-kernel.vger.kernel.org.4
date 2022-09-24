Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1CB5E868F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiIXAIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiIXAHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:07:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E23114A7B1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D968E616DF
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 00:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E05EC433D6;
        Sat, 24 Sep 2022 00:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663977957;
        bh=mWdycZrVbYlYerQP3VWTZuUZAv52rEKHRKG7opsxIoQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NNQb1trdB5wAEa0rLSi7MfG1r3yx6medNJchwv/GWiAbeVAngL2qIBHEmeDJsyYyW
         6xv59nob/pbHQWYWcsDBGkGRC7hUPZTlTuh8TlrlFo3hd10yJRP1Tm7mf8hAaC7etY
         rfp6I2AI1MNOpQt4eLkK1OK1LI4Er+Xib8koMOdE=
Date:   Fri, 23 Sep 2022 17:05:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Liu Zixian <liuzixian4@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "David Hildenbrand" <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: hugetlb: fix UAF in hugetlb_handle_userfault
Message-Id: <20220923170554.7046bb023f8cf582b5909b77@linux-foundation.org>
In-Reply-To: <20220923042113.137273-1-liushixin2@huawei.com>
References: <20220923042113.137273-1-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022 12:21:13 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> The vma_lock and hugetlb_fault_mutex are dropped before handling
> userfault and reacquire them again after handle_userfault(), but
> reacquire the vma_lock could lead to UAF[1,2] due to the following
> race,
> 
> hugetlb_fault
>   hugetlb_no_page
>     /*unlock vma_lock */
>     hugetlb_handle_userfault
>       handle_userfault
>         /* unlock mm->mmap_lock*/
>                                            vm_mmap_pgoff
>                                              do_mmap
>                                                mmap_region
>                                                  munmap_vma_range
>                                                    /* clean old vma */
>         /* lock vma_lock again  <--- UAF */
>     /* unlock vma_lock */
> 
> Since the vma_lock will unlock immediately after hugetlb_handle_userfault(),
> let's drop the unneeded lock and unlock in hugetlb_handle_userfault() to fix
> the issue.
> 
> [1] https://lore.kernel.org/linux-mm/000000000000d5e00a05e834962e@google.com/
> [2] https://lore.kernel.org/linux-mm/20220921014457.1668-1-liuzixian4@huawei.com/
> Reported-by: syzbot+193f9cee8638750b23cf@syzkaller.appspotmail.com
> Reported-by: Liu Zixian <liuzixian4@huawei.com>
> Fixes: 1a1aad8a9b7b ("userfaultfd: hugetlbfs: add userfaultfd hugetlb hook")
> CC: stable@vger.kernel.org # 4.14+

Patch is against mm-unstable, which isn't appropriate for a backport. 
Could you please something against current -linus (which will be more
backportable), then I'll figure out the fallout on mm-unstable.

Thanks.
