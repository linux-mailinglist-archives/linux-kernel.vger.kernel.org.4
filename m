Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAE36E5143
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjDQTyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjDQTyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C40B49DE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681761209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VlJAJroC0qfUjlayNMIBwxZydfuRD55bTGjabDZPAD4=;
        b=ZP/rrgSoE8H9BWi3SPbjCRHnruOYAOKmECWWGBS7em4hapH1bU7Oqr/XeGCDTbsTf+iJ8d
        v3YYFvtsDL2Z5avJZYs/N1aJuNkWGuEMNlPsZmPnkZRywhVuDHjU//+aAZY9RHocslZfQL
        Hb4nFryoUJ2xGvroq0l5JKHQ1fsSRi0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-kbxCxsszMya_WNCi-f4CHQ-1; Mon, 17 Apr 2023 15:53:28 -0400
X-MC-Unique: kbxCxsszMya_WNCi-f4CHQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3ed767b30easo1905071cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681761207; x=1684353207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlJAJroC0qfUjlayNMIBwxZydfuRD55bTGjabDZPAD4=;
        b=PEpzUxSrViaNRRpWeADN++C5Yj7jF5lN2MbPOyE/58Yy74CJWc6I3QqFDsrtK8H40l
         16FNG62byDuMgl6bMa7vs30ICmcriVrGaeYe7mc8gWCf56L7TbbDNDBbI2/Soorb0Rgb
         kZjTKjGxtDrZhozfoK7jvw9BAPNvpAtML9kPESwETQx/8XsZHizLbqjSH7bfIP6sn6K4
         QAfzB7/5rJZJQL021aWy/NUb1S1LTDyxfMVTXTC4LQW/hTbh+CSJkb5fEvp6HeC/pqDi
         pfF7OHd0jmjKLXCsyWmnxOwMY6CnRaASwdz2c6tiYgKbjbkiIlzWv0guCXMV6TVzZyRd
         W5NQ==
X-Gm-Message-State: AAQBX9cecB4SpY42T/z5V2sN5dSRKCs7donLG+cQqvJXHyVwKiadjVdi
        mYMPE8+azsOgR7XPJdEsQK5PkP36dy64Pe5EYdzXLmqcfgLc+xzZLbLggfUQgYsEZfSuwSsmlEF
        YyGswNywh00Mb2Xcy8/zflQYQMfVzX65O82yPDkJSOCUAgXlXVLSVHDJvz9reXOTQhCaSWvaQAz
        ey6aeANA==
X-Received: by 2002:ac8:4e43:0:b0:3bf:cf77:a861 with SMTP id e3-20020ac84e43000000b003bfcf77a861mr19130150qtw.4.1681761206873;
        Mon, 17 Apr 2023 12:53:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350atiTLtabqgcPaZB1CQI3pkzcoQyHjGkW0AJzAmgZF9tCzczfoqxlZpXO4VXi+keofELA+BDw==
X-Received: by 2002:ac8:4e43:0:b0:3bf:cf77:a861 with SMTP id e3-20020ac84e43000000b003bfcf77a861mr19130115qtw.4.1681761206528;
        Mon, 17 Apr 2023 12:53:26 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id r17-20020ac87ef1000000b003edfb5d7637sm1731278qtc.73.2023.04.17.12.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:53:25 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 3/6] selftests/mm: Add a few options for uffd-unit-test
Date:   Mon, 17 Apr 2023 15:53:14 -0400
Message-Id: <20230417195317.898696-4-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230417195317.898696-1-peterx@redhat.com>
References: <20230417195317.898696-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

