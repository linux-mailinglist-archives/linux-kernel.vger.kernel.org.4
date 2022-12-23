Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF59654C56
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 06:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiLWF45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 00:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiLWF4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 00:56:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33D963D9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 21:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671774965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wv+IEcA7/J3RltAXesX4+KgFk8vshmbgrHzr3MZHu0Q=;
        b=B7Cch5LU98EtRDCd58Vfe1Nnc1sPKHbe3YmoKSd2dTl2tuSoKYa114iqLjiNrKDiFN96B2
        lnpWv5dVJGGuy9e6NoGpZIDH9jkiR/JT8txungbZAGTV91LLy4MzSdtg5JiHbSgil361Lk
        xYxMI9r248XGqXi/EzRmIDP9G2ICW1I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-sh02hvWLPMyizWEvAw7SDw-1; Fri, 23 Dec 2022 00:56:03 -0500
X-MC-Unique: sh02hvWLPMyizWEvAw7SDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AB7E1C05EAC;
        Fri, 23 Dec 2022 05:56:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-204.pek2.redhat.com [10.72.12.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ADA8A40C2004;
        Fri, 23 Dec 2022 05:56:00 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     sgarzare@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/4] vdpa_sim: support vendor statistics
Date:   Fri, 23 Dec 2022 13:55:47 +0800
Message-Id: <20221223055548.27810-4-jasowang@redhat.com>
In-Reply-To: <20221223055548.27810-1-jasowang@redhat.com>
References: <20221223055548.27810-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new config ops callback to allow individual
simulator to implement the vendor stats callback.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 14 ++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 341da107e7da..45d3f84b7937 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -424,6 +424,18 @@ static int vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 	return 0;
 }
 
+static int vdpasim_get_vq_stats(struct vdpa_device *vdpa, u16 idx,
+				struct sk_buff *msg,
+				struct netlink_ext_ack *extack)
+{
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	if (vdpasim->dev_attr.get_stats)
+		return vdpasim->dev_attr.get_stats(vdpasim, idx,
+						   msg, extack);
+	return -EOPNOTSUPP;
+}
+
 static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
 {
 	return VDPASIM_QUEUE_ALIGN;
@@ -710,6 +722,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.set_vq_ready           = vdpasim_set_vq_ready,
 	.get_vq_ready           = vdpasim_get_vq_ready,
 	.set_vq_state           = vdpasim_set_vq_state,
+	.get_vendor_vq_stats    = vdpasim_get_vq_stats,
 	.get_vq_state           = vdpasim_get_vq_state,
 	.get_vq_align           = vdpasim_get_vq_align,
 	.get_vq_group           = vdpasim_get_vq_group,
@@ -743,6 +756,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.set_vq_ready           = vdpasim_set_vq_ready,
 	.get_vq_ready           = vdpasim_get_vq_ready,
 	.set_vq_state           = vdpasim_set_vq_state,
+	.get_vendor_vq_stats    = vdpasim_get_vq_stats,
 	.get_vq_state           = vdpasim_get_vq_state,
 	.get_vq_align           = vdpasim_get_vq_align,
 	.get_vq_group           = vdpasim_get_vq_group,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 51c070a543f1..d2a08c0abad7 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -48,6 +48,9 @@ struct vdpasim_dev_attr {
 	work_func_t work_fn;
 	void (*get_config)(struct vdpasim *vdpasim, void *config);
 	void (*set_config)(struct vdpasim *vdpasim, const void *config);
+	int (*get_stats)(struct vdpasim *vdpasim, u16 idx,
+			 struct sk_buff *msg,
+			 struct netlink_ext_ack *extack);
 };
 
 /* State of each vdpasim device */
-- 
2.25.1

