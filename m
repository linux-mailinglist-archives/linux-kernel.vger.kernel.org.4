Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6245372B8F2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbjFLHoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbjFLHoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:44:08 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2331C199B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:43:35 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b227fdda27so29269801fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686555742; x=1689147742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ71bt9b3FYUgSPlOf8FiPxADV6UnEaiTW42jFRDtmk=;
        b=P722nCiaq2yIdg/3iiugSvm9is7X0mEyUj3q4fADu2UGqsPP1ozMs/8BBqloMTM71+
         V4yxp5rLchwYfC6TETyyIEKsS+yGBv2M+WfdensYdpqkJPcX3zPeE5VoXujeh8q0aovJ
         lzRkgNQAWxiFrlsEpWLd8fCH5/sJw6vOIw48MisYrEhyjqnf5bW3crdrG+0qUa5OBROw
         7PnNZyqSqNu/a9YjoynTVlEt8oKsj1ZNFXeXAVAcw8+rVeDnFfjoWep8m9EpuviTvHbt
         93/6iKJMTHH+wgDWp+tlL7IldkISFcv6923dTJjf2litTAOtdWkZMYlACaK0MzSjdxPX
         Y9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686555742; x=1689147742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQ71bt9b3FYUgSPlOf8FiPxADV6UnEaiTW42jFRDtmk=;
        b=QIxQWMe6fLKOTmA8vwWZTUh6Het5Pf407vPRHRT/Xac2yEoztsNftcQzeEtKERAGJ6
         8s3YBb3o4EQ3T43W5oIeKk0Tb48Ks0mLOygjku0H4UHyfDnoFKSVk5wTREFQVLieOSQE
         CzNXZ0duQpenBGkzKRVyarlX9naF7QFsxs6ws25KPUAOPDWBGeEIjMMt5FxYW4vcJpa9
         LTgZ0KBy7YNj7mTNI6GykFhj1+McNZLLuOQofUusEjbIuqyV+i6qWbXfZUtPoAQCA6oP
         IPai0TOJMG1mvgyFwo44+PVB0g6PVKLPUKaTJemw5DCuAR0Uti5a19+yrmTQCB5OZGtm
         ZNSw==
X-Gm-Message-State: AC+VfDzM86JfXq/TekmLrndnlJ0J4qmr/UeR0PRyFf7c1OZlmtnUOf+y
        rIgMUgF01ehY4kcufju4n6DP8Sx6vIJ401R4oeN0r3NwPhjXsIR1h7Q=
X-Google-Smtp-Source: ACHHUZ5uY0mHfdIyxOS33Tx+basV/6dyKGu5gb0l5C4gE5e3VvPBE71lr30zNoEEprrb7OYY4jKBZVkFREq38dYDrJ8=
X-Received: by 2002:adf:e403:0:b0:30a:ea65:6676 with SMTP id
 g3-20020adfe403000000b0030aea656676mr4578723wrm.23.1686554148766; Mon, 12 Jun
 2023 00:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_D656D683705F41324657ED3393C3384C7408@qq.com>
In-Reply-To: <tencent_D656D683705F41324657ED3393C3384C7408@qq.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 12 Jun 2023 09:15:38 +0200
Message-ID: <CAHVXubiYHQCYkymde2y_okNb2XcE-xVBMj8iZ7kM5d08bhqxiQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: move memblock_allow_resize() after lm is ready
To:     Woody Zhang <woodylab@foxmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Woody,

On Sat, Jun 10, 2023 at 1:49=E2=80=AFAM Woody Zhang <woodylab@foxmail.com> =
wrote:
>
> The initial memblock metadata is accessed from kernel image mapping. The
> regions arrays need to "reallocated" from memblock and accessed through
> linear mapping to cover more memblock regions. So the resizing should
> not be allowed until linear mapping is ready. Note that there are
> memblock allocations when building linear mapping.
>
> Signed-off-by: Woody Zhang <woodylab@foxmail.com>
> ---
>  arch/riscv/mm/init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 9e9da69720ce..8a33ecbb4d0f 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -258,7 +258,6 @@ static void __init setup_bootmem(void)
>         dma_contiguous_reserve(dma32_phys_limit);
>         if (IS_ENABLED(CONFIG_64BIT))
>                 hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> -       memblock_allow_resize();
>  }
>
>  #ifdef CONFIG_MMU
> @@ -1250,6 +1249,9 @@ static void __init setup_vm_final(void)
>         csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | satp_=
mode);
>         local_flush_tlb_all();
>
> +       /* Depend on that Linear Mapping is ready */
> +       memblock_allow_resize();
> +
>         pt_ops_set_late();
>  }
>  #else
> --
> 2.39.2
>

The commit log does not describe the issue thoroughly enough to me,
maybe you could point to the arm64 commit that did the same? I mean
commit 24cc61d8cb5a ("arm64: memblock: don't permit memblock resizing
until linear mapping is up").

Another point is that I would not put this call into setup_vm_final(),
I'd rather add it in paging_init() as it does not seem like a good fit
for setup_vm_final(). But that's a nit so up to you of course.

Anyway, that's a good catch, thanks!

Alex
