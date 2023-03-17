Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACEC6BED30
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCQPoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjCQPo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:44:28 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561091D92A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:44:27 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id r4so2948761ilt.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jeremypeper-com.20210112.gappssmtp.com; s=20210112; t=1679067866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wK+kx73ZS+J3kSGKqGjS6Zro6H1OC5B9GKyBYifueXE=;
        b=UuVU1hz40zBTeinmipIydDSCefVESR6VNzlxYAl611fCX+3AjXzyp8Fr/5uI7+WhzV
         3lAIvTWYNjc3Cw5uT4NGrqNQuac/qL11qUYZ7eeLRYIVOjxSm55MFgLHiCWircqVPI0s
         zz7LobUTPC2g5spFKiBzOjPdjFC+7jIbg1ABl6QwH2+RZj6VnH3nmyl6o8PFhQYT87b6
         mVZRcvh5lurtdPbJgTImmR8d7FnagQHP6IFlWJ0lDG69o9E2GceardW0ivB9Ydqa/DIQ
         1ns5sI4osULwtAO9ORhVSw7haTPRYGD5OMG5Xsq3cKdPAD4boDeEOtAdyVr3dx59WbWW
         TUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK+kx73ZS+J3kSGKqGjS6Zro6H1OC5B9GKyBYifueXE=;
        b=MtGKaD52rOhrxC0SCr7+3f8CjbfwWxoH3xOIvxHCj+rnqRnmnaIy0/DElwzxnUYZQj
         jaOG+D1e+zGSbwHeKums44jAO/Iryj64QSe3n0isXOsJIgQppVJfTPdte47SzRGBAJQK
         b94BsbS838iFpscwRnm74aOm1+ESdO4tXJPrFAhFPdEV3iBdy51bGmC3AE7RFcLgb+a9
         GPmWj/S4QcvEpuv9mVZBlVxLkwVDF0Uj4eIaRqNptDQipwJkqa9/087Q5bhQu8BngSjb
         RjGCCDuMVue6vRLGcun2E4Ww4ViouLBEYCzdLxEh0z3YMtojrJykKpaKURDb79+Yg3/G
         mcvw==
X-Gm-Message-State: AO0yUKX3DzWoO4oheV3Uxy7BwpGBU0QcKn0cCls/N9JV1DA/6CYzTVy7
        1bCe+KtkVvVLmBHrjmi4kxSO9w==
X-Google-Smtp-Source: AK7set87MrynYlMV2D1TPz3AmiszcuKDgTzUvXJNcYoDJ/tVBI3y/HoR8sbesFE6OK3m6zJIHP1fJQ==
X-Received: by 2002:a92:611:0:b0:316:d9fa:f31b with SMTP id x17-20020a920611000000b00316d9faf31bmr127491ilg.32.1679067866695;
        Fri, 17 Mar 2023 08:44:26 -0700 (PDT)
Received: from earth (70-59-64-215.mpls.qwest.net. [70.59.64.215])
        by smtp.gmail.com with ESMTPSA id c17-20020a056e020cd100b0031593c8861asm683295ilj.50.2023.03.17.08.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:44:26 -0700 (PDT)
Received: by earth (Postfix, from userid 1000)
        id BFAEE1060082; Fri, 17 Mar 2023 10:44:25 -0500 (CDT)
From:   "Jeremy J. Peper" <jeremy@jeremypeper.com>
To:     linux-kernel@vger.kernel.org, arnd@kernel.org
Cc:     "Jeremy J . Peper" <jeremy@jeremypeper.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] set the correct driver for the i2c RTC
Date:   Fri, 17 Mar 2023 10:43:45 -0500
Message-Id: <20230317154411.3727514-2-jeremy@jeremypeper.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230317154411.3727514-1-jeremy@jeremypeper.com>
References: <20230317154411.3727514-1-jeremy@jeremypeper.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Original code was largely copy-pasted from the reference board code, adjust to use the actual RTC chip present on the TS-WXL.

Signed-off-by: Jeremy J. Peper <jeremy@jeremypeper.com>
---
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
index 383dc6eab..c3f6dc351 100644
--- a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
+++ b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
@@ -39,7 +39,7 @@ static struct mv_sata_platform_data db78x00_sata_data = {
 };
 
 static struct i2c_board_info __initdata db78x00_i2c_rtc = {
-	I2C_BOARD_INFO("ds1338", 0x68),
+	I2C_BOARD_INFO("rs5c372a", 0x32),
 };
 
 
-- 
2.30.2

