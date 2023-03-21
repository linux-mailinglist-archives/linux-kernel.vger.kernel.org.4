Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EB56C26A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCUA71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCUA7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:59:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51086305ED
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:59:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9D8CB80AB3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E9FC433D2;
        Tue, 21 Mar 2023 00:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360356;
        bh=6DcpPXTZ7xNkasjI+sZ0IKPVFtzvWjhG3dAxGsBoKj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Usq6838HtSh4AJ4uEwQ2w2/FrtkFBPfpZvAGA5aV7V1F5bwty9qeH/7l/UWplbeeu
         QG3PHOUI6544DMilXTPS5UoIIB0mIw3kREHoCBd833CBRyBSQueiYKk+mgwhcqR6CW
         5N/aLkxewMc6+QuQFqTddL7eZYcAIlFqdM7OTbzxUY2IHRwCfA5LbGlo0zYlUQbKdQ
         st5OUax/zb/0c8eD2eCEI/6ciI/6Kg6GwlU8agjG7IHXpTFdcmjuCjd3gBoAuAl+LF
         ZG0rCn9OJY0AHsiD8trqKtb8LXzA9K+OydhTA8+sHVjiSJ7/Mbuwbl5EppznkkDW9S
         uzPJSAKggcBYg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 23BA81540395; Mon, 20 Mar 2023 17:59:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@meta.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 1/2] instrumented.h: Fix all kernel-doc format warnings
Date:   Mon, 20 Mar 2023 17:59:13 -0700
Message-Id: <20230321005914.50783-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <a26f2bdb-1504-487b-8ec8-001adafc5491@paulmck-laptop>
References: <a26f2bdb-1504-487b-8ec8-001adafc5491@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix 26 kernel-doc notation warnings by converting the function
documentation to kernel-doc format.

Warning example:

instrumented.h:155: warning: Function parameter or member 'to' not described in 'instrument_copy_from_user_after'
instrumented.h:155: warning: Function parameter or member 'from' not described in 'instrument_copy_from_user_after'
instrumented.h:155: warning: Function parameter or member 'n' not described in 'instrument_copy_from_user_after'
instrumented.h:155: warning: Function parameter or member 'left' not described in 'instrument_copy_from_user_after'

