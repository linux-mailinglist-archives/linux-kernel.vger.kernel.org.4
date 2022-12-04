Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449F7641BB2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 09:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiLDIs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 03:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiLDIsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 03:48:53 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCE413DD1
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 00:48:52 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-349423f04dbso95195717b3.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 00:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hv1AlD/N8UTuFVn9wgXP6NOrgTCtpTTdAjQOJxXKIq4=;
        b=AqgRV04m5ESLMnwsT4/5JD1K2yyCk1ECvoWMu/2kKh33uVYf0sFxHmaWdleWw0f/8M
         p4Z9PTAEe76zEZgaxascMxY2mI2QwBrF1XVRWNRSEEiDCYowt4a8esgexNcB9/Jr6Lr2
         cWUUuUYRMlA4n0MbeaxZPyUs3qtaWSGjLZePvXFlTGnH1+GuZOIYu4345kM+HIILP/OF
         3qFeZ3jTcyJbXjvVXtRAAz8yoVLQujGptj1FKNsLpMeWbsOVdRacATtuOssOsvsnzZN2
         107ZRyL4jhOEMgTaLhgP2qeCcAtaaoK7+ayn/XYXnUf5wJBS1JbuuVw4fv0gocgxgQqb
         p+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hv1AlD/N8UTuFVn9wgXP6NOrgTCtpTTdAjQOJxXKIq4=;
        b=6I4rA/IEkPk2eeFdB2uOoRuupfmVXuTHAlyiljdWBAhyoUXr6VCPBwRG9Yja0Y52/u
         W8KLulEWFYCy2qKxvR0Cp3TCZWyOo+1ftS/qQPjuml6LmmMXGCCCBXWNLeMNfd4Y8bHo
         6zR5EQTvd1KCMcqp1HXWfNjsLKV2yMKpA7WkiK+JpLWFEMj601mfa5FIUDQbaGvR6o+Z
         CdjXZb5M0X1YBs6v0Ygb2LeLEqEUx7djELGr7x8NXoHf9nvJpXrSgdplrrylb9FshrEx
         OK6MAAFCReYbXnWaZ/xwmSfmJhsQ87nf0j0tvUG65QhYZgtQIzH9TBYev0s0Ph2aZaCN
         YXiw==
X-Gm-Message-State: ANoB5pmJPY9zyd4aHgveKxsxOwvAUbU3W+Etslnw5g2N3isIEoKIc0JI
        HEapycYpL7lhaPh2UniyIz0tlY3yJCg=
X-Google-Smtp-Source: AA0mqf7jr2z/NaxzqrO4PuMyjcyI+usmP3PAmJpfoGBcdzkN9CJITk2z23hm13NatsJh0xReolx4QWytIHY=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f297:e6e9:66d9:b7cd])
 (user=badhri job=sendgmr) by 2002:a25:268b:0:b0:6e6:e55e:bacb with SMTP id
 m133-20020a25268b000000b006e6e55ebacbmr55772693ybm.250.1670143731303; Sun, 04
 Dec 2022 00:48:51 -0800 (PST)
Date:   Sun,  4 Dec 2022 00:48:43 -0800
In-Reply-To: <20221204084844.3573800-1-badhri@google.com>
Mime-Version: 1.0
References: <20221204084844.3573800-1-badhri@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221204084844.3573800-2-badhri@google.com>
Subject: [PATCH v3 2/3] usb: typec: tcpci: Add callback for evaluating
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

