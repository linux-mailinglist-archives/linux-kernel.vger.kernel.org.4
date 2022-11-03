Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2EA6179C3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiKCJWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiKCJVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:21:19 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Nov 2022 02:21:16 PDT
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBAEDEF6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 02:21:16 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202211030920119665f4193357e38990
        for <linux-kernel@vger.kernel.org>;
        Thu, 03 Nov 2022 10:20:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QeSUu4Ms1ReYltx1YEd2ys6BjOyEGceHV47VU6Yavg0=;
 b=cGOFEC5me1Uwq8iEJHNaGXuKArG4OyW90JV3clM+iU2ChlajxkvHyGVpdQoI6jeDIelxBe
 zLhHA52FGNHWQrcHbEegCI3ExkfSPG64gx6XsTW6uea1a83CxK/n1EN7Upo95yjOcZmaACVv
 xzDekjEAiMb+Mv0onQFabQMShitNg=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 3/3] tty: n_gsm: add parameter negotiation support
Date:   Thu,  3 Nov 2022 10:17:43 +0100
Message-Id: <20221103091743.2119-3-daniel.starke@siemens.com>
In-Reply-To: <20221103091743.2119-1-daniel.starke@siemens.com>
References: <20221103091743.2119-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapter 5.1.8.1.1 describes the parameter negotiation
messages and parameters. Chapter 5.4.1 states that the default parameters
are to be used if no negotiation is performed. Chapter 5.4.6.3.1 describes
the encoding of the parameter negotiation message. The meaning of the
parameters and allowed value ranges can be found in chapter 5.7.

Add parameter negotiation support accordingly. DLCI specific parameter
configuration by the user requires additional ioctls. This is subject to
another patch.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 335 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 327 insertions(+), 8 deletions(-)

v2 -> v3:

Removed __packed attribute from struct gsm_dlci_param_bits and added
static_assert instead. Now use get_unaligned_le16() to read the 'n_bits'
field as suggested by Ilpo Järvinen.

Changed pr_err() to pr_debug() in gsm_encode_params() as suggested by
Greg KH. Other pr_info() functions remain as such due to the fact that
these indicate that the connected device does not conform to the standard.
Additional, these outputs are gated by the module parameter 'debug' which
disables such outputs by default. Future patches will likely change this
behavior to use the dynamic kernel debug functions. However, for the time
being the driver specific debug mechanisms are used to provide a common
behavior within this driver.

Simplification of command retry handling and switch from pr_*() functions
to dev_*() functions as well as the general switch to the dynamic kernel
debug interface for all debug outputs remains subject to future patches.

Link: https://lore.kernel.org/all/d253f864-5585-ce29-b9b4-92a0e2bc374@linux.intel.com/
Link: https://lore.kernel.org/all/Y2C51txUYBGv53j+@kroah.com/
Link: https://lore.kernel.org/all/20221024130114.2070-3-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c217013b3e16..cde1e846c81e 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -38,6 +38,7 @@
 #include <linux/sched/signal.h>
 #include <linux/interrupt.h>
 #include <linux/tty.h>
+#include <linux/bitfield.h>
 #include <linux/ctype.h>
 #include <linux/mm.h>
 #include <linux/math.h>
