Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233756D869D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjDETNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjDETNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:13:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212A349CC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680721981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bRChuKg+AyjKdL5C2dzdM6PZM+/EGW73Fd/2uqy3jZc=;
        b=TB48uZ9hcetKn7cF2SU1V5g32ihFZajzNOB1M7b+wC5UaiCAd134nErtqzvc0EHEoGoIvS
        nSGTSt8zVYKeA/4QhNGM+k2jM592cNNMTNJNOxTvL27AKsVOb8MgLnoY/pgaLPaQl7+gx5
        LLzBCmF+ayPgEW4lZYf8MrGvz7GfYvc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-e9OQGeCMP0yVvxEXb0MuwA-1; Wed, 05 Apr 2023 15:12:58 -0400
X-MC-Unique: e9OQGeCMP0yVvxEXb0MuwA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-74610f3f19fso19725185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 12:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680721977; x=1683313977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRChuKg+AyjKdL5C2dzdM6PZM+/EGW73Fd/2uqy3jZc=;
        b=ztbR4hJbG6vncKxdafK3rJ8n25EpHlNc5AFt3rhbjAI5iwBboF+DDi0V14JGg4e7MT
         ZrOvm2qjIB3dTCdSZuFsczj2iCV3791GAE1olY6fOFQyrQ7AgNOTWbqaiQ69mUgvtTRw
         nRFq5SL8ckHjlrJB8Kcc3IVdWDI2jTLpWzEYIAES46YikR5xOtKUy7yIEzkfzN3VxVsX
         GHDtBBhkf2/H32c6Usr4gDDJ8uxx5m9alwPubACJZZQjWowwrIV4ieo1aRZbzrB5GxV1
         knIfFovikarbKYy+LcdeyBMFe0SwFxV2uLuNnwavdwzCpdqJBuJcLiduWxiusN7dKXFF
         28gw==
X-Gm-Message-State: AAQBX9cpC42OZz721zKO8gIMIB0pPTWSZKRBQ2ix8/Bhcpc0tDZrlXWA
        CG8NNfHenu2CNjHedI2tAgICqIYkE+mKx5i/ULo8O6bvjS1Mi7iVKJg1NzXmsLDZMHAH3ssW4VM
        mPrb+dc+7zxHB/6FMMyo7YiLf
X-Received: by 2002:a05:622a:1889:b0:3d1:16f4:ae58 with SMTP id v9-20020a05622a188900b003d116f4ae58mr5270063qtc.2.1680721977538;
        Wed, 05 Apr 2023 12:12:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350bVo9ufZ2cZHfOZizrr+KeK3BDE+GGsR3Jgjosp01At2GHN0XiIx6kA0YsQmYWEQ61U2Gib1A==
X-Received: by 2002:a05:622a:1889:b0:3d1:16f4:ae58 with SMTP id v9-20020a05622a188900b003d116f4ae58mr5270016qtc.2.1680721977092;
        Wed, 05 Apr 2023 12:12:57 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id p4-20020ac87404000000b003e390b48958sm4182160qtq.55.2023.04.05.12.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 12:12:56 -0700 (PDT)
Date:   Wed, 5 Apr 2023 15:12:55 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/29] selftests/mm: uffd_[un]register()
Message-ID: <ZC3INzNZqZ1JNER8@x1n>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160747.3107258-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3Sb0bv4kXOGv7yMA"
Content-Disposition: inline
In-Reply-To: <20230330160747.3107258-1-peterx@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3Sb0bv4kXOGv7yMA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Mar 30, 2023 at 12:07:47PM -0400, Peter Xu wrote:
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index c57757c2a36f..17f2bb82c3db 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -330,33 +330,6 @@ void uffd_test_ctx_init(uint64_t features)
>  			err("pipe");
>  }
>  
> -uint64_t get_expected_ioctls(uint64_t mode)
> -{
> -	uint64_t ioctls = UFFD_API_RANGE_IOCTLS;
> -
> -	if (test_type == TEST_HUGETLB)
> -		ioctls &= ~(1 << _UFFDIO_ZEROPAGE);
> -
> -	if (!((mode & UFFDIO_REGISTER_MODE_WP) && test_uffdio_wp))
> -		ioctls &= ~(1 << _UFFDIO_WRITEPROTECT);
> -
> -	if (!((mode & UFFDIO_REGISTER_MODE_MINOR) && test_uffdio_minor))
> -		ioctls &= ~(1 << _UFFDIO_CONTINUE);
> -
> -	return ioctls;
> -}
> -
> -void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
> -{
> -	uint64_t expected = get_expected_ioctls(mode);
> -	uint64_t actual = ioctls & expected;
> -
> -	if (actual != expected) {
> -		err("missing ioctl(s): expected %"PRIx64" actual: %"PRIx64,
> -		    expected, actual);
> -	}
> -}

