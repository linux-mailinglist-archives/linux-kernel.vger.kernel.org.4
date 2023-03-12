Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0E16B669E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCLN0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjCLN0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:26:06 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA92903F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:25:37 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id fd5so4688928edb.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678627537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yXeUy3HcdztCB0Ld8qfPoUhK1lKlns3n47t71MgWEBM=;
        b=Dd3U7NSZWiATgzwzUFgKjIv4WIaS5m8ab5QYcHS6kj63tjLo1Vbw9IL0rURdCKjKUx
         XLFPZSa86OIETw9hGe+GrihBdFy2H7zKwwQIexL61xTRq7UY6ExW9D33eSG8sns5TsMH
         WyVGdLuvTUARRMaojGsp98TzjT510g/Iii3FnLwdhAMCpxp0orpo6rDdy9pPZMHvgMKD
         DITSxsFawNBW3kIqctlZ4eRF9ASb4fKEU+JvB82/fBwuQO7FgRafpm3/3HTvDP0R2Gys
         LfF0qeyHbH57yYUNuQ+4QRxMq2fVw0KoHDZ0dcayguxlBsRbZFOlDj/rJk9ShRJicvtt
         hRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678627537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXeUy3HcdztCB0Ld8qfPoUhK1lKlns3n47t71MgWEBM=;
        b=q1hrvQ7h8nPG05ad4GjmFLn+zwxpZicpLS5ZXvtIQUcAoNlWNpxbPR/Kj55R9dKIDO
         Rk21JHUDpbv/gg5Tc4mRKVWzX30Ao939tFz4h8qoSH6Xrw2JMu9ICDUX+6/Fd1mYqIFv
         YeQoZnmj3XifR16iC8t83KrK6P2UyPzEYBzvM4ExN0O9xtoE4+EgmLEnrgJRYRc0TK02
         Ax1IzouA4WwXQNIyRNxcXDn8uWh4d7rgSXEfPrbdhDUaG3Zega1DtSAB5HmtC1yuUW9M
         q99UACyJq8ZtmTEtqFIYhY55oOZLpM+QlsvMncryW1abrQ2QhcgQub1vKwdjYCs12NNm
         RNdQ==
X-Gm-Message-State: AO0yUKVTRK/jvoHvY+6JbZd023jP34+39FZ6cjpRZpoZmKkSChFpdLCZ
        g73wUV8K5aMYcDBhrXDIJR6tSQ==
X-Google-Smtp-Source: AK7set/Lmvmw41Sctc9aj29/JgR5CI7HO1/JK5pXtKXHE/wmNwgU58jaxQF9y5cZAEGxFauentONOg==
X-Received: by 2002:aa7:c1c4:0:b0:4c5:bc48:d422 with SMTP id d4-20020aa7c1c4000000b004c5bc48d422mr25696218edp.7.1678627537160;
        Sun, 12 Mar 2023 06:25:37 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id i23-20020a508717000000b004bc422b58a2sm2171320edb.88.2023.03.12.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:25:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] i3c: dw: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:25:35 +0100
Message-Id: <20230312132535.352246-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).  This
also fixes !CONFIG_OF error:

  drivers/i3c/master/dw-i3c-master.c:1201:34: error: ‘dw_i3c_master_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/i3c/master/dw-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 48954d3e6571..4859dd75388d 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1209,7 +1209,7 @@ static struct platform_driver dw_i3c_driver = {
 	.remove = dw_i3c_remove,
 	.driver = {
 		.name = "dw-i3c-master",
-		.of_match_table = of_match_ptr(dw_i3c_master_of_match),
+		.of_match_table = dw_i3c_master_of_match,
 	},
 };
 module_platform_driver(dw_i3c_driver);
-- 
2.34.1

