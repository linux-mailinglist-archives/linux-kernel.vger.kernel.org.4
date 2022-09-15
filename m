Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94265B96AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiIOIvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiIOIvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7245A8A7C4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663231872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8XmPJuB5tHNskXmGICX1EPUx87n5D6gb1Ho2lhilDoU=;
        b=XQOM6XyC/nbnnF9CdfE6hpcWJsYR1GszTt+lPcXt3oi7TedRf+E2nL2tnuinulAmHjYYvJ
        Dm4/c08Gwlbi19Yq/UH3dWbQ7czfbwXvaH5mXISax/uFj0Rkbth+6/fdVLzNUWq+El2pGv
        FfChaTLiLrb+n1b2LIEa+3mMCQw1Zdo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-TwSQuAN9N4qtM2J1_2a_hQ-1; Thu, 15 Sep 2022 04:51:09 -0400
X-MC-Unique: TwSQuAN9N4qtM2J1_2a_hQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4D321012461;
        Thu, 15 Sep 2022 08:51:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-201.pek2.redhat.com [10.72.12.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB74C1759E;
        Thu, 15 Sep 2022 08:51:03 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     elic@nvidia.com, si-wei.liu@oracle.com, parav@nvidia.com,
        wuzongyong@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com,
        lingshan.zhu@intel.com, gdawar@xilinx.com, lulu@redhat.com,
        xieyongji@bytedance.com
Subject: [PATCH 2/3] vdpa_sim_net: support feature provisioning
Date:   Thu, 15 Sep 2022 16:50:47 +0800
Message-Id: <20220915085048.12840-3-jasowang@redhat.com>
In-Reply-To: <20220915085048.12840-1-jasowang@redhat.com>
References: <20220915085048.12840-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements features provisioning for vdpa_sim_net.

1) validating the provisioned features to be a subset of the parent
   features.
2) clearing the features that is not wanted by the  userspace

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 886449e88502..a9ba02be378b 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	dev_attr.work_fn = vdpasim_net_work;
 	dev_attr.buffer_size = PAGE_SIZE;
 
+	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
+		if (config->device_features &
+		    ~dev_attr.supported_features)
+			return -EINVAL;
+		dev_attr.supported_features &=
+			 config->device_features;
+	}
+
 	simdev = vdpasim_create(&dev_attr);
 	if (IS_ERR(simdev))
 		return PTR_ERR(simdev);
@@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
 	.id_table = id_table,
 	.ops = &vdpasim_net_mgmtdev_ops,
 	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
-			     1 << VDPA_ATTR_DEV_NET_CFG_MTU),
+			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
+		             1 << VDPA_ATTR_DEV_FEATURES),
 	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
 	.supported_features = VDPASIM_NET_FEATURES,
 };
-- 
2.25.1

