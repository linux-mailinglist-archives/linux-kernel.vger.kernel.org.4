Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399365B96A4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiIOIvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiIOIvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477C77CB75
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663231862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GENWxAVvpWd3dVo6dm0mZc+x/Kx2jIgk/iiRb5OOLbg=;
        b=QoprnRvRHbRpUWvzlHTWafzIM8LgWXQZu0nyLr/fJvGJCMo2GYsot54xcwsFICbE5RONkg
        gXFrsU3zbtnGyUl9EbMVcjlV9hTVuII/g8X14VESSCYSf4j0zzr2/0H5s+qHQc22guO2YJ
        KIxR53GhScQsoV4Bd39tHNb/5YuTXL0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-dSUG1HUlNtCHrmg3fr2PXQ-1; Thu, 15 Sep 2022 04:50:58 -0400
X-MC-Unique: dSUG1HUlNtCHrmg3fr2PXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92604858F13;
        Thu, 15 Sep 2022 08:50:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-201.pek2.redhat.com [10.72.12.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 108A91759E;
        Thu, 15 Sep 2022 08:50:51 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     elic@nvidia.com, si-wei.liu@oracle.com, parav@nvidia.com,
        wuzongyong@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com,
        lingshan.zhu@intel.com, gdawar@xilinx.com, lulu@redhat.com,
        xieyongji@bytedance.com
Subject: [PATCH 0/3] vdpa: device feature provisioning
Date:   Thu, 15 Sep 2022 16:50:45 +0800
Message-Id: <20220915085048.12840-1-jasowang@redhat.com>
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

Hi All:

Virtio features are neogiated between the device and the drivers. This
allows the mediation layer like vDPA to hide some features from the
driver to faciliate the cross vendor live migration:

vDPA on the source supports feature set X
vDPA on the destination supports feature set Y

Management can simply provision the vDPA instance with features X&Y on
both source and destination to let the vDPA can be migrate-able
between the two vDPA devies with different features support.

This series tries to allow the device features to be provisioned via
netlink to achieve this.

Please review.

Thanks

Jason Wang (3):
  vdpa: device feature provisioning
  vdpa_sim_net: support feature provisioning
  vp_vdpa: support feature provisioning

 drivers/vdpa/vdpa.c                  |  5 +++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
 drivers/vdpa/virtio_pci/vp_vdpa.c    | 16 ++++++++++++++--
 include/linux/vdpa.h                 |  1 +
 include/uapi/linux/vdpa.h            |  2 ++
 5 files changed, 32 insertions(+), 3 deletions(-)

-- 
2.25.1

