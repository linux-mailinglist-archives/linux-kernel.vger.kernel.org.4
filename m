Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499BA70EB02
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 03:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbjEXBtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 21:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbjEXBta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 21:49:30 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F4F185
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:49:27 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba8253f635cso661606276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684892967; x=1687484967;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qRR20WPPG9GQ+bWld5KX4B7EuAV7QhoHIJ5BRRfzj5g=;
        b=fL1Ko/YzJ7ADR+5IhbndnTRBOzBniMKv2InrhlDBTKJ8NlYVC/WzojNZzRdjG8LqqI
         8LB9Z4sfpXm4DMnyfRFicnIehOON6Mw+FClbq6xhPa9tlrIuXm3Q/2idrYMx02+afzOp
         1VCSHU1xv+O9cTuzhmlxGQq1v0D4TgBrAS9dYOJLgo+SzeMAZ7rQLDPNPL9H5vsD1p44
         JTB4zFm6Ty/2t/Mm5CpAGXHuXSex52HKZD5bYmtrIhNvgrtjqZinsu17ACzjltY7KKk5
         TNaE7Q4HSc79RkqKOj+NGXTgrLKTP+KzqHxsfw06sf9yCgMnslxI0DnH5G6oL7bKwZgq
         fWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684892967; x=1687484967;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRR20WPPG9GQ+bWld5KX4B7EuAV7QhoHIJ5BRRfzj5g=;
        b=j6QAYumoGYzcbpoQfiVjYKLFA67jb+AU6boI71OVja0hddFPipcqrUxHb8tZBNc3Fj
         /3iv6taLyOvWlu00x2RluCKLN06BzfWmCdBE3sryhesZ8z9s3wK3XcVCYjWHBQkM0Vcm
         9/2yAwI6go+1I8VpuKgqFh3vR/CB0hUKhXzWcutpV/3HPM27AMPIR/ikzth1P0WfLAzp
         7UAGPc0bQn9ghvO7ITb+Rq+ME1bkvsEbfx4Khqk8W1EbBsqm1cCeEoZXv3tQsK+9IY39
         XYclwOPT3IwE5/q78O74fUdE3kRUlS8kpcu/l3BwY40vD3uzNz+b2Y2OSHfz2SxPUO6b
         cKZQ==
X-Gm-Message-State: AC+VfDxA/CQ9P6WtLrbdWOcTlGGcfJqKDPUw0FCDCsf+hX/uOyxlNmV/
        q7ZUZlRP7ESJ3VTGaNVRrpKgIA==
X-Google-Smtp-Source: ACHHUZ7f0TOZQo7Cw+o/qEVNq4B1zvZdBbLM5VJM6QqwwtZu4t36Vxp5CkGSHrwBFYCBff4rw2Ddpw==
X-Received: by 2002:a25:385:0:b0:ba8:54c4:3136 with SMTP id 127-20020a250385000000b00ba854c43136mr19398918ybd.52.1684892966804;
        Tue, 23 May 2023 18:49:26 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x7-20020a259a07000000b00b8f6ec5a955sm2395274ybn.49.2023.05.23.18.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 18:49:26 -0700 (PDT)
Date:   Tue, 23 May 2023 18:49:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 15/23] s390: allow pte_offset_map_lock() to fail
In-Reply-To: <20230523140056.55b664b1@p-imbrenda>
Message-ID: <b64cd153-18e8-81a6-b852-c04d8b1381d@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com> <94aec8fe-383f-892-dcbf-d4c14e460a7@google.com> <20230517123546.672fb9b0@p-imbrenda> <4a15dbaa-1614-ce-ce1f-f73959cef895@google.com> <20230523140056.55b664b1@p-imbrenda>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023, Claudio Imbrenda wrote:
> 
> so if I understand the above correctly, pte_offset_map_lock will only
> fail if the whole page table has disappeared, and in that case, it will
> never reappear with zero pages, therefore we can safely skip (in that
> case just break). if we were to do a continue instead of a break, we
> would most likely fail again anyway.

Yes, that's the most likely; and you hold mmap_write_lock() there,
and VM_NOHUGEPAGE on all vmas, so I think it's the only foreseeable
possibility.

> 
> in that case I would still like a small change in your patch: please
> write a short (2~3 lines max) comment about why it's ok to do things
> that way

Sure.

But I now see that I've disobeyed you, and gone to 4 lines (but in the
comment above the function, so as not to distract from the code itself):
is this good wording to you?  I needed to research how they were stopped
from coming in afterwards, so wanted to put something greppable in there.

And, unless I'm misunderstanding, that "after THP was enabled" was
always supposed to say "after THP was disabled" (because splitting a
huge zero page pmd inserts a a page table full of little zero ptes).

Or would you prefer the comment in the commit message instead,
or down just above the pte_offset_map_lock() line?

It would much better if I could find one place at the mm end, to
enforce its end of the contract; but cannot think how to do that.

Hugh

--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2537,7 +2537,12 @@ static inline void thp_split_mm(struct mm_struct *mm)
  * Remove all empty zero pages from the mapping for lazy refaulting
  * - This must be called after mm->context.has_pgste is set, to avoid
  *   future creation of zero pages
- * - This must be called after THP was enabled
+ * - This must be called after THP was disabled.
+ *
+ * mm contracts with s390, that even if mm were to remove a page table,
+ * racing with the loop below and so causing pte_offset_map_lock() to fail,
+ * it will never insert a page table containing empty zero pages once
+ * mm_forbids_zeropage(mm) i.e. mm->context.has_pgste is set.
  */
 static int __zap_zero_pages(pmd_t *pmd, unsigned long start,
 			   unsigned long end, struct mm_walk *walk)
