Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF4D6D0AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjC3QII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjC3QH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02510A27B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E56MghZwBJmwObq6HpbLSvJ4ZkxH3HDhcAvyqpX+TEo=;
        b=AF91dBakt6zza2SclKAYqOdBUynTFRYfJxLY53C8Xq/LnXEpnJTDBquEfSREl0K2WoeYJN
        xIi2krrkU+KlWIbE9RWdr2MiujoXt42RX6JrBRZo6oJavojhsOKB8XAY8ikV5+2WGgrv63
        lNZBLuGFon6vIWriVoezjxEMqKyB1PY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-1dMOqwSCMwKLlmZnQcXyPg-1; Thu, 30 Mar 2023 12:07:14 -0400
X-MC-Unique: 1dMOqwSCMwKLlmZnQcXyPg-1
Received: by mail-qv1-f72.google.com with SMTP id px9-20020a056214050900b005d510cdfc41so8511729qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192434; x=1682784434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E56MghZwBJmwObq6HpbLSvJ4ZkxH3HDhcAvyqpX+TEo=;
        b=Y7kkQZV5Q5v0MzhjgxQ+hZ+/NcwFXo6RRqsHCkfMIcbVyAkdZoGCdSurKvRPeNFDOK
         K/toUIAzUFlCqNHwAWBYwfCITiD1OBmeq0aU3cvuVQrWO2o+M/GQIbgYTknZ1426EyI/
         BHsw9751J+KaHDhrrqfzYpAHbAqwmKOMJezknfZWAGKCq395w8eRpCMx93JF7DykRcTS
         OIAklilFWGYFNohCxPqMx3CKze8GDt0YJqyST9/ifRu64LyivT18vG3IxYEar7Eg6q0T
         qwYZ/8HazpsL/X7kQGdxuxO9nA1CNbzcydUt9JsyXYynW4GMY3PfWlUnyUBcJTpMXfVO
         jekQ==
X-Gm-Message-State: AO0yUKUAKpYEuhKuYfp4N4iyNa3mIUtlFDuYz2XrO+Ihl2YBxFxWvCTQ
        TQXvSP8LM/k3qZfV6MfuQPi7uUStDsWPrcW9twcvRngNUKmvn2QSszy2hUGf7zALODDp+b8mNq7
        P4RQw+pBukVAB9Bdi21rT69TE
X-Received: by 2002:a05:622a:1441:b0:3e3:c889:ecf9 with SMTP id v1-20020a05622a144100b003e3c889ecf9mr39965906qtx.1.1680192434233;
        Thu, 30 Mar 2023 09:07:14 -0700 (PDT)
X-Google-Smtp-Source: AK7set9xAaaiu8B7fUg9IKNqpQZzRasQSp33mstFG5mjRfDlXBiQLIYFStz2qxFjSs126X/1sVdKHA==
X-Received: by 2002:a05:622a:1441:b0:3e3:c889:ecf9 with SMTP id v1-20020a05622a144100b003e3c889ecf9mr39965871qtx.1.1680192433979;
        Thu, 30 Mar 2023 09:07:13 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id p126-20020a374284000000b007486fc7a74csm3517380qka.135.2023.03.30.09.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:07:12 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 09/29] selftests/mm: Reuse pagemap_get_entry() in vm_util.h
Date:   Thu, 30 Mar 2023 12:07:11 -0400
Message-Id: <20230330160711.3106988-1-peterx@redhat.com>
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

Meanwhile drop pagemap_read_vaddr().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/userfaultfd.c | 31 +++++++-----------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
index 7e841f7e2884..795fbc4d84f8 100644
--- a/tools/testing/selftests/mm/userfaultfd.c
+++ b/tools/testing/selftests/mm/userfaultfd.c
@@ -1399,19 +1399,6 @@ static int pagemap_open(void)
 	return fd;
 }
 
-static uint64_t pagemap_read_vaddr(int fd, void *vaddr)
-{
-	uint64_t value;
-	int ret;
-
-	ret = pread(fd, &value, sizeof(uint64_t),
-		    ((uint64_t)vaddr >> 12) * sizeof(uint64_t));
-	if (ret != sizeof(uint64_t))
-		err("pread() on pagemap failed");
-
-	return value;
-}
-
 /* This macro let __LINE__ works in err() */
 #define  pagemap_check_wp(value, wp) do {				\
 		if (!!(value & PM_UFFD_WP) != wp)			\
@@ -1427,7 +1414,7 @@ static int pagemap_test_fork(bool present)
 	if (!child) {
 		/* Open the pagemap fd of the child itself */
 		fd = pagemap_open();
-		value = pagemap_read_vaddr(fd, area_dst);
+		value = pagemap_get_entry(fd, area_dst);
 		/*
 		 * After fork() uffd-wp bit should be gone as long as we're
 		 * without UFFD_FEATURE_EVENT_FORK
@@ -1446,24 +1433,24 @@ static void userfaultfd_wp_unpopulated_test(int pagemap_fd)
 
 	/* Test applying pte marker to anon unpopulated */
 	wp_range(uffd, (uint64_t)area_dst, page_size, true);
-	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, true);
 
 	/* Test unprotect on anon pte marker */
 	wp_range(uffd, (uint64_t)area_dst, page_size, false);
-	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, false);
 
 	/* Test zap on anon marker */
 	wp_range(uffd, (uint64_t)area_dst, page_size, true);
 	if (madvise(area_dst, page_size, MADV_DONTNEED))
 		err("madvise(MADV_DONTNEED) failed");
-	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, false);
 
 	/* Test fault in after marker removed */
 	*area_dst = 1;
-	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, false);
 	/* Drop it to make pte none again */
 	if (madvise(area_dst, page_size, MADV_DONTNEED))
@@ -1522,7 +1509,7 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 	/* Touch the page */
 	*area_dst = 1;
 	wp_range(uffd, (uint64_t)area_dst, test_pgsize, true);
-	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, true);
 	/* Make sure uffd-wp bit dropped when fork */
 	if (pagemap_test_fork(true))
@@ -1536,7 +1523,7 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 		err("madvise(MADV_PAGEOUT) failed");
 
 	/* Uffd-wp should persist even swapped out */
-	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, true);
 	/* Make sure uffd-wp bit dropped when fork */
 	if (pagemap_test_fork(false))
@@ -1544,12 +1531,12 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 
 	/* Unprotect; this tests swap pte modifications */
 	wp_range(uffd, (uint64_t)area_dst, page_size, false);
-	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, false);
 
 	/* Fault in the page from disk */
 	*area_dst = 2;
-	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	value = pagemap_get_entry(pagemap_fd, area_dst);
 	pagemap_check_wp(value, false);
 
 	close(pagemap_fd);
-- 
2.39.1

