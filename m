Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B92E5B90AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiINW5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiINW5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:57:00 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E969083059;
        Wed, 14 Sep 2022 15:56:58 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id l10so16568348plb.10;
        Wed, 14 Sep 2022 15:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hIeIUTsBV4QxjBZVDpe2dp3qI8fehLgRx48IHpHPzW8=;
        b=wdIrNcyTufCnLE2MrarhWcgNI47ziV7uNfT9DSr4fNIANC8H59e3bIu4qvfIjcaOmS
         9w27RE8tuYJEGH6jqrrbqSN7++hKQJQ7+muFaEPzS3pJ0Ap1kqihckqKZ/OlB9IgaH7J
         wNudswNnMFHg+EjA0AkgCbGsf231t+qvtoxX5lVEECfK9wkqPYplQpga6lr87jL1/wus
         cSSOINTUHvtavMGymA440x9VbPvgxUuKVymo+AfRiT6/6+JPsXnEvxPYcOQxxrV6Bghn
         YZYzLq3Wp3+FRTcyr9XpORH79uc+mxG9UVWE3sqRh0PkTYWRPaBTu3ej+zDidPw7lg5x
         Uo8Q==
X-Gm-Message-State: ACrzQf0ammYT0b7vP2LZwSdp16c61gRQQqUJ9UILsgELsigOJLjqwh6o
        Zknmx938O9syRXCWVxtjCao=
X-Google-Smtp-Source: AMsMyM7xbb0K/O3zh7pzBk0SS0ANyvZ/W2+59zP+9cC7ZtIfUPFv4j7NqiRjg9PlRZ0Cr9vyvQoM7g==
X-Received: by 2002:a17:90b:b06:b0:200:aff0:2e68 with SMTP id bf6-20020a17090b0b0600b00200aff02e68mr7411578pjb.159.1663196218342;
        Wed, 14 Sep 2022 15:56:58 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9147:e0c1:9227:cf53])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902d70900b0016d1b70872asm2606926ply.134.2022.09.14.15.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 15:56:57 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Mike Christie <michael.christie@oracle.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 6/7] module: Improve support for asynchronous module exit code
Date:   Wed, 14 Sep 2022 15:56:20 -0700
Message-Id: <20220914225621.415631-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220914225621.415631-1-bvanassche@acm.org>
References: <20220914225621.415631-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some kernel modules call device_del() from their module exit code and
schedule asynchronous work from inside the .release callback without waiting
until that callback has finished. As an example, many SCSI LLD drivers call
scsi_remove_host() from their module exit code. scsi_remove_host() may
invoke scsi_device_dev_release_usercontext() asynchronously.
scsi_device_dev_release_usercontext() uses the host template pointer and
that pointer usually exists in static storage in the SCSI LLD. Support
using the module reference count to keep the module around until
asynchronous module exiting has completed by waiting in the delete_module()
system call until the module reference count drops to zero.

The following debug patch has been used to make the new wait_event()
call wait:

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 8be8e08fb67d..fead694ff95a 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/bsg.h>
+#include <linux/delay.h>

 #include <scsi/scsi.h>
 #include <scsi/scsi_device.h>
@@ -518,6 +519,7 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)

 	if (parent)
 		put_device(parent);
+	msleep(100);
 	module_put(mod);
 }

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a271126d7d59..0bf75ec3f5a8 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -756,8 +756,10 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	 * unloading is not forced, wait for the module reference count to drop
 	 * to zero again.
 	 */
-	if (!forced)
+	if (!forced) {
+		WARN_ON_ONCE(atomic_read(&mod->refcnt));
 		wait_event(mod->refcnt_wq, atomic_read(&mod->refcnt) == 0);
+	}
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_GOING, mod);
 	klp_module_going(mod);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index aeea9731ef80..f021625f2caa 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3355,7 +3355,7 @@ int schedule_on_each_cpu(work_func_t func)
  */
 int execute_in_process_context(work_func_t fn, struct execute_work *ew)
 {
-	if (!in_interrupt()) {
+	if (false && !in_interrupt()) {
 		fn(&ew->work);
 		return 0;
 	}

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: John Garry <john.garry@huawei.com>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/module.h |  1 +
 kernel/module/main.c   | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 518296ea7f73..3a77d2bd4198 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -533,6 +533,7 @@ struct module {
 	/* Destruction function. */
 	void (*exit)(void);
 
+	wait_queue_head_t refcnt_wq;
 	atomic_t refcnt;
 #endif
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index a4e4d84b6f4e..a271126d7d59 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -550,6 +550,7 @@ static int module_unload_init(struct module *mod)
 
 	/* Hold reference count during initialization. */
 	atomic_inc(&mod->refcnt);
+	init_waitqueue_head(&mod->refcnt_wq);
 
 	return 0;
 }
@@ -750,6 +751,13 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	/* Final destruction now no one is using it. */
 	if (mod->exit != NULL)
 		mod->exit();
+	/*
+	 * If the module reference count was increased by mod->exit() and if
+	 * unloading is not forced, wait for the module reference count to drop
+	 * to zero again.
+	 */
+	if (!forced)
+		wait_event(mod->refcnt_wq, atomic_read(&mod->refcnt) == 0);
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_GOING, mod);
 	klp_module_going(mod);
@@ -854,6 +862,8 @@ void module_put(struct module *module)
 		WARN_ON(ret < 0);	/* Failed to put refcount */
 		trace_module_put(module, _RET_IP_);
 		preempt_enable();
+		if (ret == 0)
+			wake_up(&module->refcnt_wq);
 	}
 }
 EXPORT_SYMBOL(module_put);
