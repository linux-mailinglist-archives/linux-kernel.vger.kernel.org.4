Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B857D70E372
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbjEWR1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238156AbjEWR11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:27:27 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20BF130
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:27:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso8275b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684862832; x=1687454832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wr5Y1AbC5Kt78Cige8N9lA89ZsVNn6MGAOTvD82Xhes=;
        b=WTldKzUaYF/QsUJrGQyUPUk4T7QfuSDnzbO5uxdSr9QExW7/uZkZN2tVlqH5OjckrZ
         Lvyf8VCVGnsZ0xBeX+yHJaaM2KU3JGjkEt29Mf4bgj5RprnzbsTyaqmfLbvJJ7iuY4d6
         5iPgSRimHE5U53JOAjrgL6gARNgn9yAdJRMuLcHIE8yg2FLB/9DuB1hI47bnBHZEuaLB
         lALQEmC3IwiQqbMc9H+7xWLl6JcuEL4+rGzCBgL5nng4MRPCxM1Efr7LMA90Is7FDl3Y
         nGA751GN8n94gcsx8gTdz7arinWyqd/1BJ8R6OjH8TeIZrUwkGEbZSAItgxx0MWkXFnw
         ISng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862832; x=1687454832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wr5Y1AbC5Kt78Cige8N9lA89ZsVNn6MGAOTvD82Xhes=;
        b=NkkQ6C0cBDqEhmqv/iuMbo3Bh6SZCwosvZtBTBnQKReRK/W6TM0qYG4NjRa34YlcXW
         OgKc7Ugo5l/y3OmKK8dtCNwfPBAoJgokbBhP+YYZYZgrodxnM9bb3NblUO+nLjQBdXLJ
         guThf88k7jbT9IYtw2m2KrZkB0X3ttWnOs+ovyOrW68GgxqKMUwiSPJmJ0AJG7SGKgx0
         Mrj1ILvxCwX5Uv/ANVRGLF3EBYUMCoLkmEzx7IsZdyzF3pxqQoeBnEk2JphDLnfteqED
         eG950+TwFimSsSnRvb3Y2qWvNiES25vN+zt/f8yh3dl0szo5BcXV+pePQQDdwGPx4c54
         Stzw==
X-Gm-Message-State: AC+VfDwMMd66cCch3BBWyq8TNDVvUr/P3LmAyVuecSZLHQQYG+7J/bzR
        q7qhdOI6I4xhJGV9zk8zzE8=
X-Google-Smtp-Source: ACHHUZ6l0a1Pe8kJUHAg+kjIv6UxReiNdf6ysBDRIXlGUk2xbGzZELxgfBfcrJuHlk4C/maxzoO8lw==
X-Received: by 2002:a05:6a00:2282:b0:643:b263:404 with SMTP id f2-20020a056a00228200b00643b2630404mr21862389pfe.33.1684862831639;
        Tue, 23 May 2023 10:27:11 -0700 (PDT)
Received: from Osmten.. ([103.84.150.89])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78557000000b0063b8f17768dsm6071547pfn.129.2023.05.23.10.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:27:11 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     sre@kernel.org, jinpu.wang@ionos.com
Cc:     linux-kernel@vger.kernel.org, Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] omap_ssi_port.c: Fix error checking for debugfs_create_dir
Date:   Tue, 23 May 2023 22:24:34 +0500
Message-Id: <20230523172434.13477-1-osmtendev@gmail.com>
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

This patch fixes the error checking in omap_ssi_port.c in
debugfs_create_dir. The correct way to check if an error occurred
is 'IS_ERR' inline function.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/hsi/controllers/omap_ssi_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index b9495b720f1b..7ad41599baa5 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -157,12 +157,12 @@ static int ssi_debug_add_port(struct omap_ssi_port *omap_port,
 	struct hsi_port *port = to_hsi_port(omap_port->dev);
 
 	dir = debugfs_create_dir(dev_name(omap_port->dev), dir);
-	if (!dir)
+	if (IS_ERR(dir))
 		return -ENOMEM;
 	omap_port->dir = dir;
 	debugfs_create_file("regs", S_IRUGO, dir, port, &ssi_port_regs_fops);
 	dir = debugfs_create_dir("sst", dir);
-	if (!dir)
+	if (IS_ERR(dir))
 		return -ENOMEM;
 	debugfs_create_file_unsafe("divisor", 0644, dir, port,
 				   &ssi_sst_div_fops);
-- 
2.34.1

