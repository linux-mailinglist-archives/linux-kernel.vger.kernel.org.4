Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C77573D318
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 20:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFYSzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 14:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFYSzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 14:55:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444821B3;
        Sun, 25 Jun 2023 11:55:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-262b213eddfso1320916a91.0;
        Sun, 25 Jun 2023 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687719346; x=1690311346;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+KezNnGcb3cxAVG4ZYOxPdXLpxML8OUkwIxVcdPDfCc=;
        b=GFbnr+PTf0Y0M2eichqIUCZzASI7tJUMkTdnjhJaO73A6sCajSAzUm21FyKKnABpGn
         wT2xhQcHKwpU6RrPltxsu1HvqxveAkCNpfMbEgzlD5bjeUcgSpWRnelD171KHMqlHg7k
         HLXs2l4INTaYguk2z3M5sHpukAPGi/LgVvvcCEQvzJYPNsPGTbPVUYKJJ1n1QvniFI9B
         E413LL+p/kXJ8KM1KarAQh6n7y82TP4GTnJ40O4u/+GBOFJeedKCP1PDU7u3mjKSxDI1
         /gkboUugt+pw1qbkDDWrvm5y9XvAvqAJChaOXkYPH7xVR3ES1r/a9KQZ/JJXoDCk/1CM
         QCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687719346; x=1690311346;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+KezNnGcb3cxAVG4ZYOxPdXLpxML8OUkwIxVcdPDfCc=;
        b=FNn2hhNvvkSMRxk/dHtsxQXy+7vmOVj68yzYEpo59K3iUw1x2nv6WDuVZcgioexf0y
         QTQ7oewxPKfNK1lMdTbhdg0rsXfvihnbm0UwMMT+PXs3+vDqesbUozWh+qlTZy1crerK
         ZBqnXj1FSXNPjlG9lKlQlKREsgKFPDhy6E3FGtur7A+OnxnUjOeRlg9LvwCJfq2Ws0zM
         pv21n6B9KaylO1myqXy7O5KrzN78OL4t5g3+N5cV6bor5WbW9KAw1KSkhJyiUV76yz4+
         yGwUWobKTVRdMksg90lEhipdLrUGlHEN4a8gnfzlHAn1l17zfiI+XCisaCCIyyWQ9OtM
         39EQ==
X-Gm-Message-State: AC+VfDwmQxyNfRHyZXaaMH/pLXsmYGc9d7p4gQHsGNXSTOSwv5C6MRIY
        lIUR96F6FRQj/7kIFZZ7rKkXI1QP+OezB7vB9K1N5q7v
X-Google-Smtp-Source: ACHHUZ64Zw+TZlko0Fyfe6ge9vjTWpBbW1JIvzPDMFlZfbIGVF3vx+whH886yalrOd5uQIs7Ne45Mxe/dahqlQqGGZ0=
X-Received: by 2002:a17:90b:113:b0:262:ec04:4ff7 with SMTP id
 p19-20020a17090b011300b00262ec044ff7mr1916194pjz.16.1687719346213; Sun, 25
 Jun 2023 11:55:46 -0700 (PDT)
MIME-Version: 1.0
From:   Uros Milojkovic <uroshm@gmail.com>
Date:   Sun, 25 Jun 2023 14:55:35 -0400
Message-ID: <CAP=xWk6GvVQxzTJ6jS2pQ9dKvgoFFHc=m4yMma101MGKgdcm5A@mail.gmail.com>
Subject: [PATCH] staging: nvec: udelay to usleep_range
To:     linux-kernel@vger.kernel.org, marvin24@gmx.de,
        p.zabel@pengutronix.de, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch pl alerts that usleep_range is preferred to udelay. The
change is made.
Signed-off-by: umilojkovic <uroshm@gmail.com>
---
 drivers/staging/nvec/nvec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 2823cacde130..8bb3b691d1f5 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -627,7 +627,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
         break;
     case 2:        /* first byte after command */
         if (status == (I2C_SL_IRQ | RNW | RCVD)) {
-            udelay(33);
+            usleep_range(33, 200);
             if (nvec->rx->data[0] != 0x01) {
                 dev_err(nvec->dev,
                     "Read without prior read command\n");
@@ -714,7 +714,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
      * We experience less incomplete messages with this delay than without
      * it, but we don't know why. Help is appreciated.
      */
-    udelay(100);
+    usleep_range(100, 200);

     return IRQ_HANDLED;
 }
-- 
2.34.1
