Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39E86C80D3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjCXPM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjCXPMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:12:25 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80914DBD6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:12:04 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A446A10000C;
        Fri, 24 Mar 2023 15:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679670723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uEOh0qZu1a2y7GIksVmAUhkUm9kTU1yLtPR9HJ3ihj8=;
        b=ZokWZYJTGNn9ygnjiqhAgA2WsmQttAsCsQZ9b7QYA3tysT5jhchh0sMl2nn702pbQ2/O60
        nYX5hlcdhazB/sVPex+KwLJ5iRrRAY/9e8dWA5Lc3S6oXBGUSO32n8GVFHtD8WQv1I5wt6
        7/q8iwSjbX6S7Clm9bj11ZdwL43mljrADDhH30NectMuY7gkiJMg7R23bbULsrefrPQLrT
        hnQflll/cqzMKsFLgWKAkUJNX007IghfE6XrPI8x/SFqWkfXTzbzo7LqqWoDBytphe/GqK
        vzDNuIN7x0TYi29ZkUZ1xomVvrRYlnwg8bfMQ4NhxB5aHNkmaeObMR3kQxyRSg==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Adam Pigg --to=linux-media @ vger . kernel . org" <adam@piggz.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/9] media: sun6i-csi/isp: Implement MC I/O support
Date:   Fri, 24 Mar 2023 16:11:40 +0100
Message-Id: <20230324151149.2777981-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

