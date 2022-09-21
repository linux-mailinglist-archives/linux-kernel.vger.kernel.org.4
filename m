Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024BF5E5394
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 21:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiIUTH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 15:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIUTHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:07:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA29956B1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 12:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EAA8B8291B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 19:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35A7C433D6;
        Wed, 21 Sep 2022 19:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663787270;
        bh=+dgwWgBjf4EjDuSy+NuN+4D3f+4fqKols2uXvgLzp6c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V9H7X499TAXk/psu574CoKuDuntHqiL08cIeLbaPTllmR3s8O2e9BD27lDC5dRDLp
         /Y4iAAewaV8hNRthPmI/09W+J7i5e4wKEwUObW8zaC4xZ6Btnf3u2Y2u858dUHqcUx
         XuSed0ogH8lPrMywzTT6KpAAhwTlxlXW/Zu1KvaQ=
Date:   Wed, 21 Sep 2022 12:07:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Liu Zixian <liuzixian4@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] mm: hugetlb: fix UAF in hugetlb_handle_userfault
Message-Id: <20220921120748.79f3255fa0a06b182576f497@linux-foundation.org>
In-Reply-To: <20220921083440.1267903-1-liushixin2@huawei.com>
References: <20220921083440.1267903-1-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 16:34:40 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> The vma_lock and hugetlb_fault_mutex are dropped before handling
> userfault and reacquire them again after handle_userfault(), but
> reacquire the vma_lock could lead to UAF[1] due to the following
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
> @@ -5508,17 +5507,12 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
>  
>  	/*
>  	 * vma_lock and hugetlb_fault_mutex must be
> -	 * dropped before handling userfault.  Reacquire
> -	 * after handling fault to make calling code simpler.
> +	 * dropped before handling userfault.
>  	 */
>  	hugetlb_vma_unlock_read(vma);
>  	hash = hugetlb_fault_mutex_hash(mapping, idx);
>  	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> -	ret = handle_userfault(&vmf, reason);
> -	mutex_lock(&hugetlb_fault_mutex_table[hash]);
> -	hugetlb_vma_lock_read(vma);
> -
> -	return ret;
> +	return handle_userfault(&vmf, reason);
>  }

Current code is rather different from this.  So if the bug still exists
in current code, please verify this and redo the patch appropriately?

And hang on to this version to help with the -stable backporting.

Thanks.
