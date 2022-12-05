Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AD26424E1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiLEImv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiLEIms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:42:48 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EF72D6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:42:47 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id h28so10655030pfq.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+dCWxxUeLTQvAT0ndb12QNsjElrDNW1TJacgl+80Vuo=;
        b=MZgf2asxhSswMz3zLGbCsLM0/Z7hcFM9gYCjsQfXf51nE8foeZrDHbF9Zshf4Mgha9
         z0Gb1VGnTeHcWxheNolKpXYY2flSleZCqr1DjMBbbYA0Q3po3ssw7V5Qpz/I3noVRmdl
         nuyeI8YeBmUSuKfzws0Ln8T8wJOROyoMl/pC+s9U1njE9ozP+UgpoOVslM/K2NsTMYt0
         3GpGxnsyE9ixPNBo/2xt5viLcQbsaU+HtMRZZ/WW+pUBu+CJhArcEJEptLmh5SGL7eDI
         uDbIZZPckQSiM17Wn2Nx89LZSbvDClllKdKo2auDWLhBpLQgLnEPdiwPSNpGZM5yFYEZ
         Kxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dCWxxUeLTQvAT0ndb12QNsjElrDNW1TJacgl+80Vuo=;
        b=iaxbTAd7AjbxcZfKrqYdOiwgR0Rpv3FWLBSGWtYnsp7RgWeL3MXSSWcUoRFYxJYFzW
         qOny2nLMDSssy6ljZlH7Yovf3RuZMJTdb9ep5cX8is9mxLawwwd6MJxG00uKKDPnedWY
         lwP2QH+Fs6r6EOsfqB/tUSnn1DbXipq/SzSvFAcHLBI+SwT6gtog0SwgkkKydzKASZPJ
         PwdB7ld34iLJa1KSPwA9WBBnXgBOsuul5xNKHyCzYNKCEQxSTA8IQ92XM1kIISiheH0H
         54sfM4TGVYWB7g0iHXzOomWIo1caOd/eFranXACcsc4ImXuj3aaD/fLCh3me9yEEP2uk
         FGdw==
X-Gm-Message-State: ANoB5pkmNckoepuLcwooe7NeZ747irZnMYQbuXxzFqiNFGq6H+CeN4wz
        VtASjmXq6eQ6+Gp3Zn2KZVGx
X-Google-Smtp-Source: AA0mqf6Mq5L6TlIGpWqCeJNcZb0+W9oyx2fEQFGCu+Z/HhpjRRPYXbkgCw2lNYE+Pl5gGoQ0fHt0cA==
X-Received: by 2002:a63:4b07:0:b0:46e:9363:d96e with SMTP id y7-20020a634b07000000b0046e9363d96emr55533154pga.85.1670229766916;
        Mon, 05 Dec 2022 00:42:46 -0800 (PST)
Received: from localhost ([101.229.232.206])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b00188f07c9eedsm9873031plm.176.2022.12.05.00.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 00:42:46 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/11] VDUSE: Improve performance
Date:   Mon,  5 Dec 2022 16:41:16 +0800
Message-Id: <20221205084127.535-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series introduces some ways to improve VDUSE performance.

Patch 1 ~ 7 brings current interrupt affinity spreading mechanism
to vduse device and make it possible for the virtio-blk driver
to build the blk-mq queues based on it. This would be useful to
mitigate the virtqueue lock contention in virtio-blk driver. In
our test, we could get ~50% improvement (600k iops -> 900k iops)
when using per-cpu virtqueue.

Patch 8 adds a sysfs interface for each vduse virtqueue to show
the affinity and effective affinity for IRQ callback. And the
effective affinity interface is also writable so that we can
do some performance tuning when the affinity mask contains more
than one CPU.

Patch 9 adds a sysfs interface for each virtqueues to control
whether use workqueue to inject irq or not. The vhost-vdpa case
can benefit from it.

Patch 10, 11 add a sysfs interface to support specifying bounce
buffer size in virtio-vdpa case. The high throughput workloads
can benefit from it. And we can also use it to reduce the memory
overhead for small throughput workloads.

Please review, thanks!

V1 to V2:
- Export irq_create_affinity_masks()
- Add set/get_vq_affinity and set_irq_affinity callbacks in vDPA
  framework
- Add automatic irq callback affinity support in VDUSE driver [Jason]
- Add more backgrounds information in commit log [Jason]
- Only support changing effective affinity when the value is a subset
  of the IRQ callback affinity mask.

Xie Yongji (11):
  genirq/affinity:: Export irq_create_affinity_masks()
  vdpa: Add set/get_vq_affinity callbacks in vdpa_config_ops
  vdpa: Add set_irq_affinity callback in vdpa_config_ops
  vduse: Refactor allocation for vduse virtqueues
  vduse: Introduce bound workqueue for irq injection
  vduse: Support automatic irq callback affinity
  vduse: Support set/get_vq_affinity callbacks
  vduse: Add sysfs interface for irq callback affinity
  vduse: Add enable_irq_wq sysfs interface for virtqueues
  vduse: Delay iova domain creation
  vduse: Support specifying bounce buffer size via sysfs

 drivers/vdpa/vdpa_user/vduse_dev.c | 497 +++++++++++++++++++++++++----
 drivers/virtio/virtio_vdpa.c       |  32 ++
 include/linux/vdpa.h               |  21 ++
 kernel/irq/affinity.c              |   1 +
 4 files changed, 488 insertions(+), 63 deletions(-)

-- 
2.20.1

