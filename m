Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A985EBBE7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiI0Hsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiI0Hs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA197AC0B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664264905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Epw8BTEITTG51o1ixLVEgGzqrZgiUy5p9Cv+5Yl00kA=;
        b=iGE9yWnQ+2aiCTzXQDP4DqL+fjsvT25Mci1TGq09tq9PpTaknSdz7zZdiGHN9UltyYl18F
        0M7kEqM2c3/LwZlcP4NdDUgm8AWYl/BhkanUk2i6X2tp0cDNbeU5qrKmCQEwjxerHifd3p
        n0p14pxAdqlt0TZIJBUfMg71NDR1QTQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-g2io9IK_MOaSBbTLx4aq0w-1; Tue, 27 Sep 2022 03:48:19 -0400
X-MC-Unique: g2io9IK_MOaSBbTLx4aq0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C6B1101A528;
        Tue, 27 Sep 2022 07:48:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-192.pek2.redhat.com [10.72.13.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFC4E140EBF3;
        Tue, 27 Sep 2022 07:48:12 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     elic@nvidia.com, si-wei.liu@oracle.com, parav@nvidia.com,
        wuzongyong@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com,
        lingshan.zhu@intel.com, gdawar@xilinx.com, lulu@redhat.com,
        xieyongji@bytedance.com, sgarzare@redhat.com
Subject: [PATCH V3 0/3] vdpa: device feature provisioning
Date:   Tue, 27 Sep 2022 15:48:07 +0800
Message-Id: <20220927074810.28627-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes since V2:

- remove the unnecessary and operation for the devie_features after
  validating it is a subset of what device supports
- provison the features via vdpasim_create() to benefit all type of
  simulators
- fix the reference leak when fail to provision feature for vp_vdpa
- add a warn when failing to provision vp_vdpa device features

Changes since V1:

- Add vdpa tool command output

Please review.

Jason Wang (3):
  vdpa: device feature provisioning
  vdpa_sim_net: support feature provisioning
  vp_vdpa: support feature provisioning

 drivers/vdpa/vdpa.c                  |  5 +++++
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 12 +++++++++++-
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  3 ++-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  5 +++--
 drivers/vdpa/virtio_pci/vp_vdpa.c    | 22 ++++++++++++++++++++--
 include/linux/vdpa.h                 |  1 +
 include/uapi/linux/vdpa.h            |  2 ++
 8 files changed, 45 insertions(+), 7 deletions(-)

-- 
2.25.1

