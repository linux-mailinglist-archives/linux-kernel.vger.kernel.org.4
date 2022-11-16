Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57E762C1B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiKPPAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiKPPAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:00:19 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6320C5288F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:59:54 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b21so16643748plc.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1jAWHUqALggNjCWqoXUSEwcnk3/O/6QqeWFVl02PEXo=;
        b=AhEGOfoYS0C7V3XzptlL7bN5eNHwkgzXMNWSwyxgeGqI0WHoJzUUjMcxI0zpcV9Vvo
         6DVWZhBEjtNmzSzk7uyoP3atPElhv+zA/3vitkbAal4izvNukVzPKN+Rp9XCjkhAgbsM
         KtTjLpigk9xb2seSwvoDaklD9bOBdZo9WptKakc7opq6Hw+jjrEzkh0KNmj2WGxSAaHB
         ggIcCoUJw4s7MAzafWtEBtHZfrD5MEIoF5CZaZDJJS0sxZrMgQ9ETPLnat+aebWjuLQ3
         NH2rJSx2OGzFOCFn2g/h2C66VocGsDFLkID8Q9h5TSILxT+XwY3xIzcgFehNAmujBMMo
         H5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jAWHUqALggNjCWqoXUSEwcnk3/O/6QqeWFVl02PEXo=;
        b=kamz6J/0XXkTFE+XXRgJVF5M+ae1J8KqLp20MQYEo23BbAonGPjxm50XgTl931cJPC
         Iu9P9M6WYc3nHDCFsJe7ZNThoMfx4biGz43sne4pOp5G2aoiIKX/rACMU/FToXQRzXlu
         2GNdaK/YmYWFUTL/ER1JHnMdpUt8DWj3il5vc79iMGsJHuJebqgHUhawnIbqj4z3iGoZ
         kwqovbhzO/wnqv2ZuHj2Pd0K2CyDUU2ZHbY0uyDBI1hTOkK4qC1cXZyn0fqt1cR5rtts
         V/sVDZO3dZPGdXbbDBkPCv9SeHqvPj2cRji2bcgltnqn5yzB8VykOFLh5+r0mswvXwZ5
         fRvA==
X-Gm-Message-State: ANoB5pnUhxMLI7PJOmOk5Xo+3RYXhSSqVNFbaimoQZrIyiUNnzCXbejN
        31V1UddbcGIVPP0Yib3KFCgzqbkLcHrD/NXX+kTeSA==
X-Google-Smtp-Source: AA0mqf6tE0gG5PUtr2w0thHGzbpuJ3sE89+hCkJxPOEx5y27NCk8SUlz0BxWXo7FEq2NQYcWvwectDmphNqSd4nkAnM=
X-Received: by 2002:a17:90b:1998:b0:212:2098:fd2f with SMTP id
 mv24-20020a17090b199800b002122098fd2fmr4085483pjb.162.1668610793843; Wed, 16
 Nov 2022 06:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20221116083811.464678-1-liushixin2@huawei.com> <20221116083811.464678-2-liushixin2@huawei.com>
In-Reply-To: <20221116083811.464678-2-liushixin2@huawei.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 16 Nov 2022 09:59:16 -0500
Message-ID: <CA+CK2bAF6Tj257W10kowSagQd883hLOLPsZ5Cd9dEeVuRWaEqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64/mm: fix incorrect file_map_count for non-leaf pmd/pud
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <dhildenb@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 2:51 AM Liu Shixin <liushixin2@huawei.com> wrote:
>
> The page table check trigger BUG_ON() unexpectedly when collapse hugepage:
>
>  ------------[ cut here ]------------
>  kernel BUG at mm/page_table_check.c:82!
>  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>  Dumping ftrace buffer:
>     (ftrace buffer empty)
>  Modules linked in:
>  CPU: 6 PID: 68 Comm: khugepaged Not tainted 6.1.0-rc3+ #750
>  Hardware name: linux,dummy-virt (DT)
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : page_table_check_clear.isra.0+0x258/0x3f0
>  lr : page_table_check_clear.isra.0+0x240/0x3f0
> [...]
>  Call trace:
>   page_table_check_clear.isra.0+0x258/0x3f0
>   __page_table_check_pmd_clear+0xbc/0x108
>   pmdp_collapse_flush+0xb0/0x160
>   collapse_huge_page+0xa08/0x1080
>   hpage_collapse_scan_pmd+0xf30/0x1590
>   khugepaged_scan_mm_slot.constprop.0+0x52c/0xac8
>   khugepaged+0x338/0x518
>   kthread+0x278/0x2f8
>   ret_from_fork+0x10/0x20
> [...]
>
> Since pmd_user_accessible_page() doesn't check if a pmd is leaf, it
> decrease file_map_count for a non-leaf pmd comes from collapse_huge_page().
> and so trigger BUG_ON() unexpectedly.
>
> Fix this problem by using pmd_leaf() insteal of pmd_present() in

s/insteal/instead

> pmd_user_accessible_page(). Moreover, use pud_leaf() for
> pud_user_accessible_page() too.
>
> Fixes: 42b2547137f5 ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
> Reported-by: Denys Vlasenko <dvlasenk@redhat.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 71a1af42f0e8..edf6625ce965 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -863,12 +863,12 @@ static inline bool pte_user_accessible_page(pte_t pte)
>
>  static inline bool pmd_user_accessible_page(pmd_t pmd)
>  {
> -       return pmd_present(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> +       return pmd_leaf(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>  }
>
>  static inline bool pud_user_accessible_page(pud_t pud)
>  {
> -       return pud_present(pud) && pud_user(pud);
> +       return pud_leaf(pud) && pud_user(pud);

Thanks a lot. The x86 variants are already using p*d_leaf() in these functions.

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
