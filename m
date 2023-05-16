Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506C07046F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjEPHwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjEPHw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:52:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC4D1FD8;
        Tue, 16 May 2023 00:52:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ab032d9266so127402095ad.0;
        Tue, 16 May 2023 00:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684223547; x=1686815547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLSNqhfsX/8DU8Piq0V69+g0dOlfyAZ+TAo+HAf1L+o=;
        b=dAbNaJyT7pMNupMmkMfqoR5ouQYIVR98losthCV5npFlKyeJf5GZ0wZhQPLJ7pdYzF
         smGLNPkKlCXo4XQU9nSzS9WptgIN128/Ud+fRadprroxmhxmQ8mIsE+UsyE1+Y1cIHQS
         bsc2HCfduUHyAAoc9EqflW/9v9wwTpWKY8sq89WlXhc2Oev9LdNXNIE6WFIKAjaop9Qf
         MEbR23SFiEORYdftppLBGIX5hAjljIp+z1KD5IcckLbBy/UTaBfiYh+oyEXjbbiirblC
         WGtDR2ku2hLX/njJPYb85DVy84qDpkKxIXqoZHGlKgIQ6US51ZAUbm/NWtIJ90D7AaEu
         uJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684223547; x=1686815547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLSNqhfsX/8DU8Piq0V69+g0dOlfyAZ+TAo+HAf1L+o=;
        b=J5/dGmJhPV+Zylw+/okkF2OaIblKqDajkZpirZ2ZPI3YQFLMPI5XzHPAgTGDOiWVDR
         FpATHrA8tBJwbApkW9dBhZKuiJp4XbKGnXDUMpAi5emLTnKabfxgMnFq/OOd6Ab6ewkK
         RKmixMqZ8N9HremnDsuVt8SqV2EZ2bgjFXhkM7XNDC6Zu/sQS0wRfUqaFcqFppDKhCzt
         EBqiuliaMmAuGkm5x+54wFHBQnQ6YNgpiWWN+k2RpK/ZTmH+ebLDn9/h3u7JIBCNfCu0
         sVXk/XGAdAGZzReir+EvXiiS9T60UuiX4Tm6yaMn6MCsYY5Z2RfyE865LNV+HvXsNq6k
         tU0Q==
X-Gm-Message-State: AC+VfDwF0XqI1ZeaR0ZXKhnhXH9KIwFC/uSjoH3qVncML6FmvjN+vNWw
        JciiL9CrQCWB3CZp2tE8dvM=
X-Google-Smtp-Source: ACHHUZ5uTqwifjat9zlCoRctDNTMQca+z1Yw2tSwplEfB4BBUCOc6/3ENeAY50ytDGfzhCyfdge8bg==
X-Received: by 2002:a17:902:7402:b0:1a9:7a7c:2086 with SMTP id g2-20020a170902740200b001a97a7c2086mr37998596pll.27.1684223547565;
        Tue, 16 May 2023 00:52:27 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id n18-20020a170903111200b001ab061e352bsm4793043plh.195.2023.05.16.00.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 00:52:27 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v11 01/10] arm64: Kconfig.platforms: Add config for Nuvoton MA35 platform
Date:   Tue, 16 May 2023 07:52:08 +0000
Message-Id: <20230516075217.205401-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230516075217.205401-1-ychuang570808@gmail.com>
References: <20230516075217.205401-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add ARCH_NUVOTON configuration option for Nuvoton MA35 family SoCs.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/Kconfig.platforms | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 89a0b13b058d..e28dbc477a99 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -225,6 +225,14 @@ config ARCH_S32
 
 endif
 
+config ARCH_MA35
+	bool "Nuvoton MA35 Architecture"
+	select GPIOLIB
+	select PINCTRL
+	select RESET_CONTROLLER
+	help
+	  This enables support for the ARMv8 based Nuvoton MA35 series SoCs.
+
 config ARCH_NPCM
 	bool "Nuvoton NPCM Architecture"
 	select PINCTRL
-- 
2.34.1

