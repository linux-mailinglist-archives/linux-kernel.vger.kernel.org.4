Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E95B65A2C7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 06:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiLaFea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 00:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLaFe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 00:34:27 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DD5140EF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 21:34:26 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso13681656pjc.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 21:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rGGeCk21G/Bf+W1olwgjeL85Rvj7z5on3ld44bdFjs0=;
        b=Fu7JoIItTlulDeChYQ3n5q3Txe1MG7f+4Xx5+KCf5v6unhhCahjZREJWy5Sl1luZRl
         Vb968Me+NhMSaqAJNEG/fXVLiFe3Z2D3D/p195mh0gbKMuydjPMlww/d1Cxl6FQo9kHV
         cWoSP5ErC+CLhV8KveK9wZQl/DqD/KHj6M1RVMuvAn71BedcIyANYjHt9l6BaAdA0oif
         uPhfNnuARgdShqaNcvRKPVLzoBa4b7bawzf+q6CRBDJrWRHpupP7qpMKd7FfpyrQJ38c
         wvxqc47FOpmd7185pA0r0WAmYoP/M5Zroutx/OkRmsz5jliFjH01weWHwCgQ0CRYCqqK
         BGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGGeCk21G/Bf+W1olwgjeL85Rvj7z5on3ld44bdFjs0=;
        b=GlL3IA7SipMMwt4QeDvQZR4LRJZBZmfAVsAG/qDBexOGBeiOhWiY8QfxbKllfob8cI
         4JHEnfB2iHFX8qhXFHP1HoXReqbbAehyr4pwgZCA9oKIwXBuTKqDWP46xin1/1r29Qcn
         zYZfIQlwaZLd9n3UjXAl8k2czsaa0wDEBlGzxZJvJGpFKKgdrh7DQSCJyIq6Ex9wEw/f
         owtZ36XcZl14hhfjARVhvf7s/q9wSgVbfXjQ1nCDAHVCMP46zdQuTdtaKQonwCpK8cnB
         HJtcvd5DKCgwGV9WG2SQUSkZRxmVdXDdX8zKIHsShSQZawptUy4n+VEMS9QFqvYoEDuN
         78Kg==
X-Gm-Message-State: AFqh2koADprjXW33BtuLOb2fKVHm2B9frOmD1VYlvaHt8G9+ltAUCCwZ
        zpuma60OcX0UsB2zGHRNZzQ=
X-Google-Smtp-Source: AMrXdXuxDPWvftZnOlqopDcIyMcscLxRO7Dll7thhEDO6G/vghRqpmN9gV6AFpYNl/paOgtjtYtnNg==
X-Received: by 2002:a17:902:ebc3:b0:189:361f:89ac with SMTP id p3-20020a170902ebc300b00189361f89acmr43510938plg.64.1672464865541;
        Fri, 30 Dec 2022 21:34:25 -0800 (PST)
Received: from localhost.localdomain (kayle.snu.ac.kr. [147.46.126.79])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b00178b9c997e5sm15930693plf.138.2022.12.30.21.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 21:34:25 -0800 (PST)
From:   Yoochan Lee <yoochan1026@gmail.com>
To:     jens.wiklander@linaro.org
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Yoochan Lee <yoochan1026@gmail.com>
Subject: [PATCH] tee: optee: ffa_abi: Fix use-after-free in optee_ffa_open
Date:   Sat, 31 Dec 2022 14:34:21 +0900
Message-Id: <20221231053421.2039591-1-yoochan1026@gmail.com>
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
ffa_abi device while calling open().

This is a race condition between optee_open() function and
the optee_ffa_remove() function, which may lead to Use-After-Free.

Therefore, add a refcount check to optee_ffa_remove() function
to free the "optee" structure after the device is close()d.

---------------CPU 0--------------------CPU 1-----------------
            optee_open()      |     optee_ffa_remove()
--------------------------------------------------------------
struct optee *optee = tee_get_|
drvdata(teedev); — (1)        |
                              | struct optee *optee = ffa_dev_
                              | get_drvdata(ffa_dev);
                              | ...
                              | kfree(optee); — (2)
if (teedev == optee->supp_    |
teedev) { — (3)               |

Signed-off-by: Yoochan Lee <yoochan1026@gmail.com>
---
 drivers/tee/optee/ffa_abi.c       | 49 +++++++++++++++++++++++++------
 drivers/tee/optee/optee_private.h |  1 +
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 0828240f27e6..ea76d7532419 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -726,15 +726,52 @@ static void optee_ffa_get_version(struct tee_device *teedev,
 	*vers = v;
 }
 
+static void optee_ffa_delete(struct kref *kref)
+{
+	struct optee *optee = container_of(kref, struct optee, refcnt);
+
+	optee_remove_common(optee);
+
+	mutex_destroy(&optee->ffa.mutex);
+	rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
+
+	kfree(optee);
+
+}
+
+static void optee_ffa_release(struct tee_context *ctx)
+{
+	struct optee *optee = tee_get_drvdata(teedev);
+
+	optee_release_helper(ctx, optee_close_session_helper);
+	kref_put(&optee->refcnt, optee_ffa_delete);
+}
+
+void optee_ffa_release_supp(struct tee_context *ctx)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+
+	optee_release_helper(ctx, optee_close_session_helper);
+	if (optee->scan_bus_wq) {
+		destroy_workqueue(optee->scan_bus_wq);
+		optee->scan_bus_wq = NULL;
+	}
+	optee_supp_release(&optee->supp);
+	kref_put(&optee->refcnt, optee_ffa_delete);
+}
+
 static int optee_ffa_open(struct tee_context *ctx)
 {
+	struct optee *optee = tee_get_drvdata(teedev);
+	kref_get(&optee->refcnt);
+
 	return optee_open(ctx, true);
 }
 
 static const struct tee_driver_ops optee_ffa_clnt_ops = {
 	.get_version = optee_ffa_get_version,
 	.open = optee_ffa_open,
-	.release = optee_release,
+	.release = optee_ffa_release,
 	.open_session = optee_open_session,
 	.close_session = optee_close_session,
 	.invoke_func = optee_invoke_func,
@@ -752,7 +789,7 @@ static const struct tee_desc optee_ffa_clnt_desc = {
 static const struct tee_driver_ops optee_ffa_supp_ops = {
 	.get_version = optee_ffa_get_version,
 	.open = optee_ffa_open,
-	.release = optee_release_supp,
+	.release = optee_ffa_release_supp,
 	.supp_recv = optee_supp_recv,
 	.supp_send = optee_supp_send,
 	.shm_register = optee_ffa_shm_register, /* same as for clnt ops */
@@ -775,13 +812,7 @@ static const struct optee_ops optee_ffa_ops = {
 static void optee_ffa_remove(struct ffa_device *ffa_dev)
 {
 	struct optee *optee = ffa_dev_get_drvdata(ffa_dev);
-
-	optee_remove_common(optee);
-
-	mutex_destroy(&optee->ffa.mutex);
-	rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
-
-	kfree(optee);
+	kref_put(&optee->refcnt, optee_ffa_delete);
 }
 
 static int optee_ffa_probe(struct ffa_device *ffa_dev)
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
-- 
2.39.0

