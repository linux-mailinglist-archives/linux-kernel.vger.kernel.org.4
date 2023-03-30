Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E74E6D0AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjC3QI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjC3QIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:08:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393EC9ED8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBXFNiQEy11weTKM7tK5TrNqKeG1r9RMGXvyXsqJW94=;
        b=INhxXP8f1TI5QgUgYh3taKeCZ8lt9qMjh4IpIoS2NOl9HmYdWQDLQvW9Zhk5Nl2n7+Yumm
        SdTQdwIMVlis94768jrnMBoL/qKFQ02S6C1R/n3uMTeyUEMMy4WhImoydp5gvS2SxGMxFp
        f8cmLBPlxdy4UJAHAJMrN1j5I7E/Wo0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-pSR0SseUNXe9yN5GoxU-OA-1; Thu, 30 Mar 2023 12:07:21 -0400
X-MC-Unique: pSR0SseUNXe9yN5GoxU-OA-1
Received: by mail-qv1-f69.google.com with SMTP id px9-20020a056214050900b005d510cdfc41so8511894qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192440; x=1682784440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBXFNiQEy11weTKM7tK5TrNqKeG1r9RMGXvyXsqJW94=;
        b=dlgrDU3ONLEs2hX1fenrWC7NYDx128PHXPiiCoezY+Yxywbi9bP+DsYr645wbGyhYm
         OS32yagqbB79osLPy8TJJ2QG5U2nm0t2+wy0lvg8lubsN7latLln9Ra+rjVTT1qOglEX
         BTVpchr9Wf+akJLEEfx22QgsZWWyXIR5j9j5I7EJV+DtzuzKq9aHb/koxVPXd0kMyXpd
         oj/IuUjFbABILUTQM3l+XFIy+y6Mw1TUZjXghULcfx4tJvJ+mSw/OEgCZui0m9X3B7Fi
         fch+Ov1dAAXWKcCyrE2REpc8YcveRpu4zmaPesUm++VnuUDHXuioW0QQPxTsfukH9Xn8
         tzJQ==
X-Gm-Message-State: AAQBX9fhEZvvK4rcQi9nWU1TyjfSyHDTXDW4rQSJbLxYdebYLRtSOK09
        V6SXkrRVuReZdvyHQ4S5EiY3naJqAsJMXmTtqKuev//xcMf+N+M8ffnnHsaK7JybEGUuxBoyYQV
        cEJY6+a70OmgsZnjgE8VIK9T2
X-Received: by 2002:a05:6214:f67:b0:5e0:3825:9adb with SMTP id iy7-20020a0562140f6700b005e038259adbmr3997365qvb.2.1680192440538;
        Thu, 30 Mar 2023 09:07:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350agoyNKdIa8Z89k2xkNRJVMAlfupevmh3H7qWdAB3fR6lzQMsGdBqB1QpElcSem0cMxlH2SCg==
X-Received: by 2002:a05:6214:f67:b0:5e0:3825:9adb with SMTP id iy7-20020a0562140f6700b005e038259adbmr3997336qvb.2.1680192440324;
        Thu, 30 Mar 2023 09:07:20 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id pr23-20020a056214141700b005dd8b934579sm5514594qvb.17.2023.03.30.09.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:07:19 -0700 (PDT)
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
Subject: [PATCH 11/29] selftests/mm: Drop test_uffdio_zeropage_eexist
Date:   Thu, 30 Mar 2023 12:07:17 -0400
Message-Id: <20230330160717.3107010-1-peterx@redhat.com>
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

The idea was trying to flip this var in the alarm handler from time to time
to test -EEXIST of UFFDIO_ZEROPAGE, but firstly it's only used in the
zeropage test so probably only used once, meanwhile we passed
"retry==false" so it'll never got tested anyway.

Drop both sides so we always test UFFDIO_ZEROPAGE retries if has_zeropage
is set (!hugetlb).

One more thing to do is doing UFFDIO_REGISTER for the alias buffer too,
because otherwise the test won't even pass!  We were just lucky that this
test never really got ran at all.

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