Here I dropped the other reference of get_expected_ioctls(), so I also
dropped this test which I think is kind of flawed IMHO - as I replied in
the other thread, we should probably not reference UFFD_API_RANGE_IOCTLS.

But I can feel (from the comments in the other patch that removed the other
reference of get_expected_ioctls()) that a lot of us would still care about
this test.

So I added a new patch / test on top of the series (so it'll have one more
patch in the next version at last), just to test all possible combinations
of UFFDIO_REGISTER alongside with its returned uffdio_register.ioctls.

This is IMHO better than get_expected_ioctls() because:

  - It's much cleaner to have a separate test on this rather than testing
    it randomly in the code with random values passed in.

  - It tests all combinations. It not only includes shmem-private that this
    series introduced while wasn't there before, but also all combinations
    of (miss, wp, minor) tuples.

  - It doesn't rely on UFFD_API_RANGE_IOCTLS anymore.

It'll be something like this:

===8<===
/*
 * Test the returned uffdio_register.ioctls with different register modes.
 * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage test.
 */
static void
do_register_ioctls_test(uffd_test_args_t *args, bool miss, bool wp, bool minor)
{
	uint64_t ioctls = 0, expected = BIT_ULL(_UFFDIO_WAKE);
	mem_type_t *mem_type = args->mem_type;
	int ret;

	ret = uffd_register_with_ioctls(uffd, area_dst, page_size,
					miss, wp, minor, &ioctls);

	/*
	 * Handle special cases of UFFDIO_REGISTER here where it should
	 * just fail with -EINVAL first..
	 *
	 * Case 1: register MINOR on anon
	 * Case 2: register with no mode selected
	 */
	if ((minor && (mem_type->mem_flag == MEM_ANON)) ||
	    (!miss && !wp && !minor)) {
		if (ret != -EINVAL)
			err("register (miss=%d, wp=%d, minor=%d) failed "
			    "with wrong errno=%d", miss, wp, minor, ret);
		return;
	}

	/* UFFDIO_REGISTER should succeed, then check ioctls returned */
	if (miss)
		expected |= BIT_ULL(_UFFDIO_COPY);
	if (wp)
		expected |= BIT_ULL(_UFFDIO_WRITEPROTECT);
	if (minor)
		expected |= BIT_ULL(_UFFDIO_CONTINUE);

	if ((ioctls & expected) != expected)
		err("unexpected uffdio_register.ioctls "
		    "(miss=%d, wp=%d, minor=%d): expected=0x%"PRIx64", "
		    "returned=0x%"PRIx64, miss, wp, minor, expected, ioctls);

	uffd_unregister(uffd, area_dst, page_size);
}

static void uffd_register_ioctls_test(uffd_test_args_t *args)
{
	int miss, wp, minor;

	for (miss = 0; miss <= 1; miss++)
		for (wp = 0; wp <= 1; wp++)
			for (minor = 0; minor <= 1; minor++)
				do_register_ioctls_test(args, miss, wp, minor);

	uffd_test_pass();
}
===8<===

Side note: the _UFFDIO_ZEROPAGE test will be left in the specific zeropage
test.

