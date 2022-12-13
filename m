Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF1264B1A9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiLMJBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbiLMJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:01:08 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF3562E1;
        Tue, 13 Dec 2022 01:01:07 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 62so9966439pgb.13;
        Tue, 13 Dec 2022 01:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnZ14x+Cd+TEg+zucSh/Nr19nBP6U3yPYDLuptGj0yU=;
        b=qUTiEHNy4ETosFcpfvdfkl5YygjNK3pfz1KiVstmSGIsMF4rqVrBI60aPcZZqzkAPZ
         To8u7kWzviFjCrW1xbuoJG0FJjowUeDiVmzXW/5o5D1Zd5WJhZY3UbIsBr4rIWK++Rqf
         LjfQCn94uIEufBDNz+M6QH+aPXDO6nlxbWQzorcB6DaPSXZO4vaO50JTCHo+gozNSMWF
         JbnRQmDZcW8q0sr6YMiz3uVH96XQ9CU6Qng4xPM+hENqg9sY9UuqDRVgOske8Fzt5qsv
         847sAcQuNlDIuCUnWJMtQ4XbdSjIUH/gcGJJmqtFodZr9athZC9ZfmR6WDbYnsXx1Z6+
         Lguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnZ14x+Cd+TEg+zucSh/Nr19nBP6U3yPYDLuptGj0yU=;
        b=FbO5CrArAeTHbf+KXG81fVRcHKxxsn/smSaP/VhA5mqkQmI235zq4fl9rpu74nkEcQ
         f7xqWN9eQCBv8Pg86AOvBq+5cMhuuL7hJkXL4kp6RigxSS6j0KLBGkMJgeVHN/ropled
         ZFNOn4ibQx8hxuyGDRr638I1+/TonBymK13CGYrhfr5cDefgCf4eA4B91UQdN162QGfJ
         EmyXGVju1znfd8uVrqtXt4GePvDQK4DFGfKEIvQy0FX7oQju/ZAoLcs4sfpnrjzbj+fT
         jruhlHkkD/UNPOeToMJidaxN8BfgHN8iCUnmgrnOuJ8ZNaPUlNpbC6dIzI0LezoZNOKs
         uYKQ==
X-Gm-Message-State: ANoB5plt7wWqBNssT0x8ygYWub6lWCjO949ilqZv4/MZIa/rS2SOVdt0
        dSVDxn4+hmYqxve8D5du06o=
X-Google-Smtp-Source: AA0mqf7qQ2N1uaMw/3habB8PEWG5XLIVxsixMXxuZT22ZTgVqQLUZUV0DF661xBgdUW58HDO6QhK0w==
X-Received: by 2002:a05:6a00:26c5:b0:576:fb7c:7aa3 with SMTP id p5-20020a056a0026c500b00576fb7c7aa3mr18291570pfw.14.1670922067266;
        Tue, 13 Dec 2022 01:01:07 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2dc-5c03-264b-f684-a8c9-21ae.emome-ip6.hinet.net. [2001:b400:e2dc:5c03:264b:f684:a8c9:21ae])
        by smtp.gmail.com with ESMTPSA id 81-20020a621954000000b0056b9ec7e2desm7141682pfz.125.2022.12.13.01.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 01:01:06 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V6 01/24] mmc: core: Cleanup printing of speed mode at card insertion
Date:   Tue, 13 Dec 2022 17:00:24 +0800
Message-Id: <20221213090047.3805-2-victor.shih@genesyslogic.com.tw>
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

The current print of the bus speed mode in mmc_add_card() has grown over
the years and is now difficult to parse. Let's clean up the code and also
take the opportunity to properly announce "DDR" for eMMCs as
"high speed DDR", which is according to the eMMC spec.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/core/bus.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 36679f4e9acc..bbbbdbca5366 100644
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
@@ -337,25 +338,29 @@ int mmc_add_card(struct mmc_card *card)
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
+	else {
+		pr_info("%s: new %s%s%s card at address %04x\n",
+			mmc_hostname(card->host), speed_mode,
 			uhs_bus_speed_mode, type, card->rca);
 	}
 
-- 
2.25.1

