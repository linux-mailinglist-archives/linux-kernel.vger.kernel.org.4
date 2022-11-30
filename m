Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A6F63D260
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbiK3Jrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiK3JrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:47:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F0F1F2C9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669801588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+cu3xgYjWpmSRgV5LPKpXBlA+9KOBxrwF+YKe+TNV4A=;
        b=ChzwCLDFOg1YL5wFxIYpNzm0K9FB82NodlCPBY5nathcR9iezhxTxJvNneQxKUxynb04Og
        D8GGjBQ8mBCOytem/9WfTEfJIv9wNjC8Rl+pYSQMlm6kriFAV0ayVgdNBwmenxRKDs1QdJ
        UlXeM6KE4pH7pdUmzfyzBUoH1wO5hZg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-369-3q2Qc-a3Pli1Ev793QiebQ-1; Wed, 30 Nov 2022 04:46:27 -0500
X-MC-Unique: 3q2Qc-a3Pli1Ev793QiebQ-1
Received: by mail-wr1-f71.google.com with SMTP id s1-20020adfa281000000b00241f7467851so3413187wra.17
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cu3xgYjWpmSRgV5LPKpXBlA+9KOBxrwF+YKe+TNV4A=;
        b=wTCdrJwwRz3LNAKUi1sV62WWB5NgPgh3HyfV1aAF2KY3z92wZYW5j9jvJBjKiqlN+L
         yBDKrYyp2+/Fje8015jWoiVcWtakSmE59KhD/UV+N2efJ0e6TztW9Lyw1PsGKl4AIRU1
         Eg/9iP6Xb2I4pExdAvPvRoB0OjBKBj6FYbaZQcHnn5Sq2IYBnSPFq3xlx5v2xAL5WqU9
         4vIsPQ0F6RcmQ1c0Agx+ME1V9bsvSQeWLR/B/CZgsyl/Uo1oHiB9pIYu2biLlbYBtPeW
         ypJyOqKxHTfT7C64K5jt7BqxL8i/ZsBIndGLMHWn0DSodPWPft3MhwJuktxLkSd+uFpF
         0eOw==
X-Gm-Message-State: ANoB5pm9wRRidanzM2KY+CRkdjK3IAz60awOWME74bNG5jKUn8yRZzOw
        l4BT8VxAFap39D/8Adzmb04RUMoHW94ah7c6bTnXk5hA8hOlJTgExne32LOJij3/ctaHdzRmi1b
        p+yvLaXqHPia3WrThON35Mfup
X-Received: by 2002:a1c:790a:0:b0:3cf:e137:b31d with SMTP id l10-20020a1c790a000000b003cfe137b31dmr34366005wme.205.1669801586022;
        Wed, 30 Nov 2022 01:46:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4QTMF/mFsiU9u2cnVmMEzm+1p117TtofaUUL5J0DSwov5KZjImZGryPwEjNH19L8Bts0fcaQ==
X-Received: by 2002:a1c:790a:0:b0:3cf:e137:b31d with SMTP id l10-20020a1c790a000000b003cfe137b31dmr34365977wme.205.1669801585633;
        Wed, 30 Nov 2022 01:46:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:7600:a8ea:29ce:7ee3:dd41? (p200300cbc7037600a8ea29ce7ee3dd41.dip0.t-ipconnect.de. [2003:cb:c703:7600:a8ea:29ce:7ee3:dd41])
        by smtp.gmail.com with ESMTPSA id n29-20020a05600c3b9d00b003c21ba7d7d6sm1441159wms.44.2022.11.30.01.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 01:46:25 -0800 (PST)
Message-ID: <1eff312b-1aca-6afb-3587-f65e698b3f8c@redhat.com>
Date:   Wed, 30 Nov 2022 10:46:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 00/10] mm/hugetlb: Make huge_pte_offset() thread-safe for
 pmd unshare
In-Reply-To: <20221129193526.3588187-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.22 20:35, Peter Xu wrote:
> Based on latest mm-unstable (9ed079378408).
> 
> This can be seen as a follow-up series to Mike's recent hugetlb vma lock
> series for pmd unsharing, but majorly covering safe use of huge_pte_offset.
> 
> Comparing to previous rfcv2, the major change is I dropped the new pgtable
> lock but only use vma lock for locking.  The major reason is I overlooked
> that the pgtable lock was not protected by RCU: __pmd_free_tlb() frees the
> pgtable lock before e.g. call_rcu() for RCU_TABLE_FREE archs.  OTOH many of
> the huge_pte_offset() call sites do need to take pgtable lock.  It means
> the valid users for the new RCU lock will be very limited.

Thanks.

> 
> It's possible that in the future we can rework the pgtable free to only
> free the pgtable lock after RCU grace period (move pgtable_pmd_page_dtor()
> to be within tlb_remove_table_rcu()), then the RCU lock will make more
> sense.  For now, make it simple by fixing the races first.

Good.

> 
> Since this version attached a reproducer (below) and also removed the RCU
> (especially, the fallback irqoff) solution, removing RFC tag.

Very nice, thanks.

> 
> Old versions:
> 
> rfcv1:  https://lore.kernel.org/r/20221030212929.335473-1-peterx@redhat.com
> rfcv2:  https://lore.kernel.org/r/20221118011025.2178986-1-peterx@redhat.com
> 
> Problem
> =======
> 
> huge_pte_offset() is a major helper used by hugetlb code paths to walk a
> hugetlb pgtable.  It's used mostly everywhere since that's needed even
> before taking the pgtable lock.
> 
> huge_pte_offset() is always called with mmap lock held with either read or
> write.  It was assumed to be safe but it's actually not.  One race
> condition can easily trigger by: (1) firstly trigger pmd share on a memory
> range, (2) do huge_pte_offset() on the range, then at the meantime, (3)
> another thread unshare the pmd range, and the pgtable page is prone to lost
> if the other shared process wants to free it completely (by either munmap
> or exit mm).

So just that I understand correctly:

Two processes, #A and #B, share a page table. Process #A runs two 
threads, #A1 and #A2.

#A1 walks that shared page table (using huge_pte_offset()), for example, 
to resolve a page fault. Concurrently, #A2 triggers unsharing of that 
page table (replacing it by a private page table), for example, using 
munmap().

So #A1 will eventually read/write the shared page table while we're 
placing a private page table. Which would be fine (assuming no unsharing 
would be required by #A1), however, if #B also concurrently drops the 
reference to the shared page table (), the shared page table could 
essentially get freed while #A1 is still walking it.

I suspect, looking at the reproducer, that the page table deconstructor 
was called. Will the page table also actually get freed already? IOW, 
could #A1 be reading/writing a freed page?


> 
> The recent work from Mike on vma lock can resolve most of this already.
> It's achieved by forbidden pmd unsharing during the lock being taken, so no
> further risk of the pgtable page being freed.  It means if we can take the
> vma lock around all huge_pte_offset() callers it'll be safe.

Agreed.

> 
> There're already a bunch of them that we did as per the latest mm-unstable,
> but also quite a few others that we didn't for various reasons especially
> on huge_pte_offset() usage.
> 
> One more thing to mention is that besides the vma lock, i_mmap_rwsem can
> also be used to protect the pgtable page (along with its pgtable lock) from
> being freed from under us.  IOW, huge_pte_offset() callers need to either
> hold the vma lock or i_mmap_rwsem to safely walk the pgtables.
> 
> A reproducer of such problem, based on hugetlb GUP (NOTE: since the race is
> very hard to trigger, one needs to apply another kernel delay patch too,
> see below):

Thanks,

David / dhildenb

