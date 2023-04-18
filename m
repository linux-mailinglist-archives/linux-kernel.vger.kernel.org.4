Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EDE6E677D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjDROvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjDROvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:51:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B73D125B7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:50:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f16b99b990so22882575e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1681829458; x=1684421458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJV57xSs2dDfAf5r16zc+/+R5eeJIggrJnMj0a1LSiU=;
        b=VRMABw4RSJhyc76sJKWgp2LNpymhYyaL3jGqm1PDs57nvREiTvC+3OqClQzCqdF/4s
         tr4sCS4x/0frof4DQ1xoKUQyBkDnUcPjaFuC38ChxbeF1RPFhPnv4hHy7em9b8sDXjM2
         /fauE8QYdVPuU5KbZ+sBYIKaYEBpyqapOpEY83vjYsPFwJUutBQARt+JgUCwUxado0mQ
         uusl/sVS6CiUouItaRVZzImRu3TEwM0TJnR12I0u9qu27EhzWQmV/OzzUvYTNDZdiAG+
         jF5UiImVXbZFtvrGRfyHpTcX5mU4fvi2NNlhvKpvg/G2atKjK48OVYy8UTaG8pfNY6UE
         jjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681829458; x=1684421458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJV57xSs2dDfAf5r16zc+/+R5eeJIggrJnMj0a1LSiU=;
        b=TWxYJWGX7+O6ifBQcXXfPloNHs/ToruW+BN0YM5UWVDIiZEEe4PqzqxhgnN6lE+GB4
         rXFdDBY+eyoZZPO6M/VDFaO98IwT/B+GeUZVrZ82MYSSuMe0LnQffizCe1uOXys7fUWF
         rTlKD+q7By27zFUYDz1sf1vbfBNAL+UZI9wYU6nw91Ctu+e2NZ8EDiyHL6TWI4FFj9zD
         IcJuzia+KQ/kfPAoq9IF50L9NqjRFRmjdrGy1q85mmUKBmcjk8v6TquFL8TeaRnslMZ/
         szgBnV7s4C39AAWPvor/wdzjnrFMCrHl6NyMxPHIZzq6D07eghtQ+WUj6SlOUXJQdJWv
         kayA==
X-Gm-Message-State: AAQBX9c2IxZKvfOGLLSeMjPgZ1+mLHwTxU6ikXSy8swauNmMozI9fUyh
        qhj962qo7s2HMo/0MtmFSmHXgCpIYopbaV1hlWE5OA==
X-Google-Smtp-Source: AKy350axAc+K4lhNkWK4lxu38HCZ+O/xzrvyvk5VpTB//CWpARY3e97Ak0e7VaTA+kGtCNgo1vaxug==
X-Received: by 2002:a5d:690f:0:b0:2f9:a822:89bf with SMTP id t15-20020a5d690f000000b002f9a82289bfmr2222232wru.16.1681829457870;
        Tue, 18 Apr 2023 07:50:57 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id z16-20020adff750000000b002fb6a79dea0sm3787823wrp.7.2023.04.18.07.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 07:50:57 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] regulator: userspace-consumer: Multiple regulators
Date:   Tue, 18 Apr 2023 16:50:51 +0200
Message-Id: <20230418145051.4192963-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230418145051.4192963-1-Naresh.Solanki@9elements.com>
References: <20230418145051.4192963-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use property regulator-supplies to determine all regulator
supplies.
This is useful in case of a connector having 2 or more supplies.
Example: PCIe connector on mainboard can be powered by 12V & 3.3V
suplies.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/regulator/userspace-consumer.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 97f075ed68c9..0bb49547b926 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -120,7 +120,10 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 	struct regulator_userspace_consumer_data tmpdata;
 	struct regulator_userspace_consumer_data *pdata;
 	struct userspace_consumer_data *drvdata;
-	int ret;
+	struct device_node *np = pdev->dev.of_node;
+	struct property *prop;
+	const char *supply;
+	int ret, count = 0;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
@@ -131,11 +134,19 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 		memset(pdata, 0, sizeof(*pdata));
 
 		pdata->no_autoswitch = true;
-		pdata->num_supplies = 1;
-		pdata->supplies = devm_kzalloc(&pdev->dev, sizeof(*pdata->supplies), GFP_KERNEL);
+		pdata->num_supplies = of_property_count_strings(np, "regulator-supplies");
+		if (pdata->num_supplies < 0) {
+			dev_err(&pdev->dev, "could not parse property regulator-supplies");
+			return -EINVAL;
+		}
+		pdata->supplies = devm_kzalloc(&pdev->dev,
+					       sizeof(*pdata->supplies) * pdata->num_supplies,
+					       GFP_KERNEL);
 		if (!pdata->supplies)
 			return -ENOMEM;
-		pdata->supplies[0].supply = "vout";
+
+		of_property_for_each_string(np, "regulator-supplies", prop, supply)
+			pdata->supplies[count++].supply = supply;
 	}
 
 	if (pdata->num_supplies < 1) {
-- 
2.39.1

