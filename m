Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5080063CEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 06:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiK3FST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 00:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiK3FSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 00:18:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD36E69ABE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 21:18:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D6B52CE17EC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 05:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B40C433D6;
        Wed, 30 Nov 2022 05:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669785491;
        bh=LthRoD/zLPG9U+Zco97eCEddMkCmFyhLksJ09r5LxBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qf+88bujVlsGtbJhGEKuyTN8cI+YiRVYOwBRf5XX7L4QvEQfQk5nzyrlNxn93NpaM
         DMmkNdtS8RU5BeWhKxovjrCPXAO7uUU+RO/1qQwxohR63Bah0gB4RJ9cWIrjwcc+mZ
         +HCX7PR0eyAeOPE5IbSoGDgoy2rDOWFtoWJ7PePTgJpzGK8tfELHAMKkX1ktQrZr4z
         zIIF74BGt0CE49UGDWwAEJUXotUuw53TTmuM6nyZxyZuuhkyJBhEQNFHhB3sTeBNKW
         1teCDxRTdLRj61Z6GTWKPDSj5C5FeS/K/A71B2Mibc29dCg66RjBN4t23WbbqqvZym
         7+27oIX/FjJdg==
Date:   Tue, 29 Nov 2022 21:18:08 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 10/10] mm/hugetlb: Introduce hugetlb_walk()
Message-ID: <Y4bnkO3ikp5bu44x@sol.localdomain>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-11-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129193526.3588187-11-peterx@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 02:35:26PM -0500, Peter Xu wrote:
> +static inline pte_t *
> +hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
> +{
> +#if defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
> +	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
> +
> +	/*
> +	 * If pmd sharing possible, locking needed to safely walk the
> +	 * hugetlb pgtables.  More information can be found at the comment
> +	 * above huge_pte_offset() in the same file.
> +	 *
> +	 * NOTE: lockdep_is_held() is only defined with CONFIG_LOCKDEP.
> +	 */
> +	if (__vma_shareable_flags_pmd(vma))
> +		WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
> +			     !lockdep_is_held(
> +				 &vma->vm_file->f_mapping->i_mmap_rwsem));
> +#endif

FYI, in next-20221130 there is a compile error here due to this commit:

    In file included from security/commoncap.c:19:
    ./include/linux/hugetlb.h:1262:42: error: incomplete definition of type 'struct hugetlb_vma_lock'
                    WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
                                                   ~~~~~~~~^
    ./include/linux/lockdep.h:286:47: note: expanded from macro 'lockdep_is_held'
    #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
                                                           ^~~~

- Eric
