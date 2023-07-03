Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468D97460C1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjGCQd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCQd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:33:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ED2E49
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688401984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=o9JfmV88VU7bKRr8QoDVSiiCtWQNwua/yZVv7UwouXs=;
        b=ccnhnC+uBCK6wJgvikMKWDVdu+2CIrjBQFfHJEk1q1hNkDgsMR3KO1TrkWh+bjYHi2qj+V
        WUGPllpp7+ZjavcUTmbmAfu0OyWNCO5TTnZ5vWyZVQkmiFUrlt8wVBt8YCpwp+OWtpE1i3
        7qmSZFMuSvnO1GZG5cHIOSX5KjcPEqQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-J1Sx18vxNTKHdKqesQaetw-1; Mon, 03 Jul 2023 12:33:01 -0400
X-MC-Unique: J1Sx18vxNTKHdKqesQaetw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbdde92299so1979525e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 09:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688401980; x=1690993980;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9JfmV88VU7bKRr8QoDVSiiCtWQNwua/yZVv7UwouXs=;
        b=ax3a4EovbusVMgPZkdvLfpsmV8lmo+BP1ZLnMYlo5cQ9IQCAf0mbKOxQFLzwWl73AY
         pJZtmcNNDGi8uUOprIziP/+19MDkgNN3b0UpXuxF9F9isIkfzZrk57Il5BYgcK4VjL1y
         xVZ20V5f4jKslxA6fewbgGtxm2uGUWa4Zc8os6SzejFbjI8TMcg0vF4cJ8cXGzYQSoty
         Z0DOwqV/Ve5bpxY7865sQDJWHiMt6HmOrpmRoJ2SNGVNLRLkYEAmOp6kV0X6fk7l26L8
         hOfZWqkk59h7m/dZzAHH2lt6WKKb3CEU6jJFePd73oIQ4xV7OX5oOjK1AcouryVDO0Bp
         I+9Q==
X-Gm-Message-State: ABy/qLZao7aTkQxdVTzS47S25VA3CnV7HI/QnMtW9q2IfuOCnWJyygIE
        BYAxbkIJN8WYW3Cy5W4c+w4revjy+V1VZvMoC38dK1tOV/OxvAuycCPVxs+0Ad12nx5/m+7naXE
        LyJG1t1mK5RIFJwkTNV05cvfI
X-Received: by 2002:a05:600c:204c:b0:3fb:c9f4:14f3 with SMTP id p12-20020a05600c204c00b003fbc9f414f3mr7664414wmg.2.1688401980559;
        Mon, 03 Jul 2023 09:33:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF3hFeAuV3dUEiLC0bwfsYkvJ+BICpkbXADsRD+NAYyFyEPyRSAlNMR3Fy4eKLuXU7LTEvA3A==
X-Received: by 2002:a05:600c:204c:b0:3fb:c9f4:14f3 with SMTP id p12-20020a05600c204c00b003fbc9f414f3mr7664400wmg.2.1688401980209;
        Mon, 03 Jul 2023 09:33:00 -0700 (PDT)
Received: from redhat.com ([2.52.13.33])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b003f733c1129fsm18646129wmc.33.2023.07.03.09.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 09:32:59 -0700 (PDT)
Date:   Mon, 3 Jul 2023 12:32:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alvaro.karsz@solid-run.com, dtatulea@nvidia.com, elic@nvidia.com,
        feliu@nvidia.com, horms@kernel.org, jasowang@redhat.com,
        krzysztof.kozlowski@linaro.org, lingshan.zhu@intel.com,
        maxime.coquelin@redhat.com, michael.christie@oracle.com,
        mst@redhat.com, peng.fan@nxp.com, saeedm@nvidia.com,
        shannon.nelson@amd.com, tianxianting.txt@alibaba-inc.com,
        xianting.tian@linux.alibaba.com, xieyongji@bytedance.com
Subject: [GIT PULL] virtio: features, fixes, cleanups
Message-ID: <20230703123256-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: dropped some commits at the last moment, I did verify we get
the same code in the end as what was in linux next for a while now.

