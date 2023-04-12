Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256516DEC66
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjDLHSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDLHSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:18:07 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014081713
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:18:00 -0700 (PDT)
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id HBD00056;
        Wed, 12 Apr 2023 15:17:56 +0800
Received: from localhost.localdomain.com (10.200.104.82) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.21; Wed, 12 Apr 2023 15:17:55 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] tools/virtio/ringtest: Replace obsolete memalign() with posix_memalign()
Date:   Wed, 12 Apr 2023 03:17:53 -0400
Message-ID: <20230412071753.1966-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   202341215175682d1f7c533356d546f6d3bdac4f0bacd
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memalign() is obsolete according to its manpage.

Replace memalign() with posix_memalign() and remove malloc.h include
that was there for memalign().

As a pointer is passed into posix_memalign(), initialize *p to NULL
to silence a warning about the function's return value being used as
uninitialized (which is not valid anyway because the error is properly
checked before p is returned).

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 tools/virtio/ringtest/ptr_ring.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/virtio/ringtest/ptr_ring.c b/tools/virtio/ringtest/ptr_ring.c
index c9b26335f891..a0bf4978eace 100644
--- a/tools/virtio/ringtest/ptr_ring.c
+++ b/tools/virtio/ringtest/ptr_ring.c
@@ -26,9 +26,12 @@ typedef int gfp_t;
 
 static void *kmalloc(unsigned size, gfp_t gfp)
 {
-	void *p = memalign(64, size);
-	if (!p)
-		return p;
+	void *p;
+	int ret;
+
+	ret = posix_memalign(&p, 64, size)
+	if (ret < 0)
+		return NULL;
 
 	if (gfp & __GFP_ZERO)
 		memset(p, 0, size);
-- 
2.27.0

