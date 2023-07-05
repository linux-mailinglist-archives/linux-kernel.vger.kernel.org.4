Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311767483D4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjGEMLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjGEMLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:11:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C87BE;
        Wed,  5 Jul 2023 05:11:05 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:cbfb:e358:222c:d8c1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 354B266020F5;
        Wed,  5 Jul 2023 13:11:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688559063;
        bh=0EkrhqfP9XUDXvCh3iJ2AF/1rs8GBjnfIgfGSYhPJMo=;
        h=From:To:Cc:Subject:Date:From;
        b=e6SFTrA/Jj+0xACBNA/LjXYY9LHtlF9uNFamKrovQoUdpxcuDIYTWlQSlXqaRrpcZ
         Dq/N3wsdZeHPIrDsTpHSteNF04Q+7zKvF4sJM6Wv8kZmIw0TME12eRRkqOSUrySuoz
         IqcVmjQQpgDuHQEZtVa6hhfAClSumhkjq7+Kjs5pWAwt/U/qkATMvIothDaB90hsby
         wcsNZuJ9PtKJhAiuVkuFd4j3T7F1QxCo9TC5y2utZmibmDhAqxTjpCVGk4CrNbEsN+
         n+Ouqv0/ZvYpSMoeB3Bp9OLkxm/Aja9VtC4x9ANyRK7exm3NQd4fx4A1m03koZg2Bo
         z2ZmREQ30ZsHw==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v4 00/10]  Add DELETE_BUF ioctl
Date:   Wed,  5 Jul 2023 14:10:46 +0200
Message-Id: <20230705121056.37017-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike when resolution change on keyframes, dynamic resolution change
on inter frames doesn't allow to do a stream off/on sequence because
it is need to keep all previous references alive to decode inter frames.
This constraint have two main problems:
- more memory consumption.
- more buffers in use.
To solve these issue this series introduce DELETE_BUFS ioctl and remove
the 32 buffers limit per queue.

VP9 conformance tests using fluster give a score of 210/305.
The 24 resize inter tests (vp90-2-21-resize_inter_* files) are ok
but require to use postprocessor.

Kernel branch is available here:
https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/remove_vb2_queue_limit_v4

GStreamer branch to use DELETE_BUF ioctl and testing dynamic resolution
change is here:
https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/commits/VP9_drc

changes in version 4:
- Stop using Xarray, instead let queues decide about their own maximum
  number of buffer and allocate bufs array given that value.
- Rework offset cookie encoding pattern.
- Change DELETE_BUF to DELETE_BUFS because it now usable for
  range of buffer to be symetrical of CREATE_BUFS.
- Add fixes tags on couple of Verisilicon related patches.
- Be smarter in Verisilicon postprocessor buffers management.
- Rebase on top of v6.4

changes in version 3:
- Use Xarray API to store allocated video buffers.
- No module parameter to limit the number of buffer per queue.
- Use Xarray inside Verisilicon driver to store postprocessor buffers
  and remove VB2_MAX_FRAME limit.
- Allow Versilicon driver to change of resolution while streaming
- Various fixes the Verisilicon VP9 code to improve fluster score.
 
changes in version 2:
- Use a dynamic array and not a list to keep trace of allocated buffers.
  Not use IDR interface because it is marked as deprecated in kernel
  documentation.
- Add a module parameter to limit the number of buffer per queue.
- Add DELETE_BUF ioctl and m2m helpers.
 
Benjamin Gaignard (10):
  media: videobuf2: Access vb2_queue bufs array through helper functions
  media: videobuf2: Be more flexible on the number of queue stored
    buffers
  media: videobuf2: Rework offset 'cookie' encoding pattern
  media: verisilicon: Refactor postprocessor to store more buffers
  media: verisilicon: Store chroma and motion vectors offset
  media: verisilicon: vp9: Use destination buffer height to compute
    chroma offset
  media: verisilicon: postproc: Fix down scale test
  media: verisilicon: vp9: Allow to change resolution while streaming
  media: v4l2: Add DELETE_BUFS ioctl
  media: v4l2: Add mem2mem helpers for DELETE_BUFS ioctl

 .../userspace-api/media/v4l/user-func.rst     |   1 +
 .../media/v4l/vidioc-delete-bufs.rst          |  73 +++++
 .../media/common/videobuf2/videobuf2-core.c   | 304 +++++++++++++-----
 .../media/common/videobuf2/videobuf2-v4l2.c   |  44 ++-
 drivers/media/platform/amphion/vpu_dbg.c      |  22 +-
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    |   6 +-
 .../vcodec/vdec/vdec_vp9_req_lat_if.c         |   2 +-
 drivers/media/platform/st/sti/hva/hva-v4l2.c  |   4 +
 drivers/media/platform/verisilicon/hantro.h   |   9 +-
 .../media/platform/verisilicon/hantro_drv.c   |   4 +-
 .../platform/verisilicon/hantro_g2_vp9_dec.c  |  10 +-
 .../media/platform/verisilicon/hantro_hw.h    |   2 +-
 .../platform/verisilicon/hantro_postproc.c    | 105 ++++--
 .../media/platform/verisilicon/hantro_v4l2.c  |  27 +-
 drivers/media/test-drivers/vim2m.c            |   1 +
 drivers/media/test-drivers/visl/visl-dec.c    |  28 +-
 drivers/media/v4l2-core/v4l2-dev.c            |   1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  17 +
 drivers/media/v4l2-core/v4l2-mem2mem.c        |  20 ++
 .../staging/media/atomisp/pci/atomisp_ioctl.c |   2 +-
 include/media/v4l2-ioctl.h                    |   4 +
 include/media/v4l2-mem2mem.h                  |  12 +
 include/media/videobuf2-core.h                |  13 +-
 include/media/videobuf2-v4l2.h                |  11 +
 include/uapi/linux/videodev2.h                |  17 +
 25 files changed, 592 insertions(+), 147 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst

-- 
2.39.2

