Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73476028DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJRJ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJRJ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:56:17 -0400
X-Greylist: delayed 13237 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Oct 2022 02:56:12 PDT
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E9DA2A85;
        Tue, 18 Oct 2022 02:56:12 -0700 (PDT)
X-QQ-mid: bizesmtp73t1666086939tfc7fd05
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 18 Oct 2022 17:55:33 +0800 (CST)
X-QQ-SSF: 01400000000000C0K000000A0000000
X-QQ-FEAT: bQsUcYFpAAYBiBHsWQunkLgscl2cKPYwrjfuIFuXB3Pw4YAWydLHFD4pq8yv0
        zIRhg0mXP01fi/51RsWMDou+7Owr+a6it+uOQrgIl18ujr9zJOMJLdQvyLM2U7rjvk/G5Dy
        LqDck9PlY82qvKp5A+cOakwn0HgxryTKmGxR/PlzBaXtuPZ1X1jfErf07zrqbLq0ncmV79Z
        UTV7qOSZ7+G7DMnEelIc0cA7NLRzow894pbHbGNbWXXlPJWY7ENgYm5RZWyaoWH7/3lcU+K
        Ypx+xwizF0w3mzwsML0/tV9ddY0vmW71Pt6H8pM3XAgVyIXN4RVSBWV6/Jt54VIadcGvPU8
        iB9W3w6aH93s5ApGKmIKDWgzhzTiz74my/Am+xGKAuDr9KSEuPfQmExXJyt/F1PcmUc9TFT
        W5HOny0lpG8=
X-QQ-GoodBg: 1
From:   Manyi Li <limanyi@uniontech.com>
To:     hdegoede@redhat.com
Cc:     ike.pan@canonical.com, limanyi@uniontech.com,
        linux-kernel@vger.kernel.org, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2] platform/x86: ideapad-laptop: Disable touchpad_switch
Date:   Tue, 18 Oct 2022 17:53:23 +0800
Message-Id: <20221018095323.14591-1-limanyi@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <bade32f9-594c-3efd-d6da-ea6a4a433948@redhat.com>
References: <bade32f9-594c-3efd-d6da-ea6a4a433948@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ideapads for "Lenovo Yoga 3 Pro 1370" and "ZhaoYang K4e-IML" do not
use EC to switch touchpad.

Reading VPCCMD_R_TOUCHPAD will return zero thus touchpad may be blocked
unexpectedly.

Signed-off-by: Manyi Li <limanyi@uniontech.com>
---
 drivers/platform/x86/ideapad-laptop.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index abd0c81d62c4..33b3dfdd1b08 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1533,6 +1533,24 @@ static const struct dmi_system_id hw_rfkill_list[] = {
 	{}
 };
 
+static const struct dmi_system_id no_touchpad_switch_list[] = {
+	{
+	.ident = "Lenovo Yoga 3 Pro 1370",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo YOGA 3"),
+		},
+	},
+	{
+	.ident = "ZhaoYang K4e-IML",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ZhaoYang K4e-IML"),
+		},
+	},
+	{}
+};
+
 static void ideapad_check_features(struct ideapad_private *priv)
 {
 	acpi_handle handle = priv->adev->handle;
@@ -1541,7 +1559,12 @@ static void ideapad_check_features(struct ideapad_private *priv)
 	priv->features.hw_rfkill_switch = dmi_check_system(hw_rfkill_list);
 
 	/* Most ideapads with ELAN0634 touchpad don't use EC touchpad switch */
-	priv->features.touchpad_ctrl_via_ec = !acpi_dev_present("ELAN0634", NULL, -1);
+	if (acpi_dev_present("ELAN0634", NULL, -1))
+		priv->features.touchpad_ctrl_via_ec = 0;
+	else if (dmi_check_system(no_touchpad_switch_list))
+		priv->features.touchpad_ctrl_via_ec = 0;
+	else
+		priv->features.touchpad_ctrl_via_ec = 1;
 
 	if (!read_ec_data(handle, VPCCMD_R_FAN, &val))
 		priv->features.fan_mode = true;
-- 
2.20.1

