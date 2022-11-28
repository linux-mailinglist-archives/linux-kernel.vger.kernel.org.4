Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EDE63B2AF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiK1UBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiK1UBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:01:50 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EADC13D65
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:01:49 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a9so8125538pfr.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oC5AyQfQRGlt2k0oZ4me4gf06algNJkEEOfbxMNz+t4=;
        b=YOigQTHA5uW+XL7+GYQwyvkZBnQZcSWjbqeTaWiUiyFzHR9zA4j9R/646ePGYixsS9
         sgI1471Majo+HiG27TJLaUYe/McYFcNSTRvMl4RQqZx8ze0fefRfA8wPJWqZpLCoPTKd
         kMTkhNOtiFS/pekaCJGZsWDQHhz12YBLxTpq2jA7pNAAcrKPZaSg1eZmT0EmYB8iKDb/
         shU9V81Y4W8bzUKAIu2RXP81yevu3Bx+7XANdgHY5v85lwRIeKqOHJeYJqiJiuuuor+h
         J2IMxITgSXWx/eUTwiDyt/VE+ApD510OkblKi3zggYe8DIWjz0/HkqusZpYXDWqZHeUH
         bhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oC5AyQfQRGlt2k0oZ4me4gf06algNJkEEOfbxMNz+t4=;
        b=zzM3tEmN6zxkt9FHvwesx0ejYY4Wv8/GEJ5BghZp32ycNtDQzbeD5SyvhyIw3FAv51
         txaBDR4t0q296T16LIxFxFDH5hdMFDgGiLio+4NIx0DvBbyik+04ODdJPjZm3j/B2nAD
         8C7rIQS7XPXjHZCkO8nlupczmTCxMUISakPdERMQfTQwpZwkRbf/LwoQIM1FVeUw/qUN
         2ZxYqIND0UYh2Fan0nc8+2w28rsWZwXMrAOVCmMVRMMAxLiyGTHBHaKuVOkirnSB6gGY
         P3wBPtYFkn/2GjTe/ORnHoqocxktMRVsaACs6TcCfVmOv530tsGVcsYvg8gtTghDZuJv
         ryxg==
X-Gm-Message-State: ANoB5pn4t8xdQMTJe0QckfxsbBpfZFBw9kEp03Tt+Gq6mJmFNmjL3GcD
        Y7bZ7rzHa6501enVxsiLKOGwWr4hNufQs8JqY+E=
X-Google-Smtp-Source: AA0mqf6FKO6FEdYyc4d8fjeivC7APuhAXEksRBvmMv1C+KXB7APUuJM69FmLr4TKeUtLqFSQ9WgaxcCKepr/ymCfEh8=
X-Received: by 2002:a05:6a00:1696:b0:53e:6656:d829 with SMTP id
 k22-20020a056a00169600b0053e6656d829mr55909155pfc.63.1669665708577; Mon, 28
 Nov 2022 12:01:48 -0800 (PST)
MIME-Version: 1.0
References: <8a2f2644-71d0-05d7-49d8-878aafa99652@huawei.com>
In-Reply-To: <8a2f2644-71d0-05d7-49d8-878aafa99652@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 28 Nov 2022 12:01:37 -0800
Message-ID: <CAHbLzkr-eXk8gateN=EmMoBuW3wxoQKTCfJcTRQsQX3QxD+CmA@mail.gmail.com>
Subject: Re: [QUESTION] memcg page_counter seems broken in MADV_DONTNEED with
 THP enabled
To:     Yongqiang Liu <liuyongqiang13@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        aarcange@redhat.com, hughd@google.com, mgorman@suse.de,
        mhocko@suse.cz, cl@gentwo.org, n-horiguchi@ah.jp.nec.com,
        zokeefe@google.com, rientjes@google.com,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>,
        kirill.shutemov@linux.intel.com, Lu Jialin <lujialin4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 5:10 AM Yongqiang Liu <liuyongqiang13@huawei.com> wrote:
>
> Hi,
>
> We use mm_counter to how much a process physical memory used. Meanwhile,
> page_counter of a memcg is used to count how much a cgroup physical
> memory used.
> If a cgroup only contains a process, they looks almost the same. But with
> THP enabled, sometimes memory.usage_in_bytes in memcg may be twice or
> more than rss
> in proc/[pid]/smaps_rollup as follow:
>
> [root@localhost sda]# cat /sys/fs/cgroup/memory/test/memory.usage_in_bytes
> 1080930304
> [root@localhost sda]# cat /sys/fs/cgroup/memory/test/cgroup.procs
> 1290
> [root@localhost sda]# cat /proc/1290/smaps_rollup
> 55ba80600000-ffffffffff601000 ---p 00000000 00:00 0
> [rollup]
> Rss:              500648 kB
> Pss:              498337 kB
> Shared_Clean:       2732 kB
> Shared_Dirty:          0 kB
> Private_Clean:       364 kB
> Private_Dirty:    497552 kB
> Referenced:       500648 kB
> Anonymous:        492016 kB
> LazyFree:              0 kB
> AnonHugePages:    129024 kB
> ShmemPmdMapped:        0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> THPeligible:    0
>
> I have found the differences was because that __split_huge_pmd decrease
> the mm_counter but page_counter in memcg was not decreased with refcount
> of a head page is not zero. Here are the follows:
>
> do_madvise
>    madvise_dontneed_free
>      zap_page_range
>        unmap_single_vma
>          zap_pud_range
>            zap_pmd_range
>              __split_huge_pmd
>                __split_huge_pmd_locked
>                  __mod_lruvec_page_state
>              zap_pte_range
>                 add_mm_rss_vec
>                    add_mm_counter                    -> decrease the
> mm_counter
>        tlb_finish_mmu
>          arch_tlb_finish_mmu
>            tlb_flush_mmu_free
>              free_pages_and_swap_cache
>                release_pages
>                  folio_put_testzero(page)            -> not zero, skip
>                    continue;
>                  __folio_put_large
>                    free_transhuge_page
>                      free_compound_page
>                        mem_cgroup_uncharge
>                          page_counter_uncharge        -> decrease the
> page_counter
>
> node_page_stat which shows in meminfo was also decreased. the
> __split_huge_pmd
> seems free no physical memory unless the total THP was free.I am
> confused which
> one is the true physical memory used of a process.

This should be caused by the deferred split of THP. When MADV_DONTNEED
is called on the partial of the map, the huge PMD is split, but the
THP itself will not be split until the memory pressure is hit (global
or memcg limit). So the unmapped sub pages are actually not freed
until that point. So the mm counter is decreased due to the zapping
but the physical pages are not actually freed then uncharged from
memcg.

>
>
> Kind regards,
>
> Yongqiang Liu
>
>
