Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72D563B2A0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiK1T5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiK1T5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:57:10 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDB32D1EE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:57:09 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x66so11564245pfx.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q++N7mMr2bng1GoyuTRGH7t3fqpBykOOtM6lUt7GCbc=;
        b=Pn7vV1/M4oM5qFJ3pcZbD0WrvdbiESeFbb0QMGvnyeF7CEZE40krxPB+Ctto/SqrU/
         07pYUte5HyNzmVBJlOQp/qEDAU8ZRc/Nt7IJIWVVR60RWD8JupJvw6C77we/0u9t+0S4
         NfwDVZNufFlucKugYMBxxyhViOGtXzkMIjT/+KV40HewUFMv6Ysk1RVTHkMWZYRCVbKY
         DBJa3Q2LB8TkEOUltC63rGZS8XukkAyz+0PMpr2QtGrGBpKd8dIMStWzyYWwd70/robP
         Dw2yPMSNTJdxd0HVxqtdFzkMkOqljhO0TpJ2+4M7L7B0Tp9E7EeqNUMK13v20ssvf+n2
         vCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q++N7mMr2bng1GoyuTRGH7t3fqpBykOOtM6lUt7GCbc=;
        b=bxHsv2+M0CwDFdvskQDKkFB3KW7/rGJHGXQbg3osKYTzyG+7gbg0Sb7jxQMxjQyv02
         TDOGKp/y3nfa9ZocHJuShHOODlkJQQNsYp9TFYSiiVL0ie5O6hV6RfOLe7ZZHgcwsncR
         nJVxNPeZAW5LOAbq30SiplCH8Ttza1h6QsQV6r/gnJy3kfH+Zq7rayHlJQS2/ZR0gSZd
         sXfLNj6RAasIm83c8O1O7sYUWJHaGnsxsQkEEtqHH7gZ4TWd+4PANXr3yqNgjLaxmWyj
         rfIv9GAl5gd2GqMOsU7WLeSY2rV+hoolUzi/D2tAGqdOza2l+QXaOZvI7Knk7BlcvFwy
         WVbA==
X-Gm-Message-State: ANoB5pnuyWfzMEXrKZaJC13uu2b1z908y9WuqOJSl1uO0s6RRKvvsltJ
        FHtBtbEqtWAcx2bJJdh8jslLKvAx3shiWXQx6Vg=
X-Google-Smtp-Source: AA0mqf5pEXXu3ZZ0NNttSxTKItzjXS6JBsJmqLVUAAHbyjFseNpEy2X8y97Gmcu1eatgGg2U+m/jQiEVV3yMJhTFp44=
X-Received: by 2002:a05:6a00:5:b0:574:f82c:9389 with SMTP id
 h5-20020a056a00000500b00574f82c9389mr11701508pfk.39.1669665428820; Mon, 28
 Nov 2022 11:57:08 -0800 (PST)
MIME-Version: 1.0
References: <20221128180252.1684965-1-jannh@google.com> <20221128180252.1684965-3-jannh@google.com>
In-Reply-To: <20221128180252.1684965-3-jannh@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 28 Nov 2022 11:56:57 -0800
Message-ID: <CAHbLzkoPdeMYOd591vS8XnWmwwn92kp30tac7_a8tWJE2+aN7w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm/khugepaged: Invoke MMU notifiers in shmem/file
 collapse paths
To:     Jann Horn <jannh@google.com>
Cc:     security@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Mon, Nov 28, 2022 at 10:03 AM Jann Horn <jannh@google.com> wrote:
>
> Any codepath that zaps page table entries must invoke MMU notifiers to
> ensure that secondary MMUs (like KVM) don't keep accessing pages which
> aren't mapped anymore. Secondary MMUs don't hold their own references to
> pages that are mirrored over, so failing to notify them can lead to page
> use-after-free.
>
> I'm marking this as addressing an issue introduced in commit f3f0e1d2150b
> ("khugepaged: add support of collapse for tmpfs/shmem pages"), but most of
> the security impact of this only came in commit 27e1f8273113 ("khugepaged:
> enable collapse pmd for pte-mapped THP"), which actually omitted flushes
> for the removal of present PTEs, not just for the removal of empty page
> tables.
>
> Cc: stable@kernel.org
> Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
> v4: no changes
>
>  mm/khugepaged.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index c3d3ce596bff7..49eb4b4981d88 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1404,6 +1404,7 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
>                                   unsigned long addr, pmd_t *pmdp)
>  {
>         pmd_t pmd;
> +       struct mmu_notifier_range range;
>
>         mmap_assert_write_locked(mm);
>         if (vma->vm_file)
> @@ -1415,8 +1416,12 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
>         if (vma->anon_vma)
>                 lockdep_assert_held_write(&vma->anon_vma->root->rwsem);
>
> +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL, mm, addr,
> +                               addr + HPAGE_PMD_SIZE);
> +       mmu_notifier_invalidate_range_start(&range);
>         pmd = pmdp_collapse_flush(vma, addr, pmdp);
>         tlb_remove_table_sync_one();
> +       mmu_notifier_invalidate_range_end(&range);
>         mm_dec_nr_ptes(mm);
>         page_table_check_pte_clear_range(mm, addr, pmd);
>         pte_free(mm, pmd_pgtable(pmd));
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
