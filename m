Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661E9654F24
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbiLWKVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbiLWKVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:21:31 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D9E233A8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:21:29 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h66-20020a252145000000b0071a7340eea9so4711849ybh.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4lQ9S7cFV5h+15BzFdRHTEL/7JNDLQyQN33ciJaHlE=;
        b=NQZfg+bMJ4LXL3C+o5QVYwbY1QPol/2dTM6qgplQc5kLDcj8s3G2tH0Z0wljbdqnMY
         +pxxVlbabEQTCwTV2Y/VaEVxm/T36Lmms8LAKKn/y1TPK7YTbSDupZ32xAtp9tgXuG/i
         0p70OQBS25YsAfGp4RjO/Nha2GaBd3cmcD6AuNfNJX269zCDL6qdHtDgGUmQ3edt7kXc
         1RxvqsjIFK6q3uv1dgkltKNwJncpSDbP3p4M9dgPuRDx81sTVwkDBLx8fcb6pzbZjDZL
         FHfvLXU0dpPQrb63ic/u4GDXyX7UpHrS0u4Cud5v04Jj2xSzAdhdoJuPZQK9fUBznDM1
         rTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4lQ9S7cFV5h+15BzFdRHTEL/7JNDLQyQN33ciJaHlE=;
        b=R5OtD7QDGNEaoH3KXPP2/REwfkZVvWO8kzM1VCj9pV5IrkSIctLaUZCfR2F872EyXH
         ffAa4JzNZaeAb9f6C3lwPUAzE46DYH4aaCgCl5kcI6uTyCx20SVU3G+fwjE4EDhSum2P
         bE50zEQW3GSsJIkmaB/y3D4ys+dASanmzbX1bMG/lWnFT3+mMRnfTnNcjka5cPTaN1Wo
         QKxP/J4u2U1+PXOn5mVRfi06zTA1Voe87NP5kuNPZqFCtBCCTtL8gTJodXvF8cDL5Mtc
         PjgDa42jY1KvNFBSRDo0lpID+jrRK9dwz0SQ1dUjN8S+pDZm0bzNZimeZuFaf72l2r1t
         Accw==
X-Gm-Message-State: AFqh2krNPWnPDwPJi1gx+2/7vyY4sODV/+yra4pwQd3rszOfh6l47YlF
        fMeLNIDK4HNAIcOfdGrtmMGTFdJHLXg=
X-Google-Smtp-Source: AMrXdXtRb3KpdYTJqCQPS+wq697rDw2y23RU9Uacax0ZVjL18FkkjSSDsEYhIVbIrt2XzawvleCddIFQOFs=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:a2de:465b:836b:7563])
 (user=badhri job=sendgmr) by 2002:a0d:d40b:0:b0:3c1:5879:d3a4 with SMTP id
 w11-20020a0dd40b000000b003c15879d3a4mr983722ywd.165.1671790888916; Fri, 23
 Dec 2022 02:21:28 -0800 (PST)
Date:   Fri, 23 Dec 2022 02:21:21 -0800
In-Reply-To: <20221223102122.1038499-1-badhri@google.com>
Mime-Version: 1.0
References: <20221223102122.1038499-1-badhri@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223102122.1038499-2-badhri@google.com>
Subject: [PATCH v11 2/3] usb: typec: tcpci: Add callback for evaluating
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