I considered moving get_expected_ioctls() rather than dropping in the same
patch, but that's just over-complicated when without the unit test
frameworks being ready.  I hope this addresses the concern here, otherwise
please shoot.

I've also attached the two patches that will test uffdio_register.ioctls as
a whole, just in case helpful for discussion before I post v2.

Thanks,

-- 
Peter Xu

--3Sb0bv4kXOGv7yMA
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-selftests-mm-Move-zeropage-test-into-uffd-unit-tests.patch"

From bea1534894c8edca4d7132c2d2676a9faf94a346 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 29 Mar 2023 16:34:15 -0400
Subject: [PATCH] selftests/mm: Move zeropage test into uffd unit tests

Simplifies it a bit along the way, e.g., drop the never used offset
field (which was always the 1st page so offset=0).

Introduce uffd_register_with_ioctls() out of uffd_register() to detect
uffdio_register.ioctls got returned.  Check that automatically when testing
UFFDIO_ZEROPAGE on different types of memory (and kernel).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-stress.c     | 94 +-------------------
 tools/testing/selftests/mm/uffd-unit-tests.c | 93 +++++++++++++++++++
 tools/testing/selftests/mm/vm_util.c         | 14 ++-
 tools/testing/selftests/mm/vm_util.h         |  2 +
 4 files changed, 108 insertions(+), 95 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index f3046ae13a90..a6f3609c1ad1 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -110,15 +110,6 @@ static inline uint64_t uffd_minor_feature(void)
 		return 0;
 }
 
-static int my_bcmp(char *str1, char *str2, size_t n)
-{
-	unsigned long i;
-	for (i = 0; i < n; i++)
-		if (str1[i] != str2[i])
-			return 1;
-	return 0;
-}
-
 static void *locking_thread(void *arg)
 {
 	unsigned long cpu = (unsigned long) arg;
@@ -274,89 +265,6 @@ static int stress(struct uffd_stats *uffd_stats)
 	return 0;
 }
 
-static void retry_uffdio_zeropage(int ufd,
-				  struct uffdio_zeropage *uffdio_zeropage,
-				  unsigned long offset)
-{
-	uffd_test_ops->alias_mapping(&uffdio_zeropage->range.start,
-				     uffdio_zeropage->range.len,
-				     offset);
-	if (ioctl(ufd, UFFDIO_ZEROPAGE, uffdio_zeropage)) {
-		if (uffdio_zeropage->zeropage != -EEXIST)
-			err("UFFDIO_ZEROPAGE error: %"PRId64,
-			    (int64_t)uffdio_zeropage->zeropage);
-	} else {
-		err("UFFDIO_ZEROPAGE error: %"PRId64,
-		    (int64_t)uffdio_zeropage->zeropage);
-	}
-}
-
-static int __uffdio_zeropage(int ufd, unsigned long offset)
-{
-	struct uffdio_zeropage uffdio_zeropage;
-	int ret;
-	bool has_zeropage = !(test_type == TEST_HUGETLB);
-	__s64 res;
-
-	if (offset >= nr_pages * page_size)
-		err("unexpected offset %lu", offset);
-	uffdio_zeropage.range.start = (unsigned long) area_dst + offset;
-	uffdio_zeropage.range.len = page_size;
-	uffdio_zeropage.mode = 0;
-	ret = ioctl(ufd, UFFDIO_ZEROPAGE, &uffdio_zeropage);
-	res = uffdio_zeropage.zeropage;
-	if (ret) {
-		/* real retval in ufdio_zeropage.zeropage */
-		if (has_zeropage)
-			err("UFFDIO_ZEROPAGE error: %"PRId64, (int64_t)res);
-		else if (res != -EINVAL)
-			err("UFFDIO_ZEROPAGE not -EINVAL");
-	} else if (has_zeropage) {
-		if (res != page_size) {
-			err("UFFDIO_ZEROPAGE unexpected size");
-		} else {
-			retry_uffdio_zeropage(ufd, &uffdio_zeropage,
-					      offset);
-			return 1;
-		}
-	} else
-		err("UFFDIO_ZEROPAGE succeeded");
-
-	return 0;
-}
-
-static int uffdio_zeropage(int ufd, unsigned long offset)
-{
-	return __uffdio_zeropage(ufd, offset);
-}
-
-/* exercise UFFDIO_ZEROPAGE */
-static int userfaultfd_zeropage_test(void)
-{
-	printf("testing UFFDIO_ZEROPAGE: ");
-	fflush(stdout);
-
-	uffd_test_ctx_init(0);
-
-	if (uffd_register(uffd, area_dst, nr_pages * page_size,
-			  true, test_uffdio_wp, false))
-		err("register failure");
-
-	if (area_dst_alias) {
-		/* Needed this to test zeropage-retry on shared memory */
-		if (uffd_register(uffd, area_dst_alias, nr_pages * page_size,
-				  true, test_uffdio_wp, false))
-			err("register failure");
-	}
-
-	if (uffdio_zeropage(uffd, 0))
-		if (my_bcmp(area_dst, zeropage, page_size))
-			err("zeropage is not zero");
-
-	printf("done.\n");
-	return 0;
-}
-
 static int userfaultfd_stress(void)
 {
 	void *area;
@@ -468,7 +376,7 @@ static int userfaultfd_stress(void)
 		uffd_stats_report(uffd_stats, nr_cpus);
 	}
 
