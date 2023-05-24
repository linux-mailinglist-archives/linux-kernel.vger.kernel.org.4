Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE02B70F79B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjEXN3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjEXN3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:29:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D9DBF
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:29:32 -0700 (PDT)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1q1oYU-0007Bo-5v; Wed, 24 May 2023 15:29:30 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 0/2] media: video-mux: fix error paths and update to active state
Date:   Wed, 24 May 2023 15:29:24 +0200
Message-Id: <20230524-video-mux-active-state-v1-0-325c69937ac3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADQRbmQC/x2N0QrCMAwAf2Xk2UBtpzh/RXxIu+gCs5OmK4Oxf
 zf4eAfH7aBchBXu3Q6Fm6gs2eB86iBNlN+MMhqDdz64i++xycgLftYNKVVpjFqpMrrheot9cIFp
 AIsjKWMslNNkeV7n2eS38Eu2/+3xPI4fO2r7W30AAAA=
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.12-dev-aab37
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix V4L2 async notifier and media entity cleanup and replace the open
coded pad format array with subdev active state to reduce some boiler
plate.

Tested on v6.4-rc3 on i.MX6QP with the async-multi patches [1].

[1] https://lore.kernel.org/all/20230524112349.2141396-1-sakari.ailus@linux.intel.com/

To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel@pengutronix.de
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

---
Philipp Zabel (2):
      media: video-mux: fix error paths
      media: video-mux: update driver to active state

 drivers/media/platform/video-mux.c | 104 +++++++++++++++----------------------
 1 file changed, 43 insertions(+), 61 deletions(-)
---
base-commit: a23a3041c733e068bed5ece88acb45fe0edf0413
change-id: 20230524-video-mux-active-state-0968b4303ea9

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>
