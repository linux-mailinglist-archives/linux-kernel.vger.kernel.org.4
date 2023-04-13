Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE6E6E17ED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjDMXMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjDMXM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:12:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1188646A9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681427492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VlJAJroC0qfUjlayNMIBwxZydfuRD55bTGjabDZPAD4=;
        b=TnBSw08Ofe1FonYiJSbfR0l2EnYAnj0MC03K3hIMQ7u/rsHxBEbHEO7fpGjD4/HqeukUNk
        /nbKPWVovu7TqS5fgBwKVnGpBpIos5UokhNOXLKWKU1+Dbry8BBRIsLTehBq7CU1EbPDpT
        dVTP+33iie9nYpb0wx2yB4Q0sdEeG5w=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-EEkusKa8NRmbUY7Hswl6Vw-1; Thu, 13 Apr 2023 19:11:30 -0400
X-MC-Unique: EEkusKa8NRmbUY7Hswl6Vw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3eab4df3ef0so822621cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681427489; x=1684019489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlJAJroC0qfUjlayNMIBwxZydfuRD55bTGjabDZPAD4=;
        b=hP5pKlwPXgKbzIf6pKd1YPKN0Hr7s1y41L4kGCihHGx9DPQD0CZnA9OqhqEihJkrXA
         kFCPxAKyBw8oZaRykJOcfoy2GLlxzh9Oahvppt4i6wKS7Pxo807PIATTeC0bDaFHAsAB
         PiQoC+w1Zri2ORwo5e5KzF83D6CI6+mVkaQsGoKTervgh+8NqTHe8VKIIoO8BvtDyONr
         3trs3+XLnofzqYCnCJa4JdUxhpEjl6PJYTOjHK4aIuEq3JK938DyV+MmkmG6/Pey93IC
         7xPDC2AjDirba/HSsMBH7pVPNSdsi52Mjxjx3ESOovH0MrRbI7TxNY///ZIHkUbl9r43
         E3Wg==
X-Gm-Message-State: AAQBX9fSRb5kJ5jtbMo0L95umcnBa2oUQ9uuHYHOsqgDOy2BcBf+l0lj
        dq3ggk04mwVXonclbz0LZpT3IR+Fs+gJaOEppZTE/V+uT7LVLStvBtn1W8ymXOr68I1jc6nRTc/
        BGOaccffjq8Y4mfWBCGmGqGIEluG6au6dXwJDfYi3HHTyDsmeteswtttwhlns3gyLHASR7R5Bgg
        21cp3D6A==
X-Received: by 2002:a05:622a:1a0b:b0:3e6:3af1:de7a with SMTP id f11-20020a05622a1a0b00b003e63af1de7amr979948qtb.4.1681427489625;
        Thu, 13 Apr 2023 16:11:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350an97YBpu5VR+5rQ8BpvcSWa0qXKTYAqU3oGcgNxCkPHbBxgc6lQQadGX+kjho8InyBO8r1YA==
X-Received: by 2002:a05:622a:1a0b:b0:3e6:3af1:de7a with SMTP id f11-20020a05622a1a0b00b003e63af1de7amr979903qtb.4.1681427489278;
        Thu, 13 Apr 2023 16:11:29 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id g3-20020ac81243000000b003ea1b97acfasm612446qtj.49.2023.04.13.16.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:11:28 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH 3/6] selftests/mm: Add a few options for uffd-unit-test
Date:   Thu, 13 Apr 2023 19:11:17 -0400
Message-Id: <20230413231120.544685-4-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230413231120.544685-1-peterx@redhat.com>
References: <20230413231120.544685-1-peterx@redhat.com>
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

Namely:

  "-f": add a wildcard filter for tests to run
  "-l": list tests rather than running any
  "-h": help msg

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 52 +++++++++++++++++---
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index d871bf732e62..452ca05a829d 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -909,28 +909,65 @@ uffd_test_case_t uffd_tests[] = {
 	},
 };
 
+static void usage(const char *prog)
+{
+	printf("usage: %s [-f TESTNAME]\n", prog);
+	puts("");
+	puts(" -f: test name to filter (e.g., event)");
+	puts(" -h: show the help msg");
+	puts(" -l: list tests only");
+	puts("");
+	exit(KSFT_FAIL);
+}
+
 int main(int argc, char *argv[])
 {
 	int n_tests = sizeof(uffd_tests) / sizeof(uffd_test_case_t);
 	int n_mems = sizeof(mem_types) / sizeof(mem_type_t);
+	const char *test_filter = NULL;
+	bool list_only = false;
 	uffd_test_case_t *test;
 	mem_type_t *mem_type;
 	uffd_test_args_t args;
 	char test_name[128];
 	const char *errmsg;
-	int has_uffd;
+	int has_uffd, opt;
 	int i, j;
 
-	has_uffd = test_uffd_api(false);
-	has_uffd |= test_uffd_api(true);
+	while ((opt = getopt(argc, argv, "f:hl")) != -1) {
+		switch (opt) {
+		case 'f':
+			test_filter = optarg;
+			break;
+		case 'l':
+			list_only = true;
+			break;
+		case 'h':
+		default:
+			/* Unknown */
+			usage(argv[0]);
+			break;
+		}
+	}
+
+	if (!test_filter && !list_only) {
+		has_uffd = test_uffd_api(false);
+		has_uffd |= test_uffd_api(true);
 
-	if (!has_uffd) {
-		printf("Userfaultfd not supported or unprivileged, skip all tests\n");
-		exit(KSFT_SKIP);
+		if (!has_uffd) {
+			printf("Userfaultfd not supported or unprivileged, skip all tests\n");
+			exit(KSFT_SKIP);
+		}
 	}
 
 	for (i = 0; i < n_tests; i++) {
 		test = &uffd_tests[i];
+		if (test_filter && !strstr(test->name, test_filter))
+			continue;
+		if (list_only) {
+			printf("%s\n", test->name);
+			continue;
+		}
 		for (j = 0; j < n_mems; j++) {
 			mem_type = &mem_types[j];
 			if (!(test->mem_targets & mem_type->mem_flag))
@@ -952,7 +989,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	uffd_test_report();
+	if (!list_only)
+		uffd_test_report();
 
 	return ksft_get_fail_cnt() ? KSFT_FAIL : KSFT_PASS;
 }
-- 
2.39.1

