Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4BE60E2DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbiJZOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiJZOJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:09:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AE826F8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:09:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a14so23749581wru.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L8c2OBjHn01HQbFbmOQb3O6qQFFydiS8u7n6jx35YlY=;
        b=qwRhI5VTWmsnRfxZ7DbdXTibU24vXngyRrAWuofIV2aCxFVIgI4xjb+qw+MsmztG4a
         PPeNPGgNlANWT3LweFGlcBqDrMPQ2hNnJUfMDhucRg9+ePUlxDSrQVG9e4fQ6F1TxNXX
         4OG81ml7u3Di39zsp3QQlgnqFRK6Cqw9SYu54w0Oaa348xKf9LGRW2pnO4ZJs2Zv/XlX
         KA7QS5Diz73Nee//0iiOQp/EyXQ8tlVFZnTlK+3jjYhgi4tboFnp4p/TXfIG9xqk9TIx
         G4TsO7Yb5oPAk1Dq3QHYj3VOuekmW7bG3D5eXrhkCuqHYaefFJyZeP9kiOfqnokZPsxK
         4eIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8c2OBjHn01HQbFbmOQb3O6qQFFydiS8u7n6jx35YlY=;
        b=fFUOTk5wJ8+/Tfse56nmZQnuHmBrbTdGsD8271+11CtVxR+P9upeEiGAeZbjXLNyIc
         J93E8F7RBH5C96KqVfZQ5fxzmH6QiJy/Pn0yxUBlHqq1dZXj2s83aGOUoVt3PkiEp4m5
         p3Pxa3Ltm9NgJBwev50w+6rxWqrEdbEm/3wQIX06tzvvjt844HIXuEmpP1o7He3Y4bZT
         PqZthwtlu/AHwSI3sHxkBeZmOA0xHtJMHCad+zApK7mavLLXUoLLoiIfMLaXdcY4fRUF
         VC981V/VnWluUs6Ze6dZES+365jsjd2C1Dykqvi8lejOAP3rSXPO/mzRL8UFYz/hD9aV
         SByA==
X-Gm-Message-State: ACrzQf0YJdY0xBY8O76q+PkJS8k6psNFdPqouTzm2iNpiwcOplTRwbiY
        67V84sDTKZWf31rxvh6hYD8DwA==
X-Google-Smtp-Source: AMsMyM6ETs32F+QOHsj7Ve2nfzJcfZ6xrAV02hFQxKATw9rQbyAEas2dcjfFMX5fb3RKVQYVH12NoQ==
X-Received: by 2002:a05:6000:1f01:b0:236:64ae:ad19 with SMTP id bv1-20020a0560001f0100b0023664aead19mr13560321wrb.523.1666793362047;
        Wed, 26 Oct 2022 07:09:22 -0700 (PDT)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:5e38:f194:7686:c33])
        by smtp.gmail.com with ESMTPSA id r29-20020adfa15d000000b002365f326037sm6760202wrr.63.2022.10.26.07.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:09:21 -0700 (PDT)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     lee@kernel.org, linux-kernel@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH] mfd: palmas: add support of module build for Ti palmas chip
Date:   Wed, 26 Oct 2022 16:09:11 +0200
Message-Id: <20221026140911.204776-1-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
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

From: Guillaume La Roque <glaroque@baylibre.com>

Modified Kconfig to enable module build support

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8b93856de432..e433663a655e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1499,7 +1499,7 @@ config MFD_OMAP_USB_HOST
 	  OMAP USB Host drivers.
 
 config MFD_PALMAS
-	bool "TI Palmas series chips"
+	tristate "TI Palmas series chips"
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
-- 
2.25.1

