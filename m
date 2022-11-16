Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C9062C24B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiKPPTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbiKPPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:19:29 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1B82AD3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:19:29 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id f3so10534144pgc.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QYE5isvHLUkPorHdSOGCWdeGDSyYRtFAWzOE26fRCa0=;
        b=cKbgdu7w09RFdjIlH32RgzSdjf5zCsyy/TPrBsHwqP33kTzbagAP3+LzLUfttf5DoZ
         1vkeSh5Wn5iybEyI15jNL6iBwJPN6t0lA/Vuyir+RD4v7J1QmqyTpz0hbnzhC0F8ZwmF
         nvDPdYDl8S61Lj0iKE85GHx8hoGuKqNl9J5awHc3Y5u++W2vl3kg+bK6xobKzmiPTLs5
         QWsMMMD+w0Cx4wrIuQS77qassjUFjuUqEfQfbaU8S2vcgo3arfUKv3GeMgv84Bb5HNtz
         u9mmssoPIGyzJYqFIDbiU5nBsmacDiR1/Q2NBBTmirEwMa8v+6pjd/+1uVSRTUzsxo0L
         NI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYE5isvHLUkPorHdSOGCWdeGDSyYRtFAWzOE26fRCa0=;
        b=KTiSKhwppC2hdyC9iJJOMHRSgKZmhnjKzYs5b7KqiGgwXQ/jnrBLlL8RnwjD/72tBa
         ovUZML1RW9BFNFh2aYI5ZkgnYIBloRNAJEosAtGth6M3pqZy7XVHchRFKGN1MgdXEMa1
         rLgrYhBmNijor1b3vEOesAgxH3lPztbJV8gaWmdtFgCkBFDwVkC6h5TUgqg8alvK0gHZ
         6CVbHqNgId8AbdNAvn97w+3ERFxxic3w5ybwk/SirZaCvogzXpl3j72O2WDhRWlghF6+
         HcXFUIKktk8001Ooc8CkTXPjO3Yv4o/2THDArIHpG38Rx57uH/mfamjLpGd2deSqipnm
         YU7A==
X-Gm-Message-State: ANoB5pkgcC7lMGAwhBKaE1Ecn3lzatSvGj56ISqpW075BrlsOXcLLCXe
        SX9yrFMfu5llyAw6P+BJKZKmeKO4yeXo30G3e3y+6A==
X-Google-Smtp-Source: AA0mqf7zQz1mK85XhI7pEiFAkD97PVLxJqR0BWo7yP/Xv3yX2wEetGG83KCMWzpBWcA/UNqbUx2BFFUxM7GFxT2bs4I=
X-Received: by 2002:a63:1f47:0:b0:476:ed2a:6228 with SMTP id
 q7-20020a631f47000000b00476ed2a6228mr2419122pgm.137.1668611968576; Wed, 16
 Nov 2022 07:19:28 -0800 (PST)
MIME-Version: 1.0
References: <20221116083811.464678-1-liushixin2@huawei.com> <20221116083811.464678-3-liushixin2@huawei.com>
In-Reply-To: <20221116083811.464678-3-liushixin2@huawei.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 16 Nov 2022 10:18:51 -0500
Message-ID: <CA+CK2bAHD2oj1SbdrLTQnEs5E7Cp=D=7c0AVG6bU3Nr+_NK15w@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64/mm: fix incorrect file_map_count for invalid pmd/pud
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
> The page table check trigger BUG_ON() unexpectedly when split hugepage:
>
>  ------------[ cut here ]------------
>  kernel BUG at mm/page_table_check.c:119!
>  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>  Dumping ftrace buffer:
>     (ftrace buffer empty)
>  Modules linked in:
>  CPU: 7 PID: 210 Comm: transhuge-stres Not tainted 6.1.0-rc3+ #748
>  Hardware name: linux,dummy-virt (DT)
>  pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : page_table_check_set.isra.0+0x398/0x468
>  lr : page_table_check_set.isra.0+0x1c0/0x468
> [...]
>  Call trace:
>   page_table_check_set.isra.0+0x398/0x468
>   __page_table_check_pte_set+0x160/0x1c0
>   __split_huge_pmd_locked+0x900/0x1648
>   __split_huge_pmd+0x28c/0x3b8
>   unmap_page_range+0x428/0x858
>   unmap_single_vma+0xf4/0x1c8
>   zap_page_range+0x2b0/0x410
>   madvise_vma_behavior+0xc44/0xe78
>   do_madvise+0x280/0x698
>   __arm64_sys_madvise+0x90/0xe8
>   invoke_syscall.constprop.0+0xdc/0x1d8
>   do_el0_svc+0xf4/0x3f8
>   el0_svc+0x58/0x120
>   el0t_64_sync_handler+0xb8/0xc0
>   el0t_64_sync+0x19c/0x1a0
> [...]
>
> On arm64, pmd_present() will return true even if the pmd is invalid.
> in pmdp_invalidate() the file_map_count will not only decrease once but
> also increase once. Then in set_pte_at(), the file_map_count increase
> again, and so trigger BUG_ON() unexpectedly.

>  static inline bool pmd_user_accessible_page(pmd_t pmd)
>  {
> -       return pmd_leaf(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> +       return pmd_leaf(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd)) && pmd_valid(pmd);
>  }
>
>  static inline bool pud_user_accessible_page(pud_t pud)
>  {
> -       return pud_leaf(pud) && pud_user(pud);
> +       return pud_leaf(pud) && pud_user(pud) && pud_valid(pud);

This looks closer to x86 where the check is directly: pmd_val(pmd) &
_PAGE_PRESENT, without PTE_PROT_NONE that is part of pmd_present()

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thanks,
Pasha
