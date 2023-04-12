Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AD56DEB38
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDLFig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjDLFid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:38:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFE7E54;
        Tue, 11 Apr 2023 22:38:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o2-20020a17090a0a0200b00246da660bd2so3365080pjo.0;
        Tue, 11 Apr 2023 22:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681277913; x=1683869913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed17VsKqIYY1EHY3aBloZZET84zjPJ3dZSJioIcN9l0=;
        b=i/l1XdVo6tC0oXOGg7hrT7W3LYx9xPQd5AXrSK71g9YS7Totu+tSpT7Yz6L/Ysz0ov
         3tpmRLDQglpc1ZddE4TDJYLd3NbbhL09gEL6RfneRgaJDO8oSEs3jgNeQeWXrmxx4leK
         nwS03im7+XrqRP8w3ckznY84cGlCLrqcJ9bOu8rcdtX6dCls02xmR6XG6BEeHr84TTbN
         XOGVQNLBqvmhbHd5lTRtS7PaeFUs4f0yGasO+s3CIVPY1Eglxh+9fR76UvAfgL9gMNqc
         QtpiiwubtqMouE/k8Q/xhO4O/1ZRkr0Et0qLx8CFUoQbFRNWRRqLLNbvkV7AXWCSP4TY
         ZD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681277913; x=1683869913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed17VsKqIYY1EHY3aBloZZET84zjPJ3dZSJioIcN9l0=;
        b=eWX9qEFDzIHiHxLXi956Rfu9DYWCqLd4N8kUXzWmWK4i5kOslcfCjI937UU1+HQ96W
         urWVYCUa0gtxGhdy0GsHOrWlW7qJiTvESyU/U87qoVBvp2GJQ5xyF8CV2bCN1nvL8ECN
         U8Ig15n2nh+AG7g53vspX+WPpBfr6Cr6wva8XDTELQhzaYOo0pizNeWsdjYkRtZMCc70
         rPNx2cFFbQb9KHVhW04u9Wg16a5kiMZrq/vSO48tVhGwgLe2UnKBSCrnxn/fpUbjCmh4
         y4LtrQ3But7YCQbchf7cPFvzcLG56o8ZbFSWlz0kZVWwY4HL/zjdOqOhoFQP6EplRreE
         MTjw==
X-Gm-Message-State: AAQBX9f5eBs6BXtpFiZ757kn5JEWgMXKI7/kTf1sefDTCwI+8qVUioRc
        ZX/Y4pJBOg1E7OesV8qkTfklNU/eZehmyw==
X-Google-Smtp-Source: AKy350YsnT4fc0ziMpOasjDUSbPSDR8oQ5TPMqC5RvoUThfpkhxRdy4jQEaT01jWptDcWAQxopitYw==
X-Received: by 2002:a17:903:2092:b0:1a2:8f43:5449 with SMTP id d18-20020a170903209200b001a28f435449mr14661582plc.54.1681277912688;
        Tue, 11 Apr 2023 22:38:32 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id ix10-20020a170902f80a00b001a64c4023aesm619640plb.36.2023.04.11.22.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 22:38:32 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v7 01/12] arm64: Kconfig.platforms: Add config for Nuvoton MA35 platform
Date:   Wed, 12 Apr 2023 05:38:13 +0000
Message-Id: <20230412053824.106-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412053824.106-1-ychuang570808@gmail.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

Add ARCH_NUVOTON configuration option for Nuvoton MA35 family SoCs.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 arch/arm64/Kconfig.platforms | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 89a0b13b058d..c1f277c05569 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -236,6 +236,15 @@ config ARCH_NPCM
 	  General support for NPCM8xx BMC (Arbel).
 	  Nuvoton NPCM8xx BMC based on the Cortex A35.
 
+config ARCH_NUVOTON
+	bool "Nuvoton MA35 Platforms"
+	select GPIOLIB
+	select PINCTRL
+	select RESET_CONTROLLER
+	help
+	  This enables support for the ARMv8 based Nuvoton SoCs such
+	  as MA35D1.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.34.1

