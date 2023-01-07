Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA168660D55
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjAGJqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjAGJqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:46:40 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE3D7CBCF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 01:46:39 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso7769780pjt.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 01:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nDiSSUCXyfTxgSY9w0A6cnWBkOKJja5kzfazSGhDk+s=;
        b=Ip9Fl0k1pj40UoY+CGobxiY7Cb+1N2wjCHxGSMm+/IGkJbHoHvYlHh9isCjXM6EYbS
         uYU63Wve+S4jpifnghRtL7kd3WflrBwh3ewvMkoPRgWyadCiC/fK8XtXA9ABONYlraHH
         H5+qiphc39Pcnh5CPLvVweuQB6KVkf62uqYq4VP+3A9IzulQJBBeRToU4TMkrupx6yG1
         gY3IhrlZ8V1zCR8JXMja5X1cV0jUZ2U8FjERPU1meMnTd8SBruQNkYFYuxV3KO23FQQQ
         ElMN75eyjKeoaEgs84MOvHjxLXbZGa1jMV2iWjz0TDxOIu7m7T0XnEleWV6dJxbEIhqc
         W1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nDiSSUCXyfTxgSY9w0A6cnWBkOKJja5kzfazSGhDk+s=;
        b=DYKIBl78bExjpYNFH/HxdA3YMqBUj75j3TxHjX47cWkO2P9uSPONs7EXNJyk7arVuh
         g+CyzHjhIsBsPEwOPWHxMDvZqrJT3S6SRIghxeU+eJH9I8jOCzutu0l3KwhzKAVvX6cC
         ENazor7TRoOyaLWnFWTUbuBLRwZmIOyGASNK4zl2ieUGf49R7detzXW1VFVuMxDa80tx
         L4VvbaHP32ZNG6HSUeB+hkKDz2+RTP1Z1koKaPMuRYyaO7hml/bXel7WexEyz9lbUQ8V
         06R/2wtTka6Vw1mlSC7BGkxWtLX3Cf+dYWbXGNfXIcY69IEkyrJSNvLC5hSjuYqq1J7f
         nQ6Q==
X-Gm-Message-State: AFqh2kqmnL8suGa4nflXVwDAUhXMV0/w/KyaTTOp6ytK9smxmR/FLT4W
        BFYfLMdi1y5RVu7Y7ytN2nfZpw==
X-Google-Smtp-Source: AMrXdXvo+rexBnZY1QlfA2EAy1F/HDKl7+wrHDMpE1Bhi7y2UBror3BjgD1EIrqM70vva4yt50Esag==
X-Received: by 2002:a17:902:f78d:b0:192:ae36:f760 with SMTP id q13-20020a170902f78d00b00192ae36f760mr32857238pln.47.1673084799038;
        Sat, 07 Jan 2023 01:46:39 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d2c900b00183c6784704sm2263449plc.291.2023.01.07.01.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 01:46:38 -0800 (PST)
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
Subject: [PATCH v6 0/7] KVM: arm64: Normalize cache configuration
Date:   Sat,  7 Jan 2023 18:46:22 +0900
Message-Id: <20230107094629.181236-1-akihiko.odaki@daynix.com>
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
 arch/arm64/kvm/sys_regs.c                  | 263 +++++++++++++--------
 arch/arm64/tools/gen-sysreg.awk            |  20 +-
 arch/arm64/tools/sysreg                    |  17 ++
 11 files changed, 219 insertions(+), 112 deletions(-)

-- 
2.38.1

