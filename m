Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1FC66549A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbjAKG3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjAKG3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:29:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B53631E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673418514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+4wcK32yTG8RIPffsWit0AM8U7mssDeI6INzJz2GeQ=;
        b=JnM9I9pgJVzW+jG3yMgt8Gi21WUsINU0uZb9nhc3o8sS78kxwP/OcyZ65q16XtITK994fa
        S+QmvdzO4I4j+B4uAmQIW7WawyvmYgxJbc7BVs6fsAmT2ByKdqamnztpuj9cxKPUaF6bSn
        DMVSZuzGY83HhUtYzFBqhDaKgpa3DP8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-_n38zNkSN4y1z_p4rB0FMQ-1; Wed, 11 Jan 2023 01:28:31 -0500
X-MC-Unique: _n38zNkSN4y1z_p4rB0FMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B89D2A59557;
        Wed, 11 Jan 2023 06:28:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-175.pek2.redhat.com [10.72.13.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E61B4078903;
        Wed, 11 Jan 2023 06:28:27 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     elic@nvidia.com, gdawar@amd.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tanuj.kamde@amd.com
Subject: [PATCH 4/5] vdpa: set dma mask for vDPA device
Date:   Wed, 11 Jan 2023 14:28:08 +0800
Message-Id: <20230111062809.25020-5-jasowang@redhat.com>
In-Reply-To: <20230111062809.25020-1-jasowang@redhat.com>
References: <20230111062809.25020-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting DMA mask for vDPA device in case that there are virtqueue that
is not backed by DMA so the vDPA device could be advertised as the DMA
device that is used by DMA API for software emulated virtqueues.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 8ef7aa1365cc..6821b2850bbb 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -39,6 +39,11 @@ static int vdpa_dev_probe(struct device *d)
 	u32 max_num, min_num = 1;
 	int ret = 0;
 
+	d->dma_mask = &d->coherent_dma_mask;
+	ret = dma_set_mask_and_coherent(d, DMA_BIT_MASK(64));
+	if (ret)
+		return ret;
+
 	max_num = ops->get_vq_num_max(vdev);
 	if (ops->get_vq_num_min)
 		min_num = ops->get_vq_num_min(vdev);
-- 
2.25.1

