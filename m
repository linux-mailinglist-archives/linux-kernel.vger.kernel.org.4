Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893AA7290AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbjFIHPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjFIHO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:14:56 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AA72D7E;
        Fri,  9 Jun 2023 00:14:55 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-39ca48cd4c6so13968b6e.0;
        Fri, 09 Jun 2023 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686294895; x=1688886895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgQbAD4zC7kyh7MqqeeXdMAW7P6yao31pgzuJElJL7w=;
        b=i6jTdmt1w7SWFBB1wgrSWhNVEIDyon0fJIt+wwVOzO0ocikQo4ypDaXsoT54+J2d1t
         7xY29S6Obuvy4uIXNrRXRM6nG964ByX3OsQl2u6D2OK3qZSsv+5+i96pG/2po1TGqotE
         XbMnG0XbqksGLMrQ+SEQoroOesunzXepvF4SkfSLH/QOAS3+ljkGtOXR8ZKsB3Acne1o
         YTeU9VNWJaxgUm6Bk0Mod5FSxKPYfW8oMBrdKdFLXObL61Vzoo1Tzj5LRuxjitdhMngn
         Xg/kDW25XF5NBX2hGcPCZhB2iZ3fJKYS2qy147OK18eU8ZBWvh0F5P7yJVOL8LcNGB4H
         d06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686294895; x=1688886895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgQbAD4zC7kyh7MqqeeXdMAW7P6yao31pgzuJElJL7w=;
        b=S8vRSFl2H0FcEtWI51G+2Aan9NLkmHSOQKe+CvlRLMYBlrzbjTBv3+w0034bUAMl6z
         pZQdA7FbLh1dEqoDQHUbFdA8ur64UTD3zd2vKwk2EuJ87qE5Sl4hQXVvNQGWdtO65LzF
         0Wx6dOfkRmowkROgEmaakDQ7d+/mUWSEC0l/i3qsDaiYwGxl8zQ+3N3HcGKN0+evHXEh
         EaI00T1P6AFL1gEW4j6ECeaAeNwCa51cP+fLjy8u6vCqFaalHC9HvP2W8b5U3N8FOU/d
         3lHy3lCd6cBce4ayAE40+iLIryTrCclxo8Zu2sgXR3Nz7KbVvX+wtkvbVzKvcZ1cOK5H
         VlVw==
X-Gm-Message-State: AC+VfDysMf5iCSgZ0hkTp9ZOYDFVm36f+X/W3jC/Zqz83Ojid3z6kkKN
        eVweBIMH1080acap9PUlYeI=
X-Google-Smtp-Source: ACHHUZ5o/KTVYmx5CjsbpRM3Zz5LMbydV2anFnaNGhcjTvOttu1JWcR3ZDk7gLMD5jg6K948UKTkcw==
X-Received: by 2002:a05:6808:3a1:b0:39a:babe:a7e with SMTP id n1-20020a05680803a100b0039ababe0a7emr563376oie.35.1686294894954;
        Fri, 09 Jun 2023 00:14:54 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-07a7-2523-0b40-49e4-7cbb.emome-ip6.hinet.net. [2001:b400:e282:7a7:2523:b40:49e4:7cbb])
        by smtp.gmail.com with ESMTPSA id f3-20020a656283000000b005308b255502sm2085196pgv.68.2023.06.09.00.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 00:14:54 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V6 3/4] mmc: sdhci: Add VDD2 definition for power control register
Date:   Fri,  9 Jun 2023 15:14:40 +0800
Message-Id: <20230609071441.451464-4-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230609071441.451464-1-victorshihgli@gmail.com>
References: <20230609071441.451464-1-victorshihgli@gmail.com>
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

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Add new definition for VDD2 - UHS2 or PCIe/NVMe.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f4f2085c274c..f219bdea8f28 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -99,6 +99,13 @@
 #define  SDHCI_POWER_180	0x0A
 #define  SDHCI_POWER_300	0x0C
 #define  SDHCI_POWER_330	0x0E
+/*
+ * VDD2 - UHS2 or PCIe/NVMe
+ * VDD2 power on/off and voltage select
+ */
+#define  SDHCI_VDD2_POWER_ON	0x10
+#define  SDHCI_VDD2_POWER_120	0x80
+#define  SDHCI_VDD2_POWER_180	0xA0
 
 #define SDHCI_BLOCK_GAP_CONTROL	0x2A
 
-- 
2.25.1

