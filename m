Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6C560502E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiJSTLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJSTLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:11:31 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B2F181DA6;
        Wed, 19 Oct 2022 12:11:25 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-132af5e5543so21823738fac.8;
        Wed, 19 Oct 2022 12:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HWbMi0BhU5RSsaj3t9gz8sb2tRhVv6F39wL/nVJWCs=;
        b=oY3643uoeK2h2EQmqcZb0CYchxdcS7t/3I8dZAO2bnQOyN+XVErSAd3/qDN2LTE3DG
         Z3GqdkevO/bWez4+XMT9NYCBuDhoxwtSTxsRMgn2R0YF8CrxY3N9hPaweT5kack917CW
         C/AtczxVOhzL1DBi0mkXJGnSzxs5wipjQYV8vSGLhrRpOEVoKImWU2zEtr1xPimes4ga
         bIawoIPUNiDKD1P7uSGGeZ28zIJwXBgQDQF1sLab4byze/QgD2KRfNPkWlman8HwDJqx
         BBd8NTi3TnQu2QOFiTGu7AUJWxGEAFHYP2x/rcRjEpPBFs080kbExbzL+lB/L9nkCg0k
         dZ2g==
X-Gm-Message-State: ACrzQf0ufe5BiFjlCtnZ0IwgyRUHiubl1UOtn+lsYCOvqKw9/6AY302h
        GxxEb8+vkD5c/KH8bpGWaQ==
X-Google-Smtp-Source: AMsMyM6L+gye/LwLSUbTwvcqYD3FLUzUB3vYmZL9Im4PgtcEfWLLmd/KydKz+OoIOnaMZdgD5mTlwg==
X-Received: by 2002:a05:6870:9688:b0:132:9c55:72 with SMTP id o8-20020a056870968800b001329c550072mr6180621oaq.104.1666206684576;
        Wed, 19 Oct 2022 12:11:24 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q10-20020a056830018a00b006618f1fbb84sm7348116ota.80.2022.10.19.12.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 12:11:24 -0700 (PDT)
Received: (nullmailer pid 3420895 invoked by uid 1000);
        Wed, 19 Oct 2022 19:11:25 -0000
Subject: [PATCH v2 0/7] perf: Arm SPEv1.2 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIANtLUGMC/3WNzQrCMBCEX6Xs2ZV0tb8n30M8pO2mCdZENhqQknc3ePc0fAPfzA6RxXGEsdpBOL
 nogi9Ahwpmq/3K6JbCQIpI9dSglgfGJ2PqsUPDi1FnrltDJyjKpCPjJNrPtkj+vW2ltC6+gnx+F6ku
 cf2zlmpUOHfN1C8DcTvQ5c7ieTsGWeGWc/4CRvTey64AAAA=
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 19 Oct 2022 14:11:23 -0500
Message-Id: <20220825-arm-spe-v8-7-v2-0-e37322d68ac0@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.11.0-dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Arm SPEv1.2 which is part of the
Armv8.7/Armv9.2 architecture. There's 2 new features that affect the 
kernel: a new event filter bit, branch 'not taken', and an inverted 
event filter register. 

Since this support adds new registers and fields, first the SPE register 
defines are converted to automatic generation.

Note that the 'config3' addition in sysfs format files causes SPE to 
break. A stable fix e552b7be12ed ("perf: Skip and warn on unknown format 
'configN' attrs") landed in v6.1-rc1.

The perf tool side changes are available here[1].

Tested on FVP.

[1] https://lore.kernel.org/all/20220914-arm-perf-tool-spe1-2-v2-v4-0-83c098e6212e@kernel.org/

Signed-off-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
- Convert the SPE register defines to automatic generation
- Fixed access to SYS_PMSNEVFR_EL1 when not present
- Rebase on v6.1-rc1
- Link to v1: https://lore.kernel.org/r/20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org

---
Rob Herring (7):
      perf: arm_spe: Use feature numbering for PMSEVFR_EL1 defines
      arm64: Drop SYS_ from SPE register defines
      arm64/sysreg: Convert SPE registers to automatic generation
      perf: arm_spe: Drop BIT() and use FIELD_GET/PREP accessors
      perf: arm_spe: Support new SPEv1.2/v8.7 'not taken' event
      perf: Add perf_event_attr::config3
      perf: arm_spe: Add support for SPEv1.2 inverted event filtering

 arch/arm64/include/asm/el2_setup.h |   6 +-
 arch/arm64/include/asm/sysreg.h    |  99 +++------------------------
 arch/arm64/kvm/debug.c             |   2 +-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c |   2 +-
 arch/arm64/tools/sysreg            | 116 +++++++++++++++++++++++++++++++
 drivers/perf/arm_spe_pmu.c         | 136 ++++++++++++++++++++++++-------------
 include/uapi/linux/perf_event.h    |   3 +
 7 files changed, 224 insertions(+), 140 deletions(-)
---
base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
change-id: 20220825-arm-spe-v8-7-fedf04e16f23

Best regards,
-- 
Rob Herring <robh@kernel.org>
