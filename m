Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806DB65AE94
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjABJOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjABJN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:13:57 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E74F21A1;
        Mon,  2 Jan 2023 01:13:56 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso20206876wmb.0;
        Mon, 02 Jan 2023 01:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ce6OmGFq9VZBpGi1vGDY3sSx/S75wdoRU07kB2bZ+9c=;
        b=EoquokVRhdtRVmPK97+iSE9uIv6hKX8ijtFzvLhlHxCQgVpsA/Klrh3kAwvmp0I9GN
         mT7ApOawKh6TRpw0JR23VMK8dGs77ilsEb3PxzEkGfxtB5+slDO/xkeyN5klkwApnrQ5
         T/U5qy38glE2KT/4QQq5mMKtozmgU6fGbcY+9xx22QnRaNLD7J7YzwBosFbdUgbpXuLX
         40NArEMJdV0GHO6ioE9Nl3NllJtW0BKD+P4AdDMfXy3BF6Ub6YYzlh9wP1QHcD0tCuH8
         AHekCt22XUdTKCBVdjWvTrn6drZgLVRnQuEOmQdatJmCGQHTWPsosqCh7Yzj6Wlo7ueq
         ku3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ce6OmGFq9VZBpGi1vGDY3sSx/S75wdoRU07kB2bZ+9c=;
        b=5QaulAi87A8G3p4CQZxmJTQg8DIqZg5P1sdi5tatQdK38OjS9+WZdnfaSDqqeEYIVU
         m63uQ9/o59WSL2Ux2vr/j5lbjn+TiFA0k6QFxekkfEmXZb/9UZUgP+ZPUP3TMn1PQdHr
         e6Jcq9Rm6e9TGSyKH0ftC6rMoPBLe7nSmKTliwOJntAWhLoQVbeubrb1Mh4LF85SZvhd
         TPkNtsP6Vm6Tnm4GP+vSInYu3bhb49RAzCDetNBvRXG5TQEbVr0hP/2lAYCOlcpPzEgR
         0adZZ+ALY4QcEw6td3R+6rqi07L3fsf6TyWxbtHinM2zyGXi+Ko0qnnQNLLyGUmFTHQ2
         UceQ==
X-Gm-Message-State: AFqh2krPltyBo0ZSmtmPrDXq/ve0wWO5yuYoc7980jHwu0CRWAg57oJR
        mscOgCFLT+u0Xhb6ajM+/dEmLdZe8Xitrw==
X-Google-Smtp-Source: AMrXdXs7SCQj0wzyqzkSFxedhqj0UniP7iPuFeZsaG7t8JL9TtTJCkLv4L0H/xAJdi/B+dRMYcN/mg==
X-Received: by 2002:a05:600c:1da3:b0:3d3:4dbc:75ef with SMTP id p35-20020a05600c1da300b003d34dbc75efmr28346951wms.17.1672650835101;
        Mon, 02 Jan 2023 01:13:55 -0800 (PST)
Received: from tpt440p.steeds.sam ([2602:fbf6:10:8::2])
        by smtp.gmail.com with ESMTPSA id n36-20020a05600c3ba400b003b49bd61b19sm44700735wms.15.2023.01.02.01.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 01:13:54 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     pali@kernel.org, sre@kernel.org, brauner@kernel.org,
        linux-kernel@vger.kernel.org,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH 1/1] power: supply: bq27xxx: fix reporting critical level
Date:   Mon,  2 Jan 2023 11:13:26 +0200
Message-Id: <20230102091326.3959978-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.39.0
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

The EDV1/SOC1 flag is set when the battery voltage drops below the
threshold set in EEPROM. From observing the capacity_level reported by
the driver, and reading the datasheet, EDV1 remains set even when
EDVF/SOCF gets set. Thus, bq27xxx_battery_capacity_level() never reaches
the CAPACITY_LEVEL_CRITICAL code path, since CAPACITY_LEVEL_LOW takes
precedence.

This commit fixes the issue by swapping the order in which the flags are
tested. It was tested with bq27200 in the Nokia N900.

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/power/supply/bq27xxx_battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 8bf048fbd36a..5ff6f44fd47b 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1917,10 +1917,10 @@ static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *di,
 	if (di->opts & BQ27XXX_O_ZERO) {
 		if (di->cache.flags & BQ27000_FLAG_FC)
 			level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
-		else if (di->cache.flags & BQ27000_FLAG_EDV1)
-			level = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
 		else if (di->cache.flags & BQ27000_FLAG_EDVF)
 			level = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+		else if (di->cache.flags & BQ27000_FLAG_EDV1)
+			level = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
 		else
 			level = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
 	} else if (di->opts & BQ27Z561_O_BITS) {
@@ -1933,10 +1933,10 @@ static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *di,
 	} else {
 		if (di->cache.flags & BQ27XXX_FLAG_FC)
 			level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
-		else if (di->cache.flags & BQ27XXX_FLAG_SOC1)
-			level = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
 		else if (di->cache.flags & BQ27XXX_FLAG_SOCF)
 			level = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+		else if (di->cache.flags & BQ27XXX_FLAG_SOC1)
+			level = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
 		else
 			level = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
 	}
-- 
2.39.0

