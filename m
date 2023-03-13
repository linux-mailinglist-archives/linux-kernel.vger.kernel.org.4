Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75F56B79CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjCMOAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCMN7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:59:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6E56F637;
        Mon, 13 Mar 2023 06:59:26 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7a7b:d0cc:67e9:4297])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 00FCA66020C5;
        Mon, 13 Mar 2023 13:59:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678715964;
        bh=+om2k2KNQgvylarO49oxczzpR8UPvFV3qo3tlidzUT0=;
        h=From:To:Cc:Subject:Date:From;
        b=PrYrPAJYVyfuCF96dRZ7vSuoHhW31z3DNMLGXKHKxNJ5+8BrNiFh7mbqFGAx0OqBO
         NvGy3gsxpPKrIIMBzj5lUVYTClXrcY37rGoWf6rP3MdTJz9wX9DRHYrLA6KYQoi7wY
         wvnat1Fk21LZfIhnWlxld5uB4r+UkL3IDLPgpXvXDsgxrA+b9e35HVltnR9g9raRK8
         qwEqAPTVRXFzYKqnoGWSv4kkndvcrT8IFvJpHd4HM17YA/VxE0cZfBeUgujBnw/ro/
         uI/iSkUSL9F3+O2nYWT5VwcSqzwUTHxlAR80dJNRRXaZs3ZFr0JBnYHiMZJuetByFw
         ZM8TAlLUsvTvw==
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
        laurent.pinchart@ideasonboard.com, jerbel@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [RFC 0/4] Allow more than 32 vb2 buffers per queue
Date:   Mon, 13 Mar 2023 14:59:12 +0100
Message-Id: <20230313135916.862852-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queues can only store up to VB2_MAX_FRAME (32) vb2 buffers.
Some use cases like VP9 dynamic resolution change may require
to have more than 32 buffers in use at the same time.
The goal of this series is to prepare queues for these use
cases by replacing bufs array by a list a vb2 buffers.

For the same VP9 use case we will need to be able to delete
buffers from the queue to limit memory usage so this series
add a bitmap to manage buffer indexes. This should permit to
avoid creating holes in vb2 index range.

I test these patches with Fluster test suite on Hantro video
decoder (VP9 and HEVC). I notice no performances issues and 
no regressions.

Despite carefully checking if removing bufs array doesn't break
the compilation of any media driver, I may have miss some so
one of the goal of this RFC is also to trig compilation robots.
 
Benjamin Gaignard (4):
  media: videobuf2: Use vb2_get_buffer() as helper everywhere
  media: videobuf2: Replace bufs array by a list
  media: videobuf2: Use bitmap to manage vb2 index
  media: videobuf2: Stop define VB2_MAX_FRAME as global

 .../media/common/videobuf2/videobuf2-core.c   | 107 +++++++++++-------
 .../media/common/videobuf2/videobuf2-v4l2.c   |  17 +--
 drivers/media/platform/amphion/vdec.c         |   1 +
 drivers/media/platform/amphion/vpu_dbg.c      |   4 +-
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    |   2 +-
 .../vcodec/vdec/vdec_vp9_req_lat_if.c         |   4 +-
 drivers/media/platform/qcom/venus/hfi.h       |   2 +
 .../media/platform/verisilicon/hantro_hw.h    |   2 +
 drivers/media/test-drivers/visl/visl-dec.c    |  16 +--
 include/media/videobuf2-core.h                |  42 ++++++-
 include/media/videobuf2-v4l2.h                |   4 -
 11 files changed, 130 insertions(+), 71 deletions(-)

-- 
2.34.1

