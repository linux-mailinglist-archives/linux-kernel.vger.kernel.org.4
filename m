Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883D87043A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjEPCxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjEPCxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:53:50 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECDB4C17;
        Mon, 15 May 2023 19:53:48 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-334f64c91aeso24588595ab.2;
        Mon, 15 May 2023 19:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684205628; x=1686797628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPK335sb4Cf31lJbZCxsHRj3PEm/5gZa6oNqr83Lzyw=;
        b=JogALCqy2cPwzHHhxfINXnYvM4vYAoJddwJgLf7BB5tI/43dNo45SpNpjzuoOne7rA
         5P9WaVe3v9bEj/hdij4ez3dLu4Ro40GcKi/tOuvs4I87vp/eVD+MFYijwH7vFM4S+aw4
         WQGgTE/W+Uj+1+gXjw1jbbcuzQx5htG0WeVuCxBebWfdVEj+L/KWsT7BPvNXniAf9aYK
         E7FuKddBuyGgfniD2Towkix3Wqds9yjeIx+d0lQhQTpfDK8Ek45h/BzN+hUILZwoeNHs
         dGVsmtPMfsBS5ef32//ggs74w/HQC+qGXxinu7a/NWnE7PUkD6CVxmXvHILVLGFYFwo3
         6+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684205628; x=1686797628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPK335sb4Cf31lJbZCxsHRj3PEm/5gZa6oNqr83Lzyw=;
        b=jE8gEf0nAR14FyEXCVzRrQRyBL5MiCP/yDt9Xk0dFVkzO8HNKM+7aRav6qHPLhLnGT
         /BR0cYd0FSq/kNOMndGT8tmvfBsimaX4kDEgvO2ZohXy8Ls94eC3nCvHgHQELlive+TE
         gOO5KJ7eY94csRV7GcgrxiRxcBc2S1Ss+KYuvh4yXqcxR9Pxx2f00IH/UWxiAPBevmen
         KYo+mCrU22XFntQBUHs1jgfyXMa3DDPXvB2rdcYqU4GeRtGdGLi6/bw9BhqwJm3NKuMO
         GADTy8Fppq4ApTGfxYrH1P7nIt+utEU2ahF7PB6FE3mu1vvxQVeacw56oycAtdxcoeoE
         oCNA==
X-Gm-Message-State: AC+VfDxhvGGHJ+J4+BKbJjSMT2AWAROS7wmQnc1aQ+tCumuqeG6jxQdD
        KjQTsA90nqd0cMNXfszE/fo=
X-Google-Smtp-Source: ACHHUZ4ct61Y0xN8dW0ABXsS/m04wf32vXiZfpsDBTi3wLsxXM5N+wUkrOluqNG14nrVsixQMV1Jlw==
X-Received: by 2002:a92:d8cb:0:b0:331:2e7b:9efa with SMTP id l11-20020a92d8cb000000b003312e7b9efamr22051000ilo.19.1684205627983;
        Mon, 15 May 2023 19:53:47 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id u1-20020a02aa81000000b00418849c2ea7sm2784139jai.122.2023.05.15.19.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 19:53:47 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] scsi: target: Replace all non-returning strlcpy with strscpy
Date:   Tue, 16 May 2023 02:53:22 +0000
Message-ID: <20230516025322.2804923-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/target/iscsi/iscsi_target_parameters.c |    4 ++--
 drivers/target/iscsi/iscsi_target_util.c       |    4 ++--
 drivers/target/target_core_configfs.c          |   10 +++++-----
 drivers/target/target_core_device.c            |    6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_parameters.c b/drivers/target/iscsi/iscsi_target_parameters.c
index 557516c642c3..5b90c22ee3dc 100644
--- a/drivers/target/iscsi/iscsi_target_parameters.c
+++ b/drivers/target/iscsi/iscsi_target_parameters.c
@@ -726,8 +726,8 @@ static int iscsi_add_notunderstood_response(
 	}
 	INIT_LIST_HEAD(&extra_response->er_list);
 
