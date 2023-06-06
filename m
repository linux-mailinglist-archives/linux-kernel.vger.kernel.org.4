Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E407236B2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 07:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbjFFFMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 01:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbjFFFMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 01:12:44 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEE0123;
        Mon,  5 Jun 2023 22:12:38 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-565bd368e19so57501937b3.1;
        Mon, 05 Jun 2023 22:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686028358; x=1688620358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8oq115v7opk1kvdj9ziSNYaJGB85R3jZNwGWEgDNy3c=;
        b=OsRTo+hsJIugXQPIR5sgBM4A9Z1R7WLB6boVGjUdAaXp54HjE3KgZedWQevahtI/FR
         Omrg4Mr34iolwF/f3T6AQBV96m/KcsPvH745lNKIfhXKJA4+Vm+4OBcsgeL3EwFCP/pS
         QO7suTVUSYwN1Ld2/Mj9jRMSnTNcxP3UswMi2KgHVNmt2mE2/l3Kbt8QjHQo8ka+AF5X
         iRCw2ifSZ4KcRR2FYl1ITYNzw1cuhWcilAWuvIQwAmVP7UGqgNsNQ+o5PEJE4WxDhLr3
         C0/zzcsKFglNcpuG61s+v5CLfGN2rO48+eDDMwwGZa56h7IS+LggL6sRLSsPzWQz1fYV
         R6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686028358; x=1688620358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oq115v7opk1kvdj9ziSNYaJGB85R3jZNwGWEgDNy3c=;
        b=JClNy0bvAhqfWlUBuXgqSIDE4/zrS2yN+B7yI8xeHFp0rZYPhjo0fyAnYEUAzOVvwy
         Rs+GqGgzkw1Tnfg/2BFOyq8HOIgYOTxVQ0h2Xt79fYfW1L0paQf+ugXK5i+EkjRAeI/3
         O3s4Yl53hc/bnhhs6R8zrTe6QdjLv4a8pPozCsVRrBLjltVR4tvAsjhee+XJYSYJFOCF
         FXXTSOq6crVVdAnF1GMGg2xB2qUqjmwAwBXtRy3A1A7r2Lgcvq60Kjm9Dtr7In619/5y
         P0igY0a9WojD4SclfeTJ5B17hDNEHMUkKg6RkXVfEuQTmQjItRbkoFYbuqwueu1ntQGZ
         3P9w==
X-Gm-Message-State: AC+VfDzl3x3eJQM9dQYPBVSCLdfuwmT2tpBguqKNlV/JEGPcNp/fCkrk
        kja3xfTXgekJc432ZPO1sAk=
X-Google-Smtp-Source: ACHHUZ5h3PA0xcImyQ8vFP5pPyoTW6IRSa15Nl3FOGkQ24eCgEKFdoHXl6hJVozgh6N1raiDp+afEg==
X-Received: by 2002:a81:688b:0:b0:569:ecfc:dd77 with SMTP id d133-20020a81688b000000b00569ecfcdd77mr439526ywc.6.1686028357871;
        Mon, 05 Jun 2023 22:12:37 -0700 (PDT)
Received: from ip-172-31-23-7.us-east-2.compute.internal (ec2-18-222-137-9.us-east-2.compute.amazonaws.com. [18.222.137.9])
        by smtp.googlemail.com with ESMTPSA id o64-20020a0dcc43000000b00565ebcdcc95sm3824722ywd.84.2023.06.05.22.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 22:12:37 -0700 (PDT)
From:   Jianlin Lv <iecedge@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, paulmck@kernel.org,
        bp@suse.de, peterz@infradead.org, will@kernel.org,
        rdunlap@infradead.org, kim.phillips@amd.com, rostedt@goodmis.org,
        wyes.karny@amd.com
Cc:     iecedge@gmail.com, jianlv@ebay.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: sd: support specify probe type of build-in driver
Date:   Tue,  6 Jun 2023 05:12:17 +0000
Message-Id: <20230606051217.2064-1-iecedge@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SCSI disks are located on different SCSI hosts within a system,
asynchronous detection can lead to non-deterministic SCSI disk names.

This patch introduces the 'sd_probe_type=' kernel boot parameter.

In scenarios where SCSI disk name sensitivity is crucial, the probe type
of the build-in sd driver can be set to synchronous. As a result,
the scsi disk names are deterministic.

Signed-off-by: Jianlin Lv <iecedge@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 ++++++++
 drivers/scsi/sd.c                             | 23 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..083f741d63bb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5611,6 +5611,15 @@
 			non-zero "wait" parameter.  See weight_single
 			and weight_many.
 
+	sd_probe_type=	[HW,SCSI] Manual setup probe type of built-in scsi disk driver
+			Format: <int>
+			Default: 1
+			<int> -- device driver probe type to try
+				0 - PROBE_DEFAULT_STRATEGY
+				1 - PROBE_PREFER_ASYNCHRONOUS
+				2 - PROBE_FORCE_SYNCHRONOUS
+			Example: sd_probe_type=1
+
 	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
 			xtime_lock contention on larger systems, and/or RCU lock
 			contention on all systems with CONFIG_MAXSMP set.
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 1624d528aa1f..78b80b9e5618 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -121,6 +121,9 @@ static void scsi_disk_release(struct device *cdev);
 
 static DEFINE_IDA(sd_index_ida);
 
+/* Probe type of SCSI Disk Driver */
+static int sd_probe_type = PROBE_PREFER_ASYNCHRONOUS;
+
 static mempool_t *sd_page_pool;
 static struct lock_class_key sd_bio_compl_lkclass;
 
@@ -3826,6 +3829,25 @@ static int sd_resume_runtime(struct device *dev)
 	return sd_resume(dev);
 }
 
+#ifndef MODULE
+
+/* Set the boot options to sd driver.
+ * Syntax is defined in Documentation/admin-guide/kernel-parameters.txt.
+ */
+static int __init sd_probe_setup(char *str)
+{
+	int probe_type = -1;
+
+	if (get_option(&str, &probe_type) && probe_type >= 0 && probe_type < 3)
+		sd_probe_type = probe_type;
+
+	return 1;
+}
+
+__setup("sd_probe_type=", sd_probe_setup);
+
+#endif
+
 /**
  *	init_sd - entry point for this driver (both when built in or when
  *	a module).
@@ -3858,6 +3880,7 @@ static int __init init_sd(void)
 		goto err_out_class;
 	}
 
+	sd_template.gendrv.probe_type = sd_probe_type;
 	err = scsi_register_driver(&sd_template.gendrv);
 	if (err)
 		goto err_out_driver;
-- 
2.25.1

