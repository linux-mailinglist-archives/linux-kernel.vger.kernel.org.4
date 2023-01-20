Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C889675511
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjATM4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjATM4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:56:14 -0500
X-Greylist: delayed 614 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Jan 2023 04:56:09 PST
Received: from smtpcmd13147.aruba.it (smtpcmd13147.aruba.it [62.149.156.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 366215FD4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:56:08 -0800 (PST)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id IqmFpgGfF6DTZIqmTpKxFZ; Fri, 20 Jan 2023 13:46:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1674218765; bh=clriM8z2Ncxi4fAOWxWB+jvP5/EzqBX4gQWuMCxv8Rc=;
        h=From:To:Subject:Date:MIME-Version;
        b=lapgEq5sABIekSkKB7RRhsJtMtwhjbDABv5/vkkYXQiX8pNUKyz688adxNjhZ2zzJ
         aBS4Ulqu+3DE6/nbW90rOT/SeyxCCmfDnHD57Fz1ft0NLYNPIo6/wK74/FpmK6j6Ez
         I1H3UMADDinPvpzsDIA5TBF46lJW8FnQbYr84rawt+tD+U5rbSAjmEWNMpiOnYb8Bz
         a/67B8Ppmt9tSQnZGBhArZ13tsWmgYtJ07g7G3mwner/ATveXd+Nltr95+S9pWfBxQ
         nKEvvdR7B3U2+9Ri4EWpiqCt8mBkReScTn15GJ6iZ6xBjGlBRpaqLQTN9wpR+Evb84
         8S8mbSSQvGUbw==
From:   Luca Ellero <l.ellero@asem.it>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH 3/3] Input: ads7846 - don't check penirq immediately for 7845
Date:   Fri, 20 Jan 2023 13:45:44 +0100
Message-Id: <20230120124544.5993-4-l.ellero@asem.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230120124544.5993-1-l.ellero@asem.it>
References: <20230120124544.5993-1-l.ellero@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOvKTel4AMy9mgv2aDCh+FC7Vu9mcAlOTWAUNZhZU3ZJd12ZBlI7VzbaTcXCOZ0luEXUJl0JhyM9KQ/248BtB5tDHZOdHYGEgfz3HnguekQ22mR8Tt6a
 U1MwQVQYjkiSBPu8dWNrN1A2ctYlGtJLNfvZ7yLoCDZ1tUIscrw5ky5NfNtAc53lhgMPfvpq26SsA5VISmW43Yj3LV7y8NEL73caQY0TEqgUr6kMPqT/8oPK
 nwS+lkVWYQe1qC5JJG6j9K2qXTjdM8lRAgvyneJ8joTW/WUm0midKwpucCxUJrMO/9y6SkFmW+SoQSl3EHO/HhBZY01/DBxuSdHJO6SpTaaV42ZvMlI1kn5H
 AwEbFl/Bf9nIpaJ7mzERFwg+dTIqy3ZTKSghLT1lClMrnsUM+ktd/YvvP+M+cF5NhdDW4ox97kko00FFiMVIi9c/8HYRROlqkUwOXdRddg5QYVqv7cOhELwA
 eVJSpM6/z9zW52gHDqQrfxs4H96S0/FJmPXcB9gx8dnNC3RsxciOi1sU2Qi6m7GeuQfwomipWai94uzfBUiKmkT5Qvwk/2L1oJG9aQY+dECVsi5laKRji+yp
 Q8LMq6Nx90Vfo4bHCPL/ATaX
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To discard false readings, one should use "ti,penirq-recheck-delay-usecs".
Checking get_pendown_state() at the beginning, most of the time fails
causing malfunctioning.

Signed-off-by: Luca Ellero <l.ellero@asem.it>
---
 drivers/input/touchscreen/ads7846.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 15da1047a577..17f11bce8113 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -843,14 +843,8 @@ static void ads7846_report_state(struct ads7846 *ts)
 	if (x == MAX_12BIT)
 		x = 0;
 
-	if (ts->model == 7843) {
+	if (ts->model == 7843 || ts->model == 7845) {
 		Rt = ts->pressure_max / 2;
-	} else if (ts->model == 7845) {
-		if (get_pendown_state(ts))
-			Rt = ts->pressure_max / 2;
-		else
-			Rt = 0;
-		dev_vdbg(&ts->spi->dev, "x/y: %d/%d, PD %d\n", x, y, Rt);
 	} else if (likely(x && z1)) {
 		/* compute touch pressure resistance using equation #2 */
 		Rt = z2;
-- 
2.25.1

