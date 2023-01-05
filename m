Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A389F65F6A1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbjAEWWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbjAEWWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:22:13 -0500
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0F06B198
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 14:22:10 -0800 (PST)
Date:   Thu, 5 Jan 2023 22:22:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672957328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jUI9TSiA75B4vjGbap/Y0EjPHoVUu/AzEKZE5jFgpHg=;
        b=QW44AXC4DbOOKrF4eAPSNoVRO42xVcoshBgAnnxFHEhd3hKj0mII5TWxIkNdocZG9Kz7bs
        JVJXFN1rQ2WxSJ46GXjpk2quWO3M4EWu/UXD2yRhm0nM/WKX4CTJQFwJtxc5+H900NnXpR
        PN/h8KcFXMfMKaZcQRnR4HyPcLCEpGM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v5 6/7] KVM: arm64: Mask FEAT_CCIDX
Message-ID: <Y7dNihZMs4NSSw0v@google.com>
References: <20221230095452.181764-1-akihiko.odaki@daynix.com>
 <20221230095452.181764-7-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230095452.181764-7-akihiko.odaki@daynix.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 06:54:51PM +0900, Akihiko Odaki wrote:
> The CCSIDR access handler masks the associativity bits according to the
> bit layout for processors without FEAT_CCIDX. KVM also assumes CCSIDR is
> 32-bit where it will be 64-bit if FEAT_CCIDX is enabled. Mask FEAT_CCIDX
> so that these assumptions hold.
> 
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

FYI, I'm an idiot and replied to v4 of this patch... Forwarding comments
below:

> ---
>  arch/arm64/kvm/sys_regs.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index f4a7c5abcbca..aeabf1f3370b 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1124,6 +1124,12 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu, struct sys_reg_desc const *r
>  						      ID_DFR0_PERFMON_SHIFT,
>  						      kvm_vcpu_has_pmu(vcpu) ? ID_DFR0_PERFMON_8_4 : 0);
>  		break;
> +	case SYS_ID_AA64MMFR2_EL1:
> +		val &= ~ID_AA64MMFR2_EL1_CCIDX_MASK;
> +		break;
> +	case SYS_ID_MMFR4_EL1:
> +		val &= ~ARM64_FEATURE_MASK(ID_MMFR4_CCIDX);
> +		break;

Not that it is necessarily worth addressing, but I wanted to point
something out.

This change breaks migration from older kernels on implementations w/
FEAT_CCIDX. There is most likely exactly 0 of those in the wild, but
we need to be careful changing user-visible stuff like this.

--
Thanks,
Oliver
