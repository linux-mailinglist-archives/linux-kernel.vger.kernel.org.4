Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974A264AC2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiLMARZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbiLMARH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:17:07 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1491B1DF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:17:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e15-20020a5b0ccf000000b006ed1704b40cso14745954ybr.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=M8gKXPtvSnujkFWzKh+1TE/D8A+unHwbuyURFcPqV7g=;
        b=oikR4k/YvNkMbE/UC5Bzf96qpIJXJtiLGFf80pbar3MbSe9xkR02tPegsy1MzPNRR1
         P/fMWRdmCHGRG+4PJC/RAb6f/NEYb7PQ365rsPpPKl8pDpDF9JnKgjnxoUL5hnPz5Xb6
         yoMSKg+Y0gISjOVsP4kt5i2sv2hP5zRNYjcFA15TS+vJvIu+ap5a/9+DImee/7HjS/Yb
         gs0wlNl86pWuU4fl75bzelkmpLN94j1fUy2W233vaON/4saTKkmge9ChxVbDRExK9IYF
         j5TnBzD4rBnxTOTGDNEtCTlBtPdi3Ztq5EGDj1efhIP6Gb2LPLoX+8LsYHJWr3TQSoEI
         LNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M8gKXPtvSnujkFWzKh+1TE/D8A+unHwbuyURFcPqV7g=;
        b=rBzIJbtXCvmq8mo0lFPHxvR5DQZErRcscSmdvMm8iuG7tORaLGZv+ScICbXkEFXqqa
         H2D4pVQjMfZ0DDTlMNXgZb6bOOEmkDJ4dypER2vbKxlZcM+r2L0LV7NXhVR+CByRM1Q/
         NnNZfKwzg1+GAMFWCovejrFymj9Nj/HARY3Shsmct/j2CWkqDZWcPFgiVNSnHA/2iL+y
         /rSovw4H/ACQagfqIfE94wChQiz95Pprxn8HWhFku15adeikf/4hhFKX0oh5q5qNo9lj
         o9ym85l5EEzdcCowmejzpk8KWYlKVUY6gC5xcBLqhIjbKhi3XMw8pmKCZcrb2rQfREZP
         mQpw==
X-Gm-Message-State: ANoB5pkJwU5aoaQe7jTflFQVkcRil3GP+2EaxJFXgfNKw5hOx1iov67R
        Pf1JS+Hk6kk49To1BoIOhjW5zowcK5s=
X-Google-Smtp-Source: AA0mqf7Q9qI1wDH/dcWjWFM94U57KTqb7jtGhaAh76MhvnBCcz2/FuDXsNQTZH108HtSEVOKNLQckow7PUc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:50cd:0:b0:707:18f:7226 with SMTP id
 e196-20020a2550cd000000b00707018f7226mr10335955ybb.505.1670890625378; Mon, 12
 Dec 2022 16:17:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Dec 2022 00:16:44 +0000
In-Reply-To: <20221213001653.3852042-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221213001653.3852042-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213001653.3852042-6-seanjc@google.com>
Subject: [PATCH 05/14] KVM: selftests: Fix a typo in x86-64's kvm_get_cpu_address_width()
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

Fix a == vs. = typo in kvm_get_cpu_address_width() that results in
@pa_bits being left unset if the CPU doesn't support enumerating its
MAX_PHY_ADDR.  Flagged by clang's unusued-value warning.

lib/x86_64/processor.c:1034:51: warning: expression result unused [-Wunused-value]
                *pa_bits == kvm_cpu_has(X86_FEATURE_PAE) ? 36 : 32;

Fixes: 3bd396353d18 ("KVM: selftests: Add X86_FEATURE_PAE and use it calc "fallback" MAXPHYADDR")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index c4d368d56cfe..acfa1d01e7df 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1031,7 +1031,7 @@ bool is_amd_cpu(void)
 void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 {
 	if (!kvm_cpu_has_p(X86_PROPERTY_MAX_PHY_ADDR)) {
-		*pa_bits == kvm_cpu_has(X86_FEATURE_PAE) ? 36 : 32;
+		*pa_bits = kvm_cpu_has(X86_FEATURE_PAE) ? 36 : 32;
 		*va_bits = 32;
 	} else {
 		*pa_bits = kvm_cpu_property(X86_PROPERTY_MAX_PHY_ADDR);
-- 
2.39.0.rc1.256.g54fd8350bd-goog

