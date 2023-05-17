Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656C6706D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjEQQF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjEQQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:05:26 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97109110;
        Wed, 17 May 2023 09:05:25 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so816815a12.0;
        Wed, 17 May 2023 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684339525; x=1686931525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JbDnB2PXIbg1nrLsvecGt1DuT+K73v6dCg1HZevcZvc=;
        b=R+JAY/0n8zLGV8wFotOEzEJpiiGuPQJiOm3W4d16A9wrPM1VEk7cqZDc7jDh7VwHLe
         bMfHTeB3HFe7LBnZYLy7u9GRO9cQp9E7/Jg/2Vbjq5L9P7NGAxrkq/yNS/oDK1S3rb0W
         t9YJJ7xXTylFuZbhTJcmFSWCJJLRU12eopskn9Dy224gmIMOaP8JSFVepuxZfT10XCIw
         0MjvLgzetNIOv0z0ngngo7kh8a3lsXnIfZ93k/eTETASKJZlEg2EBMgQDdx0Dmnrj3tY
         nqyGZIaDur0HDgK+/Gy3hwzO3fth3LXQKpSiqX2QJsssWza9bQS3nZntIgG9rnIsZ30m
         HADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684339525; x=1686931525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbDnB2PXIbg1nrLsvecGt1DuT+K73v6dCg1HZevcZvc=;
        b=N/43dhOqs62g2dLEahPWPiMST66f4C8siv5W+I5AwMX5gBHu67KYSA8kmk4DFFvxe8
         RuoTmt/fNT+PnVS9FxTcJdlfW703mxCrvlxNkv2ikWUTej74MJghpTtFr3UE46CeC3Pk
         rq3cle3jufoEasf67AlqMoir51tXzZnaGSllQyqTjj8RqRez37eRa9QJ3ENa9ka36IOH
         3rjCHLDJ7i78LuA6ETvwExmTSTlAxgV9Ga9nzZdcvomNph3F/nShGwPCEIe9AJDuBzfI
         B0F9ldHl62q+wi1tlQQb28pUMC+o15yUCezzMchtSvHjUf7OFqkmWOmA6SRL9XxRbLIy
         bzbw==
X-Gm-Message-State: AC+VfDzCzWMt/e1j4KCHHUoUZaK3dC5ccXbbGQVIyl/NYz/HcHYkv7dA
        0urb4yrXU7WCVtZBboXVPBQ=
X-Google-Smtp-Source: ACHHUZ4oolr6vSu2DCsqdae9ZtsRnHqAr8S5wkd9TDaX6Pz+T6IL71zNKd6ul4I9LTk3ZBgpweyczA==
X-Received: by 2002:a17:90b:3645:b0:250:d137:e2ae with SMTP id nh5-20020a17090b364500b00250d137e2aemr168165pjb.23.1684339524459;
        Wed, 17 May 2023 09:05:24 -0700 (PDT)
Received: from Osmten.. ([103.84.150.101])
        by smtp.gmail.com with ESMTPSA id o4-20020a17090ad20400b00250c1392ed3sm1761949pju.55.2023.05.17.09.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:05:23 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, bchihi@baylibre.com,
        wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] lvts_thermal.c: Fix error checking for debugfs_create_dir
Date:   Wed, 17 May 2023 21:03:26 +0500
Message-Id: <20230517160326.10732-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the error checking in lvts_thermal.c in
debugfs_create_dir. The correct way to check if an error occurred
is 'IS_ERR' inline function.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index d0a3f95b7884..61386be78fa0 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -188,7 +188,7 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
 	int i;
 
 	lvts_td->dom_dentry = debugfs_create_dir(dev_name(dev), NULL);
-	if (!lvts_td->dom_dentry)
+	if (IS_ERR(lvts_td->dom_dentry))
 		return 0;
 
 	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
@@ -197,7 +197,7 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
 
 		sprintf(name, "controller%d", i);
 		dentry = debugfs_create_dir(name, lvts_td->dom_dentry);
-		if (!dentry)
+		if (IS_ERR(dentry))
 			continue;
 
 		regset = devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL);
-- 
2.34.1

