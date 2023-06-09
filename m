Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783A5729536
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241523AbjFIJbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241474AbjFIJbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0376EAE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686302700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BSYu94PSBBeau34XT4dGzInntObCc6c7/xjwJmmjNHA=;
        b=HQJlwRNSDdOttwjngS6GaFluxSjDRTLzruecnjXuDkI7NQ7ZXgP83FNk7WT2sgKJRtQLhJ
        iKsDY2kyxYdI6N1qc/p9tdcrnT/sgTasBG6ez6SpPN9nrjIeW/kLpWwLxWjNlkdT4XnELh
        vwFV2s1B4jFmyJMeF6sHuRDjk6Krvtg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-xyILRbHZOBWmGloccysoMQ-1; Fri, 09 Jun 2023 05:21:40 -0400
X-MC-Unique: xyILRbHZOBWmGloccysoMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B03985A5A8;
        Fri,  9 Jun 2023 09:21:39 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86DD420268C6;
        Fri,  9 Jun 2023 09:21:36 +0000 (UTC)
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
Subject: [PATCH v2 2/4] vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature
Date:   Fri,  9 Jun 2023 11:21:25 +0200
Message-Id: <20230609092127.170673-3-eperezma@redhat.com>
In-Reply-To: <20230609092127.170673-1-eperezma@redhat.com>
References: <20230609092127.170673-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accepting VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature if
userland sets it.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vhost/vdpa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index bf77924d5b60..a3204406b73d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -680,7 +680,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 			return -EFAULT;
 		if (features & ~(VHOST_VDPA_BACKEND_FEATURES |
 				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
-				 BIT_ULL(VHOST_BACKEND_F_RESUME)))
+				 BIT_ULL(VHOST_BACKEND_F_RESUME) |
+				 BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK)))
 			return -EOPNOTSUPP;
 		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
 		     !vhost_vdpa_can_suspend(v))
-- 
2.31.1

