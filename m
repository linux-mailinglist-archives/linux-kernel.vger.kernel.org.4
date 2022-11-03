Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CC0617B3F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiKCLBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKCLBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:01:30 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3743BE0A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:01:27 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g62so1237072pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 04:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdlSJiSDdFVNFGf7aj1iVzyqCpSjnjyK7zZt5V+eoFk=;
        b=UAmCLml2yroJcnFXFQvvkzy2aNsqlmSGQS5t8dAlzArMlFBKaJvBqOYgjVuzPCG/bE
         L2WuZiDJamaQQHF2ZtSeEUW7/i0igpivEDO/H0L4WEvA96KyIp4Ir6RN5mH65cTc+2M7
         uSNZPqD1dPevSMC1cs4iZuhIbno4Gm1Rqm0SPA93wu+ObgvakF0ME6NX0J9HsYvsCZvF
         gYm49A8S1d6ELns4/t72kFySs2bKD4wSQcIFa2W4uAii1H6TKDUFwRr3OI63qafeKe4t
         1/WNmtSiTXdFO7DIb5EO1TUOV4ctgbAKuGeVs62PKSYpI4fPzdnAVRZR26VNUsmsW+eI
         RMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdlSJiSDdFVNFGf7aj1iVzyqCpSjnjyK7zZt5V+eoFk=;
        b=W2r/71qAsUwW6QwRQglHv0UJVSmy6mFthXDS/BW7btkGd9lsZbBij8+wTgPkHUAoiX
         k4kcvliKX1ZnN1XyiZn9oSLw2tsUgg8g5ZIUCqM1g/19P3hSs29ONfQUEdFgggFsxnzu
         F1zWkOhXfORxn3GIxrQ0EbCYq+mWyMPeM/GJo4voqhokJkuXw2G7SftwiMnsjP3W1AGT
         P9EbfAzwTIWRPvyr+pwIBLMofNAvedERFrHkrnpl4Fk7X96oKqe0KdzmccowqwYr/3ZZ
         LfQqCCaI83VI5H7S+4sru4y8R3PNdygXNvXE64RZkqi9AfHHz2tyoFrvk1H2OBa6W9LR
         BJRg==
X-Gm-Message-State: ACrzQf04aI0gpdnS5slXBd3FmwRXQzxtLvjpoK9R/6s5AXEbSv04e53P
        80Bng5gslIkac0t2iKGVwXvGyw==
X-Google-Smtp-Source: AMsMyM5Tmy8uLzzWKsj3p8zB/Bu8mxxZ/K6C/aTTqngKlL9AKMx2cTWBUah3RAb1oXK+BGWrxzA2qQ==
X-Received: by 2002:a05:6a00:140f:b0:56e:1190:e731 with SMTP id l15-20020a056a00140f00b0056e1190e731mr7920554pfu.39.1667473287402;
        Thu, 03 Nov 2022 04:01:27 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id gm22-20020a17090b101600b002132f3e71c6sm684726pjb.52.2022.11.03.04.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 04:01:22 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     James Calligeros <jcalligeros99@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: opp: Fix usage of current in microwatt property
Date:   Thu,  3 Nov 2022 16:31:04 +0530
Message-Id: <f7eefa76db8c7d01b4bdaafa6acc4cb84c193fe0.1667473008.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1667473008.git.viresh.kumar@linaro.org>
References: <cover.1667473008.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings mentions "current" instead of "power". Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index 66d0ec763f0b..cb025b0a346d 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -108,7 +108,7 @@ select: false
           The power for the OPP in micro-Watts.
 
           Entries for multiple regulators shall be provided in the same field
-          separated by angular brackets <>. If current values aren't required
+          separated by angular brackets <>. If power values aren't required
           for a regulator, then it shall be filled with 0. If power values
           aren't required for any of the regulators, then this field is not
           required. The OPP binding doesn't provide any provisions to relate the
-- 
2.31.1.272.g89b43f80a514

