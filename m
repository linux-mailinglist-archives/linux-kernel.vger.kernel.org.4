Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B816C71801A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbjEaMku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjEaMks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:40:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A2E40
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:40:31 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f3a9ad31dbso6855906e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685536829; x=1688128829;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Drw4vNL26e11s4ylGTZbprOZ2Zv1Gl249oIHxh4ALM=;
        b=F5zLkMcWHok2hdrPzqlru3sCe+ZGSukQ1VL0vdhE1d0mY53j74VPtA2CJBraRh0ZO3
         LpgyGYTewEjJFhxT0BCBFaVtLmnHSiWO7rEd6EuMDB+QmN29IyyHRp7JNmJYZjHPzR0q
         9vvWcswWzLiSjuJXMDiU9zlllCZQvy8KYMNpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685536829; x=1688128829;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Drw4vNL26e11s4ylGTZbprOZ2Zv1Gl249oIHxh4ALM=;
        b=WIafa+ZL29h42kD3iF0hoHZhVzGW2cKoM37yv4hcXGCd5jSEyxQZi2LGXBatfFODpj
         WWZNVQiqbbp6HeaXNfpUYAJRBUyuIzKXbFPNTL5Q4kRebdOPQx3nX/W53+CTPvr14sGo
         M82mOHb7yCX7OVvxyNP9n2z1NMrKTBwTXmeqBBRuu95lJ3PmK1Z13z2xsDKOm9RVEllz
         3zY1RjSIbPiDundQXiI3ww4XTmBy6ORUxcGQZkZOh6zXIp/y5xuJJEAhjNtnjjIe/8yY
         gYKK1Mb4+EunvjFnrTzUNc0KCuysxmYNrbg8fdLUv+Ujl4lr9hH5oEhwGDcsKzezlO2O
         gcFw==
X-Gm-Message-State: AC+VfDzsQmPMj/pdx1RW8bbz0WoMKDIfi1xaYXB6ZTn33cEqBNPqBxT3
        Vt8CMLf+rsUnJLL9P1rswje/Lw==
X-Google-Smtp-Source: ACHHUZ7rW3ic9Nm2E01LMvkpflmEoGqghIHGnRnNSs0cCIPALrEJZm6RA4JTp5liW1MRbAdiohMoWQ==
X-Received: by 2002:a19:750c:0:b0:4f2:455d:18bd with SMTP id y12-20020a19750c000000b004f2455d18bdmr2574670lfe.16.1685536829603;
        Wed, 31 May 2023 05:40:29 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:f61c:2660:1f5f:4519])
        by smtp.gmail.com with ESMTPSA id f21-20020a19ae15000000b004f37b88eacfsm704263lfc.187.2023.05.31.05.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 05:40:29 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@chromium.org>
Date:   Wed, 31 May 2023 14:40:02 +0200
Subject: [PATCH] xhci: Do not create endpoint debugfs while holding the
 bandwidth mutex
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230531-xhci-deadlock-v1-1-57780bff5124@chromium.org>
X-B4-Tracking: v=1; b=H4sIACFAd2QC/x2NQQrDIBBFryKzrqCGLNqrlCzGcVKHihYlJRBy9
 wzZ/ffh8Q4Y3IUHvMwBnf8ypFUF/zBAGeuHrSRlCC5Mbp683TOJTYypNPrqCBiDp6eLBOpEHGx
 jx0pZrbqVouev8yr7HXkv53kBi64eGnQAAAA=
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Ricardo Ribalda Delgado <ribalda@chromium.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=UQKGCiJA+KdR3RLJnA2tjVxT/UayTXJli+zLmQfrUEo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkd0Arw8YxmyplnKTmqj9XF1FWk5KtM1tEXuCHT
 zeDErIrA52JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZHdAKwAKCRDRN9E+zzrE
 iH1eD/9OFdkkUrhA5UTJTjNXlK/J5tiYnqBc7obMtJpFlV+q2qWZUkl6eCoV0sh2g7GbD5gm32F
 AFh6IpfE+pC2Wbc0sAfJklrHTU4N5stAmnqkkTeQjqB3Qkk9J3sT9Tb5P70cnxwlql1XshRP9MU
 6arPEmy739c9ma2VsCbH6cwelGYPmp1mdRLZVip/X1Fyq8qRZ4vqCrAkaCGOwtNuYnuJMlOLgFY
 X+QcMXjqXZlEyLgnMdREpxrXXrjpO+uSk4c9h3bH6ivlUywXCTJB+82t00gFx3CpwVdDAQqb9CJ
 +i2RkxnM6q7VouEhXXFyzvy2vjgO+eo2cOOgrFFLdpO/6e2kkmBTn+b/3bvMLEhC3ufYa3VCPDh
 reGMDA8WakMb7NW2u6r3Tcmc9l+PlByb9muQf59Ad1aGLdZmHz+dWgXHgYwPO4pMsEFGnSTzVrr
 zbNtKO1sNTVnol9eoZQZi1496JWKKnVqhu7GJL5hTL89cXw/PwA1emDyfBmm+S12gpmpQSMHNTv
 vnY8ZDJTcPCqGX6ep6/GDmxjFv4r/3O+25AcMGNWrQYBW1WlpvnfM9aBZUSrph232z2/QrdncD9
 7FtkTp6EhOcWGY4wnJmeIEzOAIaBFUnAgud4+Y/c5B9SpXldpOk8FPeflHFyvbZSZVdykgCm1Hj
 HqKhBDbRyBjX9dQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xhci_debugfs_create_endpoint needs to take the mm->mmap_sem, which is
