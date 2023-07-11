Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4133574F3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjGKPh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjGKPg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:36:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1188619BD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D488614DC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF09C433CC;
        Tue, 11 Jul 2023 15:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689089790;
        bh=fpzblsPSQYpoP86N5Eq39fYdejh6sSoZdOdfkJkZF2s=;
        h=Date:From:To:Cc:Subject:From;
        b=UFAoX/KoJ4MTJqDW16Qy4ZewD6kIoJ/icPvg1Mnrvdy+bJeQzgK72oVPkqfGq54Yt
         PpU+l6XQAlWbCFQtsi1qah2V7H1C/r2GMZdlH2+KSD6vabNFqKsY+yGm5Joni/4U5l
         HSnIBUYIhhk82nWgWBtKnm1YDvsCKK5mMlkQeHejr2K0TUfPkSz8vh8y7Kn8t9WZNg
         zpck6twrEeunHRLtmZazsZgiX4bQCL91dg90JNkROibTGTQDv2BuKWMmcLg/2E25k9
         SDk4mpfTaNZkGqJprGziLk1a9rz0arezvKYGsV9WFtHWSOokbUbEjkhxmfGhyL//pb
         IjInw3D2oG2dA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 02AC540516; Tue, 11 Jul 2023 12:36:26 -0300 (-03)
Date:   Tue, 11 Jul 2023 12:36:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Binbin Wu <binbin.wu@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ricardo Koller <ricarkol@google.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync linux/kvm.h with the kernel
 sources
Message-ID: <ZK12+virXMIXMysy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

To pick the changes in:

  89d01306e34d6ace ("RISC-V: KVM: Implement device interface for AIA irqchip")
  22725266bdf95bdd ("KVM: Fix comment for KVM_ENABLE_CAP")
  2f440b72e852be42 ("KVM: arm64: Add KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE")

That just rebuilds perf, as these patches don't add any new KVM ioctl to
be harvested for the the 'perf trace' ioctl syscall argument
beautifiers.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Anup Patel <apatel@ventanamicro.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Ricardo Koller <ricarkol@google.com>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 737318b1c1d9a163..f089ab290978450e 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1190,6 +1190,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP 225
 #define KVM_CAP_PMU_EVENT_MASKED_EVENTS 226
 #define KVM_CAP_COUNTER_OFFSET 227
+#define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
+#define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1442,6 +1444,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
 	KVM_DEV_TYPE_ARM_PV_TIME,
 #define KVM_DEV_TYPE_ARM_PV_TIME	KVM_DEV_TYPE_ARM_PV_TIME
+	KVM_DEV_TYPE_RISCV_AIA,
+#define KVM_DEV_TYPE_RISCV_AIA		KVM_DEV_TYPE_RISCV_AIA
 	KVM_DEV_TYPE_MAX,
 };
 
@@ -1613,7 +1617,7 @@ struct kvm_s390_ucas_mapping {
 #define KVM_GET_DEBUGREGS         _IOR(KVMIO,  0xa1, struct kvm_debugregs)
 #define KVM_SET_DEBUGREGS         _IOW(KVMIO,  0xa2, struct kvm_debugregs)
 /*
- * vcpu version available with KVM_ENABLE_CAP
+ * vcpu version available with KVM_CAP_ENABLE_CAP
  * vm version available with KVM_CAP_ENABLE_CAP_VM
  */
 #define KVM_ENABLE_CAP            _IOW(KVMIO,  0xa3, struct kvm_enable_cap)
-- 
2.37.1

