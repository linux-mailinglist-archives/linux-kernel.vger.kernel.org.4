Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F9B65C57D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjACR4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbjACR42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:56:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7E211836
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:56:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D44A614B6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79571C433D2;
        Tue,  3 Jan 2023 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672768585;
        bh=UC4RdBvcPnI5XJhhZ46pv1YotwVqygpNpSpelRcjc+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNq2WgLp6fiiAgRTQt9iNPOZmuaaRoeBfgUewesNE5DImDRlCrMbjbqSMDDiIsrFy
         fQ83YDSZTq659bmYpz0aXisuvux6mnraKOdoQTbm8JpDuEzCHDkdZCh0Mmds2rOQr4
         zwjr57RrWgKHYZBAU2oGsX+AOLkodvGX+nd5XUGzF+g2U5a6wQmmlHrkb/NpGNyF1g
         jiab5756EaFtBNsVqKqCW7kzfCZqz0E0E9J4T6flkSFrvguURllYJpT8ZFXEwxrudf
         t41+RiIxV47Yxh5zw0ecjSLfdvnlD3015xQwGTLefok2gZH6Usex2tz5xk+tFQ/HKP
         hD7KRz4wXqP0A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pClWR-00Ga6w-6F;
        Tue, 03 Jan 2023 17:56:23 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
        kvmarm@lists.linux.dev
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org,
        Oliver Upton <oliver.upton@linux.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, asahi@lists.linux.dev,
        James Morse <james.morse@arm.com>
Subject: Re: (subset) [PATCH 0/3] KVM: arm64: M2 vgic maintenance interrupt rework pre-NV
Date:   Tue,  3 Jan 2023 17:56:19 +0000
Message-Id: <167276854454.3239244.7195924669135808939.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103095022.3230946-1-maz@kernel.org>
References: <20230103095022.3230946-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, maz@kernel.org, kvmarm@lists.linux.dev, suzuki.poulose@arm.com, linux-kernel@vger.kernel.org, oliver.upton@linux.dev, alyssa@rosenzweig.io, catalin.marinas@arm.com, marcan@marcan.st, sven@svenpeter.dev, alexandru.elisei@arm.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, will@kernel.org, asahi@lists.linux.dev, james.morse@arm.com
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

On Tue, 3 Jan 2023 09:50:19 +0000, Marc Zyngier wrote:
> I've spent the holiday break reviving the Nested Virt KVM/arm64
> implementation[1] and allowing it to work on the Apple M2 SoC. The
> amusing part is that it actually works!
> 
> However, the way the vgic is implemented on this HW is still at odds
> with the rest of the architecture, and requires some hacks, some of
> which are independent of the actual NV code. This is what this series
> is about.
> 
> [...]

Applied to fixes, thanks!

[1/3] KVM: arm64: vgic: Add Apple M2 cpus to the list of broken SEIS implementations
      commit: 4f6202c9fb51cc6a2593ad37d8ddff136b7acef2

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


