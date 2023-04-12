Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F4F6DFC00
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjDLQ5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDLQ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:57:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8503E8A42
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681318539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ndlAQp34To4na8gq5wbdyyXxzaHqcVWVuJagrtwfaA=;
        b=P/lB6CWQMG15p8zd+SQrUspYKd+E3JMd7RIySdaEL3+FZ8gDW1ijmAK7bYW5kn9rF0gpzy
        3M/xt3zbhkpiHM4sxvZSMAyY/+yQDoX0RKmeTKZMK7vSA5g1EDurcmfOLSlqwHvJEOeqKz
        P1LWtvRRn51/AtDO0PMBKHSfBGLciZA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-vawm8nB-PmCS-58qXLKOzw-1; Wed, 12 Apr 2023 12:45:20 -0400
X-MC-Unique: vawm8nB-PmCS-58qXLKOzw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5ea572ef499so7659966d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317920; x=1683909920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ndlAQp34To4na8gq5wbdyyXxzaHqcVWVuJagrtwfaA=;
        b=SUwPOUvw6QyP1CfcmQNfsgu6CQQmPLssPlPaCzyM6IqAJsGvVm5DhUTykiOVKIYM/R
         LWJbOcBFEE8WfgTeEv/c0GKp7ZMaBNwsbb45fXiQBQDNykX1ExH3paAcfql6g5gXFtBr
         WEUsbXTP6daXdCOWSBG9xLeCAvJZ/7rZ4Gvob61Tk//7QLDDA1xI4SELtj/ZJs1K01hA
         yS9vLquU6tE9ulIl521LsWg51+aMvSRP1zVwLUgf61E0qVlonPMW/+AsHb5C6/Cq8R70
         vd4/ZH3SubouRlU/plTiV6xlb0sO70KwSjSltrrDtJ9+Z4xWkKtJ1w76v1HAJbgg4I9X
         1Qyw==
X-Gm-Message-State: AAQBX9cc/pIaKIvrXpAQFfDXb3bMhTMJbryi/JAVm0DgJZje1w3BFXhx
        /U6AzMUNJZQV6FVHzYMjqJ94d6YHiUTELcAm73OsnMVgUqPy+M8TS/nbyeBlnyIWf4TPlWXC5aO
        KgcBGu0F+LAbHLgTLyECePEfo
X-Received: by 2002:ad4:5de6:0:b0:5da:b965:1efd with SMTP id jn6-20020ad45de6000000b005dab9651efdmr27671967qvb.2.1681317920286;
        Wed, 12 Apr 2023 09:45:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350YZb2K0e1JvXEoA25aoHQ/nvgMcYX1GQMHOJJJS45iAA64autN1RPeNtWC+riOtge78epKXPA==
X-Received: by 2002:ad4:5de6:0:b0:5da:b965:1efd with SMTP id jn6-20020ad45de6000000b005dab9651efdmr27671945qvb.2.1681317919979;
        Wed, 12 Apr 2023 09:45:19 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id cw8-20020ad44dc8000000b005ef465ad69bsm319693qvb.23.2023.04.12.09.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 09:45:19 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        peterx@redhat.com, David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 27/31] selftests/mm: Workaround no way to detect uffd-minor + wp
Date:   Wed, 12 Apr 2023 12:45:17 -0400
Message-Id: <20230412164517.329152-1-peterx@redhat.com>
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

Userfaultfd minor+wp mode was very recently added.  The test will fail on
the old kernels at ioctl(UFFDIO_CONTINUE) which is misterious.
Unfortunately there's no feature bit to detect for this support.

Add a hack to leverage WP_UNPOPULATED to detect whether that feature
existed, since WP_UNPOPULATED was merged right after minor+wp.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 160bd8ccda55..a33d6c928eeb 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -780,7 +780,13 @@ uffd_test_case_t uffd_tests[] = {
 		.mem_targets = MEM_SHMEM | MEM_HUGETLB,
 		.uffd_feature_required =
 		UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM |
-		UFFD_FEATURE_PAGEFAULT_FLAG_WP,
+		UFFD_FEATURE_PAGEFAULT_FLAG_WP |
+		/*
+		 * HACK: here we leveraged WP_UNPOPULATED to detect whether
+		 * minor mode supports wr-protect.  There's no feature flag
+		 * for it so this is the best we can test against.
+		 */
+		UFFD_FEATURE_WP_UNPOPULATED,
 	},
 	{
 		.name = "minor-collapse",
-- 
2.39.1

