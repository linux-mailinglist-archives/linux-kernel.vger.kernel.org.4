Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC51740AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjF1IKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjF1H6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:58:45 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D453A81;
        Wed, 28 Jun 2023 00:57:14 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44387d40adaso327304137.0;
        Wed, 28 Jun 2023 00:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687939033; x=1690531033;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZH9p/TlXmsSBedGYAp6KRMQEOzFtRlyTJ1ayjylHrQ=;
        b=CVwpPOe/QywFz2rfqmgkS+MK9k/aXzUEM23tscaCQ2MVGUgzEUA7gjNhz72SI8Qv9f
         92+RuFqxjhFjKqXeg0mUXsjKLKLG3r/WmAa5yMtvRxlkQvxBTy7EyvSuOHoCMF2dV4H3
         7/+3UEu8sTktXblM1a2MSNw+6r5/4A84rLhKNwcUn6nLH9gDQJ9yIfCBiEEv7GB09Zlg
         r3fnZgRT8Ip3p/ylfNP1vVPy4jpuhN4yuIwQgN2n7kbFYjiPbUJHIu0yieAkkVvvvax0
         IGX3dyaeFRSzx9x4qD9Vgd1vfMzxbU+wy5H/cc0S+mLwAtypIEcwgGMQvQRl/pV4VlYg
         EaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939033; x=1690531033;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZH9p/TlXmsSBedGYAp6KRMQEOzFtRlyTJ1ayjylHrQ=;
        b=eJLw59oreu+W3DilXEWVVHfcEQEIzz5bJlHgg/M9hVrt+ASno44fDGpi1X35XNT+bR
         JOLYR88SGueXlTZfrC5vjV3k412g9ArH931Ae6ISRSNWAh9CKojMuSh8BoSZhNRWpRz9
         IQ6HwDehG8YjUqQO0F4VoRSfGphh3ODQCawWW07SsBNMBUW+1OhuHxns58hrkLGAxDHK
         LYn1mwc+YbZijGOSSnt+UQbQRWu433ENB3fHQtFtHQ+D0JgKGdiX05nAOlFCEW4c+XbH
         jrZsgd9ZS+Y3NrOKWIVZZnEii94e5Y0SnkvCfQEXlMQBxNNZmNW3Zgefyoyi+uc2XNYT
         MR8Q==
X-Gm-Message-State: AC+VfDyOsWjOd1rHn7a2uobmTP3EOcYnNY7ssa7KrbysDN32u5WPI4Xk
        V+aDzz8+Rc/sve2/f8w309uy52CyQxqjAQ==
X-Google-Smtp-Source: ACHHUZ7Kq5ytomtdmxd7m/mxd37OtSoMioEFtdJJ9POj33Ux2foJvKqyx5h2X6I93vcd3YiWLxxPZQ==
X-Received: by 2002:a17:902:e811:b0:1b6:9954:2030 with SMTP id u17-20020a170902e81100b001b699542030mr959664plg.8.1687937326445;
        Wed, 28 Jun 2023 00:28:46 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902c1d400b001b7f95fbec1sm5455850plc.78.2023.06.28.00.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 00:28:45 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] mfd: qcom-pm8xxx: Fix potential deadlock on &chip->pm_irq_lock
Date:   Wed, 28 Jun 2023 07:28:40 +0000
Message-Id: <20230628072840.28587-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &chip->pm_irq_lock is acquired by pm8xxx_irq_handler() under irq
context, other process context code should disable irq before acquiring
the lock.

I think .irq_set_type and .irq_get_irqchip_state callbacks should be
executed from process context without irq disabled by default. Thus the
same lock acquision should disable irq.

Possible deadlock scenario
pm8xxx_irq_set_type()
    -> pm8xxx_config_irq()
    -> spin_lock(&chip->pm_irq_lock)
        <irq interrupt>
        -> pm8xxx_irq_handler()
        -> pm8xxx_irq_master_handler()
        -> pm8xxx_irq_block_handler()
        -> pm8xxx_read_block_irq()
        -> spin_lock(&chip->pm_irq_lock) (deadlock here)

This flaw was found using an experimental static analysis tool we are
developing for irq-related deadlock.

The tentative patch fix the potential deadlock by spin_lock_irqsave().

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/mfd/qcom-pm8xxx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index 9a948df8c28d..07c531bd1236 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -103,8 +103,9 @@ static int
 pm8xxx_config_irq(struct pm_irq_chip *chip, unsigned int bp, unsigned int cp)
 {
 	int	rc;
+	unsigned long flags;
 
-	spin_lock(&chip->pm_irq_lock);
+	spin_lock_irqsave(&chip->pm_irq_lock, flags);
 	rc = regmap_write(chip->regmap, SSBI_REG_ADDR_IRQ_BLK_SEL, bp);
 	if (rc) {
 		pr_err("Failed Selecting Block %d rc=%d\n", bp, rc);
@@ -116,7 +117,7 @@ pm8xxx_config_irq(struct pm_irq_chip *chip, unsigned int bp, unsigned int cp)
 	if (rc)
 		pr_err("Failed Configuring IRQ rc=%d\n", rc);
 bail:
-	spin_unlock(&chip->pm_irq_lock);
+	spin_unlock_irqrestore(&chip->pm_irq_lock, flags);
 	return rc;
 }
 
@@ -321,6 +322,7 @@ static int pm8xxx_irq_get_irqchip_state(struct irq_data *d,
 	struct pm_irq_chip *chip = irq_data_get_irq_chip_data(d);
 	unsigned int pmirq = irqd_to_hwirq(d);
 	unsigned int bits;
+	unsigned long flags;
 	int irq_bit;
 	u8 block;
 	int rc;
@@ -331,7 +333,7 @@ static int pm8xxx_irq_get_irqchip_state(struct irq_data *d,
 	block = pmirq / 8;
 	irq_bit = pmirq % 8;
 
-	spin_lock(&chip->pm_irq_lock);
+	spin_lock_irqsave(&chip->pm_irq_lock, flags);
 	rc = regmap_write(chip->regmap, SSBI_REG_ADDR_IRQ_BLK_SEL, block);
 	if (rc) {
 		pr_err("Failed Selecting Block %d rc=%d\n", block, rc);
@@ -346,7 +348,7 @@ static int pm8xxx_irq_get_irqchip_state(struct irq_data *d,
 
 	*state = !!(bits & BIT(irq_bit));
 bail:
-	spin_unlock(&chip->pm_irq_lock);
+	spin_unlock_irqrestore(&chip->pm_irq_lock, flags);
 
 	return rc;
 }
-- 
2.17.1

