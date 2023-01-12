Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8B466683D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 02:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbjALBGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 20:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjALBGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 20:06:36 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838305F88
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:06:34 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q9so11746123pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/EuDV1NUKfsL4GEXfqEv23SAelvBXb3ssMRhZva4bUQ=;
        b=phQ25BvAFBeuQtOnMo8GA7sj/hVjEu8xpCWDWKmFFqeBQM8Xh4dJoGrq5+uKBCWCJO
         BPi2JeNAdu2C6jvyR+5J482j9kU07ya8TyJ39H3HKLYGOKQN91hRSBH6Z/ze/uxQSDu8
         r9NufpcOhux4lXG9cMwgnT4dvxJaQ4q/IuNLB2F0b8j6ETQSHeItrrw8D0YL1rBWAIsM
         NuTTTom8ZzIPz+bT/Oqqn6to8PXgheDNNjs3N4UEce5j6Mg0dYjjB40ux0QC7nBLT6mk
         RgEIXpi4JOb0k+EeOc5m+kiD7uzydsibHlY41kNerbJKYOvPFBH2kiGNSUpUtxpIj9Ve
         Sg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EuDV1NUKfsL4GEXfqEv23SAelvBXb3ssMRhZva4bUQ=;
        b=MV1Jy/+hCzkm3A9q4O8clEpyIli6H9qlCc+ZtNG/49U7uwSdMzbRc/X7bOD89mbW57
         FQnpJRYGXG9veBz7mgFxB64t3tFc3+aKKM5oAM6cTsW+Z+bec8wm/h6TIQuRVZLmo+wE
         wPwDeq+YmcYVDRhShYIQtYMR/JyUKilKoHxvuahOGdiwxvcgiQH2pIFiiTs1SXqTKDJ2
         s3PWIjVNg86b8bq+yX2/MN0ImSFUD4wCBoD0p4f3k2NQZqryFIoUQSIf56g9i7fZ23/0
         eaRyFR5b8ZQnN3Hh8Y9krABRQyNzQgf6/QrstRCUvCRDyJaMUGMasIItaPaz+dutBvhX
         iA9g==
X-Gm-Message-State: AFqh2kpbck2x5n3r6MzbRR4hvLA+RLp0gpDDEPvU6Vn1IivypnmM8xdU
        m0Tnut1hRKK8nzPvtidojkKskkv4t9XYLDJycXpkThVj
X-Google-Smtp-Source: AMrXdXsU07RBuYlPZNvoWjqBoRCrA9nV+WED0cM8rX2iBjZUsBQkQbWNvRSY67DvAcXfRB/IByFw4z/YadO1L84xkmk=
X-Received: by 2002:a63:1b64:0:b0:481:5b48:9ea with SMTP id
 b36-20020a631b64000000b004815b4809eamr4988303pgm.237.1673485594007; Wed, 11
 Jan 2023 17:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20230111133351.807024-1-jannh@google.com>
In-Reply-To: <20230111133351.807024-1-jannh@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 11 Jan 2023 17:06:22 -0800
Message-ID: <CAHbLzkqqKWcMOxm9V4xeyDnnqBVzUjgMaPHtxV=+X3yq4NP1zw@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
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

On Wed, Jan 11, 2023 at 5:33 AM Jann Horn <jannh@google.com> wrote:
>
> If an ->anon_vma is attached to the VMA, collapse_and_free_pmd() requires
> it to be locked. retract_page_tables() bails out if an ->anon_vma is
> attached, but does this check before holding the mmap lock (as the comment
> above the check explains).
>
> If we racily merge an existing ->anon_vma (shared with a child process)
> from a neighboring VMA, subsequent rmap traversals on pages belonging to
> the child will be able to see the page tables that we are concurrently
> removing while assuming that nothing else can access them.
>
> Repeat the ->anon_vma check once we hold the mmap lock to ensure that there
> really is no concurrent page table access.
>
> Reported-by: Zach O'Keefe <zokeefe@google.com>
> Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> zokeefe@ pointed out to me that the current code (after my last round of patches)
> can hit a lockdep assert by racing, and after staring at it a bit I've

I'm supposed the lockdep is the one in collapse_and_free_pmd(). It is
better to have the splat included in the commit log.

> convinced myself that this is a real, preexisting bug.
> (I haven't written a reproducer for it though. One way to hit it might be
> something along the lines of:
>
>  - set up a process A with a private-file-mapping VMA V1
>  - let A fork() to create process B, thereby copying V1 in A to V1' in B
>  - let B extend the end of V1'
>  - let B put some anon pages into the extended part of V1'

I don't quite get why we need this step. A cow fault on A's V1 isn't
enough to have anon_vma for V1? This should not prevent V1 and V2 from
sharing anon_vma. Did I miss something?

>  - let A map a new private-file-mapping VMA V2 directly behind V1, without
>    an anon_vma
> [race begins here]
>   - in A's thread 1: begin retract_page_tables() on V2, run through first
>     ->anon_vma check
>   - in A's thread 2: run __anon_vma_prepare() on V2 and ensure that it
>     merges the anon_vma of V1 (which implies V1 and V2 must be mapping the
>     same file at compatible offsets)
>   - in B: trigger rmap traversal on anon page in V1'
>
>  mm/khugepaged.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 5cb401aa2b9d..0bfed37f3a3b 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1644,7 +1644,7 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
>                  * has higher cost too. It would also probably require locking
>                  * the anon_vma.
>                  */
> -               if (vma->anon_vma) {
> +               if (READ_ONCE(vma->anon_vma)) {
>                         result = SCAN_PAGE_ANON;
>                         goto next;
>                 }
> @@ -1672,6 +1672,18 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
>                 result = SCAN_PTE_MAPPED_HUGEPAGE;
>                 if ((cc->is_khugepaged || is_target) &&
>                     mmap_write_trylock(mm)) {
> +                       /*
> +                        * Re-check whether we have an ->anon_vma, because
> +                        * collapse_and_free_pmd() requires that either no
> +                        * ->anon_vma exists or the anon_vma is locked.
> +                        * We already checked ->anon_vma above, but that check
> +                        * is racy because ->anon_vma can be populated under the
> +                        * mmap lock in read mode.
> +                        */
> +                       if (vma->anon_vma) {
> +                               result = SCAN_PAGE_ANON;
> +                               goto unlock_next;
> +                       }
>                         /*
>                          * When a vma is registered with uffd-wp, we can't
>                          * recycle the pmd pgtable because there can be pte
>
> base-commit: 7dd4b804e08041ff56c88bdd8da742d14b17ed25
> --
> 2.39.0.314.g84b9a713c41-goog
>
