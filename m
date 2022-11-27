Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3AC639A4D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiK0MEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiK0MEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:04:30 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65451F009
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 04:04:29 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z20so11988059edc.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 04:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=De+5l1xEgoXB7FNa4tg4HfrVAuuxUoNVJkryeDf0EOs=;
        b=0R4ABPMda0JKrV6c2Z7FSfz2HeRwIqis3ahHt3e2bNFs04gENMcHGKm538cKYbwU2q
         CvScJMbfoGvowwcwjjY8XPQAXJdKgaJIcniIYt2R0ZUP1qJi6FyQdeGiEKnmxUCWm3N1
         kPIUKWCeWRChnYFhm2D1ePsWkyZFCWZp2Ff1hiIwTF5iHVoyANvJqgo1QpbV83OenrXv
         Zz/vC48dUCuFfadbkFlX/2ypf8ZV6u7o3HPfqmyBWh4NU9EKldYRFjcwL7E+qzdGp1uM
         DAYdVwEvZVf2yB4bRUivUCM3thYOV40EiZsb8HZkaQu2lxBZ6YnELg/GW4LqZRMhhoeo
         6zxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=De+5l1xEgoXB7FNa4tg4HfrVAuuxUoNVJkryeDf0EOs=;
        b=bKt6YsPl03Ij/W3j0ETMD2q0sOuHUYXT9/I+j/zza4IEUuGIiexH45ijU7Gmbt+fKs
         uSA51f2NkegvpJ7FNNqh7xvWHzC/M/2VV1wIqmQFY1ImSFCxbndwxLNT0UCDwaM9ed/M
         DrkCUYB1iG2mvEIJnqJV4FeQCG1Hcis4ZrTCSf1syrdCZ11CdNB3TB2ktRHIpfIUirhZ
         KjWPIQG9mCqBbl9nFBSqcFRpsMtH6AaIjKtOPbNRbZ0WA4zGH0vGT1V51bBjXn9puN/h
         hoPGQ1mqMevlywh2bsKqD37JbA//0dZVbgFWx0fjqvHOqE9IBnLkof4mux6HBEQKdwrc
         7l6w==
X-Gm-Message-State: ANoB5pmz1zuqUps6RnxD+zEVFafuKnspIHoC+ge31k1x99EAPrOyWmqa
        EnDzHkXiXtebLBqKU2xRt1mASKjYs9VmbJAdqdSMcQ==
X-Google-Smtp-Source: AA0mqf66R2SJvhmt7UjDg/avS8f9xHQnlUWA0xIT+F9M17TPUZQlaiwzfJuCRCRQs8kCMs6pNIRPgGyJfCOvWzRVS1s=
X-Received: by 2002:aa7:c859:0:b0:461:17e9:4ea3 with SMTP id
 g25-20020aa7c859000000b0046117e94ea3mr43421493edt.49.1669550667865; Sun, 27
 Nov 2022 04:04:27 -0800 (PST)
MIME-Version: 1.0
References: <20221101053811.5884-1-liubo03@inspur.com>
In-Reply-To: <20221101053811.5884-1-liubo03@inspur.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 27 Nov 2022 17:34:15 +0530
Message-ID: <CAAhSdy0t1XGTENidgNQkQ5m5emZOes+-2RXTPLEJ0tEZXuX2hA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: use vma_lookup() instead of find_vma_intersection()
To:     Bo Liu <liubo03@inspur.com>
Cc:     atishp@atishpatra.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 11:08 AM Bo Liu <liubo03@inspur.com> wrote:
>
> vma_lookup() finds the vma of a specific address with a cleaner interface
> and is more readable.
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Looks good to me.

Queued this patch for Linux-6.2

Thanks,
Anup

> ---
>  arch/riscv/kvm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 3620ecac2fa1..5942d10c9736 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -632,7 +632,7 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
>
>         mmap_read_lock(current->mm);
>
> -       vma = find_vma_intersection(current->mm, hva, hva + 1);
> +       vma = vma_lookup(current->mm, hva);
>         if (unlikely(!vma)) {
>                 kvm_err("Failed to find VMA for hva 0x%lx\n", hva);
>                 mmap_read_unlock(current->mm);
> --
> 2.27.0
>
