Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717AC6E7333
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjDSG1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjDSG1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:27:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ED993C7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681885558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bqr63rdBNJW6MJxcSz6TUxSygJeiGgSztBtqTvNWdFg=;
        b=S7uG2kPa8CfmGclxm5ulKqNBskILe2cpxElfd1353UaUuELutyDFqIB+dvjJ9VOuOeEE78
        BiQraveZPz16RSWFAx2o+vMUwvi7m6AAH0s6p+ABlhgnW9OexARX0EtTjvt3yZFtoi59AF
        zVneSdXjx8dEvQ7ICwd8iVOzth0bQAI=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-t2gZM8hkNdedVffY5wcs9Q-1; Wed, 19 Apr 2023 02:25:57 -0400
X-MC-Unique: t2gZM8hkNdedVffY5wcs9Q-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-18486cd43d7so8761496fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681885556; x=1684477556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqr63rdBNJW6MJxcSz6TUxSygJeiGgSztBtqTvNWdFg=;
        b=AkHJlE5gevKwlG10YCZ1/R1FkBn6F0fCFshf9C5Z3+kUxzpJP60/NRbMpZuL+Bu9Wm
         lrZwXaxfCewe/cqZ2+1wYTuQc9Js8Kt4ql5lDTQd0hS3hhZwWgPYZrk18qSWo9gxjCXE
         TEcw3QnDc/G1xr2nC3ppfFz0GfY/lmr0qP0oSrFQ54nQkEWWcpf/Q756WcUrq+np6+ro
         TlkrYmF+CdEXtHP1T4uzR7ZYq7FFB0e9nKM7wNY6zsaBmXaOj5II4ZFDeJ1ZQ0PmbYNm
         jUSoctVMQntqiE7V2D7xazAk4iudYJwMXBQkvV17dSnTlbDrm6EI6NXoj3v0gTedpm2P
         Vgmg==
X-Gm-Message-State: AAQBX9cDZK/nMo7JZO5W/ETi6U5lKEWSzBq4N7ih/pIgLjIXydbHeIYH
        YT32BwV/MlK+cGsjt+NbPndIUD8sR4k8Smmoyv0ChxdUSznPQd/hfBonsT8MKCXSGuG2PKiBYhz
        bgmJgH2vbszkr8fSRxuDqi76i
X-Received: by 2002:a9d:66c2:0:b0:684:ac9d:1a17 with SMTP id t2-20020a9d66c2000000b00684ac9d1a17mr780828otm.3.1681885556474;
        Tue, 18 Apr 2023 23:25:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350bKqCcNO2hix2PAQ0Js4/U/l3iu/UbIueif/kSkvexkCNyDPR3W7BSse6fcLfLJEK8fENU1ZQ==
X-Received: by 2002:a9d:66c2:0:b0:684:ac9d:1a17 with SMTP id t2-20020a9d66c2000000b00684ac9d1a17mr780819otm.3.1681885556236;
        Tue, 18 Apr 2023 23:25:56 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a802:873a:dbfb:e929:5eb5:6a2c])
        by smtp.gmail.com with ESMTPSA id y20-20020a056830209400b006a305c68617sm6304916otq.53.2023.04.18.23.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 23:25:55 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [RFC PATCH 1/1] riscv/atomic.h: Deduplicate arch_atomic.*
Date:   Wed, 19 Apr 2023 03:25:06 -0300
Message-Id: <20230419062505.257231-1-leobras@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions use mostly the same asm for 32-bit and 64-bit versions.

