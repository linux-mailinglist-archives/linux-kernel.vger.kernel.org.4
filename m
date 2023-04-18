Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458416E5E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDRKMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjDRKMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:12:02 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A8A6E8D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:11:36 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-329627dabfbso30750315ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681812694; x=1684404694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t7oNbt6UHUojCngKOJ0DxqaobdP4aHKdK/uVGrFOX4A=;
        b=Cv2mPKC/vP9dBafytcdnqHnkxMtJ7odBspcC7EBjxQaZbbGa51BPAqJCODkF/BFlzo
         KYjeYx0Dm3UD0AEQ10KK81Oe/kqzQWv7g/TGJ7bNJ/FOu4NgKsB1b5w7bCecNWhrpnkk
         cplxOnpGBy939dBcB97TDYLR6bVrOJIihIiHyWQzPciROwz/YGEL4SIU/eWk6/uOHHY+
         eTanoBMfME1C8b4Lt0IjFi4C29mb0aVTqQHX+Ggchm+mki797ql/KaG2qFZXKpac7ZTK
         o32CId0UaQoUvPs2/6HLK92TFLgv3rxo1NUzoRpI9S5SFrbVfompKGBr2Jwv3yaBWyeH
         ij4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681812694; x=1684404694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7oNbt6UHUojCngKOJ0DxqaobdP4aHKdK/uVGrFOX4A=;
        b=jEF8bPLEpRaSru9J1Hk2Xl3HcrgQ2/uJzB3nUJbR8sosreqQDcStYUPhRFi7Qe/67q
         Af07iJKhcPdWohwqk6Td965uyIw1MFoJYFQ6NwrWzri5NzylgnQZtRIZm/sT0Y62DcJx
         98FnftfDvt9Yllm2r0D/QWUEapywMTVfH9rqFD+v3VMS2c3oNaKkqSlMxARfNJ2hBHuA
         yHDieXVpwjp68fsk13y9ZJeOZ1Z1fQ+f7Ga9V5wt1MkYaZoQ/DM9kIHaBlaSTWyTb7QV
         bDZvkTqrV3QEQrJc4rAU9Ku7+0yHlkBzFeaBhAa5MEk1bIRFCx/44XYTEi+MfxHQSQQg
         WXXQ==
X-Gm-Message-State: AAQBX9e6vnX7vPWcSYVjL57Gy94x00FCSF93UEhQRGT2bHHB+ZTZo5NK
        fB1KsQsiYWkp0ueb4CC52vtPz5x6OWinr6Z8XFiGiQ==
X-Google-Smtp-Source: AKy350YNZVWkwrsSvj08CvK+g3B+QBOhbLyfSq9683Wfe1DivlOxIMokDWKxZHy0H6PZp5kSqAIU8GYD3d/gzR/ZzI4=
X-Received: by 2002:a5e:8607:0:b0:753:989:ebb5 with SMTP id
 z7-20020a5e8607000000b007530989ebb5mr1447879ioj.7.1681812694096; Tue, 18 Apr
 2023 03:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230413131223.4135168-1-glider@google.com> <20230413131223.4135168-4-glider@google.com>
In-Reply-To: <20230413131223.4135168-4-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 Apr 2023 12:10:57 +0200
Message-ID: <CANpmjNMVVRg6sVREDYGCiSPO6GOpWd4wuMnyNM5=wRJJvox4bQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] mm: apply __must_check to vmap_pages_range_noflush()
To:     Alexander Potapenko <glider@google.com>
Cc:     urezki@gmail.com, hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, dvyukov@google.com,
        kasan-dev@googlegroups.com,
        Dipanjan Das <mail.dipanjan.das@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 13 Apr 2023 at 15:12, Alexander Potapenko <glider@google.com> wrote:
>
> To prevent errors when vmap_pages_range_noflush() or
> __vmap_pages_range_noflush() silently fail (see the link below for an
> example), annotate them with __must_check so that the callers do not
> unconditionally assume the mapping succeeded.
>
> Reported-by: Dipanjan Das <mail.dipanjan.das@gmail.com>
> Link: https://lore.kernel.org/linux-mm/CANX2M5ZRrRA64k0hOif02TjmY9kbbO2aCBPyq79es34RXZ=cAw@mail.gmail.com/
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/internal.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 7920a8b7982ec..a646cf7c41e8a 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -833,20 +833,20 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
>   * mm/vmalloc.c
>   */
>  #ifdef CONFIG_MMU
> -int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> -                pgprot_t prot, struct page **pages, unsigned int page_shift);
> +int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> +               pgprot_t prot, struct page **pages, unsigned int page_shift);
>  #else
>  static inline
> -int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> -                pgprot_t prot, struct page **pages, unsigned int page_shift)
> +int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> +               pgprot_t prot, struct page **pages, unsigned int page_shift)
>  {
>         return -EINVAL;
>  }
>  #endif
>
> -int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> -                              pgprot_t prot, struct page **pages,
> -                              unsigned int page_shift);
> +int __must_check __vmap_pages_range_noflush(
> +       unsigned long addr, unsigned long end, pgprot_t prot,
> +       struct page **pages, unsigned int page_shift);
>
>  void vunmap_range_noflush(unsigned long start, unsigned long end);
>
> --
> 2.40.0.577.gac1e443424-goog
>
