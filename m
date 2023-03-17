Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157FD6BF1E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCQTuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCQTuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:50:37 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E08E47415
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:50:35 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id d5-20020a17090ac24500b0023cb04ec86fso2739200pjx.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679082634;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rAMNw7I/iPQBXA5776+hHO5jp6wGCvuivl6D7qCj+lg=;
        b=bkDvkAdeGenE8Nh+dNVYbOas9j+tbvuvSxVZ3KZ6+Bp1/ka2FLNL89Mybe9NZYX7dt
         GMU8OOsR4l62JzYYGVcxdjL/FhvKNqKUph7Wep4ysxQsQ4+zlnVygMiWznRQbvBterir
         Sc5HKVqhSk23DF3gaZ0JkHgXLoLomYTau8+SgyfFiWkyOC7iF0Xwnq8DAR4E9qLq5rr5
         pbx4NRjR/m7tdJcDmIKTFw4osieL92c3ru5Y1UppsyXCXwXJ8ImOGQ3RphFl5W+++D4j
         iZltVWp/nHYfkz8YHLqDCymyLCUI9T494hD4X3z9W64iqLAqayU9pTw1zHxhzvU9tlX5
         9NYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679082634;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rAMNw7I/iPQBXA5776+hHO5jp6wGCvuivl6D7qCj+lg=;
        b=0BvaOFpKHxAg2Xq0o6syTLcphiUvOz7hxCIErG/K5qWRnNFyQqQgYnD7IhhmRZGhBX
         HCattsmY9ee+jPt+jLGAL3qmjjX7U+51BX2aFVxtK05BWiL+P+0Jq5dqzLYiTdTZCIMC
         QucZ050tnTPznTn4p/3C/yHHZtrlOuyzvjQkSmKYMPyDYETv3hdN/fiHW3zcG5SK/I78
         shtuWyCHtLFFyD5gy53PShPcKsOU7IFKVAYc5US7Cpxx7i1HnpqktmaIF0SF7Z7hem9+
         N9Uv3jSAz/sYdhkiCzI1pgtlWw8GmQTyJcdCb643DxEyZ4i6oE6EmFcsRRZOGS9DK+XD
         FIbg==
X-Gm-Message-State: AO0yUKXC5uwsKjV2tmYBKqo0iYyibOxjwC64a1JbUVUsnxN1c1SkvcYi
        9iswJ6gpI0Wv/PCsRjxvlEMLhcRNTsTeAH0=
X-Google-Smtp-Source: AK7set/gvArTV0vJudQh6stgruRNDqAenLkESzbpOZcMUYDbXQMRuvUxE1x49plm6rE743b7PqZM35p2AJ1snKs=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a05:6a00:4503:b0:5a8:aaa1:6c05 with SMTP
 id cw3-20020a056a00450300b005a8aaa16c05mr1896705pfb.2.1679082634554; Fri, 17
 Mar 2023 12:50:34 -0700 (PDT)
Date:   Fri, 17 Mar 2023 15:50:19 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230317195027.3746949-1-zalbassam@google.com>
Subject: [PATCH v4 0/8] perf: arm: Make PMUv3 driver available for aarch32
From:   Zaid Al-Bassam <zalbassam@google.com>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, f.fainelli@gmail.com
Cc:     Zaid Al-Bassam <zalbassam@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, PMUv3 driver is only available for ARMv8 aarch64 platforms,
ARMv8 platorms running in aarch32 mode dont have access to the driver.
This is, especially, a problem for ARMv8 platforms that only have
aarch32 support, like the Cortex-A32.

Make the PMUv3 driver available to arm arch (ARMv8 aarch32) by moving
the PMUv3 driver from arm64 to drivers, that makes the driver common
to both arm and arm64 architectures, then add PMUv3 arm Support.

The main work in this patchset was made a while back by Marc Zyngier
in [1]. Patchset version 1 [v1] rebases Marc's patches to the latest
kernel revision and adds additional patches to accommodate the changes
in the kernel since Marc wrote the patches.

version 2 [v2] of the patchset was created by Marc Zyngier and I
picked it up from [2].

Changes in v2:
- Flattened the nested switches in the arm_pmuv3.h for arm.
- Removed wrappers and added stubs for the PMU KVM functions for arm.
- Added PMU version abstractions.

Changes in v3:
- Removed the link tag from the commit messages.
- Fixed the license header in the arm_pmuv3.h files.

Changes in v4:
- Rebased to 6.3.0-rc2 (Clean rebase)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm/pmuv3-32bit
[2] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=arm/pmuv3

[v1] https://lore.kernel.org/all/20230126204444.2204061-1-zalbassam@google.com/
[v2] https://lore.kernel.org/all/20230210165500.2292608-1-zalbassam@google.com/
[v3] https://lore.kernel.org/all/20230213210319.1075872-1-zalbassam@google.com/

Thank you,
Zaid Al-Bassam

Marc Zyngier (5):
  arm64: perf: Move PMUv3 driver to drivers/perf
  arm64: perf: Abstract system register accesses away
  ARM: Make CONFIG_CPU_V7 valid for 32bit ARMv8 implementations
  ARM: perf: Allow the use of the PMUv3 driver on 32bit ARM
  ARM: mach-virt: Select PMUv3 driver by default

Zaid Al-Bassam (3):
  perf: pmuv3: Abstract PMU version checks
  perf: pmuv3: Move inclusion of kvm_host.h to the arch-specific helper
  perf: pmuv3: Change GENMASK to GENMASK_ULL

 arch/arm/Kconfig                              |   1 +
 arch/arm/include/asm/arm_pmuv3.h              | 247 ++++++++++++++
 arch/arm/mm/Kconfig                           |   2 +-
 arch/arm64/include/asm/arm_pmuv3.h            | 155 +++++++++
 arch/arm64/include/asm/perf_event.h           | 249 --------------
 arch/arm64/kernel/Makefile                    |   1 -
 drivers/perf/Kconfig                          |  10 +
 drivers/perf/Makefile                         |   1 +
 .../perf_event.c => drivers/perf/arm_pmuv3.c  | 131 ++------
 include/kvm/arm_pmu.h                         |   2 +-
 include/linux/perf/arm_pmuv3.h                | 303 ++++++++++++++++++
 11 files changed, 751 insertions(+), 351 deletions(-)
 create mode 100644 arch/arm/include/asm/arm_pmuv3.h
 create mode 100644 arch/arm64/include/asm/arm_pmuv3.h
 rename arch/arm64/kernel/perf_event.c => drivers/perf/arm_pmuv3.c (93%)
 create mode 100644 include/linux/perf/arm_pmuv3.h

-- 
2.40.0.rc2.332.ga46443480c-goog

