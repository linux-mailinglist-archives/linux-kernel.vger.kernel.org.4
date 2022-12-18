Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC91A64FDB2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 06:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiLRFP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 00:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiLRFPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 00:15:25 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047BDD112
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 21:15:25 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d7so6067149pll.9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 21:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a01G1GBaf3qfiSutprsFR/TlqOiwESaNiFiCPW34lhQ=;
        b=oB2m/VIEAkS9xOaITyE3rjE56r6CApd8uv6/I9Uhzf8pGv9vmJR578c5JqGMjoKvPv
         kRaPQEyoEv/UxuTchSJGFAhseLU8GEBHWCYoQenv0Ni/ERulgVgmbY3R/CwgWJw/TvAs
         3IeonmoVwK5kmEVznc8OofYBZSw1es2YvP7mL6RU21/0ABA/Kh6iBYlEl6MlbLsjVe4X
         ALHKRtXC/iDcupj1w/c56rFgGtEO3dQpCE4BWpSytHZIad5dgzuxbns1fNb3nFkpVaw0
         ts9lgWdtWxzOk2YhyxanXAGFYk4O0Rk9MCFkzxjA6qSrJb/6shjAA5V82VzCfyKPQ4Og
         HTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a01G1GBaf3qfiSutprsFR/TlqOiwESaNiFiCPW34lhQ=;
        b=6z6TzMUJidI0Kjp7sAkBPhx9s17D66Wzc5JrNvrjK2eVWxtIGCqoI4Sgdc8g7wiQHO
         SKLWQIUc05BMQOf3s79ng2Qga37qD7ZmPa+tE76yM0hUmfZZFnLfLo1irnEFZMECK2ZB
         +mKqJa3vfApGUOFkn/pw1ax5lYY6CpVBx3qK0J9U6lqpDmaJwzAt6Ayu/rXWlm4AFVDy
         Tu6FPO6tRYlQ0sK0ImbAtSUNSGh/RfeMaBHcT1OVVb0xiLl7nL9MVVyl51qH9XQw5b5O
         VwXIRtm8qf7k0O0CjTq/RpjUnmPzqTINcC83jgAYxmydYBgTHiFSUG9DamYhSND4E1el
         uA+A==
X-Gm-Message-State: ANoB5pk+x/VV5AY7wCOvoAg2jRjUs7PRGk1gmlxI6aQlYDllWt88AIhW
        /cj0y12y7xV95/BTkblWyQkG1HyLxQx9l+7wicg=
X-Google-Smtp-Source: AA0mqf72YV5edT4kAgOZXEWT3kE8W12UBWocuqS2BFj9Nm3zqofKc8b75dDfMhucuQYOpxQGxpjPjQ==
X-Received: by 2002:a17:90b:4a8c:b0:219:e763:1d21 with SMTP id lp12-20020a17090b4a8c00b00219e7631d21mr39250867pjb.5.1671340524491;
        Sat, 17 Dec 2022 21:15:24 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090a6ac100b002139459e121sm7002417pjm.27.2022.12.17.21.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 21:15:23 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/7] KVM: arm64: Normalize cache configuration
Date:   Sun, 18 Dec 2022 14:14:05 +0900
Message-Id: <20221218051412.384657-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this change, the cache configuration of the physical CPU was
exposed to vcpus. This is problematic because the cache configuration a
vcpu sees varies when it migrates between vcpus with different cache
configurations.

Fabricate cache configuration from the sanitized value, which holds the
CTR_EL0 value the userspace sees regardless of which physical CPU it
resides on.

V2 -> V3:
- Corrected message for patch "Normalize cache configuration"
- Split patch "Normalize cache configuration"
- Added handling for CSSELR_EL1.TnD
- Added code to ignore RES0 in CSSELR_EL1
- Replaced arm64_ftr_reg_ctrel0.sys_val with
  read_sanitised_ftr_reg(SYS_CTR_EL0)
- Fixed vcpu->arch.ccsidr initialziation
- Added CCSIDR_EL1 sanitization
- Added FWB check
- Added a comment for CACHE_TYPE_SEPARATE
- Added MTE tag cache creation code for CLIDR_EL1 fabrication
- Removed CLIDR_EL1 reset code for reset caused by guest
- Added a comment for CCSIDR2

V2: https://lore.kernel.org/lkml/20221211051700.275761-2-akihiko.odaki@daynix.com/
V1: https://lore.kernel.org/lkml/525ff263-90b3-5b12-da31-171b09f9ad1b@daynix.com/

Akihiko Odaki (7):
  arm64/sysreg: Convert CCSIDR_EL1 to automatic generation
  arm64/sysreg: Add CCSIDR2_EL1
  arm64/cache: Move CLIDR macro definitions
  KVM: arm64: Always set HCR_TID2
  KVM: arm64: Allow user to set CCSIDR_EL1
  KVM: arm64: Mask FEAT_CCIDX
  KVM: arm64: Normalize cache configuration

 arch/arm64/include/asm/cache.h             |   9 +
 arch/arm64/include/asm/kvm_arm.h           |   3 +-
 arch/arm64/include/asm/kvm_emulate.h       |   4 -
 arch/arm64/include/asm/kvm_host.h          |   6 +-
 arch/arm64/include/asm/sysreg.h            |   1 -
 arch/arm64/kernel/cacheinfo.c              |   5 -
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h |   2 -
 arch/arm64/kvm/reset.c                     |   1 +
 arch/arm64/kvm/sys_regs.c                  | 246 +++++++++++++--------
 arch/arm64/tools/sysreg                    |  16 ++
 10 files changed, 182 insertions(+), 111 deletions(-)

-- 
2.38.1

