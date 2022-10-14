Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAA35FF3CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiJNSql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiJNSqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:46:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C2F1BE1EB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:46:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id h13so5706317pfr.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r9b1WxYCtQHAvJQbAPYaXXw5JIstR8dPjphyBTVotDg=;
        b=C9ChpAljNx+6EX+b7MIXOhJ/DxR1oEgil1ZdehQzrOHu0htP0Wb4hihn7cdKw7kusB
         unlXoi0fYM8ckb4UqUThqiouQ/fgrebyEJmB7iEik2j7ocpYju1X+GtQNb/e2THXGyfu
         pdn2pYHgdd7SXL+E5NiLfpnCE8W4Xn9DguZTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9b1WxYCtQHAvJQbAPYaXXw5JIstR8dPjphyBTVotDg=;
        b=GBssaesT2WjSWGuKJuJMTNo0xr4BgtefApcYonfsVv7PQcclhratnqTdgdR9PxSyES
         RL6e1PkyMOVfAPKsik/GfYv+O/TXI9W2Qr20y8Zp3aXe4V7LuGbAUxDYXrnPGM+Wh5r8
         TkIIeBqYODDlScC5zZ78uPCs7imVTuQ0CXnulxeIwTCdqvZBnPfAWAS3WemnK6EBKwAy
         fAGDQn7WuAlPA5tJABBADLBahAkRcFO7x5obe5SfF0IPUQBhFclg6zE++jIPHXaGhmq8
         4u3RGsAFjs9ljPKzHV7tNOB1WLEe2AuWppzt5nD81ACfQqknS/MjNeHSVe/zzfxaM/DI
         lfhA==
X-Gm-Message-State: ACrzQf3+qVihGuNENT/W4RJdj/6vASaChStDM1JABxi0UIUTO2yRMm8W
        NxV9PMpjrsChgDLwYunehEwObw==
X-Google-Smtp-Source: AMsMyM4KxZFUnZ3+JVUZbSV1KdBMKe5N17ONrn6zYeMpUbJ+0CiKCyk427n5W/she7eWjJeNE5SITA==
X-Received: by 2002:a05:6a00:1707:b0:562:e790:dfc3 with SMTP id h7-20020a056a00170700b00562e790dfc3mr6609803pfc.59.1665773196248;
        Fri, 14 Oct 2022 11:46:36 -0700 (PDT)
Received: from localhost ([2620:15c:2ce:200:e8c9:5029:f577:f6ca])
        by smtp.gmail.com with UTF8SMTPSA id 203-20020a6217d4000000b0053653c6b9f9sm2047145pfx.204.2022.10.14.11.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 11:46:35 -0700 (PDT)
From:   Denis Nikitin <denik@chromium.org>
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Denis Nikitin <denik@chromium.org>
Subject: [PATCH v3] KVM: arm64: nvhe: Fix build with profile optimization
Date:   Fri, 14 Oct 2022 11:45:32 -0700
Message-Id: <20221014184532.3153551-1-denik@chromium.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel build with clang and KCFLAGS=-fprofile-sample-use=<profile> fails with:

error: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.tmp.o: Unexpected SHT_REL
section ".rel.llvm.call-graph-profile"

Starting from 13.0.0 llvm can generate SHT_REL section, see
https://reviews.llvm.org/rGca3bdb57fa1ac98b711a735de048c12b5fdd8086.
gen-hyprel does not support SHT_REL relocation section.

Filter out profile use flags to fix the build with profile optimization.

Signed-off-by: Denis Nikitin <denik@chromium.org>
---
V2 -> V3: Filter out the profile-use flags.
V1 -> V2: Remove the relocation instead of disabling the profile-use flags.
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index b5c5119c7396..16c6abdda494 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -89,6 +89,10 @@ quiet_cmd_hypcopy = HYPCOPY $@
 # Remove ftrace, Shadow Call Stack, and CFI CFLAGS.
 # This is equivalent to the 'notrace', '__noscs', and '__nocfi' annotations.
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
+# Starting from 13.0.0 llvm emits SHT_REL section '.llvm.call-graph-profile'
+# when profile optimization is applied. gen-hyprel does not support SHT_REL and
+# causes a build failure. Remove profile optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%, $(KBUILD_CFLAGS))
 
 # KVM nVHE code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
-- 
2.38.0.413.g74048e4d9e-goog

