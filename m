Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33145EC1A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiI0LjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiI0LjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:39:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6ED1449D3;
        Tue, 27 Sep 2022 04:39:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b5so9153537pgb.6;
        Tue, 27 Sep 2022 04:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Za2InhZkbyYKnD28W32y98g/AVSxLF4A9r63BGgksLE=;
        b=JUUR6JaExhRepcLumPfEHU7gwLXOU8uyIF3TEk3AezJswqYXqfGqc4tiKMuYgx4aFW
         e9aa8S5qmiL1j/mc44Wq6K67E8FvwmEtKKlTb1KAVFJFta12uuV0dFB+OnbNZvN3lap5
         6Sj7j4xDLHynLQ8Q0krx2e5OChz5PsKBGJik6yyAHPAhdXt5QHsUfaJ47+B/cU1L7Vo0
         9fToh3Re+MICaIcpV0VcfTk9/nkwOZ/N1zu6ARYeY6CaIlwACPbvde9zn9LOzqns9DsK
         rF63imbnMI0qFRKjHwWjYwx2YGrKfhlxbmYHwskLHAkMVC2/RzIfmAshNcamvgrSWfCt
         QMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Za2InhZkbyYKnD28W32y98g/AVSxLF4A9r63BGgksLE=;
        b=7yWSAwu96AOGmoTqawI5FZIBNDuzFvtMCTyHs8f+nesH5/0Zxtt9DNyk5wnH3PYI7W
         1m5WfiDSsmrmxkb7vnkC1/0bgZUwKpM3+60ecfAs5i3g8yTeSiQ5o2VcfBvbyxdysHq5
         +cUYX3AALgXVxuJ4nfhNPsFL7hKZvAiViu+J9aYwsy8E9s4Aftx5+s1C2D4pFugHhZb6
         hin4Jw9aiGHYLu7GFtgyYU75TGmwgYlXOcWQK/K3zB1G01Gx1BVH+eI4rC06pzjcKmBk
         MPLh6FfvJzHDDkWKj/CU5y9ktCjN95UpxgQh4k9riYzMTOxdnNX5/BbUR+1tJVtJ5nxH
         cMYg==
X-Gm-Message-State: ACrzQf0HyJWMTGoITqJEKh82UUIRapevk2GXhtb53PyQ1VxZb/Gnm5sE
        UUri4iULwSSaj0hvAf/q0nuIUZPrVaKZu7eU
X-Google-Smtp-Source: AMsMyM6hEvLPVMu+HdNNHrsWOMsl4Urq4ho7/eCbDspcDtyEw0ARkXXED3a8E3QOa7EReZkDya1x7A==
X-Received: by 2002:a63:ff50:0:b0:439:ae51:503c with SMTP id s16-20020a63ff50000000b00439ae51503cmr24597571pgk.158.1664278742595;
        Tue, 27 Sep 2022 04:39:02 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k60-20020a17090a4cc200b002006f15ad4fsm8241431pjh.10.2022.09.27.04.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 04:39:02 -0700 (PDT)
