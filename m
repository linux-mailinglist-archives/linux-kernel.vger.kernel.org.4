Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE355F4B18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJDVqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiJDVpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66096DAFE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 14:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664919787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iDP4uYCeHzqEOaCGXbcAwOcK1rZC2BBuQ6aTX5fgU3w=;
        b=cM7qRnpkZjQEY+Ujh9rGEuA89d+cTGs8Wg553RYc2JgYt2n6Ho9oaaph8I/589smYnJodG
        uVbaE9milM70QaDpc/de1JKEwc223QKnr+/SHNmJJhQ0wR+ANFjSjkb5j+HBwmKkvQivKj
        OiJWkRkEHcNP/J7ETkXicx8EQBmya1s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-55-4EmC-g2cOFCE76Mk0UAzAQ-1; Tue, 04 Oct 2022 17:43:06 -0400
X-MC-Unique: 4EmC-g2cOFCE76Mk0UAzAQ-1
Received: by mail-qk1-f197.google.com with SMTP id o13-20020a05620a2a0d00b006cf9085682dso12629617qkp.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 14:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iDP4uYCeHzqEOaCGXbcAwOcK1rZC2BBuQ6aTX5fgU3w=;
        b=XUpWgcxiXR7lUC/47BTfVB9FaFkurFsJPTezaxK839KDyAB+uhVX6tgyW39C9CK4a1
         CeQM0hwxfk1J9pSyoGe4vI6C6yiSExCC48VO7H0VyL8Qk4l+Kp7QcFm7je8A8BPX4bVP
         kxyJ//1VJrQiKFcCk6Lrps0+qRRkRgCcDk5aHnHuhRGbVNW70lBqBAtc0oOD3NncveZD
         fMvFSHAnhk2+jfLrEGg2HYQ6AGgE7iBZB6rD17IlzmymFmTkfJKGvCNpKIPnu3Weg4Hq
         VoP/k32iYw2ICSm6+4YtxvY/Fgn9T2yTbnBOisaw/fERhN9Lo+xx+RbJfz7g+OjKA1NO
         WYsQ==
X-Gm-Message-State: ACrzQf2UJUXi5lUHhKG2MiYRcftVOQSlkDMJ7HuN2PA7jiR6DesIPp/d
        l90MnNmVyGTKbOOlmncoqeVLqCte/APSsOsoqmnrKL5SLBstXtmVmLbwk4lnpdjC2AZ5UwMilIx
        ie949J7jWFyCbUizHLl4hyqIj7aR15MOUuebfapNVQgHOE/SI6bb2yuAqPzFo7yvNX25WxXWIew
        ==
X-Received: by 2002:a37:4553:0:b0:6cf:4dbd:b5f6 with SMTP id s80-20020a374553000000b006cf4dbdb5f6mr18472734qka.339.1664919785841;
        Tue, 04 Oct 2022 14:43:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM77JL7JEmps8VFSIv2pFu3zdKv9SaLpBJ+ezlOLM+yMue29M9e7KeiI1bvH4JScBSCCgMYdkQ==
X-Received: by 2002:a37:4553:0:b0:6cf:4dbd:b5f6 with SMTP id s80-20020a374553000000b006cf4dbdb5f6mr18472717qka.339.1664919785571;
        Tue, 04 Oct 2022 14:43:05 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id a5-20020ac85b85000000b0035ba7012724sm13297803qta.70.2022.10.04.14.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 14:43:05 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/4] selftests/vm: Use memfd for hugepage-mremap test
Date:   Tue,  4 Oct 2022 17:43:03 -0400
Message-Id: <20221004214303.121394-1-peterx@redhat.com>
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

