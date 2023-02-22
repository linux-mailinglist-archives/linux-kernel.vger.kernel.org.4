Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361FD69FB98
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjBVS4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjBVS4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:56:07 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1B02CFC1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:56:07 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id q5-20020a170902788500b0019b0c60afa8so5153484pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YG/yZ5MTiTnKi2W7bMShINtpnN93/lRwNEGmf8C47/k=;
        b=i7NxihAfFbYYyyjyGZS5DuxZ+rdpbqpMY22wBJwiDd7BFosm05z+sDb9ryNRWqEp4m
         4gmmFZM8bOZqjrLiO9iZwZmYN7QxeZkqJvXq3UNXdyTCNzpGPb1yaEIg7OJT8shdOpXV
         faKw1iVPqQ0+iDqhlV/a3VUNKw4kUAWkRfe8qQ4tiNrHe+pdgk66DWqiWC87nVQJWs0p
         KDNRGM/EGoHuNknc1iYNTESyY8gIcZr8upA+hLIjili0eyhK1ReJ/K2PRoXfc4pf16Af
         pLmwmxDD9V5rScr7Spq5g+RbCRYQJw35sbY9cq/09K6mhCD0feN+tuiy+BmQGQ4/fcNX
         j25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YG/yZ5MTiTnKi2W7bMShINtpnN93/lRwNEGmf8C47/k=;
        b=r4bCUXhCu7kIee4yz+T/JIxaNt/Yw621VH6Po6Q/dHN9IN64nhG3yPFs7F/qyfNl3S
         YJwS19Z7Q2UVyptk/uCjn9KyJWFe7byRzEqPWPPeAI9vNxzCzOz4wwsCzNw+oo++y7Jz
         Z0du+p8IcfgkO0UCnDZOInv0FJfNFWue6u6HqRW8kBd5cinJ82/vH6Fla35MPwEcUhwL
         0mGrHC3rQs5Iqvm8JcvuMcgyQB34WVDNdltg5Xail7Pl2PHCrgwLPCZFvLK4MPB1NymU
         y5UaH6k7KBPmNGQB5vYzdKx5lPuX81ISGhRcTTy8OJIKKW2dl3g3ipFHODnPQKERGnWw
         6zpg==
X-Gm-Message-State: AO0yUKUy9cycdfE4TcGG+adpy4k1BmGxZblQNY7mxa7cqyh45jCWN7Dh
        HmW/PRjz+WmuQ+Hd/+Lxjzux5msRJvE=
X-Google-Smtp-Source: AK7set/nADglnCxuPPrBhMotCwjpTkh0FxC6vVPmRgUyX6Vl9bPXUNIGGPML4QUYJ+tjMjrKKd5pFf5u2MM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:7b58:0:b0:502:d7c8:882d with SMTP id
 k24-20020a637b58000000b00502d7c8882dmr848071pgn.3.1677092166518; Wed, 22 Feb
 2023 10:56:06 -0800 (PST)
Date:   Wed, 22 Feb 2023 10:56:04 -0800
In-Reply-To: <20230221145610.ytlj5nkqsscc2yxo@linux.intel.com>
Mime-Version: 1.0
References: <20230217231022.816138-1-seanjc@google.com> <20230217231022.816138-6-seanjc@google.com>
 <20230221145610.ytlj5nkqsscc2yxo@linux.intel.com>
Message-ID: <Y/ZlRDuRivMDKGwo@google.com>
Subject: Re: [PATCH 05/12] KVM: x86: Use KVM-governed feature framework to
 track "XSAVES enabled"
From:   Sean Christopherson <seanjc@google.com>
To:     Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023, Yu Zhang wrote:
> On Fri, Feb 17, 2023 at 03:10:15PM -0800, Sean Christopherson wrote:
> > Use the governed feature framework to track if XSAVES is "enabled", i.e.
> > if XSAVES can be used by the guest.  Add a comment in the SVM code to
> > explain the very unintuitive logic of deliberately NOT checking if XSAVES
> > is enumerated in the guest CPUID model.
> > 
> > No functional change intended.
> 
> xsaves_enabled in struct kvm_vcpu_arch is no longer used. But instead of
> just deleting it, maybe we could move 'bool load_eoi_exitmap_pending' to
> its place, so 7 bytes can be saved for each struct kvm_vcpu_arch:

I prefer leaving load_eoi_exitmap_pending where it is so that it's co-located with
ioapic_handled_vectors.  I agree wasting 7 bytes is unfortunate, but I don't want
to take an ad hoc approach to shrinking per-vCPU structs.  See the link below for
more discussion.

https://lore.kernel.org/all/20230213163351.30704-1-minipli@grsecurity.net

> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index cd660de02f7b..0eef5469c165 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -740,7 +740,6 @@ struct kvm_vcpu_arch {
>         u64 efer;
>         u64 apic_base;
>         struct kvm_lapic *apic;    /* kernel irqchip context */
> -       bool load_eoi_exitmap_pending;
>         DECLARE_BITMAP(ioapic_handled_vectors, 256);
>         unsigned long apic_attention;
>         int32_t apic_arb_prio;
> @@ -750,7 +749,7 @@ struct kvm_vcpu_arch {
>         u64 smi_count;
>         bool at_instruction_boundary;
>         bool tpr_access_reporting;
> -       bool xsaves_enabled;
> +       bool load_eoi_exitmap_pending;
>         bool xfd_no_write_intercept;
>         u64 ia32_xss;
>         u64 microcode_version;
> 
> B.R.
> Yu
> 
