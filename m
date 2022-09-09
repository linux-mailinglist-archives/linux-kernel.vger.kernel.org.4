Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFED5B3819
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiIIMo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIIMoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:44:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52149E3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E078061FD8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FCDC433D6;
        Fri,  9 Sep 2022 12:44:19 +0000 (UTC)
Date:   Fri, 9 Sep 2022 13:44:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH] KVM: arm64: Report Protected KVM cap only if KVM is
 enabled
Message-ID: <Yxs1H3+iI8Y7+Zbu@arm.com>
References: <20220902040122.346654-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902040122.346654-1-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:01:22PM -0700, Elliot Berman wrote:
> If "kvm-arm.mode=protected" is present on kernel command line, but the
> kernel doesn't actually support KVM because it booted from EL1, the
> ARM64_KVM_PROTECTED_MODE capability is misleadingly reported as present.
> Fix this by adding a check whether we booted from EL2.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: David Brazdil <dbrazdil@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 8d88433de81d..866667be0651 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1974,7 +1974,7 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
>  #ifdef CONFIG_KVM
>  static bool is_kvm_protected_mode(const struct arm64_cpu_capabilities *entry, int __unused)
>  {
> -	return kvm_get_mode() == KVM_MODE_PROTECTED;
> +	return is_hyp_mode_available() && kvm_get_mode() == KVM_MODE_PROTECTED;
>  }
>  #endif /* CONFIG_KVM */

Could we not fix this in early_kvm_mode_cfg()?

-- 
Catalin
