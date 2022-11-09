Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4CB622DA6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiKIOV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiKIOUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:20:44 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECE21F9CA;
        Wed,  9 Nov 2022 06:20:07 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 65DDCFF80A;
        Wed,  9 Nov 2022 14:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668003603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WqadaQ7yXjv/t0SavSa/yt7ba9txtNTuK1AiW/yRmsI=;
        b=KQg2bF+92M9dGL/Jc82k7ZMsuv/EInDiLTZ64PwJkkakvn2TAfYiSFF/kn0L4bBS1LX6ut
        v2ETBf0Es1FnH+CZSnVxyUg4fsUaCZwqPJMizdu5JvDODlGWOjyxyfi2ACjoVghepyKnSp
        tNTAqWB2EeAIhC4KWJT5qZoF3bB/iJL0iZqqksn5E2C5ly+CIFeMdzx76G2dwE1iCIjNWX
        N6jGvJkdfg9QvbbnE00xGS3Wd6v2fbWnyjc3GydNwvL9ytsbpgSY3UUM6A7uLj3zsBGcDq
        bDP4cSD08hL/u3UXmnDL6nCRHTsQL6dEy1ipeHVtCL7xBB6TeJ0+pHYbKOJx7g==
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
Subject: [PATCH 17/23] staging: media: tegra-video: add a per-soc enable/disable op
Date:   Wed,  9 Nov 2022 15:18:46 +0100
Message-Id: <20221109141852.729246-18-luca.ceresoli@bootlin.com>
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

The Tegra20 VI needs an additional operation to enable the VI, add an
operation for that.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/staging/media/tegra-video/vi.c | 7 +++++++
 drivers/staging/media/tegra-video/vi.h | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 2dd3c6c944a2..d0c387873d4e 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1853,6 +1853,9 @@ static int tegra_vi_probe(struct platform_device *pdev)
 	vi->client.ops = &vi_client_ops;
 	vi->client.dev = &pdev->dev;
 
+	if (vi->ops->vi_enable)
+		vi->ops->vi_enable(vi, true);
+
 	ret = host1x_client_register(&vi->client);
 	if (ret < 0) {
 		dev_err(&pdev->dev,
@@ -1863,6 +1866,8 @@ static int tegra_vi_probe(struct platform_device *pdev)
 	return 0;
 
 rpm_disable:
+	if (vi->ops->vi_enable)
+		vi->ops->vi_enable(vi, false);
 	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
@@ -1879,6 +1884,8 @@ static int tegra_vi_remove(struct platform_device *pdev)
 		return err;
 	}
 
+	if (vi->ops->vi_enable)
+		vi->ops->vi_enable(vi, false);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
diff --git a/drivers/staging/media/tegra-video/vi.h b/drivers/staging/media/tegra-video/vi.h
index 879547073371..851c4f3fcb91 100644
--- a/drivers/staging/media/tegra-video/vi.h
+++ b/drivers/staging/media/tegra-video/vi.h
@@ -37,8 +37,11 @@ enum tegra_vi_pg_mode {
 	TEGRA_VI_PG_PATCH,
 };
 
+struct tegra_vi;
+
 /**
  * struct tegra_vi_ops - Tegra VI operations
+ * @vi_enable: soc-specific operations needed to enable/disable the VI peripheral
  * @vi_fmt_align: modify `pix` to fit the hardware alignment
  *		requirements and fill image geometry
  * @vi_start_streaming: starts media pipeline, subdevice streaming, sets up
@@ -48,6 +51,7 @@ enum tegra_vi_pg_mode {
  *		back any queued buffers.
  */
 struct tegra_vi_ops {
+	int (*vi_enable)(struct tegra_vi *vi, bool on);
 	void (*vi_fmt_align)(struct v4l2_pix_format *pix, unsigned int bpp);
 	int (*vi_start_streaming)(struct vb2_queue *vq, u32 count);
 	void (*vi_stop_streaming)(struct vb2_queue *vq);
-- 
2.34.1

