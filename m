Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD536740CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjF1Jbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:31:39 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:47684 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjF1JZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:25:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC9E161297;
        Wed, 28 Jun 2023 09:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD2EC433C9;
        Wed, 28 Jun 2023 09:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687944345;
        bh=4PmZyVhRq0Ye11xniroAevs1l+zECLPfz1z2cmdYQrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIwAu/j+rbQ23HtC/H5lvjobCeU/lvPMh/7bbV4+Y7D2/0Gshy21qpfsLGjGikQJj
         TFrY6ooHLyf8xM+epXMvRwlUx0A8ayhnLzjLRTB0efXf+qINAbvKVYCRZpHBvPLgSk
         EH2zCYP5bZ+clrCd+XATo980L7G431rtuSK8CMJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.288
Date:   Wed, 28 Jun 2023 11:25:29 +0200
Message-ID: <2023062828-swagger-candle-4857@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023062828-devouring-discolor-8814@gregkh>
References: <2023062828-devouring-discolor-8814@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 756d6e997cd2..0293da44bdcd 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 287
+SUBLEVEL = 288
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index e90cf51b87ec..22266c7e2cc1 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -98,8 +98,14 @@
 				       (!!x)<<8 | 0x1f)
 
 #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
+#define SYS_DC_IGSW			sys_insn(1, 0, 7, 6, 4)
+#define SYS_DC_IGDSW			sys_insn(1, 0, 7, 6, 6)
 #define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
+#define SYS_DC_CGSW			sys_insn(1, 0, 7, 10, 4)
+#define SYS_DC_CGDSW			sys_insn(1, 0, 7, 10, 6)
 #define SYS_DC_CISW			sys_insn(1, 0, 7, 14, 2)
