Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B0A72951A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241481AbjFIJ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241464AbjFIJ27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9193C3F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686302500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yrvz2NuuJ8t+PjTH8hQDFouZJRAvGRd7mM5s6NiOOaU=;
        b=VEulbuZSenqb41bfbWhG5LSAnkrDQxkv+G06R0rA4DQvEJocA7GFOw2zlKwzwbM3bvHa48
        tVcFzpc0eE6DKGi00AGSTrwFo7koBHiIgTPhlYh3lWjo20TW/k1ZKhHXJ2HlRjoHn2zNNy
        RrKg5qyuTcZwSpvSuVlamYgA2AfnL/I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-jjshG5t0OBG9vTCK3FCePw-1; Fri, 09 Jun 2023 05:21:37 -0400
X-MC-Unique: jjshG5t0OBG9vTCK3FCePw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 405448028B2;
        Fri,  9 Jun 2023 09:21:36 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C101202696C;
        Fri,  9 Jun 2023 09:21:33 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     mst@redhat.com, Jason Wang <jasowang@redhat.com>
Cc:     Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization@lists.linux-foundation.org,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng2@huawei.com,
        Lei Yang <leiyang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Gautam Dawar <gdawar@xilinx.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>, linux-api@vger.kernel.org,
        Liuxiangdong <liuxiangdong5@huawei.com>,
        linux-kernel@vger.kernel.org, alvaro.karsz@solid-run.com,
        Shannon Nelson <snelson@pensando.io>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Cindy Lu <lulu@redhat.com>, si-wei.liu@oracle.com,
        Harpreet Singh Anand <hanand@xilinx.com>
Subject: [PATCH v2 1/4] vdpa: add VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag
Date:   Fri,  9 Jun 2023 11:21:24 +0200
Message-Id: <20230609092127.170673-2-eperezma@redhat.com>
In-Reply-To: <20230609092127.170673-1-eperezma@redhat.com>
References: <20230609092127.170673-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This feature flag allows the driver enabling virtqueues both before and
after DRIVER_OK.

This is needed for software assisted live migration, so userland can
restore the device status in devices with control virtqueue before the
dataplane is enabled.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Shannon Nelson <shannon.nelson@amd.com>
---
 include/uapi/linux/vhost_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index c5690a8992d8..4889e6d70b15 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -165,5 +165,9 @@ struct vhost_vdpa_iova_range {
 #define VHOST_BACKEND_F_SUSPEND  0x4
 /* Device can be resumed */
 #define VHOST_BACKEND_F_RESUME  0x5
+/* Device supports the driver enabling virtqueues both before and after
+ * DRIVER_OK
+ */
+#define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
 
 #endif
-- 
2.31.1

