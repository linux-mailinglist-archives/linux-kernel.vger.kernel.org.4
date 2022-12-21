Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A1F652CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiLUGSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiLUGSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:18:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B21B1EC71
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671603433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efTUIZYKkcN6gJm1sKkzjaOGjtEXRgR99AIquQd4Vbw=;
        b=ES9ZeoPJ/p+Z4xyVxLTib76SI8KaUqgW4EZXKI0k3PVYAAJG2+DXes5y104pOeHfk7c2oT
        Rs4fkWzHSzHSttcuhXIqY/QTqGgx9JQT8tyglCV2fWUAGuHT7bUyy5Yzw55GbRG+RE1G0P
        Km86HHI/1KwZyVTWQz2JdRNp7anv9Wo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-lR64KuZONDOe9vjW3QznTA-1; Wed, 21 Dec 2022 01:17:09 -0500
X-MC-Unique: lR64KuZONDOe9vjW3QznTA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34FB23813F2B;
        Wed, 21 Dec 2022 06:17:09 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-236.pek2.redhat.com [10.72.13.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 986562166B26;
        Wed, 21 Dec 2022 06:17:06 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     sgarzare@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] vdpa_sim: support vendor satistics
Date:   Wed, 21 Dec 2022 14:16:51 +0800
Message-Id: <20221221061652.15202-4-jasowang@redhat.com>
In-Reply-To: <20221221061652.15202-1-jasowang@redhat.com>
References: <20221221061652.15202-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 55aaa023a6e2..02e892f819e7 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -426,6 +426,18 @@ static int vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
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
+	return -EINVAL;
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

