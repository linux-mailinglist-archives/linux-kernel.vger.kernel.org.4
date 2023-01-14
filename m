Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E856D66AA65
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 10:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjANJXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 04:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjANJXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 04:23:36 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093B25BBB
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:23:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x188-20020a2531c5000000b00716de19d76bso25555020ybx.19
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2U/x+KRdCN6it3HlCS5RsRS3YSvRa1PfTbg1xgKGHs=;
        b=HMqRbjyf9FNteENmFFL3Kz2KHCesjEzxHU/+oj+EmqNjOMk2TRqlgMrNDlBWt60ZDh
         Rpvj/2E5oXk57+GnFnDbWFP2omGuuMjnnY4YAHM1arj4flDEJGBOnb0/UcuApt2PboxR
         JgYa9tmwg3RuaDuAdI/8q28rDHjFDuQco53HeBHq0Fb0hINd6YJf8YgEYE39wBN8+LQV
         CzSt8uR0MlKPlyqtLDUG4oqyEaxEGAtgWI0yvHzEzfkvWX3AdxFupZXjXGmTvSPot/eP
         JkSNazU67fAlXb4PntFhbCpiwkSAa7dUSS0jIyG0nxmIUz1xfke6tTkzfYFmpnEgow+9
         fFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2U/x+KRdCN6it3HlCS5RsRS3YSvRa1PfTbg1xgKGHs=;
        b=IIBaEtMGDjqS4XqivOt6YW8UqfP0nkCgHAO3D5NM5e97BdsUGDymDIQ0CzTIM8Nd4q
         2y9Jubce0YzLiMtAqzL8nGXCnaiRgzkjFMz0wk7L3vHPYwGz6+y8wQf5yWs4fmpynfot
         Qlks79zzPUbRZemUdvnoZUA3oadtfFeC0lZk4bEvaI6n6kW5bhaMHmo7kYRGYyebkc+F
         BRcuxoPxZ7ljacBOCSbSyLYdn+gV0gMHfNfJbg7bldheuK1c9ggHFPH351TOUjBETZFl
         WnotOj7vir3jdVJLJzKCfx1UGq50scJz7GriuSUF1c93MgjjkoICm5zY7tlxvgVHiIIl
         v7KQ==
X-Gm-Message-State: AFqh2krysf75cC4kd89A8U6/Je4baKbsyEV2AZCY6x8nCAaCunr2RzGi
        aEWAQAFm5LXr8oU5vjMv9oZsM8uP5Og=
X-Google-Smtp-Source: AMrXdXsOKri/ygrZN2zncVRQ5HkPN4TJ+/MeWyENrYm/6eEG9jF1wqk9ZAtbLJD6IC/aNs/yWCjy1P8oQSo=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:d726:232e:7cc0:6434])
 (user=badhri job=sendgmr) by 2002:a81:4ed8:0:b0:3b5:1538:c19 with SMTP id
 c207-20020a814ed8000000b003b515380c19mr3525599ywb.210.1673688214260; Sat, 14
 Jan 2023 01:23:34 -0800 (PST)
Date:   Sat, 14 Jan 2023 01:23:27 -0800
In-Reply-To: <20230114092328.1907406-1-badhri@google.com>
Mime-Version: 1.0
References: <20230114092328.1907406-1-badhri@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230114092328.1907406-2-badhri@google.com>
Subject: [PATCH v12 2/3] usb: typec: tcpci: Add callback for evaluating
 contaminant presence
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds callback to evaluate presence of contaminant in
the TCPCI layer.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v11:
* None
Changes since v10:
* None
Changes since v9:
* Check for presence of low level check_contaminant before installing tcpc.check_contaminant.
Changes since v7:
* None. Skipped versions by mistake.
Changes since v6:
* Removed is_potential_contaminant callback
Changes since v5:
* None
Changes since v4:
* None
Changes since v3:
* None
Changes since v2:
* Added tcpci_is_potential_contaminant to offload
* disconnect_while_debounce logic
---
 drivers/usb/typec/tcpm/tcpci.c | 11 +++++++++++
 include/linux/usb/tcpci.h      |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index fe781a38dc82..699539e1be06 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -403,6 +403,14 @@ static void tcpci_frs_sourcing_vbus(struct tcpc_dev *dev)
 		tcpci->data->frs_sourcing_vbus(tcpci, tcpci->data);
 }
 
+static void tcpci_check_contaminant(struct tcpc_dev *dev)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(dev);
+
+	if (tcpci->data->check_contaminant)
+		tcpci->data->check_contaminant(tcpci, tcpci->data);
+}
+
 static int tcpci_set_bist_data(struct tcpc_dev *tcpc, bool enable)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
@@ -778,6 +786,9 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
 	tcpci->tcpc.set_partner_usb_comm_capable = tcpci_set_partner_usb_comm_capable;
 
+	if (tcpci->data->check_contaminant)
+		tcpci->tcpc.check_contaminant = tcpci_check_contaminant;
+
 	if (tcpci->data->auto_discharge_disconnect) {
 		tcpci->tcpc.enable_auto_vbus_discharge = tcpci_enable_auto_vbus_discharge;
 		tcpci->tcpc.set_auto_vbus_discharge_threshold =
diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
index 17657451c762..85e95a3251d3 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -188,6 +188,12 @@ struct tcpci;
  *		Optional; The USB Communications Capable bit indicates if port
  *		partner is capable of communication over the USB data lines
  *		(e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
+ * @check_contaminant:
+ *		Optional; The callback is invoked when chiplevel drivers indicated
+ *		that the USB port needs to be checked for contaminant presence.
+ *		Chip level drivers are expected to check for contaminant and call
+ *		tcpm_clean_port when the port is clean to put the port back into
+ *		toggling state.
  */
 struct tcpci_data {
 	struct regmap *regmap;
@@ -204,6 +210,7 @@ struct tcpci_data {
 	void (*frs_sourcing_vbus)(struct tcpci *tcpci, struct tcpci_data *data);
 	void (*set_partner_usb_comm_capable)(struct tcpci *tcpci, struct tcpci_data *data,
 					     bool capable);
+	void (*check_contaminant)(struct tcpci *tcpci, struct tcpci_data *data);
 };
 
 struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
-- 
2.39.0.314.g84b9a713c41-goog

