Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2594973D209
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjFYQQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjFYQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:16:13 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505D918E;
        Sun, 25 Jun 2023 09:16:11 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-66872d4a141so945316b3a.1;
        Sun, 25 Jun 2023 09:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687709771; x=1690301771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D0lDnChJx3uU6azmWebeFvx41PSoyDt49evO4AFiEPA=;
        b=K2X3Y0Cg4GQfrBLsBV6d6vgTckaV/4LGU2izcIcoWNarMLF3GUmw3I7fv7Xbmwb6U6
         2M7AcMU7WIQWTw0j9DOZJK7QklX8eCSDZC/bvbDUIYuWw8jyfFrXm6Ua/qOWPxAUL3yv
         ev0ys45Dzt4dMuR9waRg+Mp/wW2E5xLL+UJY8qgPnjZVy6x1EAz+opbgqE02rtx8TLkn
         CN3D1F5KResE4VeeHZq1AnAgGwl5hxTW5whwy9eZWncijMm6Ai9/ZkMUy7lm7YExHh12
         tsrQX9p8DqF9O7TAgQZwcIK+fRoMFLqEE6P327ouojy0Jdq2/oW5tOKXgor03AWZeLxl
         cIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687709771; x=1690301771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0lDnChJx3uU6azmWebeFvx41PSoyDt49evO4AFiEPA=;
        b=guk0NSx9UeSeu29RPVSKdIsRHZDZXzkUJe8s7B/aZuV0PCXw79zBnQjPekqwMYaOsQ
         RL+lZJFhB5sJ8twmp7jHS8Lmi+qU81sMLdl/UWgk/R1MW9DMhewA9rz5MtNyH1Fg8LOu
         hnl0x8DrfZQvdJTag4HoDdoJ+fxqL5VU9+IkFvEop1AJQfMtzAjqpGO+bQit6m/antSm
         AGBBugTPfcq5plIVsXtxB/UJu4I/wMRzXpithZkHnsv42bLpFd9QBPbe9I5bNCnOMwpQ
         X+w//OYUrlwW8rb2zdQpat3FEhj65FnS4dIcLV8TQJ/10wrjua9XPt1cxj14J7KkPjxU
         YPMA==
X-Gm-Message-State: AC+VfDwp585VgbIOqD8kWCA+3TsbILUiMZFFO8fqHS2RQMeDccdaS/Ze
        3TV17vDPFWB3ioAnPGY8UfE=
X-Google-Smtp-Source: ACHHUZ4luRJDbj8rI4UE0s4bWy2sMzO7YLRMyd97jHiUFaJNmmO3JDskfrKHHbwg3caI3kHgRocLYg==
X-Received: by 2002:a05:6a00:2282:b0:66a:3eb5:92bf with SMTP id f2-20020a056a00228200b0066a3eb592bfmr11483551pfe.16.1687709770632;
        Sun, 25 Jun 2023 09:16:10 -0700 (PDT)
Received: from localhost.localdomain ([240e:3b4:d0:6750:b853:cf8f:2208:c89a])
        by smtp.gmail.com with ESMTPSA id g6-20020aa78746000000b006749c22d079sm948312pfo.167.2023.06.25.09.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 09:16:10 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH v2] usb: ohci-at91: Fix the unhandle interrupt when resume
Date:   Mon, 26 Jun 2023 00:15:53 +0800
Message-Id: <20230625161553.11073-1-aarongt.shen@gmail.com>
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
when resume from suspend(MEM) to fix.

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
---
 drivers/usb/host/ohci-at91.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index b9ce8d80f20b..1a0356d9ea15 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -672,7 +672,12 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 	else
 		at91_start_clock(ohci_at91);
 
-	ohci_resume(hcd, false);
+	/*
+	 * need to reset according to the comment of suspend routine,
+	 * otherwise the ohci_irq would skip the interrupt if ohci_state
+	 * was OHCI_RH_HALTED.
+	 */
+	ohci_resume(hcd, !ohci_at91->wakeup);
 
 	return 0;
 }
-- 
2.25.1

