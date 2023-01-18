Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE36723EE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjARQqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjARQpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:45:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6685D582AA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674060253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHqIpzQSkuEl19TQY/3XES0k5HPtR7PzJw91HkmdGrE=;
        b=UK3L84TPIeY/Ia5ttYrHvRvXpk44Ep/TNNwL1+4BqEOdGMXerU3ce6WjGRI0lTHbgmZAxb
        KxKAYBprKc8q6tTnxd76l26gQdoxF5xRGH2t2CvJSXCwhLDRdSG7VRldN63zAV39JwYpF0
        b6DlrpbkZevbOF+rscsaKqzlovpnrmM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-qnHa-CyiOPyF5XEt1aLMuQ-1; Wed, 18 Jan 2023 11:44:12 -0500
X-MC-Unique: qnHa-CyiOPyF5XEt1aLMuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 979113804527;
        Wed, 18 Jan 2023 16:44:08 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EE30140EBF6;
        Wed, 18 Jan 2023 16:44:06 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     mst@redhat.com
Cc:     leiyang@redhat.com, Laurent Vivier <lvivier@redhat.com>,
        sgarzare@redhat.com, jasowang@redhat.com,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        linux-kernel@vger.kernel.org, lulu@redhat.com,
        Gautam Dawar <gdawar@xilinx.com>, alvaro.karsz@solid-run.com
Subject: [PATCH 2/2] vringh: fetch used_idx from vring at vringh_init_iotlb
Date:   Wed, 18 Jan 2023 17:43:59 +0100
Message-Id: <20230118164359.1523760-3-eperezma@redhat.com>
In-Reply-To: <20230118164359.1523760-1-eperezma@redhat.com>
References: <20230118164359.1523760-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from an used_idx different than 0 is needed in use cases like
virtual machine migration.  Not doing so and letting the caller set an
avail idx different than 0 causes destination device to try to use old
buffers that source driver already recover and are not available
anymore.

While callers like vdpa_sim set avail_idx directly it does not set
used_idx.  Instead of let the caller do the assignment, fetch it from
the guest at initialization like vhost-kernel do.

To perform the same at vring_kernel_init and vring_user_init is left for
the future.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vhost/vringh.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 33eb941fcf15..0eed825197f2 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1301,6 +1301,17 @@ static inline int putused_iotlb(const struct vringh *vrh,
 	return 0;
 }
 
+/**
+ * vringh_update_used_idx - fetch used idx from driver's used split vring
+ * @vrh: The vring.
+ *
+ * Returns -errno or 0.
+ */
+static inline int vringh_update_used_idx(struct vringh *vrh)
+{
+	return getu16_iotlb(vrh, &vrh->last_used_idx, &vrh->vring.used->idx);
+}
+
 /**
  * vringh_init_iotlb - initialize a vringh for a ring with IOTLB.
  * @vrh: the vringh to initialize.
@@ -1319,8 +1330,18 @@ int vringh_init_iotlb(struct vringh *vrh, u64 features,
 		      struct vring_avail *avail,
 		      struct vring_used *used)
 {
-	return vringh_init_kern(vrh, features, num, weak_barriers,
-				desc, avail, used);
+	int r = vringh_init_kern(vrh, features, num, weak_barriers, desc,
+				 avail, used);
+
+	if (r != 0)
+		return r;
+
+	/* Consider the ring not initialized */
+	if ((void *)desc == used)
+		return 0;
+
+	return vringh_update_used_idx(vrh);
+
 }
 EXPORT_SYMBOL(vringh_init_iotlb);
 
-- 
2.31.1

