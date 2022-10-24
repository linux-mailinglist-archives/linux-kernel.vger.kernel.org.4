Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC7860B77F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiJXTYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiJXTW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:22:58 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32D07F137
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:57:42 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-13b103a3e5dso12739072fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qmxj0vWQEgj+Z1mhxk0t11F2TRS4068pG7Cn3YLc93M=;
        b=RoeYtWCJrPlGX0VIs/sc613ERsiT3jaYUobVmaCMhW3nhpYDM0rLD5Hx7T0fmI+ovc
         0ZgzTQmQThekxpZw4bPmYTOZW5E2uNHWODxkebN2f1QGt3WsTjShOOHkGn9JHcHgYawk
         mbhb1yEhHsbkzfaOjuFM2WBP8Ptv5f4pqEQwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qmxj0vWQEgj+Z1mhxk0t11F2TRS4068pG7Cn3YLc93M=;
        b=2IefEAtP5BdExjtiy0KJqJvw6OCIbl5XSbEDdVP8A/TlspZXJLKffqz5BImQh331B9
         NclssWPqVXZnCgIB3txYWOaH7svqf+A32v7FNt/d5EwBnvRNCuGYxD1eX8bKOYzALotg
         xPEl5sl+GOX9bg+Prb4s7gfQoyyRz2cHQZ68qMgRByAXs2IOodmxiILMK9fW9bOvVCkS
         RUcIwF+UUOuwfw7eW9Vx4cwdOOjpf1Z1KShR0QORKYGxcSyQlzR/NNUSK0eg8FbqiWVa
         A1nI9c7j95599hzVac5embl77hK4u+k5Q1iBUSHrNADYcb7YrajcK3t5Y+2ZdqiU9lS1
         7bKQ==
X-Gm-Message-State: ACrzQf3pD/Y6nu7hhJ8b1zPhYsR/5gcg80fiw8k2wCeUzZWD6zRwMKaL
        tbaZ+1j9jraNV7vjwsZcmhO+fDkKESXdqg==
X-Google-Smtp-Source: AMsMyM6SD4YTg6SCH0K2c+hMrObX6n3FppmFrvLZysM4eucGJEdzo5KnqJt0Rjl72g/JHVfWkl7FCQ==
X-Received: by 2002:a17:90b:1bd2:b0:213:2d7:3162 with SMTP id oa18-20020a17090b1bd200b0021302d73162mr8926706pjb.91.1666632061482;
        Mon, 24 Oct 2022 10:21:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p15-20020a17090a348f00b00212d9a06edcsm3740554pjb.42.2022.10.24.10.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 10:20:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Daniel Axtens <dja@axtens.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        Zorro Lang <zlang@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/2] Introduce flexible array struct helpers