-	return userfaultfd_zeropage_test();
+	return 0;
 }
 
 static void set_test_type(const char *type)
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 20fa73730b51..676edfdcbbe9 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -660,7 +660,100 @@ static void uffd_events_wp_test(void)
 	uffd_events_test_common(true);
 }
 
+static void retry_uffdio_zeropage(int ufd,
+				  struct uffdio_zeropage *uffdio_zeropage)
+{
+	uffd_test_ops->alias_mapping(&uffdio_zeropage->range.start,
+				     uffdio_zeropage->range.len,
+				     0);
+	if (ioctl(ufd, UFFDIO_ZEROPAGE, uffdio_zeropage)) {
+		if (uffdio_zeropage->zeropage != -EEXIST)
+			err("UFFDIO_ZEROPAGE error: %"PRId64,
+			    (int64_t)uffdio_zeropage->zeropage);
+	} else {
+		err("UFFDIO_ZEROPAGE error: %"PRId64,
+		    (int64_t)uffdio_zeropage->zeropage);
+	}
+}
+
+static bool do_uffdio_zeropage(int ufd, bool has_zeropage)
+{
+	struct uffdio_zeropage uffdio_zeropage = { 0 };
+	int ret;
+	__s64 res;
+
+	uffdio_zeropage.range.start = (unsigned long) area_dst;
+	uffdio_zeropage.range.len = page_size;
+	uffdio_zeropage.mode = 0;
+	ret = ioctl(ufd, UFFDIO_ZEROPAGE, &uffdio_zeropage);
+	res = uffdio_zeropage.zeropage;
+	if (ret) {
+		/* real retval in ufdio_zeropage.zeropage */
+		if (has_zeropage)
+			err("UFFDIO_ZEROPAGE error: %"PRId64, (int64_t)res);
+		else if (res != -EINVAL)
+			err("UFFDIO_ZEROPAGE not -EINVAL");
+	} else if (has_zeropage) {
+		if (res != page_size)
+			err("UFFDIO_ZEROPAGE unexpected size");
+		else
+			retry_uffdio_zeropage(ufd, &uffdio_zeropage);
+		return true;
+	} else
+		err("UFFDIO_ZEROPAGE succeeded");
+
+	return false;
+}
+
+/*
+ * Registers a range with MISSING mode only for zeropage test.  Return true
+ * if UFFDIO_ZEROPAGE supported, false otherwise. Can't use uffd_register()
+ * because we want to detect .ioctls along the way.
+ */
+static bool
+uffd_register_detect_zp(int uffd, void *addr, uint64_t len)
+{
+	uint64_t ioctls = 0;
+
+	if (uffd_register_with_ioctls(uffd, addr, len, true,
+				      false, false, &ioctls))
+		err("zeropage register fail");
+
+	return ioctls & (1 << _UFFDIO_ZEROPAGE);
+}
+
+/* exercise UFFDIO_ZEROPAGE */
+static void uffd_zeropage_test(void)
+{
+	bool has_zeropage;
+	int i;
+
+	has_zeropage = uffd_register_detect_zp(uffd, area_dst, page_size);
+	if (area_dst_alias)
+		/* Ignore the retval; we already have it */
+		uffd_register_detect_zp(uffd, area_dst_alias, page_size);
+
+	if (do_uffdio_zeropage(uffd, has_zeropage))
+		for (i = 0; i < page_size; i++)
+			if (area_dst[i] != 0)
+				err("data non-zero at offset %d\n", i);
+
+	if (uffd_unregister(uffd, area_dst, page_size))
+		err("unregister");
+
+	if (area_dst_alias && uffd_unregister(uffd, area_dst_alias, page_size))
+		err("unregister");
+
+	uffd_test_pass();
+}
+
 uffd_test_case_t uffd_tests[] = {
+	{
+		.name = "zeropage",
+		.uffd_fn = uffd_zeropage_test,
+		.mem_targets = MEM_ALL,
+		.uffd_feature_required = 0,
+	},
 	{
 		.name = "pagemap",
 		.uffd_fn = uffd_pagemap_test,
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index dad1f62a7ecd..6b2bc17efe13 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -198,8 +198,9 @@ unsigned long default_huge_page_size(void)
 	return hps;
 }
 
-int uffd_register(int uffd, void *addr, uint64_t len,
-		  bool miss, bool wp, bool minor)
+/* If `ioctls' non-NULL, the allowed ioctls will be returned into the var */
+int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
+			      bool miss, bool wp, bool minor, uint64_t *ioctls)
 {
 	struct uffdio_register uffdio_register = { 0 };
 	uint64_t mode = 0;
@@ -218,10 +219,19 @@ int uffd_register(int uffd, void *addr, uint64_t len,
 
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1)
 		ret = -errno;
+	else if (ioctls)
+		*ioctls = uffdio_register.ioctls;
 
 	return ret;
 }
 
