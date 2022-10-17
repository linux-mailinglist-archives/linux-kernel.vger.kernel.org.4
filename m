Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84B8600A05
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiJQJMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiJQJMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:12:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65E320F46;
        Mon, 17 Oct 2022 02:12:19 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d10so10520731pfh.6;
        Mon, 17 Oct 2022 02:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgpjV9k83EmC3yQ4DvMrLoo12ich9kue84KtDrunu4g=;
        b=avhubzSXytLQG4oLf2aQK8NeqCg/pRWd4hV68c0UYH0QumxgNhCx18nDeGQkJX4c67
         H7vhUwuuIUz0pj8qRItSnbqq9CPjDH8+xQJNUul0dW662nA43GWbQJFZVk2DqE0mvELh
         598ATlUep4wOB74EhNfYjqA4IkObs+PNbdHt4Xvs9z9iB6c18GavkzEjNWa2JXTg3E7e
         DD0hOKxvDvyWso+r5jLzVVSvR7qVmeZJ88QXqn3zumFf/lF4r0RBGnvF6yLtcgICt/D2
         +95FE9sjJ0xYUnFQHB2B6PQLBJKEAZr0cvE3UWnbxlEIeT5bhN/kyxIGQ9ldUaJ2Aech
         mGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgpjV9k83EmC3yQ4DvMrLoo12ich9kue84KtDrunu4g=;
        b=njoZ1AV6WrGZO3SNal7jtp73jXP0pcHSqB/fLXfo3ECwW5gonHYnbzF0t/kTWTVj8V
         izSt8+9AnXVvd7CoSvhPU/y1IT25yHLgfyIZE/3lAp7aWzwBpUObVKAX8jkLmtQ7AMj9
         XYCHaSDsQpZ29uHFOnbQ7/bNZKGZFvLULpKg3irGefbnl9iUTJpb0Kef9SsgE9h06X19
         G259vbHsxlTuqXOdu9Af7bjAq+IHKyOQ3jysibSApSgJOBj9x1XaYESuSm4bX9BgvMTd
         edLJ1H5vw+T09F09yi+/Hjs3uu3Ha7lowoJT4AVOtQ0qhDS6x7nZIf54Mq1tJQ+eLnxP
         N6cg==
X-Gm-Message-State: ACrzQf3ljpeblOK2YeUK/8RHytWZCWPC0EJBJ+vlrvpnqPk33AV0knWq
        x1saJ+9qtS8eReVk3Za/bJ6hmkNkBUc=
X-Google-Smtp-Source: AMsMyM7T0cdbvI35GprVkg4LVdMx1gv1h+IaPuk4QnrivFs3487TgIz7NTGVjQavm1/nq/0bDkJZvQ==
X-Received: by 2002:a63:1112:0:b0:43c:7998:ac15 with SMTP id g18-20020a631112000000b0043c7998ac15mr10261548pgl.51.1665997938722;
        Mon, 17 Oct 2022 02:12:18 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-4ca3-4989-34c1-7890.emome-ip6.hinet.net. [2001:b400:e258:8c34:4ca3:4989:34c1:7890])
        by smtp.gmail.com with ESMTPSA id t22-20020a170902b21600b0017f75bc7a61sm6091996plr.166.2022.10.17.02.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:12:18 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V5 03/26] mmc: core: Announce successful insertion of an SD UHS-II card
Date:   Mon, 17 Oct 2022 17:11:30 +0800
Message-Id: <20221017091153.454873-4-victor.shih@genesyslogic.com.tw>
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

