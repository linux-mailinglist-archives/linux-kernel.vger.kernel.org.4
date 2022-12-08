Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E8A6466B5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiLHCAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiLHCAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:00:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C3292A1A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 18:00:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r7-20020a25c107000000b006ff55ac0ee7so13524773ybf.15
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 18:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SwslB3VPbnLWhTauQf3ujZ3C7cLlwRSqUDF8mp/fjWo=;
        b=tkE30ABPYDwrpXmTy+HkUzUMJXERWU6ZQFz3gFMwl8yr+YiAv6P3OhUsjDjPAbPfNV
         WDlE0t7mfl1cD+fjclyjXe/0oTcnX+fFBkYpMlybwN1Lf6ng/eoReAZeThptNZR0RlcQ
         Wf4jvzjgVD41pGChutjTpiyIVNECJEeijGGdYMDUEg+O/vIoNXmwW1PbF8e5gjaWqA5b
         +MKmVQdM0wWgrreDYUtHhek/MC4hisCXYkIRKE4S16gtBQA5ud1rOfyeXi3Avc5FzeUV
         n2Qj/gYZ01vVH/YzvB52SfJp+Vk+bdsodbfAio0huiO/R5YFGNm7TKVZ3ktyTYB5Qzzj
         ZT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwslB3VPbnLWhTauQf3ujZ3C7cLlwRSqUDF8mp/fjWo=;
        b=ts+VqeFJG9Fw4TkFQ0pu2VyQ3dD8Ul/S9bWfYzbteR9AZ8E0glQvf7+tlUH6Dv4+mD
         0UY8HzxjToeSG02Oc/SiTD2kPRrbu25GK/GXVE24und9PNH6hDkB4ZFw70IQYBtS4L+S
         YRQeJYjX+9xfeXuNYzmW6eXoxM/AsabmJcnLiMp8EuTX9FM2a5gVwVteD2cnEVcc1LuO
         8ttdnRyYX0g5Y2g4tDTorAtg8ypR1Plxv4ZpCw0ogCHd12ENEgG+nvPWkQ0qi8teJ0Dc
         K9ASFTr9RldgaO5ocQ0ap2D61/tO7TKvRFALS0SzOOTc0cQcPWoiTh7n8CDhn1J/Se65
         jPeQ==
X-Gm-Message-State: ANoB5pnBRkX1gtZkQlkOPLzUY3pgM/TiAsUkxOR2Ol3M2wNFL+xRrwle
        55kl1dPva3FsV7MUxwCW9Q2Dj0Rp4eU=
X-Google-Smtp-Source: AA0mqf5F15VSh/2kF1dLtjM19BXfiSiQ5kbOOxztHwJIFNqumcUllbvNP3hZVYUYGolKZNgXlCT2QOgJNLc=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:592e:36a9:5604:2233])
 (user=badhri job=sendgmr) by 2002:a0d:e6c4:0:b0:3bc:7270:cb70 with SMTP id
 p187-20020a0de6c4000000b003bc7270cb70mr55637971ywe.83.1670464848383; Wed, 07
 Dec 2022 18:00:48 -0800 (PST)
Date:   Wed,  7 Dec 2022 18:00:42 -0800
In-Reply-To: <20221208020043.374033-1-badhri@google.com>
Mime-Version: 1.0
References: <20221208020043.374033-1-badhri@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221208020043.374033-2-badhri@google.com>
Subject: [PATCH v5 2/3] usb: typec: tcpci: Add callback for evaluating
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

