Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A9E6479E8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLHX0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiLHX0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:26:09 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9CD614C;
        Thu,  8 Dec 2022 15:25:55 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id h24so2401594qta.9;
        Thu, 08 Dec 2022 15:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XNi9Ztz/USYrTyc7KmWiTdI5lY+DaOhV8z0ob+ajO9A=;
        b=m/PjQ69IU2l0+dd3Ot+Z8InqhQ9bvX6FQQePM/hhp0Sba4A+kwZdxtDL8/4RYX4vJO
         Ok+ZGRbi5VuUxSYJMgR2AarhPvPtP8h88YOh4MemM0UhyrbOVq23N7l+5y+wGmm5WOJw
         kJk5WnfNtr5xjJWoLAEdl5rszLEwkOsYEeZ8bSvlMMD5atk+Ib/80F7IF+1zXG5PFgYK
         iH9VenTAmr8mcFkpFBKDJL4Jzok8G38ASLnncblOBPWuz6D2bN47EtpcBSP2pOFT5pWM
         lgrSW9/GTTnfiQB2prFAgBZe71NnxWTepwdn9mielkabpR9ODfCY8Tms/1lwFnIUSJQb
         gGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNi9Ztz/USYrTyc7KmWiTdI5lY+DaOhV8z0ob+ajO9A=;
        b=tg09MFXv3+W6yFFbLTGfQz4ZVVJ4/TYSxVJHlOBNJmk6+p9iYqV37qbh/nyH/sE7/o
         iogzE/k8oqofS3ewN1PqODJjPfpVc9WEA2+HcebVMUX+FJVnXvtcfkA/W+9M/XHVCVzu
         AOqSx+4btCQlqK/xi+noJgG3at8zp1m5eEUVzQjlq+oFwNtU/X0MRDRXCuKaAmv5JpG2
         dPRzySnWS/GHpncU+CoG50HFzA9fgvlNUrs2Xo6DzMBRrK+ezkK1deJcItnej5PfePO8
         8yKdUbvNyh6y5Zc/zFjZeE7JpjeiIZBgnvzUeOy1uSaBnkDutngLfnqFg/aKokI9uFuk
         5SqQ==
X-Gm-Message-State: ANoB5plgjhRdhGZXOjz5taEFxs1ptzCDDoMi04kUOC1CLCJGQkCkPTIM
        dv0uFBtLRXQ+UmeDdRM5kuA=
X-Google-Smtp-Source: AA0mqf7rznZmEFIprWaiWXrNpPFjuOFrdr/7fWFzboq8YPec+AHx4QtPV03Sv+xbJaMdefm9qb/O4g==
X-Received: by 2002:ac8:6ecb:0:b0:3a7:f424:d1bb with SMTP id f11-20020ac86ecb000000b003a7f424d1bbmr4799455qtv.21.1670541955026;
        Thu, 08 Dec 2022 15:25:55 -0800 (PST)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id w13-20020a05620a444d00b006fafc111b12sm5087977qkp.83.2022.12.08.15.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 15:25:54 -0800 (PST)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        John Meneghini <jmeneghi@redhat.com>,
        Charles Rose <charles_rose@dell.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Doug Farley <Douglas_Farley@dell.com>,
        Lenny Szubowicz <lszubowi@redhat.com>
Subject: [PATCH] acpi: add support for the NBFT
Date:   Thu,  8 Dec 2022 17:25:36 -0600
Message-Id: <20221208232536.591347-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.31.1
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

Add support for the NVMe Boot Firmware Table (NBFT) to facilitate
booting from NVM Express namespaces which are accessed via
NVMe over Fabrics (NVMe-oF).

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: Doug Farley <Douglas_Farley@dell.com>
Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
---
 drivers/acpi/tables.c | 3 ++-
 include/acpi/actbl1.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 47ec11d4c68e..f390c5883b56 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -545,7 +545,8 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
 	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
-	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI };
+	ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
+	ACPI_SIG_NBFT };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 15c78678c5d3..6ec43410288a 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -49,6 +49,8 @@
 #define ACPI_SIG_S3PT           "S3PT"	/* S3 Performance (sub)Table */
 #define ACPI_SIG_PCCS           "PCC"	/* PCC Shared Memory Region */
 
+#define ACPI_SIG_NBFT		"NBFT"	/* NVMe Boot Firmware Table */
+
 /* Reserved table signatures */
 
 #define ACPI_SIG_MATR           "MATR"	/* Memory Address Translation Table */
-- 
2.31.1

