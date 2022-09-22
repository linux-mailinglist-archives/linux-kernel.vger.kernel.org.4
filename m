Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDA45E5ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiIVFc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIVFc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:32:56 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3EDB0B1F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:32:55 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d24so7771564pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=eaz6ZZzobVs4ZGOrwYHQM/Kk9ITDhPdxEg8Bt1PkbOo=;
        b=gp1syXD960EDwksWcE/cXsJC6FBR/7T41asUdURa6KbF0WHbYvX/7JgyZkJnR31xSW
         R2QN4ser1APqmuvLWX5c8pdcbH/HbZE40zup5CLKwRM9kbiBNW5PyqcUthnYUF2uQzro
         3+082TC7dgU7d9QVdJdjgUL9PoeIRL0iJy1x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eaz6ZZzobVs4ZGOrwYHQM/Kk9ITDhPdxEg8Bt1PkbOo=;
        b=WEEuZpVOkKG8Tp10QfYcrE1/141uGNnRJJWUdj49X62v8M+nCfYtxS86pbotAUhca2
         /x1ptU7i79vFVox/u1t1/ppC4SNd87mo3KUkSAmccrHHUeoonCS5qXGAbqgJF74JAsf7
         z5/JqWVupl1b4iKtWo+iaOSmyYSEPC4jFyYmfNbcEhBMzvECoTDJDuLUqri1xRT79noW
         HFC2v+0HAHrBPcnmZ42D5feJG1ocjdi5d9kfN7cGQaxzHHuFhazBwE5aEb63CrUA4SKO
         krwkg+U+jtKuDu10RhPDu144ZRsddadHk/UAC2A0DCdYVSF/7JaCpco1537/Xq8Ul8l+
         F2Fw==
X-Gm-Message-State: ACrzQf29wL2LFPFmej+kW/YOIvUnekQVluP56rmV0BV7UZo3djy993Ml
        HTRazrDHK9f1rCjptQFl+6aLlg==
X-Google-Smtp-Source: AMsMyM7HqZ7Z3byol1GnlGc5Fi7MDzpmzIZjyH6g+1U93zDQm5u+l5l7g/ZrmPjsCSBhDGWebRc+FQ==
X-Received: by 2002:a17:903:41cb:b0:178:36c2:a98 with SMTP id u11-20020a17090341cb00b0017836c20a98mr1553573ple.47.1663824774600;
        Wed, 21 Sep 2022 22:32:54 -0700 (PDT)
Received: from localhost ([2620:15c:2ce:200:5e9f:5b94:af12:8e6d])
        by smtp.gmail.com with UTF8SMTPSA id m1-20020a170902bb8100b0016d5b7fb02esm2984746pls.60.2022.09.21.22.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 22:32:54 -0700 (PDT)
From:   Denis Nikitin <denik@chromium.org>
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Denis Nikitin <denik@chromium.org>
Subject: [PATCH v2] KVM: arm64: nvhe: Fix build with profile optimization
Date:   Wed, 21 Sep 2022 22:31:45 -0700
Message-Id: <20220922053145.944786-1-denik@chromium.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220920082005.2459826-1-denik@chromium.org>
References: <20220920082005.2459826-1-denik@chromium.org>
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

Kernel build with clang and KCFLAGS=-fprofile-sample-use fails with:

error: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.tmp.o: Unexpected SHT_REL
section ".rel.llvm.call-graph-profile"

Starting from 13.0.0 llvm can generate SHT_REL section, see
https://reviews.llvm.org/rGca3bdb57fa1ac98b711a735de048c12b5fdd8086.
gen-hyprel does not support SHT_REL relocation section.

Remove ".llvm.call-graph-profile" SHT_REL relocation from kvm_nvhe
to fix the build.

Signed-off-by: Denis Nikitin <denik@chromium.org>
---
V1 -> V2: Remove the relocation instead of disabling the profile-use flags.
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index b5c5119c7396..49ec950ac57b 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -78,8 +78,10 @@ $(obj)/kvm_nvhe.o: $(obj)/kvm_nvhe.rel.o FORCE
 
 # The HYPREL command calls `gen-hyprel` to generate an assembly file with
 # a list of relocations targeting hyp code/data.
+# Starting from 13.0.0 llvm emits SHT_REL section '.llvm.call-graph-profile'
+# when profile optimization is applied. gen-hyprel does not support SHT_REL.
 quiet_cmd_hyprel = HYPREL  $@
-      cmd_hyprel = $(obj)/gen-hyprel $< > $@
+	cmd_hyprel = $(OBJCOPY) -R .llvm.call-graph-profile $<; $(obj)/gen-hyprel $< > $@
 
 # The HYPCOPY command uses `objcopy` to prefix all ELF symbol names
 # to avoid clashes with VHE code/data.
-- 
2.37.3.968.ga6b4b080e4-goog

