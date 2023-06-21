Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE9E73821C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjFUKDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjFUKCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:02:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AD71FE9;
        Wed, 21 Jun 2023 03:02:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666edfc50deso3059408b3a.0;
        Wed, 21 Jun 2023 03:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687341728; x=1689933728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAj0e8JoXzHhlsLLqu6YTeFIF4wjRxOs4Y3AewMm+Vk=;
        b=lLoXcLzoI8VWYVJcdRLFG7LDZ86q+eZharxLBDXGC0mLFt8fCNymgd9eqDlHALfxXq
         p2uXcwAdO9tRruQGX1M47DhhzyJeq5N13MuSZk27mFfd8rr5Xb63Aa44QdupmTdeDotC
         8P4zQx21fS35ct+axu9Ri/iRFf5XsiM3YoLT/xVectDz6ME5+bY0c2YZQGR/EgYQlHGq
         b4wOTCIkufY8y6A+jq201u63dQzGKs8DlQLRt8+h/82+yMu1Y8Dhl30ewo0yjoXDA+ED
         HjR8lZOag9DDSU4t9XDAanQlUB2WPrmnrjmK0FqLShlTA5DO0CbRxnkFn+g+10JfxQvo
         pkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341728; x=1689933728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAj0e8JoXzHhlsLLqu6YTeFIF4wjRxOs4Y3AewMm+Vk=;
        b=N/kb8lrSEbqrXNLAvMBwZPiCz1Otu+ga+4vPBfQMCMraU/hEE5Ar3rSVyAUsOzDj0t
         oMw71Mg7YPbDTI9P3yDv66Bfm7brCnZT/YEP9Fm9yAWtEN9UvpU4KVyIcnfTra/bio/t
         /DLhBjFqKriwgflJpKCZkubcO7MRJ9gaI8rmKU7j46+fdsbr7rXC0hb/dIr10usMOnVI
         U6V8DM/MpQRcVG1XgYK79xlj4EZrXrejTudGX/gYkzLMToQgOKwAtisQ4LA1LnxI5Jbf
         zhv115rLRQIhBOG5keNec+vK5v36b52KspdUAkFBZbZkdsb2bH/LgKX+XSs2m4LLn3cy
         XjJg==
X-Gm-Message-State: AC+VfDxe/mzMI/D2oV+OQq15iFbXdjjsfCCQyfbAkNef/pz9ai/BIzzN
        IW9v0555phoXey+fEt3sWRQ=
X-Google-Smtp-Source: ACHHUZ5eW66VorL0KNfw72onBR0W6lOsS6k81s4xQjvzUfNX7hFaHk3wBHr4omhYPM/EGi4heV1QIA==
X-Received: by 2002:a05:6a00:1305:b0:666:c1ab:d6e5 with SMTP id j5-20020a056a00130500b00666c1abd6e5mr18937550pfu.16.1687341727716;
        Wed, 21 Jun 2023 03:02:07 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e254-4eda-2716-05ea-20f5-b048.emome-ip6.hinet.net. [2001:b400:e254:4eda:2716:5ea:20f5:b048])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b0064f46570bb7sm2611196pfo.167.2023.06.21.03.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:02:07 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V8 03/23] mmc: core: Announce successful insertion of an SD UHS-II card
Date:   Wed, 21 Jun 2023 18:01:31 +0800
Message-Id: <20230621100151.6329-4-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230621100151.6329-1-victorshihgli@gmail.com>
References: <20230621100151.6329-1-victorshihgli@gmail.com>
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

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Update in V7:
 - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A in
   mmc_card_uhs2 function.

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
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/core/bus.c  | 4 +++-
 drivers/mmc/core/host.h | 7 +++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index cf32cf135781..d9a3b3d38d8b 100644
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
index 48c4952512a5..9f6e5e31dfea 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -89,5 +89,12 @@ static inline bool mmc_card_sd_express(struct mmc_host *host)
 		host->ios.timing == MMC_TIMING_SD_EXP_1_2V;
 }
 
+static inline bool mmc_card_uhs2(struct mmc_host *host)
+{
+	return host->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_A_HD ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
+	       host->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD;
+}
 #endif
 
-- 
2.25.1

