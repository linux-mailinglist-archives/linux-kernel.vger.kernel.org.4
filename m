Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB48D664CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjAJTnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjAJTnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:43:23 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB20CDEB3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:43:22 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id y37-20020a634b25000000b004b1d90ea947so3557136pga.15
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XmjuGEcRACakTvOMtrLrmXhVn02mZnR7fERkmJ1dYkc=;
        b=rXV+aFWr3GAnUDp4iw94U5r3juez5gY6E40D21jZPY+Kir5xKBuk1BinoAEDlKhseN
         Skjx/QVvdik0l/9326BENbkDQIyWfAcUbIgL1YgB4gI9ohPBz4R7EtCazN/zB0rc4IP/
         Hohjhb5qPyO/AJyWcblDFbe+/Q0UzAJFN2CbSZ7hwHKev3YNkL5ldEmIX1khgDLLRMx+
         TkzyzgeAfkFocz29yr0IlXz5+Ote8oZF9u7mFhgUeAZM7DWvzKi8NPjPJ6PJ9xkyBdxx
         UwmaOvjfbdKfnpmO/A1ieviS7VaVhJyQJ/zIwZURvk5XgR8GHoS4lYdRpDO4Xi6umkjz
         NdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XmjuGEcRACakTvOMtrLrmXhVn02mZnR7fERkmJ1dYkc=;
        b=IbRcBJLB4j1RV1gFeOJuqvxoz57pT3NVEqtzvtcLK/N1/hURVF2fZzGAvexInkFd/R
         XfKlD7nQr9QITa0XygQlZ5jdRGdz9HKrtD1DL1Qn2U0rVnPPZggXcuAzVTnjdDqCDawS
         u+b0VY8Ne1NyAmgVN2HT352DrHtnAG5kWafA0D0reRw1yU4Tza742GdYKZPjsfhp/Uv5
         s0ike63SOzGUAfbE9uk6lqc0YBx/KsHTPC0sHz0fBKDH+sMG/wK3Sw8rlqkWReJ3FFfU
         Xw8+oGb6HYNr1PzgJzBRUdL+/Er2R/US/ovtjTtW0kZYI78wHeFw+4G2SwocQcmgP6vj
         vFDQ==
X-Gm-Message-State: AFqh2kq0l4CxbFAHyUIPu1Ruza1+4Dqg5OVpg8lIHrfnn5Q4+et+4rBN
        PLIxLk5PdxSmV4f7rTM3c0N7Zz2PCtQ=
X-Google-Smtp-Source: AMrXdXvxlL0QPDsTWiYuM9c/C5hYNN1CxBk526MWowwobh4qRYTlxj7BbwWIy5YStL1CKT4qpoVKVxyyeao=
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:11:8358:4c2a:eae1:4752])
 (user=pgonda job=sendgmr) by 2002:a17:902:a98a:b0:187:190f:6aa7 with SMTP id
 bh10-20020a170902a98a00b00187190f6aa7mr4899864plb.131.1673379802175; Tue, 10
 Jan 2023 11:43:22 -0800 (PST)
Date:   Tue, 10 Jan 2023 11:43:19 -0800
Message-Id: <20230110194319.953718-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH V6.1 7/7] KVM: selftests: Add simple sev vm testing
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Michael Roth <michael.roth@amd.com>
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

A very simple of booting SEV guests that checks related CPUID bits. This
is a stripped down version of "[PATCH v2 08/13] KVM: selftests: add SEV
boot tests" from Michael but much simpler.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
cc: Andrew Jones <andrew.jones@linux.dev>
Suggested-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
---
V6.1
  *Fixes gitignore change headers.
---
 tools/testing/selftests/kvm/Makefile          |  1 +
 .../selftests/kvm/x86_64/sev_all_boot_test.c  | 84 +++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index b7cfb15712d1..66d7ab3da990 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -111,6 +111,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/tsc_msrs_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_pmu_caps_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_shinfo_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_vmcall_test
+TEST_GEN_PROGS_x86_64 += x86_64/sev_all_boot_test
 TEST_GEN_PROGS_x86_64 += x86_64/sev_migrate_tests
 TEST_GEN_PROGS_x86_64 += x86_64/amx_test
 TEST_GEN_PROGS_x86_64 += x86_64/max_vcpuid_cap_test
diff --git a/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
new file mode 100644
index 000000000000..e9e4d7305bc1
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Basic SEV boot tests.
+ *
+ */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+#include "linux/psp-sev.h"
+#include "sev.h"
+
+#define NR_SYNCS 1
+
+#define MSR_AMD64_SEV_BIT  1
+
+static void guest_run_loop(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+	int i;
+
+	for (i = 0; i <= NR_SYNCS; ++i) {
+		vcpu_run(vcpu);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			continue;
+		case UCALL_DONE:
+			return;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unexpected exit: %s",
+				  exit_reason_str(vcpu->run->exit_reason));
+		}
+	}
+}
+
+static void is_sev_enabled(void)
+{
+	uint64_t sev_status;
+
+	GUEST_ASSERT(this_cpu_has(X86_FEATURE_SEV));
+
+	sev_status = rdmsr(MSR_AMD64_SEV);
+	GUEST_ASSERT(sev_status & 0x1);
+}
+
+static void guest_sev_code(void)
+{
+	GUEST_SYNC(1);
+
+	is_sev_enabled();
+
+	GUEST_DONE();
+}
+
+static void test_sev(void *guest_code, uint64_t policy)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm = vm_sev_create_with_one_vcpu(policy, guest_code, &vcpu);
+	TEST_ASSERT(vm, "vm_sev_create_with_one_vcpu() failed to create VM\n");
+
+	guest_run_loop(vcpu);
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(is_kvm_sev_supported());
+
+	test_sev(guest_sev_code, SEV_POLICY_NO_DBG);
+	test_sev(guest_sev_code, 0);
+
+	return 0;
+}
-- 
2.39.0.314.g84b9a713c41-goog

