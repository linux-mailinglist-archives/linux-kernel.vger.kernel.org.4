Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285D964B1AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiLMJB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbiLMJBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:01:15 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224F0F02E;
        Tue, 13 Dec 2022 01:01:14 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 36so3062681pgp.10;
        Tue, 13 Dec 2022 01:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzyMjrzMGxa/F0kJlX9UhW9e9/tXGWF/5HYdrk5JCcw=;
        b=c7qHtaWDFJSSeLTu+g4gi4qiNcnIB/XU+cmyxqm4GfzvF2eyPpAAapSKEvexdqdcOs
         EgEgUbIFlc2lo72F/hO9GJPq2JpUB4iM5D8mAfykXx7gXUui39d0dUyiZzI/J8EPbT2y
         pk/h0A847WDMlhoQq5T0l9PWUshxUKXZDg99kf+XrCfuMnnzriMOo48Rzya0GDYA0O/s
         I/2dE38d91Syf+wACem6cp/55zqDvU7OZi2tzOVdqwSHjI/v9hkssuumhIF3C8u9b055
         SG4wGOKfHsDCa2YCxXF7daCKeRqaxj915/ZSUiRL7Ma4/EvcaDUVw+iA1IDgtuciZA2I
         WDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzyMjrzMGxa/F0kJlX9UhW9e9/tXGWF/5HYdrk5JCcw=;
        b=Qr43Qf4uMavfqYFi13la1oB4OgKo/puFy9mHvLMtImL5zO4W65U5SsDyluMKfzsAS7
         6dN4awo9WMdwxYxcYgVZ8HIl4nm7CtxaZJi7mQBRGHUd+EbS4sFq4PxFAFSenvhUrONJ
         lsExWhlAfGT+gTjnq2uD4gwPjBu8jqF0jpTgmtBYXhbOlpDZoBOSTJklZuzptuT8JULW
         1z4hVsotuZKTNkVTfCW9jL9o6d9F7/wckaE3WOPZysPALEQGhkoUU/GoU2TkfYik6u79
         V7l9RsjN28beQOUv+ScOlRo4mmIt0zijQX2s35pXFA/U1vvnVnM0Ygf/NZ2owO6O2Kwi
         Q3yQ==
X-Gm-Message-State: ANoB5pnpMpTJiQ4J7LMdO+bh3cMIFl36Qs9eVbJlP13sYyBC/P/6aC2N
        rW+VjH+9IvBCTl2LSjtRAaPrfbsSaldzAw==
X-Google-Smtp-Source: AA0mqf5i8OGkItQW+fQKKSAc38GADT0UP+JfY/AahuhDYDTit3OnRVpRbrGphGoZDc07XNk2BpGE6w==
X-Received: by 2002:a62:52d5:0:b0:577:6525:fc98 with SMTP id g204-20020a6252d5000000b005776525fc98mr19540945pfb.3.1670922073697;
        Tue, 13 Dec 2022 01:01:13 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2dc-5c03-264b-f684-a8c9-21ae.emome-ip6.hinet.net. [2001:b400:e2dc:5c03:264b:f684:a8c9:21ae])
        by smtp.gmail.com with ESMTPSA id 81-20020a621954000000b0056b9ec7e2desm7141682pfz.125.2022.12.13.01.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 01:01:12 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V6 03/24] mmc: core: Announce successful insertion of an SD UHS-II card
Date:   Tue, 13 Dec 2022 17:00:26 +0800
Message-Id: <20221213090047.3805-4-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Updates in V4:
 - Make mmc_card_uhs2() take struct mmc_host* as in-param.

Update in previous version:
To inform the users about SD UHS-II cards, let's extend the print at card
insertion with a "UHS-II" substring. Within this change, it seems
reasonable to convert from using "ultra high speed" into "UHS-I speed", for
the UHS-I type, as it should makes it more clear.

Note that, the new print for UHS-II cards doesn't include the actual
selected speed mode. Instead, this is going to be added from subsequent
change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c  | 4 +++-
 drivers/mmc/core/host.h | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index bbbbdbca5366..c8d51fc7d5bb 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -341,7 +341,9 @@ int mmc_add_card(struct mmc_card *card)
 	if (mmc_card_hs(card))
 		speed_mode = "high speed ";
 	else if (mmc_card_uhs(card))
-		speed_mode = "ultra high speed ";
+		speed_mode = "UHS-I speed ";
+	else if (mmc_card_uhs2(card->host))
+		speed_mode = "UHS-II speed ";
 	else if	(mmc_card_ddr52(card))
 		speed_mode = "high speed DDR ";
 	else if (mmc_card_hs200(card))
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 48c4952512a5..ba6a80e9b360 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -89,5 +89,9 @@ static inline bool mmc_card_sd_express(struct mmc_host *host)
 		host->ios.timing == MMC_TIMING_SD_EXP_1_2V;
 }
 
+static inline bool mmc_card_uhs2(struct mmc_host *host)
+{
+	return host->ios.timing == MMC_TIMING_SD_UHS2;
+}
 #endif
 
-- 
2.25.1

