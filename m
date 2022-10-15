Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DD25FFA92
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJOOns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 10:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJOOnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 10:43:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4784501A0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 07:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84C56B809E3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 14:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06375C433D6;
        Sat, 15 Oct 2022 14:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665845020;
        bh=hdmj9Rrf0S29adC3/oPTPWmoQRbCjFPUJreRyWhIkoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iv6Jbp/tQQdOBX0ztsMIHMr4ABO9zC6EvMwNP2EinhCT/hV0FFdGZ15FUS7ka9tdn
         c2h3v+tAIJaf+RB5Y+xArLwBwilnQVwIh+PesGFzQBJifZ5zgapWRwQIpQ09pd/3M2
         0gGnSZKBb8KQYsclTVcs2xDJfjEdqN8ffcSAs36eVwOf9niYXPW08izYt49AM2aEE2
         1KS/s1bpl0d2S1yxYtryj1t57EqZXaF0K9ExrLpiQA3srVwXtHBURKfxCsxApoIZVC
         9dA6uN22nSz0RU8WkaLDRo0EKADe5HoqotOxMmBb0TGaXMVxRvCQr+9G+REYSLUe1F
         2oKuTUL6lw18g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1ojiO1-00GhUt-L6;
        Sat, 15 Oct 2022 15:43:37 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>, Denis Nikitin <denik@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kvmarm@lists.linux.dev, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v3] KVM: arm64: nvhe: Fix build with profile optimization
Date:   Sat, 15 Oct 2022 15:43:33 +0100
Message-Id: <166584499561.1372561.8808338756381167639.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221014184532.3153551-1-denik@chromium.org>
References: <20221014184532.3153551-1-denik@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: will@kernel.org, denik@chromium.org, catalin.marinas@arm.com, kvmarm@lists.linux.dev, james.morse@arm.com, alexandru.elisei@arm.com, dbrazdil@google.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ndesaulniers@google.com, manojgupta@google.com, kvmarm@lists.cs.columbia.edu
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

On Fri, 14 Oct 2022 11:45:32 -0700, Denis Nikitin wrote:
> Kernel build with clang and KCFLAGS=-fprofile-sample-use=<profile> fails with:
> 
> error: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.tmp.o: Unexpected SHT_REL
> section ".rel.llvm.call-graph-profile"
> 
> Starting from 13.0.0 llvm can generate SHT_REL section, see
> https://reviews.llvm.org/rGca3bdb57fa1ac98b711a735de048c12b5fdd8086.
> gen-hyprel does not support SHT_REL relocation section.
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: nvhe: Fix build with profile optimization
      commit: bde971a83bbff78561458ded236605a365411b87

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


