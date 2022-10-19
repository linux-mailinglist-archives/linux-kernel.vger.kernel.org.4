Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7B60433E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiJSLdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiJSLcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:32:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884071793B5;
        Wed, 19 Oct 2022 04:09:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p6-20020a17090a748600b002103d1ef63aso235382pjk.1;
        Wed, 19 Oct 2022 04:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgpjV9k83EmC3yQ4DvMrLoo12ich9kue84KtDrunu4g=;
        b=J1J45nL9VHWciVy+gBYlYuMRgFIXJlOLtAIkWKZIrmOA5Z8Ocm+rVCD69f0Lr5n0VY
         OHBs/xb0KiYZJbXKUG/KphC5mh0Q1fNd9WHKlzn2bZjsz1ZadbLaOe5BVxKk1T91zGi2
         wnzxKHpgeKq/OdThulZSMbgjTb0fYlgydtJuxbnK2HbmtmdtUyYi3gDdVs7oQ/hGHVfC
         1RhAvTn0cnCo9OIg473/mkv7kCeBSvwZ5sm+plHrm9RezFZdLvBBLMCuxfyX+A9sB4cJ
         zRr3ML1j2gcQgRpD/ycl1OdRN1Sg3U1zHeDXfddJ0wM7a/gQl8FOCF6cJoqdwC1c2XQG
         UPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgpjV9k83EmC3yQ4DvMrLoo12ich9kue84KtDrunu4g=;
        b=fybDq51XM1D5fU1DlZaRTsQJ7mizG5K7Hzjcdty/mgxoxmmVDYl7wNGhe7O9lCiQGk
         wSCeIthqVTu9ycskdZOnOt4isnbtOl8npZ7l5ZXZ28ZXZi9Y3Kvgbf92xNDMI5y57vTd
         qRgjww9M8U1FZqWUm347jKbokgBif3IdOcrWx72F3HIdFTUAAX25CWS0W0dg2I2rf1Nd
         iXmJt5yn9YyObBWxRM74d/GRhbQwRk4/aztuqV00F56uPhBmo5NhbjH6FJX2JgZR4Vun
         OuNcBEhEuPO3W2Db9LNKl2WdW4mbS6m56Zdb++vNPDjB2u8IVSybRQ9jHNjh3z6QGvZH
         W+RA==
X-Gm-Message-State: ACrzQf1Kj6OM1+Z1BMhfjewcIjZt5YsEt9pXNhWhnZN+XiHq7NloOlqW
        HJJBqBPhVMIqXUSF6cYw/yc=
X-Google-Smtp-Source: AMsMyM6DZlYi+8VBwQU8HZlySmtjWXLZVuwg/PIDql3yJAwyvvHKfOPkQI5GoW3FKBBgyK6ZrnWKTw==
X-Received: by 2002:a17:902:6907:b0:179:c9bc:dd73 with SMTP id j7-20020a170902690700b00179c9bcdd73mr7985343plk.159.1666177625203;
        Wed, 19 Oct 2022 04:07:05 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-821b-9613-557f-bd8d.emome-ip6.hinet.net. [2001:b400:e258:8c34:821b:9613:557f:bd8d])
        by smtp.gmail.com with ESMTPSA id cc11-20020a17090af10b00b0020dc318a43esm8696225pjb.25.2022.10.19.04.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:07:04 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V5 03/26] mmc: core: Announce successful insertion of an SD UHS-II card
Date:   Wed, 19 Oct 2022 19:06:24 +0800
Message-Id: <20221019110647.11076-4-victor.shih@genesyslogic.com.tw>
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
index 088ec34299c8..dcfbd014a871 100644
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

