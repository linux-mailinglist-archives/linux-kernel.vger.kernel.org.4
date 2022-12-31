Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2D065A2C2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 06:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiLaFUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 00:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiLaFUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 00:20:01 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30775140B6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 21:20:00 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n4so23824782plp.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 21:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aZJQjCfX4+prwQo4OFfcSE3byIBK/JnH4yyvcjyPNLU=;
        b=HMb71ZYgOKteEc/FlAVyhvgMPeYEWos1QHLEjPEFFhlMwJXMSBTrwmIwzczcaDKoNZ
         XWzx5ikTnh4ln38bjFWqQcaZcH9ijWfh57WDbNBgaop6di1+jbG/bEjGVzQ1/6ftQri6
         0nXCJ8HTH+RjQCzO5UeIM0/G9rRCj0f+hj9DfDmgv+fIA4vNod7tY4Er72nqGC4o4Sp8
         U2N0pXNGsM/KDW8uLco/1ylKQX7YdaX1MnaPCD66+FxUuDcvoBmujfE+LtULTj6XrxXN
         NHt/S+JrCVSZeX7+lSRhYIv45UXqAI3/xlXSnlirdNAokOzAHkMTv/epfah4mJzu8/Bw
         9hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZJQjCfX4+prwQo4OFfcSE3byIBK/JnH4yyvcjyPNLU=;
        b=L/piy8dB3oNt4Zo2AfIXIEmo65FYHBhAYdY4v7GuOfvCXnKZua9dcKpgrWJQj1qUiS
         pI4teZJ0Esrtzr+fYdt+c9jr/3/CrQse7Vmb671WdVICfn7S/VXKKzwlXL2Z3cH/8ucO
         mTSrAy7TBdUfEigYMmvbyi172I0rRvoJ5WkOQSOL3ENckYqFUZOAEoy7xJbkZwCGGTaw
         /N+5Ef9FD814MQJ6LM9oh+ZKW9wmoHnx6oUsxzrDfsHpZAgm6tloCceR9Yz6Oz/Mt+G0
         TcaWEzVCR+FLkmyTEerughSBE7jUypMFAn+o4m8hHgQulJgh9LyHJxbFTSuXzGgKLGIb
         1RaA==
X-Gm-Message-State: AFqh2kqLOCgpxRrjYo2ZOtC7nk74smtPkFOoZSKKnA9MOwn3yjIslLs/
        09J8TIcINgmSAwAfuXW7q+YAHa0XjP4AMg==
X-Google-Smtp-Source: AMrXdXtgt2OOUmoafU5fhU4CEP3qm0CJnEDfr5aXHfUbRGMJfGmZw9Sfwzs8A86qu6NrMwk1s+pNWA==
X-Received: by 2002:a17:902:dad0:b0:191:3ec0:9166 with SMTP id q16-20020a170902dad000b001913ec09166mr56404941plx.6.1672463999649;
        Fri, 30 Dec 2022 21:19:59 -0800 (PST)
Received: from localhost.localdomain (kayle.snu.ac.kr. [147.46.126.79])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090332d200b00174c1855cd9sm15904431plr.267.2022.12.30.21.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 21:19:59 -0800 (PST)
From:   Yoochan Lee <yoochan1026@gmail.com>
To:     jens.wiklander@linaro.org
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Yoochan Lee <yoochan1026@gmail.com>
Subject: [PATCH] tee: optee: smc_abi: Fix use-after-free in optee_smc_open
Date:   Sat, 31 Dec 2022 14:19:54 +0900
Message-Id: <20221231051954.2038772-1-yoochan1026@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A race condition may occur if the user physically removes the
smc_abi device while calling open().

This is a race condition between optee_smc_open() function and
the optee_smc_remove() function, which may lead to Use-After-Free.

Therefore, add a refcount check to optee_smc_remove() function
to free the "optee" structure after the device is close()d.

---------------CPU 0--------------------CPU 1-----------------
         optee_smc_open()     |     optee_smc_remove()