@@ -127,6 +128,7 @@ struct gsm_msg {
 
 enum gsm_dlci_state {
 	DLCI_CLOSED,
+	DLCI_CONFIGURE,		/* Sending PN (for adaption > 1) */
 	DLCI_OPENING,		/* Sending SABM not seen UA */
 	DLCI_OPEN,		/* SABM/UA complete */
 	DLCI_CLOSING,		/* Sending DISC not seen UA/DM */
@@ -184,6 +186,32 @@ struct gsm_dlci {
 	struct net_device *net; /* network interface, if created */
 };
 
+/*
+ * Parameter bits used for parameter negotiation according to 3GPP 27.010
+ * chapter 5.4.6.3.1.
+ */
+
+struct gsm_dlci_param_bits {
+	u8 d_bits;
+	u8 i_cl_bits;
+	u8 p_bits;
+	u8 t_bits;
+	__le16 n_bits;
+	u8 na_bits;
+	u8 k_bits;
+};
+
+static_assert(sizeof(struct gsm_dlci_param_bits) == 8);
+
+#define PN_D_FIELD_DLCI		GENMASK(5, 0)
+#define PN_I_CL_FIELD_FTYPE	GENMASK(3, 0)
+#define PN_I_CL_FIELD_ADAPTION	GENMASK(7, 4)
+#define PN_P_FIELD_PRIO		GENMASK(5, 0)
+#define PN_T_FIELD_T1		GENMASK(7, 0)
+#define PN_N_FIELD_N1		GENMASK(15, 0)
+#define PN_NA_FIELD_N2		GENMASK(7, 0)
+#define PN_K_FIELD_K		GENMASK(2, 0)
+
 /* Total number of supported devices */
 #define GSM_TTY_MINORS		256
 
@@ -411,6 +439,7 @@ static const u8 gsm_fcs8[256] = {
 #define INIT_FCS	0xFF
 #define GOOD_FCS	0xCF
 
+static void gsm_dlci_close(struct gsm_dlci *dlci);
 static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len);
 static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk);
 static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
@@ -533,6 +562,57 @@ static void gsm_hex_dump_bytes(const char *fname, const u8 *data,
 	kfree(prefix);
 }
 
+/**
+ * gsm_encode_params	-	encode DLCI parameters
+ * @dlci: DLCI to encode from
+ * @params: buffer to fill with the encoded parameters
+ *
+ * Encodes the parameters according to GSM 07.10 section 5.4.6.3.1
+ * table 3.
+ */
+static int gsm_encode_params(const struct gsm_dlci *dlci,
+			     struct gsm_dlci_param_bits *params)
+{
+	const struct gsm_mux *gsm = dlci->gsm;
+	unsigned int i, cl;
+
+	switch (dlci->ftype) {
+	case UIH:
+		i = 0; /* UIH */
+		break;
+	case UI:
+		i = 1; /* UI */
+		break;
+	default:
+		pr_debug("unsupported frame type %d\n", dlci->ftype);
+		return -EINVAL;
+	}
+
+	switch (dlci->adaption) {
+	case 1: /* Unstructured */
+		cl = 0; /* convergence layer type 1 */
+		break;
+	case 2: /* Unstructured with modem bits. */
+		cl = 1; /* convergence layer type 2 */
+		break;
+	default:
+		pr_debug("unsupported adaption %d\n", dlci->adaption);
+		return -EINVAL;
+	}
+
+	params->d_bits = FIELD_PREP(PN_D_FIELD_DLCI, dlci->addr);
+	/* UIH, convergence layer type 1 */
+	params->i_cl_bits = FIELD_PREP(PN_I_CL_FIELD_FTYPE, i) |
+			    FIELD_PREP(PN_I_CL_FIELD_ADAPTION, cl);
+	params->p_bits = FIELD_PREP(PN_P_FIELD_PRIO, dlci->prio);
+	params->t_bits = FIELD_PREP(PN_T_FIELD_T1, gsm->t1);
+	params->n_bits = cpu_to_le16(FIELD_PREP(PN_N_FIELD_N1, dlci->mtu));
+	params->na_bits = FIELD_PREP(PN_NA_FIELD_N2, gsm->n2);
+	params->k_bits = FIELD_PREP(PN_K_FIELD_K, dlci->k);
+
+	return 0;
+}
+
 /**
  *	gsm_register_devices	-	register all tty devices for a given mux index
  *
@@ -1450,6 +1530,116 @@ static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
 	dlci->modem_rx = mlines;
 }
 
+/**
+ * gsm_process_negotiation	-	process received parameters
+ * @gsm: GSM channel
+ * @addr: DLCI address
+ * @cr: command/response
+ * @params: encoded parameters from the parameter negotiation message
+ *
+ * Used when the response for our parameter negotiation command was
+ * received.
+ */
+static int gsm_process_negotiation(struct gsm_mux *gsm, unsigned int addr,
+				   unsigned int cr,
+				   const struct gsm_dlci_param_bits *params)
+{
+	struct gsm_dlci *dlci = gsm->dlci[addr];
+	unsigned int ftype, i, adaption, prio, n1, k;
+
+	i = FIELD_GET(PN_I_CL_FIELD_FTYPE, params->i_cl_bits);
+	adaption = FIELD_GET(PN_I_CL_FIELD_ADAPTION, params->i_cl_bits) + 1;
+	prio = FIELD_GET(PN_P_FIELD_PRIO, params->p_bits);
+	n1 = FIELD_GET(PN_N_FIELD_N1, get_unaligned_le16(&params->n_bits));
+	k = FIELD_GET(PN_K_FIELD_K, params->k_bits);
+
+	if (n1 < MIN_MTU) {
+		if (debug & DBG_ERRORS)
+			pr_info("%s N1 out of range in PN\n", __func__);
+		return -EINVAL;
+	}
+
+	switch (i) {
+	case 0x00:
+		ftype = UIH;
+		break;
+	case 0x01:
+		ftype = UI;
+		break;
+	case 0x02: /* I frames are not supported */
+		if (debug & DBG_ERRORS)
+			pr_info("%s unsupported I frame request in PN\n",
+				__func__);
+		return -EINVAL;
+	default:
+		if (debug & DBG_ERRORS)
+			pr_info("%s i out of range in PN\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!cr && gsm->initiator) {
+		if (adaption != dlci->adaption) {
+			if (debug & DBG_ERRORS)
+				pr_info("%s invalid adaption %d in PN\n",
+					__func__, adaption);
+			return -EINVAL;
+		}
+		if (prio != dlci->prio) {
+			if (debug & DBG_ERRORS)
+				pr_info("%s invalid priority %d in PN",
+					__func__, prio);
+			return -EINVAL;
+		}
+		if (n1 > gsm->mru || n1 > dlci->mtu) {
+			/* We requested a frame size but the other party wants
+			 * to send larger frames. The standard allows only a
+			 * smaller response value than requested (5.4.6.3.1).
+			 */
+			if (debug & DBG_ERRORS)
+				pr_info("%s invalid N1 %d in PN\n", __func__,
+					n1);
+			return -EINVAL;
+		}
+		dlci->mtu = n1;
+		if (ftype != dlci->ftype) {
+			if (debug & DBG_ERRORS)
+				pr_info("%s invalid i %d in PN\n", __func__, i);
+			return -EINVAL;
+		}
+		if (ftype != UI && ftype != UIH && k > dlci->k) {
+			if (debug & DBG_ERRORS)
+				pr_info("%s invalid k %d in PN\n", __func__, k);
+			return -EINVAL;
+		}
+		dlci->k = k;
+	} else if (cr && !gsm->initiator) {
+		/* Only convergence layer type 1 and 2 are supported. */
+		if (adaption != 1 && adaption != 2) {
+			if (debug & DBG_ERRORS)
+				pr_info("%s invalid adaption %d in PN\n",
+					__func__, adaption);
+			return -EINVAL;
+		}
+		dlci->adaption = adaption;
+		if (n1 > gsm->mru) {
+			/* Propose a smaller value */
+			dlci->mtu = gsm->mru;
+		} else if (n1 > MAX_MTU) {
+			/* Propose a smaller value */
+			dlci->mtu = MAX_MTU;
+		} else {
+			dlci->mtu = n1;
+		}
+		dlci->prio = prio;
+		dlci->ftype = ftype;
+		dlci->k = k;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  *	gsm_control_modem	-	modem status received
  *	@gsm: GSM channel
@@ -1503,6 +1693,65 @@ static void gsm_control_modem(struct gsm_mux *gsm, const u8 *data, int clen)
 	gsm_control_reply(gsm, CMD_MSC, data, clen);
 }
 
+/**
+ * gsm_control_negotiation	-	parameter negotiation received
+ * @gsm: GSM channel
+ * @cr: command/response flag
+ * @data: data following command
+ * @dlen: data length
+ *
+ * We have received a parameter negotiation message. This is used by
+ * the GSM mux protocol to configure protocol parameters for a new DLCI.
+ */
+static void gsm_control_negotiation(struct gsm_mux *gsm, unsigned int cr,
+				    const u8 *data, unsigned int dlen)
+{
+	unsigned int addr;
+	struct gsm_dlci_param_bits pn_reply;
+	struct gsm_dlci *dlci;
+	struct gsm_dlci_param_bits *params;
+
+	if (dlen < sizeof(struct gsm_dlci_param_bits))
+		return;
+
+	/* Invalid DLCI? */
+	params = (struct gsm_dlci_param_bits *)data;
+	addr = FIELD_GET(PN_D_FIELD_DLCI, params->d_bits);
+	if (addr == 0 || addr >= NUM_DLCI || !gsm->dlci[addr])
+		return;
+	dlci = gsm->dlci[addr];
+
+	/* Too late for parameter negotiation? */
+	if ((!cr && dlci->state == DLCI_OPENING) || dlci->state == DLCI_OPEN)
+		return;
+
+	/* Process the received parameters */
+	if (gsm_process_negotiation(gsm, addr, cr, params) != 0) {
+		/* Negotiation failed. Close the link. */
+		if (debug & DBG_ERRORS)
+			pr_info("%s PN failed\n", __func__);
+		gsm_dlci_close(dlci);
+		return;
+	}
+
+	if (cr) {
+		/* Reply command with accepted parameters. */
+		if (gsm_encode_params(dlci, &pn_reply) == 0)
+			gsm_control_reply(gsm, CMD_PN, (const u8 *)&pn_reply,
+					  sizeof(pn_reply));
+		else if (debug & DBG_ERRORS)
+			pr_info("%s PN invalid\n", __func__);
+	} else if (dlci->state == DLCI_CONFIGURE) {
+		/* Proceed with link setup by sending SABM before UA */
+		dlci->state = DLCI_OPENING;
+		gsm_command(gsm, dlci->addr, SABM|PF);
+		mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
+	} else {
+		if (debug & DBG_ERRORS)
+			pr_info("%s PN in invalid state\n", __func__);
+	}
+}
+
 /**
  *	gsm_control_rls		-	remote line status
  *	@gsm: GSM channel
@@ -1612,8 +1861,12 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 		/* Modem wishes to enter power saving state */
 		gsm_control_reply(gsm, CMD_PSC, NULL, 0);
 		break;
+		/* Optional commands */
+	case CMD_PN:
+		/* Modem sends a parameter negotiation command */
+		gsm_control_negotiation(gsm, 1, data, clen);
+		break;
 		/* Optional unsupported commands */
-	case CMD_PN:	/* Parameter negotiation */
 	case CMD_RPN:	/* Remote port negotiation */
 	case CMD_SNC:	/* Service negotiation command */
 	default:
@@ -1646,8 +1899,8 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 	spin_lock_irqsave(&gsm->control_lock, flags);
 
 	ctrl = gsm->pending_cmd;
-	/* Does the reply match our command */
 	command |= 1;
+	/* Does the reply match our command */
 	if (ctrl != NULL && (command == ctrl->cmd || command == CMD_NSC)) {
 		/* Our command was replied to, kill the retry timer */
 		del_timer(&gsm->t2_timer);
@@ -1657,6 +1910,9 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 			ctrl->error = -EOPNOTSUPP;
 		ctrl->done = 1;
 		wake_up(&gsm->event);
+	/* Or did we receive the PN response to our PN command */
+	} else if (command == CMD_PN) {
+		gsm_control_negotiation(gsm, 0, data, clen);
 	}
 	spin_unlock_irqrestore(&gsm->control_lock, flags);
 }
@@ -1834,6 +2090,32 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 	wake_up(&dlci->gsm->event);
 }
 
+/**
+ * gsm_dlci_negotiate	-	start parameter negotiation
+ * @dlci: DLCI to open
+ *
+ * Starts the parameter negotiation for the new DLCI. This needs to be done
+ * before the DLCI initialized the channel via SABM.
+ */
+static int gsm_dlci_negotiate(struct gsm_dlci *dlci)
+{
+	struct gsm_mux *gsm = dlci->gsm;
+	struct gsm_dlci_param_bits params;
+	int ret;
+
+	ret = gsm_encode_params(dlci, &params);
+	if (ret != 0)
+		return ret;
+
+	/* We cannot asynchronous wait for the command response with
+	 * gsm_command() and gsm_control_wait() at this point.
+	 */
+	ret = gsm_control_command(gsm, CMD_PN, (const u8 *)&params,
+				  sizeof(params));
+
+	return ret;
+}
+
 /**
  *	gsm_dlci_t1		-	T1 timer expiry
  *	@t: timer contained in the DLCI that opened
@@ -1855,6 +2137,14 @@ static void gsm_dlci_t1(struct timer_list *t)
 	struct gsm_mux *gsm = dlci->gsm;
 
 	switch (dlci->state) {
+	case DLCI_CONFIGURE:
+		if (dlci->retries && gsm_dlci_negotiate(dlci) == 0) {
+			dlci->retries--;
+			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
+		} else {
+			gsm_dlci_begin_close(dlci); /* prevent half open link */
+		}
+		break;
 	case DLCI_OPENING:
 		if (dlci->retries) {
 			dlci->retries--;
@@ -1893,17 +2183,46 @@ static void gsm_dlci_t1(struct timer_list *t)
  *	to the modem which should then reply with a UA or ADM, at which point
  *	we will move into open state. Opening is done asynchronously with retry
  *	running off timers and the responses.
+ *	Parameter negotiation is performed before SABM if required.
  */
 
 static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
 {
-	struct gsm_mux *gsm = dlci->gsm;
-	if (dlci->state == DLCI_OPEN || dlci->state == DLCI_OPENING)
+	struct gsm_mux *gsm = dlci ? dlci->gsm : NULL;
+	bool need_pn = false;
+
+	if (!gsm)
 		return;
-	dlci->retries = gsm->n2;
-	dlci->state = DLCI_OPENING;
-	gsm_command(dlci->gsm, dlci->addr, SABM|PF);
-	mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
+
+	if (dlci->addr != 0) {
+		if (gsm->adaption != 1 || gsm->adaption != dlci->adaption)
+			need_pn = true;
+		if (dlci->prio != (roundup(dlci->addr + 1, 8) - 1))
+			need_pn = true;
+		if (gsm->ftype != dlci->ftype)
+			need_pn = true;
+	}
+
+	switch (dlci->state) {
+	case DLCI_CLOSED:
+	case DLCI_CLOSING:
+		dlci->retries = gsm->n2;
+		if (!need_pn) {
+			dlci->state = DLCI_OPENING;
+			gsm_command(gsm, dlci->addr, SABM|PF);
+		} else {
+			/* Configure DLCI before setup */
+			dlci->state = DLCI_CONFIGURE;
+			if (gsm_dlci_negotiate(dlci) != 0) {
+				gsm_dlci_close(dlci);
+				return;
+			}
+		}
+		mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
+		break;
+	default:
+		break;
+	}
 }
 
 /**
-- 
2.34.1

