Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2DB61083C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 04:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbiJ1Ci1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 22:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbiJ1Ch7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:37:59 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAD843AE8;
        Thu, 27 Oct 2022 19:37:53 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 29S2D5CC054599;
        Fri, 28 Oct 2022 10:13:05 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 Oct
 2022 10:35:58 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <hverkuil-cisco@xs4all.nl>,
        <laurent.pinchart@ideasonboard.com>, <xavier.roumegue@oss.nxp.com>,
        <ezequiel@vanguardiasur.com.ar>, <stanimir.varbanov@linaro.org>,
        <nicolas.dufresne@collabora.com>, <sakari.ailus@linux.intel.com>,
        <ming.qian@nxp.com>, <andrzej.p@collabora.com>,
        <linux-media@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 0/5] add aspeed-jpeg support for aspeed-video
Date:   Fri, 28 Oct 2022 10:35:49 +0800
Message-ID: <20221028023554.928-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 29S2D5CC054599
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aim of this series is to add aspeed-jpeg support for aspeed-video
driver. aspeed-jpeg is a per-frame differential jpeg format which only
compress the parts which are different from the previous frame. In this
way, it reduces both the amount of data to be transferred by network and
those to be decoded on the client side.

In the last, debugfs information is also updated per this change.

Changes in v11:
 - Update document

Changes in v10:
 - Add document, aspeed-video.rst, for new V4L2 CID
 - Fix warnings reported by kernel test robot
 
Changes in v9:
 - Rebase on new kernel

Changes in v8:
 - Add information of decoder's implementation
 
Changes in v7:
 - Separate other patches alone from aspeed-jpeg series
 - for Aspeed-jpeg, generate an I frame every 8 frames
 - rename compression_mode as compression_scheme
 - Add more reference for aspeed-jpeg
 - Update debugfs message

Changes in v6:
 - Update description for new format, aspeed-jpeg, in Documentation.

Changes in v5:
 - Use model data to tell different soc

Changes in v4:
 - Add definition for the Aspeed JPEG format
 - Reserve controls for ASPEED
 - Use s_fmt to update format rather than new control
 - Update aspeed hq quality range, 1 ~ 12


Jammy Huang (5):
  media: v4l: Add definition for the Aspeed JPEG format
  media: v4l2-ctrls: Reserve controls for ASPEED
  media: Documentation: aspeed-video: Add user documentation for the
    aspeed-video driver
  media: aspeed: Support aspeed mode to reduce compressed data
  media: aspeed: Extend debug message

 .../media/drivers/aspeed-video.rst            |  65 ++++
 .../userspace-api/media/drivers/index.rst     |   1 +
 .../media/v4l/pixfmt-reserved.rst             |  17 +
 drivers/media/platform/aspeed/aspeed-video.c  | 317 +++++++++++++++---
 drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
 include/uapi/linux/aspeed-video.h             |  14 +
 include/uapi/linux/v4l2-controls.h            |   6 +
 include/uapi/linux/videodev2.h                |   1 +
 8 files changed, 370 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/userspace-api/media/drivers/aspeed-video.rst
 create mode 100644 include/uapi/linux/aspeed-video.h


base-commit: aae703b02f92bde9264366c545e87cec451de471
-- 
2.25.1

