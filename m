Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCE3617B43
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiKCLBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiKCLBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:01:37 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A36B7EB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:01:36 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l2so1531491pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 04:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUlxdNeoLlpwqgvI1vJN7b1g7ZmITiL31RBfTgzzy+4=;
        b=XJqmPRwvw+FN/EEePw4qaKUzYroDLu2G9Z6BA7HPgsLyBuvWmXKCSGvjHrIuOEIARG
         uLbAxrwgIuW4C5fAjPdhLpEMEd99EaT457UbyTI8jBNoVJv6ZVLJnMKPnFxE94t0pcCL
         ir0xmdfgQ/FjROoq+EP+b2wH+9gP6VhFXEjgdgSxIout3u2ddUFIXPyJL8HVuA+JcCEc
         AGD/OxvZS1hTK32WR0qll0Hdq/35CG2SO78CgHKA9m/Xi8/d69FtbaYQvyZsPFGyGHTi
         0LG17JB/H9gightd066xVQsKspk0uBv9QvMyjhnSLn1vEY/pM4WshA9PVhP4R62yNHhJ
         5Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUlxdNeoLlpwqgvI1vJN7b1g7ZmITiL31RBfTgzzy+4=;
        b=qro1cS37YmNQONg53IsS5UMbWhxwEuwIJagsLGvRtQyV67s7EpSVOPajdOrEAe6WSO
         djqUd/dkCcDV1r+bYMCujW7FJZVw1TEq1eRsxLdyLUtAD0sLp9U4hgaMjJfOTpXfgaUK
         Iaxf6BJRuNW9N9iYvyIvbKCFu1WNeTwMQn9yfbGKD9bFlLLsFClWZ/OqUOz4N1KiS3FR
         KceH4RoXviKeOwT4tflpcDox+9Eq8oWxssrLZNAmR3NmCV7wUOpe7/x8r6Fr/5K8qsFo
         GmnvxhH5eGCfxfkqZ5CYus589UEOP+Avpm5vAZOCREp24idQeORbVfQBN+j7vUdotK6V
         rB+Q==
X-Gm-Message-State: ACrzQf0v7FH+6W6rgFQFKb4xtyGt38kx6ngvYyUtN5Y8vJK3JB2hC0/V
        ucqOz21SUntRw0gNzdKsvvfI1g==
X-Google-Smtp-Source: AMsMyM7+o44INWslrGpI+jefjbcGs9mWsqvc/VDaW4kwMbJEnEDqYNM+dVUGYoQeRY7M6xLcvREWxQ==
X-Received: by 2002:a17:90a:d084:b0:213:8cf1:4d34 with SMTP id k4-20020a17090ad08400b002138cf14d34mr31351688pju.150.1667473295998;
        Thu, 03 Nov 2022 04:01:35 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902b18200b001871acf245csm391281plr.37.2022.11.03.04.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 04:01:35 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     James Calligeros <jcalligeros99@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] OPP: Parse named opp-microwatt property too
Date:   Thu,  3 Nov 2022 16:31:06 +0530
Message-Id: <c887e9c9b4ce79437286507d3f573c86ecd04b49.1667473008.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1667473008.git.viresh.kumar@linaro.org>
References: <cover.1667473008.git.viresh.kumar@linaro.org>
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

We missed parsing the named opp-microwatt-<name> property, fix that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 605d68673f92..e010e119c42b 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -695,9 +695,19 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 		}
 	}
 
-	/* Search for "opp-microwatt" */
-	sprintf(name, "opp-microwatt");
-	prop = of_find_property(opp->np, name, NULL);
+	/* Search for "opp-microwatt-<name>" */
+	prop = NULL;
+	if (opp_table->prop_name) {
+		snprintf(name, sizeof(name), "opp-microwatt-%s",
+			 opp_table->prop_name);
+		prop = of_find_property(opp->np, name, NULL);
+	}
+
+	if (!prop) {
+		/* Search for "opp-microwatt" */
+		sprintf(name, "opp-microwatt");
+		prop = of_find_property(opp->np, name, NULL);
+	}
 
 	if (prop) {
 		pcount = of_property_count_u32_elems(opp->np, name);
-- 
2.31.1.272.g89b43f80a514

