Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330C66525E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiLTR52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiLTR5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:57:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D9910073
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:57:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DB446153E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 17:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18C5C433EF;
        Tue, 20 Dec 2022 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671559027;
        bh=M9kuyg00XjU+L/DMru8P2wesROkB1+ANbTjymLYWkSE=;
        h=Date:From:To:Cc:Subject:From;
        b=nXaPlcgAiBoPhmgV+aky0FDLx8QRZs+Ws4/7QX0wQKejkRoHXQUHxr5vPF3lalqzj
         lcGg3OmjE5z6SxcBirOoOU0aTNHSboeAiQD65lLxJKrt3blFVOpExmQixNEH4QQIh8
         q0hGCGsOD2qZbTbIWAnEkBFYPM2svEjNZGJMHShHIZx1VgntMWJRNav7cC7NE4l+Uy
         9wTHjgYPZ7yLEYWRbz9WVz1Xqp70Omq2iKFAVLHyU9z8EU8m1xsSLRuWvomPGXcSd6
         N5u5ROx4MpedZqFeV9D+4MtOy7E3Q6BZGdXPF11z9AW94exriMQe8BSH6rQ5H4LMJd
         qMRVgD5HPZd+A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EB85D40367; Tue, 20 Dec 2022 14:57:03 -0300 (-03)
Date:   Tue, 20 Dec 2022 14:57:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Gavin Shan <gshan@redhat.com>, Ian Rogers <irogers@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync linux/kvm.h with the kernel
 sources
Message-ID: <Y6H3b1Q4Msjy5Yz3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

  86bdf3ebcfe1ded0 ("KVM: Support dirty ring in conjunction with bitmap")

That just rebuilds perf, as these patches don't add any new KVM ioctl to
be harvested for the the 'perf trace' ioctl syscall argument
beautifiers.

This is also by now used by tools/testing/selftests/kvm/, a simple test
build didn't succeed, but for another reason:

  lib/kvm_util.c: In function ‘vm_enable_dirty_ring’:
  lib/kvm_util.c:125:30: error: ‘KVM_CAP_DIRTY_LOG_RING_ACQ_REL’ undeclared (first use in this function); did you mean ‘KVM_CAP_DIRTY_LOG_RING’?
    125 |         if (vm_check_cap(vm, KVM_CAP_DIRTY_LOG_RING_ACQ_REL))
        |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        |                              KVM_CAP_DIRTY_LOG_RING

I'll send a separate patch for that.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Gavin Shan <gshan@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 21d6d29502e486ad..20522d4ba1e0d8b0 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -98,7 +98,7 @@ struct kvm_userspace_memory_region {
 /*
  * The bit 0 ~ bit 15 of kvm_userspace_memory_region::flags are visible for
  * userspace, other bits are reserved for kvm internal use which are defined
- *in include/linux/kvm_host.h.
+ * in include/linux/kvm_host.h.
  */
 #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
 #define KVM_MEM_READONLY	(1UL << 1)
@@ -477,6 +477,9 @@ struct kvm_run {
 #define KVM_MSR_EXIT_REASON_INVAL	(1 << 0)
 #define KVM_MSR_EXIT_REASON_UNKNOWN	(1 << 1)
 #define KVM_MSR_EXIT_REASON_FILTER	(1 << 2)
+#define KVM_MSR_EXIT_REASON_VALID_MASK	(KVM_MSR_EXIT_REASON_INVAL   |	\
+					 KVM_MSR_EXIT_REASON_UNKNOWN |	\
+					 KVM_MSR_EXIT_REASON_FILTER)
 			__u32 reason; /* kernel -> user */
 			__u32 index; /* kernel -> user */
 			__u64 data; /* kernel <-> user */
@@ -1170,6 +1173,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_ZPCI_OP 221
 #define KVM_CAP_S390_CPU_TOPOLOGY 222
 #define KVM_CAP_DIRTY_LOG_RING_ACQ_REL 223
+#define KVM_CAP_S390_PROTECTED_ASYNC_DISABLE 224
+#define KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP 225
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1259,6 +1264,7 @@ struct kvm_x86_mce {
 #define KVM_XEN_HVM_CONFIG_RUNSTATE		(1 << 3)
 #define KVM_XEN_HVM_CONFIG_EVTCHN_2LEVEL	(1 << 4)
 #define KVM_XEN_HVM_CONFIG_EVTCHN_SEND		(1 << 5)
+#define KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG	(1 << 6)
 
 struct kvm_xen_hvm_config {
 	__u32 flags;
@@ -1726,6 +1732,8 @@ enum pv_cmd_id {
 	KVM_PV_UNSHARE_ALL,
 	KVM_PV_INFO,
 	KVM_PV_DUMP,
+	KVM_PV_ASYNC_CLEANUP_PREPARE,
+	KVM_PV_ASYNC_CLEANUP_PERFORM,
 };
 
 struct kvm_pv_cmd {
@@ -1756,6 +1764,7 @@ struct kvm_xen_hvm_attr {
 	union {
 		__u8 long_mode;
 		__u8 vector;
+		__u8 runstate_update_flag;
 		struct {
 			__u64 gfn;
 		} shared_info;
@@ -1796,6 +1805,8 @@ struct kvm_xen_hvm_attr {
 /* Available with KVM_CAP_XEN_HVM / KVM_XEN_HVM_CONFIG_EVTCHN_SEND */
 #define KVM_XEN_ATTR_TYPE_EVTCHN		0x3
 #define KVM_XEN_ATTR_TYPE_XEN_VERSION		0x4
+/* Available with KVM_CAP_XEN_HVM / KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG */
+#define KVM_XEN_ATTR_TYPE_RUNSTATE_UPDATE_FLAG	0x5
 
 /* Per-vCPU Xen attributes */
 #define KVM_XEN_VCPU_GET_ATTR	_IOWR(KVMIO, 0xca, struct kvm_xen_vcpu_attr)
-- 
2.38.1

