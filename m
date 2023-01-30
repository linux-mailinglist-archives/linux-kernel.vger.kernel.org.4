Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069D7681665
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjA3QaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbjA3Q35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:29:57 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8037A3EC46
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:29:53 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id e10so7988902pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DCJsC41WTA2Nb50A59T+Svhhje166vY6Y2FIvFXfkhQ=;
        b=omWAmCYOFTjlyeKuVcOLF/g9MigvZFVMIfHMF7gww41fzEkp0D8jt95LUNIypO7+ou
         pjhptiRYrBrAsaR8Xvf+KithypDPLb923bOqPte6b2b82ZIuocElMx1v22pKEx7GwAa0
         BqiKJLfJoe+o2pJUi8FuIMphYk1ny8i0A85RmTCYwZ64djbH73TER2Zqu6bmTHwg5QqB
         IMSzmQ5TO1TGnk9ZP39z6WK9hqqctqjOsxYslCGtTC8IDNldGwIm0UNFkXPMRPmJovQt
         LHRVZB1ENz73f87E3JXJTg1Q61v1CgaAOG2VLe+PFaVfG8zgaquuFftZntfwjYNW7szc
         laow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCJsC41WTA2Nb50A59T+Svhhje166vY6Y2FIvFXfkhQ=;
        b=44+kM9BbBs10CKGvC0J7elncqY/W4CQAyVZczYhcnevHHWHBsCNGgozbZRZV3gwj+J
         JCJeJszaNbQMB3P0L6QgW+7V7HJHl+flgW21yExnrTGYPvtyXQuI9xuJuE+2kGrilBrN
         SAM4Q48iaH61Oc5vb2yDSylx5AxKyarsyhiVftOItVUk+Ukg7ir3BiIoohLdEcM/K9Ld
         c2HkeLiKOliaSuBYkibFGjpHuidJfFKm86g41jrAWQH7jw9vk3yOxGPvTrcnOMeBFS3c
         qzJ0ZI6MWSlPBn2AObCujmYTiv3N5iR3Zwq1MnVBQLUiwOz0TVbj8nedeCbo6D0V3PzO
         qhZA==
X-Gm-Message-State: AO0yUKWuXJhCPiRVtaj5/7mQVZvqMU8/9RcZSnhiYF7wuLjKOcH9uNis
        WK31GKURUAhvZ2qvR/JL0kEq/YDV48dTiaCfHZq7d1f6hMU=
X-Google-Smtp-Source: AK7set+go3Xqpm0FoM/LSmfC/xJ8FAfFE40vdewv1suyrUoGUHZYEderoGE5WRdJvXORuGIbvwujwFT8yKJDHYvW4vw=
X-Received: by 2002:a62:830d:0:b0:592:7c9a:1236 with SMTP id
 h13-20020a62830d000000b005927c9a1236mr2110205pfe.26.1675096192769; Mon, 30
 Jan 2023 08:29:52 -0800 (PST)
MIME-Version: 1.0
References: <20230130130739.563628-1-arnd@kernel.org>
In-Reply-To: <20230130130739.563628-1-arnd@kernel.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 30 Jan 2023 08:29:41 -0800
Message-ID: <CAKgT0Ufh7bGh360GUgbSCwysmd=L2B_V2X8SGtF94CzAqCA9_Q@mail.gmail.com>
Subject: Re: [PATCH] mm: extend max struct page size for kmsan
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Potapenko <glider@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 5:07 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> After x86 has enabled support for KMSAN, it has become possible
> to have larger 'struct page' than was expected when commit
> 5470dea49f53 ("mm: use mm_zero_struct_page from SPARC on all 64b
> architectures") was merged:
>
> include/linux/mm.h:156:10: warning: no case matching constant switch condition '96'
>         switch (sizeof(struct page)) {
>
> Extend the maximum accordingly.
>
> Fixes: 5470dea49f53 ("mm: use mm_zero_struct_page from SPARC on all 64b architectures")
> Fixes: 4ca8cc8d1bbe ("x86: kmsan: enable KMSAN builds for x86")

Rather than saying this fixes the code that enables the config flags I
might be more comfortable with listing the commit that added the two
pointers to the struct:
Fixes: f80be4571b19 ("kmsan: add KMSAN runtime core")

It will make it easier to identify where the lines where added that
actually increased the size of the page struct.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This seems to show up extremely rarely in randconfig builds, but
> enough to trigger my build machine.
>
> I saw a related discussion at [1] about raising MAX_STRUCT_PAGE_SIZE,
> but as I understand it, that needs to be addressed separately.
>
> [1] https://lore.kernel.org/lkml/20220701142310.2188015-11-glider@google.com/
> ---
>  include/linux/mm.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b73ba2e5cfd2..aa39d5ddace1 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -137,7 +137,7 @@ extern int mmap_rnd_compat_bits __read_mostly;
>   * define their own version of this macro in <asm/pgtable.h>
>   */
>  #if BITS_PER_LONG == 64
> -/* This function must be updated when the size of struct page grows above 80
> +/* This function must be updated when the size of struct page grows above 96
>   * or reduces below 56. The idea that compiler optimizes out switch()
>   * statement, and only leaves move/store instructions. Also the compiler can
>   * combine write statements if they are both assignments and can be reordered,
> @@ -148,12 +148,18 @@ static inline void __mm_zero_struct_page(struct page *page)
>  {
>         unsigned long *_pp = (void *)page;
>
> -        /* Check that struct page is either 56, 64, 72, or 80 bytes */
> +        /* Check that struct page is either 56, 64, 72, 80, 88 or 96 bytes */
>         BUILD_BUG_ON(sizeof(struct page) & 7);
>         BUILD_BUG_ON(sizeof(struct page) < 56);
> -       BUILD_BUG_ON(sizeof(struct page) > 80);
> +       BUILD_BUG_ON(sizeof(struct page) > 96);
>
>         switch (sizeof(struct page)) {
> +       case 96:
> +               _pp[11] = 0;
> +               fallthrough;
> +       case 88:
> +               _pp[10] = 0;
> +               fallthrough;
>         case 80:
>                 _pp[9] = 0;
>                 fallthrough;

Otherwise the code itself looks good to me.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
