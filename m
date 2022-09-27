Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F90A5EC84B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiI0PkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiI0Pji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:39:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AD5647F3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:37:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cp18so943470pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GtrGXWLBouj+Sq7t1MDlnSu3fAu+chMcYGINAYDQ4nQ=;
        b=nth9fZmjb+r5s7sisV2ZY4tLq5XMhILIGYTiuxB+lkuRYBEQxKmuRCEjDmL+PLjMEd
         YyMuleqtD/8IoDcafCAcB/zFmY0EBcNJsRqrWOa03oNv88O4IUt3xXwVVTa3ISqznc2L
         0FO+kQE9XbK5Hg7q6ItF02pluJwKtfOGk9H7Gs5mnoy1k1vJQuYzoIScux8coDQ2HTbr
         NTZmUh7EAHsXki3u30LAr3G/ltc4+7O3tlYvOI2JX/tjIM6mLzWCrFDmLu7KNGtf/aw2
         u8o9rF6MwG8srW3awuQQrnU4xJf/3QQlNXQ7xQIsWQBpu52ZVmxSYpKX1Jbl1a10w37J
         0CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GtrGXWLBouj+Sq7t1MDlnSu3fAu+chMcYGINAYDQ4nQ=;
        b=AulXiam0jzZ2V715rYulOc7ij+LivNzh9QPRsu1fpMMgFHEyLPNp1Q1NOtV1yIYUIE
         fGSyO5UwyP0hCXFrbcfOTVoGn2l43EciWe2PQiC3lgonlRU3XwYUwPYKfgyWZcomOpe7
         glrXX0DPGER6Xfc6rFc5Dj4DlIYVCmG7FEAfUt4Lhotcv2uGKG1+lt+CR9ygkPVV9/ye
         iXDWIejhTfB5NTqEnP++/+zI8tmzh5ypoKZvmfwB0gJcVletuXRxxZ64uK9kTLK+sz/Z
         UaXP5tLP3bkwzFHAN7cONrJc+fYN6zrjROXsuwTFSIsCY8BWt9BnIHV8YT44k9lgaDC0
         Vyjw==
X-Gm-Message-State: ACrzQf18NZTgXjOmtI2vlQNMVQOiVEMHufV+n3sTs2A4ubxyiI2QxNXf
        1aTjQSbrJpXkR841yVq5zgFDsg==
X-Google-Smtp-Source: AMsMyM6SWuyZeCem7UcnG3JJgfL8e+Z32COuvs/oTFSp7uz/nzVrvcAb/VCt8AD25s/e6WJzbBztYQ==
X-Received: by 2002:a17:902:ee54:b0:178:7040:f87c with SMTP id 20-20020a170902ee5400b001787040f87cmr28160150plo.8.1664293010016;
        Tue, 27 Sep 2022 08:36:50 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm1933087pfj.119.2022.09.27.08.36.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:36:49 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: [PATCH v2 4/9] scsi: lpfc: Change to use pci_aer_clear_uncorrect_error_status()
Date:   Tue, 27 Sep 2022 23:35:19 +0800
Message-Id: <20220927153524.49172-5-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
References: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Status bits for ERR_NONFATAL errors only are cleared in
pci_aer_clear_nonfatal_status(), but we want clear uncorrectable
error status in lpfc_aer_cleanup_state(), so we change to use
pci_aer_clear_uncorrect_error_status().

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/scsi/lpfc/lpfc_attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 09cf2cd0ae60..d835cc0ba153 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -4689,7 +4689,7 @@ static DEVICE_ATTR_RW(lpfc_aer_support);
  * Description:
  * If the @buf contains 1 and the device currently has the AER support
  * enabled, then invokes the kernel AER helper routine
- * pci_aer_clear_nonfatal_status() to clean up the uncorrectable
+ * pci_aer_clear_uncorrect_error_status() to clean up the uncorrectable
  * error status register.
  *
  * Notes:
@@ -4715,7 +4715,7 @@ lpfc_aer_cleanup_state(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	if (phba->hba_flag & HBA_AER_ENABLED)
-		rc = pci_aer_clear_nonfatal_status(phba->pcidev);
+		rc = pci_aer_clear_uncorrect_error_status(phba->pcidev);
 
 	if (rc == 0)
 		return strlen(buf);
-- 
2.30.1 (Apple Git-130)

