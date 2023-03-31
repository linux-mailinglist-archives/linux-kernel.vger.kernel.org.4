Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908E06D1E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjCaK4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjCaK40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:56:26 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADFB1EA0B;
        Fri, 31 Mar 2023 03:56:15 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z19so20883212plo.2;
        Fri, 31 Mar 2023 03:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680260174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57+Q3zgUW+vus6MufB9IOoUHGrT/XyfGfE6odShrlgU=;
        b=qTHZTx92EJRF6NVQOJCdZho24EEOslckI6CvV+V8nsg4XBXvZ7KAuM1B2FwaL5MAP3
         +s9TDsx+P2/+6sGRoMD73EOyV/5CedDlQ8hbp8cEDXxbVnRzNgtTOAIRblWk2nJvXgyn
         vWSwxT0pXtxb2JzbNxWLiUWnkANduf/+hRp6Hl9Wd4eXhofPH+c2Ojr7I8l95YxAgYqO
         G/2uoUs5v0VSYn3NMCwnCDFcrQnpDZMyZqge6Y0foFMIBS96tW0Vir5C4MV3mvnSsGjK
         JBeysyraJNU+WAYrJUNuSPACLYKhRekO/UApc17zps04GR4fHG6a0Z/I8m8g59opiqHT
         Hovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680260174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57+Q3zgUW+vus6MufB9IOoUHGrT/XyfGfE6odShrlgU=;
        b=qohyz4ljGiW0iA6VMo8JMDMQzaASgMlXxoEaRW8TrpKPE7EBGiQTPWg9vikEsT2+zm
         SPirt+spmJb540Vba78is5B0jAfNJ/yMEcD645Ef5IhopRqVMvKFQqj+Znhn7vXkxpIj
         H15yp34kRqbDLYgi+LLH8V/ICsofb+qmvY2uWHjpL/QOa3nSGVk8Gwx1FTXDkaL+YRix
         McaXV7wDcRH/DLAbilh0VH9NyyhSYsyNxnCT2vbl5dr6yGQWYjhMoH3wGFxFD7kfGBw3
         Rnz+0ao2Xs4pUaUl7oQIHfeQGleEZLaPVP9mdSo3joBrUP03VYAPTjYpoHaTvHBDhsym
         0KRg==
X-Gm-Message-State: AAQBX9ekg2IoGR+4IHcJ7bCZdA0J9gB10DZyJZdze8l4mZFvGRkhMF9z
        hgUxXBeYVsE9dt1VJqaaBFM=
X-Google-Smtp-Source: AKy350YHduVKXRju8Lq3oA9oBYp9IbB11VUr1/VNHraEFBR68SH7Y3DRb73j6CgQS2YC/2dLygbOMw==
X-Received: by 2002:a17:902:e5c7:b0:1a1:be45:9857 with SMTP id u7-20020a170902e5c700b001a1be459857mr31113011plf.1.1680260174516;
        Fri, 31 Mar 2023 03:56:14 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-983f-c7ff-3efd-77d9-6c16.emome-ip6.hinet.net. [2001:b400:e25c:983f:c7ff:3efd:77d9:6c16])
        by smtp.gmail.com with ESMTPSA id f19-20020a170902e99300b0019acd3151d0sm1287665plb.114.2023.03.31.03.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 03:56:14 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V7 03/23] mmc: core: Announce successful insertion of an SD UHS-II card
Date:   Fri, 31 Mar 2023 18:55:26 +0800
Message-Id: <20230331105546.13607-4-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

