Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362B167C958
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbjAZLCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjAZLCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:02:47 -0500
X-Greylist: delayed 607 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Jan 2023 03:02:41 PST
Received: from smtpweb146.aruba.it (smtpweb146.aruba.it [62.149.158.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A4B93E4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:02:41 -0800 (PST)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id KzrppyQ5bn7VrKzrwpdlvQ; Thu, 26 Jan 2023 11:52:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1674730357; bh=H9c79j0VtyhTiRS4TnW7zV7MIRdHfFiRAQrVb9wLVoY=;
        h=From:To:Subject:Date:MIME-Version;
        b=O3rbeiY+zrMVxTbxh3oMC4P4PXec6OLmpaFUaYqGexZoQ+XcA9+n48HJJBntLH7ZF
         s9hu/lxR9Ea54dt5iyJOC6DdJApWdYH/CWYmvCJov6L0ejNPZDT+6wZJSZfgfiEHrJ
         e0+LOfrnZ0sdGdZF+nEDX7M7TlIAbO5/vSEsxXeDqW2UzFYZN4S2Fg4En6Y19rUUG8
         gOVvPrGZP9y2TGf0ydPaol5gWVEYhFOnGMb7ad5EuoJw0p5oXUN/27WWFFykUCEFdg
         TzeWhdKkadu59yX4Al9OVcrptfV0mCkmXi63jM0kJT0W6ORD9AOTNDKFrcxN47889o
         0O9BRk8vCUgCw==
From:   Luca Ellero <l.ellero@asem.it>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH 3/3] Input: ads7846 - don't check penirq immediately for 7845
Date:   Thu, 26 Jan 2023 11:52:27 +0100
Message-Id: <20230126105227.47648-4-l.ellero@asem.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230126105227.47648-1-l.ellero@asem.it>
References: <20230126105227.47648-1-l.ellero@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHuIE2j3bYbK5nB8eUKiELfmmJoV7gdzP7PFvJTlXY4Xl56qJKHKJb088FjYoJkUOYVRgPpTD5KR7VnGDT8bhHEjyC90kwKQ8uawkqsGN0vnVOhLJnk5
 7CoTpTJr0SBXgEi1BRYUuE/4u4ilXoLEAoqtF0M/AEdAH6gHJ/6eXXw3lH0i+3weLKvmbn0y7rvRjGhDQ3EQpELyTFGNk6/PIeCm3TT8OjIiNhTI+2dc6ILE
 kM3bZMsV9Ew/fi+38tX9HREKBX+sqw+66+fFZDSR3SeprG3qNGGXWop61ErY1V0E75rIEQtdAw0aVbvT106JLx4RDZQnGsBCzPW1kcdhJmqhwlSJBPBsS1u9
 58QVty2YIlt5Hai2jnrUGXVNr7y9KT4YfRYj7u0iuYDaqr4nKvxW3GxfwpKyRYGuAC04kgb2AAL34HrTgt7gJ9ndp8ad6RGRo5zsZKTm24Lpsv9q6Beoq54O
 IOFfbAr6XFVy0XhRVKublbFj/vwbJaGrAHokHnPfDUDbkzIGSfas0U6ZFGWlrJJOCxX0xx+CUnIG+btP++FZ07Vk5IM+hVi9Uc/AbNr50tQaq4M8heVJmsSD
 SMWI204EqQxoCHssmTJyb2+P
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To discard false readings, one should use "ti,penirq-recheck-delay-usecs".
Checking get_pendown_state() at the beginning, most of the time fails
causing malfunctioning.

Fixes: ffa458c1bd9b ("spi: ads7846 driver")
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

