Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3060C60CEFE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiJYOaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiJYOaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:30:01 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898936BCF5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:30:00 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id v40-20020a056830092800b00661e37421c2so7810984ott.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbVB8G8BEPej53HgVesEalqPYvMIzRPvJku1Cwp0Tiw=;
        b=RnpnL/xO41rWSypjx6gXbzZwnm4JPeiWFP20bTbX/FwV/jlOgc39jRWHx15LI85E3+
         ijSKlK+K+oENE1DDIK83isc1c1a17TQ82/j8uEy35AblLHHSY/hRRysYEMUaEB9UbNiY
         NCBGw9lv/ZxZAgePIdAyx+qAoWeK3lnxMShk2Vu5IC3xGIxvSHG5btGS844nNiKQNFCs
         oh4NrlhsiyYfrtwVaZmEC9QcHD4mlHchQfJ6F1J4Ool12ZP1tDTY+CX+EekmBcQDA6sg
         YH6Mg7gk2XITrfqoDXRuXXm39fKjD7Xny+x1Gw/7UBMUoA8vRHlpk5e3490ndg/4OI6u
         tp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbVB8G8BEPej53HgVesEalqPYvMIzRPvJku1Cwp0Tiw=;
        b=qehXgbWA9+5WRLJLlKudBz4+f2odS4orE6hIrdWjI16gyFjzgrSqnctFn6FTcBUv13
         mPO4r4Vajo+RpTrKRsiYB2nP0DTs6pI50XHZ/kdOmNsuvWqoxCc+TMbOK1DIDbJmTM4F
         L4WAqbzxc4qqQvLm3pxana0ZWbIiklA7bqe81aova3w6O/Yx/VxhDmF3MeeQ96CCihMC
         28Cg/8jetNQ+lOSo6uXK2YIp1S4hTI3zXpe6fG/wq6Ts1PHUKN1W3qeuvRwo1bDC5De8
         bLK20HMKxUlHrkfdxqDd22RyMmCxkXGE6/1d2IOylLU/HLMB9szl/uKCyP5Qcx2pXw7k
         VG5Q==
X-Gm-Message-State: ACrzQf0SKpypGVg4z3A6xb90TU++hqdoJgF1xtylu1mEehKl0nIThURg
        yQrUtx3OscX8F2gnOElFpk34vz/7+Y0=
X-Google-Smtp-Source: AMsMyM45ZwnoR9mWO2jB+td8lM/a9Cq9YG5dZ5pNT5Ze92XYkBKqPyPyjL8bGVq015U4yAvEToZlsA==
X-Received: by 2002:a05:6830:1f3d:b0:663:d47d:2482 with SMTP id e29-20020a0568301f3d00b00663d47d2482mr5527786oth.114.1666708199742;
        Tue, 25 Oct 2022 07:29:59 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id f8-20020a056870210800b001324315bb6asm1605722oae.29.2022.10.25.07.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:29:59 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B5B97404BE; Tue, 25 Oct 2022 11:29:56 -0300 (-03)
Date:   Tue, 25 Oct 2022 11:29:56 -0300
To:     linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        D Scott Phillips <scott@os.amperecomputing.com>
Subject: [PATCH FYI 1/1] tools headers arm64: Sync arm64's cputype.h with the
 kernel sources
Message-ID: <Y1fy5GD7ZYvkeufv@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To get the changes in:

  0e5d5ae837c8ce04 ("arm64: Add AMPERE1 to the Spectre-BHB affected list")

That addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/arm64/include/asm/cputype.h' differs from latest version at 'arch/arm64/include/asm/cputype.h'
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: D Scott Phillips <scott@os.amperecomputing.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/asm/cputype.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 8aa0d276a63628f5..abc418650fec04fd 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -60,6 +60,7 @@
 #define ARM_CPU_IMP_FUJITSU		0x46
 #define ARM_CPU_IMP_HISI		0x48
 #define ARM_CPU_IMP_APPLE		0x61
+#define ARM_CPU_IMP_AMPERE		0xC0
 
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
@@ -123,6 +124,8 @@
 #define APPLE_CPU_PART_M1_ICESTORM_MAX	0x028
 #define APPLE_CPU_PART_M1_FIRESTORM_MAX	0x029
 
+#define AMPERE_CPU_PART_AMPERE1		0xAC3
+
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
@@ -172,6 +175,7 @@
 #define MIDR_APPLE_M1_FIRESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM_PRO)
 #define MIDR_APPLE_M1_ICESTORM_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_MAX)
 #define MIDR_APPLE_M1_FIRESTORM_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM_MAX)
+#define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
 
 /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
 #define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
-- 
2.37.3

