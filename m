Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5308B5EEA34
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiI1XhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiI1XhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:37:03 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78464F0881
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:37:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3524fac9dbcso51936677b3.14
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=YpSTzPP9K7OiRFT94U/UGwaYXo+HEY2arnI/B5+NJt8=;
        b=KaIbArM+NMp2EAHVIV0WhqJ8Tr0bZijrlBhWPsnD+lNQDoe8k4jCtWIafa/dyHrQNS
         hvqbu98jHHp+ZTG7bJnKBXYrUl1jN4p36XiZF6bA0oyTt+vdupMd2ahGzf2RCSDhnMxS
         +6ItYkPDOLQimpYiFsHJHsfZ4pC/jLDqnUyppFQn6s2DQD09UMdsrkwNZsN44kQ0+mRL
         0AI9H62oDTEhlnnYoK/aKarTxCJJbQkd2+ARObmWuw4voMQOuCw/kMWA4jJWum/IxdIj
         WbZopnAQCFtHZQuve4TVXQH3RQDnAS1/lwY4LjHzOGpvWyrSBWECTxIBppJ9xb5dUSGp
         fvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=YpSTzPP9K7OiRFT94U/UGwaYXo+HEY2arnI/B5+NJt8=;
        b=a9uFZtmkBAstmGmGWCyFsXlTP/1sIgeMTs1h7LoGV7St4cku3wh2mRLsHe0GX2Zrhj
         KbDk6JKMx1RVzJEA3m7N99TpS4M2D3+C3NMGXhrvj6NSuSzgABoyM/M8ioDOzSyTq+vC
         Vsnu6TRyZZKKQTe2nJsVQ8RgI4gkX2GITpog/gzXhum8FFyww0Qg00UlNzJsoAcb5yUX
         im1Yn8dABwsornbeRNCUv4IpzpIz0l8ku7bz/K/K+f5FFsILUKYIWyi1T96SXvS9Gu62
         S/5Np3AlExV3fqCpj7QH1tSXxSNubT/0nEyWdp9uknXWMLpmm7RU8+kwMw2rwL9sY7Dv
         FHcA==
X-Gm-Message-State: ACrzQf1jp3Cc5pI37/xFhk+wJgyvN8y4y2QsZBdAkb8DUos1nzEb94v8
        Rmf2qhIbryNMNRHwCZ5cqbufqyDfCC8=
X-Google-Smtp-Source: AMsMyM58F+KRL1GwkA3NWkr10geBrYEg9OPOQBgBASaf967GziXuMTLUR4nDnRcBVCoOwaQdUj65e33uDZI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:5945:0:b0:352:c163:d248 with SMTP id
 n66-20020a815945000000b00352c163d248mr420756ywb.399.1664408220622; Wed, 28
 Sep 2022 16:37:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 28 Sep 2022 23:36:49 +0000
In-Reply-To: <20220928233652.783504-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220928233652.783504-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220928233652.783504-5-seanjc@google.com>
Subject: [PATCH v2 4/7] KVM: selftests: Hardcode VMCALL/VMMCALL opcodes in
 "fix hypercall" test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Jones <andrew.jones@linux.dev>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Jim Mattson <jmattson@google.com>
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

Hardcode the VMCALL/VMMCALL opcodes in dedicated arrays instead of
extracting the opcodes from inline asm, and patch in the "other" opcode
so as to preserve the original opcode, i.e. the opcode that the test
executes in the guest.

Preserving the original opcode (by not patching the source), will make
it easier to implement a check that KVM doesn't modify the opcode (the
test currently only verifies that a #UD occurred).

Use INT3 (0xcc) as the placeholder so that the guest will likely die a
horrible death if the test's patching goes awry.

As a bonus, patching from within the test dedups a decent chunk of code.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/fix_hypercall_test.c | 43 +++++++------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
index 6864eb0d5d14..cebc84b26352 100644
--- a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
@@ -25,27 +25,16 @@ static void guest_ud_handler(struct ex_regs *regs)
 	GUEST_DONE();
 }
 
-extern uint8_t svm_hypercall_insn[HYPERCALL_INSN_SIZE];
-static uint64_t svm_do_sched_yield(uint8_t apic_id)
-{
-	uint64_t ret;
-
-	asm volatile("svm_hypercall_insn:\n\t"
-		     "vmmcall\n\t"
-		     : "=a"(ret)
-		     : "a"((uint64_t)KVM_HC_SCHED_YIELD), "b"((uint64_t)apic_id)
-		     : "memory");
-
-	return ret;
-}
+static const uint8_t vmx_vmcall[HYPERCALL_INSN_SIZE]  = { 0x0f, 0x01, 0xc1 };
+static const uint8_t svm_vmmcall[HYPERCALL_INSN_SIZE] = { 0x0f, 0x01, 0xd9 };
 
-extern uint8_t vmx_hypercall_insn[HYPERCALL_INSN_SIZE];
-static uint64_t vmx_do_sched_yield(uint8_t apic_id)
+extern uint8_t hypercall_insn[HYPERCALL_INSN_SIZE];
+static uint64_t do_sched_yield(uint8_t apic_id)
 {
 	uint64_t ret;
 
-	asm volatile("vmx_hypercall_insn:\n\t"
-		     "vmcall\n\t"
+	asm volatile("hypercall_insn:\n\t"
+		     ".byte 0xcc,0xcc,0xcc\n\t"
 		     : "=a"(ret)
 		     : "a"((uint64_t)KVM_HC_SCHED_YIELD), "b"((uint64_t)apic_id)
 		     : "memory");
@@ -55,25 +44,25 @@ static uint64_t vmx_do_sched_yield(uint8_t apic_id)
 
 static void guest_main(void)
 {
-	uint8_t *native_hypercall_insn, *hypercall_insn;
-	uint8_t apic_id;
-
-	apic_id = GET_APIC_ID_FIELD(xapic_read_reg(APIC_ID));
+	const uint8_t *native_hypercall_insn;
+	const uint8_t *other_hypercall_insn;
 
 	if (is_intel_cpu()) {
-		native_hypercall_insn = vmx_hypercall_insn;
-		hypercall_insn = svm_hypercall_insn;
-		svm_do_sched_yield(apic_id);
+		native_hypercall_insn = vmx_vmcall;
+		other_hypercall_insn  = svm_vmmcall;
 	} else if (is_amd_cpu()) {
-		native_hypercall_insn = svm_hypercall_insn;
-		hypercall_insn = vmx_hypercall_insn;
-		vmx_do_sched_yield(apic_id);
+		native_hypercall_insn = svm_vmmcall;
+		other_hypercall_insn  = vmx_vmcall;
 	} else {
 		GUEST_ASSERT(0);
 		/* unreachable */
 		return;
 	}
 
+	memcpy(hypercall_insn, other_hypercall_insn, HYPERCALL_INSN_SIZE);
+
+	do_sched_yield(GET_APIC_ID_FIELD(xapic_read_reg(APIC_ID)));
+
 	/*
 	 * The hypercall didn't #UD (guest_ud_handler() signals "done" if a #UD
 	 * occurs).  Verify that a #UD is NOT expected and that KVM patched in
-- 
2.37.3.998.g577e59143f-goog

