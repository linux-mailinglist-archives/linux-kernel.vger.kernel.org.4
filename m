Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FC568C451
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjBFRNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjBFRNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:13:19 -0500
Received: from out-82.mta0.migadu.com (out-82.mta0.migadu.com [91.218.175.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F9211658
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:13:12 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675703590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2vII0gLu68kSuBCcExcNCtXjKdRpzzjDFHCPp8egne4=;
        b=UquOkQo+cdHwkgxsDiSw5Ekm1UrcIziy+pGPxa6B4zhpqZxLSovf0DU4J8ASia+yMbqK5E
        XucgPpDR8o0M4KOoG4TVUPR1M7sYxLmWU/WPpPuWH/RR87nDTwZP1Xr4T1gNSaaHkwYWUB
        1W5XFq7Vg1vypqQw0MmlB6xRWGDv9a4=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] KVM: arm64: Fix CPU resume/on with pKVM
Date:   Mon,  6 Feb 2023 17:12:59 +0000
Message-Id: <167570355326.3822888.6416716908821358162.b4-ty@linux.dev>
In-Reply-To: <20230201103755.1398086-1-qperret@google.com>
References: <20230201103755.1398086-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2023 10:37:50 +0000, Quentin Perret wrote:
> When using pKVM, we do not reset the EL2 exception vectors back to the
> stubs for e.g. Power Management or CPU hotplug as we normally do in KVM.
> As consequence, the initialisation perfomed by __finalise_el2 is missing
> on e.g. the CPU_RESUME path with pKVM, hence leaving certain registers
> in an incorrect state.
> 
> One such example is ZCR_EL2 which remains configured with SVE traps
> enabled. And so using SVE on a CPU that has gone through a hotplug
> off/on cycle leads to a hyp panic. Not good.
> 
> [...]

Applied to kvmarm/next, thanks!

[1/4] KVM: arm64: Provide sanitized SYS_ID_AA64SMFR0_EL1 to nVHE
      https://git.kernel.org/kvmarm/kvmarm/c/8669651ce0d9
[2/4] KVM: arm64: Introduce finalise_el2_state macro
      https://git.kernel.org/kvmarm/kvmarm/c/e2d4f5ae1771
[3/4] KVM: arm64: Use sanitized values in __check_override in nVHE
      https://git.kernel.org/kvmarm/kvmarm/c/3c4cc31537ec
[4/4] KVM: arm64: Finalise EL2 state from pKVM PSCI relay
      https://git.kernel.org/kvmarm/kvmarm/c/6f10f2ec61c7

--
Best,
Oliver
