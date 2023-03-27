Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402A56CA303
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjC0MCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjC0MB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:01:59 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4503584
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:01:58 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id iw3so8187036plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679918518;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fyu92y31fG4h3Y2V5QlrZ4kMvf+lpdC10uzc12nnA2Y=;
        b=cwNMmsHHs5zhgyT6nGBkF5d+POW+U82jUKuPjQo+Fo2b1Vv/Tcgb3yQqFt9A6rWj2q
         9I2TPhp5/HJJWn/nCUGTaFDvJatn7PHpIJ+SJcp1fhxw42jRciG0HUZVewoCsCsIgEbP
         UCaDybrhB4Gmn0u7yUoHD/wFCmPgS57ZWew/mEdDVb75cvxE3eX5EtbqhX7d7gNZDmLB
         l4k4cwCTbwuBV3nhttK7qutLDutGzeWvuE9Go4Fj9RGAFLBr8tjryTe7DH0H10/N0Czs
         w9uqu0BY0GUckDqKfNPILXSlAdT6NEi3+6OmEulfNlkWCMAatpMnoxUEy807EdINpM+X
         PlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679918518;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyu92y31fG4h3Y2V5QlrZ4kMvf+lpdC10uzc12nnA2Y=;
        b=RH6cXQODPL0Wbopvd2lKaFOegU1YWp+vqz8az83yknJSLXbepZC3aV45j8Q2loFG+3
         ttDR7vIHKqkXC6xQIMAJvODU4zY59YJfH0VxIKvHiwfRzw7mQ5bV26Y99H9s7aIvPud+
         QsFmwdgVQraI15xkjn+lCKxInrm8yydoE797MQSDRqdveQasRNZLWQTAIDSTteuL/+Tp
         M7tzUc4saN4Sb7KQ5e8JzeQLqisLzoVEI46jn5OQICExoCdQV3iDB7xwCyUjqam0bVIy
         me2kZbPksGJvMvIiN1nlRO0nnLDpUORi3odFBBVIJvvtPWCz1McYfE5t/anOBSxqtABp
         VaEw==
X-Gm-Message-State: AAQBX9ek34s23xBFtvDvKxtiptL6bXI221ANP7ZD9bFZ080lroKf1bVm
        K6guT4ljJbpts7/7BNfvFb8=
X-Google-Smtp-Source: AKy350YERz6Zk6bKuVoAGsFMe61LyJNIvGIVSXnpKFsQQg8WbD5VmifmwSgMR7BIft6BvBdUnSuzVQ==
X-Received: by 2002:a17:902:c44a:b0:19e:6c02:801c with SMTP id m10-20020a170902c44a00b0019e6c02801cmr8725274plm.14.1679918518040;
        Mon, 27 Mar 2023 05:01:58 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902c1cd00b0019aa8149cc9sm19048815plc.35.2023.03.27.05.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:01:57 -0700 (PDT)
Date:   Mon, 27 Mar 2023 21:01:53 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vmci_host: fix a race condition in vmci_host_poll() causing
 GPF
Message-ID: <ZCGFsdBAU4cYww5l@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During fuzzing, a general protection fault is observed in
vmci_host_poll().

general protection fault, probably for non-canonical address 0xdffffc0000000019: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]
RIP: 0010:__lock_acquire+0xf3/0x5e00 kernel/locking/lockdep.c:4926
<- omitting registers ->
Call Trace:
 <TASK>
 lock_acquire+0x1a4/0x4a0 kernel/locking/lockdep.c:5672
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:162
 add_wait_queue+0x3d/0x260 kernel/sched/wait.c:22
 poll_wait include/linux/poll.h:49 [inline]
 vmci_host_poll+0xf8/0x2b0 drivers/misc/vmw_vmci/vmci_host.c:174
 vfs_poll include/linux/poll.h:88 [inline]
 do_pollfd fs/select.c:873 [inline]
 do_poll fs/select.c:921 [inline]
 do_sys_poll+0xc7c/0x1aa0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll+0x2cc/0x330 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Example thread interleaving that causes the general protection fault
is as follows:

CPU1 (vmci_host_poll)               CPU2 (vmci_host_do_init_context)
-----                               -----
// Read uninitialized context
context = vmci_host_dev->context;
                                    // Initialize context
                                    vmci_host_dev->context = vmci_ctx_create();
                                    vmci_host_dev->ct_type = VMCIOBJ_CONTEXT;

if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
    // Dereferencing the wrong pointer
    poll_wait(..., &context->host_context);
}

In this scenario, vmci_host_poll() reads vmci_host_dev->context first,
and then reads vmci_host_dev->ct_type to check that
vmci_host_dev->context is initialized. However, since these two reads
are not atomically executed, there is a chance of a race condition as
described above.

To fix this race condition, read vmci_host_dev->context after checking
the value of vmci_host_dev->ct_type so that vmci_host_poll() always
reads an initialized context.

Reported-by: Dae R. Jeong <threeearcat@gmail.com>
Fixes: 8bf503991f87 ("VMCI: host side driver implementation.")
Signed-off-by: Dae R. Jeong <threeearcat@gmail.com>
---
 drivers/misc/vmw_vmci/vmci_host.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index 857b9851402a..abe79f6fd2a7 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -165,10 +165,16 @@ static int vmci_host_close(struct inode *inode, struct file *filp)
 static __poll_t vmci_host_poll(struct file *filp, poll_table *wait)
 {
 	struct vmci_host_dev *vmci_host_dev = filp->private_data;
-	struct vmci_ctx *context = vmci_host_dev->context;
+	struct vmci_ctx *context;
 	__poll_t mask = 0;
 
 	if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
+		/*
+		 * Read context only if ct_type == VMCIOBJ_CONTEXT to make
+		 * sure that context is initialized
+		 */
+		context = vmci_host_dev->context;
+
 		/* Check for VMCI calls to this VM context. */
 		if (wait)
 			poll_wait(filp, &context->host_context.wait_queue,
-- 
2.17.1

