Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3061C6C80D8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjCXPNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjCXPM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:12:56 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC7C1ACCF;
        Fri, 24 Mar 2023 08:12:42 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C2396E0007;
        Fri, 24 Mar 2023 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679670760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uEOh0qZu1a2y7GIksVmAUhkUm9kTU1yLtPR9HJ3ihj8=;
        b=B5BnTzisW50LzspF5O2jxGpSPr1Nxkx+49UiHLF0VjP3w5CkLT5bKVsyuR1ENRXgD+XZbW
        eggTwlU2IsiUqMvICT7jzFRVg1kgvztD13zs+EzZskvCb2LMBB1PccWz/lOUATSkobuCSs
        fwjDf2vkSI6yaG1aK1HQO1M5BDZfsNkXF6C6eNor5V1b9cnmlQM+HqoqgcI9kNZ5hzEfG6
        ffUTbOlGIhVQnY3nxMnVOqjY6a0AXkGmd3yocYHIyf+LLcgMGZqMeMe8BUR4vqrd5fjHIk
        B8Cp1kRst2DDlY5D81NpLGS5Fg39IrAat7cgjyGJpXaJ68xulkdPpfZd1EjyTQ==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adam Pigg <adam@piggz.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/9] media: sun6i-csi/isp: Implement MC I/O support
Date:   Fri, 24 Mar 2023 16:12:19 +0100
Message-Id: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a follow-up to Adam Pigg's "suns6-csi changes to support
libcamera" series, with the same purpose.

As discussed in the original thread, it takes a different approach
and ensures input/output format matching is maintained without
regression.

New v4l2 format info is also added about unusual formats used by the
driver so that no specific logic is required to handle them.

The same functionality is also added to the sun6i-isp driver.

Paul Kocialkowski (9):
  media: v4l2: Add RGB565X pixel format to v4l2 format info
  media: v4l2: Add NV12_16L16 pixel format to v4l2 format info
  media: v4l2: Introduce compressed pixel encoding definition and helper
  media: v4l2: Add JPEG pixel format to v4l2 format info
  media: sun6i-csi: capture: Rework and separate format validation
  media: sun6i-csi: capture: Implement MC I/O with extended enum_fmt
  media: sun6i-csi: capture: Implement enum_framesizes
  media: sun6i-isp: capture: Implement MC I/O with extended enum_fmt
  media: sun6i-isp: capture: Implement enum_framesizes

 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 157 ++++++++++++------
 drivers/media/v4l2-core/v4l2-common.c         |   6 +
 .../media/sunxi/sun6i-isp/sun6i_isp_capture.c |  35 +++-
 include/media/v4l2-common.h                   |   7 +
 4 files changed, 154 insertions(+), 51 deletions(-)

-- 
2.39.2

