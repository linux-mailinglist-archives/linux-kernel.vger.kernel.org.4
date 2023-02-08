Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8C268F236
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjBHPkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjBHPkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:40:10 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4294B1AE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 07:39:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f23-20020a05600c491700b003dff4480a17so2586543wmp.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 07:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oGWuGjSyAolvIuh2gpF30/sfRfWcmW0ukeqiTc1FZg4=;
        b=oJLgmWwOA/fWnsZRLlXi0D7IB41vvMVwDk7qIp/hPO/I0Cu28Q2i4d0DPXkgCMMGW7
         SdzZx2e3lqC+DVRz/VlUF+Pk6ZB+kB9aSgjpLPKWsIw6CQBDEbkGyHNWz4UyfDWYca53
         K34F4fo3Rdk5I9CATRq9b+kuSOPothxpM0z/dhRzc7xKpmGW2aUP7qLS5v26HcIzsXml
         uRi3XbYZNSXIYEpwwPGuh8OTovAuQ7No2yybmDgLJaO+R3upLfKBHWlDm2zvJPPCTQlz
         8uTHL68LY/yG++GRdkvszu7ZgdscE3xE0++V0ywwduDPIPSfpmd/Xpn8oL10Dt/+8xS3
         XurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGWuGjSyAolvIuh2gpF30/sfRfWcmW0ukeqiTc1FZg4=;
        b=Az/Vz3mBfDvsnLAIhJN3Be+ha3MuPmMm6isn6NSveugBC9NeEEytJ/yClKCuiT9dNz
         iWZBN0TYPTeSl+v07aTED6aGUYBbR8xFz3j4YoEDHqX1Xv/ol4v3gVlBUOr9EHzNmfxz
         lrAqnhZV2ypyGGjBq2FGXqgJAzoLyu1gjxsG0B8aGII6RYj3PfJ48MRBiyrXYdGSM8yo
         zi1NLVBuZ5ustpMLu3/dfyV7196KNZq/TgCs/CxwkgdITbfSTYP7Nt6S2UdrjDa+BkhV
         Qib/DWBUQl5IX3CbOUvcErOlwkQ6iXAIrzbX+B/RH4VYfgmUsb5hRrQNJWDZf48hE0qW
         XoKg==
X-Gm-Message-State: AO0yUKUEJ/lIvRyUgXNdyp7Yt4hJ/jC7ZJrGMLIQnJmW2OoDMweyMf53
        8m0CW5D0lJnwVnE4Lw4aRUSQirfMDjM=
X-Google-Smtp-Source: AK7set/9TBqIZGKiBgGkbYehMHhv5R4xqumCMXaSzOW6dO7LsQm45M+8qsR9emWP/44RWI8GFW0KSA==
X-Received: by 2002:a05:600c:1613:b0:3df:b5ae:5289 with SMTP id m19-20020a05600c161300b003dfb5ae5289mr6782149wmn.8.1675870796500;
        Wed, 08 Feb 2023 07:39:56 -0800 (PST)
Received: from work-hp.. ([91.123.148.245])
        by smtp.gmail.com with ESMTPSA id d8-20020adfe2c8000000b002bfe08c566fsm13958034wrj.106.2023.02.08.07.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 07:39:55 -0800 (PST)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] xen/grant-dma-iommu: Implement a dummy probe_device() callback
Date:   Wed,  8 Feb 2023 17:36:49 +0200
Message-Id: <20230208153649.3604857-1-olekstysh@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Update stub IOMMU driver (which main purpose is to reuse generic
IOMMU device-tree bindings by Xen grant DMA-mapping layer on Arm)
according to the recent changes done in the following
commit 57365a04c921 ("iommu: Move bus setup to IOMMU device registration").

With probe_device() callback being called during IOMMU device registration,
the uninitialized callback just leads to the "kernel NULL pointer
dereference" issue during boot. Fix that by adding a dummy callback.

Looks like the release_device() callback is not mandatory to be
implemented as IOMMU framework makes sure that callback is initialized
before dereferencing.

Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
 drivers/xen/grant-dma-iommu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/grant-dma-iommu.c b/drivers/xen/grant-dma-iommu.c
index 16b8bc0c0b33..6a9fe02c6bfc 100644
--- a/drivers/xen/grant-dma-iommu.c
+++ b/drivers/xen/grant-dma-iommu.c
@@ -16,8 +16,15 @@ struct grant_dma_iommu_device {
 	struct iommu_device iommu;
 };
 
-/* Nothing is really needed here */
-static const struct iommu_ops grant_dma_iommu_ops;
+static struct iommu_device *grant_dma_iommu_probe_device(struct device *dev)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+/* Nothing is really needed here except a dummy probe_device callback */
+static const struct iommu_ops grant_dma_iommu_ops = {
+	.probe_device = grant_dma_iommu_probe_device,
+};
 
 static const struct of_device_id grant_dma_iommu_of_match[] = {
 	{ .compatible = "xen,grant-dma" },
-- 
2.34.1

