Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F153A6731AE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 07:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjASGRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 01:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjASGQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:16:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8393E654E9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 22:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674108955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+SMXVPjE8hhIEfNKKmiT1OISlo/3YeTVVQSZ6tsGfyw=;
        b=E4aJJE21ZfCud8z4vU2Q0H93kMyNwuHIGHJHffsm7jv6XhWqO2823Gj/rgzgGbqstQr0Tv
        vDMGLIpu5+M55T/YfRaYRt4I2r/5vsXnNVDppU7N7LJib7haQTVT/FKKZAw/TtjJF9X1Ct
        oQVnCyIDGh/3LRxQAXv1xMFdRhqJx7E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-RCiPZeyiPgOMvVWjSTK2PA-1; Thu, 19 Jan 2023 01:15:50 -0500
X-MC-Unique: RCiPZeyiPgOMvVWjSTK2PA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1298811E9C;
        Thu, 19 Jan 2023 06:15:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-97.pek2.redhat.com [10.72.13.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F04E1121315;
        Thu, 19 Jan 2023 06:15:45 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     elic@nvidia.com, gdawar@amd.com, tanuj.kamde@amd.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH V2 4/5] vdpa: set dma mask for vDPA device
Date:   Thu, 19 Jan 2023 14:15:24 +0800
Message-Id: <20230119061525.75068-5-jasowang@redhat.com>
In-Reply-To: <20230119061525.75068-1-jasowang@redhat.com>
References: <20230119061525.75068-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

Reviewed-by: Eli Cohen <elic@nvidia.com>
Tested-by: Eli Cohen <elic@nvidia.com>
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

