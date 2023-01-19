Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC36674334
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjAST4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjAST4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:56:23 -0500
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Jan 2023 11:56:21 PST
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A618030EE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:56:21 -0800 (PST)
Date:   Thu, 19 Jan 2023 19:46:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674157581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ny5pbFcUDicEKi2kQlKMNoopMQxdvl4TAC0NXH0FWZc=;
        b=lQclnKO49SxNR+ip+srDOZF4ojQRaxsKsDP61gap4s4i2v1bZmFg0XsAF39r6FsaTjUS3V
        V6lZh7A2hzM1Jefk9R1hMMoYohp4/1i8UM7GYMSopzrNUMbfTn5BqZ8vkBY4ajH8SrOu8l
        7N7ix/3EhvbqAfTJqoe1qdMbq6iKJKE=
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
Subject: Re: [PATCH v7 7/7] KVM: arm64: Normalize cache configuration
Message-ID: <Y8meCFkrVXurXlTk@google.com>
References: <20230112023852.42012-1-akihiko.odaki@daynix.com>
 <20230112023852.42012-8-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112023852.42012-8-akihiko.odaki@daynix.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akihiko,

On Thu, Jan 12, 2023 at 11:38:52AM +0900, Akihiko Odaki wrote:
> Before this change, the cache configuration of the physical CPU was
> exposed to vcpus. This is problematic because the cache configuration a
> vcpu sees varies when it migrates between vcpus with different cache
> configurations.
> 
> Fabricate cache configuration from the sanitized value, which holds the
> CTR_EL0 value the userspace sees regardless of which physical CPU it
> resides on.
> 
> CLIDR_EL1 and CCSIDR_EL1 are now writable from the userspace so that
> the VMM can restore the values saved with the old kernel.
> 
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

I needed to squash in the patch below to get all of this working.
Writing back the value read for a given cache level was failing, which I
caught with the get-reg-list selftest.

Pushed the result here if you want to have a look:

  https://github.com/oupton/linux/tree/kvm-arm64/virtual-cache-geometry

--
Thanks,
Oliver

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 459e6d358dab..b6228f7d1d8d 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -148,17 +148,19 @@ static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
 
 static int set_ccsidr(struct kvm_vcpu *vcpu, u32 csselr, u32 val)
 {
-	u8 line_size = FIELD_GET(CCSIDR_EL1_LineSize, val);
+	u8 line_size = SYS_FIELD_GET(CCSIDR_EL1, LineSize, val);
+	u32 cur = get_ccsidr(vcpu, csselr);
+	u8 min_line_size = SYS_FIELD_GET(CCSIDR_EL1, LineSize, cur);
 	u32 *ccsidr = vcpu->arch.ccsidr;
 	u32 i;
 
-	if ((val & CCSIDR_EL1_RES0) || line_size < get_min_cache_line_size(csselr))
+	if (cur == val)
+		return 0;
+
+	if ((val & CCSIDR_EL1_RES0) || line_size < min_line_size)
 		return -EINVAL;
 
 	if (!ccsidr) {
-		if (val == get_ccsidr(vcpu, csselr))
-			return 0;
-
 		ccsidr = kmalloc_array(CSSELR_MAX, sizeof(u32), GFP_KERNEL);
 		if (!ccsidr)
 			return -ENOMEM;
