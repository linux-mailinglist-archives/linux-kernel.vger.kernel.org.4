Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4551D709AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjESPNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjESPNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:13:00 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28569CF
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:12:59 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-530277cf88bso2967302a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684509178; x=1687101178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4cy+s/+PbSrG6W72TYvOzX2XvryhO6RUdGZ+J49Gmw=;
        b=S+f50qtCubY6S13NpeuUqBnZCsTmxyHsKs8DUvTT4n6/nDJ61XywhI9dyaR5ScV2Rj
         sZafQdcr3KAGA2Pp4FNrh8kuzotfG76alQIZixAy2/q1mbVfouP39ioGh7OfEJh/Km69
         t0CzH7oc5pOte2TZIomKTvi9gIAJxJ+WTr9WPpZRMDDsmK0SlW4gkFgKYePnvGOd2Njf
         7chnEs3opsvniNaOFFVtVkzbVB2Vf6akAPaiRrMK6ImMiTup6SSyMJfh3riRtLgzbyFN
         qbqA6zsAIaenfZ7oLpWnJ6VmNDsqB0QYeeTLvH8Hzt4B4Fx/gNRJS3yYyjU4R7y+1XIo
         BXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684509178; x=1687101178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4cy+s/+PbSrG6W72TYvOzX2XvryhO6RUdGZ+J49Gmw=;
        b=SeO0FI7kJ2MDf43kYsHniLlYqQJ/xT7JwtGYQdZ3SyvgRrJqMYuNeN3oIisPkoYEYw
         mMJ5yA5vTHsbJbARpJ4vnq0aPQZKEosI/R5AE6oj6MvvOYup4iHplsPv8ktAXvb8IBQT
         /yGL0Yj5nJFeYeFUFi3XpdOA6AstecZPLWKPTnicrMzKCTwDi8XiiOzEkFH5prhLkvLq
         WCYWoJz7l4VQJmTjox0LFat28UpNy2JRu3V25pkEgCjrETb6UCjZephbs3s7A6wJz4oY
         0TOYGDqjpjP7RR6tYtsUdPzi+I2GxoJmhmf8w3QXCd3Mcl7yQ6Zx7lfuyX1LDPCZL1NU
         o90g==
X-Gm-Message-State: AC+VfDwJADYnnRy7/B1UHkWjC7dJrtTfZf1xNL3JQRjUnoXAVd2TSoMc
        NuQ3uVT9/gseLsc79NzSe6pKsTzg61k=
X-Google-Smtp-Source: ACHHUZ6uio+4NuEonj0KDV5lmdUQUKHOL2GYz3vWNxvmMQd58oS3kzQQglzbMFjsgcfLrjqsdmOUhJYk1ns=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:cec2:b0:1a2:87a2:c932 with SMTP id
 d2-20020a170902cec200b001a287a2c932mr749152plg.10.1684509178646; Fri, 19 May
 2023 08:12:58 -0700 (PDT)
Date:   Fri, 19 May 2023 08:12:57 -0700
In-Reply-To: <20230519081711.72906-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20230519081711.72906-1-likexu@tencent.com>
Message-ID: <ZGeR+bRA56KgEf/2@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Drop "struct kvm_mmu *mmu" from __kvm_mmu_invalidate_addr()
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> Remove incoming parameter "struct kvm_mmu *mmu" that are no longer used.
> Whether the func is using "vcpu->arch.root_mmu" or "vcpu->arch.guest_mmu",
> it can be referenced as expected via "vcpu->arch.mmu". Thus the "*mmu"
> is replaced by the use of "vcpu->arch.mmu" in commit 19ace7d6ca15 ("KVM:
> x86/mmu: Skip calling mmu->sync_spte() when the spte is 0").
> 
> No functional change is intended.
> 
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index c8961f45e3b1..160c40c83330 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5790,8 +5790,8 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
>  }
>  EXPORT_SYMBOL_GPL(kvm_mmu_page_fault);
>  
> -static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> -				      u64 addr, hpa_t root_hpa)
> +static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, u64 addr,
> +				      hpa_t root_hpa)
>  {
>  	struct kvm_shadow_walk_iterator iterator;

Oof, there's a mess waiting to happen here.  for_each_shadow_entry_using_root()
and kvm_sync_spte() do indeed operate on vcpu->arch.mmu, but the only reason that
doesn't cause explosions is because handle_invept() frees roots instead of doing
a manual invalidation.  At a glance, I don't see any major roadblocks to switching
INVEPT emulation over to use kvm_mmu_invalidate_addr().

I'm leaning towards asserting on @mmu instead of deleting it.

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c8961f45e3b1..258f12235874 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5797,6 +5797,14 @@ static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu
 
 	vcpu_clear_mmio_info(vcpu, addr);
 
+	/*
+	 * Walking and synchronizing SPTEs both assume they are operating in
+	 * the context of the current MMU, and would need to be reworked if
+	 * this is ever used to sync the guest_mmu, e.g. to emulate INVEPT.
+	 */
+	if (WARN_ON_ONCE(mmu != vcpu->arch.mmu))
+		return;
+
 	if (!VALID_PAGE(root_hpa))
 		return;
 

base-commit: 5c291b93e5d665380dbecc6944973583f9565ee5
-- 
