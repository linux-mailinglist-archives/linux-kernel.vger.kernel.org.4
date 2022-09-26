Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995725EB091
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiIZSyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiIZSyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:54:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC4C93226
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:54:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bk15so3891614wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=pbuxDw9JDV+xC3TghxOFxO+xNF5PwKD6UdAUdUuq1tU=;
        b=aFQO843m9k+KYokxy5z9m2T927KOh3X5sXSq8MPTTP+mA34udPnEUdn13LDju3Eca5
         PYg9EjjHvu0F/eWAxclfahDTGmo6ajSQxTW5aKDGgofOE4BV2AtgVDDLAsxGh/jp8Mx2
         8R0ZwR655hh/QL0VPhVSCB0jOy+lhwTY+HCYAnAaT1oHWjsBlfwQyp9o0rUl5O/k++Bm
         9lIVljYOiTp038nnvW7Z+NXF0gYpldUQZXNVatXZVRY0OLsO88DIaieAQE/MX33Jlsb1
         Bu4iPLhqAejuaUsyvVrAqovXjjdal2scdFNX4sS5uiSWMiyBKzU4CalniHUfS4I4yrdU
         E9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pbuxDw9JDV+xC3TghxOFxO+xNF5PwKD6UdAUdUuq1tU=;
        b=Bxf0mhgRecdR2AeqEXcfsIF18koogaCHf0mldmHUzC2XpraRjmjzUsjZFZMry/cbEK
         EXY3/p88trikXFuquenN0mioiH5ylozj8P5xOlBl6bMfrZIXtwY0ed0L7+oUv/dZWvtr
         F5LEmpewWyUyu+qJzKgN+zw61pP7SpxRNYA92pEnxId+tXOkhe+HAB6RFYyf3QYI9xfa
         3d4WACoJlAqLeVa/LLSX1BsEw1eHqOMkXG8l8eLGRMXVXzMXUrNASaJCCZN8BCT/DljB
         bBAYP872/FMFUikeXxY4cY6Z1+5sKZDknO/UqYrgivo2yIw+2GckRJph1Ak17NqHFcXx
         JpLQ==
X-Gm-Message-State: ACrzQf2cUa+NiySfRr/2rJazyHJ3PLz9ZH3rY6Q6z7lIICPIrGGs34Bo
        AwJpoLnPT35T+rRQ4qCg+A==
X-Google-Smtp-Source: AMsMyM7GjWK99kxe67TGQT3XudVch6STrzUY6P7ZLjqyvKQYWIaCu/JENp+bJheTAJ/uiMsnPHPjyg==
X-Received: by 2002:a5d:6c62:0:b0:22a:2f59:cb7d with SMTP id r2-20020a5d6c62000000b0022a2f59cb7dmr14410116wrz.405.1664218441374;
        Mon, 26 Sep 2022 11:54:01 -0700 (PDT)
Received: from fedora (88-106-97-87.dynamic.dsl.as9105.com. [88.106.97.87])
        by smtp.gmail.com with ESMTPSA id g16-20020adfe410000000b0022ac13aa98fsm14728910wrm.97.2022.09.26.11.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:54:01 -0700 (PDT)
Date:   Mon, 26 Sep 2022 19:53:59 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] scsi: pm8001: Convert snprintf() to scnprintf()
Message-ID: <YzH1R4XC3mk/XmUc@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinnelle reports a warning
Warning: Use scnprintf or sprintf
Adding to that, there has been a slow migration from snprintf to scnprintf.
This LWN article explains the rationale for this change
https: //lwn.net/Articles/69419/
Ie. snprintf() returns what *would* be the resulting length,
while scnprintf() returns the actual length.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/scsi/pm8001/pm8001_ctl.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index 73f036bed128..6ebc962036c4 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -61,7 +61,7 @@ static ssize_t pm8001_ctl_mpi_interface_rev_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id == chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%d\n",
+		return scnprintf(buf, PAGE_SIZE, "%d\n",
 			pm8001_ha->main_cfg_tbl.pm8001_tbl.interface_rev);
 	} else {
 		return snprintf(buf, PAGE_SIZE, "%d\n",
@@ -86,7 +86,7 @@ static ssize_t controller_fatal_error_show(struct device *cdev,
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
 			pm8001_ha->controller_fatal_error);
 }
 static DEVICE_ATTR_RO(controller_fatal_error);
@@ -107,7 +107,7 @@ static ssize_t pm8001_ctl_fw_version_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id == chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
+		return scnprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
 		(u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev >> 24),
 		(u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev >> 16),
 		(u8)(pm8001_ha->main_cfg_tbl.pm8001_tbl.firmware_rev >> 8),
@@ -138,7 +138,7 @@ static ssize_t pm8001_ctl_ila_version_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id != chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
+		return scnprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version >> 24),
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version >> 16),
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version >> 8),
@@ -164,7 +164,7 @@ static ssize_t pm8001_ctl_inactive_fw_version_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id != chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
+		return scnprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version >> 24),
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version >> 16),
 		(u8)(pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version >> 8),
