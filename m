Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE40C6668F8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 03:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjALCjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 21:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbjALCjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 21:39:08 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2375FE0CB
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 18:39:07 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q64so17748900pjq.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 18:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k83D4cHet6xxSauwnXBAG2POGQDSG6eAKHoaOWKO0ZM=;
        b=HBHPRSkefxSL8v/u0WI3RXGK8TGWvBs9nWl0eAN6b2r3P/L5A0AHOW8k+WNlNXljiA
         xcBm7wjPg/EbuBJAaGK6fXmY1J99aLHf2ygMD4Ckkm5bZqFjjM6jm6yr1tg9BHpFyBU0
         r3SZWa5xMt7w6fSPXq70t5UyNqDOUpXK5fucMnX+sRjFj6OGzvUeZKRJtYA4imZdpC15
         RiJw9c0KYYLbr6ilHj99I/BGqslESPEHZM66/T1Uxls26qk4KKAZzb4XrwUYzsiXMGct
         N7ocX5rmVHAANjUVEMpylwE/OwUabgBkdVPmqiw4HmJxTNN7/PpzCgckFbi7PsfJA76L
         wbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k83D4cHet6xxSauwnXBAG2POGQDSG6eAKHoaOWKO0ZM=;
        b=Vu2aSqHTj+fbWYLbD/S68EkSUKSeddp5NkQLKhVocKr5bQqCGZ74oxzsjXD+mI79fr
         6bl9gwU5t/6FSDvRwVLJ3gWEOW+Dd3A06JvrnCeofuVKKNDwxZ//0hg724iUJCE1G1cy
         QxLM5i1y4RF772unmP4lGPrz8fuhN551URUrS1NXFXDAv5C64M8ak/im7oLeILa8gis1
         mQsHU6+iwCT0yPY8a5WQofoxhKnIPnLxljQF24EzsqHxkHW//8lgH0XflJrbCYGqG5kL
         62S+IJQAQq5m1V49+hb+CdLf5sfwUXj62g4jX4gubQaUjJRwXBOTUBgoXT4iv56cwPb6
         p8Aw==
X-Gm-Message-State: AFqh2kqKTDeJimFAeyngKPWolZyI7rJRuQzcNQkdU7gF3WsrjT98Ewp2
        IziwrDHQhfGN30GtDxrCfBtnNw==
X-Google-Smtp-Source: AMrXdXuarUuj+dnpfbLqlXdbjMkbC9/UcAPU+8TqzLcL101PU3o/EcvUpOQA1ixTQMd2bjFz7Yttag==
X-Received: by 2002:a17:902:c102:b0:192:8e05:1505 with SMTP id 2-20020a170902c10200b001928e051505mr57871834pli.31.1673491146515;
        Wed, 11 Jan 2023 18:39:06 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
        by smtp.gmail.com with ESMTPSA id w7-20020a1709027b8700b001944b1285easm2310331pll.198.2023.01.11.18.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 18:39:05 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
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
Subject: [PATCH v7 0/7] KVM: arm64: Normalize cache configuration
Date:   Thu, 12 Jan 2023 11:38:45 +0900
Message-Id: <20230112023852.42012-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.39.0
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

V6 -> V7:
- Make the code to determine cache line more readable.
  Based on Oliver Upton's suggestion.

V5 -> V6:
- Add a comment to get_min_cache_line_size()

V4 -> V5:
- Noted why cache level existence check is unnecessary when fabricating
  CCSIDR_EL1 value.
- Removed FWB check. It is necessary as CLIDR_EL1.{LoUU, LoIUS} on the
  host are {0, 0} if FWB is enabled, and such a CLIDR_EL1 value sets
  the IDC bit of the sanitized CTR_EL0 value, which is already checked.
- Removed UNDEF injection when reading CCSIDR_EL1 with an invalid
  CSSELR_EL1 value.
- Added a check for CLIDR_EL1.{LoUU,LoC,LoUIS} values set from the
  userspace.

V3 -> V4:
- Implemented UNKNOWN system register definition for CCSIDR_EL1
- Added a comment about the relation between CCSIDR_EL1 and FEAT_CCIDX
- Squashed "Normalize cache configuration" and "Allow user to set
  CCSIDR_EL1"
  The intermediate state between them did not make much sense.
- Introduced FIELD_GET to extract CCSIDR_EL1_LineSize.

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

Akihiko Odaki (6):
  arm64/sysreg: Convert CCSIDR_EL1 to automatic generation
  arm64/sysreg: Add CCSIDR2_EL1
  arm64/cache: Move CLIDR macro definitions
  KVM: arm64: Always set HCR_TID2
  KVM: arm64: Mask FEAT_CCIDX
  KVM: arm64: Normalize cache configuration

Marc Zyngier (1):
  arm64: Allow the definition of UNKNOWN system register fields

 arch/arm64/include/asm/cache.h             |   9 +
 arch/arm64/include/asm/kvm_arm.h           |   3 +-
 arch/arm64/include/asm/kvm_emulate.h       |   4 -
 arch/arm64/include/asm/kvm_host.h          |   6 +-
 arch/arm64/include/asm/sysreg.h            |   1 -
 arch/arm64/kernel/cacheinfo.c              |   5 -
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h |   2 -
 arch/arm64/kvm/reset.c                     |   1 +
 arch/arm64/kvm/sys_regs.c                  | 274 +++++++++++++--------
 arch/arm64/tools/gen-sysreg.awk            |  20 +-
 arch/arm64/tools/sysreg                    |  17 ++
 11 files changed, 230 insertions(+), 112 deletions(-)

-- 
2.39.0

