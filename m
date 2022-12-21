Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E312652CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiLUGSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiLUGRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:17:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A5B1EC6A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671603426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SXqwCh6Com8aJFlTus6HXtifGXM4NjpzjtHRW5NKksM=;
        b=BqoFhrOGJZ3TPMky55KtM6BMiTQBkI4pRU9tvaeM3Ix7ZOa0R9AqeiolOMP5EhtVkNhLBU
        hgXbDFeT4Acu+zFnbvvRl8TNy69KNPkgkHy07t2EmoQj1w0B1MBrT2HRH3bAjJcHSrqLp+
        2MlZfn8C+WFin1XhMWCpB1FzzqZSims=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-i728ixYCPuin4W9HX5UmUQ-1; Wed, 21 Dec 2022 01:17:03 -0500
X-MC-Unique: i728ixYCPuin4W9HX5UmUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B01513C3C166;
        Wed, 21 Dec 2022 06:17:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-236.pek2.redhat.com [10.72.13.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15FB12166B26;
        Wed, 21 Dec 2022 06:16:58 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     sgarzare@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] vdpa_sim: switch to use __vdpa_alloc_device()
Date:   Wed, 21 Dec 2022 14:16:49 +0800
Message-Id: <20221221061652.15202-2-jasowang@redhat.com>
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

This allows us to control the allocation size of the structure.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index b071f0d842fb..757afef86ba0 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -250,6 +250,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 			       const struct vdpa_dev_set_config *config)
 {
 	const struct vdpa_config_ops *ops;
+	struct vdpa_device *vdpa;
 	struct vdpasim *vdpasim;
 	struct device *dev;
 	int i, ret = -ENOMEM;
@@ -267,14 +268,16 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
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

