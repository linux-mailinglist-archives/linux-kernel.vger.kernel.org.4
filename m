Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4266E2E92
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 04:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDOCVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 22:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjDOCU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 22:20:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B552130
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 19:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681525209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EbchukXhmamBCY4yfdTiw3lkj6XszMDdhtygCuSoX2M=;
        b=dry5TG1B3rW3fk87kzmw4L3zIbHVT9JgXP0mfrMX+Q5/uXmBfJsS5C82SFcxEX0HbEd3Xp
        6LT0f8TZ8JCkSEWAdExGAYbF2ElAxLLZZBsFoN7Me8nMjj67lVRyYQ+G+K50Mw5xj1FuQq
        c2swSE0DV52Fhh0D2zqEeUfqSq12FbU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-B07pot0kPLylViyUjY6cqw-1; Fri, 14 Apr 2023 22:20:05 -0400
X-MC-Unique: B07pot0kPLylViyUjY6cqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74A1080C8C7;
        Sat, 15 Apr 2023 02:20:05 +0000 (UTC)
Received: from server.redhat.com (ovpn-12-28.pek2.redhat.com [10.72.12.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C12B1140EBF4;
        Sat, 15 Apr 2023 02:20:02 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] vhost_vdpa: fix unmap process in no-batch mode
Date:   Sat, 15 Apr 2023 10:19:59 +0800
Message-Id: <20230415021959.197891-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While using the no-batch mode with vIOMMU enabled
Qemu will call a large memory to unmap. Much larger than the memory
mapped to the kernel. The iotlb is NULL in the kernel and will return fail.
Which causes failure.
To fix this, we will not remove the AS while the iotlb->nmaps is 0.
This will free in the vhost_vdpa_clean

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vdpa.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 7be9d9d8f01c..74c7d1f978b7 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -851,11 +851,7 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v,
 		if (!v->in_batch)
 			ops->set_map(vdpa, asid, iotlb);
 	}
-	/* If we are in the middle of batch processing, delay the free
-	 * of AS until BATCH_END.
-	 */
-	if (!v->in_batch && !iotlb->nmaps)
-		vhost_vdpa_remove_as(v, asid);
+
 }
 
 static int vhost_vdpa_va_map(struct vhost_vdpa *v,
@@ -1112,8 +1108,6 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
 		if (v->in_batch && ops->set_map)
 			ops->set_map(vdpa, asid, iotlb);
 		v->in_batch = false;
-		if (!iotlb->nmaps)
-			vhost_vdpa_remove_as(v, asid);
 		break;
 	default:
 		r = -EINVAL;
-- 
2.34.3

