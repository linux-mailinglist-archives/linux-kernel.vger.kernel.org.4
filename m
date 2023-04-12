Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063FA6DFB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjDLQod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjDLQoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:44:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399C57D93
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2X1citdDCADI79RLi2EG2irLSOXCvsNG1ixWpJWId4=;
        b=DlSVK8f9fdO4B4EsZhwD2K8UIyVGkTCFAaeglPjvOAwQY9/RrpOkyrMPUcSps5cA4N/WHQ
        /AJCuGwWDnqC0Fzvx1txUQ58j6JcCPHvfTH6JeYQU19/ionDTmWwPPvRSXXKVCX7D745qO
        vYmovK0mBqf8QFw7OqtLG6DWSO1T12Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-Kxfkd2onM26Psee6YroXEw-1; Wed, 12 Apr 2023 12:43:05 -0400
X-MC-Unique: Kxfkd2onM26Psee6YroXEw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3e63ec50808so4676541cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317780; x=1683909780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2X1citdDCADI79RLi2EG2irLSOXCvsNG1ixWpJWId4=;
        b=Nq/6nol0EX9ogSzB5Bt8cZdTlx89dOCmuCAgB1SdexzyDqCBZokM7OH/nXXmQqAjfg
         UggDq36oXPhEJkQ0l4zGbCxtraNxkGmfLmpBsKOO5JgRT9bDBaPDCBRBd9VN97P0es1k
         Gbo7MMbDlAI0Y6FM57GDwVtZBHUpE2Im+buDb5pyh3DtVdojpm3/lDpvITqLbOhO2xHt
         cGgeLyLgXjG1Wkx310XOEkxKB1gW6Tlwr9Gc1K3g7i5cPbbpPhomOOFnCes85yDQ8BKA
         Dm6yqsZrZNJSrWAQIMRpdySu11N9/UWm8IRbKauP0BMAmIlRq/oxhU25unuF4J04moUP
         3nmw==
X-Gm-Message-State: AAQBX9eQxzG/tM1iwkG/0FpmrrAVMiKAwq6AH3QHW7JnUgX8gprYttep
        6fHx20yWWvAnMwINmOp3kfE6Bc35BcFSdQTcpww7BfVwnGWgDJEKUcj7dR46uVAga9Rg5oJ09h2
        OdJGmPQW3cCrsc/f+MANeFp99egod/FTWC8IHIp+CsgoAIqhSa0F8lH7sbvAh/R34rU/zncqmFR
        VpYhQJAw==
X-Received: by 2002:a05:622a:189a:b0:3d1:16f4:ae58 with SMTP id v26-20020a05622a189a00b003d116f4ae58mr31197658qtc.2.1681317780631;
        Wed, 12 Apr 2023 09:43:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350aPP59fS6v/hiPCzvysroXh8Pq2l2mHvfmOO33uNBWw/uqCl3sAmpEBcvmZzo74rNrgkQNwyQ==
X-Received: by 2002:a05:622a:189a:b0:3d1:16f4:ae58 with SMTP id v26-20020a05622a189a00b003d116f4ae58mr31197613qtc.2.1681317780186;
        Wed, 12 Apr 2023 09:43:00 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id p9-20020a05620a22e900b007486d9fa1d7sm4786784qki.95.2023.04.12.09.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:42:59 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        peterx@redhat.com
Subject: [PATCH v2 16/31] selftests/mm: UFFDIO_API test
Date:   Wed, 12 Apr 2023 12:42:57 -0400
Message-Id: <20230412164257.328375-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230412163922.327282-1-peterx@redhat.com>
References: <20230412163922.327282-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
 tools/testing/selftests/mm/uffd-unit-tests.c | 109 ++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 6857388783be..bb492c258486 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -9,9 +9,116 @@
 
 #ifdef __NR_userfaultfd
 
+static void uffd_test_report(void)
+{
+	printf("Userfaults unit tests: pass=%u, skip=%u, fail=%u (total=%u)\n",
+	       ksft_get_pass_cnt(),
+	       ksft_get_xskip_cnt(),
+	       ksft_get_fail_cnt(),
+	       ksft_test_num());
+}
+
+static void uffd_test_pass(void)
+{
+	printf("done\n");
+	ksft_inc_pass_cnt();
+}
+
+#define  uffd_test_start(...)  do {		\
+		printf("Testing ");		\
+		printf(__VA_ARGS__);		\
+		printf("... ");			\
+		fflush(stdout);			\
+	} while (0)
+
+#define  uffd_test_fail(...)  do {		\
+		printf("failed [reason: ");	\
+		printf(__VA_ARGS__);		\
+		printf("]\n");			\
+		ksft_inc_fail_cnt();		\
+	} while (0)
+
+#define  uffd_test_skip(...)  do {		\
+		printf("skipped [reason: ");	\
+		printf(__VA_ARGS__);		\
+		printf("]\n");			\
+		ksft_inc_xskip_cnt();		\
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
+
+	return ksft_get_fail_cnt() ? KSFT_FAIL : KSFT_PASS;
 }
 
 #else /* __NR_userfaultfd */
-- 
2.39.1

