Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC64E65BD71
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbjACJuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjACJuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:50:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E275EE19
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:50:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C00856122B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0DAC433D2;
        Tue,  3 Jan 2023 09:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672739413;
        bh=ksABWOILjZpEH8g2g2MW4ZIXOmX06sjGYHgn9lXfTFo=;
        h=From:To:Cc:Subject:Date:From;
        b=ntAogpfdgc+AQKbqXTyAGwrZhVfC8jfZVkb7vMmvM7M3ahQE/MIr5gsx22X///eHL
         SpC5JwU8WeS91c+uHIcZVWEWY+U7Isa6FjPMqLJ7gpFu0ByDcQ6YF5rZwupH0bEBsR
         Bi3+9/GgWYgnVjM0WI+HFv6KRszTSfKVvfMMsM8F3pNt3VtPO+2Im7ynCpTwJEbjhX
         wNEmhj6LGLYWazn4vOd3UE0VqdhWnFDEPX6sfbI3eDMyFn9S+/wO0SdTUJBuzE0VXg
         anZo9ysYztrn765Ssi2pEOIdIFFma6a1UGObSRsfUEdRba3lcNK0BGAQEQoQKYZdAk
         g7NKe4qC/Mmlg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pCdvu-00GTbx-Nu;
        Tue, 03 Jan 2023 09:50:10 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     <kvmarm@lists.cs.columbia.edu>, <kvmarm@lists.linux.dev>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] KVM: arm64: M2 vgic maintenance interrupt rework pre-NV
Date:   Tue,  3 Jan 2023 09:49:50 +0000
Message-Id: <20230103094950.3230912-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, tglx@linutronix.de, will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com, suzuki.poulose@arm.com, alexandru.elisei@arm.com, oliver.upton@linux.dev, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've spent the holiday break reviving the Nested Virt KVM/arm64
implementation[1] and allowing it to work on the Apple M2 SoC. The
amusing part is that it actually works!

However, the way the vgic is implemented on this HW is still at odds
with the rest of the architecture, and requires some hacks, some of
which are independent of the actual NV code. This is what this series
is about.

The first patch places M2 on the naughty list of broken SEIS
implementations, just like the M1 before it. The second patch allows
a vgic MI to be registered, even if this MI cannot be masked (we
disable it at the source anyway). The last patch hacks the AIC driver
to actually register the vgic MI with KVM.

I plan to take the first patch as a fix for 6.2, while the rest can be
deferred to 6.3.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/nv-6.2-WIP

Marc Zyngier (3):
  KVM: arm64: vgic: Add Apple M2 cpus to the list of broken SEIS
    implementations
  KVM: arm64: vgic: Allow registration of a non-maskable maintenance
    interrupt
  irqchip/apple-aic: Register vgic maintenance interrupt with KVM

 arch/arm64/include/asm/cputype.h |  4 +++
 arch/arm64/kvm/vgic/vgic-init.c  |  2 +-
 arch/arm64/kvm/vgic/vgic-v3.c    |  3 +-
 drivers/irqchip/irq-apple-aic.c  | 55 ++++++++++++++++++++++++--------
 4 files changed, 49 insertions(+), 15 deletions(-)

-- 
2.34.1