@@ -191,7 +191,7 @@ static ssize_t pm8001_ctl_max_out_io_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id == chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%d\n",
+		return scnprintf(buf, PAGE_SIZE, "%d\n",
 			pm8001_ha->main_cfg_tbl.pm8001_tbl.max_out_io);
 	} else {
 		return snprintf(buf, PAGE_SIZE, "%d\n",
@@ -215,7 +215,7 @@ static ssize_t pm8001_ctl_max_devices_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id == chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%04d\n",
+		return scnprintf(buf, PAGE_SIZE, "%04d\n",
 			(u16)(pm8001_ha->main_cfg_tbl.pm8001_tbl.max_sgl >> 16)
 			);
 	} else {
@@ -242,7 +242,7 @@ static ssize_t pm8001_ctl_max_sg_list_show(struct device *cdev,
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
 	if (pm8001_ha->chip_id == chip_8001) {
-		return snprintf(buf, PAGE_SIZE, "%04d\n",
+		return scnprintf(buf, PAGE_SIZE, "%04d\n",
 			pm8001_ha->main_cfg_tbl.pm8001_tbl.max_sgl & 0x0000FFFF
 			);
 	} else {
@@ -315,7 +315,7 @@ static ssize_t pm8001_ctl_host_sas_address_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
-	return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
+	return scnprintf(buf, PAGE_SIZE, "0x%016llx\n",
 			be64_to_cpu(*(__be64 *)pm8001_ha->sas_addr));
 }
 static DEVICE_ATTR(host_sas_address, S_IRUGO,
@@ -336,7 +336,7 @@ static ssize_t pm8001_ctl_logging_level_show(struct device *cdev,
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
-	return snprintf(buf, PAGE_SIZE, "%08xh\n", pm8001_ha->logging_level);
+	return scnprintf(buf, PAGE_SIZE, "%08xh\n", pm8001_ha->logging_level);
 }
 
 static ssize_t pm8001_ctl_logging_level_store(struct device *cdev,
@@ -517,7 +517,7 @@ static ssize_t event_log_size_show(struct device *cdev,
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
 		pm8001_ha->main_cfg_tbl.pm80xx_tbl.event_log_size);
 }
 static DEVICE_ATTR_RO(event_log_size);
@@ -604,7 +604,7 @@ static ssize_t non_fatal_count_show(struct device *cdev,
 	struct sas_ha_struct *sha = SHOST_TO_SAS_HA(shost);
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 
-	return snprintf(buf, PAGE_SIZE, "%08x",
+	return scnprintf(buf, PAGE_SIZE, "%08x",
 			pm8001_ha->non_fatal_count);
 }
 
@@ -884,7 +884,7 @@ static ssize_t pm8001_show_update_fw(struct device *cdev,
 	if (pm8001_ha->fw_status != FLASH_IN_PROGRESS)
 		pm8001_ha->fw_status = FLASH_OK;
 
-	return snprintf(buf, PAGE_SIZE, "status=%x %s\n",
+	return scnprintf(buf, PAGE_SIZE, "status=%x %s\n",
 			flash_error_table[i].err_code,
 			flash_error_table[i].reason);
 }
-- 
2.37.3

