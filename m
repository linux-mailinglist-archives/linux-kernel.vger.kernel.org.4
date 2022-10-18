Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3328B60347C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 22:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiJRU7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 16:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJRU73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 16:59:29 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB72C1D8B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:59:08 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id v5-20020a17090abb8500b0020a76ded27eso12431214pjr.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L04i/bHb+FWWtwiQpLypJXSsQojGyBvdLvEayXA31so=;
        b=K8TIEus1IJ1GCzPG4wpF0e63hzchCvpqkrYnoE5SR8c3cXYK3qPOLgzYr1mXKd84bP
         r26FSAX5jQ6pYYhguRf2fYJP5kRlRJMlEfZv/oeXUo4MtbuY2naVFp3j2UX49thAuhXK
         BPn3l869e1Izuu9gXybVlFNrJrJH/P1+BBlewyS6e/vPIxvFfjTVUgi8D7IE3sgiMVM+
         4dOOi/sTYLYNdwtgqr1f9ZBKr9KgcXkExPgALs1sj0wTnkt92h7r8K6EsRiIG1gDqW64
         w387plPBqyecazJtgFcNCrKWA9gjPJn0wNrYmBdFra4uF/owkoUzYd/yzLFjwcS0yJfe
         8+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L04i/bHb+FWWtwiQpLypJXSsQojGyBvdLvEayXA31so=;
        b=Imy6GjM+GZgTPRAam8Pg2izOESZ06LufaT/2ZR7ZsgGJheojrAd8xlYkSvxZxTUt3J
         HxokQApwbYQnUV6XoYHUM0oEDPMUa3yJ5IHtgpT8q/qA/lPAnLmB/ZeokDcDk9osMwXJ
         3lMaUvyUD4Blj0OUIPyFBHdY2Gz3CfWMnH/m7F9Wr1jq7zFyWkvCrNv2LVjrVdoSCo4h
         EETlGR029nnfn+6PfCn1Z6StAnwjsLJGg4YNn0Z9r4UVFO3otrE3oTPwr0TNJgMGPLUt
         WBIha8PgIMQkabSyY7Uxk9c76HXMx/sGj06uor0umg0501pQx/hVdjdWeaqFQt35obHz
         ji4g==
X-Gm-Message-State: ACrzQf2+Xkq14Z/XrWHToQ2DQF+UkhaxUQQ3X5g6I4LrBod0LHKRV9zY
        2PeLk7cRjXRc4wVnYja5a5/diyjlHB4=
X-Google-Smtp-Source: AMsMyM5aOGzgU6VCd5MWRKzdgGZHnJqguWTWA2V6bGopVthtYOFCasR3EJ/qvKqrnohu3Bvq96H5YvTL1lo=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:c89b:7f49:3437:9db8])
 (user=pgonda job=sendgmr) by 2002:a17:90b:390b:b0:20d:2335:bff0 with SMTP id
 ob11-20020a17090b390b00b0020d2335bff0mr41157901pjb.141.1666126747247; Tue, 18
 Oct 2022 13:59:07 -0700 (PDT)
Date:   Tue, 18 Oct 2022 13:58:45 -0700
In-Reply-To: <20221018205845.770121-1-pgonda@google.com>
Message-Id: <20221018205845.770121-8-pgonda@google.com>
Mime-Version: 1.0
References: <20221018205845.770121-1-pgonda@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Subject: [PATCH V5 7/7] KVM: selftests: Add simple sev vm testing
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, marcorr@google.com,
        seanjc@google.com, michael.roth@amd.com, thomas.lendacky@amd.com,
        joro@8bytes.org, mizhang@google.com, pbonzini@redhat.com,
        andrew.jones@linux.dev, pgonda@google.com, vannapurve@google.com
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

Suggested-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |  1 +
 tools/testing/selftests/kvm/Makefile          |  1 +
 .../selftests/kvm/x86_64/sev_all_boot_test.c  | 84 +++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 2f0d705db9db..813e7610619d 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -35,6 +35,7 @@
 /x86_64/pmu_event_filter_test
 /x86_64/set_boot_cpu_id
 /x86_64/set_sregs_test
+/x86_64/sev_all_boot_test
 /x86_64/sev_migrate_tests
 /x86_64/smm_test
 /x86_64/state_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 4f27ef70cf2b..1eb9b2aa7c22 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -126,6 +126,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/tsc_msrs_test
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
2.38.0.413.g74048e4d9e-goog

