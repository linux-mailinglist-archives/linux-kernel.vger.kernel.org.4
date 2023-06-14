Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF96372F44A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242958AbjFNFxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbjFNFxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:53:13 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C91BC5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 22:53:11 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgvjK39t3zBQJYH
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:53:09 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686721989; x=1689313990; bh=gwL5QqnWkXh0OwdKNyQ5nGlzb3p
        qMBoMNFQEcLAZTlU=; b=cUIA2qzMBofXMMOjIic3XHBJx6Kuj4mRYoX8FuROgyS
        HSp1/Ig4etu0Te/yrPT1ZG6stnIAh4pzTLoGcuOdN81BAuAxsmkDRWXeeHyFLDrH
        98d53fHj4ICZUMOL2oXxJIJC0B3Re0KROREjfmJixN1hyvuQuoyenNzR1t++nQFK
        jbrt1sqNXw8cSPFTUZGNOIUnfp1Hb4Oqzqdd6voRGnZB/yobzAyGFwTgtKxo9c5c
        erj4XOYtI9XPSy3l6EPVNFnX8YK4OcwlcUj79qwCMXrjIfN9iQqWQ+K8YgPJxCX4
        m0zmYr3ZhoRlX3RJRkLzDQKj09cwCRBljKf3h17dz+Q==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Csh6wUO-G5-x for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 13:53:09 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgvjK1X25zBJLB3;
        Wed, 14 Jun 2023 13:53:09 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 13:53:09 +0800
From:   wuyonggang001@208suo.com
To:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: message: fusion: Replacing snprintf with scnprintf
In-Reply-To: <ecee2f186d763f578d770e7e0a05da89@208suo.com>
References: <20230613061754.22011-1-zhanglibing@cdjrlc.com>
 <ecee2f186d763f578d770e7e0a05da89@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <4de6b90007332f09f9c2e77aa27c168a@208suo.com>
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

drivers/message/fusion/mptscsih.c:3146:8-16: WARNING: use scnprintf or 
sprintf

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  drivers/message/fusion/mptscsih.c | 24 ++++++++++++------------
  1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/message/fusion/mptscsih.c 
