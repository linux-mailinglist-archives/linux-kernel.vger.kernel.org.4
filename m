Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC885F0832
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 12:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiI3KDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 06:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiI3KDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:03:17 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B6CE2CC3;
        Fri, 30 Sep 2022 03:03:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u18so6114357lfo.8;
        Fri, 30 Sep 2022 03:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=TiijBohBoy/awqqmgRbwjxKUZoYOc3v1m9FkqUu5mOo=;
        b=F1e4sp7aLKMcHwE2RHtz+Ql+5lyoyiEokYhhYQ/QXVc96LCFIrT8+ajAPNp9M60JOd
         xtqPFupm2vs/+ek8hxCw3EMu9OkyrmZYLzym33XI9HPBwLYbt2UAA7/9pO/GcdojfyU6
         OCon2iuA44ft7gM8CrWJ8SEqaqo7aPu9YVDgNjOfb9rdXwVK6TElggTg/tunD7zHUl6D
         3mXPgY2974qd1s3JVB8nHHdQmsJg0pEXenzEr8MEQBamqN4bwZZYd8goE8YQayoEa3G6
         f5Kb2vPkp1d/f9vHzieVQbEHimFeaZIy38teTntW83G+XoGGQeHC/W6osw0gwGegXcjk
         ySJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=TiijBohBoy/awqqmgRbwjxKUZoYOc3v1m9FkqUu5mOo=;
        b=yXgyfMxrlb/40vIKBP0NH/ATZJCsQbGl0ohOlGmK/y1QWf/nUwGW18BIuslweH2YrH
         pTm4rxG8YzONcfAZ7IDBhXw1aqsZWrZBevIfWtGahNvx6k9zIidp0fLOm/a6OvfPzgkc
         6EmDtnWnzhNdWYr84O9BafW+1Y6gvr/lKP6eKYhwZD6+0XHu3cKi/3TqZiZUc+pFHHVH
         MXv56fxSKvZC+0Z9fyhTbhyy47jP3oLdLvS53hzXNppxVU6CehygkFtYhU32SfCjsS5F
         mlxuZnmW88LoVw3Xhq6hg33SVjSawWd0kS0pQsmqE3sRTv+ihiOiA/jcS4IgDRSKMwh1
         vjTg==
X-Gm-Message-State: ACrzQf33a90fs1Y85g6hjb3FRB8vEcOXS6iSueoQPqsVkp2JWTjLp7oH
        /2lndECbuA0USohb5+u1gvcb9fU+nC6yMg==
X-Google-Smtp-Source: AMsMyM4+htJ/CXxmzYa4EpJ+aQ1OInRvJH88oS6U6jkAe47Vo+xzt1aksnI870SGmB6tQ7lcwVElPQ==
X-Received: by 2002:ac2:4e14:0:b0:49b:67f3:e450 with SMTP id e20-20020ac24e14000000b0049b67f3e450mr3268762lfr.591.1664532194828;
        Fri, 30 Sep 2022 03:03:14 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id k15-20020a05651c10af00b0026c170ee13csm112272ljn.91.2022.09.30.03.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 03:03:13 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] thermal: imx8mm_thermal: wait for a valid measurement
Date:   Fri, 30 Sep 2022 12:09:17 +0200
Message-Id: <20220930100917.498853-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Check if first measurement is still pending or if temperature is out of
range.
Return and try again later if that is the case.

Fixes: 5eed800a6811 ("thermal: imx8mm: Add support for i.MX8MM thermal monitoring unit")
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/thermal/imx8mm_thermal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index af666bd9e8d4..9dd60b940ef4 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -62,9 +62,15 @@ static int imx8mm_tmu_get_temp(void *data, int *temp)
 {
 	struct tmu_sensor *sensor = data;
 	struct imx8mm_tmu *tmu = sensor->priv;
-	u32 val;
+	bool ready;
+	unsigned long val;
+
+	val = readl_relaxed(tmu->base + TRITSR);
+	ready = test_bit(probe_status_offset(1), &val);
+	if (!ready)
+		return -EAGAIN;
 
-	val = readl_relaxed(tmu->base + TRITSR) & TRITSR_TEMP0_VAL_MASK;
+	val = val & TRITSR_TEMP0_VAL_MASK;
 	*temp = val * 1000;
 	if (*temp < VER1_TEMP_LOW_LIMIT)
 		return -EAGAIN;
-- 
2.37.1

