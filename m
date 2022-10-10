Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6485FA2A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiJJRUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJJRUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86BD37196
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665422439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=L7mzWGm9Fi3J3wL3BVtMdGC7y0bZYjMeGp/4Tbn7IOo=;
        b=M6P9Y1jT04D8NdRenBKIz69pcAKgkikKL+vr+uweeExKjX6YrX4PD5A+KwMG5JSmWYU+UU
        BAgN7CMxYV17TRbOKQLcDecVxUPYeesX3IM/tQML7H/7CCMDkXPFJi9pawsvSb0Y5++gYB
        1eP3Dh7u0gC0goLXj0olT7ftdU7KqKw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-417-B398vPLNNIW8RUjfK9fvAw-1; Mon, 10 Oct 2022 13:20:37 -0400
X-MC-Unique: B398vPLNNIW8RUjfK9fvAw-1
Received: by mail-wm1-f71.google.com with SMTP id c5-20020a1c3505000000b003c56da8e894so3107530wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7mzWGm9Fi3J3wL3BVtMdGC7y0bZYjMeGp/4Tbn7IOo=;
        b=r2MOylGHZHsIQ1gWsX/SDjgRfwhPbZjIyiu4eVuqVylrUYkLksYOGEV4LCxfH2a3LA
         3Z7BjGuxqeJFq6ymkdSnBKd7O0STMn5X6U4+gCA/DmUbIc4gjkXeCTd6+Rc5PD273e+a
         wM6CIOPuUvSFR75goUUQ+em1+L1BJLjzqqxHj1ELd6FPyX4x0JQ6vLsz5rFhkDAh41ck
         j5kMBWKYvlzn7z6a+pk4AKdpLYNdUPtxy4QwPz4I5hKR/Wvdz0YgvgTllq+AqrbxMk1z
         4A10SPBfcwFcddLcpd9EVDpYa8nJY52aaZqdxfRBojJkalFUqREqS3QBECtfE1pQACsQ
         z5iw==
X-Gm-Message-State: ACrzQf3+5I+mrLMuEUMkx4O3Pw3ZwizlLYjANoqrB/wocv05Zd/T8tPL
        iYeDyEUrnzc6kj2mVUAGXvh1kq+kobGLEZBT9o0SFSRxa/vDim+ZHiCB1Xa+c6MG7O9OH9Zuxpv
        LukXICD/kTv7bsXcvhUrTKL5Q
X-Received: by 2002:a5d:456b:0:b0:230:9e5b:c64c with SMTP id a11-20020a5d456b000000b002309e5bc64cmr3561537wrc.211.1665422436616;
        Mon, 10 Oct 2022 10:20:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM68dVAhvzTyD7Fyx5nUJiGXtTyQolK/pvb6X+fnB98gJfJ7lgZeRyv+gqj4yQ08CijJAvcdWw==
X-Received: by 2002:a5d:456b:0:b0:230:9e5b:c64c with SMTP id a11-20020a5d456b000000b002309e5bc64cmr3561523wrc.211.1665422436338;
        Mon, 10 Oct 2022 10:20:36 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id g7-20020a056000118700b0022ac38fb20asm9337483wrx.111.2022.10.10.10.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:20:35 -0700 (PDT)
Date:   Mon, 10 Oct 2022 13:20:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alvaro.karsz@solid-run.com, angus.chen@jaguarmicro.com,
        gavinl@nvidia.com, jasowang@redhat.com, lingshan.zhu@intel.com,
        mst@redhat.com, wangdeming@inspur.com, xiujianfeng@huawei.com
Subject: [GIT PULL] virtio: fixes, features
Message-ID: <20221010132030-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:

  Linux 6.0 (2022-10-02 14:09:07 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 71491c54eafa318fdd24a1f26a1c82b28e1ac21d:

  virtio_pci: don't try to use intxif pin is zero (2022-10-07 20:00:44 -0400)

----------------------------------------------------------------
virtio: fixes, features

9k mtu perf improvements
vdpa feature provisioning
virtio blk SECURE ERASE support

Fixes, cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alvaro Karsz (1):
      virtio_blk: add SECURE ERASE command support

Angus Chen (1):
      virtio_pci: don't try to use intxif pin is zero

Deming Wang (2):
      virtio_ring: split: Operators use unified style
      virtio_ring: make vring_alloc_queue_packed prettier

Gavin Li (2):
      virtio-net: introduce and use helper function for guest gso support checks
      virtio-net: use mtu size as buffer length for big packets

Jason Wang (3):
      vdpa: device feature provisioning
      vdpa_sim_net: support feature provisioning
      vp_vdpa: support feature provisioning

Michael S. Tsirkin (1):
      virtio: drop vp_legacy_set_queue_size

Xiu Jianfeng (1):
      vhost: add __init/__exit annotations to module init/exit funcs

Zhu Lingshan (6):
      vDPA: allow userspace to query features of a vDPA device
      vDPA: only report driver features if FEATURES_OK is set
      vDPA: check VIRTIO_NET_F_RSS for max_virtqueue_paris's presence
      vDPA: check virtio device features to detect MQ
      vDPA: fix spars cast warning in vdpa_dev_net_mq_config_fill
      vDPA: conditionally read MTU and MAC in dev cfg space

 drivers/block/virtio_blk.c           | 110 +++++++++++++++++++++++++++++------
 drivers/net/virtio_net.c             |  48 ++++++++++-----
 drivers/vdpa/vdpa.c                  |  73 ++++++++++++++++++-----
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  12 +++-
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |   3 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |   2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |   5 +-
 drivers/vdpa/virtio_pci/vp_vdpa.c    |  22 ++++++-
 drivers/vhost/net.c                  |   4 +-
 drivers/virtio/virtio_pci_common.c   |   3 +
 drivers/virtio/virtio_ring.c         |   8 +--
 include/linux/vdpa.h                 |   1 +
 include/linux/virtio_pci_legacy.h    |   2 -
 include/uapi/linux/vdpa.h            |   6 ++
 include/uapi/linux/virtio_blk.h      |  19 ++++++
 15 files changed, 253 insertions(+), 65 deletions(-)

