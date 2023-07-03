Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD574613D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjGCRPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGCRPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:15:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4B9CD;
        Mon,  3 Jul 2023 10:15:19 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BB7CE6606F7D;
        Mon,  3 Jul 2023 18:15:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688404518;
        bh=+FspP4SEXLpd8UGez/YnH27IKQxsKfy3tcMyJKUz3yk=;
        h=From:To:Cc:Subject:Date:From;
        b=eShCOhwfHuWkARISle8RvontgqPMwOzK0A+y0Swu8MYAf2U4nHZgrYGt/m7XnOWH1
         /T909DFVycl40YdEOV0Aapa17mXExSkGDaZX0/1dp11i0YqEKfeAhovI4kZsNtPLCC
         cTNMxpS4LKJe2Tn4Zkqldnapn/piPFIBJJtMXSTBU7aiDh18V5QdtoUa9AjJMUCOcs
         trPcGvU2IcCsAVIKsAXy+9ZuHokvhUx5mFwhEu2bLyi/5jWI+sUZKnuizIOyw1+g2d
         BBW7T57VY23pQM+1gsjcgAsSmt30uVQ6sm0Dk5F9mO83+1A2cShO72aMGI40pf57dq
         k5yuX1Vy94Rsg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] thermal/core: Don't update trip points inside the hysteresis range
Date:   Mon,  3 Jul 2023 13:14:44 -0400
Message-ID: <20230703171502.44657-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When searching for the trip points that need to be set, the nearest trip
point's temperature is used for the high trip, while the nearest trip
point's temperature minus the hysteresis is used for the low trip. The
issue with this logic is that when the current temperature is inside a
trip point's hysteresis range, both high and low trips will come from
the same trip point. As a consequence instability can still occur like
this:
* the temperature rises slightly and enters the hysteresis range of a
  trip point
* polling happens and updates the trip points to the hysteresis range
* the temperature falls slightly, exiting the hysteresis range, crossing
  the trip point and triggering an IRQ, the trip points are updated
* repeat

So even though the current hysteresis implementation prevents
instability from happening due to IRQs triggering on the same
temperature value, both ways, it doesn't prevent it from happening due
to an IRQ on one way and polling on the other.

To properly implement a hysteresis behavior, when inside the hysteresis
range, don't update the trip points. This way, the previously set trip
points will stay in effect, which will in a way remember the previous
state (if the temperature signal came from above or below the range) and
therefore have the right trip point already set. The exception is if
there was no previous trip point set, in which case a previous state
doesn't exist, and so it's sensible to allow the hysteresis range as
trip points.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 drivers/thermal/thermal_trip.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index 907f3a4d7bc8..c386ac5d8bad 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -57,6 +57,7 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 {
 	struct thermal_trip trip;
 	int low = -INT_MAX, high = INT_MAX;
+	int low_trip_id = -1, high_trip_id = -2;
 	int i, ret;
 
 	lockdep_assert_held(&tz->lock);
@@ -73,18 +74,34 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 
 		trip_low = trip.temperature - trip.hysteresis;
 
-		if (trip_low < tz->temperature && trip_low > low)
+		if (trip_low < tz->temperature && trip_low > low) {
 			low = trip_low;
+			low_trip_id = i;
+		}
 
 		if (trip.temperature > tz->temperature &&
-		    trip.temperature < high)
+		    trip.temperature < high) {
 			high = trip.temperature;
+			high_trip_id = i;
+		}
 	}
 
 	/* No need to change trip points */
 	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
 		return;
 
+	/*
+	 * If the current temperature is inside a trip point's hysteresis range,
+	 * don't update the trip points, rely on the previously set ones to
+	 * rememember the previous state.
+	 *
+	 * Unless no previous trip point was set, in which case there's no
+	 * previous state to remember.
+	 */
+	if ((tz->prev_low_trip > -INT_MAX || tz->prev_high_trip < INT_MAX) &&
+	    low_trip_id == high_trip_id)
+		return;
+
 	tz->prev_low_trip = low;
 	tz->prev_high_trip = high;
 
-- 
2.41.0

