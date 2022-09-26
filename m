Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B0D5EAA47
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbiIZPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbiIZPSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:18:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D537C80F5E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n15so10421580wrq.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=re6cY3b7LhtgjVns3TGnT3S1+gVlK6XqwvcFa/mv1ME=;
        b=UArrlRfiA7hARrUKxyfl5qW5zdqodgK/nppx0Qeo6Z/EJdqqMPBoC/UCikPkNEwTrE
         lBAoUIl/x4G/04V/BApjMHBMdKDHRzN8E/qaxzUlkK7rHiGTRgzLdMrG1q0J3wsgnnVL
         bcN8FS7xv105kiyJrwcTUuwNz5YE85Jji0WjSVqkRfuRHCZlTEu/RD30Z04+IHa7uUgD
         ewnho3xP3gZGvAAB6EabBd1MgKPjhhGg3ycL7L2SNURc2F4cykFcGmI0ABEF3Zq2lume
         +bfjp6DH21cnDgFr9VixSciEa1dyLp86NobKr26L3h5dV2Eaev3k2qxQ6bPp41KkOwW3
         gWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=re6cY3b7LhtgjVns3TGnT3S1+gVlK6XqwvcFa/mv1ME=;
        b=kZQKaCl8dwa1jflaAEHHA3pEpk3ymkG/fHE4hKkKFL95VA1OSLJQ3hJdq1Vv6DO2az
         7Wx0X55CRumV+TLBMs8jUFe6npuD2iqAmZq+m+isjG03wbvfZWu9vEdN9jHzoTEiq2FU
         M7MpmvDjD+0Q1Pm+NiAS8VgmZzgb5y6/ipiSoIh3w1bFjmDqT19kD/ky7/0s0ypigKLS
         bbVekUdGy9UTQkLhke2xaEPqKDtY9q/1G9zttNOk2oHBWUiGwaDAfuNfhWGs94v0Vt9y
         Ae5RIVvaOhgKGEqEr/eutgyPKrCgSIA0hIbwruMyfvfFkig3rne9/YPokwFjUdS1/bGn
         ZgAQ==
X-Gm-Message-State: ACrzQf0hdqo2n3PyfkRU73FtSkRm1bO36jhYFkKlszOFIPFp+5MF7ljA
        c2SfG8G2IEPSdrXzYxRM4gSwaA==
X-Google-Smtp-Source: AMsMyM7x8Bz2InUxuLwoQQqUMfcUpSu5SW4qKXBpq6+/e1iKeNRs9vA4dkjkDNjUT01Bccc3Cia69Q==
X-Received: by 2002:a05:6000:1864:b0:22a:e349:f031 with SMTP id d4-20020a056000186400b0022ae349f031mr13752016wri.476.1664201178267;
        Mon, 26 Sep 2022 07:06:18 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:17 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 02/30] thermal/sysfs: Do not make get_trip_hyst optional
Date:   Mon, 26 Sep 2022 16:05:36 +0200
Message-Id: <20220926140604.4173723-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
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

The get_trip_hyst() ops is optional. It results all around the thermal
framework code a check against the ops pointer and different action
adding more complexity and making the code less readable and
understandable.

A zero hysteresis value is perfectly valid, so instead of adding more
circumvolutions in the code, create unconditionnaly the hysteresis and
use the thermal_zone_get_trip() function which returns a zero
hysteresis if the get_trip_hyst() is not defined.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 75f6b151a58b..18cdd7cd0008 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -424,23 +424,20 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		return -ENOMEM;
 	}
 
-	if (tz->ops->get_trip_hyst) {
-		tz->trip_hyst_attrs = kcalloc(tz->num_trips,
-					      sizeof(*tz->trip_hyst_attrs),
-					      GFP_KERNEL);
-		if (!tz->trip_hyst_attrs) {
-			kfree(tz->trip_type_attrs);
-			kfree(tz->trip_temp_attrs);
-			return -ENOMEM;
-		}
+	tz->trip_hyst_attrs = kcalloc(tz->num_trips,
+				      sizeof(*tz->trip_hyst_attrs),
+				      GFP_KERNEL);
+	if (!tz->trip_hyst_attrs) {
+		kfree(tz->trip_type_attrs);
+		kfree(tz->trip_temp_attrs);
+		return -ENOMEM;
 	}
 
 	attrs = kcalloc(tz->num_trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
 	if (!attrs) {
 		kfree(tz->trip_type_attrs);
 		kfree(tz->trip_temp_attrs);
-		if (tz->ops->get_trip_hyst)
-			kfree(tz->trip_hyst_attrs);
+		kfree(tz->trip_hyst_attrs);
 		return -ENOMEM;
 	}
 
@@ -473,9 +470,6 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		}
 		attrs[indx + tz->num_trips] = &tz->trip_temp_attrs[indx].attr.attr;
 
-		/* create Optional trip hyst attribute */
-		if (!tz->ops->get_trip_hyst)
-			continue;
 		snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_hyst", indx);
 
@@ -512,8 +506,7 @@ static void destroy_trip_attrs(struct thermal_zone_device *tz)
 
 	kfree(tz->trip_type_attrs);
 	kfree(tz->trip_temp_attrs);
-	if (tz->ops->get_trip_hyst)
-		kfree(tz->trip_hyst_attrs);
+	kfree(tz->trip_hyst_attrs);
 	kfree(tz->trips_attribute_group.attrs);
 }
 
-- 
2.34.1

