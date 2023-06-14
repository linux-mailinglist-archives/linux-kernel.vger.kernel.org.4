Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1608972F455
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbjFNF4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243005AbjFNF4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:56:30 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B2E1BD3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:56:26 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgvn44b3bzBJLB4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:56:24 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686722184; x=1689314185; bh=ifq8SS92AiyQI92n55ie/vsInhk
        9lQuSNFdLJ7tnOxs=; b=E5Ms8znZJcpeZWdiYr9w6xx4Gc0b9QuCG5AOxBAAsYV
        in+FDR97kndTlXNXhXm8A0LwHW7cHIFU7spI/D67+cmW35V7gYRD5mJAr79SsOGG
        kq3+4/wMeghvnlsp4zjeDb/8YA1xxRt7YnZ0yYfguaf0BR8dfUGWdGNkSCgzkQAm
        HDG4rR79wp3wI7OHll39PrtYjE3d1/gWHKTuG+P6P/yTpB5CScQE6Hgqsa7EQIi6
        ldBuXlBlVKBGeCuNlacZo7qpLiSDi98eVnqDyEHmsnbib6FGbukR+HTu2EWmhfWq
        cx6sMTYnYWCqaG8g938idY55gYAIZSghZuoVnda6udg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vVnf2m4TxF18 for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 13:56:24 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgvn43C3SzBJLB3;
        Wed, 14 Jun 2023 13:56:24 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 13:56:24 +0800
From:   wuyonggang001@208suo.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@kernel.org
Subject: [PATCH] scsi: myrs: Replacing snprintf with scnprintf
In-Reply-To: <f82ebaeda200bc172cd1764b44fa1a0a@208suo.com>
References: <20230613065350.39003-1-zhanglibing@cdjrlc.com>
 <f82ebaeda200bc172cd1764b44fa1a0a@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <6d2c37de23facd0cd854bbaf6913ba3e@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/scsi/myrs.c:1411:8-16: WARNING: use scnprintf or sprintf

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  drivers/scsi/myrs.c | 22 +++++++++++-----------
  1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index a1eec65a9713..ced1d2fbd862 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -939,7 +939,7 @@ static ssize_t raid_state_show(struct device *dev,
      int ret;

      if (!sdev->hostdata)
-        return snprintf(buf, 16, "Unknown\n");
+        return scnprintf(buf, 16, "Unknown\n");

      if (sdev->channel >= cs->ctlr_info->physchan_present) {
          struct myrs_ldev_info *ldev_info = sdev->hostdata;
@@ -1058,7 +1058,7 @@ static ssize_t raid_level_show(struct device *dev,
      const char *name = NULL;

      if (!sdev->hostdata)
-        return snprintf(buf, 16, "Unknown\n");
+        return scnprintf(buf, 16, "Unknown\n");

      if (sdev->channel >= cs->ctlr_info->physchan_present) {
          struct myrs_ldev_info *ldev_info;
@@ -1086,7 +1086,7 @@ static ssize_t rebuild_show(struct device *dev,
      unsigned char status;

      if (sdev->channel < cs->ctlr_info->physchan_present)
-        return snprintf(buf, 32, "physical device - not rebuilding\n");
+        return scnprintf(buf, 32, "physical device - not 
rebuilding\n");

      ldev_info = sdev->hostdata;
      ldev_num = ldev_info->ldev_num;
@@ -1190,7 +1190,7 @@ static ssize_t consistency_check_show(struct 
device *dev,
      unsigned short ldev_num;

      if (sdev->channel < cs->ctlr_info->physchan_present)
-        return snprintf(buf, 32, "physical device - not checking\n");
+        return scnprintf(buf, 32, "physical device - not checking\n");

      ldev_info = sdev->hostdata;
      if (!ldev_info)
@@ -1303,7 +1303,7 @@ static ssize_t serial_show(struct device *dev,

      memcpy(serial, cs->ctlr_info->serial_number, 16);
      serial[16] = '\0';
-    return snprintf(buf, 16, "%s\n", serial);
+    return scnprintf(buf, 16, "%s\n", serial);
  }
  static DEVICE_ATTR_RO(serial);

@@ -1313,7 +1313,7 @@ static ssize_t ctlr_num_show(struct device *dev,
      struct Scsi_Host *shost = class_to_shost(dev);
      struct myrs_hba *cs = shost_priv(shost);

-    return snprintf(buf, 20, "%d\n", cs->host->host_no);
+    return scnprintf(buf, 20, "%d\n", cs->host->host_no);
  }
  static DEVICE_ATTR_RO(ctlr_num);

@@ -1388,7 +1388,7 @@ static ssize_t model_show(struct device *dev,
      struct Scsi_Host *shost = class_to_shost(dev);
      struct myrs_hba *cs = shost_priv(shost);

-    return snprintf(buf, 28, "%s\n", cs->model_name);
+    return scnprintf(buf, 28, "%s\n", cs->model_name);
  }
  static DEVICE_ATTR_RO(model);

@@ -1398,7 +1398,7 @@ static ssize_t ctlr_type_show(struct device *dev,
      struct Scsi_Host *shost = class_to_shost(dev);
      struct myrs_hba *cs = shost_priv(shost);

-    return snprintf(buf, 4, "%d\n", cs->ctlr_info->ctlr_type);
+    return scnprintf(buf, 4, "%d\n", cs->ctlr_info->ctlr_type);
  }
  static DEVICE_ATTR_RO(ctlr_type);

@@ -1408,7 +1408,7 @@ static ssize_t cache_size_show(struct device *dev,
      struct Scsi_Host *shost = class_to_shost(dev);
      struct myrs_hba *cs = shost_priv(shost);

-    return snprintf(buf, 8, "%d MB\n", cs->ctlr_info->cache_size_mb);
+    return scnprintf(buf, 8, "%d MB\n", cs->ctlr_info->cache_size_mb);
  }
  static DEVICE_ATTR_RO(cache_size);

@@ -1418,7 +1418,7 @@ static ssize_t firmware_show(struct device *dev,
      struct Scsi_Host *shost = class_to_shost(dev);
      struct myrs_hba *cs = shost_priv(shost);

-    return snprintf(buf, 16, "%d.%02d-%02d\n",
+    return scnprintf(buf, 16, "%d.%02d-%02d\n",
              cs->ctlr_info->fw_major_version,
              cs->ctlr_info->fw_minor_version,
              cs->ctlr_info->fw_turn_number);
@@ -1488,7 +1488,7 @@ static ssize_t 
disable_enclosure_messages_show(struct device *dev,
      struct Scsi_Host *shost = class_to_shost(dev);
      struct myrs_hba *cs = shost_priv(shost);

-    return snprintf(buf, 3, "%d\n", cs->disable_enc_msg);
+    return scnprintf(buf, 3, "%d\n", cs->disable_enc_msg);
  }

  static ssize_t disable_enclosure_messages_store(struct device *dev,
