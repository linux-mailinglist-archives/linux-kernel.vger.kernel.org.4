Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C80C5F4B14
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiJDVoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiJDVoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DB770E7A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 14:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664919691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhrtCe5O8iJscoLdf85Accar6WxcllS+eYr7bBy1HkM=;
        b=dJaHvDIYcugfcbZXI9MGjISejh5vRgBChdcjH0EX9gK2PQj+b+fXG3t17UHlBLb8jdj1yK
        2Z55fE+yYvcGEOf2L1Jboc4PS7FvGShcZezLeSolAJm6G/f9lXfiss1mCN+VM5I9NkbKjE
        t8XW6WBULBEp0OipNqWRSkD5ufkSG/w=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-GyElZGaePQK_b7KCQ-Txzg-1; Tue, 04 Oct 2022 17:41:31 -0400
X-MC-Unique: GyElZGaePQK_b7KCQ-Txzg-1
Received: by mail-qt1-f200.google.com with SMTP id ay22-20020a05622a229600b0035bbb349e79so10213334qtb.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 14:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zhrtCe5O8iJscoLdf85Accar6WxcllS+eYr7bBy1HkM=;
        b=ldbdC6yynGtre0wfjcuS9oMMC/8u2m4OweMRM75gVk2w+hzEYRoY3Ilo0Ih24bcDKH
         0XPSSlA5NBS+F6jsl1mY7pUNg1QfVbyQBjfFFbxz683LkVeVtUrkF9EFp+420OaTswWV
         of1aByE17aAt/qzh4TppdFwDHGM6jOwzW2rNkqNqbnHfRCWZb4hdempw/AKYN5HZLjec
         BUW5Ssp/qp9jv/I0qTWZJ6feL7Zk6YKnLswMpIcCM4Py26REYOkJbBv1WyWq5Wa54xTI
         WjjhyaVjmGYTg4xdOnVIZfE4O78YQkvzyg3DZtLp8dGB5mieab5SyhlJcQ2YvPfScgTq
         4dDQ==
X-Gm-Message-State: ACrzQf1n+VWMt4g3UY6VX/DIBUOInKXNM62zZxI3htcx/DQRXEVWLQOZ
        2+MPhXYNmIKlEgtitF43VZPqjnvCIW+1F/ir0Sm/xLcgZcJbDzORL7Z0YCEtATVyA2a+foNXe7i
        mxi16R2Uwr3DCBS8/3dCa7LJoXCuiK+4n8tlyrym2IF0Pt8kBuEYI6KvLvwTLh/Up4i7wMrTaDg
        ==
X-Received: by 2002:a05:6214:c6d:b0:4b1:c751:ac7 with SMTP id t13-20020a0562140c6d00b004b1c7510ac7mr400613qvj.96.1664919689990;
        Tue, 04 Oct 2022 14:41:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5na/pwjmQhLcKutEJzsIkykeE5fgN/HwlF3WpQM1DgGubYNqpa+trsw7pJkJNONLm/cQp/ew==
X-Received: by 2002:a05:6214:c6d:b0:4b1:c751:ac7 with SMTP id t13-20020a0562140c6d00b004b1c7510ac7mr400597qvj.96.1664919689696;
        Tue, 04 Oct 2022 14:41:29 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id y15-20020a05620a25cf00b006bbf85cad0fsm15519956qko.20.2022.10.04.14.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 14:41:29 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 2/4] selftests/vm: Use memfd for hugetlb-madvise test
Date:   Tue,  4 Oct 2022 17:41:23 -0400
Message-Id: <20221004214125.120993-3-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004214125.120993-1-peterx@redhat.com>
References: <20221004214125.120993-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

