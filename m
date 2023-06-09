Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9A9729515
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240054AbjFIJ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241583AbjFIJ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B605FEA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686302495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=78c5jYWz1mcsmCQBMqSzgZMFoxirWTll/3bzdXrUFCY=;
        b=IGQ9pD7np4qIufH2MLIWt30MPDaN5EMC+gKaM1zu0DX8acVsT5uDOU3TZffwHarqR1klgn
        Q/A9Sctr95OrmXkdDnhEup2h3YokfFte2JlCLbac+lZsfSDs493kzVo/SZbJnK+qUPvyBE
        /9kIHTSI6tkZ/IT4hn/p9VUk2RYBIVM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-PmFCjZxtMGuIxOAbbyyN6Q-1; Fri, 09 Jun 2023 05:21:33 -0400
X-MC-Unique: PmFCjZxtMGuIxOAbbyyN6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D88693C11A27;
        Fri,  9 Jun 2023 09:21:32 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C16320268C7;
        Fri,  9 Jun 2023 09:21:29 +0000 (UTC)
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
Subject: [PATCH v2 0/4] Add VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag to vdpa backend
Date:   Fri,  9 Jun 2023 11:21:23 +0200
Message-Id: <20230609092127.170673-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To migrate vDPA-net device state though CVQ we need to start the dataplane=
=0D
after the control virtqueue.=0D
=0D
As vdpa frontend doesn't know if the parent vdpa driver supports it, let's=
=0D
allow them to expose custom backend features by themselves.=0D
=0D
Comments are welcome.=0D
=0D
Thanks!=0D
=0D
v2: address doc issues from checkpath and fix lack of signed-off-by.=0D
=0D
v1: from RFC: Tweak doc as Shannon suggestion.=0D
=0D
Eugenio P=C3=A9rez (4):=0D
  vdpa: add VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag=0D
  vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature=0D
  vdpa: add get_backend_features vdpa operation=0D
  vdpa_sim: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK=0D
=0D
 drivers/vdpa/vdpa_sim/vdpa_sim.c |  8 ++++++++=0D
 drivers/vhost/vdpa.c             | 15 ++++++++++++++-=0D
 include/linux/vdpa.h             |  4 ++++=0D
 include/uapi/linux/vhost_types.h |  4 ++++=0D
 4 files changed, 30 insertions(+), 1 deletion(-)=0D
=0D
-- =0D
2.31.1=0D
=0D

