Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE5A5FD75F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJMJyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJMJys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:54:48 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7309411C11;
        Thu, 13 Oct 2022 02:54:46 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h10so1363881plb.2;
        Thu, 13 Oct 2022 02:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o1yqNAVn037IZuwd1cSJvfpEqCBUbSaG0FfXXsU7E7k=;
        b=PT2ZApPV9lhgRCbrO1+GjOlvi3zKlAmL75I1oIfVMJhVPIt3eDXMA3cmYi5oitz8e4
         qWm/LUImy49JANTFUvqOAkEjrVI9PZeq16YUv4cLYEelgVjQgvuDl54scedzhblUJUPp
         j/Iw8qQrLo0pY2Y9+kZBRQ/fg5A5f10msH+nvv12SowLmo7U1Z7VkqoX2KouMG7EMFPZ
         ++1OD6DVsyNKGIN7xK07V02ig5AyndyXc7FaTad+OI/dDBuVFNileTxqWuYHatFUZCXF
         DJDr31K7bYLk+HAMJvMYCSUChf/J6aoFJoRauCOCUKDrrC2M6ERuKlj6jEsGV8C06uFF
         RqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1yqNAVn037IZuwd1cSJvfpEqCBUbSaG0FfXXsU7E7k=;
        b=Pu/bVvsgs0yLKU4qm0u6IIo+ZtMC3599Za/5ZJnCXzAg9tlUDnJDhBM6j/oDTebPhY
         3S0PSDuDG33pVc6tm1eZdDnhqwp3KXlm+2Cf65fJjd3eHYqdAQcTseAsrdjS7Rp1rMzN
         RhlqR+/9vdu40bWSKCMkIs6cUu3tFVqUxFwf4x4fzL0O7cvP8gmraPIB6r+62gAO/7G2
         2mpOaLvgoSE7NalIx8dAsV4nbyotbZUc2VtzM8Rylsiqj2chnFkhxhPFGoAFRT4o+IqO
         VF4XSS2E7Sj9dKEmTuqElSgKBQjWOA+eSERBsjSl5wujTvhtWzofsG+xrHCIlqrCGfd4
         DTAA==
X-Gm-Message-State: ACrzQf13FjXflLv9O+wZYz7ionF5ny9/6eX0Oa1uutPhVK78zlfCkk5i
        xWErvAc8FTpeP+3buGvKCzM=
X-Google-Smtp-Source: AMsMyM5G5VmQzPETVse+/R1+X+z5v8zBeBRc11dFHxSAc8uARnm6u/iJBbwWvQj0Bzxj60rNWAUl8w==
X-Received: by 2002:a17:90b:4a51:b0:20d:4ded:3c26 with SMTP id lb17-20020a17090b4a5100b0020d4ded3c26mr10063350pjb.23.1665654885937;
        Thu, 13 Oct 2022 02:54:45 -0700 (PDT)
Received: from localhost (ec2-3-6-129-254.ap-south-1.compute.amazonaws.com. [3.6.129.254])
        by smtp.gmail.com with ESMTPSA id i19-20020a63cd13000000b004582e25a595sm11076472pgg.41.2022.10.13.02.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 02:54:45 -0700 (PDT)
From:   Manank Patel <pmanank200502@gmail.com>
To:     linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manank Patel <pmanank200502@gmail.com>
Subject: [PATCH] drivers: watchdog: exar_wdt.c fix use after free
Date:   Thu, 13 Oct 2022 15:24:39 +0530
Message-Id: <20221013095439.1425108-1-pmanank200502@gmail.com>
X-Mailer: git-send-email 2.38.0
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

fix use after free by storing the result of PTR_ERR(n->pdev)
to a local variable before returning.

Signed-off-by: Manank Patel <pmanank200502@gmail.com>
---
 drivers/watchdog/exar_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/exar_wdt.c b/drivers/watchdog/exar_wdt.c
index 35058d8b21bc..7c61ff343271 100644
--- a/drivers/watchdog/exar_wdt.c
+++ b/drivers/watchdog/exar_wdt.c
@@ -355,8 +355,10 @@ static int __init exar_wdt_register(struct wdt_priv *priv, const int idx)
 						    &priv->wdt_res, 1,
 						    priv, sizeof(*priv));
 	if (IS_ERR(n->pdev)) {
+		int err = PTR_ERR(n->pdev);
+
 		kfree(n);
-		return PTR_ERR(n->pdev);
+		return err;
 	}
 
 	list_add_tail(&n->list, &pdev_list);
-- 
2.38.0

