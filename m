Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B895B3DF5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiIIR2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiIIR2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:28:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0787511B772
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97FDF62071
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 17:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619F1C433D6;
        Fri,  9 Sep 2022 17:28:38 +0000 (UTC)
Date:   Fri, 9 Sep 2022 18:28:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v2] KVM: arm64: Only set KVM_MODE_PROTECTED if
 is_hyp_mode_available()
Message-ID: <Yxt3wmXYYbWraXrd@arm.com>
References: <20220909144552.3000716-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909144552.3000716-1-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 07:45:52AM -0700, Elliot Berman wrote:
> Do not switch kvm_mode to KVM_MODE_PROTECTED if hypervisor mode is not
> available. This prevents "Protected KVM" cpu capability being reported
> when Linux is booting in EL1 and would not have KVM enabled.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  arch/arm64/kvm/arm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 8fe73ee5fa84..861f4b388879 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -2272,7 +2272,9 @@ static int __init early_kvm_mode_cfg(char *arg)
>  		return -EINVAL;
>  
>  	if (strcmp(arg, "protected") == 0) {
> -		if (!is_kernel_in_hyp_mode())
> +		if (!is_hyp_mode_available())
> +			kvm_mode = KVM_MODE_DEFAULT;

I think kvm_mode is already KVM_MODE_DEFAULT at this point. You may want
to print a warning instead.

-- 
Catalin
