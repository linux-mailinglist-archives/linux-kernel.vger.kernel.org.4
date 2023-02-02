Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FC06878EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjBBJeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBBJd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:33:57 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532D2709A9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:33:27 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b5so1250524plz.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhKNUmgjGpYYrPtJU+3Ape9Wl8mBEWfEIaYMUi/pVTw=;
        b=mw4TOMdYWXPbI2rHubabkq3zaX7hILal/BRAJXpRh5alnw8qECyGBtcLGv+obKjD7M
         TDAa1PqkFMIbAQTM7E3QS+pza33y+QOxEIkANbUPWMphCmJugJ+H6DgHZz0POHvEO1EO
         FeCfum4nwXBXfR/BTyZm1gYGh1JCnqNaEcE2KXiraB0NyS8sBmCoUpDiyuN9XTQQxRV3
         0blkEjnjkGS+mJ6QcKU2VZoCMARSEJFdPF7170DXj52ynrqbd2sUat7+/Z7t6Us0i0QL
         z7U2F3FRliswGu8GJ9ow/VyWXoU4MPk7qQKHnZh3N5RLsmiJng3U+Gt218kHnONnQajG
         2SBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhKNUmgjGpYYrPtJU+3Ape9Wl8mBEWfEIaYMUi/pVTw=;
        b=uTwQg4uhxwKLpUyQCaR935LJFiyDdBEy8Y5f6AtYFTMWy62mIRTb07tabfVuvQYpT8
         z4pKJxcXmrgLZNDX1F8jUurl4NE9pPGOpXm6R0QZ9VN872I24C0WMMNIhiHJAAk6xzkB
         0csJTVklrcBSgc5kf14c3l+j2ybp6NodhzEDCkO0oDxe598JdidY/25DdniF+LpfHIDu
         c30dhsngdirzwLIyrbZZJVzHD8c77x07CiFGwYmYxQ5zINJkuikbKDz4OYBVU6QhCQYr
         YsKlxYXZLnVNVQQfDRN7qG6hg4pvmQxlDCOs4pkAVKBQdCOsaAZy1Xv8TtDb/ENaKwvS
         2VFw==
X-Gm-Message-State: AO0yUKXvyF0fu/zrUSemhGd8VOk+ECdJkIqn9Wm/nLf1odXOTGvCF8U3
        HYS72+N7dp5IqVS4b8t6mapOFQ==
X-Google-Smtp-Source: AK7set82oadZE66vGh1Lw/bvcWQLtS/MGSCNOQm/yiGxA4W0wdTs4YkmnY+vs3+lWP+vTSrXn6L4qA==
X-Received: by 2002:a17:902:f68f:b0:196:4d17:2f51 with SMTP id l15-20020a170902f68f00b001964d172f51mr6894727plg.5.1675330406890;
        Thu, 02 Feb 2023 01:33:26 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902848a00b0019254c19697sm13153343plo.289.2023.02.02.01.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:33:26 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 3/3] PM/OPP: fix error checking in opp_migrate_dentry()
Date:   Thu,  2 Feb 2023 17:32:56 +0800
Message-Id: <20230202093256.32458-4-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230202093256.32458-1-zhengqi.arch@bytedance.com>
References: <20230202093256.32458-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ff9fb72bc077 ("debugfs: return error values,
not NULL") changed return value of debugfs_rename() in
error cases from %NULL to %ERR_PTR(-ERROR), we should
also check error values instead of NULL.

Fixes: ff9fb72bc077 ("debugfs: return error values, not NULL")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/opp/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 96a30a032c5f..2c7fb683441e 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -235,7 +235,7 @@ static void opp_migrate_dentry(struct opp_device *opp_dev,
 
 	dentry = debugfs_rename(rootdir, opp_dev->dentry, rootdir,
 				opp_table->dentry_name);
-	if (!dentry) {
+	if (IS_ERR(dentry)) {
 		dev_err(dev, "%s: Failed to rename link from: %s to %s\n",
 			__func__, dev_name(opp_dev->dev), dev_name(dev));
 		return;
-- 
2.20.1

