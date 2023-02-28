Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4586A5608
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjB1Jmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjB1Jmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:42:36 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041AC1FFE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:08 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so13100055pjh.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Amkwsoc7+Zh6LpSnYPT3sNZ/xGlGMM6GhMeq+khTZDk=;
        b=bM10nE+NWvCO1Ge0vDaGLKbIbx7kHjOJCQRj2ZKs8L8kDqZq8yyqZhGRJW2Qa7Wx05
         RaoMFrX/4sCNWD19Zl0NKH4FpMWQ9DMrkVpj4mLcovpDCU4h7PCgZ4PVySCwrYdGJsuq
         uf92sEfCgTtwTdwMINeHpuXuwuAYW4eYWc2XUxf8FblBhk2sPjHqV/zid7itr9Lccyr2
         prnWEL4ijb1leI3y/Vf1QjAJVe2Xuy1nygC1LdCJwKY3sRDnGBiom6ZNxkyDt49S7NBq
         6/l3d8QNx6j9TAMQUeIqwiJ6j8L990DzdoM/PtVx1xi+TxmkV5bAv8U4PKOM5bpbTju2
         gBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Amkwsoc7+Zh6LpSnYPT3sNZ/xGlGMM6GhMeq+khTZDk=;
        b=z9oeANh4ZsdKjpAn6JtousVn7M6Y6Q0ALRms7ldZZUwireG20oVszj6ib+5Lw+J/do
         ko8mvwTw7mKAckj7pV4Vv1s9lFsTKqWKmC4hqn5VQ7ccmbCKgKJsLDJTExYvwmXsLy42
         rLfaPZUw6+zjceObfxphXXM7M6WvJJZ/mkfzxMC595ELTECj1cP3DrvtFmH8K8+pMkiJ
         zWE2emnqANyDZdigx1dLe/RHWBj0pS3S7NnshoVhfN/xa8Q4HAn0kiFSfQ1dcIym0TLK
         RuraL9jQtYQ0XPLfm6CBz5VL1q+QqJhdDcKkIpMFrm+h/cVc27jU4LxLoKoUO60Q1QIh
         7//Q==
X-Gm-Message-State: AO0yUKXCGCF3eG5p8fM2GlYVsHusOu1BBfnJf7/Es8K7H8jJP3Sq0ph6
        yoJPiFm1nwp9mEuyjdHfjNix
X-Google-Smtp-Source: AK7set/IHwkuZ2nQikTluBqUyAnDk6KZDgVNhb0Xjot2acFdIS6T/O4Q46b/vgMnZvMsvX4Jhf6uug==
X-Received: by 2002:a17:903:2441:b0:199:bd4:9fbb with SMTP id l1-20020a170903244100b001990bd49fbbmr2487808pls.43.1677577328415;
        Tue, 28 Feb 2023 01:42:08 -0800 (PST)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id gz17-20020a17090b0ed100b00230b8431323sm5780199pjb.30.2023.02.28.01.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 01:42:08 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/11] VDUSE: Improve performance
Date:   Tue, 28 Feb 2023 17:40:59 +0800
Message-Id: <20230228094110.37-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
  vdpa: Add set_irq_affinity callback in vdpa_config_ops
  vduse: Refactor allocation for vduse virtqueues
  vduse: Support automatic irq callback affinity
  vduse: Support set/get_vq_affinity callbacks
  vduse: Add sysfs interface for irq callback affinity
  vdpa: Add eventfd for the vdpa callback
  vduse: Signal interrupt's eventfd directly in vhost-vdpa case
  vduse: Delay iova domain creation
  vduse: Support specifying bounce buffer size via sysfs

 drivers/vdpa/vdpa_user/vduse_dev.c | 490 +++++++++++++++++++++++++----
 drivers/vhost/vdpa.c               |   2 +
 drivers/virtio/virtio_vdpa.c       |  33 ++
 include/linux/vdpa.h               |  25 ++
 lib/group_cpus.c                   |   1 +
 5 files changed, 488 insertions(+), 63 deletions(-)

-- 
2.20.1

