Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158C27342EE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346322AbjFQSMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjFQSM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:12:26 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA02198C;
        Sat, 17 Jun 2023 11:12:23 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b1fa5a03daso1554334a34.1;
        Sat, 17 Jun 2023 11:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687025542; x=1689617542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuu6We15tgBmKRFOQq5fqWqC4GtSw1jpgOaeBi0Ayzw=;
        b=GuQlaFuamEMUSH3O3JUPfT1Q8M9k7XQjABYy/f0Aspn3IGugK6KxvmlKZ5jUK6C6Lh
         7nLciggPgc+08RGGaGvljPD5h5oYGm3LM4qrX+Uas1bGmFSSnt4MpwYHY/8zG3C8VxnK
         H8QibuiAe8DcHlaVmGq08MFk8Z0E585x385RK+CXCu8YenzOJ5AgDW/L/3mlBRehwfPM
         Fq0GXF3IqzovoHnJr8V98pB70ReYBAkgpEDRRrrx2ZJWnvfx++yMJR31lllUBvCEdWIa
         R8KpndFm1cl3wZAyls2+RUUInUKAYG2+a05HWIwZx6NlGpiBew1pTLNqYXLtCq9E3oed
         2sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687025542; x=1689617542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuu6We15tgBmKRFOQq5fqWqC4GtSw1jpgOaeBi0Ayzw=;
        b=hFF0PBok9uRYCJPgu55kgH/mVkPMsfmvYqCvVVYFjOYZ97YIUdzkcVA+0F5Oy8p68K
         vvBgyEM7qGRvAwxdj+jvXF7aTWeq1/8Vx7AXYF/K2hAoiXfyD1u6esBcudAMR51aiU3p
         dT4ii7LELEGVRPMS5pBZkC7u1+YQydqEoOSAwAy4K10TZ+llJf4xDwbcOT+2EvQWUVXg
         B8XhaCLAku/cGiLoW9nRXZSEfkLY1dUksFZtrTtFCqQlZlhP9lSn+ikidxUBu97MmYeW
         yypGeKaSNLWVScrB3hGf90RAtJWu/LyrNlCbFXSxrWRNSz/Fc5sErnB99twYtb6CSGDb
         BBgQ==
X-Gm-Message-State: AC+VfDz4/aMfYECHIb7c1qwTJVKSapMJkZFmzR2xLwIkm54Bycvow7Rx
        nyJkhSaLh8/WraqcgZHyybM=
X-Google-Smtp-Source: ACHHUZ5F2jQYn3d9244OryEb69DsWV/Z8nKOr0A2p8w+nvC9YTaVWOkeDFCMdPQnm1s5OW+hrcCEGw==
X-Received: by 2002:a9d:7448:0:b0:6af:7fed:1fd3 with SMTP id p8-20020a9d7448000000b006af7fed1fd3mr2677314otk.31.1687025542520;
        Sat, 17 Jun 2023 11:12:22 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id j24-20020a9d7698000000b006adda5cddb7sm6604927otl.62.2023.06.17.11.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 11:12:22 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (oxp-sensors) Simplify logic of error return
Date:   Sat, 17 Jun 2023 15:11:43 -0300
Message-ID: <20230617181159.32844-3-samsagax@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230617181159.32844-1-samsagax@gmail.com>
References: <20230617181159.32844-1-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take return logic on error out of if-else, eliminating
duplicated code in tt_togle_store() function.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
 drivers/hwmon/oxp-sensors.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 584e48d8106e..1e59d97219c4 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -226,13 +226,12 @@ static ssize_t tt_toggle_store(struct device *dev,
 
 	if (value) {
 		rval = tt_toggle_enable();
-		if (rval)
-			return rval;
 	} else {
 		rval = tt_toggle_disable();
-		if (rval)
-			return rval;
 	}
+	if (rval)
+		return rval;
+
 	return count;
 }
 
-- 
2.41.0

