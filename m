Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27512604398
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiJSLnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiJSLn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:43:29 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F41EF5A8;
        Wed, 19 Oct 2022 04:22:53 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id g13so9002916ile.0;
        Wed, 19 Oct 2022 04:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxU0Pte3GePSANg5TU3silLJgxesK1rl/+ZzUZDDvz0=;
        b=p5txpMdfiH3pG8rWpVewgAwDfUIrxNY2QTotH2LxTawh1Dfl4FDKHJfTSWj+y0JXsE
         NQ7aTgtz+d2vEoESFKOSfZaUMsWAG1gPD4Uoi4xRnN7/iVPT+sIHi5TS2Yga4Iosluc/
         iAcIkoDMngCEBKL6pu45co+PRDIkyB/vCiZVFGxfVjeH+sU/BR306pLgWIucLw7PFIUL
         2u/jDHUYIoEu/jQicjpOzYPWksBk6lADXy0dFuMuGQG3AqK175YsLrhmkge6jDuKBDiR
         8zjvxAWLrNj+sk4eRka5JKOtlqahmiYoucnj2H4ombGAsbus83pHw50rGYaz9vogQRjy
         +NSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxU0Pte3GePSANg5TU3silLJgxesK1rl/+ZzUZDDvz0=;
        b=4yVQKXCpjYCkhdYSkf4jktJXjnuZceK5dxtZGV26leSgGW2TmxSYq6mzpQC4NWleW5
         ChPpuXG01VxBCRSLUoBAYE1BIdfiNM52FXHeTrOqGhYPDV3AUyoElPddPN+2sQqdiRE9
         aDVXsc/66b8/M3qacNYpxxyMuQ2VyB6grq4n6uDUV2D6oUQ/lHl/HmE9hMYAJjoyKWlB
         j9O7LTlH6QfAnxXbPlRJ81kvV3/yH+75kh6iPf+Tv/jDrE9sf41avLYUSKOZfD29HTPj
         B6FI7F9Bm0bIrnGs5pw2RDI712xM7/sr293N+MfZ2AmFdVZELc0YJVqbnh2aVag384sS
         gZZw==
X-Gm-Message-State: ACrzQf1O3J3DVvB+AZiBFaJ40Njd4Pq/J0eaMnSupQrFnha6EOlxIACI
        gbzFGP/MWeKslqncspgmbdkMnEH4BsY=
X-Google-Smtp-Source: AMsMyM68LP+Dvb7An0fG59BTV2QsKsKA6ksrkz9tPIXagEc2db6S77B1EoTEBx9GyPtzJvTNmtkqtw==
X-Received: by 2002:a63:1d1:0:b0:43a:348b:63fd with SMTP id 200-20020a6301d1000000b0043a348b63fdmr6907980pgb.52.1666177684377;
        Wed, 19 Oct 2022 04:08:04 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-821b-9613-557f-bd8d.emome-ip6.hinet.net. [2001:b400:e258:8c34:821b:9613:557f:bd8d])
        by smtp.gmail.com with ESMTPSA id cc11-20020a17090af10b00b0020dc318a43esm8696225pjb.25.2022.10.19.04.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:08:03 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 22/26] mmc: sdhci-uhs2: add pre-detect_init hook
Date:   Wed, 19 Oct 2022 19:06:43 +0800
Message-Id: <20221019110647.11076-23-victor.shih@genesyslogic.com.tw>
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
index eb3241bf95a2..212701267d2d 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -1542,6 +1542,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
 	DBG("%s: begin UHS2 init.\n", __func__);
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n",
 			mmc_hostname(host->mmc));
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0970fe392d49..97728eee5b25 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -743,6 +743,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

