Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A582648D57
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 07:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLJGQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 01:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLJGQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 01:16:31 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4458A4AF11
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 22:16:30 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-40306a5a42cso73625227b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 22:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lO6I1w/hjtZuCTkhiFwcgn3GICZUl7qyL7lRuvuHDaI=;
        b=Xxbs7dOzk/yBp3Kh2D+eYoLkbFpipK7GT11J8GksBKxiIIqu6JilfPCkmnLuA8JkHj
         LqxhL0jh29pZoNOIVq/Mt8Am1ebsk7zakIiI+q5Cr6UbKQr/jmRkE/KP2C/og4Uk9yqb
         ni7GV2IbhPaHZzaLtIeeJUsGH/JffvGhlbtVqx8oe0PdjyKuScoz6yb6W6MhV8pNL5zy
         b8oLXf+jfLSci+qYxBQSN+oiT2zSf1u16oxCqF3kDl+dM9u1ZVgL2mrIVlmsDcBgKlFD
         F+H7mzb0YYvrpHeK6qXR34IVoNJg2drpwHfNsMw693QYHv8iuU3j/nl3mqEbBjaEtGpm
         zplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lO6I1w/hjtZuCTkhiFwcgn3GICZUl7qyL7lRuvuHDaI=;
        b=4jXcq5R9i4+dQVHqWphN+7zV8N+PA5MKOJkGj8Q3PkIA/q/eTUGfe3wl+E197so2Z5
         7huBHOISftSKz3wX/64ysDoh+2z0RSoLnIqVJVTR1zgFFhDh/sSL+AgrWwvEiqb7wCAE
         VOe6v+6oGDv+5uh90BIVt3oZkQsHXZ8u75d0X+NN3uhboJEtFxoA52hw4KOrNFdRqnpZ
         +h7l3D34AbG1PUEFGvdDQ4l+5vEKVAsvnLAIilmMbFzniJVLqMKBpvvPsBHfWeCiVWx0
         r8G/EzYHIZO36EGSDFPZ3BepplGxggq7HsBH3iy9pXMEDzfhhymmm/z9/JlF3W1pOBvG
         vqvw==
X-Gm-Message-State: ANoB5plhA7S6kecWbevOWJYjh9qygigAB4ifIBXAhFsuI4sfHvdq6IOC
        0MnmSMBflgz0WplsXmCclH25TzXgIbM=
X-Google-Smtp-Source: AA0mqf7J6ODu79PxhGWsZCrcY9h7cMeKU9aAdk5cfv30qNqFt3YNBq6/P0wGHuozhjfla+HdqnJfheqUUTY=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:bcc6:f018:88f8:a199])
 (user=badhri job=sendgmr) by 2002:a81:4f57:0:b0:3d4:2e39:14e0 with SMTP id
 d84-20020a814f57000000b003d42e3914e0mr38558979ywb.451.1670652989602; Fri, 09
 Dec 2022 22:16:29 -0800 (PST)
Date:   Fri,  9 Dec 2022 22:16:24 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221210061626.948426-1-badhri@google.com>
Subject: [PATCH v9 1/3] usb: typec: tcpm: Add callbacks to mitigate wakeups
 due to contaminant
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

On some of the TCPC implementations, when the Type-C port is exposed
to contaminants, such as water, TCPC stops toggling while reporting OPEN
either by the time TCPM reads CC pin status or during CC debounce
window. This causes TCPM to be stuck in TOGGLING state. If TCPM is made
to restart toggling, the behavior recurs causing redundant CPU wakeups
till the USB-C port is free of contaminant.

[206199.287817] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[206199.640337] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[206199.985789] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]

(or)

