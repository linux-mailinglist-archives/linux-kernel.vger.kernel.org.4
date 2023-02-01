Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA346868AA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjBAOnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjBAOnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:43:10 -0500
X-Greylist: delayed 491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 06:43:05 PST
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C03D2E80B;
        Wed,  1 Feb 2023 06:43:03 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 432F6C033C;
        Wed,  1 Feb 2023 15:35:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1675262109; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=wvJB0OUDEjfjJl0NbgwhqGyfXYoeQO+CyeH0uszLyk0=;
        b=silF0PZRDEQ+cRx3MXl+8ZK4MfXSgw/Xeu5H/4fxJDygDKC88Zw65FY6WVG3pWEQ9DEWc0
        Liz7qJ8O4M71oGThvh+zL2SIYCziQcwpNs8/M2KvA0TumO6qOo0g0pGIoyNDxteHsGkHG2
        JxyR7kAoeie/HU69iXi7Wvt5qD+zNPrtwdBFTN1M6Y1AAHwsVQkyJJc8WUNoyt5lGWhtI4
        eH5KZfnH8tUtL7cFta9BVXp0h6vqDYuoBkzey2F4UrBFonlCOrJwfx17HVJTVX1uAhfemC
        zFR0NAH3zLARFWNLNg4cVG1cAPOm3hRP+kjVFxtAAYUTB3+Uw6o6xBYgg1fAgw==
From:   Frieder Schrempf <frieder@fris.de>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        keliu <liuke94@huawei.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 5/7] rtc: class: Support setting backup switch mode from devicetree
Date:   Wed,  1 Feb 2023 15:34:27 +0100
Message-Id: <20230201143431.863784-6-frieder@fris.de>
In-Reply-To: <20230201143431.863784-1-frieder@fris.de>
References: <20230201143431.863784-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Some RTC devices like the RV3028 have BSM disabled as factory default.
This makes the RTC quite useless if it is expected to preserve the
time on hardware that has a battery buffered supply for the RTC.

Let boards that have a buffered supply for the RTC available force
the BSM to the desired value via devicetree by setting the
'backup-switch-mode' property.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/rtc/class.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index e5b7b48cffac..79417d1fbeee 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -391,6 +391,11 @@ int __devm_rtc_register_device(struct module *owner, struct rtc_device *rtc)
 	struct rtc_wkalrm alrm;
 	int err;
 
+	struct rtc_param bsm = {
+		.param = RTC_PARAM_BACKUP_SWITCH_MODE,
+		.uvalue = RTC_BSM_DISABLED,
+	};
+
 	if (!rtc->ops) {
 		dev_dbg(&rtc->dev, "no ops set\n");
 		return -EINVAL;
@@ -402,6 +407,15 @@ int __devm_rtc_register_device(struct module *owner, struct rtc_device *rtc)
 	if (rtc->ops->set_offset)
 		set_bit(RTC_FEATURE_CORRECTION, rtc->features);
 
+	/* setup backup switching mode */
+	if (test_bit(RTC_FEATURE_BACKUP_SWITCH_MODE, rtc->features) &&
+	    !device_property_read_u32(rtc->dev.parent, "backup-switch-mode",
+				      (u32 *)&bsm.uvalue)) {
+		err = rtc->ops->param_set(rtc->dev.parent, &bsm);
+		if (err && err != -EINVAL)
+			return err;
+	}
+
 	rtc->owner = owner;
 	rtc_device_get_offset(rtc);
 
-- 
2.39.1

