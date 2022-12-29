Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5B065907D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiL2SiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiL2SiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:38:12 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940D6207
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:38:10 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n12so7118319pjp.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbrQz0kg29Xa0GDRC8ClbCWM8goTDo4dB/HNu/0RBic=;
        b=Iom+BzmpkbCSWAfxsPg0W4sRHVtvaB49EFLSRxp6WXmDIsMs/FCKosy/c0Ek7UxrRv
         FLF/loNKG5Km4+1PXzUZxquGpVxkUOVz1ohxTghfGbXGnEPk+V0xnjW2wRYqp+0LtzK7
         xTeTNEPWCbJICWJjKsz5VJ4z/yqQLJeSE/lJ/rMv8JSR0unV5xXU+9lhPFt6nlAvkH2c
         jrzF7fBGQPH6DIgtAuGT7DUNhpx8nKKUTmsrm1c5VlzbtSh/zt3g0UpIZ8ZzZ8ATZOfb
         UPElKwBp7h7+DqdNOfHqbxLL5uaBGf8/4OJ+BV0oCkBrKmvoGc879fepMO7/Phnggbgd
         BNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbrQz0kg29Xa0GDRC8ClbCWM8goTDo4dB/HNu/0RBic=;
        b=6DqswquUK6E8AMKdki5qvDEvIsjYwWKBjoNYvZEDYQdxllNPSC/LQ2K0E98uiXO/uL
         Sm6/fFl3GlYOHoImUbNryf1v2OJxcwZDoM6CUVGxVzsIKuSt47x7UP43uCDZHPlMEfN4
         v8XilV5BU3vIW9dSq/9wqaUhJNCPEnfMIXW1xKKZ9mveg7FXYpI3Te8taw3joZXvL8y6
         WxsCPpdYHq2YX2FlLacAIcup23CCAFWrdpxeBhi6tfH+Gvt/jTFO0OHCNIyoGeMEPFtJ
         qkSTIZ3H7Jx+4lLZ8cPW5eC6d72hXsxJiin6Mjd4XnuVR+h106iE/Gk85inmcgllKxIL
         8NGg==
X-Gm-Message-State: AFqh2kpT1eW3NZ/iVNPHtrAU4b8J1ZMs3z8tFfazTsZMWPA9P2rOknYW
        j6UEeo5MIZ9wiMr5A+cENTM=
X-Google-Smtp-Source: AMrXdXup1GjWb1k9WrctBbG+G+m+lAL5Ir5yQzr14N98Zgy349FFZFUwqsocNJ4OvcCpEjpTKmrRiQ==
X-Received: by 2002:a17:90b:2791:b0:226:3a7c:f97a with SMTP id pw17-20020a17090b279100b002263a7cf97amr1192193pjb.26.1672339089943;
        Thu, 29 Dec 2022 10:38:09 -0800 (PST)
Received: from ubuntu-server.local ([2600:1700:3ec7:421f:61cf:da7:ef83:e43e])
        by smtp.googlemail.com with ESMTPSA id mq18-20020a17090b381200b001df264610c4sm11852655pjb.0.2022.12.29.10.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 10:38:09 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     t.zhang2@samsung.com, Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH v2] nvme-pci: fix error handling in nvme_pci_enable()
Date:   Thu, 29 Dec 2022 10:37:31 -0800
Message-Id: <20221229183731.4013056-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Y63WsX8Hvxep/dtN@kbusch-mbp.dhcp.thefacebook.com>
References: <Y63WsX8Hvxep/dtN@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two issues in nvme_pci_enable()
1) If pci_alloc_irq_vectors() fails, device is left enabled. Fix this by
adding a goto disable statement.
2) nvme_pci_configure_admin_queue could return -ENODEV, in this case,
we will need to free IRQ properly. Otherwise following warning could be
triggered

[    5.286752] WARNING: CPU: 0 PID: 33 at kernel/irq/irqdomain.c:253 irq_domain_remove+0x12d/0x140
[    5.290547] Call Trace:
[    5.290626]  <TASK>
[    5.290695]  msi_remove_device_irq_domain+0xc9/0xf0
[    5.290843]  msi_device_data_release+0x15/0x80
[    5.290978]  release_nodes+0x58/0x90
[    5.293788] WARNING: CPU: 0 PID: 33 at kernel/irq/msi.c:276 msi_device_data_release+0x76/0x80
[    5.297573] Call Trace:
[    5.297651]  <TASK>
[    5.297719]  release_nodes+0x58/0x90
[    5.297831]  devres_release_all+0xef/0x140
[    5.298339]  device_unbind_cleanup+0x11/0xc0
[    5.298479]  really_probe+0x296/0x320

Fixes: a6ee7f19ebfd ("nvme-pci: call nvme_pci_configure_admin_queue from nvme_pci_enable")
Co-developed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
v2: handle pci_alloc_irq_vectors() error

 drivers/nvme/host/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f0f8027644bb..3255e7a6f643 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2530,7 +2530,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	 */
 	result = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 	if (result < 0)
-		return result;
+		goto disable;
 
 	dev->ctrl.cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 
@@ -2584,8 +2584,13 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	pci_enable_pcie_error_reporting(pdev);
 	pci_save_state(pdev);
 
-	return nvme_pci_configure_admin_queue(dev);
+	result = nvme_pci_configure_admin_queue(dev);
+	if (result)
+		goto free_irq;
+	return result;
 
+ free_irq:
+	pci_free_irq_vectors(pdev);
  disable:
 	pci_disable_device(pdev);
 	return result;
-- 
2.25.1

