Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A6F6B9213
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjCNLux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjCNLuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:50:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 814049B2C7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:50:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4AE31042;
        Tue, 14 Mar 2023 04:51:27 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 36B993F67D;
        Tue, 14 Mar 2023 04:50:43 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, robin.murphy@arm.com,
        viro@zeniv.linux.org.uk, will@kernel.org
Subject: [PATCH 1/4] lib: test copy_{to,from}_user()
Date:   Tue, 14 Mar 2023 11:50:27 +0000
Message-Id: <20230314115030.347976-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230314115030.347976-1-mark.rutland@arm.com>
References: <20230314115030.347976-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically, implementations of raw_copy_{to,from}_user() haven't
correctly handled the requirements laid forth in <linux/uaccess.h>, e.g.
as Al spotted on arm64:

  https://lore.kernel.org/all/YNSyZaZtPTmTa5P8@zeniv-ca.linux.org.uk/

Similarly, we've had other issues where incorrect fault handling logic
lead to memory corruption, e.g.

  https://lore.kernel.org/linux-arm-kernel/Y44gVm7IEMXqilef@FVFF77S0Q05N.cambridge.arm.com/

These issues are easy to introduce and hard to spot as we don't have any
systematic tests for the faulting paths.

This patch adds KUnit tests for raw_copy_{to,from}_user() which
systematically test the faulting paths, allowing us to detect and avoid
problems such as those above. The test checks copy sizes of 0 to 128
bytes at every possible alignment relative to a page boundary to
exhaustively check all potential faulting and success paths.

I've given this a spin on a few architectures using the KUnit QEMU
harness, and it looks like most get *something* wrong. From those
initial runs:

* arm64's copy_to_user() under-reports the number of bytes copied in
  some cases, e.g.

  | post-destination bytes modified (dst_page[4082]=0x1, offset=4081, size=16, ret=15)

* arm's copy_to_user() under-reports the number of bytes copied in some
  cases, and both copy_to_user() and copy_from_user() don't guarantee
  that at least a single byte is copied when a partial copy is possible,
  e.g.

  | post-destination bytes modified (dst_page[4068]=0x1, offset=4067, size=33, ret=32)
  | too few bytes consumed (offset=4068, size=32, ret=32)

* i386's copy_from_user does not guarantee that at least a single byte
  is copied when a partial copit is possible, e.g.

  | too few bytes consumed (offset=4093, size=8, ret=8)

* riscv's copy_to_user() and copy_from_user() don't guarantee that at
  least a single byte is copied when a partial copy is possible, e.g.

  | too few bytes consumed (offset=4095, size=2, ret=2)

* s390 passes all tests

