Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3925162EDBF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbiKRGjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbiKRGjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:39:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D244561519
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:20 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g2so4091876wrv.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WApaZp0eQftpVOEpuPkdkP7sInE6oeCRgV8lSQQTOB0=;
        b=iK45VugTy5cKdlstFPJtCtzg5RMhxaGL+SYt0nKGp1Bow3IDPoe9aew3J3Ou5Q6YzF
         6hhjD3WIPzdCIKt7kYLYFnoOnwiGPyEH1J5VOR8FJA3Q6JpXGEkamThQrIliiwjfv0lO
         2XLVXYdZbsnDK+CSX6r+bF9vvjQS5GA+NQbVd8xklKTi8E0d9e9gRIUISqgiTmPKPNd7
         T/tRxncldq4zmBy3zxETy1saLUjQyc0+4khBQDYQMoaGJ0vu7u6IF13fnPUm80ybFQy1
         godnAhvq+WjBbKwqb7aJa/iXlMICjT1J/AeADwP5PHmr7dnFBlnmT8sqW8fzhjrGHU5J
         cHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WApaZp0eQftpVOEpuPkdkP7sInE6oeCRgV8lSQQTOB0=;
        b=dll+ChNskGKFYS1ouCfWCvQrM5E7/Wv2yF2jhOL57s28uVXuJl0CgjIcujOLH0lNXt
         Ks8Dnz0cV986VJzC1NImDFP9gKJKhdWu4TUHd1osub0hVrA0WOYqfSqtvZ96ASzWa+mO
         CvhB83VJERTtv4l1iJDSSqvOqXdAtrQUBmn+qU6LMqMFMw9+MRq2AJynPv6cIwPGChQv
         FYacP114j/iRrnNpjV5+20iMTuryRUBeKekP+H0kwrGncKNOFj6ZbN4RFw2qHQ5ZSxGt
         DX4oYBJD0XPG46M2D1/M0KAEktVCXj6E/Xbj6pRhTMiy0nafw7EbrF7nbbML+foXwung
         +fBw==
X-Gm-Message-State: ANoB5pkDE467Ia4a/xGSn+AEEU1hKtV7bqlbpcgioGf0W8m4XvSQ7Aiq
        L4fYjex7BTi/7I1RUn2Uf575pw==
X-Google-Smtp-Source: AA0mqf4OhJOlX9Ya2XHjRFQna9lPIcu6UyMu1Ifw9d8vSFSGwCfJvOtmq/wDkRsVA1q01KNVnjJSqA==
X-Received: by 2002:adf:e702:0:b0:236:57f5:5d8a with SMTP id c2-20020adfe702000000b0023657f55d8amr3197907wrm.460.1668753559415;
        Thu, 17 Nov 2022 22:39:19 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bcbd8000000b003b4fdbb6319sm7853861wmi.21.2022.11.17.22.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:39:18 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] nvmem: lan9662-otp: fix compatible name
Date:   Fri, 18 Nov 2022 06:38:37 +0000
Message-Id: <20221118063840.6357-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118063840.6357-1-srinivas.kandagatla@linaro.org>
References: <20221118063840.6357-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Documentation of lan9662-otpc driver (namely Documentation/\
devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml) express that
compatible for this driver contains "otpc" string at the end but not "otp"
as currently present. Fix this typo.

Fixes: 9e8f208ad522 ("nvmem: lan9662-otp: add support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/lan9662-otpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/lan9662-otpc.c b/drivers/nvmem/lan9662-otpc.c
index f6732fd216d8..377bf34c2946 100644
--- a/drivers/nvmem/lan9662-otpc.c
+++ b/drivers/nvmem/lan9662-otpc.c
@@ -203,7 +203,7 @@ static int lan9662_otp_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id lan9662_otp_match[] = {
-	{ .compatible = "microchip,lan9662-otp", },
+	{ .compatible = "microchip,lan9662-otpc", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, lan9662_otp_match);
-- 
2.25.1

