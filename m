Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442276B01E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjCHIpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCHIom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:44:42 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C4E584A9;
        Wed,  8 Mar 2023 00:44:38 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x3so62514056edb.10;
        Wed, 08 Mar 2023 00:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678265077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cd+3/vfpnAi2wix3cLcUzdEe2v0MfPYk0B4J1TVbZ5E=;
        b=j2gy6Za7s2PA99ZzZIvnsTUjn9VZlKoUqB6HzZY/eOJMxGX7GHyu291VpYGBxw9EKc
         8b17kXynX/xHC1Baiz0dNBN5zErZLRf4l/msDUGrfIbjyGzQ6w+czvSVCiXetIj6HHxF
         SFqI9PQsBucMu8siD528JIxbpJJlglh+WKWbbfEZpFqXDp8UQPfldi5BR5qAKk0Ot3jm
         BXhcVvONBPotNQJl37LdI2ByX+9Y0DgX9pAzwF+Zz0cqERc+7+G/TGA+hrHrbhhT4swF
         SCzQ5Nr94nB44Zi2i8YroGQPQJvdMJto98mvSw7F389xfM7DojdrIkizTMtH4FQkaEee
         l4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678265077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cd+3/vfpnAi2wix3cLcUzdEe2v0MfPYk0B4J1TVbZ5E=;
        b=yPjI+kiyKQ+XRWDucniMfgz4vGnTDB7tbRKDq4xpQi+MF2frWtWd5Se/mJpGv6dONg
         k2hCN6rrUSME6EAHJ036Q93v1L55TojqrCxZKEa+dmyL+5hrnGgVtVAs82N+OSut6xr9
         0vXQgG/E3YRFqO6XiMu/sHpVqclb1AtAjDw/MKS4KbqyE4JvJKhs/xmdjtMuEgpq08VR
         FjDOHql6xYAZJKf/RZyUbEqk2Cfwi9x2yBBLKg58+C228USQh+rwbyiZuGXsNF/5GV6x
         99I+K+knfMZEdhAGpX1LWFvHaIg0iBeTE36viCVL7S2MgIdCsBRurHrp84r78I8AYh9i
         vuWg==
X-Gm-Message-State: AO0yUKWcCZoSnC7hGU30h8Tgz8/H0PEHJPCF1XXPGcriWFrSFWexb2hH
        xF33VG1B9pVJC+uY1WO/C8A=
X-Google-Smtp-Source: AK7set8DDraDcsd5sI0OJZTYCQm7ZR0FlTHBOc0KxBMIRDkKrR75uEUeCwQlpBQdds2fJj3Cy5HXAg==
X-Received: by 2002:a17:906:bfc9:b0:88d:ba89:1837 with SMTP id us9-20020a170906bfc900b0088dba891837mr19294522ejb.8.1678265076869;
        Wed, 08 Mar 2023 00:44:36 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906838800b008ee95ccfe06sm7163891ejx.119.2023.03.08.00.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:44:36 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] power: max17040: add passing props from supplier
Date:   Wed,  8 Mar 2023 10:44:18 +0200
Message-Id: <20230308084419.11934-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308084419.11934-1-clamor95@gmail.com>
References: <20230308084419.11934-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optionally pass status and health from supplier if
it supports those props. If cell is online assume it
is present as well.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/supply/max17040_battery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 2778ed5b5c14..6dfce7b1309e 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -390,6 +390,7 @@ static int max17040_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
+	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = max17040_get_online(chip);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
@@ -402,6 +403,10 @@ static int max17040_get_property(struct power_supply *psy,
 		val->intval = chip->low_soc_alert;
 		break;
 
+	case POWER_SUPPLY_PROP_STATUS:
+	case POWER_SUPPLY_PROP_HEALTH:
+		power_supply_get_property_from_supplier(psy, psp, val);
+		break;
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
 		val->intval = chip->batt_info->technology;
 		break;
@@ -438,10 +443,13 @@ static const struct regmap_config max17040_regmap = {
 
 static enum power_supply_property max17040_battery_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_TEMP_MIN,
-- 
2.37.2

