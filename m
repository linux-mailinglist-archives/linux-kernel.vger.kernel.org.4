Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92118725FF3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbjFGMrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbjFGMrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:47:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D671FD0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:47:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f642a24555so888043e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142031; x=1688734031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soNRO/BUZIJbMO0tj7YT3q6ZRWzbCDnTXsUpvBRWu2A=;
        b=itpQPjGA5TElmgt1urTONLMv9mjtGtb7S9Z5uyIb+OWowKNKt7+MSj9qAl4FLFJJlP
         ifnyOMTir9GkU8jjOGGLXDEimE5gB5HKNFycDQMCCA6T0l/6qzFVaX7pO64y2MvJswiy
         w/ueTkJHOv1UbOsnFRcA5MrsDh0VldxAZ/ptP01UqLLfpjaK3URAiQ1N0vpG39S3v/f3
         0ztubSa4eWOX6A+sJIYvnChwpDAA4wucYwcCemf71lEMjGE+6VgzNdkGZwv779uJ0Pxl
         cqdD0gdokH5LgttK4zcKO/B1LtKwtsdZq5SvRqpW5uRObXQwQdeNSrZdc7b8pBlFeCxa
         6LGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142031; x=1688734031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soNRO/BUZIJbMO0tj7YT3q6ZRWzbCDnTXsUpvBRWu2A=;
        b=CrSoqYE2LgtvCrkti1S8asG8p9sAfMku3p1TdSc2MMwhrpWejnwRGX599bkHz9xpYz
         4NHH7lSi6TQfEYdDRM2UyMgrPzpDZTwk8aDdP1LcUAjhc493+sXS2u1h2bnz/5adzJ+g
         ottjLD3QTzeaUJHKu1EgH50G7azKva3NUENX8DsC96dJA5tsviZzzMW+yM+yL1hOyF0H
         8LODTbrGs0p7Rg0k+3AtFHkECmSWxup18Wvrm4JrNsz7Hh9Cu4aSJJsDOON10hsgPSVZ
         V+ouoWnWGfqFwPthkfncuuF98wdmYWi8w0D6t4TkB3+lAfBo+zAjC+kOq40exomsuhCy
         100Q==
X-Gm-Message-State: AC+VfDxieWlt4CcpOeVfI/ezYfVP4bzWQw4zqx5rl71jvcIaE/3TIDJj
        I5Wu9fTYoEtbHlcgLvTv6+9d7A==
X-Google-Smtp-Source: ACHHUZ6vjXi6uoVZFASRdXD9Oxut2wR/L6LpmXTtwp68ccU9nq2Nc+wzn4DEFJH6wASf5v7NdQIk5A==
X-Received: by 2002:ac2:4195:0:b0:4f4:c973:c97d with SMTP id z21-20020ac24195000000b004f4c973c97dmr1907711lfh.25.1686142031157;
        Wed, 07 Jun 2023 05:47:11 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:47:10 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/16] OPP: Extend dev_pm_opp_data with performance level
Date:   Wed,  7 Jun 2023 14:46:24 +0200
Message-Id: <20230607124628.157465-13-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607124628.157465-1-ulf.hansson@linaro.org>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's extend the dev_pm_opp_data with a level variable, to allow users to
specify a corresponding performance level for a dynamically added OPP.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/core.c     | 1 +
 include/linux/pm_opp.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0e6ee2980f88..79b4b44ced3e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1954,6 +1954,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 
 	/* populate the opp table */
 	new_opp->rates[0] = opp->freq;
+	new_opp->level = opp->level;
 	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
 	new_opp->supplies[0].u_volt = u_volt;
 	new_opp->supplies[0].u_volt_min = u_volt - tol;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 305cd87b394c..2c6f67736579 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -94,10 +94,12 @@ struct dev_pm_opp_config {
 
 /**
  * struct dev_pm_opp_data - The data to use to initialize an OPP.
+ * @level: The performance level for the OPP.
  * @freq: The clock rate in Hz for the OPP.
  * @u_volt: The voltage in uV for the OPP.
  */
 struct dev_pm_opp_data {
+	unsigned int level;
 	unsigned long freq;
 	unsigned long u_volt;
 };
-- 
2.34.1

