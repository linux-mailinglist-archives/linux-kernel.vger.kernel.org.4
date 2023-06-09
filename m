Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCEE729D53
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbjFIOvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241586AbjFIOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:51:19 -0400
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FF435B0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:51:16 -0700 (PDT)
Date:   Fri, 9 Jun 2023 14:51:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686322274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ugtlLEv+hNjZV95DRBMsv7OADrgkWrCWZxoVXaMhWzM=;
        b=wl6Gjiblbj7fO7EYBkWbx3a+IBk/MtpnHPpaMubTxoj53g8s2Rcx5xm94W51E8Oty9MV90
        cvORNsoiQS5rS0pvl5s4vyD4mD83CYpo+bTyXAxRUZ8YydHp9RQxnxX2HDpIuwP3m6CXIO
        yTZCuO9vIGnNChBfIdcd4VlXZosEqHw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Chun-Tse Shao <ctshao@google.com>
Cc:     linux-kernel@vger.kernel.org, yuzhao@google.com,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ben Gardon <bgardon@google.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v1 3/3] KVM: arm64: Using rcu_read_lock() for
 kvm_pgtable_stage2_mkyoung()
Message-ID: <ZIM8XccN31XSb+Qh@linux.dev>
References: <20230608220558.39094-1-ctshao@google.com>
 <20230608220558.39094-4-ctshao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608220558.39094-4-ctshao@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 03:05:41PM -0700, Chun-Tse Shao wrote:
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 3b9d4d24c361..0f7ea66fb894 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1437,10 +1437,10 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
>  
>  	trace_kvm_access_fault(fault_ipa);
>  
> -	read_lock(&vcpu->kvm->mmu_lock);
> +	rcu_read_lock();
>  	mmu = vcpu->arch.hw_mmu;
>  	pte = kvm_pgtable_stage2_mkyoung(mmu->pgt, fault_ipa);
> -	read_unlock(&vcpu->kvm->mmu_lock);
> +	rcu_read_unlock();

What is the point of acquiring the RCU read lock here?
kvm_pgtable_walk_{begin,end}() already do the exact same for any
'shared' walk.

I agree with Marc that this warrants some very clear benchmark data
showing the value of the change. As I had mentioned to Yu, I already
implemented this for my own purposes, but wasn't able to see a
significant improvement over acquiring the MMU lock for read.

-- 
Thanks,
Oliver
