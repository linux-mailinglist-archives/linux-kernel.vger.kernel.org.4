Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18196E6728
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjDRO34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjDRO3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:29:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFBA0C676
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:29:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65F971684;
        Tue, 18 Apr 2023 07:30:32 -0700 (PDT)
Received: from [10.1.27.157] (C02CF1NRLVDN.cambridge.arm.com [10.1.27.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86F483F587;
        Tue, 18 Apr 2023 07:29:47 -0700 (PDT)
Message-ID: <f299a82a-a048-3f28-876d-65205f48c1b5@arm.com>
Date:   Tue, 18 Apr 2023 15:29:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v3 55/60] arm64: kvm: avoid CONFIG_PGTABLE_LEVELS for
 runtime levels
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-56-ardb@kernel.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230307140522.2311461-56-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 14:05, Ard Biesheuvel wrote:
> get_user_mapping_size() uses vabits_actual and CONFIG_PGTABLE_LEVELS to
> provide the starting point for a table walk. This is fine for LVA, as
> the number of translation levels is the same regardless of whether LVA
> is enabled. However, with LPA2, this will no longer be the case, so
> let's derive the number of levels from the number of VA bits directly.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/kvm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index d64be7b5f6692e8b..4e7c0f9a9c286c09 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -663,7 +663,7 @@ static int get_user_mapping_size(struct kvm *kvm, u64 addr)
>  		.pgd		= (kvm_pteref_t)kvm->mm->pgd,
>  		.ia_bits	= vabits_actual,
>  		.start_level	= (KVM_PGTABLE_MAX_LEVELS -
> -				   CONFIG_PGTABLE_LEVELS),
> +				   ARM64_HW_PGTABLE_LEVELS(pgt.ia_bits)),
>  		.mm_ops		= &kvm_user_mm_ops,
>  	};
>  	kvm_pte_t pte = 0;	/* Keep GCC quiet... */

You have the problem here that the KVM library (which isn't LPA2 aware) is
walking a kernel page table, which may now be in LPA2 format. I think this works
out ok as long as there are no physical addresses above 48 bits in the page
table. But otherwise, I doubt it works out very well...
