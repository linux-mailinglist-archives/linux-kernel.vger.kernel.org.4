Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3732E6D0AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjC3QJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjC3QJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0643E9750
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pi0McrG33VvWSi8wJEF+ZnP9lqDjRKaT61ZsjgmAIPc=;
        b=F9IXHLTFLdcQKC63lniv1YDIfcAb6eJR7uE7mjdCPkaqoANI/7KKPooaudFIIv6PZ0wEDx
        w+NoQZlMv77QpxXHga0GGWmEp6ABAVi7yEawfL+b6s9mcDTydOeyGiKn2n7y1vyUUaTsr5
        Ph3X0FA0xtsBdZubHCUuNkfncq1/FHQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-9gAKRPr7O2euqJG7T0FH3w-1; Thu, 30 Mar 2023 12:07:59 -0400
X-MC-Unique: 9gAKRPr7O2euqJG7T0FH3w-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-57c67ea348eso12977546d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi0McrG33VvWSi8wJEF+ZnP9lqDjRKaT61ZsjgmAIPc=;
        b=Swl9kX6rCafUUpSaIbWgytBvrWd24CSK7RQfs/T3dITrEglgl1ByKCoxP2GPphLRaY
         L1vEpfJp3GsEOW1dsd/VzV9V9CXuDxtzvo3AQYxzKAyLgA7JFqZubkeLqbuAweY4OG6F
         N7z524+QaXlGEWsv1QKf0v+G8V1Eg08MsNuJDdJR69UPK5+OzpteBZ5Fxcsw/5+P0rWe
         Ln5INGfWe5bCqPbODa4VNS8XncGAvzsZHFDDJn87wXfk0oiBVMRk2/DV3aYIK6kxyiOb
         h4FA0UUPaaea0FlwyAoT61GA8RvxpwjaXFNY3zK337rdyIR/dZ3gL1sk4n2rwkJ6TgKp
         +/Fg==
X-Gm-Message-State: AAQBX9eC+INKDjmE9IKswrDP2HxyJbRBU5R1zw+1ePj6w2sE6kK8Wq+q
        BsqAsSzbW/D1alGAia+d0oW5J3apAH05xORQLG7XWZVfAz72K9qBDDI6UzMTG7xdoN35bJ4dRnZ
        gm0TJTF53cXwVSXdf8rgtXCHE
X-Received: by 2002:a05:6214:528f:b0:5a5:e941:f33d with SMTP id kj15-20020a056214528f00b005a5e941f33dmr3649471qvb.3.1680192475183;
        Thu, 30 Mar 2023 09:07:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y+5Of9BQ51FgDOPQFkGMpVhdWP6DIaYdi2MOHzvLJbq+jW3Pu9yxIViDQt4nTW5eY4voEBhg==
X-Received: by 2002:a05:6214:528f:b0:5a5:e941:f33d with SMTP id kj15-20020a056214528f00b005a5e941f33dmr3649415qvb.3.1680192474610;
        Thu, 30 Mar 2023 09:07:54 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id bl28-20020a05620a1a9c00b007339c5114a9sm19630391qkb.103.2023.03.30.09.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:07:53 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 16/29] selftests/mm: UFFDIO_API test
Date:   Thu, 30 Mar 2023 12:07:52 -0400
Message-Id: <20230330160752.3107283-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230330155707.3106228-1-peterx@redhat.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one simple test for UFFDIO_API.  With that, I also added a bunch of
small but handy helpers along the way.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 111 ++++++++++++++++++-
 tools/testing/selftests/mm/vm_util.c         |  10 ++
 2 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 6857388783be..dfb44ffad5f5 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -9,9 +9,118 @@
 
 #ifdef __NR_userfaultfd
 
+struct {
+	unsigned int pass, skip, fail, total;
+} uffd_test_acct;
+
+static void uffd_test_report(void)
+{
+	printf("Userfaults unit tests: pass=%u, skip=%u, fail=%u (total=%u)\n",
+	       uffd_test_acct.pass,
+	       uffd_test_acct.skip,
+	       uffd_test_acct.fail,
+	       uffd_test_acct.total);
+}
+
+static void uffd_test_pass(void)
+{
+	printf("done\n");
+	uffd_test_acct.pass++;
+}
+
+#define  uffd_test_start(...)  do {		\
+		printf(__VA_ARGS__);		\
+		printf("... ");			\
+		uffd_test_acct.total++;		\
+	} while (0)
+
+#define  uffd_test_fail(...)  do {		\
+		printf("failed [reason: ");	\
+		printf(__VA_ARGS__);		\
+		printf("]\n");			\
+		uffd_test_acct.fail++;		\
+	} while (0)
+
+#define  uffd_test_skip(...)  do {		\
+		printf("skipped [reason: ");	\
+		printf(__VA_ARGS__);		\
+		printf("]\n");			\
+		uffd_test_acct.skip++;		\
+	} while (0)
+
+/*
+ * Returns 1 if specific userfaultfd supported, 0 otherwise.  Note, we'll
+ * return 1 even if some test failed as long as uffd supported, because in
+ * that case we still want to proceed with the rest uffd unit tests.
+ */
+static int test_uffd_api(bool use_dev)
+{
+	struct uffdio_api uffdio_api;
+	int uffd;
+
+	uffd_test_start("UFFDIO_API (with %s)",
+			use_dev ? "/dev/userfaultfd" : "syscall");
+
+	if (use_dev)
+		uffd = uffd_open_dev(UFFD_FLAGS);
+	else
+		uffd = uffd_open_sys(UFFD_FLAGS);
+	if (uffd < 0) {
+		uffd_test_skip("cannot open userfaultfd handle");
+		return 0;
+	}
+
+	/* Test wrong UFFD_API */
+	uffdio_api.api = 0xab;
+	uffdio_api.features = 0;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == 0) {
+		uffd_test_fail("UFFDIO_API should fail with wrong api but didn't");
+		goto out;
+	}
+
+	/* Test wrong feature bit */
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = BIT_ULL(63);
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == 0) {
+		uffd_test_fail("UFFDIO_API should fail with wrong feature but didn't");
+		goto out;
+	}
+
+	/* Test normal UFFDIO_API */
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api)) {
+		uffd_test_fail("UFFDIO_API should succeed but failed");
+		goto out;
+	}
+
+	/* Test double requests of UFFDIO_API with a random feature set */
+	uffdio_api.features = BIT_ULL(0);
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == 0) {
+		uffd_test_fail("UFFDIO_API should reject initialized uffd");
+		goto out;
+	}
+
+	uffd_test_pass();
+out:
+	close(uffd);
+	/* We have a valid uffd handle */
+	return 1;
+}
+
 int main(int argc, char *argv[])
 {
-	return KSFT_PASS;
+	int has_uffd;
+
+	has_uffd = test_uffd_api(false);
+	has_uffd |= test_uffd_api(true);
+
+	if (!has_uffd) {
+		printf("Userfaultfd not supported or unprivileged, skip all tests\n");
+		exit(KSFT_SKIP);
+	}
+	uffd_test_report();
+	return uffd_test_acct.fail ? KSFT_FAIL : KSFT_PASS;
 }
 
 #else /* __NR_userfaultfd */
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 7c2bf88d6393..62fcf039d6b7 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -254,3 +254,13 @@ int uffd_open_sys(unsigned int flags)
 	return -1;
 #endif
 }
+
+int uffd_open(unsigned int flags)
+{
+	int uffd = uffd_open_sys(flags);
+
+	if (uffd < 0)
+		uffd = uffd_open_dev(flags);
+
+	return uffd;
+}
-- 
2.39.1

