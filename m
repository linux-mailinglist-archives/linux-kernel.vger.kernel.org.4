Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FDB62E489
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbiKQSlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240619AbiKQSlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:41:01 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F7386A44
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:41:00 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id g12so5288287wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Abu7MuicKWdhbXi7GeZMoVbyzQG5Uo0La/ux0RfbuPM=;
        b=YDeXI5kYTHzKyCnnUgdV7IVVA0MucRAImCFhTJ/nwvWMKpCsclRLd57uGjViSpuyQf
         5QS4Wd1qesZDqdBbrRY5Iff+m7iYHJbx4HOLcmL9U2OkdPpZk5nVJuPUr2PoQ8TIpyue
         RNqbifCCzsB7C63G8iIqkylN6Z4HEomyuk1eT20SZmugCvHrHGCQ5r4yilwjmzcMMDz/
         R3E5Grib1eWxFNghcw/0TgUNUxbPAtnh4JybDJ8KJ4Dwl/1dq2RHGE6VfOdgXeacd7wr
         SgxVfFblUmv7USAor2fSMsX78gaK1ZNJRaFIeaaG64N6hS247rS1GHlSv+rr+uyznqLy
         q06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Abu7MuicKWdhbXi7GeZMoVbyzQG5Uo0La/ux0RfbuPM=;
        b=6VrtNvZWWFDQVMbWfK3lP5+NWoQwmUuw1FplDp+9TwGYt6JCktoA/nCt1jDCVxr5bn
         dJK9xmQ3x0UmlPvDYeMW4KxTUoom2Eu2lvJ6tk1KhvtflRV7wtL09IcxJGCP1GKvJomt
         pfS+0VS9OkLIZltavb02rtS9Y5ARKeS12m7lIph7qH+TUiOnQ9hYLz7/oltHj2ICPxtV
         wUzmoMz9xe26g1Z9rYbMOjnTmwqeVIDOp76BHEeSguA/aDRDpiSpRd9JB8/1HumdHMew
         NmOt9TalgPvWFXe1XguJyoVpcroFFkxdWuVS4Gti5sr5odYpwsVbvliarmisGb2ZAkoM
         MBLg==
X-Gm-Message-State: ANoB5pm+koZ8MZcT4f+YBq2xRT10T91qUXuQb/BJ7CZRbQzWniDYj6/E
        NAj6qFW/hzVFAPtkfOmwb/MEEA==
X-Google-Smtp-Source: AA0mqf4BdnRx/m+oA0ZgtYbjk4aNkVVR/ouVsYExnoOn6I+hbYduSDnuH2hbGI32vn6OefJT9Dfpgw==
X-Received: by 2002:adf:e603:0:b0:241:bd28:51f7 with SMTP id p3-20020adfe603000000b00241bd2851f7mr912788wrm.246.1668710459042;
        Thu, 17 Nov 2022 10:40:59 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id fc18-20020a05600c525200b003c71358a42dsm8801370wmb.18.2022.11.17.10.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:40:58 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pmbus core: Add power good support
Date:   Thu, 17 Nov 2022 19:40:22 +0100
Message-Id: <20221117184022.1808508-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
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

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Update error flags with regulation out if regulator is on & power
good status bit is set

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 7ec04934747e..20ca26e19db7 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2827,9 +2827,13 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 	if (status < 0)
 		return status;
 
-	if (pmbus_regulator_is_enabled(rdev) && (status & PB_STATUS_OFF))
-		*flags |= REGULATOR_ERROR_FAIL;
+	if (pmbus_regulator_is_enabled(rdev)) {
+		if (status & PB_STATUS_OFF)
+			*flags |= REGULATOR_ERROR_FAIL;
 
+		if (status & PB_STATUS_POWER_GOOD_N)
+			*flags |= REGULATOR_ERROR_REGULATION_OUT;
+	}
 	/*
 	 * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
 	 * defined strictly as fault indicators (not warnings).

base-commit: 27fea302952d8c90cafbdbee96bafeca03544401
-- 
2.37.3

