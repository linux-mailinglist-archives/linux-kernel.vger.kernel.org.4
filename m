Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7496B37C3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCJHvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjCJHu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:50:59 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FA41589F;
        Thu,  9 Mar 2023 23:50:58 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id b10so4448696ljr.0;
        Thu, 09 Mar 2023 23:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678434657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6GyROhr1j9FfQF8Vtrexe5r5+ALuX6utFdZqThyuMXA=;
        b=AL/x6vXYojEwDpcy19RJzTGEqIInya0uiZrP9s5Cpnhc/YKca9r4js3iuGnY65rBsc
         ilCzLkbEJYesCjOyn9ItY6OUZECw5ba3dDvNilPzgZlNDwVo7W9W+pgaYfqwdH1spTnR
         GAxko12Dg3wWxSGer7duQ+3nrco5pIhaUFxTf6+r9u+ADBH2jgwl6wrQAJ6bfBQ4iaD0
         IyBdlaTxnZTLvrUjcgc8M1E/wUd7ErbC7BNQjmBmA5Aobo3ir4y9Zvzh18jqLlqrpRwj
         kwSq94xEiZixHiHO7HRuNC8sCcuOuj0VRzL6HrRuMh2mYr5pI0VPSbjsVrpb1opUJWFy
         OklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678434657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GyROhr1j9FfQF8Vtrexe5r5+ALuX6utFdZqThyuMXA=;
        b=HFqcaSiccx6xcKXpJ9FaB+luFZAEd28RjPPzT6kI8h0/sR5xH4qbF71WfuOdpaFqCt
         QeC3B1VM8qE9PoRzScOa6e0Am9iAuxAB10WR6lqzQGq+lu3uAlataJW7APXxdNhFgQIm
         T8zvkqo3Y9WOJr7o+5eraoeP9N9zD7D8g3tks9oqXQqluubCJMpyYzYjk3lXnQrq0PfD
         LOZfjpS/vjtjOmRERTDbTckX8HxFobXMt+rDJAdbEOXrOjFOllXBT1tEm9fM1qhTjGBF
         ybUrEMUdQB9vJfiB1SRv3DbC5cBGWHrYqzbp80ArwdQK6uzRz3yfdmo5SNU+Fcxf1QQp
         B8ug==
X-Gm-Message-State: AO0yUKUnKK1IZ3TwUuhvzm9+ViUYV1rY26guEYoAC83l46JjwxKanXsR
        GNknZ458tDK10uu+Ysxt25U=
X-Google-Smtp-Source: AK7set9hQhwK3iMCgRWgS6UtCI1T/Z8QGoIlGWEGX1GQQzZFjQpnhJ2sLInrLunrh3xMiDq3eY5Amg==
X-Received: by 2002:a05:651c:211b:b0:295:b2a1:20e1 with SMTP id a27-20020a05651c211b00b00295b2a120e1mr10537260ljq.21.1678434656921;
        Thu, 09 Mar 2023 23:50:56 -0800 (PST)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id v21-20020a2e2f15000000b002932b817990sm142566ljv.31.2023.03.09.23.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 23:50:55 -0800 (PST)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] hwmon: (ina3221) return prober error code
Date:   Fri, 10 Mar 2023 08:50:35 +0100
Message-Id: <20230310075035.246083-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.39.2
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

ret is set to 0 which do not indicate an error.
Return -EINVAL instead.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/hwmon/ina3221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index e06186986444..f3a4c5633b1e 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -772,7 +772,7 @@ static int ina3221_probe_child_from_dt(struct device *dev,
 		return ret;
 	} else if (val > INA3221_CHANNEL3) {
 		dev_err(dev, "invalid reg %d of %pOFn\n", val, child);
-		return ret;
+		return -EINVAL;
 	}
 
 	input = &ina->inputs[val];
-- 
2.39.2

