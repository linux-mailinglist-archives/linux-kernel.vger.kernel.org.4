Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB03E64AC30
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiLMARa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiLMARI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:17:08 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D581CB07
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:17:07 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id z4-20020a17090ab10400b002195a146546so1012871pjq.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=aL+0YmMhUjGpxjB47w5qgiiQkK7wv4sJmU0mewoCPIk=;
        b=lXE9d6/lTyMaKAp9TWJ0VTH9OHNc6LWhK3blKtxoKuILCiWADb0CbU6Rsydob/gcil
         wHxIvfaDWuGlNvVquRWIv4yx5W+yznz7XM7a86CW8GDjqkZqbRCaIw2dz/EezUpsk1tU
         yj25I60njVb9EbdEvsJxtZS9+k7pDY33PzcH/LvsH4P5XlXsQXH7IoqjcG6Ie7dJ8g9T
         bujmb8hmgj/76jRObLTv9oiy9I32bf42pKVaFt8Dttopr1DOXN3wMxL93QijMNc8Zro1
         fKhDmxLqJgYkJDp2BLZwakAToojNx+YfT0/EJedWbNtVv2az4c/koY91ZlwuaKe+3P20
         zbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aL+0YmMhUjGpxjB47w5qgiiQkK7wv4sJmU0mewoCPIk=;
        b=H+BlSwYH2AJ80MWxahOYqzOB1UIHhb7tw5bhgwrYuG2ytawpXOVuPy31V6w9Qgebg6
         Ik7Ksc1itBSi65SJU0GADCMgMtep8TzcHqoLAAzPeBWmKby812xtL/YHSDze9xZZ5gh5
         PdJBTHTH13noZh+qL7DVqcWlY+6c6KYXwtnu0G7XfL0NHVByI/K0RbECxzlI9Jvd8Lxb
         amxZ13cztBsIA0vypSPvDAQ/1wK+MOzqjLnCSsI943HTfVV7MKhtphKbHElR/S1dBpoq
         ypKUvZ36BoCcG01r4xX4b60Om1Kp49xBg+vZ6KnG0OJv7Bcz+qJ789ApM7k8VgbD5Bfe
         IKzg==
X-Gm-Message-State: ANoB5pkou+KNiywOVHu4xg0Nezg8TAPW61i+Pt5TT0ZBibtKXBTJAvqe
        i5Zp5DntwNrxIcqlPnjtzDjgDQOXZA8=
X-Google-Smtp-Source: AA0mqf6x4MZJ4SJmtkdTS02X8t4NKcxtNfIcDJg0D7JOLNgsuOwcq0N0mfjb/DHFRBiMDDUKbvP/3oiNhVU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3556:b0:219:f1a2:b641 with SMTP id
 lt22-20020a17090b355600b00219f1a2b641mr97398pjb.97.1670890626870; Mon, 12 Dec
 2022 16:17:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Dec 2022 00:16:45 +0000
In-Reply-To: <20221213001653.3852042-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221213001653.3852042-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213001653.3852042-7-seanjc@google.com>
Subject: [PATCH 06/14] KVM: selftests: Rename UNAME_M to ARCH_DIR, fill
 explicitly for x86
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename UNAME_M to ARCH_DIR and explicitly set it directly for x86.  At
this point, the name of the arch directory really doesn't have anything
to do with `uname -m`, and UNAME_M is unnecessarily confusing given that
its purpose is purely to identify the arch specific directory.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile | 49 +++++++++-------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 947676983da1..d761a77c3a80 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -7,35 +7,16 @@ top_srcdir = ../../../..
 include $(top_srcdir)/scripts/subarch.include
 ARCH            ?= $(SUBARCH)
 
-# For cross-builds to work, UNAME_M has to map to ARCH and arch specific
-# directories and targets in this Makefile. "uname -m" doesn't map to
-# arch specific sub-directory names.
-#
-# UNAME_M variable to used to run the compiles pointing to the right arch
-# directories and build the right targets for these supported architectures.
-#
-# TEST_GEN_PROGS and LIBKVM are set using UNAME_M variable.
-# LINUX_TOOL_ARCH_INCLUDE is set using ARCH variable.
-#
-# x86_64 targets are named to include x86_64 as a suffix and directories
-# for includes are in x86_64 sub-directory. s390x and aarch64 follow the
-# same convention. "uname -m" doesn't result in the correct mapping for
-# s390x and aarch64.
-#
-# No change necessary for x86_64
-UNAME_M := $(shell uname -m)
-
-# Set UNAME_M for arm64 compile/install to work
-ifeq ($(ARCH),arm64)
-	UNAME_M := aarch64
-endif
-# Set UNAME_M s390x compile/install to work
-ifeq ($(ARCH),s390)
-	UNAME_M := s390x
-endif
-# Set UNAME_M riscv compile/install to work
-ifeq ($(ARCH),riscv)
-	UNAME_M := riscv
+ifeq ($(ARCH),x86)
+	ARCH_DIR := x86_64
+else ifeq ($(ARCH),arm64)
+	ARCH_DIR := aarch64
+else ifeq ($(ARCH),s390)
+	ARCH_DIR := s390x
+else ifeq ($(ARCH),riscv)
+	ARCH_DIR := riscv
+else
+$(error Unknown architecture '$(ARCH)')
 endif
 
 LIBKVM += lib/assert.c
@@ -196,10 +177,10 @@ TEST_GEN_PROGS_riscv += kvm_page_table_test
 TEST_GEN_PROGS_riscv += set_memory_region_test
 TEST_GEN_PROGS_riscv += kvm_binary_stats_test
 
-TEST_PROGS += $(TEST_PROGS_$(UNAME_M))
-TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
-TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(UNAME_M))
-LIBKVM += $(LIBKVM_$(UNAME_M))
+TEST_PROGS += $(TEST_PROGS_$(ARCH_DIR))
+TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH_DIR))
+TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(ARCH_DIR))
+LIBKVM += $(LIBKVM_$(ARCH_DIR))
 
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
@@ -212,7 +193,7 @@ endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
-	-I$(<D) -Iinclude/$(UNAME_M) -I ../rseq -I.. $(EXTRA_CFLAGS) \
+	-I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. $(EXTRA_CFLAGS) \
 	$(KHDR_INCLUDES)
 
 no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
-- 
2.39.0.rc1.256.g54fd8350bd-goog

