Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D22461A79E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 05:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiKEE5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 00:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiKEE5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 00:57:15 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2090E31F9D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 21:57:15 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id g66-20020a636b45000000b0043a256d3639so3442308pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 21:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n6Upwu++k4u4pvTQ5ggpu28fN9WErU6ZbFJtDquZjUo=;
        b=gwunFD8XRkB8tadYDha1qv/kRbDMr1XGQO+PmaHs5uPp80MzHt+AYtQBb1FEzg2RAR
         irHZokc2miBdZR7YaSYRWxBK9nEUsVNpZAOBvsupFTUytJOg0+ds2NYQoQyerq34hC+Y
         p1PkX1fGoXWBXXMPOx0mOyo/iwgTfnPgZzICMEnTkZu0mWKshtik31He5oszFlNyrz43
         e7QeYPXeLdVF52hlBSFEjC/RJ3015l9aQEm4B7lVy9hj/5RtnywsGszEMFAL6k32tKvw
         jceiWseFi+j95U9168l+lnNladYXUm0KgO269XNo2V/8aVxzeNpZrKZFTqCmuY9a3kQ9
         e2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6Upwu++k4u4pvTQ5ggpu28fN9WErU6ZbFJtDquZjUo=;
        b=FBg/pknOhYhIdmfjEnJVvHXFd72lJl4uvDqEJXfgBcVxcjHSS0FCD7N+Pn0gTcw8eX
         ZX6h8iX72oGUcK5zDipBosDNUUeDEMc+xdmaC9fjgnFHiT0NQbaqPu9EJ5Vqm7cQ1sY9
         unHsZvKqyzWmjfGssEuLV1vxOfkSuzbNOLinLE38iJCGKri1NEfj5IVI8XyJkZpIfSOD
         sHW9jSL4yAEFzEB9k9ulnhn7g/JFeASJ+T/Fof3ewhMJJ7f5lPxHCvmUljXY87UPgtT/
         Hy39z7PSp8ARkWTNFiweMsD08NKHUrDxL6TFGVfDepcGzKy8uFgX9sOnxzfTXWPlN5lJ
         yB2Q==
X-Gm-Message-State: ACrzQf2f2rW9tUnP7ZxhltpOKBubcHSFwTCEZKd4IxokGFRT1ywF5DL/
        hvBG+ke0Yx2sIrFkaeNUsvrN5+Q3QOZc
X-Google-Smtp-Source: AMsMyM6GijZVfmsYGrKZhmiG6jO7MByuyeJQVUsCsQrrtEvCpSi5e5egOzX0GKLixjyllbP207KuvjtNSk9y
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a05:6a00:2409:b0:54e:a3ad:d32d with SMTP
 id z9-20020a056a00240900b0054ea3add32dmr38883061pfh.70.1667624234662; Fri, 04
 Nov 2022 21:57:14 -0700 (PDT)
Date:   Fri,  4 Nov 2022 21:57:01 -0700
In-Reply-To: <20221105045704.2315186-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20221105045704.2315186-1-vipinsh@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221105045704.2315186-4-vipinsh@google.com>
Subject: [PATCH 3/6] KVM: selftests: Test Hyper-V extended hypercall enablement
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com
Cc:     dmatlack@google.com, kvm@vger.kernel.org,
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

Test Extended hypercall CPUID enablement

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/hyperv.h  | 4 ++++
 tools/testing/selftests/kvm/x86_64/hyperv_features.c | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/hyperv.h b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
index b66910702c0a..075fd29071a6 100644
--- a/tools/testing/selftests/kvm/include/x86_64/hyperv.h
+++ b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
@@ -110,6 +110,7 @@
 #define HV_ACCESS_STATS				BIT(8)
 #define HV_DEBUGGING				BIT(11)
 #define HV_CPU_MANAGEMENT			BIT(12)
+#define HV_ENABLE_EXTENDED_HYPERCALLS		BIT(20)
 #define HV_ISOLATION				BIT(22)
 
 /* HYPERV_CPUID_FEATURES.EDX */
@@ -164,6 +165,9 @@
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
 
+/* Extended hypercalls */
+#define HV_EXT_CALL_QUERY_CAPABILITIES		0x8001
+
 #define HV_FLUSH_ALL_PROCESSORS			BIT(0)
 #define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
 #define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY	BIT(2)
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index 05b32e550a80..6b443ce456b6 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -602,6 +602,15 @@ static void guest_test_hcalls_access(void)
 			hcall->expect = HV_STATUS_SUCCESS;
 			break;
 		case 19:
+			hcall->control = HV_EXT_CALL_QUERY_CAPABILITIES;
+			hcall->expect = HV_STATUS_ACCESS_DENIED;
+			break;
+		case 20:
+			feat->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
+			hcall->control = HV_EXT_CALL_QUERY_CAPABILITIES | HV_HYPERCALL_FAST_BIT;
+			hcall->expect = HV_STATUS_INVALID_PARAMETER;
+			break;
+		case 21:
 			kvm_vm_free(vm);
 			return;
 		}
-- 
2.38.1.273.g43a17bfeac-goog

