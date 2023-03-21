Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3C26C3605
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjCUPn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCUPnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCB7CDC5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679413353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+21M6FOpDI3Nr+X7KYn7VxKMZfev1okJOfwsG6shoDo=;
        b=NhYvEp2Z0O+DsKzLmf8iVaWjDI8PEtrg6CxZtghm2aQFKuSrKVqOesmsyRpkwYOjQ6ZXaL
        q1dJp6Sy2fYFsdqsFV2rDEknhagnCcnNG7nM7PDmtwtrJgfmOQr5NrvBYaDxKqBe4hbH93
        /0uejU5Rbes3xNCV0G1dyISDnHIDDos=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-MLNGtUwiN1GkZOeLlG14gw-1; Tue, 21 Mar 2023 11:42:32 -0400
X-MC-Unique: MLNGtUwiN1GkZOeLlG14gw-1
Received: by mail-wm1-f70.google.com with SMTP id bi27-20020a05600c3d9b00b003e9d0925341so7272957wmb.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679413351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+21M6FOpDI3Nr+X7KYn7VxKMZfev1okJOfwsG6shoDo=;
        b=Nc2oI4FTVpZGOc2mCNo+dBCqecJp9s3X3pdBSfIoezy6dWC6SORdRfID/V6/7uDRww
         lp8mH8qMO35eb/Fqew3KIlSZhp0Zul8HVFF2U2wIqfvqTsDLTXciTxbNhJnMgmkYc4JR
         d3qug84J8j7UNyLmUfIsW9XZx0L4Z7TkBt31dEka6s9PLYpGd3sMAjBB8+FVDvCWlWeP
         PFwxFgFFmTUUS17/hR1kvefPPbdd29udFAsXEne9xtQtncLEjK5cMVsS8p+KYd3SzvIJ
         pA2psfOGKLbC503lVdXKuoZxf/Ow3V5gth8oKAajDuYCotFyGsZZydg7w7Qfmj30vYIZ
         j2sA==
X-Gm-Message-State: AO0yUKWGSdgoE5MUNi2OxIPlU4oYODA4rhxRBlzFlKMkO8XJBHOZDUJR
        tgnEE68dOe+Ph47PTYsGMIYka6DQTf4tEQEDwv9CTAq4aNS0wD/6zQSbG9uBW9QtN4wpmAA18el
        QcWri9sBLHlGK+RgYZ7raAeTk
X-Received: by 2002:a5d:6b50:0:b0:2cf:ee6b:36aa with SMTP id x16-20020a5d6b50000000b002cfee6b36aamr2562219wrw.64.1679413351351;
        Tue, 21 Mar 2023 08:42:31 -0700 (PDT)
X-Google-Smtp-Source: AK7set+jl15tAxH9/4PthYuff9mKcJ9PlapXD8hbv/rRlufjrczN3T38t3QWIyMzX15FRRs1sZibOQ==
X-Received: by 2002:a5d:6b50:0:b0:2cf:ee6b:36aa with SMTP id x16-20020a5d6b50000000b002cfee6b36aamr2562203wrw.64.1679413351047;
        Tue, 21 Mar 2023 08:42:31 -0700 (PDT)
Received: from step1.redhat.com (host-82-57-51-170.retail.telecomitalia.it. [82.57.51.170])
        by smtp.gmail.com with ESMTPSA id n2-20020adffe02000000b002cfeffb442bsm11582490wrr.57.2023.03.21.08.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 08:42:30 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        eperezma@redhat.com, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 0/8] vdpa_sim: add support for user VA
Date:   Tue, 21 Mar 2023 16:42:20 +0100
Message-Id: <20230321154228.182769-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the use of user virtual addresses in the
vDPA simulator devices.

The main reason for this change is to lift the pinning of all guest memory.
Especially with virtio devices implemented in software.

The next step would be to generalize the code in vdpa-sim to allow the
implementation of in-kernel software devices. Similar to vhost, but using vDPA
so we can reuse the same software stack (e.g. in QEMU) for both HW and SW
devices.

For example, we have never merged vhost-blk, and lately there has been interest.
So it would be nice to do it directly with vDPA to reuse the same code in the
VMM for both HW and SW vDPA block devices.

The main problem (addressed by this series) was due to the pinning of all
guest memory, which thus prevented the overcommit of guest memory.

Thanks,
Stefano

Changelog listed in each patch.
v2: https://lore.kernel.org/lkml/20230302113421.174582-1-sgarzare@redhat.com/
RFC v1: https://lore.kernel.org/lkml/20221214163025.103075-1-sgarzare@redhat.com/

Stefano Garzarella (8):
  vdpa: add bind_mm/unbind_mm callbacks
  vhost-vdpa: use bind_mm/unbind_mm device callbacks
  vringh: replace kmap_atomic() with kmap_local_page()
  vringh: support VA with iotlb
  vdpa_sim: make devices agnostic for work management
  vdpa_sim: use kthread worker
  vdpa_sim: replace the spinlock with a mutex to protect the state
  vdpa_sim: add support for user VA

 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  11 +-
 include/linux/vdpa.h                 |  10 ++
 include/linux/vringh.h               |   5 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |   2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 144 ++++++++++++++++++++-----
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  10 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  10 +-
 drivers/vhost/vdpa.c                 |  31 ++++++
 drivers/vhost/vringh.c               | 153 +++++++++++++++++++++------
 9 files changed, 301 insertions(+), 75 deletions(-)

-- 
2.39.2

