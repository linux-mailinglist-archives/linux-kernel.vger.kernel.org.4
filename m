Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318B663AC8B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiK1P1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiK1P1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:27:07 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CED924943;
        Mon, 28 Nov 2022 07:25:27 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 70852100008;
        Mon, 28 Nov 2022 15:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669649126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4L2vAgix/FUBMn0M/99DVyke1fXls4rI0uUzO7MX+jc=;
        b=iCt69+ylDHxiA2gkJhoPgSh+HTmr7PctRzItlxinwTagRevlXhbFQC4vdNlKMJWjUuGb09
        YhYsA+DaD9xw6vR5a8aeBkcGnct2o4RJhx75x5QpZfcQsJfVxIADbhMfweVGUNWJXFCiMQ
        6PEujs/MXTwEp1InPRytovxTJkJ+H0U2i6oY/kcw211LRtEAIdouwMP04Wvy0NK5DILnG9
        sTqRtD/fJN3/ZTUO+lZtTjhGrTKrxl/hDa0D0jiAIrjeB0lzHcb/qdTp4mnm/ZnGMsZ12I
        MBBHOEuzgB+eS+To20n4cQDUGYyiniGfLspyGHphbHHI1KI8L4PaIaXJDRRKsg==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2 15/21] staging: media: tegra-video: add a per-soc enable/disable op
Date:   Mon, 28 Nov 2022 16:23:30 +0100
Message-Id: <20221128152336.133953-16-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
References: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
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

The Tegra20 VI needs an additional operation to enable the VI, add an
operation for that.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

No changes in v2
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

