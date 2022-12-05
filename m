Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874BB643645
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiLEVAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiLEVAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:00:25 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 080DB26578;
        Mon,  5 Dec 2022 13:00:25 -0800 (PST)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9C4AA20B83E7;
        Mon,  5 Dec 2022 13:00:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C4AA20B83E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1670274024;
        bh=6JJ22vDLZixue1HuFsZ8xRQiC3Hh2+K9lI5MIkS93s4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGmFUkLuy4//eTyXtmNRvxO5TPQOsZOdB2Nn9HYDYsevaAziCzVeBlWrQyJPdNOIW
         GG/4cKKp/ZFSKxSLas4/WJzL/kVpD+y5w1aWPkcJ0v8uyeLL8l7ITWc6Anj5JAw8R6
         2FaxN1uSCm0reerokYNs/Wc1+fTyDFNHdZbkhZMU=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/11] tracing/user_events: Add ioctl for disabling addresses
Date:   Mon,  5 Dec 2022 13:00:11 -0800
Message-Id: <20221205210017.23440-6-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205210017.23440-1-beaub@linux.microsoft.com>
References: <20221205210017.23440-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enablements are now tracked by the lifetime of the task/mm. User
processes need to be able to disable their addresses if tracing is
requested to be turned off. Before unmapping the page would suffice.
However, we now need a stronger contract. Add an ioctl to enable this.

A new flag bit is added, freeing, to user_event_enabler to ensure that
if the event is attempted to be removed while a fault is being handled
that the remove is delayed until after the fault is reattempted.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 include/uapi/linux/user_events.h | 24 +++++++++
 kernel/trace/trace_events_user.c | 93 +++++++++++++++++++++++++++++++-
 2 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
index 5bee4201dad0..833f1f8a8a4a 100644
--- a/include/uapi/linux/user_events.h
+++ b/include/uapi/linux/user_events.h
@@ -46,6 +46,27 @@ struct user_reg {
 	__u32 write_index;
 } __attribute__((__packed__));
 
+/*
+ * Describes an event unregister, callers must set the size, address and bit.
+ * This structure is passed to the DIAG_IOCSUNREG ioctl to disable bit updates.
+ */
+struct user_unreg {
+	/* Input: Size of the user_unreg structure being used */
+	__u32 size;
+
+	/* Input: Bit to unregister */
+	__u8 disable_bit;
+
+	/* Input: Reserved, set to 0 */
+	__u8 __reserved;
+
+	/* Input: Reserved, set to 0 */
+	__u16 __reserved2;
+
+	/* Input: Address to unregister */
+	__u64 disable_addr;
+} __attribute__((__packed__));
+
 #define DIAG_IOC_MAGIC '*'
 
 /* Requests to register a user_event */
@@ -54,4 +75,7 @@ struct user_reg {
 /* Requests to delete a user_event */
 #define DIAG_IOCSDEL _IOW(DIAG_IOC_MAGIC, 1, char*)
 
+/* Requests to unregister a user_event */
+#define DIAG_IOCSUNREG _IOW(DIAG_IOC_MAGIC, 2, struct user_unreg*)
+
 #endif /* _UAPI_LINUX_USER_EVENTS_H */
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 5c061a54086f..ebbde72e1f85 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -102,6 +102,9 @@ struct user_event_enabler {
 /* Bit 6 is for faulting status of enablement */
 #define ENABLE_VAL_FAULTING_BIT 6
 
+/* Bit 7 is for freeing status of enablement */
+#define ENABLE_VAL_FREEING_BIT 7
+
 /* Only duplicate the bit value */
 #define ENABLE_VAL_DUP_MASK ENABLE_VAL_BIT_MASK
 
@@ -301,6 +304,12 @@ static void user_event_enabler_fault_fixup(struct work_struct *work)
 	/* Prevent state changes from racing */
 	mutex_lock(&event_mutex);
 
+	/* User asked for enabler to be removed during fault */
+	if (test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))) {
+		user_event_enabler_destroy(enabler);
+		goto out;
+	}
+
 	/*
 	 * If we managed to get the page, re-issue the write. We do not
 	 * want to get into a possible infinite loop, which is why we only
@@ -315,7 +324,7 @@ static void user_event_enabler_fault_fixup(struct work_struct *work)
 		user_event_enabler_write(mm, enabler, true);
 		mmap_read_unlock(mm->mm);
 	}
-
+out:
 	mutex_unlock(&event_mutex);
 
 	/* In all cases we no longer need the mm or fault */
