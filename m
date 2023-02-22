Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1812F69F324
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjBVLHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjBVLG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:06:57 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D648C38E8E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:06:55 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z2so8481227plf.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKF4g3sJY4F36hMtcM0eHUIlxzL76BJwo9OlrmTuaXo=;
        b=r1QtHTdmuiRplIZ5BlnOJSnSr9AfM12vU5yV8seTDhtwDfAwQVVrchPoLYEtimSeSO
         fZcOjLk2nkQ4BNkACOsmfYIXAurwqq1Wcp1/8R447NRr9t/UwAwiK4ReoOoKg8fMz61B
         NzblmUIez8fpvNadarTg5ogp8sv3C6SBBsUiAuHC/3V6DbSw/L42g5bneQ4b2MtrHTsv
         sTs7V9J11iejVjby1kcY+SPupy/b+vy3wM6W0mLZe9sgFJr2hD26X8aWk4K8YILU4Qns
         DluNjWyWME9jDCYpOFtKWAImOytgUD1JN11Vdpbiw72JWSd1Bj/xkYth2KyB6VcR8mrk
         up7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKF4g3sJY4F36hMtcM0eHUIlxzL76BJwo9OlrmTuaXo=;
        b=NWdurBxGwlIVJxEg4o5xg7tYMOTfEpNN8XU8YokIu49/iH4bS1kXyMCqrtdclZTQnj
         SZP1G3nwE/+CFM57MqUxAEuHrGrM/iE8jAhnF3r2/RTdXCNptKCXL6BgIJRgScpIBLPC
         aK2kY/8QOitHTh2AfWDamCPPQL9qyPc8D8dZsjueuXOiUkaZCJ6NkPQKXag46KuxJfcd
         tr9sBJ2Usi2P81cXO1SN+FMhUUMloeqhEyAC/kydBQD5MNB4N8Va1RruxiN5+GH2mkwG
         dTt+uLeVcj7McZYbuJ2CXr+h8A9fnrUihzzXEY1F2RlV4YjZSgLi7WAoMjWtOBneykDX
         8YIg==
X-Gm-Message-State: AO0yUKV/6IBVMIVwUI8397Xk0zktF4kOLJy+8XklzQEAOcSGljPsK8ru
        tG8u3rXqSv6J77qdgTbskKtrIw==
X-Google-Smtp-Source: AK7set8KiGimYVmciFfKyYspnOZlfnqBDC3S2RItxcdvLBhN4RUzQmnZsgiLF8s5kx1/dn69giz5bQ==
X-Received: by 2002:a17:902:cf48:b0:19a:80c2:4396 with SMTP id e8-20020a170902cf4800b0019a80c24396mr8138522plg.68.1677064015575;
        Wed, 22 Feb 2023 03:06:55 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c14c00b001949f21e1d2sm4579999plj.308.2023.02.22.03.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 03:06:55 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jun Nie <jun.nie@linaro.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] OPP: Handle all genpd cases together in _set_required_opps()
Date:   Wed, 22 Feb 2023 16:36:37 +0530
Message-Id: <8f9fba47f91ef04fa2cf0c3adba9299a23d5280a.1677063656.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1677063656.git.viresh.kumar@linaro.org>
References: <cover.1677063656.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no real need of keeping separate code for single genpd case, it
can be made to work with a simple change.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e87567dbe99f..6d7016ce8c53 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -959,7 +959,8 @@ static int _set_required_opps(struct device *dev,
 			      struct dev_pm_opp *opp, bool up)
 {
 	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
-	struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
+	struct device **genpd_virt_devs =
+		opp_table->genpd_virt_devs ? opp_table->genpd_virt_devs : &dev;
 	int i, ret = 0;
 
 	if (!required_opp_tables)
@@ -979,12 +980,6 @@ static int _set_required_opps(struct device *dev,
 		return -ENOENT;
 	}
 
-	/* Single genpd case */
-	if (!genpd_virt_devs)
-		return _set_required_opp(dev, dev, opp, 0);
-
-	/* Multiple genpd case */
-
 	/*
 	 * Acquire genpd_virt_dev_lock to make sure we don't use a genpd_dev
 	 * after it is freed from another thread.
-- 
2.31.1.272.g89b43f80a514

