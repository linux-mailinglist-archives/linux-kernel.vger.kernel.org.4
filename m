Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2E15FF075
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiJNOjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJNOj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A61B1D4DE7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665758367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhrtCe5O8iJscoLdf85Accar6WxcllS+eYr7bBy1HkM=;
        b=gtdPCQsofa7kHijNmmurBxhr/APJhIXVcNkZGAICAgJzsqN8S/KYZw8zO/ZVAZh19ZVc0H
        NeMb4fZxaw3zIiKsAZkrtL62b+FEnrh+/YSzx77cKfwLqSZoywohaqXv6peouxWspVaxEs
        qJ6aF9gJul5lj9NBGKPAXkANnUTjDNE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-339-p1WeIEz_M_CFSrXw6Tm80g-1; Fri, 14 Oct 2022 10:39:26 -0400
X-MC-Unique: p1WeIEz_M_CFSrXw6Tm80g-1
Received: by mail-qk1-f197.google.com with SMTP id az32-20020a05620a172000b006ee8ae138a7so3594407qkb.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhrtCe5O8iJscoLdf85Accar6WxcllS+eYr7bBy1HkM=;
        b=g4VKWBHrZvqNyr2VGAzGCLM7kL+U6/eLN8CQ9BXeT67l2RRgg1SUE+HY9GffFf8Iue
         DHwowud44HkwRdlsBbtQsw0SE7HBYUMObE+uTA1sKMTp4jDlclYNplZqWDpoZ4IrO2kB
         H0VmPOltvQJp2AntD9mFzG5+EgFwgJ7GZOudhCh4V9C1/KrKxDB5lHZcuTu80JEeXPIg
         M5Xs8TQVzl2hrFpDgSDwx+hHwKAguHnwIHkOLlye8qt0HkeJlVxD4uOo6m44Xb4g993n
         295+kUeDBgDj5h0Q+kvMcgrBsjZQlaI6S8CfzVuaoAqYDDTGN2E2a8+DZH7/rA2KuCGB
         mD1g==
X-Gm-Message-State: ACrzQf1zz+88uePPogAIUi7yBcAl98fyRRrgGM/hLsFSMvJ5yP7CqHoS
        SetPN0lATx49BRB9NIIKJoUkelC0iJ9XdDngouXyxKL2xOMCcpskEJitaoL7v/7MMMgXZ8xIX+J
        w6z/1dfS2OwLKkiD41cxrXVMbQ/wDeqTf54+WjN3PhqY/wgIfs/XvdLHKgEUAEL5Q3k+IuxgZiQ
        ==
X-Received: by 2002:a05:620a:4487:b0:6ee:bcfd:bd38 with SMTP id x7-20020a05620a448700b006eebcfdbd38mr3958894qkp.468.1665758365599;
        Fri, 14 Oct 2022 07:39:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Sm2N0MTTyvS+djMYYsPheIDh6qYStLP75xZfMOIeKo1yJ56X446Gqke44gOKPwhPm9ANfZA==
X-Received: by 2002:a05:620a:4487:b0:6ee:bcfd:bd38 with SMTP id x7-20020a05620a448700b006eebcfdbd38mr3958866qkp.468.1665758365343;
        Fri, 14 Oct 2022 07:39:25 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q4-20020a05620a2a4400b006ec09d7d357sm2675541qkp.47.2022.10.14.07.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 07:39:24 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 2/4] selftests/vm: Use memfd for hugetlb-madvise test
Date:   Fri, 14 Oct 2022 10:39:19 -0400
Message-Id: <20221014143921.93887-3-peterx@redhat.com>
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

For dropping the hugetlb mountpoint in run_vmtests.sh.  Since no parameter
is needed, drop USAGE too.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/hugetlb-madvise.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/vm/hugetlb-madvise.c b/tools/testing/selftests/vm/hugetlb-madvise.c
index 3c9943131881..f96435b70986 100644
--- a/tools/testing/selftests/vm/hugetlb-madvise.c
+++ b/tools/testing/selftests/vm/hugetlb-madvise.c
@@ -12,6 +12,7 @@
  * directory.
  */
 
+#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
@@ -19,7 +20,6 @@
 #define __USE_GNU
 #include <fcntl.h>
 
-#define USAGE	"USAGE: %s <hugepagefile_name>\n"
 #define MIN_FREE_PAGES	20
 #define NR_HUGE_PAGES	10	/* common number of pages to map/allocate */
 
@@ -103,11 +103,6 @@ int main(int argc, char **argv)
 	int fd;
 	int ret;
 
-	if (argc != 2) {
-		printf(USAGE, argv[0]);
-		exit(1);
-	}
-
 	huge_page_size = default_huge_page_size();
 	if (!huge_page_size) {
 		printf("Unable to determine huge page size, exiting!\n");
@@ -125,9 +120,9 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	fd = open(argv[1], O_CREAT | O_RDWR, 0755);
+	fd = memfd_create(argv[0], MFD_HUGETLB);
 	if (fd < 0) {
-		perror("Open failed");
+		perror("memfd_create() failed");
 		exit(1);
 	}
 
@@ -406,6 +401,5 @@ int main(int argc, char **argv)
 	(void)munmap(addr2, NR_HUGE_PAGES * huge_page_size);
 
 	close(fd);
-	unlink(argv[1]);
 	return 0;
 }
-- 
2.37.3

