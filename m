Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0709750B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjGLO5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjGLO5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:57:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A01FBB;
        Wed, 12 Jul 2023 07:57:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so78652305e9.3;
        Wed, 12 Jul 2023 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689173824; x=1691765824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJrp5y7emiUiskxEtT6O6KgXmyIwXxE+Vf82XYcN9+M=;
        b=JTg3PenSA7B5nNFlCA58eU1/tZgLP+HbTzZnZfzLeesLFXId098mracvvveoKZsy/6
         qnz4yYIVrns/sirnaeejvVQAHzzIKOuWJpRa4BtNBSJgab/DuqwdNubePsJLjkYN4gFn
         oAQujP9oyLm9G+KMLm0FWFulJO7gFkuIO6tif1T++UChWQvgO3IvXfgtK8yQyYHbUAqC
         /lwjlDIOzD2mZdPCRonqAeIqgy8kNgR6lPNLMyaicx7DlOb4fP3HYtP7+SWiZC1/zoIT
         efl+zNV1Elzbacv8spNoNmDmgoHWbSJKJmghh6f9eG9USLacVijw3Nx7X7P2MTYJJYCe
         z+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173824; x=1691765824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJrp5y7emiUiskxEtT6O6KgXmyIwXxE+Vf82XYcN9+M=;
        b=hk5QxxZx66aCiVUgVv9mxIvvwiiflIXhBmpEKEx5ZrM+9VqKZqg5hMIdkeq4T11xwH
         rcZxYVwCWaLSYIldObdNFdOgfpvKPenUa0fhH6T7G84VLZkVpJVJqpNAtBcVbxFKtz4f
         XCF4hrsArKT+aC37xiPIdfSNX1/HLcSxEQdr7ljbc6SEw7KdNG4vEkrhmF881pF4tWo9
         3PuKgnt3kycRtzHWi1LKZyYwVQPpjzh0KrWEkPm31a7nc+4xpDmMv4DJiKK477hHKpns
         GnUznrdN5XCZ1AsYMEmaIvwOhfNGogCid1ZG8Ed2qw50OqgAZ7nG8zC58UQUvsIn+7Ze
         kS9Q==
X-Gm-Message-State: ABy/qLayjPO7ya7irvsofBl9QyGgwo2WXcxw8stCjYaVw5BjrWArUxI8
        jbuDZ+jg/0MaDSfiwsIorMg=
X-Google-Smtp-Source: APBJJlEtqBWVxQSl/4H18KOnasubDV3RZX1lpfd0V0GgtfogkuEuhDaqwDNb5GOA4PlOBrdZ84kGiQ==
X-Received: by 2002:a05:600c:220e:b0:3fb:9ea6:7a73 with SMTP id z14-20020a05600c220e00b003fb9ea67a73mr17101879wml.23.1689173823609;
        Wed, 12 Jul 2023 07:57:03 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c294200b003fbe791a0e8sm5379371wmd.0.2023.07.12.07.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 07:57:02 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] video: fbdev: kyro: make some const read-only arrays static
Date:   Wed, 12 Jul 2023 15:57:02 +0100
Message-Id: <20230712145702.460690-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the const read-only arrays on the stack but instead
make them static const. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/video/fbdev/kyro/STG4000InitDevice.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/kyro/STG4000InitDevice.c b/drivers/video/fbdev/kyro/STG4000InitDevice.c
index edfa0a04854d..bf1ee3addbd0 100644
--- a/drivers/video/fbdev/kyro/STG4000InitDevice.c
+++ b/drivers/video/fbdev/kyro/STG4000InitDevice.c
@@ -83,11 +83,11 @@ volatile u32 i,count=0; \
 static u32 InitSDRAMRegisters(volatile STG4000REG __iomem *pSTGReg,
 			      u32 dwSubSysID, u32 dwRevID)
 {
-	u32 adwSDRAMArgCfg0[] = { 0xa0, 0x80, 0xa0, 0xa0, 0xa0 };
-	u32 adwSDRAMCfg1[] = { 0x8732, 0x8732, 0xa732, 0xa732, 0x8732 };
-	u32 adwSDRAMCfg2[] = { 0x87d2, 0x87d2, 0xa7d2, 0x87d2, 0xa7d2 };
-	u32 adwSDRAMRsh[] = { 36, 39, 40 };
-	u32 adwChipSpeed[] = { 110, 120, 125 };
+	static const u32 adwSDRAMArgCfg0[] = { 0xa0, 0x80, 0xa0, 0xa0, 0xa0 };
+	static const u32 adwSDRAMCfg1[] = { 0x8732, 0x8732, 0xa732, 0xa732, 0x8732 };
+	static const u32 adwSDRAMCfg2[] = { 0x87d2, 0x87d2, 0xa7d2, 0x87d2, 0xa7d2 };
+	static const u32 adwSDRAMRsh[] = { 36, 39, 40 };
+	static const u32 adwChipSpeed[] = { 110, 120, 125 };
 	u32 dwMemTypeIdx;
 	u32 dwChipSpeedIdx;
 
-- 
2.39.2

