Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE32C5F5958
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiJERsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiJERsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:48:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F7C238
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 10:48:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id z23so20316946ejw.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ygXgrMvwI83oTWciRbWlrh/kQps7FfPG+yghSVi9/U=;
        b=NDy/TvK3L7DC7SkJDhT99xIPSRmwqUPUnB9VOPISmgU4v7mI2YvcoR1ddz/qLrnw+0
         JtBz1FcFB8Hh4CpZJIL5Q+9dR1Kvk7FSPZ0QY57RKem+vG3zMyPQvs2nEtW3eP9DlSte
         Q4Q00ZX8taSGQ9FGTZwSmDEE/CU7q3Waw2GQgwV/QleXYiFIkD1QBokMpLj5yTgyFGg3
         H2LNVp4TR3NuYpy0KYQENae1x6fej8VH6Je2Fa2B8fJCHhTADIKgj4isSF/rvP0nhV5E
         3bMD3Rl83GS3q/aaSd70GK9gqKLw7jMxWByorqPO22D1SN2zgBz4kAvKbkZBYcwxBZDh
         KA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ygXgrMvwI83oTWciRbWlrh/kQps7FfPG+yghSVi9/U=;
        b=lQ+tdRjV/PN2Li3T+swbRcrHCNn6TJB7DYDokfURiMwhAMYDpt786GP5aYalniMU4B
         N4S7ypTr917grRDd640xEtbLCqfokrd+he3aSXLbmUtmmGUVhl7pfODkR/abpz6dUNQ2
         028dV0M+KQAng5F7dJzIYaECsYfhx7UYcN9m/nnVxphtlR9208YnD0zj2cPTh/kkP89g
         Up/gnh5fA5qnQIJkC321W4k7fZHptW8Fy8FbL9asGKvJMGGAr+IMCFi3zy3I2AFPYyGK
         /A8jOLttGEMXL1Qtl/b0BtmijgHjnuv18D/Ojlrzre125i/L4q/FdNHv9mjmk2bepwi/
         Ilcw==
X-Gm-Message-State: ACrzQf1nXAgXvp01MEWQILgQ/MPMhyTVSHaAzumI2Y0nCe6oH4U9zZDs
        bAxfGC4w6/xGgpmH1KdUEtQ=
X-Google-Smtp-Source: AMsMyM4gLayulwBKZ3oV/w4C4GfrZsOmtMMi5W8Of0+00e76+GDcK9bgiaaGE+JcXnb5caWk4vJrHg==
X-Received: by 2002:a17:906:cc14:b0:78d:2267:3a57 with SMTP id ml20-20020a170906cc1400b0078d22673a57mr596908ejb.241.1664992114759;
        Wed, 05 Oct 2022 10:48:34 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id ee32-20020a056402292000b0044e7862ab3fsm4320697edb.7.2022.10.05.10.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:48:34 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 2/2] xen/virtio: Fix potential deadlock when accessing xen_grant_dma_devices
Date:   Wed,  5 Oct 2022 20:48:23 +0300
Message-Id: <20221005174823.1800761-3-olekstysh@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005174823.1800761-1-olekstysh@gmail.com>
References: <20221005174823.1800761-1-olekstysh@gmail.com>
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

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

As find_xen_grant_dma_data() is called from both interrupt and process
contexts, the access to xen_grant_dma_devices XArray must be protected
by xa_lock_irqsave to avoid deadlock scenario.
As XArray API doesn't provide xa_store_irqsave helper, call lockless
__xa_store directly and guard it externally.

Also move the storage of the XArray's entry to a separate helper.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Fixes: d6aca3504c7d ("xen/grant-dma-ops: Add option to restrict memory access under Xen")
---
 drivers/xen/grant-dma-ops.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 1998d0e8ce82..c66f56d24013 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -25,7 +25,7 @@ struct xen_grant_dma_data {
 	bool broken;
 };
 
-static DEFINE_XARRAY(xen_grant_dma_devices);
+static DEFINE_XARRAY_FLAGS(xen_grant_dma_devices, XA_FLAGS_LOCK_IRQ);
 
 #define XEN_GRANT_DMA_ADDR_OFF	(1ULL << 63)
 
@@ -42,14 +42,29 @@ static inline grant_ref_t dma_to_grant(dma_addr_t dma)
 static struct xen_grant_dma_data *find_xen_grant_dma_data(struct device *dev)
 {
 	struct xen_grant_dma_data *data;
+	unsigned long flags;
 
-	xa_lock(&xen_grant_dma_devices);
+	xa_lock_irqsave(&xen_grant_dma_devices, flags);
 	data = xa_load(&xen_grant_dma_devices, (unsigned long)dev);
-	xa_unlock(&xen_grant_dma_devices);
+	xa_unlock_irqrestore(&xen_grant_dma_devices, flags);
 
 	return data;
 }
 
+static int store_xen_grant_dma_data(struct device *dev,
+				    struct xen_grant_dma_data *data)
+{
+	unsigned long flags;
+	int ret;
+
+	xa_lock_irqsave(&xen_grant_dma_devices, flags);
+	ret = xa_err(__xa_store(&xen_grant_dma_devices, (unsigned long)dev, data,
+			GFP_ATOMIC));
+	xa_unlock_irqrestore(&xen_grant_dma_devices, flags);
+
+	return ret;
+}
+
 /*
  * DMA ops for Xen frontends (e.g. virtio).
  *
@@ -338,8 +353,7 @@ void xen_grant_setup_dma_ops(struct device *dev)
 	 */
 	data->backend_domid = iommu_spec.args[0];
 
-	if (xa_err(xa_store(&xen_grant_dma_devices, (unsigned long)dev, data,
-			GFP_KERNEL))) {
+	if (store_xen_grant_dma_data(dev, data)) {
 		dev_err(dev, "Cannot store Xen grant DMA data\n");
 		goto err;
 	}
-- 
2.25.1

