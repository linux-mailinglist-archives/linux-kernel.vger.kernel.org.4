Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D787A658D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiL2NeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 08:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbiL2Ndn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:33:43 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC6311C24;
        Thu, 29 Dec 2022 05:33:04 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 44FBCFF810;
        Thu, 29 Dec 2022 13:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672320782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmVEahmNOu/9XkwMiVdBvL6gDHPQH+245qlFUC5ws4k=;
        b=apw5+e6aWCj4dRLTZ1BGruiImviQ2Nozxdv0Zt9IRaT2cggI2CvLG/RdR8P6eEKCJS8Suu
        u2kZIH+RbxSjpo2pbioNY10citwaaoC0g65Bze8BWzeYq0dDGKIuNrVbv/r8g7lyHgMh8G
        yi+2i6wK24vxoXxRI1Z2K5ZoezHMJ52dk8BFMsqHgKHTTIbAuTwPMVra3wnMXwUJatGf+H
        oGqK3rso5948BeoOnuCCYlZSKhraFuOdCooH5D2EB8LCzApNmFJudq/U2r04ERrMIq9fG9
        gsU/9f1JMqHeMukH67OtEDfrA0XM7BCPmf1q5vDF7tsGnPDrSm3QBuZd4JrImg==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v3 18/21] staging: media: tegra-video: add syncpts for Tegra20 to struct tegra_vi
Date:   Thu, 29 Dec 2022 14:32:02 +0100
Message-Id: <20221229133205.981397-19-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229133205.981397-1-luca.ceresoli@bootlin.com>
References: <20221229133205.981397-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to implement Tegra20 parallel video capture, add a variable
to hold the required syncpt and document all the syncpt variables.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v3:
 - recycle mw_ack_sp[0] instead of adding out_sp

No changes in v2
---
 drivers/staging/media/tegra-video/vi.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.h b/drivers/staging/media/tegra-video/vi.h
index 8fadca33bcc9..d5e1ed4217e0 100644
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
+ *		frame through host1x syncpoint counters (On Tegra20 used for the
+ *              OUT_1 syncpt)
  * @sp_incr_lock: protects cpu syncpoint increment.
+ * @next_out_sp_idx: next expected value for mw_ack_sp[0], i.e. OUT_1 (Tegra20)
  *
  * @kthread_start_capture: kthread to start capture of single frame when
  *		vb buffer is available. This thread programs VI CSI hardware
@@ -173,6 +175,7 @@ struct tegra_vi_channel {
 	struct host1x_syncpt *mw_ack_sp[GANG_PORTS_MAX];
 	/* protects the cpu syncpoint increment */
 	spinlock_t sp_incr_lock[GANG_PORTS_MAX];
+	u32 next_out_sp_idx;
 
 	struct task_struct *kthread_start_capture;
 	wait_queue_head_t start_wait;
-- 
2.34.1

