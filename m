Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D7C6E6ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjDRRQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDRRQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BACD13C06
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681838137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=914MbDCapASQxkK9BuyG9zv/qlx7fwHmIuJzggClNB8=;
        b=YfUDg95rEqPqVXorOmWHQ9LrAR976TPtw2mpe6ij83xxr4PJPiWzjf7EbH9Ccp/Cz5NRdD
        vGsM4tjoCPyso+VDzfXeSMSUlkCH8iB5vOfROfqm8MotK4Hyj3X4wLMbF90Gm5xY0/4n53
        jYYp3r4NIadfyDSYN7sRl5ekXZ5uO4Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-YKyY_ucKP2uNreI52tG6sw-1; Tue, 18 Apr 2023 13:15:31 -0400
X-MC-Unique: YKyY_ucKP2uNreI52tG6sw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7696E101A551;
        Tue, 18 Apr 2023 17:15:28 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.10.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C23540C20FA;
        Tue, 18 Apr 2023 17:15:27 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
        arthurgrillo@riseup.net, davidgow@google.com, javierm@redhat.com,
        christian.koenig@amd.com, mairacanal@riseup.net, daniel@ffwll.ch,
        airlied@gmail.com, ddutile@redhat.com, kunit-dev@googlegroups.com
Subject: [PATCH] kunit: drm: make DRM buddy test compatible with other pages sizes
Date:   Tue, 18 Apr 2023 11:15:24 -0600
Message-Id: <20230418171524.274386-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM buddy test uses a fixed 12 bit shift to covert from pages to 
bytes. This number is then used to confirm that (chunk_size < PAGE_SIZE)
which can lead to a failing drm_buddy_init on systems with PAGE_SIZE > 4k.

Fixes: 92937f170d3f ("drm/selftests: add drm buddy alloc range testcase")
Signed-off-by: Nico Pache <npache@redhat.com>
---
 drivers/gpu/drm/tests/drm_buddy_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
index 09ee6f6af896..a62b2690d3c2 100644
--- a/drivers/gpu/drm/tests/drm_buddy_test.c
+++ b/drivers/gpu/drm/tests/drm_buddy_test.c
@@ -318,8 +318,8 @@ static void mm_config(u64 *size, u64 *chunk_size)
 	s &= -ms;
 
 	/* Convert from pages to bytes */
-	*chunk_size = (u64)ms << 12;
-	*size = (u64)s << 12;
+	*chunk_size = (u64)ms << PAGE_SHIFT;
+	*size = (u64)s << PAGE_SHIFT;
 }
 
 static void drm_test_buddy_alloc_pathological(struct kunit *test)
-- 
2.39.2

