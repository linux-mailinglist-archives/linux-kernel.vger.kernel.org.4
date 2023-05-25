Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6797D7119F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 00:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241790AbjEYWGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 18:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjEYWGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 18:06:33 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6102A12F
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:06:32 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-561c1ae21e7so3785257b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685052391; x=1687644391;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UR4x6rXE0bo/ckqm6Jv4R6OAJNwweiidW4Yk75ZB+NQ=;
        b=ueglYvsjHws3Vja2dJ9Cy5bXiw8Uu5eCcGKzAUINwqqmZmuOVZ2tSeTbvZesbRYf5k
         LVuLldxIO5UaKvQPPHoCfrz+K1HmO1Q7e7lObTL7uAyZBcrrJBIFPfsebZEzoqlSF/NC
         uNW3Pw2Ws777qnPVwi1s1YRqXXBabl3XW/USHJBSzUo2BMhiUET3eZnBC+Tw6hhTMpvU
         9mwXS3U27RpbuNeA3YXCMRCzZnA5avZvcuFZk4xAQR+SUZgnpl0nvx+1bkB9f3Ag+QGc
         RlClPWHiz9eYf2lBVNbE6HX4hkTPTlwAvH3CPE47ekdt78pxKuEQ18kaQgjAUkc1BGz8
         0VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685052391; x=1687644391;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UR4x6rXE0bo/ckqm6Jv4R6OAJNwweiidW4Yk75ZB+NQ=;
        b=BhK2cz3ESuLIl8LsSFbDO8Xre8f66Zt4hLh2jqnnuRcd6Z/95pOrJcPQ5MXOtpIWNg
         2gyD4mTavPSNXsZueaIPLVK9VHuwBH5fIjg7eRfG0Ck1bh4I7nW79eq751Gk8c0I3RII
         TYu9pOlsO4Tvbm03za/Aj+2I/srZtB1KzkGUmur7NsOFTveElYYaiv0uJZOTy1nXn9OA
         YH9sMPu+1uonjgM6K4oxDs9HihgeVLLdn59TipcKvwDnSTBCmfGDI0FVKib5t484te8E
         jW/izi5mvhnjtO+EnuN9Vs1sfyIsfkGAVDCV5QxuLugP12uWZvqsOxwzpo3sxdZWkhyf
         QumA==
X-Gm-Message-State: AC+VfDzqKC2OgfDz5OzDD9coKJU7pFh0UEO0M7zApnD1T7Xmi4N3NRbz
        L2OmYGUdnqgWHE/NCgWxtVb7HQ==
X-Google-Smtp-Source: ACHHUZ5+gq3WKyM1RjGKDETUWUkkI2NTdK1hXriUldQCpOa1eAi5N8VOb1OaskV4/hm/b64oaD8bpA==
X-Received: by 2002:a81:9201:0:b0:561:baab:fd22 with SMTP id j1-20020a819201000000b00561baabfd22mr1046488ywg.3.1685052391294;
        Thu, 25 May 2023 15:06:31 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t20-20020a81c254000000b00561949f713fsm648660ywg.39.2023.05.25.15.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 15:06:30 -0700 (PDT)
Date:   Thu, 25 May 2023 15:06:27 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Peter Xu <peterx@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 15/31] mm/userfaultfd: allow pte_offset_map_lock() to
 fail
In-Reply-To: <ZG6TOyH7NJIgXxGX@x1n>
Message-ID: <8f2131ac-8996-e4b3-2aad-7a4d11bd538f@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <49d92b15-3442-4e84-39bd-c77c316bf844@google.com> <ZG6TOyH7NJIgXxGX@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023, Peter Xu wrote:
> On Sun, May 21, 2023 at 10:07:35PM -0700, Hugh Dickins wrote:
> > mfill_atomic_install_pte() and mfill_atomic_pte_zeropage() treat
> > failed pte_offset_map_lock() as -EFAULT, with no attempt to retry.
> 
> Could you help explain why it should be -EFAULT, not -EAGAIN or -EEXIST?

Thanks a lot for looking, Peter.

No good justification for -EFAULT: I just grabbed the closest, fairly
neutral, error code that I could see already being in use there: but now
that you mention -EAGAIN, which I can see being used from mfill_atomic(),
yes, that would be ideal - and consistent with how it's already being used.

I'll make that change, thanks for suggesting.  (And it had bugged me how
my fs/userfaultfd.c was electing to retry, but this one electing to fail.)

> 
> IIUC right now if pte existed we have -EEXIST returned as part of the
> userfault ABI, no matter whether it's pte or thp.

It might or might not correspond to -EEXIST - it might even end up as
-EFAULT on a retry after -EAGAIN: I see mfill_atomic() contains both
-EEXIST and -EFAULT cases for pmd_trans_huge().  Actually, I could
say that the -EFAULT case there corresponds to the -EFAULT in this
15/31 patch, but that would be by coincidence not design: I'm happier
with your -EAGAIN suggestion.

> 
> IMHO it may boil down to my limited knowledge on how pte_offset_map_lock()
> is used after this part 2 series, and I assume the core changes will be in
> your 3rd series (besides this one and the arch one).
> 
> Please shed some light if there's quick answers (IIUC this is for speeding
> up collapsing shmem thps, but still no much clue here), or I can also wait
> for reading the 3rd part if it'll come soon in any form.

It wouldn't be particularly easy to deduce from the third series of
patches, rather submerged in implementation details.  Just keep in mind
that, like in the "old" pmd_trans_unstable() cases, there may be instants
at which, when trying to get the lock on a page table, that page table
might already have gone, or been replaced by something else e.g. a THP,
and a retry necessary at the outer level (if it's important to persist).

Hugh