* sparc's copy_from_user() over-reports the number of bbytes copied in
  some caes, e.g.

  | copied bytes incorrect (dst_page[0+0]=0x0, src_page[4095+0]=0xff, offset=4095, size=2, ret=1

* x86_64 passes all tests

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 lib/Kconfig.debug    |   9 +
 lib/Makefile         |   1 +
 lib/usercopy_kunit.c | 445 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 455 insertions(+)
 create mode 100644 lib/usercopy_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c8b379e2e9ad..bd737db4ef06 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2647,6 +2647,15 @@ config SIPHASH_KUNIT_TEST
 	  This is intended to help people writing architecture-specific
 	  optimized versions.  If unsure, say N.
 
+config USERCOPY_KUNIT_TEST
+	bool "KUnit tests for usercopy functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Tests for faulting behaviour of copy_{to,from}_user().
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index baf2821f7a00..37fb438e6c43 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -391,6 +391,7 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
+obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/usercopy_kunit.c b/lib/usercopy_kunit.c
new file mode 100644
index 000000000000..0c73177b6ce5
--- /dev/null
+++ b/lib/usercopy_kunit.c
@@ -0,0 +1,445 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for usercopy faulting behaviour
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <kunit/test.h>
+
+#include <linux/highmem.h>
+#include <linux/kthread.h>
+#include <linux/mm.h>
+#include <linux/sched/mm.h>
+#include <linux/uaccess.h>
+#include <linux/vmalloc.h>
+
+#define UBUF_ADDR_BASE	SZ_2M
+
+struct usercopy_env {
+	struct mm_struct		*mm;
+	void				*kbuf;
+	struct page			*ubuf_page;
+	void				*ubuf;
+};
+
+struct usercopy_params {
+	long		offset;
+	unsigned long	size;
+};
+
+static void *usercopy_env_alloc(void)
+{
+	struct usercopy_env *env = kzalloc(sizeof(*env), GFP_KERNEL);
+	if (!env)
+		return NULL;
+
+	env->kbuf = vmalloc(PAGE_SIZE);
+	if (!env->kbuf)
+		goto out_free_env;
+
+	return env;
+
+out_free_env:
+	kfree(env);
+	return NULL;
+}
+
+static void usercopy_env_free(struct usercopy_env *env)
+{
+	vfree(env->kbuf);
+	kfree(env);
+}
+
+static void *usercopy_mm_alloc(struct usercopy_env *env)
+{
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	mm = mm_alloc();
+	if (!mm)
+		return NULL;
+
+	if (mmap_write_lock_killable(mm))
+		goto out_free;
+
+	vma = vm_area_alloc(mm);
+	if (!vma)
+		goto out_unlock;
+
+	vma_set_anonymous(vma);
+	vma->vm_start = UBUF_ADDR_BASE;
+	vma->vm_end = UBUF_ADDR_BASE + PAGE_SIZE;
+	vm_flags_init(vma, VM_READ | VM_MAYREAD | VM_WRITE | VM_MAYWRITE);
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
+
+	if (insert_vm_struct(mm, vma))
+		goto out_free_vma;
+
+	mmap_write_unlock(mm);
+	return mm;
+
+out_free_vma:
+	vm_area_free(vma);
+out_unlock:
+	mmap_write_unlock(mm);
+out_free:
+	mmput(mm);
+	return NULL;
+}
+
+static void usercopy_mm_free(struct mm_struct *mm)
+{
+	mmput(mm);
+}
+
+static struct page *usercopy_ubuf_pin(struct usercopy_env *env)
+{
+	struct page *p = NULL;
+
+	kthread_use_mm(env->mm);
+	pin_user_pages_unlocked(UBUF_ADDR_BASE, 1, &p, FOLL_LONGTERM);
+	kthread_unuse_mm(env->mm);
+
+	return p;
+}
+
+static void usercopy_ubuf_unpin(struct usercopy_env *env)
+{
+	unpin_user_page(env->ubuf_page);
+}
+
+static int usercopy_test_init(struct kunit *test)
+{
+	struct usercopy_env *env;
+
+	env = usercopy_env_alloc();
+	if (!env)
+		return -ENOMEM;
+
+	env->mm = usercopy_mm_alloc(env);
+	if (!env->mm)
+		goto out_free_env;
+
+	env->ubuf_page = usercopy_ubuf_pin(env);
+	if (!env->ubuf_page)
+		goto out_free_mm;
+
+	env->ubuf = kmap(env->ubuf_page);
+	if (!env->ubuf)
+		goto out_unpin_ubuf;
+
+	test->priv = env;
+
+	return 0;
+
+out_unpin_ubuf:
+	usercopy_ubuf_unpin(env);
+out_free_mm:
+	usercopy_mm_free(env->mm);
+out_free_env:
+	usercopy_env_free(env);
+	return -ENOMEM;
+}
+
+void usercopy_test_exit(struct kunit *test)
+{
+	struct usercopy_env *env = test->priv;
+
+	kunmap(env->ubuf);
+
+	usercopy_ubuf_unpin(env);
+	usercopy_mm_free(env->mm);
+	usercopy_env_free(env);
+}
+
+static char buf_pattern(int offset)
+{
+	return offset & 0xff;
+}
+
+static void buf_init_pattern(char *buf)
+{
+	for (int i = 0; i < PAGE_SIZE; i++)
+		buf[i] = buf_pattern(i);
+}
+
+static void buf_init_zero(char *buf)
+{
+	memset(buf, 0, PAGE_SIZE);
+}
+
+static void assert_size_valid(struct kunit *test,
+			      const struct usercopy_params *params,
+			      unsigned long ret)
+{
+	const unsigned long size = params->size;
+	const unsigned long offset = params->offset;
+
+	if (ret > size) {
+		KUNIT_ASSERT_FAILURE(test,
+			"return value is impossibly large (ret=%lu, size=%lu)",
+			ret, size);
+	}
+
+	/*
+	 * When the user buffer starts within a faulting page, no bytes can be
+	 * copied, so ret must equal size.
+	 */
+	if (offset < 0 || offset >= PAGE_SIZE) {
+		if (ret == size)
+			return;
+
+		KUNIT_ASSERT_FAILURE(test,
+			"impossible copy did not fail (offset=%ld, size=%lu, ret=%lu)",
+			offset, size, ret);
+	}
+
+	/*
+	 * When the user buffer fits entirely within a non-faulting page, all
+	 * bytes must be copied, so ret must equal 0.
+	 */
+	if (offset + size <= PAGE_SIZE) {
+		if (ret == 0)
+			return;
+
+		KUNIT_ASSERT_FAILURE(test,
+			"completely possible copy failed (offset=%ld, size=%lu, ret=%lu)",
+			offset, size, ret);
+	}
+
+	/*
+	 * The buffer starts in a non-faulting page, but continues into a
+	 * faulting page. At least one byte must be copied, and at most all the
+	 * non-faulting bytes may be copied.
+	 */
+	if (ret == size) {
+		KUNIT_ASSERT_FAILURE(test,
+			"too few bytes consumed (offset=%ld, size=%lu, ret=%lu)",
+			offset, size, ret);
+	}
+
+	if (ret < (offset + size) - PAGE_SIZE) {
+		KUNIT_ASSERT_FAILURE(test,
+			   "too many bytes consumed (offset=%ld, size=%lu, ret=%lu)",
+			   offset, size, ret);
+	}
+}
+
+static void assert_src_valid(struct kunit *test,
+			     const struct usercopy_params *params,
+			     const char *src, long src_offset,
+			     unsigned long ret)
+{
+	const unsigned long size = params->size;
+	const unsigned long offset = params->offset;
+
+	/*
+	 * A usercopy MUST NOT modify the source buffer.
+	 */
+	for (int i = 0; i < PAGE_SIZE; i++) {
+		char val = src[i];
+
+		if (val == buf_pattern(i))
+			continue;
+
+		KUNIT_ASSERT_FAILURE(test,
+			"source bytes modified (src[%d]=0x%x, offset=%ld, size=%lu, ret=%lu)",
+			i, offset, size, ret);
+	}
+}
+
+static void assert_dst_valid(struct kunit *test,
+			     const struct usercopy_params *params,
+			     const char *dst, long dst_offset,
+			     unsigned long ret)
+{
+	const unsigned long size = params->size;
+	const unsigned long offset = params->offset;
+
+	/*
+	 * A usercopy MUST NOT modify any bytes before the destination buffer.
+	 */
+	for (int i = 0; i < dst_offset; i++) {
+		char val = dst[i];
+
+		if (val == 0)
+			continue;
+
+		KUNIT_ASSERT_FAILURE(test,
+			"pre-destination bytes modified (dst_page[%d]=0x%x, offset=%ld, size=%lu, ret=%lu)",
+			i, val, offset, size, ret);
+	}
+
+	/*
+	 * A usercopy MUST NOT modify any bytes after the end of the destination
+	 * buffer.
+	 */
+	for (int i = dst_offset + size - ret; i < PAGE_SIZE; i++) {
+		char val = dst[i];
+
+		if (val == 0)
+			continue;
+
+		KUNIT_ASSERT_FAILURE(test,
+			"post-destination bytes modified (dst_page[%d]=0x%x, offset=%ld, size=%lu, ret=%lu)",
+			i, val, offset, size, ret);
+	}
+}
+
+static void assert_copy_valid(struct kunit *test,
+			      const struct usercopy_params *params,
+			      const char *dst, long dst_offset,
+			      const char *src, long src_offset,
+			      unsigned long ret)
+{
+	const unsigned long size = params->size;
+	const unsigned long offset = params->offset;
+
+	/*
+	 * Have we actually copied the bytes we expected to?
+	 */
+	for (int i = 0; i < params->size - ret; i++) {
+		char dst_val = dst[dst_offset + i];
+		char src_val = src[src_offset + i];
+
+		if (dst_val == src_val)
+			continue;
+
+		KUNIT_ASSERT_FAILURE(test,
+			"copied bytes incorrect (dst_page[%ld+%d]=0x%x, src_page[%ld+%d]=0x%x, offset=%ld, size=%lu, ret=%lu",
+			dst_offset, i, dst_val,
+			src_offset, i, src_val,
+			offset, size, ret);
+	}
+}
+
+static unsigned long do_copy_to_user(const struct usercopy_env *env,
+				     const struct usercopy_params *params)
+{
+	void __user *uptr = (void __user *)UBUF_ADDR_BASE + params->offset;
+	void *kptr = env->kbuf;
+	unsigned long ret;
+
+	kthread_use_mm(env->mm);
+	ret = raw_copy_to_user(uptr, kptr, params->size);
+	kthread_unuse_mm(env->mm);
+
+	return ret;
+}
+
+static unsigned long do_copy_from_user(const struct usercopy_env *env,
+				       const struct usercopy_params *params)
+{
+	void __user *uptr = (void __user *)UBUF_ADDR_BASE + params->offset;
+	void *kptr = env->kbuf;
+	unsigned long ret;
+
+	kthread_use_mm(env->mm);
+	ret = raw_copy_from_user(kptr, uptr, params->size);
+	kthread_unuse_mm(env->mm);
+
+	return ret;
+}
+
+/*
+ * Test offsets in the ranges [-size, 0] and [PAGE_SIZE - size, PAGE_SIZE] so
+ * that we check all possible fault boundaries.
+ */
+#define for_each_offset(size, offset)				\
+	for (long offset = -size;				\
+	     offset <= (long)PAGE_SIZE;				\
+	     offset = (offset ? offset + 1 : (PAGE_SIZE - size)))
+
+static void test_copy_to_user(struct kunit *test)
+{
+	const struct usercopy_env *env = test->priv;
+	const unsigned long size = *(unsigned long *)test->param_value;
+
+	for_each_offset(size, offset) {
+		const struct usercopy_params params = {
+			.size = size,
+			.offset = offset,
+		};
+		unsigned long ret;
+
+		buf_init_zero(env->ubuf);
+		buf_init_pattern(env->kbuf);
+
+		ret = do_copy_to_user(env, &params);
+
+		assert_size_valid(test, &params, ret);
+		assert_src_valid(test, &params, env->kbuf, 0, ret);
+		assert_dst_valid(test, &params, env->ubuf, params.offset, ret);
+		assert_copy_valid(test, &params,
+				  env->ubuf, params.offset,
+				  env->kbuf, 0,
+				  ret);
+	}
+}
+
+static void test_copy_from_user(struct kunit *test)
+{
+	const struct usercopy_env *env = test->priv;
+	const unsigned long size = *(unsigned long *)test->param_value;
+
+	for_each_offset(size, offset) {
+		const struct usercopy_params params = {
+			.size = size,
+			.offset = offset,
+		};
+		unsigned long ret;
+
+		buf_init_zero(env->kbuf);
+		buf_init_pattern(env->ubuf);
+
+		ret = do_copy_from_user(env, &params);
+
+		assert_size_valid(test, &params, ret);
+		assert_src_valid(test, &params, env->ubuf, params.offset, ret);
+		assert_dst_valid(test, &params, env->kbuf, 0, ret);
+		assert_copy_valid(test, &params,
+				  env->kbuf, 0,
+				  env->ubuf, params.offset,
+				  ret);
+	}
+}
+
+static const void *gen_size(const void *prev, char *desc)
+{
+	/*
+	 * Usercopy routines may have special cases for different sized copies,
+	 * so we must test a range of sizes. Most cap out at chunks of up to 64
+	 * bytes, so we check double this to make sure that this works in
+	 * conjunction with any prologue/epilogue copys, and/or when looped.
+	 */
+	const unsigned long max_size = 128;
+	static unsigned long size;
+
+	if (!prev) {
+		size = 0;
+	} else if (size < max_size) {
+		size++;
+	} else {
+		return NULL;
+	}
+
+	sprintf(desc, "%ld byte(s)", size);
+	return &size;
+}
+
+static struct kunit_case usercopy_cases[] = {
+	KUNIT_CASE_PARAM(test_copy_to_user,	gen_size),
+	KUNIT_CASE_PARAM(test_copy_from_user,	gen_size),
+	{ /* sentinel */ }
+};
+
+static struct kunit_suite usercopy_suite = {
+	.name = "usercopy",
+	.init = usercopy_test_init,
+	.exit = usercopy_test_exit,
+	.test_cases = usercopy_cases,
+};
+kunit_test_suites(&usercopy_suite);
+
+MODULE_AUTHOR("Mark Rutland <mark.rutland@arm.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.30.2

