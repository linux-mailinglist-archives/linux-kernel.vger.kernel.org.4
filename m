Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13022679276
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjAXIAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjAXIAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:00:39 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4543EFC3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:00:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d14so9326235wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CqSZybdUuskI+UDVH1j93jvIbGoD0+XsFL55JSeaP+k=;
        b=b6H059p3q9xg6E9c9XQB6jeEpHYZpMtkObtgJ6shIqMFcjqV1MYW7qTz6S2CRHj27i
         1TKgxE7c8dtixSqWvF98vecR84mlfuZLI60RrLF4f/I406iDTKwZVOnoEw5xAJYTmbXA
         ngN8ug+S4wFE3dQ0QMTi4BOLCy2P3skctJM4mg9QhlJXWG22To0vkohGxqM4d3MokLSC
         GVmKpV3HRAOgqv8acmEXkW8AeyvWBiigkNMveO4uFIIHS4gK64om7JLDHTT+MlmIdSFN
         gaF9FbDAVVpedWKzzz3zdaZcywtPT71D0YdaPgUDV7O90c3s/sU/LQG5tjrC0EH4xyip
         RREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqSZybdUuskI+UDVH1j93jvIbGoD0+XsFL55JSeaP+k=;
        b=uPVJolDsxozZMKxs4Fuw0oWQcfGaOpWz0JOX2ft1Z9KyqjbRSneToaQz+mmA40rlbh
         5lPt9tLZ4DLs5HHokV99Cn5o37UZ+5lNNgEVO2Ip1OI7jYJk000rEtOkjCt0FcRDEktj
         byYm+vfHoujERYfhx1HNwRzogd8wGCX8H+/4EpSgM7LlgaRigResmu9q66CL5Ejmh5Cj
         2++iyBKtkYjyCHO1WteiQ2tuQb/SkPu2rryAA10KnRRNquuiVEGBGGJf37FRyQslrVV7
         2vd89cvgK2bxN4r7PLYLj4nINGWTA7AQoapf3hF4vf4QcUJQQSZp8WfWc/KTOXfqNhQw
         wPGA==
X-Gm-Message-State: AFqh2kqj66VxrwrxlWWtDDgd9exgFHLiDnbdx2F4B6Y2xROnDLYpaZOo
        5kH6Qu+9Uu7gessfA6YBBHorL3B6U5Gjac8opkhnuA==
X-Google-Smtp-Source: AMrXdXvPLscFw4dlQnNZxaTZSeeo5RV7pn56CWqRBz3ECJ7Gfy9qulLKrkg3tXoRsE2OvYfbItKgsSpGdywsTmb1+NA=
X-Received: by 2002:a5d:5190:0:b0:2bd:d6bc:e35c with SMTP id
 k16-20020a5d5190000000b002bdd6bce35cmr1218375wrv.144.1674547236441; Tue, 24
 Jan 2023 00:00:36 -0800 (PST)
MIME-Version: 1.0
References: <20230123100951.810807-1-alexghiti@rivosinc.com>
 <20230123100951.810807-2-alexghiti@rivosinc.com> <Y88HD2ocLQilIuDr@spud>
In-Reply-To: <Y88HD2ocLQilIuDr@spud>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 24 Jan 2023 09:00:25 +0100
Message-ID: <CAHVXubiSJMyeuy253wyFALQ0DzDn_yuuR4HWKy9rmGYLNeXpKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] riscv: Split early and final KASAN population functions
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Mon, Jan 23, 2023 at 11:15 PM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Alex,
>
> FYI this patch has a couple places with spaces used rather than tabs for
> indent.

Damn, I forgot to run checkpatch this time...

Thanks,

Alex

>
> >  static void __init kasan_populate_p4d(pgd_t *pgd,
> > -                                   unsigned long vaddr, unsigned long end,
> > -                                   bool early)
> > +                                   unsigned long vaddr, unsigned long end)
> >  {
> >       phys_addr_t phys_addr;
> >       p4d_t *p4dp, *base_p4d;
> >       unsigned long next;
> >
> > -     if (early) {
> > -             /*
> > -              * We can't use pgd_page_vaddr here as it would return a linear
> > -              * mapping address but it is not mapped yet, but when populating
> > -              * early_pg_dir, we need the physical address and when populating
> > -              * swapper_pg_dir, we need the kernel virtual address so use
> > -              * pt_ops facility.
> > -              */
> > -             base_p4d = pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(*pgd)));
> > -     } else {
> > -             base_p4d = (p4d_t *)pgd_page_vaddr(*pgd);
> > -             if (base_p4d == lm_alias(kasan_early_shadow_p4d)) {
> > -                     base_p4d = memblock_alloc(PTRS_PER_PUD * sizeof(p4d_t), PAGE_SIZE);
> > -                     memcpy(base_p4d, (void *)kasan_early_shadow_p4d,
> > -                             sizeof(p4d_t) * PTRS_PER_P4D);
> > -             }
> > -     }
> > +     base_p4d = (p4d_t *)pgd_page_vaddr(*pgd);
> > +     if (base_p4d == lm_alias(kasan_early_shadow_p4d)) {
> > +             base_p4d = memblock_alloc(PTRS_PER_PUD * sizeof(p4d_t), PAGE_SIZE);
> > +        memcpy(base_p4d, (void *)kasan_early_shadow_p4d,
> > +                sizeof(p4d_t) * PTRS_PER_P4D);
> > +    }
>
> ^^  here.
>
> Thanks,
> Conor.
>
