Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7F55EF485
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiI2Lmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiI2Lmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:42:50 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD71414FE0B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:42:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 081CACE2185
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A19C433C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664451765;
        bh=R8C++G9yVjwgvqMjhqRqKMSuZQfilkNzr6uk/kuxuGo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WH9SOjOmqxgO/Nwf83BfzJWn5pkQQfwFvgx65m+fn9DJDuAcKYQlmTm+C9b/mTtGa
         8IbSW0gag5BPck7AsAk066x0N0zBmt6LtVh/ZEFVkkdG80vv3nT0JptzWmr0oa9gTB
         VD9glJMAcl3uz8Wo66wCjItA04eH3/3MnbP4aWfH1RFKpY9zhQBxkNntPOrbdeY/0H
         HE6+Wum5r/yAcTKiP8w4aBYb/bZ7Rh49CHnAFbHhPIaA9eWe5dQ71MftDCv9dkAzJm
         lXkR8CCI+TdXH/Mpmx0fYFjwq/luE+jfNxP6mqkfMmfU/V6gIkGo9n1xFJAnJ79xLt
         ii18tkDND6oVQ==
Received: by mail-vs1-f50.google.com with SMTP id j123so1203827vsc.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:42:44 -0700 (PDT)
X-Gm-Message-State: ACrzQf3B3nYgBJ6Q/ntO7lsBAIsRBtrOeSzddbRZDUMvCCzowadT3s9+
        y3qFgY78xOZNDWBOhaSUhNTfUt30hmDmkyPGVn4=
X-Google-Smtp-Source: AMsMyM6Nnt8ZdRe8FMdHl/JPv1eHTDU5Op0EUXbvFWEy78GzfWHyiNuR27dKEVd0bqvRZVt7fePlnxU/4+oWz5pRMMM=
X-Received: by 2002:a05:6102:1481:b0:39a:67f5:3096 with SMTP id
 d1-20020a056102148100b0039a67f53096mr989910vsv.70.1664451763903; Thu, 29 Sep
 2022 04:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220929112318.32393-1-zhengqi.arch@bytedance.com> <20220929112318.32393-3-zhengqi.arch@bytedance.com>
In-Reply-To: <20220929112318.32393-3-zhengqi.arch@bytedance.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 29 Sep 2022 19:42:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H76pOCs2uAA6y1JB+-uwASDBTWk-zaheGdG+ap-4HUZxA@mail.gmail.com>
Message-ID: <CAAhV-H76pOCs2uAA6y1JB+-uwASDBTWk-zaheGdG+ap-4HUZxA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] LoongArch: update local TLB if PTE entry exists
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, maobibo@loongson.cn,
        chenhuacai@loongson.cn, songmuchun@bytedance.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        loongarch@lists.linux.dev, chris@zankel.net, jcmvbkbc@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

Should this patch go via mm tree or loongarch tree? If via mm tree, then

Acked-by: Huacai Chen <chenhuacai@loongson.cn>

On Thu, Sep 29, 2022 at 7:23 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>
> Currently, the implementation of update_mmu_tlb() is empty if
> __HAVE_ARCH_UPDATE_MMU_TLB is not defined. Then if two threads
> concurrently fault at the same page, the second thread that did
> not win the race will give up and do nothing. In the LoongArch
> architecture, this second thread will trigger another fault,
> and only updates its local TLB.
>
> Instead of triggering another fault, it's better to implement
> update_mmu_tlb() to directly update the local TLB of the second
> thread. Just do it.
>
> Suggested-by: Bibo Mao <maobibo@loongson.cn>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  arch/loongarch/include/asm/pgtable.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> index 8ea57e2f0e04..946704bee599 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -412,6 +412,9 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>         __update_tlb(vma, address, ptep);
>  }
>
> +#define __HAVE_ARCH_UPDATE_MMU_TLB
> +#define update_mmu_tlb update_mmu_cache
> +
>  static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>                         unsigned long address, pmd_t *pmdp)
>  {
> --
> 2.20.1
>
>
