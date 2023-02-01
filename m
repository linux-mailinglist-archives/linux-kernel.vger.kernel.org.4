Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A44686476
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjBAKiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjBAKiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:38:13 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A94E8686
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:38:01 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id j25-20020adfd219000000b002bfd1484f9bso2333895wrh.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 02:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s4zWblSgk9sC59/aeD2C4zXhl1NkdUvsWjCEZ+kae5w=;
        b=kDd5sNOxRKfGTyQyrwC8Z9FLlQkrpsj/Nng2DTWB6IJUir3WQndNIexufILUN++wdV
         JDwcGHttIbcRuSGZu7j9qulGqGELbopzYZ3m8BIvsoLl5QqurHIf6HGUOy+1AH4o06Ba
         VNDrWbdJVT7ESS5kjdleefmF0NLuB3WcOoOJtsonsWVaNaBJDrHQTAgCuYmv5i/ph5Zl
         UR2zJtbSKKV85ivzBHyqklZSKeSB/QSPrTRbPWkBl7+94vRWUCwYOn/R+g7PNWGcQH08
         xrRKBM3IyQbvObsc3VmNRqTfnUlUIxxqTU0sIC/IIuFBnorDytqD1S3czSqHoRXsHpoc
         XzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s4zWblSgk9sC59/aeD2C4zXhl1NkdUvsWjCEZ+kae5w=;
        b=Walh0lLKd/JI9ZpCLBh674MGd4MKRJZtX52YkbYD/HN/YL/aT9g39PHuWDKZPN/O1K
         bEvFxsJZ+k+6ED8t+MBSKRuWtwsRWD4CFer3lsgtwDnzfa0bgqIRFRSQuhfor89X6XPX
         ZRcrf19NfqJSzCyfSJGLCPp8GUgquBq/lO72cMdRS2fDsR8lP4F6B5PKijkobke2jQeR
         bmLjZaFAP4UL21kCFgBp/cpAX2AKOkpwhcvXT1WudtSzwUOf6BVJ3cQ97FCHMoZykfN2
         QAykv89uBy+fwwHiUneIX9BaGEwv8+cx8KQAGcqmZUAE3MGCPoVjfrqYArRN656K+Jx1
         8fNQ==
X-Gm-Message-State: AO0yUKV6i4xFqtJSswj/LQbBxj7Ol/gOgxfNGhPX9OU36ZDURQY2gRBX
        QBU7hCtjd03bqt018zr1P6Ct3P6epb0+
X-Google-Smtp-Source: AK7set9OO31MOIG5ytUAh8LFORGHH4kWKzwK1XEnu8LH1geO7NiaHrTAAjdFjC0NALlJrHjXuGZHsPmGikuT
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a05:600c:170a:b0:3dc:5240:a87b with SMTP
 id c10-20020a05600c170a00b003dc5240a87bmr145717wmn.12.1675247879605; Wed, 01
 Feb 2023 02:37:59 -0800 (PST)
Date:   Wed,  1 Feb 2023 10:37:50 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230201103755.1398086-1-qperret@google.com>
Subject: [PATCH 0/4] KVM: arm64: Fix CPU resume/on with pKVM
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using pKVM, we do not reset the EL2 exception vectors back to the
stubs for e.g. Power Management or CPU hotplug as we normally do in KVM.
As consequence, the initialisation perfomed by __finalise_el2 is missing
on e.g. the CPU_RESUME path with pKVM, hence leaving certain registers
in an incorrect state.

One such example is ZCR_EL2 which remains configured with SVE traps
enabled. And so using SVE on a CPU that has gone through a hotplug
off/on cycle leads to a hyp panic. Not good.

This series fixes this by macroizing the first half of __finalise_el2
(that is, the part that is not specific to VHE) to allow its re-use
from pKVM's PSCI relay.

Quentin Perret (4):
  KVM: arm64: Provide sanitized SYS_ID_AA64SMFR0_EL1 to nVHE
  KVM: arm64: Introduce finalise_el2_state macro
  KVM: arm64: Use sanitized values in __check_override in nVHE
  KVM: arm64: Finalise EL2 state from pKVM PSCI relay

 arch/arm64/include/asm/el2_setup.h | 92 ++++++++++++++++++++++++++++++
 arch/arm64/include/asm/kvm_hyp.h   |  1 +
 arch/arm64/kernel/hyp-stub.S       | 79 +------------------------
 arch/arm64/kvm/arm.c               |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-init.S |  1 +
 arch/arm64/kvm/hyp/nvhe/sys_regs.c |  1 +
 6 files changed, 98 insertions(+), 77 deletions(-)

-- 
2.39.1.456.gfc5497dd1b-goog

