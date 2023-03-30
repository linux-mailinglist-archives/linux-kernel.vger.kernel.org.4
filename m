Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E356F6D0AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjC3QJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjC3QIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:08:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E271103
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y+QAWrtqijcBRWNbbJvqOTcdIrT0hJlkJlw2bNALieY=;
        b=Bfxtvo9G7DNj0J9UaJtiIFZZcAH73nFi/dq8zBbbEF/Zq62zMwUQyGCWleOkqnVVVYuBhZ
        zXTFE3bkXUyQVPOxGPYBnnX6esRICIctnJ+k7b8u/003zQrmWrdi0UKHseytECP6V0+iQ+
        +OU9ZYIqCS0s2aOsmaMthIqYkt4qEMA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-n1gvLEObMauLq5kOesBvdQ-1; Thu, 30 Mar 2023 12:07:52 -0400
X-MC-Unique: n1gvLEObMauLq5kOesBvdQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-57c67ea348eso12977306d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+QAWrtqijcBRWNbbJvqOTcdIrT0hJlkJlw2bNALieY=;
        b=qo8O1vG7jeg16oKcA+JEhqu4NfaCe2rPnVODr6/nS8THSesAL0RmRGQf5yPjAPgrbO
         613gTj1ZY6c9KVaqfYxJ4Yu0nwtR+5LAnveWUmBYFwaOEvAhQ2W1wdYBT5kp72r61C8U
         MWATbE7CNWXtvySBXOaaeoMP6DBQcX5xyoBdfjLe7R+e+HsypzEyUPOY7X3g9ljYek1q
         a+JhW4iJLC+N8U5ly+PK9txtMzQuB+wyNNk6z0bAITgKPyV6VdY/w4/v7T83uV+en85j
         VOa4EvIWu8pVllHYKi2BY/xm6+2LyUilIKUxX7zgpbefJnAh9IX1ht/pcpgZTQyTJ8X9
         fipg==
X-Gm-Message-State: AAQBX9c0teNojQweSWOax1z5YsiAfmSBkZOc0YxQJzRncMoMJLcOb629
        plYKKOs2G/m+hkF4JKfV7e4+B924wIuFYsJ//dtPUZbrmGQIm+FyBDt9Uh2hXuei67N/7wkOLik
        SoiF4iGV7FqJG3dP1/KlkOwbo
X-Received: by 2002:a05:6214:5089:b0:57d:747b:1f7 with SMTP id kk9-20020a056214508900b0057d747b01f7mr3712118qvb.1.1680192472107;
        Thu, 30 Mar 2023 09:07:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZAVMXrazBe1vAQ/esRv12K7m2amBl/weU4s0XRJNLyUQvvVZevPT3MnJh9bSHpN/NtrYQMVw==
X-Received: by 2002:a05:6214:5089:b0:57d:747b:1f7 with SMTP id kk9-20020a056214508900b0057d747b01f7mr3712094qvb.1.1680192471894;
        Thu, 30 Mar 2023 09:07:51 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id ev11-20020a0562140a8b00b005dd8b9345bcsm5580475qvb.84.2023.03.30.09.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:07:51 -0700 (PDT)
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
Subject: [PATCH 15/29] selftests/mm: uffd_open_{dev|sys}()
Date:   Thu, 30 Mar 2023 12:07:49 -0400
Message-Id: <20230330160749.3107270-1-peterx@redhat.com>
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

Provide two helpers to open an uffd handle.  Drop the error checks around
SKIPs because it's inside an errexit() anyway, which IMHO doesn't really
help much if the test will not continue.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-common.c | 28 +++++-------------------
 tools/testing/selftests/mm/vm_util.c     | 24 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 17f2bb82c3db..3a9b5c1aca9d 100644
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
index 10e76400ed70..7c2bf88d6393 100644
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
-- 
2.39.1

