Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE776A798E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCBCfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjCBCfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:35:13 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F7E3BD95
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 18:35:13 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h3-20020a25d003000000b00a1a201a745aso2601795ybg.22
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 18:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677724512;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=caFgStrTuySjAQcmvmwnTSRJEM4Rl3g/SRMkznV97d8=;
        b=iY8Jh2kRo29CB7vA8hyuykn4S8nQHPN2KKKIjOyaG75XwivUDLy7g6fX1TNcCdNfwb
         Y+t1Sy0aulmA1tVRWscaVXEek1xrr4gd4a3hEjifTotPlt5Af2XyscpbvGxgj6FZBp1O
         ozIYFehno9Grehq4PJPMlK7VPjkil82KaCz+AHGmF4aUGPQcI+LD88tjvjmJWzxgerYr
         djV4+ezic/RZhbrrLzFPa2vnUm4Z51Ds6IhEV+1REBMcmEOFjo8Uh9a1mSiHvfsI5mpq
         hLyr0tfELWJzfcSi5s78jgjDPDllEudvMk3atr1WpAdJVQUfbjhQ/wyyHYplo9RB0Jz/
         nquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677724512;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=caFgStrTuySjAQcmvmwnTSRJEM4Rl3g/SRMkznV97d8=;
        b=OZwPO70cT+I2o/yI5LV4P9JqRw61yLWgsvnid5VLsGSuiBGoKKhLBKce3Ak2aoGrDv
         daTBPEUbt6SpXLkiVNyXidJCeWEOSoNwivooNzlL8Espio2OlAnFP0bcYfLTBP7VIHTr
         LrCWhTHqIT4ueuHOzkDBJvTX7iXjSLzIedp8r6PuAfj2K2+A9rJ1unwWn2/PnzDpjP2T
         CiyvstVpOcK3f5i5xtUpFivZm0T8auNw0G05tVbtAQX2X3Z9hguRSQy22UE0YxjoH45X
         r2raBFVPFowuFSYgb2tRYfUUzYNtEEoWWWTPqAL7q3Si63FNrEA3nyQbA5r2AMf119/Q
         bD0Q==
X-Gm-Message-State: AO0yUKW3vFEl+B2cTXuxWB7AwlP3iMaCeGqXwCB2FhS/gIM/3tMRaUbE
        IWFgYip4p87ECmRXm+dHtI9eRpiLw1Qn0gA=
X-Google-Smtp-Source: AK7set/Hv+rH5hBk60nAMaxloM3SlgNfaFtK67uEGAQpoRWIHi0ABy3iw5mGbd1AwDypVrqmmHn/62tQ/dI1M5s=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7e6c:b66b:c51a:b6ed])
 (user=saravanak job=sendgmr) by 2002:a81:b305:0:b0:536:155a:b73d with SMTP id
 r5-20020a81b305000000b00536155ab73dmr5460494ywh.2.1677724512316; Wed, 01 Mar
 2023 18:35:12 -0800 (PST)
Date:   Wed,  1 Mar 2023 18:35:09 -0800
Message-Id: <20230302023509.319903-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1] serdev: Set fwnode for serdev devices
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        kernel-team@android.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allow fw_devlink to do dependency tracking for serdev devices.

Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/lkml/03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com/
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Florian,

Can you give it a shot and a tested-by please?

-Saravana

 drivers/tty/serdev/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index aa80de3a8194..678014253b7b 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -534,7 +534,7 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
 		if (!serdev)
 			continue;
 
-		serdev->dev.of_node = node;
+		device_set_node(&serdev->dev, of_fwnode_handle(node));
 
 		err = serdev_device_add(serdev);
 		if (err) {
-- 
2.39.2.722.g9855ee24e9-goog

