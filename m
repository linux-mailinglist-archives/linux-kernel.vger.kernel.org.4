Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD1F690D09
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjBIPeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjBIPeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:34:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68196144B7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675956801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=hjd5gtUB1FFqfcJWUv9qrW5kcd1bszAAtI+X6kwFBXk=;
        b=G6qcjjajdVmVDzxZqne2LsGRPlIf+l8TNlOG7Y30iM3hvqULTMLiqQ5QrxRvdpE1OBfzzJ
        kUOyDwy7sonVNsw0x7Msv8C8uagxvow5rj9//6W8H37q7HoT7l4eEOXBmXdV24vIFIEgYf
        nVP1DS2jApkOXNyOcB84t2B3Bmwiy0g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-unXOuOmGPT2X0gACJlUVeQ-1; Thu, 09 Feb 2023 10:33:18 -0500
X-MC-Unique: unXOuOmGPT2X0gACJlUVeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98BE93C10EDA;
        Thu,  9 Feb 2023 15:33:16 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4973F40398A0;
        Thu,  9 Feb 2023 15:33:16 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 72D73403CC077; Thu,  9 Feb 2023 12:32:51 -0300 (-03)
Message-ID: <20230209153204.765612949@redhat.com>
User-Agent: quilt/0.67
Date:   Thu, 09 Feb 2023 12:01:55 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@linux.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v2 05/11] this_cpu_cmpxchg: x86: switch this_cpu_cmpxchg to locked, add _local function
References: <20230209150150.380060673@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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


