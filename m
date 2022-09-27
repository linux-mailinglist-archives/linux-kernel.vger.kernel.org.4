Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6B65EC17F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiI0Leu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiI0Leq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:34:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BE64C629;
        Tue, 27 Sep 2022 04:34:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id i6so5238797pfb.2;
        Tue, 27 Sep 2022 04:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=hKVtQAwnVa1yA0DBDx9GBM794IiTF2YgOfvvntIUx3w=;
        b=Vd4Z2d1dCQxHn7Pk8xckvV36IVZ2fCTCrRg02KCj4v7ZZSDVJ1PAxV61zoxTupP6xY
         BpVQYhxYlL5F0Ky/5VASsyZT/oZl/VWFgC51p25NyQWsmFDYLpgbUJboYwyO9uRgP9KQ
         sR//aFkhhXGDLPtoX4Fz8SYnNgKG4UVbjOrk8ghY0/fkT5X93XW2uEZAOs81XEXOerUv
         cvpUTHuPG71idEtLLc+7A9WhmyosPCSi0tu/ilC+h4S5FJyitr5ijK5wXWkPpftqhr8x
         qznys6X0MKvpzGZ5C4MLa8IWCDiF3KWEMlBUHIRhQmH28NUeRzU57A1JukUCh0NxB2sw
         lirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=hKVtQAwnVa1yA0DBDx9GBM794IiTF2YgOfvvntIUx3w=;
        b=omGw8uduQ/TjwU6vBPFLbD9UXqf/gcyk8XMQhXNkWXATFBK+HHKqI3NVAd+YoUFlRC
         jMtErK08Hi/tOOzecvFin6bWz/v3ATt4vZIb2eho/Vgh87ZGFbgsitlCTPUrV1P/1pko
         POvrEZqZR8XO+FH4pqiqqlvay+R0yOjcJX8Yi7CL9f2tYDvCdXHFNYX/r54tgaXHZJrv
         rxhaFzUqQ3CBl5vPKp972SBD+QeZXtmlDeEsHCG6Cbd4z9egFiJTUwgig8FgtDCH2NnE
         qm+1fHyeNTagLW74NYQu3l+Ncm/eufpiQp4cOQuxTMtyOQP/zGICWo3AlZ0KOfavrszL
         8chw==
X-Gm-Message-State: ACrzQf12fKhsFAi9RhjMaA3HKrHC3D5Lv+g39J85E9FZEdeWWODw8tQ8
        mUtYBG2yCpeXqIxfB5GU45oEaqPBpJMCsmtl
X-Google-Smtp-Source: AMsMyM5MqrQBuzBRzbjNmVYD71uT2kvnFr0CcCXu66EDrPs1+u5tJgTFD/WiUysKJuFcZ40b/TYOvA==
X-Received: by 2002:a63:da02:0:b0:439:cc64:27fd with SMTP id c2-20020a63da02000000b00439cc6427fdmr24694374pgh.313.1664278483788;
        Tue, 27 Sep 2022 04:34:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ix9-20020a170902f80900b0017837d30a8csm1262870plb.254.2022.09.27.04.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 04:34:43 -0700 (PDT)
From:   zhangsongyi.cgel@gmail.com
X-Google-Original-From: zhang.songyi@zte.com.cn
To:     martin.petersen@oracle.com
Cc:     zhang.songyi@zte.com.cn, mgurtovoy@nvidia.com,
        michael.christie@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] scsi: target: use sysfs_emit() to instead of snprintf()
