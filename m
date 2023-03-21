Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875476C2EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCUK3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCUK3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:29:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508B45FFB;
        Tue, 21 Mar 2023 03:29:10 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:f5ef:1040:e3c1:3d00])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6900266030DA;
        Tue, 21 Mar 2023 10:29:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679394548;
        bh=thP50rZe85eKdLn09P/bJZIXTEK1LuBUDkCFuB2KNec=;
        h=From:To:Cc:Subject:Date:From;
        b=WANier/NNPyE0Tv/3S9lJSi5ZYSmzU0VgJo+nRTJVSmYgRQ7lVfT014TDpr5IZxDe
         Ekzaiy1mtjb/2ANsIToKpM8WO7QfkSspjxYUj4JUoY/Cov+A6nkJLafapGCI8PcFWO
         m8uM6LMu3dRbEC2h5lsGhKz3sJ4zRt0QE+YQso0OtHxhIBnPvB89xcAdbjLH17BsLi
         9EAC/w+2NIaN2gCS12NwzyF15MXCVZ/Qwls8e0n52FNRbm9b5M6zmR85n3eZfd8Lt7
         CWDq1ix3An5x04XiwjW4SfVMhUqFeUmVVbLXAenVCYC42YkdyOEiPKPBS0fiJ+taMH
         c/Jg7F9DXYEsA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        ming.qian@nxp.com, shijie.qin@nxp.com, eagle.zhou@nxp.com,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        daniel.almeida@collabora.com, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, jernel@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 0/8] Add DELETE_BUF ioctl
Date:   Tue, 21 Mar 2023 11:28:47 +0100
Message-Id: <20230321102855.346732-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VP9 dynamic resolution change use case requires to change resolution
without doing stream off/on to keep references frames.
In consequence the numbers of buffers increase until all 'old'
reference frames are deprecated.
To make it possible this series remove the 32 buffers limit per queue
and introduce DELETE_BUF ioctl to delete buffers from a queue without
doing stream off/on sequence.

change in version 2:
- Use a dynamic array and not a list to keep trace of allocated buffers.
  Not use IDR interface because it is marked as deprecated in kernel
  documentation.
- Add a module parameter to limit the number of buffer per queue.
- Add DELETE_BUF ioctl and m2m helpers.

Benjamin Gaignard (8):
  media: videobuf2: Access vb2_queue bufs array through helper functions
  media: videobuf2: Make bufs array dynamic allocated
  media: videobuf2: Add a module param to limit vb2 queue buffer storage
  media: videobuf2: Stop define VB2_MAX_FRAME as global
  media: v4l2: Add DELETE_BUF ioctl
  media: v4l2: Add mem2mem helpers for DELETE_BUF ioctl
  media: vim2m: Use v4l2-mem2mem helpers for VIDIOC_DELETE_BUF ioctl
  media: verisilicon: Use v4l2-mem2mem helpers for VIDIOC_DELETE_BUF
    ioctl

 .../userspace-api/media/v4l/user-func.rst     |   1 +
 .../media/v4l/vidioc-delete-buf.rst           |  51 ++++++
 .../media/common/videobuf2/videobuf2-core.c   | 168 +++++++++++++-----
 .../media/common/videobuf2/videobuf2-v4l2.c   |  23 ++-
 drivers/media/platform/amphion/vdec.c         |   1 +
 drivers/media/platform/amphion/vpu_dbg.c      |   4 +-
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    |   2 +-
 .../vcodec/vdec/vdec_vp9_req_lat_if.c         |   4 +-
 drivers/media/platform/qcom/venus/hfi.h       |   2 +
 .../media/platform/verisilicon/hantro_hw.h    |   2 +
 .../media/platform/verisilicon/hantro_v4l2.c  |   1 +
 drivers/media/test-drivers/vim2m.c            |   1 +
 drivers/media/test-drivers/visl/visl-dec.c    |  16 +-
 drivers/media/v4l2-core/v4l2-dev.c            |   1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  10 ++
 drivers/media/v4l2-core/v4l2-mem2mem.c        |  20 +++
 .../staging/media/atomisp/pci/atomisp_ioctl.c |   2 +-
 drivers/staging/media/ipu3/ipu3-v4l2.c        |   2 +
 include/media/v4l2-ioctl.h                    |   4 +
 include/media/v4l2-mem2mem.h                  |  12 ++
 include/media/videobuf2-core.h                |  84 ++++++++-
 include/media/videobuf2-v4l2.h                |  15 +-
 include/uapi/linux/videodev2.h                |   1 +
 23 files changed, 353 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst

-- 
2.34.1

