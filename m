Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3E469FBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjBVTP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBVTPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:15:55 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEF33A0BD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:15:50 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id b12so1151173ils.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I2c3lg+eD0Vch4RpQWqcPIBMzqi7iy6PEw8ILtwvF7k=;
        b=nM7f3kbWFpK5eMz3TP33DsONrx0dUPXyBQ9urgT0uhsqEzo5yKgunv8MjuMgEFPlFf
         Ptkx6NTZkhwDeZBBChJ/2MHr8B3tJcNa1g2A/gly43vIZaqQK/owG6pe+hX24yAfHHAC
         HGZ4Qwnw6Y2Xyjdz/rIFyQcajwP6BXzc353mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2c3lg+eD0Vch4RpQWqcPIBMzqi7iy6PEw8ILtwvF7k=;
        b=kD1MtuHlkGAn/1eQ+jyJWt76P2z2UIhFx1sHgcBDLK0ABJhVY9AVLA3iMSmAj2AEe3
         6l2kebQZl8ZHQU1cfbiijEAwZsW5osGIDAceih8O9euZ/OgjMQ4HQSbAtyWz39WcKuwY
         4iKRklKMc/Wr4U2rPwMKqWs0mpldgyrnL03/CgvpDqBPDaK1LWew+NHbnT9VCcbcK9ut
         WuPcgRcfHS7DPifih2+kkJGKuBveGD4uIpG2YQ0MYTv8l6wHvmR+O87db1v4QZPN2QaI
         bNdIXFa0UeEF8GHigQ6qtLwzI3AVyO26t6Ejkh41UTSxfQFL+3zuLfDPe42HBHJC/eVa
         xc0Q==
X-Gm-Message-State: AO0yUKXJP5q2kfKnIx9Ps7jarJDVTOBqFAHrS1T/SkIZ4E/GaFozIlA6
        OgItZYZSUbYMzDII6inW2TE/iw==
X-Google-Smtp-Source: AK7set+Kx4qOBhb7aHna/RNkAittWxiCvUfJ+f6eh6nbB2r0zMDVL1NrXtJvFKZULmqbxQ9Ia+8UYQ==
X-Received: by 2002:a92:7a06:0:b0:315:8bc0:1d85 with SMTP id v6-20020a927a06000000b003158bc01d85mr7077253ilc.11.1677093349797;
        Wed, 22 Feb 2023 11:15:49 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id g2-20020a0566380c4200b003c4f55da7easm1403449jal.45.2023.02.22.11.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 11:15:49 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] regulator: core: Use ktime_get_boottime() to determine how long a regulator was off
Date:   Wed, 22 Feb 2023 19:15:46 +0000
Message-Id: <20230222191537.1.I9719661b8eb0a73b8c416f9c26cf5bd8c0563f99@changeid>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For regulators with 'off-on-delay-us' the regulator framework currently
uses ktime_get() to determine how long the regulator has been off
before re-enabling it (after a delay if needed). A problem with using
ktime_get() is that it doesn't account for the time the system is
suspended. As a result a regulator with a longer 'off-on-delay' (e.g.
500ms) that was switched off during suspend might still incurr in a
delay on resume before it is re-enabled, even though the regulator
might have been off for hours. ktime_get_boottime() accounts for
suspend time, use it instead of ktime_get().

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/regulator/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ae69e493913d..4fcd36055b02 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1584,7 +1584,7 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 	}
 
 	if (rdev->desc->off_on_delay)
-		rdev->last_off = ktime_get();
+		rdev->last_off = ktime_get_boottime();
 
 	/* If the constraints say the regulator should be on at this point
 	 * and we have control then make sure it is enabled.
@@ -2673,7 +2673,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		 * this regulator was disabled.
 		 */
 		ktime_t end = ktime_add_us(rdev->last_off, rdev->desc->off_on_delay);
-		s64 remaining = ktime_us_delta(end, ktime_get());
+		s64 remaining = ktime_us_delta(end, ktime_get_boottime());
 
 		if (remaining > 0)
 			_regulator_delay_helper(remaining);
@@ -2912,7 +2912,7 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
 	}
 
 	if (rdev->desc->off_on_delay)
-		rdev->last_off = ktime_get();
+		rdev->last_off = ktime_get_boottime();
 
 	trace_regulator_disable_complete(rdev_get_name(rdev));
 
-- 
2.39.2.722.g9855ee24e9-goog

