Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39C862E06A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbiKQP4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiKQP4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:56:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA5F769E1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668700510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RMcPvClDyXqRCgCSImfOhtmqcNJCWNKsgSbr+RY5l4g=;
        b=g+Nf3E3uMd2DfVdzqQbByfazINNkdvYe1A+Qn+Qutr2uBTZ2jZScKWmlnkAM907w9Hnj+A
        MO/7Y+ZwUnkZnU/CcflCDIZrJt9BPEV95TdPaHIEDVJBb5uAz8nScGBtuoFvZfhGJhuCeo
        M3t9Dl0DQ4vOHJSK9U2fDqxiQDGYlb8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225--alPYjEWN-OVxn2vZ2vEhQ-1; Thu, 17 Nov 2022 10:55:07 -0500
X-MC-Unique: -alPYjEWN-OVxn2vZ2vEhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B822394AB06;
        Thu, 17 Nov 2022 15:55:06 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B347B111E3ED;
        Thu, 17 Nov 2022 15:55:05 +0000 (UTC)
From:   =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To:     linux-kernel@vger.kernel.org, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vdpa_sim_net: Offer VIRTIO_NET_F_STATUS
Date:   Thu, 17 Nov 2022 16:55:02 +0100
Message-Id: <20221117155502.1394700-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VIRTIO_NET_S_LINK_UP is already returned in config reads since vdpasim
creation, but the feature bit was not offered to the driver.

Tested modifying VIRTIO_NET_S_LINK_UP and different values of "status"
in qemu virtio-net options, using vhost_vdpa.

Not considering as a fix, because there should be no driver trusting in
this config read before the feature flag.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index c3cb225ea469..30cfcfcf97f7 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -27,6 +27,7 @@
 
 #define VDPASIM_NET_FEATURES	(VDPASIM_FEATURES | \
 				 (1ULL << VIRTIO_NET_F_MAC) | \
+				 (1ULL << VIRTIO_NET_F_STATUS) | \
 				 (1ULL << VIRTIO_NET_F_MTU) | \
 				 (1ULL << VIRTIO_NET_F_CTRL_VQ) | \
 				 (1ULL << VIRTIO_NET_F_CTRL_MAC_ADDR))
-- 
2.31.1