-	strlcpy(extra_response->key, key, sizeof(extra_response->key));
-	strlcpy(extra_response->value, NOTUNDERSTOOD,
+	strscpy(extra_response->key, key, sizeof(extra_response->key));
+	strscpy(extra_response->value, NOTUNDERSTOOD,
 		sizeof(extra_response->value));
 
 	list_add_tail(&extra_response->er_list,
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 26dc8ed3045b..dc1ac5a0f806 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -1321,7 +1321,7 @@ void iscsit_collect_login_stats(
 		if (conn->param_list)
 			intrname = iscsi_find_param_from_key(INITIATORNAME,
 							     conn->param_list);
-		strlcpy(ls->last_intr_fail_name,
+		strscpy(ls->last_intr_fail_name,
 		       (intrname ? intrname->value : "Unknown"),
 		       sizeof(ls->last_intr_fail_name));
 
@@ -1360,7 +1360,7 @@ void iscsit_fill_cxn_timeout_err_stats(struct iscsit_session *sess)
 		return;
 
 	spin_lock_bh(&tiqn->sess_err_stats.lock);
-	strlcpy(tiqn->sess_err_stats.last_sess_fail_rem_name,
+	strscpy(tiqn->sess_err_stats.last_sess_fail_rem_name,
 			sess->sess_ops->InitiatorName,
 			sizeof(tiqn->sess_err_stats.last_sess_fail_rem_name));
 	tiqn->sess_err_stats.last_sess_failure_type =
diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 74b67c346dfe..936e5ff1b209 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -649,7 +649,7 @@ static void dev_set_t10_wwn_model_alias(struct se_device *dev)
 	 * here without potentially breaking existing setups, so continue to
 	 * truncate one byte shorter than what can be carried in INQUIRY.
 	 */
-	strlcpy(dev->t10_wwn.model, configname, INQUIRY_MODEL_LEN);
+	strscpy(dev->t10_wwn.model, configname, INQUIRY_MODEL_LEN);
 }
 
 static ssize_t emulate_model_alias_store(struct config_item *item,
@@ -675,7 +675,7 @@ static ssize_t emulate_model_alias_store(struct config_item *item,
 	if (flag) {
 		dev_set_t10_wwn_model_alias(dev);
 	} else {
-		strlcpy(dev->t10_wwn.model, dev->transport->inquiry_prod,
+		strscpy(dev->t10_wwn.model, dev->transport->inquiry_prod,
 			sizeof(dev->t10_wwn.model));
 	}
 	da->emulate_model_alias = flag;
@@ -1426,7 +1426,7 @@ static ssize_t target_wwn_vendor_id_store(struct config_item *item,
 	}
 
 	BUILD_BUG_ON(sizeof(dev->t10_wwn.vendor) != INQUIRY_VENDOR_LEN + 1);
-	strlcpy(dev->t10_wwn.vendor, stripped, sizeof(dev->t10_wwn.vendor));
+	strscpy(dev->t10_wwn.vendor, stripped, sizeof(dev->t10_wwn.vendor));
 
 	pr_debug("Target_Core_ConfigFS: Set emulated T10 Vendor Identification:"
 		 " %s\n", dev->t10_wwn.vendor);
@@ -1482,7 +1482,7 @@ static ssize_t target_wwn_product_id_store(struct config_item *item,
 	}
 
 	BUILD_BUG_ON(sizeof(dev->t10_wwn.model) != INQUIRY_MODEL_LEN + 1);
-	strlcpy(dev->t10_wwn.model, stripped, sizeof(dev->t10_wwn.model));
+	strscpy(dev->t10_wwn.model, stripped, sizeof(dev->t10_wwn.model));
 
 	pr_debug("Target_Core_ConfigFS: Set emulated T10 Model Identification: %s\n",
 		 dev->t10_wwn.model);
@@ -1538,7 +1538,7 @@ static ssize_t target_wwn_revision_store(struct config_item *item,
 	}
 
 	BUILD_BUG_ON(sizeof(dev->t10_wwn.revision) != INQUIRY_REVISION_LEN + 1);
-	strlcpy(dev->t10_wwn.revision, stripped, sizeof(dev->t10_wwn.revision));
+	strscpy(dev->t10_wwn.revision, stripped, sizeof(dev->t10_wwn.revision));
 
 	pr_debug("Target_Core_ConfigFS: Set emulated T10 Revision: %s\n",
 		 dev->t10_wwn.revision);
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 90f3f4926172..b7ac60f4a219 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -789,10 +789,10 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
 	xcopy_lun->lun_tpg = &xcopy_pt_tpg;
 
 	/* Preload the default INQUIRY const values */
-	strlcpy(dev->t10_wwn.vendor, "LIO-ORG", sizeof(dev->t10_wwn.vendor));
-	strlcpy(dev->t10_wwn.model, dev->transport->inquiry_prod,
+	strscpy(dev->t10_wwn.vendor, "LIO-ORG", sizeof(dev->t10_wwn.vendor));
+	strscpy(dev->t10_wwn.model, dev->transport->inquiry_prod,
 		sizeof(dev->t10_wwn.model));
-	strlcpy(dev->t10_wwn.revision, dev->transport->inquiry_rev,
+	strscpy(dev->t10_wwn.revision, dev->transport->inquiry_rev,
 		sizeof(dev->t10_wwn.revision));
 
 	return dev;

