Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EE9654C53
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 06:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiLWF4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 00:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLWF4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 00:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FECA62EF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 21:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671774960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xglbcwBtHUzE7Svvg1D0riaViqFayLrBuEpuMnhx0Os=;
        b=XdlTGVxW+l+jL/D5wFjjOyPKjiDzBnMDQ4RD7MfGP4ixcGKkoLfRvW+YhAI+SKo/p/8jyl
        VMND92Ecptunn1uVnaSWxL1T2MyueHpZjSmd/PXt/niysZu4J0rbdi9wd2Ltt20J0lCyJr
        shj61LOKCJGA1X1HfDYtrZV/zvasjZU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-9wZ9O01HPuOwAkPNvArVfw-1; Fri, 23 Dec 2022 00:55:57 -0500
X-MC-Unique: 9wZ9O01HPuOwAkPNvArVfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2C1518811F4;
        Fri, 23 Dec 2022 05:55:56 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-204.pek2.redhat.com [10.72.12.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30D0D40C2064;
        Fri, 23 Dec 2022 05:55:53 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     sgarzare@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/4] vdpa_sim: switch to use __vdpa_alloc_device()
Date:   Fri, 23 Dec 2022 13:55:45 +0800
Message-Id: <20221223055548.27810-2-jasowang@redhat.com>
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

This allows us to control the allocation size of the structure.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index cb88891b44a8..118dbc8e5d67 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -249,6 +249,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 			       const struct vdpa_dev_set_config *config)
 {
 	const struct vdpa_config_ops *ops;
+	struct vdpa_device *vdpa;
 	struct vdpasim *vdpasim;
 	struct device *dev;
 	int i, ret = -ENOMEM;
@@ -266,14 +267,16 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	else
 		ops = &vdpasim_config_ops;
 
-	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
-				    dev_attr->ngroups, dev_attr->nas,
-				    dev_attr->name, false);
-	if (IS_ERR(vdpasim)) {
-		ret = PTR_ERR(vdpasim);
+	vdpa = __vdpa_alloc_device(NULL, ops,
+				   dev_attr->ngroups, dev_attr->nas,
+				   sizeof(struct vdpasim),
+				   dev_attr->name, false);
+	if (IS_ERR(vdpa)) {
+		ret = PTR_ERR(vdpa);
 		goto err_alloc;
 	}
 
+	vdpasim = vdpa_to_sim(vdpa);
 	vdpasim->dev_attr = *dev_attr;
 	INIT_WORK(&vdpasim->work, dev_attr->work_fn);
 	spin_lock_init(&vdpasim->lock);
-- 
2.25.1

