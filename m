Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9BA5C016E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiIUP2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiIUP1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:27:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE9498C9C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663773946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MJ39CAYEHz5DuZbQG0qWjQkfEh+Ru65oeAaxgqhArRM=;
        b=KWw6XEA4MuIs5dG+7LrtHGhrU4uh2hf7tmpON2PloIz6i1gACEduBxJqPK1/Q3ANvMz501
        doK/WvY9wZ1Fa+jF9V9Yl6RcZetH6Q45Q7NjrcCBTaSPAoUSNmcbwPqd6PABuDzQX9Ch1P
        yXcLdUjLqcaNG+yIoxozaccK3m/In7Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-bArzDiqrOPe1fhzNS9-RTA-1; Wed, 21 Sep 2022 11:25:41 -0400
X-MC-Unique: bArzDiqrOPe1fhzNS9-RTA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08E63185A78B;
        Wed, 21 Sep 2022 15:25:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2E142166B26;
        Wed, 21 Sep 2022 15:25:38 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 23/39] KVM: selftests: Better XMM read/write helpers
Date:   Wed, 21 Sep 2022 17:24:20 +0200
Message-Id: <20220921152436.3673454-24-vkuznets@redhat.com>
In-Reply-To: <20220921152436.3673454-1-vkuznets@redhat.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_xmm()/get_xmm() helpers are fairly useless as they only read 64 bits
from 128-bit registers. Moreover, these helpers are not used. Borrow
_kvm_read_sse_reg()/_kvm_write_sse_reg() from KVM limiting them to
XMM0-XMM8 for now.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 .../selftests/kvm/include/x86_64/processor.h  | 70 ++++++++++---------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 0cbc71b7af50..1c7805de8c27 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -436,71 +436,73 @@ static inline bool this_cpu_has(struct kvm_x86_cpu_feature feature)
 	return gprs[feature.reg] & BIT(feature.bit);
 }
 
-#define SET_XMM(__var, __xmm) \
-	asm volatile("movq %0, %%"#__xmm : : "r"(__var) : #__xmm)
+typedef u32		__attribute__((vector_size(16))) sse128_t;
+#define __sse128_u	union { sse128_t vec; u64 as_u64[2]; u32 as_u32[4]; }
+#define sse128_lo(x)	({ __sse128_u t; t.vec = x; t.as_u64[0]; })
+#define sse128_hi(x)	({ __sse128_u t; t.vec = x; t.as_u64[1]; })
 
-static inline void set_xmm(int n, unsigned long val)
+static inline void read_sse_reg(int reg, sse128_t *data)
 {
-	switch (n) {
+	switch (reg) {
 	case 0:
-		SET_XMM(val, xmm0);
+		asm("movdqa %%xmm0, %0" : "=m"(*data));
 		break;
 	case 1:
-		SET_XMM(val, xmm1);
+		asm("movdqa %%xmm1, %0" : "=m"(*data));
 		break;
 	case 2:
-		SET_XMM(val, xmm2);
+		asm("movdqa %%xmm2, %0" : "=m"(*data));
 		break;
 	case 3:
-		SET_XMM(val, xmm3);
+		asm("movdqa %%xmm3, %0" : "=m"(*data));
 		break;
 	case 4:
-		SET_XMM(val, xmm4);
+		asm("movdqa %%xmm4, %0" : "=m"(*data));
 		break;
 	case 5:
-		SET_XMM(val, xmm5);
+		asm("movdqa %%xmm5, %0" : "=m"(*data));
 		break;
 	case 6:
-		SET_XMM(val, xmm6);
+		asm("movdqa %%xmm6, %0" : "=m"(*data));
 		break;
 	case 7:
-		SET_XMM(val, xmm7);
+		asm("movdqa %%xmm7, %0" : "=m"(*data));
 		break;
+	default:
+		BUG();
 	}
 }
 
-#define GET_XMM(__xmm)							\
-({									\
-	unsigned long __val;						\
-	asm volatile("movq %%"#__xmm", %0" : "=r"(__val));		\
-	__val;								\
-})
-
-static inline unsigned long get_xmm(int n)
+static inline void write_sse_reg(int reg, const sse128_t *data)
 {
-	assert(n >= 0 && n <= 7);
-
-	switch (n) {
+	switch (reg) {
 	case 0:
-		return GET_XMM(xmm0);
+		asm("movdqa %0, %%xmm0" : : "m"(*data));
+		break;
 	case 1:
-		return GET_XMM(xmm1);
+		asm("movdqa %0, %%xmm1" : : "m"(*data));
+		break;
 	case 2:
-		return GET_XMM(xmm2);
+		asm("movdqa %0, %%xmm2" : : "m"(*data));
+		break;
 	case 3:
-		return GET_XMM(xmm3);
+		asm("movdqa %0, %%xmm3" : : "m"(*data));
+		break;
 	case 4:
-		return GET_XMM(xmm4);
+		asm("movdqa %0, %%xmm4" : : "m"(*data));
+		break;
 	case 5:
-		return GET_XMM(xmm5);
+		asm("movdqa %0, %%xmm5" : : "m"(*data));
+		break;
 	case 6:
-		return GET_XMM(xmm6);
+		asm("movdqa %0, %%xmm6" : : "m"(*data));
+		break;
 	case 7:
-		return GET_XMM(xmm7);
+		asm("movdqa %0, %%xmm7" : : "m"(*data));
+		break;
+	default:
+		BUG();
 	}
-
-	/* never reached */
-	return 0;
 }
 
 static inline void cpu_relax(void)
-- 
2.37.3

