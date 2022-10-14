Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5E05FF07C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiJNOkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiJNOkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2C950BB7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665758417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iDP4uYCeHzqEOaCGXbcAwOcK1rZC2BBuQ6aTX5fgU3w=;
        b=aJ/1qwubn0CASPVpRYd8b13X7iD65tWPi7YQDqLQvYOT/xBA19IK0tF5IXrql57THycRlJ
        E4Qveg/106Z35UMsWtplpaR6sLvhhBV9vIpn2HIamd4VEr//rqF1w18XrXeygNEE7qQHwp
        SEP9S7XZzFpwsa9LniWg3trPKGH4F4k=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-437-UtZ32APbMee-iw_SH0NmFQ-1; Fri, 14 Oct 2022 10:40:16 -0400
X-MC-Unique: UtZ32APbMee-iw_SH0NmFQ-1
Received: by mail-qk1-f200.google.com with SMTP id w13-20020a05620a424d00b006e833c4fb0dso3587391qko.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDP4uYCeHzqEOaCGXbcAwOcK1rZC2BBuQ6aTX5fgU3w=;
        b=2+1Br4UPiU60QR9Q/vlNsF67WZHX0tv1Nxtv0iacy4FNmd+0FMVir7nyJ6Ay85HppI
         zG6Dmfoa9ML5M6sRTltPF5K6ue2QDq5fr+K7TC0aflDD6rThQNtIE8ZE5JHsBw7e3UbJ
         cmYCQkA0XTn2GBkaNq4FqAYOEf2axwSWr01/AIt35P0r0CeTqI7RGQhj/tX3XPZS4UMH
         JhvZGx3V6gpRcntdaThGYvqWId1xgnIa9igMvaL8pDrWOUUDoMSL+wsAZW6ullR0k4nK
         oQrcoZTVLXpU3ozfYlgo0MMXi3lIvPjpGwFfqxNerpkO60oTZLVymBTJ98A86k8EFCUq
         ryrg==
X-Gm-Message-State: ACrzQf0drtMt72lqs1iNHZJPZVpNQOeqYQkOPE+TOKFFtqIeGVT0twQK
        Hg3X5jL97PE44CNKHxftBFrHwGL3biqwvjG3X+RTTYmE7MGMRL5RHCT1OvcLonpgptNDR2kfsUV
        ztxlWAPy3ZmlVugEZpK90wJF38RajkylmIkmw40V+dqF94AufAuKDdJHJvvDYL0hJK4ZmXr6j9g
        ==
X-Received: by 2002:a37:c85:0:b0:6ed:4a79:fc66 with SMTP id 127-20020a370c85000000b006ed4a79fc66mr4006758qkm.433.1665758415401;
        Fri, 14 Oct 2022 07:40:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6IfO7EVM9SoCYkoTimioBOx4Rp2krEuu3nGfkA84AP3QQ2Bab1uDw6m7lhGlL2PHeYZ7hQHQ==
X-Received: by 2002:a37:c85:0:b0:6ed:4a79:fc66 with SMTP id 127-20020a370c85000000b006ed4a79fc66mr4006731qkm.433.1665758415046;
        Fri, 14 Oct 2022 07:40:15 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id d75-20020ae9ef4e000000b006ed61f18651sm2503120qkg.16.2022.10.14.07.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 07:40:14 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 3/4] selftests/vm: Use memfd for hugepage-mremap test
Date:   Fri, 14 Oct 2022 10:40:13 -0400
Message-Id: <20221014144013.94027-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221014143921.93887-1-peterx@redhat.com>
References: <20221014143921.93887-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For dropping the hugetlb mountpoint in run_vmtests.sh.  Cleaned it up a
little bit around the changed codes.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/hugepage-mremap.c | 21 +++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
index e63a0214f639..e53b5eaa8fce 100644
--- a/tools/testing/selftests/vm/hugepage-mremap.c
+++ b/tools/testing/selftests/vm/hugepage-mremap.c
@@ -22,6 +22,7 @@
 #include <sys/syscall.h> /* Definition of SYS_* constants */
 #include <linux/userfaultfd.h>
 #include <sys/ioctl.h>
+#include <string.h>
 
 #define DEFAULT_LENGTH_MB 10UL
 #define MB_TO_BYTES(x) (x * 1024 * 1024)
@@ -108,26 +109,23 @@ static void register_region_with_uffd(char *addr, size_t len)
 int main(int argc, char *argv[])
 {
 	size_t length = 0;
+	int ret = 0, fd;
 
-	if (argc != 2 && argc != 3) {
-		printf("Usage: %s [length_in_MB] <hugetlb_file>\n", argv[0]);
+	if (argc >= 2 && !strcmp(argv[1], "-h")) {
+		printf("Usage: %s [length_in_MB]\n", argv[0]);
 		exit(1);
 	}
 
 	/* Read memory length as the first arg if valid, otherwise fallback to
 	 * the default length.
 	 */
-	if (argc == 3)
-		length = argc > 2 ? (size_t)atoi(argv[1]) : 0UL;
+	if (argc >= 2)
+		length = (size_t)atoi(argv[1]);
+	else
+		length = DEFAULT_LENGTH_MB;
 
-	length = length > 0 ? length : DEFAULT_LENGTH_MB;
 	length = MB_TO_BYTES(length);
-
-	int ret = 0;
-
-	/* last arg is the hugetlb file name */
-	int fd = open(argv[argc-1], O_CREAT | O_RDWR, 0755);
-
+	fd = memfd_create(argv[0], MFD_HUGETLB);
 	if (fd < 0) {
 		perror("Open failed");
 		exit(1);
@@ -185,7 +183,6 @@ int main(int argc, char *argv[])
 	}
 
 	close(fd);
-	unlink(argv[argc-1]);
 
 	return ret;
 }
-- 
2.37.3

