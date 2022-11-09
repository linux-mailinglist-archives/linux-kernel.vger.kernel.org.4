Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3049D6226FF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKIJaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiKIJad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:30:33 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54A21C92C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:30:32 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id t4so10374553wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+oiaRg9ab/55i5+llsM8upTgpALjLL7ge6TbqM64xg=;
        b=RHhGDNRzwjUu9GvsrF38Zt6cOnKGnXOnmW2bPWtOVMfrRFJF09jZRIOIRmCc0QIfz4
         7IyK8Y70iYRAOfz9MqySdyrP1aDkQSfrI5KhD7OhkP4tmOVB14h4zumEscz3hRqqEBnt
         QJ3qVVmlrKvlvWabD6nzjxFq2dn7zwoBFOlmmTKUORVojv4iH71C1yA8QKIdiME71/qn
         t5MP9FZO5lKz5Wqd61R91SkRLRtbQO1IvR++HKJjbiSEEOUKJ4YxlCwNPrXCKxgQFWB+
         upDrvG29rcIGIeRe/4OJ9dQPfGnAfcvkerNLkuco0IsxO+Q71E+C4pazqO/NJjlkzfgC
         ZPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+oiaRg9ab/55i5+llsM8upTgpALjLL7ge6TbqM64xg=;
        b=SNxeWM0yekTRFxz9ozss9ydJ4PeL2qToL5Qm/FcmqlK4b3Nkd22ekXk91t25F6yi02
         GZu8BNHOvh1vdwhTIMD/7TUajnq6b/eKsGpwlje0oB56PILm/IjcA9LNgT8SC00cn7d0
         w7jfmWaTypL4G6Uj4vxgtWaA6xC0Gc6kd7gp+24Ui/PPECe9kSvUrc+6GREGCLdR/JHy
         onII94fWA6CQ2C6W7cDFutG3+8MAlSWHfbUKj2Jm5CVZBH1KJNNTv2bBc7+DYGNkvzpo
         luFRo3qJXAA0NFwIG4OBP/lkHEXvvdo2D4FHgT+M2RrGXFL5S75UUZFZY83DP6zYvjE/
         ZlVA==
X-Gm-Message-State: ACrzQf3z3qRnQY1Zxzh16eWyi3tUc8/0mIoCP6OfR2ZX/l3p4p4r4DAP
        jmlb2x+ksj3ifHIPrkeSeQOqy7bzAGui3A==
X-Google-Smtp-Source: AMsMyM5CZJzOBieKuAmEeCCzQQ10GFMLXs4aPyOGSzVfWZwM2kf9IibD/CZi0VB1hLNqteJmscvGcQ==
X-Received: by 2002:a05:600c:3107:b0:3c6:ff0a:c42 with SMTP id g7-20020a05600c310700b003c6ff0a0c42mr48554390wmo.141.1667986231447;
        Wed, 09 Nov 2022 01:30:31 -0800 (PST)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (254.31.102.84.rev.sfr.net. [84.102.31.254])
        by smtp.gmail.com with ESMTPSA id g12-20020adffc8c000000b0022cd96b3ba6sm14547919wrr.90.2022.11.09.01.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 01:30:30 -0800 (PST)
From:   Julien Panis <jpanis@baylibre.com>
To:     nm@ti.com, vigneshr@ti.com, afd@ti.com, kristo@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: dts: ti: k3-am625-sk: mark MCU watchdog as reserved
Date:   Wed,  9 Nov 2022 10:30:26 +0100
Message-Id: <20221109093026.103790-3-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221109093026.103790-1-jpanis@baylibre.com>
References: <20221109093026.103790-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCU wdt is typically used by M4F.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 93a5f0817efc..089970b304cf 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -503,6 +503,11 @@ &main_mcan0 {
 	status = "disabled";
 };
 
+&mcu_rti0 {
+	/* MCU RTI0 is used by M4F firmware */
+	status = "reserved";
+};
+
 &epwm0 {
 	status = "disabled";
 };
-- 
2.37.3

