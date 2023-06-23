Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226E873C24F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjFWVPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjFWVPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:15:17 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E57189;
        Fri, 23 Jun 2023 14:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8WWGDy69qrtzavSblwBRgHQbwXA80r1Q53C16BTDHPg=;
  b=Nf2/PyVP65m4zS14KRN+iZPPDLs/1MtgDOLaD5cMvJhgt0f/01EceRnR
   jgPoDPxYGosXJu/ZTArJNQFAaCz5QS5fBWEzE7SX5MXsWerfQlC0Ssb1x
   C5j6BWtq+9VXv9wmH8wzYLLYHbEQB/XuYhxgc+ye2WpqAzpvKugTAcvbM
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686166"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:15:11 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     David Hildenbrand <david@redhat.com>
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/26] virtio-mem: use array_size
Date:   Fri, 23 Jun 2023 23:14:39 +0200
Message-Id: <20230623211457.102544-9-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230623211457.102544-1-Julia.Lawall@inria.fr>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use array_size to protect against multiplication overflows.

The changes were done using the following Coccinelle semantic patch:

// <smpl>
@@
    expression E1, E2;
    constant C1, C2;
    identifier alloc = {vmalloc,vzalloc};
@@
    
(
      alloc(C1 * C2,...)
|
      alloc(
-           (E1) * (E2)
+           array_size(E1, E2)
      ,...)
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/virtio/virtio_mem.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 835f6cc2fb66..a4dfe7aab288 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -399,7 +399,7 @@ static int virtio_mem_bbm_bb_states_prepare_next_bb(struct virtio_mem *vm)
 	if (vm->bbm.bb_states && old_pages == new_pages)
 		return 0;
 
-	new_array = vzalloc(new_pages * PAGE_SIZE);
+	new_array = vzalloc(array_size(new_pages, PAGE_SIZE));
 	if (!new_array)
 		return -ENOMEM;
 
@@ -465,7 +465,7 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
 	if (vm->sbm.mb_states && old_pages == new_pages)
 		return 0;
 
-	new_array = vzalloc(new_pages * PAGE_SIZE);
+	new_array = vzalloc(array_size(new_pages, PAGE_SIZE));
 	if (!new_array)
 		return -ENOMEM;
 
@@ -588,7 +588,7 @@ static int virtio_mem_sbm_sb_states_prepare_next_mb(struct virtio_mem *vm)
 	if (vm->sbm.sb_states && old_pages == new_pages)
 		return 0;
 
-	new_bitmap = vzalloc(new_pages * PAGE_SIZE);
+	new_bitmap = vzalloc(array_size(new_pages, PAGE_SIZE));
 	if (!new_bitmap)
 		return -ENOMEM;
 