Date:   Mon, 24 Oct 2022 10:20:57 -0700
Message-Id: <20221024172058.534477-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024171848.never.522-kees@kernel.org>
References: <20221024171848.never.522-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18300; h=from:subject; bh=VE7xE6KLOJSCX2oFsNSDiArHxjbRjS0XR5nN7wPVdak=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjVsl5dqBVu20HBDxjnaBdpQ4Z+Gwk8jxnBnk9XUf6 TjbRDE2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1bJeQAKCRCJcvTf3G3AJnjYD/ 9e8sZwsx0UGUUd9+YNI10JmHm8eu4aq3JfuMHdBoia93B7Pfw3j0gOiqJ8qwMu3sika8o2bvIIyvDT xq6w6nz0GWN5ltrDJcPmSq6CQGbghZiANR35ZMRLF89TQ0ozS7UWuLwOGZ6spWJf6r65BokhasAwR2 k4iFjwyereicMgyzRebXEZCDNCdhET1K0rY5ZH8O4OWzRlkIDEismAqs96gWGLpMOt7tMVAheAk8lj bFUncugq4ldcbrUcp2bDUK1qDe3bOR0dW/vyAGYvXK4HhcuaK3s3CEkqI8Anh0GGsTLvTKBOFKasle 3pFWCw13Wk0qVVAmbhCesAB9VP3yoJNVDsiI/4zS9zH8PwtQ6H6CjNmDVd2uXCQjXPxfQXZWLKNPCY ZyFtqbn45v39IXDjf53qmFJGrYF/oB2N062qNehpGFXNhc3Gdj2BJ7DDqWZRh36tj8WPXWFZXuMjpS R8meS6vh3P2OPOFHbLngSo6nIHsIysYn73VzIMK3Umqtnr8iJXEF7+f0NAl+O5oVyEKunMcTwENEku xkDj7Z6ocZuSOhHU7HAuzMHKgWiD/k5vjhFuU8l0gCToAUGXpMazhw4wrUff5TyUgCMHqBdXnsd+Tv IMcZ/gH68RIPK9jqs8I6p46YpHPbYZJzIcOd8v4osi1Oc0mC7BLsLsvEi5Gg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler is not able to automatically perform bounds checking on
structures that end in flexible arrays: __builtin_object_size() is
compile-time only, and __builtin_dynamic_object_size() may not always
be able to figure it out. Any possible run-time checks are currently
short-circuited (or trigger false positives) because there isn't
an obvious common way to figure out the bounds of such a structure.
C has no way (yet[1]) to signify which struct member holds the number
of allocated flexible array elements (like exists in other languages).

As a result, the kernel (and C projects generally) need to manually
check the bounds, check the element size calculations, and perform sanity
checking on all the associated variable types in between (e.g. 260
cannot be stored in a u8). This is extremely fragile.

However, even if we could do all this through a magic memcpy(), the API
itself doesn't provide meaningful feedback, which forces the kernel
into an "all or nothing" approach: either do the copy or panic the
system. Any failure conditions should be _detectable_, with API users
able to gracefully recover.

To deal with these needs, create the first of a set of helper functions
that do the work of memcpy() but perform the needed bounds checking
based on the arguments given: flex_cpy().

This API will be expanded in the future to also include the common
pattern of "allocate and copy": flex_dup(), "deserialize and copy":
mem_to_flex(), and "deserialize, allocate, and copy": mem_to_flex_dup().

The concept of a "flexible array structure" is introduced, which is a
struct that has both a trailing flexible array member _and_ an element
count member. If a struct lacks the element count member, it's just a
blob: there are no bounds associated with it.

The most common style of flexible array struct in the kernel is a
"simple" one, where both the flex-array and element-count are present:

    struct flex_array_struct_example {
        ...		/* arbitrary members */
        u16 part_count;	/* count of elements stored in "parts" below. */
        ...		/* arbitrary members */
        u32 parts[];	/* flexible array with elements of type u32. */
    };

Next are "encapsulating flexible array structs", which is just a struct
that contains a flexible array struct as its final member:

    struct encapsulating_example {
        ...		/* arbitrary members */
        struct flex_array_struct_example fas;
    };

There are also "split" flex array structs, which have the element-count
member in a separate struct level than the flex-array member:

    struct split_example {
        ...		/* arbitrary members */
        u16 part_count;	/* count of elements stored in "parts" below. */
        ...		/* arbitrary members */
        struct blob_example {
            ...		/* other blob members */
            u32 parts[];/* flexible array with elements of type u32. */
        } blob;
    };

To have the helpers deal with these arbitrary layouts, the names of the
flex-array and element-count members need to be specified with each use
(since C lacks the array-with-length syntax[1] so the compiler cannot
automatically determine them). However, for the "simple" (most common)
case, we can get close to "automatic" by explicitly declaring common
member aliases "__flex_array_elements", and "__flex_array_elements_count"
respectively. The regular helpers use these members, but extended helpers
exist to cover the other two code patterns.

