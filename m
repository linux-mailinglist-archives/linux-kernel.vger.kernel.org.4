Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF96964AC39
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiLMASM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiLMARZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:17:25 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41921CB2E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:17:17 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id z4-20020a17090ab10400b002195a146546so1013156pjq.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xj/6XiZ0FcL9g/cIOTUKNxH2a5zHGMGnhonaffOKQyU=;
        b=Ynr5HNzm6tcPWug6yfLA7uxzPSFdxsDbFS0g0RKFnUjDpg1KpLtNRGj/Gf5/eVmZS7
         /E+4Syq2m0k2o5pz9jJkKOO6Sj8cSiSA59XiRJyOIRS4qCG3ooDGOujDsXFak0y3HWEH
         JVE64IrNpMB7KkNprBOvUTG/cEurYq5To2UJjMVj8f7IjF8u6mpzW6rAt4PhQmyqLhQB
         1i18xIcii3lgptRuB9CPP2XNPfFgre8ZBl8B6sbn4hkuTa1njt/nq23+dRz4CjgSzC33
         AdeV5GwIU5qK4qiw325lbgQvG6tA0I6pTb5gl4H3ZodnnRxzTiH/D2U7oooCiaGH4QZQ
         TQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xj/6XiZ0FcL9g/cIOTUKNxH2a5zHGMGnhonaffOKQyU=;
        b=DKuZYnbulzWuq1yahcPuFUYwon8Z+49yH5J9alQf6Rspa9Tbi+bxd22QL52LPIB03h
         rIQUHiLkapG6ZVGlV/vY5nGthiqEHnEOIeh8fae4zi3PaijHFufUoN4F+URMNoQ2bVJ6
         7nzQCX/rbwNyfeJY4/lvwzI5NaMppqNjNwFJYRC6v87txn0jxE5PaQuE/hUarUjlg183
         5m/Dj6R8L1zWtosahM/si17oUhTMFEGjv5/lRMGt8FnyM1y7OF+J4+zsiPYZ40l6DEWI
         MP4WGnDsBLvWVVeCDeroWuX6z/psi0UIjh89H4gCG1BF88nvCymkaC3gpGPFqccW/Vpi
         yqhQ==
X-Gm-Message-State: ANoB5pm5pNb4PoQRSE/Ww294CrF6WbSnnqTjsSYTQ4Uvye8DllaIhWuG
        phlIEKPUYE7SpWxKbvqblYqz1cwfVOo=
X-Google-Smtp-Source: AA0mqf7B6mgUqxDLQ3i89LPKmIpCGPzYFo4QfxqabC4YmJpdYxUAVEO/jE0NsIR7MXoyw3EdaxVTTeKRQcw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:1b21:b0:218:e3e8:c024 with SMTP id
 q30-20020a17090a1b2100b00218e3e8c024mr75063pjq.125.1670890637231; Mon, 12 Dec
 2022 16:17:17 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Dec 2022 00:16:51 +0000
In-Reply-To: <20221213001653.3852042-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221213001653.3852042-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213001653.3852042-13-seanjc@google.com>
Subject: [PATCH 12/14] KVM: selftests: Use wildcards to find library source files
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ricardo Koller <ricarkol@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>
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

Use $(wildcard ...) to find the library source files instead of manually
defining the inputs, which is a maintenance burden and error prone.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile | 45 ++++------------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 9cff99a1cb2e..a9930e9197da 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -19,44 +19,6 @@ else
 $(error Unknown architecture '$(ARCH)')
 endif
 
-LIBKVM += lib/assert.c
-LIBKVM += lib/elf.c
-LIBKVM += lib/guest_modes.c
-LIBKVM += lib/io.c
-LIBKVM += lib/kvm_util.c
-LIBKVM += lib/memstress.c
-LIBKVM += lib/rbtree.c
-LIBKVM += lib/sparsebit.c
-LIBKVM += lib/test_util.c
-LIBKVM += lib/ucall_common.c
-LIBKVM += lib/userfaultfd_util.c
-
-LIBKVM_STRING += lib/string_override.c
-
-LIBKVM_x86_64 += lib/x86_64/apic.c
-LIBKVM_x86_64 += lib/x86_64/handlers.S
-LIBKVM_x86_64 += lib/x86_64/hyperv.c
-LIBKVM_x86_64 += lib/x86_64/memstress.c
-LIBKVM_x86_64 += lib/x86_64/processor.c
-LIBKVM_x86_64 += lib/x86_64/svm.c
-LIBKVM_x86_64 += lib/x86_64/ucall.c
-LIBKVM_x86_64 += lib/x86_64/vmx.c
-
-LIBKVM_aarch64 += lib/aarch64/gic.c
-LIBKVM_aarch64 += lib/aarch64/gic_v3.c
-LIBKVM_aarch64 += lib/aarch64/handlers.S
-LIBKVM_aarch64 += lib/aarch64/processor.c
-LIBKVM_aarch64 += lib/aarch64/spinlock.c
-LIBKVM_aarch64 += lib/aarch64/ucall.c
-LIBKVM_aarch64 += lib/aarch64/vgic.c
-
-LIBKVM_s390x += lib/s390x/diag318_test_handler.c
-LIBKVM_s390x += lib/s390x/processor.c
-LIBKVM_s390x += lib/s390x/ucall.c
-
-LIBKVM_riscv += lib/riscv/processor.c
-LIBKVM_riscv += lib/riscv/ucall.c
-
 # Non-compiled test targets
 TEST_PROGS_x86_64 += x86_64/nx_huge_pages_test.sh
 
@@ -213,10 +175,13 @@ pgste-option = $(call try-run, echo 'int main(void) { return 0; }' | \
 LDLIBS += -ldl
 LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
 
-LIBKVM_C := $(filter %.c,$(LIBKVM))
-LIBKVM_S := $(filter %.S,$(LIBKVM))
+LIBKVM_C := $(filter-out lib/string_override.c,$(wildcard lib/*.c))
+LIBKVM_C += $(wildcard lib/$(ARCH_DIR)/*.c)
+LIBKVM_S := $(wildcard lib/*.S)
+LIBKVM_S += $(wildcard lib/$(ARCH_DIR)/*.S)
 LIBKVM_C_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
 LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
+LIBKVM_STRING := lib/string_override.c
 LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
 LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
 
-- 
2.39.0.rc1.256.g54fd8350bd-goog

