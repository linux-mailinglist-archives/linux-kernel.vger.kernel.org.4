Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF2E6D5586
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 02:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjDDA2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 20:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDDA2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 20:28:06 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8F1F2139
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hTfRX
        v529POZONG3xBGKc0eFtpS/ui6QZ+0V2eow3Mc=; b=hPAd1bgUfHSivH0xEBrN0
        DwRPcFE88IyUrLF5SGIVNXNdkh7ejxHXxTQZM/5W9eJw8sLG3dcZ2yWUjU8oexEh
        nqYUKKegFA2uIpfFnOopiVgvNASPFH5cR+bN3NdUSDvr/aUxusJs+ynIE4MYmuhF
        jErHxOVjTUxG5kwWTqdVwE=
Received: from yuq-Aspire-4738G.lan (unknown [116.225.76.16])
        by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wBHK4Tkbitk8woAAg--.8076S3;
        Tue, 04 Apr 2023 08:27:25 +0800 (CST)
From:   yq882255@163.com
To:     dri-devel@lists.freedesktop.org
Cc:     Erico Nunes <nunes.erico@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Qiang Yu <yuq825@gmail.com>
Subject: [PATCH 1/3] Revert "drm/lima: add show_fdinfo for drm usage stats"
Date:   Tue,  4 Apr 2023 08:25:59 +0800
Message-Id: <20230404002601.24136-2-yq882255@163.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230404002601.24136-1-yq882255@163.com>
References: <20230404002601.24136-1-yq882255@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHK4Tkbitk8woAAg--.8076S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw45KrWDWw4Uuw4DKFyxuFg_yoW8Zr1DpF
        sxA3y2yrWxAr4UWwnrA34DuryaqasrZayfur18Gwna9Fn0vryjgFW5tr1xZrW5Jry7A3Za
        qr4qkry7CF1Ik3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-F4_UUUUU=
X-Originating-IP: [116.225.76.16]
X-CM-SenderInfo: d1tymjqsvvqiywtou0bp/1tbiVhJHGlqzxIGuZQAAs+
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiang Yu <yuq825@gmail.com>

This reverts commit 4a66f3da99dcb4dcbd28544110636b50adfb0f0d.

This is due to the depend commit has been reverted on upstream:
baad10973fdb ("Revert "drm/scheduler: track GPU active time per entity"")

Signed-off-by: Qiang Yu <yuq825@gmail.com>
---
 drivers/gpu/drm/lima/lima_drv.c | 31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index 3420875d6fc6..f456a471216b 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -261,36 +261,7 @@ static const struct drm_ioctl_desc lima_drm_driver_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(LIMA_CTX_FREE, lima_ioctl_ctx_free, DRM_RENDER_ALLOW),
 };
 
-static void lima_drm_driver_show_fdinfo(struct seq_file *m, struct file *filp)
-{
-	struct drm_file *file = filp->private_data;
-	struct drm_device *dev = file->minor->dev;
-	struct lima_device *ldev = to_lima_dev(dev);
-	struct lima_drm_priv *priv = file->driver_priv;
-	struct lima_ctx_mgr *ctx_mgr = &priv->ctx_mgr;
-	u64 usage[lima_pipe_num];
-
-	lima_ctx_mgr_usage(ctx_mgr, usage);
-
-	/*
-	 * For a description of the text output format used here, see
-	 * Documentation/gpu/drm-usage-stats.rst.
-	 */
-	seq_printf(m, "drm-driver:\t%s\n", dev->driver->name);
-	seq_printf(m, "drm-client-id:\t%u\n", priv->id);
-	for (int i = 0; i < lima_pipe_num; i++) {
-		struct lima_sched_pipe *pipe = &ldev->pipe[i];
-		struct drm_gpu_scheduler *sched = &pipe->base;
-
-		seq_printf(m, "drm-engine-%s:\t%llu ns\n", sched->name, usage[i]);
-	}
-}
-
-static const struct file_operations lima_drm_driver_fops = {
-	.owner = THIS_MODULE,
-	DRM_GEM_FOPS,
-	.show_fdinfo = lima_drm_driver_show_fdinfo,
-};
+DEFINE_DRM_GEM_FOPS(lima_drm_driver_fops);
 
 /*
  * Changelog:
-- 
2.25.1

