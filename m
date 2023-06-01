Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6567194F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjFAIC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjFAICt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:02:49 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7510E56
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:02:37 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-546ee6030e5so274165eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685606557; x=1688198557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFj+kT/VBusdgZog+iDZ1ooQoiEYtKUuWkkl3xIlR2I=;
        b=OhqzkRJGfG1+JD4yVtA8DAeV9NZBCL4nRgB7u1r+sBe3HdedZWr7Zk8RA6s8DoRzXe
         sT9Q8G1+z2DbkbcgRScqS/9t9Y457dDsxLt0D/qecTvoP5Og7DJ7gvfVtHCbEpjOkQHq
         Dzm72NElUOxLqw/CzCXevoFsO1A1t7dlw1B1cYpkOr27a+OhP+wEfkncLSt5GzjKAsBs
         ZB8FSD0clVT3WDx2t6D3kHdsTZyXORSmQXTVwmwGlBhacuXGLrRiFPtoi4nPjm8U6zYl
         9IClnINlV+vQEp66W6SxgwTrZbos9DJsEDeWBHkvL0qB4q1jmhrlgxwka7XpJuLt8fl4
         1cOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685606557; x=1688198557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFj+kT/VBusdgZog+iDZ1ooQoiEYtKUuWkkl3xIlR2I=;
        b=DKMf6c7MszpL+zo2/vcl75qfM/TuW5YC7fTgWKKOnZA+nptPkdybLd4TjY5v7KPMKm
         CDz9MSFXCzXYbjYtTrMAZz1g9aBUrsLHdIhsKC1vrk7Dfgefabn7oQBo3XlJx7603za4
         G8410BMkdJpNnGrLE3J3cd8edxd1cAqzSzfFo5ppKULCPCQdrWFcV8e1okLU8/wFf6Hu
         YgU+MOnhIYdyvxim44y9LyjNvzMUBXwijnvAnsXZg1QeI/feQN/U9i+Z6tbHTZiP1APq
         WxJnnUzT4lOPtl13kdxhapE0f5m+un+gh9sQo0ggg5eQuya1mQsVaNSiC4xxFMmbm7NS
         zzcQ==
X-Gm-Message-State: AC+VfDxF3KZRUYc3FxcQl8XsN1YnGbaJ8ooxapBMm+xwy/BcoDBY+VOJ
        nH0rnpnfEd+o3AbxxQNwvqLGmKCUG0QTvXRbYKay4w==
X-Google-Smtp-Source: ACHHUZ6U11TNquIEIVZC+F2sDbjEhIWog9gz4EgT+L7KWQXwOLZBFnHQOMc5AkC1hYLE6UOkXIIQklZPzZvzVHyLEVw=
X-Received: by 2002:a05:6358:9499:b0:122:956c:b356 with SMTP id
 i25-20020a056358949900b00122956cb356mr2392943rwb.22.1685606556968; Thu, 01
 Jun 2023 01:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230522112058.2965866-1-talumbau@google.com> <20230522112058.2965866-3-talumbau@google.com>
In-Reply-To: <20230522112058.2965866-3-talumbau@google.com>
From:   Yuanchu Xie <yuanchu@google.com>
Date:   Thu, 1 Jun 2023 16:02:26 +0800
Message-ID: <CAJj2-QEFYapMq2YeaAAeQUovMSsGP7m1G9m0O12AR23MfH-Ufg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 3/4] mm: multi-gen LRU: add helpers in page
 table walks
To:     "T.J. Alumbaugh" <talumbau@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, May 22, 2023 at 7:21=E2=80=AFPM T.J. Alumbaugh <talumbau@google.com=
> wrote:
>
> Add helpers to page table walking code:
>  - Clarifies intent via name "should_walk_mmu" and "should_clear_pmd_youn=
g"
I wonder if these should be called "can_walk_mmu" and
"can_clear_pmd_young", but that's rather minor.

>  - Avoids repeating same logic in two places
>
> Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
> ---
>  mm/vmscan.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index e088db138f5f..ad0f589d32e6 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3234,6 +3234,16 @@ DEFINE_STATIC_KEY_ARRAY_FALSE(lru_gen_caps, NR_LRU=
_GEN_CAPS);
>  #define get_cap(cap)   static_branch_unlikely(&lru_gen_caps[cap])
>  #endif
>
> +static bool should_walk_mmu(void)
> +{
> +       return arch_has_hw_pte_young() && get_cap(LRU_GEN_MM_WALK);
> +}
> +
> +static bool should_clear_pmd_young(void)
> +{
> +       return arch_has_hw_nonleaf_pmd_young() && get_cap(LRU_GEN_NONLEAF=
_YOUNG);
> +}
> +
>  /***********************************************************************=
*******
>   *                          shorthand helpers
>   ***********************************************************************=
*******/
> @@ -4098,7 +4108,7 @@ static void walk_pmd_range_locked(pud_t *pud, unsig=
ned long addr, struct vm_area
>                         goto next;
>
>                 if (!pmd_trans_huge(pmd[i])) {
> -                       if (arch_has_hw_nonleaf_pmd_young() && get_cap(LR=
U_GEN_NONLEAF_YOUNG))
> +                       if (should_clear_pmd_young())
>                                 pmdp_test_and_clear_young(vma, addr, pmd =
+ i);
>                         goto next;
>                 }
> @@ -4191,7 +4201,7 @@ static void walk_pmd_range(pud_t *pud, unsigned lon=
g start, unsigned long end,
>  #endif
>                 walk->mm_stats[MM_NONLEAF_TOTAL]++;
>
> -               if (arch_has_hw_nonleaf_pmd_young() && get_cap(LRU_GEN_NO=
NLEAF_YOUNG)) {
> +               if (should_clear_pmd_young()) {
>                         if (!pmd_young(val))
>                                 continue;
>
> @@ -4493,7 +4503,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruve=
c, unsigned long max_seq,
>          * handful of PTEs. Spreading the work out over a period of time =
usually
>          * is less efficient, but it avoids bursty page faults.
>          */
> -       if (!arch_has_hw_pte_young() || !get_cap(LRU_GEN_MM_WALK)) {
> +       if (!should_walk_mmu()) {
>                 success =3D iterate_mm_list_nowalk(lruvec, max_seq);
>                 goto done;
>         }
> @@ -5730,10 +5740,10 @@ static ssize_t enabled_show(struct kobject *kobj,=
 struct kobj_attribute *attr, c
>         if (get_cap(LRU_GEN_CORE))
>                 caps |=3D BIT(LRU_GEN_CORE);
>
> -       if (arch_has_hw_pte_young() && get_cap(LRU_GEN_MM_WALK))
> +       if (should_walk_mmu())
>                 caps |=3D BIT(LRU_GEN_MM_WALK);
>
> -       if (arch_has_hw_nonleaf_pmd_young() && get_cap(LRU_GEN_NONLEAF_YO=
UNG))
> +       if (should_clear_pmd_young())
>                 caps |=3D BIT(LRU_GEN_NONLEAF_YOUNG);
>
>         return sysfs_emit(buf, "0x%04x\n", caps);
> --
> 2.40.1.698.g37aff9b760-goog
>
Other than that,
Reviewed-by: Yuanchu Xie <yuanchu@google.com>
