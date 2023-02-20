Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043B669C386
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 01:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBTAOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 19:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBTAOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 19:14:35 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCE9CC24;
        Sun, 19 Feb 2023 16:14:33 -0800 (PST)
Received: from fedori.lan (bc065635.dsl.pool.telekom.hu [::ffff:188.6.86.53])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006F9AF.0000000063F2BB69.002C6C1C; Mon, 20 Feb 2023 01:14:29 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>,
        Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v3 2/3] Input: add ABS_SND_PROFILE
Date:   Mon, 20 Feb 2023 01:13:03 +0100
Message-Id: <1a4752739568afbdbaaff48436d2bb595d2bda0d.1676850819.git.soyer@irl.hu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1676850819.git.soyer@irl.hu>
References: <cover.1676850819.git.soyer@irl.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ABS_SND_PROFILE used to describe the state of a multi-value sound profile
switch. This will be used for the alert-slider on OnePlus phones or other
phones.

Profile values added as SND_PROFLE_(SILENT|VIBRATE|RING) identifiers
to input-event-codes.h so they can be used from DTS.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 Documentation/input/event-codes.rst    | 6 ++++++
 drivers/hid/hid-debug.c                | 1 +
 include/uapi/linux/input-event-codes.h | 9 +++++++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
index b4557462edd7..d43336e64d6a 100644
--- a/Documentation/input/event-codes.rst
+++ b/Documentation/input/event-codes.rst
@@ -241,6 +241,12 @@ A few EV_ABS codes have special meanings:
     emitted only when the selected profile changes, indicating the newly
     selected profile value.
 
+* ABS_SND_PROFILE:
+
+  - Used to describe the state of a multi-value sound profile switch.
+    An event is emitted only when the selected profile changes,
+    indicating the newly selected profile value.
+
 * ABS_MT_<name>:
 
   - Used to describe multitouch input events. Please see
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index e213bdde543a..76fb2ecbbc51 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1018,6 +1018,7 @@ static const char *absolutes[ABS_CNT] = {
 	[ABS_DISTANCE] = "Distance",	[ABS_TILT_X] = "XTilt",
 	[ABS_TILT_Y] = "YTilt",		[ABS_TOOL_WIDTH] = "ToolWidth",
 	[ABS_VOLUME] = "Volume",	[ABS_PROFILE] = "Profile",
+	[ABS_SND_PROFILE] = "SoundProfile",
 	[ABS_MISC] = "Misc",
 	[ABS_MT_TOUCH_MAJOR] = "MTMajor",
 	[ABS_MT_TOUCH_MINOR] = "MTMinor",
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 022a520e31fc..e8d5ee027b40 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -866,6 +866,7 @@
 
 #define ABS_VOLUME		0x20
 #define ABS_PROFILE		0x21
+#define ABS_SND_PROFILE		0x22
 
 #define ABS_MISC		0x28
 
@@ -974,4 +975,12 @@
 #define SND_MAX			0x07
 #define SND_CNT			(SND_MAX+1)
 
+/*
+ * ABS_SND_PROFILE values
+ */
+
+#define SND_PROFILE_SILENT	0x00
+#define SND_PROFILE_VIBRATE	0x01
+#define SND_PROFILE_RING	0x02
+
 #endif
-- 
2.39.2

