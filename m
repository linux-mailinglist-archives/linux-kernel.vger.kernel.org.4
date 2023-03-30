Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9ED6D0AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjC3QLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjC3QLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:11:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BF9D329
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680192519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IPQaNGX43g5m/+6Rf9W/FOC5JWY5QcIX+G5qmLnnQxA=;
        b=Hb+5TF649nX2wLjYKfDBk6kNgL870K4+ohErg/DmguCOFw5VN2QHAX0qHn/SmU/5Dz2WUD
        H1X03GNOVBFYck26q83488wDfWpyGXn8Um3T/h1itR4vQnaNqCEcQ1lvnEbrsMpGGs+znw
        wRj5X6ltaAb6Bz2UyWfye4d99g9UXIE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-4bRmtZ_9Oy6UcYlN6N0lLg-1; Thu, 30 Mar 2023 12:08:38 -0400
X-MC-Unique: 4bRmtZ_9Oy6UcYlN6N0lLg-1
Received: by mail-qv1-f72.google.com with SMTP id w2-20020a0cc242000000b00583d8e55181so8447049qvh.23
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPQaNGX43g5m/+6Rf9W/FOC5JWY5QcIX+G5qmLnnQxA=;
        b=oI8EtJWwuYIKClEaZCIknK93SvKXJwzlAuUzJhEsFGT2Yw4AC1OLwQWEoaeeSdZ/QB
         ghGzfOC3qvOxlVGVuzWy7f/HtWg7YQggCzXJlM4AOck0XniIQvryfcSAT3VIGYAY2SwW
         6hcU0B3dpX+8RSgLqGtmVohs/svzwmvlJboT++TfAWRo4S/3EYrX2HUh+/QbtmSwJ6p5
         bcOv+onr7h3QMrVG4nByzIPSmxC78gjUa9gXS1j5k+Xu6URJWgtj6sdWeOjSHMeCymRG
         dX0duquv4aVa1FY4+6/5CxXMJEcGghBwE8+0tf/ReJAV8v9S3WxgbncEQkQApNWqerpt
         +Vrg==
X-Gm-Message-State: AAQBX9dctWoPThzTgmdfXRcpii/woOldLkAywXwZXJ4vzQnUrwDv6nxi
        04HgTBDnAM1ng0BPSPaSLEBNOxsbX03ggl+QEOaF4J6/16j3T1L+zh1zxhfI88eXGtrr+7r+Hup
        923OBX2v5xxASxmKreHVJibsJjAA8Y7OoZ4VoA4HEW8s1AhpGJC6Zb+Q4vrrGmFch5AtAZYnGNY
        dqKBMbiQ==
X-Received: by 2002:a05:622a:1894:b0:3e4:d3cc:4211 with SMTP id v20-20020a05622a189400b003e4d3cc4211mr4416059qtc.3.1680192515384;
        Thu, 30 Mar 2023 09:08:35 -0700 (PDT)
X-Google-Smtp-Source: AKy350aRBS/3Ba03nR6/rH7+O6OKnPp5UZSkwf7AEEAgfK8oTfxGPLAAS7vHG57dqP9Xg/7Bnp679A==
X-Received: by 2002:a05:622a:1894:b0:3e4:d3cc:4211 with SMTP id v20-20020a05622a189400b003e4d3cc4211mr4416001qtc.3.1680192515042;
        Thu, 30 Mar 2023 09:08:35 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id l18-20020ac84a92000000b003e3860f12f7sm9484075qtq.56.2023.03.30.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:08:34 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 26/29] selftests/mm: Workaround no way to detect uffd-minor + wp
Date:   Thu, 30 Mar 2023 12:08:33 -0400
Message-Id: <20230330160833.3107602-1-peterx@redhat.com>
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
index 376dfa320b6f..82fd3aaa06c2 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -784,7 +784,13 @@ uffd_test_case_t uffd_tests[] = {
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