+int uffd_register(int uffd, void *addr, uint64_t len,
+		  bool miss, bool wp, bool minor)
+{
+	return uffd_register_with_ioctls(uffd, addr, len,
+					 miss, wp, minor, NULL);
+}
+
 int uffd_unregister(int uffd, void *addr, uint64_t len)
 {
 	struct uffdio_range range = { .start = (uintptr_t)addr, .len = len };
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 634eb2f41145..b950bd16083a 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -52,6 +52,8 @@ int uffd_open_dev(unsigned int flags);
 int uffd_open_sys(unsigned int flags);
 int uffd_open(unsigned int flags);
 int uffd_get_features(uint64_t *features);
+int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
+			      bool miss, bool wp, bool minor, uint64_t *ioctls);
 
 /*
  * On ppc64 this will only work with radix 2M hugepage size
-- 
2.39.1


--3Sb0bv4kXOGv7yMA
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-selftests-mm-Add-uffdio-register-ioctls-test.patch"

From f575e3d26dedce19ef9790c2ac0a5e7e17bcf2bd Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 5 Apr 2023 14:20:18 -0400
Subject: [PATCH] selftests/mm: Add uffdio register ioctls test

This new test tests against the returned ioctls from UFFDIO_REGISTER, where
put into uffdio_register.ioctls.

This also tests the expected failure cases of UFFDIO_REGISTER, aka:

  - Register with empty mode should fail with -EINVAL
  - Register anon without page cache (anon) should fail with -EINVAL

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 111 ++++++++++++++++---
 1 file changed, 96 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 37a844bafe19..88968ed5f57d 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -62,8 +62,14 @@ mem_type_t mem_types[] = {
 	},
 };
 
+/* Arguments to be passed over to each uffd unit test */
+struct uffd_test_args {
+	mem_type_t *mem_type;
+};
+typedef struct uffd_test_args uffd_test_args_t;
+
 /* Returns: UFFD_TEST_* */
