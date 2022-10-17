Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920686009FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiJQJMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJQJMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:12:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850CE2192;
        Mon, 17 Oct 2022 02:12:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so13652462pjg.1;
        Mon, 17 Oct 2022 02:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0jM/mUgD0JOQwQmZNoiPwNFGZczmcozFW6ZNuUqVKE=;
        b=JwccgKqx/rfzefXegWsoG2Houuy8cuhPSOOz31K/GblqO475U+7oVPzGlK3jtkLaet
         JNh+lt8/P88f0kBOjIwCcibUroljzY9y/CIq00Q3Hw40wJjknuuh1JLJ3XkwDKzyy+6U
         tsYqUC2S2EYB+c2CdFdfEqQyjPgwmjQSdvGxEGhPW8SThGyvRzYDS3NPfmhxq8vGpLTn
         2xtzyxvVAPJ5JPXcSzjuiFOQJiSNAHkLdl1HL4hCwGD2i9M9PIboqgNKZIZj8wPmsj8D
         Z3M5c9TxruQWZvrV7+eDam6Bv5dwfD6JpUI9AHprB4N8K6wLwJ5b2X4yWxQGiF9DAhMR
         /Xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0jM/mUgD0JOQwQmZNoiPwNFGZczmcozFW6ZNuUqVKE=;
        b=YaQeaHKig6Crcrh04TluJe1GkCpHcLkx6l/0uy+v1GurnujN9vaESRrnJusVQoP0bd
         Ay986/4fusI4y1Jz5ca11vixAX5GPHCDCAtWS4sjT/wTRd8hukrLEH21EAW1KV/ZoMJX
         tg7czajGyy8lL7gvyK2+IKtE9i7MGDOuyV1+rnVxErGp6RDdwN3M7WVn1kIY17qdcNl0
         TJobZQBR1y+ixK8pRb0d9rrj1qV+atuM4DbS7n4UkaMTg96dvi5rv5sAyPaS27xqQcs7
         rX7KRQN8mMoYeqKsKVGNR9b8RBoq7fDyKoUxWRoGHAdPf2fDByDkLw+RBHWeg1cZsqlm
         q9Ww==
X-Gm-Message-State: ACrzQf0oR5YpF8N4lviflpid9nEhIPO1N+R7B36d75PmzNKDPtFLHuCf
        8a8x2vOxxvJg0wh9EUhGcH28Rm8pUKg=
X-Google-Smtp-Source: AMsMyM6JI3H4VVDZC9jOKN/aFOcwUYKj+HaN+pz3BzhyYu1fozuUW/sAww1NSNnCVVlcE2Xn7CuHVw==
X-Received: by 2002:a17:902:8b83:b0:17f:5de5:c5ff with SMTP id ay3-20020a1709028b8300b0017f5de5c5ffmr11377668plb.52.1665997932026;
        Mon, 17 Oct 2022 02:12:12 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-4ca3-4989-34c1-7890.emome-ip6.hinet.net. [2001:b400:e258:8c34:4ca3:4989:34c1:7890])
        by smtp.gmail.com with ESMTPSA id t22-20020a170902b21600b0017f75bc7a61sm6091996plr.166.2022.10.17.02.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:12:11 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V5 01/26] mmc: core: Cleanup printing of speed mode at card insertion
Date:   Mon, 17 Oct 2022 17:11:28 +0800
Message-Id: <20221017091153.454873-2-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
References: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
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

The current print of the bus speed mode in mmc_add_card() has grown over
the years and is now difficult to parse. Let's clean up the code and also
take the opportunity to properly announce "DDR" for eMMCs as
"high speed DDR", which is according to the eMMC spec.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index d8762fa3d5cd..088ec34299c8 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -299,6 +299,7 @@ int mmc_add_card(struct mmc_card *card)
 {
 	int ret;
 	const char *type;
+	const char *speed_mode = "";
 	const char *uhs_bus_speed_mode = "";
 	static const char *const uhs_speeds[] = {
 		[UHS_SDR12_BUS_SPEED] = "SDR12 ",
@@ -337,27 +338,30 @@ int mmc_add_card(struct mmc_card *card)
 		break;
 	}
 
+	if (mmc_card_hs(card))
+		speed_mode = "high speed ";
+	else if (mmc_card_uhs(card))
+		speed_mode = "ultra high speed ";
+	else if	(mmc_card_ddr52(card))
+		speed_mode = "high speed DDR ";
+	else if (mmc_card_hs200(card))
+		speed_mode = "HS200 ";
+	else if (mmc_card_hs400es(card))
+		speed_mode = "HS400 Enhanced strobe ";
+	else if (mmc_card_hs400(card))
+		speed_mode = "HS400 ";
+
 	if (mmc_card_uhs(card) &&
 		(card->sd_bus_speed < ARRAY_SIZE(uhs_speeds)))
 		uhs_bus_speed_mode = uhs_speeds[card->sd_bus_speed];
 
-	if (mmc_host_is_spi(card->host)) {
-		pr_info("%s: new %s%s%s card on SPI\n",
-			mmc_hostname(card->host),
-			mmc_card_hs(card) ? "high speed " : "",
-			mmc_card_ddr52(card) ? "DDR " : "",
-			type);
-	} else {
-		pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
-			mmc_hostname(card->host),
-			mmc_card_uhs(card) ? "ultra high speed " :
-			(mmc_card_hs(card) ? "high speed " : ""),
-			mmc_card_hs400(card) ? "HS400 " :
-			(mmc_card_hs200(card) ? "HS200 " : ""),
-			mmc_card_hs400es(card) ? "Enhanced strobe " : "",
-			mmc_card_ddr52(card) ? "DDR " : "",
+	if (mmc_host_is_spi(card->host))
+		pr_info("%s: new %s%s card on SPI\n",
+			mmc_hostname(card->host), speed_mode, type);
+	else
+		pr_info("%s: new %s%s%s card at address %04x\n",
+			mmc_hostname(card->host), speed_mode,
 			uhs_bus_speed_mode, type, card->rca);
-	}
 
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_card_debugfs(card);
-- 
2.25.1