The following changes since commit 6995e2de6891c724bfeb2db33d7b87775f913ad1:

  Linux 6.4 (2023-06-25 16:29:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 9e396a2f434f829fb3b98a24bb8db5429320589d:

  vhost: Make parameter name match of vhost_get_vq_desc() (2023-07-03 12:15:15 -0400)

----------------------------------------------------------------
virtio: features, fixes, cleanups

resume support in vdpa/solidrun
structure size optimizations in virtio_pci
new pds_vdpa driver
immediate initialization mechanism for vdpa/ifcvf
interrupt bypass for vdpa/mlx5
multiple worker support for vhost
viirtio net in Intel F2000X-PL support for vdpa/ifcvf

fixes, cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alvaro Karsz (1):
      vdpa/snet: implement the resume vDPA callback

Dragos Tatulea (1):
      virtio-vdpa: Fix unchecked call to NULL set_vq_affinity

Eli Cohen (1):
      vdpa/mlx5: Support interrupt bypassing

Feng Liu (1):
      virtio_pci: Optimize virtio_pci_device structure size

Krzysztof Kozlowski (1):
      vdpa: solidrun: constify pointers to hwmon_channel_info

Maxime Coquelin (1):
      vduse: fix NULL pointer dereference

Mike Christie (17):
      vhost: create worker at end of vhost_dev_set_owner
      vhost: dynamically allocate vhost_worker
      vhost: add vhost_worker pointer to vhost_virtqueue
      vhost, vhost_net: add helper to check if vq has work
      vhost: take worker or vq instead of dev for queueing
      vhost: take worker or vq for flushing
      vhost: convert poll work to be vq based
      vhost_sock: convert to vhost_vq_work_queue
      vhost_scsi: make SCSI cmd completion per vq
      vhost_scsi: convert to vhost_vq_work_queue
      vhost_scsi: flush IO vqs then send TMF rsp
      vhost: remove vhost_work_queue
      vhost: add helper to parse userspace vring state/file
      vhost: replace single worker pointer with xarray
      vhost: allow userspace to create workers
      vhost_scsi: add support for worker ioctls
      vhost: Allow worker switching while work is queueing

Peng Fan (1):
      tools/virtio: fix build break for aarch64

Shannon Nelson (11):
      virtio: allow caller to override device id in vp_modern
      virtio: allow caller to override device DMA mask in vp_modern
      pds_vdpa: Add new vDPA driver for AMD/Pensando DSC
      pds_vdpa: move enum from common to adminq header
      pds_vdpa: new adminq entries
      pds_vdpa: get vdpa management info
      pds_vdpa: virtio bar setup for vdpa
      pds_vdpa: add vdpa config client commands
      pds_vdpa: add support for vdpa and vdpamgmt interfaces
      pds_vdpa: subscribe to the pds_core events
      pds_vdpa: pds_vdps.rst and Kconfig

Simon Horman (1):
      virtio: Add missing documentation for structure fields

Xianting Tian (4):
      virtio-crypto: call scheduler when we free unused buffs
      virtio-console: call scheduler when we free unused buffs
      virtio_bt: call scheduler when we free unused buffs
      vhost: Make parameter name match of vhost_get_vq_desc()

Zhu Lingshan (8):
      vDPA/ifcvf: virt queue ops take immediate actions
      vDPA/ifcvf: get_driver_features from virtio registers
      vDPA/ifcvf: retire ifcvf_start_datapath and ifcvf_add_status
      vDPA/ifcvf: synchronize irqs in the reset routine
      vDPA/ifcvf: a vendor driver should not set _CONFIG_S_FAILED
      vDPA/ifcvf: dynamic allocate vq data stores
      vDPA/ifcvf: detect and report max allowed vq size
      vDPA/ifcvf: implement new accessors for vq_state

 .../device_drivers/ethernet/amd/pds_vdpa.rst       |  85 +++
 .../networking/device_drivers/ethernet/index.rst   |   1 +
 MAINTAINERS                                        |   4 +
 drivers/bluetooth/virtio_bt.c                      |   1 +
 drivers/char/virtio_console.c                      |   1 +
 drivers/crypto/virtio/virtio_crypto_core.c         |   1 +
 drivers/vdpa/Kconfig                               |  10 +
 drivers/vdpa/Makefile                              |   1 +
 drivers/vdpa/ifcvf/ifcvf_base.c                    | 215 +++---
 drivers/vdpa/ifcvf/ifcvf_base.h                    |  48 +-
 drivers/vdpa/ifcvf/ifcvf_main.c                    | 108 +--
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  | 165 ++++-
 drivers/vdpa/mlx5/net/mlx5_vnet.h                  |  15 +
 drivers/vdpa/pds/Makefile                          |  10 +
 drivers/vdpa/pds/aux_drv.c                         | 140 ++++
 drivers/vdpa/pds/aux_drv.h                         |  26 +
 drivers/vdpa/pds/cmds.c                            | 185 +++++
 drivers/vdpa/pds/cmds.h                            |  18 +
 drivers/vdpa/pds/debugfs.c                         | 289 ++++++++
 drivers/vdpa/pds/debugfs.h                         |  17 +
 drivers/vdpa/pds/vdpa_dev.c                        | 769 +++++++++++++++++++++
 drivers/vdpa/pds/vdpa_dev.h                        |  49 ++
 drivers/vdpa/solidrun/snet_ctrl.c                  |   6 +
 drivers/vdpa/solidrun/snet_hwmon.c                 |   2 +-
 drivers/vdpa/solidrun/snet_main.c                  |  15 +
 drivers/vdpa/solidrun/snet_vdpa.h                  |   1 +
 drivers/vdpa/vdpa_user/vduse_dev.c                 |   6 +-
 drivers/vhost/net.c                                |   8 +-
 drivers/vhost/scsi.c                               | 103 +--
 drivers/vhost/vhost.c                              | 425 ++++++++++--
 drivers/vhost/vhost.h                              |  24 +-
 drivers/vhost/vsock.c                              |   4 +-
 drivers/virtio/virtio_pci_common.h                 |   7 +-
 drivers/virtio/virtio_pci_modern_dev.c             |  33 +-
 drivers/virtio/virtio_vdpa.c                       |   4 +-
 include/linux/pds/pds_adminq.h                     | 247 +++++++
 include/linux/pds/pds_common.h                     |  21 +-
 include/linux/virtio.h                             |   5 +-
 include/linux/virtio_pci_modern.h                  |   6 +
 include/uapi/linux/vhost.h                         |  31 +
 include/uapi/linux/vhost_types.h                   |  16 +
 tools/virtio/Makefile                              |  13 +-
 42 files changed, 2777 insertions(+), 358 deletions(-)
 create mode 100644 Documentation/networking/device_drivers/ethernet/amd/pds_vdpa.rst
 create mode 100644 drivers/vdpa/pds/Makefile
 create mode 100644 drivers/vdpa/pds/aux_drv.c
 create mode 100644 drivers/vdpa/pds/aux_drv.h
 create mode 100644 drivers/vdpa/pds/cmds.c
 create mode 100644 drivers/vdpa/pds/cmds.h
 create mode 100644 drivers/vdpa/pds/debugfs.c
 create mode 100644 drivers/vdpa/pds/debugfs.h
 create mode 100644 drivers/vdpa/pds/vdpa_dev.c
 create mode 100644 drivers/vdpa/pds/vdpa_dev.h