b/drivers/message/fusion/mptscsih.c
index 2bc17087d17d..f79a22f130b1 100644
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -3045,7 +3045,7 @@ mptscsih_version_fw_show(struct device *dev, 
struct device_attribute *attr,
      MPT_SCSI_HOST    *hd = shost_priv(host);
      MPT_ADAPTER *ioc = hd->ioc;

-    return snprintf(buf, PAGE_SIZE, "%02d.%02d.%02d.%02d\n",
+    return scnprintf(buf, PAGE_SIZE, "%02d.%02d.%02d.%02d\n",
          (ioc->facts.FWVersion.Word & 0xFF000000) >> 24,
          (ioc->facts.FWVersion.Word & 0x00FF0000) >> 16,
          (ioc->facts.FWVersion.Word & 0x0000FF00) >> 8,
@@ -3061,7 +3061,7 @@ mptscsih_version_bios_show(struct device *dev, 
struct device_attribute *attr,
      MPT_SCSI_HOST    *hd = shost_priv(host);
      MPT_ADAPTER *ioc = hd->ioc;

-    return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
+    return scnprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
          (ioc->biosVersion & 0xFF000000) >> 24,
          (ioc->biosVersion & 0x00FF0000) >> 16,
          (ioc->biosVersion & 0x0000FF00) >> 8,
@@ -3077,7 +3077,7 @@ mptscsih_version_mpi_show(struct device *dev, 
struct device_attribute *attr,
      MPT_SCSI_HOST    *hd = shost_priv(host);
      MPT_ADAPTER *ioc = hd->ioc;

-    return snprintf(buf, PAGE_SIZE, "%03x\n", ioc->facts.MsgVersion);
+    return scnprintf(buf, PAGE_SIZE, "%03x\n", ioc->facts.MsgVersion);
  }
  static DEVICE_ATTR(version_mpi, S_IRUGO, mptscsih_version_mpi_show, 
NULL);

@@ -3090,7 +3090,7 @@ char *buf)
      MPT_SCSI_HOST    *hd = shost_priv(host);
      MPT_ADAPTER *ioc = hd->ioc;

-    return snprintf(buf, PAGE_SIZE, "%s\n", ioc->prod_name);
+    return scnprintf(buf, PAGE_SIZE, "%s\n", ioc->prod_name);
  }
  static DEVICE_ATTR(version_product, S_IRUGO,
      mptscsih_version_product_show, NULL);
@@ -3104,7 +3104,7 @@ mptscsih_version_nvdata_persistent_show(struct 
device *dev,
      MPT_SCSI_HOST    *hd = shost_priv(host);
      MPT_ADAPTER *ioc = hd->ioc;

-    return snprintf(buf, PAGE_SIZE, "%02xh\n",
+    return scnprintf(buf, PAGE_SIZE, "%02xh\n",
          ioc->nvdata_version_persistent);
  }
  static DEVICE_ATTR(version_nvdata_persistent, S_IRUGO,
@@ -3118,7 +3118,7 @@ mptscsih_version_nvdata_default_show(struct device 
*dev,
      MPT_SCSI_HOST    *hd = shost_priv(host);
      MPT_ADAPTER *ioc = hd->ioc;

-    return snprintf(buf, PAGE_SIZE, 
"%02xh\n",ioc->nvdata_version_default);
+    return scnprintf(buf, PAGE_SIZE, "%02xh\n", 
ioc->nvdata_version_default);
  }
  static DEVICE_ATTR(version_nvdata_default, S_IRUGO,
      mptscsih_version_nvdata_default_show, NULL);
@@ -3131,7 +3131,7 @@ mptscsih_board_name_show(struct device *dev, 
struct device_attribute *attr,
      MPT_SCSI_HOST    *hd = shost_priv(host);
      MPT_ADAPTER *ioc = hd->ioc;

-    return snprintf(buf, PAGE_SIZE, "%s\n", ioc->board_name);
+    return scnprintf(buf, PAGE_SIZE, "%s\n", ioc->board_name);
  }
  static DEVICE_ATTR(board_name, S_IRUGO, mptscsih_board_name_show, 
NULL);

@@ -3143,7 +3143,7 @@ mptscsih_board_assembly_show(struct device *dev,
      MPT_SCSI_HOST    *hd = shost_priv(host);
      MPT_ADAPTER *ioc = hd->ioc;

-    return snprintf(buf, PAGE_SIZE, "%s\n", ioc->board_assembly);
+    return scnprintf(buf, PAGE_SIZE, "%s\n", ioc->board_assembly);
  }
  static DEVICE_ATTR(board_assembly, S_IRUGO,
      mptscsih_board_assembly_show, NULL);
@@ -3156,7 +3156,7 @@ mptscsih_board_tracer_show(struct device *dev, 
struct device_attribute *attr,
      MPT_SCSI_HOST    *hd = shost_priv(host);
      MPT_ADAPTER *ioc = hd->ioc;

-    return snprintf(buf, PAGE_SIZE, "%s\n", ioc->board_tracer);
+    return scnprintf(buf, PAGE_SIZE, "%s\n", ioc->board_tracer);
  }
  static DEVICE_ATTR(board_tracer, S_IRUGO,
      mptscsih_board_tracer_show, NULL);
@@ -3169,7 +3169,7 @@ mptscsih_io_delay_show(struct device *dev, struct 
device_attribute *attr,
      MPT_SCSI_HOST    *hd = shost_priv(host);
      MPT_ADAPTER *ioc = hd->ioc;

-    return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->io_missing_delay);
+    return scnprintf(buf, PAGE_SIZE, "%02d\n", ioc->io_missing_delay);
  }
  static DEVICE_ATTR(io_delay, S_IRUGO,
      mptscsih_io_delay_show, NULL);
@@ -3182,7 +3182,7 @@ mptscsih_device_delay_show(struct device *dev, 
struct device_attribute *attr,
      MPT_SCSI_HOST    *hd = shost_priv(host);
      MPT_ADAPTER *ioc = hd->ioc;

-    return snprintf(buf, PAGE_SIZE, "%02d\n", 
ioc->device_missing_delay);
+    return scnprintf(buf, PAGE_SIZE, "%02d\n", 
ioc->device_missing_delay);
  }
  static DEVICE_ATTR(device_delay, S_IRUGO,
      mptscsih_device_delay_show, NULL);
@@ -3195,7 +3195,7 @@ mptscsih_debug_level_show(struct device *dev, 
struct device_attribute *attr,
      MPT_SCSI_HOST    *hd = shost_priv(host);
      MPT_ADAPTER *ioc = hd->ioc;

-    return snprintf(buf, PAGE_SIZE, "%08xh\n", ioc->debug_level);
+    return scnprintf(buf, PAGE_SIZE, "%08xh\n", ioc->debug_level);
  }
  static ssize_t
  mptscsih_debug_level_store(struct device *dev, struct device_attribute 
*attr,