Make a macro that is generic enough and avoid code duplication.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/atomic.h | 164 +++++++++++++++-----------------
 1 file changed, 76 insertions(+), 88 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 0dfe9d857a762..85eb2edbc8219 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -196,22 +196,28 @@ ATOMIC_OPS(xor, xor, i)
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 
+#define _arch_atomic_fetch_add_unless(_prev, _rc, counter, _a, _u, sfx)	\
+({									\
+	__asm__ __volatile__ (						\
+		"0:	lr." sfx "     %[p],  %[c]\n"			\
+		"	beq	       %[p],  %[u], 1f\n"		\
+		"	add            %[rc], %[p], %[a]\n"		\
+		"	sc." sfx ".rl  %[rc], %[rc], %[c]\n"		\
+		"	bnez           %[rc], 0b\n"			\
+		"	fence          rw, rw\n"			\
+		"1:\n"							\
+		: [p]"=&r" (_prev), [rc]"=&r" (_rc), [c]"+A" (counter)	\
+		: [a]"r" (_a), [u]"r" (_u)				\
+		: "memory");						\
+})
+
 /* This is required to provide a full barrier on success. */
 static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
        int prev, rc;
 
-	__asm__ __volatile__ (
-		"0:	lr.w     %[p],  %[c]\n"
-		"	beq      %[p],  %[u], 1f\n"
-		"	add      %[rc], %[p], %[a]\n"
-		"	sc.w.rl  %[rc], %[rc], %[c]\n"
-		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
-		"1:\n"
-		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		: [a]"r" (a), [u]"r" (u)
-		: "memory");
+	_arch_atomic_fetch_add_unless(prev, rc, v->counter, a, u, "w");
+
 	return prev;
 }
 #define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
@@ -222,17 +228,8 @@ static __always_inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a,
        s64 prev;
        long rc;
 
-	__asm__ __volatile__ (
-		"0:	lr.d     %[p],  %[c]\n"
-		"	beq      %[p],  %[u], 1f\n"
-		"	add      %[rc], %[p], %[a]\n"
-		"	sc.d.rl  %[rc], %[rc], %[c]\n"
-		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
-		"1:\n"
-		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		: [a]"r" (a), [u]"r" (u)
-		: "memory");
+	_arch_atomic_fetch_add_unless(prev, rc, v->counter, a, u, "d");
+
 	return prev;
 }
 #define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
@@ -310,61 +307,79 @@ ATOMIC_OPS()
 #undef ATOMIC_OPS
 #undef ATOMIC_OP
 
+#define _arch_atomic_inc_unless_negative(_prev, _rc, counter, sfx)	\
+({									\
+	__asm__ __volatile__ (						\
+		"0:	lr." sfx "      %[p],  %[c]\n"			\
+		"	bltz            %[p],  1f\n"			\
+		"	addi            %[rc], %[p], 1\n"		\
+		"	sc." sfx ".rl   %[rc], %[rc], %[c]\n"		\
+		"	bnez            %[rc], 0b\n"			\
+		"	fence           rw, rw\n"			\
+		"1:\n"							\
+		: [p]"=&r" (_prev), [rc]"=&r" (_rc), [c]"+A" (counter)	\
+		:							\
+		: "memory");						\
+})
+
 static __always_inline bool arch_atomic_inc_unless_negative(atomic_t *v)
 {
 	int prev, rc;
 
-	__asm__ __volatile__ (
-		"0:	lr.w      %[p],  %[c]\n"
-		"	bltz      %[p],  1f\n"
-		"	addi      %[rc], %[p], 1\n"
-		"	sc.w.rl   %[rc], %[rc], %[c]\n"
-		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
-		"1:\n"
-		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		:
-		: "memory");
+	_arch_atomic_inc_unless_negative(prev, rc, v->counter, "w");
+
 	return !(prev < 0);
 }
 
 #define arch_atomic_inc_unless_negative arch_atomic_inc_unless_negative
 
