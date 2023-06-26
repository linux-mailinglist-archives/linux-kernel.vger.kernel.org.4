Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3291973E344
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjFZP1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFZP1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:27:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984DBC7;
        Mon, 26 Jun 2023 08:27:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b7ffab7ff1so6900885ad.2;
        Mon, 26 Jun 2023 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687793255; x=1690385255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DtF7Bv5SvW35SPc+Oj+N7Ltt+S4wZnjN/u3LXzV4SC0=;
        b=pIhMjoXIxis/rCCSFQxeFzMYPXL5eVCVKvB0keoDspMGy9J9aRDZhqckNe5MTqhnRp
         GgQiCHHZ9wq0B7dCJ9vqzSuk61K4vBy8wMKf1hFdBZ2Mz1ZoZcw97UQ5sUG+dLGm6k7y
         qKLoiEVMLAzDo64siF3ZD1546ng8FY9QODIqq2J4cHJnjZtxed4QAT1texovd9KW/Pw7
         /95u2W3GZLxLNKe3qvpiyVW+kjDsrcrAMepzt919i0R8GPxt0TrLwRmtWKqJ9aBlvtJp
         bQdnLAvaSTvTBabOQXFMhRwXeO397n3nrYTaHxyJ0z759Zol0cHmZjiIvBW1a1C0roeQ
         wrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793255; x=1690385255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtF7Bv5SvW35SPc+Oj+N7Ltt+S4wZnjN/u3LXzV4SC0=;
        b=h3z9iuCJA299OumKKM6oBN29B7bg2Glmw00DlGtn0NsGzwlkqqwi+NNwZstzN5vSuK
         iHNbOqU1ggyO2sROtSZ18BUfQyF6AIJf7WOq5BJ2Y0ruaJ/awzDAg9fqgt+MLNETEYcm
         LEFL1jlHrTrAV8x9VG2VwKKjowszCWS91z+SBlfY80uY9mafld1Eu35ey41NsHVHWLoK
         ceSIOQbo5jzfkZmQy+dAbTyCrly8ZsA0x9SXMiwC/2Y3fMdfvDQ+B96OHOPUFq1PhQ2t
         KUk7LbfE47UY0hClZlr2mnlhNJW4EqKhVfa9jE9FashIBfm5jDd19m7Ria092alYaoOQ
         jXRA==
X-Gm-Message-State: AC+VfDx15NZxVqG0CQsGvWvqxbsBRlKe8AL++Jy7soZVeObjVohdXIl1
        feVZJ5Yw/DJBCa24mne8Tz8=
X-Google-Smtp-Source: ACHHUZ6g0uPrJaai9JngmtxS8LEGJckoJ8+hnH+joZaWY6SyCdkbf1ED3bxVqkCCgVwQRpFnQRnquA==
X-Received: by 2002:a17:902:ce01:b0:1b6:9b29:bb1a with SMTP id k1-20020a170902ce0100b001b69b29bb1amr4243063plg.9.1687793254920;
        Mon, 26 Jun 2023 08:27:34 -0700 (PDT)
Received: from localhost.localdomain ([113.103.4.28])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902dac200b001a9bcedd598sm4368345plx.11.2023.06.26.08.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:27:34 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH v3] usb: ohci-at91: Fix the unhandle interrupt when resume
Date:   Mon, 26 Jun 2023 23:27:13 +0800
Message-Id: <20230626152713.18950-1-aarongt.shen@gmail.com>
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

According to the comment in ohci_hcd_at91_drv_suspend(), it need to reset
when resume from suspend(MEM) to fix by setting "hibernated" argument of
ohci_resume().

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
---
 drivers/usb/host/ohci-at91.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 533537ef3c21..360680769494 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -673,7 +673,13 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 	else
 		at91_start_clock(ohci_at91);
 
-	ohci_resume(hcd, false);
+	/*
+	 * According to the comment in ohci_hcd_at91_drv_suspend()
+	 * we need to do a reset if the 48Mhz clock was stopped,
+	 * that is, if ohci_at91->wakeup is clear. Tell ohci_resume()
+	 * to reset in this case by setting its "hibernated" flag.
+	 */
+	ohci_resume(hcd, !ohci_at91->wakeup);
 
 	return 0;
 }
-- 
2.25.1

