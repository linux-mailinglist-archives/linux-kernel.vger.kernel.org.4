Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B47647624
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLHTVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLHTUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:20:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02509B285
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:20:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so5677247pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 11:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBUYq/f5W1QpvWQ1L0owj+9liBAfVOZ5HyYf2BUvGw4=;
        b=Yq20ujLHdDmxfsm6nXV56O+R5s3byqsOzEHjK+WiS1J/KE/7s2Me27w3dKPKEBUPXj
         EBxaZvKRup2jGETzG6pHkC4C/xO67Cr3V2UFuWIZ7iYRcD+t8/x/7b6NpJY4r9h9ugBF
         i2f52c853182eqqlzGcIlS/0+SsTPdNlNu2oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBUYq/f5W1QpvWQ1L0owj+9liBAfVOZ5HyYf2BUvGw4=;
        b=I78WiK6/M0LGLVRGDkR8zFF+FbSwj32YoUrhVmdmNiYbwgu5n/etfcu8dAaRnx7q9C
         8GBPpizXpzjd1/NDhTof9ut+h4sWyVvlzIFxcEEcAZeTNXSQaWofs+Pw/etUTuBdlxf5
         zrGwsIBHg3fuuTR5ClF3O+bDNrUUPW8lFDkD7OgAkQw2JIIXBNgDmR/g2r65jHJT4SkN
         f4AtIQfwVDZeQJASWOIZzlTeOfXBMT0Mz+M0fVoD6akNHVWdVuFLVVF/iNq6MciGS66W
         CgDJ3vJw+LMLHqZjRjsgHwqQNeT3+A6m2MZ3KUmLGSWVHX4K1VAXcczheyzT8ghgT3oX
         VAZw==
X-Gm-Message-State: ANoB5pmQfvaBVqQ1y9GoYaWgi+ivK2bnmh+bX+hIXnufwRpG35NjC3LI
        cwEnectNCQjYMsO79mOjWjsIaw==
X-Google-Smtp-Source: AA0mqf7pK4FpReUS3h/Hh2p63l51HOF6nGWZ47zSsvE4GtKIA0vxz1NbgiSFJHh7GgCAGq05255THA==
X-Received: by 2002:a17:903:40cf:b0:189:ccb2:f20a with SMTP id t15-20020a17090340cf00b00189ccb2f20amr3555544pld.49.1670527238392;
        Thu, 08 Dec 2022 11:20:38 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:3aa1:2c62:9ac:4468])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e5c500b00186a2274382sm17112019plf.76.2022.12.08.11.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 11:20:37 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     mka@chromium.org, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Input: elants_i2c: Delay longer with reset asserted
Date:   Thu,  8 Dec 2022 11:20:06 -0800
Message-Id: <20221208111910.5.I6edfb3f459662c041563a54e5b7df727c27caaba@changeid>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221208192006.1070898-1-dianders@chromium.org>
References: <20221208192006.1070898-1-dianders@chromium.org>
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

In order to account for this we let's lengthen the amount of time that
we keep the reset asserted. Let's bump it up from 500us to 5000us.
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

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/input/touchscreen/elants_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index 879a4d984c90..377adf89b25c 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -114,7 +114,7 @@
 /* calibration timeout definition */
 #define ELAN_CALI_TIMEOUT_MSEC	12000
 
-#define ELAN_POWERON_DELAY_USEC	500
+#define ELAN_POWERON_DELAY_USEC	5000
 #define ELAN_RESET_DELAY_MSEC	20
 
 /* FW boot code version */
-- 
2.39.0.rc1.256.g54fd8350bd-goog

