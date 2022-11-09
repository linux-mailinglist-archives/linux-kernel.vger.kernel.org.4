Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E95622DAF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiKIOV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiKIOVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:21:11 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EA8233BF;
        Wed,  9 Nov 2022 06:20:12 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id B5EE6FF80D;
        Wed,  9 Nov 2022 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668003609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=htGRYXVJHCm+VjabaduYJWZ2LBkEOdCNwzZfPxcpLAk=;
        b=dIFQPstrZBE9F39CDeMweJNRNdwH9ovs1sNOXltT4zqaZEY7cfZc6BySALsx3umUd4nfrQ
        JjowYHiwMbJb3gR8NkfOQQ/jrjo5Ch0thJyUXxc3bPJ1HFCeGMpICQYXjQJvTa9ZC9CdOn
        rWu5Fg0xArIN52xsjhbDh+lnQe+5+wfuBoGP2TkMruFyOma6t9om7bvBqQJQVL/3cWFJhY
        uqvc97cyA2x8dSH3snjEb/v2+kj/3Nc96Hvl7AELJ1rLHvPrqPxBlicYyg9ISwT52S9xMV
        XgkKsV+iO0g+VAmVHlXxPoaLvGdX41eYHY3gaKDHZ6gvNEqOIxplqHPF76Mzew==
From:   luca.ceresoli@bootlin.com
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 19/23] staging: media: tegra-video: add syncpts for Tegra20 to struct tegra_vi
Date:   Wed,  9 Nov 2022 15:18:48 +0100
Message-Id: <20221109141852.729246-20-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109141852.729246-1-luca.ceresoli@bootlin.com>
References: <20221109141852.729246-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

In preparation to implement Tegra20 parallel video capture, add variables
to hold the required syncpt.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/staging/media/tegra-video/vi.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.h b/drivers/staging/media/tegra-video/vi.h
index 8fadca33bcc9..ba563cd17296 100644
--- a/drivers/staging/media/tegra-video/vi.h
+++ b/drivers/staging/media/tegra-video/vi.h
@@ -117,11 +117,13 @@ struct tegra_vi {
  * @vi: Tegra video input device structure
  * @frame_start_sp: host1x syncpoint pointer to synchronize programmed capture
  *		start condition with hardware frame start events through host1x
- *		syncpoint counters.
+ *		syncpoint counters. (Tegra210)
  * @mw_ack_sp: host1x syncpoint pointer to synchronize programmed memory write
  *		ack trigger condition with hardware memory write done at end of
- *		frame through host1x syncpoint counters.
+ *		frame through host1x syncpoint counters. (Tegra210)
  * @sp_incr_lock: protects cpu syncpoint increment.
+ * @out_sp: host1x syncpoint pointer for frame sync (Tegra20)
+ * @next_out_sp_idx: next expected value for @out_sp (Tegra20)
  *
  * @kthread_start_capture: kthread to start capture of single frame when
  *		vb buffer is available. This thread programs VI CSI hardware
@@ -173,6 +175,8 @@ struct tegra_vi_channel {
 	struct host1x_syncpt *mw_ack_sp[GANG_PORTS_MAX];
 	/* protects the cpu syncpoint increment */
 	spinlock_t sp_incr_lock[GANG_PORTS_MAX];
+	struct host1x_syncpt *out_sp;
+	u32 next_out_sp_idx;
 
 	struct task_struct *kthread_start_capture;
 	wait_queue_head_t start_wait;
-- 
2.34.1

