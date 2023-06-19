Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A15735AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjFSPKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFSPKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:10:08 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6D59B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:10:07 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f866a3d8e4so2630480e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687187406; x=1689779406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEaQN5x4Wxywu5DRGerlvVJNwGjReSSnSGgqsLpGfq8=;
        b=RPt8uIPW6Z1I8YsH+/4gGjf0coJJvCyrShdrTfreq02XGa44yMc4IRgwBtAIVfG7Sl
         qwMmN7FMMFw9wCZGht7sIWTqD9T+cFXqNqLVfiGkZcbsmFAC4eNxzTfJYrJoTADVa+cQ
         B9RdCqbWEDDEBrolg3fidkt+ooGT5anjwastHqnb6Eubr8Ff51O6/uuQ7FfSiiynmVHf
         +Azn0Bm82yG/+vPWJUtget0XUxX22Yt7lkfCUn5rCtd8CwBxfH4G4bEJZupfcXZZTFYM
         EUXWFnME/0fehi4NmXwkML8S63PbG3kKJxxvJ7hYnoSYHT8vCLzamjfXTfiuCXNm/opX
         JcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187406; x=1689779406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEaQN5x4Wxywu5DRGerlvVJNwGjReSSnSGgqsLpGfq8=;
        b=iHQiC/jv2S2O4lIL8WQobi9DTNRie7UBPwXpKxM4d5GCT15K1CWXAJbBGaCGSxm7ru
         MtyNmKhIp0wbEe985LkkcX8dV1s2b4xBETymzLYCKShsF9h4r0DPbsn07UOaUjaRuuWu
         gf+/KpS5XuBg2xyG797J5voHE7WrIf+P9VKafd9dgzm88e6t0cyUx4KYk7x+BJBzM0B8
         T6hY99bmmdIObcXX8r5daajN9MEsSuIg2Mh5tpL5REd3AougqaojmafWPRWRauCrW1n5
         cLfa3BWuQFYP5z6AHe/HR7dj8Qj0g/1f3G4mYmrJyW73rREMqZAaq04nD8OnkvC+LAxj
         MstQ==
X-Gm-Message-State: AC+VfDxecQCPo/vZuXTUWeMLXl4li/WXBMQaOtAM440Bb3mhPiH31E2Y
        O1co+LtxB+XkKyaV7h4m6J5p9T6hPGg=
X-Google-Smtp-Source: ACHHUZ4aQi79GTD852ryOqtRfHZUKyif4wukn1JIVkmcg7rnOJKoGWfxHwWWuUqgnv4t3SLFyR6k5A==
X-Received: by 2002:a05:6512:47a:b0:4f8:7494:17d7 with SMTP id x26-20020a056512047a00b004f8749417d7mr1260966lfd.59.1687187405320;
        Mon, 19 Jun 2023 08:10:05 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abbd5.dynamic.kabel-deutschland.de. [95.90.187.213])
        by smtp.gmail.com with ESMTPSA id p6-20020a056402044600b0050488d1d376sm13297186edw.0.2023.06.19.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:10:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: rtl8192e: convert else if sequence to switch
Date:   Mon, 19 Jun 2023 17:09:51 +0200
Message-ID: <20230619150953.22484-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619150953.22484-1-straube.linux@gmail.com>
References: <20230619150953.22484-1-straube.linux@gmail.com>
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

Convert a sequence of else if statements that all check the same
variable to a single switch statement. With a switch statement it is
easier to see what is going on. Additionally this clears a checkpatch
warning.

WARNING: braces {} are not necessary for any arm of this statement

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index a47614c837ce..7b3cbe28e562 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2830,15 +2830,19 @@ void rtllib_start_protocol(struct rtllib_device *ieee)
 	 * attempts does not fail just because the user provide the essid
 	 * and the nic is still checking for the AP MAC ??
 	 */
-	if (ieee->iw_mode == IW_MODE_INFRA) {
+	switch (ieee->iw_mode) {
+	case IW_MODE_INFRA:
 		rtllib_start_bss(ieee);
-	} else if (ieee->iw_mode == IW_MODE_ADHOC) {
+		break;
+	case IW_MODE_ADHOC:
 		rtllib_start_ibss(ieee);
-
-	} else if (ieee->iw_mode == IW_MODE_MASTER) {
+		break;
+	case IW_MODE_MASTER:
 		rtllib_start_master_bss(ieee);
-	} else if (ieee->iw_mode == IW_MODE_MONITOR) {
+		break;
+	case IW_MODE_MONITOR:
 		rtllib_start_monitor_mode(ieee);
+		break;
 	}
 }
 
-- 
2.41.0

