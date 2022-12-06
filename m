Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C87643AF0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 02:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiLFBse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 20:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLFBs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 20:48:29 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31C012634
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 17:48:28 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3dddef6adb6so125603977b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 17:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9DrD3oFPXDoavGOsF1ixpSGI6PcvOV3sQMSM7zsZrg=;
        b=RdFdqjT1CasRGFsal6IcoDbvQgLEosOjxsoko2VsgH4kjgAOigwIDFI+4IkQJtY/3F
         nrt34rDbkC7YcVrL07FlQz4JasK28jmX4s+cZlUfRWaaxo3nLmFNPfxajjATOSIXSTM+
         Qz+chOizJeQXw4nT6wz3cG3i4M+6dfHJrqmZwR18HJVlFDXW5Ru+hAEtPTYBiq5UJNYz
         bUOTuD/HOEQimqSixqiiWEL8BfjQwFaNKQQYoC3K+/gbbPEG9ljXPbDWXKNZhj/MLFjn
         k63eCkQYjNmfxTjGHJUe85rdaCHClDkiCqAt7Ldze6jrnP7m1WUdHeE0gLm59hjzDUsF
         5mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9DrD3oFPXDoavGOsF1ixpSGI6PcvOV3sQMSM7zsZrg=;
        b=bODtowF9E98cR+XD6MSBXLO9vB9KpTygGv9SbWwWS9QIKmP6r6roh+2wUcUHdKP6z+
         DOegxqLTwmT2MuCq7Z1xeDUc5aKbtNz4OdEtZ+rYrnTlbZpdzyvxl/o6w50bdqbxZDHI
         dy1DUZlQ3QVcKtmlD+ycQcuSzisssAh1GMIJl+lOsnT5dhYKtPjF99mnFXLPOXWsBuat
         dmMs+3fPL7h18wN1X9CT5zPBwT+ISmls7Y3DmpimOIfx3ke3UBK3fguJa8o0fkTrD7Nb
         7vdvIkK7MfEEzwfWdFP+fpoPjusvdjouGvYvoPEvNwlY/WdZmxyZTv8/UtV6MU1aO9Vm
         wlgQ==
X-Gm-Message-State: ANoB5plLyI1ViOzhiiI7PpObKummcgnLbExLiDs956JNMS+A292myq2E
        LqicgC8l4Yt6mjaZhScMdNXN8HScGaY=
X-Google-Smtp-Source: AA0mqf6j1s8oGJwUmNbxz9xmVICZum+jc+gBkTaWIHzpeaJSWibYph1hLOUNmyG8AxJW9RIaJzDwv28JH6w=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:8c86:3c57:a044:cb9])
 (user=badhri job=sendgmr) by 2002:a25:40d4:0:b0:6f0:118d:f77c with SMTP id
 n203-20020a2540d4000000b006f0118df77cmr57264697yba.205.1670291307918; Mon, 05
 Dec 2022 17:48:27 -0800 (PST)
Date:   Mon,  5 Dec 2022 17:48:21 -0800
In-Reply-To: <20221206014822.4105421-1-badhri@google.com>
Mime-Version: 1.0
References: <20221206014822.4105421-1-badhri@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221206014822.4105421-2-badhri@google.com>
Subject: [PATCH v4 2/3] usb: typec: tcpci: Add callback for evaluating
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

