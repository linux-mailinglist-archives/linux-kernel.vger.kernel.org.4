Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351E67395A6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjFVC5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjFVC5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:57:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B172C171C;
        Wed, 21 Jun 2023 19:57:48 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-54f75f85a17so3608421a12.0;
        Wed, 21 Jun 2023 19:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687402668; x=1689994668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=baRINIxlSWtAcWNB0GnBkwJVhbIeRDHzK+M6uQUBCxY=;
        b=UiHan2d1ePk+GkYMfi1riVe8TWvV+IgmOiBYEV+MdEsZRGhtYq2xL3blysO644ApQb
         8sgv7LM2MzIRD9tu9zok8gypjqlwkaTtx4cg4r2cjrmUcwuPeos5IIpMYU2K2M5sd3Tu
         7/4wuBrUr47rVeE6FJtglmeIx+ZbX2HEd4JRWGe1GMEYnJPuoHfgTfkmvDgb9tBlx+2j
         4aIobbKx5Xa1vnBaQb5C+SXxzdxkQ7Bc1zisrRQ7gXInIamZSIhcFL25pU7iy3ym2z6k
         D51wqdh4F6C6yFYvFyrwRuq5kG2t4v8MDzV6gwCpm0R9t1gj0YH1F8lgZPapEOLCsnUN
         7aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687402668; x=1689994668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=baRINIxlSWtAcWNB0GnBkwJVhbIeRDHzK+M6uQUBCxY=;
        b=BfOuVSAOxbIjzu2KFt2aQjAv8zjyz3tqlrTuPRU/Al4n70hKpjM8XIW15udzQCDDqj
         HqPMo+Uz9EF2OBa9QKUxLiWWnsy8ZbTm4/MkMKj6A7wQuC37QFybwVNON3HzCA3TCeRO
         N5Mvr4WAea+ISWmalJ1VklZGcZiBg3NWHMp1TNkiVDKxL9FWFlLqXtzKhF62Es7N3BlU
         qQzKlxaXFYHpufdZwiVEIwDoGJoAFlaXnWxgRggMf9q9TJuhQaO7OzIXjVZ4ISZcBB6e
         0BDbeu1fi1+k6GOxpsH77waH7uF5P6tx6oR5b6XiKTNbMPYPHVeopi5sXjUPttq/LMie
         tFvw==
X-Gm-Message-State: AC+VfDx1+pN5q2wnw6R2jIvMwnIgkLwzkvUf/c+F/fUfMgYNirhlgyJw
        q0mnC5cAP+xI7nM0PU+msKWMUuLwo9t6UpfVdAk=
X-Google-Smtp-Source: ACHHUZ5WmLGa0KabM5PrJGqArh26LKaN/KvGk3iNwbGJKvW2iChEEaIElSh9lOhtptkWEdlzaNwpaA==
X-Received: by 2002:a05:6a20:394a:b0:121:b1fc:1a48 with SMTP id r10-20020a056a20394a00b00121b1fc1a48mr9291508pzg.3.1687402668160;
        Wed, 21 Jun 2023 19:57:48 -0700 (PDT)
Received: from localhost.localdomain ([113.66.180.22])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902b94800b001ac444fd07fsm4154020pls.100.2023.06.21.19.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 19:57:47 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH] usb: ohci-at91: Fix the unhandle interrupt when resume
Date:   Thu, 22 Jun 2023 10:57:39 +0800
Message-Id: <20230622025739.13934-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The ohci_hcd_at91_drv_suspend() sets ohci->rh_state to OHCI_RH_HALTED when
suspend which will let the ohci_irq() skip the interrupt after resume. And
nobody to handle this interrupt.

Set the ohci->rh_state to OHCI_RH_SUSPEND instead of OHCI_RH_HALTED when
suspend to fix it.

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
---
 drivers/usb/host/ohci-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index b9ce8d80f20b..7a970e573668 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -645,7 +645,7 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 	 * REVISIT: some boards will be able to turn VBUS off...
 	 */
 	if (!ohci_at91->wakeup) {
-		ohci->rh_state = OHCI_RH_HALTED;
+		ohci->rh_state = OHCI_RH_SUSPENDED;
 
 		/* flush the writes */
 		(void) ohci_readl (ohci, &ohci->regs->control);
-- 
2.25.1

