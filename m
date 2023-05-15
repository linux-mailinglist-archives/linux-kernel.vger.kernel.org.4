Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EDF703BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245087AbjEOSHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243192AbjEOSGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925A61F307
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684173826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=F5ZFnFWd0bfXvbTVZzhDKmwHy0T6x+spMFYT61y9M6E=;
        b=g3vAmX6c3AFB9Rrmyat6tJSIckmT2gusprlx0AqtVuoDmaPBoI00F3AYPYM/EOVSpYZuAc
        wlPVA2L+FypOVn6UPH+LjbB3BNIWXOy2lSi5/p0kBT4tJ2fi4UEVmr7ce0R8GnHWu/wxPH
        oGea7ik6qAvW7msFR43Da6Fp8I0C2h0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-s_j6uHycNbCQd9e2JrYNNA-1; Mon, 15 May 2023 14:03:42 -0400
X-MC-Unique: s_j6uHycNbCQd9e2JrYNNA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 618F63C0ED41;
        Mon, 15 May 2023 18:03:41 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04617492B00;
        Mon, 15 May 2023 18:03:41 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 54F094161E527; Mon, 15 May 2023 15:02:17 -0300 (-03)
Message-ID: <20230515180138.541141182@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 15 May 2023 15:00:20 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v8 05/13] this_cpu_cmpxchg: x86: switch this_cpu_cmpxchg to locked, add _local function
References: <20230515180015.016409657@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goal is to have vmstat_shepherd to transfer from
per-CPU counters to global counters remotely. For this,
an atomic this_cpu_cmpxchg is necessary.

Following the kernel convention for cmpxchg/cmpxchg_local,
change x86's this_cpu_cmpxchg_ helpers to be atomic.
and add this_cpu_cmpxchg_local_ helpers which are not atomic.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

Index: linux-vmstat-remote/arch/x86/include/asm/percpu.h
===================================================================
--- linux-vmstat-remote.orig/arch/x86/include/asm/percpu.h
+++ linux-vmstat-remote/arch/x86/include/asm/percpu.h
@@ -197,11 +197,11 @@ do {									\
  * cmpxchg has no such implied lock semantics as a result it is much
  * more efficient for cpu local operations.
  */
-#define percpu_cmpxchg_op(size, qual, _var, _oval, _nval)		\
+#define percpu_cmpxchg_op(size, qual, _var, _oval, _nval, lockp)	\
 ({									\
 	__pcpu_type_##size pco_old__ = __pcpu_cast_##size(_oval);	\
 	__pcpu_type_##size pco_new__ = __pcpu_cast_##size(_nval);	\
-	asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",		\
+	asm qual (__pcpu_op2_##size(lockp "cmpxchg", "%[nval]",		\
 				    __percpu_arg([var]))		\
 		  : [oval] "+a" (pco_old__),				\
 		    [var] "+m" (_var)					\
@@ -279,16 +279,20 @@ do {									\
 #define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, , pcp, val)
 #define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, , pcp, val)
 #define raw_cpu_add_return_4(pcp, val)		percpu_add_return_op(4, , pcp, val)
-#define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, , pcp, oval, nval)
-#define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, , pcp, oval, nval)
-#define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, , pcp, oval, nval)
+#define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, , pcp, oval, nval, "")
+#define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, , pcp, oval, nval, "")
+#define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, , pcp, oval, nval, "")
 
 #define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, volatile, pcp, val)
 #define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, volatile, pcp, val)
 #define this_cpu_add_return_4(pcp, val)		percpu_add_return_op(4, volatile, pcp, val)
-#define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, volatile, pcp, oval, nval)
-#define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, volatile, pcp, oval, nval)
-#define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, volatile, pcp, oval, nval)
+#define this_cpu_cmpxchg_local_1(pcp, oval, nval)	percpu_cmpxchg_op(1, volatile, pcp, oval, nval, "")
+#define this_cpu_cmpxchg_local_2(pcp, oval, nval)	percpu_cmpxchg_op(2, volatile, pcp, oval, nval, "")
+#define this_cpu_cmpxchg_local_4(pcp, oval, nval)	percpu_cmpxchg_op(4, volatile, pcp, oval, nval, "")
+
+#define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, volatile, pcp, oval, nval, LOCK_PREFIX)
+#define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, volatile, pcp, oval, nval, LOCK_PREFIX)
+#define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, volatile, pcp, oval, nval, LOCK_PREFIX)
 
 #ifdef CONFIG_X86_CMPXCHG64
 #define percpu_cmpxchg8b_double(pcp1, pcp2, o1, o2, n1, n2)		\
@@ -319,16 +323,17 @@ do {									\
 #define raw_cpu_or_8(pcp, val)			percpu_to_op(8, , "or", (pcp), val)
 #define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, , pcp, val)
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
-#define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, , pcp, oval, nval)
+#define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, , pcp, oval, nval, "")
 
-#define this_cpu_read_8(pcp)			percpu_from_op(8, volatile, "mov", pcp)
-#define this_cpu_write_8(pcp, val)		percpu_to_op(8, volatile, "mov", (pcp), val)
-#define this_cpu_add_8(pcp, val)		percpu_add_op(8, volatile, (pcp), val)
-#define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
-#define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
-#define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
-#define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(8, volatile, pcp, nval)
-#define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
+#define this_cpu_read_8(pcp)				percpu_from_op(8, volatile, "mov", pcp)
+#define this_cpu_write_8(pcp, val)			percpu_to_op(8, volatile, "mov", (pcp), val)
+#define this_cpu_add_8(pcp, val)			percpu_add_op(8, volatile, (pcp), val)
+#define this_cpu_and_8(pcp, val)			percpu_to_op(8, volatile, "and", (pcp), val)
+#define this_cpu_or_8(pcp, val)				percpu_to_op(8, volatile, "or", (pcp), val)
+#define this_cpu_add_return_8(pcp, val)			percpu_add_return_op(8, volatile, pcp, val)
+#define this_cpu_xchg_8(pcp, nval)			percpu_xchg_op(8, volatile, pcp, nval)
+#define this_cpu_cmpxchg_local_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval, "")
+#define this_cpu_cmpxchg_8(pcp, oval, nval)		percpu_cmpxchg_op(8, volatile, pcp, oval, nval, LOCK_PREFIX)
 
 /*
  * Pretty complex macro to generate cmpxchg16 instruction.  The instruction


