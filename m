Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FDA68BA22
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjBFK3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjBFK2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:37 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20041EFC8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:33 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n13so8281487wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiCtgga95+oBIC2lKHYt0aFS1kvbxISlsHgDAHK16wM=;
        b=XlA+AKCidfq2z3vth6GCD05fWjyeJOxPaAcP/hpOaKlol9GAsKYK+Rlt1oPB53CMgj
         jaonf8GJBWVyN2c3iWBBvz3pyAbtXFcZJyVQ2BU/K8Jb18AraaJO9En/fTkRjJUIXvYo
         XJ5sgs5aIsQ4M60T7EocbLI0T438by3b9XBHmlKXG8TENzwhjOsLmQwHr3Z7CC9gFeiS
         T0MDsjGF0GZnZqEe1JEBVA5kvtUXpjL3L52yGB9f3h1SYdw8r7EFBpCMzkhzLE/4vIJx
         aWj1RmRoVVhqFDorZUny7K748Gete6QAK7vPboHurCEeJcg9txDoYyEkReu//YPc6kVF
         E3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiCtgga95+oBIC2lKHYt0aFS1kvbxISlsHgDAHK16wM=;
        b=Fzo2DwJL1G3tff30fLVaKPonb+hq7kRkjqJIC6ufzn1aDeFvtsuU+qyMSbyWLOAzDf
         N/on13/po6u8huxPw4pC1j/AzdFQXYe6GKS31uOfYS0TQwdOPPRP8WaoypwAe6tMVM7U
         ALucKAyAL2QBfs3W1EideAxDc0lvhMpyzK595Ov9+eJ/K9WjnZTZ8YBstCH02cvANSyX
         E6jl4O3tkvn0a9EFSTfPtVWyMIZ1XlVnFiuMzxHAWErIvnTJoBIzIvRyb4+SljjCtnAI
         0WzV9cqv0Xztl1n7FCMHkEgEQiHFvGtAB2zk7INl+TOIwrBwABgR6AvRmQULnmM2QWxp
         76Tg==
X-Gm-Message-State: AO0yUKWpk9PUaZTGVx0RY+wgNs2NJ7a3syAmWCyIdhkMs9c4DQK90TGT
        bgeg7CFZLXmt3B3W3qyxX7VbBA==
X-Google-Smtp-Source: AK7set/RIOftW6+XnvmGVNEKFt1mA6TD1CpnFypvQyFfnqQL5snkmmlD/+srAvOaiW/AtDtUInb/qg==
X-Received: by 2002:a1c:7c0e:0:b0:3dc:4548:abe6 with SMTP id x14-20020a1c7c0e000000b003dc4548abe6mr18036017wmc.12.1675679312345;
        Mon, 06 Feb 2023 02:28:32 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:31 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 15/37] nvmem: core: add nvmem_add_one_cell()
Date:   Mon,  6 Feb 2023 10:27:37 +0000
Message-Id: <20230206102759.669838-16-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Add a new function to add exactly one cell. This will be used by the
nvmem layout drivers to add custom cells. In contrast to the
nvmem_add_cells(), this has the advantage that we don't have to assemble
a list of cells on runtime.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 59 ++++++++++++++++++++--------------
 include/linux/nvmem-provider.h |  8 +++++
 2 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 98ae70695f36..58f8e33e7a8c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -501,6 +501,36 @@ static int nvmem_cell_info_to_nvmem_cell_entry(struct nvmem_device *nvmem,
 	return 0;
 }
 
+/**
+ * nvmem_add_one_cell() - Add one cell information to an nvmem device
+ *
+ * @nvmem: nvmem device to add cells to.
+ * @info: nvmem cell info to add to the device
+ *
+ * Return: 0 or negative error code on failure.
+ */
+int nvmem_add_one_cell(struct nvmem_device *nvmem,
+		       const struct nvmem_cell_info *info)
+{
+	struct nvmem_cell_entry *cell;
+	int rval;
+
+	cell = kzalloc(sizeof(*cell), GFP_KERNEL);
+	if (!cell)
+		return -ENOMEM;
+
+	rval = nvmem_cell_info_to_nvmem_cell_entry(nvmem, info, cell);
+	if (rval) {
+		kfree(cell);
+		return rval;
+	}
+
+	nvmem_cell_entry_add(cell);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvmem_add_one_cell);
+
 /**
  * nvmem_add_cells() - Add cell information to an nvmem device
  *
@@ -514,34 +544,15 @@ static int nvmem_add_cells(struct nvmem_device *nvmem,
 		    const struct nvmem_cell_info *info,
 		    int ncells)
 {
-	struct nvmem_cell_entry **cells;
-	int i, rval = 0;
-
-	cells = kcalloc(ncells, sizeof(*cells), GFP_KERNEL);
-	if (!cells)
-		return -ENOMEM;
+	int i, rval;
 
 	for (i = 0; i < ncells; i++) {
-		cells[i] = kzalloc(sizeof(**cells), GFP_KERNEL);
-		if (!cells[i]) {
-			rval = -ENOMEM;
-			goto out;
-		}
-
-		rval = nvmem_cell_info_to_nvmem_cell_entry(nvmem, &info[i], cells[i]);
-		if (rval) {
-			kfree(cells[i]);
-			goto out;
-		}
-
-		nvmem_cell_entry_add(cells[i]);
+		rval = nvmem_add_one_cell(nvmem, &info[i]);
+		if (rval)
+			return rval;
 	}
 
-out:
-	/* remove tmp array */
-	kfree(cells);
-
-	return rval;
+	return 0;
 }
 
 /**
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index a953a3a59535..0262b86194eb 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -153,6 +153,9 @@ struct nvmem_device *devm_nvmem_register(struct device *dev,
 void nvmem_add_cell_table(struct nvmem_cell_table *table);
 void nvmem_del_cell_table(struct nvmem_cell_table *table);
 
+int nvmem_add_one_cell(struct nvmem_device *nvmem,
+		       const struct nvmem_cell_info *info);
+
 #else
 
 static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
@@ -170,6 +173,11 @@ devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
 
 static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
 static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
+static inline int nvmem_add_one_cell(struct nvmem_device *nvmem,
+				     const struct nvmem_cell_info *info)
+{
+	return -EOPNOTSUPP;
+}
 
 #endif /* CONFIG_NVMEM */
 #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
-- 
2.25.1

