Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C8274FBAA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 01:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjGKXCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 19:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjGKXB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 19:01:58 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AC7199E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:01:47 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2631fc29e8aso6932728a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689116507; x=1691708507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qyvtqeRPq/MlF0ZTdDehI+RMIDCPhIW4IOYWhk2FAaM=;
        b=QEG302AqsBou4e85I0bF1Fz1XHfj0kuK+s+Tyb/kkQXroB3QCJtAhiMap8KwBAPra/
         6dcmyFBYaZJ8RT7RQa7OY1Sv8Bq/HZxHa/hQ/i0T48PfCJX4o82eWzWooZWWpf9I/9hI
         BmJU4cP7FdnXukTED5kPtBE1V7fVEVH3jgT7bjT7vwZcpSYJXmNuAefLnVlGTauwTbFN
         J2hChuMEbuHZ4Lg75AxBrMxefqcIHUIiyVrsJFOykmBCruaMa6gD+2f0zzjDugYF/Nby
         c66Uj630xv5E9wJ2kPs2CBKz123BxpbrZJ38lJWWHiYCINz+XSK+zr8bzynn2LI3K0tL
         ynqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689116507; x=1691708507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyvtqeRPq/MlF0ZTdDehI+RMIDCPhIW4IOYWhk2FAaM=;
        b=T1Q0SyVL+uByS9olfs11gdeL0V9OG6pF59jGD3acb6zNDIXA+wUF+kOmbbhJYpEx9T
         qvdI4XQhXVAaHkzZQXI1xBwFj0Y96ERCrl+QURJo3gCPQI2vhXu/I3k0mYv8981VKpDk
         QHWnT0xMkND4UnTtvAIqfYdidfQUocydjXq5kZH3YANKURGrbJHZJm0WykVqKjM3eef8
         4FWOHaZX7GdzKV8pQLM08t8BywNiAKM2pv8M/f2D0OiEY0neiwZRQzfqrxPNQPwJ7SiK
         qfexKdR/dp10CPG60MeofWq7Rbr4fAahkadmia52jOx5zW/J5JH1lKbAXF5BLwQPOF7p
         sx8Q==
X-Gm-Message-State: ABy/qLboIQp4w5dy6a1slXOAqcy0z5pKJVaqE1IJBLCYkRYFViEyXrCw
        5f91T2xPGRnXAZw/CeADYe1Mf2MEV/k=
X-Google-Smtp-Source: APBJJlFssnO9DQk9xNcC8/Dw0TPX6R+aq2Z9D0TlOLfkADLXcqzjIuHJH8FHS9An3QkxmoLlpbPu6f6OJtY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ead1:b0:1b9:e8e5:b0a4 with SMTP id
 p17-20020a170902ead100b001b9e8e5b0a4mr2142642pld.8.1689116506840; Tue, 11 Jul
 2023 16:01:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 11 Jul 2023 16:01:30 -0700
In-Reply-To: <20230711230131.648752-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230711230131.648752-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711230131.648752-7-seanjc@google.com>
Subject: [PATCH 6/7] KVM: selftests: Verify stats fd can be dup()'d and read
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheng Zhang <zheng.zhang@email.ucr.edu>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand the binary stats test to verify that a stats fd can be dup()'d
and read, to (very) roughly simulate userspace passing around the file.
Adding the dup() test is primarily an intermediate step towards verifying
that userspace can read VM/vCPU stats before _and_ after userspace closes
its copy of the VM fd; the dup() test itself is only mildly interesting.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/kvm_binary_stats_test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index 653f10d8fb7c..5317e27b77d0 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -232,17 +232,23 @@ int main(int argc, char *argv[])
 	}
 
 	/*
-	 * Check stats read for every VM and vCPU, with a variety of testcases.
+	 * Check stats read for every VM and vCPU, with a variety of flavors.
 	 * Note, stats_test() closes the passed in stats fd.
 	 */
 	for (i = 0; i < max_vm; ++i) {
+		/*
+		 * Verify that creating multiple userspace references to a
+		 * single stats file works and doesn't cause explosions.
+		 */
 		vm_stats_fds = vm_get_stats_fd(vms[i]);
+		stats_test(dup(vm_stats_fds));
 
 		/* Verify userspace can instantiate multiple stats files. */
 		stats_test(vm_get_stats_fd(vms[i]));
 
 		for (j = 0; j < max_vcpu; ++j) {
 			vcpu_stats_fds[j] = vcpu_get_stats_fd(vcpus[i * max_vcpu + j]);
+			stats_test(dup(vcpu_stats_fds[j]));
 			stats_test(vcpu_get_stats_fd(vcpus[i * max_vcpu + j]));
 		}
 
-- 
2.41.0.255.g8b1d071c50-goog