not serialized with the hcd->bandwidth_mutex across the codebase.

Without this patch a deadlock has been observed with the uvc driver at
the functions v4l2_mmap() and usb_set_interface().

Cc: Stephen Boyd <swboyd@chromium.org
Fixes: 167657a1bb5f ("xhci: don't create endpoint debugfs entry before ring buffer is set.")
Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>
---
I do not have a proper reproducer for this and I am not used to this
subsystem, so please take a careful look at this patch :).

Thanks!
---
 drivers/usb/host/xhci-debugfs.c | 4 ++++
 drivers/usb/host/xhci.c         | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index 99baa60ef50f..2acce2af2ca9 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -238,6 +238,10 @@ static int xhci_ring_open(struct inode *inode, struct file *file)
 	int			i;
 	struct xhci_file_map	*f_map;
 	const char		*file_name = file_dentry(file)->d_iname;
+	struct xhci_ring	*ring = *(struct xhci_ring **)inode->i_private;
+
+	if (!ring)
+		return -EAGAIN;
 
 	for (i = 0; i < ARRAY_SIZE(ring_files); i++) {
 		f_map = &ring_files[i];
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 78790dc13c5f..2715900b2540 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1930,6 +1930,8 @@ int xhci_add_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 	ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->in_ctx, ep_index);
 	trace_xhci_add_endpoint(ep_ctx);
 
+	xhci_debugfs_create_endpoint(xhci, virt_dev, ep_index);
+
 	xhci_dbg(xhci, "add ep 0x%x, slot id %d, new drop flags = %#x, new add flags = %#x\n",
 			(unsigned int) ep->desc.bEndpointAddress,
 			udev->slot_id,
@@ -2963,7 +2965,6 @@ int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 		xhci_check_bw_drop_ep_streams(xhci, virt_dev, i);
 		virt_dev->eps[i].ring = virt_dev->eps[i].new_ring;
 		virt_dev->eps[i].new_ring = NULL;
-		xhci_debugfs_create_endpoint(xhci, virt_dev, i);
 	}
 command_cleanup:
 	kfree(command->completion);
@@ -2989,7 +2990,6 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 	/* Free any rings allocated for added endpoints */
 	for (i = 0; i < 31; i++) {
 		if (virt_dev->eps[i].new_ring) {
-			xhci_debugfs_remove_endpoint(xhci, virt_dev, i);
 			xhci_ring_free(xhci, virt_dev->eps[i].new_ring);
 			virt_dev->eps[i].new_ring = NULL;
 		}

---
base-commit: 48b1320a674e1ff5de2fad8606bee38f724594dc
change-id: 20230531-xhci-deadlock-de2ab21c90bc

Best regards,
-- 
Ricardo Ribalda Delgado <ribalda@chromium.org>