@@ -370,7 +379,8 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 	if (refcount_read(&mm->tasks) == 0)
 		return -ENOENT;
 
-	if (unlikely(test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler))))
+	if (unlikely(test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)) ||
+		     test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))))
 		return -EBUSY;
 
 	ret = pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
@@ -428,6 +438,10 @@ static bool user_event_enabler_dup(struct user_event_enabler *orig,
 {
 	struct user_event_enabler *enabler;
 
+	/* Skip pending frees */
+	if (unlikely(test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(orig))))
+		return true;
+
 	enabler = kzalloc(sizeof(*enabler), GFP_NOWAIT);
 
 	if (!enabler)
@@ -2069,6 +2083,75 @@ static long user_events_ioctl_del(struct user_event_file_info *info,
 	return ret;
 }
 
+static long user_unreg_get(struct user_unreg __user *ureg,
+			   struct user_unreg *kreg)
+{
+	u32 size;
+	long ret;
+
+	ret = get_user(size, &ureg->size);
+
+	if (ret)
+		return ret;
+
+	if (size > PAGE_SIZE)
+		return -E2BIG;
+
+	if (size < offsetofend(struct user_unreg, disable_addr))
+		return -EINVAL;
+
+	ret = copy_struct_from_user(kreg, sizeof(*kreg), ureg, size);
+
+	return ret;
+}
+
+/*
+ * Unregisters an enablement address/bit within a task/user mm.
+ */
+static long user_events_ioctl_unreg(unsigned long uarg)
+{
+	struct user_unreg __user *ureg = (struct user_unreg __user *)uarg;
+	struct user_event_mm *mm = current->user_event_mm;
+	struct user_event_enabler *enabler, *next;
+	struct user_unreg reg;
+	long ret;
+
+	ret = user_unreg_get(ureg, &reg);
+
+	if (ret)
+		return ret;
+
+	if (!mm)
+		return -ENOENT;
+
+	ret = -ENOENT;
+
+	/*
+	 * Flags freeing and faulting are used to indicate if the enabler is in
+	 * use at all. When faulting is set a page-fault is occurring asyncly.
+	 * During async fault if freeing is set, the enabler will be destroyed.
+	 * If no async fault is happening, we can destroy it now since we hold
+	 * the event_mutex during these checks.
+	 */
+	mutex_lock(&event_mutex);
+
+	list_for_each_entry_safe(enabler, next, &mm->enablers, link)
+		if (enabler->addr == reg.disable_addr &&
+		    (enabler->values & ENABLE_VAL_BIT_MASK) == reg.disable_bit) {
+			set_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler));
+
+			if (!test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)))
+				user_event_enabler_destroy(enabler);
+
+			/* Removed at least one */
+			ret = 0;
+		}
+
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+
 /*
  * Handles the ioctl from user mode to register or alter operations.
  */
@@ -2091,6 +2174,12 @@ static long user_events_ioctl(struct file *file, unsigned int cmd,
 		ret = user_events_ioctl_del(info, uarg);
 		mutex_unlock(&group->reg_mutex);
 		break;
+
+	case DIAG_IOCSUNREG:
+		mutex_lock(&group->reg_mutex);
+		ret = user_events_ioctl_unreg(uarg);
+		mutex_unlock(&group->reg_mutex);
+		break;
 	}
 
 	return ret;
-- 
2.25.1