Fixes: 36e4d4dd4fc4 ("include/linux: Add instrumented.h infrastructure")
Fixes: 00047c2e6d7c ("instrumented.h: Introduce read-write instrumentation hooks")
Fixes: 33b75c1d884e ("instrumented.h: allow instrumenting both sides of copy_from_user()")
Fixes: 888f84a6da4d ("x86: asm: instrument usercopy in get_user() and put_user()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Marco Elver <elver@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/instrumented.h | 63 +++++++++++++++---------------------
 1 file changed, 26 insertions(+), 37 deletions(-)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 501fa8486749..1b608e00290a 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -15,12 +15,11 @@
 
 /**
  * instrument_read - instrument regular read access
+ * @v: address of access
+ * @size: size of access
  *
  * Instrument a regular read access. The instrumentation should be inserted
  * before the actual read happens.
- *
- * @ptr address of access
- * @size size of access
  */
 static __always_inline void instrument_read(const volatile void *v, size_t size)
 {
@@ -30,12 +29,11 @@ static __always_inline void instrument_read(const volatile void *v, size_t size)
 
 /**
  * instrument_write - instrument regular write access
+ * @v: address of access
+ * @size: size of access
  *
  * Instrument a regular write access. The instrumentation should be inserted
  * before the actual write happens.
- *
- * @ptr address of access
- * @size size of access
  */
 static __always_inline void instrument_write(const volatile void *v, size_t size)
 {
@@ -45,12 +43,11 @@ static __always_inline void instrument_write(const volatile void *v, size_t size
 
 /**
  * instrument_read_write - instrument regular read-write access
+ * @v: address of access
+ * @size: size of access
  *
  * Instrument a regular write access. The instrumentation should be inserted
  * before the actual write happens.
- *
- * @ptr address of access
- * @size size of access
  */
 static __always_inline void instrument_read_write(const volatile void *v, size_t size)
 {
@@ -60,12 +57,11 @@ static __always_inline void instrument_read_write(const volatile void *v, size_t
 
 /**
  * instrument_atomic_read - instrument atomic read access
+ * @v: address of access
+ * @size: size of access
  *
  * Instrument an atomic read access. The instrumentation should be inserted
  * before the actual read happens.
- *
- * @ptr address of access
- * @size size of access
  */
 static __always_inline void instrument_atomic_read(const volatile void *v, size_t size)
 {
@@ -75,12 +71,11 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
 
 /**
  * instrument_atomic_write - instrument atomic write access
+ * @v: address of access
+ * @size: size of access
  *
  * Instrument an atomic write access. The instrumentation should be inserted
  * before the actual write happens.
- *
- * @ptr address of access
- * @size size of access
  */
 static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
 {
@@ -90,12 +85,11 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 
 /**
  * instrument_atomic_read_write - instrument atomic read-write access
+ * @v: address of access
+ * @size: size of access
  *
  * Instrument an atomic read-write access. The instrumentation should be
  * inserted before the actual write happens.
- *
- * @ptr address of access
- * @size size of access
  */
 static __always_inline void instrument_atomic_read_write(const volatile void *v, size_t size)
 {
@@ -105,13 +99,12 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
 
 /**
  * instrument_copy_to_user - instrument reads of copy_to_user
+ * @to: destination address
+ * @from: source address
+ * @n: number of bytes to copy
  *
  * Instrument reads from kernel memory, that are due to copy_to_user (and
  * variants). The instrumentation must be inserted before the accesses.
- *
- * @to destination address
- * @from source address
- * @n number of bytes to copy
  */
 static __always_inline void
 instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
@@ -123,13 +116,12 @@ instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
 
 /**
  * instrument_copy_from_user_before - add instrumentation before copy_from_user
+ * @to: destination address
+ * @from: source address
+ * @n: number of bytes to copy
  *
  * Instrument writes to kernel memory, that are due to copy_from_user (and
  * variants). The instrumentation should be inserted before the accesses.
- *
- * @to destination address
- * @from source address
- * @n number of bytes to copy
  */
 static __always_inline void
 instrument_copy_from_user_before(const void *to, const void __user *from, unsigned long n)
@@ -140,14 +132,13 @@ instrument_copy_from_user_before(const void *to, const void __user *from, unsign
 
 /**
  * instrument_copy_from_user_after - add instrumentation after copy_from_user
+ * @to: destination address
+ * @from: source address
+ * @n: number of bytes to copy
+ * @left: number of bytes not copied (as returned by copy_from_user)
  *
  * Instrument writes to kernel memory, that are due to copy_from_user (and
  * variants). The instrumentation should be inserted after the accesses.
- *
- * @to destination address
- * @from source address
- * @n number of bytes to copy
- * @left number of bytes not copied (as returned by copy_from_user)
  */
 static __always_inline void
 instrument_copy_from_user_after(const void *to, const void __user *from,
@@ -158,12 +149,11 @@ instrument_copy_from_user_after(const void *to, const void __user *from,
 
 /**
  * instrument_get_user() - add instrumentation to get_user()-like macros
+ * @to: destination variable, may not be address-taken
  *
  * get_user() and friends are fragile, so it may depend on the implementation
  * whether the instrumentation happens before or after the data is copied from
  * the userspace.
- *
- * @to destination variable, may not be address-taken
  */
 #define instrument_get_user(to)				\
 ({							\
@@ -175,14 +165,13 @@ instrument_copy_from_user_after(const void *to, const void __user *from,
 
 /**
  * instrument_put_user() - add instrumentation to put_user()-like macros
+ * @from: source address
+ * @ptr: userspace pointer to copy to
+ * @size: number of bytes to copy
  *
  * put_user() and friends are fragile, so it may depend on the implementation
  * whether the instrumentation happens before or after the data is copied from
  * the userspace.
- *
- * @from source address
- * @ptr userspace pointer to copy to
- * @size number of bytes to copy
  */
 #define instrument_put_user(from, ptr, size)			\
 ({								\
-- 
2.40.0.rc2

