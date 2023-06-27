Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4D973FF97
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjF0PZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjF0PZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:25:03 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4A02962
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:25:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso2416638b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687879502; x=1690471502;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A04KwW6ieNfH8wPX+bT+AUz62umM36e5LmdKIB4p2KU=;
        b=gFsc45xjzR8Am3ZaCp58fSbQaJdocsOnbrpJ9Xgff/S7Oh/Dsiiv/F6un7RbkBfP3G
         qO3kOZQm2EYfOUgT+GnFMVM2bSiaq9CWjDsBm3onyx+3WT4nuQPnwvWoJvjYQ6GA6mZJ
         FCH/KE+WrBEbe9VhxarFTgxX+JLXLYScOUKkZ4QeWeRCdp3MG9gqehCS2gsBblJEvcuE
         k7aNB6wGaF090K3gveDr8JI+2Z7R9W90v4bigF3WWFwaKIoQRO5R1C8sIwSO5pj9SEIL
         crfl0IxOLeJLp6p+0lGbbh6Uw1Si3K/FhHORHSgsQEsbiz51wohC4VNlcDUj84oBQ6jv
         1F4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687879502; x=1690471502;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A04KwW6ieNfH8wPX+bT+AUz62umM36e5LmdKIB4p2KU=;
        b=b//eSveVjI0L6YCMDeC6QsR47LkMJtbd5G5/lJ8X2FOZSwwMXoGOTQDHCCPBhc5T2b
         acVGjOYNaWNp0TJVf/8/QG80r9r7sDHDA3SXyeX111h8ujsbxAR55pReDedPn03Xnt0e
         WO5BsSXMV6em0Y5Jr4pf0GCCPHJNohFho8+agkVmSiuLtOScxorvfb2PCjz6l4qgdNcJ
         KVu7W8XLj5wa+hBVENyfu/DTZiJKq8qSSeQ88kAqPBDjodzONiK38SdUWtVmmdZjmqhF
         bC1F5/knGncy9QwIX5mwaYW2OhUVDQmJ2b3QkKoT+szVUFFcnWBZlDjuxXOiya06Zi0r
         JjZg==
X-Gm-Message-State: AC+VfDwuOZaUv2PiY4O277JodkSEtdgf/s7byWU+6QolkAXd0gVouchE
        OmRYcvrhci7tKF8vWXu6KAc=
X-Google-Smtp-Source: ACHHUZ4b7RXNKqghsTi/f+R3YVRZ/ld3bJiRzs7zvbbv0rU/xTija4QR1IMms5rxrd4qW/Rhub2g+w==
X-Received: by 2002:a17:902:8d88:b0:1b0:3742:e718 with SMTP id v8-20020a1709028d8800b001b03742e718mr5595430plo.25.1687879502173;
        Tue, 27 Jun 2023 08:25:02 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902e89200b001a5fccab02dsm5294252plg.177.2023.06.27.08.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:25:01 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] ipmi: fix potential deadlock on &kcs_bmc->lock
Date:   Tue, 27 Jun 2023 15:24:49 +0000
Message-Id: <20230627152449.36093-1-dg573847474@gmail.com>
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

As kcs_bmc_handle_event() is executed inside both a timer and a hardirq,
it should disable irq before lock acquisition otherwise deadlock could
happen if the timmer is preemtped by the irq.

Possible deadlock scenario:
aspeed_kcs_check_obe() (timer)
    -> kcs_bmc_handle_event()
    -> spin_lock(&kcs_bmc->lock)
        <irq interruption>
        -> aspeed_kcs_irq()
        -> kcs_bmc_handle_event()
        -> spin_lock(&kcs_bmc->lock) (deadlock here)

This flaw was found using an experimental static analysis tool we are
developing for irq-related deadlock.

The tentative patch fix the potential deadlock by spin_lock_irqsave()

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/char/ipmi/kcs_bmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index 03d02a848f3a..8b1161d5194a 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -56,12 +56,13 @@ irqreturn_t kcs_bmc_handle_event(struct kcs_bmc_device *kcs_bmc)
 {
 	struct kcs_bmc_client *client;
 	irqreturn_t rc = IRQ_NONE;
+	unsigned long flags;
 
-	spin_lock(&kcs_bmc->lock);
+	spin_lock_irqsave(&kcs_bmc->lock, flags);
 	client = kcs_bmc->client;
 	if (client)
 		rc = client->ops->event(client);
-	spin_unlock(&kcs_bmc->lock);
+	spin_unlock_irqrestore(&kcs_bmc->lock, flags);
 
 	return rc;
 }
-- 
2.17.1

