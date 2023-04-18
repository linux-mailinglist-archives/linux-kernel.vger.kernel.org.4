Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25956E5B70
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjDRIDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjDRICe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:02:34 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6A14492;
        Tue, 18 Apr 2023 01:02:02 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 78450240003;
        Tue, 18 Apr 2023 08:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681804919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OjDn7feuOfCx2JjEUm878aYF49HGL6X0Phz44CtOnuQ=;
        b=I7tZjmhH627GBuHF1wzSyhCZUFSROiN803K5xByz5h/wt2k+vh76TmZaCefebp80x3tKbt
        0kpo4QrCalP+dLGNLqxKfbSCCAJm+6bwNHkBQLwEzKBagUNnUGZPxEd8jWtNRK3e+59QaY
        Tiq9bgDcC3neCV9d6syb1oGzdfrMqs4FkUl0j+lc6Pke91BnkjTVb7xe10tZYr6dDnbLZf
        zIBUz+rbcZ2D0oSA8IE8pOVTb9vauOgQKOMhQ53snUFlXg2m+oy2KvfcCUeQRmhCHsEPA7
        mCfxL1NF8yRAm6lppOViupcDCHjs+CPjo1eGp96jBBk0KBYkZyXgfdD4uy9HrA==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     linux-tegra@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v6 15/20] staging: media: tegra-video: add a per-soc enable/disable op
Date:   Tue, 18 Apr 2023 10:00:49 +0200
Message-Id: <20230418080054.452955-16-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418080054.452955-1-luca.ceresoli@bootlin.com>
References: <20230418080054.452955-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra20 VI needs an additional operation to enable the VI, add an
operation for that.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>

---

No changes in v6
No changes in v5

Changed in v4:
 - Added review tags

No changes in v3
No changes in v2
---
 drivers/staging/media/tegra-video/vi.c | 7 +++++++
 drivers/staging/media/tegra-video/vi.h | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index c76c2a404889..8df233049c81 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1950,6 +1950,9 @@ static int tegra_vi_probe(struct platform_device *pdev)
 	vi->client.ops = &vi_client_ops;
 	vi->client.dev = &pdev->dev;
 
+	if (vi->ops->vi_enable)
+		vi->ops->vi_enable(vi, true);
+
 	ret = host1x_client_register(&vi->client);
 	if (ret < 0) {
 		dev_err(&pdev->dev,
@@ -1960,6 +1963,8 @@ static int tegra_vi_probe(struct platform_device *pdev)
 	return 0;
 
 rpm_disable:
+	if (vi->ops->vi_enable)
+		vi->ops->vi_enable(vi, false);
 	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
@@ -1976,6 +1981,8 @@ static int tegra_vi_remove(struct platform_device *pdev)
 		return err;
 	}
 
+	if (vi->ops->vi_enable)
+		vi->ops->vi_enable(vi, false);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
diff --git a/drivers/staging/media/tegra-video/vi.h b/drivers/staging/media/tegra-video/vi.h
index b424c967c6f2..886b10e7d723 100644
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

