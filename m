Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DE471109C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbjEYQOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjEYQOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:14:00 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E49195;
        Thu, 25 May 2023 09:13:59 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96fe88cd2fcso151076066b.1;
        Thu, 25 May 2023 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685031237; x=1687623237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tSd8MlXqT6QSbuJx+uxcDUS9lRDh+KiKFkFHt+L9QJo=;
        b=KN7VHaTIqWtpT7Ba986WFB+mqIPESovyThLaEJnV1RLALEyAgKtzZfPjuvKtTlCFKR
         Zqfn1qy+XLhPB1uISE1Zts5En0e83kRiltRGkw2NstDCfoyJcHqcsj+qB6CPfa+ha0Hr
         xck62bjWpaU7ueG+OjoDNABHPs+s0sTYe3eVnoTdNzT+DzLjzRCjHI05TjzADZNPd9eJ
         I1Bi1l/Yc4yjytKMlVOhjGgSr68KA/5oh1OtElcspFLuaJCb3Tw1FZN4AwxIizJ/Gv47
         3bWhy5mmqGmxFSPWRWpY4hEUZnyu0/NaoCZmUh6/0htdO5MYzANZvF5pCaXeyhIXpn2q
         geBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685031237; x=1687623237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSd8MlXqT6QSbuJx+uxcDUS9lRDh+KiKFkFHt+L9QJo=;
        b=MkonJQ7jpxQJeikT/eHIDgXPLaaCsyh/pGpNbGaCSa+9JJzlS0Lid+0aVfJF/3vDyL
         xwQGpgnY6bzltfF3ve5hzOagejLL9F+t3VrdcSEhfuL1Y74zuYg3g09vhS1n4sa7xtzx
         Pk3ma+UZBe1Xe11lk3OWycPkcSLpkrZcUj+MP/nnGjuUpRpdn5IGcU7hMVY0lph/VAZj
         QzDBxeyeSMrwWHUtKUQFbv3fucY+dmQlaijdAc0SJfkqcxcyscSAK6oSccV7fPjqPJz7
         m8PGEjnbDhdF1pR5+0jyE7wL8wz2xd1dcNky7MhwUUN9vwf+Y5YKg3X+FY/bfj2Ux5aG
         NekQ==
X-Gm-Message-State: AC+VfDyfbeKOZ9+RkONT1RnXawzZ/tEqVjITUI3N3XKUPGUvaEYAjdNr
        GIBvvScGXl5z4XdUt4J5bVgv8Gowd206JA==
X-Google-Smtp-Source: ACHHUZ5BXTOeGyEjSWsNwiDq7XickshueH3jtQcAkXBZmbWKNDuzdhvf780ZjFVmGi3bmbQAXABVTg==
X-Received: by 2002:a17:907:1c8b:b0:949:cb6a:b6f7 with SMTP id nb11-20020a1709071c8b00b00949cb6ab6f7mr2481859ejc.56.1685031237230;
        Thu, 25 May 2023 09:13:57 -0700 (PDT)
Received: from Osmten.. ([103.84.150.78])
        by smtp.gmail.com with ESMTPSA id md7-20020a170906ae8700b0094edbe5c7ddsm1024165ejb.38.2023.05.25.09.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 09:13:56 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] ucd9000.c: Drop error checking for debugfs_create_dir
Date:   Thu, 25 May 2023 21:13:13 +0500
Message-Id: <20230525161313.15745-1-osmtendev@gmail.com>
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

This patch fixes the error checking in ucd9000.c.
The DebugFS kernel API is developed in
a way that the caller can safely ignore the errors that
occur during the creation of DebugFS nodes.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/hwmon/pmbus/ucd9000.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index 3daaf2237832..73559afa8ba7 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -512,8 +512,6 @@ static int ucd9000_init_debugfs(struct i2c_client *client,
 		return -ENOENT;
 
 	data->debugfs = debugfs_create_dir(client->name, debugfs);
-	if (!data->debugfs)
-		return -ENOENT;
 
 	/*
 	 * Of the chips this driver supports, only the UCD9090, UCD90160,
-- 
2.34.1