For example, using the newly introduced flex_cpy():

    /* Flexible array struct with members identified. */
    struct simple {
        int mode;
        DECLARE_FAS_COUNT(int, how_many);
        unsigned long flags;
        DECLARE_FAS_ARRAY(u32, value);
    };
    ...

    int do_simple(struct simple *src) {
        struct simple *instance = NULL;
        size_t bytes;
        int rc;

        /* Allocate */
        if (fas_bytes(src, &bytes))
            return -E2BIG;
        instance = kmalloc(bytes, GFP_KERNEL);
        if (!instance)
            return -ENOMEM;
        instance->how_many = src->how_many;
        /* Copy */
        rc = flex_cpy(instance, src);
        if (rc) {
            kfree(instance);
            return rc;
        }
        return 0;
    }

If anything goes wrong, it returns a negative errno. Note that the
"allocate" pattern above will be the basis of the future flex_dup()
helper.

With these helpers the kernel can move away from many of the open-coded
patterns of using memcpy() with a dynamically-sized destination buffer.

[1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1990.htm

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Keith Packard <keithp@keithp.com>
Cc: Francis Laniel <laniel_francis@privacyrequired.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Tadeusz Struk <tadeusz.struk@linaro.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20220504014440.3697851-3-keescook@chromium.org
---
 include/linux/flex_array.h  | 325 ++++++++++++++++++++++++++++++++++++
 include/linux/string.h      |   1 +
 include/uapi/linux/stddef.h |  14 ++
 3 files changed, 340 insertions(+)
 create mode 100644 include/linux/flex_array.h

diff --git a/include/linux/flex_array.h b/include/linux/flex_array.h
new file mode 100644
index 000000000000..ebdbf0e5f722
--- /dev/null
+++ b/include/linux/flex_array.h
@@ -0,0 +1,325 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FLEX_ARRAY_H_
+#define _LINUX_FLEX_ARRAY_H_
+
+#include <linux/string.h>
+
+/* Make sure we compose correctly with KASAN. */
+#ifndef __underlying_memcpy
+#define __underlying_memcpy     __builtin_memcpy
+#endif
+#ifndef __underlying_memset
+#define __underlying_memset	__builtin_memset
+#endif
+
+/*
+ * A "flexible array structure" (FAS) is a structure which ends with a
+ * flexible array member (FAM) _and_ contains another member that represents
+ * how many array elements are present in the struct instance's flexible
+ * array member:
+ *
+ * struct flex_array_struct_example {
+ *	...		// arbitrary members
+ *	u16 part_count;	// count of elements stored in "parts" below.
+ *	...		// arbitrary members
+ *	u32 parts[];	// flexible array member containing u32 elements.
+ * };
+ *
+ * Without the "count of elements" member, a structure ending with a
+ * flexible array has no way to check its own size, and should be
+ * considered just a blob of memory that is length-checked through some
+ * other means. Kernel structures with flexible arrays should strive to
+ * always be true flexible array structures so that they can be operated
+ * on with the flex*()-family of helpers defined below.
+ *
+ * To use the normal flex*() helpers, prepare for future C syntax that
+ * would identify a flex array's count member directly, and keep kernel
+ * declarations minimized, a common declaration, bounded_flex_array(), is
+ * provided:
+ *
+ * struct flex_array_struct_example {
+ *	...			 // arbitrary members
+ *	bounded_flex_array(
+ *		u16, part_count, // count of elements stored in "parts" below.
+ *		u32, parts	 // flexible array with elements of type u32.
+ *	);
+ * );
+ *
+ * To handle the less common case when the count member cannot be made a
+ * neighbor of the flex array, either the extended flex*() helpers can be
+ * used, or the members can also be declared separately:
+ *
+ * struct flex_array_struct_example {
+ *	...		// position-sensitive members
+ *	// count of elements stored in "parts" below.
+ *	DECLARE_FAS_COUNT(u16, part_count);
+ *	..		// position-sensitive members
+ *	// flexible array with elements of type u32.
+ *	DECLARE_FAS_ARRAY(u32, parts);
+ * };
+ *
+ * The above two declaration styles will create an alias for part_count as
+ * __flex_array_elements_count and for parts as __flex_array_elements,
+ * which are used internally to avoid needing to repeat the member names
+ * as arguments to the normal flex*() helpers.
+ *
+ * The extended flex*() helpers are designed to be used in the less common
+ * situations when the member aliases are not available, especially in two
+ * flexible array struct layout situations: "encapsulated" and "split".
+ *
+ * An "encapsulated flexible array structure" is a structure that contains
+ * a full "flexible array structure" as its final struct member. These are
+ * used frequently when needing to pass around a copy of a flexible array
+ * structure, and track other things about the data outside of the scope of
+ * the flexible array structure itself:
+ *
+ * struct encapsulated_example {
+ *	...		// arbitrary members
+ *	struct flex_array_struct_example fas;
+ * };
+ *
+ * A "split flexible array structure" is like an encapsulated flexible
+ * array struct, but the element count member is at a different level,
+ * separate from the struct that contains the flexible array:
+ *
+ * struct blob_example {
+ *	...		// arbitrary members
+ *	u32 parts[];	// flexible array with elements of type u32.
+ * };
+ *
+ * struct split_example {
+ *	...		// arbitrary members
+ *	u16 part_count;	// count of elements stored in "parts" below.
+ *	...		// arbitrary members
+ *	struct blob_example blob;
+ * };
+ *
+ * In the case where the element count member is not stored in native
+ * CPU format, the extended helpers can be used to specify the to/from
+ * cpu helper needed to do the conversions.
+ *
+ * Examples of using flex_cpy():
+ *
+ *	struct simple {
+ *		u32 flags;
+ *		bounded_flex_array(
+ *			u32,	count,
+ *			u8,	data
+ *		);
+ *	};
+ *	struct hardware_defined {
+ *		DECLARE_FAS_COUNT(u32, count);
+ *		u32 state;
+ *		u32 flags;
+ *		DECLARE_FAS_ARRAY(u8, data);
+ *	};
+ *
+ *	int do_simple(struct simple *src) {
+ *		struct simple *ptr_simple = NULL;
+ *		struct hardware_defined *ptr_hw = NULL;
+ *
+ *		...allocation of ptr_simple happens...
+ *		ptr_simple->count = src->count;
+ *		rc = flex_cpy(ptr_simple, src);
+ *		...
+ *		...allocation of ptr_hw happens...
+ *		ptr_hw->count = src->count;
+ *		rc = flex_cpy(ptr_hw, src);
+ *		...
+ *	}
+ *
+ *	struct blob {
+ *		u32 flags;
+ *		u8 data[];
+ *	};
+ *	struct split {
+ *		be32 count;
+ *		struct blob blob;
+ *	};
+ *	struct split *ptr_split = NULL;
+ *
+ *	int do_split(struct split *src) {
+ *		struct split *ptr = NULL;
+ *
+ *		...allocation of ptr happens...
+ *		ptr->count = src->count;
+ *		rc = __flex_cpy(ptr, src, blob.data, count, be32_to_cpu);
+ *		...
+ *	}
+ *
+ */
+
+/* Wrappers around the UAPI macros. */
+#define bounded_flex_array(COUNT_TYPE, COUNT_NAME, ARRAY_TYPE, ARRAY_NAME) \
+	__DECLARE_FAS_COUNT(COUNT_TYPE, COUNT_NAME);	\
+	__DECLARE_FAS_ARRAY(ARRAY_TYPE, ARRAY_NAME)
+
+#define DECLARE_FAS_COUNT(TYPE, NAME)			\
+	__DECLARE_FAS_COUNT(TYPE, NAME)
+
+#define DECLARE_FAS_ARRAY(TYPE, NAME)			\
+	__DECLARE_FAS_ARRAY(TYPE, NAME)
+
+/* All the helpers return negative on failure, and must be checked. */
+static inline int __must_check __must_check_errno(int err)
+{
+	return err;
+}
+
+#define __passthru(x)	(x)
+
+/**
+ * __fas_elements_bytes - Calculate potential size of the flexible
+ *			  array elements of a given flexible array
+ *			  structure
+ *
+ * @p: Pointer to flexible array structure.
+ * @flex_member: Member name of the flexible array elements.
+ * @count_member: Member name of the flexible array elements count.
+ * @elements_count: Count of proposed number of @p->__flex_array_elements
+ * @bytes: Pointer to variable to write calculation of total size in bytes.
+ *
+ * Returns: 0 on successful calculation, -ve on error.
+ *
+ * This performs the same calculation as flex_array_size(), except
+ * that the result is bounds checked and written to @bytes instead
+ * of being returned.
+ */
+#define __fas_elements_bytes(p, flex_member, count_member,		\
+			     elements_count, bytes)			\
+__must_check_errno(({							\
+	int __feb_err = -EINVAL;					\
+	size_t __feb_elements_count = (elements_count);			\
+	size_t __feb_elements_max =					\
+		type_max(typeof((p)->count_member));			\
+	if (__feb_elements_count > __feb_elements_max ||		\
+	    check_mul_overflow(sizeof(*(p)->flex_member),		\
+			       __feb_elements_count, bytes)) {		\
+		*(bytes) = 0;						\
+		__feb_err = -E2BIG;					\
+	} else {							\
+		__feb_err = 0;						\
+	}								\
+	__feb_err;							\
+}))
+
+/**
+ * fas_elements_bytes - Calculate current size of the flexible array
+ *			elements of a given flexible array structure
+ *
+ * @p: Pointer to flexible array structure.
+ * @bytes: Pointer to variable to write calculation of total size in bytes.
+ *
+ * Returns: 0 on successful calculation, -ve on error.
+ *
+ * This performs the same calculation as flex_array_size(), except
+ * that the result is bounds checked and written to @bytes instead
+ * of being returned.
+ */
+#define fas_elements_bytes(p, bytes)					\
+	__fas_elements_bytes(p, __flex_array_elements,			\
+			     __flex_array_elements_count,		\
+			     (p)->__flex_array_elements_count, bytes)
+
+/**
+ * __fas_bytes - Calculate potential size of flexible array structure
+ *
+ * @p: Pointer to flexible array structure.
+ * @flex_member: Member name of the flexible array elements.
+ * @count_member: Member name of the flexible array elements count.
+ * @elements_count: Count of proposed number of @p->__flex_array_elements
+ * @bytes: Pointer to variable to write calculation of total size in bytes.
+ *
+ * Returns: 0 on successful calculation, -ve on error.
+ *
+ * This performs the same calculation as struct_size(), except
+ * that the result is bounds checked and written to @bytes instead
+ * of being returned.
+ */
+#define __fas_bytes(p, flex_member, count_member, elements_count, bytes)\
+__must_check_errno(({							\
+	int __fasb_err;							\
+	typeof(*bytes) __fasb_bytes;					\
+									\
+	if (__fas_elements_bytes(p, flex_member, count_member,		\
+				 elements_count, &__fasb_bytes) ||	\
+	    check_add_overflow(sizeof(*(p)), __fasb_bytes, bytes)) {	\
+		*(bytes) = 0;						\
+		__fasb_err = -E2BIG;					\
+	} else {							\
+		__fasb_err = 0;						\
+	}								\
+	__fasb_err;							\
+}))
+
+/**
+ * fas_bytes - Calculate current size of flexible array structure
+ *
+ * @p: Pointer to flexible array structure.
+ * @bytes: Pointer to variable to write calculation of total size in bytes.
+ *
+ * This performs the same calculation as struct_size(), except
+ * that the result is bounds checked and written to @bytes instead
+ * of being returned, using the current size of the flexible array
+ * structure (via @p->__flexible_array_elements_count).
+ *
+ * Returns: 0 on successful calculation, -ve on error.
+ */
+#define fas_bytes(p, bytes)						\
+	__fas_bytes(p, __flex_array_elements,				\
+		    __flex_array_elements_count,			\
+		    (p)->__flex_array_elements_count, bytes)
+
+/**
+ * flex_cpy - Copy from one flexible array struct into another
+ *
+ * @dst: Destination pointer
+ * @src: Source pointer
+ *
+ * The full structure of @src will be copied to @dst, including all trailing
+ * flexible array elements. @dst->__flex_array_elements_count must be large
+ * enough to hold @src->__flex_array_elements_count. Any elements left over
+ * in @dst will be zero-wiped.
+ *
+ * Returns: 0 on successful calculation, -ve on error.
+ */
+#define __flex_cpy(dst, src, elements_member, count_member, to_cpu)	\
+__must_check_errno(({							\
+	int __fc_err = -EINVAL;						\
+	typeof(*(dst)) *__fc_dst = (dst);				\
+	typeof(*(src)) *__fc_src = (src);				\
+	size_t __fc_dst_bytes, __fc_src_bytes;				\
+									\
+	BUILD_BUG_ON(!__same_type(*(__fc_dst), *(__fc_src)));		\
+									\
+	do {								\
+		if (__fas_bytes(__fc_dst,				\
+				elements_member,			\
+				count_member,				\
+				to_cpu(__fc_dst->count_member),		\
+				&__fc_dst_bytes) ||			\
+		    __fas_bytes(__fc_src,				\
+				elements_member,			\
+				count_member,				\
+				to_cpu(__fc_src->count_member),		\
+				&__fc_src_bytes) ||			\
+		    __fc_dst_bytes < __fc_src_bytes) {			\
+			/* do we need to wipe dst here? */		\
+			__fc_err = -E2BIG;				\
+			break;						\
+		}							\
+		__underlying_memcpy(__fc_dst, __fc_src, __fc_src_bytes);\
+		/* __flex_array_elements_count is included in memcpy */	\
+		/* Wipe any now-unused trailing elements in @dst: */	\
+		__underlying_memset((u8 *)__fc_dst + __fc_src_bytes, 0,	\
+				 __fc_dst_bytes - __fc_src_bytes);	\
+		__fc_err = 0;						\
+	} while (0);							\
+	__fc_err;							\
+}))
+
+#define flex_cpy(dst, src)						\
+	__flex_cpy(dst, src, __flex_array_elements,			\
+		   __flex_array_elements_count, __passthru)
+
+#endif /* _LINUX_FLEX_ARRAY_H_ */
diff --git a/include/linux/string.h b/include/linux/string.h
index cf7607b32102..9277f9e2a432 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -256,6 +256,7 @@ static inline const char *kbasename(const char *path)
 #define unsafe_memcpy(dst, src, bytes, justification)		\
 	memcpy(dst, src, bytes)
 #endif
+#include <linux/flex_array.h>
 
 void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
 		    int pad);
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 7837ba4fe728..e16afe1951d8 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -44,4 +44,18 @@
 		struct { } __empty_ ## NAME; \
 		TYPE NAME[]; \
 	}
+
+/* For use with flexible array structure helpers, in <linux/flex_array.h> */
+#define __DECLARE_FAS_COUNT(TYPE, NAME)					\
+	union {								\
+		TYPE __flex_array_elements_count;			\
+		TYPE NAME;						\
+	}
+
+#define __DECLARE_FAS_ARRAY(TYPE, NAME)					\
+	union {								\
+		__DECLARE_FLEX_ARRAY(TYPE, __flex_array_elements);	\
+		__DECLARE_FLEX_ARRAY(TYPE, NAME);			\
+	}
+
 #endif
-- 
2.34.1

