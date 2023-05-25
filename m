Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCF57102E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjEYC1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjEYC1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:27:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A467135;
        Wed, 24 May 2023 19:27:41 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34P2Q6uO4002726, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34P2Q6uO4002726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 25 May 2023 10:26:06 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 25 May 2023 10:26:17 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 25 May 2023 10:26:17 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Thu, 25 May 2023 10:26:17 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael Grzeschik" <m.grzeschik@pengutronix.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Ray Chi <raychi@google.com>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v2 1/3] usb: phy: add usb phy notify port status API
Date:   Thu, 25 May 2023 10:26:02 +0800
Message-ID: <20230525022617.30537-1-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Realtek SoC, the parameter of usb phy is designed to can dynamic
tuning base on port status. Therefore, add a notify callback of phy
driver when usb port status change.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
v1 to v2 change:
    No change
---
 drivers/usb/core/hub.c  | 13 +++++++++++++
 include/linux/usb/phy.h | 14 ++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 97a0f8faea6e..b4fbbeae1927 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -614,6 +614,19 @@ static int hub_ext_port_status(struct usb_hub *hub, int port1, int type,
 		ret = 0;
 	}
 	mutex_unlock(&hub->status_mutex);
+
+	if (!ret) {
+		struct usb_device *hdev = hub->hdev;
+
+		if (hdev && !hdev->parent) {
+			struct usb_hcd *hcd = bus_to_hcd(hdev->bus);
+
+			if (hcd->usb_phy)
+				usb_phy_notify_port_status(hcd->usb_phy,
+					    port1 - 1, *status, *change);
+		}
+	}
+
 	return ret;
 }
 
diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index e4de6bc1f69b..53bf3540098f 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -144,6 +144,10 @@ struct usb_phy {
 	 */
 	int	(*set_wakeup)(struct usb_phy *x, bool enabled);
 
+	/* notify phy port status change */
+	int	(*notify_port_status)(struct usb_phy *x,
+		int port, u16 portstatus, u16 portchange);
+
 	/* notify phy connect status change */
 	int	(*notify_connect)(struct usb_phy *x,
 			enum usb_device_speed speed);
@@ -316,6 +320,16 @@ usb_phy_set_wakeup(struct usb_phy *x, bool enabled)
 		return 0;
 }
 
+static inline int
+usb_phy_notify_port_status(struct usb_phy *x, int port, u16 portstatus,
+	    u16 portchange)
+{
+	if (x && x->notify_port_status)
+		return x->notify_port_status(x, port, portstatus, portchange);
+	else
+		return 0;
+}
+
 static inline int
 usb_phy_notify_connect(struct usb_phy *x, enum usb_device_speed speed)
 {
-- 
2.34.1

