Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8376DD5B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjDKIef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjDKIe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:34:28 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C082D5A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:34:25 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-50489c6171dso2005129a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681202064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIQy0z8jTVH7zpmG87sxcsYghwyL6FkUSdX2CbnH7m8=;
        b=DuHQvrn/8Nf7AGWkzoPpopKmBeR2a55nT6ZfggsT2qQtV48yy/cy9SxnYQzW2ib8bO
         l+Zo5ErASoESd8miPWGvAGnHoU9bryee0XJBjbAK7z4QKQkYO4jLjeEBOnmBrLbK8kJ+
         vv2dQHMgucuaT+mXJWANkANvPStSVGQeKml4jhSTHXFfTitCk5Z3kGsAsMkvpXn8mo5S
         ErPoKIUDsRKUucMhsTkfFrH5CWzeWicgIXwaGrofpQoi80gKqO8rNc18QNmUgOSMgQE3
         kZ+dIGQMjCuI44Vj8mqxq4PK1IQsKN3F74PFsuJBqtnEyQ+pZIWBTgXlPFEXYJzAqJyZ
         BEWQ==
X-Gm-Message-State: AAQBX9d5QemXmzOLGIIew7aAiH7tfqXEAIpmWJBfg/5JJEjNxCWCJOJb
        GH+IX8KGipFO+ZMZDFI+cp4=
X-Google-Smtp-Source: AKy350abpQBdo14BHKyD1DlIP4kfKIBceIoChFJi8UO9MpvMFnw1yvMf7PbQU/JZNN6j9mYiJ9SMeA==
X-Received: by 2002:aa7:de13:0:b0:502:a700:dc8b with SMTP id h19-20020aa7de13000000b00502a700dc8bmr8410709edv.9.1681202064337;
        Tue, 11 Apr 2023 01:34:24 -0700 (PDT)
Received: from localhost.localdomain (aftr-82-135-86-174.dynamic.mnet-online.de. [82.135.86.174])
        by smtp.googlemail.com with ESMTPSA id v13-20020a50954d000000b004fc649481basm5683178eda.58.2023.04.11.01.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 01:34:23 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     JoseJavier.Rodriguez@duagon.com, Jorge.SanjuanGarcia@duagon.com,
        linux-kernel@vger.kernel.org,
        Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>,
        Javier Rodriguez <josejavier.rodriguez@duagon.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 3/3] mcb-lpc: Reallocate memory region to avoid memory overlapping
Date:   Tue, 11 Apr 2023 10:33:29 +0200
Message-Id: <20230411083329.4506-4-jth@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411083329.4506-1-jth@kernel.org>
References: <20230411083329.4506-1-jth@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>

mcb-lpc requests a fixed-size memory region to parse the chameleon
table, however, if the chameleon table is smaller that the allocated
region, it could overlap with the IP Cores' memory regions.

After parsing the chameleon table, drop/reallocate the memory region
with the actual chameleon table size.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 drivers/mcb/mcb-lpc.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/mcb/mcb-lpc.c b/drivers/mcb/mcb-lpc.c
index 53decd89876e..a851e0236464 100644
--- a/drivers/mcb/mcb-lpc.c
+++ b/drivers/mcb/mcb-lpc.c
@@ -23,7 +23,7 @@ static int mcb_lpc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct priv *priv;
-	int ret = 0;
+	int ret = 0, table_size;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -58,16 +58,43 @@ static int mcb_lpc_probe(struct platform_device *pdev)
 
 	ret = chameleon_parse_cells(priv->bus, priv->mem->start, priv->base);
 	if (ret < 0) {
-		mcb_release_bus(priv->bus);
-		return ret;
+		goto out_mcb_bus;
 	}
 
-	dev_dbg(&pdev->dev, "Found %d cells\n", ret);
+	table_size = ret;
+
+	if (table_size < CHAM_HEADER_SIZE) {
+		/* Release the previous resources */
+		devm_iounmap(&pdev->dev, priv->base);
+		devm_release_mem_region(&pdev->dev, priv->mem->start, resource_size(priv->mem));
+
+		/* Then, allocate it again with the actual chameleon table size */
+		res = devm_request_mem_region(&pdev->dev, priv->mem->start,
+					      table_size,
+					      KBUILD_MODNAME);
+		if (!res) {
+			dev_err(&pdev->dev, "Failed to request PCI memory\n");
+			ret = -EBUSY;
+			goto out_mcb_bus;
+		}
+
+		priv->base = devm_ioremap(&pdev->dev, priv->mem->start, table_size);
+		if (!priv->base) {
+			dev_err(&pdev->dev, "Cannot ioremap\n");
+			ret = -ENOMEM;
+			goto out_mcb_bus;
+		}
+
+		platform_set_drvdata(pdev, priv);
+	}
 
 	mcb_bus_add_devices(priv->bus);
 
 	return 0;
 
+out_mcb_bus:
+	mcb_release_bus(priv->bus);
+	return ret;
 }
 
 static int mcb_lpc_remove(struct platform_device *pdev)
-- 
2.39.2

