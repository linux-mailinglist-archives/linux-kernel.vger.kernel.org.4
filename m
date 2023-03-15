Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799AF6BBD7B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjCOToW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCOToU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:44:20 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF098E192;
        Wed, 15 Mar 2023 12:44:17 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FJZs8l008235;
        Wed, 15 Mar 2023 14:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=Kzw+l8cqcJr1TSQ6WJDIEKu8YNtPoQdgFhRljLL9mF4=;
 b=QqIS5jloX/fG4fXNvugksYi2rctNr25TfrONuwGOD/5T1cUSMqV2v+SMImGU6okdBE2L
 +mdIYZYwbgOnQVPupgyK2z2YVMPN6uQC+OEzyRIuEAgvGod0/B77nPhmdMXpf146qWN0
 J/8pEr8cCgCS4M6Fc08BvgVFFg8pDWmAo/bF44+pJcd/0u+lDBcZmkNDFtc4ObhMJrcw
 8HultaCiuNIPlP+Bf9RJXLMlSHid8EOfSN5mbbLncmCkKil0QTGIPxwrM9bhqzl50zwN
 gvCxO2Br3ThY6fRVYDuym5wU4A8/ZzV715ekhP88EYmNmKl4IeiSqETfrlUsjZ+UAaqJ XA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pb2cr91ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 14:44:15 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 15 Mar
 2023 14:44:13 -0500
Received: from aus-sw-rshr002.ad.cirrus.com (141.131.206.14) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 15 Mar 2023 14:44:13 -0500
Received: by aus-sw-rshr002.ad.cirrus.com (Postfix, from userid 46936)
        id 214064C1266; Wed, 15 Mar 2023 19:44:13 +0000 (UTC)
From:   James Ogletree <james.ogletree@cirrus.com>
To:     <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "James Ogletree" <james.ogletree@cirrus.com>
Subject: [PATCH] Input: support pre-stored effects
Date:   Wed, 15 Mar 2023 19:43:45 +0000
Message-ID: <20230315194345.1848427-1-james.ogletree@cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: g6oMvsgP7Lf9hTueMbDN0cMSzPBFiNLl
X-Proofpoint-GUID: g6oMvsgP7Lf9hTueMbDN0cMSzPBFiNLl
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, the best way to define effects that
pre-exist in device memory is by utilizing
the custom_data field, which it was not intended
for, and requires arbitrary interpretation by
the driver to make meaningful.

Provide option for defining pre-stored effects in
device memory.

Signed-off-by: James Ogletree <james.ogletree@cirrus.com>
---
 include/uapi/linux/input.h | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 2557eb7b0561..689e5fa10647 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -428,17 +428,27 @@ struct ff_rumble_effect {
 	__u16 weak_magnitude;
 };
 
+/**
+ * struct ff_prestored_effect - defines parameters of a pre-stored force-feedback effect
+ * @index: index of effect
+ * @bank: memory bank of effect
+ */
+struct ff_prestored_effect {
+	__u16 index;
+	__u16 bank;
+};
+
 /**
  * struct ff_effect - defines force feedback effect
  * @type: type of the effect (FF_CONSTANT, FF_PERIODIC, FF_RAMP, FF_SPRING,
- *	FF_FRICTION, FF_DAMPER, FF_RUMBLE, FF_INERTIA, or FF_CUSTOM)
+ *	FF_FRICTION, FF_DAMPER, FF_RUMBLE, FF_INERTIA, FF_PRESTORED, or FF_CUSTOM)
  * @id: an unique id assigned to an effect
  * @direction: direction of the effect
  * @trigger: trigger conditions (struct ff_trigger)
  * @replay: scheduling of the effect (struct ff_replay)
  * @u: effect-specific structure (one of ff_constant_effect, ff_ramp_effect,
- *	ff_periodic_effect, ff_condition_effect, ff_rumble_effect) further
- *	defining effect parameters
+ *	ff_periodic_effect, ff_condition_effect, ff_rumble_effect, ff_prestored_effect)
+ *	further defining effect parameters
  *
  * This structure is sent through ioctl from the application to the driver.
  * To create a new effect application should set its @id to -1; the kernel
@@ -464,6 +474,7 @@ struct ff_effect {
 		struct ff_periodic_effect periodic;
 		struct ff_condition_effect condition[2]; /* One for each axis */
 		struct ff_rumble_effect rumble;
+		struct ff_prestored_effect prestored;
 	} u;
 };
 
@@ -479,20 +490,21 @@ struct ff_effect {
 #define FF_DAMPER	0x55
 #define FF_INERTIA	0x56
 #define FF_RAMP		0x57
+#define FF_PRESTORED	0x58
 
 #define FF_EFFECT_MIN	FF_RUMBLE
-#define FF_EFFECT_MAX	FF_RAMP
+#define FF_EFFECT_MAX	FF_PRESTORED
 
 /*
  * Force feedback periodic effect types
  */
 
-#define FF_SQUARE	0x58
-#define FF_TRIANGLE	0x59
-#define FF_SINE		0x5a
-#define FF_SAW_UP	0x5b
-#define FF_SAW_DOWN	0x5c
-#define FF_CUSTOM	0x5d
+#define FF_SQUARE	0x59
+#define FF_TRIANGLE	0x5a
+#define FF_SINE		0x5b
+#define FF_SAW_UP	0x5c
+#define FF_SAW_DOWN	0x5d
+#define FF_CUSTOM	0x5e
 
 #define FF_WAVEFORM_MIN	FF_SQUARE
 #define FF_WAVEFORM_MAX	FF_CUSTOM
-- 
2.25.1

