Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5E3663046
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjAIT0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjAIT0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:26:34 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DFE41664;
        Mon,  9 Jan 2023 11:26:33 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id b10-20020a4a9fca000000b004e6f734c6b4so2677354oom.9;
        Mon, 09 Jan 2023 11:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yp8JdvF4JGjAOoO+JkWqYIq2KRzORi/rQl4T8RRSxME=;
        b=LoIOKT6QKBAOz9G7xQClga9Y8R9jUbhStXwHe2ZHcMBIDgYeGE7baJXQvbF/WnATNM
         NO++AxPLvhpLqxQpAwomntl5xP5dLRNraLqt3RYPvANDj4gC8dt/uTZ9ewa4R+dNR3i7
         kACGavUNGIWB9WIHDW4fbcIE/5IdI44vGQIYQGz7ga6yNbRJi6y3J/5tQQNLyY9ZFCty
         eyke1F1CUpwWTx/tuS4WPRt37KcT6rcMmP/Lyug4CAInELlOb8XMMlJp3LKjjMlJsazY
         /BR53V/CM0m89eKnWy+pg9eA694qwU2IfCqs/XLOvuA4uw1fOXVidbgijWEu0h5t29QA
         LdyQ==
X-Gm-Message-State: AFqh2koatA5zmvxtSGMJH2VPQxpsrYHg/53xEYGlWyo3sByeXmRuwGm3
        ACPbMX8fKhGg4aWwixhcBNrauLsTJA==
X-Google-Smtp-Source: AMrXdXvSFir+DX3JReWJXkByMkbmVvVh/qFsGZDjfj2ioJ8TlxEwlmfZdeyAtE0+NuibVjMwKYWxZg==
X-Received: by 2002:a4a:9613:0:b0:4a3:9f7a:add0 with SMTP id q19-20020a4a9613000000b004a39f7aadd0mr28637976ooi.5.1673292392657;
        Mon, 09 Jan 2023 11:26:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e40-20020a056820062800b004f1c4baa96bsm4640563oow.6.2023.01.09.11.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:26:32 -0800 (PST)
Received: (nullmailer pid 1483603 invoked by uid 1000);
        Mon, 09 Jan 2023 19:26:31 -0000
From:   Rob Herring <robh@kernel.org>
Subject: [PATCH v4 0/8] perf: Arm SPEv1.2 support
Date:   Mon, 09 Jan 2023 13:26:17 -0600
Message-Id: <20220825-arm-spe-v8-7-v4-0-327f860daf28@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFlqvGMC/33NQQrCMBAF0KuUrB1JJ20TXXkPcZGm0zZYU0k0I
 KV3d3AnYlfD//D+LCJR9JTEsVhEpOyTnwOHalcIN9owEPiOs0CJKA3WYOMN0p0gG9DQU9fLisqm
 RyWYtDYRtNEGNzIKz2nicvTpMcfX50Uu+Zz/rOUSJDhdt6Y7IDUHPF0pBpr2cxzEhZcybmlkTUo
 rxK4x1skfrba0Ym10Y7DXxlnrvvS6rm9MxsJPKgEAAA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>
X-Mailer: b4 0.12-dev
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, this series is blocked on an ack from you on patch 7. There was 
some discussion on validation of the 'config3' attr. The options where 
laid out by Mark here[0]. Please chime in on your preference.

Will, can you pick up patches 1-6 at least if there's no progress on 
'config3'.

This series adds support for Arm SPEv1.2 which is part of the
Armv8.7/Armv9.2 architecture. There's 2 new features that affect the 
kernel: a new event filter bit, branch 'not taken', and an inverted 
event filter register. 

Since this support adds new registers and fields, first the SPE register 
defines are converted to automatic generation.

The perf tool side changes are available here[1].

Tested on FVP.

[0] https://lore.kernel.org/all/Y49ttrv6W5k3ZNYw@FVFF77S0Q05N.cambridge.arm.com/ 
[1] https://lore.kernel.org/all/20220914-arm-perf-tool-spe1-2-v2-v4-0-83c098e6212e@kernel.org/

Signed-off-by: Rob Herring <robh@kernel.org>
---
Changes in v4:
- Rebase on v6.2-rc1
- Link to v3: https://lore.kernel.org/r/20220825-arm-spe-v8-7-v3-0-87682f78caac@kernel.org

Changes in v3:
- Add some more missing SPE register fields and use Enums for some 
  fields
- Use the new PMSIDR_EL1 register Enum defines in the SPE driver
- Link to v2: https://lore.kernel.org/r/20220825-arm-spe-v8-7-v2-0-e37322d68ac0@kernel.org

Changes in v2:
- Convert the SPE register defines to automatic generation
- Fixed access to SYS_PMSNEVFR_EL1 when not present
- Rebase on v6.1-rc1
- Link to v1: https://lore.kernel.org/r/20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org

---
Rob Herring (8):
      perf: arm_spe: Use feature numbering for PMSEVFR_EL1 defines
      arm64: Drop SYS_ from SPE register defines
      arm64/sysreg: Convert SPE registers to automatic generation
      perf: arm_spe: Drop BIT() and use FIELD_GET/PREP accessors
      perf: arm_spe: Use new PMSIDR_EL1 register enums
      perf: arm_spe: Support new SPEv1.2/v8.7 'not taken' event
      perf: Add perf_event_attr::config3
      perf: arm_spe: Add support for SPEv1.2 inverted event filtering

 arch/arm64/include/asm/el2_setup.h |   6 +-
 arch/arm64/include/asm/sysreg.h    |  99 +++--------------------
 arch/arm64/kvm/debug.c             |   2 +-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c |   2 +-
 arch/arm64/tools/sysreg            | 139 +++++++++++++++++++++++++++++++++
 drivers/perf/arm_spe_pmu.c         | 156 ++++++++++++++++++++++++-------------
 include/uapi/linux/perf_event.h    |   3 +
 7 files changed, 257 insertions(+), 150 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20220825-arm-spe-v8-7-fedf04e16f23

Best regards,
-- 
Rob Herring <robh@kernel.org>
