Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1A26172C0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKBXhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiKBXgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:36:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCD8D2FC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:28:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f126-20020a255184000000b006cb2aebd124so379259ybb.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 16:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=47NN14tzjqb2Jkjp+DZD0PLnkTAdeUGBp2aNHGDmHKU=;
        b=iExh/fYctDhDT2GR5L2oUQlwBYQkU8U79TQCr7U34lzJZ9FOj4LdJXlk6H96PeM/sy
         FDYviQAM8Aj4+GPwFBIfX4BIaZQrJxaEgoBet3kygw3fyE3sRYJah6Q+H1flApkDrtSj
         fmUQwcke74FTSEU5peoNjbJRdIF4gNe27CScm1SR50pWdAAJunYSaPN7lUxk+tkwruyi
         ZRMo4JarTk/lYV/tukRK3lXXnuEYcUW9AbkLvZLjxbfwMTBeLfacEh44NacfgfTG1HAf
         S3R4SEL1Cvmr9DjijMEj3K6K4Oa07mMxAIcj28VlWrkl1d8iW/YBgygbgZNAcnUn6ZZH
         2XIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47NN14tzjqb2Jkjp+DZD0PLnkTAdeUGBp2aNHGDmHKU=;
        b=DkamjX8w/lDVL90lOcLuYAvV1Zh8xebnOapcU7sCIPqNymAoBup2n6bpI99lHSpCyj
         A+hzMvjlVenFY9UIw966p5Phz+pabmxf165L4Q3ec/RiDXYJ3iX/kNNm9L5p3otv+TxL
         sL6LGXg4MooKzParjUuHvo10ruNTYQTOZMozI29Bhn3ktCcL4yVMcwNc3xegm9NA61lp
         E/sPEc5mVLpaLDIcsqZWERgZICgE7eo9ZqN/9C173NItWV2FBnBAZM/oEjgoUXBt0t2G
         CJaVPf1CHPnpdlq2Lw1wvRRbvKbf6dSU+8yULpMblwbR4vzfeIhNfnKzPB+2xzGa+21X
         NwwQ==
X-Gm-Message-State: ACrzQf1/nNAQ6n6EFpRIMgvyT0y6Ho3VB2Fqbj2XWrFdQNzf3lKrhAhz
        mXFUrpSgUfFTdQQhcXDuKSAVnCIMPpW3
X-Google-Smtp-Source: AMsMyM7c6AK421/51FaS7EjnL1reK65nBGtuf6Ki4MccFg6eZrNtGMgZwjzzyLFVz2yNbJyHZE86NwBJ/k1D
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a81:6083:0:b0:355:6608:2730 with SMTP id
 u125-20020a816083000000b0035566082730mr188700ywb.183.1667431669185; Wed, 02
 Nov 2022 16:27:49 -0700 (PDT)
Date:   Wed,  2 Nov 2022 16:27:35 -0700
In-Reply-To: <20221102232737.1351745-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221102232737.1351745-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102232737.1351745-6-vipinsh@google.com>
Subject: [PATCH v8 5/7] KVM: selftests: Shorten the test args in memslot_modification_stress_test.c
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Cc:     andrew.jones@linux.dev, wei.w.wang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
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

Change test args memslot_modification_delay and nr_memslot_modifications
to delay and nr_iterations for simplicity.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../kvm/memslot_modification_stress_test.c     | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
index d7ddc8a105a2..d6089ccaa484 100644
--- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
+++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
@@ -87,8 +87,8 @@ static void add_remove_memslot(struct kvm_vm *vm, useconds_t delay,
 }
 
 struct test_params {
-	useconds_t memslot_modification_delay;
-	uint64_t nr_memslot_modifications;
+	useconds_t delay;
+	uint64_t nr_iterations;
 	bool partition_vcpu_memory_access;
 };
 
@@ -107,8 +107,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	pr_info("Started all vCPUs\n");
 
-	add_remove_memslot(vm, p->memslot_modification_delay,
-			   p->nr_memslot_modifications);
+	add_remove_memslot(vm, p->delay,
+			   p->nr_iterations);
 
 	run_vcpus = false;
 
@@ -144,8 +144,8 @@ int main(int argc, char *argv[])
 	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
 	int opt;
 	struct test_params p = {
-		.memslot_modification_delay = 0,
-		.nr_memslot_modifications =
+		.delay = 0,
+		.nr_iterations =
 			DEFAULT_MEMSLOT_MODIFICATION_ITERATIONS,
 		.partition_vcpu_memory_access = true
 	};
@@ -158,8 +158,8 @@ int main(int argc, char *argv[])
 			guest_modes_cmdline(optarg);
 			break;
 		case 'd':
-			p.memslot_modification_delay = atoi_paranoid(optarg);
-			TEST_ASSERT(p.memslot_modification_delay >= 0,
+			p.delay = atoi_paranoid(optarg);
+			TEST_ASSERT(p.delay >= 0,
 				    "A negative delay is not supported.");
 			break;
 		case 'b':
@@ -175,7 +175,7 @@ int main(int argc, char *argv[])
 			p.partition_vcpu_memory_access = false;
 			break;
 		case 'i':
-			p.nr_memslot_modifications = atoi_paranoid(optarg);
+			p.nr_iterations = atoi_paranoid(optarg);
 			break;
 		case 'h':
 		default:
-- 
2.38.1.273.g43a17bfeac-goog