+#define SYS_DC_CIGSW			sys_insn(1, 0, 7, 14, 4)
+#define SYS_DC_CIGDSW			sys_insn(1, 0, 7, 14, 6)
 
 #define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
 #define SYS_MDCCINT_EL1			sys_reg(2, 0, 0, 2, 0)
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 8e70c2ba21b3..fb17767552ef 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -102,7 +102,10 @@ static void init_x2apic_ldr(void)
 
 static int x2apic_phys_probe(void)
 {
-	if (x2apic_mode && (x2apic_phys || x2apic_fadt_phys()))
+	if (!x2apic_mode)
+		return 0;
+
+	if (x2apic_phys || x2apic_fadt_phys())
 		return 1;
 
 	return apic == &apic_x2apic_phys;
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 002f7a01af11..00f104e341e5 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -12,6 +12,11 @@ $(obj)/string.o: $(srctree)/arch/x86/boot/compressed/string.c FORCE
 $(obj)/sha256.o: $(srctree)/lib/sha256.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
+# When profile-guided optimization is enabled, llvm emits two different
+# overlapping text sections, which is not supported by kexec. Remove profile
+# optimization flags.
+KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
+
 LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
 targets += purgatory.ro
 
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 31cfa47d2498..988d0e37f87f 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -541,15 +541,20 @@ struct ipmi_smi {
 	atomic_t         event_waiters;
 	unsigned int     ticks_to_req_ev;
 
+	spinlock_t       watch_lock; /* For dealing with watch stuff below. */
+
 	/* How many users are waiting for commands? */
-	atomic_t         command_waiters;
+	unsigned int     command_waiters;
 
 	/* How many users are waiting for watchdogs? */
-	atomic_t         watchdog_waiters;
+	unsigned int     watchdog_waiters;
+
+	/* How many users are waiting for message responses? */
+	unsigned int     response_waiters;
 
 	/*
 	 * Tells what the lower layer has last been asked to watch for,
-	 * messages and/or watchdogs.  Protected by xmit_msgs_lock.
+	 * messages and/or watchdogs.  Protected by watch_lock.
 	 */
 	unsigned int     last_watch_mask;
 
@@ -945,6 +950,64 @@ static void deliver_err_response(struct ipmi_smi *intf,
 	deliver_local_response(intf, msg);
 }
 
+static void smi_add_watch(struct ipmi_smi *intf, unsigned int flags)
+{
+	unsigned long iflags;
+
+	if (!intf->handlers->set_need_watch)
+		return;
+
+	spin_lock_irqsave(&intf->watch_lock, iflags);
+	if (flags & IPMI_WATCH_MASK_CHECK_MESSAGES)
+		intf->response_waiters++;
+
+	if (flags & IPMI_WATCH_MASK_CHECK_WATCHDOG)
+		intf->watchdog_waiters++;
+
+	if (flags & IPMI_WATCH_MASK_CHECK_COMMANDS)
+		intf->command_waiters++;
+
+	if ((intf->last_watch_mask & flags) != flags) {
+		intf->last_watch_mask |= flags;
+		intf->handlers->set_need_watch(intf->send_info,
+					       intf->last_watch_mask);
+	}
+	spin_unlock_irqrestore(&intf->watch_lock, iflags);
+}
+
+static void smi_remove_watch(struct ipmi_smi *intf, unsigned int flags)
+{
+	unsigned long iflags;
+
+	if (!intf->handlers->set_need_watch)
+		return;
+
+	spin_lock_irqsave(&intf->watch_lock, iflags);
+	if (flags & IPMI_WATCH_MASK_CHECK_MESSAGES)
+		intf->response_waiters--;
+
+	if (flags & IPMI_WATCH_MASK_CHECK_WATCHDOG)
+		intf->watchdog_waiters--;
+
+	if (flags & IPMI_WATCH_MASK_CHECK_COMMANDS)
+		intf->command_waiters--;
+
+	flags = 0;
+	if (intf->response_waiters)
+		flags |= IPMI_WATCH_MASK_CHECK_MESSAGES;
+	if (intf->watchdog_waiters)
+		flags |= IPMI_WATCH_MASK_CHECK_WATCHDOG;
+	if (intf->command_waiters)
+		flags |= IPMI_WATCH_MASK_CHECK_COMMANDS;
+
+	if (intf->last_watch_mask != flags) {
+		intf->last_watch_mask = flags;
+		intf->handlers->set_need_watch(intf->send_info,
+					       intf->last_watch_mask);
+	}
+	spin_unlock_irqrestore(&intf->watch_lock, iflags);
+}
+
 /*
  * Find the next sequence number not being used and add the given
  * message with the given timeout to the sequence table.  This must be
@@ -988,6 +1051,7 @@ static int intf_next_seq(struct ipmi_smi      *intf,
 		*seq = i;
 		*seqid = intf->seq_table[i].seqid;
 		intf->curr_seq = (i+1)%IPMI_IPMB_NUM_SEQ;
+		smi_add_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES);
 		need_waiter(intf);
 	} else {
 		rv = -EAGAIN;
@@ -1026,6 +1090,7 @@ static int intf_find_seq(struct ipmi_smi      *intf,
 				&& (ipmi_addr_equal(addr, &msg->addr))) {
 			*recv_msg = msg;
 			intf->seq_table[seq].inuse = 0;
+			smi_remove_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES);
 			rv = 0;
 		}
 	}
@@ -1087,6 +1152,7 @@ static int intf_err_seq(struct ipmi_smi *intf,
 		struct seq_table *ent = &intf->seq_table[seq];
 
 		ent->inuse = 0;
+		smi_remove_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES);
 		msg = ent->recv_msg;
 		rv = 0;
 	}
@@ -1098,30 +1164,6 @@ static int intf_err_seq(struct ipmi_smi *intf,
 	return rv;
 }
 
-/* Must be called with xmit_msgs_lock held. */
-static void smi_tell_to_watch(struct ipmi_smi *intf,
-			      unsigned int flags,
-			      struct ipmi_smi_msg *smi_msg)
-{
-	if (flags & IPMI_WATCH_MASK_CHECK_MESSAGES) {
-		if (!smi_msg)
-			return;
-
-		if (!smi_msg->needs_response)
-			return;
-	}
-
-	if (!intf->handlers->set_need_watch)
-		return;
-
-	if ((intf->last_watch_mask & flags) == flags)
-		return;
-
-	intf->last_watch_mask |= flags;
-	intf->handlers->set_need_watch(intf->send_info,
-				       intf->last_watch_mask);
-}
-
 static void free_user_work(struct work_struct *work)
 {
 	struct ipmi_user *user = container_of(work, struct ipmi_user,
@@ -1198,12 +1240,9 @@ int ipmi_create_user(unsigned int          if_num,
 	spin_lock_irqsave(&intf->seq_lock, flags);
 	list_add_rcu(&new_user->link, &intf->users);
 	spin_unlock_irqrestore(&intf->seq_lock, flags);
-	if (handler->ipmi_watchdog_pretimeout) {
+	if (handler->ipmi_watchdog_pretimeout)
 		/* User wants pretimeouts, so make sure to watch for them. */
-		if (atomic_inc_return(&intf->watchdog_waiters) == 1)
-			smi_tell_to_watch(intf, IPMI_WATCH_MASK_CHECK_WATCHDOG,
-					  NULL);
-	}
+		smi_add_watch(intf, IPMI_WATCH_MASK_CHECK_WATCHDOG);
 	srcu_read_unlock(&ipmi_interfaces_srcu, index);
 	*user = new_user;
 	return 0;
@@ -1276,7 +1315,7 @@ static void _ipmi_destroy_user(struct ipmi_user *user)
 		user->handler->shutdown(user->handler_data);
 
 	if (user->handler->ipmi_watchdog_pretimeout)
-		atomic_dec(&intf->watchdog_waiters);
+		smi_remove_watch(intf, IPMI_WATCH_MASK_CHECK_WATCHDOG);
 
 	if (user->gets_events)
 		atomic_dec(&intf->event_waiters);
@@ -1289,6 +1328,7 @@ static void _ipmi_destroy_user(struct ipmi_user *user)
 		if (intf->seq_table[i].inuse
 		    && (intf->seq_table[i].recv_msg->user == user)) {
 			intf->seq_table[i].inuse = 0;
+			smi_remove_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES);
 			ipmi_free_recv_msg(intf->seq_table[i].recv_msg);
 		}
 	}
@@ -1634,8 +1674,7 @@ int ipmi_register_for_cmd(struct ipmi_user *user,
 		goto out_unlock;
 	}
 
-	if (atomic_inc_return(&intf->command_waiters) == 1)
-		smi_tell_to_watch(intf, IPMI_WATCH_MASK_CHECK_COMMANDS, NULL);
+	smi_add_watch(intf, IPMI_WATCH_MASK_CHECK_COMMANDS);
 
 	list_add_rcu(&rcvr->link, &intf->cmd_rcvrs);
 
@@ -1685,7 +1724,7 @@ int ipmi_unregister_for_cmd(struct ipmi_user *user,
 	synchronize_rcu();
 	release_ipmi_user(user, index);
 	while (rcvrs) {
-		atomic_dec(&intf->command_waiters);
+		smi_remove_watch(intf, IPMI_WATCH_MASK_CHECK_COMMANDS);
 		rcvr = rcvrs;
 		rcvrs = rcvr->next;
 		kfree(rcvr);
@@ -1813,8 +1852,6 @@ static void smi_send(struct ipmi_smi *intf,
 		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
 	smi_msg = smi_add_send_msg(intf, smi_msg, priority);
 
-	smi_tell_to_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES, smi_msg);
-
 	if (!run_to_completion)
 		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
 
@@ -2014,9 +2051,6 @@ static int i_ipmi_req_ipmb(struct ipmi_smi        *intf,
 				ipmb_seq, broadcast,
 				source_address, source_lun);
 
-		/* We will be getting a response in the BMC message queue. */
-		smi_msg->needs_response = true;
-
 		/*
 		 * Copy the message into the recv message data, so we
 		 * can retransmit it later if necessary.
@@ -2204,7 +2238,6 @@ static int i_ipmi_request(struct ipmi_user     *user,
 			goto out;
 		}
 	}
-	smi_msg->needs_response = false;
 
 	rcu_read_lock();
 	if (intf->in_shutdown) {
@@ -3425,9 +3458,8 @@ int ipmi_add_smi(struct module         *owner,
 	INIT_LIST_HEAD(&intf->xmit_msgs);
 	INIT_LIST_HEAD(&intf->hp_xmit_msgs);
 	spin_lock_init(&intf->events_lock);
+	spin_lock_init(&intf->watch_lock);
 	atomic_set(&intf->event_waiters, 0);
-	atomic_set(&intf->watchdog_waiters, 0);
-	atomic_set(&intf->command_waiters, 0);
 	intf->ticks_to_req_ev = IPMI_REQUEST_EV_TIME;
 	INIT_LIST_HEAD(&intf->waiting_events);
 	intf->waiting_events_count = 0;
@@ -4207,7 +4239,53 @@ static int handle_one_recv_msg(struct ipmi_smi *intf,
 	int chan;
 
 	ipmi_debug_msg("Recv:", msg->rsp, msg->rsp_size);
-	if (msg->rsp_size < 2) {
+
+	if ((msg->data_size >= 2)
+	    && (msg->data[0] == (IPMI_NETFN_APP_REQUEST << 2))
+	    && (msg->data[1] == IPMI_SEND_MSG_CMD)
+	    && (msg->user_data == NULL)) {
+
+		if (intf->in_shutdown)
+			goto free_msg;
+
+		/*
+		 * This is the local response to a command send, start
+		 * the timer for these.  The user_data will not be
+		 * NULL if this is a response send, and we will let
+		 * response sends just go through.
+		 */
+
+		/*
+		 * Check for errors, if we get certain errors (ones
+		 * that mean basically we can try again later), we
+		 * ignore them and start the timer.  Otherwise we
+		 * report the error immediately.
+		 */
+		if ((msg->rsp_size >= 3) && (msg->rsp[2] != 0)
+		    && (msg->rsp[2] != IPMI_NODE_BUSY_ERR)
+		    && (msg->rsp[2] != IPMI_LOST_ARBITRATION_ERR)
+		    && (msg->rsp[2] != IPMI_BUS_ERR)
+		    && (msg->rsp[2] != IPMI_NAK_ON_WRITE_ERR)) {
+			int ch = msg->rsp[3] & 0xf;
+			struct ipmi_channel *chans;
+
+			/* Got an error sending the message, handle it. */
+
+			chans = READ_ONCE(intf->channel_list)->c;
+			if ((chans[ch].medium == IPMI_CHANNEL_MEDIUM_8023LAN)
+			    || (chans[ch].medium == IPMI_CHANNEL_MEDIUM_ASYNC))
+				ipmi_inc_stat(intf, sent_lan_command_errs);
+			else
+				ipmi_inc_stat(intf, sent_ipmb_command_errs);
+			intf_err_seq(intf, msg->msgid, msg->rsp[2]);
+		} else
+			/* The message was sent, start the timer. */
+			intf_start_seq_timer(intf, msg->msgid);
+free_msg:
+		requeue = 0;
+		goto out;
+
+	} else if (msg->rsp_size < 2) {
 		/* Message is too small to be correct. */
 		dev_warn(intf->si_dev,
 			 PFX "BMC returned to small a message for netfn %x cmd %x, got %d bytes\n",
@@ -4447,8 +4525,6 @@ static void smi_recv_tasklet(unsigned long val)
 		}
 	}
 
-	smi_tell_to_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES, newmsg);
-
 	if (!run_to_completion)
 		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
 	if (newmsg)
@@ -4466,62 +4542,16 @@ void ipmi_smi_msg_received(struct ipmi_smi *intf,
 	unsigned long flags = 0; /* keep us warning-free. */
 	int run_to_completion = intf->run_to_completion;
 
-	if ((msg->data_size >= 2)
-	    && (msg->data[0] == (IPMI_NETFN_APP_REQUEST << 2))
-	    && (msg->data[1] == IPMI_SEND_MSG_CMD)
-	    && (msg->user_data == NULL)) {
-
-		if (intf->in_shutdown)
-			goto free_msg;
-
-		/*
-		 * This is the local response to a command send, start
-		 * the timer for these.  The user_data will not be
-		 * NULL if this is a response send, and we will let
-		 * response sends just go through.
-		 */
-
-		/*
-		 * Check for errors, if we get certain errors (ones
-		 * that mean basically we can try again later), we
-		 * ignore them and start the timer.  Otherwise we
-		 * report the error immediately.
-		 */
-		if ((msg->rsp_size >= 3) && (msg->rsp[2] != 0)
-		    && (msg->rsp[2] != IPMI_NODE_BUSY_ERR)
-		    && (msg->rsp[2] != IPMI_LOST_ARBITRATION_ERR)
-		    && (msg->rsp[2] != IPMI_BUS_ERR)
-		    && (msg->rsp[2] != IPMI_NAK_ON_WRITE_ERR)) {
-			int ch = msg->rsp[3] & 0xf;
-			struct ipmi_channel *chans;
-
-			/* Got an error sending the message, handle it. */
-
-			chans = READ_ONCE(intf->channel_list)->c;
-			if ((chans[ch].medium == IPMI_CHANNEL_MEDIUM_8023LAN)
-			    || (chans[ch].medium == IPMI_CHANNEL_MEDIUM_ASYNC))
-				ipmi_inc_stat(intf, sent_lan_command_errs);
-			else
-				ipmi_inc_stat(intf, sent_ipmb_command_errs);
-			intf_err_seq(intf, msg->msgid, msg->rsp[2]);
-		} else
-			/* The message was sent, start the timer. */
-			intf_start_seq_timer(intf, msg->msgid);
-
-free_msg:
-		ipmi_free_smi_msg(msg);
-	} else {
-		/*
-		 * To preserve message order, we keep a queue and deliver from
-		 * a tasklet.
-		 */
-		if (!run_to_completion)
-			spin_lock_irqsave(&intf->waiting_rcv_msgs_lock, flags);
-		list_add_tail(&msg->link, &intf->waiting_rcv_msgs);
-		if (!run_to_completion)
-			spin_unlock_irqrestore(&intf->waiting_rcv_msgs_lock,
-					       flags);
-	}
+	/*
+	 * To preserve message order, we keep a queue and deliver from
+	 * a tasklet.
+	 */
+	if (!run_to_completion)
+		spin_lock_irqsave(&intf->waiting_rcv_msgs_lock, flags);
+	list_add_tail(&msg->link, &intf->waiting_rcv_msgs);
+	if (!run_to_completion)
+		spin_unlock_irqrestore(&intf->waiting_rcv_msgs_lock,
+				       flags);
 
 	if (!run_to_completion)
 		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
@@ -4576,7 +4606,7 @@ static void check_msg_timeout(struct ipmi_smi *intf, struct seq_table *ent,
 			      struct list_head *timeouts,
 			      unsigned long timeout_period,
 			      int slot, unsigned long *flags,
-			      unsigned int *watch_mask)
+			      bool *need_timer)
 {
 	struct ipmi_recv_msg *msg;
 
@@ -4588,13 +4618,14 @@ static void check_msg_timeout(struct ipmi_smi *intf, struct seq_table *ent,
 
 	if (timeout_period < ent->timeout) {
 		ent->timeout -= timeout_period;
-		*watch_mask |= IPMI_WATCH_MASK_CHECK_MESSAGES;
+		*need_timer = true;
 		return;
 	}
 
 	if (ent->retries_left == 0) {
 		/* The message has used all its retries. */
 		ent->inuse = 0;
+		smi_remove_watch(intf, IPMI_WATCH_MASK_CHECK_MESSAGES);
 		msg = ent->recv_msg;
 		list_add_tail(&msg->link, timeouts);
 		if (ent->broadcast)
@@ -4607,7 +4638,7 @@ static void check_msg_timeout(struct ipmi_smi *intf, struct seq_table *ent,
 		struct ipmi_smi_msg *smi_msg;
 		/* More retries, send again. */
 
-		*watch_mask |= IPMI_WATCH_MASK_CHECK_MESSAGES;
+		*need_timer = true;
 
 		/*
 		 * Start with the max timer, set to normal timer after
@@ -4652,20 +4683,20 @@ static void check_msg_timeout(struct ipmi_smi *intf, struct seq_table *ent,
 	}
 }
 
-static unsigned int ipmi_timeout_handler(struct ipmi_smi *intf,
-					 unsigned long timeout_period)
+static bool ipmi_timeout_handler(struct ipmi_smi *intf,
+				 unsigned long timeout_period)
 {
 	struct list_head     timeouts;
 	struct ipmi_recv_msg *msg, *msg2;
 	unsigned long        flags;
 	int                  i;
-	unsigned int         watch_mask = 0;
+	bool                 need_timer = false;
 
 	if (!intf->bmc_registered) {
 		kref_get(&intf->refcount);
 		if (!schedule_work(&intf->bmc_reg_work)) {
 			kref_put(&intf->refcount, intf_free);
-			watch_mask |= IPMI_WATCH_MASK_INTERNAL;
+			need_timer = true;
 		}
 	}
 
@@ -4685,7 +4716,7 @@ static unsigned int ipmi_timeout_handler(struct ipmi_smi *intf,
 	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++)
 		check_msg_timeout(intf, &intf->seq_table[i],
 				  &timeouts, timeout_period, i,
-				  &flags, &watch_mask);
+				  &flags, &need_timer);
 	spin_unlock_irqrestore(&intf->seq_lock, flags);
 
 	list_for_each_entry_safe(msg, msg2, &timeouts, link)
@@ -4716,7 +4747,7 @@ static unsigned int ipmi_timeout_handler(struct ipmi_smi *intf,
 
 	tasklet_schedule(&intf->recv_tasklet);
 
-	return watch_mask;
+	return need_timer;
 }
 
 static void ipmi_request_event(struct ipmi_smi *intf)
@@ -4736,9 +4767,8 @@ static atomic_t stop_operation;
 static void ipmi_timeout(struct timer_list *unused)
 {
 	struct ipmi_smi *intf;
-	unsigned int watch_mask = 0;
+	bool need_timer = false;
 	int index;
-	unsigned long flags;
 
 	if (atomic_read(&stop_operation))
 		return;
@@ -4751,28 +4781,14 @@ static void ipmi_timeout(struct timer_list *unused)
 				ipmi_request_event(intf);
 				intf->ticks_to_req_ev = IPMI_REQUEST_EV_TIME;
 			}
-			watch_mask |= IPMI_WATCH_MASK_INTERNAL;
+			need_timer = true;
 		}
 
-		if (atomic_read(&intf->watchdog_waiters))
-			watch_mask |= IPMI_WATCH_MASK_CHECK_WATCHDOG;
-
-		if (atomic_read(&intf->command_waiters))
-			watch_mask |= IPMI_WATCH_MASK_CHECK_COMMANDS;
-
-		watch_mask |= ipmi_timeout_handler(intf, IPMI_TIMEOUT_TIME);
-
-		spin_lock_irqsave(&intf->xmit_msgs_lock, flags);
-		if (watch_mask != intf->last_watch_mask &&
-					intf->handlers->set_need_watch)
-			intf->handlers->set_need_watch(intf->send_info,
-						       watch_mask);
-		intf->last_watch_mask = watch_mask;
-		spin_unlock_irqrestore(&intf->xmit_msgs_lock, flags);
+		need_timer |= ipmi_timeout_handler(intf, IPMI_TIMEOUT_TIME);
 	}
 	srcu_read_unlock(&ipmi_interfaces_srcu, index);
 
-	if (watch_mask)
+	if (need_timer)
 		mod_timer(&ipmi_timer, jiffies + IPMI_TIMEOUT_JIFFIES);
 }
 
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 429fe063e33f..8c7a1b8f9689 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1079,7 +1079,7 @@ static void set_need_watch(void *send_info, unsigned int watch_mask)
 	unsigned long flags;
 	int enable;
 
-	enable = !!(watch_mask & ~IPMI_WATCH_MASK_INTERNAL);
+	enable = !!watch_mask;
 
 	atomic_set(&smi_info->need_watch, enable);
 	spin_lock_irqsave(&smi_info->si_lock, flags);
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 34c5b287c412..fc4a96014161 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1159,7 +1159,7 @@ static void ssif_set_need_watch(void *send_info, unsigned int watch_mask)
 
 	if (watch_mask & IPMI_WATCH_MASK_CHECK_MESSAGES)
 		timeout = SSIF_WATCH_MSG_TIMEOUT;
-	else if (watch_mask & ~IPMI_WATCH_MASK_INTERNAL)
+	else if (watch_mask)
 		timeout = SSIF_WATCH_WATCHDOG_TIMEOUT;
 
 	flags = ipmi_ssif_lock_cond(ssif_info, &oflags);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index f2481a2014bb..2b7ecc02b277 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1327,7 +1327,7 @@ int exynos_g2d_exec_ioctl(struct drm_device *drm_dev, void *data,
 	/* Let the runqueue know that there is work to do. */
 	queue_work(g2d->g2d_workq, &g2d->runqueue_work);
 
-	if (runqueue_node->async)
+	if (req->async)
 		goto out;
 
 	wait_for_completion(&runqueue_node->complete);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 19697c1362d8..947c9627c565 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -480,8 +480,6 @@ static int vidi_remove(struct platform_device *pdev)
 	if (ctx->raw_edid != (struct edid *)fake_edid_info) {
 		kfree(ctx->raw_edid);
 		ctx->raw_edid = NULL;
-
-		return -EINVAL;
 	}
 
 	component_del(&pdev->dev, &vidi_component_ops);
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 27d8e7dd2d06..46f7789693ea 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -377,7 +377,6 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 	struct radeon_device *rdev = dev->dev_private;
 	struct drm_radeon_gem_set_domain *args = data;
 	struct drm_gem_object *gobj;
-	struct radeon_bo *robj;
 	int r;
 
 	/* for now if someone requests domain CPU -
@@ -390,13 +389,12 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 		up_read(&rdev->exclusive_lock);
 		return -ENOENT;
 	}
-	robj = gem_to_radeon_bo(gobj);
 
 	r = radeon_gem_set_domain(gobj, args->read_domains, args->write_domain);
 
 	drm_gem_object_put_unlocked(gobj);
 	up_read(&rdev->exclusive_lock);
-	r = radeon_gem_handle_lockup(robj->rdev, r);
+	r = radeon_gem_handle_lockup(rdev, r);
 	return r;
 }
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 4e4a3424c1f9..c50b26a9bc44 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2390,8 +2390,13 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		goto fail_quirks;
 	}
 
-	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
+	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
 		error = hid_hw_open(hdev);
+		if (error) {
+			hid_err(hdev, "hw open failed\n");
+			goto fail_quirks;
+		}
+	}
 
 	wacom_set_shared_values(wacom_wac);
 	devres_close_group(&hdev->dev, wacom);
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index ccfa5ceb43c0..f79346de7f88 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -813,11 +813,22 @@ static void vmbus_wait_for_unload(void)
 		if (completion_done(&vmbus_connection.unload_event))
 			goto completed;
 
-		for_each_online_cpu(cpu) {
+		for_each_present_cpu(cpu) {
 			struct hv_per_cpu_context *hv_cpu
 				= per_cpu_ptr(hv_context.cpu_context, cpu);
 
+			/*
+			 * In a CoCo VM the synic_message_page is not allocated
+			 * in hv_synic_alloc(). Instead it is set/cleared in
+			 * hv_synic_enable_regs() and hv_synic_disable_regs()
+			 * such that it is set only when the CPU is online. If
+			 * not all present CPUs are online, the message page
+			 * might be NULL, so skip such CPUs.
+			 */
 			page_addr = hv_cpu->synic_message_page;
+			if (!page_addr)
+				continue;
+
 			msg = (struct hv_message *)page_addr
 				+ VMBUS_MESSAGE_SINT;
 
@@ -851,11 +862,14 @@ static void vmbus_wait_for_unload(void)
 	 * maybe-pending messages on all CPUs to be able to receive new
 	 * messages after we reconnect.
 	 */
-	for_each_online_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
 		page_addr = hv_cpu->synic_message_page;
+		if (!page_addr)
+			continue;
+
 		msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
 		msg->header.message_type = HVMSG_NONE;
 	}
diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index f494b2749700..a4f90796032b 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -206,8 +206,8 @@ static void lpi2c_imx_stop(struct lpi2c_imx_struct *lpi2c_imx)
 /* CLKLO = I2C_CLK_RATIO * CLKHI, SETHOLD = CLKHI, DATAVD = CLKHI/2 */
 static int lpi2c_imx_config(struct lpi2c_imx_struct *lpi2c_imx)
 {
-	u8 prescale, filt, sethold, clkhi, clklo, datavd;
-	unsigned int clk_rate, clk_cycle;
+	u8 prescale, filt, sethold, datavd;
+	unsigned int clk_rate, clk_cycle, clkhi, clklo;
 	enum lpi2c_imx_pincfg pincfg;
 	unsigned int temp;
 
diff --git a/drivers/media/cec/cec-adap.c b/drivers/media/cec/cec-adap.c
index a42043379d67..2f49c4db49b3 100644
--- a/drivers/media/cec/cec-adap.c
+++ b/drivers/media/cec/cec-adap.c
@@ -1032,7 +1032,8 @@ void cec_received_msg_ts(struct cec_adapter *adap,
 	mutex_lock(&adap->lock);
 	dprintk(2, "%s: %*ph\n", __func__, msg->len, msg->msg);
 
-	adap->last_initiator = 0xff;
+	if (!adap->transmit_in_progress)
+		adap->last_initiator = 0xff;
 
 	/* Check if this message was for us (directed or broadcast). */
 	if (!cec_msg_is_broadcast(msg))
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 967e47770af6..d42c5da1a226 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1912,7 +1912,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
-		ret = -EINVAL;
+		ret = host->irq;
 		goto host_free;
 	}
 
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index e22bbff89c8d..fff9980a3ef2 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -699,17 +699,15 @@ static int mvsd_probe(struct platform_device *pdev)
 	struct mmc_host *mmc = NULL;
 	struct mvsd_host *host = NULL;
 	const struct mbus_dram_target_info *dram;
-	struct resource *r;
 	int ret, irq;
 
 	if (!np) {
 		dev_err(&pdev->dev, "no DT node\n");
 		return -ENODEV;
 	}
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
-	if (!r || irq < 0)
-		return -ENXIO;
+	if (irq < 0)
+		return irq;
 
 	mmc = mmc_alloc_host(sizeof(struct mvsd_host), &pdev->dev);
 	if (!mmc) {
@@ -761,7 +759,7 @@ static int mvsd_probe(struct platform_device *pdev)
 
 	spin_lock_init(&host->lock);
 
-	host->base = devm_ioremap_resource(&pdev->dev, r);
+	host->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(host->base)) {
 		ret = PTR_ERR(host->base);
 		goto out;
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index b2873a2432b6..345b35483cee 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1347,7 +1347,7 @@ static int mmc_omap_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -ENXIO;
+		return irq;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->virt_base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 0135693afa15..881d1de4a563 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2006,9 +2006,11 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
-	if (res == NULL || irq < 0)
+	if (!res)
 		return -ENXIO;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 6cc187ce3a32..069b9a07aca5 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -721,7 +721,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	host->ops	= &sdhci_acpi_ops_dflt;
 	host->irq	= platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
-		err = -EINVAL;
+		err = host->irq;
 		goto err_free;
 	}
 
diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index b88728b686e8..e436f7e7a3ee 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1749,8 +1749,10 @@ static int usdhi6_probe(struct platform_device *pdev)
 	irq_cd = platform_get_irq_byname(pdev, "card detect");
 	irq_sd = platform_get_irq_byname(pdev, "data");
 	irq_sdio = platform_get_irq_byname(pdev, "SDIO");
-	if (irq_sd < 0 || irq_sdio < 0)
-		return -ENODEV;
+	if (irq_sd < 0)
+		return irq_sd;
+	if (irq_sdio < 0)
+		return irq_sdio;
 
 	mmc = mmc_alloc_host(sizeof(struct usdhi6_host), dev);
 	if (!mmc)
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 05cb2f7cc35c..8603df2ae173 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1136,8 +1136,8 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 	eth_hdr_len = ntohs(skb->protocol) == ETH_P_8021Q ?
 						VLAN_ETH_HLEN : ETH_HLEN;
 	if (skb->len <= 60 &&
-	    (lancer_chip(adapter) || skb_vlan_tag_present(skb)) &&
-	    is_ipv4_pkt(skb)) {
+	    (lancer_chip(adapter) || BE3_chip(adapter) ||
+	     skb_vlan_tag_present(skb)) && is_ipv4_pkt(skb)) {
 		ip = (struct iphdr *)ip_hdr(skb);
 		pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len));
 	}
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index afd49c7fd87f..3e6095f0cb5f 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -553,8 +553,7 @@ qcaspi_spi_thread(void *data)
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		if ((qca->intr_req == qca->intr_svc) &&
-		    (qca->txr.skb[qca->txr.head] == NULL) &&
-		    (qca->sync == QCASPI_SYNC_READY))
+		    !qca->txr.skb[qca->txr.head])
 			schedule();
 
 		set_current_state(TASK_RUNNING);
diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index d07e5571e07a..1ac600d18688 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -540,7 +540,7 @@ static int hwsim_del_edge_nl(struct sk_buff *msg, struct genl_info *info)
 static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
 {
 	struct nlattr *edge_attrs[MAC802154_HWSIM_EDGE_ATTR_MAX + 1];
-	struct hwsim_edge_info *einfo;
+	struct hwsim_edge_info *einfo, *einfo_old;
 	struct hwsim_phy *phy_v0;
 	struct hwsim_edge *e;
 	u32 v0, v1;
@@ -580,8 +580,10 @@ static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
 	list_for_each_entry_rcu(e, &phy_v0->edges, list) {
 		if (e->endpoint->idx == v1) {
 			einfo->lqi = lqi;
-			rcu_assign_pointer(e->info, einfo);
+			einfo_old = rcu_replace_pointer(e->info, einfo,
+							lockdep_is_held(&hwsim_phys_lock));
 			rcu_read_unlock();
+			kfree_rcu(einfo_old, rcu);
 			mutex_unlock(&hwsim_phys_lock);
 			return 0;
 		}
diff --git a/drivers/nfc/nfcsim.c b/drivers/nfc/nfcsim.c
index 533e3aa6275c..cf07b366500e 100644
--- a/drivers/nfc/nfcsim.c
+++ b/drivers/nfc/nfcsim.c
@@ -345,10 +345,6 @@ static struct dentry *nfcsim_debugfs_root;
 static void nfcsim_debugfs_init(void)
 {
 	nfcsim_debugfs_root = debugfs_create_dir("nfcsim", NULL);
-
-	if (!nfcsim_debugfs_root)
-		pr_err("Could not create debugfs entry\n");
-
 }
 
 static void nfcsim_debugfs_remove(void)
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 63c79e140f1a..f5f201bfc814 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2445,6 +2445,24 @@ static int hv_pci_query_relations(struct hv_device *hdev)
 	if (!ret)
 		ret = wait_for_response(hdev, &comp);
 
+	/*
+	 * In the case of fast device addition/removal, it's possible that
+	 * vmbus_sendpacket() or wait_for_response() returns -ENODEV but we
+	 * already got a PCI_BUS_RELATIONS* message from the host and the
+	 * channel callback already scheduled a work to hbus->wq, which can be
+	 * running pci_devices_present_work() -> survey_child_resources() ->
+	 * complete(&hbus->survey_event), even after hv_pci_query_relations()
+	 * exits and the stack variable 'comp' is no longer valid; as a result,
+	 * a hang or a page fault may happen when the complete() calls
+	 * raw_spin_lock_irqsave(). Flush hbus->wq before we exit from
+	 * hv_pci_query_relations() to avoid the issues. Note: if 'ret' is
+	 * -ENODEV, there can't be any more work item scheduled to hbus->wq
+	 * after the flush_workqueue(): see vmbus_onoffer_rescind() ->
+	 * vmbus_reset_channel_cb(), vmbus_rescind_cleanup() ->
+	 * channel->rescind = true.
+	 */
+	flush_workqueue(hbus->wq);
+
 	return ret;
 }
 
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index c9bc9a6bd73b..ee4338158ae2 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1353,6 +1353,7 @@ void ccw_device_set_notoper(struct ccw_device *cdev)
 enum io_sch_action {
 	IO_SCH_UNREG,
 	IO_SCH_ORPH_UNREG,
+	IO_SCH_UNREG_CDEV,
 	IO_SCH_ATTACH,
 	IO_SCH_UNREG_ATTACH,
 	IO_SCH_ORPH_ATTACH,
@@ -1385,7 +1386,7 @@ static enum io_sch_action sch_get_action(struct subchannel *sch)
 	}
 	if ((sch->schib.pmcw.pam & sch->opm) == 0) {
 		if (ccw_device_notify(cdev, CIO_NO_PATH) != NOTIFY_OK)
-			return IO_SCH_UNREG;
+			return IO_SCH_UNREG_CDEV;
 		return IO_SCH_DISC;
 	}
 	if (device_is_disconnected(cdev))
@@ -1447,6 +1448,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 	case IO_SCH_ORPH_ATTACH:
 		ccw_device_set_disconnected(cdev);
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 	case IO_SCH_UNREG:
 		if (!cdev)
@@ -1480,6 +1482,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 		if (rc)
 			goto out;
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 		spin_lock_irqsave(sch->lock, flags);
 		if (cdev->private->flags.resuming) {
diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index 5db8842a8026..e39177f9fdb0 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -1072,6 +1072,7 @@ int iscsi_target_locate_portal(
 	iscsi_target_set_sock_callbacks(conn);
 
 	login->np = np;
+	conn->tpg = NULL;
 
 	login_req = (struct iscsi_login_req *) login->req;
 	payload_length = ntoh24(login_req->dlength);
@@ -1141,7 +1142,6 @@ int iscsi_target_locate_portal(
 	 */
 	sessiontype = strncmp(s_buf, DISCOVERY, 9);
 	if (!sessiontype) {
-		conn->tpg = iscsit_global->discovery_tpg;
 		if (!login->leading_connection)
 			goto get_target;
 
@@ -1158,9 +1158,11 @@ int iscsi_target_locate_portal(
 		 * Serialize access across the discovery struct iscsi_portal_group to
 		 * process login attempt.
 		 */
+		conn->tpg = iscsit_global->discovery_tpg;
 		if (iscsit_access_np(np, conn->tpg) < 0) {
 			iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
 				ISCSI_LOGIN_STATUS_SVC_UNAVAILABLE);
+			conn->tpg = NULL;
 			ret = -1;
 			goto out;
 		}
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 044128277248..6cd168cb673f 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -113,6 +113,13 @@ struct ltq_uart_port {
 	unsigned int		err_irq;
 };
 
+static inline void asc_update_bits(u32 clear, u32 set, void __iomem *reg)
+{
+	u32 tmp = __raw_readl(reg);
+
+	__raw_writel((tmp & ~clear) | set, reg);
+}
+
 static inline struct
 ltq_uart_port *to_ltq_uart_port(struct uart_port *port)
 {
@@ -138,7 +145,7 @@ lqasc_start_tx(struct uart_port *port)
 static void
 lqasc_stop_rx(struct uart_port *port)
 {
-	ltq_w32(ASCWHBSTATE_CLRREN, port->membase + LTQ_ASC_WHBSTATE);
+	__raw_writel(ASCWHBSTATE_CLRREN, port->membase + LTQ_ASC_WHBSTATE);
 }
 
 static int
@@ -147,11 +154,12 @@ lqasc_rx_chars(struct uart_port *port)
 	struct tty_port *tport = &port->state->port;
 	unsigned int ch = 0, rsr = 0, fifocnt;
 
-	fifocnt = ltq_r32(port->membase + LTQ_ASC_FSTAT) & ASCFSTAT_RXFFLMASK;
+	fifocnt = __raw_readl(port->membase + LTQ_ASC_FSTAT) &
+		  ASCFSTAT_RXFFLMASK;
 	while (fifocnt--) {
 		u8 flag = TTY_NORMAL;
-		ch = ltq_r8(port->membase + LTQ_ASC_RBUF);
-		rsr = (ltq_r32(port->membase + LTQ_ASC_STATE)
+		ch = readb(port->membase + LTQ_ASC_RBUF);
+		rsr = (__raw_readl(port->membase + LTQ_ASC_STATE)
 			& ASCSTATE_ANY) | UART_DUMMY_UER_RX;
 		tty_flip_buffer_push(tport);
 		port->icount.rx++;
@@ -163,16 +171,16 @@ lqasc_rx_chars(struct uart_port *port)
 		if (rsr & ASCSTATE_ANY) {
 			if (rsr & ASCSTATE_PE) {
 				port->icount.parity++;
-				ltq_w32_mask(0, ASCWHBSTATE_CLRPE,
+				asc_update_bits(0, ASCWHBSTATE_CLRPE,
 					port->membase + LTQ_ASC_WHBSTATE);
 			} else if (rsr & ASCSTATE_FE) {
 				port->icount.frame++;
-				ltq_w32_mask(0, ASCWHBSTATE_CLRFE,
+				asc_update_bits(0, ASCWHBSTATE_CLRFE,
 					port->membase + LTQ_ASC_WHBSTATE);
 			}
 			if (rsr & ASCSTATE_ROE) {
 				port->icount.overrun++;
-				ltq_w32_mask(0, ASCWHBSTATE_CLRROE,
+				asc_update_bits(0, ASCWHBSTATE_CLRROE,
 					port->membase + LTQ_ASC_WHBSTATE);
 			}
 
@@ -211,10 +219,10 @@ lqasc_tx_chars(struct uart_port *port)
 		return;
 	}
 
-	while (((ltq_r32(port->membase + LTQ_ASC_FSTAT) &
+	while (((__raw_readl(port->membase + LTQ_ASC_FSTAT) &
 		ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF) != 0) {
 		if (port->x_char) {
-			ltq_w8(port->x_char, port->membase + LTQ_ASC_TBUF);
+			writeb(port->x_char, port->membase + LTQ_ASC_TBUF);
 			port->icount.tx++;
 			port->x_char = 0;
 			continue;
@@ -223,7 +231,7 @@ lqasc_tx_chars(struct uart_port *port)
 		if (uart_circ_empty(xmit))
 			break;
 
-		ltq_w8(port->state->xmit.buf[port->state->xmit.tail],
+		writeb(port->state->xmit.buf[port->state->xmit.tail],
 			port->membase + LTQ_ASC_TBUF);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
@@ -239,7 +247,7 @@ lqasc_tx_int(int irq, void *_port)
 	unsigned long flags;
 	struct uart_port *port = (struct uart_port *)_port;
 	spin_lock_irqsave(&ltq_asc_lock, flags);
-	ltq_w32(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
+	__raw_writel(ASC_IRNCR_TIR, port->membase + LTQ_ASC_IRNCR);
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 	lqasc_start_tx(port);
 	return IRQ_HANDLED;
@@ -251,8 +259,9 @@ lqasc_err_int(int irq, void *_port)
 	unsigned long flags;
 	struct uart_port *port = (struct uart_port *)_port;
 	spin_lock_irqsave(&ltq_asc_lock, flags);
+	__raw_writel(ASC_IRNCR_EIR, port->membase + LTQ_ASC_IRNCR);
 	/* clear any pending interrupts */
-	ltq_w32_mask(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
+	asc_update_bits(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
 		ASCWHBSTATE_CLRROE, port->membase + LTQ_ASC_WHBSTATE);
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 	return IRQ_HANDLED;
@@ -264,7 +273,7 @@ lqasc_rx_int(int irq, void *_port)
 	unsigned long flags;
 	struct uart_port *port = (struct uart_port *)_port;
 	spin_lock_irqsave(&ltq_asc_lock, flags);
-	ltq_w32(ASC_IRNCR_RIR, port->membase + LTQ_ASC_IRNCR);
+	__raw_writel(ASC_IRNCR_RIR, port->membase + LTQ_ASC_IRNCR);
 	lqasc_rx_chars(port);
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 	return IRQ_HANDLED;
@@ -274,7 +283,8 @@ static unsigned int
 lqasc_tx_empty(struct uart_port *port)
 {
 	int status;
-	status = ltq_r32(port->membase + LTQ_ASC_FSTAT) & ASCFSTAT_TXFFLMASK;
+	status = __raw_readl(port->membase + LTQ_ASC_FSTAT) &
+		 ASCFSTAT_TXFFLMASK;
 	return status ? 0 : TIOCSER_TEMT;
 }
 
@@ -304,15 +314,15 @@ lqasc_startup(struct uart_port *port)
 		clk_enable(ltq_port->clk);
 	port->uartclk = clk_get_rate(ltq_port->fpiclk);
 
-	ltq_w32_mask(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
+	asc_update_bits(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
 		port->membase + LTQ_ASC_CLC);
 
-	ltq_w32(0, port->membase + LTQ_ASC_PISEL);
-	ltq_w32(
+	__raw_writel(0, port->membase + LTQ_ASC_PISEL);
+	__raw_writel(
 		((TXFIFO_FL << ASCTXFCON_TXFITLOFF) & ASCTXFCON_TXFITLMASK) |
 		ASCTXFCON_TXFEN | ASCTXFCON_TXFFLU,
 		port->membase + LTQ_ASC_TXFCON);
-	ltq_w32(
+	__raw_writel(
 		((RXFIFO_FL << ASCRXFCON_RXFITLOFF) & ASCRXFCON_RXFITLMASK)
 		| ASCRXFCON_RXFEN | ASCRXFCON_RXFFLU,
 		port->membase + LTQ_ASC_RXFCON);
@@ -320,7 +330,7 @@ lqasc_startup(struct uart_port *port)
 	 * setting enable bits
 	 */
 	wmb();
-	ltq_w32_mask(0, ASCCON_M_8ASYNC | ASCCON_FEN | ASCCON_TOEN |
+	asc_update_bits(0, ASCCON_M_8ASYNC | ASCCON_FEN | ASCCON_TOEN |
 		ASCCON_ROEN, port->membase + LTQ_ASC_CON);
 
 	retval = request_irq(ltq_port->tx_irq, lqasc_tx_int,
@@ -344,7 +354,7 @@ lqasc_startup(struct uart_port *port)
 		goto err2;
 	}
 
-	ltq_w32(ASC_IRNREN_RX | ASC_IRNREN_ERR | ASC_IRNREN_TX,
+	__raw_writel(ASC_IRNREN_RX | ASC_IRNREN_ERR | ASC_IRNREN_TX,
 		port->membase + LTQ_ASC_IRNREN);
 	return 0;
 
@@ -363,10 +373,10 @@ lqasc_shutdown(struct uart_port *port)
 	free_irq(ltq_port->rx_irq, port);
 	free_irq(ltq_port->err_irq, port);
 
-	ltq_w32(0, port->membase + LTQ_ASC_CON);
-	ltq_w32_mask(ASCRXFCON_RXFEN, ASCRXFCON_RXFFLU,
+	__raw_writel(0, port->membase + LTQ_ASC_CON);
+	asc_update_bits(ASCRXFCON_RXFEN, ASCRXFCON_RXFFLU,
 		port->membase + LTQ_ASC_RXFCON);
-	ltq_w32_mask(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
+	asc_update_bits(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
 		port->membase + LTQ_ASC_TXFCON);
 	if (!IS_ERR(ltq_port->clk))
 		clk_disable(ltq_port->clk);
@@ -438,7 +448,7 @@ lqasc_set_termios(struct uart_port *port,
 	spin_lock_irqsave(&ltq_asc_lock, flags);
 
 	/* set up CON */
-	ltq_w32_mask(0, con, port->membase + LTQ_ASC_CON);
+	asc_update_bits(0, con, port->membase + LTQ_ASC_CON);
 
 	/* Set baud rate - take a divider of 2 into account */
 	baud = uart_get_baud_rate(port, new, old, 0, port->uartclk / 16);
@@ -446,22 +456,22 @@ lqasc_set_termios(struct uart_port *port,
 	divisor = divisor / 2 - 1;
 
 	/* disable the baudrate generator */
-	ltq_w32_mask(ASCCON_R, 0, port->membase + LTQ_ASC_CON);
+	asc_update_bits(ASCCON_R, 0, port->membase + LTQ_ASC_CON);
 
 	/* make sure the fractional divider is off */
-	ltq_w32_mask(ASCCON_FDE, 0, port->membase + LTQ_ASC_CON);
+	asc_update_bits(ASCCON_FDE, 0, port->membase + LTQ_ASC_CON);
 
 	/* set up to use divisor of 2 */
-	ltq_w32_mask(ASCCON_BRS, 0, port->membase + LTQ_ASC_CON);
+	asc_update_bits(ASCCON_BRS, 0, port->membase + LTQ_ASC_CON);
 
 	/* now we can write the new baudrate into the register */
-	ltq_w32(divisor, port->membase + LTQ_ASC_BG);
+	__raw_writel(divisor, port->membase + LTQ_ASC_BG);
 
 	/* turn the baudrate generator back on */
-	ltq_w32_mask(0, ASCCON_R, port->membase + LTQ_ASC_CON);
+	asc_update_bits(0, ASCCON_R, port->membase + LTQ_ASC_CON);
 
 	/* enable rx */
-	ltq_w32(ASCWHBSTATE_SETREN, port->membase + LTQ_ASC_WHBSTATE);
+	__raw_writel(ASCWHBSTATE_SETREN, port->membase + LTQ_ASC_WHBSTATE);
 
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 
@@ -572,10 +582,10 @@ lqasc_console_putchar(struct uart_port *port, int ch)
 		return;
 
 	do {
-		fifofree = (ltq_r32(port->membase + LTQ_ASC_FSTAT)
+		fifofree = (__raw_readl(port->membase + LTQ_ASC_FSTAT)
 			& ASCFSTAT_TXFREEMASK) >> ASCFSTAT_TXFREEOFF;
 	} while (fifofree == 0);
-	ltq_w8(ch, port->membase + LTQ_ASC_TBUF);
+	writeb(ch, port->membase + LTQ_ASC_TBUF);
 }
 
 static void lqasc_serial_port_write(struct uart_port *port, const char *s,
diff --git a/drivers/usb/gadget/udc/amd5536udc_pci.c b/drivers/usb/gadget/udc/amd5536udc_pci.c
index 362284057d30..a3d15c3fb82a 100644
--- a/drivers/usb/gadget/udc/amd5536udc_pci.c
+++ b/drivers/usb/gadget/udc/amd5536udc_pci.c
@@ -171,6 +171,9 @@ static int udc_pci_probe(
 		retval = -ENODEV;
 		goto err_probe;
 	}
+
+	udc = dev;
+
 	return 0;
 
 err_probe:
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index c726b42ca92d..e5fee7fac915 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -372,7 +372,15 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 			struct page *page = pvec.pages[i];
 
 			lock_page(page);
-			nilfs_clear_dirty_page(page, silent);
+
+			/*
+			 * This page may have been removed from the address
+			 * space by truncation or invalidation when the lock
+			 * was acquired.  Skip processing in that case.
+			 */
+			if (likely(page->mapping == mapping))
+				nilfs_clear_dirty_page(page, silent);
+
 			unlock_page(page);
 		}
 		pagevec_release(&pvec);
diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 20c479b5e41b..e72466fc8ca9 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -101,6 +101,12 @@ int nilfs_segbuf_extend_segsum(struct nilfs_segment_buffer *segbuf)
 	if (unlikely(!bh))
 		return -ENOMEM;
 
+	lock_buffer(bh);
+	if (!buffer_uptodate(bh)) {
+		memset(bh->b_data, 0, bh->b_size);
+		set_buffer_uptodate(bh);
+	}
+	unlock_buffer(bh);
 	nilfs_segbuf_add_segsum_buffer(segbuf, bh);
 	return 0;
 }
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 3091d1a3edde..d9e0b2b2b555 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -984,10 +984,13 @@ static void nilfs_segctor_fill_in_super_root(struct nilfs_sc_info *sci,
 	unsigned int isz, srsz;
 
 	bh_sr = NILFS_LAST_SEGBUF(&sci->sc_segbufs)->sb_super_root;
+
+	lock_buffer(bh_sr);
 	raw_sr = (struct nilfs_super_root *)bh_sr->b_data;
 	isz = nilfs->ns_inode_size;
 	srsz = NILFS_SR_BYTES(isz);
 
+	raw_sr->sr_sum = 0;  /* Ensure initialization within this update */
 	raw_sr->sr_bytes = cpu_to_le16(srsz);
 	raw_sr->sr_nongc_ctime
 		= cpu_to_le64(nilfs_doing_gc() ?
@@ -1001,6 +1004,8 @@ static void nilfs_segctor_fill_in_super_root(struct nilfs_sc_info *sci,
 	nilfs_write_inode_common(nilfs->ns_sufile, (void *)raw_sr +
 				 NILFS_SR_SUFILE_OFFSET(isz), 1);
 	memset((void *)raw_sr + srsz, 0, nilfs->ns_blocksize - srsz);
+	set_buffer_uptodate(bh_sr);
+	unlock_buffer(bh_sr);
 }
 
 static void nilfs_redirty_inodes(struct list_head *head)
@@ -1778,6 +1783,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 	list_for_each_entry(segbuf, logs, sb_list) {
 		list_for_each_entry(bh, &segbuf->sb_segsum_buffers,
 				    b_assoc_buffers) {
+			clear_buffer_uptodate(bh);
 			if (bh->b_page != bd_page) {
 				if (bd_page)
 					end_page_writeback(bd_page);
@@ -1789,6 +1795,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 				    b_assoc_buffers) {
 			clear_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
+				clear_buffer_uptodate(bh);
 				if (bh->b_page != bd_page) {
 					end_page_writeback(bd_page);
 					bd_page = bh->b_page;
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 221a54faab52..99bcb4ab47a6 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -374,10 +374,31 @@ static int nilfs_move_2nd_super(struct super_block *sb, loff_t sb2off)
 		goto out;
 	}
 	nsbp = (void *)nsbh->b_data + offset;
-	memset(nsbp, 0, nilfs->ns_blocksize);
 
+	lock_buffer(nsbh);
 	if (sb2i >= 0) {
+		/*
+		 * The position of the second superblock only changes by 4KiB,
+		 * which is larger than the maximum superblock data size
+		 * (= 1KiB), so there is no need to use memmove() to allow
+		 * overlap between source and destination.
+		 */
 		memcpy(nsbp, nilfs->ns_sbp[sb2i], nilfs->ns_sbsize);
+
+		/*
+		 * Zero fill after copy to avoid overwriting in case of move
+		 * within the same block.
+		 */
+		memset(nsbh->b_data, 0, offset);
+		memset((void *)nsbp + nilfs->ns_sbsize, 0,
+		       nsbh->b_size - offset - nilfs->ns_sbsize);
+	} else {
+		memset(nsbh->b_data, 0, nsbh->b_size);
+	}
+	set_buffer_uptodate(nsbh);
+	unlock_buffer(nsbh);
+
+	if (sb2i >= 0) {
 		brelse(nilfs->ns_sbh[sb2i]);
 		nilfs->ns_sbh[sb2i] = nsbh;
 		nilfs->ns_sbp[sb2i] = nsbp;
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index 24f626e7d012..d550a564645e 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -375,6 +375,18 @@ unsigned long nilfs_nrsvsegs(struct the_nilfs *nilfs, unsigned long nsegs)
 				  100));
 }
 
+/**
+ * nilfs_max_segment_count - calculate the maximum number of segments
+ * @nilfs: nilfs object
+ */
+static u64 nilfs_max_segment_count(struct the_nilfs *nilfs)
+{
+	u64 max_count = U64_MAX;
+
+	do_div(max_count, nilfs->ns_blocks_per_segment);
+	return min_t(u64, max_count, ULONG_MAX);
+}
+
 void nilfs_set_nsegments(struct the_nilfs *nilfs, unsigned long nsegs)
 {
 	nilfs->ns_nsegments = nsegs;
@@ -384,6 +396,8 @@ void nilfs_set_nsegments(struct the_nilfs *nilfs, unsigned long nsegs)
 static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 				   struct nilfs_super_block *sbp)
 {
+	u64 nsegments, nblocks;
+
 	if (le32_to_cpu(sbp->s_rev_level) < NILFS_MIN_SUPP_REV) {
 		nilfs_msg(nilfs->ns_sb, KERN_ERR,
 			  "unsupported revision (superblock rev.=%d.%d, current rev.=%d.%d). Please check the version of mkfs.nilfs(2).",
@@ -430,7 +444,35 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 		return -EINVAL;
 	}
 
-	nilfs_set_nsegments(nilfs, le64_to_cpu(sbp->s_nsegments));
+	nsegments = le64_to_cpu(sbp->s_nsegments);
+	if (nsegments > nilfs_max_segment_count(nilfs)) {
+		nilfs_msg(nilfs->ns_sb, KERN_ERR,
+			  "segment count %llu exceeds upper limit (%llu segments)",
+			  (unsigned long long)nsegments,
+			  (unsigned long long)nilfs_max_segment_count(nilfs));
+		return -EINVAL;
+	}
+
+	nblocks = (u64)i_size_read(nilfs->ns_sb->s_bdev->bd_inode) >>
+		nilfs->ns_sb->s_blocksize_bits;
+	if (nblocks) {
+		u64 min_block_count = nsegments * nilfs->ns_blocks_per_segment;
+		/*
+		 * To avoid failing to mount early device images without a
+		 * second superblock, exclude that block count from the
+		 * "min_block_count" calculation.
+		 */
+
+		if (nblocks < min_block_count) {
+			nilfs_msg(nilfs->ns_sb, KERN_ERR,
+				  "total number of segment blocks %llu exceeds device size (%llu blocks)",
+				  (unsigned long long)min_block_count,
+				  (unsigned long long)nblocks);
+			return -EINVAL;
+		}
+	}
+
+	nilfs_set_nsegments(nilfs, nsegments);
 	nilfs->ns_crc_seed = le32_to_cpu(sbp->s_crc_seed);
 	return 0;
 }
diff --git a/include/linux/ipmi_smi.h b/include/linux/ipmi_smi.h
index 86b119400f30..75865064c70b 100644
--- a/include/linux/ipmi_smi.h
+++ b/include/linux/ipmi_smi.h
@@ -32,14 +32,11 @@ typedef struct ipmi_smi *ipmi_smi_t;
 
 /*
  * Flags for set_check_watch() below.  Tells if the SMI should be
- * waiting for watchdog timeouts, commands and/or messages.  There is
- * also an internal flag for the message handler, SMIs should ignore
- * it.
+ * waiting for watchdog timeouts, commands and/or messages.
  */
-#define IPMI_WATCH_MASK_INTERNAL	(1 << 0)
-#define IPMI_WATCH_MASK_CHECK_MESSAGES	(1 << 1)
-#define IPMI_WATCH_MASK_CHECK_WATCHDOG	(1 << 2)
-#define IPMI_WATCH_MASK_CHECK_COMMANDS	(1 << 3)
+#define IPMI_WATCH_MASK_CHECK_MESSAGES	(1 << 0)
+#define IPMI_WATCH_MASK_CHECK_WATCHDOG	(1 << 1)
+#define IPMI_WATCH_MASK_CHECK_COMMANDS	(1 << 2)
 
 /*
  * Messages to/from the lower layer.  The smi interface will take one
@@ -66,12 +63,6 @@ struct ipmi_smi_msg {
 	int           rsp_size;
 	unsigned char rsp[IPMI_MAX_MSG_LENGTH];
 
-	/*
-	 * There should be a response message coming back in the BMC
-	 * message queue.
-	 */
-	bool needs_response;
-
 	/*
 	 * Will be called when the system is done with the message
 	 * (presumably to free it).
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 68cbe111420b..cf139d6e5c1d 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -410,6 +410,24 @@ static inline void rcu_preempt_sleep_check(void) { }
 	_r_a_p__v;							      \
 })
 
+/**
+ * rcu_replace_pointer() - replace an RCU pointer, returning its old value
+ * @rcu_ptr: RCU pointer, whose old value is returned
+ * @ptr: regular pointer
+ * @c: the lockdep conditions under which the dereference will take place
+ *
+ * Perform a replacement, where @rcu_ptr is an RCU-annotated
+ * pointer and @c is the lockdep argument that is passed to the
+ * rcu_dereference_protected() call used to read that pointer.  The old
+ * value of @rcu_ptr is returned, and @rcu_ptr is set to @ptr.
+ */
+#define rcu_replace_pointer(rcu_ptr, ptr, c)				\
+({									\
+	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
+	rcu_assign_pointer((rcu_ptr), (ptr));				\
+	__tmp;								\
+})
+
 /**
  * rcu_swap_protected() - swap an RCU and a regular pointer
  * @rcu_ptr: RCU pointer
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a8185cdb8587..6322b56529e9 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1652,7 +1652,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 {
 	struct cgroup *dcgrp = &dst_root->cgrp;
 	struct cgroup_subsys *ss;
-	int ssid, i, ret;
+	int ssid, ret;
 	u16 dfl_disable_ss_mask = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
@@ -1696,7 +1696,8 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		struct cgroup_root *src_root = ss->root;
 		struct cgroup *scgrp = &src_root->cgrp;
 		struct cgroup_subsys_state *css = cgroup_css(scgrp, ss);
-		struct css_set *cset;
+		struct css_set *cset, *cset_pos;
+		struct css_task_iter *it;
 
 		WARN_ON(!css || cgroup_css(dcgrp, ss));
 
@@ -1714,9 +1715,22 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		css->cgroup = dcgrp;
 
 		spin_lock_irq(&css_set_lock);
-		hash_for_each(css_set_table, i, cset, hlist)
+		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
+		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
+					 e_cset_node[ss->id]) {
 			list_move_tail(&cset->e_cset_node[ss->id],
 				       &dcgrp->e_csets[ss->id]);
+			/*
+			 * all css_sets of scgrp together in same order to dcgrp,
+			 * patch in-flight iterators to preserve correct iteration.
+			 * since the iterator is always advanced right away and
+			 * finished when it->cset_pos meets it->cset_head, so only
+			 * update it->cset_head is enough here.
+			 */
+			list_for_each_entry(it, &cset->task_iters, iters_node)
+				if (it->cset_head == &scgrp->e_csets[ss->id])
+					it->cset_head = &dcgrp->e_csets[ss->id];
+		}
 		spin_unlock_irq(&css_set_lock);
 
 		/* default hierarchy doesn't enable controllers by default */
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 58834a10c0be..93045373e44b 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -237,6 +237,9 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 
 	secpath_reset(skb);
 
+	if (skb_needs_linearize(skb, skb->dev->features) &&
+	    __skb_linearize(skb))
+		return -ENOMEM;
 	return 0;
 }
 
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index eeee64a8a72c..69313ec24264 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -272,6 +272,9 @@ static int esp6_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features
 
 	secpath_reset(skb);
 
+	if (skb_needs_linearize(skb, skb->dev->features) &&
+	    __skb_linearize(skb))
+		return -ENOMEM;
 	return 0;
 }
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 62bc4cd0b7be..2968f21915dd 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4640,7 +4640,8 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
-	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
+	if (!list_empty(&set->bindings) &&
+	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
 		return -EBUSY;
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
@@ -4823,7 +4824,9 @@ static int nf_tables_delsetelem(struct net *net, struct sock *nlsk,
 	set = nft_set_lookup(ctx.table, nla[NFTA_SET_ELEM_LIST_SET], genmask);
 	if (IS_ERR(set))
 		return PTR_ERR(set);
-	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
+
+	if (!list_empty(&set->bindings) &&
+	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
 		return -EBUSY;
 
 	if (nla[NFTA_SET_ELEM_LIST_ELEMENTS] == NULL) {
diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index 917f06110c82..21e4554c7695 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -442,3 +442,4 @@ module_init(nfnl_osf_init);
 module_exit(nfnl_osf_fini);
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_OSF);
diff --git a/net/netfilter/xt_osf.c b/net/netfilter/xt_osf.c
index bf7bba80e24c..226a317d52a0 100644
--- a/net/netfilter/xt_osf.c
+++ b/net/netfilter/xt_osf.c
@@ -90,4 +90,3 @@ MODULE_AUTHOR("Evgeniy Polyakov <zbr@ioremap.net>");
 MODULE_DESCRIPTION("Passive OS fingerprint matching.");
 MODULE_ALIAS("ipt_osf");
 MODULE_ALIAS("ip6t_osf");
-MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_OSF);
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 31793af1a77b..93548b9e07cf 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -943,6 +943,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	if (ret < 0)
 		return ret;
 
+	sch_tree_lock(sch);
 	/* backup q->clg and q->loss_model */
 	old_clg = q->clg;
 	old_loss_model = q->loss_model;
@@ -951,7 +952,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS]);
 		if (ret) {
 			q->loss_model = old_loss_model;
-			return ret;
+			goto unlock;
 		}
 	} else {
 		q->loss_model = CLG_RANDOM;
@@ -1018,6 +1019,8 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	/* capping jitter to the range acceptable by tabledist() */
 	q->jitter = min_t(s64, abs(q->jitter), INT_MAX);
 
+unlock:
+	sch_tree_unlock(sch);
 	return ret;
 
 get_table_failure:
@@ -1027,7 +1030,8 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	 */
 	q->clg = old_clg;
 	q->loss_model = old_loss_model;
-	return ret;
+
+	goto unlock;
 }
 
 static int netem_init(struct Qdisc *sch, struct nlattr *opt,
diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 4f18bb272e92..0ecea65a80b4 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -1899,6 +1899,30 @@ static const struct dmi_system_id nau8824_quirk_table[] = {
 		},
 		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
 	},
+	{
+		/* Positivo CW14Q01P */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "CW14Q01P"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
+	{
+		/* Positivo K1424G */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "K1424G"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
+	{
+		/* Positivo N14ZP74G */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "N14ZP74G"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
 	{}
 };
 
