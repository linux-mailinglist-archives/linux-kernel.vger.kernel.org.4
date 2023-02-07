Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B24A68D5B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjBGLkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjBGLj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:39:58 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3581167C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:39:56 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so13997581pjp.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 03:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dankook-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZ6K/KqCj8pDHNXLdT4gXi5ZWgqVInn4mxJn19ef0hc=;
        b=SI6tl2awZEyjLhlfWvnpxIEH33qgdOwS4rpcvxEWXei8AxM/GtPclV76aWYCT9GCqH
         R2NQG9tRN3pZ6n//ZsgxdmU0kO9Ku2C4ledVTMGL4h5xdfPNj1tKf3jd5mkOF7/meAVX
         k2LOEXlS92vju7NNOQUuYz+KJ3gq5poNawzEdo9zmoHLIY3stUHJe6p121agVLCyL4cP
         76survKDho35ty1CH9GfaT2WbqaIZDtzgY6ZYJV5Nsg1A3myTfIxSENnL/36WUBzfJ3n
         l+ido8Ao2CkJdDv6twvLYaJqU9GXBpbX1Comn8Bi+dHfnNB4OPAyDOz9/9jzDWty8xWr
         IhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZ6K/KqCj8pDHNXLdT4gXi5ZWgqVInn4mxJn19ef0hc=;
        b=ZN/8OteLumV9vUGczgQ5ibqDcxjZFiCX5MwQ9ny9kwtqFasdqXe8cdulBFD/BbX8fi
         3SAj+0ujleFR6hIySNlNBYpv8sBN8pIQCKQvh1IYQwaJHOF0MYXMdZnGcXvQHrXRyFIi
         RAxiG57oYG4yCnv+UbQfn5GuZxoOna30vIqXVpqEDTtkMp88mNF4oLANk6Ytf9vIxoRV
         gKt3PwiYpuXpLoiztB2icWsjB7pBojd7CKy9SNgXOeFIniLOb/EjH3rCPzsLbaU4NRln
         dZjh6YivLzBASa5Pg3en9rLbD2M+JRH4fPSsZd8fqzBrRHLlECggcZCuQQCVex4mjt7w
         bf6Q==
X-Gm-Message-State: AO0yUKWY8AFvX9Ua068nnfVvsj8lxyWnAOe4D9FBbzSVYRnbgQ6UNqOW
        IH+wCNxm/q9nyB3AtC8E11nwWg==
X-Google-Smtp-Source: AK7set+OROHGpHOvb4TeMD8kWjZCB/TWCkbp9fXcmeLi6E41EGTHfTapuuRnaVHVa+CdPonTtMHblA==
X-Received: by 2002:a17:903:1246:b0:196:19af:a7f3 with SMTP id u6-20020a170903124600b0019619afa7f3mr2523896plh.39.1675769995751;
        Tue, 07 Feb 2023 03:39:55 -0800 (PST)
Received: from localhost.localdomain ([220.149.244.126])
        by smtp.googlemail.com with ESMTPSA id v13-20020a17090331cd00b00198f1de408csm6597761ple.268.2023.02.07.03.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 03:39:55 -0800 (PST)
From:   Seunggyun Lee <sglee97@dankook.ac.kr>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci/mmap: add pci device EBUSY check
Date:   Tue,  7 Feb 2023 20:39:49 +0900
Message-Id: <20230207113949.17943-1-sglee97@dankook.ac.kr>
X-Mailer: git-send-email 2.25.1
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

When using a pci device through the vfio-pci driver, other software was
also able to access the pci device memory through sysfs.

To prevent this, when mmap is performed through sysfs, a process of
checking whether the device is in use is added.

Signed-off-by: Seunggyun Lee <sglee97@dankook.ac.kr>
---
 drivers/pci/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
index 4504039056d1..4c9df2e23e03 100644
--- a/drivers/pci/mmap.c
+++ b/drivers/pci/mmap.c
@@ -25,6 +25,8 @@ int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
 {
 	unsigned long size;
 	int ret;
+	if (pdev->driver)
+		return -1;
 
 	size = ((pci_resource_len(pdev, bar) - 1) >> PAGE_SHIFT) + 1;
 	if (vma->vm_pgoff + vma_pages(vma) > size)
-- 
2.25.1

