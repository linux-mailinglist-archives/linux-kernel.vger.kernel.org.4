Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C69C74FBA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 01:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjGKXBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 19:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjGKXBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 19:01:42 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3818310D8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:01:41 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-262d69faef9so6960784a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689116500; x=1691708500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8VQapMKBQBMTZxsjOULvb/Z6n7A3B0Prs/TRyhAaINo=;
        b=0meBJIEhxTgxt0w5IKnl8Z7teH02rv9JZxqyDtEuF1SoUNM0EhdKFpSC+T8V5Zcc4f
         ItM4ARCIWVT/rgEt8uYkBwBE/REmEktJEKeeLxdD+HYTwWEZGeMbWRig1L8QTKsIQ5T2
         hVkbXXKQSkWbxGGMsrcm56i8+aD/5dB7DOJP97opcnl2Ry4E6RHruR/qykibFq0/aUfW
         extko0Q/JcbDrL4/gyZcVcBTXaYze++0rQtwMUtlL1UnwshBD8Q5le30OExohxvBKRNa
         iLoDSD7fcIE/6uWCbzRK5jSM2JFe8rTxZeHBnCvka8ar7fO6J7NhQ6ilvUovBerrQ8U2
         Jhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689116500; x=1691708500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VQapMKBQBMTZxsjOULvb/Z6n7A3B0Prs/TRyhAaINo=;
        b=H9NxWJiyzBg0uq0tCgVMftQ4zTYVB6mT0QJeDae9gtXzEF01SmscsWyDvKRSuB7j0/
         5p5fwTa5wmogFDBpewq/Jji4TlItgC3hRHSuXGH7UysMec1+cJKXOUqfnGvstc467bUt
         eRL53sWNIgfug/ruRuTgsCrLl5trZoU3AUnHkhIWsR/IibGKMbFwfQN7Oe+ob7kYwbcn
         HpW7DvzZ/F7bWNs7OOVYSYvdIk+eIt94XIWxsA+paofF1DEhICHssL0zjxrDesLvRMux
         BAV9gO/8Bf85a6oow+e6UISQ+52wbYWW3J+tfOHPfd3XkL5EwjLk3ENgPl5wR6n5cjUn
         RVTg==
X-Gm-Message-State: ABy/qLZ0hLRIoLry0OG5rH20qfLr4O60MGOuM4Ha3Ra8H+UWWT7vAGrW
        4RnQTmwty40nhdjJU5A4PeJ/rDwU9nY=
X-Google-Smtp-Source: APBJJlGManPSJIk0kdX94lHfSRSwM/QUvQS1ucWRoZhgJW/JZxlZW9IEoHaKwptTif9cwXe6p+xwpmckpJs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:a417:b0:1b8:2055:fc1f with SMTP id
 p23-20020a170902a41700b001b82055fc1fmr13104726plq.2.1689116500737; Tue, 11
 Jul 2023 16:01:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 11 Jul 2023 16:01:27 -0700
In-Reply-To: <20230711230131.648752-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230711230131.648752-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230711230131.648752-4-seanjc@google.com>
Subject: [PATCH 3/7] KVM: selftests: Clean up stats fd in common stats_test() helper
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

Move the stats fd cleanup code into stats_test() and drop the
superfluous vm_stats_test() and vcpu_stats_test() helpers in order to
decouple creation of the stats file from consuming/testing the file
(deduping code is a bonus).  This will make it easier to test various
edge cases related to stats, e.g. that userspace can dup() a stats fd,
that userspace can have multiple stats files for a singleVM/vCPU, etc.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/kvm_binary_stats_test.c     | 22 ++++---------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index eae99d0e8377..f02663711c90 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -167,23 +167,7 @@ static void stats_test(int stats_fd)
 	free(stats_data);
 	free(stats_desc);
 	free(id);
-}
 
-
-static void vm_stats_test(struct kvm_vm *vm)
-{
-	int stats_fd = vm_get_stats_fd(vm);
-
-	stats_test(stats_fd);
-	close(stats_fd);
-	TEST_ASSERT(fcntl(stats_fd, F_GETFD) == -1, "Stats fd not freed");
-}
-
-static void vcpu_stats_test(struct kvm_vcpu *vcpu)
-{
-	int stats_fd = vcpu_get_stats_fd(vcpu);
-
-	stats_test(stats_fd);
 	close(stats_fd);
 	TEST_ASSERT(fcntl(stats_fd, F_GETFD) == -1, "Stats fd not freed");
 }
@@ -241,9 +225,11 @@ int main(int argc, char *argv[])
 
 	/* Check stats read for every VM and VCPU */
 	for (i = 0; i < max_vm; ++i) {
-		vm_stats_test(vms[i]);
+		stats_test(vm_get_stats_fd(vms[i]));
+
 		for (j = 0; j < max_vcpu; ++j)
-			vcpu_stats_test(vcpus[i * max_vcpu + j]);
+			stats_test(vcpu_get_stats_fd(vcpus[i * max_vcpu + j]));
+
 		ksft_test_result_pass("vm%i\n", i);
 	}
 
-- 
2.41.0.255.g8b1d071c50-goog