Date:   Tue, 27 Sep 2022 11:34:37 +0000
Message-Id: <20220927113437.259529-1-zhang.songyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the value
to be returned to user space.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 drivers/target/iscsi/iscsi_target_stat.c | 94 ++++++++++++------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_stat.c b/drivers/target/iscsi/iscsi_target_stat.c
index 367c6468b8e1..64a3fa7965a6 100644
--- a/drivers/target/iscsi/iscsi_target_stat.c
+++ b/drivers/target/iscsi/iscsi_target_stat.c
@@ -50,39 +50,39 @@ static struct iscsi_tiqn *iscsi_instance_tiqn(struct config_item *item)
 static ssize_t iscsi_stat_instance_inst_show(struct config_item *item,
 		char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n",
+	return sysfs_emit(page, "%u\n",
 			iscsi_instance_tiqn(item)->tiqn_index);
 }
 
 static ssize_t iscsi_stat_instance_min_ver_show(struct config_item *item,
 		char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n", ISCSI_DRAFT20_VERSION);
+	return sysfs_emit(page, "%u\n", ISCSI_DRAFT20_VERSION);
 }
 
 static ssize_t iscsi_stat_instance_max_ver_show(struct config_item *item,
 		char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n", ISCSI_DRAFT20_VERSION);
+	return sysfs_emit(page, "%u\n", ISCSI_DRAFT20_VERSION);
 }
 
 static ssize_t iscsi_stat_instance_portals_show(struct config_item *item,
 		char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n",
+	return sysfs_emit(page, "%u\n",
 			iscsi_instance_tiqn(item)->tiqn_num_tpg_nps);
 }
 
 static ssize_t iscsi_stat_instance_nodes_show(struct config_item *item,
 		char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n", ISCSI_INST_NUM_NODES);
+	return sysfs_emit(page, "%u\n", ISCSI_INST_NUM_NODES);
 }
 
 static ssize_t iscsi_stat_instance_sessions_show(struct config_item *item,
 		char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n",
+	return sysfs_emit(page, "%u\n",
 		iscsi_instance_tiqn(item)->tiqn_nsessions);
 }
 
@@ -99,7 +99,7 @@ static ssize_t iscsi_stat_instance_fail_sess_show(struct config_item *item,
 			  sess_err->pdu_format_errors);
 	spin_unlock_bh(&sess_err->lock);
 
