Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE8265899B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 07:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiL2GF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 01:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiL2GF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 01:05:56 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589C8E0F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 22:05:54 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b2so18046084pld.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 22:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WvHrnh6Kzoj0nWwyaMrKvOTOMFA+VSrJVZRapH+1ngs=;
        b=gHeW4JYgRqPC62v7wcEHkWIpBU/G/V9W2+kEV3nbqnVkgqU/4StLE+Tb4qZ7gsgxMa
         fOCKMPaszpVfHWa90O+eHOeKrfSUBdRIN86L+OxE4TiDFmo8dw36HAvua3UEIHGb8Pv7
         RV8kaJTJnd9eq4+rYYTngrMHmCMqZ5V3uKKDjDgse9ghe3zAJdqLvacnwL7Eujxkp3KB
         0u54DvQQKjTzBMdQ1yU0Cjvb98JBLQwq/nNPnz3Bk3dcW+BeSzgmDTfaDD4myPwuSpyD
         6zkQrxiuXuQXNuzZnmJzoKjQAwFu6HJCc54xqoyOs+wDa0hJOYyHY39wF8txyvFMepYy
         2PPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WvHrnh6Kzoj0nWwyaMrKvOTOMFA+VSrJVZRapH+1ngs=;
        b=GdoJzmGI3vcg7E38kvLvaAw536gOt9Xc2GkiSKuWDgcgpapWowGPt2TufBJOqNvLQz
         0YzLg8s6T3f+k/2sAy0dWmzpBzIIwMsWm4wYGaBcq6mSLNkJTmh3FObsXp+aIfQT7hJz
         eX8lx/fswdKXxv1oMVcMHox9tdAgSyytAB2f0RNYFdh/RzgyFwHprUBOKeDGMFkWRlwQ
         sGx3Jkm+DJVrx4ogBZZQzTt89cSdH/57BoMExm9qyDeNaLrqeEgbelX9HBF6x/5dk+Yq
         GCMukQRAMUeQsG6k6c9MvVephKjvRpGAfkkioloEfpq9E6Mu+Njaf6wvysKOYzukN1m5
         68ig==
X-Gm-Message-State: AFqh2kq5dGUPtzlKZhm2aCVrFppg9xWkoiVDNEUaMUfWNs5EmRT4VmMy
        n0dbRW5uTC9R8Ow//KIlE9E=
X-Google-Smtp-Source: AMrXdXu7gFAQsreFVb70AT8TyMkIkhPD8Mj81ZOfKm926upQi0YDWXAVYlwQHOwZEMDKq8E01rdEPg==
X-Received: by 2002:a17:902:a717:b0:188:640f:f41e with SMTP id w23-20020a170902a71700b00188640ff41emr29193354plq.4.1672293953727;
        Wed, 28 Dec 2022 22:05:53 -0800 (PST)
Received: from ubuntu-server.local ([2600:1700:3ec7:421f:61cf:da7:ef83:e43e])
        by smtp.googlemail.com with ESMTPSA id u9-20020a1709026e0900b0018699e6afd8sm7316431plk.265.2022.12.28.22.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 22:05:53 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     t.zhang2@samsung.com, Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH] nvme-pci: free irq properly when cannot create adminq
Date:   Wed, 28 Dec 2022 22:05:49 -0800
Message-Id: <20221229060549.3976570-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
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

nvme_pci_configure_admin_queue could return -ENODEV, in this case, we
will need to free IRQ properly. Otherwise following warning could be
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
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/nvme/host/pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f0f8027644bb..1fc2a2e130ab 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
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