-typedef void (*uffd_test_fn)(void);
+typedef void (*uffd_test_fn)(uffd_test_args_t *);
 
 typedef struct {
 	const char *name;
@@ -172,8 +178,9 @@ static int test_uffd_api(bool use_dev)
  * This function initializes the global variables.  TODO: remove global
  * vars and then remove this.
  */
-static int uffd_setup_environment(uffd_test_case_t *test, mem_type_t *mem_type,
-				  const char **errmsg)
+static int
+uffd_setup_environment(uffd_test_args_t *args, uffd_test_case_t *test,
+		       mem_type_t *mem_type, const char **errmsg)
 {
 	map_shared = mem_type->shared;
 	uffd_test_ops = mem_type->mem_ops;
@@ -187,6 +194,9 @@ static int uffd_setup_environment(uffd_test_case_t *test, mem_type_t *mem_type,
 	/* TODO: remove this global var.. it's so ugly */
 	nr_cpus = 1;
 
+	/* Initialize test arguments */
+	args->mem_type = mem_type;
+
 	return uffd_test_ctx_init(test->uffd_feature_required, errmsg);
 }
 
@@ -239,7 +249,7 @@ static int pagemap_test_fork(bool present)
 	return result;
 }
 
-static void uffd_wp_unpopulated_test(void)
+static void uffd_wp_unpopulated_test(uffd_test_args_t *args)
 {
 	uint64_t value;
 	int pagemap_fd;
@@ -285,7 +295,7 @@ static void uffd_wp_unpopulated_test(void)
 	uffd_test_pass();
 }
 
-static void uffd_pagemap_test(void)
+static void uffd_pagemap_test(uffd_test_args_t *args)
 {
 	int pagemap_fd;
 	uint64_t value;
@@ -415,17 +425,17 @@ static void uffd_minor_test_common(bool test_collapse, bool test_wp)
 		uffd_test_pass();
 }
 
-void uffd_minor_test(void)
+void uffd_minor_test(uffd_test_args_t *args)
 {
 	uffd_minor_test_common(false, false);
 }
 
-void uffd_minor_wp_test(void)
+void uffd_minor_wp_test(uffd_test_args_t *args)
 {
 	uffd_minor_test_common(false, true);
 }
 
-void uffd_minor_collapse_test(void)
+void uffd_minor_collapse_test(uffd_test_args_t *args)
 {
 	uffd_minor_test_common(true, false);
 }
@@ -603,12 +613,12 @@ static void uffd_sigbus_test_common(bool wp)
 		uffd_test_pass();
 }
 
-static void uffd_sigbus_test(void)
+static void uffd_sigbus_test(uffd_test_args_t *args)
 {
 	uffd_sigbus_test_common(false);
 }
 
-static void uffd_sigbus_wp_test(void)
+static void uffd_sigbus_wp_test(uffd_test_args_t *args)
 {
 	uffd_sigbus_test_common(true);
 }
@@ -651,12 +661,12 @@ static void uffd_events_test_common(bool wp)
 		uffd_test_pass();
 }
 
-static void uffd_events_test(void)
+static void uffd_events_test(uffd_test_args_t *args)
 {
 	uffd_events_test_common(false);
 }
 
-static void uffd_events_wp_test(void)
+static void uffd_events_wp_test(uffd_test_args_t *args)
 {
 	uffd_events_test_common(true);
 }
@@ -724,7 +734,7 @@ uffd_register_detect_zp(int uffd, void *addr, uint64_t len)
 }
 
 /* exercise UFFDIO_ZEROPAGE */
-static void uffd_zeropage_test(void)
+static void uffd_zeropage_test(uffd_test_args_t *args)
 {
 	bool has_zeropage;
 	int i;
@@ -748,7 +758,76 @@ static void uffd_zeropage_test(void)
 	uffd_test_pass();
 }
 
