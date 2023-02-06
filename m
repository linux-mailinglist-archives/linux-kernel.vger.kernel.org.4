Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD868CAD2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjBFXxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjBFXxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:53:49 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7188E2F7A5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:53:48 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id z22so580002vsq.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 15:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zxq2MjNyjTiKPe+e54ZGdQfseG5oFgTN20Sk0NhevJU=;
        b=KXN7BgkAKRfghoPQliwOEcghdFgCavhapKhYhu24kwgo1ru29J+4xcKmC4xtdC9KnB
         e+KgMvmFy2al1UDxFsGEyqfiooVMqZ3PGqr/IZ1wATNQII0NlTXXsnxJvOtFM7YP54K7
         QogVCLD/z3zYZfadSjEIgQg7MDdnr4DEwhFMA1fzgqfanL8L1R+QSPpi3uHQXBhfgQmR
         lcyqCxPhS4KbzYzCDhIGSTiyfZWQUdVQnP7WguaVNu2eYigQUZvqwUE4+npf+9A4pqix
         lnHfDA8sG/nw1NUDWPiXSFuI9oIq3d0Ah9VcEGAx8Va5azEO5tnkQ94onQs5+pvFoo0B
         PwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxq2MjNyjTiKPe+e54ZGdQfseG5oFgTN20Sk0NhevJU=;
        b=a4J4Oa4Du/PRK8wvBQDLHcKme0vq5T+QMPI18+maoK0nnWC7xHP7+6f0v8RQP5KSpc
         XOqsS8PeV9BhAuhNTAmiYTHX1Cv/Ib1lsQfCy1m1+WvZtJ+YGfZLVOXuSe172nbOJXBA
         0/LCbvSmemRg152jlAKoV8r3TjG+NXWrnS/KE9CXWBs0xPSTfb2R5G4lL1xYgZxx3A+r
         YpN4AI5vdDVkfyYEJVfniUnucByfbRhzmwwJE92dxNu0wEmOW6pXXNUCMJ8oA2+ImgBM
         dAb14bQ1IaA7R6F+wJ/OjU/xEWxXqVXQ+/gYbMhPGBq6Hp8e2Y8ZbZmaC/QwueszIY6z
         c1mQ==
X-Gm-Message-State: AO0yUKXPRxz90TsVj5vb+m+WHnxwiKjTJQxRyviMjTBPBQ0IBKoV6hpj
        KIvSbDIwPX5yoCA74KhBzDNHL6S4vPFehh1ybn64bg==
X-Google-Smtp-Source: AK7set/72A43ENFd2BdH7pYwi9k+sdd+lus7IGlzGM/pZdnZ/Ydu6qyXLx4kzwdB6htpvRUQRWTwIEaUI1SAoeSB88o=
X-Received: by 2002:a05:6102:352:b0:3f2:f733:fb2e with SMTP id
 e18-20020a056102035200b003f2f733fb2emr287571vsa.38.1675727627535; Mon, 06 Feb
 2023 15:53:47 -0800 (PST)
MIME-Version: 1.0
References: <20230203192822.106773-1-vipinsh@google.com> <20230203192822.106773-3-vipinsh@google.com>
In-Reply-To: <20230203192822.106773-3-vipinsh@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Mon, 6 Feb 2023 15:53:21 -0800
Message-ID: <CALzav=d9h-fVgdsK138m74a_qTyay9cprcbdWAJk4GJtw4p6tg@mail.gmail.com>
Subject: Re: [Patch v2 2/5] KVM: x86/mmu: Optimize SPTE change flow for clear-dirty-log
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 11:28 AM Vipin Sharma <vipinsh@google.com> wrote:
>
> diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
> index 30a52e5e68de..21046b34f94e 100644
> --- a/arch/x86/kvm/mmu/tdp_iter.h
> +++ b/arch/x86/kvm/mmu/tdp_iter.h
> @@ -121,4 +121,17 @@ void tdp_iter_start(struct tdp_iter *iter, struct kvm_mmu_page *root,
>  void tdp_iter_next(struct tdp_iter *iter);
>  void tdp_iter_restart(struct tdp_iter *iter);
>
> +static inline u64 kvm_tdp_mmu_clear_spte_bit(struct tdp_iter *iter, u64 mask)
> +{
> +       atomic64_t *sptep;
> +
> +       if (kvm_tdp_mmu_spte_has_volatile_bits(iter->old_spte, iter->level)) {
> +               sptep = (atomic64_t *)rcu_dereference(iter->sptep);
> +               return (u64)atomic64_fetch_and(~mask, sptep);

I think you can just set iter->old_spte here and drop the return value?

> +       }
> +
> +       __kvm_tdp_mmu_write_spte(iter->sptep, iter->old_spte & ~mask);
> +       return iter->old_spte;
> +}
