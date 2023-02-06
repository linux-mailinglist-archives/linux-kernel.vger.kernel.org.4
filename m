Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C16868B4DD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 05:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjBFEdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 23:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjBFEdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 23:33:31 -0500
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DC418179
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 20:33:29 -0800 (PST)
Received: from misaki.sumomo.pri (unknown [192.168.0.134])
        by kozue.soulik.info (Postfix) with ESMTPA id 3D8BD100DAB;
        Mon,  6 Feb 2023 13:33:20 +0900 (JST)
From:   ayaka <ayaka@soulik.info>
To:     linux-media@vger.kernel.org
Cc:     randy.li@synaptics.com, Brian.Starkey@arm.com,
        boris.brezillon@collabora.com, frkoenig@chromium.org,
        hans.verkuil@cisco.com, hiroh@chromium.org, hverkuil@xs4all.nl,
        kernel@collabora.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        narmstrong@baylibre.com, nicolas@ndufresne.ca, sakari.ailus@iki.fi,
        stanimir.varbanov@linaro.org, tfiga@chromium.org,
        "Randy Li" <ayaka@soulik.info>
Subject: [RFC PATCH v7 0/9] media: v4l2: Add extended fmt and buffer
Date:   Mon,  6 Feb 2023 12:32:59 +0800
Message-Id: <20230206043308.28365-1-ayaka@soulik.info>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Randy Li" <ayaka@soulik.info>

This is the v7 refresh of the previous v6.
Except the ext fmt part, I drop backward feedback feature. I didn't
changes those ext_buf related patches unless it conflicts during
the refresh.

v6:
https://patchwork.linuxtv.org/project/linux-media/cover/20210114180738.1758707-1-helen.koike@collabora.com/
v5:
https://patchwork.linuxtv.org/project/linux-media/cover/20200804192939.2251988-1-helen.koike@collabora.com/
v4:
https://patchwork.linuxtv.org/project/linux-media/cover/20200717115435.2632623-1-helen.koike@collabora.com/
v3: https://patchwork.linuxtv.org/cover/59345/
v2: https://patchwork.kernel.org/project/linux-media/list/?series=101153
v1: https://patchwork.kernel.org/project/linux-media/list/?series=93707

Helen Koike (8):
  media: vivid: Convert to v4l2_ext_pix_format
  media: v4l2: Add extended buffer (de)queue operations for video types
  media: videobuf2-v4l2: reorganize flags handling
  media: videobuf2: Expose helpers for Ext qbuf/dqbuf
  media: vivid: use vb2_ioctls_ext_{d}qbuf hooks
  media: vimc: use vb2_ioctls_ext_{d}qbuf hooks
  media: mediabus: Add helpers to convert a ext_pix format to/from a
    mbus_fmt
  media: vimc: Convert to v4l2_ext_pix_format

Randy Li (1):
  media: v4l2: Extend pixel formats to unify single/multi-planar
    handling (and more)

 .../media/common/videobuf2/videobuf2-core.c   |  46 +-
 .../media/common/videobuf2/videobuf2-v4l2.c   | 499 ++++++++++++----
 .../media/test-drivers/vimc/vimc-capture.c    | 119 ++--
 drivers/media/test-drivers/vimc/vimc-common.c |   6 +-
 drivers/media/test-drivers/vimc/vimc-common.h |   2 +-
 drivers/media/test-drivers/vivid/vivid-core.c | 106 +---
 .../media/test-drivers/vivid/vivid-vid-cap.c  | 203 +++----
 .../media/test-drivers/vivid/vivid-vid-cap.h  |  15 +-
 .../media/test-drivers/vivid/vivid-vid-out.c  | 198 +++----
 .../media/test-drivers/vivid/vivid-vid-out.h  |  15 +-
 drivers/media/v4l2-core/v4l2-dev.c            |  17 +
 drivers/media/v4l2-core/v4l2-ioctl.c          | 541 +++++++++++++++++-
 include/media/v4l2-ioctl.h                    |  36 ++
 include/media/v4l2-mediabus.h                 |  42 ++
 include/media/videobuf2-core.h                |  33 +-
 include/media/videobuf2-v4l2.h                |   8 +-
 include/uapi/linux/videodev2.h                | 101 +++-
 17 files changed, 1459 insertions(+), 528 deletions(-)

-- 
2.17.1

