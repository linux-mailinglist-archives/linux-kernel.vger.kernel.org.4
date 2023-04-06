Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59646D8B95
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjDFAR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjDFAR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:17:28 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6D94C25
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:17:26 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 20-20020a630514000000b0050bed8b0b61so11235357pgf.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 17:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680740246;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSrLpj5Mx+jlyA+XFp12BRt3DAqBhRubVCM/KLiZHsM=;
        b=Tkso+jzYidBy6OOwDkvxljn0sCdqk35kTgKT14HDFDP9omJXZm1QexkYtg/xggSTaG
         pJGGTp/SIbDZaHx7sB94nEIhRrWF8NGeS3LBhvaks1ZMaqIJULXa0GiQ9bOBHfNL/37x
         ex+1fNOQ+Ph7/q6MlxPBFHos2oxJtSVlhGlN3BK1QdVgbnJv505J8sHzsR3J7xNBE+Yr
         hrNZunQkL4zgjGxR2MgaMb7E7AMQJ3hcLLFgaNbzn+ZoasPINxpC7IklUApNLVZwxEW7
         sVbqA000ebHFxlgYvvld4thKKvzYsSwCLBJI5PjbIVRcRUbgXSufo1XeOd0WBDddWIB2
         /iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680740246;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSrLpj5Mx+jlyA+XFp12BRt3DAqBhRubVCM/KLiZHsM=;
        b=N919S33mnMQUukwBsYtUawJfnYKmu7hJpQHoD0RMpGgwyMMLzERdv4kafKhZDbpp5M
         jxnFq1bP9U1RAfRD+EkbqRbseNL5Xwtz1zcxHZlAtdoVdmIMnkrNCWdKe62cpz1mH5Wv
         sppNsWuWGHLBYoZrPJXPb0kQ5BJ92NNmH7tBAh7waM/oTg8DHkDuLTgh3neQTFL70yw0
         DH+M7S0jxxrpLjgnwmI3H6w0h+YsxsgyVQx9yvQcuPED5GCQDTn7hX4YW3vb87crrMxb
         lgwcPuzjwq5LQ0o2HtE9p3YXTkWccMNfo245HXPKanVQgYJvZfRCh3JJD6+DNmTVVNEL
         LLjA==
X-Gm-Message-State: AAQBX9eIV38E2H1NpUBgD/0cj5nhjtGG4s2hbQQkXz7YU6S7d6lQfal8
        pat0bVHwP8eTmBR7d6QI+HFdjOeIYYQ=
X-Google-Smtp-Source: AKy350ZYPMUiMSxUEMGNgrl/UmKWv4BJnYIBWgqomDGllnZVYQEsa/60/oBwutrkgPxgnvw71SHNglGRl5Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:400b:0:b0:503:a26e:b4cf with SMTP id
 f11-20020a65400b000000b00503a26eb4cfmr2573022pgp.8.1680740246264; Wed, 05 Apr
 2023 17:17:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  5 Apr 2023 17:17:24 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230406001724.706668-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Refactor stable TSC check to use TEST_REQUIRE()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Ge <gehao@kylinos.cn>, Vipin Sharma <vipinsh@google.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the nested TSC scaling test's check on a stable system TSC to
use TEST_REQUIRE() to do the heavy lifting when the system doesn't have
a stable TSC.  Using a helper+TEST_REQUIRE() eliminates the need for
gotos and a custom message.

Cc: Hao Ge <gehao@kylinos.cn>
Cc: Vipin Sharma <vipinsh@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86_64/vmx_nested_tsc_scaling_test.c  | 22 ++++++-------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
index fa03c8d1ce4e..e710b6e7fb38 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_nested_tsc_scaling_test.c
@@ -116,29 +116,21 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_DONE();
 }
 
-static void stable_tsc_check_supported(void)
+static bool system_has_stable_tsc(void)
 {
+	bool tsc_is_stable;
 	FILE *fp;
 	char buf[4];
 
 	fp = fopen("/sys/devices/system/clocksource/clocksource0/current_clocksource", "r");
 	if (fp == NULL)
-		goto skip_test;
+		return false;
 
-	if (fgets(buf, sizeof(buf), fp) == NULL)
-		goto close_fp;
+	tsc_is_stable = fgets(buf, sizeof(buf), fp) &&
+			!strncmp(buf, "tsc", sizeof(buf));
 
-	if (strncmp(buf, "tsc", sizeof(buf)))
-		goto close_fp;
-
-	fclose(fp);
-	return;
-
-close_fp:
 	fclose(fp);
-skip_test:
-	print_skip("Kernel does not use TSC clocksource - assuming that host TSC is not stable");
-	exit(KSFT_SKIP);
+	return tsc_is_stable;
 }
 
 int main(int argc, char *argv[])
@@ -156,7 +148,7 @@ int main(int argc, char *argv[])
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_TSC_CONTROL));
-	stable_tsc_check_supported();
+	TEST_REQUIRE(system_has_stable_tsc());
 
 	/*
 	 * We set L1's scale factor to be a random number from 2 to 10.

base-commit: 7712145073876092e9aa81f0b836fef8b5694b14
-- 
2.40.0.348.gf938b09366-goog

