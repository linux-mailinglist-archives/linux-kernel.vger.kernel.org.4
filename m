Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077FB734353
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 21:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjFQT3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 15:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjFQT3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 15:29:39 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701801BC9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 12:29:38 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso565083b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 12:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687030178; x=1689622178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q3Flr21//mrp/R+bLKaAiuQMbZXMngPcVO43D7NaF+M=;
        b=Tu683Aj7ojr67shcehcZOuv0zMZ5G5zTgT3Ar0HoUhoax3QZ4FabOpOAe11bA+f2Qo
         bT88qKtinROKN9CuI594FuNiNb2DosR4fugziuZLB6FoF3iIUjDPx8Rtc5tzVjunKvT1
         okxLfH2bU0mAsIWChdbbtRLRTPTnJTTi257K1xhVGU+V70EKDn/dyEwwQPnR0W2tOezR
         qpeH+4Icbeo9w7uA9GwR+x5zsY8eS/RUTFa0Ne4aRg6cpuAEJ8VZhL+eqia1N1Jvuza2
         3RaLFvVA/R3QhYXt3VhIO9zeP7gBHCiNPTLxV/nygq8kuy0LlDEuyuZ1vx2WG3wNZxW2
         3rEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687030178; x=1689622178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3Flr21//mrp/R+bLKaAiuQMbZXMngPcVO43D7NaF+M=;
        b=Y73hvJ7kAkcwbeUxoElsmXC4yRvUeu/aB0Sx/awCo0oVE5wgBbGpnD8OqB7ahbjB21
         JciAjqErg/Uvos6Kmgs5UTQDQqvGt8hXSqieIZ5sokk33+OaYh7oageXlQx2LfbjQebf
         RDxGH6WRHls+HETjEgymiVujl0G+NZZUtgbtWMn7A/C7arXoFnuhvZ1wrEbZ10vF7Xjs
         w0jS0uocm25UJ07q/JBGoojLPHrY+zZsi2L2xIign+I4y2Vg+0iGQm+9DAvah+nM4Me3
         LS6xMZ/KbeS6tLtEIbTk+E3HbZEyoQaCuXbaU0rxoKOXQKrDBidPxkJZEVLdEG8L/FkM
         00Yw==
X-Gm-Message-State: AC+VfDxwnMUn0uW4snK1yQLgXY4JVSM2B8jwT3g1nBjXLQldF35MxjoD
        5U+FThAwDtyV2blZV/t4gVl3Llmb+b37S8UUPl7zRs7RaGM=
X-Google-Smtp-Source: ACHHUZ7Va0w7lbIrBj7ScFe81i5qqdhtkTbboLSWIKCteUrVIg4takHgRIqNqGvPuRuS7gl8P9ibxXLfO1qiLm1fCng=
X-Received: by 2002:a05:6a00:134c:b0:65a:cbf3:4687 with SMTP id
 k12-20020a056a00134c00b0065acbf34687mr5743238pfu.0.1687030177819; Sat, 17 Jun
 2023 12:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230613201827.9441-1-vishal.moola@gmail.com> <20230613201827.9441-4-vishal.moola@gmail.com>
In-Reply-To: <20230613201827.9441-4-vishal.moola@gmail.com>
From:   Lorenzo Stoakes <lstoakes@gmail.com>
Date:   Sat, 17 Jun 2023 20:29:26 +0100
Message-ID: <CAA5enKaOdYnX-J_ABwqxZO54+e3D-bP16hPFyjcRXDYq90LcoQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm/gup_test.c: Convert verify_dma_pinned() to us folios
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 at 21:18, Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> verify_dma_pinned() checks that pages are dma-pinned. We can convert
> this to use folios.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  mm/gup_test.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/mm/gup_test.c b/mm/gup_test.c
> index 8ae7307a1bb6..860b093b4b3e 100644
> --- a/mm/gup_test.c
> +++ b/mm/gup_test.c
> @@ -40,24 +40,25 @@ static void verify_dma_pinned(unsigned int cmd, struct page **pages,
>                               unsigned long nr_pages)
>  {
>         unsigned long i;
> -       struct page *page;
> +       struct folio *folio;
>
>         switch (cmd) {
>         case PIN_FAST_BENCHMARK:
>         case PIN_BASIC_TEST:
>         case PIN_LONGTERM_BENCHMARK:
>                 for (i = 0; i < nr_pages; i++) {
> -                       page = pages[i];
> -                       if (WARN(!page_maybe_dma_pinned(page),
> +                       folio = page_folio(pages[i]);
> +
> +                       if (WARN(!folio_maybe_dma_pinned(folio),
>                                  "pages[%lu] is NOT dma-pinned\n", i)) {
>
> -                               dump_page(page, "gup_test failure");
> +                               dump_page(&folio->page, "gup_test failure");
>                                 break;
>                         } else if (cmd == PIN_LONGTERM_BENCHMARK &&
> -                               WARN(!is_longterm_pinnable_page(page),
> +                               WARN(!folio_is_longterm_pinnable(folio),
>                                      "pages[%lu] is NOT pinnable but pinned\n",
>                                      i)) {
> -                               dump_page(page, "gup_test failure");
> +                               dump_page(&folio->page, "gup_test failure");
>                                 break;
>                         }
>                 }
> --
> 2.40.1
>
>

(Hope you don't mind me taking a look, GUP is of interest to me :)

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
