Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BF05E58BF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 04:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIVCnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 22:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiIVCnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:43:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E91ACA1A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 19:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663814614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=voAQSkJZsqEcFHoE05kFOKlNJJihIbhmQEwAm2HrkYI=;
        b=W/ViMObWCqT3JP3Nck3DuuG2Sep9TNuyKY6dgyDtER3TboS0ERAdzkNmTKA3adD1njg270
        ByJrXxeUjpnXIVPu68A8TV7jOHsbodxASwGxRDXCYZsU1mBi0nWgb+A2tifNxFSCiiwJV/
        WUXpC22KS4c8363NOqvPZbnOTJgaTrs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-vpxGZcnCPNGHGUaF0l8ATQ-1; Wed, 21 Sep 2022 22:43:29 -0400
X-MC-Unique: vpxGZcnCPNGHGUaF0l8ATQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 950CD1C05AA7;
        Thu, 22 Sep 2022 02:43:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-82.pek2.redhat.com [10.72.13.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A43E4140EBF3;
        Thu, 22 Sep 2022 02:43:22 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     elic@nvidia.com, si-wei.liu@oracle.com, parav@nvidia.com,
        wuzongyong@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com,
        lingshan.zhu@intel.com, gdawar@xilinx.com, lulu@redhat.com,
        xieyongji@bytedance.com
Subject: [PATCH V2 1/3] vdpa: device feature provisioning
Date:   Thu, 22 Sep 2022 10:43:03 +0800
Message-Id: <20220922024305.1718-2-jasowang@redhat.com>
In-Reply-To: <20220922024305.1718-1-jasowang@redhat.com>
References: <20220922024305.1718-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows the device features to be provisioned through
netlink. A new attribute is introduced to allow the userspace to pass
a 64bit device features during device adding.

This provides several advantages:

- Allow to provision a subset of the features to ease the cross vendor
  live migration.
- Better debug-ability for vDPA framework and parent.

Reviewed-by: Eli Cohen <elic@nvidia.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa.c       | 5 +++++
 include/linux/vdpa.h      | 1 +
 include/uapi/linux/vdpa.h | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index c06c02704461..278e26bfa492 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -600,6 +600,11 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 		}
 		config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
 	}
+	if (nl_attrs[VDPA_ATTR_DEV_FEATURES]) {
+		config.device_features =
+			nla_get_u64(nl_attrs[VDPA_ATTR_DEV_FEATURES]);
+		config.mask |= BIT_ULL(VDPA_ATTR_DEV_FEATURES);
+	}
 
 	/* Skip checking capability if user didn't prefer to configure any
 	 * device networking attributes. It is likely that user might have used
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index d282f464d2f1..6d0f5e4e82c2 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -104,6 +104,7 @@ struct vdpa_iova_range {
 };
 
 struct vdpa_dev_set_config {
+	u64 device_features;
 	struct {
 		u8 mac[ETH_ALEN];
 		u16 mtu;
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 25c55cab3d7c..9dc855f37c59 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -52,6 +52,8 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
 	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
 
+	VDPA_ATTR_DEV_FEATURES,                 /* u64 */
+
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
 };
-- 
2.25.1

