Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F4D712E20
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbjEZUZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjEZUZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:25:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B70E7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:25:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb79a17b8so1580326276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685132720; x=1687724720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxOQ4gCfGSTF1dpRyqdlhwmp7zJADkZ+djJftuD+6KU=;
        b=bv8Q200Y/wyD/a4gX1QQFcREfDoKLvd7WokdjdD5nz8PpN/+7BVVXYN29de96CWsln
         I/ECPDziCYNJEHmBHMMkIq+h61MgVtYTqWcUDZH4D/TQU++myPkUdMX9R30L0vZdQEwh
         LUMPUgenfwpTZZ3tINAAVhldkz0yyiolHqUZseh63bci8Cbu0h3/8SHb4sUOk/r6TYQd
         FW2hIj5DsvBoOUUqC6x99Ao6ObVtQCFTqpq4nSQ2seC5yWIZJRcuVQEFj+2i6PfuaqDW
         fgX35MqvtJikQAX7YvaRp4vS7dsJVzxqGwJuP/C34ubjHLYVuI/Fyi9AiV+9RPNJMek1
         R22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685132720; x=1687724720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxOQ4gCfGSTF1dpRyqdlhwmp7zJADkZ+djJftuD+6KU=;
        b=h+Bga6+vAKfrDOww1QtVYNHhpbfzJkMx8hBs/TzbpPnBYrcOlPa9/U01pfeq47MzsS
         eiGQvpMQjBI/t/zIhGNn0JyiLLJNKK/qfM5Gnb6Wb1JKUAW9/pjLfD0SfnXYptYNFVqU
         gWekTZjeZxanKmDmfCsapcmpZkvhMblyw2yGA/pyULCJBt0Io9KOPGMYj1E9kAfbUl4p
         lZwzZmJCFcTxhnK+3vD4pXfKSm1QCDseG9KjpuqkhWrYjhpN60QhUYUTMIhlWP89sbx0
         +l7svTKYzcR+zH/Adr9+B6Xtw4z4rvl6qwmR6vwxfyx8Klr6KTKRbqEfpWepknIqNnvi
         /wNQ==
X-Gm-Message-State: AC+VfDyFCO82UCB6pqO72Qrhx3hQduA1w8x9kvbH+O6tTim+ckQh5RAG
        Jg3/DMo+uM5qywB6ujxjyGv1iccWiOQ=
X-Google-Smtp-Source: ACHHUZ6ah9AHKvfFOMGqWcnXv0bilVsz0AIcmTATSpO0d1/88Bq2t/Bl4Eibgwmo7HC2aCPXJG9WDZYIiqk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:3cb:0:b0:bad:99d:f087 with SMTP id
 194-20020a2503cb000000b00bad099df087mr1578238ybd.6.1685132719909; Fri, 26 May
 2023 13:25:19 -0700 (PDT)
Date:   Fri, 26 May 2023 13:25:18 -0700
In-Reply-To: <20230413175844.21760-1-itazur@amazon.com>
Mime-Version: 1.0
References: <20230413175844.21760-1-itazur@amazon.com>
Message-ID: <ZHEVrowZsi2j6dVI@google.com>
Subject: Re: [PATCH v2] KVM: x86: Update KVM_GET_CPUID2 to return valid entry count
From:   Sean Christopherson <seanjc@google.com>
To:     Takahiro Itazuri <itazur@amazon.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, Takahiro Itazuri <zulinx86@gmail.com>
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

On Thu, Apr 13, 2023, Takahiro Itazuri wrote:
> Modify the KVM_GET_CPUID2 API to return the number of valid entries in
> nent field of kvm_cpuid2 even on success.
> 
> Previously, the KVM_GET_CPUID2 API only updated the nent field when an
> error was returned. If the API was called with an entry count larger
> than necessary (e.g., KVM_MAX_CPUID_ENTRIES), it would succeed, but the
> nent field would continue to show a value larger than the actual number
> of entries filled by the KVM_GET_CPUID2 API. With this change, users can
> rely on the updated nent field and there is no need to traverse
> unnecessary entries and check whether an entry is valid or not.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
> ---
> Changes
> v1 -> v2
> * Capitalize "kvm" in the commit title.
> * Remove a scratch "nent" variable.
> * Link to v1: https://lore.kernel.org/all/20230410141820.57328-1-itazur@amazon.com/
> 
>  arch/x86/kvm/cpuid.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 599aebec2d52..20d28ebdc672 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -523,18 +523,18 @@ int kvm_vcpu_ioctl_get_cpuid2(struct kvm_vcpu *vcpu,
>  			      struct kvm_cpuid2 *cpuid,
>  			      struct kvm_cpuid_entry2 __user *entries)
>  {
> -	int r;
> +	int r = 0;
>  
> -	r = -E2BIG;
>  	if (cpuid->nent < vcpu->arch.cpuid_nent)
> -		goto out;
> -	r = -EFAULT;
> -	if (copy_to_user(entries, vcpu->arch.cpuid_entries,
> +		r = -E2BIG;
> +	else if (copy_to_user(entries, vcpu->arch.cpuid_entries,
>  			 vcpu->arch.cpuid_nent * sizeof(struct kvm_cpuid_entry2)))
> -		goto out;
> -	return 0;
> +		r = -EFAULT;
>  
> -out:
> +	/*
> +	 * Update "nent" even on failure, e.g. so that userspace can fix an
> +	 * -E2BIG issue by allocating a larger array.
> +	 */

Gah, this is wrong.  The caller only copies @cpuid to userspace on success.  My
fault for not seeing this in v1, but this is exactly why we write tests.

I've written a test and a fix, I'll post 'em shortly.