[ 7853.867577] Start toggling
[ 7853.889921] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[ 7855.698765] CC1: 0 -> 0, CC2: 0 -> 5 [state TOGGLING, polarity 0, connected]
[ 7855.698790] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
[ 7855.698826] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
[ 7855.703559] CC1: 0 -> 0, CC2: 5 -> 5 [state SNK_ATTACH_WAIT, polarity 0, connected]
[ 7855.856555] CC1: 0 -> 0, CC2: 5 -> 0 [state SNK_ATTACH_WAIT, polarity 0, disconnected]
[ 7855.856581] state change SNK_ATTACH_WAIT -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
[ 7855.856613] pending state change SNK_ATTACH_WAIT -> SNK_UNATTACHED @ 170 ms [rev3 NONE_AMS]
[ 7856.027744] state change SNK_ATTACH_WAIT -> SNK_UNATTACHED [delayed 170 ms]
[ 7856.181949] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[ 7856.187896] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[ 7857.645630] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, disconnected]
[ 7857.647291] CC1: 0 -> 0, CC2: 0 -> 5 [state TOGGLING, polarity 0, connected]
[ 7857.647298] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
[ 7857.647310] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
[ 7857.808106] CC1: 0 -> 0, CC2: 5 -> 0 [state SNK_ATTACH_WAIT, polarity 0, disconnected]
[ 7857.808123] state change SNK_ATTACH_WAIT -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
[ 7857.808150] pending state change SNK_ATTACH_WAIT -> SNK_UNATTACHED @ 170 ms [rev3 NONE_AMS]
[ 7857.978727] state change SNK_ATTACH_WAIT -> SNK_UNATTACHED [delayed 170 ms]

To mitigate redundant TCPM wakeups, TCPCs which do have the needed hardware
can implement the check_contaminant callback which is invoked by TCPM
to evaluate for presence of contaminant. Lower level TCPC driver can
restart toggling through TCPM_PORT_CLEAN event when the driver detects
that USB-C port is free of contaminant. check_contaminant callback also passes
the disconnect_while_debounce flag which when true denotes that the CC pins
transitioned to OPEN state during the CC debounce window.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v7:
* None. Skipped versions by mistake.
Changes since v6:
* folded the debounce logic into tcpm state machine and removed tcpm
* state export.
* Added a helper to determine whether the port is in toggling state.
* Excluded CHECK_CONTAMINANT from tcpm_log.
Changes since v5:
* Updated commit message. Removed change id.
Changes since v4:
* None
Changes since v3:
* None
Changes since V2:
* Offloaded tcpm from maintaining disconnect_while_debouncing logic
* to lower level maxim tcpc driver based on feedback.
---
 drivers/usb/typec/tcpm/tcpm.c | 51 ++++++++++++++++++++++++++++++++++-
 include/linux/usb/tcpm.h      |  8 ++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 904c7b4ce2f0..5f514e5e6e2a 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -36,6 +36,7 @@
 #define FOREACH_STATE(S)			\
 	S(INVALID_STATE),			\
 	S(TOGGLING),			\
+	S(CHECK_CONTAMINANT),			\
 	S(SRC_UNATTACHED),			\
 	S(SRC_ATTACH_WAIT),			\
 	S(SRC_ATTACHED),			\
@@ -249,6 +250,7 @@ enum frs_typec_current {
 #define TCPM_RESET_EVENT	BIT(2)
 #define TCPM_FRS_EVENT		BIT(3)
 #define TCPM_SOURCING_VBUS	BIT(4)
+#define TCPM_PORT_CLEAN		BIT(5)
 
 #define LOG_BUFFER_ENTRIES	1024
 #define LOG_BUFFER_ENTRY_SIZE	128
@@ -483,6 +485,13 @@ struct tcpm_port {
 	 * SNK_READY for non-pd link.
 	 */
 	bool slow_charger_loop;
+
+	/*
+	 * When true indicates that the lower level drivers indicate potential presence
+	 * of contaminant in the connector pins based on the tcpm state machine
+	 * transitions.
+	 */
+	bool potential_contaminant;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	struct mutex logbuffer_lock;	/* log buffer access lock */
@@ -647,7 +656,7 @@ static void tcpm_log(struct tcpm_port *port, const char *fmt, ...)
 	/* Do not log while disconnected and unattached */
 	if (tcpm_port_is_disconnected(port) &&
 	    (port->state == SRC_UNATTACHED || port->state == SNK_UNATTACHED ||
-	     port->state == TOGGLING))
+	     port->state == TOGGLING || port->state == CHECK_CONTAMINANT))
 		return;
 
 	va_start(args, fmt);
@@ -3904,15 +3913,28 @@ static void run_state_machine(struct tcpm_port *port)
 	unsigned int msecs;
 	enum tcpm_state upcoming_state;
 
