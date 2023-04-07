Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218B96DADAB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjDGNh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDGNhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F13246B7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680874628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aIvmfG2D4lMXQvYk341nc+hYEXy66ytDTxFyh3hTIFM=;
        b=XvLoVRpyjwLY8+y5uPyJ/uzuB+i6cCWsxui06Z5K6YQyiYWXgTryu3mIUofGrTyEMtNtyH
        4r7ijow1qNyyt+qe4+5cSui/56JZQlUuEqDhmgvMO+i7khmTWiGReU9wLnGoAjGuolmJ5/
        Z1cGs5vq7yhmQFWhtHuEfT9qKNn6+CA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-umMy1kCeMZylci8LyQmRug-1; Fri, 07 Apr 2023 09:37:05 -0400
X-MC-Unique: umMy1kCeMZylci8LyQmRug-1
Received: by mail-qt1-f197.google.com with SMTP id f2-20020ac87f02000000b003e6372b917dso16841946qtk.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680874625; x=1683466625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIvmfG2D4lMXQvYk341nc+hYEXy66ytDTxFyh3hTIFM=;
        b=wjB/40hNb1Pj9UNjTJLVFPME9xQMq3NtOiQORTwzsFLf18XCwaOOv2i7T1KUiBPZL2
         mHBgT0Ay4dEesQn/K+iBj2X10uXlYgo4DcpqJ4QSVS1TI2YcueyxzQcLshp2LfDxUMYo
         IfM9BZlUbpvKyhSzRNZMuTsllW+wROCIvWoFZvUJxZyh8Y4IL4EQ9KPbyzCGGdkwX3/5
         LDaJ/26CpoSNRO6I/d6L9Zc4/5y/s3KuUK54F7g+RLMDot8wbVFR9CpFFWSWDz3Qx7j+
         OIJi3JPNUxJYl6M18HGkxioOjfCWS4nctLBZynKQPQvV+Ptqif/TQAgEfyFtkwL4KNQv
         dqQw==
X-Gm-Message-State: AAQBX9fwlfPtQCC0V3puNRHsJ4RUxAh/UCp9cw//RNAGc3F1Gc55FcGB
        7x0PIu3CbvCQedZPW0ezuP2uSbY+48m2HU2HZaWybeBXVJ82WSKitVUzRAMhcVfTNqtlLBLuxCn
        VNSiMoIsuKSxeA2Swd1IE0HQb
X-Received: by 2002:a05:6214:21aa:b0:5a5:9297:21b2 with SMTP id t10-20020a05621421aa00b005a5929721b2mr3148621qvc.21.1680874624748;
        Fri, 07 Apr 2023 06:37:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350YAYMwT2wYKup442yHZBqo2BdAdAw1o1pmJYgAzO/7ubEP4yOwY4XvBBvM3cXQjkygfMrvgUA==
X-Received: by 2002:a05:6214:21aa:b0:5a5:9297:21b2 with SMTP id t10-20020a05621421aa00b005a5929721b2mr3148598qvc.21.1680874624509;
        Fri, 07 Apr 2023 06:37:04 -0700 (PDT)
Received: from step1.redhat.com ([5.77.69.107])
        by smtp.gmail.com with ESMTPSA id h2-20020ad45442000000b005dd8b9345e0sm1332899qvt.120.2023.04.07.06.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:37:03 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Eugenio=20P=C3=A9rez=20Martin?= <eperezma@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 0/2] vdpa_sim_blk: support shared backend
Date:   Fri,  7 Apr 2023 15:36:56 +0200
Message-Id: <20230407133658.66339-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is mainly for testing live migration between 2 vdpa_sim_blk
devices.

The first patch is preparation and moves the buffer allocation into devices,
the second patch adds the `shared_buffer_mutex` parameter to vdpa_sim_blk to
use the same ramdisk for all devices.

Tested with QEMU v8.0.0-rc2 in this way:

modprobe vhost_vdpa
modprobe vdpa_sim_blk shared_backend=true

vdpa dev add mgmtdev vdpasim_blk name blk0
vdpa dev add mgmtdev vdpasim_blk name blk1

qemu-system-x86_64 -m 512M -smp 2 -M q35,accel=kvm,memory-backend=mem \
  -object memory-backend-file,share=on,id=mem,size="512M",mem-path="/dev/shm"
  ...
  -blockdev node-name=drive_src1,driver=virtio-blk-vhost-vdpa,path=/dev/vhost-vdpa-1,cache.direct=on \
  -device virtio-blk-pci,id=src1,bootindex=2,drive=drive_src1 \
  -incoming tcp:0:3333

qemu-system-x86_64 -m 512M -smp 2 -M q35,accel=kvm,memory-backend=mem \
  -object memory-backend-file,share=on,id=mem,size="512M",mem-path="/dev/shm"
  ...
  -blockdev node-name=drive_src1,driver=virtio-blk-vhost-vdpa,path=/dev/vhost-vdpa-0,cache.direct=on \
  -device virtio-blk-pci,id=src1,bootindex=2,drive=drive_src1

(qemu) migrate -d tcp:0:3333

Stefano Garzarella (2):
  vdpa_sim: move buffer allocation in the devices
  vdpa_sim_blk: support shared backend

 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  3 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  7 +--
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 83 +++++++++++++++++++++++++---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 28 +++++++---
 4 files changed, 100 insertions(+), 21 deletions(-)

-- 
2.39.2

