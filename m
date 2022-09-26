Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012D05E9E7F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiIZJ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbiIZJ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:59:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9CA9FE6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:59:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 102DA60B68
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7643CC433D6;
        Mon, 26 Sep 2022 09:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664186384;
        bh=JkqwGO41jubzZ7FENPY93uExAipCGViKwp9CWUpcYec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQZ8GcxQRwTvaC9P7g6BCyFH/8e7160/hRnWMTBbxuq3tCdNYKdHF907yaJKkL6Kw
         ZTJWJc1wz8KkgDcuFr/czYUsGeb2W2YmosFwu2B/Cxor4DH7nG4Rk9ohqbc5Zp1vvs
         SnB9453ofpP6KyOV/UZfcaNb/DRMGhz9XUloVr2UYg1njQbC9mA/J5V0vBsERzwKX4
         swIPOxfDQVKyb6eu1cBujSicjfWn7vz2T+901VzOqop0RpF40KAl5ueZDDvQ8oaj/F
         K3sIFHN6ZeqN/wct/3mv1rmq8zRdp6LS+/k79gfiCVZO2TmBb2JtQWQJZSa5vPc7Px
         S0HXlAFCru6gQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1ocktq-00CcjO-82;
        Mon, 26 Sep 2022 10:59:42 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] KVM: arm64: Ignore kvm-arm.mode if !is_hyp_mode_available()
Date:   Mon, 26 Sep 2022 10:59:39 +0100
Message-Id: <166418635574.3586576.7130049081458859826.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220920190658.2880184-1-quic_eberman@quicinc.com>
References: <20220920190658.2880184-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: james.morse@arm.com, alexandru.elisei@arm.com, catalin.marinas@arm.com, will@kernel.org, suzuki.poulose@arm.com, quic_eberman@quicinc.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 12:06:58 -0700, Elliot Berman wrote:
> Ignore kvm-arm.mode if !is_hyp_mode_available(). Specifically, we want
> to avoid switching kvm_mode to KVM_MODE_PROTECTED if hypervisor mode is
> not available. This prevents "Protected KVM" cpu capability being
> reported when Linux is booting in EL1 and would not have KVM enabled.
> Reasonably though, we should warn if the command line is requesting a
> KVM mode at all if KVM isn't actually available. Allow
> "kvm-arm.mode=none" to skip the warning since this would disable KVM
> anyway.

Applied to next, thanks!

[1/1] KVM: arm64: Ignore kvm-arm.mode if !is_hyp_mode_available()
      commit: b2a4d007c347b4cb4c60f7512733c3f8300a129c

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


