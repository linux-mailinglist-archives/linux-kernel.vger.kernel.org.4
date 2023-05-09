Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4956FBEFC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjEIGGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjEIGGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:06:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F26A5DC
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:05:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aaf70676b6so38142495ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 23:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683612358; x=1686204358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTbn+h4gklWy0dywRwfvbPwQi40OPxYHy/1+bcQ3D9A=;
        b=I++T0PObS5Hlj30jDivMOzpKfFrKhlVzRGZ7kdj+puPlgR4LkyRYCiyq+h+KCQiUUT
         kzxKC1r7UD+LSAsTvlRLx49lkH/dJjDow1+eg+Tasa/LgA3+PePOYjVJhatDeix4YROg
         aIoG9ZyMMqvNrfptmZTPXEHicW/DkzVphK8zyu9IXyiPqR41ySQ2jBMcgQGZxMpIeAXO
         CQDgNikelA6PGPjDYGn7RNtqz5Npmu6iNR6CShjWhud2ANr0bAWuoE89WMf6FJk75e7+
         iYmGw8kqDRnNrtZqKJXq2EpzTboLIUl1cBiRt5et1NzRBoX7eLuicWIaX60kTDDpOfS5
         MEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683612358; x=1686204358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTbn+h4gklWy0dywRwfvbPwQi40OPxYHy/1+bcQ3D9A=;
        b=MrTYiift71Xl1fqfaO6CvYC/qQQGATC6kP0ns3NFSCOWQZeo4Jwyp9B/KnADGmmrZ7
         5tzj/lXLvyH4X0jAdJWlBlIaOVrmTAH9AsB8HFMOlbGl7Le8uwOR52XXSjkcUEotnijo
         cIt3hPeyde3NFkAXXW3V77cKr/TSPJPlSfhiDdXOXb/A+CpUYI5BDGRrlM+7z1XNDiZl
         2xUIkS1iIiYlGxBPl0vthth6s5gJ8KHFQB8ukjIPAxfpDdu8yA1zZtvAIz1ko0NKsqS7
         4AK/gYCosApmoBq9n7kLWqlJ9vjpd9PIRtiOp++t76mPn/4IJgzXDpafuv+7gdUPmrif
         nwxw==
X-Gm-Message-State: AC+VfDwtkF69cPri9tUNl7+GkKWbphpeK49nntFE0lgkwlZHm/8w96AC
        XxQPg6En6gNAdo/wHq4oNQk=
X-Google-Smtp-Source: ACHHUZ4CyHPLhXIGEnY4kuAcYs5P0Eh2uVnnPwvb14AvbHEdbipgfSp5AY6dZZJN4r7rN6bYH3cW3w==
X-Received: by 2002:a17:903:2292:b0:1a2:3108:5cc9 with SMTP id b18-20020a170903229200b001a231085cc9mr18047893plh.40.1683612358698;
        Mon, 08 May 2023 23:05:58 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id ay8-20020a1709028b8800b001a9a3b3f931sm582220plb.99.2023.05.08.23.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 23:05:58 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-phy@lists.infradead.org
Cc:     David Yang <mmyangfl@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] phy: hisilicon: Allow building phy-hisi-inno-usb2 on ARM32
Date:   Tue,  9 May 2023 14:04:45 +0800
Message-Id: <20230509060449.1151113-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509060449.1151113-1-mmyangfl@gmail.com>
References: <20230509060449.1151113-1-mmyangfl@gmail.com>
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

Support for inno-usb2-phy on Hi3798MV100 was added into existing driver,
while Hi3798MV100 is a A9 ARM32-only SoC.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/phy/hisilicon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/hisilicon/Kconfig b/drivers/phy/hisilicon/Kconfig
index d3b92c288554..6c89136fc8c2 100644
--- a/drivers/phy/hisilicon/Kconfig
+++ b/drivers/phy/hisilicon/Kconfig
@@ -54,7 +54,7 @@ config PHY_HISTB_COMBPHY
 
 config PHY_HISI_INNO_USB2
 	tristate "HiSilicon INNO USB2 PHY support"
-	depends on (ARCH_HISI && ARM64) || COMPILE_TEST
+	depends on ARCH_HISI || COMPILE_TEST
 	select GENERIC_PHY
 	select MFD_SYSCON
 	help
-- 
2.39.2

