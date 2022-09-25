Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C955E9569
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 20:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiIYS2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 14:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiIYS2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 14:28:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056C9275CC
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 11:28:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9567B60A55
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 18:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6335C433D6;
        Sun, 25 Sep 2022 18:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1664130509;
        bh=EHSLcpBjg2pvaVSJ2FIO8Y8QlTy9gtQvI4Xe/G8rgBc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ppeR53xd3o2yKoI+pE+IT7S1enVQJA3+gwm4sw683pxEW1jqdUEwSQ2QjmmidyPlQ
         hv/jumPN0eDDupb+er4aYbQiD2xHI2/DvKpTQZje8qZIzgeFjBEFoZ7d6xdeHycyo6
         slltRKu7mnMIdeSW0GI8t8/irdtooxdOCUQfZ6ig=
Date:   Sun, 25 Sep 2022 11:28:26 -0700
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
Subject: Re: [PATCH v4] mm: hugetlb: fix UAF in hugetlb_handle_userfault
Message-Id: <20220925112826.c3efd2cf438d1bb6329f78ed@linux-foundation.org>
In-Reply-To: <20220924034905.2694686-1-liushixin2@huawei.com>
References: <20220924034905.2694686-1-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022 11:49:05 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

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

Thanks.  Turns out that porting all the pending material on top of this
change was not a confidence-inspiring activity.  So I ended up merging
your v3.  Please work with Greg on the backporting when he gets on to
it?  Hopefully that will merely involve sending him this v4.

