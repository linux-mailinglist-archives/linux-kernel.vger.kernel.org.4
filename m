Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732A760433C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJSLcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiJSLcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:32:35 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F181BB94A;
        Wed, 19 Oct 2022 04:08:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h2so9558909plb.2;
        Wed, 19 Oct 2022 04:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0jM/mUgD0JOQwQmZNoiPwNFGZczmcozFW6ZNuUqVKE=;
        b=qVt1Rs8rcWdXExyvaRr9F805wEuRAdpZb1glKhjuw9qbyZODXMk9ZTzPCUPtpq3H2k
         XWRcPkMX3B+SNM5u5WfoDlOQsOrom4Fn22YA/LpPEITtRLrVz3oVHzgq2DtTNymNncwg
         TAzXENliIo/JN+/uyrLTwR6JfLE9kbpFo9bS0qtYs8qcuXvSwyPRILSYulvbmsFCLJ0T
         XzSx4hxujM6itO9TnFVmW0YpbaFRpoIkhCLtGmlIaACznPJ+aaesk631i4DSA5qOVEVB
         69VakORCGFlN/GuU4Wd6bcXgg3Oxx/2eNig88QLTZe/kULFTpaW3nH8TcYAOW1LIvjhI
         /KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0jM/mUgD0JOQwQmZNoiPwNFGZczmcozFW6ZNuUqVKE=;
        b=AOGXYTr6ZS6BAXjTjH+kCh6s00mOKi2d2MQaU4QBMiNoXShkyEnJLTtiYUbdww3qov
         V0HOEQEpiDWnzw6fRhkYBPTNeK+g/jeRJJpm6dZ2DCgYge41jgmFsEm0zbwiND6c8eeW
         KSkDLKnuhUcIR3wTNTaCXJUaEabY/jMDlLj4oDPgEMeRFeDl06DvLUE+x7LkYPf+QaMA
         ZEtbwNYWrCxqmGOh9Wtz8kRonrVz6iA+mSVJnmyKHtBiL7ibZ1qvmHgcAfVBzXsyoGIX
         Cdjts9CrXMGtJUynK1Z0SUc7AdeLbtXFfbbhrLgjgke89Aom12bq4wUbYqME3OkAtTFr
         qJdQ==
X-Gm-Message-State: ACrzQf1oQXvu5GpXVVwUPilbvrUARGtFM/bxCixh4E5jUsuAmeojV8eI
        h0cmXVwLugPtYx2gNsffuR8=
X-Google-Smtp-Source: AMsMyM67naJ6SV8zUx4iz93Fs9P9bWuVp+kVYWWlVnbi+KuZepmzArnZy05QBrIU46P0iVCjo0/WhQ==
X-Received: by 2002:a17:90a:8c97:b0:20d:a1a2:bfda with SMTP id b23-20020a17090a8c9700b0020da1a2bfdamr9122300pjo.234.1666177619120;
        Wed, 19 Oct 2022 04:06:59 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-821b-9613-557f-bd8d.emome-ip6.hinet.net. [2001:b400:e258:8c34:821b:9613:557f:bd8d])
        by smtp.gmail.com with ESMTPSA id cc11-20020a17090af10b00b0020dc318a43esm8696225pjb.25.2022.10.19.04.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:06:58 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V5 01/26] mmc: core: Cleanup printing of speed mode at card insertion
Date:   Wed, 19 Oct 2022 19:06:22 +0800
Message-Id: <20221019110647.11076-2-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
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

