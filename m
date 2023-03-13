Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDE86B8039
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjCMSTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjCMSTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:19:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C999B5A6FC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:19:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c10so8173433pfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678731542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qek4QFzg5aoX0CRg0LYKieeL+YfPUejJQDb+/Lp8t1M=;
        b=mmxNMNZHv2j0J2jp64hKGlBki3V/twTrg6jVvdh7fOMXp5M4e1y7x7GPS0vwD3KGqK
         nIseKRnavewPpWx91/uh9dkVRtHRSlmeGh2ufvNVbd18Y1kwscuRY0UAJlnG8ne/UkQQ
         oCV7xHTRWmvA5cNMFB9k2o51uo8+h1cr5GXxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678731542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qek4QFzg5aoX0CRg0LYKieeL+YfPUejJQDb+/Lp8t1M=;
        b=4hGMphq3et0c7/+HMYEs2gUdfMZ9Xft8MBOVzWdFYbWUzj5o6PnVTxmynTHtTRDY9m
         41IXC9SWuTZeEDrkLsJ+ZDRJrX56xPDYeJ7rVv96sGaI7658Jf0fNjHHm97UKb6DQHfM
         FSsk1N3SquL9izIbyZ4sAYwNhZmE781d8skAbRhHiZ6M2Lre+L9LVVVsy53VIqafVuF9
         60K16fK5AOwKi7CCxe6eH01+ddGsWW7lkSBYK95jNcA5npebDQ04+FlSVBY9nRZQ5qO2
         FQel9yM8WX008a2l+giKEeDjoR8YRPClklekidH/EOVloGZMqB4PHJUmHjRN8wxHWb7M
         sxtw==
X-Gm-Message-State: AO0yUKX76nk9GGA1NEYAFKbA4cLW4Kold8Zp5phlWVYwK1rg8VMZAxwf
        52kZOt2fcURqDInG2DgdXa1Pxw==
X-Google-Smtp-Source: AK7set+Z922FC0C+iP8sW7kEXnB8QRkqlD0CjOE/nTy1kGDIuxbmc8/b8OsL25NhvhM4U6nNycSTMQ==
X-Received: by 2002:a05:6a00:1912:b0:594:1f1c:3d3a with SMTP id y18-20020a056a00191200b005941f1c3d3amr12327707pfi.15.1678731541910;
        Mon, 13 Mar 2023 11:19:01 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:79c6:a848:199d:3491])
        by smtp.gmail.com with ESMTPSA id a11-20020aa780cb000000b005ac419804d3sm25169pfn.186.2023.03.13.11.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 11:19:01 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     mka@chromium.org, christian@kohlschutter.com,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] regulator: core: Shorten off-on-delay-us for always-on/boot-on by time since booted
Date:   Mon, 13 Mar 2023 11:18:19 -0700
Message-Id: <20230313111806.1.I2eaad872be0932a805c239a7c7a102233fb0b03b@changeid>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230313181820.2482385-1-dianders@chromium.org>
References: <20230313181820.2482385-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is very close to a straight revert of commit 218320fec294
("regulator: core: Fix off-on-delay-us for always-on/boot-on
regulators"). We've identified that patch as causing a boot speed
regression on sc7180-trogdor boards. While boot speed certainly isn't
more important than making sure that power sequencing is correct,
looking closely at the original change it doesn't seem to have been
fully justified. It mentions "cycling issues" without describing
exactly what the issues were. That means it's possible that the
cycling issues were really a problem that should be fixed in a
different way.

Let's take a careful look at how we should handle regulators that have
an off-on-delay and that are boot-on or always-on. Linux currently
doesn't have any way to identify whether a GPIO regulator was already
on when the kernel booted. That means that when the kernel boots we
probe a regulator, see that it wants boot-on / always-on we, and then
turn the regulator on. We could be in one of two cases when we do
this:

a) The regulator might have been left on by the bootloader and we're
   ensuring that it stays on.
b) The regulator might have been left off by the bootloader and we're
   just now turning it on.

For case a) we definitely don't need any sort of delay. For case b) we
_might_ need some delay in case the bootloader turned the regulator
off _right_ before booting the kernel. To get the proper delay for
case b) then we can just assume a `last_off` of 0, which is what it
gets initialized to by default.

As per above, we can't tell whether we're in case a) or case b) so
we'll assume the longer delay (case b). This basically puts the code
to how it was before commit 218320fec294 ("regulator: core: Fix
off-on-delay-us for always-on/boot-on regulators"). However, we add
one important change: we make sure that the delay is actually honored
if `last_off` is 0. Though the original "cycling issues" cited were
vague, I'm hopeful that this important extra change will be enough to
fix the issues that the initial commit mentioned.

With this fix, I've confined that on a sc7180-trogdor board the delay
at boot goes down from 500 ms to ~250 ms. That's not as good as the 0
ms that we had prior to commit 218320fec294 ("regulator: core: Fix
off-on-delay-us for always-on/boot-on regulators"), but it's probably
safer because we don't know if the bootloader turned the regulator off
right before booting.

One note is that it's possible that we could be in a state that's not
a) or b) if there are other issues in the kernel. The only one I can
think of is related to pinctrl. If the pinctrl driver being used on a
board isn't careful about avoiding glitches when setting up a pin then
it's possible that setting up a pin could cause the regulator to "turn
off" briefly immediately before the regulator probes. If this is
indeed causing problems then the pinctrl driver should be fixed,
perhaps in a similar way to what was done in commit d21f4b7ffc22
("pinctrl: qcom: Avoid glitching lines when we first mux to output")

Fixes: 218320fec294 ("regulator: core: Fix off-on-delay-us for always-on/boot-on regulators")
Cc: Christian Kohlschütter <christian@kohlschutter.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4fcd36055b02..1490eb40c973 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1583,9 +1583,6 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 			rdev->constraints->always_on = true;
 	}
 
-	if (rdev->desc->off_on_delay)
-		rdev->last_off = ktime_get_boottime();
-
 	/* If the constraints say the regulator should be on at this point
 	 * and we have control then make sure it is enabled.
 	 */
@@ -1619,6 +1616,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 
 		if (rdev->constraints->always_on)
 			rdev->use_count++;
+	} else if (rdev->desc->off_on_delay) {
+		rdev->last_off = ktime_get();
 	}
 
 	print_constraints(rdev);
@@ -2668,7 +2667,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 
 	trace_regulator_enable(rdev_get_name(rdev));
 
-	if (rdev->desc->off_on_delay && rdev->last_off) {
+	if (rdev->desc->off_on_delay) {
 		/* if needed, keep a distance of off_on_delay from last time
 		 * this regulator was disabled.
 		 */
-- 
2.40.0.rc1.284.g88254d51c5-goog

