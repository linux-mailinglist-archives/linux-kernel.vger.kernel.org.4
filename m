Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7120A6DCE0F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjDJX15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjDJX1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:27:50 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CF82710;
        Mon, 10 Apr 2023 16:27:42 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id bf5so4325198oib.8;
        Mon, 10 Apr 2023 16:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681169262; x=1683761262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mfji5NwyNXtXMo7uqw/b5LhlGHgLtluaYpZTYl5kDcg=;
        b=1X5EktgpuTUZA3z9/cGIm5uaeMOsBwZoHcVr31VXaXlUaUQjXll9rOiCIXvs0BA9Kp
         x3zknCRos+8rnR3IHjidGBMZ1H6JtHys9W4w+A3Lm3yR5pZlh0zW2JU+gyUKPBqR2E7G
         Ma7XoGrW8Z0c+rX8w26BGvrqdyRTyd58U23KtFlfb2f2XeVJVmYIW20NzPaHN5un5xio
         tCyabZ9cKl5yRsCkoOol07sx3pQ6NZDRKaCyXxI1F9el9uwWxTjPPOvM4nX19GPZ4DGc
         mMXv1Ta8cfqPriW7SCCfN+W3FvRsiDv8ZwtnvdpEhjkMXDRipqkFnb393tC8i9ZtT3wY
         0i3Q==
X-Gm-Message-State: AAQBX9dtflDRV+ilNZUGSCpg7BfXJAcfkuPSrvwGZsa5m7FH2pduHJ4N
        bw2qlSHKESjoeJEIkym1Pg==
X-Google-Smtp-Source: AKy350YAbAr6APS9TvDqRY2lI0vAquRw5hKXo1B2+OpPci8Vc6rmORsRHoIs5Ce4Xt+6ABzM9Ze33g==
X-Received: by 2002:a05:6808:4391:b0:384:dfc7:7d84 with SMTP id dz17-20020a056808439100b00384dfc77d84mr4983708oib.58.1681169262021;
        Mon, 10 Apr 2023 16:27:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s83-20020acac256000000b00383eaea5e88sm4769712oif.38.2023.04.10.16.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:27:41 -0700 (PDT)
Received: (nullmailer pid 1562406 invoked by uid 1000);
        Mon, 10 Apr 2023 23:27:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bus: tegra-gmi: Replace of_platform.h with explicit includes
Date:   Mon, 10 Apr 2023 18:27:35 -0500
Message-Id: <20230410232735.1562296-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra-gmi doesn't use anything from of_platform.h, but depends on
of.h, of_device.h, and platform_device.h which are all implicitly
included, but that is going to be removed soon.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/bus/tegra-gmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/tegra-gmi.c b/drivers/bus/tegra-gmi.c
index 662266719682..e3506ef37051 100644
--- a/drivers/bus/tegra-gmi.c
+++ b/drivers/bus/tegra-gmi.c
@@ -9,7 +9,9 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
-- 
2.39.2

