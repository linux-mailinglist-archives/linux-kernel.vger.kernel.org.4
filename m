Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AD85BC189
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiISCtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiISCtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:49:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144FE193EF;
        Sun, 18 Sep 2022 19:49:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so4787832pjh.3;
        Sun, 18 Sep 2022 19:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=tnJe4HddJzoTq7U3gvumxaLwIT9PB6AzqhNeMSwvGvQ=;
        b=hXNIFMt8cNaFei+Hbyb+2wy6gVBxGjly+UvtRVh8dq/muS3GjIHB623FWUUNMd/LNd
         wWnRByglELN/epUmBzVkz6tlGpOAJGovnm4MaGABP8KvJghMBDITGjjgQDNPpXJJ9W12
         U0ebWlELapWhVXCXXCOBm8OAxdAYDJ3pqwkaIIM4UKepOGKWwYA7UswzCpnvOE5FNiwp
         IvXxqqVxUMQHkERErV7FWyksskK35K8Is7ajt9Oo6BBXBFXHOee/4bDmgTghUcgc0WA7
         dlJ8f/D04CAJ8QrABTpA19CzJLRONiOI1shM1uOfptBALy9Ly4XmM29MtfEYcQlbDjMi
         rTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=tnJe4HddJzoTq7U3gvumxaLwIT9PB6AzqhNeMSwvGvQ=;
        b=JdXtYPsCFOBdzelcFZ4WZ8nk6yw5MDAzd2kji/wPeurkJSgtHEY7C4qkq1KE3zJgUI
         ohJg3VcjkjZYa2fVcnSlWaRmEyuR5N1QiZcdSrCLXqJbkKdx54p2f1ex7FJDgktt+EDP
         ct6XkzPrsDvRILRiC+IJnSGSsWjZxPxCSaXvPlzGTeflqOHjahW0XZ9oAH8uMqO1TmDd
         R2RvfSMpC4zEkTimu3NR1PkgwBzizlMXO81+IQDCeMx3UTXxjcVu57yk0wpt7IgAlAYp
         /7+1yj5xf+mrqqkbJ5W2Wo5gRl3dCN+KtEjKjAVRcjhSZkKz8eJZfCNMSNBCz+ne7tkS
         H4/g==
X-Gm-Message-State: ACrzQf1k/+HmUXnm4ijpvXQr6hYVPzIl44GH978+NmYkTouZFEtOjlqc
        kpwD6QrZXzbfWh0KQqyQbAG+YtfKU1Q=
X-Google-Smtp-Source: AMsMyM4hP8zTE1h0wXRgHbr7oKN06P6gJrWXoBPCpeGT7rIRWS1SHMHF+ITe/rTpoJBoBg77Rira+g==
X-Received: by 2002:a17:90a:e7cc:b0:202:f493:6ad1 with SMTP id kb12-20020a17090ae7cc00b00202f4936ad1mr28564021pjb.198.1663555763431;
        Sun, 18 Sep 2022 19:49:23 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a020200b0020322204672sm5408572pjc.38.2022.09.18.19.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 19:49:22 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] power: supply: use strscpy() is more robust and safer
Date:   Mon, 19 Sep 2022 02:49:19 +0000
Message-Id: <20220919024919.211210-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/power/supply/max1721x_battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max1721x_battery.c b/drivers/power/supply/max1721x_battery.c
index 473e53cd2801..0f948db958d5 100644
--- a/drivers/power/supply/max1721x_battery.c
+++ b/drivers/power/supply/max1721x_battery.c
@@ -384,7 +384,7 @@ static int devm_w1_max1721x_add_device(struct w1_slave *sl)
 	}
 
 	if (!info->ManufacturerName[0])
-		strncpy(info->ManufacturerName, DEF_MFG_NAME,
+		strscpy(info->ManufacturerName, DEF_MFG_NAME,
 			2 * MAX1721X_REG_MFG_NUMB);
 
 	if (get_string(info, MAX1721X_REG_DEV_STR,
@@ -403,15 +403,15 @@ static int devm_w1_max1721x_add_device(struct w1_slave *sl)
 
 		switch (dev_name & MAX172XX_DEV_MASK) {
 		case MAX172X1_DEV:
-			strncpy(info->DeviceName, DEF_DEV_NAME_MAX17211,
+			strscpy(info->DeviceName, DEF_DEV_NAME_MAX17211,
 				2 * MAX1721X_REG_DEV_NUMB);
 			break;
 		case MAX172X5_DEV:
-			strncpy(info->DeviceName, DEF_DEV_NAME_MAX17215,
+			strscpy(info->DeviceName, DEF_DEV_NAME_MAX17215,
 				2 * MAX1721X_REG_DEV_NUMB);
 			break;
 		default:
-			strncpy(info->DeviceName, DEF_DEV_NAME_UNKNOWN,
+			strscpy(info->DeviceName, DEF_DEV_NAME_UNKNOWN,
 				2 * MAX1721X_REG_DEV_NUMB);
 		}
 	}
-- 
2.25.1
