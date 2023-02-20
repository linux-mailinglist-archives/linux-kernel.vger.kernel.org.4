Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15C769C4E5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 06:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjBTFSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 00:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjBTFSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 00:18:03 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F72CA0F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 21:17:56 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a7so101654pfx.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 21:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV7KTxwXiC7V4O0O5od5sHIu4cCn1T2P5o+63BvkyPY=;
        b=SULu8Yjhj4OnTHDQ/jMZTifEYPrGyh7QP1+1ZtIdy1P0Qd0FTPckrxo8QVspXqTZkB
         E08g6Mzo1fX8J+d+85GGlakJsQ7Wh/PcNckUg1eumi5GkohgYE0zqsaNn+G8rZ5xXeD9
         I04Pqzm9HI8tTU9LpdyhGOVjIUYfSDpINdmGmf+EDSPz8VcXZt2iXEn/Mmflm9kcbOtK
         UaoOe3daEemSSA051c2xOjtqJiKndsZt0RiDjGr2yXWfw6XuKVs3JQSNF7/PBk559rlw
         w1JVOkD4R24JcNxAL4GkjDIGpmmZkI6bUUqr8iciDH+b1kUb/BZ8Aediz9dZesQALaRq
         UufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aV7KTxwXiC7V4O0O5od5sHIu4cCn1T2P5o+63BvkyPY=;
        b=KJ+5h8CEZsWH+QrUnT81Cwplx/kOCSHys4dEzUx+FzXXjqESaQEa6PysixKQcPk/Eb
         4gQgcpX/jbS3E8pRCkiXmP04FAIzz/wx6zEyNp2Za6oCjk8zzLr4aIDwCnzizixJYWDr
         wHatm9bTBsGdZHAJ5mMlKNzWxJYvxreJ1B8yXrDKhOBd2QpwF53U2rTBsbf7DxA9nUxI
         Uqyf6dhMFYzvTC2VJlndE0zmGVMcab/VCZmL9sJIjNY5j0tsZDZcX/Ebz8hW5xiuBt9F
         kp0tKz3WUI0tLQyRazz+Hrdx5Il+4BMvjwR2ZU/uSMCvH39Xv1d5dnKEGHVNtIGUqRQ1
         onBA==
X-Gm-Message-State: AO0yUKXwUisGbQo+T9OXP+d+g1XLJe/PGDMYqAOHZU17lHupaa08LqhI
        DaC50aAhVYmX4VSyPmhA78Mniw==
X-Google-Smtp-Source: AK7set9hthU5T+nqtaIzuuL3rfTD1TGjsF6cevrzgOicaQ9m+OWBrlEyPgbvuFHFVFcy9v23ow0sHw==
X-Received: by 2002:a62:4e0a:0:b0:5a8:be42:2c5f with SMTP id c10-20020a624e0a000000b005a8be422c5fmr2523469pfb.34.1676870276315;
        Sun, 19 Feb 2023 21:17:56 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b005ae8e94b0d5sm3192087pfn.107.2023.02.19.21.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 21:17:55 -0800 (PST)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2 3/4] tee: expose tee efivar register function
Date:   Mon, 20 Feb 2023 14:17:21 +0900
Message-Id: <20230220051723.1257-4-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230220051723.1257-1-masahisa.kojima@linaro.org>
References: <20230220051723.1257-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the functions to register/unregister
the tee-based EFI variable driver.

Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/tee/tee_core.c  | 23 +++++++++++++++++++++++
 include/linux/tee_drv.h | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 98da206cd761..0dce5b135d2c 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -7,6 +7,7 @@
 
 #include <linux/cdev.h>
 #include <linux/cred.h>
+#include <linux/efi.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/module.h>
@@ -1263,6 +1264,28 @@ static void __exit tee_exit(void)
 	tee_class = NULL;
 }
 
+void tee_register_efivar_ops(struct efivars *tee_efivars,
+			     struct efivar_operations *ops)
+{
+	/*
+	 * If the firmware EFI runtime services support SetVariable(),
+	 * tee-based EFI variable services are not used.
+	 */
+	if (!efivar_supports_writes()) {
+		efivars_generic_ops_unregister();
+		pr_info("Use tee-based EFI runtime variable services\n");
+		efivars_register(tee_efivars, ops);
+	}
+}
+EXPORT_SYMBOL_GPL(tee_register_efivar_ops);
+
+void tee_unregister_efivar_ops(struct efivars *tee_efivars)
+{
+	efivars_unregister(tee_efivars);
+	efivars_generic_ops_register();
+}
+EXPORT_SYMBOL_GPL(tee_unregister_efivar_ops);
+
 subsys_initcall(tee_init);
 module_exit(tee_exit);
 
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 17eb1c5205d3..def4ea6212ee 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -7,6 +7,7 @@
 #define __TEE_DRV_H
 
 #include <linux/device.h>
+#include <linux/efi.h>
 #include <linux/idr.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -507,4 +508,26 @@ struct tee_context *teedev_open(struct tee_device *teedev);
  */
 void teedev_close_context(struct tee_context *ctx);
 
+/**
+ * tee_register_efivar_ops() - register the efivar ops
+ * @tee_efivars:	pointer to efivars structure
+ * @ops:		pointer to contain the efivar operation
+ *
+ * This function registers the tee-based efivar operation as an
+ * EFI Runtime Service.
+ *
+ */
+void tee_register_efivar_ops(struct efivars *tee_efivars,
+			     struct efivar_operations *ops);
+
+/**
+ * tee_unregister_efivar_ops() - unregister the efivar ops
+ * @tee_efivars:	pointer to efivars structure
+ *
+ * This function unregisters the tee-based efivar operation
+ * and reverts to the generic operation.
+ *
+ */
+void tee_unregister_efivar_ops(struct efivars *tee_efivars);
+
 #endif /*__TEE_DRV_H*/
-- 
2.30.2