+	if (port->tcpc->check_contaminant && port->state != CHECK_CONTAMINANT)
+		port->potential_contaminant = ((port->enter_state == SRC_ATTACH_WAIT &&
+						port->state == SRC_UNATTACHED) ||
+					       (port->enter_state == SNK_ATTACH_WAIT &&
+						port->state == SNK_UNATTACHED));
+
 	port->enter_state = port->state;
 	switch (port->state) {
 	case TOGGLING:
 		break;
+	case CHECK_CONTAMINANT:
+		port->tcpc->check_contaminant(port->tcpc);
+		break;
 	/* SRC states */
 	case SRC_UNATTACHED:
 		if (!port->non_pd_role_swap)
 			tcpm_swap_complete(port, -ENOTCONN);
 		tcpm_src_detach(port);
+		if (port->potential_contaminant) {
+			tcpm_set_state(port, CHECK_CONTAMINANT, 0);
+			break;
+		}
 		if (tcpm_start_toggling(port, tcpm_rp_cc(port))) {
 			tcpm_set_state(port, TOGGLING, 0);
 			break;
@@ -4150,6 +4172,10 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_swap_complete(port, -ENOTCONN);
 		tcpm_pps_complete(port, -ENOTCONN);
 		tcpm_snk_detach(port);
+		if (port->potential_contaminant) {
+			tcpm_set_state(port, CHECK_CONTAMINANT, 0);
+			break;
+		}
 		if (tcpm_start_toggling(port, TYPEC_CC_RD)) {
 			tcpm_set_state(port, TOGGLING, 0);
 			break;
@@ -4926,6 +4952,9 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 		else if (tcpm_port_is_sink(port))
 			tcpm_set_state(port, SNK_ATTACH_WAIT, 0);
 		break;
+	case CHECK_CONTAMINANT:
+		/* Wait for Toggling to be resumed */
+		break;
 	case SRC_UNATTACHED:
 	case ACC_UNATTACHED:
 		if (tcpm_port_is_debug(port) || tcpm_port_is_audio(port) ||
@@ -5425,6 +5454,11 @@ static void tcpm_pd_event_handler(struct kthread_work *work)
 			port->vbus_source = true;
 			_tcpm_pd_vbus_on(port);
 		}
+		if (events & TCPM_PORT_CLEAN) {
+			tcpm_log(port, "port clean");
+			if (port->state == CHECK_CONTAMINANT)
+				tcpm_set_state(port, TOGGLING, 0);
+		}
 
 		spin_lock(&port->pd_event_lock);
 	}
@@ -5477,6 +5511,21 @@ void tcpm_sourcing_vbus(struct tcpm_port *port)
 }
 EXPORT_SYMBOL_GPL(tcpm_sourcing_vbus);
 
+void tcpm_port_clean(struct tcpm_port *port)
+{
+	spin_lock(&port->pd_event_lock);
+	port->pd_events |= TCPM_PORT_CLEAN;
+	spin_unlock(&port->pd_event_lock);
+	kthread_queue_work(port->wq, &port->event_work);
+}
+EXPORT_SYMBOL_GPL(tcpm_port_clean);
+
+bool tcpm_port_is_toggling(struct tcpm_port *port)
+{
+	return port->port_type == TYPEC_PORT_DRP && port->state == TOGGLING;
+}
+EXPORT_SYMBOL_GPL(tcpm_port_is_toggling);
+
 static void tcpm_enable_frs_work(struct kthread_work *work)
 {
 	struct tcpm_port *port = container_of(work, struct tcpm_port, enable_frs);
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index bffc8d3e14ad..ab7ca872950b 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -114,6 +114,11 @@ enum tcpm_transmit_type {
  *              Optional; The USB Communications Capable bit indicates if port
  *              partner is capable of communication over the USB data lines
  *              (e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
+ * @check_contaminant:
+ *		Optional; The callback is called when CC pins report open status
+ *		at the end of the deboumce period or when the port is still
+ *		toggling. Chip level drivers are expected to check for contaminant
+ *		and call tcpm_clean_port when the port is clean.
  */
 struct tcpc_dev {
 	struct fwnode_handle *fwnode;
@@ -148,6 +153,7 @@ struct tcpc_dev {
 						 bool pps_active, u32 requested_vbus_voltage);
 	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
 	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
+	void (*check_contaminant)(struct tcpc_dev *dev);
 };
 
 struct tcpm_port;
@@ -165,5 +171,7 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
 			       enum tcpm_transmit_status status);
 void tcpm_pd_hard_reset(struct tcpm_port *port);
 void tcpm_tcpc_reset(struct tcpm_port *port);
+void tcpm_port_clean(struct tcpm_port *port);
+bool tcpm_port_is_toggling(struct tcpm_port *port);
 
 #endif /* __LINUX_USB_TCPM_H */

base-commit: 1524ceb14dd5ebd6f724d993c5ec1a9a8d445d8e
-- 
2.39.0.rc1.256.g54fd8350bd-goog

