Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AFC65BD75
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbjACJvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbjACJup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:50:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA3AE0F7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:50:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52812B80E74
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E3DC43392;
        Tue,  3 Jan 2023 09:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672739441;
        bh=ARLfbpBM69dXDtUx7JEBSy4KWdTmviEfk9qRcpSeYPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdQr+NHPQAJ+Ij1jsH782ej6DuZ5M8bl5ceEdI/mosMJn2peIBgjl6D0kygQrEENF
         DsFyhme9/k7cYXWf04r1jjTRFsX0YtAEV9Or2S8q479OhNynAfZkrD1VP/ehs3h+7E
         ytfNGEs5Kl6ZreIkkH/9CCfkjLkCJveo/dgYrzWct0stsioYg6ES1HNn5vLe7GLloI
         djxp8FssKWatHN5BshdArNm0pRLOyTxq30Nyb6/V/hgoxAFcL7yOiyS0CBR62gxF4i
         OLZvTYaFHF/kAQFZRGg5aNAYcgtiRnpTN0piWe1QsED3pPvSAIfpeOX8jFFe2cnPsO
         AeJptl9eUoRNA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pCdwN-00GTcP-M8;
        Tue, 03 Jan 2023 09:50:39 +0000
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
Subject: [PATCH 2/3] KVM: arm64: vgic: Allow registration of a non-maskable maintenance interrupt
Date:   Tue,  3 Jan 2023 09:50:21 +0000
Message-Id: <20230103095022.3230946-3-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103095022.3230946-1-maz@kernel.org>
References: <20230103095022.3230946-1-maz@kernel.org>
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

Our Apple M1/M2 friends do have a per-CPU maintenance interrupt,
but no mask to make use of it in the standard Linux framework.

Given that KVM directly drives the *source* of the interrupt and
leaves the GIC interrupt always enabled, there is no harm in tolerating
such a setup. It will become useful once we enable NV on M2 HW.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index f6d4f4052555..e61d9ca01768 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -572,7 +572,7 @@ int kvm_vgic_hyp_init(void)
 	if (ret)
 		return ret;
 
-	if (!has_mask)
+	if (!has_mask && !kvm_vgic_global_state.maint_irq)
 		return 0;
 
 	ret = request_percpu_irq(kvm_vgic_global_state.maint_irq,
-- 
2.34.1

