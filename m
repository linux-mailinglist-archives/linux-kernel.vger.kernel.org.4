Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED536DFB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjDLQoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjDLQn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:43:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C208A4A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681317764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1TTsACSLiRja1XbqXldcznrpQfU/7XLsecI/fn7kMpU=;
        b=G101O6kGr66QB31F/K3SOmm5H+EdlVvqLlZuuK1rL9xZ87obZkPPeLfpIqXwfTbT9fluto
        LXhBZAnlQOrNkcjc7hjuaHGLlkmgiKmCWPCQiwqf4/JZSmHPpMlIxymPtiRPugWop0GbXd
        9nkpKA/sklXGxm7ComV8ovGS4bHDyjo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-Fkl8l0tLMYizcR-bcGnwtA-1; Wed, 12 Apr 2023 12:42:43 -0400
X-MC-Unique: Fkl8l0tLMYizcR-bcGnwtA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-74a9035256eso54256085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317762; x=1683909762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TTsACSLiRja1XbqXldcznrpQfU/7XLsecI/fn7kMpU=;
        b=bZN+RiudWwtwLK3laSu7eEngUyN0wTOGZ4QhbltZIL6Eli4LQwzBRgGd0Q1W8vGQQI
         XjWWgwxfkn66SnM6O3+cAUiHKCNrJdBqXnTjJr75HHVJ/9KaYhLpoS8pKdnZs2MKyDn3
         FJ6BILpdY2fhEXnaluzi4v7x7CugeLfP3NkkfxJgXPKJHXKeVcgok3eZEmfRt7N30V9O
         bVG6rISCos3GYW5FtqmrHpTCHfFZzTak6Z7DPu6DdVnzgoX7xUVrK/iXDDQmKUQkwE8Y
         zaAXHlRloVubT9c0wlWk3mUQYjDnR5QcrNQNjba6G0TlYJJ6Qx/vblyibleiwmGBqcaX
         vL5w==
X-Gm-Message-State: AAQBX9eD6xosxQrXqiXznA+X3fzkrcLAxk3lhT0PWV7bar8qe7KET0dY
        /1odLLoscTWJraAnMD+MT/gAwNS6vjr8AhF9QKLtyFgUozhFSX4jUb61argNDIwRT9BqKt+FlK8
        M6zs/NividRYmmOBxHMYKgM2ct3yMIspC4WJ5/bAJE4POOSO+kBoLisB8uUx9yvyf9mHeur4q1k
        5MlvpyKA==
X-Received: by 2002:a05:6214:5192:b0:5e8:e6ac:591a with SMTP id kl18-20020a056214519200b005e8e6ac591amr4458283qvb.2.1681317761949;
        Wed, 12 Apr 2023 09:42:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350YBsQS6JYJjxqfbIX08K5h2eIXR2P+DncIxdAAKOWLtDWxM+vNCtIyUP4FvBHNvZ8jfexZ/kA==
X-Received: by 2002:a05:6214:5192:b0:5e8:e6ac:591a with SMTP id kl18-20020a056214519200b005e8e6ac591amr4458247qvb.2.1681317761589;
        Wed, 12 Apr 2023 09:42:41 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id mf18-20020a0562145d9200b005dd8b934579sm3676547qvb.17.2023.04.12.09.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:42:40 -0700 (PDT)
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
Subject: [PATCH v2 11/31] selftests/mm: Drop test_uffdio_zeropage_eexist
Date:   Wed, 12 Apr 2023 12:42:38 -0400
Message-Id: <20230412164238.328238-1-peterx@redhat.com>
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

The idea was trying to flip this var in the alarm handler from time to time
to test -EEXIST of UFFDIO_ZEROPAGE, but firstly it's only used in the
zeropage test so probably only used once, meanwhile we passed
"retry==false" so it'll never got tested anyway.

Drop both sides so we always test UFFDIO_ZEROPAGE retries if has_zeropage
is set (!hugetlb).

One more thing to do is doing UFFDIO_REGISTER for the alias buffer too,
because otherwise the test won't even pass!  We were just lucky that this
test never really got ran at all.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/userfaultfd.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
index d724f1c78847..3487ec0bfcc8 100644
--- a/tools/testing/selftests/mm/userfaultfd.c
+++ b/tools/testing/selftests/mm/userfaultfd.c
@@ -88,7 +88,6 @@ static bool test_dev_userfaultfd;
 /* exercise the test_uffdio_*_eexist every ALARM_INTERVAL_SECS */
 #define ALARM_INTERVAL_SECS 10
 static volatile bool test_uffdio_copy_eexist = true;
-static volatile bool test_uffdio_zeropage_eexist = true;
 /* Whether to test uffd write-protection */
 static bool test_uffdio_wp = true;
 /* Whether to test uffd minor faults */
@@ -1114,7 +1113,7 @@ static void retry_uffdio_zeropage(int ufd,
 	}
 }
 
-static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
+static int __uffdio_zeropage(int ufd, unsigned long offset)
 {
 	struct uffdio_zeropage uffdio_zeropage;
 	int ret;
@@ -1138,11 +1137,8 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
 		if (res != page_size) {
 			err("UFFDIO_ZEROPAGE unexpected size");
 		} else {
-			if (test_uffdio_zeropage_eexist && retry) {
-				test_uffdio_zeropage_eexist = false;
-				retry_uffdio_zeropage(ufd, &uffdio_zeropage,
-						      offset);
-			}
+			retry_uffdio_zeropage(ufd, &uffdio_zeropage,
+					      offset);
 			return 1;
 		}
 	} else
@@ -1153,7 +1149,7 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
 
 static int uffdio_zeropage(int ufd, unsigned long offset)
 {
-	return __uffdio_zeropage(ufd, offset, false);
+	return __uffdio_zeropage(ufd, offset);
 }
 
 /* exercise UFFDIO_ZEROPAGE */
@@ -1177,6 +1173,13 @@ static int userfaultfd_zeropage_test(void)
 	assert_expected_ioctls_present(
 		uffdio_register.mode, uffdio_register.ioctls);
 
+	if (area_dst_alias) {
+		/* Needed this to test zeropage-retry on shared memory */
+		uffdio_register.range.start = (unsigned long) area_dst_alias;
+		if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+			err("register failure");
+	}
+
 	if (uffdio_zeropage(uffd, 0))
 		if (my_bcmp(area_dst, zeropage, page_size))
 			err("zeropage is not zero");
@@ -1763,7 +1766,6 @@ static void sigalrm(int sig)
 	if (sig != SIGALRM)
 		abort();
 	test_uffdio_copy_eexist = true;
-	test_uffdio_zeropage_eexist = true;
 	alarm(ALARM_INTERVAL_SECS);
 }
 
-- 
2.39.1