-	return snprintf(page, PAGE_SIZE, "%u\n", sess_err_count);
+	return sysfs_emit(page, "%u\n", sess_err_count);
 }
 
 static ssize_t iscsi_stat_instance_fail_type_show(struct config_item *item,
@@ -108,7 +108,7 @@ static ssize_t iscsi_stat_instance_fail_type_show(struct config_item *item,
 	struct iscsi_tiqn *tiqn = iscsi_instance_tiqn(item);
 	struct iscsi_sess_err_stats *sess_err = &tiqn->sess_err_stats;
 
-	return snprintf(page, PAGE_SIZE, "%u\n",
+	return sysfs_emit(page, "%u\n",
 			sess_err->last_sess_failure_type);
 }
 
@@ -118,7 +118,7 @@ static ssize_t iscsi_stat_instance_fail_rem_name_show(struct config_item *item,
 	struct iscsi_tiqn *tiqn = iscsi_instance_tiqn(item);
 	struct iscsi_sess_err_stats *sess_err = &tiqn->sess_err_stats;
 
-	return snprintf(page, PAGE_SIZE, "%s\n",
+	return sysfs_emit(page, "%s\n",
 			sess_err->last_sess_fail_rem_name[0] ?
 			sess_err->last_sess_fail_rem_name : NONE);
 }
@@ -126,25 +126,25 @@ static ssize_t iscsi_stat_instance_fail_rem_name_show(struct config_item *item,
 static ssize_t iscsi_stat_instance_disc_time_show(struct config_item *item,
 		char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n", ISCSI_DISCONTINUITY_TIME);
+	return sysfs_emit(page, "%u\n", ISCSI_DISCONTINUITY_TIME);
 }
 
 static ssize_t iscsi_stat_instance_description_show(struct config_item *item,
 		char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%s\n", ISCSI_INST_DESCR);
+	return sysfs_emit(page, "%s\n", ISCSI_INST_DESCR);
 }
 
 static ssize_t iscsi_stat_instance_vendor_show(struct config_item *item,
 		char *page)
 {
-	return snprintf(page, PAGE_SIZE, "Datera, Inc. iSCSI-Target\n");
+	return sysfs_emit(page, "Datera, Inc. iSCSI-Target\n");
 }
 
 static ssize_t iscsi_stat_instance_version_show(struct config_item *item,
 		char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%s\n", ISCSIT_VERSION);
+	return sysfs_emit(page, "%s\n", ISCSIT_VERSION);
 }
 
 CONFIGFS_ATTR_RO(iscsi_stat_instance_, inst);
@@ -196,7 +196,7 @@ static struct iscsi_tiqn *iscsi_sess_err_tiqn(struct config_item *item)
 static ssize_t iscsi_stat_sess_err_inst_show(struct config_item *item,
 		char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n",
+	return sysfs_emit(page, "%u\n",
 		iscsi_sess_err_tiqn(item)->tiqn_index);
 }
 
@@ -206,7 +206,7 @@ static ssize_t iscsi_stat_sess_err_digest_errors_show(struct config_item *item,
 	struct iscsi_tiqn *tiqn = iscsi_sess_err_tiqn(item);
 	struct iscsi_sess_err_stats *sess_err = &tiqn->sess_err_stats;
 
-	return snprintf(page, PAGE_SIZE, "%u\n", sess_err->digest_errors);
+	return sysfs_emit(page, "%u\n", sess_err->digest_errors);
 }
 
 static ssize_t iscsi_stat_sess_err_cxn_errors_show(struct config_item *item,
@@ -215,7 +215,7 @@ static ssize_t iscsi_stat_sess_err_cxn_errors_show(struct config_item *item,
 	struct iscsi_tiqn *tiqn = iscsi_sess_err_tiqn(item);
 	struct iscsi_sess_err_stats *sess_err = &tiqn->sess_err_stats;
 
-	return snprintf(page, PAGE_SIZE, "%u\n", sess_err->cxn_timeout_errors);
+	return sysfs_emit(page, "%u\n", sess_err->cxn_timeout_errors);
 }
 
 static ssize_t iscsi_stat_sess_err_format_errors_show(struct config_item *item,
@@ -224,7 +224,7 @@ static ssize_t iscsi_stat_sess_err_format_errors_show(struct config_item *item,
 	struct iscsi_tiqn *tiqn = iscsi_sess_err_tiqn(item);
 	struct iscsi_sess_err_stats *sess_err = &tiqn->sess_err_stats;
 
-	return snprintf(page, PAGE_SIZE, "%u\n", sess_err->pdu_format_errors);
+	return sysfs_emit(page, "%u\n", sess_err->pdu_format_errors);
 }
 
 CONFIGFS_ATTR_RO(iscsi_stat_sess_err_, inst);
@@ -258,14 +258,14 @@ static struct iscsi_tiqn *iscsi_tgt_attr_tiqn(struct config_item *item)
 static ssize_t iscsi_stat_tgt_attr_inst_show(struct config_item *item,
 		char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n",
+	return sysfs_emit(page, "%u\n",
 			iscsi_tgt_attr_tiqn(item)->tiqn_index);
 }
 
 static ssize_t iscsi_stat_tgt_attr_indx_show(struct config_item *item,
 		char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n", ISCSI_NODE_INDEX);
+	return sysfs_emit(page, "%u\n", ISCSI_NODE_INDEX);
 }
 
 static ssize_t iscsi_stat_tgt_attr_login_fails_show(struct config_item *item,
@@ -281,7 +281,7 @@ static ssize_t iscsi_stat_tgt_attr_login_fails_show(struct config_item *item,
 			lstat->other_fails);
 	spin_unlock(&lstat->lock);
 
-	return snprintf(page, PAGE_SIZE, "%u\n", fail_count);
+	return sysfs_emit(page, "%u\n", fail_count);
 }
 
 static ssize_t iscsi_stat_tgt_attr_last_fail_time_show(struct config_item *item,
@@ -297,7 +297,7 @@ static ssize_t iscsi_stat_tgt_attr_last_fail_time_show(struct config_item *item,
 				INITIAL_JIFFIES) * 100 / HZ) : 0;
 	spin_unlock(&lstat->lock);
 
-	return snprintf(page, PAGE_SIZE, "%u\n", last_fail_time);
+	return sysfs_emit(page, "%u\n", last_fail_time);
 }
 
 static ssize_t iscsi_stat_tgt_attr_last_fail_type_show(struct config_item *item,
@@ -311,7 +311,7 @@ static ssize_t iscsi_stat_tgt_attr_last_fail_type_show(struct config_item *item,
 	last_fail_type = lstat->last_fail_type;
 	spin_unlock(&lstat->lock);
 
-	return snprintf(page, PAGE_SIZE, "%u\n", last_fail_type);
+	return sysfs_emit(page, "%u\n", last_fail_type);
 }
 
 static ssize_t iscsi_stat_tgt_attr_fail_intr_name_show(struct config_item *item,
@@ -326,7 +326,7 @@ static ssize_t iscsi_stat_tgt_attr_fail_intr_name_show(struct config_item *item,
 				lstat->last_intr_fail_name : NONE);
 	spin_unlock(&lstat->lock);
 
-	return snprintf(page, PAGE_SIZE, "%s\n", buf);
+	return sysfs_emit(page, "%s\n", buf);
 }
 
 static ssize_t iscsi_stat_tgt_attr_fail_intr_addr_type_show(struct config_item *item,
@@ -338,9 +338,9 @@ static ssize_t iscsi_stat_tgt_attr_fail_intr_addr_type_show(struct config_item *
 
 	spin_lock(&lstat->lock);
 	if (lstat->last_intr_fail_ip_family == AF_INET6)
-		ret = snprintf(page, PAGE_SIZE, "ipv6\n");
+		ret = sysfs_emit(page, "ipv6\n");
 	else
-		ret = snprintf(page, PAGE_SIZE, "ipv4\n");
+		ret = sysfs_emit(page, "ipv4\n");
 	spin_unlock(&lstat->lock);
 
 	return ret;
@@ -354,7 +354,7 @@ static ssize_t iscsi_stat_tgt_attr_fail_intr_addr_show(struct config_item *item,
 	int ret;
 
 	spin_lock(&lstat->lock);
-	ret = snprintf(page, PAGE_SIZE, "%pISc\n", &lstat->last_intr_fail_sockaddr);
+	ret = sysfs_emit(page, "%pISc\n", &lstat->last_intr_fail_sockaddr);
 	spin_unlock(&lstat->lock);
 
 	return ret;
@@ -398,14 +398,14 @@ static struct iscsi_tiqn *iscsi_login_stat_tiqn(struct config_item *item)
 
 static ssize_t iscsi_stat_login_inst_show(struct config_item *item, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n",
+	return sysfs_emit(page, "%u\n",
 		iscsi_login_stat_tiqn(item)->tiqn_index);
 }
 
 static ssize_t iscsi_stat_login_indx_show(struct config_item *item,
 		char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n", ISCSI_NODE_INDEX);
+	return sysfs_emit(page, "%u\n", ISCSI_NODE_INDEX);
 }
 
 static ssize_t iscsi_stat_login_accepts_show(struct config_item *item,
@@ -416,7 +416,7 @@ static ssize_t iscsi_stat_login_accepts_show(struct config_item *item,
 	ssize_t ret;
 
 	spin_lock(&lstat->lock);
-	ret = snprintf(page, PAGE_SIZE, "%u\n", lstat->accepts);
+	ret = sysfs_emit(page, "%u\n", lstat->accepts);
 	spin_unlock(&lstat->lock);
 
 	return ret;
@@ -430,7 +430,7 @@ static ssize_t iscsi_stat_login_other_fails_show(struct config_item *item,
 	ssize_t ret;
 
 	spin_lock(&lstat->lock);
-	ret = snprintf(page, PAGE_SIZE, "%u\n", lstat->other_fails);
+	ret = sysfs_emit(page, "%u\n", lstat->other_fails);
 	spin_unlock(&lstat->lock);
 
 	return ret;
@@ -444,7 +444,7 @@ static ssize_t iscsi_stat_login_redirects_show(struct config_item *item,
 	ssize_t ret;
 
 	spin_lock(&lstat->lock);
-	ret = snprintf(page, PAGE_SIZE, "%u\n", lstat->redirects);
+	ret = sysfs_emit(page, "%u\n", lstat->redirects);
 	spin_unlock(&lstat->lock);
 
 	return ret;
@@ -458,7 +458,7 @@ static ssize_t iscsi_stat_login_authorize_fails_show(struct config_item *item,
 	ssize_t ret;
 
 	spin_lock(&lstat->lock);
-	ret = snprintf(page, PAGE_SIZE, "%u\n", lstat->authorize_fails);
+	ret = sysfs_emit(page, "%u\n", lstat->authorize_fails);
 	spin_unlock(&lstat->lock);
 
 	return ret;
@@ -472,7 +472,7 @@ static ssize_t iscsi_stat_login_authenticate_fails_show(
 	ssize_t ret;
 
 	spin_lock(&lstat->lock);
-	ret = snprintf(page, PAGE_SIZE, "%u\n", lstat->authenticate_fails);
+	ret = sysfs_emit(page, "%u\n", lstat->authenticate_fails);
 	spin_unlock(&lstat->lock);
 
 	return ret;
@@ -486,7 +486,7 @@ static ssize_t iscsi_stat_login_negotiate_fails_show(struct config_item *item,
 	ssize_t ret;
 
 	spin_lock(&lstat->lock);
-	ret = snprintf(page, PAGE_SIZE, "%u\n", lstat->negotiate_fails);
+	ret = sysfs_emit(page, "%u\n", lstat->negotiate_fails);
 	spin_unlock(&lstat->lock);
 
 	return ret;
@@ -530,13 +530,13 @@ static struct iscsi_tiqn *iscsi_logout_stat_tiqn(struct config_item *item)
 
 static ssize_t iscsi_stat_logout_inst_show(struct config_item *item, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n",
+	return sysfs_emit(page, "%u\n",
 		iscsi_logout_stat_tiqn(item)->tiqn_index);
 }
 
 static ssize_t iscsi_stat_logout_indx_show(struct config_item *item, char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%u\n", ISCSI_NODE_INDEX);
+	return sysfs_emit(page, "%u\n", ISCSI_NODE_INDEX);
 }
 
 static ssize_t iscsi_stat_logout_normal_logouts_show(struct config_item *item,
@@ -545,7 +545,7 @@ static ssize_t iscsi_stat_logout_normal_logouts_show(struct config_item *item,
 	struct iscsi_tiqn *tiqn = iscsi_logout_stat_tiqn(item);
 	struct iscsi_logout_stats *lstats = &tiqn->logout_stats;
 
-	return snprintf(page, PAGE_SIZE, "%u\n", lstats->normal_logouts);
+	return sysfs_emit(page, "%u\n", lstats->normal_logouts);
 }
 
 static ssize_t iscsi_stat_logout_abnormal_logouts_show(struct config_item *item,
@@ -554,7 +554,7 @@ static ssize_t iscsi_stat_logout_abnormal_logouts_show(struct config_item *item,
 	struct iscsi_tiqn *tiqn = iscsi_logout_stat_tiqn(item);
 	struct iscsi_logout_stats *lstats = &tiqn->logout_stats;
 
-	return snprintf(page, PAGE_SIZE, "%u\n", lstats->abnormal_logouts);
+	return sysfs_emit(page, "%u\n", lstats->abnormal_logouts);
 }
 
 CONFIGFS_ATTR_RO(iscsi_stat_logout_, inst);
@@ -592,7 +592,7 @@ static ssize_t iscsi_stat_sess_inst_show(struct config_item *item, char *page)
 	struct iscsi_tiqn *tiqn = container_of(wwn,
 			struct iscsi_tiqn, tiqn_wwn);
 
-	return snprintf(page, PAGE_SIZE, "%u\n", tiqn->tiqn_index);
+	return sysfs_emit(page, "%u\n", tiqn->tiqn_index);
 }
 
 static ssize_t iscsi_stat_sess_node_show(struct config_item *item, char *page)
@@ -608,7 +608,7 @@ static ssize_t iscsi_stat_sess_node_show(struct config_item *item, char *page)
 	if (se_sess) {
 		sess = se_sess->fabric_sess_ptr;
 		if (sess)
-			ret = snprintf(page, PAGE_SIZE, "%u\n",
+			ret = sysfs_emit(page, "%u\n",
 				sess->sess_ops->SessionType ? 0 : ISCSI_NODE_INDEX);
 	}
 	spin_unlock_bh(&se_nacl->nacl_sess_lock);
@@ -629,7 +629,7 @@ static ssize_t iscsi_stat_sess_indx_show(struct config_item *item, char *page)
 	if (se_sess) {
 		sess = se_sess->fabric_sess_ptr;
 		if (sess)
-			ret = snprintf(page, PAGE_SIZE, "%u\n",
+			ret = sysfs_emit(page, "%u\n",
 					sess->session_index);
 	}
 	spin_unlock_bh(&se_nacl->nacl_sess_lock);
@@ -651,7 +651,7 @@ static ssize_t iscsi_stat_sess_cmd_pdus_show(struct config_item *item,
 	if (se_sess) {
 		sess = se_sess->fabric_sess_ptr;
 		if (sess)
-			ret = snprintf(page, PAGE_SIZE, "%lu\n",
+			ret = sysfs_emit(page, "%lu\n",
 				       atomic_long_read(&sess->cmd_pdus));
 	}
 	spin_unlock_bh(&se_nacl->nacl_sess_lock);
@@ -673,7 +673,7 @@ static ssize_t iscsi_stat_sess_rsp_pdus_show(struct config_item *item,
 	if (se_sess) {
 		sess = se_sess->fabric_sess_ptr;
 		if (sess)
-			ret = snprintf(page, PAGE_SIZE, "%lu\n",
+			ret = sysfs_emit(page, "%lu\n",
 				       atomic_long_read(&sess->rsp_pdus));
 	}
 	spin_unlock_bh(&se_nacl->nacl_sess_lock);
@@ -695,7 +695,7 @@ static ssize_t iscsi_stat_sess_txdata_octs_show(struct config_item *item,
 	if (se_sess) {
 		sess = se_sess->fabric_sess_ptr;
 		if (sess)
-			ret = snprintf(page, PAGE_SIZE, "%lu\n",
+			ret = sysfs_emit(page, "%lu\n",
 				       atomic_long_read(&sess->tx_data_octets));
 	}
 	spin_unlock_bh(&se_nacl->nacl_sess_lock);
@@ -717,7 +717,7 @@ static ssize_t iscsi_stat_sess_rxdata_octs_show(struct config_item *item,
 	if (se_sess) {
 		sess = se_sess->fabric_sess_ptr;
 		if (sess)
-			ret = snprintf(page, PAGE_SIZE, "%lu\n",
+			ret = sysfs_emit(page, "%lu\n",
 				       atomic_long_read(&sess->rx_data_octets));
 	}
 	spin_unlock_bh(&se_nacl->nacl_sess_lock);
@@ -739,7 +739,7 @@ static ssize_t iscsi_stat_sess_conn_digest_errors_show(struct config_item *item,
 	if (se_sess) {
 		sess = se_sess->fabric_sess_ptr;
 		if (sess)
-			ret = snprintf(page, PAGE_SIZE, "%lu\n",
+			ret = sysfs_emit(page, "%lu\n",
 				       atomic_long_read(&sess->conn_digest_errors));
 	}
 	spin_unlock_bh(&se_nacl->nacl_sess_lock);
@@ -761,7 +761,7 @@ static ssize_t iscsi_stat_sess_conn_timeout_errors_show(
 	if (se_sess) {
 		sess = se_sess->fabric_sess_ptr;
 		if (sess)
-			ret = snprintf(page, PAGE_SIZE, "%lu\n",
+			ret = sysfs_emit(page, "%lu\n",
 				       atomic_long_read(&sess->conn_timeout_errors));
 	}
 	spin_unlock_bh(&se_nacl->nacl_sess_lock);
-- 
2.25.1


