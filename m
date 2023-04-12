Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FF56DFB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjDLQos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDLQoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:44:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D0E448B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AoupzZV60neLuDl2cXNTlifM0oGkfquzJdJQPjel9/o=;
        b=hPB3rxrD2dI1QPBys3g5wafqp8peA28f3RQV1wIwEPoxfT2LYZraDjLdQirxtEVstV226L
        6LgRuOOoxf8CDyjIqL7UWxfzNWNVGM816oEd6SJgqmX+Dt9rCgWhGvsCdpWJi5hN7tFe4o
        BL/DqCUDaUeRHmj0cE3+UgWLGKBeqnM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-_MJ8t0T7Oaics3B9w-nD4A-1; Wed, 12 Apr 2023 12:42:59 -0400
X-MC-Unique: _MJ8t0T7Oaics3B9w-nD4A-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-74a90355636so62117185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317777; x=1683909777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoupzZV60neLuDl2cXNTlifM0oGkfquzJdJQPjel9/o=;
        b=PdGLWHsG6HRHsWyjdi+mkv7h9BL4PyUceSYtX8gi8c8YwgIauDPeW0jYslFmYTLJNV
         rB25KwqEfBd73IFIUyTJ6P32AgIHQK4jy1AjPC8gn6XS9NnZ1SzW20l+MIF6XegOXosU
         4rXgZ3Cqyl+UKgLDh+KAKkq4HA6Gs84Wv80TEjHpEQ0I4+tAwPBX1lwtvy0as3c5GSr6
         2lKxlhcp0RjX3MAOA7Nv9Y1dRsEYgyOMo91sWYVwRkSJuV1SyduWSBp9/P0gWOHmq/pt
         pvzYw7ZqR1U/2Wq4bPruL5zza0dzUc4UZiCA2qODqNgEGEpahjD68FAQUHw9+BjvpNgP
         NyAQ==
X-Gm-Message-State: AAQBX9d0VvMIDlYg0rMJi/Z8hbWZiD2xdhL1wuxhu9IMRMIvOSL5FuSI
        pMhVU7zG1R1ruwT8IBkKLWnv3MjFnVEAVbav0EMjcxCrQe+1UT5QfWMPyEuYLdvMR7J8BGweuef
        9wlQw/2/FNcSKDDg6TF1QJJRK2NCjgPe6Ht8fJugOSdad2eU7uXx1djbPorendZ7PMi0JXU6fmo
        VhREg54w==
X-Received: by 2002:a05:6214:5290:b0:5ed:c96e:ca4a with SMTP id kj16-20020a056214529000b005edc96eca4amr14523324qvb.1.1681317777552;
        Wed, 12 Apr 2023 09:42:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350bfOXnCx58JgZiPwX0xXvF0Ya2D7UIXCwQklBBts7OkUAc2gH540xRewo9GNFpZt0OMQoqV1g==
X-Received: by 2002:a05:6214:5290:b0:5ed:c96e:ca4a with SMTP id kj16-20020a056214529000b005edc96eca4amr14523277qvb.1.1681317777138;
        Wed, 12 Apr 2023 09:42:57 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id o24-20020a05620a229800b00747d211536dsm4766694qkh.107.2023.04.12.09.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:42:56 -0700 (PDT)
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
        peterx@redhat.com, Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 15/31] selftests/mm: uffd_open_{dev|sys}()
Date:   Wed, 12 Apr 2023 12:42:54 -0400
Message-Id: <20230412164254.328335-1-peterx@redhat.com>
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

Provide two helpers to open an uffd handle.  Drop the error checks around
SKIPs because it's inside an errexit() anyway, which IMHO doesn't really
help much if the test will not continue.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-common.c | 28 +++++-------------------
 tools/testing/selftests/mm/vm_util.c     | 24 ++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h     |  2 ++
 3 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index daa5b5781e7a..09ea24c5f02c 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -192,34 +192,16 @@ void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
 	printf("\n");
 }
 
-static int __userfaultfd_open_dev(void)
-{
-	int fd, _uffd;
-
-	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
-	if (fd < 0)
-		errexit(KSFT_SKIP, "opening /dev/userfaultfd failed");
-
-	_uffd = ioctl(fd, USERFAULTFD_IOC_NEW, UFFD_FLAGS);
-	if (_uffd < 0)
-		errexit(errno == ENOTTY ? KSFT_SKIP : 1,
-			"creating userfaultfd failed");
-	close(fd);
-	return _uffd;
-}
-
 void userfaultfd_open(uint64_t *features)
 {
 	struct uffdio_api uffdio_api;
 
 	if (test_dev_userfaultfd)
-		uffd = __userfaultfd_open_dev();
-	else {
-		uffd = syscall(__NR_userfaultfd, UFFD_FLAGS);
-		if (uffd < 0)
-			errexit(errno == ENOSYS ? KSFT_SKIP : 1,
-				"creating userfaultfd failed");
-	}
+		uffd = uffd_open_dev(UFFD_FLAGS);
+	else
+		uffd = uffd_open_sys(UFFD_FLAGS);
+	if (uffd < 0)
+		err("uffd open failed (dev=%d)", test_dev_userfaultfd);
 	uffd_flags = fcntl(uffd, F_GETFD, NULL);
 
 	uffdio_api.api = UFFD_API;
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index bb633d050d71..5ee6c4688a7c 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -3,6 +3,8 @@
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <linux/userfaultfd.h>
+#include <sys/syscall.h>
+#include <unistd.h>
 #include "../kselftest.h"
 #include "vm_util.h"
 
@@ -230,3 +232,25 @@ int uffd_unregister(int uffd, void *addr, uint64_t len)
 
 	return ret;
 }
+
+int uffd_open_dev(unsigned int flags)
+{
+	int fd, uffd;
+
+	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+	uffd = ioctl(fd, USERFAULTFD_IOC_NEW, flags);
+	close(fd);
+
+	return uffd;
+}
+
+int uffd_open_sys(unsigned int flags)
+{
+#ifdef __NR_userfaultfd
+	return syscall(__NR_userfaultfd, flags);
+#else
+	return -1;
+#endif
+}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 3a9762022efd..481354141533 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -48,6 +48,8 @@ unsigned long default_huge_page_size(void);
 int uffd_register(int uffd, void *addr, uint64_t len,
 		  bool miss, bool wp, bool minor);
 int uffd_unregister(int uffd, void *addr, uint64_t len);
+int uffd_open_dev(unsigned int flags);
+int uffd_open_sys(unsigned int flags);
 
 /*
  * On ppc64 this will only work with radix 2M hugepage size
-- 
2.39.1