+/*
+ * Test the returned uffdio_register.ioctls with different register modes.
+ * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage test.
+ */
+static void
+do_register_ioctls_test(uffd_test_args_t *args, bool miss, bool wp, bool minor)
+{
+	uint64_t ioctls = 0, expected = BIT_ULL(_UFFDIO_WAKE);
+	mem_type_t *mem_type = args->mem_type;
+	int ret;
+
+	ret = uffd_register_with_ioctls(uffd, area_dst, page_size,
+					miss, wp, minor, &ioctls);
+
+	/*
+	 * Handle special cases of UFFDIO_REGISTER here where it should
+	 * just fail with -EINVAL first..
+	 *
+	 * Case 1: register MINOR on anon
+	 * Case 2: register with no mode selected
+	 */
+	if ((minor && (mem_type->mem_flag == MEM_ANON)) ||
+	    (!miss && !wp && !minor)) {
+		if (ret != -EINVAL)
+			err("register (miss=%d, wp=%d, minor=%d) failed "
+			    "with wrong errno=%d", miss, wp, minor, ret);
+		return;
+	}
+
+	/* UFFDIO_REGISTER should succeed, then check ioctls returned */
+	if (miss)
+		expected |= BIT_ULL(_UFFDIO_COPY);
+	if (wp)
+		expected |= BIT_ULL(_UFFDIO_WRITEPROTECT);
+	if (minor)
+		expected |= BIT_ULL(_UFFDIO_CONTINUE);
+
+	if ((ioctls & expected) != expected)
+		err("unexpected uffdio_register.ioctls "
+		    "(miss=%d, wp=%d, minor=%d): expected=0x%"PRIx64", "
+		    "returned=0x%"PRIx64, miss, wp, minor, expected, ioctls);
+
+	uffd_unregister(uffd, area_dst, page_size);
+}
+
+static void uffd_register_ioctls_test(uffd_test_args_t *args)
+{
+	int miss, wp, minor;
+
+	for (miss = 0; miss <= 1; miss++)
+		for (wp = 0; wp <= 1; wp++)
+			for (minor = 0; minor <= 1; minor++)
+				do_register_ioctls_test(args, miss, wp, minor);
+
+	uffd_test_pass();
+}
+
 uffd_test_case_t uffd_tests[] = {
+	{
+		/* Test returned uffdio_register.ioctls. */
+		.name = "register-ioctls",
+		.uffd_fn = uffd_register_ioctls_test,
+		.mem_targets = MEM_ALL,
+		.uffd_feature_required = UFFD_FEATURE_MISSING_HUGETLBFS |
+		UFFD_FEATURE_MISSING_SHMEM |
+		UFFD_FEATURE_PAGEFAULT_FLAG_WP |
+		UFFD_FEATURE_WP_HUGETLBFS_SHMEM |
+		UFFD_FEATURE_MINOR_HUGETLBFS |
+		UFFD_FEATURE_MINOR_SHMEM,
+	},
 	{
 		.name = "zeropage",
 		.uffd_fn = uffd_zeropage_test,
@@ -835,6 +914,7 @@ int main(int argc, char *argv[])
 	int n_mems = sizeof(mem_types) / sizeof(mem_type_t);
 	uffd_test_case_t *test;
 	mem_type_t *mem_type;
+	uffd_test_args_t args;
 	char test_name[128];
 	const char *errmsg;
 	int has_uffd;
@@ -862,11 +942,12 @@ int main(int argc, char *argv[])
 				uffd_test_skip("feature missing");
 				continue;
 			}
-			if (uffd_setup_environment(test, mem_type, &errmsg)) {
+			if (uffd_setup_environment(&args, test, mem_type,
+						   &errmsg)) {
 				uffd_test_skip(errmsg);
 				continue;
 			}
-			test->uffd_fn();
+			test->uffd_fn(&args);
 		}
 	}
 
-- 
2.39.1


--3Sb0bv4kXOGv7yMA--

