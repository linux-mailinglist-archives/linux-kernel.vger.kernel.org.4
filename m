Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16ED7381A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjFUKEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjFUKDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:03:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3833119AB;
        Wed, 21 Jun 2023 03:02:47 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so2477440b3a.3;
        Wed, 21 Jun 2023 03:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687341766; x=1689933766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaNZf4PIUqE3a9RgtDYiWhJtXMohH17DDxUnrbViPks=;
        b=BWNWi4a7UUGRum595CVhn/eCulcwOwUbJH0aPBCoCUxlf6eMbdfBTFydAB0TATwbyp
         VSiZtbelxP90P83hHnhVtSx8i308oOKAz2Yo6+2cy+oLa+UCZTnKy4aH4joM8Up2Uxzo
         E+1XJF5VPoZkMQYs4cHrpLm5ch8CfBLdSYBkQiOWh508z3kkzK3eR/rDdYxWsotkrHed
         cPP61siKX2KiHPxFIsbD4ATUEzDesMvqhTQItrpL5e5vjI8f6N26qdniuzwetRkYYhmr
         1N5GBg/bE/byde/B+Hpk5u2Q7KXHNfA7eyfLTt0C+JogEm0RaEQNJDTdnLv7NoVZKnUb
         JzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341766; x=1689933766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaNZf4PIUqE3a9RgtDYiWhJtXMohH17DDxUnrbViPks=;
        b=Jz35fMz+JGy+4cvp/9Uh6L+M5tOvTu4gEhWWJtbV79LCrI3OUzq2hWpUSrnUI+IM4A
         epxmwznr5n8Z+04grgatxtDkQGYY+XmVNt+Lb9ek+cdiC2yYy/CLztXLI+5b9oa0n2x0
         ucLeFHKGbrgthIoHrdPupsBMJ3nwdF/pkrivjeYcetRxByjD2X7812+pc5ARzGbJ0zU1
         /iPkFjuzXRk4TZPrgcjc9wvGnfyr6VcyWvJAwFYRqyv/p2BENu9APzN1c2O1Eykp447b
         SUSxjwL5ev6Ir5KxZVVSCIfJhcFSfYrfLcVUI8/QiYJarswL2HqaQvyk/0R3NjV7pKzY
         a6XA==
X-Gm-Message-State: AC+VfDzTxZaOwLytG2+u5sRoNWzxxeNSE9Pl3p2la8iQ2Hs9opI5FM+o
        Jzph20A6QmE0rdGIe9AkE8E=
X-Google-Smtp-Source: ACHHUZ7a2/28sDNVYUaevSVhAwceZt+aJecNatlYACun3y2Adp9h1h+MjJ2fhzvEBog9KhfN6fOpQQ==
X-Received: by 2002:a05:6a21:6d96:b0:121:5c4b:45b7 with SMTP id wl22-20020a056a216d9600b001215c4b45b7mr5516745pzb.20.1687341766571;
        Wed, 21 Jun 2023 03:02:46 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e254-4eda-2716-05ea-20f5-b048.emome-ip6.hinet.net. [2001:b400:e254:4eda:2716:5ea:20f5:b048])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b0064f46570bb7sm2611196pfo.167.2023.06.21.03.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:02:46 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V8 16/23] mmc: sdhci-uhs2: add clock operations
Date:   Wed, 21 Jun 2023 18:01:44 +0800
Message-Id: <20230621100151.6329-17-victorshihgli@gmail.com>
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

This is a sdhci version of mmc's uhs2_[enable|disable]_clk operations.

Updates in V8:
 - Remove unnecessary include file.
 - read_poll_timeout() to instead of read_poll_timeout_atomic()
   in sdhci_uhs2_enable_clk().
 - Put the comment on the end and put the lines in descending
   line length in sdhci_uhs2_enable_clk().
 - Modify return value in sdhci_uhs2_enable_clk().

Updates in V6:
 - Remove unnecessary functions.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 4c2a56629ab3..af1b0c5e48fd 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -329,6 +329,36 @@ static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	return 0;
 }
 
+static int sdhci_uhs2_disable_clk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	return 0;
+}
+
+static int sdhci_uhs2_enable_clk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	int timeout_us = 20000; /* 20ms */
+	u32 val;
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	if (read_poll_timeout(sdhci_readw, val, (val & SDHCI_CLOCK_INT_STABLE),
+			      10, timeout_us, true, host, SDHCI_CLOCK_CONTROL)) {
+		pr_err("%s: Internal clock never stabilised.\n", mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		return -EIO;
+	}
+	return 0;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
-- 
2.25.1

