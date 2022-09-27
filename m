Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCED5EC842
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiI0PkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiI0PjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:39:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3CE1CEDC8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:37:30 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so10471095pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RIt/qxR4EAUFbxZ1RMkWtn/7tkqNw/Ddhp3wGfxncRU=;
        b=Wsp7XHabqPR9cfN47YLDb5kP/+DtTWVPXDtUDkStJwV2rn/HziBanxswpSDmdcRLKo
         Dq48tAVzMZp92d4f2AamMdyY8zGEbeQXB6tLxpaB6Y6Wy1VanyBKBfRP9VCLyZAejQ5Y
         a93f5ZK+7C25YS/LlQfWf06VDV3NKB5Luu1bvtlF6PZbg7BkbqtGZsqyim91FVKC6lEU
         8muWZi3OdBTxGXgk0JYE5D0t+53+wm9AL7EvbMtB88Dvaw6MIid+MhOhPoX9yA5NOz7c
         BbZqCnkgyhan4o2ymTMZOD6XQFYA38i8N4n3lHJDN4qromb5YDGrzMTLjyHVlIv8DDnB
         2DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RIt/qxR4EAUFbxZ1RMkWtn/7tkqNw/Ddhp3wGfxncRU=;
        b=po9UHhOcKl6G1+R6sOazcmT4NX+6LamN5yvoslvZH8NQdROhYmG2DrFmtp4EmkGU04
         Lk5qFvVPZIJ8XJO4Z9miiL7rqR6cTFnIsVbsoppetJVjbfm5iYzpihhzAGM358FpvRHE
         sTh/lFaucO0O4jqK4kpWTk/qDinko5N44l2q/uloufBnxXRgntpl753OXUdn4dj68fON
         Q1jEhnPTR4vy8YM9I5X4hVr6lO0RaylngjtjJo3xGLeruA/qISiGl3rxLeyKOtyhsKt5
         n6j3Pz2uqclLBEncHBcKyehGe27xsT3emYvsWm7XjjynRK6Mn1TgzJW1NxVjWSYFfaCy
         t3FQ==
X-Gm-Message-State: ACrzQf0RA9m6Xl9nN9Oin91E+9uE2A52lVGzR7/MkuFh1gAPGrlRaIuH
        BecICxUmUi/4g9Vfp+nnqRN3IQ==
X-Google-Smtp-Source: AMsMyM4PN/sa9EbDRewn4uJ6KiQJHc76Hv5S3W7v3hjUMHPJa2uK3esBhbriqEzLGCbP+ZwPX9ZUzw==
X-Received: by 2002:a17:902:8214:b0:178:95c9:bd5d with SMTP id x20-20020a170902821400b0017895c9bd5dmr28462138pln.106.1664293017089;
        Tue, 27 Sep 2022 08:36:57 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm1933087pfj.119.2022.09.27.08.36.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:36:56 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: [PATCH v2 5/9] PCI/AER: Unexport pci_aer_clear_nonfatal_status()
Date:   Tue, 27 Sep 2022 23:35:20 +0800
Message-Id: <20220927153524.49172-6-chenzhuo.1@bytedance.com>
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

Since pci_aer_clear_nonfatal_status() is used only internally, move
its declaration to the PCI internal header file. Also, no one cares
about return value of pci_aer_clear_nonfatal_status(), so make it void.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pci.h      | 2 ++
 drivers/pci/pcie/aer.c | 7 ++-----
 include/linux/aer.h    | 5 -----
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 785f31086313..a114175d08e4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -684,6 +684,7 @@ void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
+void pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
 #else
@@ -691,6 +692,7 @@ static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
+static inline void pci_aer_clear_nonfatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 #endif
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 4e637121be23..e2ebd108339d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -251,13 +251,13 @@ int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
 
-int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
+void pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
 	u32 status, sev;
 
 	if (!pcie_aer_is_native(dev))
-		return -EIO;
+		return;
 
 	/* Clear status bits for ERR_NONFATAL errors only */
 	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &status);
@@ -265,10 +265,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 	status &= ~sev;
 	if (status)
 		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
-
-	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_aer_clear_nonfatal_status);
 
 void pci_aer_clear_fatal_status(struct pci_dev *dev)
 {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 154690c278cb..f638ad955deb 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -44,7 +44,6 @@ struct aer_capability_regs {
 /* PCIe port driver needs this function to enable AER */
 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
-int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev);
 void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
@@ -57,10 +56,6 @@ static inline int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
-static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
-{
-	return -EINVAL;
-}
 static inline int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev)
 {
 	return -EINVAL;
-- 
2.30.1 (Apple Git-130)

