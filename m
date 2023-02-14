Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5356970BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjBNW2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBNW2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:28:03 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD69E3AA;
        Tue, 14 Feb 2023 14:28:02 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9DDD1240003;
        Tue, 14 Feb 2023 22:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676413681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BmYZR4JrM9x4aQG1Rp/o53TgezZzLn9T7oax1lvX/z0=;
        b=PZhpJoxCdK7NRs44h/0bsCm3xy4wWnw6ovLhnqD4I38qF7IiWc63+sHXJWBdY6eGx24Pks
        KVB+ulpGunOge+LZoCcTK/lYuGLpc39zPujxduwQ1kP9t54I3ZlPAAqZYpRpTcwaMSB3Gl
        o7SaWWy+GC4dxaZzWU8GO3fhNdGcjr9UyRymmK65hrV89ikXYuvt4qsKUbVXny3o46S1JZ
        bp6JhDGARq4NSZ9wEursUHRUiuzvWL+EbjZu87hg3ZOoTKLt5nFN8KSdbWgaxbcqxpL3ed
        3hNqwx0OazR9liMxaYUU7bleuQVR5vBswZhIOrKewzLNCAaT9lOELBgbKZO/XA==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Zhipeng Wang <zhipeng.wang_1@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: allow rtc_read_alarm without read_alarm callback
Date:   Tue, 14 Feb 2023 23:27:53 +0100
Message-Id: <20230214222754.582582-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

.read_alarm is not necessary to read the current alarm because it is
recorded in the aie_timer and so rtc_read_alarm() will never call
rtc_read_alarm_internal() which is the only function calling the callback.

Reported-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Fixes: 7ae41220ef58 ("rtc: introduce features bitfield")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 7c30cb3c764d..499d89150afc 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -392,7 +392,7 @@ int rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 		return err;
 	if (!rtc->ops) {
 		err = -ENODEV;
-	} else if (!test_bit(RTC_FEATURE_ALARM, rtc->features) || !rtc->ops->read_alarm) {
+	} else if (!test_bit(RTC_FEATURE_ALARM, rtc->features)) {
 		err = -EINVAL;
 	} else {
 		memset(alarm, 0, sizeof(struct rtc_wkalrm));
-- 
2.39.1

