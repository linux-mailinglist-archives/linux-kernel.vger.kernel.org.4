Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599EA6C5EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjCWFca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjCWFb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:31:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095382B9C3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:20 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ja10so21320262plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679549473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iK0RRb+GsjI38l88SqEX++UffkinqDa+fiWVU5n6eaI=;
        b=BqgkbVRokfgB9FbFCmBB1h9YZzTyKIVb9sx5pWB3Nj4auGpOSLT7kOsMU+VqoE0PQ+
         K/ieviKlJi6mxRYnzifZICuXlILoLfc/9GjqP+auyrrXUuphf2iB69UYS6fBlsAewr5R
         sYu9zzmJlw4pGwxJY0NH4Ux+eB7amMDr1JsN090L9QQbs2nXprrx9ThHSFHAviWKwzo2
         Tab2mP8IR69LR05geM4shv37JBwh6uv/NWkJ5ccf68uhqqlSIOMxnELN7uhqCid7m6HP
         +i/+XgJ0gMCYkJwmuzWOSX1hFmLYn8hHRyOO3GR3JG4zxzoIAV863iZQ6NtND6Io4IWe
         9mDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679549473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iK0RRb+GsjI38l88SqEX++UffkinqDa+fiWVU5n6eaI=;
        b=OwE8bcRaCFCgxEeTq7cWOXkHUtKKmCnh+Ie1M79sSx+quJuS1FNhuebQ7cI9W7AX7U
         xvLsRnyZ9jtbyMdSw2EvHQkA4eEr9YnjjxuLwoaD3fvKFA535I/wiBqOcmGoap4SnFtP
         gW2LthG77xojbIF0Jcq0Amrg81ZAjoTXaN/2BQsp18CDMvQ/HsYHIaF0/S+yhdofPs8x
         3fgnjykXBHIQcPIQ6pGwedg8n0f+9ADYIIqwhHFmnuDaEBdhp5WTfhNCD0Y4x1Mtu31V
         8Fjw0kHzc9USWXSg6bSSYiA68OVch5InMMi8V284S01Lb6kYbRxAT3B+2N04JETAof9w
         ur6w==
X-Gm-Message-State: AAQBX9e5kvqYkAYC9gq1mdUvqFzwe7EksT0RBvexPKSTGCjpIumoGK3A
        ndjw1nCsOTm4VkqfkE1hH1ej
X-Google-Smtp-Source: AKy350ZvKBHyKPolSTbLaFCfBtjwCf0znn6Y4pUR4yrDpiMOlRDfVTBav/kJEpGXrwhvQwOQrdLh1g==
X-Received: by 2002:a17:90b:4d83:b0:23d:870:5244 with SMTP id oj3-20020a17090b4d8300b0023d08705244mr4221278pjb.13.1679549472758;
        Wed, 22 Mar 2023 22:31:12 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id b18-20020a17090a551200b0023d1976cd34sm457870pji.17.2023.03.22.22.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 22:31:12 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/11] VDUSE: Improve performance
Date:   Thu, 23 Mar 2023 13:30:32 +0800
Message-Id: <20230323053043.35-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series introduces some ways to improve VDUSE performance.

Patch 1 ~ 6 bring current interrupt affinity spreading mechanism
to vduse device and make it possible for the virtio-blk driver
to build the blk-mq queues based on it. This would be useful to
mitigate the virtqueue lock contention in virtio-blk driver. In
our test, with those patches, we could get ~50% improvement (600k
iops -> 900k iops) when using per-cpu virtqueue.

Patch 7 adds a sysfs interface for each vduse virtqueue to change
the affinity for IRQ callback. It would be helpful for performance
tuning when the affinity mask contains more than one CPU.

Patch 8 ~ 9 associate an eventfd to the vdpa callback so that
we can signal it directly during irq injection without scheduling
an additional workqueue thread to do that.

Patch 10, 11 add a sysfs interface to support specifying bounce
buffer size in virtio-vdpa case. The high throughput workloads
can benefit from it. And we can also use it to reduce the memory
overhead for small throughput workloads.

Please review, thanks!

V3 to V4:
- Remove set_irq_affinity callback [Jason]
- Move the logic of interrupt affinity spreading mechanism from
  vduse module to virtio-vdpa module and unify set_vq_affinity
  callback to pass the affinity to vduse device [Jason]
- Rename the eventfd variable of the vdpa callback and add more
  comments for it [Jason]
- Fix compile warnings

V2 to V3:
- Rebased to newest kernel tree
- Export group_cpus_evenly() instead of irq_create_affinity_masks() [MST]
- Remove the sysfs for workqueue control [Jason]
- Associate an eventfd to the vdpa callback [Jason]
- Signal the eventfd directly in vhost-vdpa case [Jason]
- Use round-robin to spread IRQs between CPUs in the affinity mask [Jason]
- Handle the cpu hotplug case on IRQ injection [Jason]
- Remove effective IRQ affinity and balance mechanism for IRQ allocation

V1 to V2:
- Export irq_create_affinity_masks()
- Add set/get_vq_affinity and set_irq_affinity callbacks in vDPA
  framework
- Add automatic irq callback affinity support in VDUSE driver [Jason]
- Add more backgrounds information in commit log [Jason]
- Only support changing effective affinity when the value is a subset
  of the IRQ callback affinity mask

Xie Yongji (11):
  lib/group_cpus: Export group_cpus_evenly()
  vdpa: Add set/get_vq_affinity callbacks in vdpa_config_ops
  virtio-vdpa: Support interrupt affinity spreading mechanism
  vduse: Refactor allocation for vduse virtqueues
  vduse: Support set_vq_affinity callback
  vduse: Support get_vq_affinity callback
  vduse: Add sysfs interface for irq callback affinity
  vdpa: Add eventfd for the vdpa callback
  vduse: Signal vq trigger eventfd directly if possible
  vduse: Delay iova domain creation
  vduse: Support specifying bounce buffer size via sysfs

 drivers/vdpa/vdpa_user/vduse_dev.c | 414 ++++++++++++++++++++++++-----
 drivers/vhost/vdpa.c               |   2 +
 drivers/virtio/virtio_vdpa.c       |  97 +++++++
 include/linux/vdpa.h               |  19 ++
 lib/group_cpus.c                   |   1 +
 5 files changed, 470 insertions(+), 63 deletions(-)

-- 
2.20.1