From:   zhangsongyi.cgel@gmail.com
X-Google-Original-From: zhang.songyi@zte.com.cn
To:     freude@linux.ibm.com
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] s390/ap: Convert to use sysfs_emit() APIs
Date:   Tue, 27 Sep 2022 11:38:57 +0000
Message-Id: <20220927113857.259596-1-zhang.songyi@zte.com.cn>
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
 drivers/s390/crypto/ap_bus.c | 37 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 59ac98f2bd27..0f7f0d179289 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1165,7 +1165,7 @@ EXPORT_SYMBOL(ap_parse_mask_str);
 
 static ssize_t ap_domain_show(struct bus_type *bus, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%d\n", ap_domain_index);
+	return sysfs_emit(buf, "%d\n", ap_domain_index);
 }
 
 static ssize_t ap_domain_store(struct bus_type *bus,
@@ -1193,9 +1193,9 @@ static BUS_ATTR_RW(ap_domain);
 static ssize_t ap_control_domain_mask_show(struct bus_type *bus, char *buf)
 {
 	if (!ap_qci_info)	/* QCI not supported */
-		return scnprintf(buf, PAGE_SIZE, "not supported\n");
+		return sysfs_emit(buf, "not supported\n");
 
-	return scnprintf(buf, PAGE_SIZE,
+	return sysfs_emit(buf,
 			 "0x%08x%08x%08x%08x%08x%08x%08x%08x\n",
 			 ap_qci_info->adm[0], ap_qci_info->adm[1],
 			 ap_qci_info->adm[2], ap_qci_info->adm[3],
@@ -1208,9 +1208,9 @@ static BUS_ATTR_RO(ap_control_domain_mask);
 static ssize_t ap_usage_domain_mask_show(struct bus_type *bus, char *buf)
 {
 	if (!ap_qci_info)	/* QCI not supported */
-		return scnprintf(buf, PAGE_SIZE, "not supported\n");
+		return sysfs_emit(buf, "not supported\n");
 
-	return scnprintf(buf, PAGE_SIZE,
+	return sysfs_emit(buf,
 			 "0x%08x%08x%08x%08x%08x%08x%08x%08x\n",
 			 ap_qci_info->aqm[0], ap_qci_info->aqm[1],
 			 ap_qci_info->aqm[2], ap_qci_info->aqm[3],
@@ -1223,9 +1223,9 @@ static BUS_ATTR_RO(ap_usage_domain_mask);
 static ssize_t ap_adapter_mask_show(struct bus_type *bus, char *buf)
 {
 	if (!ap_qci_info)	/* QCI not supported */
-		return scnprintf(buf, PAGE_SIZE, "not supported\n");
+		return sysfs_emit(buf, "not supported\n");
 
-	return scnprintf(buf, PAGE_SIZE,
+	return sysfs_emit(buf,
 			 "0x%08x%08x%08x%08x%08x%08x%08x%08x\n",
 			 ap_qci_info->apm[0], ap_qci_info->apm[1],
 			 ap_qci_info->apm[2], ap_qci_info->apm[3],
@@ -1237,15 +1237,14 @@ static BUS_ATTR_RO(ap_adapter_mask);
 
 static ssize_t ap_interrupts_show(struct bus_type *bus, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%d\n",
-			 ap_irq_flag ? 1 : 0);
+	return sysfs_emit(buf, "%d\n", ap_irq_flag ? 1 : 0);
 }
 
 static BUS_ATTR_RO(ap_interrupts);
 
 static ssize_t config_time_show(struct bus_type *bus, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%d\n", ap_config_time);
+	return sysfs_emit(buf, "%d\n", ap_config_time);
 }
 
 static ssize_t config_time_store(struct bus_type *bus,
@@ -1264,7 +1263,7 @@ static BUS_ATTR_RW(config_time);
 
 static ssize_t poll_thread_show(struct bus_type *bus, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%d\n", ap_poll_kthread ? 1 : 0);
+	return sysfs_emit(buf, "%d\n", ap_poll_kthread ? 1 : 0);
 }
 
 static ssize_t poll_thread_store(struct bus_type *bus,
@@ -1288,7 +1287,7 @@ static BUS_ATTR_RW(poll_thread);
 
 static ssize_t poll_timeout_show(struct bus_type *bus, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", poll_timeout);
+	return sysfs_emit(buf, "%llu\n", poll_timeout);
 }
 
 static ssize_t poll_timeout_store(struct bus_type *bus, const char *buf,
@@ -1317,14 +1316,14 @@ static BUS_ATTR_RW(poll_timeout);
 
 static ssize_t ap_max_domain_id_show(struct bus_type *bus, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%d\n", ap_max_domain_id);
+	return sysfs_emit(buf, "%d\n", ap_max_domain_id);
 }
 
 static BUS_ATTR_RO(ap_max_domain_id);
 
 static ssize_t ap_max_adapter_id_show(struct bus_type *bus, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%d\n", ap_max_adapter_id);
+	return sysfs_emit(buf, "%d\n", ap_max_adapter_id);
 }
 
 static BUS_ATTR_RO(ap_max_adapter_id);
@@ -1335,7 +1334,7 @@ static ssize_t apmask_show(struct bus_type *bus, char *buf)
 
 	if (mutex_lock_interruptible(&ap_perms_mutex))
 		return -ERESTARTSYS;
-	rc = scnprintf(buf, PAGE_SIZE,
+	rc = sysfs_emit(buf,
 		       "0x%016lx%016lx%016lx%016lx\n",
 		       ap_perms.apm[0], ap_perms.apm[1],
 		       ap_perms.apm[2], ap_perms.apm[3]);
@@ -1428,7 +1427,7 @@ static ssize_t aqmask_show(struct bus_type *bus, char *buf)
 
 	if (mutex_lock_interruptible(&ap_perms_mutex))
 		return -ERESTARTSYS;
-	rc = scnprintf(buf, PAGE_SIZE,
+	rc = sysfs_emit(buf,
 		       "0x%016lx%016lx%016lx%016lx\n",
 		       ap_perms.aqm[0], ap_perms.aqm[1],
 		       ap_perms.aqm[2], ap_perms.aqm[3]);
@@ -1517,7 +1516,7 @@ static BUS_ATTR_RW(aqmask);
 
 static ssize_t scans_show(struct bus_type *bus, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			 atomic64_read(&ap_scan_bus_count));
 }
 
@@ -1540,9 +1539,9 @@ static ssize_t bindings_show(struct bus_type *bus, char *buf)
 
 	ap_calc_bound_apqns(&apqns, &n);
 	if (atomic64_read(&ap_scan_bus_count) >= 1 && n == apqns)
-		rc = scnprintf(buf, PAGE_SIZE, "%u/%u (complete)\n", n, apqns);
+		rc = sysfs_emit(buf, "%u/%u (complete)\n", n, apqns);
 	else
-		rc = scnprintf(buf, PAGE_SIZE, "%u/%u\n", n, apqns);
+		rc = sysfs_emit(buf, "%u/%u\n", n, apqns);
 
 	return rc;
 }
-- 
2.25.1


