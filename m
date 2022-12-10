Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF8A648D42
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 07:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLJGB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 01:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLJGBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 01:01:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11668389DE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 22:01:25 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k7-20020a256f07000000b006cbcc030bc8so7294887ybc.18
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 22:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=abRRdYll+HFDYesrmBP7w9sZdXxn/R3Cq4kLHzOoXvc=;
        b=lYkSJrCOj7VvM5zk2HO9seIecvdAifg364eIKS7NlyNzC/ty05dAjJKYBwn80V2Vye
         SwVnRzHc+BswJQxYouBbAsCMuTGy7UeNR9MxrTH5OFBip7VEHzO5NJUSBcoz/gqhyoEX
         wQkpjzoxEAKXr4h9YiwpVqDpzs0J8Ny4AS+e6LTS5+Mck3JXf0WgCLAUpDSHVXTxLXBr
         JcX/cDN7b2lpEt8efdlrvqAbDf2ww9Zv8LSqCX4Sjr+pN926XaBg8QL7pFKbEqfJX5C0
         Coy6I7jJS3BuUFauMPRP+zEAGklk68NaT8/W2ELHsAZPOnb61qzzSIb9ZwZJI1iqp/Xa
         vBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abRRdYll+HFDYesrmBP7w9sZdXxn/R3Cq4kLHzOoXvc=;
        b=SZNWvRAAAAmpRzV68vTc1/+RSRhGEJhtdOjT92HuhCgAasXUgeHhwKu349XTAdxWTH
         3fskn5BgAoo3QfYtG+f8plQ8Uxw/0fM+ZHIU3BzkgoHFBQR2nVz4KRwbS+w3A4lTiNKq
         kpEcR/FTmnmtFRI6dGeybUnndVhCR29qUazvB+unMFllih9yt31DX3acSBaTrWLGM1R7
         NaC4cpTTxpcMO6rKk7d7aoufoD0A5x5tRsIAZap2ZzgDbhZBsZ/h9KSf2icuNAciJG8Y
         fSKGwSU2wRCuwhzzj0fU+yrylFz34tOL75UMQw1YR6yRBgGv5dELtcGpWcVXnXiLaN2M
         p+jQ==
X-Gm-Message-State: ANoB5pkg126E+EJVYKrx/sDsT8u5yZYvu8IqSU5WvPEg4VH7NwX99u6/
        HE0QSLEhXVo5myYUY1+nvjgQTFUoOhs=
X-Google-Smtp-Source: AA0mqf4yUIhTDTInED7Rc2K5D8yQ2cqH7A9hRJ2YZ7XNw/Dkgzxpe6HVYR4755C3u+ZAersjbqIHvU1uLWc=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:bcc6:f018:88f8:a199])
 (user=badhri job=sendgmr) by 2002:a25:ced1:0:b0:6f4:57a4:783c with SMTP id
 x200-20020a25ced1000000b006f457a4783cmr52348565ybe.14.1670652084361; Fri, 09
 Dec 2022 22:01:24 -0800 (PST)
Date:   Fri,  9 Dec 2022 22:01:18 -0800
In-Reply-To: <20221210060119.944931-1-badhri@google.com>
Mime-Version: 1.0
References: <20221210060119.944931-1-badhri@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221210060119.944931-2-badhri@google.com>
Subject: [PATCH v7 2/3] usb: typec: tcpci: Add callback for evaluating
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
 drivers/usb/typec/tcpm/tcpci.c | 9 +++++++++
 include/linux/usb/tcpci.h      | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index fe781a38dc82..c8e78c13c9c4 100644
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
@@ -777,6 +785,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.enable_frs = tcpci_enable_frs;
 	tcpci->tcpc.frs_sourcing_vbus = tcpci_frs_sourcing_vbus;
 	tcpci->tcpc.set_partner_usb_comm_capable = tcpci_set_partner_usb_comm_capable;
+	tcpci->tcpc.check_contaminant = tcpci_check_contaminant;
 
 	if (tcpci->data->auto_discharge_disconnect) {
 		tcpci->tcpc.enable_auto_vbus_discharge = tcpci_enable_auto_vbus_discharge;
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

