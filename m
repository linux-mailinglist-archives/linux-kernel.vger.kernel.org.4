Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA45C647270
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiLHPFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLHPFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:05:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB10259842
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:05:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f11-20020a5b01cb000000b0070374b66537so1704025ybp.14
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 07:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rgcJmSY/a3u3/TKPh3sf1WEcjrc/opZ8FA/EjT+FEzA=;
        b=bee95gXMVlaSHPjGxdRRdoBEJRlUc8HO478qdX3Gn4pp+oowyEHZEnY0J4HmU1GQf/
         aQZBj7AWnUP+ZSjNS5P8r9Pa29jbaulYyjK+ysoJ2si33cyYcAl3kLJO38egOGc7GZz5
         oyU5YoQFiFzyI6ZE4329Z5OLUiU/3c1kBViNxN5rsXpIFQLvu6bT7MEFcTs9dy4Le+Dj
         /q9X4JbbaqohoQHBH9G1tqLpebk1ir8zQP049JUF3j1QYquhIH6GNwrKDrkIpSF77Sjh
         Ux5F3lC56u4vjrhs9RHD5oFhwSsLlSdzwhYf3ZiB925oxIOKBiingqQNbDVaQz0AHQTD
         /80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgcJmSY/a3u3/TKPh3sf1WEcjrc/opZ8FA/EjT+FEzA=;
        b=TjYrQfBAhV+gwOZjKnP963Whf4zEsCt6iBg7Q4Sk2KnWC80wxRSN0bJRK7mZc0NT4s
         EES5tDxjpCdkOVv+7Z2EQlKPxYrhd3Ho46Pwuiv9XjreTwVln8GvVpx5d40LQpsA8V38
         QRYLA6RloDQyHSVS4lb02RIZtiXrkVHXDhOIvfBAQV7ny4Bi3gI0wS13mOz0C3vP9Dc/
         lcnjAkXmU6BWtY2Hc9jO9YJklw0kDp06/0AYK+mg1VS637cAUYBNbFS4VMTUEkKa61bL
         UtggisBdHsn+hJ5MchnNWNmHIRRwEmazatmDo2TGaU8mxHz/IXHqEw9oWWDTyMJw5dgr
         oheA==
X-Gm-Message-State: ANoB5pnf65OtseRQn8pBtRjkzHRpDOq3czGOPJSbyXydT2TGbb9CDtWD
        ClcpBS/o69Qjl7HkoOhl/sExpzzdDW8=
X-Google-Smtp-Source: AA0mqf6ZCZHTKOBGc7FXx532jY1CZ58ivW4l9hvUCyogvYH0kcq/BIxRsRtxStu/At01eE0UX8jd/oBiCzI=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:592e:36a9:5604:2233])
 (user=badhri job=sendgmr) by 2002:a81:4b05:0:b0:38d:e8f4:c8ba with SMTP id
 y5-20020a814b05000000b0038de8f4c8bamr23301840ywa.159.1670511901241; Thu, 08
 Dec 2022 07:05:01 -0800 (PST)
Date:   Thu,  8 Dec 2022 07:04:55 -0800
In-Reply-To: <20221208150456.473056-1-badhri@google.com>
Mime-Version: 1.0
References: <20221208150456.473056-1-badhri@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221208150456.473056-2-badhri@google.com>
Subject: [PATCH v6 2/3] usb: typec: tcpci: Add callback for evaluating
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
 drivers/usb/typec/tcpm/tcpci.c | 20 ++++++++++++++++++++
 include/linux/usb/tcpci.h      | 13 +++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index fe781a38dc82..2aadf785970f 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -403,6 +403,24 @@ static void tcpci_frs_sourcing_vbus(struct tcpc_dev *dev)
 		tcpci->data->frs_sourcing_vbus(tcpci, tcpci->data);
 }
 
+static bool tcpci_is_potential_contaminant(struct tcpc_dev *dev, enum tcpm_state current_state)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(dev);
+
+	if (tcpci->data->is_potential_contaminant)
+		return tcpci->data->is_potential_contaminant(tcpci, tcpci->data, current_state);
+
+	return false;
+}
+
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
@@ -777,6 +795,8 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.enable_frs = tcpci_enable_frs;
 	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
 	tcpci->tcpc.set_partner_usb_comm_capable = tcpci_set_partner_usb_comm_capable;
+	tcpci->tcpc.is_potential_contaminant = tcpci_is_potential_contaminant;
+	tcpci->tcpc.check_contaminant = tcpci_check_contaminant;
 
 	if (tcpci->data->auto_discharge_disconnect) {
 		tcpci->tcpc.enable_auto_vbus_discharge = tcpci_enable_auto_vbus_discharge;
diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
index 17657451c762..548e85fdc7fa 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -188,6 +188,16 @@ struct tcpci;
  *		Optional; The USB Communications Capable bit indicates if port
  *		partner is capable of communication over the USB data lines
  *		(e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
+ * @check_contaminant:
+ *		Optional; The callback is invoked when chiplevel drivers indicated
+ *		that the USB port needs to be checked for contaminant presence.
+ *		Chip level drivers are expected to check for contaminant and call
+ *		tcpm_clean_port when the port is clean to put the port back into
+ *		toggling state.
+ * @is_potential_contaminant:
+ *		Optional; TCPM invokes the callback for every TCPM state machine
+ *		transition. Chiplevel drivers can monitor the state machine
+ *		transitions to flag for potential contaminant presence.
  */
 struct tcpci_data {
 	struct regmap *regmap;
@@ -204,6 +214,9 @@ struct tcpci_data {
 	void (*frs_sourcing_vbus)(struct tcpci *tcpci, struct tcpci_data *data);
 	void (*set_partner_usb_comm_capable)(struct tcpci *tcpci, struct tcpci_data *data,
 					     bool capable);
+	void (*check_contaminant)(struct tcpci *tcpci, struct tcpci_data *data);
+	bool (*is_potential_contaminant)(struct tcpci *tcpci, struct tcpci_data *data,
+					 enum tcpm_state current_state);
 };
 
 struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

