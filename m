Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BB2647BF5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiLICHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 21:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLICGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:06:35 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD72A0F85
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 18:06:34 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id m4so3395670pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 18:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYHKt7eErryFsunPtjvbbKSRjv/mzx815uk+wD/pTQA=;
        b=d49/UoZlVE5w3d9YzUdP39J9v1X4sYnfWRYbfkz4kRMG3f3MBGnFZoF8oeyfpj09BG
         cFP+PcSftvmWByGj00bsk6B8QOC0edfwZ/94cvliN5dhM3a6QtVOi6KQzImXE4Xu1ie/
         gkorIwsbpNx6+8bg3nBEGTwD/wgAQHl4nCDkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYHKt7eErryFsunPtjvbbKSRjv/mzx815uk+wD/pTQA=;
        b=aLOEA/lHKhTn2+cmVrlxnIFYjFNz1xdQVeKpKOWeTBY4fzXtNM6O7sJVWw/hlmn6GO
         sm0ICmBjItoR+LHGrVjXpqd7AHa0c9ZX80u0TcN7UVJFDmJx5thBijtYUFd7qlfE33wJ
         FRFN92gejCKMPakWI71iJ1SjJ2NHmY7YmSBfeyECFpKuwIg6ZuVf1z39fnMGLIwIqAgG
         rCIAm3T18Wld9Q9jWnMrkxPZLcRKSKlTj5gVIee8nUjlYkYWyw5YuwurapdS5xLYvTzA
         UEIWwMdchdXhJdUmwSWVTg8q0QPLD4rkfEaTnheXds0+C0gUMB8KakeB0uU66l9YOWS3
         908w==
X-Gm-Message-State: ANoB5pmaBkMsGknHHJxsUmsEloFHhP7mN9DyVRT/FbKx5ZRMalUCfxSc
        U5RmOv+fLmnrniL8ms7iE8rANw==
X-Google-Smtp-Source: AA0mqf7uDUzumlQz01jBVxnxyEVFcy0Yo5fQx0dH1g79MUe7PgisOwmPsSg6vsxK4/zwUphVR1W31w==
X-Received: by 2002:a17:90a:5281:b0:212:f0fe:bb45 with SMTP id w1-20020a17090a528100b00212f0febb45mr4080802pjh.40.1670551594503;
        Thu, 08 Dec 2022 18:06:34 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9a82:7898:7bf4:b4f])
        by smtp.gmail.com with ESMTPSA id h3-20020a17090a648300b00218ddc8048bsm233473pjj.34.2022.12.08.18.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 18:06:34 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, mka@chromium.org,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-input@vger.kernel.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] Input: elants_i2c: Delay longer with reset asserted
Date:   Thu,  8 Dec 2022 18:06:12 -0800
Message-Id: <20221208180603.v2.5.I6edfb3f459662c041563a54e5b7df727c27caaba@changeid>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221209020612.1303267-1-dianders@chromium.org>
References: <20221209020612.1303267-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The elan touchscreen datasheet says that the reset GPIO only needs to
be asserted for 500us in order to reset the regulator. The problem is
that some boards need a level shifter between the signals on the GPIO
controller and the signals on the touchscreen. All of these extra
components on the line can slow the transition of the signals. On one
board, we measured the reset line and saw that it took almost 1.8ms to
go low. Even after we bumped up the "drive strength" of the signal
from the default 2mA to 8mA we still saw it take 421us for the signal
to go low.

In order to account for this let's lengthen the amount of time that we
keep the reset asserted. Let's bump it up from 500us to 5000us.
That's still a relatively short amount of time and is much safer.

It should be noted that this fixes real problems. Case in point:
1. The touchscreen power rail may be shared with another device (like
   an eDP panel). That means that at probe time power might already be
   on.
2. In probe we grab the reset GPIO and assert it (make it low).
3. We turn on power (a noop since it was already on).
4. We wait 500us.
5. We deassert the reset GPIO.

With the above case and only a 500us delay we saw only a partial reset
asserted, which is bad. Giving it 5ms is overkill but feels safer in
case someone else has a different level shifter setup.

Note that bumping up the delay to 5000 means that some configs yell
about using udelay(). We'll change to using usleep_range(). We give a
small range here because:
- This isn't a delay that happens very often so we don't need to worry
  about giving a big range to allow for power efficiency.
- usleep_range() is known to almost always pick the upper bound and
  delay that long and we really don't want to slow down the power on
  of the touchscreen that much.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- Fix typo in commit message (Matthias)
- udelay -> usleep_range (Patches Robot, Dmitry)

 drivers/input/touchscreen/elants_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index 879a4d984c90..192d543e5aa9 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -114,7 +114,7 @@
 /* calibration timeout definition */
 #define ELAN_CALI_TIMEOUT_MSEC	12000
 
-#define ELAN_POWERON_DELAY_USEC	500
+#define ELAN_POWERON_DELAY_USEC	5000
 #define ELAN_RESET_DELAY_MSEC	20
 
 /* FW boot code version */
@@ -1352,7 +1352,7 @@ static int elants_i2c_power_on(struct elants_data *ts)
 	 * We need to wait a bit after powering on controller before
 	 * we are allowed to release reset GPIO.
 	 */
-	udelay(ELAN_POWERON_DELAY_USEC);
+	usleep_range(ELAN_POWERON_DELAY_USEC, ELAN_POWERON_DELAY_USEC + 100);
 
 release_reset_gpio:
 	gpiod_set_value_cansleep(ts->reset_gpio, 0);
-- 
2.39.0.rc1.256.g54fd8350bd-goog

