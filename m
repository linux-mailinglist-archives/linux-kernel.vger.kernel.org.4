Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6874564AC29
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiLMARr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbiLMARX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:17:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BFC1C919
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:17:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n197-20020a25d6ce000000b00702558fba96so14793145ybg.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cl2hz2Xl0INQZgi0/FdsZaZQh2aAYVKtm1GOrQ0BNuA=;
        b=qtuKL0chntBw8WmvJab1K7kXx56vDxcM9Lz3Ed1k66okiPfskMIfRbRPhkpYl+zGcP
         mkp5v4Xa7xKSkNVTIU5I70auAIKnC0QeyzQFPgSFF7WWS+tDOctc4tDRG/YuUfhAOX4B
         t8ijgFRQsDMni3C+Sb2bEyRHhRoH07jF7n9YtSS4rtkdGTPQ9kigYoTmO1aL/fn/jywD
         tNkEscjQPz0T4cqIQReHVuDH+sIuUu9AxFpVApk///ScvT5q9609eMJOQx/F3P0B5FVO
         7yKU4XPqBRk3J8E/xxsYrzOoSaTZobfNQITHw9pavl02O+kx8NUkPc5JhtHd2UP0Zuz7
         2pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cl2hz2Xl0INQZgi0/FdsZaZQh2aAYVKtm1GOrQ0BNuA=;
        b=aCOE4PWmqnSE/0ku1mh1StjZVhu4xDbX/dEDUdYoIVS6sYw+OKZghodscGpCTa0WY2
         eQVJHVrjGSpSZkYtxk2DaPjtWQ8/FmutaYlZD4YFMoYElFNQedA1RbQ6tti/9w7KULOk
         VB8M22czmAGeoSw94I0uJOlqku0sySpvdKsNkAebOpAMJqamiZE42D0xPRPqLSuPCQHU
         yw+Ge6XkHcbzGm9cbRyGijlvSwDqQAo1PbEXV7Ea6M898OkUBPkuSHz8KoiXVspmkg4V
         uWqu8UApdfXMOpEPOH4HLeXSF6THGjKIL8HXeZ//GFJzKqE6CJYwCVqXLLFlGZ2TVJRW
         a0Jw==
X-Gm-Message-State: ANoB5pm4NqoE2k9wKxrAh/qtjStb8jSu5K++R17z2tcy6Pf6kAcN+wWi
        qmroq9KrUsNWWy1DxqHYN12a8VOu3FI=
X-Google-Smtp-Source: AA0mqf5PAbtMk1FlbJUnxb446gjQZtpZQwbl0k154cV60HQy1+WGqGPPTBe02uIxBcfNlX5eyXkFbuPBOrQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:3303:0:b0:6f0:be3f:26f0 with SMTP id
 z3-20020a253303000000b006f0be3f26f0mr67005598ybz.512.1670890632080; Mon, 12
 Dec 2022 16:17:12 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Dec 2022 00:16:48 +0000
In-Reply-To: <20221213001653.3852042-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221213001653.3852042-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213001653.3852042-10-seanjc@google.com>
Subject: [PATCH 09/14] KVM: selftests: Explicitly disable builtins for mem*() overrides
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

Explicitly disable the compiler's builtin memcmp(), memcpy(), and
memset().  Because only lib/string_override.c is built with -ffreestanding,
the compiler reserves the right to do what it wants and can try to link the
non-freestanding code to its own crud.

  /usr/bin/x86_64-linux-gnu-ld: /lib/x86_64-linux-gnu/libc.a(memcmp.o): in function `memcmp_ifunc':
  (.text+0x0): multiple definition of `memcmp'; tools/testing/selftests/kvm/lib/string_override.o:
  tools/testing/selftests/kvm/lib/string_override.c:15: first defined here
  clang: error: linker command failed with exit code 1 (use -v to see invocation)

Fixes: 6b6f71484bf4 ("KVM: selftests: Implement memcmp(), memcpy(), and memset() for guest use")
Reported-by: Aaron Lewis <aaronlewis@google.com>
Reported-by: Raghavendra Rao Ananta <rananta@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index a6050dcc381a..6594ed51eeea 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -191,6 +191,7 @@ else
 LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
+	-fno-builtin-memcmp -fno-builtin-memcpy -fno-builtin-memset \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
 	-I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. $(EXTRA_CFLAGS) \
-- 
2.39.0.rc1.256.g54fd8350bd-goog

