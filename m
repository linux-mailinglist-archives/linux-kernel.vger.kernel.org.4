Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AB863292D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKUQPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiKUQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:15:45 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3084AD28BF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:15:45 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:4821:1ba5:2638:5c3a])
        by laurent.telenet-ops.be with bizsmtp
        id n4Fj2800Y5WXlCv014Fjsj; Mon, 21 Nov 2022 17:15:43 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox9SR-0019aB-5j; Mon, 21 Nov 2022 17:15:43 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox9SQ-00BS6W-Bu; Mon, 21 Nov 2022 17:15:42 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] pwm: Move pwm_capture() dummy to restore order
Date:   Mon, 21 Nov 2022 17:15:41 +0100
Message-Id: <96b39e1fe0e0c239d56ce321ccbf62cd38133803.1669047294.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the dummy pwm_capture(), to make the declaration order of all
dummies to match the declaration order of the real functions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
v2:
  - Add Acked-by.
---
 include/linux/pwm.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index bba492eea96c5552..991ecfe1a85d3a98 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -440,13 +440,6 @@ static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
 	return -EINVAL;
 }
 
-static inline int pwm_capture(struct pwm_device *pwm,
-			      struct pwm_capture *result,
-			      unsigned long timeout)
-{
-	return -EINVAL;
-}
-
 static inline int pwm_enable(struct pwm_device *pwm)
 {
 	might_sleep();
@@ -458,6 +451,13 @@ static inline void pwm_disable(struct pwm_device *pwm)
 	might_sleep();
 }
 
+static inline int pwm_capture(struct pwm_device *pwm,
+			      struct pwm_capture *result,
+			      unsigned long timeout)
+{
+	return -EINVAL;
+}
+
 static inline int pwm_set_chip_data(struct pwm_device *pwm, void *data)
 {
 	return -EINVAL;
-- 
2.25.1

