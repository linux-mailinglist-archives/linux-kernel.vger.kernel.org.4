Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0524D6731AA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 07:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjASGQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 01:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjASGQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:16:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996BA65EF1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 22:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674108947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DINlqTBfPPkQSaUFJZpbcOWI3MVsDFM2A5IzYzWW+XQ=;
        b=R7lfGLth/MwkskECuNHwyEFCfpCQfTi2oESodGPXuiWJwX/BWjMjgTymw+RSuQ4RjK6PNt
        RhMSID28lA369BzP8Z/B1zxmnG0ILzN8h+cc5AAUwtd6+Y4Av7yV5COBwY1M/6T/Bupqq2
        1ojKRGJSWOGozH7Yku9H6dOdqeuyXn4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-FZ9LurrSPMSHkxASg_7zXw-1; Thu, 19 Jan 2023 01:15:33 -0500
X-MC-Unique: FZ9LurrSPMSHkxASg_7zXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B3C88A010C;
        Thu, 19 Jan 2023 06:15:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-97.pek2.redhat.com [10.72.13.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4D901121315;
        Thu, 19 Jan 2023 06:15:29 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     elic@nvidia.com, gdawar@amd.com, tanuj.kamde@amd.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH V2 0/5] virtio_ring: per virtqueue DMA device
Date:   Thu, 19 Jan 2023 14:15:20 +0800
Message-Id: <20230119061525.75068-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
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

Changes since V1:
- make mlx5_get_vq_dma_dev() static

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

