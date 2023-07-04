Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2CB747701
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjGDQmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjGDQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB2910D8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688488863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h3fmV53fwhiWk7sQEChyplGv7CVi08pMxUVWbzUrLYY=;
        b=SQD7+wgtnB08hvcp5lUn9+VuXakI+kxin56HYjkAD/jbUUB9ReSu/SL6egDQa5+ADC/aGi
        0Z5rhilu43C5TSTqvayTpwB/xMfrW3oVkDLWiVQEKx2hoSaAqC+Nrl0hsR3ucBFGhENH7A
        5XGtFL2XpGYC3vr7mLx/4mZP702ReV4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-eJ42uQqnNNqHjT5-jlVUrw-1; Tue, 04 Jul 2023 12:40:59 -0400
X-MC-Unique: eJ42uQqnNNqHjT5-jlVUrw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B6FE38008B2;
        Tue,  4 Jul 2023 16:40:59 +0000 (UTC)
Received: from max-t490s.redhat.com (unknown [10.39.208.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0A1E492B02;
        Tue,  4 Jul 2023 16:40:56 +0000 (UTC)
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
To:     xieyongji@bytedance.com, jasowang@redhat.com, mst@redhat.com,
        david.marchand@redhat.com, lulu@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
        Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v2 3/3] vduse: Temporarily disable control queue features
Date:   Tue,  4 Jul 2023 18:40:45 +0200
Message-ID: <20230704164045.39119-4-maxime.coquelin@redhat.com>
In-Reply-To: <20230704164045.39119-1-maxime.coquelin@redhat.com>
References: <20230704164045.39119-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtio-net driver control queue implementation is not safe
when used with VDUSE. If the VDUSE application does not
reply to control queue messages, it currently ends up
hanging the kernel thread sending this command.

Some work is on-going to make the control queue
implementation robust with VDUSE. Until it is completed,
let's disable control virtqueue and features that depend on
it.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 1271c9796517..04367a53802b 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1778,6 +1778,25 @@ static struct attribute *vduse_dev_attrs[] = {
 
 ATTRIBUTE_GROUPS(vduse_dev);
 
+static void vduse_dev_features_fixup(struct vduse_dev_config *config)
+{
+	if (config->device_id == VIRTIO_ID_NET) {
+		/*
+		 * Temporarily disable control virtqueue and features that
+		 * depend on it while CVQ is being made more robust for VDUSE.
+		 */
+		config->features &= ~((1ULL << VIRTIO_NET_F_CTRL_VQ) |
+				(1ULL << VIRTIO_NET_F_CTRL_RX) |
+				(1ULL << VIRTIO_NET_F_CTRL_VLAN) |
+				(1ULL << VIRTIO_NET_F_GUEST_ANNOUNCE) |
+				(1ULL << VIRTIO_NET_F_MQ) |
+				(1ULL << VIRTIO_NET_F_CTRL_MAC_ADDR) |
+				(1ULL << VIRTIO_NET_F_RSS) |
+				(1ULL << VIRTIO_NET_F_HASH_REPORT) |
+				(1ULL << VIRTIO_NET_F_NOTF_COAL));
+	}
+}
+
 static int vduse_create_dev(struct vduse_dev_config *config,
 			    void *config_buf, u64 api_version)
 {
@@ -1793,6 +1812,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	if (!dev)
 		goto err;
 
+	vduse_dev_features_fixup(config);
+
 	dev->api_version = api_version;
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
-- 
2.41.0