--------------------------------------------------------------
struct optee *optee = tee_get_|
drvdata(ctx->teedev); — (1)   |
                              | struct optee *optee = platform_
                              | get_drvdata(pdev);
                              | ...
                              | kfree(optee); — (2)
u32 sec_caps = optee->smc.sec_|
caps; — (3)

Signed-off-by: Yoochan Lee <yoochan1026@gmail.com>
---
 drivers/tee/optee/optee_private.h |  1 +
 drivers/tee/optee/smc_abi.c       | 66 ++++++++++++++++++++++---------
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 04ae58892608..f52b1cf20eab 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -175,6 +175,7 @@ struct optee {
 	bool   scan_bus_done;
 	struct workqueue_struct *scan_bus_wq;
 	struct work_struct scan_bus_work;
+	struct kref refcnt;
 };
 
 struct optee_session {
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..4fbec2acc255 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1077,18 +1077,61 @@ static void optee_get_version(struct tee_device *teedev,
 	*vers = v;
 }
 
+static void optee_smc_delete(struct kref *kref)
+{
+	struct optee *optee = container_of(kref, struct optee, refcnt);
+
+	/*
+	 * Ask OP-TEE to free all cached shared memory objects to decrease
+	 * reference counters and also avoid wild pointers in secure world
+	 * into the old shared memory range.
+	 */
+	if (!optee->rpc_param_count)
+		optee_disable_shm_cache(optee);
+
+	optee_smc_notif_uninit_irq(optee);
+
+	optee_remove_common(optee);
+
+	if (optee->smc.memremaped_shm)
+		memunmap(optee->smc.memremaped_shm);
+
+	kfree(optee);
+}
+
+static void optee_smc_release_supp(struct tee_context *ctx)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+
+	optee_release_helper(ctx, optee_close_session_helper);
+	if (optee->scan_bus_wq) {
+		destroy_workqueue(optee->scan_bus_wq);
+		optee->scan_bus_wq = NULL;
+	}
+	optee_supp_release(&optee->supp);
+	kref_put(&optee->refcnt, optee_smc_delete);
+}
+
+static void optee_smc_release(struct tee_context *ctx)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+
+	optee_release_helper(ctx, optee_close_session_helper);
+	kref_put(&optee->refcnt, optee_smc_delete);
+}
+
 static int optee_smc_open(struct tee_context *ctx)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	u32 sec_caps = optee->smc.sec_caps;
-
+	kref_get(&optee->refcnt);
 	return optee_open(ctx, sec_caps & OPTEE_SMC_SEC_CAP_MEMREF_NULL);
 }
 
 static const struct tee_driver_ops optee_clnt_ops = {
 	.get_version = optee_get_version,
 	.open = optee_smc_open,
-	.release = optee_release,
+	.release = optee_smc_release,
 	.open_session = optee_open_session,
 	.close_session = optee_close_session,
 	.invoke_func = optee_invoke_func,
@@ -1106,7 +1149,7 @@ static const struct tee_desc optee_clnt_desc = {
 static const struct tee_driver_ops optee_supp_ops = {
 	.get_version = optee_get_version,
 	.open = optee_smc_open,
-	.release = optee_release_supp,
+	.release = optee_smc_release_supp,
 	.supp_recv = optee_supp_recv,
 	.supp_send = optee_supp_send,
 	.shm_register = optee_shm_register_supp,
@@ -1319,22 +1362,7 @@ static int optee_smc_remove(struct platform_device *pdev)
 {
 	struct optee *optee = platform_get_drvdata(pdev);
 
-	/*
-	 * Ask OP-TEE to free all cached shared memory objects to decrease
-	 * reference counters and also avoid wild pointers in secure world
-	 * into the old shared memory range.
-	 */
-	if (!optee->rpc_param_count)
-		optee_disable_shm_cache(optee);
-
-	optee_smc_notif_uninit_irq(optee);
-
-	optee_remove_common(optee);
-
-	if (optee->smc.memremaped_shm)
-		memunmap(optee->smc.memremaped_shm);
-
-	kfree(optee);
+	kref_put(&optee->refcnt, optee_smc_delete);
 
 	return 0;
 }
-- 
2.39.0

