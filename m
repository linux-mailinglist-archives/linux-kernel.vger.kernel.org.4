Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0261F6787AC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjAWUZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjAWUZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:25:17 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D63367EE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:25:12 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674505510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=au8ZWtE9bpKXrUx2+rVz6YucHx64Tiv6wraMR9Ps5aI=;
        b=H4xc2VK1l42xb06YdwJ3PNziW3+B/OpaCye3SvNxBARlyaMHg5CpkcBk+GfaflhfEuqz6i
        36ZixVWK8UOQ+mvVr0SRsSPUQ8HQJ+d90QOnzABLF8NY7pNdVDHMQnr7bg1ecdh84hoOKe
        RK6qs+CVXW4/gdorAqT6MrwQrm2Aw0g=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Hector Martin <marcan@marcan.st>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v7 0/7] KVM: arm64: Normalize cache configuration
Date:   Mon, 23 Jan 2023 20:24:56 +0000
Message-Id: <167450318853.2568505.3166405888000533001.b4-ty@linux.dev>
In-Reply-To: <20230112023852.42012-1-akihiko.odaki@daynix.com>
References: <20230112023852.42012-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 11:38:45 +0900, Akihiko Odaki wrote:
> Before this change, the cache configuration of the physical CPU was
> exposed to vcpus. This is problematic because the cache configuration a
> vcpu sees varies when it migrates between vcpus with different cache
> configurations.
> 
> Fabricate cache configuration from the sanitized value, which holds the
> CTR_EL0 value the userspace sees regardless of which physical CPU it
> resides on.
> 
> [...]

Applied to kvmarm/next, thanks!

[1/7] arm64: Allow the definition of UNKNOWN system register fields
      https://git.kernel.org/kvmarm/kvmarm/c/e2c0b51f1c9d
[2/7] arm64/sysreg: Convert CCSIDR_EL1 to automatic generation
      https://git.kernel.org/kvmarm/kvmarm/c/d1a0eb124c44
[3/7] arm64/sysreg: Add CCSIDR2_EL1
      https://git.kernel.org/kvmarm/kvmarm/c/8f407d6a15f3
[4/7] arm64/cache: Move CLIDR macro definitions
      https://git.kernel.org/kvmarm/kvmarm/c/805e6ec1c5e0
[5/7] KVM: arm64: Always set HCR_TID2
      https://git.kernel.org/kvmarm/kvmarm/c/8cc6dedaff42
[6/7] KVM: arm64: Mask FEAT_CCIDX
      https://git.kernel.org/kvmarm/kvmarm/c/bf48040cd9b0
[7/7] KVM: arm64: Normalize cache configuration
      https://git.kernel.org/kvmarm/kvmarm/c/7af0c2534f4c

--
Best,
Oliver
