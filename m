Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7972638E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiKYQTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiKYQTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:19:39 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F015D4AF20
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 08:19:37 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ha10so11411534ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 08:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/q0MZJ4+Hs8nfmckUaUTRdDZ/RrFoFIfZn+oOmPN1Ss=;
        b=TB53FpzTOBfmO4vPF12EQmXaT/7IR6+8sN47+tv5R8ZcQQ7ovtmDfOtW4Ee3HdOai4
         PKjIMXjVcD0Uc7lGywK+HTf3dKFUFTRub+HpQqwPL7HPoqO1K1w12K54Et229XlF7xhZ
         FZ4XpJCANyN5GerP5vAIo+SUmvXsWpizk3UbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/q0MZJ4+Hs8nfmckUaUTRdDZ/RrFoFIfZn+oOmPN1Ss=;
        b=d8UHZPSuMKSOlnd+77PzsMqOTHCUjuFjXiqxbHHOJFyyFOnzxGVqjf33WUU8gJM5Fi
         FrGoTJ/sGuj+wFvkO4cxFokMY5fY5+OUmkz3GXy6cY8uxGHvas32Hi56PICcLBvjwpv3
         Hp15wDCLV6HG9rxRTuAQClg02YC8TjYxcYLHndNQBSS6QmySiRRLSno5amUgBRFLLDdO
         Vbv/r8Mqghz4z1X4hFkIDH6gvPWbCqJwR+2PRD6OdQfV7rP+kpZdnJud5tFyMyljcpDU
         gHg+szIh2j9EQ/ZvPEoo+4QI7kz+Zj0Rgr54dbLAbA9VCsoqyhnv8f8IRprv2qBBj1UK
         mL8A==
X-Gm-Message-State: ANoB5pkMEIjC957pMt/zobvhBQawwtIGTpkBf3dGmLgTrWtjM7zUDw+9
        wm7TWfYVPD8wVgIPtZr9pTrSPg==
X-Google-Smtp-Source: AA0mqf5rOSJA/XyRv3Hn1/RoEiM2SyXqzkQZs9e86B5m1uyn3rnriQmXLqpwQWtb37c3UPdZyL6RgA==
X-Received: by 2002:a17:906:16d4:b0:7b9:f0fd:47b1 with SMTP id t20-20020a17090616d400b007b9f0fd47b1mr11421279ejd.462.1669393176582;
        Fri, 25 Nov 2022 08:19:36 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id x22-20020a1709064bd600b0078d3f96d293sm1738626ejv.30.2022.11.25.08.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 08:19:36 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 25 Nov 2022 17:19:12 +0100
Subject: [PATCH] mailbox: mtk-cmdq: Do not request irq until we are ready
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221125-mtk-mailbox-v1-0-2e3ee120850c@chromium.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Pfgq3cetcD6H5umRF+mnqFYIMTf/wVZSYUZ+95IEVPY=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjgOsKXc9/JqrrNMUJ0FRpX5f3QsGved06zFHgG3TD
 LYdQ90GJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4DrCgAKCRDRN9E+zzrEiIN9D/
 9SGMhOXA7mTz8AZoRLAKZgDbDGIZFvOzu4JcxE5VDEplnxrX4mBGldhAOI00bICFWwL8QFbiukTzK3
 F4kdOnHKOVho+hK22h6R557i9RFbbYuVfjQseRgxjnK0CbaPuGbodXy5YrifRltRG20IrHwGV9wyVi
 fC30dRLYIJXaGzAxXL7v7XdLP6iLhlj79Qxm/c76+nqoPCcbZbVYtQ+mGW2fedSqXsPqxpYz/jMINN
 +OkaagQ1jJDoinN3DMD9/+UszW4Ussg+AETObowjBQZUJyB0zGAVt2ZAA7g/GQpuArdhgQPlLGTHWq
 UVVZEl7FrQxjqR1osa2IhWGfzC4p0To+j2rfXFVmELPsgXF1w3scFMdXKYVGx+B6N181J82b0qAenx
 qX4dTgBrQsmKc36tC9qwJd7jRjdIdY5KAZVYTu9Ku9YyhkNfsdD7SLV5qvy5tou1UftfZisDvZkszF
 +TMEvP8n53e66FVOjP611lrZRkzxp0mPHsXQMWpMf+h4lBNdsipyRR1ycerzyua0Ckjx82mVG534Pg
 LIwGFaCdNkcNx7g8SFRea86hFpyrJlNpwSu5SY7wZeUozFkb2xng3BwFgjVkF4Q1gDOiRXZHo0bIHw
 Zpw49Z8CmlUBNh3RulMe5Fi71RDjNk4RPiliBgkJLAG0zLO7Bix7z7xTdH3g==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the system comes from kexec() the peripheral might trigger an IRQ
befoe we are ready for it. Triggering a crash due to an access to
invalid memory.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
To: Jassi Brar <jassisinghbrar@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 9465f9081515..829f1ef3309f 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -545,12 +545,6 @@ static int cmdq_probe(struct platform_device *pdev)
 	cmdq->control_by_sw = plat_data->control_by_sw;
 	cmdq->gce_num = plat_data->gce_num;
 	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
-	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
-			       "mtk_cmdq", cmdq);
-	if (err < 0) {
-		dev_err(dev, "failed to register ISR (%d)\n", err);
-		return err;
-	}
 
 	dev_dbg(dev, "cmdq device: addr:0x%p, va:0x%p, irq:%d\n",
 		dev, cmdq->base, cmdq->irq);
@@ -613,6 +607,13 @@ static int cmdq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, cmdq);
 
+	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
+			       "mtk_cmdq", cmdq);
+	if (err < 0) {
+		dev_err(dev, "failed to register ISR (%d)\n", err);
+		return err;
+	}
+
 	WARN_ON(clk_bulk_prepare(cmdq->gce_num, cmdq->clocks));
 
 	cmdq_init(cmdq);

---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221125-mtk-mailbox-ba6cbd1d91b6

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