+#define _arch_atomic_dec_unless_positive(_prev, _rc, counter, sfx)	\
+({									\
+	__asm__ __volatile__ (						\
+		"0:	lr." sfx "      %[p],  %[c]\n"			\
+		"	bgtz            %[p],  1f\n"			\
+		"	addi            %[rc], %[p], -1\n"		\
+		"	sc." sfx ".rl   %[rc], %[rc], %[c]\n"		\
+		"	bnez            %[rc], 0b\n"			\
+		"	fence           rw, rw\n"			\
+		"1:\n"							\
+		: [p]"=&r" (_prev), [rc]"=&r" (_rc), [c]"+A" (counter)	\
+		:							\
+		: "memory");						\
+})
+
 static __always_inline bool arch_atomic_dec_unless_positive(atomic_t *v)
 {
 	int prev, rc;
 
-	__asm__ __volatile__ (
-		"0:	lr.w      %[p],  %[c]\n"
-		"	bgtz      %[p],  1f\n"
-		"	addi      %[rc], %[p], -1\n"
-		"	sc.w.rl   %[rc], %[rc], %[c]\n"
-		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
-		"1:\n"
-		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		:
-		: "memory");
+	_arch_atomic_dec_unless_positive(prev, rc, v->counter, "w");
+
 	return !(prev > 0);
 }
 
 #define arch_atomic_dec_unless_positive arch_atomic_dec_unless_positive
 
+#define _arch_atomic_dec_if_positive(_prev, _rc, counter, sfx)		\
+({									\
+	__asm__ __volatile__ (						\
+		"0:	lr." sfx "     %[p],  %[c]\n"			\
+		"	addi           %[rc], %[p], -1\n"		\
+		"	bltz           %[rc], 1f\n"			\
+		"	sc." sfx ".rl  %[rc], %[rc], %[c]\n"		\
+		"	bnez           %[rc], 0b\n"			\
+		"	fence          rw, rw\n"			\
+		"1:\n"							\
+		: [p]"=&r" (_prev), [rc]"=&r" (_rc), [c]"+A" (counter)	\
+		:							\
+		: "memory");						\
+})
+
 static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
 {
        int prev, rc;
 
-	__asm__ __volatile__ (
-		"0:	lr.w     %[p],  %[c]\n"
-		"	addi     %[rc], %[p], -1\n"
-		"	bltz     %[rc], 1f\n"
-		"	sc.w.rl  %[rc], %[rc], %[c]\n"
-		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
-		"1:\n"
-		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		:
-		: "memory");
+	_arch_atomic_dec_if_positive(prev, rc, v->counter, "w");
+
 	return prev - 1;
 }
 
@@ -376,17 +391,8 @@ static __always_inline bool arch_atomic64_inc_unless_negative(atomic64_t *v)
 	s64 prev;
 	long rc;
 
-	__asm__ __volatile__ (
-		"0:	lr.d      %[p],  %[c]\n"
-		"	bltz      %[p],  1f\n"
-		"	addi      %[rc], %[p], 1\n"
-		"	sc.d.rl   %[rc], %[rc], %[c]\n"
-		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
-		"1:\n"
-		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		:
-		: "memory");
+	_arch_atomic_inc_unless_negative(prev, rc, v->counter, "d");
+
 	return !(prev < 0);
 }
 
@@ -397,17 +403,8 @@ static __always_inline bool arch_atomic64_dec_unless_positive(atomic64_t *v)
 	s64 prev;
 	long rc;
 
-	__asm__ __volatile__ (
-		"0:	lr.d      %[p],  %[c]\n"
-		"	bgtz      %[p],  1f\n"
-		"	addi      %[rc], %[p], -1\n"
-		"	sc.d.rl   %[rc], %[rc], %[c]\n"
-		"	bnez      %[rc], 0b\n"
-		"	fence     rw, rw\n"
-		"1:\n"
-		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		:
-		: "memory");
+	_arch_atomic_dec_unless_positive(prev, rc, v->counter, "d");
+
 	return !(prev > 0);
 }
 
@@ -418,17 +415,8 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
        s64 prev;
        long rc;
 
-	__asm__ __volatile__ (
-		"0:	lr.d     %[p],  %[c]\n"
-		"	addi      %[rc], %[p], -1\n"
-		"	bltz     %[rc], 1f\n"
-		"	sc.d.rl  %[rc], %[rc], %[c]\n"
-		"	bnez     %[rc], 0b\n"
-		"	fence    rw, rw\n"
-		"1:\n"
-		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
-		:
-		: "memory");
+	_arch_atomic_dec_if_positive(prev, rc, v->counter, "d");
+
 	return prev - 1;
 }
 
-- 
2.40.0

