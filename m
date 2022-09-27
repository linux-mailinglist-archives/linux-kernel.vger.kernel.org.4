Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33825EC839
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiI0Pjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiI0Pi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:38:58 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489281CEDF9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:37:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id b5so9736375pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pu5CUxxvzQDPV1MrZt0eySYk5qcgDQDMRS6x862FR3M=;
        b=hpOlDxF35EkFZOgnZUEUpb7bfMeNXlEs/6zeqAK6eTGvVycSXxN5mhIMc9S8WfoaF/
         cwWs267qASx0e+WT1TwXng5S9nSyp1dRWH7rUpDXZLoP8jh/myCkq/Dpt9Ocv61bMCrX
         KCVkGQ/DsIqrtNOayppyBxQYmf/6pDTp8loAtnshKT2GVLI7NiICfkvNXNmQwARXA4ba
         w7biRtQ/LR4lB7JOHBHhVgKhVaVGPDngj0vRuIKmH6akrigtDtDlTjL6PpQqW/lzhXea
         fBVQ0A2O0oriv/fWIVwEeR77bbp0SvmTpT9sZNgGsqs2ciLylmpapoYCcXrGggb+tFGz
         ksig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pu5CUxxvzQDPV1MrZt0eySYk5qcgDQDMRS6x862FR3M=;
        b=qt8v0EwjKYNgRHmBL2rSW4twfvkV0NTMoySz64vhBDDpYp37JsgXK3TxIsxXe//E8J
         uuijhSDQLI1yXsRD3551A4PsU5ZOeYHGefMdpODi5ole1SawuKEMva74ZlhjfpAgl3ua
         kIsvhtLGSqEEpB+bk/l8VUcJActG/oMFMHA91iAKYUin5Zp36ekz9/TgMXiqHVE4NBoh
         ET0H0hpy35lk7GzM7rtX3rxxA0MIt8r6ROxpiouocESts5i/DMaJZ02w+8qFH0i++ngg
         YwXMu0b5N48BoXFSsh0C24P3iZ7eEAXaqZVQhyuWB9lsTC8gDK84OmwrKkusIRfpgqld
         Mn6w==
X-Gm-Message-State: ACrzQf0K5ICb8I519izIsKPtF5qcRkq48l8UpSjntv01CMCYI6yYyn4B
        MFka+ipYbADfok7mTieGEwfliw==
X-Google-Smtp-Source: AMsMyM5Rm9HIrz8bymvsH/euOjrFQJ4/XBJHdRa6nFHuOBrWJvQLmhDheo/pfwZ79K47Gzo473rdQw==
X-Received: by 2002:aa7:8c4e:0:b0:54e:fa98:5031 with SMTP id e14-20020aa78c4e000000b0054efa985031mr29740531pfd.44.1664293002852;
        Tue, 27 Sep 2022 08:36:42 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm1933087pfj.119.2022.09.27.08.36.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:36:42 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: [PATCH v2 3/9] NTB: Change to use pci_aer_clear_uncorrect_error_status()
Date:   Tue, 27 Sep 2022 23:35:18 +0800
Message-Id: <20220927153524.49172-4-chenzhuo.1@bytedance.com>
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
error status in idt_init_pci(), so we change to use
pci_aer_clear_uncorrect_error_status().

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 0ed6f809ff2e..d5f0aa87f817 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2657,8 +2657,8 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
 	ret = pci_enable_pcie_error_reporting(pdev);
 	if (ret != 0)
 		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
-	else /* Cleanup nonfatal error status before getting to init */
-		pci_aer_clear_nonfatal_status(pdev);
+	else /* Cleanup uncorrectable error status before getting to init */
+		pci_aer_clear_uncorrect_error_status(pdev);
 
 	/* First enable the PCI device */
 	ret = pcim_enable_device(pdev);
-- 
2.30.1 (Apple Git-130)

