Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DBD64903E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 19:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiLJSvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 13:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiLJSvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 13:51:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AE313F2B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 10:51:36 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z17-20020a25e311000000b00719e04e59e1so5388679ybd.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 10:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wDRNns46OiMIOfUacnaTaHtRPFcj4uoQbXwU5dGeZx4=;
        b=Q/TbfuyWo05MMVCw4NRFAc4qPu5GPWVq4HFwhVoP8VFml6PbhGhezYZGkPUX1fLS1a
         51K7MP3HhoZgpjN4V8YRlkffjswYV+QduE7hkY1c8N3t2E2ZwcShQHPjo2OuaXtH+AaA
         fh4s0LYGJC+72OyT3AMLrs2H/vEuboXhFt6goPOQhawEc/RObDaw9cEORq1DERgbUUvM
         6S7TIRN1P4QnTzrnGVfMCh9x5HY9yH98Tx8CFGXFwqkbLAVmPAmDo/78d+6xKg7GfOFa
         XSAbFuyzL1Dkv9qsAxtsnKU4PL1vqzLYpv1s7n/n7AK2cih9gla5C5c8F86Bok/hk8Ba
         8Xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDRNns46OiMIOfUacnaTaHtRPFcj4uoQbXwU5dGeZx4=;
        b=eQ/M+pzHLjJbe3X0Gp8vJGrWKiU+8AqI4Pw6qTNCHQHCu8YZt35OQs513x10ZKIlmI
         T+by0TekXVuVk4bPlN9uXDXL6hMJ00XRfNcf0ADsnD0KJpbNUVCUGg8F4hayhWur1lJ5
         FycOg1Q227NZIscWUUzSMHNFmyxEv+502l4VmPePTJzlpTDWCIz1u7jBvxmxW/UKi6CO
         NOn3njKh7acWNGHkNlBJO7003p+2CUeyxVTgYRWY0tppH6yQw7Gu4YV3D6iA23euNLXE
         3EBI/saKNhAX0EejbaQMyRtyt33HwDXhn2O7a/ZGvbZ5qrYVAT2AC91QN1dEjAowrw77
         5n1w==
X-Gm-Message-State: ANoB5pny9kYa2IbBolA81u4Z0sGQCtoJTE6wIwm2DxNqtWDrGTSdyql5
        k/g63m3LHqVBEYYL7XH6g+gSCatEzf8=
X-Google-Smtp-Source: AA0mqf7EdbmjkyEiGAIdQ7JQH3f6h3h+7NzpCsZzIi/dkSbyRAY5F+g5eyRmW72EZopi/tyoNRI2eMlkBPI=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:bcc6:f018:88f8:a199])
 (user=badhri job=sendgmr) by 2002:a05:690c:589:b0:3b5:1538:c19 with SMTP id
 bo9-20020a05690c058900b003b515380c19mr1019381ywb.210.1670698295609; Sat, 10
 Dec 2022 10:51:35 -0800 (PST)
Date:   Sat, 10 Dec 2022 10:51:28 -0800
In-Reply-To: <20221210185129.1094531-1-badhri@google.com>
Mime-Version: 1.0
References: <20221210185129.1094531-1-badhri@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221210185129.1094531-2-badhri@google.com>
Subject: [PATCH v10 2/3] usb: typec: tcpci: Add callback for evaluating
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
2.39.0.rc1.256.g54fd8350bd-goog

