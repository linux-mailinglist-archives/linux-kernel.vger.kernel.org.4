Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4873861A616
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiKDXq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKDXq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:46:27 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA7E2E9D3;
        Fri,  4 Nov 2022 16:46:26 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id j1-20020a4ad181000000b0049e6e8c13b4so835687oor.1;
        Fri, 04 Nov 2022 16:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=p4lPoKL1RWNuy897FDzE5HGIgTwpr2K0oV8rbjzJsp0=;
        b=oe8xhJj52G5t5uSB76V7g/ZJQK2/x/1DjqYUl0vSZg9seIiLuR+ySI8fzMioxmY49h
         5DkPDEsTpEJTLFwFe1Q6z9YTbfGPeu+n5yyZlgmKW3dR3kUY1YthJGIXNc2+2auO9+e1
         TU8d+Sh8Wa4Q5rpbdajZCZYkA4obP0rbL4CL3Vhw4eP0FzUauUpcslcB3TJNK3r4lLt9
         n00oQnyTEBRgB9UQtkB3YOZ1g7Z7byVYMmiAFn8LsYSiuiuCxjFWUVHzHn3J9Tki+PFR
         ztNH+zui12UpLv30OCnof3I7d2Ovq78L+nRKiVKtFiP8jg0TPIH1p+au+REC93mrb1QT
         jj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4lPoKL1RWNuy897FDzE5HGIgTwpr2K0oV8rbjzJsp0=;
        b=gXJOIL+SAJvnqsAPd1zOS6Qib0rQNkDxCOvK4tW4FL1s08lf0IprWgjhwSpW/pOnT9
         nQ0al1o991L1FHIvE0PG2RypN4vw0oVOgPAyeEsjAPRTtNcjWKwNyd15T5r5gLn57wvp
         /8qGzhVrl492/tSJZB7v+Qz56XSS7mIg75+y8q8hvP7r2FORWKhkFzr3KNJlzeEk4FzG
         jtxkmLJTbJ5vn6OpJLrpAgba8TGOGbBgLPF6vPX9EcIElIsQQ4GcMnt+r61lfcFvJf1J
         3+9mJsK0MahFPA/Pmz+iywfHJdYrK0oCKQADmOsz46640vRllGiDn7h1k2ZgUp+BUWbR
         v90g==
X-Gm-Message-State: ACrzQf3F20YYujjYdzJdQgPZXmPkevjXKiJb0Gzj5N8HVbBZ3M22RY4T
        D3v1S2nC9wqDo1tFICIoWA0YsMz7+WE=
X-Google-Smtp-Source: AMsMyM4AdYlWxjVcGi73/hYvM46Qdj6sGaxqlvAMyY5f5C7L/uq60+WCZpRA9/qBzo+FXVKDwxm8tA==
X-Received: by 2002:a4a:d127:0:b0:49b:2b6f:a074 with SMTP id n7-20020a4ad127000000b0049b2b6fa074mr13006459oor.20.1667605585893;
        Fri, 04 Nov 2022 16:46:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fp19-20020a056870659300b0013b8b3710bfsm203577oab.13.2022.11.04.16.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 16:46:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Zev Weiss <zev@bewilderbeest.net>
Subject: [PATCH] Revert "hwmon: (pmbus) Add regulator supply into macro"
Date:   Fri,  4 Nov 2022 16:46:22 -0700
Message-Id: <20221104234622.2444747-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 54cc3dbfc10dc3db7cb1cf49aee4477a8398fbde.

Zev Weiss reports that the reverted patch may cause a regulator
undercount. Here is his report:

... having regulator-dummy set as a supply on my PMBus regulators
(instead of having them as their own top-level regulators without
an upstream supply) leads to enable-count underflow errors when
disabling them:

    # echo 0 > /sys/bus/platform/devices/efuse01/state
    [  906.094477] regulator-dummy: Underflow of regulator enable count
    [  906.100563] Failed to disable vout: -EINVAL
    [  136.992676] reg-userspace-consumer efuse01: Failed to configure state: -22

Zev reports that reverting the patch fixes the problem. So let's do that
for now.

Fixes: 54cc3dbfc10d ("hwmon: (pmbus) Add regulator supply into macro")
Cc: Marcello Sylvester Bauer <sylv@sylv.io>
Reported-by: Zev Weiss <zev@bewilderbeest.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 7daaf0caf4d3..10fb17879f8e 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -467,7 +467,6 @@ extern const struct regulator_ops pmbus_regulator_ops;
 #define PMBUS_REGULATOR_STEP(_name, _id, _voltages, _step)  \
 	[_id] = {						\
 		.name = (_name # _id),				\
-		.supply_name = "vin",				\
 		.id = (_id),					\
 		.of_match = of_match_ptr(_name # _id),		\
 		.regulators_node = of_match_ptr("regulators"),	\
-- 
2.36.2

