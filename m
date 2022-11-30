Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC88E63DB66
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiK3RDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiK3RCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:02:44 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51206900FF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:59:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d1so28117587wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WyB3ufPbqxDphL9azoYblwx5btpnokUgFLuY6XL+Nc=;
        b=Qw8vJln92qZi9+bWm/VwPlkXpqE5kbwSfK1vxtLp7CiiLYJGCnFsYMF9iIqjee5wts
         oEg9AJ5neOsdRnh7D/6OEy423m7+pl1CF+RSlkgB4v4fmTnvRcsBJRzbXqLvI5hjErHC
         QIQTTeqg3hjRX4gpFye81jXkqrUXz3hchQ4554l8j8w4ssnjC8jTDGIHGfBysn2V3v3g
         KjuOmpGKZTW56uLzTb0fic0oZh3IejPINgzLT6fh/p+mVsbixwBM6vJVlfPmjkmxmPh1
         z4pPgROgv1EUjqHs/+zInYqbozJ3PtwlGAWGnFv9eBoklyIsZm4n/9b2X9c1dQWb2adT
         jtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WyB3ufPbqxDphL9azoYblwx5btpnokUgFLuY6XL+Nc=;
        b=Nfap+6fbV/P+RETlfmtZDQDtJUSP5rOhPehbR1+xJumOECk+nG5yY913ZgNhlNFMRB
         3ZpXvqIvEu1aQEtNJHT32DqcY0R1FsQTE/tWvfzA92Nj2Bx+9qfnZOGcJoabTAa/3cyv
         8KF9qPE8dDXeJOgVNhLSGQREYOxJi5RwUIs/1UBSAU+y/Lxgkqea4/QD6LcogsFWZm/z
         8jdXg58VGH6ggT4JpYcHpMqV4tvWfX2DGSsVPUcw+vWzQkvmwxVRIFISIGIUiCNdL8TD
         XM+Kmj/q09b7n978ftUvPYD7CQVIHN+7A/LHNBuG2XgZNktT0q2B5flgnC7uTmwKLHpH
         HEtw==
X-Gm-Message-State: ANoB5pkTZy7bCyc5j87ZsKdad6anwiK8VBZgazWAJXtgyC7ZpVB8eizO
        x7VWFVzsnk2m5qpXkF3p+5zSKlbPmympzlEV
X-Google-Smtp-Source: AA0mqf4NiWlsIW8ZJF44oc20R+Q1yt9vhWAzRpzkMmQDj+R/2wnJ8xj6lHDYa3uJICsH/jDqHe0qIw==
X-Received: by 2002:a5d:49c5:0:b0:242:2fe2:ffa1 with SMTP id t5-20020a5d49c5000000b002422fe2ffa1mr1851739wrs.96.1669827544793;
        Wed, 30 Nov 2022 08:59:04 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id t67-20020a1c4646000000b003cfa622a18asm6066895wma.3.2022.11.30.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 08:59:04 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v3 1/4] hwmon: (pmbus/core): Update regulator flag map
Date:   Wed, 30 Nov 2022 17:58:29 +0100
Message-Id: <20221130165833.3478555-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221130165833.3478555-1-Naresh.Solanki@9elements.com>
References: <20221130165833.3478555-1-Naresh.Solanki@9elements.com>
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

Add regulator flag map for PMBUS status byte & status input.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 95e95783972a..f5caceaaef2a 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2752,6 +2752,15 @@ struct pmbus_regulator_status_category {
 
 static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] = {
 	{
+		.func = -1,
+		.reg = PMBUS_STATUS_BYTE,
+		.bits = (const struct pmbus_regulator_status_assoc[]) {
+			{ PB_STATUS_IOUT_OC,   REGULATOR_ERROR_OVER_CURRENT },
+			{ PB_STATUS_VOUT_OV,   REGULATOR_ERROR_REGULATION_OUT },
+			{ PB_STATUS_VIN_UV,    REGULATOR_ERROR_UNDER_VOLTAGE },
+			{ },
+		},
+	}, {
 		.func = PMBUS_HAVE_STATUS_VOUT,
 		.reg = PMBUS_STATUS_VOUT,
 		.bits = (const struct pmbus_regulator_status_assoc[]) {
@@ -2768,6 +2777,7 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
 			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
 			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
 			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
+			{ PB_POUT_OP_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
 			{ },
 		},
 	}, {
@@ -2778,6 +2788,18 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
 			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
 			{ },
 		},
+	}, {
+		.func = PMBUS_HAVE_STATUS_INPUT,
+		.reg = PMBUS_STATUS_INPUT,
+		.bits = (const struct pmbus_regulator_status_assoc[]) {
+			{ PB_IIN_OC_FAULT,       REGULATOR_ERROR_OVER_CURRENT },
+			{ PB_IIN_OC_WARNING,     REGULATOR_ERROR_OVER_CURRENT_WARN },
+			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
+			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_OVER_VOLTAGE_WARN },
+			{ },
+		},
 	},
 };
 
@@ -2834,14 +2856,6 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 		if (status & PB_STATUS_POWER_GOOD_N)
 			*flags |= REGULATOR_ERROR_REGULATION_OUT;
 	}
-	/*
-	 * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
-	 * defined strictly as fault indicators (not warnings).
-	 */
-	if (status & PB_STATUS_IOUT_OC)
-		*flags |= REGULATOR_ERROR_OVER_CURRENT;
-	if (status & PB_STATUS_VOUT_OV)
-		*flags |= REGULATOR_ERROR_REGULATION_OUT;
 
 	/*
 	 * If we haven't discovered any thermal faults or warnings via

base-commit: 9494c53e1389b120ba461899207ac8a3aab2632c
-- 
2.37.3

