Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FC66B6C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 00:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCLXb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 19:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCLXbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 19:31:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1B631E2C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:31:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id er25so13801585edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678663905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhdKUD0TAzd/uf+JAXT2IFzkYdIwo6ITZjySQ+D1PHE=;
        b=azPy5XcGlzr++jtHV3Dz2BfDG54xn1DZmdZVW/yrxOPDggNzgdJCe5NY/N53tgfy5y
         5ylErCksi1wEOEr9GpO1WtOqQ+TYwO+/oHNzuwjvSoheLsq7bj9ZViSJdmWOX3okfz3O
         AYnYl64mFt4m/NqNtAzN8lRCzTQYp0jlwYR8S/ItddVUV5lyH5ACOVuo5/rmCol7a1dD
         R14jFVP+Fji9b/FiVFFwdP1ExLJPFKH6x2PTDnd/uIEFeOiyj5m7EoBjDmlspAqUveDD
         nWF1LYVIdpve7VMYQ5b/MM57G8ONaFV91d5kOWspMK2fl9SogHMYE9J5X1tm+cvjjZuI
         +MJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678663905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhdKUD0TAzd/uf+JAXT2IFzkYdIwo6ITZjySQ+D1PHE=;
        b=0Ow1+U55FQWfnpaO5rN4/ln0YFqRoPKfsK2Xo2+7GbTBR0aBj0t/i8DOUg7t7AJEt3
         bzJAoxEftz5Q8q9NISjunFoBMmenIFeoNRjqJeOlQyCneqYVeByK6Z61LcuMtJi+o5cl
         GdoCVXFNpLq91cHDRG0nrGRCBTVZMy7wHXLCuPufqBLl8iAGq1yznnyaGvlVJQRLlLoc
         KIfFF/PbzRhrb0mDiav4B0wCAV/hjSNtieImmzfsw89slJNVIEflOUifjltmkoBDl/x6
         u4rfxchQEBYkICadR7OUOv/NsqBMZvHAvSUYQ2HyFl8Z9X5uwTsRxKZ70ACllwYD6JSi
         m5uA==
X-Gm-Message-State: AO0yUKXxewQOAIe6FthFEJDIB1zZxgrYWI5ne7s8PwqdVb7OpXrC8sy9
        eDlZvWx8oJ9mgE3OBjAcIEQ=
X-Google-Smtp-Source: AK7set+nzU3s/+PxT8hDjsADugoTfEsghkmA9lYqthx06STAreKzJ43EtL1b8gNvii1ClfkTzC5WYQ==
X-Received: by 2002:a17:907:7f12:b0:928:d4f6:6f7b with SMTP id qf18-20020a1709077f1200b00928d4f66f7bmr2138268ejc.66.1678663904834;
        Sun, 12 Mar 2023 16:31:44 -0700 (PDT)
Received: from centennial.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id vv11-20020a170907a68b00b009226f644a07sm2009958ejc.139.2023.03.12.16.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 16:31:43 -0700 (PDT)
From:   Erico Nunes <nunes.erico@gmail.com>
To:     Qiang Yu <yuq825@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH 3/3] drm/lima: add show_fdinfo for drm usage stats
Date:   Mon, 13 Mar 2023 00:30:52 +0100
Message-Id: <20230312233052.21095-4-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312233052.21095-1-nunes.erico@gmail.com>
References: <20230312233052.21095-1-nunes.erico@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This exposes an accumulated active time per client via the fdinfo
infrastructure per execution engine, following
Documentation/gpu/drm-usage-stats.rst.
In lima, the exposed execution engines are gp and pp.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_drv.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index d23c0b77a252..c044a31493a4 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -261,7 +261,36 @@ static const struct drm_ioctl_desc lima_drm_driver_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(LIMA_CTX_FREE, lima_ioctl_ctx_free, DRM_RENDER_ALLOW),
 };
 
-DEFINE_DRM_GEM_FOPS(lima_drm_driver_fops);
+static void lima_drm_driver_show_fdinfo(struct seq_file *m, struct file *filp)
+{
+	struct drm_file *file = filp->private_data;
+	struct drm_device *dev = file->minor->dev;
+	struct lima_device *ldev = dev->dev_private;
+	struct lima_drm_priv *priv = file->driver_priv;
+	struct lima_ctx_mgr *ctx_mgr = &priv->ctx_mgr;
+	u64 usage[lima_pipe_num];
+
+	lima_ctx_mgr_usage(ctx_mgr, usage);
+
+	/*
+	 * For a description of the text output format used here, see
+	 * Documentation/gpu/drm-usage-stats.rst.
+	 */
+	seq_printf(m, "drm-driver:\t%s\n", dev->driver->name);
+	seq_printf(m, "drm-client-id:\t%u\n", priv->id);
+	for (int i = 0; i < lima_pipe_num; i++) {
+		struct lima_sched_pipe *pipe = &ldev->pipe[i];
+		struct drm_gpu_scheduler *sched = &pipe->base;
+
+		seq_printf(m, "drm-engine-%s:\t%llu ns\n", sched->name, usage[i]);
+	}
+}
+
+static const struct file_operations lima_drm_driver_fops = {
+	.owner = THIS_MODULE,
+	DRM_GEM_FOPS,
+	.show_fdinfo = lima_drm_driver_show_fdinfo,
+};
 
 /*
  * Changelog:
-- 
2.39.2

