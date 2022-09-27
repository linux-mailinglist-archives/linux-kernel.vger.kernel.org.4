Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574EC5EC837
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiI0Pjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiI0Piz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:38:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F791CE608
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:37:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so15908026pjq.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Q86dpO4MZD0CA12jM08xWGYyYtYWODVJgw7gnIuH5Tk=;
        b=IMIPIN6w3MO7MCbD7V3ThsGSRsp1g0IjueBKGf/11rJ6MD5qN4UR3XGmJipX9CK++6
         eiOchrYYinPyoOBn+0Y+rDP0uVRFImrpBNU1UDXtOMNUxPlRqmop3RFvpzPbyEybSG5F
         CRDPQ1enPFC99WOwYFVY2QZDmn8jSfY/zTlBpgKJUVPQ+lpJjVT0rmsBeR4eYvaQSxZK
         dvTm2obycBfI5P1tTJ+khPgiPLQGLeUoFr7m2HgOHrjHsPGgqHpQ2Yy3mDC88pmtuxyB
         YdSpANeZeOxf58GtYGN2R1FOht2o+Xmi4V/D1Ny4qiePO8a/2BpFtrT8iUKZBeNMTtOh
         RWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Q86dpO4MZD0CA12jM08xWGYyYtYWODVJgw7gnIuH5Tk=;
        b=2egJqz6BMLFCdieAF4P4lnxwzxCK3DrslEi/SpPTsPx5M61l9YSdASlPBRKCytjty0
         3mODaxKRHBVt2vnz3kabw1k4YNzw1CFLwFP+rq4sAPdOURvAnw8ncXATuSRPj/eOq6JR
         r/a7kWXPjLZWp2AS8epDoBa4S4NBo/+d8MSA9Tb+5CPsfdXkpFPQQpvxmlvolHYfKLvX
         vvoMAS/Sd1hQomeBiCBI1IJ/I7cIXFBfhxtxG+xGIb/pcNeAE3hXSa1Vq8IzDPl/xNtj
         uAT5MIIm5AyYvN3x3fECyHtr9M3bww19YY4mA91/z24OdM5184K7vt8+Bi3W/JpO5w9a
         pTog==
X-Gm-Message-State: ACrzQf12jXga6idi4lWAcxt2GrSxbcYJNpkDDIvGDZ7JZ3t0P510uEC0
        7qbfknFTfV33VsEpxKT0U75qzw==
X-Google-Smtp-Source: AMsMyM5RaT7WFGyUZHFYqoVH6SiLBpf6gppnLFccPidOBspFk2OpmdxZsinWDsz9SjngtrgXs1RPug==
X-Received: by 2002:a17:90b:17cf:b0:202:95a2:e310 with SMTP id me15-20020a17090b17cf00b0020295a2e310mr5447237pjb.76.1664292992706;
        Tue, 27 Sep 2022 08:36:32 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm1933087pfj.119.2022.09.27.08.36.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:36:32 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: [PATCH v2 2/9] PCI/DPC: Use pci_aer_clear_uncorrect_error_status() to clear uncorrectable error status
Date:   Tue, 27 Sep 2022 23:35:17 +0800
Message-Id: <20220927153524.49172-3-chenzhuo.1@bytedance.com>
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

Use pci_aer_clear_nonfatal_status() in dpc_process_error(), which has
no functional changes.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pcie/dpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3e9afee02e8d..7942073fbb34 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -288,8 +288,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
-		pci_aer_clear_nonfatal_status(pdev);
-		pci_aer_clear_fatal_status(pdev);
+		pci_aer_clear_uncorrect_error_status(pdev);
 	}
 }
 
-- 
2.30.1 (Apple Git-130)

