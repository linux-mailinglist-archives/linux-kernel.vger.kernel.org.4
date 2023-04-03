Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C956F6D4648
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjDCN4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDCNz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:55:59 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7F8DF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:55:57 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bx10so12110248ljb.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680530155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/5Zx2eZQePqnyU3jO2bDpJxc2Hq5psZfequ5YzrYbHY=;
        b=RSURZppHyMHfLXYJ6cYrt3X4//roop14nutqpZ39uquOsLcXxvXqdBcpklyZtcDDvQ
         o0tkT3Vixuiy1rWcQD2Rp2cOlp3rpDjfIcVgFp8RR8N/Mw5X0QkzgXV/QScmcpX9lhMO
         7+DD0cC7giFYmGphfYV4r49q2zer4yj9kIfylLe7iDXdyyCQibiph9Ml39aGgdVbSQU+
         dR2aZn4re1Nyq/opJCqjCk1mWcE9M/fSt+ajjqm9i0MjGZFJKyD9aA3ixtk/D9oLhcps
         y2hQO7YzJ0RQnuSI6nWfbbZkHjMMp1VG+knz146+pTABVf0QlN5esfWoIhVNsv+Ik0lB
         J/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680530155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5Zx2eZQePqnyU3jO2bDpJxc2Hq5psZfequ5YzrYbHY=;
        b=EIEB+UPQuJeXJ2UUbUqtkZQ3xrFI2nQO0QE4YkhYue2+GpgtPA6Uq1V4UPNI/kIIAT
         dH3q+4ifxI5pR5PFgJBPejzppu+4eminz6LcTJYP257TkqoaRKZVmJnNcB/wAK2N/uag
         KAsRjox+txCPqZH9qVy29dDDcde2suNURQuUG7WGQ67KV4So0NYNPKwuOoh3AUdIbFhU
         TLpFrRhOTrvBSIGRWuoBr6snBzPz5mUCgZ3oj/plBoL0cBuwdVhzYei0nRY5slnD1Pjv
         l1w88INUwb2hheZFTcsGJZTHxC+CuQUUwkh50wiJoUzXUa7yre0oAGTc4jlDT7zi+R/L
         vbNA==
X-Gm-Message-State: AAQBX9cMsgnQiaURpYzvcVZ0UtmVYyKpAE18cthI4HYKdC3V0mlLpJzj
        fqy52tegvpmAM8FhVE6Q9f0qd3w/NxNaeuBhUxzsUg==
X-Google-Smtp-Source: AKy350b6GzK2LPgpejAVC48Na07/2rfnj818m0hmVue412JxJo4CZzRvP2f1ux3gKtirZZ0ofaAfNUfNSUT1R0KMxBU=
X-Received: by 2002:a2e:7004:0:b0:299:c8c4:c9f1 with SMTP id
 l4-20020a2e7004000000b00299c8c4c9f1mr10719258ljc.8.1680530154972; Mon, 03 Apr
 2023 06:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230403111020.3136-1-kirill.shutemov@linux.intel.com> <20230403111020.3136-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230403111020.3136-2-kirill.shutemov@linux.intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 3 Apr 2023 15:55:43 +0200
Message-ID: <CACT4Y+b=+DOuL2tR_q2F608xXms-MwWLBsz_+PtVojvQj98rcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/mm/iommu/sva: Fix error code for LAM enabling
 failure due to SVA
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 at 13:10, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Normally, LAM and SVA are mutually exclusive. LAM enabling will fail if
> SVA is already in use.
>
> Correct error code for the failure. EINTR is nonsensical there.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 23e5d9ec2bab ("x86/mm/iommu/sva: Make LAM and SVA mutually exclusive")
> Reported-by: Dmitry Vyukov <dvyukov@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  arch/x86/kernel/process_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 74c7e84a94d8..c7dfd727c9ec 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -760,7 +760,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
>
>         if (mm_valid_pasid(mm) &&
>             !test_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &mm->context.flags))
> -               return -EINTR;
> +               return -EINVAL;
>
>         if (mmap_write_lock_killable(mm))
>                 return -EINTR;
> --
> 2.39.2
>
