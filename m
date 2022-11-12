Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70544626B41
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 20:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiKLThS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 14:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLThQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 14:37:16 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8888A9FC3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 11:37:15 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 6so6974485pgm.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 11:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ae3zsNTUGJCSO95ziRPGHoXWUiriLhIsXToU81lFzec=;
        b=AKbzuKalV3IzX2rlsXBtV2YfOD/Zq9vUY6C0ty/N0dZLheQXK6aBNGDkG8s9yu8br4
         8KRlLV8b6dpwfYJcse1QORVqYRGXLs2ku8Xyfd3l5J9G3pudZkrKvOpfZnLVPM/yUjkP
         +J8WdiSi3+pW2nFkRdWwegQY1BO+t4uVrscNzcR+A+J4sgFtnIrhQTmxqW59ucuA/zUm
         xoBpIFaAv2W2Yt4ca8LzoV9TZLnIX5nPWCSXGBqZzVxHbgLyNtys2oB+P4/VZFZqWXK8
         9rHs/3DcAf2fqiqTFbbnU4Z/UqnWX9yZN8+fw+YUVdCOZhKHDeMI//3HXqpBbNnEJ4Z+
         h6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ae3zsNTUGJCSO95ziRPGHoXWUiriLhIsXToU81lFzec=;
        b=IM55+HCMxMYHWSDfan3cmiA1Zsd2u7OnShJbg3ThOdy0U9TNu7jj9MBOofth8IfsPK
         b9avpzDgspC1SH1dq5mrVTCj2GAP012v8/F++Ay4SZyLihLvA6cNvvFiYYspw3LknrKg
         ZjPljM3E+vd3Bv5bPYlWBpuXFVgrNF8nbjJ9WE6o3u0nQIY+tZkKIQ3iPSWeJRmFh88r
         j19AT030SksyCJcF1uk6iEIVUUjRJatQ/eEB1zLLiZn7rFX/VqQmFCOx3Znui/faJcYd
         ZQxeDF5TZaJREvfBsY5s68mGCVNiSuxoYiAPSyvLh4Y2J5WgdqZxHfIyG9xqwMcMWtIv
         hI6g==
X-Gm-Message-State: ANoB5pnRU6UhlUtgItyQUKmRrXmV+HvD1mgAJatxYl/KHJhYXRkPDFHs
        YcaFRk0hdwmEutBeQwh14Wk=
X-Google-Smtp-Source: AA0mqf49agb8/jSJ2tSsNf/2WFj/LzlSgMWbaBmjVj8g5Nfo1PoD3jy+j5u+8yeTR5HF05NPHVQBAg==
X-Received: by 2002:a05:6a00:3011:b0:563:5e0a:97e8 with SMTP id ay17-20020a056a00301100b005635e0a97e8mr7856945pfb.75.1668281834694;
        Sat, 12 Nov 2022 11:37:14 -0800 (PST)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id g22-20020a63e616000000b0047679467c78sm141177pgh.57.2022.11.12.11.37.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Nov 2022 11:37:14 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v9 0/3] fix hugetlb MADV_DONTNEED vma_lock handling
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20221111232628.290160-1-mike.kravetz@oracle.com>
Date:   Sat, 12 Nov 2022 11:37:12 -0800
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <78B2DE9B-C9D5-4E3F-8328-427590C5A610@gmail.com>
References: <20221111232628.290160-1-mike.kravetz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 11, 2022, at 3:26 PM, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:

> This series addresses the issue first reported in [1], and fully
> described in patch 3.  While exploring solutions to this issue,
> related problems with mmu notification calls were discovered.  The
> first two patches address those issues.
>=20
> Previous discussions suggested further cleanup by removing the
> routine zap_page_range.  This is possible because =
zap_page_range_single
> is now exported, and all callers of zap_page_range pass ranges =
entirely
> within a single vma.  This work will be done in a later patch so as =
not
> to distract from this bug fix.
>=20
> [1] =
https://lore.kernel.org/lkml/CAO4mrfdLMXsao9RF4fUE8-Wfde8xmjsKrTNMNC9wjUb6=
JudD0g@mail.gmail.com/
>=20
> Mike Kravetz (3):
>  madvise: use zap_page_range_single for madvise dontneed
>  hugetlb: remove duplicate mmu notifications
>  hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing
>=20
> include/linux/mm.h | 29 +++++++++++++++++++++--------
> mm/hugetlb.c       | 45 +++++++++++++++++++++++++--------------------
> mm/madvise.c       |  6 +++---
> mm/memory.c        | 25 ++++++++++++-------------
> 4 files changed, 61 insertions(+), 44 deletions(-)

With my limited knowledge of hugetlbfs, it all looks good.

Having said that - 2 random thoughts:

1. It is more intuitive to me to have
mmu_notifier_invalidate_range_{start|end}() next to =
tlb_{start|end}_vma().
I think that one day these two should have been combined into a
single function, which could have also executed
adjust_range_if_pmd_sharing_possible() as needed.

2. If you still have a concern of exposing zap_details as you had in the
past (not that I care), consider putting zap_details and
zap_page_range_single() in mm/internal.h.

Thanks,
Nadav=
