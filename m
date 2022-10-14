Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26655FED61
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJNLrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJNLrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:47:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021E414EC6F;
        Fri, 14 Oct 2022 04:47:19 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c24so4522863plo.3;
        Fri, 14 Oct 2022 04:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgpjV9k83EmC3yQ4DvMrLoo12ich9kue84KtDrunu4g=;
        b=DHety4CljA7B3Bly/Wik8leEZNJ4ay10sgbxnOE1ksTH86+vbIVUraV7xKMuZ/hqJq
         Tw9i4zQHY4AVvIWUALrXHKSFiLI6xXnrYNHrbHCa1SPdgDegMa14CWU1KHZlMZTn/Iav
         cnQu03DgjP90f70Xpga4uzipthFZ4gPlScofL/hWPmuTsdRJ44fw9WMvvtB7GuMR2bAN
         a+SXHLH2qEa+HTgA9VB1MU8XWNTSAQukWxU10TBCAZb+B1/OG2ISgEufPZczyFWTkXbF
         PsOB4HLOL9lT30Hde6HeIGceau95DkxATCMW8pZH4QRmkg4uhsSC6nllvcZ/I3WDBCPs
         Xvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgpjV9k83EmC3yQ4DvMrLoo12ich9kue84KtDrunu4g=;
        b=kd6jP4kXKfwJnEzHrrHAs2Ps9XZbBJferswT6XetVxnXF+aiwVM4/0uPHZOtLBKkyu
         bYTQEfjoEyFvw+mFbZQMv+DIG226vN0vtJNBm1Ovy2CeJtVDWRrfCD3teOKOCcZT2LHK
         zHpXjX8vPhdV3S5szI+IkXNFcWQX8OjU7msn+3NNeVCbqTkAtxJKYMaE+zQKqSurmdGR
         obZ4haMjEH1OMwhwi9I2IamuB6mmEUPMV4XH7W9TfLflpqlC0Fz8Z7uTNRoUAO8UGZl1
         koUPKufCf0ZdYvpPCP9u8V3U28+0L+puh+GwgLyuPhsK2iDo98eYinCAcaxDrNz62VeI
         soNQ==
X-Gm-Message-State: ACrzQf0KXl2yzbdr01FBaxQLxWdRh1NXwjsRZwe3VVTlaUfOfm9+lTiv
        wxXOAjzrPgmEf/v1ityJJ7Y=
X-Google-Smtp-Source: AMsMyM7aYYmYFHHedK5pHhuLlcVTuCeg4CNcy62LF6xKudPm/K1VqCTpxL6lqdAgocMisCC4Rpt2Hw==
X-Received: by 2002:a17:902:bd02:b0:178:1a1c:889 with SMTP id p2-20020a170902bd0200b001781a1c0889mr4940379pls.107.1665748038635;
        Fri, 14 Oct 2022 04:47:18 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-2aaa-c1aa-06c8-0e68-c5ee.emome-ip6.hinet.net. [2001:b400:e282:2aaa:c1aa:6c8:e68:c5ee])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001746f66244asm1606678plg.18.2022.10.14.04.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:47:18 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V5 03/26] mmc: core: Announce successful insertion of an SD UHS-II card
Date:   Fri, 14 Oct 2022 19:45:38 +0800
Message-Id: <20221014114601.15594-4-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
References: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
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

