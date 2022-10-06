Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B58C5F6A7E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiJFPYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiJFPYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:24:40 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2776E77
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:24:35 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id i134so1520884ioa.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 08:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1a+psg2nqIZL7bAZ6z1cIQFIUH3jE8LmypWSBzkS2oo=;
        b=rSXh1u7hwhORzZwyDce9LUkOzigRIDR41Au4fcmTpZ2GI2gKKIJvrJ/i0/ClQ/LSub
         e0HTQ+YSb3fdIXmE140lznkj3350+Jxd7RiGKzq2riUNJK3zR595y/bYaKns/XnO1d6I
         Ty6f3XcarE4fwy+tDx9srBv0EhzGaB0FDSz/iYxhk+kxiQtnpwBqb1rXOoASXrYcv2L9
         PrJRODlq08hZ7j34hBhEMdAmZDnPqJURVbx3C6iPpMZOlGUmNhw/4pXbI4sV6InCoW3A
         RxCH3NBUXeO9kZkP+LkJDaDb2Z7z1NiGV+Uuw7Jz925LRjMeZP87mclo8m8A6EGtKrUc
         x8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1a+psg2nqIZL7bAZ6z1cIQFIUH3jE8LmypWSBzkS2oo=;
        b=oYLByxwNkrrvBCtPKXFivf0YP1DLf9nXUc9crfSBoPu3h32XHMI8OwNDP6zOhjUOln
         huQYDJamxQiu42wuqimVWAe/Q9r0dZYPmeCiw2NiiYKUExZRTN7kBLace4eJS3jC1172
         9GMUOq0MJ5nPtQIDL6eqJelQciaaKIxrxNRmBb2JDN//nQ3MKKdOJDaCbDXk7lUvjYja
         zLbVRwqFy4rOc4+AgmRB8SM1RrU1gzONp77N3DfKTBp314DJSX8LBFv3nd+FiQZw1FIn
         IJCSpoGofJm4dwqDCrH/p7mdIyr29jVLLNRza/L1lyYhWfk1hhHy3vFabLXsNgB/mUwg
         uoTg==
X-Gm-Message-State: ACrzQf2usfAw0EwT8kU4gGJsPyG+ClkDI83+yeihYA9IDUC2Mpz9pztt
        Ejbe0Mm7/tKlQOvYmOkw+V2mUTAQ16HbxqcFTNNPyA==
X-Google-Smtp-Source: AMsMyM4vahoSfRZE5lpPET3RLGsrNUFdrN5iUP1gQqWxcLez6lwgoo+5s1Ej6C5tpjbEy+hQr6LmPZK1lGSy426yfB8=
X-Received: by 2002:a6b:5d07:0:b0:6bb:7253:a439 with SMTP id
 r7-20020a6b5d07000000b006bb7253a439mr164573iob.2.1665069875206; Thu, 06 Oct
 2022 08:24:35 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Thu, 6 Oct 2022 17:23:59 +0200
Message-ID: <CAG48ez3h-mnp9ZFC10v+-BW_8NQvxbwBsMYJFP8JX31o0B17Pg@mail.gmail.com>
Subject: ptep_get_lockless() on 32-bit x86/mips/sh looks wrong
To:     Linux-MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptep_get_lockless() does the following under CONFIG_GUP_GET_PTE_LOW_HIGH:

pte_t pte;
do {
  pte.pte_low = ptep->pte_low;
  smp_rmb();
  pte.pte_high = ptep->pte_high;
  smp_rmb();
} while (unlikely(pte.pte_low != ptep->pte_low));

It has a comment above it that argues that this is correct because:
1. A present PTE can't become non-present and then become a present
PTE pointing to another page without a TLB flush in between.
2. TLB flushes involve IPIs.

As far as I can tell, in particular on x86, _both_ of those
assumptions are false; perhaps on mips and sh only one of them is?

Number 2 is straightforward: X86 can run under hypervisors, and when
it runs under hypervisors, the MMU paravirtualization code (including
the KVM version) can implement remote TLB flushes without IPIs.

Number 1 is gnarlier, because breaking that assumption implies that
there can be a situation where different threads see different memory
at the same virtual address because their TLBs are incoherent. But as
far as I know, it can happen when MADV_DONTNEED races with an
anonymous page fault, because zap_pte_range() does not always flush
stale TLB entries before dropping the page table lock. I think that's
probably fine, since it's a "garbage in, garbage out" kind of
situation - but if a concurrent GUP-fast can then theoretically end up
returning a completely unrelated page, that's bad.


Sadly, mips and sh don't define arch_cmpxchg_double(), so we can't
just change ptep_get_lockless() to use arch_cmpxchg_double() and be
done with it...
