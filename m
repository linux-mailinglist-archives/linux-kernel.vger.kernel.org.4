Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC9C6D0AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjC3QIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjC3QIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:08:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C58B771
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GWrLladF+2uMEiKA8QDU9N/tbvqlj2DcoX5RP21NYpg=;
        b=KU9tWyruuQxgCvrZzW8Rr57s3CEV0YxqgFFzxEQikHVrmw1pqSGQiftCj8AbKLZngWOhJR
        0aAL2sEYIZUVQaCNmeg3B3uKVlEVQ5OKItkKynXWgkzY7z+dPNk1v2MTYGLIVUhdb6bmOa
        0vunZLC2B77r/AGFgAKevkqGYc2TSPg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-dVPK78B6NSKV8Bzc-BEd_w-1; Thu, 30 Mar 2023 12:07:15 -0400
X-MC-Unique: dVPK78B6NSKV8Bzc-BEd_w-1
Received: by mail-qk1-f199.google.com with SMTP id x80-20020a376353000000b0074681bc7f42so9100671qkb.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192431; x=1682784431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWrLladF+2uMEiKA8QDU9N/tbvqlj2DcoX5RP21NYpg=;
        b=UjFc6yVY4LSxzJaLnC49ox9UUscRrEyZsTDiQvJL/klNyNPlp/Nr2T9ZKvYz6P4F5v
         KVNt84rwWPkCuH4BFP6DzWK++Pgq8tdh+0yehvpPyNsF8q3G8kaEo02J1ESvepgHuvrA
         x5xmgEm+FX7SmhqqDf+5FwHGAO5GmiaFmx3r+W5YrAKl3qmNmEm6EV2kVJ3eq01/ZKWx
         +e5cc1q/WRJjxlxKsKY1RcF6VO2QS4txoDoV6yq+pqQKj/s3r4wfrHVx4QB/03kFxb+j
         /q/XkeYXkIAf3Pc6uYgj7n9a000c+6YwnNkifjknWCV1Ol/gUoDbJEG055nVrKAE8AT8
         7Q7w==
X-Gm-Message-State: AO0yUKVXHRJCaEO3ySVfl2pVfFQQOdYib74LUCDPEGF57kCk8Yj6DVl0
        KTkApxfhJGAuncc5mjgBcjUZeF+vywYXNOewCQHBbnoJtQANtT6MveAuW6Fa9O55e5CianYoXs3
        jRwSYZW0AvD4pLmpBkC77jgYW
X-Received: by 2002:a05:622a:1886:b0:3d1:16f4:ae58 with SMTP id v6-20020a05622a188600b003d116f4ae58mr37195469qtc.2.1680192431567;
        Thu, 30 Mar 2023 09:07:11 -0700 (PDT)
X-Google-Smtp-Source: AK7set8GQWWP5A2SWociPwDs+/krj5i0TiQOKiGvePWsmn+f7FgX8FsfyTl2mFFLsw0jAZRNZOJYbg==
X-Received: by 2002:a05:622a:1886:b0:3d1:16f4:ae58 with SMTP id v6-20020a05622a188600b003d116f4ae58mr37195424qtc.2.1680192431235;
        Thu, 30 Mar 2023 09:07:11 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id 12-20020a370b0c000000b0074680682acdsm14989583qkl.76.2023.03.30.09.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:07:10 -0700 (PDT)
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
Subject: [PATCH 08/29] selftests/mm: Use PM_* macros in vm_utils.h
Date:   Thu, 30 Mar 2023 12:07:08 -0400
Message-Id: <20230330160708.3106977-1-peterx@redhat.com>
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

We've got the macros in uffd-stress.c, move it over and use it in
vm_util.h.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/userfaultfd.c |  8 --------
 tools/testing/selftests/mm/vm_util.c     | 16 ++++------------
 tools/testing/selftests/mm/vm_util.h     |  8 ++++++++
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
index 4cc80a0e8955..7e841f7e2884 100644
--- a/tools/testing/selftests/mm/userfaultfd.c
+++ b/tools/testing/selftests/mm/userfaultfd.c
@@ -1389,14 +1389,6 @@ static int userfaultfd_minor_test(void)
 	return stats.missing_faults != 0 || stats.minor_faults != nr_pages;
 }
 
-#define BIT_ULL(nr)                   (1ULL << (nr))
-#define PM_SOFT_DIRTY                 BIT_ULL(55)
-#define PM_MMAP_EXCLUSIVE             BIT_ULL(56)
-#define PM_UFFD_WP                    BIT_ULL(57)
-#define PM_FILE                       BIT_ULL(61)
-#define PM_SWAP                       BIT_ULL(62)
-#define PM_PRESENT                    BIT_ULL(63)
-
 static int pagemap_open(void)
 {
 	int fd = open("/proc/self/pagemap", O_RDONLY);
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 12dc654b5be3..8e9da621764a 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -25,25 +25,17 @@ uint64_t pagemap_get_entry(int fd, char *start)
 
 bool pagemap_is_softdirty(int fd, char *start)
 {
-	uint64_t entry = pagemap_get_entry(fd, start);
-
-	// Check if dirty bit (55th bit) is set
-	return entry & 0x0080000000000000ull;
+	return pagemap_get_entry(fd, start) & PM_SOFT_DIRTY;
 }
 
 bool pagemap_is_swapped(int fd, char *start)
 {
-	uint64_t entry = pagemap_get_entry(fd, start);
-
-	return entry & 0x4000000000000000ull;
+	return pagemap_get_entry(fd, start) & PM_SWAP;
 }
 
 bool pagemap_is_populated(int fd, char *start)
 {
-	uint64_t entry = pagemap_get_entry(fd, start);
-
-	/* Present or swapped. */
-	return entry & 0xc000000000000000ull;
+	return pagemap_get_entry(fd, start) & (PM_PRESENT | PM_SWAP);
 }
 
 unsigned long pagemap_get_pfn(int fd, char *start)
@@ -51,7 +43,7 @@ unsigned long pagemap_get_pfn(int fd, char *start)
 	uint64_t entry = pagemap_get_entry(fd, start);
 
 	/* If present (63th bit), PFN is at bit 0 -- 54. */
-	if (entry & 0x8000000000000000ull)
+	if (entry & PM_PRESENT)
 		return entry & 0x007fffffffffffffull;
 	return -1ul;
 }
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index d7163fff8fb7..d9fadddb5c69 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -6,6 +6,14 @@
 #include <string.h> /* ffsl() */
 #include <unistd.h> /* _SC_PAGESIZE */
 
+#define BIT_ULL(nr)                   (1ULL << (nr))
+#define PM_SOFT_DIRTY                 BIT_ULL(55)
+#define PM_MMAP_EXCLUSIVE             BIT_ULL(56)
+#define PM_UFFD_WP                    BIT_ULL(57)
+#define PM_FILE                       BIT_ULL(61)
+#define PM_SWAP                       BIT_ULL(62)
+#define PM_PRESENT                    BIT_ULL(63)
+
 extern unsigned int __page_size;
 extern unsigned int __page_shift;
 
-- 
2.39.1

