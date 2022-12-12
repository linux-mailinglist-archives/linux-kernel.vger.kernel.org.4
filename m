Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5C464A6D9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiLLSVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiLLSV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:21:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70651E31
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670869229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wKvRIO4qKG6iczskSWCLDSh7tBhagcatV42gi39S0ik=;
        b=ORjBJehjUqVHN0RVsBfMogCCW7Pcxm2zKVMHPdBgfwOnYCaXCOlTmpD97pxzVdRnqIfdXf
        jS7e48osNbmPqcVQOeWXUY9bmU3+saWvV+bDD9HRMiDHDY9P5CuRiIreNCgVcEuirZg3IG
        Yz7SMqcfFZx093G7iWYRd3L+PBK9tqE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-Ftdw1M7zMmqS-nsNq-Icvw-1; Mon, 12 Dec 2022 13:20:23 -0500
X-MC-Unique: Ftdw1M7zMmqS-nsNq-Icvw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77B1F29324A1;
        Mon, 12 Dec 2022 18:20:23 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC09CC15BAD;
        Mon, 12 Dec 2022 18:20:21 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH mm-stable] mm/gup_test: free memory allocated via kvcalloc() using kvfree()
Date:   Mon, 12 Dec 2022 19:20:18 +0100
Message-Id: <20221212182018.264900-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have to free via kvfree(), not via kfree().

Fixes: c77369b437f9 ("mm/gup_test: start/stop/read functionality for PIN LONGTERM test")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup_test.c b/mm/gup_test.c
index 33f431e0da60..8ae7307a1bb6 100644
--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -214,7 +214,7 @@ static inline void pin_longterm_test_stop(void)
 		if (pin_longterm_test_nr_pages)
 			unpin_user_pages(pin_longterm_test_pages,
 					 pin_longterm_test_nr_pages);
-		kfree(pin_longterm_test_pages);
+		kvfree(pin_longterm_test_pages);
 		pin_longterm_test_pages = NULL;
 		pin_longterm_test_nr_pages = 0;
 	}
@@ -255,7 +255,7 @@ static inline int pin_longterm_test_start(unsigned long arg)
 	fast = !!(args.flags & PIN_LONGTERM_TEST_FLAG_USE_FAST);
 
 	if (!fast && mmap_read_lock_killable(current->mm)) {
-		kfree(pages);
+		kvfree(pages);
 		return -EINTR;
 	}
 
-- 
2.38.1

