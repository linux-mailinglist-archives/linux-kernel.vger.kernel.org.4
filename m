Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B276C634BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiKWA72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiKWA7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:59:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C80AFE65
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 16:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669165099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FRXQzInu4Oq+Sfj0rM7dyXyjMHp78R6zBNAHLpf5AvU=;
        b=jUpgEAT4QRjW17MR7Z4fdTjnekXLW/CnSYdAYEk6ZMw7QpDPl2kxVLhGPiCxUedCnSEnmP
        zDrPseFUHgOmk5gIkR8YPJOII5W2cXoOVRRNdhb8qHmhd7/jD2HqHP2UKkdmbGam86pWOE
        0mdxw2x1sz0hs0JuB5uWYM+UpZ/MncQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-XCEd7GhINXuqIGb4MCnXLQ-1; Tue, 22 Nov 2022 19:58:15 -0500
X-MC-Unique: XCEd7GhINXuqIGb4MCnXLQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6256C811E67;
        Wed, 23 Nov 2022 00:58:15 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-62.bne.redhat.com [10.64.54.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02F044A9254;
        Wed, 23 Nov 2022 00:58:11 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        william.kucharski@oracle.com, ziy@nvidia.com,
        kirill.shutemov@linux.intel.com, david@redhat.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com
Subject: [PATCH] mm: migrate: Fix THP's mapcount on isolation
Date:   Wed, 23 Nov 2022 08:57:52 +0800
Message-Id: <20221123005752.161003-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue is reported when removing memory through virtio_mem device.
The transparent huge page, experienced copy-on-write fault, is wrongly
regarded as pinned. The transparent huge page is escaped from being
isolated in isolate_migratepages_block(). The transparent huge page
can't be migrated and the corresponding memory block can't be put
into offline state.

Fix it by replacing page_mapcount() with total_mapcount(). With this,
the transparent huge page can be isolated and migrated, and the memory
block can be put into offline state.

Fixes: 3917c80280c9 ("thp: change CoW semantics for anon-THP")
Cc: stable@vger.kernel.org   # v5.8+
Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/compaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index c51f7f545afe..c408b5e04c1d 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -990,7 +990,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 * admittedly racy check.
 		 */
 		mapping = page_mapping(page);
-		if (!mapping && page_count(page) > page_mapcount(page))
+		if (!mapping && page_count(page) > total_mapcount(page))
 			goto isolate_fail;
 
 		/*
-- 
2.23.0

