Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9957C73FD2E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjF0NtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjF0Ns5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:48:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63532D62;
        Tue, 27 Jun 2023 06:48:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fb10fd9ad3so19196705e9.0;
        Tue, 27 Jun 2023 06:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687873733; x=1690465733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JqpiHtecb9C65DHHvOJv3B2wwux1crTE1Hic8Ce6/L4=;
        b=V2k9AFsCpd5fPtYvki3IdaGAOVQns/84yXy0EQeQzkz6JcR24ZH3XwM4wIxeOiAJC7
         uE5CBB9ZKEH5BK8ZveSilQdZQ9oXYBnQHU4ooZsW+dSBTN6mDkdEyiryDLF98GI1Sil6
         Z9UByBBzbUwcKGLHjuI2KZPff7tEfnSsFYnyATIXzJFeVeieV+zLvDjddz2N4a2yR5hk
         yCCLuWkE64kI/gsLW5GE1qYUHlFKqECaY0+xoIg1ihWgfYXAjlGQlEjh4aN4USg1y+HS
         /7GLOJGN+JXCU32Ug6xNlRgQ3l6FqKwMIcFvXWyFnTmmnJVxTTnpnY9MlNekpwNOoE7N
         qMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687873733; x=1690465733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqpiHtecb9C65DHHvOJv3B2wwux1crTE1Hic8Ce6/L4=;
        b=EI6qUUL5KXPAlgs4eUVgoRaa8yvOmk9LqfhnsyEH9bbRhW7JjXtdGtaxlF3T5Uagqk
         BkOH/a21jE2FNpwLcZJB32UqEgLlYOC7yFWLhsiqSnFdp0pioFmTwC64l7dQXZa4o+yV
         QJa4BLHbaSqohnasDunovd6UBBSemGgzHZS05UYFAi8yNExj0OOnoBIa+SBQYchi8ff2
         UeytIRRO734Lt5rI88QOFGTDh8KoHqSb7w9hbSR9S0XoyPxSBmuGz31l9DuheTi29Lcz
         3VhVJGBCbn4h8fXrRvnhwwn1PfqY0si8EIY6xeYmpvISjScpCwOVfuHvqd8Urzs+HRjo
         v8iA==
X-Gm-Message-State: AC+VfDx5NZw2olHKI+G1k3lR7K1s1kc2Joy6sIcrcIeAbRg9Pugg0V/x
        86mmIC1oNVHbYLzXO8SHim4=
X-Google-Smtp-Source: ACHHUZ7ObcIX3NdFQkDirjNljZfgfmkV0MHKzii8w+mAA8/EbhgJ2dv7kapt7PF6IQ/IvCkxgLb1Fg==
X-Received: by 2002:a05:600c:2152:b0:3f9:a6f3:8a53 with SMTP id v18-20020a05600c215200b003f9a6f38a53mr20815220wml.20.1687873733154;
        Tue, 27 Jun 2023 06:48:53 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6102000000b003127a21e986sm10345778wrt.104.2023.06.27.06.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 06:48:52 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] media: bt8xx: make read-only arrays static
Date:   Tue, 27 Jun 2023 14:48:51 +0100
Message-Id: <20230627134851.728487-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the arrays on the stack, instead make them static const.
Also add spaces between values to clean up checkpatch style warnings.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/pci/bt8xx/dvb-bt8xx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/bt8xx/dvb-bt8xx.c b/drivers/media/pci/bt8xx/dvb-bt8xx.c
index 4cb890b949c3..df83b59a618d 100644
--- a/drivers/media/pci/bt8xx/dvb-bt8xx.c
+++ b/drivers/media/pci/bt8xx/dvb-bt8xx.c
@@ -190,11 +190,15 @@ static int cx24108_tuner_set_params(struct dvb_frontend *fe)
 	u32 freq = c->frequency;
 	int i, a, n, pump;
 	u32 band, pll;
-	u32 osci[]={950000,1019000,1075000,1178000,1296000,1432000,
-		1576000,1718000,1856000,2036000,2150000};
-	u32 bandsel[]={0,0x00020000,0x00040000,0x00100800,0x00101000,
+	static const u32 osci[] = {
+		950000, 1019000, 1075000, 1178000, 1296000, 1432000,
+		1576000, 1718000, 1856000, 2036000, 2150000
+	};
+	static const u32 bandsel[] = {
+		0, 0x00020000, 0x00040000, 0x00100800, 0x00101000,
 		0x00102000,0x00104000,0x00108000,0x00110000,
-		0x00120000,0x00140000};
+		0x00120000, 0x00140000
+	};
 
 	#define XTAL 1011100 /* Hz, really 1.0111 MHz and a /10 prescaler */
 	dprintk("cx24108 debug: entering SetTunerFreq, freq=%d\n", freq);
-- 
2.39.2

