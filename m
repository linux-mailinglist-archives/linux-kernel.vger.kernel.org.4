Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD6E5FEA48
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJNIQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiJNIQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:16:34 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC008BE2E0;
        Fri, 14 Oct 2022 01:16:32 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a6so5133860ljq.5;
        Fri, 14 Oct 2022 01:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=edW1SZPZk5oTvbkbtASITiKdHC2vwGxOU1SxXrshM3s=;
        b=Y78sMr/o4YSO539vsfAdIvlQ0jd/6rPhIdLpv6YNTg0hrcITtiG9myVUl/aNFGedin
         0Ra0o/d+gVFZMawqf+rVVAqKgPgbMWK6xIlCL08+Kl6XgLg94b3y9dPd5FzD5YICpb59
         zP/C2eiwx8xWWGMOoUBe2l+Lg2T5HTuwStdLMVullG6pTbNbIaZcXejzFpbPn/N9NDan
         qQOlqCdziGe00c5UZxRU7AzsTkUeDekjFrzs+y5Wmv/tq/BdfFtkXRJW0Jg0GrHPtlT5
         0Ck6rUdnnkaBNem5Rw+1pMVBU1UUAX60w4tTsT1pj9L9ZSO+d34CNihQ4oXoKa3ZiTzA
         pdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edW1SZPZk5oTvbkbtASITiKdHC2vwGxOU1SxXrshM3s=;
        b=uGzk25czvw0mYZrlWFquLNa8NqKZnRtLdJRzNFcgOMebr85YhipY1zLiV+IqddUuJm
         GOe1S4AZ1svMLdzBTJ07SGBGcxCVDdn/XL5+jPFe39ibDNQ+Y6SI166f3RIzsjKU5BRX
         l2CZcGziNSdfozxChK0d/fjIs1CEw/UpWJ0+KSM+MaBUJ0QbiNAN1ksgW5y/zltvNhU2
         Eey2Zavk6OR/IxMO2SIRhjhA5hnJAbhoKFFBWiE+7gm4XOUVVGG3bLBZ3895NE5iCcYB
         366op5OgcEE/hbLuP4IyWBd15sBiYP9+A6y0wOa/wq1FzaNHLR35kE3f4SrkgMtOCx/C
         6XwQ==
X-Gm-Message-State: ACrzQf0UcUFSI8uz35DXgKg48jbpIscmNtNDIwLeBXK2/70PMsSvDPjN
        m39D7XLoElbr/IKSGqUzSXY=
X-Google-Smtp-Source: AMsMyM4naaQLAMQ8tXoTscYfLSobLQwKWzJzvDBqvWV5PXeeauDm1XtczDREsNSk5AfT1jKfT7LXxA==
X-Received: by 2002:a2e:bd0c:0:b0:26d:d9fd:f61b with SMTP id n12-20020a2ebd0c000000b0026dd9fdf61bmr1434686ljq.151.1665735391141;
        Fri, 14 Oct 2022 01:16:31 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id a9-20020a05651c030900b0026ddd41aecasm263555ljp.135.2022.10.14.01.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:16:29 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] thermal: imx8mm_thermal: use GENMASK() when appropriate
Date:   Fri, 14 Oct 2022 10:16:20 +0200
Message-Id: <20221014081620.1599511-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
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

GENMASK() is preferred to use for bitmasks.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/thermal/imx8mm_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index c5cd873c6e01..74fc34b88bb0 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -23,8 +23,8 @@
 
 #define TER_ADC_PD		BIT(30)
 #define TER_EN			BIT(31)
-#define TRITSR_TEMP0_VAL_MASK	0xff
-#define TRITSR_TEMP1_VAL_MASK	0xff0000
+#define TRITSR_TEMP0_VAL_MASK	GENMASK(7, 0)
+#define TRITSR_TEMP1_VAL_MASK	GENMASK(23, 16)
 
 #define PROBE_SEL_ALL		GENMASK(31, 30)
 
-- 
2.37.1

