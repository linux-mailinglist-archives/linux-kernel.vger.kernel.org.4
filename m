Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C46665495
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjAKG3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjAKG3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:29:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7FD6547
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673418501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zuZT9imH3GUC8e7yu58JVlPWyjWUNDx6BVFaTW7cVbc=;
        b=AvUJVHgKMLGc6ZlFlY2FkAO5FmX2THqqX4Yc9NTG9MFMmdJDhVxHJGIdgpUIZ+pZ2xPiM+
        QjXQYP0IP4qXEV54vhFBAqA8kC4aBnoTCgzbbVT6AP7qAzoEcvvBpthAJZbpVhj/PF6t9j
        e9DyR5IGJaP6CTx3nYqAswxDf8M+jGs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-wrl8SHr6O8eAICQ3lh1IcA-1; Wed, 11 Jan 2023 01:28:15 -0500
X-MC-Unique: wrl8SHr6O8eAICQ3lh1IcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 133753C025BA;
        Wed, 11 Jan 2023 06:28:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-175.pek2.redhat.com [10.72.13.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F38DE4078903;
        Wed, 11 Jan 2023 06:28:11 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     elic@nvidia.com, gdawar@amd.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tanuj.kamde@amd.com
Subject: [PATCH 0/5] virtio_ring: per virtqueue DMA device
Date:   Wed, 11 Jan 2023 14:28:04 +0800
Message-Id: <20230111062809.25020-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

In some cases, the virtqueue could be backed by different devices. One
example is that in the case of vDPA some parent may emualte virtqueue
via vringh. In this case, it would be wrong if we stick with the
physical DMA device for software emulated device, since there's no
easy way for vringh to know about the hardware IOMMU mappings.

So this series tries to introduce per virtqueue DMA device, then
software virtqueues can utilize the transport specific method to
assign appropirate DMA device.

This fixes the crash of mlx5_vdpa + virtio_vdpa when platform IOMMU is
enabled but not in the passthrough mode. The reason for the crash is
that the virito_ring tries to map the control virtqueue into platform
IOMMU but the vringh assumes a direct mapping (PA as IOVA). This is
fixed by advetise the vDPA device that doesnt do DMA (without a DMA
ops). So DMA API can go with the direct mapping then the vringh will
be happy since mlx5_vdpa assuems a direct/identical mapping by
default.

Please review.

Thanks

Jason Wang (5):
  virtio_ring: per virtqueue dma device
  vdpa: introduce get_vq_dma_device()
  virtio-vdpa: support per vq dma device
  vdpa: set dma mask for vDPA device
  vdpa: mlx5: support per virtqueue dma device

 drivers/vdpa/mlx5/net/mlx5_vnet.c |  11 +++
 drivers/vdpa/vdpa.c               |   5 ++
 drivers/virtio/virtio_ring.c      | 133 +++++++++++++++++++++---------
 drivers/virtio/virtio_vdpa.c      |  13 ++-
 include/linux/vdpa.h              |   6 ++
 include/linux/virtio_ring.h       |  16 ++++
 6 files changed, 141 insertions(+), 43 deletions(-)

-- 
2.25.1

