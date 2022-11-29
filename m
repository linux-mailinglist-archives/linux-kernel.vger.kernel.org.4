Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9444E63C3CB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiK2Paj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiK2Pag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:30:36 -0500
X-Greylist: delayed 622 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Nov 2022 07:30:32 PST
Received: from smtpcmd04131.aruba.it (smtpcmd04131.aruba.it [62.149.158.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A8066315F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:30:32 -0800 (PST)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id 02Ozp6txJm9gv02PLpWxUk; Tue, 29 Nov 2022 16:20:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1669735228; bh=loRkK3v18v6DijDl9IFXyx+yOfz6h4JPvTbCHffpCLU=;
        h=From:To:Subject:Date:MIME-Version;
        b=NVog6tFKruhE4LHx4UXgTbTlJRMCJ09Mesd28Y1WSlXkGshLggIOoDcdrvOt684/f
         SpEDYj8adL30DmT/9Hv3vWIp8wY9cnyrKReW07yj8bkCJtRiCct7+vxoJ9P8wgQ9sJ
         WEx6bpst52PkcMuhzCyMvx8ovPwfKVA32Z0cgvk7rAoGTyy2lsay0gBimtbPKDyLLO
         ok8Im3Gfi7dfTCCprKTqdqyhLQoH23wT8tFiXx2HpEZeD4a2v56bvcn3Te34J/jAzv
         KbbpKjRLhG9gjcol8/9I/Upg1Q97eX+KbVII7X4P8+yCBf8SSa3Z3UDGtS4/kPYs4b
         8JiTlx7Du4OzQ==
From:   Luca Ellero <l.ellero@asem.it>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH 3/3] ads7846: don't check penirq immediately for 7845
Date:   Tue, 29 Nov 2022 16:19:59 +0100
Message-Id: <20221129151959.26052-4-l.ellero@asem.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129151959.26052-1-l.ellero@asem.it>
References: <20221129151959.26052-1-l.ellero@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPYgu1vwqK7707YHL9+lchuSqtqnDkS9kvjahqpsSp7Xa4s3YkRoB80VbCh+Hclx9Lqq/tvTOYfd+z/N1RpqouOgqeBV41BZDtVBFrVjW2rqD25cL63O
 +NT1tz+G+LHT1wA3I+hRqswcuHn3xNi+AoEwPxvhM47C/ggi6NcOidSvPiOuaASNEvyqNnV5hBvTEJmck1ho1TT7T7bP5veh4bB7fhagCqfQ/91R7zFG9Pt6
 P210cEjQHfXqV5OEQJ3LUXEuIsn5Kchh3oYW/ZuymzC0odv0bhCGRM7+3iqrUpAxkgvgfaBaTVt2kcWMbcVIc0A4niOE0cdGgGLnpZ3++qw+Hfmzoi9Rv2YX
 MU1atxttLF27kcvkckMLmLWxnAYx2buzNrxYp5hRcXqxD7aobfMxlnXT6+ero3uqN4Qggy2iUpaDZIz6xP8/yZvW70oJoGmVBClPZiAoX6s0U/mHnUN41XEZ
 fjdTuPxpaI8c1idaT2EVrNWqTtras8dxd3Miym5RLYX4o/inLr7G7275/YUC7vXL5M/Bl9t6kKR7vXa8P60o/pbdMQwAl+1YRWsRMFPZL1WJPihQRWUTXnz/
 2ZQ9ZL/j0LgA0No50m1NF2F/
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
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
index 9e15cdf6faa0..122d3a13b7c5 100644
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

