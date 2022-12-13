Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C356064B1DA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiLMJET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiLMJCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:02:18 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15929101F9;
        Tue, 13 Dec 2022 01:02:18 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id s196so9996552pgs.3;
        Tue, 13 Dec 2022 01:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqVdZlaw4OqprZkFV/DFABpNPHZPNiE0uwjLPDRS6Mo=;
        b=ppyZDN2dLPPCqAQgEKy5cK7IG3nBjLfoovEQkutRpbfJtJ3w7psQbnG7P4x8U7rvO/
         eEe7ZvnnkCbY2o5MdDmNWyZSAyarB9Wy8EBVs8Z+uBsLlrjKZyEKiyTrajAvrXR1mJAA
         aGZHGFoj3H5MGhk2qCt+JGn6OosPcfIeSWRCzybF1Unuei5qqUK/RTIYXfgnrb7XZlCv
         +zwzNjUlbG58VnLnCLgI/Ki97UhtoEqL8UzNUEBly/7z/e2Fjcc0uyp4HStHpNbaF+QU
         6dKpxkDZSXa9MehXWe5AyNEh5IoNGcxFM3tclXtBANLxC7OhYmUJOg3Vymu6YvhyS2OO
         ZntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqVdZlaw4OqprZkFV/DFABpNPHZPNiE0uwjLPDRS6Mo=;
        b=DJ7TPJA4UkjELA0rXeBEkRauG71KO0LJgcVljH5Of9kE/2nplwpPfBQ6+Zzlpqclxo
         fY7rRn/TKrGkctB0LaTnuh6lKHzPJf8L/Q/VnIqI9fMBgUXnivIaxXyugBxFZ4c7afRO
         mVZ4xxhHYkfmlqL463MlrbBCwK400Gop79lbwyseR453uP/JTKfV2ScdY78ye/AoUIF6
         rnJdvr/CercJOLWGRpV6W60cMytx4o6p21uNebvLEt0RopRH1qtlhL2NKAA/DRmQko7j
         qSRbha77THO73wMCr5Cm6a65fCyx1k+TmTjnNzzgdpcH/YGRCPdTVaihJ4BGW3npjO/H
         BwOA==
X-Gm-Message-State: ANoB5pmhCermIh62sHqg3f1CMHkY2MyVv+mF6fNssPSKF7sRAnCE+s/N
        Rjz0yS9DMi25KS4DBHtwzFY=
X-Google-Smtp-Source: AA0mqf51xIpaDlaVa8O1nYuElbM30SJsE/QzQNYgCl1DLTxXXB7clUWZXqDJUaLxuujPwCgHpUYOAw==
X-Received: by 2002:a62:3103:0:b0:576:14a4:b76a with SMTP id x3-20020a623103000000b0057614a4b76amr17377652pfx.34.1670922137587;
        Tue, 13 Dec 2022 01:02:17 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2dc-5c03-264b-f684-a8c9-21ae.emome-ip6.hinet.net. [2001:b400:e2dc:5c03:264b:f684:a8c9:21ae])
        by smtp.gmail.com with ESMTPSA id 81-20020a621954000000b0056b9ec7e2desm7141682pfz.125.2022.12.13.01.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 01:02:17 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V6 21/24] mmc: sdhci-uhs2: add pre-detect_init hook
Date:   Tue, 13 Dec 2022 17:00:44 +0800
Message-Id: <20221213090047.3805-22-victor.shih@genesyslogic.com.tw>
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

From: Victor Shih <Victor.Shih@genesyslogic.com.tw>

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 5349173b4f90..1b481260885f 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -1358,6 +1358,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
 	DBG("Begin do uhs2 detect init.\n");
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n",
 			mmc_hostname(host->mmc));
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 5f090b5ecc61..e5f64b38e339 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -727,6 +727,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

