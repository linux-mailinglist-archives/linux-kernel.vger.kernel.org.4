Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6AD6C05C1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCSVtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjCSVta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:49:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56D51287D;
        Sun, 19 Mar 2023 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SpoMKXqIXTbAoX8SsquPbYaqmeShuOVFsw+coEwE9Sc=; b=o+tz2jWFMhZJyPTK8dgGqD2cfI
        riYUa2UHNQr0IFbnFP93Rui1gzk9MAB3K+zNkRz9V6qGUdpT5jXhPaMs4OflNi6Az0GkLAIeV/0Af
        xr4/3DThd6AJtnh8yUO7O0O5GLlCveswIUZO5cRSEaD2kZhibkMJmVr67qH7QyCoV98krEpwOnY3b
        N5KSbPG79zdLB6zhs22WA1R3zfN+LQHMCC3qtuUj863AKJs2cD4mpFzK9IMsi41WTpSrr6MYO8IGt
        gOaF/nVbxk/x7MnmJiphaB7IbbReFV6PTiyQs3qxvGDePJELqHeRk6wcw/UV9p7CDVL6ZzjY93knL
        gL9gmLOw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe0u8-007WjY-0i;
        Sun, 19 Mar 2023 21:49:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [RFT 5/5] module: add a sanity check prior to allowing kernel module auto-loading
Date:   Sun, 19 Mar 2023 14:49:26 -0700
Message-Id: <20230319214926.1794108-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230319214926.1794108-1-mcgrof@kernel.org>
References: <20230319214926.1794108-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_module() is what we use for kernel-module autoloading. But
this today is pretty stupid, it just requests for the module without
even checking if its needed. And so we bounce to userspace and hope
for the best.

We can instead do a simple check to see if the module is already
present. This will however contend the module_mutex, but it should
never be heavily contended. However, module auto-loading is a special
use case in the kernel and kernel/kmod already limits the amount of
concurrent requests from the kernel to 50 so we know the kernel can
only contend on the module_mutex for querying if a module exists 50
times at any single point in time.

This work is only valuable if it proves useful for booting up large
systems where a lot of current kernel heuristics use many kernel
module auto-loading features and they could benefit from this. There
are no metrics yet to show, but at least this doesn't penalize much
existing systems.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/module/internal.h |  1 +
 kernel/module/kmod.c     |  7 +++++++
 kernel/module/main.c     | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 6ae29bb8836f..cb00555780bd 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -86,6 +86,7 @@ struct find_symbol_arg {
 	enum mod_license license;
 };
 
+bool module_autoload_proceed(const char *name);
 int mod_verify_sig(const void *mod, struct load_info *info);
 int try_to_force_load(struct module *mod, const char *reason);
 bool find_symbol(struct find_symbol_arg *fsa);
diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
index b717134ebe17..67efc6de902f 100644
--- a/kernel/module/kmod.c
+++ b/kernel/module/kmod.c
@@ -28,6 +28,8 @@
 
 #include <trace/events/module.h>
 
+#include "internal.h"
+
 /*
  * Assuming:
  *
@@ -167,8 +169,13 @@ int __request_module(bool wait, const char *fmt, ...)
 
 	trace_module_request(module_name, wait, _RET_IP_);
 
+	if (!module_autoload_proceed(module_name)) {
+		ret = 0;
+		goto out;
+	}
 	ret = call_modprobe(module_name, wait ? UMH_WAIT_PROC : UMH_WAIT_EXEC);
 
+out:
 	atomic_inc(&kmod_concurrent_max);
 	wake_up(&kmod_wq);
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 32955b7819b3..2a84d747865a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2665,6 +2665,24 @@ static int module_patient_check_exists(const char *name)
 		return -EBUSY;
 }
 
+/*
+ * We allow contention of the module_mutex here because kernel module
+ * auto-loading a special feature *and* because we are only allowing
+ * MAX_KMOD_CONCURRENT possible checks at a time for a module.
+ */
+bool module_autoload_proceed(const char *name)
+{
+	int err;
+
+	mutex_lock(&module_mutex);
+	err = module_patient_check_exists(name);
+	mutex_unlock(&module_mutex);
+
+	if (err == -EEXIST)
+		return false;
+	return true;
+}
+
 /*
  * We try to place it in the list now to make sure it's unique before
  * we dedicate too many resources.  In particular, temporary percpu
-- 
2.39.1

