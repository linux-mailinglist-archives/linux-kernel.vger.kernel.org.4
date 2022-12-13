Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7390164B201
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbiLMJNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbiLMJMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:12:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA3F1C926
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670922446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xS/8xvH79U0/asorExnaiOvmHaZmjwQI42/K+CiILXM=;
        b=NrjwPczThD4EPXnlsSblcpO9b1Jqq0dEbA3CGJw4ePC0yJzMIq46B+eIQ//lHb9CwMvtNH
        PwSVT2ppkE28Ez0And3Gr+Zd5P9Zwi8TqM+nmK6pvrVoFEBBAlTGLFnjkGwnlsSEMv/m3l
        OVv8SAsppSzBE/tGkxJjdFxiCP2KUS8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-kxxqnWQ-PKmhloyUxEmFuA-1; Tue, 13 Dec 2022 04:07:23 -0500
X-MC-Unique: kxxqnWQ-PKmhloyUxEmFuA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19AF085A5B6;
        Tue, 13 Dec 2022 09:07:23 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-188.pek2.redhat.com [10.72.13.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9D9A492B00;
        Tue, 13 Dec 2022 09:07:20 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     gautam.dawar@xilinx.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vdpasim: fix memory leak when freeing IOTLBs
Date:   Tue, 13 Dec 2022 17:07:17 +0800
Message-Id: <20221213090717.61529-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit bda324fd037a ("vdpasim: control virtqueue support"),
vdpasim->iommu became an array of IOTLB, so we should clean the
mappings of each free one by one instead of just deleting the ranges
in the first IOTLB which may leak maps.

Fixes: bda324fd037a ("vdpasim: control virtqueue support")
Cc: Gautam Dawar <gautam.dawar@xilinx.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index b071f0d842fb..9668dc477843 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -690,7 +690,9 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	}
 
 	kvfree(vdpasim->buffer);
-	vhost_iotlb_free(vdpasim->iommu);
+	for (i = 0; i < vdpasim->dev_attr.nas; i++)
+		vhost_iotlb_reset(&vdpasim->iommu[i]);
+	kfree(vdpasim->iommu);
 	kfree(vdpasim->vqs);
 	kfree(vdpasim->config);
 }
-- 
2.25.1

