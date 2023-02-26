Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D042F6A2E7E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 06:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBZFyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 00:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZFye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 00:54:34 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC8CF766;
        Sat, 25 Feb 2023 21:54:33 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so6910100pjb.3;
        Sat, 25 Feb 2023 21:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1KU4UKwDKBhb3LB8IBaolpZP0aXG6lbdDGveHBNcajY=;
        b=PVkpTdH/j4Zk41D9854onJLUFNleBil8ezXgBr9h7Gq/p/99RCPJPocAQVjvIi6kMc
         5mpkYl4ZrDkQUtz/XsHaUlx64M3pCaEHGwneocwl03JqI1ZP9a1wI3qD5Ie2dAsy6ECE
         ii2PmNWEJyZJkOluYxVsGTYf1CvZtEwWdBNYhC5Y9EVhLe4CPbDKlhN2TqpWKNHlRtnq
         iWR/tBx3KODwMCh3ZG4eDMlbAWAErCsklP/IZNAE8uld51dCtg1Ef5HJZnVMiJHuJ9Hv
         mkaO5vYXME4Pbtj+GX7iR4uvKkNiP0/29tOXCzWR+2fneZngbwPZ8Evgmy74l2LzNUuz
         JeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KU4UKwDKBhb3LB8IBaolpZP0aXG6lbdDGveHBNcajY=;
        b=t6eIzJCCoptOjTXzvy7xb5AicML9Pin54ysPBVIhAoFlED/1pb5pa84XLGsmGCeNzd
         lfYuMDI4kyt2ftSVzD1CzIwf7y0aa4TAZh/ESIImUx9vA2LZ16UTrg85iS6o2XWpd4Vo
         cF0koM/JbcoNOXo66nVJhQFExYGK7EhR6u0QfogErk+/j1Bt/+IXLkL7Bwb66CgYR+9C
         5jHqCVFnW+iGidYbjjtk0cggUoC54taDNdRAgI0JTS7sCEsVcqDEHXjUeTCGeK3k9a5S
         igvkGUCz29XcsKeKWRpdecYk2mQeDYRDUEi7PxTwDdb80nvpBm5eeGyfoyOPv1E8iYzM
         3Tqw==
X-Gm-Message-State: AO0yUKWhrdDudtWK3VcBrj2nAVD1fdbuGXMqD2ULo3b52ZL+bmegczyp
        FDRS2LInYZImJpKJ7MdKlvk=
X-Google-Smtp-Source: AK7set91V52B1esubCcF+lnxwPQ0rLhC0bc07ISISeNB2K4/mJ+WCFa9kpkQKEujKGIk15AtBGeiAQ==
X-Received: by 2002:a17:903:8c4:b0:19a:b5cd:6e73 with SMTP id lk4-20020a17090308c400b0019ab5cd6e73mr5051874plb.3.1677390872747;
        Sat, 25 Feb 2023 21:54:32 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id v1-20020a1709028d8100b00194d2f14ef0sm2095504plo.23.2023.02.25.21.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 21:54:32 -0800 (PST)
From:   Kang Chen <void0red@gmail.com>
To:     lenb@kernel.org
Cc:     rafael@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kang Chen <void0red@gmail.com>
Subject: [PATCH] acpi: check for null return of devm_kzalloc in fch_misc_setup
Date:   Sun, 26 Feb 2023 13:54:27 +0800
Message-Id: <20230226055427.2512453-1-void0red@gmail.com>
X-Mailer: git-send-email 2.34.1
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

devm_kzalloc may fail, clk_data->name might be null and will
cause illegal address access later.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/acpi/acpi_apd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 3bbe2276c..80f945cbe 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -83,6 +83,8 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 	if (!acpi_dev_get_property(adev, "clk-name", ACPI_TYPE_STRING, &obj)) {
 		clk_data->name = devm_kzalloc(&adev->dev, obj->string.length,
 					      GFP_KERNEL);
+		if (!clk_data->name)
+			return -ENOMEM;
 
 		strcpy(clk_data->name, obj->string.pointer);
 	} else {
-- 
2.34.1

