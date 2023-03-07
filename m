Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562326AD5C2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCGDkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCGDkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:40:32 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD01A2E813
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 19:40:27 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so10718164pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 19:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dankook-ac-kr.20210112.gappssmtp.com; s=20210112; t=1678160427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOv8muTU07U92XozAkeK6WRLTHSE9zCFuGRi/TSymo8=;
        b=QHbUmKNl0fLY+emQllxBnXmO+4TjiX5VgHHImKoKpJ6aMOZrIj8KIsWbeoJTyTPLah
         1JZPproFZO3Lu2EjgYvqnUHduYQGnNxo1zLSFUZo6Zp4oTNJF/uocLqJLPnPN1YylbxP
         w/AbMldhYUJM953LxOFaJzY+w8kwqXsq6FBFmcIt+bZYWR/jm52Wm6lnqxv43pR5754z
         Xk0PqgEleYN3HjRKQrihd9tvii1xJHu9Ke6lQmDt41hUkTNS7OkcKHZkW/hXGrLqAvui
         A0X3N54pJtY9ua5XBZ2L4zkLv8qEkIJ0HoeqBsEI0x8VGThCVMBJ1bidLyHkP8NxBQa6
         P0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678160427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOv8muTU07U92XozAkeK6WRLTHSE9zCFuGRi/TSymo8=;
        b=MpB+UhPPtJviIJesdYH/va/mC+WTIOW05cQ8Y0XXWt/FUwzHyMUC2VUVWapshOaruS
         uqABKi9dslHQyy5OBmhLpbdKLcTsIEvtwKLq0rRwNVF8izbTJ4oQsHHRgajSW7MZTKSU
         ixOER+YBbFOEbMI8BuztHEOsdXc/vZ0KGHGfvf8Cg90ETo5fWmn8SxuAzaz0Y3jvftpI
         s8Pz7stERNlWqCWyBCN+h0hFjeqBN7M0u6s3YTWB43S5z3T1s/fFq6l0gQ6Umj6fGFmE
         MvqIxaP+lgktDwoxDNdiSv39Yb0Vr7Ms3HUYZU5gbex5mj7KSm1H8p7s4cF5jn6OzHEw
         ubGQ==
X-Gm-Message-State: AO0yUKUYbzenejcmU4+MrKA0R2Y2+Vi3i2EX7L++7NwjudPEOZ5GyTwg
        3I8P1Px48E/m+biePQbL+347dg==
X-Google-Smtp-Source: AK7set9fg+11Sf7CPd3sSqSwOwSjNAzdDidOD5Q+q4uaJeVQIB75J+pPfN/GHSSHN10ON9h/WbqoGQ==
X-Received: by 2002:a17:90b:1d8f:b0:237:161e:3329 with SMTP id pf15-20020a17090b1d8f00b00237161e3329mr13221671pjb.40.1678160427139;
        Mon, 06 Mar 2023 19:40:27 -0800 (PST)
Received: from localhost.localdomain ([220.149.244.126])
        by smtp.googlemail.com with ESMTPSA id c2-20020a17090a674200b0023670dbb82fsm6601370pjm.25.2023.03.06.19.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 19:40:26 -0800 (PST)
From:   Seunggyun Lee <sglee97@dankook.ac.kr>
To:     alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vfio/pci/vfio_pci_core.c: add IORESOURCE_EXCLUSIVE flag
Date:   Tue,  7 Mar 2023 12:40:18 +0900
Message-Id: <20230307034018.36980-1-sglee97@dankook.ac.kr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While using a pci device (GPU) through the vfio-pci passthrough in QEMU
VM, host can mmap the PCI device which used by the guest through sysfs.

In this case, when the guest used the PCI device, the host could also
access the data stored in the PCI device memory.

Regarding this, there is a routine to check IORESOURCE_EXCLUSIVE through
iomem_is_exclusive() in pci_mmap_resource() of pci-sysfs.c, but vfio-pci
driver doesn't seem to set that flag.

Wouldn't it be better to use pci_request_selected_regions_exclusive() to
set the IORESOURCE_EXCLUSIVE flag rather than
pci_request_selected_regions() that was used previously?

Signed-off-by: Seunggyun Lee <sglee97@dankook.ac.kr>
---
 drivers/vfio/pci/vfio_pci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 26a541cc64d1..9731ac35b3ad 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1779,7 +1779,7 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	 * we need to request the region and the barmap tracks that.
 	 */
 	if (!vdev->barmap[index]) {
-		ret = pci_request_selected_regions(pdev,
+		ret = pci_request_selected_regions_exclusive(pdev,
 						   1 << index, "vfio-pci");
 		if (ret)
 			return ret;
-- 
2.25.1

